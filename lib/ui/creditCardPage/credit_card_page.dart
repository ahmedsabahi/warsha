import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/creditCardPage/credit_card_provider.dart';
import 'package:warsha_app/ui/summary_page.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCardPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var creditCardProvider = Provider.of<CreditCardProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        iconTheme: IconThemeData(color: Color(0xff022C43)),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'طريقة الدفع',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff022C43),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Color(0xff022C43),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 150.0,
              height: 50.0,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'الرجوع',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              width: 150.0,
              height: 50.0,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.amberAccent),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print('valid!');
                    _showValidDialog(
                        context, "Valid", "Your card successfully valid !!!");
                  } else {
                    print('invalid!');
                    _showValidDialog(
                        context, "invalid", "Your card invalid !!!");
                  }
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SummaryPage()));
                },
                child: Text(
                  'أدفع',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: creditCardProvider.cardNumber,
              expiryDate: creditCardProvider.expiryDate,
              cardHolderName: creditCardProvider.cardHolderName,
              cvvCode: creditCardProvider.cvvCode,
              showBackView: creditCardProvider.isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              cardType: CardType.mastercard,
              cardBgColor: Color(0xFF4994F9),
              textStyle: TextStyle(color: Colors.amberAccent),
              width: MediaQuery.of(context).size.width * 0.80,
              animationDuration: Duration(milliseconds: 1000),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 330,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.transparent,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: creditCardProvider.cardNumber,
                          cvvCode: creditCardProvider.cvvCode,
                          cardHolderName: creditCardProvider.cardHolderName,
                          expiryDate: creditCardProvider.expiryDate,
                          themeColor: Colors.blue,
                          cardNumberDecoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                          ),
                          expiryDateDecoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange:
                              creditCardProvider.onCreditCardModelChange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showValidDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                child: Text(
                  "Ok",
                  style: TextStyle(fontSize: 18, color: Colors.cyan),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}
