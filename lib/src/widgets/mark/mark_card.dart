
import 'package:cupboard_flutter/src/models/mark_model.dart';
import 'package:cupboard_flutter/src/services/mark_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarkCard extends StatelessWidget {

  final Mark mark;

  const MarkCard({
    Key? key, 
    required this.mark, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final markService = Provider.of<MarkService>(context);
    final index = markService.marks.indexWhere((e) => e.idTrademark == mark.idTrademark);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 0),
        width: double.infinity,
        height: 90,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft, 
          children: [
        
            _DetailsMark( nameMark: mark.mark,),

            Positioned(
              top: 10,
              right: 40,
              child: IconButton(
              splashRadius: 20,
              splashColor: Colors.deepOrange,
              icon: Icon(
                Icons.edit,
                color: Colors.blue.withOpacity(0.8),
              ),
              onPressed: () {
                markService.selectMark = markService.marks[index];
                Navigator.pushNamed(context, 'formMark');
              },
            ),
            ),

            Positioned(
              top: 10,
              right: 0,
              child: IconButton(
              splashRadius: 20,
              splashColor: Colors.deepOrange,
              icon: Icon(
                Icons.delete,
                color: Colors.red.withOpacity(0.8),
              ),
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text('¿Desea eliminar la marca ${mark.mark}?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                    TextButton(
                      child: const Text('Delete'),
                      onPressed: () async {
                        await markService.deleteMark('${mark.idTrademark}');
                        Navigator.of(context).pop();
                      },
                    ),
                  ]);
                showDialog(context: context, builder: (_) => dialog);
              },
            ),
            ),

          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      )
    ]
  );
}

class _DetailsMark extends StatelessWidget {

  final dynamic nameMark;

  const _DetailsMark( {
    Key? key,  
    required this.nameMark
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: 90,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name:', style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6),)),
            const SizedBox(height: 5,),
            Text(nameMark, style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,bottomLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
    
  );
}