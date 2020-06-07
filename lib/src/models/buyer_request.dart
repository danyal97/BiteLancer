class BuyerRequest {
  final String buyerFoodItemRequired;
  final String buyerName;
  final String buyerPhoneNumber;
  final String buyerAddress;
  final String buyerPrice;
  final String buyerDescription;

  BuyerRequest(
      {this.buyerName,
      this.buyerAddress,
      this.buyerFoodItemRequired,
      this.buyerPhoneNumber,
      this.buyerPrice,
      this.buyerDescription});
}
