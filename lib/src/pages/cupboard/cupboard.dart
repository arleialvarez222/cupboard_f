
import 'package:cupboard_flutter/src/models/reques_cupboard_model.dart';
import 'package:cupboard_flutter/src/pages/loading.dart';
import 'package:cupboard_flutter/src/services/req_cupboard_service.dart';
import 'package:cupboard_flutter/src/widgets/cupboard/cupboard_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CupboardPage extends StatelessWidget {
  const CupboardPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //final cupboardService = Provider.of<CupboardService>(context);
    final reqCupboardService = Provider.of<ReqCupboadService>(context);
    if(reqCupboardService.isloading)return const Loading();

    return Scaffold(
      body: ListView.builder(
        itemCount: reqCupboardService.cupboardList.length,
        itemBuilder: (BuildContext context, int index) {
          return CupboardCard(cupboard: reqCupboardService.cupboardList[index], height: 120);
        },
      ),
    
     floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          reqCupboardService.selectCupboardDetail = CupBoardReq(
            nameCupBoard: "",
            isDefault: true,
          );
          reqCupboardService.selectCupboardDet = CupBoardDetail(
            idProduct: "",
            amount: "",
            entryDate: "",
            exitDate: "",
            expirationDate: "",
          );
          Navigator.pushNamed(context, 'cupboardForm');
        },
      ),
   );
  }
}