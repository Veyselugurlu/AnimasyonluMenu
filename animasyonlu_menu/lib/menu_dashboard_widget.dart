import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const TextStyle menuFontStyle = TextStyle(color: Colors.white,fontSize: 20);
const Color backgroundColor = Color(0xFF343442);

class MenuDashBoard extends StatefulWidget {
  const MenuDashBoard({super.key});

  @override
  State<MenuDashBoard> createState() => _MenuDashBoardState();
}

class _MenuDashBoardState extends State<MenuDashBoard> with SingleTickerProviderStateMixin{
double? ekranYuksekligi, ekranGenisligi;
bool menuAcikMi = false;
AnimationController? _controller;
Animation<double>? _scaleAnimation;  // Bu animasyon, ana ekranin olçegini (scale) kontrol eder. Ornegin, menu acildiginda ana ekranin kuculmesini saglar.
Animation<double>? _scaleMenuAnimation; //menu acildiginda menunun buyumesini saglar.
Animation<Offset>? _menuOffsetAnimation;  //menunun ekran uzerindeki konumunu ayarlar.menu cubuguna tiklandiginda ekranin solda saga kaymasi gibi

final Duration _duration = Duration(milliseconds: 500);

@override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: _duration);
    _scaleAnimation =Tween(begin: 1.0,end : 0.6).animate(_controller!);
    _scaleMenuAnimation =Tween(begin: 0.0,end : 1.0).animate(_controller!);
    _menuOffsetAnimation = Tween(begin: Offset(-1,0) , end: Offset(0, 0)).
    animate(CurvedAnimation(parent: _controller!, curve: Curves.easeIn),);
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ekranGenisligi = MediaQuery.of(context).size.width;
    ekranYuksekligi = MediaQuery.of(context).size.height;    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            menuOlustur(context),
            dashBoardOlustur(context),
          ],
        ),
      ),
    );
  }

  menuOlustur(BuildContext context) {
    //menu olusturma
    return SlideTransition(  //widget'ı belirli bir kaydirma efektiyle ekrana getirir.
      position: _menuOffsetAnimation!,
      child: ScaleTransition(  //ekrani kücültme 
        scale: _scaleMenuAnimation!,  // olcek faktoru cocuk widget'in boyutunu nasil degistirecegini belirtir.
        child: Padding(
          padding: const EdgeInsets.only(left: 17.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize:MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dashboard",style: menuFontStyle,),
                const  SizedBox(height: 10,),
                 Text("Mesajar",style: menuFontStyle,),
                const  SizedBox(height: 10,),
                 Text("Utility Bills",style: menuFontStyle,),
                const  SizedBox(height: 10,),
                 Text("Fund Transfer",style: menuFontStyle,),
                const  SizedBox(height: 10,),
                 Text("Branches",style: menuFontStyle,),
                const  SizedBox(height: 10,),
            
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget dashBoardOlustur(BuildContext context) {
   // Dashboard oluşturma işlevi.
  return AnimatedPositioned(
    top: menuAcikMi ? 0.001 * ekranYuksekligi! : 0,
    bottom: menuAcikMi ? 0.001 * ekranYuksekligi! : 0,
    left: menuAcikMi ? 0.3 * ekranGenisligi! : 0,
    right: menuAcikMi ? -0.3 * ekranGenisligi! : 0,

    duration:_duration,

    child: ScaleTransition(
      scale: _scaleAnimation!,
      child: SingleChildScrollView(
        child: Material(
          borderRadius:menuAcikMi ? BorderRadius.all(Radius.circular(30)) : null,
          elevation: 15,
          color: backgroundColor,
          child:Container(
            padding:const EdgeInsets.only(
               top : 0,
             // top: 8,
              right: 16,
              left: 16,),
            child:  Column(
              children:  [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        if (menuAcikMi) {
                          _controller?.reverse();
                        }
                        else{
                          _controller?.forward();
                        }
                        menuAcikMi = !menuAcikMi;
                      });
                    },
                    child:const Icon(
                      Icons.menu,
                    color: Colors.white,),
                  ),
               const   Text("My Cards",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 24),
                    ),
                const  Icon(Icons.add_circle_outline,color: Colors.white,),
        
            
                ],
              ),
                Container(
                  margin:const EdgeInsets.only(top: 10),
                  height: 200,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
        
                        color: Colors.blue,
                        width: 100,
                        margin:const EdgeInsets.symmetric(horizontal: 12),
                      ),
                       Container(
        
                        color: Colors.red,
                        width: 100,
                        margin:const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      
          
                      Container(
        
                        color: Colors.yellow,
                        width: 100,
                        margin:const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
              
                ListView.separated(
                   shrinkWrap: true,
                   physics:const BouncingScrollPhysics(),
                 scrollDirection: Axis.vertical,
                 
                  itemBuilder: (context,index){
                  return  ListTile(
                    leading:const Icon(Icons.person),
                    title: Text("Öğrenci $index"),
                    trailing:const Icon(Icons.add),
        
                  );
                }, 
                separatorBuilder: (context, index){
                  return const Divider();
                }, itemCount: 40),
        
              ],
            ),
          ),
        ),
      ),
    ),
  );

   }
}
