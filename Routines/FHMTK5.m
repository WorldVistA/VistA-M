FHMTK5 ; HISC/NCA - List Patients Without Diet Patterns/Ind Pattern ;3/09/04  12:35
 ;;5.5;DIETETICS;;Jan 28, 2005
LIS W !!,"The list requires a 132 column printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="L1^FHMTK5",FHLST="" D EN2^FH G KIL
 U IO D L1 D ^%ZISC K %ZIS,IOP G KIL
L1 ; Process Listing Patients Without Diet Patterns & Patients
 ; With Individual Pattern
 D NOW^%DTC S DTP=% D DTP^FH S FHDTP=DTP
 K ^TMP($J,"D"),^TMP($J,"NP"),^TMP($J,"W") S ANS=""
 F W1=0:0 S W1=$O(^FH(119.6,W1)) Q:W1<1  D
 .S P0=$G(^FH(119.6,W1,0)),WRDN=$P(P0,"^",1),P0=$P(P0,"^",4),P0=$S(P0<1:99,P0<10:"0"_P0,1:P0)
 .S ^TMP($J,"W",P0_WRDN)=W1 Q
 S NX="" F  S NX=$O(^TMP($J,"W",NX)) Q:NX=""  S X1=$G(^(NX)),W1=+X1 D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",W1,FHDFN)) Q:FHDFN<1  D
 ..D PATNAME^FHOMUTL I DFN="" Q
 ..S ADM=$G(^FHPT("AW",W1,FHDFN)),RI=$G(^DPT(DFN,.108)),RM=$G(^DPT(DFN,.101)) S:RM="" RM="***"
 ..S RE=$S(RI:$O(^FH(119.6,"AR",+RI,W1,0)),1:"")
 ..S R0=$S(RE:$P($G(^FH(119.6,W1,"R",+RE,0)),"^",2),1:"")
 ..S R0=$S(R0<1:99,R0<10:"0"_R0,1:R0)
 ..D CUR^FHORD7 Q:"^^^^"[FHOR  S:Y'="" O1=Y
 ..Q:$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,2))'=""
 ..S DPAT=$O(^FH(111.1,"AB",FHOR,0))
 ..I 'DPAT S ^TMP($J,"NP",NX_"~"_R0_"~"_RM_"~"_FHDFN)=FHDFN_"^"_ADM_"^"_O1 Q
 ..S TIM=$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)),"^",9) D GET
 ..Q
 .Q
 S PG=0 D HDR S X9="" F  S X9=$O(^TMP($J,"NP",X9)) Q:X9=""  S FHDFN=$P(^(X9),"^",1),ADM=$P(^(X9),"^",2),Y=$P(^(X9),"^",3) D  Q:ANS="^"
 .D PATNAME^FHOMUTL I DFN="" Q
 .S RM=$P(X9,"~",3),WRDN=$E($P(X9,"~",1),3,99)
 .D:$Y'<(IOSL-8) HDR Q:ANS="^"
 .W !,$E(WRDN,1,15)_"/"_$E(RM,1,15),?34,$E($P($G(^DPT(DFN,0)),"^",1),1,30),?66,Y Q
 Q:ANS="^"  S PG=0 D HDR1 S X9="" F  S X9=$O(^TMP($J,"D",X9)) Q:X9=""  S XX=$G(^(X9)),ZZ=$G(^(X9,1)),FHDFN=$P(XX,"^",1),ADM=$P(XX,"^",2),Y=$P(XX,"^",3) D  Q:ANS="^"
 .D PATNAME^FHOMUTL I DFN="" Q
 .S RM=$P(X9,"~",3),WRDN=$E($P(X9,"~",1),3,99)
 .D:$Y'<(IOSL-8) HDR1 Q:ANS="^"
 .W !!,$E(WRDN,1,15)_"/"_$E(RM,1,15),!,$E($P($G(^DPT(DFN,0)),"^",1),1,30)
 .S DTP=$P(XX,"^",4) D:DTP'="" DTP^FH W:DTP'="" ?32,DTP W ?52,"Current: ",Y,!
 .S DTP=$P(ZZ,"^",2) D:DTP'="" DTP^FH W:DTP'="" ?32,DTP W ?52,"Prev. Pattern: ",$P(ZZ,"^",1),! Q
 Q
GET ; Get Previous Diet Order
 K ^TMP($J,"TRAV") S SK=0 F K0=0:0 S K0=$O(^FHPT(FHDFN,"A",ADM,"AC",K0)) Q:K0<1!(K0'<TIM)  S K2=$G(^(K0,0)),SK=K0,^TMP($J,"TRAV",9999999-SK)=K2
 S X7="" F K0=0:0 S K0=$O(^TMP($J,"TRAV",K0)) Q:K0<1  S K2=$G(^(K0)) D  Q:X7'=""
 .S X5=$P(K2,"^",2) Q:'X5
 .S X6=$G(^FHPT(FHDFN,"A",ADM,"DI",+X5,0)) Q:X6=""
 .Q:$P(X6,"^",7)'=""
 .S X7=$G(^FHPT(FHDFN,"A",ADM,"DI",+X5,2))
 .Q:X7=""
 .S X8=$P($G(^FHPT(FHDFN,"A",ADM,"DI",+X5,0)),"^",9) D CUR
 .S X8=$S($P($G(^FHPT(FHDFN,"A",ADM,"DI",+X5,3)),"^",2):$P(^FHPT(FHDFN,"A",ADM,"DI",+X5,3),"^",2),1:X8)
 .S ^TMP($J,"D",NX_"~"_R0_"~"_RM_"~"_FHDFN)=FHDFN_"^"_ADM_"^"_O1_"^"_TIM
 .S ^TMP($J,"D",NX_"~"_R0_"~"_RM_"~"_FHDFN,1)=Y_"^"_X8 Q
 .Q
 Q
CUR S Y="" Q:X6=""  S FHOR=$P(X6,"^",2,6),FHLD=$P(X6,"^",7)
 I FHLD'="" S FHDU=";"_$P(^DD(115.02,6,0),"^",3),%=$F(FHDU,";"_FHLD_":") Q:%<1  S Y=$P($E(FHDU,%,999),";",1) Q
 F A1=1:1:5 S D3=$P(FHOR,"^",A1) I D3 S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7)
 Q
HDR ; Print No Diet Pattern Heading
 D PAUSE Q:ANS="^"  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !,FHDTP,?33,"I N P A T I E N T S   W I T H   N O   D I E T   P A T T E R N S",?123,"Page ",PG
 W !!,"Ward/Room",?34,"Patient",?66,"Current-Diet",!
 Q
HDR1 ; Print Previous Diet Pattern Heading
 S PG=PG+1 D PAUSE Q:ANS="^"  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 W !,FHDTP,?27,"P A T I E N T S   T H A T   H A D   I N D I V I D U A L   P A T T E R N S",?123,"Page ",PG
 W !!,"Patient",?32,"Effective",?52,"Diet"
 Q
PAUSE ; Check to pause for reading
 I IOST?1"C".E,PG R !!,"Press RETURN to continue. ",X:DTIME S:'$T!(X["^") ANS="^" Q:ANS="^"  I "^"'[X W !,"Enter a RETURN to Continue." G PAUSE
 Q
KIL K ^TMP($J) G KILL^XUSCLEAN
