import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_travelling/artikel/bloc/rekomendasi_bloc.dart';
import 'package:healing_travelling/artikel/domain/models/rekomendasi_model.dart';
import 'package:healing_travelling/artikel/screens/detail_artikel_screen.dart';
import 'package:healing_travelling/home/widgets/card_rekomendasi_widget.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/widget/custom_appbar_widget.dart';
import 'package:shimmer/shimmer.dart';

class ArtikelScreen extends StatefulWidget {
  const ArtikelScreen({ Key? key }) : super(key: key);

  @override
  State<ArtikelScreen> createState() => _ArtikelScreenState();
}

class _ArtikelScreenState extends State<ArtikelScreen> {
  final _scrollController = ScrollController();
  late int index;

  @override
  void initState() {
    index = 1;
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_isBottom){
      index++;
      context.read<RekomendasiBloc>().add(RekomendasiEventFetch(index.toString()));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      appBar: CustomAppbarWidget(
        appBar: AppBar(), 
        title: 'Rekomendasi'
      ),
      body: _gridViewRekomendasiWidget(),
    );
  }

  Widget _gridViewRekomendasiWidget() {
    return BlocBuilder<RekomendasiBloc, RekomendasiState>(
      builder: (context, state) {
        if(state.status == RekomendasiStatus.success){
          return GridView.builder(
            padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                mainAxisExtent: 200,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20
              ),
            itemCount: state.rekomendasi.length,
            itemBuilder: (context, index){
              return GestureDetector(
                //tambah reverse untuk menampilkan data yang terbaru terlebih dahulu
                child: CardRekomendasiWidget(rekomendasi: state.rekomendasi.reversed.toList()[index]),
                onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailArtikelScreen(rekomendasi: state.rekomendasi.reversed.toList()[index],))
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
                return CardRekomendasiWidget(rekomendasi: Rekomendasi(title: '', content: '', image: ''));
              }
            ),
          );
        }
      },
    );
  }
}