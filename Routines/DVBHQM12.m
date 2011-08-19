DVBHQM12 ;ISC-ALBANY/PKE/JLU-create mail message ;9/28/88@0800
 ;;4.0;HINQ;**4,49**;03/25/92 
 ;
LIN Q:CT>100  S CT=CT+1,A1=A_CT_",0)",@A1=T1 Q
DD S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".") S:$L(Y)=10 Y=Y_" " Q
 ;
BLOCK I $D(DVBCN) S T1="      Claim Number = "_DVBCN D LIN
B I $D(DVBSN) S T1="    Service Number = " F I=2:1 Q:'$D(DVBSN(I))  S T1=T1_DVBSN(I)_"  "
 I $D(DVBSN) D LIN
 I $D(DVBFL) S T1="   Folder Location = "_DVBFL D LIN
 I $D(DVBBIR),$P(DVBBIR,U,18) S T1=$P(DVBBIR,U,18) D CHR S T1="C.H.Record Location = "_$S(Y:Y,1:T1) D LIN
 I $D(DVBPOA) S T1=" Power of Attorney = "_$G(DVBPOA) D LIN
 S T1=1
 I $D(DVBPOW) S T1=$E(BL,1,9)_"      POW = "_$S(DVBPOW=0:"No period of rec.",DVBPOW=1:"30 days or fewer",DVBPOW=2:"more than 30 days",DVBPOW=" ":"Not applicable",1:DVBPOW)
 I $D(DVBPOWD) S T1=$S('+T1:T1_"  "_DVBPOWD,1:"POW  "_DVBPOWD)
 I 'T1 D LIN K T1
 I $D(DVBTOTAS) S T1="  Total Active Svc = "_DVBTOTAS D LIN
 ;
 ;DVB*4*49 - Disability Indicator no longer being sent
 I $D(DVBBIR) S T1="INDICATORS( Active Duty Training "_$S($P(DVBBIR,U,24)["Y":"YES",1:"NO ")
 S T1=T1_"   Homeless Veteran "_$S($P(DVBBIR,U,30)["Y":"YES",$P(DVBBIR,U,30)="H":"YES",1:"NO ")_")" D LIN
 ;
 S T1="" D LIN
 S T1=" Service data - VBA" D LIN
 S T1="--------------------------------------------------------------" D LIN
 ;
 ;DVB*4*49 - all military service data should be in the BIRLS portion of
 ;the response message, since that is where up to three episodes of
 ;service can be stored, and the statistical segment information
 ;would just duplicate the BIRLs segment info, due to there being no
 ;indication of which database is being used.  So, if there is data
 ;in DVBBOS(2), DVBEOD(2), or DVBRAD(2), kill the 1st node of these arrs.
 I $G(DVBBOS(2))]"" K DVBBOS(1)
 I +$G(DVBEOD(2))>0 K DVBEOD(1)
 I +$G(DVBRAD(2))>0 K DVBRAD(1)
 ;
 I $D(DVBBOS) D BOS F I=2:1 Q:'$D(DVBBOS(I))  S Y=DVBBOS(I) D XBOS S T1=T1_Y
 I $D(DVBBOS) D LIN
 ;
 I $D(DVBEOD) S T1="         EOD: " F I=0:0 S I=$O(DVBEOD(I)) D:I="" LIN Q:I=""  D CEOD S T1=T1_Y_"          "
 I $D(DVBRAD) S T1="         RAD: " F I=0:0 S I=$O(DVBRAD(I)) D:I="" LIN Q:I=""  D CRAD S T1=T1_Y_"          "
 S T1="" D LIN
 ;
 Q
 ;
BOS S T1="  Svc Branch: " I $D(DVBBOS(1)) S Y=DVBBOS(1) D XBOS S T1=T1_Y
 Q
XBOS ;DVB*4*49 - BOS codes have changed
 N DVBY
 Q:Y']""
 S Y=$TR(Y," ")
 S Y=$$UPPER^VALM1(Y)
 N YY
 S YY=Y
 S Y=$S(Y="ARMY":"Army",Y="NAVY":"Navy",Y="AF":"Air Force",Y="AFA":"Air Force Acad",Y="AFC":"Air Force Civilian",Y="AFR":"Air Force Res",Y="ANG":"Air Nat Guard",Y="AAC":"Army Air Corps/Army Air Force",1:Y)
 I YY=Y S Y=$S(Y="AACV":"Amer. Airlines Civilian",Y="ANC":"Army Nurse Corps",Y="ANCF":"ANC Fem Civ-Bataan/Correg.",Y="AFS":"Civilians AFS/WWII Overseas",Y="ARNG":"Army Nat Guard",1:Y)
 I YY=Y S Y=$S(Y="CG":"Coast Guard",Y="CGA":"CG Acad",Y="CGR":"CG Res",Y="CGS":"Coast & Geodetic Survey",Y="CPDW":"Civilians PNAB Wake/WWII",Y="ESSA":"Envir Science Svcs Admin",Y="GCS":"Guer Combination Svc",1:Y)
 I YY=Y S Y=$S(Y="HDAV":"Hon Disch Members Amer Vol Guard",Y="MC":"Marine Corps",Y="MCR":"MC Res",Y="MM":"Merchant Marine",1:Y)
 I YY=Y S Y=$S(Y="NA":"Naval Acad",Y="NNC":"Navy Nurse Corps",Y="NOAA":"Nat Ocean & Atmospher Admin",Y="NR":"Navy Res",Y="O":"Other",Y="OTH":"Other",Y="OSSC":"Civ OSS Secret Intel",1:Y)
 I YY=Y S Y=$S(Y="PACC":"Pan Am Civ contract Overseas WWII",Y="POUS":"Phil Army ordered US Arm Forces",Y="PCA":"Phillip Comn Army",Y="PG":"Phillip Guerilla",Y="PGCS":"Phil Guer & Comb Svc",1:Y)
 I YY=Y S Y=$S(Y="PRS":"Phillip Reg Scout & Comb Svc",Y="PHS":"Public Health Scv",Y="QC":"Quartermaster Corps Keswick/Correg/WWII",1:Y)
 I YY=Y S Y=$S(Y="RPS":"Reg Phillip Scout",Y="SPS":"Spec Phillip Scout",Y="USAR":"US Army Res",Y="USCV":"US Civ Vol Act Defense Bataan",1:Y)
 S Y=$S(Y="USMA":"US Mil Acad",Y="USMS":"US Merch Seamen Blockship Op Mulberry",Y="WASP":"Womens AF Svc Pilots",Y="WAAC":"Womens Army Aux Corps",Y="WAC":"Womens Army Corps",Y="WRM":"Womens Res of Marines",1:Y)
 S DVBY="                     " ;sized to match widest char service value
 S Y=Y_$E(DVBY,$L(Y)+1,22)
 Q
 ;
CEOD I I=1 S M=$E(DVBEOD(1),1,2) D MM^DVBHQM11 S Y=M_" "_$E(DVBEOD(1),3,4)_","_$E(DVBEOD(1),5,8) Q
 I DVBEOD(I)?7N S Y=DVBEOD(I) D DD
 E  S Y=""
 Q
 ;
CRAD I I=1 S M=$E(DVBRAD(1),1,2) D MM^DVBHQM11 S Y=M_" "_$E(DVBRAD(1),3,4)_","_$E(DVBRAD(1),5,8) Q
 I DVBRAD(I)?7N S Y=DVBRAD(I) D DD
 E  S Y=""
 Q
CHR S Y=0,Y=$O(^DIC(4,"D",+$P(DVBBIR,U,18),Y)) I Y S Y=$S($D(^DIC(4,Y,0)):$P(^DIC(4,Y,99),U,1)_" - "_$P(^(0),U),1:"")
 Q
