FHASMR1 ; HISC/REL/NCA/JH - Assessment Report (cont) ;5/17/96  12:48
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
EN ; Print Report
 D NOW^%DTC S NOW=% K % S ANS=""
 I '$G(ASN),$G(FHCAS) S ASN=FHCAS
 S LN="",$P(LN,"-",80)="",PG=0,S1=$S(IOST?1"C".E:IOSL-2,1:IOSL-6) D HEAD
 W !!,NAM,?40,$S(SEX="M":"Male",1:"Female"),?60,"Age ",AGE
 S DTP=ADT D DTP^FH W !?25,"Date of Assessment: ",$E(DTP,1,9)
 S (FHRDIPLD,FHRDIST,FHRDIPL,FHRDINFD,FHRDINA,FHRDINFD,FHRDINF,FHREDU,FHRDIDI,FHRDITF,FHRDITFD,FHRDITFM,FHRDITFK,FHRDITFC,FHRNWGT,FHRDNWGT,FHRFUD,FHRFEC,FHRFPC,FHRFDC)="" D DIA
EN1 S DTP="" I FHRDIPLD S DTP=FHRDIPLD D DTP^FH
 I $G(FH7FLG)=1 G FLG7
 W !,"Diagnosis: ",$E(FHRDIPL,1,30)
 S DTP="" I FHRDINFD S DTP=FHRDINFD D DTP^FH
 W !,"Problem: ",$E(FHRDINA,1,30)
 S DTP="" I FHRDINFD S DTP=FHRDINFD D DTP^FH
 W !,"Additional Problem: ",$E(FHRDINF,1,30)
 W !!,"Current Diet: ",$E(FHRDIDI,1,33)
 I FHRDITFD'="" D
 .W !,"Tubefeed Ordered: " S DTP=FHRDITFD D DTP^FH W DTP
 .I ASN I $D(^FHPT(FHDFN,"N",ASN,"TF")) F FHTUN=0:0 S FHTUN=$O(^FHPT(FHDFN,"N",ASN,"TF",FHTUN)) Q:FHTUN'>0  D
 ..S FHASTFZN=$G(^FHPT(FHDFN,"N",ASN,"TF",FHTUN,0))
 ..S TNM=$P(FHASTFZN,U,1),STR=$P(FHASTFZN,U,2),QUA=$P(FHASTFZN,U,3)
 ..W !?3,$P($G(^FH(118.2,TNM,0)),"^",1),", ",$S(STR=4:"Full",STR=1:"1/4",STR=2:"1/2",1:"3/4")," Str., ",QUA Q
 .W !,"Total Quantity: ",FHRDITFM," ml",?42,"Total KCAL: ",FHRDITFK
 .W !,"Tubefeed Comment: ",FHRDITFC
 K FHASTFZN,FHRDIPL,FHRDIPLD,FHRDINF,FHRDINFD,FHRDIDI,FHRDITF,DTP,FHRDITFD,FHRDITFM,FHRDITFK,FHRDITFC
FLG7 S X1=$S(HGT\12:HGT\12_"'",1:"")_$S(HGT#12:" "_(HGT#12)_"""",1:""),X2=+$J(HGT*2.54,0,0)_" cm"
 W !!,"Height:        ",$S(FHU'="M":X1,1:X2)," (",$S(FHU'="M":X2,1:X1),")" W:HGP'="" " ",$S(HGP="K":"knee hgt",HGP="S":"stated",1:"")
 S X1=WGT_" lbs",X2=+$J(WGT/2.2,0,1)_" kg"
 W !,"Weight:        ",$S(FHU'="M":X1,1:X2)," (",$S(FHU'="M":X2,1:X1),")" W:WGP'="" " ",$S(WGP="A":"anthro",WGP="S":"stated",1:"")
 S DTP="" I DWGT S DTP=DWGT D DTP^FH
 W ?50,"Weight Taken:     ",DTP
 S X1=FHRNWGT_" lbs",X2=+$J(FHRNWGT/2.2,0,1)_" kg"
 ;W !,"New Weight:   ",$S(FHU'="M":X1,1:X2)," (",$S(FHU'="M":X2,1:X1),")" W:WGP'="" " ",$S(WGP="A":"anthro",WGP="S":"stated",1:"") S DTP=FHRDNWGT D DTP^FH W ?50,"New Weight Taken: ",DTP
 K FHRNWGT,FHRDNWGT
 I UWGT S X1=UWGT_" lbs",X2=+$J(UWGT/2.2,0,1)_" kg"
 W !,"Usual Weight:  " W:UWGT $S(FHU'="M":X1,1:X2)," (",$S(FHU'="M":X2,1:X1),")" W ?50,"% Usual Wt:       " W:UWGT $J(WGT/UWGT*100,3,0),"%"
 I '$D(IBW) S IBW=RIBW
 S X1=IBW_" lbs",X2=+$J(IBW/2.2,0,1)_" kg"
 W !,"Target Weight: ",$S(FHU'="M":X1,1:X2)," (",$S(FHU'="M":X2,1:X1),")" W ?50,"% Target Wt:      " W:IBW $J(WGT/IBW*100,3,0),"%"
 I AMP W !?6,"Target weight adjusted for amputation"
 W !,"Frame Size:    ",$S(FRM="S":"Small",FRM="M":"Medium",FRM="L":"Large",1:"")
 W ?50,"Body Mass Index:  ",BMI
 ;W:BMIP'="" " (",BMIP,"% )"
 I $G(TSF)!$G(SCA)!$G(ACIR)!$G(CCIR) S EXT="Y"
 D:$Y'<(S1-3) HF Q:ANS="^"  G:EXT'="Y" Q4 W !!?26,"Anthropometric Measurements",!?35,"%ile",?71,"%ile",!
 W !?4,"Triceps Skinfold (mm)" I TSF W ?31,$J(+TSF,3,0),?36,$J(TSFP,3)
 W ?43,"Arm Circumference (cm)" I ACIR W ?67,$J(+ACIR,3,0),?72,$J(ACIRP,3)
 W !?4,"Subscapular Skinfold (mm)" I SCA W ?31,$J(+SCA,3,0),?36,$J(SCAP,3)
 W ?43,"Bone-free AMA (cm2)" I BFAMA W ?67,$J(+BFAMA,3,0),?72,$J(BFAMAP,3)
 W !?4,"Calf Circumference (cm)" I CCIR W ?31,$J(+CCIR,3,0),?36,$J(CCIRP,3)
Q4 I $Y'<(S1-4) D HF Q:ANS="^"
 W !!?32,"Laboratory Data",!?5,"Test",?30,"Result    units",?51,"Ref.   range",?67,"Date"
 S N1=0 F K=0:0 S K=$O(LRTST(K)) Q:K=""  D LAB
 I 'N1 W !!?3,"No laboratory data available last ",$S($D(^FH(119.9,1,3)):$P(^(3),"^",2),1:90)," days"
 S N=PRO/6.25 I $Y'<(S1-4) D HF Q:ANS="^"
DRU ;pharmacy data.
 W !!?3,"Medications"
 S PX=1 D DRUG^FHASM4
 I $D(PSCA) D
 .W !
 .F FHI=0:0 S FHI=$O(PSCA(FHI)) Q:FHI'>0  S FHJ="" F  S FHJ=$O(PSCA(FHI,FHJ)) Q:FHJ=""  D
 ..W !?3,FHJ
 W !!,"Educated on Food/Drug Interactions: ",$S(FHREDU="Y":"Yes",1:"No") K FHREDU
 W !,"FOOD/DRUG COMMENT: ",FHRFDC
 K FHI,FHJ,PSD,PSCA,FHRFDC
 I $D(FHFEC),(FHFEC'="") S FHRFEC=FHFEC
 W !!,"Energy Requirements:  ",KCAL," Kcal/day" W:N ?50,"Kcal:N  ",$J(KCAL/N,0,0),":1" W:NB'="" ?67,"N-Bal: ",NB
 W:FHRFEC'="" !?3,"Energy calculation is based on: ",FHRFEC
 I $D(FHFPC),(FHFPC'="") S FHRFPC=FHFPC
 W !,"Protein Requirements: ",PRO," gm/day" W:N ?50,"NPC:N   ",$J(KCAL-(PRO*4)/N,0,0),":1"
 W:FHRFPC'="" !?3,"Protein calculation is based on: ",FHRFPC
 K FHRFEC,FHRFPC
 I FLD'="" W !,"Fluid Requirements:   ",FLD," ml/day"
 G:'PRT Q6
 D:$Y'<(S1-4) HF Q:ANS="^"  W:APP'="" !!,"Appearance: ",?20,APP
 I XD W !,"Nutrition Class: " W ?20,$P($G(^FH(115.3,XD,0)),"^",1)
 I RC W !,"Nutrition Status: " W ?20,$P($G(^FH(115.4,RC,0)),"^",2)
 D DCOM
 Q
 ;D:$Y'<(S1-4) HF Q:ANS="^"  W !!,"Comments",!
DIA ;patch #8: adding diagnosis, follow-up date and status data.
 ;get data from DI node.
 ;
 I ASN S FHDIA=$G(^FHPT(FHDFN,"N",ASN,"DI")) Q:FHDIA=""  D
 .S FHRDIPL=$P(FHDIA,U,1)
 .S FHRDIPLD=$P(FHDIA,U,2)
 .S FHRDINF=$P(FHDIA,U,3)
 .S FHRDINFD=$P(FHDIA,U,4)
 .S FHRFUD=$P(FHDIA,U,5)
 .S FHRDIST=$P(FHDIA,U,6)
 .S FHRDIDI=$P(FHDIA,U,7)
 .S FHRDITFD=$P(FHDIA,U,8)
 .S FHRDITFM=$P(FHDIA,U,10)
 .S FHRDITFK=$P(FHDIA,U,11)
 .S FHRDITFC=$P($G(^FHPT(FHDFN,"N",ASN,4)),U,1)
 .S FHRFEC=$P($G(^FHPT(FHDFN,"N",ASN,3)),U,2)
 .S FHRFPC=$P($G(^FHPT(FHDFN,"N",ASN,3)),U,3)
 .S FHRDINA=$P($G(^FHPT(FHDFN,"N",ASN,3)),U,4)
 .S FHREDU=$P($G(^FHPT(FHDFN,"N",ASN,3)),U,5)
 .S FHRFDC=$P($G(^FHPT(FHDFN,"N",ASN,3)),U,6)
 Q
DCOM ;print follow up date and status and comments
 S DTP="" I FHRFUD S DTP=FHRFUD D DTP^FH
 W !!,"Follow-up Date: ",DTP
 W ?40,"Assessment Status: ",$S(FHRDIST="C":"Completed",FHRDIST="S":"Signed",FHRDIST="W":"Work in Progress",1:"")
 K FHRFUD,FHRDIST
 W !!,"Comments:"
 I ASN F K=0:0 S K=$O(^FHPT(FHDFN,"N",ASN,"X",K)) Q:K<1  D:$Y'<S1 HF Q:ANS="^"  W !,^FHPT(FHDFN,"N",ASN,"X",K,0)
 S SIGN=$P(^FHPT(FHDFN,"N",ASN,0),U,23) W:SIGN'="" !!,"Entered by: ",$P($P(^VA(200,SIGN,0),U),",",2)," ",$P($P(^VA(200,SIGN,0),U),",")
 G:$E(IOST)="C" Q6 F KK=1:1:IOSL-$Y-7 W !
 S $P(UL,"-",39)="" W !?38,UL W !?38,"Signature",?68,"Date"
Q6 D FOOT Q
LAB S X1=$P(LRTST(K),"^",7) Q:X1=""  S DTP=X1\1 D DTP^FH S N1=N1+1
 I $Y'<S1 D HF Q:ANS="^"
 W !?5,$P(LRTST(K),"^",1),?27,$P(LRTST(K),"^",6),?40,$P(LRTST(K),"^",4),?51,$P(LRTST(K),"^",5),?65,DTP Q
HF ; Do Header and Footer
 D FOOT Q:ANS="^"  D HEAD
 Q
HEAD ; Page Header
 I IOST?1"C".E W @IOF Q
 W:PG @IOF S PG=PG+1,DTP=DT D DTP^FH
 W !,LN,!,DTP,?29,"NUTRITION ASSESSMENT",?73,"Page ",PG,!,LN Q
FOOT ; Page Footer
 D PAUSE Q:IOST?1"C-".E
 F KK=1:1:IOSL-$Y-5 W !
 D SITE^FH W !,LN,!,NAM W ?(80-$L(SITE)\2),SITE,?67,"VAF 10-9034"
 W ! W:PID'="" PID
 I $G(DFN) S W1=$G(^DPT(DFN,.1)) S:$D(^DPT(DFN,.101)) W1=W1_"/"_^DPT(DFN,.101) W:W1'="" ?(80-$L(W1)\2),W1,?66,"(Vice SF 509)"
 I 'DFN S W1="Outpatient Assesment" W ?(80-$L(W1)\2),W1,?66,"(Vice SF 509)"
 W !,LN,! Q
PAUSE ; Pause to Scroll
 I IOST?1"C".E R !!,"Press RETURN to continue. ",YN:DTIME S:'$T!(YN["^") ANS="^" Q:ANS="^"  I "^"'[YN W !,"Enter a RETURN to Continue." G PAUSE
 Q
