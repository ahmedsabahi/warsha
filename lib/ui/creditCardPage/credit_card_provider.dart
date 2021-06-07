import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';

class CreditCardProvider with ChangeNotifier {
  String _cardNumber = '';
  String _expiryDate = '';
  String _cardHolderName = '';
  String _cvvCode = '';
  bool _isCvvFocused = false;

  String get cardNumber => _cardNumber;
  String get expiryDate => _expiryDate;
  String get cardHolderName => _cardHolderName;
  String get cvvCode => _cvvCode;
  bool get isCvvFocused => _isCvvFocused;

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    _cardNumber = creditCardModel.cardNumber;
    _expiryDate = creditCardModel.expiryDate;
    _cardHolderName = creditCardModel.cardHolderName;
    _cvvCode = creditCardModel.cvvCode;
    _isCvvFocused = creditCardModel.isCvvFocused;
  }
}
