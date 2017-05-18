class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if status == 'pending'
      self.sender.balance -= amount
      self.receiver.balance += amount
      self.status = 'complete'
      if !self.valid?
        reverse_transfer
        self.status = 'rejected'
        "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer
    if status == 'complete'
      self.sender.balance += amount
      self.receiver.balance -= amount
      self.status = 'reversed'
    end
  end
end
