import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/travelling/bloc/travel_bloc.dart';
import 'package:healing_travelling/travelling/domain/models/travelling_model.dart';
import 'package:healing_travelling/travelling/domain/services/travelling_services.dart';
import 'package:healing_travelling/travelling/screens/detail_travelling_screen.dart';
import 'package:healing_travelling/travelling/widgets/card_travelling_widget.dart';
import 'package:healing_travelling/widget/custom_appbar_widget.dart';
import 'package:healing_travelling/widget/loading_dialog_widget.dart';
import 'package:healing_travelling/wishlist/bloc/wishlist_bloc.dart';
import 'package:healing_travelling/wishlist/domain/services/wishlist_service.dart';
import 'package:shimmer/shimmer.dart';

class TravellingScreen extends StatelessWidget {
  const TravellingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TravelBloc(TravellingService())..add(TravelEventFetch('1')),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(WishListService()),
        ),
      ],
      child: TravelView(),
    );
  }

}

class TravelView extends StatefulWidget {
  const TravelView({ Key? key }) : super(key: key);

  @override
  State<TravelView> createState() => _TravelViewState();
}

class _TravelViewState extends State<TravelView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      appBar: CustomAppbarWidget(
        appBar: AppBar(), 
        title: 'Travelling'
      ),
      body: BlocListener<WishlistBloc, WishlistState>(
        listener: (context, state) {
          if(state is WishlistPostSuccess){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text('Berhasil ditambahkan ke wishlist'))
            );
          } else if (state is WishlistDeleteSuccess){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text('Berhasil dihapus dari wishlist'))
            );
          } else if (state is WishlistLoading){
            showDialog(
              context: context, 
              builder: (_){
                return LoadingDialog();
              }
            );
          }
        },
        child: _gridViewTravellingWidget(),
      ),
    );
  }


  Widget _gridViewTravellingWidget() {
    return BlocBuilder<TravelBloc, TravelState>(
      builder: (context, state) {
        if(state.status == TravelStatus.success){
          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
              mainAxisExtent: 230,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20
            ),
            itemCount: state.travel.length,
            itemBuilder: (context, index){
              return GestureDetector(
                child: CardTravellingWidget(
                  isFavorite: state.travel[index].isWishlist!,
                  onTap: (){
                     if(state.travel[index].isWishlist == true){
                       context.read<WishlistBloc>().add(WishlistEventDelete(state.travel[index].id.toString()));
                       setState(() {
                         state.travel[index].isWishlist = false;
                       });
                     } else {
                       context.read<WishlistBloc>().add(WishlistEventCreate(state.travel[index].id.toString()));
                       setState(() {
                         state.travel[index].isWishlist = true;
                       });
                     }
                  },
                  travel: state.travel[index],
                ),
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => BlocProvider(
                    create: (context) => WishlistBloc(WishListService()),
                    child: DetailTravellingScreen(travel: state.travel[index],),
                  ))
                ),
              );
            }
          );
        } else if(state.status == TravelStatus.failure){
          return const Center(child: Text('failed to fetch travel'));
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                mainAxisExtent: 230,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20
              ),
              itemCount: 6,
              primary: false,
              itemBuilder: (context, index){
                return CardTravellingWidget(
                  isFavorite: false,
                  onTap: (){},
                  travel: Travel(title: '', price: '0', image: 'https://via.placeholder.com/150'),
                );
              }
            ),
          );
        }
      },
    );
  }
}