FHASMR2 ;HISC/RVD - Progress Notes To TIU ;04/27/07  06:59
 ;;5.5;DIETETICS;**8,14,17**;Apr 27, 2007;Build 9
 ;input var: fhdfn,na ien (var ASN),dfn
 ;only process inpatient assessment.
 ;uses DBIA #1911
EN ; save note to a temp global
 K ^TMP("TIUP",$J)
 D NOW^%DTC S NOW=% K % S FHN=1
 S ($P(LN5," ",5),$P(LN10," ",10),$P(LN20," ",20),$P(LN25," ",25),$P(LN30," ",30))=""
 S ($P(LN35," ",35),$P(LN40," ",40),$P(LN45," ",45),$P(LN50," ",45),$P(LN55," ",55),$P(LN60," ",60))=""
 S ($P(LN65," ",65))=""
 S ^TMP("TIUP",$J,FHN,0)=NAM_LN10_$S(SEX="M":"Male",1:"Female")_LN10_"Age: "_AGE
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S DTP=ADT D DTP^FH S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN25_"Date of Assessment: "_$E(DTP,1,9)
 S (FHRDIPLD,FHRDIST,FHRDIPL,FHRDINFD,FHRDINA,FHRDINFD,FHRDINF,FHREDU,FHRDIDI,FHRDITF,FHRDITFM,FHRDITFK,FHRDITFC,FHRNWGT,FHRDNWGT,FHRFUD,FHRFEC,FHRFPC,FHRFDC)="" D DIA
EN1 S DTP="" I FHRDIPLD S DTP=FHRDIPLD D DTP^FH
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Diagnosis: "_$E(FHRDIPL,1,30)
 S DTP="" I FHRDINFD S DTP=FHRDINFD D DTP^FH
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Problem: "_$E(FHRDINA,1,30)
 S DTP="" I FHRDINFD S DTP=FHRDINFD D DTP^FH
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Additional Problem: "_$E(FHRDINF,1,30)
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S FHN=FHN+1
 S ^TMP("TIUP",$J,FHN,0)="Current Diet: "_$E(FHRDIDI,1,53)
 I FHRDITF'="" D
 .S DTP=FHRDITF D DTP^FH
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Tubefeed Ordered: "_DTP
 .I ASN I $D(^FHPT(FHDFN,"N",ASN,"TF")) F FHTUN=0:0 S FHTUN=$O(^FHPT(FHDFN,"N",ASN,"TF",FHTUN)) Q:FHTUN'>0  D
 ..S FHASTFZN=$G(^FHPT(FHDFN,"N",ASN,"TF",FHTUN,0))
 ..S TNM=$P(FHASTFZN,U,1),STR=$P(FHASTFZN,U,2),QUA=$P(FHASTFZN,U,3)
 ..S FHTFPROD=$P($G(^FH(118.2,TNM,0)),"^",1)_", "_$S(STR=4:"Full",STR=1:"1/4",STR=2:"1/2",1:"3/4")_" Str., "_QUA
 ..S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="  "_FHTFPROD
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Total Quantity: "_FHRDITFM_"ml"_LN5_"Total KCAL: "_FHRDITFK
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Tubefeed Comment: "_FHRDITFC
 K FHRDIPL,FHRDIPLD,FHRDINF,FHRDINFD,FHRDIDI,FHTFPROD,FHRDITF,FHRDITFM,FHRDITFK,FHRDITFC,DTP
 S X1=$S(HGT\12:HGT\12_"'",1:"")_$S(HGT#12:" "_(HGT#12)_"""",1:""),X2=+$J(HGT*2.54,0,0)_" cm"
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="",FHN=FHN+1
 S ^TMP("TIUP",$J,FHN,0)="Height:        "_$S(FHU'="M":X1,1:X2)_" ("_$S(FHU'="M":X2,1:X1)_")" I HGP'="" S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_" "_$S(HGP="K":"knee hgt",HGP="S":"stated",1:"")
 S X1=WGT_" lbs",X2=+$J(WGT/2.2,0,1)_" kg"
 S FHN=FHN+1
 S ^TMP("TIUP",$J,FHN,0)="Weight:        "_$S(FHU'="M":X1,1:X2)_" ("_$S(FHU'="M":X2,1:X1)_")" I WGP'="" S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_" "_$S(WGP="A":"anthro",WGP="S":"stated",1:"")
 S DTP=DWGT D DTP^FH
 S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_LN5_"  Weight Taken: "_DTP
 S X1=FHRNWGT_" lbs",X2=+$J(FHRNWGT/2.2,0,1)_" kg"
 K FHRNWGT,FHRDNWGT
 I UWGT S X1=UWGT_" lbs",X2=+$J(UWGT/2.2,0,1)_" kg"
 S FHN=FHN+1
 S ^TMP("TIUP",$J,FHN,0)="Usual Weight:  "
 I UWGT S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_$S(FHU'="M":X1,1:X2)_" ("_$S(FHU'="M":X2,1:X1)_")"
 S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_LN5_"% Usual Wt: "
 I UWGT S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_$J(WGT/UWGT*100,3,0)_"%"
 S X1=IBW_" lbs",X2=+$J(IBW/2.2,0,1)_" kg"
 S FHN=FHN+1
 S ^TMP("TIUP",$J,FHN,0)="Target Weight: "_$S(FHU'="M":X1,1:X2)_" ("_$S(FHU'="M":X2,1:X1)_")    % Target Wt: "
 I IBW S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_$J(WGT/IBW*100,3,0)_"%"
 I AMP S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN5_"Target weight adjusted for amputation"
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Frame Size:    "_$S(FRM="S":"Small",FRM="M":"Medium",FRM="L":"Large",1:"")
 S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_LN10_"       Body Mass Index:  "_BMI
 S EXT="" I $G(TSF)!$G(SCA)!$G(ACIR)!$G(CCIR) S EXT="Y"
 G:EXT'="Y" EN2  ;there is no antthropometric measurement.
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="",FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN25_"Anthropometric Measurements"
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN35_"%ile                              %ile"
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN5_"Triceps Skinfold (mm)     "_$J(+TSF,3,0)_" "_$J(TSFP,3)_LN5_"Arm Circumference (cm) "
 S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_$J(+ACIR,3,0)_" "_$J(ACIRP,3)
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN5_"Subscapular Skinfold (mm) "
 S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_$J(+SCA,3,0)_" "_$J(SCAP,3)_"    Bone-free AMA (cm2)    "
 S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_$J(+BFAMA,3,0)_" "_$J(BFAMAP,3)
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN5_"Calf Circumference (cm)   "
 S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_$J(+CCIR,3,0)_" "_$J(CCIRP,3)
EN2 ;skip here if there is no anthropometric measurement. 
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN30_"Laboratory Data"
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN5_"Test"_LN20_"Result    units"_LN10_"Ref.   range"_LN10_"Date"
 S N1=0 F K=0:0 S K=$O(LRTST(K)) Q:K=""  D LAB
 I 'N1 D
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN5_"No laboratory data available last "_$S($D(^FH(119.9,1,3)):$P(^(3),"^",2),1:90)_" days"
 S N=PRO/6.25
DRU ;pharmacy data.
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN5_"Medications"
 S PX=1 D DRUG^FHASM4
 I $D(PSCA) D
 .F FHI=0:0 S FHI=$O(PSCA(FHI)) Q:FHI'>0  S FHJ="" F  S FHJ=$O(PSCA(FHI,FHJ)) Q:FHJ=""  D
 ..S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 ..S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN5_FHJ
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Educated on Food/Drug Interactions: "_$S(FHREDU="Y":"Yes",1:"No") K FHREDU
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="FOOD/DRUG COMMENT: "_FHRFDC
 K FHI,FHJ,PSD,PSCA
 ;
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Energy Requirements:  "_KCAL_" Kcal/day"
 I N S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_"       Kcal:N  "_$J(KCAL/N,0,0)_":1"
 I NB'="" S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_"     N-Bal: "_NB
 I FHRFEC'="" D
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN5_"Energy calculation is based on: "_FHRFEC
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Protein Requirements: "_PRO_" gm/day"
 I N S ^TMP("TIUP",$J,FHN,0)=^TMP("TIUP",$J,FHN,0)_"           NPC:N   "_$J(KCAL-(PRO*4)/N,0,0)_":1"
 I FHRFPC'="" D
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN5_"Protein calculation is based on: "_FHRFPC
 K FHRFEC,FHRFPC
 I FLD'="" D
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Fluid Requirements:   "_FLD_" ml/day"
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 I FHAPP'="" D
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Appearance:       "_FHAPP
 I XD D
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Nutrition Class:  "_$P($G(^FH(115.3,XD,0)),"^",1)
 I RC D
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Nutrition Status: "_$P($G(^FH(115.4,RC,0)),"^",2)
 D DCOM
 Q
DIA ;get data from DI node.
 I ASN S FHDIA=$G(^FHPT(FHDFN,"N",ASN,"DI")) Q:FHDIA=""  D
 .S FHRDIPL=$P(FHDIA,U,1)
 .S FHRDIPLD=$P(FHDIA,U,2)
 .S FHRDINF=$P(FHDIA,U,3)
 .S FHRDINFD=$P(FHDIA,U,4)
 .S FHRFUD=$P(FHDIA,U,5)
 .S FHRDIST=$P(FHDIA,U,6)
 .S FHRDIDI=$P(FHDIA,U,7)
 .S FHRDITF=$P(FHDIA,U,8)
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
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Follow-up Date: "_DTP
 K FHRFUD,FHRDIST
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="Comments:"
 I ASN F K=0:0 S K=$O(^FHPT(FHDFN,"N",ASN,"X",K)) Q:K<1  D
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=^FHPT(FHDFN,"N",ASN,"X",K,0)
 S SIGN=$P(^FHPT(FHDFN,"N",ASN,0),U,23)
 D NOW^%DTC S FHRDT=%,FHIFN="",FHESBY=FHCLI K %,%H,%I,X
 ;Use data from user selection from file 8925.1
 K DIC,DA W !!,"Enter a Progress Note Title for this Assessment!!",!
 S DIC=8925.1,DIC(0)="AEQMZ",DIC("S")="I ($P($G(^TIU(8925.1,+Y,0)),U,7)'=13),($P(^(0),U,1)[""NUTRITION""),($P(^(0),U,4)=""DOC"")" D ^DIC
 K DIC I X["^"!$D(DTOUT)!(Y<1) S FHOUT=1 Q
 S FHIEN1=+Y
 ;call TIU to create a progress notes; DBIA #1911
 ;D NEW^TIUPNAPI(.FHIFN,DFN,DUZ,FHRDT,FHIEN1,"","","",FHESBY,"","")
 D NEW^TIUPNAPI(.FHIFN,DFN,DUZ,FHRDT,FHIEN1,"","","","","","")
 I $P(FHIFN,U,1)'>0 S FHOUT=1
 K FHIFN,FHRDT,FHTITLE,FHESBY,FHTIUST,FH251,FHIEN1
 ;done
 Q
Q6 D FOOT Q
LAB S X1=$P(LRTST(K),"^",7) Q:X1=""  S DTP=X1\1 D DTP^FH
 I 'N1 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)="" S N1=N1+1
 S FHLABTE=$P(LRTST(K),U,1)_"                    "
 S FHLABRE=$P(LRTST(K),U,6)_"                    "
 S FHLABUN=$P(LRTST(K),U,4)_"                    "
 S FHLABRR=$P(LRTST(K),U,5)_"                    "
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=$E(FHLABTE,1,20)_" "_$E(FHLABRE,1,11)_" "_$E(FHLABUN,1,13)_" "_$E(FHLABRR,1,20)_" "_DTP
 Q
HEAD ; Page Header
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=DTP_LN30_"NUTRITION ASSESSMENT"
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN
 Q
FOOT ; Page Footer
 D SITE^FH
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 I $G(DFN) S W1=$G(^DPT(DFN,.1)) S:$D(^DPT(DFN,.101)) W1=W1_"/"_^DPT(DFN,.101) I W1'="" D
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 .S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN30_W1_LN5_"(Vice SF 509)"
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=LN
 S FHN=FHN+1,^TMP("TIUP",$J,FHN,0)=""
 Q
