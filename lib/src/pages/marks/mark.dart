
import 'package:cupboard_flutter/src/models/mark_model.dart';
import 'package:cupboard_flutter/src/pages/loading.dart';
import 'package:cupboard_flutter/src/services/mark_service.dart';
import 'package:cupboard_flutter/src/widgets/mark/mark_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarkPage extends StatelessWidget {
  const MarkPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final markService = Provider.of<MarkService>(context);
    if(markService.isloading) return const Loading();
    return Scaffold(
      body: ListView.builder(
        itemCount: markService.marks.length,
        itemBuilder: (BuildContext context, int index){
          return MarkCard(mark: markService.marks[index]);
        } 
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          markService.selectMark = Mark(
            mark: '',
          );
          Navigator.pushNamed(context, 'formMark');
        },
      ),
    );
  }
}