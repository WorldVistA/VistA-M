FHORE21 ; HISC/REL/NCA - List Early/Late Trays (cont) ;11/9/94  13:33 
 ;;5.5;DIETETICS;**5,8,15**;Jan 28, 2005;Build 2
 ;patch #5 - added outpt room-bed.
 S D1=DTE,COUNT=0,LINE=1 K ^TMP($J) S ANS=""
F2 S D1=$O(^FHPT("ADLT",D1)) G:D1<1!(D1\1'=DTE) P0 S FHDFN=0
F3 S FHDFN=$O(^FHPT("ADLT",D1,FHDFN)) G:FHDFN<1 F2 S ADM=0
F4 S ADM=$O(^FHPT("ADLT",D1,FHDFN,ADM)) G:ADM<1 F3
 I $S($D(^DGPM(ADM,0)):$P(^(0),"^",17),1:1) G F7
 S Y(0)=$G(^FHPT(FHDFN,"A",ADM,"EL",D1,0)) G:Y(0)="" F7
 S X=$G(^FHPT(FHDFN,"A",ADM,0)),OLW=$P(X,"^",11),IS=$P(X,"^",10)
 S W1=$P(X,"^",8),X2=$G(^FH(119.6,+W1,0)),WARD=$P(X2,"^",1)
 G:WARD="" F4 S P0=$P(X2,"^",8) I FHP,P0'=FHP G F4
 S M1=$P(Y(0),"^",2) I MEAL'="A",M1'=MEAL G F4
 D CUR G:FHLD'="" F4 S O1=Y
 S ^TMP($J,"EL",D1_"-"_$P(Y(0),"^",6),FHDFN_"-"_ADM)=WARD_"^"_P0_"^"_OLW_"^"_IS_"^"_O1_"^"_$P(Y(0),"^",2,4) G F4
P0 D NOW^%DTC S DTP=% D DTP^FH S H1=DTP,DTP=DTE\1 D DTP^FH S L1=DTP
 I LAB S LAB=$P($G(^FH(119.9,1,"D",IOS,0)),"^",2) S:'LAB LAB=1
 S S1=LAB=2*5+36
P1 S M2="Z",PG=0 D:'LAB HDR
 S N1="" F  S N1=$O(^TMP($J,"EL",N1)) Q:N1=""!(ANS="^")  S N2="" F  S N2=$O(^TMP($J,"EL",N1,N2)) Q:N2=""  S Y=^(N2) D P2 Q:ANS="^"
 ;
 D ^FHOMELT  ;List Outpatient (Recurring Meals) Late Trays
 I LAB<1 W !!
 S FHPREV="" D:'LAB OPHDR
 F N1="B","N","E"  D
 .I '$D(^TMP($J,N1)) Q
 .S N2="" F  S N2=$O(^TMP($J,N1,N2)) Q:N2=""!(ANS="^")  D
 ..S FHDATA=$G(^TMP($J,N1,N2)),FHLOC=$P(FHDATA,U,1),FHDFN=$P(FHDATA,U,2)
 ..S FHBAG=$P(FHDATA,U,3),(O1,FHDIET)=$P(FHDATA,U,4),RM=$P(FHDATA,U,5) D PATNAME^FHOMUTL
 ..S (WARD,FHLOCNM)=$E($P($G(^FH(119.6,FHLOC,0)),U,1),1,10)
 ..S FHIP=$P($G(^FHPT(FHDFN,0)),U,5),FHIPD="",IS=""
 ..I FHIP'="" S (IS,FHIPD)=$P($G(^FH(119.4,FHIP,0)),U,2)_$P($G(^FH(119.4,FHIP,0)),U,3)
 ..S P1=FHPTNM,BID=FHBID,TIM=$P(N2,"~",1),M1=N1
 ..I LAB<1 D OUTP
 ..I LAB>0,LAB<3 D P3
 ..I LAB>2 D LL Q
 I LAB>2 D DPLL^FHLABEL K ^TMP($J) Q
 I LAB<3 F K=1:1:$S('LAB:1,1:18) W !
 Q
P2 S FHDFN=+N2,WARD=$P(Y,"^",1),P0=$P(Y,"^",2),OLW=$P(Y,"^",3),IS=$P(Y,"^",4),O1=$P(Y,"^",5),M1=$P(Y,"^",6),TIM=$P(Y,"^",7),BAG=$P(Y,"^",8)
 I IS S IS=^FH(119.4,IS,0),IS=$P(IS,"^",2)_$P(IS,"^",3)
 D PATNAME^FHOMUTL I DFN="" Q
 S Y=^DPT(DFN,0),P1=$P(Y,"^",1) D PID^FHDPA
 S RM=$G(^DPT(DFN,.101)) I LAB>2 D LL Q
 G:LAB P3
 I $Y>(IOSL-10) D HDR Q:ANS="^"  W !!?56,$S(M1="B":"Breakfast ",M1="N":"   Noon ",1:" Evening "),$J(TIM,6),! S M2=M1_TIM
 S X=M1_TIM I X'=M2 W !!?56,$S(M1="B":"Breakfast ",M1="N":"   Noon ",1:" Evening "),$J(TIM,6),! S M2=X
 W !,$S(WARD'="":$E(WARD,1,10),1:"")_$S(RM'="":"/"_$E(RM,1,10),1:""),?24,$E(P1,1,22),?50,BID,?61,$S(IS'="":IS,1:""),?67,$S(BAG="Y":"YES",1:""),?73,O1
 D ALG^FHCLN W !,"Allergies: ",$S(ALG="":"None on file",1:ALG)
 Q
P3 S P1=$E(P1,1,22),WARD=$E(WARD,1,15),RM=$E(RM,1,10)
 D ALG^FHCLN
 W !,$S(M1="B":"Breakfast",M1="N":"  Noon ",1:" Evening"),?10,TIM,?(S1-12),L1 W:LAB=2 !
 W !,$E(P1,1,S1-5-$L(WARD)),?(S1-3-$L(WARD)),WARD
 W !,BID W:IS'="" ?(S1-3\2),IS W ?(S1-3-$L(RM)),RM W:LAB=2 !
 I $L(O1)<S1 W !,O1,$S(ALG="":"",1:" *ALG"),!!
 E  S L=$S($L($P(O1,",",1,3))<S1:3,1:2) W !,$P(O1,",",1,L),!,$E($P(O1,",",L+1,5),2,99),$S(ALG="":"",1:"*ALG"),!
 W:LAB=2 ! Q
OUTP ;
 I $Y>(IOSL-10) D OPHDR Q:ANS="^"
 S NEW=N1_$P(N2,"~",1) I FHPREV'=NEW W !!?56,$S(N1="B":"Breakfast ",N1="N":"   Noon ",1:" Evening "),$J($P(N2,"~",1),6),!
 W !,FHLOCNM
 D PATNAME^FHOMUTL W "/"_RM,?24,FHPTNM,?50,FHBID
 W ?61,FHIPD,?67,$S(FHBAG="Y":"YES",1:"")
 W ?73,FHDIET
 D ALG^FHCLN W !,"Allergies: ",$S(ALG="":"None on file",1:ALG)
 S FHPREV=N1_$P(N2,"~",1)
 Q
F7 K ^FHPT("ADLT",D1,FHDFN,ADM) G F4
CUR S A1=0,(Y,FHLD,FHOR)="" F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1!(KK>D1)  S A1=KK
 Q:'A1  S FHORD=$P(^FHPT(FHDFN,"A",ADM,"AC",A1,0),"^",2),X=^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),FHOR=$P(X,"^",2,6),FHLD=$P(X,"^",7)
 I FHLD'="" S FHDU=";"_$P(^DD(115.02,6,0),"^",3),%=$F(FHDU,";"_FHLD_":") Q:%<1  S Y=$P($E(FHDU,%,999),";",1) Q
 S Y="" F A1=1:1:5 S D3=$P(FHOR,"^",A1) I D3 S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7)
 Q
DP K N S Y=$G(^FH(119.73,+P0,1))
 F KK=1,2,3,7,8,9,13,14,15 S X=$P(Y,"^",KK) I X'="" S N($S(KK<7:"B",KK<13:"N",1:"E"),X)=""
 Q
HDR ; Print Header (INPATIENT)
 I PG,IOST?1"C-".E R !!,"Press RETURN to continue or ""^"" to exit. ",ANS:DTIME S:'$T!(ANS["^") ANS="^" Q:ANS="^"  I "^"'[ANS W !,"Enter Return or ""^""." G HDR
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !?32,"I N P A T I E N T   E A R L Y / L A T E   T R A Y S",?110,H1
 W !,$S('FHP:"Consolidated",1:$P(^FH(119.73,FHP,0),"^",1)),?61,L1,?121,"Page ",PG
 W !!,"Ward/Room",?24,"Patient",?50,"ID#",?61,"Iso   Bag   Current-Diet",! Q
OPHDR ; Print Header (OUTPATIENT)
 I PG,IOST?1"C-".E R !!,"Press RETURN to continue or ""^"" to exit. ",ANS:DTIME S:'$T!(ANS["^") ANS="^" Q:ANS="^"  I "^"'[ANS W !,"Enter Return or ""^""." G OPHDR
 W:$E(IOST,1,2)="C-" @IOF S PG=PG+1
 W !?32,"O U T P A T I E N T   E A R L Y / L A T E   T R A Y S",?110,H1
 W !,$S('FHP:"Consolidated",1:$P(^FH(119.73,FHP,0),"^",1)),?61,L1,?121,"Page ",PG
 W !!,"Ward/Room",?24,"Patient",?50,"ID#",?61,"Iso   Bag   Current-Diet",! Q
LL ;
 D ALG^FHCLN
 S FHCOL=$S(LAB=3:3,1:2)
 I LABSTART>1 F FHLABST=1:1:(LABSTART-1)*FHCOL D  S LABSTART=1
 .I LAB=3 S (PCL1,PCL2,PCL3,PCL4,PCL5,PCL6)="" D LL3^FHLABEL
 .I LAB=4 S (PCL1,PCL2,PCL3,PCL4,PCL5,PCL6,PCL7,PCL8)="" D LL4^FHLABEL
 .Q
 S SL1=$S(LAB=3:25,1:38)
 S MEALTM=$S(M1="B":"Breakfast",M1="N":"Noon",1:"Evening")_"  "_TIM
 S BID=BID_$S(ALG="":"",1:" *ALG")
 S BIDIS=BID_$E("        ",1,12-$L(BID))_IS
 S WARD=$E(WARD,1,15),WLN=$L(WARD),RM=$E(RM,1,10)
 I LAB=3 D
 .S P1=$E(P1,1,24-WLN)
 .S (PCL1,PCL6)="",PCL2=MEALTM_$J(L1,25-$L(MEALTM))
 .S PCL3=P1_$J(WARD,25-$L(P1)),PCL4=BIDIS_$J(RM,25-$L(BIDIS))
 .S PCL5=$E(O1,1,29) D LL3^FHLABEL
 I LAB=4 D
 .S P1=$E(P1,1,37-WLN)
 .S (PCL1,PCL2,PCL7,PCL8)="",PCL3=MEALTM_$J(L1,38-$L(MEALTM))
 .S PCL4=P1_$J(WARD,38-$L(P1)),PCL5=BIDIS_$J(RM,38-$L(BIDIS))
 .S PCL6=$E(O1,1,42) D LL4^FHLABEL
 Q
