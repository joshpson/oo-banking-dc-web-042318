class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    accounts_valid = self.sender.valid? && self.receiver.valid?
    sender_afford = (self.sender.balance > self.amount)
    status_okay = (self.status == "pending")
    accounts_valid && sender_afford && status_okay
  end

  def execute_transaction
    if self.valid?
        self.sender.balance -= self.amount
        self.receiver.balance += self.amount
        self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount
      self.status = "reversed"
    end
  end

end
