import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_travelling/artikel/bloc/rekomendasi_bloc.dart';
import 'package:healing_travelling/artikel/domain/models/rekomendasi_model.dart';
import 'package:healing_travelling/artikel/domain/services/rekomendasi_service.dart';
import 'package:healing_travelling/artikel/screens/artikel_screen.dart';
import 'package:healing_travelling/artikel/screens/detail_artikel_screen.dart';
import 'package:healing_travelling/home/bloc/banner_bloc.dart';
import 'package:healing_travelling/home/domain/services/banner_service.dart';
import 'package:healing_travelling/home/widgets/card_rekomendasi_widget.dart';
import 'package:healing_travelling/home/widgets/carousel_widget.dart';
import 'package:healing_travelling/profile/screens/profile_screen.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';
import 'package:healing_travelling/widget/custom_text_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RekomendasiBloc(RekomendasiService())..add(RekomendasiEventFetch('1')),
        ),
        BlocProvider(
          create: (context) => BannerBloc(BannerService())..add(BannerEventFetch()),
        ),
      ],
      child: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      appBar: _appBarWidget(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bannerBlocBuilderWidget(),
            SizedBox(height: 24,),
            _subtitleWidget(context),
            _gridViewRekomendasiWidget()
          ],
        ),
      ),
    );
  }

  Widget _gridViewRekomendasiWidget() {
    return BlocBuilder<RekomendasiBloc, RekomendasiState>(
      builder: (context, state) {
        if(state.status == RekomendasiStatus.success){
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 6/7
            ),
            shrinkWrap: true,
            primary: false,
            itemCount: 6,
            itemBuilder: (context, index){
              return GestureDetector(
                child: CardRekomendasiWidget(rekomendasi: state.rekomendasi[index]),
                onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailArtikelScreen(rekomendasi: state.rekomendasi[index],))
                ),
              );
            }
          );
        } else if(state.status == RekomendasiStatus.failure){
          return const Center(child: Text('failed to fetch posts'));
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 6/7
              ),
              shrinkWrap: true,
              primary: false,
              itemCount: 6,
              itemBuilder: (context, index){
                return CardRekomendasiWidget(rekomendasi: Rekomendasi(title: '', content: '', image: 'https://via.placeholder.com/150'));
              }
            ),
          );
        }
      },
    );
  }

  Padding _subtitleWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(
            text: 'Rekomendasi Wisata',
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          GestureDetector(
            onTap: ()=> Navigator.push(
              context, 
              MaterialPageRoute(builder: (_) => BlocProvider.value(value: BlocProvider.of<RekomendasiBloc>(context), child: ArtikelScreen(),))
            ),
            child: CustomTextWidget(
              text: 'Lihat semua',
              fontSize: 12,
              color: kPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  AppBar _appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryBackgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: kPrimaryBackgroundColor,
        statusBarIconBrightness: Brightness.dark
      ),
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: 'Selamat datang',
              fontSize: 14,
              color: Colors.black,
            ),
            CustomTextWidget(
              text: '${SharedPreferenceSingleton.getString("name")}',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )
          ],
        )
      ),
      actions: [
        GestureDetector(
          onTap: ()=> Navigator.push(
            context, 
            MaterialPageRoute(builder: (_) => ProfileScreen())
          ),
          child: Container(
            width: 36,
            height: 36,
            margin: EdgeInsets.only(right: 16, top: 16),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/user.png')
              )
            ),
          ),
        )
      ],
    );
  }

  Widget bannerBlocBuilderWidget(){
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if(state is BannerSuccess){
          return Container(
            height: 160,
            margin: EdgeInsets.only(top: 28),
            decoration: BoxDecoration(
              color: Colors.grey[200]
            ),
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 24),
              itemBuilder: (context, index){
                return Container(
                  width: 300,
                  height: 161,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[400],
                    image: DecorationImage(
                      image: NetworkImage(state.banner[index].image!),
                      fit: BoxFit.cover
                    )
                  ),
                );
              }, 
              separatorBuilder: (_,__) => SizedBox(width: 10,), 
              itemCount: state.banner.length
            ),
          );
        } else if(state is BannerFailed){
          return Center(child: Text('get banner failed ${state.message}'));
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: CarouselWidget(length: 3,), 
          );
        }
      },
    );
  }
}

