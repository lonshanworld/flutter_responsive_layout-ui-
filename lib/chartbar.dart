import "package:flutter/material.dart";

class ChartBar extends StatelessWidget {

  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (j,L){
        return Column(
          children: <Widget>[
            SizedBox(
              height: L.maxHeight * 0.12,
              child: FittedBox(
                child: Text(
                  "${spendingAmount.toStringAsFixed(0)}Ks",
                ),
              ),
            ),
            SizedBox( height: L.maxHeight * 0.05,),
            SizedBox(
              height: L.maxHeight * 0.65,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox( height: L.maxHeight * 0.05,),
            SizedBox(
              height: L.maxHeight * 0.10,
              child:  FittedBox(
                child: Text(label,),
              ),
            ),
          ],
        );
      }
    );
  }
}
