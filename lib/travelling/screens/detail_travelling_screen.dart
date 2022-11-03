import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/travelling/domain/models/travelling_model.dart';
import 'package:healing_travelling/widget/custom_appbar_widget.dart';
import 'package:healing_travelling/widget/custom_text_widget.dart';
import 'package:healing_travelling/widget/error_dialog_widget.dart';
import 'package:healing_travelling/widget/loading_dialog_widget.dart';
import 'package:healing_travelling/wishlist/bloc/wishlist_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class DetailTravellingScreen extends StatefulWidget {
  const DetailTravellingScreen({ Key? key, required this.travel, }) : super(key: key);
  final Travel travel;

  @override
  State<DetailTravellingScreen> createState() => _DetailTravellingScreenState();
}

class _DetailTravellingScreenState extends State<DetailTravellingScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        appBar: AppBar(), 
        title: 'Detail'
      ),
      body: Scaffold(
        backgroundColor: kPrimaryBackgroundColor,
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(vertical: 16),
              children: [
                _imageArtikel(),
                SizedBox(height: 10,),
                _descriptionWidget(),
                SizedBox(height: 10,),
                _containerFasilitasWidget(),
                SizedBox(height: 56,)
              ],
            ),
            _containerPriceAndCheckoutWidget(context),
          ],
        ),
      ),
    );
  }

  Container _containerFasilitasWidget() {
    return _containerDataWidget(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: 'Fasilitas',
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          SizedBox(height: 8,),
          _rowFasilitasDataWidget(widget.travel.lodging!),
          _rowFasilitasDataWidget(widget.travel.transportation!),
          _rowFasilitasDataWidget(daysBetween(widget.travel.startDate!, widget.travel.endDate!).toString()+' Hari')
        ],
      )
    );
  }

  Align _containerPriceAndCheckoutWidget(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:16.0, vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
           boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 9,
              color: Colors.black.withOpacity(.15)
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(
              text: NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(widget.travel.price!)),
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
            Container(
              width: 112,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    color: kPrimaryColor.withOpacity(.25)
                  )
                ]
              ),
              child: ElevatedButton.icon(
                onPressed: (){}, 
                icon: Icon(Icons.shopping_bag_outlined, size: 18,), 
                label: CustomTextWidget(
                  text: 'Checkout',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  onPrimary: Colors.white,
                  shadowColor: kPrimaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  )
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Row _rowFasilitasDataWidget(String text) {
    return Row(
      children: [
        Container(
          width: 4.0,
          height: 4.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kGreyColor
          ),
        ),
        SizedBox(width: 8,),
        CustomTextWidget(
          text: text,
          fontSize: 12,
          color: kGreyColor,
        )
      ],
    );
  }

  Container _descriptionWidget() {
    return _containerDataWidget(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: widget.travel.title!,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          SizedBox(height: 8,),
          Text(
            widget.travel.description!,
            style: TextStyle(
              fontSize: 12,
              color: kGreyColor
            ),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  Container _containerDataWidget({Widget? content}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: content
    );
  }

  Container _imageArtikel() {
    return Container(
      height: 333,
      padding: EdgeInsets.fromLTRB(16, 13, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 8,
              color: Colors.black.withOpacity(.25)
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(widget.travel.image!),
            fit: BoxFit.cover
          )
        ),
        child: GestureDetector(
          onTap: (){
            if(widget.travel.isWishlist == true){
              context.read<WishlistBloc>().add(WishlistEventDelete(widget.travel.id.toString()));
              setState(() {
                widget.travel.isWishlist = false;
              });
            } else {
              context.read<WishlistBloc>().add(WishlistEventCreate(widget.travel.isWishlist.toString()));
              setState(() {
                widget.travel.isWishlist = true;
              });
            }
          },
          child: BlocListener<WishlistBloc, WishlistState>(
            listener: (context, state) {
              if(state is WishlistLoading){
                LoadingDialog();
              } else if(state is WishlistPostSuccess){
                Navigator.pop(context);
              } else if(state is WishlistFailed){
                Navigator.pop(context);
                showDialog(
                  context: context, 
                  builder: (_)=> ErrorDialog(errorValue: state.message)
                );
              }
            },
            child: Container(
              width: 34,
              height: 34,
              margin: EdgeInsets.only(top: 2, right: 5),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: widget.travel.isWishlist == true ? Icon(Icons.favorite, color: Color.fromRGBO(252, 71, 85, 1),size: 21,) : Icon(Icons.favorite_border, size: 21,),
            ),
          ),
        ),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}