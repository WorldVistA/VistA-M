ECEFPAT ;ALB/JAM-Enter Event Capture Data Patient Filer ;12 Oct 00
 ;;2.0; EVENT CAPTURE ;**25,32,39,42,47,49,54,65,72,95,76**;8 May 96;Build 6
 ;
FILE ;Used by the RPC broker to file patient encounter in file #721
 ;  Uses Supported IA 1995 - allow access to $$CPT^ICPTCOD
 ;
 ;     Variables passed in
 ;       ECIEN   - IEN of #721, if editing
 ;       ECDEL   - Delete record. 1- YES; 0- 0, null or undefine for NO.
 ;       ECDFN   - Patient IEN for file #2
 ;       ECDT    - Date and time of procedure
 ;       ECL     - Location
 ;       ECD     - DSS Unit
 ;       ECC     - Category
 ;       ECP     - Procedure
 ;       ECVOL   - Volume
 ;       ECU1..n - Provider (1 thru n), Prov 1 is required,other optional
 ;       ECMN    - Ordering Section
 ;       ECDUZ   - Entered/Edited by, pointer to #200
 ;       ECDX    - Primary Diagnosis
 ;       ECDXS   - Secondary Diagnosis; multiple, optional
 ;       EC4     - Associated Clinic, required if sending data to PCE
 ;       ECPTSTAT- Patient Status
 ;       ECPXREAS- Procedure reason, optional
 ;       ECMOD   - CPT modifiers, optional
 ;       ECLASS  - Classification, optional
 ;       ECELIG  - Eligibility, optional
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #721^Message
 ;
 N NODE,ECS,ECM,ECID,ECCPT,ECINT,ECPCE,ECX,ECERR,ECOUT,ECFLG,ECRES
 N ECFIL,ECPRV
 S ECFLG=1,ECERR=0 D CHKDT(1) I ECERR Q
 F ECX=1:1 Q:'$D(@("ECU"_ECX))  D  I ECERR Q
 .I @("ECU"_ECX)="" Q
 .S NODE=$$GET^XUA4A72(@("ECU"_ECX),ECDT) I +NODE'>0 S ECERR=1 D  Q
 ..S ^TMP($J,"ECMSG",1)="0^Provider doesn't have an active Person class"
 .S ECPRV(ECX)=@("ECU"_ECX)_"^^"_$S(ECX=1:"P",1:"S")
 I $G(ECIEN)'="" S ECFLG=0 D  I ECERR Q
 . I '$D(^ECH(ECIEN)) S ECERR=1,^TMP($J,"ECMSG",1)="0^Pat IEN Not Found"
 I $G(ECDEL) K ^TMP($J,"ECMSG") D  Q
 .S ECVST=$P($G(^ECH(ECIEN,0)),"^",21) I ECVST D
 ..;* Resend all EC records with same Visit file entry to PCE
 ..;* Remove Visit entry from ^ECH( so DELVFILE will complete cleanup
 ..K EC2PCE S ECVAR1=$$FNDVST^ECUTL(ECVST,,.EC2PCE) K ECVAR1
 ..;Set VALQUIET to stop Amb Care validator from broadcasting to screen
 ..N ECPKG,ECSOU
 ..S ECPKG=$O(^DIC(9.4,"B","EVENT CAPTURE",0)),ECSOU="EVENT CAPTURE DATA"
 ..S VALQUIET=1,ECVV=$$DELVFILE^PXAPI("ALL",ECVST,ECPKG,ECSOU) K ECVST,VALQUIET
 ..;- Send to PCE task
 ..D PCETASK^ECPCEU(.EC2PCE) K EC2PCE
 .S DA=ECIEN,DIK="^ECH(" D ^DIK K DA,DIK,ECVV
 .S ^TMP($J,"ECMSG",1)="1^Procedure Deleted"
 I '$D(ECPRV) S ^TMP($J,"ECMSG",1)="0^No provider present" Q
 S ECDT=+ECDT,NODE=$G(^ECD(ECD,0)) I NODE="" D MSG Q
 S ECFN=$G(ECIEN),ECVOL=$G(ECVOL,1),ECS=$P(NODE,U,2),ECM=$P(NODE,U,3)
 S ECPCE="U~"_$S($P(NODE,"^",14)]"":$P(NODE,"^",14),1:"N")
 ;S ECPTSTAT=$$INOUTPT^ECUTL0(ECDFN,+ECDT) ;pat stat may not need
 I $G(EC4)="" D GETCLN^ECEDF
 S ECID=$S(+EC4:$P($G(^SC(+EC4,0)),"^",7),1:""),ECINP=ECPTSTAT
 I $S($P(ECPCE,"~",2)="N":0,$P(ECPCE,"~",2)="O"&(ECINP'="O"):0,1:1) D
 .D CHKDT(2)
 I +EC4 S ECRES=$$CLNCK^SDUTL2(+EC4,0) I 'ECRES D  S ECERR=1
 .S ^TMP($J,"ECMSG",1)=ECRES_" Clinic MUST be corrected before filing."
 Q:ECERR  I ECFLG D NEWIEN
 S ECCPT=$S(ECP["ICPT":+ECP,1:$P($G(^EC(725,+ECP,0)),U,5))
 ;validate CPT value and handle HCPCS name to IEN conversion (HD223010)
 S ECCPT=+$$CPT^ICPTCOD(ECCPT)
 S ECCPT=$S(+ECCPT>0:ECCPT,1:0)
 K DA,DR,DIE S DIE="^ECH(",(DA,ECFN)=ECIEN K ECIEN
 S DR=".01////"_ECFN_";1////"_ECDFN_";3////"_ECL_";4////"_ECS
 S DR=DR_";5////"_ECM_";6////"_ECD_";7////"_+ECC_";9////"_ECVOL
 S $P(^ECH(ECFN,0),"^",9)=ECP
 D ^DIE I $D(DTOUT) D RECDEL,MSG Q
 S DA=ECFN,DR="11////"_ECMN_";13////"_ECDUZ_";2////"_ECDT
 S ECPXREAS=$G(ECPXREAS)
 S DR=DR_";19////"_$S(+ECCPT:ECCPT,1:"@")_";20////"_ECDX
 S DR=DR_";26////"_$G(EC4)_";27////"_$G(ECID)_";29////"_ECPTSTAT
 S DR=DR_";34////"_$S(ECPXREAS="":"@",1:ECPXREAS)
 D ^DIE I $D(DTOUT) D RECDEL,MSG Q
 I ECDX S ^DISV(DUZ,"^ICD9(")=ECDX  ;last ICD9 code
 S ECX=$O(ECPRV("A"),-1) I ECX'="" S ^DISV(DUZ,"^VA(200,")=+ECPRV(ECX)
 ;Remove Old CPT modifiers
 I 'ECFLG D
 . K OLDMOD S (ECDA,DA(1))=ECFN,DIK="^ECH("_DA(1)_",""MOD"",",DA=0
 . F  S DA=$O(^ECH(ECDA,"MOD",DA)) Q:'DA  S OLDMOD(DA)="" D ^DIK
 . K DA,ECDA,DIK,^ECH(ECFN,"MOD")
 .;Remove old secondary diagnosis codes
 . K OLDDXS S (ECDA,DA(1))=ECFN,DIK="^ECH("_DA(1)_",""DX"",",DA=0
 . F  S DA=$O(^ECH(ECDA,"DX",DA)) Q:'DA  S OLDDXS(DA)="" D ^DIK
 . K DA,ECDA,DIK,^ECH(ECFN,"DX")
 I $D(DTOUT) D RECDEL,MSG Q
 ;File multiple providers
 S ECFIL=$$FILPRV^ECPRVMUT(ECFN,.ECPRV,.ECOUT) K ECOUT
 I 'ECFIL D RECDEL,MSG Q
 ;File CPT modifiers
 I $G(ECMOD)'="" D
 . S DIC(0)="L",DA(1)=ECFN,DIC("P")=$P(^DD(721,36,0),U,2)
 . S DIC="^ECH("_DA(1)_","_"""MOD"""_","
 . F ECX=1:1:$L(ECMOD,"^") S MODIEN=$P(ECMOD,U,ECX) I +MODIEN>0 D
 . . K DD,DO S X=MODIEN D FILE^DICN
 . K MODIEN,DIC
 I $D(DTOUT) D RECDEL,MSG Q
 ; File multiple secondary diagnosis codes
 I $G(ECDXS)'="" D
 . S DXS="",DIC(0)="L",DA(1)=ECFN,DIC("P")=$P(^DD(721,38,0),U,2)
 . S DIC="^ECH("_DA(1)_","_"""DX"""_",",ECDXY=ECDX K ECDXX
 . F ECX=1:1:$L(ECDXS,"^") S DXSIEN=$P(ECDXS,U,ECX) I +DXSIEN>0 D
 . . S DXCDE=$$ICDDX^ICDCODE(DXSIEN,ECDT) Q:+DXCDE<0  I '$P(DXCDE,U,10) Q
 . . K DD,DO S X=DXSIEN D FILE^DICN
 . . S DXCDE=$P(DXCDE,U,2),ECDXX(DXCDE)=DXSIEN
 . . S ^DISV(DUZ,"^ICD9(")=DXSIEN  ;last ICD9 code
 . ; Update all procedures for an encounter with same primary & second dx
 . S PXUPD=$$PXUPD^ECUTL2(ECDFN,ECDT,ECL,EC4,ECDXY,.ECDXX,ECFN)
 . K PXUPD,ECDXY,ECDXX,DXS,DXSIEN,DIC,DXCDE,DA,DD,DO
 I $D(DTOUT) D RECDEL,MSG Q
 S DA=ECFN
 ;File classification AO^IR^SC^EC^MST^HNC^CV^SHAD
 I $G(ECLASS)'="" D
 . S CLSTR="21^22^24^23^35^39^40^41",DR=""
 . F ECX=1:1:$L(CLSTR,"^") D
 . . S DR=DR_$P(CLSTR,U,ECX)_"////"_$P(ECLASS,U,ECX)_";"
 . S DR=$E(DR,1,($L(DR)-1)) D ^DIE
 . K CLSTR,DR,DIE
 I $D(DTOUT) D RECDEL,MSG Q
 ;
PCE ; format PCE data to send
 I ($P(ECPCE,"~",2)="N")!($P(ECPCE,"~",2)="O"&(ECINP'="O")) D  Q
 .S ^TMP($J,"ECMSG",1)="1^Record Filed"
 D:ECFLG PCE^ECBEN2U I 'ECFLG S EC(0)=^ECH(ECFN,0) D PCEE^ECBEN2U K EC
 I $G(ECOUT)!(ECERR) D  Q
 . D RECDEL S STR=$S($G(^ECH(ECFN,"R")):^("R"),1:" PCE Data Missing")
 . S ^TMP($J,"ECMSG",1)="0^Record Not Filed, "_STR K STR
 S ^TMP($J,"ECMSG",1)="1^Record Filed"_U_$G(ECIEN)
 Q
 ;
NEWIEN ;Create new IEN in file #721
 N DIC,DA,DD,DO,ECRN
RLCK L +^ECH(0):60 S ECRN=$P(^ECH(0),"^",3)+1
 I $D(^ECH(ECRN)) S $P(^ECH(0),"^",3)=$P(^(0),"^",3)+1 L -^ECH(0) G RLCK
 L -^ECH(0) S DIC(0)="L",DIC="^ECH(",X=ECRN
 D FILE^DICN S ECIEN=+Y
 Q
RECDEL ; Delete record
 ;restore old data
 I 'ECFLG D  Q
 . I $O(OLDMOD("")) D
 . . S DIC(0)="L",DA(1)=ECFN,DIC("P")=$P(^DD(721,36,0),U,2)
 . . S DIC="^ECH("_DA(1)_","_"""MOD"""_",",ECX=0
 . . F  S ECX=$O(OLDMOD(ECX)) Q:'ECX  I ECX>0 K DD,DO S X=ECX D FILE^DICN
 . I $O(OLDDXS("")) D
 . . S DIC(0)="L",DA(1)=ECFN,DIC("P")=$P(^DD(721,38,0),U,2)
 . . S DIC="^ECH("_DA(1)_","_"""DX"""_",",ECX=0
 . . F  S ECX=$O(OLDDXS(ECX)) Q:'ECX  I ECX>0 K DD,DO S X=ECX D FILE^DICN
 . K DIC,DA,DD,DO,OLDMOD,OLDDXS,ECX
 S DA=ECFN,DIK="^ECH(" D ^DIK K DA,DIK
 Q
MSG ;Record not filed
 S ^TMP($J,"ECMSG",1)="0^Record not Filed"
 Q
CHKDT(FLG) ;Required Data Check
 N I,C
 S C=1
 I FLG=1 D  Q
 .F I="ECD","ECC","ECL","ECDT","ECP","ECDFN","ECMN","ECDUZ","ECPTSTAT" D
 ..I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key data missing "_I,C=C+1,ECERR=1
 .I $G(ECDEL),$D(ECIEN) K ^TMP($J,"ECMSG") S ECERR=0
 ;check PCE data
 I FLG=2 D  Q
 .F I="EC4","ECDX" D  Q
 ..I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key PCE data missing "_I,C=C+1,ECERR=1
 Q
VALDATA ;validate data
 N ECRRX
 D CHK^DIE(721,1,,"`"_ECDFN,.ECRRX) I ECRRX'=ECDFN D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Patient"
 D CHK^DIE(721,2,,ECDT,.ECRRX) I ECRRX'=ECDT D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Procedure Date"
 D CHK^DIE(721,3,,"`"_ECL,.ECRRX) I ECRRX'=ECL D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Location"
 D CHK^DIE(721,6,,"`"_ECD,.ECRRX) I ECRRX'=ECD D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid DSS Unit"
 D CHK^DIE(721,7,,"`"_ECC,.ECRRX) I ECRRX'=ECC D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Category"
 D  I ECERR Q
 .I ECP["ICPT" S ECRRX=$$CPT^ICPTCOD(+ECP,ECDT) I +ECRRX>0,$P(ECRRX,U,7) Q
 .I ECP["EC",$D(^EC(725,+ECP,0)) Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Procedure"
 D CHK^DIE(721,11,,"`"_ECMN,.ECRRX) I ECRRX'=ECMN D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Ordering Section"
 D CHK^DIE(721,20,,"`"_ECDX,.ECRRX) I ECRRX'=ECDX D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Primary Diagnosis"
 I $G(EC4)'="" D CHK^DIE(721,26,,"`"_EC4,.ECRRX) I ECRRX'=EC4 D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Associated Clinic"
 Q
