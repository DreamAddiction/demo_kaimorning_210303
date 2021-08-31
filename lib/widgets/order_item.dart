import 'package:demo_kai_morning_210303/constant/firestore_keys.dart';
import 'package:demo_kai_morning_210303/constant/size.dart';
import 'package:demo_kai_morning_210303/model/order_model.dart';
import 'package:demo_kai_morning_210303/network/order_network_func.dart';
import 'package:demo_kai_morning_210303/screen/sub/send_photo.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {

  final OrderModel orderModel;

  OrderItem({this.orderModel});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {

//  orderKey
//  store
//  menu
//  time
//  madeTime
//  goal
//  orderer
//  process

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey)]
        ),
        child: Column(
          children: [
            Text('가게 : ${widget.orderModel.store}'),
            Text('메뉴 : ${widget.orderModel.menu}'),
            Text('시간 : ${widget.orderModel.time}'),
            Text('수령장소 : ${widget.orderModel.goal}'),
            Text('주문자 : ${widget.orderModel.orderer}'),
            Text('폰번호 : ${widget.orderModel.phone}'),
            Text('주문시간 : ${widget.orderModel.madeTime}', style: TextStyle(color: Colors.grey, fontSize: 10.0),),
            SizedBox(height: 10.0,),
            Text('현재 상태'),
            SizedBox(height: 10.0,),
            Row(
              children: [
                SizedBox(
                  width: size.width*0.2,
                ),
                InkWell(
                  onTap: ()async{
                    if(widget.orderModel.process != KEY_READY){
                      bool flag = await showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: Text('상태 변경'),
                          content: Text('${widget.orderModel.store}\n${widget.orderModel.menu}\n${widget.orderModel.time}\n${widget.orderModel.orderer}\n\n정말 대기 상태로 돌리시겠습니까?'),
                          actions: [
                            FlatButton(
                              child: Text('변경'),
                              onPressed: (){
                                Navigator.pop(context, true);
                              },
                            ),
                            FlatButton(
                              child: Text('취소'),
                              onPressed: (){
                                Navigator.pop(context, false);
                              },
                            )
                          ],
                        );
                      });

                      if (flag != null && flag)
                        await orderNetwork.changeOrderProcess(orderKey: widget.orderModel.orderKey, process: KEY_READY);
                    }
                  },
                  child: Container(
                    width: size.width*0.2,
                    child: Text('대기중', style: TextStyle(color: (widget.orderModel.process == KEY_READY)? Colors.red: Colors.grey),),
                  ),
                ),
                InkWell(
                  onTap: ()async{
                    if(widget.orderModel.process != KEY_DOING){

                      bool flag = await showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: Text('상태 변경'),
                          content: Text('${widget.orderModel.store}\n${widget.orderModel.menu}\n${widget.orderModel.time}\n${widget.orderModel.orderer}\n\n진행중 상태로 변경하시겠습니까? \n (상품 수령 하신거죠?) \n (아니면 배송 오류?!)'),
                          actions: [
                            FlatButton(
                              child: Text('변경'),
                              onPressed: (){
                                Navigator.pop(context, true);
                              },
                            ),
                            FlatButton(
                              child: Text('취소'),
                              onPressed: (){
                                Navigator.pop(context, false);
                              },
                            )
                          ],
                        );
                      });

                      if(flag != null && flag)
                        await orderNetwork.changeOrderProcess(orderKey: widget.orderModel.orderKey, process: KEY_DOING);
                    }
                  },
                  child: Container(
                    width: size.width*0.2,
                    child: Text('진행중', style: TextStyle(color: (widget.orderModel.process == KEY_DOING)? Colors.red: Colors.grey),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SendPhoto(orderModel: widget.orderModel,)));
                  },
                  child: Container(
                    width: size.width*0.2,
                    child: Text('완료', style: TextStyle(color: (widget.orderModel.process == KEY_DONE)? Colors.red: Colors.grey),),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }
}
