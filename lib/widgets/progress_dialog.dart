import 'package:flutter/material.dart';

class ProgressDialogs extends StatelessWidget {
  ProgressDialogs({super.key, this.message});
  String? message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black54,
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(width: 6.0,),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),

              SizedBox(width: 26,),
              Text(
                message!,
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

