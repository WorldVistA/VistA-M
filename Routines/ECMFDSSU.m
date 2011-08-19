ECMFDSSU ;ALB/JAM-Event Capture Management Filer DSS Unit ;20 Nov 00
 ;;2.0; EVENT CAPTURE ;**25,30,33**;8 May 96
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
 . . S ECERR=1,^TMP($J,"ECMSG",1)="0^Category Changed, EC Screen exist"
 . S ECONAM=$P($G(^ECD(ECIEN,0)),U)
 D  I ECERR D END Q   ;Check name
 . I (ECFLG)!((ECONAM'="")&(ECONAM'=ECDUNM)),$D(^ECD("B",ECDUNM)) D  Q
 . . S ECERR=1,^TMP($J,"ECMSG",1)="0^DSS Unit Name already exist"
 . I 'ECFLG K DIE S DIE="^ECD(",DA=ECIEN,DR=".01////"_ECDUNM D ^DIE
 S ECPCE=$S(ECPCE="A":"A",ECPCE="O":"O",1:"N")
 I ECPCE="N",$G(ECASC)="" D  D END Q
 . S ECERR=1,^TMP($J,"ECMSG",1)="0^No associated clinic, Send to PCE=N"
 I ECIEN="" D NEWIEN
 K DA,DR,DIE
 S ECST=$E($G(ECST)),ECST=$S(ECST="I":1,1:0),ECDFDT=$E($G(ECDFDT))
 S ECDFDT=$S(ECDFDT="N":"N",1:"X"),DIE="^ECD(",DA=ECIEN
 S DR="1////"_ECS_";2////"_ECM_";3////"_ECTR_";4////"_$G(ECUN)
 S DR=DR_";5////"_ECST_";7////1;9////"_$S(ECPCE'="N":"@",1:$G(ECASC))
 S DR=DR_";10////"_ECC_";11////"_ECDFDT_";13////"_ECPCE
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
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Associated Clinic"
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
 L +^ECD(0)
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
