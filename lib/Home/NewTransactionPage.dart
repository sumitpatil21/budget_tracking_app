


import 'package:budget_tracking_app/Home/Controller/Home_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NewTransactionPage extends StatelessWidget {

  final  controller = Get.put(HomeController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Transaction'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle between Income/Expenses
            SizedBox(height: 20),
            Row(
              children: [
                // Income Button
                Expanded(
                  child: Obx(() => GestureDetector(
                    onTap: () => controller.isIncome!.value = true,
                    child: Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: controller.isIncome!.value ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(10),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_circle_down,
                            color: controller.isIncome!.value ? Colors.white : Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Income',
                            style: TextStyle(
                              color: controller.isIncome!.value ? Colors.white : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),)
                ),
                SizedBox(width: 10),

                // Expenses Button
               Obx(() =>  Expanded(
                 child: GestureDetector(
                   onTap: () => controller.isIncome!.value = false,
                   child: Container(
                     height: 70,
                     padding: EdgeInsets.symmetric(vertical: 15),
                     decoration: BoxDecoration(
                       color: !controller.isIncome!.value ? Colors.blue : Colors.white,
                       borderRadius: BorderRadius.circular(10),

                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.withOpacity(0.2),
                           spreadRadius: 2,
                           blurRadius: 5,
                           offset: Offset(0, 3),
                         ),
                       ],
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(
                           Icons.arrow_circle_up,
                           color: !controller.isIncome!.value ? Colors.white : Colors.black,
                         ),
                         SizedBox(width: 8),
                         Text(
                           'Expenses',
                           style: TextStyle(
                             color: !controller.isIncome!.value ? Colors.white : Colors.black,
                             fontSize: 18,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),)
              ],
            ),


            // Amount Input Field
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.txtAmount,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                        border: InputBorder.none, // Removes default border
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.attach_money,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),


            SizedBox(height: 20),

            // Category Selection
            Text(
              "Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
             GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.selectedCategoryIndex.value = index;
                    controller.txtCategory.text=controller.categories[index]['name'];
                  },
                  child: Obx(() => Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: controller.selectedCategoryIndex.value == index
                          ? Colors.blue
                          : Color(0xffF6F7F9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: controller.selectedCategoryIndex.value == index
                            ? Colors.blue
                            : Color(0xffF6F7F9),
                        width: 2,
                      ),
                    ),
                    child:Column(
                      children: [
                        IconButton(onPressed: () {

                        }, icon: Icon(controller.categories[index]['icon'],color: controller.selectedCategoryIndex.value == index
                            ? Colors.white
                            : Colors.black,)),
                        Text(
                          controller.categories[index]['name'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: controller.selectedCategoryIndex.value == index
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),),
                );
              },
            ),
            SizedBox(height: 20),

            // Note Input Field
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  controller.txtDate.text =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              },
              child: Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black,width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:  Icon(Icons.calendar_today_outlined,),
                        ),
                        SizedBox(width: 10),
                       Text(
                          controller.txtDate.text==null
                              ? controller.txtDate.text
                              : "Today",
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    Icon(Icons.chevron_right,size: 30,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              // child: ElevatedButton(
              //
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.symmetric(vertical: 15),
              //     backgroundColor: Colors.blue,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              //   child: Text(
              //     'Save Transaction',
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
            ),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  int come=controller.isIncome!.value?1:0;
                  controller.insertDb(double.parse(controller.txtAmount.text), controller.txtCategory.text,controller.txtDate.text,come);
                  Get.back();
                  controller.txtAmount.clear();
                  controller.txtCategory.clear();
                  controller.txtDate.clear();
                  // Add your save logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 22,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
