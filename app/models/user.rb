class User < ActiveRecord::Base
  REGEX_NAME = /^((http|https):\/\/)[a-z0-9]*(\.?[a-z0-9]+)\.[a-z]{2,5}(:[0-9]{1,5})?(\/.)?$/ix
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :organized_events, class_name: Event.name, foreign_key: "organizer_id"
  has_many :attendances
  has_many :events, through: :attendances
  has_many :boards
  has_and_belongs_to_many :organizations
  has_one :plan

  validates :domain_name, presence: true
  validates :domain_name, format: {without: REGEX_NAME, multiline: true}

  def date_difference date1, date2
    month = (date2.year - date1.year) * 12 + date2.month - date1.month - (date2.day >= date1.day ? 0 : 1)
  end

  def free_trial
    month = date_difference self.created_at, Date.today
    if month >= 1
      return false
      errors.add :trial_end, "Your Free Trial Has Ended, please select from a plan"
    elsif month < 1
      return true
    end
  end

  def amount_pending
    trial = self.free_trial
    if trial == false && self.active?
      last_transaction = Transaction.where(user_id: self.id).last
      if date_difference(last_transaction.created_at, Date.today) >= 1
        errors.add :pending, "You have an outstanding invoice, kindly pay at the earliest."
        true
      end
    end
  end

  def creadit_card_valid
    date = Date.today
    year = self.year
    month = self.month
    expiry_month = (date.year - year) * 12 + date.month - month
    if expiry_month > 6
      true
    elsif expiry_month > 6
      false
      errors.add :transaction, "Credit Card not valid"
    end
  end

  def charge_credit_card
    trial = self.free_trial
    amount_pending = self.amount_pending
    creadit_card_valid = self.creadit_card_valid
    if trial == false && self.active? &&
      amount_pending == true && creadit_card_valid == true
      plan_id = self.plan_id
      plan = Plan.where(id: plan_id).first
      transaction = Transaction.new
      transaction.attributes user_id: self.id, first_name: self.first_name,
        last_name: self.last_name, card_type: self.card_type, year: self.year,
        amount: plan.price
      if transaction.save!
        transaction.status = true
        transaction.update
      else
        transaction.status = false
        transaction.update
        errors.add :transaction, "Credit Card Could not be Charged"
      end
    end
  end
end
