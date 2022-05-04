class PaymentCard {
  String paymentId;
  String cardHolder;
  String cardNumber;
  String expireDate;
  String cvv;
  bool defaultMethod;

  PaymentCard(this.paymentId, this.cardHolder, this.cardNumber, this.expireDate,
      this.cvv, this.defaultMethod);

  @override
  String toString() {
    return "Payment method: $cardNumber $cvv $cardHolder $expireDate";
  }
}
