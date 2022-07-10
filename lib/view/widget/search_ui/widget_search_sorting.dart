import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jubelio/controller/search/search_cubit.dart';
import 'package:jubelio/view/widget/search_ui/widget_search_sorting_name.dart';

import '../../../common/custom_color.dart';
import '../../../common/custom_currency.dart';
import '../../../common/custom_font.dart';
import '../../../common/custom_size.dart';
import '../custom_margin.dart';
import '../custom_responsive.dart';

Widget widgetSearchSorting(BuildContext context, SearchLoaded state){
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sorting Nama Produk", style:
        CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f15 : CustomSize.f25)),
        customSizedBox(CustomSize.f15, CustomSize.f0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            sortingName(context, "Baju", () {
              context.read<SearchCubit>().sortingProductName(name: "baju");
            }),
            sortingName(context, "Sepeda", () {
              context.read<SearchCubit>().sortingProductName(name: "sepeda");
            }),
            sortingName(context, "Tas", () {
              context.read<SearchCubit>().sortingProductName(name: "tas");
            }),
            sortingName(context, "IPhone", () {
              context.read<SearchCubit>().sortingProductName(name: "iphone");
            }),
          ],
        ),
        state.nameProduct != "" ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSizedBox(CustomSize.f20, CustomSize.f0),
            Text("Sorting Harga", style:
            CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f15 : CustomSize.f25)),
            Slider(
              value: state.setPrice,
              max: state.maxPrice,
              min: state.minPrice,
              onChanged: (value){
                context.read<SearchCubit>().updateSorting(
                    maxPrice: state.maxPrice,
                    setPrice: value);
              },
            ),
            Text(CustomCurrency.convertIdr(state.setPrice.toString()), style:
            CustomFont.fontTitleCard(CustomColor.black, !tablet(context) ? CustomSize.f20 : CustomSize.f30)),
          ],
        ) : SizedBox.shrink(),
        Spacer(),
        state.nameProduct != "" ? Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CustomColor.blueColor
          ),
          child: Center(
            child: GestureDetector(
              onTap: (){
                context.read<SearchCubit>().getSearchProduct(setPrice: state.setPrice, nameProduct: state.nameProduct);
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text("Tampilkan Produk (${state.nameProduct.toUpperCase()})", style:
                CustomFont.fontTitleCard(CustomColor.white, !tablet(context) ? CustomSize.f15 : CustomSize.f25)),
              ),
            ),
          ),
        ) : SizedBox.shrink(),
      ],
    ),
  );
}