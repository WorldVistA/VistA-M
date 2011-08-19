FHASP ; HISC/REL - Nutrition Profile ;11/16/94  16:55
 ;;5.5;DIETETICS;**5,8**;Jan 28, 2005;Build 28
 ;RVD patch #8 - added drug screening and print order of a drug based on the site parameter.
 ;               replaced Ideal to Target and added BMI.
P0 S ALL=1 D ^FHDPA G:'DFN KIL S:WARD="" ADM=""
 ;ask user for how far to print encounter, 1 yr back as default.
 W ! S %DT="AEP",%DT("A")="Print Dietetics Encounter since Date: "
 S %DT("B")="T-365",%DT(0)="-T" D ^%DT K %DT Q:X["^"!$D(DTOUT)
 S FHET=Y
 D MONUM^FHOMUTL I FHNUM="" Q
 ;
L0 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q0^FHASP",FHLST="FHDFN^DFN^PID^ADM^WARD^FHNUM" D EN2^FH D KILL^XUSCLEAN G P0
 U IO D Q0 D ^%ZISC K %ZIS,IOP G FHASP
Q0 ; Print Profile
 D NOW^%DTC S NOW=%,DT=NOW\1 S FHU=$S($D(^FH(119.9,1,3)):$P(^(3),"^",1),1:"E")
 S Y=^DPT(DFN,0),NAM=$P(Y,"^",1),SEX=$P(Y,"^",2),DOB=$P(Y,"^",3)
 S AGE="" I DOB'="" S AGE=$E(NOW,1,3)-$E(DOB,1,3)-($E(NOW,4,7)<$E(DOB,4,7))
 S LN="",$P(LN,"-",80)="",ANS="",PG=0,S1=$S(IOST?1"C".E:IOSL-2,1:IOSL-7) D HEAD
 W !!,"Status: " I WARD="" W "Outpatient"
 E  S DTP=$P(^DGPM(ADM,0),"^",1) D DTP^FH W "Inpatient admitted ",DTP D ^FHASP2
 S RC="",ASE=$O(^FHPT(FHDFN,"S",0)) I ASE S Y=^(ASE,0),RC=$P(Y,"^",2),DTP=$P(Y,"^",1)
 ;get problem and additional problem for the last assessment on file.
 S (FHADPROB,FHPROB)=""
 S ASN=$O(^FHPT(FHDFN,"N",0)) I ASN D
 .S (FHADPROB,FHPROB)=""
 .I $D(^FHPT(FHDFN,"N",ASN,3)) S FHPROB=$P(^(3),U,4)
 .I $D(^FHPT(FHDFN,"N",ASN,"DI")) S FHADPROB=$P(^("DI"),U,3)
 W !!,"Problem: ",FHPROB,!,"Additional Problem: ",FHADPROB
 W !!,"Nutrition Status: " I RC W ?20,$P($G(^FH(115.4,RC,0)),"^",2) D DTP^FH W "  (",$E(DTP,1,9),")"
 D ALG^FHCLN W !!,"Allergies: " S ALG=$S(ALG="":"None on file",1:ALG) D LNE^FHDMP
 W !!?29,"Nutrition Assessments"
 I ASN'>0 W !!?5,"No assessments on file." G Q1
 W !!,"Recent Assessments:"
 S N1=0 F K=0:0 S K=$O(^FHPT(FHDFN,"N",K)) Q:K<1  S DTP=$P(^(K,0),"^",1) D DTP^FH W "  ",$E(DTP,1,9) S N1=N1+1 Q:N1=3
 S Y=^FHPT(FHDFN,"N",ASN,0)
 S N1=0 F K=1,4:1:11,21 S N1=N1+1,@$P("ADT HGT HGP WGT WGP DWGT UWGT IBW XD BMI"," ",N1)=$P(Y,"^",K)
 S X1=$S(HGT\12:HGT\12_"'",1:"")_$S(HGT#12:" "_(HGT#12)_"""",1:""),X2=+$J(HGT*2.54,0,0)_" cm"
 ;
 S (FHHT,FHWWT,FHX1,FHX2,FHDVT)=""
 I DFN S GMRVSTR="WT" D EN6^GMRVUTL S FHDVT=$P(X,"^",1),FHWWT=$P(X,"^",8),GMRVSTR="HT" D EN6^GMRVUTL S FHHT=$P(X,"^",8)
 S:'FHDVT FHDVT=$P(X,"^",1)
 I FHHT'="" S FHX1=$S(FHHT\12:FHHT\12_"'",1:"")_$S(FHHT#12:" "_(FHHT#12)_"""",1:""),FHX2=+$J(FHHT*2.54,0,0)_" cm"
 W !!,"Vitals Height: " W:FHX2'="" FHX2 W:FHX1'="" " (",FHX1,")"
 K FHX2,FHX1
 S (FHX1,FHX2)=""
 I FHWWT'="" S FHX1=FHWWT_" lbs",FHX2=+$J(FHWWT/2.2,0,1)_" kg"
 W ?40,"Vitals Wt: " W:FHWWT'="" FHX2," (",FHX1,")"
 I WGT S X1=WGT_" lbs",X2=+$J(WGT/2.2,0,1)_" kg"
 W !,"Last Wt: " W:WGT X2," (",X1,")"
 I UWGT S X1=UWGT_" lbs",X2=+$J(UWGT/2.2,0,1)_" kg"
 W !,"Usual Wt: " W:UWGT X2," (",X1,")" W ?40,"Last Wt/Usual Wt: " W:UWGT $J(WGT/UWGT*100,3,0),"%"
 S X1=IBW_" lbs",X2=+$J(IBW/2.2,0,1)_" kg"
 W !,"Target Wt: " W:IBW X2," (",X1,")" W ?40,"Last Wt/TBW:      " W:IBW $J(WGT/IBW*100,3,0),"%"
 S BMI=""
 I FHWWT,FHHT S A2=FHHT*.0254,BMI=+$J(FHWWT/2.2/(A2*A2),0,1)
 W !,"Body Mass Index: ",BMI
 S DTP=FHDVT D:DTP'="" DTP^FH W ?40,"Date Taken:   ",DTP
 I XD W !!?5,"Nutrition Class: " W ?20,$P($G(^FH(115.3,XD,0)),"^",1)
Q1 S PX=0 D LAB^FHASM4 S PX=$S(WARD="":0,1:1) D DRUG^FHASM4
 W !!?34,"Medications" S N1=0
 F N2=0:0 S N2=$O(PSCNS(N2)) Q:N2=""  S FHCN3="" F  S FHCN3=$O(PSCNS(N2,FHCN3)) Q:FHCN3=""  D
 .D:$Y'<S1 HF Q:ANS="^"  W:'N1 ! W !?5,FHCN3 S N1=N1+1
 Q:ANS="^"
 I 'N1 W !!?5,"No current medications in selected drug classes."
 W !!?32,"Laboratory Data"
 S N1=0 F K=0:0 S K=$O(LRTST(K)) Q:K=""  D:$Y'<S1 HF Q:ANS="^"  D LAB
 Q:ANS="^"
 I 'N1 W !!?5,"No selected laboratory data available last ",$S($D(^FH(119.9,1,3)):$P(^(3),"^",2),1:90)," days."
 G ^FHASP1
LAB S X1=$P(LRTST(K),"^",7) Q:X1=""  S DTP=X1\1 D DTP^FH
 I 'N1 W !?5,"Test",?30,"Result    units",?51,"Ref.   range",?67,"Date",!
 S N1=N1+1
 W !?5,$P(LRTST(K),"^",1),?27,$P(LRTST(K),"^",6),?40,$P(LRTST(K),"^",4),?51,$P(LRTST(K),"^",5),?65,DTP Q
HF ; Do Header and Footer
 D FOOT Q:ANS="^"  D HEAD
 Q
HEAD ; Page Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1,DTP=DT D DTP^FH
 W !,LN,!,DTP,?31,"NUTRITION PROFILE",?73,"Page ",PG,!,LN
 W !,NAM,?40,$S(SEX="M":"Male",SEX="F":"Female",1:""),?73,"Age ",AGE,! Q
FOOT ; Page Footer
 D PAUSE Q:IOST?1"C".E
 F KK=1:1:IOSL-$Y-6 W !
 D SITE^FH W !,LN,!,NAM W ?(80-$L(SITE)\2),SITE,?67,"VAF 10-9034"
 W ! W:PID'="" PID
 S W1=$G(^DPT(DFN,.1)) S:$D(^DPT(DFN,.101)) W1=W1_"/"_^DPT(DFN,.101) W:W1'="" ?(80-$L(W1)\2),W1 W ?66,"(Vice SF 509)"
 W !,LN,! Q
PAUSE ; Pause For Scroll
 I IOST?1"C".E R !!,"Press RETURN to continue. ",X:DTIME S:'$T!(X["^") ANS="^" Q:ANS="^"  I "^"'[X W !,"Enter a RETURN to Continue." G PAUSE
 Q
KIL ; Final variable kill
 G KILL^XUSCLEAN
