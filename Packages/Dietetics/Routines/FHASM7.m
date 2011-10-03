FHASM7 ; HISC/REL - KCAL Distribution ;8/18/93  11:05
 ;;5.5;DIETETICS;**8,14**;Jan 28, 2005;Build 1
 S PRT=0,(ASN,NB)=""
E31 S FH7FLG=1 D ^FHASMR1 K FH7FLG
 R !!,"Do you want to do a NITROGEN BALANCE? NO// ",X:DTIME G:'$T!(X["^") KIL^FHASM1 S:X="" X="N" D TR^FHASM1 I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES or NO" G E31
 I $E(X,1)="N" G KIL:'FHDFN,EDU
E32 R !!,"Enter Protein Intake (gm/24hr): ",X1:DTIME S:X1=U FHQUIT=1 G KIL^FHASM1:'$T!(X1["^"),E35:X1=""
 I X1'?.N.1".".N!(X1<0)!(X1>200) W !?5,"Enter 0-200 grams of protein intake" G E32
E33 R !,"Enter Urinary Nitrogen Output (gm/24hr): ",X2:DTIME S:X2=U FHQUIT=1 G KIL^FHASM1:'$T!(X2["^"),E35:X2=""
 I X2'?.N.1".".N!(X2<0)!(X2>30) W !?5,"Enter 0-30 gms of Urinary Nitrogen output (24 hr UUN)" G E33
E34 R !,"Enter Insensible Nitrogen Output (gm/24hr): 4// ",X3:DTIME S:X3="" X3=4 S:X3=U FHQUIT=1 G:'$T!(X3["^") KIL^FHASM1
 I X3'?.N.1".".N!(X3<0)!(X3>10) W !?5,"Insensible Nitrogen output should be between 0-10 grams" G E34
 S NB=X1/6.25-(X2+X3),NB=$J(NB,0,0) W !,"Nitrogen Balance: ",NB
E35 G:'FHDFN KIL
EDU ;
 W !!,"Did you educate patient on Food/Drug Interactions (Y/N): " W:FHEDU'="" FHEDU_"//" W:FHEDU="" "N//" R X:DTIME
 G KIL^FHASM1:'$T!(X["^")
 I X="",FHEDU="" S X="N"
 I X="",FHEDU'="" S X=FHEDU
 D TR^FH
 I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,!,"Enter 'Y' for yes or 'N' for no." G EDU
 S FHEDU=$E(X,1)
EDC ;food/drug comment.
 S FHFDC=FHFDCSV
 W !!,"Food/Drug Comment: ",FHFDCSV,"// " R FHFDC:DTIME I '$T!(FHFDC["^") S FHQUIT=1 G KIL^FHASM1
 I FHFDC="@" S FHFDCSV="" W "  deleted..." G DPL
 I (FHFDC=""),(FHFDCSV'="") S FHFDC=FHFDCSV
 I FHFDC["?"!($L(FHFDC)>30) W *7,!,"Enter Food/Drug Comment or Hit Return to Accept or @ to Delete and cannot exceed 30 characters!!" G EDC
 S FHFDCSV=FHFDC
 ;adding diagnosis, follow-up date
DPL ;get diagnosis from Problem List package.
 D:DFN LIST^GMPLUTL2(.FHPLIST,DFN,"A","")
 S FHDIACT=0
 I $D(FHPLIST(0)) S FHDIACT=FHPLIST(0)
DP1 I FHDIACT D
 .S FHDCH=""
 .W !!,"Patient's Diagnosis from Problem List:",!
 .F FHDLI=0:0 S FHDLI=$O(FHPLIST(FHDLI)) Q:'FHDLI  D
 ..S DTP=$P(FHPLIST(FHDLI),U,6) D DTP^FH
 ..W !,?6,FHDLI_"  ",$P(FHPLIST(FHDLI),U,3)," - Date entered: ",DTP
 G:'FHDIACT ANF
 W !!,"Diagnosis: " W:FHDIPL'="" FHDIPL W "// " R FHDCH:DTIME S:FHDCH=U FHQUIT=1 G:'$T!(FHDCH["^") KIL^FHASM1
 G:FHDCH="" ANF
 I FHDCH="@" S (FHDIPL,FHDIPLD)="" G ANF
 I '$D(FHPLIST(FHDCH)) W !!,*7,"Choose a number from the list or Hit Return to accept default!!",! G DP1
 S FHDIPL=$P(FHPLIST(FHDCH),U,3),FHDIPLD=$P(FHPLIST(FHDCH),U,6)
ANF ;problem through NFS.
 S AFDIA=FHDINA
 W !!,"Problem: ",FHDINA,"// " R AFDIA:DTIME I '$T!(AFDIA["^") S FHQUIT=1 G KIL^FHASM1
 I AFDIA="@" S FHDINA="" W "  deleted..." G DNF
 I (AFDIA=""),(FHDINA'="") S AFDIA=FHDINA
 I AFDIA["?"!($L(AFDIA)>30) W *7,!,"Enter patient's Problem or Hit Return to Accept or @ to Delete and cannot exceed 30 characters!!" G ANF
 S FHDINA=AFDIA
 ;
DNF ;aditional problem through NFS.
 S NFDIA=FHDINF
 W !!,"Additional Problem: ",FHDINF,"// " R NFDIA:DTIME I '$T!(NFDIA["^") S FHQUIT=1 G KIL^FHASM1
 I NFDIA="@" S FHDINF="" W "  deleted..." G E4
 I (NFDIA=""),(FHDINF'="") S NFDIA=FHDINF
 I NFDIA["?"!($L(NFDIA)>30) W *7,!,"Enter Additional Problem of a patient or Hit Return to Accept or @ to Delete and cannot exceed 30 characters!!" G DNF
 S FHDINF=NFDIA
 ;
E4 ;
 S APP=FHAPP
 W !!,"Appearance: ",FHAPP,"// " R APP:DTIME I '$T!(APP["^") S FHQUIT=1 G KIL^FHASM1
 I APP="@" S FHAPP="" W "  deleted..." G EC1
 I (APP=""),(FHAPP'="") S APP=FHAPP
 I APP["?"!(APP'?.ANP)!($L(APP)>60) W *7,!,"Enter Physical Appearance of patient or Hit Return to Accept or @ to Delete and cannot exceed 60 characters." G E4
 S FHAPP=APP
EC1 W ! S DIC="^FH(115.3,",DIC(0)="AEQMZ",DIC("B")=XD D ^DIC K DIC G KIL^FHASM1:X["^"!$D(DTOUT) S XD=$S(Y>0:+Y,1:"")
E5 W ! S DIC="^FH(115.4,",DIC(0)="AEQMZ",DIC("B")=RC,DIC("S")="I $P(^(0),U,2)'=""""" D ^DIC K DIC G KIL^FHASM1:X["^"!$D(DTOUT) S RC=$S(Y>0:+Y,1:"")
 W !!,"Comments:" K ^TMP("FH",$J) S DIC="^TMP(""FH"",$J,",DWPK=1
 I FHASK="E",$D(^FHPT(FHDFN,"N",FHCAS,"X")) M ^TMP("FH",$J)=^FHPT(FHDFN,"N",FHCAS,"X") D EN^DIWE G FDT
 D EN^DIWE
FDT ;enter follow-up date.
 S (FHDD,DTP)=""
 I $G(RC) D
 .S X=$P($G(^FH(115.4,RC,0)),U,2) D TR^FH
 .I X["NORMAL" D
 ..S:FHLOC FHDD=$P($G(^FH(119.6,FHLOC,0)),U,20)
 ..S:FHDD DTP="T+"_FHDD
 ..S:'FHDD DTP="T+11"
 .I X["MILD" D
 ..S:FHLOC FHDD=$P($G(^FH(119.6,FHLOC,0)),U,21)
 ..S:FHDD DTP="T+"_FHDD
 ..S:'FHDD DTP="T+9"
 .I X["MODERATE" D
 ..S:FHLOC FHDD=$P($G(^FH(119.6,FHLOC,0)),U,22)
 ..S:FHDD DTP="T+"_FHDD
 ..S:'FHDD DTP="T+7"
 .I X["SEVERE" D
 ..S:FHLOC FHDD=$P($G(^FH(119.6,FHLOC,0)),U,23)
 ..S:FHDD DTP="T+"_FHDD
 ..S:'FHDD DTP="T+5"
 K %DT S %DT="AEF",%DT("A")="Enter Follow-up Assessment Date: "
 I FHFUD'="",FHFUD>DT S DTP=$E(FHFUD,4,5)_"/"_$E(FHFUD,6,7)_"/"_$E(FHFUD,2,3)
 S:DTP'="" %DT("B")=DTP S:DTP="" %DT("B")="TODAY"
 S %DT(0)=DT
 W ! D ^%DT K %DT G KIL^FHASM1:X["^"!$D(DTOUT),FDT:Y<1
 S FHFUD=Y
SDAT ;create or update nutrition assessment and file to Progress Notes.
 G:'$D(FHASK) KILL^XUSCLEAN
 I '$D(^FHPT(FHDFN,0)) S ^(0)=FHDFN
 I '$D(^FHPT(FHDFN,"N",0)) S ^FHPT(FHDFN,"N",0)="^115.011D^^"
 K DIC,DD,DO S DIC="^FHPT(FHDFN,""N"",",DIC(0)="L",DLAYGO=115,DA(1)=FHDFN
 I FHASK="E" S ASN=FHCAS D REC^FHASM3  ;re-calculate calorie, protien and fluid requirement.
 I FHASK="C" S X=ADT,DINUM=9999999-ADT D FILE^DICN S ASN=+Y  ;if not an update, create.
 D NOW^%DTC S NOW=%
 S A2=HGT*.0254,BMI=+$J(WGT/2.2/(A2*A2),0,1)
 S Y=ADT_"^"_SEX_"^"_AGE_"^"_HGT_"^"_HGP_"^"_WGT_"^"_WGP_"^"_DWGT_"^"_UWGT_"^"_IBW_"^"_FRM_"^"_AMP_"^^^^"_KCAL_"^"_PRO_"^"_FLD_"^"_RC_"^"_XD_"^"_BMI_"^"_BMIP_"^"_DUZ_"^"_NOW_"^"_NB
 S ^FHPT(FHDFN,"N",ASN,0)=Y
 S:'FHFUD FHFUD=DT
 S FHASN1=TSF_U_TSFP_U_SCA_U_SCAP_U_ACIR_U_ACIRP_U_CCIR_U_CCIRP_U_BFAMA_U_BFAMAP_U_WCCM_U_CIBW_U_CERBO_U_CENB_U_PCTB_U_SEF_U_CFRB_U_CFRBO_U_CPRBO_U_EKKG
 S ^FHPT(FHDFN,"N",ASN,1)=FHASN1
 S ^FHPT(FHDFN,"N",ASN,2)=FHAPP
 S ^FHPT(FHDFN,"N",ASN,3)=FHYN_U_FHFEC_U_FHFPC_U_FHDINA_U_FHEDU_U_FHFDCSV_U_FHPL_U_FHSPC
 S ^FHPT(FHDFN,"N",ASN,"DI")=FHDIPL_U_FHDIPLD_U_FHDINF_U_FHDINFD_U_FHFUD_U_FHDIST_U_FHDIDI_U_FHDITFDT
 S $P(^FHPT(FHDFN,"N",ASN,"DI"),U,10)=FHDITFML
 S $P(^FHPT(FHDFN,"N",ASN,"DI"),U,11)=FHDITFKC
 S $P(^FHPT(FHDFN,"N",ASN,4),U,1)=FHDITFCM
 I $D(FHDITFPR),'$D(^FHPT(FHDFN,"N",ASN,"TF")) F FHTUN=0:0 S FHTUN=$O(FHDITFPR(FHTUN)) Q:FHTUN'>0  D
 .S Y=FHTUN K DIC,DO S DA(2)=FHDFN,DA(1)=ASN
 .S DIC="^FHPT("_DA(2)_",""N"","_DA(1)_",""TF"","
 .S DIC(0)="L",DIC("P")=$P(^DD(115.011,67.1,0),U,2),X=+Y
 .D FILE^DICN I Y=-1 Q
 .K DIE S DA(2)=FHDFN,DA(1)=ASN,DA=+Y
 .S FH1=$P(FHDITFPR(FHTUN),U,2),FH2=$P(FHDITFPR(FHTUN),U,3)
 .S DIE="^FHPT("_DA(2)_",""N"","_DA(1)_",""TF"","
 .S DR="1////^S X=FH1;2////^S X=FH2" D ^DIE
 I FHFUDS,(FHFUDS'=FHFUD) K ^FHPT("E",FHFUDS,FHDFN,ASN)
 I FHFUD S DA(1)=FHDFN,DA=ASN,DIK="^FHPT(DA(1)"_",""N"",",DIK(1)="64^E" D IX^DIK
 G:'$D(LRTST) E7
 S N1=0 F K=0:0 S K=$O(LRTST(K)) Q:K=""  S ^FHPT(FHDFN,"N",ASN,"L",K,0)=LRTST(K),N1=N1+1
 I N1,'$D(^FHPT(FHDFN,"N",ASN,"L",0)) S ^(0)="^115.021^^"
E7 G:'$D(^TMP("FH",$J)) E8
 S ^FHPT(FHDFN,"N",ASN,"X",0)=^TMP("FH",$J,0)
 S N1=0 F K=0:0 S K=$O(^TMP("FH",$J,K)) Q:K'>0  S N1=N1+1,^FHPT(FHDFN,"N",ASN,"X",N1,0)=^TMP("FH",$J,K,0)
E8 S DTE=ADT,S1=1,S2="I",S3=$S('RC:"",1:"Nutrition Status: "_$P(^FH(115.4,RC,0),"^",2))
 I $G(DFN) D FIL^FHASE3 I 'RC G E9
 I '$D(^FHPT(FHDFN,"S",0)) S ^(0)="^115.012D^^"
 K DIC,DD,DO S DIC="^FHPT(FHDFN,""S"",",DIC(0)="L",DLAYGO=115,DA(1)=FHDFN,X=ADT,DINUM=9999999-ADT D FILE^DICN S ASE=+Y
 I $G(DFN) D DID^FHDPA S $P(^FHPT(FHDFN,"S",ASE,0),"^",2,3)=RC_"^"_DUZ S:FHWRD $P(^(0),"^",6)=FHWRD
E9 ;D P0^FHASMR
E6 R !!,"Save as Work in Progress or Complete or Delete this assessment: W// ",X:DTIME G:'$T!(X["^") KILL^XUSCLEAN
 S:X="" X="W" D TR^FHASM1
 I ($E(X)'="W"),($E(X)'="C"),($E(X)'="D") W *7,!,"  Answer 'W' to file as Work in progress or 'C' to Complete and send to TIU or 'D' to Delete" G E6
 I $E(X)="D" S DA(1)=FHDFN,DIK="^FHPT(FHDFN,""N"",",DA=ASN D ^DIK W !!,"Deleted...",! G KILL^XUSCLEAN
 I $E(X)="W" S $P(^FHPT(FHDFN,"N",ASN,"DI"),U,6)="W" W !!,"This Assessment has been saved as Work in Progress...",!
 I $E(X)="C" D
 .;send assessment to TIU if pt has entry in #2 and is inpatient.
 .I $G(DFN) S WARD=$G(^DPT(DFN,.1)) I WARD'="" D ^FHASMR2 K ^TMP($J) I $G(FHOUT) D  Q
 ..W !!,"TIU Progress Note was NOT created!!"
 ..S $P(^FHPT(FHDFN,"N",ASN,"DI"),U,6)="W"
 .S $P(^FHPT(FHDFN,"N",ASN,"DI"),U,6)="C"
 .W !!,"Assessment is completed" I $G(DFN),WARD'="" W " and forwarded to TIU" W "...",!
KIL G KILL^XUSCLEAN
