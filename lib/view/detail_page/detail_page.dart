import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jubelio/common/custom_color.dart';
import 'package:jubelio/common/custom_font.dart';
import 'package:jubelio/common/custom_size.dart';
import 'package:jubelio/controller/product_detail/product_detail_cubit.dart';
import 'package:jubelio/view/widget/custom_responsive.dart';
import 'package:http/http.dart' show Client;

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.prdNo}) : super(key: key);

  final String? prdNo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailCubit>(
      create: (_)=>ProductDetailCubit()..getProductDetail(prdNo!),
      child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state){
          if(state is ProductDetailLoaded){
            return MaterialApp(
              home: Scaffold(
                key: ProductDetailCubit.scaffold,
                appBar: AppBar(
                  toolbarHeight: !tablet(context) ? kToolbarHeight : CustomSize.f60,
                  title: Text(state.modelProductDetail.prdNm!, style:
                  CustomFont.fontTitleCard(CustomColor.white, !tablet(context) ? CustomSize.f20 : CustomSize.f27)),
                  actions: [
                    GestureDetector(
                        onTap: (){
                          context.read<ProductDetailCubit>().addToCart(state.modelProductDetail);
                          print("pasti");
                        },
                        child: Container(
                          key: const Key("hello"),
                          margin: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.add_shopping_cart_rounded, size: !tablet(context) ? CustomSize.f20 : CustomSize.f30,),
                        )
                    )
                  ],
                ),
                backgroundColor: CustomColor.white,
                body: SingleChildScrollView(
                  child: Container(
                    color: CustomColor.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                          child: Text(state.modelProductDetail.selPrc!, style:
                          CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f30),),
                        ),
                        Html(
                            style: {
                              "body": Style(
                                fontSize: FontSize(!tablet(context) ? CustomSize.f20 : CustomSize.f30),
                              )
                            },
                            data: state.modelProductDetail.htmlDetail),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if(state is ProductDetailError){
            return Scaffold(
              key: ProductDetailCubit.scaffold,
              appBar: AppBar(
                toolbarHeight: !tablet(context) ? kToolbarHeight : CustomSize.f60,
                title: Text(state.message, style:
                CustomFont.fontTitleCard(CustomColor.white, !tablet(context) ? CustomSize.f20 : CustomSize.f27)),
              ),
              backgroundColor: CustomColor.white,
              body: Center(
                child: Text(state.message, style:
                CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f27),),
              ),
            );
          }
          return Center(
            child: Container(
              color: Colors.transparent,
              child: const CircularProgressIndicator(),
              height: 50, width: 50,
            ),
          );
        }
      ),
    );
  }
}
