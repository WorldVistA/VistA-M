FHPATM ; HISC/REL/JH - Patient Movements ;4/2/98  14:53
 ;;5.5;DIETETICS;**21**;Jan 28, 2005;Build 6
 ;Integration Agreements added FH*5.5*21 SLC/GDU
 ;GLOBAL REFERENCE  FIELD REFERECE                        DBIA
 ;^DG(405.4,D0      .01 NAME 0;1                          1380
 ;^DGPM(APTT1,DFN,                                        2090
 ;^DGPM(APTT2,DFN,                                        2090
 ;^DGPM(APTT4,DFN,                                        2090
 ;^DGPM(APID,DFN,INVERSE DATE_AS,DA                       2090
 ;^DGPM(DO,0        .03 PATIENT 0;3                       2090
 ;                  .06 WARD LOCATION 0;6                 2090
 ;                  .07 ROOM-BED 0;7                      2090
 ;                  .14 ADMISSION/CHECK-IN MOVEMENT 0;14  2090
 ;                  .18 MAS MOVEMENT 0;18                 2090
 ;^DIC(42,DO,0)     .015 DIVISION 0;11                    10039
 S DAT=0 D HDR
P1 S %DT="AEXT",%DT("A")="START with DATE@TIME: " W ! D ^%DT G:Y<1 KIL S DAT=Y
 I DAT>NOW W "  [ Date cannot be in Future ]" G P1
 S X1=DT,X2=-5 D C^%DTC I DAT<X W "  [ DATE MORE THAN 5 DAYS IN PAST ]" G P1
 D DIVISION^VAUTOMA
P2 W ! K IOP S %ZIS="MQ",%ZIS("A")="Select LIST Printer: " D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="F0^FHPATM",FHLST="DAT^DT^VAUTD*" D EN2^FH G KIL
 U IO D F0,NOTE D ^%ZISC K %ZIS,IOP G KIL
F0 D HDR W !!?5,"Name",?24,"ID#",?35,"Date/Time",?49,"FROM Ward-Bed",?65,"TO Ward-Bed"
 W !!?26,"--- A D M I S S I O N S ---",! S NOD="ATT1" D FND
 W !!?26,"--- D I S C H A R G E S ---",! S NOD="ATT3" D FND
 W !!?27,"--- T R A N S F E R S ---",! S NOD="ATT2" D FND W ! Q
HDR S H1="" I DAT S DTP=DAT D DTP^FH S H1=DTP_" to "
 W:$E(IOST,1,2)="C-" @IOF W !?23,"P A T I E N T   M O V E M E N T S"
 I $D(VAUTD) D
 . W !,"Division:  " I $D(VAUTD)=1 W "ALL" Q
 . N N F N=0:0 S N=$O(VAUTD(N)) Q:'N  W VAUTD(N)  W:$O(VAUTD(N))>0 ", "
 D NOW^%DTC S (DTP,NOW)=%,DT=NOW\1 D DTP^FH S H1=H1_DTP W !!?(80-$L(H1)\2),H1 Q
FND S NX=DAT-.0000005
F1 S NX=$O(^DGPM(NOD,NX)) Q:NX<1!(NX'<NOW)
 F DA=0:0 S DA=$O(^DGPM(NOD,NX,DA)) Q:DA=""  S X1=$G(^DGPM(DA,0)),NOWRD=0 D PRT
 G F1
PRT S DFN=+$P(X1,"^",3),ADM=$P(X1,"^",14),XT=$P(X1,"^",18) Q:ADM<1  D P0
 Q
P0 Q:'$D(^DPT(DFN,0))  S Y(0)=^(0) D PID^FHDPA I NOD="ATT1",XT=40 Q
 I NOD="ATT3",XT=41!(XT=42)!(XT=46)!(XT=47) Q
 S FH7R=0 D GET Q:NOD="ATT1"&TW=""  S:'FH7R FH7R=0 Q:'$G(VAUTD)&'$D(VAUTD(FH7R))
 W !,$E($P(Y(0),"^",1),1,21),?23,BID
 W ?32,$J(+$E(NX,6,7),2),"-",$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(NX,4,5))
 I NX#1 S I2=+$E(NX_"0",9,10) W $J($S(I2>12:I2-12,1:I2),3),":",$E(NX_"000",11,12),$S(I2>11:"pm",1:"am")
 W ?48,FW,?65,TW W:NOWRD="*" ?79,NOWRD Q
GET S (FW,FR)="" I NOD="ATT3" S (TW,TR)="" D LST G G1
 S TW=$P(X1,"^",6),TR=$P(X1,"^",7) I NOD="ATT1" Q:'TW  S NOWRD=$O(^FH(119.6,"AW",TW,0)) S:'NOWRD NOWRD="*" G G1
 S FW=TW,FR=TR
 I "^1^2^3^25^26^43^45^"[("^"_XT_"^") S TW=$S(XT=2!(XT=26):"AUTH LEAVE",XT=3!(XT=25):"UA LEAVE",XT=1:"ON PASS",XT=43!(XT=45):"ASIH OTHER",1:TW),TR=""
 I "^22^23^24^25^26^44^"[("^"_XT_"^") S FW=$S(XT=24!(XT=25):"AUTH LEAVE",XT=22!(XT=26):"UA LEAVE",XT=23:"PASS",XT=44:"ASIH OTHER",1:FW),FR=""
 I "^4^13^14^45^"[("^"_XT_"^") D LST
G1 S:FW FH7R=$P($G(^DIC(42,FW,0)),"^",11) I 'FH7R,TW S FH7R=$P($G(^DIC(42,TW,0)),"^",11)
 S:FW FW=$O(^FH(119.6,"AW",FW,0)) S:FW FW=$P($G(^FH(119.6,FW,0)),U) S SW=TW S:TW TW=$O(^FH(119.6,"AW",TW,0))
 I TW S TW=$P($G(^FH(119.6,TW,0)),U)
 E  S:SW TW=$P(^DIC(42,SW,0),U),NOWRD="*"
 S:FR FR=$P(^DG(405.4,FR,0),"^",1) S:TR TR=$P(^DG(405.4,TR,0),"^",1)
 S FW=FW_" "_FR,TW=TW_" "_TR Q  ;S FW=$E(FW,1,14-$L(FR))_" "_FR,TW=$E(TW,1,14-$L(TR))_" "_TR Q
LST S TRN=9999999.9999999-$E(NX,1,14)
 F TRN=TRN:0 S TRN=$O(^DGPM("APID",DFN,TRN)) Q:TRN=""  F T0=0:0 S T0=$O(^DGPM("APID",DFN,TRN,T0)) Q:T0=""  I T0'=DA S X=$G(^DGPM(T0,0)),FW=$P(X,"^",6),FR=$P(X,"^",7) G:FW L1
L1 S:"^43^45^"[("^"_$P(X,"^",18)_"^") FR="",FW="ASIH OTHER" Q
NOTE W !!,"* Denotes that there is no associated Ward in the Dietetic Ward File!" Q
KIL G KILL^XUSCLEAN
