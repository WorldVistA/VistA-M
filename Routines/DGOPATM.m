DGOPATM ;GLRISC/REL - Patient Movements ;11/4/89  11:05 ;
 ;;5.3;Registration;**93,162**;Aug 13, 1993
 S (DAT,DGU)=0 D HDR
P1 S %DT="AEXT",%DT("A")="START with DATE@TIME: " W ! D ^%DT G:Y<1 KIL S DAT=Y
 I DAT>NOW W "  [ Date cannot be in Future ]" G P1
 S X1=DT,X2=-5 D C^%DTC I DAT<X W "  [ DATE MORE THAN 5 DAYS IN PAST ]" G P1
P2 S DGVAR="DAT^DGU",DGPGM="F0^DGOPATM" W ! D ZIS^DGUTQ I 'POP U IO G F0^DGOPATM
KIL K %,%DT,%ZIS,ADM,DAT,DFN,DTP,DGVAR,DGPGM,DGU,DGX,FHA1,FW,FR,H1,I2,KK,LL,LST,NOD,NOW,NX,POP,RM,T1,TRN,TW,TR,X,X1,X2,Y,VA("BID"),VA("PID"),VAIP,VAERR,VADAT,VADATE D CLOSE^DGUTQ Q
F0 D HDR1
 S DGX="--- A D M I S S I O N S ---" W !!?26,DGX,! S NOD="AMV1" D FND G KIL:DGU
 S DGX="--- D I S C H A R G E S ---" W !!?26,DGX,! S NOD="AMV3" D FND G KIL:DGU
 S DGX="--- T R A N S F E R S ---" W !!?26,DGX,! S NOD="AMV2" D FND W ! G KIL:DGU
 G KIL
DTP S DTP=$E(DTP,1,12) S DTP=$$FMTE^XLFDT(DTP,"1P") Q
HDR S H1="" I DAT S DTP=DAT D DTP S H1=DTP_" to "
 W @IOF,!!?23,"P A T I E N T   M O V E M E N T S"
 D NOW^%DTC S (DTP,NOW)=%,DT=NOW\1 D DTP S H1=H1_DTP W !!?(80-$L(H1)\2),H1 Q
FND S NX=$P(DAT,".",1)-.0001
FN1 S NX=$O(^DGPM(NOD,NX)) I NX=""!(NX[".")!(NX>(DAT\1)) G FN2
 F DFN=0:0 S DFN=$O(^DGPM(NOD,NX,DFN)) Q:'DFN  D PRT Q:DGU
FN2 S LST=DT+1,NX=DAT+$S(DAT[".":-.0001,1:.0000001)
FN3 S NX=$O(^DGPM(NOD,NX)) Q:NX=""!(NX'<LST)!(DGU)
 F DFN=0:0 S DFN=$O(^DGPM(NOD,NX,DFN)) G:'DFN FN3 D PRT Q:DGU
 Q:DGU
PRT S ADM=$O(^DGPM(NOD,NX,DFN,0)) Q:'ADM  D P0
 Q
P0 Q:'$D(^DPT(DFN,0))  S Y(0)=^(0) Q:'$D(^DGPM(ADM,0))
 I NOD="AMV1" S X1=$P(^DGPM(ADM,0),"^",18) Q:X1=40
 I NOD="AMV3" S X1=$P(^DGPM(ADM,0),"^",18) I X1=41!(X1=42)!(X1=46)!(X1=47) Q
 I $Y+6>IOSL D RT Q:DGU
 D PID^VADPT6 W !,$E($P(Y(0),"^",1),1,22),?24,VA("BID")
 W ?32,$J(+$E(NX,6,7),2),"-",$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(NX,4,5))
 I NX#1 S I2=+$E(NX_"0",9,10) W $J($S(I2>12:I2-12,1:I2),3),":",$E(NX_"000",11,12),$S(I2>11:"pm",1:"am")
 D GET W ?48,FW,?65,TW Q
GET S (FW,TW,FR,TR)=""
 S X1=^DGPM(ADM,0) I NOD="AMV1" S TW=$P(X1,"^",6),TR=$P(X1,"^",7) G G1
 S FW=$P(X1,"^",6),FR=$P(X1,"^",7) G:NOD="AMV2" G0
 S VAIP("E")=ADM D IN5^VADPT I VAIP(15)]"" S T1=^DGPM(VAIP(15),0) S:T1<NX FW=$P(T1,"^",6) S:$P(T1,"^",7) FR=$P(T1,"^",7) I +T1'<NX S TW=$P(T1,"^",6) S:$P(T1,"^",7) TR=$P(T1,"^",7)
 S:TW'="" FW=TW,TW="",FR=TR,TR="" G G1
G0 S X2="",VAIP("E")=ADM D IN5^VADPT
 I VAIP(15)]"" S X1=^DGPM(VAIP(15),0) I X1<NX S FW=$P(X1,"^",6),FR=$P(X1,"^",7),X2=$P(X1,"^",18)
 S X1=^DGPM(ADM,0),TW=$P(X1,"^",6),TR=$P(X1,"^",7)
 S X1=$P(X1,"^",18)
 I "^1^2^3^25^43^45^"[("^"_X1_"^") S TW=$S(X1=2:"AUTH LEAVE",X1=3!(X1=25):"UA LEAVE",X1=1:"ON PASS",X1=44:"ASIH",X1=43!(X1=45):"ASIH OTHER",1:TW),TR=""
 I "^14^22^23^24^44^45^"[("^"_X1_"^") S FW=$S(X1=24:"AUTH LEAVE",X1=22:"UA LEAVE",X1=23:"FROM PASS",X2=43!(X1=45)!(X1=44):"ASIH OTHER",1:FW) I X1'=14,(X2'=13) S FR="" ; keep room if returning from asih in same hosp
G1 S:FW FW=$P(^DIC(42,FW,0),"^",1) S:TW TW=$P(^DIC(42,TW,0),"^",1)
 S:FR FR=$P(^DG(405.4,FR,0),"^",1) S:TR TR=$P(^DG(405.4,TR,0),"^",1)
 S FW=$E(FW,1,14-$L(FR))_" "_FR,TW=$E(TW,1,14-$L(TR))_" "_TR Q
RT F X=$Y:1:(IOSL-2) W !
 I (IOST?1"C-".E) R ?22,"Enter <RET> to continue or '^' to QUIT ",X:DTIME S:X["^"!('$T) DGU=1 Q:DGU
 D HDR1 W !!?26,DGX,! Q
HDR1 D HDR W !!?5,"Name",?24,"PT ID",?35,"Date/Time",?49,"FROM Ward-Bed",?67,"TO Ward-Bed"
