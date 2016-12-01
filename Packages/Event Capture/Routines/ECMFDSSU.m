ECMFDSSU ;ALB/JAM-Event Capture Management Filer DSS Unit ;1/22/16  16:28
 ;;2.0;EVENT CAPTURE ;**25,30,33,126,131**;8 May 96;Build 13
 ;
FILE ;Used by the RPC broker to file DSS Units in file #724
 ;     Variables passed in
 ;       ECIEN  - IEN of #724, if editing
 ;       ECDUNM - DSS Unit Name
 ;       ECS    - Service
 ;       ECM    - Medical Speciality
 ;       ECTR   - Cost Center
 ;       ECUN   - Unit Number
 ;       ECST   - Status Flag (Active/Inactive)
 ;       ECASC  - Associated Stop Code
 ;       ECC    - Category
 ;       ECDFDT - Default Data Entry Date
 ;       ECPCE  - Send to PCE
 ;       ECSCN  - Event Code Screens status
 ;       ECCSC  - Credit stop code, can be used when PCE status is "no records"
 ;       ECHAR4 - CHAR4 code, can be used when PCE status is "no records"
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #724^Message
 ;
 N ECERR,ECX,ECFLG,ECRES,ECONAM
 S ECERR=0 D CHKDT I ECERR Q
 D VALDATA I ECERR Q
 S ECIEN=$G(ECIEN),ECFLG=1,ECONAM="",ECC=$S(ECC="Y":1,1:0)
 I ECIEN'="" S ECFLG=0 D  I ECERR D END Q
 . I '$D(^ECD(ECIEN,0)) D  Q
 . . S ECERR=1,^TMP($J,"ECMSG",1)="0^DSS Unit Not on File" Q
 . D CATCHK^ECUMRPC1(.ECRES,ECIEN) I ECRES,ECC'=$P(^ECD(ECIEN,0),U,11) D 
 . . I ECC=0 D FIXSCRNS Q  ;131 If Category changed to no, update existing event code screens
 . . S ECERR=1,^TMP($J,"ECMSG",1)="0^Category Changed, EC Screen exist"
 . S ECONAM=$P($G(^ECD(ECIEN,0)),U)
 D  I ECERR D END Q   ;Check name
 . I (ECFLG)!((ECONAM'="")&(ECONAM'=ECDUNM)),$D(^ECD("B",ECDUNM)) D  Q
 . . S ECERR=1,^TMP($J,"ECMSG",1)="0^DSS Unit Name already exist"
 . I 'ECFLG K DIE S DIE="^ECD(",DA=ECIEN,DR=".01////"_ECDUNM D ^DIE
 S ECPCE=$S(ECPCE="A":"A",ECPCE="O":"O",1:"N")
 I ECPCE="N",$G(ECASC)="" D  D END Q
 . S ECERR=1,^TMP($J,"ECMSG",1)="0^No associated stop code, Send to PCE=N" ;126 Corrected error message
 I 'ECFLG,ECPCE="N",$P($G(^ECD(+$G(ECIEN),0)),U,14)'="N" D UPDSCRN ;131 If existing DSS unit and PCE is being changed to "send no records" then update related EC screens
 I ECIEN="" D NEWIEN
 K DA,DR,DIE
 S ECST=$E($G(ECST)),ECST=$S(ECST="I":1,1:0),ECDFDT=$E($G(ECDFDT))
 S ECDFDT=$S(ECDFDT="N":"N",1:"X"),DIE="^ECD(",DA=ECIEN
 S DR="1////"_ECS_";2////"_ECM_";3////"_ECTR_";4////"_$G(ECUN)
 S DR=DR_";5////"_ECST_";7////1;9////"_$S(ECPCE'="N":"@",1:$G(ECASC))
 S DR=DR_";10////"_ECC_";11////"_ECDFDT_";13////"_ECPCE
 S DR=DR_";14////"_$S(ECPCE'="N":"@",$G(ECCSC)="":"@",1:$G(ECCSC))_";15////"_$S(ECPCE'="N":"@",$G(ECHAR4)="":"@",1:$G(ECHAR4)) ;126 Add credit stop and char4 fields
 D ^DIE I $D(DTOUT) D RECDEL D  D END Q
 . S ^TMP($J,"ECMSG",1)="0^DSS Unit Record not Filed"
 I 'ECFLG D ECSCRNS
 S ^TMP($J,"ECMSG",1)="1^DSS Unit Record Filed"_U_ECIEN
END K DIE,DIC,DR,DA,DO,ECIEN
 Q
VALDATA ;validate data
 N ECRRX
 D CHK^DIE(724,.01,"E",ECDUNM,.ECRRX) I ECRRX'=ECDUNM D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid DSS Unit Name"
 D CHK^DIE(724,1,"E","`"_ECS,.ECRRX) I ECRRX'=ECS D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Service"
 D CHK^DIE(724,2,"E","`"_ECM,.ECRRX) I ECRRX'=ECM D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Medical Speciality"
 D CHK^DIE(724,3,"E","`"_ECTR,.ECRRX) I ECRRX'=ECTR D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Cost Center"
 I $G(ECUN)'="" D CHK^DIE(724,4,"E",ECUN,.ECRRX) I ECRRX'=ECUN D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Unit Number"
 I $G(ECASC)'="" D CHK^DIE(724,9,"E","`"_ECASC,.ECRRX) I ECRRX'=ECASC D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Associated Stop Code" ;126 Corrected error message
 I $G(ECCSC)'="" D CHK^DIE(724,14,"E","`"_ECCSC,.ECRRX) I ECRRX'=ECCSC S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Credit Stop Code" Q  ;126
 I $G(ECHAR4)'="" D CHK^DIE(724,15,"E","`"_ECHAR4,.ECRRX) I ECRRX'=ECHAR4 S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid CHAR4 Code" Q  ;126
 Q
ECSCRNS ;Determine if event codes should be updated based on change of DSS Unit
 ;status
 ;  DSS Unit status changed from Active to Inactive, if EC screen status
 ;      A - retain, do nothing,  B - inactiviate
 ;  DSS Unit status changed from Inactive to Active, if EC screen status
 ;      C - reactiviate,         D - remain inactive
 ;
 N ECD,ECINC,ZTDESC,ZTSAVE,ZTIO,ZTRTN,ZTDTH
 I ($G(ECSCN)="")!(ECSCN="A")!(ECSCN="D") Q
 I "^B^C^"']"^"_ECSCN_"^" Q
 S ECD=ECIEN,ECINC=DT
 I ECSCN="B" D
 .S ZTDESC="DEALLOCATE DSS UNIT & INACTIVATE EVENT CODE SCREENS"
 I ECSCN="C" D
 .S ZTDESC="REACTIVIATE EVENT CODE SCREENS",ECINC="@"
 S ZTRTN=$S(ECSCN="B":"DIK",1:"INSCRN")_"^ECDEAL",ZTDTH=$H
 N ECSCN
 S ECSCN=1,(ZTSAVE("ECD"),ZTSAVE("ECSCN"),ZTSAVE("ECINC"))="",ZTIO=""
 D ^%ZTLOAD K ZTSK Q
 D @ZTRTN
 Q
 ;
RECDEL ; Delete record
 I ECFLG S DA=ECIEN,DIK="^ECD(" D ^DIK K DA,DIK
 Q
NEWIEN ;Create new IEN in file #724
 N DIC,DA,DD,DO
 L +^ECD(0):3 ;126 Added lock time out as required by standard
 S DIC=724,DIC(0)="L",X=ECDUNM
 D FILE^DICN
 L -^ECD(0)
 S ECIEN=+Y
 Q
CHKDT ;Required Data Check
 N I,C
 S C=1
 F I="ECDUNM","ECS","ECM","ECTR","ECC" D
 .I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key data missing "_I,C=C+1,ECERR=1
 Q
USER ;Used by the RPC broker to allocate or de-allocate users for DSS Units
 ;in file #200
 ;     Variables passed in
 ;       ECIEN      - IEN of DSS Unit in file #724
 ;       ECUSR0..n  - Users to allocate/deallocate to DSS Unit
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #724^Message
 ;
 N EDUZ,ECERR,ECI,ECX,USER,DIC,DIK,X,Y,DA
 S (EDUZ,ECERR)=0,ECIEN=$G(ECIEN)
 I ECIEN="" S ^TMP($J,"ECMSG",1)="0^DSS Unit missing" Q
 D  I ECERR Q
 . I '$D(^ECD(ECIEN,0)) D
 . . S ECERR=1,^TMP($J,"ECMSG",1)="0^DSS Unit Not on File"
 F ECI=0:1 S ECX="ECUSR"_ECI Q:'$D(@ECX)  S:@ECX'="" USER(@ECX)=""
 F  S EDUZ=$O(^VA(200,EDUZ)) Q:'EDUZ  I $D(^VA(200,EDUZ,"EC",ECIEN,0)) D
 . I $D(USER(EDUZ)) K USER(EDUZ) Q
 . K DA,DIK S DA(1)=EDUZ,DA=ECIEN,DIK="^VA(200,"_DA(1)_",""EC"","
 . D ^DIK K USER(EDUZ)
 ;add users for DSS Unit
 S EDUZ=0 F  S EDUZ=$O(USER(EDUZ)) Q:'EDUZ  D
 . K DIC,DD,DO S DIC=200,DIC(0)="QNMX",X=EDUZ D ^DIC I Y<0 Q
 . K DIC,DD,DO S DIC(0)="L",DA(1)=EDUZ,DIC("P")=$P(^DD(200,720,0),U,2)
 . S DINUM=ECIEN,DIC="^VA(200,"_DA(1)_",""EC"",",X=ECIEN
 . D FILE^DICN
 S ^TMP($J,"ECMSG",1)="1^Record Filed"_U_ECIEN K DINUM
 Q
DSSU ;Used by the RPC broker to allocate or de-allocate DSS Units for a user
 ;in file #200
 ;     Variables passed in
 ;       ECIEN   - User IEN in file #200
 ;       ECD0..n - IEN of DSS Unit in file #724 to allocate/deallocate
 ;       
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #200^Message
 ;
 N EDU,ECERR,ECI,ECX,ECDSSU,DIC,DIK,DA,X,Y
 S (EDU,ECERR)=0,ECIEN=$G(ECIEN)
 I ECIEN="" S ^TMP($J,"ECMSG",1)="0^User missing" Q
 D  I ECERR Q
 . S DIC=200,DIC(0)="QNX",X=ECIEN D ^DIC D:Y<0
 . . S ECERR=1,^TMP($J,"ECMSG",1)="0^User Not on File"
 F ECI=0:1 S ECX="ECD"_ECI Q:'$D(@ECX)  S:@ECX'="" ECDSSU(@ECX)=""
 F  S EDU=$O(^VA(200,ECIEN,"EC",EDU)) Q:'EDU  D
 . I $D(ECDSSU(EDU)) K ECDSSU(EDU) Q
 . K DA,DIK S DA(1)=ECIEN,DA=EDU,DIK="^VA(200,"_DA(1)_",""EC"","
 . D ^DIK
 ;add DSS Units for user
 S EDU=0 F  S EDU=$O(ECDSSU(EDU)) Q:'EDU  D
 . I '$D(^ECD(EDU,0)) Q
 . K DIC,DD,DO S DIC(0)="L",DA(1)=ECIEN,DIC("P")=$P(^DD(200,720,0),U,2)
 . S DINUM=EDU,DIC="^VA(200,"_DA(1)_",""EC"",",X=EDU
 . D FILE^DICN
 S ^TMP($J,"ECMSG",1)="1^Record Filed"_U_ECIEN
 Q
 ;
UPDSCRN ;131 Section added to remove default associated clinic from event capture screens for a specific DSS Unit
 N LOC,CAT,PROC,DA,DIE,DR
 S LOC=0 F  S LOC=$O(^ECJ("AP",LOC)) Q:'+LOC  S CAT="" F  S CAT=$O(^ECJ("AP",LOC,ECIEN,CAT)) Q:CAT=""  S PROC="" F  S PROC=$O(^ECJ("AP",LOC,ECIEN,CAT,PROC)) Q:PROC=""  D
 .S DA=$O(^ECJ("AP",LOC,ECIEN,CAT,PROC,0)) Q:'+DA
 .S DIE="^ECJ("
 .S DR="55///@"
 .D ^DIE
 Q
 ;
FIXSCRNS ;131 Section added to inactivate existing event code screens
 ;when category changed from yes to no.  Equivalent event code screens
 ;without a category will either be reactivated or created, as needed
 ;
 N LOC,CAT,PROC,DR,DA,DIE,DSS,ECCH,ECL,ECD,ECC,ECP,ECST,ECSYN,ECVOL,ECAC,ECREAS,NODE
 S LOC=0 F  S LOC=$O(^ECJ("AP",LOC)) Q:'+LOC  S CAT=0 F  S CAT=$O(^ECJ("AP",LOC,ECIEN,CAT)) Q:'+CAT  S PROC="" F  S PROC=$O(^ECJ("AP",LOC,ECIEN,CAT,PROC)) Q:PROC=""  D
 .S DA=$O(^ECJ("AP",LOC,ECIEN,CAT,PROC,0)) Q:'+DA  ;Get record # of existing event code screen
 .I $P(^ECJ(DA,0),U,2)'="" Q  ;Screen is already inactive, no action needed
 .S DIE="^ECJ(",DR="1///"_$$DT^XLFDT D ^DIE ;Inactivate screen using today's date
 .;Create or activate/update equivalent event code screen without a category
 .S ECCH=LOC_"-"_ECIEN_"-"_0_"-"_PROC,DSS=ECIEN S ECIEN="" ;protecting ECIEN as it's used in another routine
 .I $D(^ECJ("B",ECCH)) S ECIEN=$O(^ECJ("B",ECCH,0)) Q:'+ECIEN  ;Non-category event code screen exists, identify record number for updating
 .S ECL=LOC,ECD=DSS,ECC=0,ECP=PROC,ECST="A"
 .S NODE=$G(^ECJ(DA,"PRO")),ECSYN=$P(NODE,U,2),ECVOL=$P(NODE,U,3),ECAC=$P(NODE,U,4),ECREAS=$E($$GET1^DIQ(720.3,DA,56,"E"),1) ;Setting input variables needed for call to ECMFECS
 .D FILE^ECMFECS ;File update or create new event code screen
 .S ECIEN=DSS ;Reset ECIEN to DSS Unit IEN
 Q
