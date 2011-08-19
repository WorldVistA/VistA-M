FHASMR ; HISC/REL/NCA - Assessment Report ;4/25/93  18:46
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
 S FHALL=1 D ^FHOMDPA G:'FHDFN KIL
 I '$D(^FHPT(FHDFN,"N",0)) W !!,"No Nutrition Assessments on file" G KIL
 ;K DIC S DIC="^FHPT(FHDFN,""N"",",DIC(0)="Q",DA=FHDFN,X="??" D ^DIC
 W ! F FHNIEN=0:0 S FHNIEN=$O(^FHPT(FHDFN,"N","B",FHNIEN)) Q:FHNIEN'>0  D
 .S FHNRV=$O(^FHPT(FHDFN,"N","B",FHNIEN,"")) Q:FHNRV'>0
 .S Y=$P($G(^FHPT(FHDFN,"N",FHNRV,0)),U,1) D DD^%DT W !?3,Y
 .S FHNASS=$P($G(^FHPT(FHDFN,"N",FHNRV,"DI")),U,6)
 .W ?25,$S(FHNASS="C":"Completed",FHNASS="S":"Signed",FHNASS="W":"Work in Progress",1:"")
A0 S DIC="^FHPT(FHDFN,""N"",",DIC(0)="AEQM",DIC("A")="SELECT Assessment Date: " W ! D ^DIC G KIL:"^"[X!$D(DTOUT),A0:Y<1 S ASN=+Y
P0 ; Select Device
 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHASMR",FHLST="FHDFN^DFN^PID^ASN" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Process Printing Assessment
 D PATNAME^FHOMUTL
 S NAM=FHPTNM
 S %DT="XT",X="NOW" D ^%DT S DT=Y\1,DTP=+Y D DTP^FH S NOW=DTP
 ;S NAM=$P(^DPT(DFN,0),"^",1)
 S FHAP=$G(^FH(119.9,1,3)),FHU=$P(FHAP,"^",1)
 S Y=^FHPT(FHDFN,"N",ASN,0)
 F K=1:1:22 S @$P("ADT SEX AGE HGT HGP WGT WGP DWGT UWGT RIBW FRM AMP X X X KCAL PRO FLD RC XD BMI BMIP"," ",K)=$P(Y,"^",K)
 S NB=$P(Y,"^",25)
 S EXT="" I $D(^FHPT(FHDFN,"N",ASN,1)) S Y=^(1) F K=1:1:10 S @$P("TSF TSFP SCA SCAP ACIR ACIRP CCIR CCIRP BFAMA BFAMAP"," ",K)=$P(Y,"^",K)
 S APP=$G(^FHPT(FHDFN,"N",ASN,2))
 K LRTST F K=0:0 S K=$O(^FHPT(FHDFN,"N",ASN,"L",K)) Q:K<1  S LRTST(K)=^(K,0)
 S PRT=1 G ^FHASMR1
KIL ; Final variable kill
 ;quit if calls from enter/edit assessment
 Q:$D(FHASK)
 G KILL^XUSCLEAN
