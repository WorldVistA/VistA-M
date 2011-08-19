GMRYSTCA ;HIRMFO/YH-IV SITE AND CATHETER SELECTION ;3/1/96
 ;;4.0;Intake/Output;;Apr 25, 1997
SITECATH ;ENTER INFUSION SITE/CATH TYPE
 Q:GSITE'=""&(GCATH'="")&(GCATH(1)'="")  N GHOLD
 I GSITE'="",GDR'=1 S GHOLD=GCATH(2),GHOLD(1)=GCATH,(GHOLD(2),GHOLD(3))="" D:GCATH(1)="" FINDPORT(.GHOLD) Q:GMROUT  S GCATH(1)=GHOLD(3) Q
 E  D
 .N GMRZ D EN1^GMRYUT5 S X="" W ": " R X:DTIME I '$T!(X["^")!($L(X)>3) S:'$T!(X["^") GMROUT=1 S X="" Q
 .I '(X=""!(X["?")) D EN2^GMRYUT5 S GSITE=X
 Q:GMROUT  I X=""!(X["?") W !!,"Enter the number of the site you want and a L for LEFT/R for RIGHT after",!,"the number. The default is L(eft).",!,"For example, 1L or 1 is LEFT HAND, 1R is RIGHT HAND.",! S X="",GSITE="" G SITECATH
ENTER  S (GHOLD,GHOLD(1),GHOLD(2),GHOLD(3),GCATH(1),GCATH(2))=""
 I GCATH="" D CATH(.GHOLD) Q:GMROUT  S GCATH=GHOLD(1) D FINDPORT(.GHOLD) S GCATH(1)=GHOLD(3),GCATH(2)=GHOLD Q
 E  S GHOLD(1)=GCATH,GHOLD=$O(^GMRD(126.74,"B",GCATH,0)) D FINDPORT(.GHOLD)
 Q:GMROUT
YN W !,GHOLD(1)_"  "_GHOLD(3) ;S %=1 D YN^DICN W:%=0 !!,"Enter N(o) if the data is not correct.",! I %<1 S GMROUT=1 Q
 S GCATH(1)=GHOLD(3),GCATH(2)=GHOLD
 Q
FINDPORT(JJ) ;
 N GJ K GMRPORT
 I JJ>0,$P($G(^GMRD(126.74,+JJ,1,0)),"^",4)>0 D  Q:GMROUT
 . S GJ=0,GJ(1)="" F  S GJ(1)=$O(^GMRD(126.74,+JJ,1,"B",GJ(1))) Q:GJ(1)=""  S GJ(2)=0 F  S GJ(2)=$O(^GMRD(126.74,+JJ,1,"B",GJ(1),GJ(2))) Q:GJ(2)'>0  S GJ=GJ+1,GMRPORT(GJ)=GJ(2)_"^"_GJ(1)
PORT . S JJ(4)=GJ Q:GJ'>0!($G(GOPT)["FLUSH")!GMROUT  W ! F I=1:1:GJ W !,I_"  "_$P(GMRPORT(I),"^",2)
 . W !!,?3,"Select the port number used for medication infusion or ^ to quit: " S JJ(2)=0 R JJ(2):DTIME I '$T!(JJ(2)["^") S GMROUT=1
 . Q:GMROUT  I '$D(GMRPORT(+JJ(2))) W !,"ERROR ENTRY!" G PORT
 . S JJ(3)=$P(GMRPORT(+JJ(2)),"^",2)
 .Q
 Q
CATH(II) ;
 N GTXT,GMRY,GMRZ,GMRN
LISTC K GMRZ W !,"Select from the following IV CATHs",! S (GMRZ,GMRN)=0 F  S GMRZ=$O(^GMRD(126.74,GMRZ)) Q:GMRZ'>0  S GMRN=GMRN+1,GMRY(GMRN)=GMRZ_"^"_$P(^(GMRZ,0),"^")_"^"_GMRN_". "
 S GMRN(1)=(GMRN\2)+(GMRN#2) D LISTS^GMRYUT5 W !,"Select a number between 1 and "_GMRN_": " S X="" R X:DTIME I '$T!(X["^") S GMROUT=1 Q
 I X=""!(X["?")!'(X>0&(X<(GMRN+1))) W !,"Enter a number between 1 and "_GMRN G LISTC
 S II=+$P(GMRY(+X),"^"),II(1)=$P(^GMRD(126.74,II,0),"^")
 Q
