FHASXR1 ; HISC/REL - Print Screening (cont) ;4/20/95  08:53
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
Q1 ; Print assessment
 I $G(DFN)="" Q
 S X="T",%DT="X" D ^%DT S DT=Y,Y=^DPT(DFN,0),NAM=$P(Y,"^",1),SEX=$P(Y,"^",2),DOB=$P(Y,"^",3)
 S AGE=$E(DT,1,3)-$E(DOB,1,3)-($E(DT,4,7)<$E(DOB,4,7)) D PID^FHDPA
 S FHAP=$G(^FH(119.9,1,3)),FHU=$P(FHAP,"^",1)
 S LN="",$P(LN,"-",80)="",PG=0,S1=$S(IOST?1"C".E:IOSL-2,1:IOSL-6) D HEAD
 S UL="",$P(UL,"_",80)="",ANS=""
 W !!,"S:  Chewing Problems: Y N",?41,"Pre-Admission Diet: ",$E(UL,1,18)
 W !?4,"Dysphagia: Y N",?41,"Wt. + - ____ # in last ___ months"
 W !?4,"Appetite: + -",?41,"Nausea: Y N",?58,"Vomiting: Y N"
 W !?4,"Feeding Assistance Required: Y N",?41,"Diarrhea: Y N",?58,"Constipation: Y N"
 D ALG^FHCLN W !?4,"Food Allergies: " S ALG=$S(ALG="":"None on file",1:ALG) D LNE
 I $P(FHAP,"^",5)'="" W !?4,$P(FHAP,"^",5)
Q2 W !!,"O:  Current Diet: " G:WARD="" Q21 I $D(^FHPT(FHDFN,"A",ADM,0)) D CUR^FHORD7 W Y
 S X(0)=$G(^FHPT(FHDFN,"A",ADM,0))
 I Y'="",FHORD>0 I $D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1)) S COM=^(1) W:COM'="" !?4,"Comment: ",COM
 S TYP=$P(X,"^",8) I TYP'="" W !?4,"Service: ",$S(TYP="T":"Tray",TYP="D":"Dining Room",1:"Cafeteria")
 S DTP=$P(X(0),"^",3) I DTP D DTP^FH W !?4,"Expires: ",DTP
 S TF=$P(X(0),"^",4) G:TF<1 F2
 S Y=^FHPT(FHDFN,"A",ADM,"TF",TF,0)
 S DTP=$P(Y,"^",1),COM=$P(Y,"^",5),TQU=$P(Y,"^",6),CAL=$P(Y,"^",7)
 D DTP^FH W !?4,"Tubefeed Ordered: ",DTP
 F TF2=0:0 S TF2=$O(^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2)) Q:TF2<1  S XY=^(TF2,0) D LP
 W !?4,"Total Quantity: ",TQU," ml",?42,"Total KCAL: ",CAL
 W:COM'="" !?4,"Comment: ",COM
F2 S X=$P($G(^DGPM(ADM,0)),"^",10) W !?4,"Adm. Dx: ",$E(X,1,27)
 S DTP=$P($G(^DGPM(ADM,0)),"^",1) D DTP^FH W ?41,"Adm. Date:   ",?59,DTP
Q21 W !?4,"Age: ",AGE,?18,"Sex: ",SEX,?41,"Prior Assessment:" S ASN=$O(^FHPT(FHDFN,"N",0)) I ASN>0 S DTP=9999999-ASN D DTP^FH W ?59,DTP
 S Y=$S(ASN>0:^FHPT(FHDFN,"N",ASN,0),1:"")
 S HGT=$P(Y,"^",4),WGT=$P(Y,"^",6),DWGT=$P(Y,"^",8),UWGT=$P(Y,"^",9),IBW=$P(Y,"^",10),FRM=$P(Y,"^",11),AMP=$P(Y,"^",12),HGP=$P(Y,"^",5),WGP=$P(Y,"^",7)
 I HGT'="" S X1=$S(HGT\12:HGT\12_"'",1:"")_$S(HGT#12:" "_(HGT#12)_"""",1:""),X2=+$J(HGT*2.54,0,0)_" cm"
 S (FHHT,FHWWT,FHDWT,FHX1,FHX2)=""
 I DFN S GMRVSTR="WT" D EN6^GMRVUTL S FHDWT=$P(X,"^",1),FHWWT=$P(X,"^",8),GMRVSTR="HT" D EN6^GMRVUTL S FHHT=$P(X,"^",8)
 I FHHT'="" S FHX1=$S(FHHT\12:FHHT\12_"'",1:"")_$S(FHHT#12:" "_(FHHT#12)_"""",1:""),FHX2=+$J(FHHT*2.54,0,0)_" cm"
 W !?4,"Vitals Height:",?18 W:FHX2'="" FHX2
 W:FHX1'="" " (",FHX1,")"
 S (FHX1,FHX2)=""
 W ?41,"Frame Size:",?59,$S(FRM="S":"Small",FRM="M":"Medium",FRM="L":"Large",1:"")
 I FHWWT'="" S FHX1=FHWWT_" lbs",FHX2=+$J(FHWWT/2.2,0,1)_" kg"
 W !?4,"Vitals Weight:" W:FHX2'="" ?18,FHX2 W:FHX1'="" " (",FHX1,")"
 W ?41,"Weight Taken:"
 S DTP=""
 I FHDWT'="" S DTP=FHDWT D DTP^FH
 W ?59,DTP
 S DTP=DWGT D:DTP'="" DTP^FH
 ;W ?41,"Amputation %:",?59,AMP
 S (X1,X2)=""
 I WGT'="" S X1=WGT_" lbs",X2=+$J(WGT/2.2,0,1)_" kg"
 W !?4,"Last Weight:" I WGT'="" W ?18,X2 W:WGP'="" " ",WGP W " (",X1,")"
 W ?41,"Weight Taken:"
 S DTP=DWGT D DTP^FH W:WGT'="" ?59,DTP
 I UWGT'="" S X1=UWGT_" lbs",X2=+$J(UWGT/2.2,0,1)_" kg"
 W !?4,"Usual Weight:" I UWGT'="" W ?18,X2," (",X1,")"
 W ?41,"Last Weight/Usual Wt: " W:UWGT ?59,$J(WGT/UWGT*100,3,0),"%"
 I IBW'="" S X1=IBW_" lbs",X2=+$J(IBW/2.2,0,1)_" kg"
 W !?4,"Target Weight:" I IBW'="" W ?18,X2," (",X1,")"
 W ?41,"Last Weight/TBW:" W:IBW ?59,$J(WGT/IBW*100,3,0),"%"
 S BMI=""
 I FHWWT,FHHT S A2=FHHT*.0254,BMI=+$J(FHWWT/2.2/(A2*A2),0,1)
 W !?4,"Body Mass Index: ",BMI,?41,"Amputation %:",?59,AMP
Q3 S PX=4 D LAB^FHASM4
 W !!?32,"Laboratory Data",!?5,"Test",?30,"Result    units",?51,"Ref.   range",?67,"Date",!
 S N1=0 F K=0:0 S K=$O(LRTST(K)) Q:K=""  D LAB
 I 'N1 W !?5,"No laboratory data available last ",$S($D(^FH(119.9,1,3)):$P(^(3),"^",2),1:90)," days"
Q6 W !!?4,"Appearance: "
 W !!,"A:  Nutrition Status",?48,"Nutrition Education",!
 S E(1)="Further Education Required: Y N",E(2)=$E(UL,1,31)
 S N=0 F KK=0:0 S KK=$O(^FH(115.4,KK)) Q:KK<1&(N>1)  S N=N+1 W !?4 W:$P($G(^FH(115.4,+KK,0)),"^",2)'="" "___ ",$P(^(0),"^",2) W:N<3 ?48,E(N)
 W !?4,"Comments:"
 W !!,"P:  Nutrition Plan",!
 F KK=0:0 S KK=$O(^FH(115.5,KK)) Q:KK<1  W !?4,"___ ",$P(^(KK,0),"^",1)
 W !?4,"Recommendations:" F KK=1:1:IOSL-$Y-7 W !
 W !?41,$E(UL,1,38)
 W !?41,"Signature",?68,"Date"
 D FOOT Q:'NP!(ANS="^")  W:$E(IOST,1,2)'="C-" @IOF D Q0^FHASP Q
LAB S X1=$P(LRTST(K),"^",7) Q:X1=""  S DTP=X1\1 D DTP^FH S N1=N1+1
 W !?5,$P(LRTST(K),"^",1),?27,$P(LRTST(K),"^",6),?40,$P(LRTST(K),"^",4),?51,$P(LRTST(K),"^",5),?65,DTP Q
LNE ; Break Line if longer than 56 chars
 I $L(ALG)<57 W ALG Q
 F L=58:-1:1 Q:$E(ALG,L-1,L)=", "
 W $E(ALG,1,L-2)
 S ALG=$E(ALG,L+1,999)
 Q:ALG=""  W !?20
 G LNE
HEAD ; Page Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1,DTP=DT D DTP^FH
 W !,LN,!,DTP,?30,"NUTRITION SCREENING",?73,"Page ",PG,!,LN Q
FOOT ; Page Footer
 D PAUSE Q:IOST?1"C".E
 F KK=1:1:IOSL-$Y-5 W !
 D SITE^FH W !,LN,!,NAM W ?(80-$L(SITE)\2),SITE,?67,"VAF 10-9034"
 W ! W:PID'="" PID
 S W1=$G(^DPT(DFN,.1)) S:$D(^DPT(DFN,.101)) W1=W1_"/"_^DPT(DFN,.101) W:W1'="" ?(80-$L(W1)\2),W1,?66,"(Vice SF 509)"
 W !,LN,! Q
PAUSE ; Pause to Scroll
 I IOST?1"C".E R !!,"Press RETURN to continue." R X:DTIME S:'$T!(X["^") ANS="^" Q:ANS="^"  I "^"'[X W !,"Enter a RETURN to Continue." G PAUSE
 Q
LP S TUN=$P(XY,"^",1),STR=$P(XY,"^",2),QUA=$P(XY,"^",3)
 W !?7,$P($G(^FH(118.2,TUN,0)),"^",1),", ",$S(STR=4:"Full",STR=1:"1/4",STR=2:"1/2",1:"3/4")," Str., ",QUA Q
