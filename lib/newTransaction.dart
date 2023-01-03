import "package:flutter/material.dart";
import "package:intl/intl.dart";

class newTransaction extends StatefulWidget {

  final Function addTx;

  newTransaction(this.addTx);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction>{

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData(){
    // if(_priceController.text.isEmpty){
    //   return;
    // }

    final enterName = _nameController.text;
    final enterPrice = int.parse(_priceController.text);

    if( enterName.isEmpty || enterPrice <0 || _selectedDate == null){
      return ;
    }
    widget.addTx(
      enterName,
      enterPrice,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.redAccent, // <-- SEE HERE
              onPrimary: Colors.yellowAccent, // <-- SEE HERE
              onSurface: Color.fromRGBO(0, 61, 186, 1.0), // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if(pickedDate == null){
        return ;
      }
      setState((){
        _selectedDate = pickedDate ;
      }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration:const InputDecoration(
                  labelText: "Enter Name",
                ),
                controller: _nameController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration:const InputDecoration(
                  labelText: "Enter Price",
                ),
                controller: _priceController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      // child: Text(
                      //   _selectedDate == null ?
                      //   "No Date Chosen!"
                      //       :
                      //   "Picked Date: ${DateFormat.yMMMd().format(_selectedDate!)}"
                      //   ,
                      //   style: const TextStyle(
                      //     color: Colors.red,
                      //     fontSize: 14,
                      //   ),
                      // ),
                      child: _selectedDate == null
                          ?
                        const Text(
                          "No Date Chosen!",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                          ),
                        )
                          :
                        Text(
                          "Picked Date: ${DateFormat.yMMMd().format(_selectedDate!)}",
                          style: const TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 14,
                          ),
                        ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 40)),
                      ),
                      onPressed: _presentDatePicker,
                      child: const Text(
                        "Choose Date",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text(
                  "Add Transaction",
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(239, 125, 10, 1.0)),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    )),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color.fromRGBO(255, 185, 41, 1.0); //<-- SEE HERE
                        return null; // Defer to the widget's default.
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
