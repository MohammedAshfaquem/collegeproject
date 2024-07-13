import 'package:college_project/Detailspage.dart';
import 'package:college_project/doantecontroller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Donatepage extends StatelessWidget {
  const Donatepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<Donatecontroler>(
        builder: (context, value, child) =>ListView.builder(
          itemCount: value.itemlist.length,
          itemBuilder: (context, index) =>Padding(
                padding: const EdgeInsets.all(28.0),
                child: GestureDetector(
                  onTap: () {
                    
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Detailspage(
                      cntctno: value.itemlist[index].cntctbo,course: value.itemlist[index].course,itemdes: value.itemlist[index].descriptiom,itemname: value.itemlist[index].itemname,user: value.itemlist[index].username,
                    ),));
                  },
                  child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 5),
                  blurRadius: 5
                                ),
                                
                              ],
                                borderRadius: BorderRadius.circular(12),
                                color:  Color(0xff247D7F)),
                            height: 110,
                            width: 500,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    child: Image.asset("lib/images/sadya.jpg"),
                                                    decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(7)),
                                                    height: 70,
                                                    width: 70,
                                  ),
                                ),
                                SizedBox(width: 10,),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                  SizedBox(height: 15,),
                   Text(
                  value.itemlist[index].itemname,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                                ),
                                SizedBox(height: 6,),
                                Text(DateFormat.yMd().add_jm().format(value.itemlist[index].date),
                                style:TextStyle(fontWeight: FontWeight.bold, fontSize: 15) ,),
                                ],
                               ),
                                const SizedBox(
                  width: 30,
                                ),
                                IconButton(
                    onPressed:() => value.deleteitem(index,context), icon: const Icon(Icons.delete))
                              ],
                            ),
                  ),
                ),
              ),
        )),
    );
  }
}