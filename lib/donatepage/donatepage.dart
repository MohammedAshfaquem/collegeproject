import 'package:college_project/donatepage/donateDetailspage.dart';
import 'package:college_project/donatepage/donatecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class Donatepage extends StatelessWidget {
  const Donatepage({super.key,  this.showbackbutton = false, required this.onpressed});
  final bool showbackbutton;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color(0xff247D7F),
        leading: IconButton(
          onPressed: onpressed,
          icon:showbackbutton?Icon(
            LineAwesomeIcons.angle_left_solid,
          ):SizedBox(),
        ),
        title: Text(
          'Available Donations',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1,color: Theme.of(context).colorScheme.surface),
        ),
        centerTitle: true,
      ),
      backgroundColor:Theme.of(context).colorScheme.surface,
      body: Consumer<Donatecontroler>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.itemlist.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(28.0).w,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detailspage(
                        imageurl: value.itemlist[index].image,
                        cntctno: value.itemlist[index].cntctbo,
                        course: value.itemlist[index].course,
                        lname: value.itemlist[index].lname,
                        foodname: value.itemlist[index].foodname,
                        user: value.itemlist[index].fname,
                        option: value.itemlist[index].option,
                        itemdes: value.itemlist[index].description,
                      ),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(5, 5),
                          blurRadius: 5),
                    ],
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff247D7F)),
                height: 110.h,
                width: 500.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5).w,
                      child: Container(
                        child: value.savedimage != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(value.itemlist[index].image))
                            : CircleAvatar(),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(7)),
                        height: 70.h,
                        width: 70.w,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            value.itemlist[index].fname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                 fontSize: 19.sp),
                          ),
                          Text(
                            value.itemlist[index].course,
                            style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey.shade200),
                          ),
                          Text(
                            DateFormat.yMd()
                                .add_jm()
                                .format(value.itemlist[index].date),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.sp),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    IconButton(
                      onPressed: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          showCancelBtn: true,
                          onCancelBtnTap: () => Navigator.pop(context),
                          title: 'Are you sure',
                          onConfirmBtnTap: () {
                            value.deleteitem(index, context);
                            Navigator.pop(context);
                          }
                              
                        );
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
