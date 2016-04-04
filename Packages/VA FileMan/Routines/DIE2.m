DIE2 ;SFISC/GFT,XAK-DELETE AN ENTRY ;12:37 PM  20 Feb 2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,11,95,999**
 ;
 D F,DL Q:$D(DTOUT)  G B^DIED:Y=2,A^DIED:Y,UP^DIE1:DL>1,Q^DIE1
 ;
F S D=$P(DQ(DQ),U,4) S:DP+1 D=DIFLD Q
 ;
Z S DIEZFLAG=1 D DL K DIEZFLAG S DU="" I Y=2 G @(DQ_U_DNM)
 I Y D:$G(DE(DW,"INDEX")) SAVEVALS^@DNM G @("A^"_DNM)
 G R^DIE9:DL>1,E^DIE9
DL ;
 S %=DP,X=D,Y=$P(DQ(DQ),U,4)="0;1"
 G X:$D(DE(DQ))[0,X:DV["R"&'Y,X:$D(^DD("KEY","F",DP,D))&'Y,S:DP<0,DD:DUZ(0)="@" I DV S %=+$P(DC,U,2),X=.01
 G DD:DP<2 I $D(DIDEL),DIDEL\1=(DP\1) G DD
 I Y,$S($D(^VA(200,"AFOF")):1,1:$D(^DIC(3,"AFOF"))) G DD:$D(^DD(DP,0,"UP"))!DV,DAR:'$S($D(^VA(200,DUZ,"FOF",DP)):1,1:$D(^DIC(3,DUZ,"FOF",DP))),DAR:'$P(^(DP,0),U,3),DD
 I Y,$D(^DIC(%,0,"DEL")) S X=^("DEL")
 E  G DD:'$D(^DD(%,X,8.5)) S X=^(8.5)
 G DD:X="" F %=1:1:$L(X) G DD:DUZ(0)[$E(X,%)
DAR D  ;**CCO/NI "DELETE ACCESS REQUIRED"   thru next 5 lines
 .N IN,OUT
 .S IN(1)=$$LABEL^DIALOGZ(DP,DIFLD),IN(2)=$$FILENAME^DIALOGZ(DP)
 .D BLD^DIALOG(712,.IN,,"OUT"),EN^DDIOL(.OUT)
X I $D(DB(DQ)) D N G A
 W:$D(^DD("KEY","F",DP,D))!(DV["R")&'$D(DIER) "  ",$$EZBLD^DIALOG(8041) G R ;This is a required response. Enter '^' to exit
 ;
 ;
DD G MD:DV S DH=0,DU=0 F  S DH=$O(^DD(DP,D,"DEL",DH)) Q:DH=""  I $D(^(DH,0)) X ^(0) Q:$D(DTOUT)  G X:$T ;IF SWITCH ON MEANS NO DELETION ALLOWED
CC ;CONSISTENCY CHECK WOULD GO HERE
 S DH=-1,X=DQ(DQ) I Y,$E(@(DIE_"0)"))'=U S X=^(0)
 D D G R:X I Y D FIREREC(DP) S X=DE(DQ) D DEL:$D(DIU(0)) K DE,DG,DQ,DB S DIK=DIE D ^DIK S Y=0 K:DL<2 DA Q
S S X="",DG($P(DQ(DQ),U,4))="" D:'$G(DIEZFLAG) LOADXR^DIED
A S Y=1 Q
 ;
D I $D(DB(DQ)) S X=0 Q
 W $C(7),!?3,"SURE YOU WANT TO DELETE"
 I Y W " THE ENTIRE " W:DV'["D"&(DV'["P")&(DV'["V") "'"_DE(DQ)_"' " W $P(X,U,1)
 S %=0,X=0 D YN^DICN Q:%=1  S X=1 W:$X>55 !?9
N I $D(DE(DQ))#2,'$D(DDS) W:'$D(ZTQUEUED) $C(7),"  <NOTHING DELETED>"
 Q
 ;
MD G X:DV["R"&($P(DC,U,5)=1) S DH=0,DU=0 F  S DH=$O(^DD(+$P(DC,U,2),.01,"DEL",DH)) Q:DH=""  I $D(^(DH,0)) D DDA X ^(0) D UDA G X:$T
 S DH=-1,Y=DC>1,X=$E(DQ(DQ),8,99) D D
 I 'X D DDA D FIREREC(+$P(DC,U,2)) S DIK=DIC D ^DIK,UDA K DE(DQ) S X=$P(@(DIK_"0)"),U,3,4),DC=$P(DC,U,1,3)_U_X,DIC=DIE S:$D(^(+X,0)) DE(DQ)=$P(^(0),U,1)
R S Y=2 Q
 ;
DDA N T,X
 S T=$T
 F X=+$O(DA(" "),-1):-1:1 K DA(X+1) S:$D(DA(X))#2 DA(X+1)=DA(X)
 S:$D(DA)#2 DA(1)=DA
 S DIC=DIE_DA_","""_$P(DC,U,3)_""",",DA=$P(DC,U,4)
 S:$D(DIETMP)#2 DIIENS=DA_","_DIIENS
 I T
 Q
 ;
UDA N T,X
 S T=$T
 S DA=$G(DA(1)) ;K DA(1)
 F X=2:1:+$O(DA(" "),-1) I $D(DA(X))#2 S DA(X-1)=DA(X) K DA(X)
 S:$D(DIETMP)#2 DIIENS=$P(DIIENS,",",2,999)
 I T
 Q
QS ;
 G ^DIEQ
QQ ;
 G QQ^DIEQ
 Q
DEL I '$S($D(^VA(200,"AFOF",DA)):1,1:$D(^DIC(3,"AFOF",DA))) Q
 S DA(1)="",DIFOF=DA
 F P=0:0 S DA(1)=$S($D(^VA(200,"AFOF")):$O(^VA(200,"AFOF",DA,DA(1))),1:$O(^DIC(3,"AFOF",DA,DA(1)))) Q:'DA(1)  I $S($D(^VA(200,DA(1),"FOF",DA)):1,1:$D(^DIC(3,DA(1),"FOF",DA))) S DIK=$S($D(^VA(200)):"^VA(200,",1:"^DIC(3,")_DA(1)_",""FOF""," D ^DIK
 K DA S DA=DIFOF K DIFOF
 Q
V ;
 G ^DIE3
 ;
FIREREC(DIFILE) ;Fire record-level xrefs accumulated in ^TMP for file
 ;or subfile DIFILE and all its subfiles
 G:$G(DIEZFLAG) FIRERECZ
 Q:$D(DIETMP)[0
 Q:$D(@DIETMP@("R"))<2
 ;
 ;If we're at top level, fire all accumulated record-level xrefs
 N X,Y
 I '$G(^DD(DIFILE,0,"UP")) D FIREREC^DIE1 Q
 ;
 ;Save the DA array and DIIENS
 N DASV,DIIENSSV
 M DASV=DA S DIIENSSV=DIIENS
 ;
 ;Get list of subfiles under DIFILE
 N DA,DIE,DIFLIST,DIIENS,DIPAT,DP
 D SUBFILES^DIKCU(DIFILE,.DIFLIST)
 S DIFLIST(DIFILE)=""
 S DIPAT=".E1"""_DIIENSSV_""""
 ;
 ;Fire record-level cross references DIFILE and its subfiles
 S DP=0 F  S DP=$O(DIFLIST(DP)) Q:'DP  D
 . Q:'$D(@DIETMP@("R",DP))
 . S DIIENS=" " F  S DIIENS=$O(@DIETMP@("R",DP,DIIENS)) Q:DIIENS=""  D
 .. Q:DIIENS'?@DIPAT
 .. S DIE=@DIETMP@("R",DP,DIIENS)
 .. D DA^DILF(DIIENS,.DA)
 .. D FIRE^DIKC(DP,.DA,"KS",$NA(@DIETMP@("R")),"F")
 .. K @DIETMP@("R",DP,DIIENS),@DIETMP@("V",DP,DIIENS)
 . K:'$D(@DIETMP@("V",DP)) @DIETMP@("R",DP)
 Q
 ;
FIRERECZ ;Come here from FIREREC above, for compiled templates
 Q:'$D(DIEZRXR)
 ;
 ;If we're at top level, fire all accumulated record-level xrefs
 N X,Y
 I '$G(^DD(DIFILE,0,"UP")) D FIREREC^DIE17 Q
 ;
 ;Save the DA array and DIIENS
 N DASV,DIIENSSV
 M DASV=DA S DIIENSSV=DIIENS
 ;
 ;Get list of subfiles under DIFILE
 N DA,DIE,DIEZXR,DIFLIST,DIIENS,DIPAT,DP
 D SUBFILES^DIKCU(DIFILE,.DIFLIST)
 S DIFLIST(DIFILE)=""
 S DIPAT=".E1"""_DIIENSSV_""""
 ;
 ;Fire record-level cross references DIFILE and its subfiles
 S DP=0 F  S DP=$O(DIFLIST(DP)) Q:'DP  D
 . Q:'$D(DIEZRXR(DP))
 . S DIIENS=" " F  S DIIENS=$O(DIEZRXR(DP,DIIENS)) Q:DIIENS=""  D
 .. Q:DIIENS'?@DIPAT
 .. S DIE=DIEZRXR(DP,DIIENS)
 .. D DA^DILF(DIIENS,.DA)
 .. S DIEZXR=0 F  S DIEZXR=$O(DIEZRXR(DP,DIEZXR)) Q:DIEZXR'=+DIEZXR  D
 ... D:$D(DIEZAR(DP,DIEZXR))#2 @DIEZAR(DP,DIEZXR)
 .. K DIEZRXR(DP,DIIENS),@DIETMP@("V",DP,DIIENS)
 . K:'$D(@DIETMP@("V",DP)) DIEZRXR(DP)
 Q
