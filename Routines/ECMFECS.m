ECMFECS ;ALB/JAM - Event Capture Management - Event Code Screen Filer ;1 Jul 08
 ;;2.0; EVENT CAPTURE ;**25,33,47,55,65,95,100**;8 May 96;Build 21
 ;
 I $G(ECL0)'="" D MULTLOC Q  ;multiple location filing
 ;
FILE ;Used by the RPC broker to file EC Code Screens in file #720.3
 ;     Variables passed in
 ;       ECIEN     - IEN of #720.3, if editing
 ;       ECL       - Location
 ;       ECD       - DSS Unit
 ;       ECC       - Category
 ;       ECP       - Procedure
 ;       ECST      - Event code screen status
 ;       ECSYN     - Synonym
 ;       ECVOL     - Volume
 ;       ECAC      - Associated Clinic
 ;       ECREAS    - Reason indicator
 ;       ECRES0..n - array of reasons
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #720.3^Message
 ;
 N ECCH,ECERR,ECX,ECY,ECFLG,ECR,ECI,X,Y,DIK,DIE
 N ECLOC  ;protect from XREF reuse & kills
 N ECRES  ;prevent ECREAS overwrite
 S ECERR=0 D CHKDT I ECERR Q
 D VALDATA I ECERR Q
 I ECIEN'="" S ECFLG=0,ECX=$G(^ECJ(ECIEN,0)),ECY=$P(ECX,U) D  I ECERR Q
 .I ECX="" D  Q
 ..S ECERR=1,^TMP($J,"ECMSG",1)="0^Event Code Screen Not on File" Q
 .S ECL=$P(ECY,"-"),ECD=$P(ECY,"-",2),ECC=$P(ECY,"-",3),ECP=$P(ECY,"-",4)
 .I ECST="A",$P(ECX,U,2)'="" S DA=ECIEN,DIE="^ECJ(",DR="1///@" D ^DIE Q
 .I ECST="I",$P(ECX,U,2)="" S $P(^ECJ(ECIEN,0),U,2)=DT
 S ECC=$G(ECC,0),ECCH=ECL_"-"_ECD_"-"_ECC_"-"_ECP
 I '$P($G(^ECD(ECD,0)),U,11),ECC D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^DSS Unit/Category inconsistency" Q
 I ECIEN="" D  I ECERR Q
 .I $D(^ECJ("B",ECCH)) D  Q
 ..S ECERR=1,^TMP($J,"ECMSG",1)="0^EC Screen Exist" Q
 .D NEWIEN
 S DA=ECIEN,DIK="^ECJ(",ECRES=$S(ECREAS="Y":1,1:0) D IX^DIK
 S ^ECJ("AP",ECL,ECD,ECC,ECP,ECIEN)="",^ECJ("APP",ECL,ECD,ECP,ECIEN)=""
 S $P(^ECJ(ECIEN,"PRO"),U)=ECP
 S DR="53////"_$S($G(ECSYN)'="":ECSYN,1:"@")_";54////"_$G(ECVOL,1)
 S DR=DR_";55////"_$S($G(ECAC)'="":ECAC,1:"@")_";56////"_ECRES,DIE="^ECJ(",DA=ECIEN
 D ^DIE K DA,DR,DIE
 I $D(DTOUT) D RECDEL S ^TMP($J,"ECMSG",1)="0^Record not Filed" Q
 I ECRES D
 .N ECLARR,ECLIEN
 .K DIC,DA,DR,ECX S DIC="^ECL(",DIC(0)="L",DLAYGO=720.5,ECR=0
 .F ECI=0:1 S ECX="ECRES"_ECI Q:'$D(@ECX)  S ECR=(@ECX) D
 ..Q:ECR=""  I '$D(^ECR(ECR,0)) Q
 ..S ECLARR(ECR)=""  ; control of valid passed in Procedure Reason Codes
 ..I '$D(^ECL("AD",ECIEN,ECR)) S X=ECR,DIC("DR")=".02////"_ECIEN
 ..K DD,DO,DLAYGO D FILE^DICN
 .;kill nodes no Procedure Reason Code passed in but "AD" Xref exists 
 .K DIK S DIK="^ECL(",DA=""
 .S ECR=0 F  S ECR=$O(^ECL("AD",ECIEN,ECR)) Q:ECR=""  D
 ..I $D(ECLARR(ECR)) Q  ;procedure reason code passed in - don't remove
 ..S ECLIEN=0 F  S ECLIEN=$O(^ECL("AD",ECIEN,ECR,ECLIEN)) Q:ECLIEN=""  S DA=ECLIEN D ^DIK
 S ^TMP($J,"ECMSG",1)="1^Record Filed"_U_ECIEN
 K DIC,DA,DR,ECX,DIK
 Q
 ;
VALDATA ;validate data
 N ECRRX,ECRES
 S DIC="^DIC(4,",DIC(0)="NX",X=ECL D ^DIC I Y=-1 D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Location"
 S DIC="^ECD(",DIC(0)="NX",X=ECD D ^DIC I Y=-1 D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid DSS Unit"
 I ECC S DIC="^EC(726,",DIC(0)="NX",X=ECC D ^DIC I Y=-1 D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Category"
 I ECP'="" D  I ECERR Q
 .; ATG-1003-32110 : by VMP
 .I ECP["ICPT" S ECRRX=$$CPT^ICPTCOD(+ECP) I +ECRRX>0 Q:$G(ECIEN)  I $P(ECRRX,U,7) Q
 .I ECP["EC",$D(^EC(725,+ECP,0)) Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Procedure"
 I $G(ECAC)'="" D  I ECERR Q
 .D CHK^DIE(720.3,55,"E","`"_ECAC,.ECRRX) I ECRRX'=ECAC D  Q
 ..S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Associated Clinic"
 .S ECRES=$$CLNCK^SDUTL2(ECAC,0) I 'ECRES D  S ECERR=1
 ..S ^TMP($J,"ECMSG",1)=ECRES_" Clinic MUST be corrected before filing."
 I $G(ECSYN)'="" D CHK^DIE(720.3,53,"E",ECSYN,.ECRRX) I ECRRX'=ECSYN D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Synonym"
 I "^N^Y^"'[U_ECREAS_U D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Reason Response"
 Q
RECDEL ; Delete record
 I ECFLG S DA=ECIEN,DIK="^ECJ(" D ^DIK K DA,DIK
 Q
 ;
NEWIEN ;Create new IEN in file #720.3
 N DIC,DA,DD,DO
 L +^ECJ(0):10 I '$T S ECERR=1,^TMP($J,"ECMSG",1)="0^Another user is editing this file." Q
 S X=ECCH,DIC="^ECJ(",DIC(0)="L",DLAYGO=720.3 D FILE^DICN
 L -^ECJ(0)
 S ECIEN=+Y,$P(^ECJ(ECIEN,0),U,3)=DT,$P(^ECJ(ECIEN,"PRO"),U)=ECP
 I ECST="I" S $P(^ECJ(ECIEN,0),U,2)=DT
 Q
CHKDT ;Required Data Check
 N I,C
 S C=1
 F I="ECL","ECD","ECC","ECP","ECREAS" D
 .I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key data missing "_I,C=C+1,ECERR=1
 Q
REASON ;Used by the RPC broker to file EC Reasons in file #720.4
 ;     Variables passed in
 ;       ECIEN     - IEN of #720.4, if editing
 ;       ECRES     - Reason
 ;       ECST      - Reason status
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #720.4^Message
 ;
 N ECOST,ECERR,ECFLG,X,Y,DIC,DIE
 S ECERR=0 I $G(ECRES)="" D  I ECERR Q
 .S ^TMP($J,"ECMSG",1)="0^Key data missing - Reason",ECERR=1
 D CHK^DIE(720.4,.01,,ECRES,.ECRRX) I ECRRX="^" D  Q
 .S ^TMP($J,"ECMSG",1)="0^Invalid Reason",ECERR=1
 S ECST=$G(ECST,"A")
 I "^I^A^"'[U_ECST_U S ^TMP($J,"ECMSG",1)="0^Invalid Reason Status" Q
 S ECST=$S(ECST="I":0,1:1),ECIEN=$G(ECIEN),ECFLG=1
 I ECIEN'="" S ECFLG=0 I $G(^ECR(ECIEN,0))="" D  I ECERR K ECST Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Reason Not on File" Q
 I ECIEN="" D  I ECERR K ECST Q
 .I $D(^ECR("B",ECRES)) S ECERR=1,^TMP($J,"ECMSG",1)="0^Reason Exist" Q
 .K DIE,DR,DA
 .L +^ECR(0):10 I '$T S ECERR=1,^TMP($J,"ECMSG",1)="0^Another user is editing this file." Q
 .S X=ECRES,DIC="^ECR(",DIC(0)="L",DLAYGO=720.4 D FILE^DICN
 .L -^ECR(0)
 .S ECIEN=+Y
 S ECOST=$P($G(^ECR(ECIEN,0)),U,2)
 I ECST'=ECOST D
 .S DIE=DIC,DA=ECIEN,DR=".02////"_ECST D ^DIE
 S ^TMP($J,"ECMSG",1)="1^Reason Filed"_U_ECIEN K ECST
 Q
 ;
MULTLOC ;Entry point for multiple locations
 ;  Input:
 ;    ECL0..n - locations IEN
 ;    ECIEN - IEN for edits; "" for new records
 ;    See FILE tag for other variables passed in
 ;
 ;  Output:
 ;    ^TMP($J,"ECMSG",n)=Success or failure
 ;
 N ECERR  ;error flag
 N ECI    ;generic index
 N ECL    ;location IEN
 N ECLN   ;location name
 N ECLOC  ;array of locations
 N ECX    ;variable name (ex. ECL1)
 ;
 ;short circuit when IEN passed w/multiple locations
 I (+$G(ECIEN)>0)&(ECL0="ALL"!($D(ECL1))) D  Q
 . S ^TMP($J,"ECMSG",1)=0_U_"Multiple location edits not allowed"
 ;
 I ECL0="ALL" D
 . D LOCARRY^ECRUTL  ;returns all sites in ECLOC(n)=IEN^name format
 E  D
 . F ECI=0:1 S ECX="ECL"_ECI Q:'$D(@ECX)  D
 . . S ECLN=$$GET1^DIQ(4,@ECX_",",.01,"")
 . . S ECLOC(ECI+1)=@ECX_U_ECLN
 ;
 S ECI=0
 F  S ECI=$O(ECLOC(ECI)) Q:'ECI  D
 . I ECL0="ALL"!($D(ECL1)) N ECIEN S ECIEN=""  ;reset IEN for multiple
 . S ECL=+ECLOC(ECI)
 . D FILE^ECMFECS
 . I $P(^TMP($J,"ECMSG",1),U)=0 S ECERR(ECI)=ECLOC(ECI)_U_$P(^TMP($J,"ECMSG",1),U,2)
 ;
 ;process results
 I '$D(ECERR) S ^TMP($J,"ECMSG",1)=1_U_"Records filed for all locations"
 E  D PROCERR(.ECERR)
 Q
 ;
PROCERR(ECERR) ;process multiple location errors
 ;  Input:
 ;    ECERR - array of location errors
 ;
 ;  Output:
 ;    ^TMP($J,"ECMSG" - RPC results global array
 ;    Format:  ^TMP($J,"ECMSG",1)="0^One or more locations did not file"
 ;             ^TMP($J,"ECMSG",n)=Location_IEN^Location_name^Error_text
 ;
 Q:'$D(ECERR)
 ;
 N ECCNT,ECI
 S ECCNT=1
 S ^TMP($J,"ECMSG",ECCNT)=0_U_"One or more locations did not file"
 S ECI=0
 F  S ECI=$O(ECERR(ECI)) Q:'ECI  S ECCNT=ECCNT+1 D
 . S ^TMP($J,"ECMSG",ECCNT)=$P(ECERR(ECI),U)_U_$P(ECERR(ECI),U,2)_U_$P(ECERR(ECI),U,3)
 Q
