
import 'package:flutter/material.dart';

import '../Models/QuestionModel.dart';

class OptionsWidget extends StatelessWidget {
  final QuestionModel question;
  final ValueChanged<Options> onClickedOption;
  OptionsWidget({
    required this.question,
  required this.onClickedOption
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: question.options.map((option) => BuildOption(context,option )).toList(),
    );
  }
  Widget BuildOption(BuildContext context,Options option){
    final color=GetColorForOption(option, question);
    return InkWell(
      onTap: (){
        onClickedOption(option);
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color:color )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(option.text,style: TextStyle(fontSize: 20),),
            GetIconForOption(option, question)
          ],
        ),
      ),
    );
  }
  Color GetColorForOption(Options option,QuestionModel question){
    final  isSelected=option==question.selectedOption;
    if(question.isLocked){
      if(isSelected){
        return option.iscorrect?Colors.green:Colors.red;
      }else if(option.iscorrect){
        return Colors.green;
      }
    }
    return Colors.grey.shade200;
  }
  Widget GetIconForOption(Options option,QuestionModel question){
    final  isSelected=option==question.selectedOption;
    if(question.isLocked){
      if(isSelected){
        return option.iscorrect
             ? const  Icon(Icons.check_circle_rounded,color: Colors.green,)
             : const  Icon(Icons.cancel,color: Colors.red,);
      }else if(option.iscorrect){
        return const  Icon(Icons.check_circle_rounded,color: Colors.green,);
      }
    }
    return SizedBox.shrink();
  }

}
