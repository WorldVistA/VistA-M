FHASM1 ; HISC/REL - Nutrition Assessment ;1/25/00  12:08
 ;;5.5;DIETETICS;**8,14,22**;Jan 28, 2005;Build 1
 W @IOF,!!?20,"N U T R I T I O N   A S S E S S M E N T",!! S X="T",%DT="X" D ^%DT S DT=+Y
F1 ; Select Patient
 S FHALL=1 D ^FHOMDPA G KILL^XUSCLEAN:'FHDFN
 S:DFN'>0 DFN=""
 I $G(DFN),$P($G(^DPT(DFN,.35)),"^",1) W *7,!!?5,"  [ Patient has expired. ]" G KILL^XUSCLEAN
 S (ADM,ASN,FHASK,KNEE,EXT,DTP,FHCAS,FHCASD,FHASS,FHFFC,FHFEC,FHFPC,FHCFRBO,FHCM,FHEF,FHKCAL,FHLOC)="",(FHHWF,FHQUIT)=0
 S (ADT,SEX,AGE,HGT,HGP,WGT,WGP,DWGT,UWGT,IBW,FRM,AMP,KCAL,PRO,FLD,RC,XD,BMI,BMIP,FHCLI,FHPLXSV)=""
 S (NOW,NB,TSF,TSFP,SCA,SCAP,ACIR,ACIRP,CCIR,CCIRP,BFAMA,BFAMAP,FHAPP,FHEDU,DEWGT,WARD,FHSPC)=""
 S (FHDIPL,FHDIPLD,FHAST,FHDINF,FHDINFD,FHFUD,FHDIST,FHDIDI,FHDITF,FHDIDI,FHDITF,FHDITFDT,FHDITFCM,FHDITFML,FHDITFKC,FHVHGT,FHDVHGT)=""
 S (TSF,TSFP,SCA,SCAP,ACIR,ACIRP,CCIR,CCIRP,BFAMA,BFAMAP,BMI,BMIP,X1,X2,FHFUDS,EKKG,FHFDC,FHFDCSV)=""
 S (WCCM,CIBW,CERBO,CENB,PCTB,SEF,CFRB,CFRBO,CPRBO,NWGT,DNWGT,FHYN,FHDINA,FHVWGT,FHDVWGT,FHPL)=""
 S FHCLI=DUZ
 K ^TMP("FH",$J) S FHQTALL=0
 ;get current diet and tf
 S Y=""
 I DFN D
 .F I=0:0 S I=$O(^FHPT("AW",I)) Q:I'>0  I $D(^FHPT("AW",I,FHDFN)) S FHLOC=I Q
 .I $G(FHLOC),$D(^FH(119.6,FHLOC,0)) S FHCLI=$P($G(^FH(119.6,FHLOC,0)),U,2)
 .S WARD=$G(^DPT(DFN,.1)) I WARD'="" S ADM=$G(^DPT("CN",WARD,DFN))
 .I ADM D CUR^FHORD7 S X1=""
 .S FHDIDI=$S(Y'="":Y,1:"No Order")
 .W !,"Current Diet: ",FHDIDI
 .Q:'ADM
 .S TF=$P(^FHPT(FHDFN,"A",ADM,0),"^",4)
 .Q:'TF
 .S FHDITFDT=$P($G(^FHPT(FHDFN,"A",ADM,"TF",TF,0)),U,1)
 .S FHDITFCM=$P($G(^FHPT(FHDFN,"A",ADM,"TF",TF,0)),U,5)
 .S FHDITFML=$P($G(^FHPT(FHDFN,"A",ADM,"TF",TF,0)),U,6)
 .S FHDITFKC=$P($G(^FHPT(FHDFN,"A",ADM,"TF",TF,0)),U,7)
 .F TF2=0:0 S TF2=$O(^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2)) Q:TF2<1  D
 ..S Y=^(TF2,0),TUN=$P(Y,"^",1)
 ..I TUN,$D(^FH(118.2,TUN,0)) S FHDITFPR(TUN)=Y
 .W ?30,"Tubefeeding: " I $D(FHDITFPR) F FHTUN=0:0 S FHTUN=$O(FHDITFPR(FHTUN)) Q:FHTUN'>0  W $P($G(^FH(118.2,FHTUN,0)),"^",1) I $O(FHDITFPR(FHTUN))'="" W ", "
 K Y
STA ;if pt has Work in Progress assessment, ask user to Edit or Create or Delete Assessment.
 D PATNAME^FHOMUTL
 S AGE=FHAGE
 I $D(^FHPT(FHDFN,"N",0)) D
 .S FHCAS=$P(^FHPT(FHDFN,"N",0),U,3)
 .Q:'FHCAS
 .S FHCASD=$P(^FHPT(FHDFN,"N",FHCAS,0),U,1)
 .I $D(^FHPT(FHDFN,"N",FHCAS,"DI")) S FHASS=$P($G(^FHPT(FHDFN,"N",FHCAS,"DI")),U,6)
 .S FHAST=0
 .F FHA=0:0 S FHA=$O(^FHPT(FHDFN,"N",FHA)) Q:'FHA  D
 ..S FHASSD=$P($G(^FHPT(FHDFN,"N",FHA,"DI")),U,6)
 ..I (FHASSD="W")!(FHASS="") S FHAST=1
 ..I $D(^FHPT(FHDFN,"N",FHA,0)),'$D(^FHPT(FHDFN,"N",FHA,"DI")) S FHAST=1
 I 'FHCAS!(FHAST=0) G CRE
 D ASK^FHASM2 G:FHQUIT KILL^XUSCLEAN
 I FHASK="D" S DIK="^FHPT("_FHDFN_",""N"",",DA(1)=FHDFN,DA=FHCAS D ^DIK W ?65,"Deleted..." G F1
 I FHASK="E" S ADT=FHCAS D SVAR G:SEX=""!(AGE="") P1 G F3A
CRE ;create new assessment
 ;D:FHCAS PRTA^FHASM2
 S FHASK="C"
 W !!,"Creating new Assessment...",!
 I (FHSEX="")!(FHAGE="") G P1
 E  S NAM=FHPTNM,SEX=FHSEX,AGE=FHAGE
 S X="NOW",%DT="XT" D ^%DT S ADT=Y
 I SEX=""!(AGE="") G P1
F2 S X="NOW",%DT="XT" D ^%DT S ADT=Y
F3 I DFN,$D(^FHPT(FHDFN,"N",9999999-ADT)) S ADT=$$FMADD^XLFDT(ADT,,,1) G F3
F3A ;start here if edit
 S FHAP=$G(^FH(119.9,1,3)),FHU=$P(FHAP,"^",1),NAM=FHPTNM
 G:'FHDFN F4 S XX=$O(^FHPT(FHDFN,"N",0)) G:XX="" F4 S XX=$G(^(XX,0)),HGT=$P(XX,"^",4),HGP=$P(XX,"^",5)
 I HGP'="S" S X1=$S(HGT\12:HGT\12_"'",1:"")_$S(HGT#12:" "_(HGT#12)_"""",1:""),X2=+$J(HGT*2.54,0,0)_"CM",X1=$S(FHU'="M":X1,1:X2)
F4 ; If Multidivisional site Select Communications Office
 S FHCOMM="" I $P($G(^FH(119.9,1,0)),U,20)'="N" D  I FHCOMM="" Q
 .K DIC S DIC="^FH(119.73," S DIC(0)="AEMQ" D ^DIC
 .I Y=-1 Q
 .S FHCOMM=+Y
 ;get ht and wt from vitals.
 I DFN S GMRVSTR="WT" D EN6^GMRVUTL S FHDVWGT=$P(X,"^",1),FHVWGT=$P(X,"^",8),GMRVSTR="HT" D EN6^GMRVUTL S FHVHGT=$P(X,"^",8)
 I X1="" S (X1,HGT)=FHVHGT
F4A W !!,"Height: " W:X1'="" X1,"// " R X:DTIME G:'$T!(X["^") KIL I X="",X1'="" S Y0=$J(HGT,0,0),H1=Y0 G F5
 D TR,HGT I Y<1 D HGP G F4A
 S:X1'=Y FHHWF=1
 S HGT=Y,H1=Y0,HGP=Y1
F5 I FHVWGT'="" S WGT=FHVWGT
 W !!,"Weight: " W:WGT'="" WGT_" lbs","// " R X:DTIME G:'$T!(X["^") KIL I X="",WGT S X=WGT_"#"
 S:X="a" X="A"
 I X="A",AGE>39 D A^FHASM2D G:Y<1 F5 S:WGT'=Y FHHWF=1 S WGT=Y,WGP="A" G F6
 D WGT I Y<1 D WGP W:AGE>39 !,"You may enter an A to calculate weight anthropometrically." G F5
 S:WGT'=Y FHHWF=1
 S WGT=Y,WGP=Y1 I FHDVWGT'="" S DWGT=$P(FHDVWGT,".",1)
F6 G:'FHHWF F7
 S %DT="AEP",%DT("A")="Date Weight Taken: "
 I 'DWGT,FHDVWGT S DTP=$E(FHDVWGT,4,5)_"/"_$E(FHDVWGT,6,7)_"/"_$E(FHDVWGT,2,3)
 I DWGT S DTP=$E(DWGT,4,5)_"/"_$E(DWGT,6,7)_"/"_$E(DWGT,2,3)
 S:DTP'="" %DT("B")=DTP S:DTP="" %DT("B")="TODAY"
 S %DT(0)="-T" W ! D ^%DT K %DT G KIL:X["^"!$D(DTOUT),F6:Y<1
 S DWGT=Y
 ;
F7 S:UWGT X=UWGT W !!,"Usual Weight: " W:UWGT'="" UWGT_" lbs","// " R X:DTIME G:'$T!(X["^") KIL I X="" G F8
 D WGT I Y<1 D WGP G F7
 S UWGT=Y
F8 K %DT,A1,K,X,Y G ^FHASM2
HGT ; Convert Height to inches
 S A1=+X I 'A1 S Y=-1 Q
 S X=$P(X,A1,2,99) S:$E(X,1)=" " X=$E(X,2,99) I "SMK"[$E(X,1) S Y=A1 S:FHU="M" Y=Y/2.54 G H1
 I """I"[$E(X,1) S Y=A1 G H1
 I $E(X,1)="C" S Y=A1/2.54 G H1
 I "'F"'[$E(X,1) S Y=-1 G H2
 S Y=A1*12 F K=1:1 Q:$E(X,K)?.N
 I $E(X,K,99)="" G H1
 S A1=+$E(X,K,99),X=$P(X,A1,2,99) S:$E(X,1)=" " X=$E(X,2,99)
 I """I"'[$E(X,1) S Y=-1 G H2
 S Y=Y+A1
H1 I X["K" D K^FHASM2D
H2 I Y<12!(Y>96) S Y=-1
 S:Y>0 Y0=+$J(Y,0,0),Y=+$J(Y,0,1) S Y1=$S(X["K":"K",X["S":"S",1:"") Q
HGP ; Height Help
 W !!,"Enter height as: 6' 2"" or 74"" or 74IN or 6FT 2 IN or 30CM"
 W !,"Add an S if height is stated rather than measured."
 W !,"Add a K if value is a Knee Height measurement."
 W !,"Height should be between 12"" and 96"" (8')." Q
WGT ; Convert Weight to lbs.
 D TR S A1=+X I 'A1 S Y=-1 Q
 S X=$P(X,A1,2,99) S:$E(X,1)=" " X=$E(X,2,99) I "SM"[$E(X,1) S Y=A1 S:FHU="M" Y=Y*2.2 G W1
 I $E(X,1)="O" S Y=A1/16 G W1
 I $E(X,1)="G" S Y=A1/1000*2.2 G W1
 I $E(X,1)="K" S Y=A1*2.2 G W1
 I "L#"'[$E(X,1) S Y=-1 G W1
 S Y=A1 F K=1:1 Q:$E(X,K)?.N
 I $E(X,K,99)="" G W1
 S A1=+$E(X,K,99),X=$P(X,A1,2,99) S:$E(X,1)=" " X=$E(X,2,99)
 I $E(X,1)'="O" S Y=-1 G W1
 S Y=A1/16+Y
W1 I Y<0!(Y>750) S Y=-1
 S:Y>0 Y0=+$J(Y,0,0),Y=+$J(Y,0,1) S Y1="" S:X["S" Y1="S" Q
WGP ; Weight help
 W !!,"Enter Weight as 150# or 150# 6OZ or 800G or 70KG"
 W !,"Add an S if weight is stated rather than measured."
 W !,"Enter an A to determine weight anthropometrically."
 W !,"Weight should be between 0 Lbs and 750 Lbs." Q
TR ; Translate Lower to Upper Case
 D TR^FH
 Q
KIL ; Final variable kill
 ;if X not equal ^, update or create nutrition assessment
 G:$G(FHQUIT) ASKUS
 I $D(X),X=U G KILL^XUSCLEAN
 D SDAT^FHASM7
 ;
 G KILL^XUSCLEAN
PAT S (FHDFN,DFN,SEX,AGE,PID)="" R !!,"Enter Patient's Name: ",NAM:DTIME G:'$T!(NAM["^") KILL^XUSCLEAN
 I NAM["?"!(NAM'?.ANP)!(NAM="") W *7,!?5,"Enter Patient's Name to be printed on the report." G PAT
P1 I SEX="" R !,"Sex: ",SEX:DTIME S:SEX="" SEX="?" G:'$T!(SEX["^") KILL^XUSCLEAN S X=SEX D TR S SEX=X I $P("FEMALE",SEX,1)'="",$P("MALE",SEX,1)'="" W *7,"  Enter M or F" S SEX="" G P1
 S SEX=$E(SEX,1)
P2 I AGE="" R !,"Age: ",AGE:DTIME S:AGE="" AGE="?" G:'$T!(AGE["^") KILL^XUSCLEAN S X=AGE D TR S AGE=X
 S:AGE["M" AGE=+$J($P(AGE,"M",1)/12,0,2) I AGE'>0!(AGE>124) W !?5,"Enter Age Less Than 124 in Years or Months (followed by M) but Not Both" S AGE="" G P2
 G F2
SVAR ;set variables of incomplete assessment.
 Q:'$D(^FHPT(FHDFN,"N",0))
 S FHA0=$G(^FHPT(FHDFN,"N",FHCAS,0))
 S ADT=$P(FHA0,U,1),SEX=$P(FHA0,U,2),AGE=$P(FHA0,U,3),HGT=$P(FHA0,U,4)
 S HGP=$P(FHA0,U,5),WGT=$P(FHA0,U,6),WGP=$P(FHA0,U,7),DWGT=$P(FHA0,U,8)
 S UWGT=$P(FHA0,U,9),IBW=$P(FHA0,U,10),FRM=$P(FHA0,U,11),AMP=$P(FHA0,U,12)
 S KCAL=$P(FHA0,U,16),PRO=$P(FHA0,U,17),FLD=$P(FHA0,U,18),RC=$P(FHA0,U,19)
 S XD=$P(FHA0,U,20),BMI=$P(FHA0,U,21),BMIP=$P(FHA0,U,22)
 S NOW=$P(FHA0,U,24),NB=$P(FHA0,U,25)
 S FHA1=$G(^FHPT(FHDFN,"N",FHCAS,1))
 S TSF=$P(FHA1,U,1),TSFP=$P(FHA1,U,2),SCA=$P(FHA1,U,3),SCAP=$P(FHA1,U,4),ACIR=$P(FHA1,U,5)
 S ACIRP=$P(FHA1,U,6),CCIR=$P(FHA1,U,7),CCIRP=$P(FHA1,U,8),BFAMA=$P(FHA1,U,9),BFAMAP=$P(FHA1,U,10)
 S WCCM=$P(FHA1,U,11),CIBW=$P(FHA1,U,12),CERBO=$P(FHA1,U,13),CENB=$P(FHA1,U,14),PCTB=$P(FHA1,U,15)
 S SEF=$P(FHA1,U,16),CFRB=$P(FHA1,U,17),CFRBO=$P(FHA1,U,18),CPRBO=$P(FHA1,U,19),EKKG=$P(FHA1,U,20)
 S FHAPP=$G(^FHPT(FHDFN,"N",FHCAS,2))
 S FHA3=$G(^FHPT(FHDFN,"N",FHCAS,3))
 S FHYN=$P(FHA3,U,1),FHFEC=$P(FHA3,U,2),FHFPC=$P(FHA3,U,3),FHDINA=$P(FHA3,U,4),FHEDU=$P(FHA3,U,5)
 S FHFDCSV=$P(FHA3,U,6),FHPL=$P(FHA3,U,7),FHSPC=$P(FHA3,U,8)
 S FHADI=$G(^FHPT(FHDFN,"N",FHCAS,"DI"))
 S FHDIPL=$P(FHADI,U,1),FHDIPLD=$P(FHADI,U,2),FHDINF=$P(FHADI,U,3),FHDINFD=$P(FHADI,U,4)
 S (FHFUD,FHFUDS)=$P(FHADI,U,5),FHDIST=$P(FHADI,U,6),FHDIDI=$P(FHADI,U,7),FHDITF=$P(FHADI,U,8)
 Q
ASKUS R !!,"Do you wish to SAVE this Assessment Y// ",X:DTIME G:'$T!(X["^") KILL^XUSCLEAN
 S:X="" X="Y" D TR I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,!,"  Answer YES or NO" G ASKUS
 I X'?1"Y".E G KILL^XUSCLEAN
 D SDAT^FHASM7 G KILL^XUSCLEAN
