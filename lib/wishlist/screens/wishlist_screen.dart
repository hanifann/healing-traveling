import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/widget/custom_appbar_widget.dart';
import 'package:healing_travelling/widget/custom_text_widget.dart';
import 'package:healing_travelling/wishlist/bloc/wishlist_bloc.dart';
import 'package:healing_travelling/wishlist/domain/services/wishlist_service.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class WishlishtScreen extends StatelessWidget {
  const WishlishtScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistBloc(WishListService())..add(WishlistEventFetch()),
      child: WishlistView(),
    );
  }
}

class WishlistView extends StatelessWidget {
  const WishlistView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        appBar: AppBar(), 
        title: 'Wishlist'
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if(state is WishlistFetchSuccess){
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index){
                return _cardWishlist(state.wishlist.data![index].travel!.price!, state.wishlist.data![index].travel!.title!, state.wishlist.data![index].travel!.image!, context, state.wishlist.data![index].id.toString());
              }, 
              separatorBuilder: (_,__) => SizedBox(height: 10,), 
              itemCount: state.wishlist.data!.length
            );
          } else if(state is WishlistFailed){
            return Center(
              child: Text('something went wrong, ${state.message}'),
            );
          } else {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index){
                  return _cardWishlist('100', '', 'https://via.placeholder.com/150', context, '0');
                }, 
                separatorBuilder: (_,__) => SizedBox(height: 10,), 
                itemCount: 6
              ),
            );
          }
        },
      ),
    );
  }

  Container _cardWishlist(String price, String title, String image, BuildContext context, String id) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8
          )
        ]
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          _thumbnailWishlist(image),
          SizedBox(width: 16,),
          _detailWishlist(title, price, context, id)
        ],
      ),
    );
  }

  Column _detailWishlist(String title, String price, BuildContext context, String id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: title,
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 4,),
        CustomTextWidget(
          text: NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(price)),
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 8,),
        Row(
          children: [
            Container(
              height: 27,
              width: 27,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4)
              ),
              child: OutlinedButton(
                onPressed: () async {
                  context.read<WishlistBloc>().add(WishlistEventDelete(id));
                }, 
                child: Icon(Icons.delete_outline_rounded),
                style: OutlinedButton.styleFrom(
                  onSurface: Colors.redAccent,
                  primary: Colors.redAccent,
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                  )
                ),
              ),
            ),
            SizedBox(width: 12,),
            Container(
              width: 115,
              height: 27,
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
        )
      ],
    );
  }

  Container _thumbnailWishlist(String image) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 8,
            color: Colors.black.withOpacity(.25)
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover
        )
      ),
    );
  }
}