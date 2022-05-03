class PaymentMethod {
  String cardHolder;
  String cardNumber;
  String expireDate;
  String cvv;
  bool defaultMethod;

  PaymentMethod(this.cardHolder, this.cardNumber, this.expireDate, this.cvv,
      this.defaultMethod);

  @override
  String toString() {
    return "Payment method: $cardNumber $cvv $cardHolder $expireDate";
  }
}
