IBY519PO ;ALB/GEF - Post install routine for patch 519 ; 21-FEB-14
 ;;2.0;INTEGRATED BILLING;**519**;21-MAR-94;Build 56
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Call to XUPROD is allowed with IA#4440
 ; XPDUTL calls are DBIA#10141
 ; ZTQUEUED is a KIDS variable that indicates if the user queued the install.  This variable should not
 ; be killed or newed here
 ;
 D EN
 Q
DOC ; This routine will Create Data Extract EMAILS from Each VAMC to FSC for Initial Seeding of NIF
 ;
 ; Each VistA site will submit a data extract in the form of one or more emails as defined in
 ; the ICD.  This data extract is to happen only once at each of the VAMC after the patch 
 ; IB*2.0*519 is nationally released upon direction of the VA's Chief Business Office's (CBO) 
 ; eInsurance team.  FSC will load the data from these flat files into the FSC Staging table.  
 ; The data within the FSC Staging table will be used to identify a consolidated list of payers 
 ;(insurance companies) across all VAMCs which will then be used to initially populated (seed) 
 ; the VA National Insurance File (NIF).
 ;
 ; Types of Records:  HEADER (HDR), PAYER (INS), TRAILER (EOF)    
 ; * Each VAMC will have 1 HEADER record and 1 TRAILER record, with 1 to many PAYER records in between the two.
 ; Delimiter = "^"
 ;
 ; Data output: 
 ; HDR^Station #^Site name
 ; INS^Stn#^Ins.Co.ien^NAME^EDI PROF^EDI INST^QUAL^2NDARY I1^QUAL^2ND I2^QUAL^2ND P1^QUAL^2ND P2^VA NTL ID^STR ADR 1^ADR2^CITY^ST^ZIP^BILL NM^PH^TYP OF COVG
 ; EOF^Stn#^Site
 ;
 ; Search criteria:
 ; 1.  Insurance Company entry in file #36 must be ACTIVE (field #.05 '=1)
 ; 2.  There must be patients associated with the Ins.Co. (^DPT("AB",INS))
 ; 3.  There must be groups associated with the Ins. Co. (^IBA(355.3,"B",INS))
 ;
 ; note the following:
 ; 3.1  PAYER (*P365.12'), [3;10] populate with VA NATIONAL ID only if 
 ; Payer file #365.13 application "IIV" is locally & nationally active 
 ;
 Q
EN ; Post Install Routine primary entry point
 ;
 N IBPRD,DIC,X,Y,DIE,DR,DA
 ; Call to XUPROD allowed by IA#4440
 S IBPRD=$S($$PROD^XUPROD(1)=1:"P",1:"T")
 ;Stuff FSC domain into link
 S DIC="^HLCS(870,",DIC(0)="LS" S X="IB NIF TCP" D ^DIC
 ; For test environments, use the FSC test domain
 I IBPRD="T",Y'=-1 S DIE=DIC,DA=+Y,DR=".08///ECOMMLLPTST.FSC.DOMAIN.EXT;400.02///9346;4.5///1" K DIC D ^DIE
 ; For Production environments, use the FSC PRD domain
 I IBPRD="P",Y'=-1 S DIE=DIC,DA=+Y,DR=".08///ECOMMLLPPRD.FSC.DOMAIN.EXT;400.02///9346;4.5///1" K DIC D ^DIE
 K DA,DIE,DR,X,Y
 ;Set up NIFQRY mail group to trigger batch query for this environment
 N DO,DD,DA,DLAYGO,DIC,X,RCSITE
 S RCSITE=$G(^XMB("NETNAME"))  Q:RCSITE=""   ; SITE DOMAIN NAME
 S X="S.IBCNH HPID NIF BATCH QUERY@"_RCSITE             ; SERVER NAME WITH SITE DOMAIN NAME
 S DA(1)=$O(^XMB(3.8,"B","NIFQRY",0))           ; MAIL GROUP IEN
 I $D(^XMB(3.8,DA(1),6,"B",$E(X,1,30))) Q    ; MAIL ADDRESS ALREADY EXISTS.
 S DLAYGO=3.812,DIC(0)="L",DIC="^XMB(3.8,"_DA(1)_",6,"
 D FILE^DICN                                 ; FILE THE ADDRESS
 ;Do not run extract if this patch has already been installed once - DBIA#10141
 I $$INSTALDT^XPDUTL("IB*2.0*519")>0 D:'$D(ZTQUEUED) BMES^XPDUTL("Post-Install already performed.  No need to run again.") Q
 ;  08/29/14 No longer run extract in test environments
 I IBPRD="T" D:'$D(ZTQUEUED) BMES^XPDUTL("Post-Install extract will not be run in a non-Production environment.") Q
 ; if the user queued the patch install, just run it for now, skip the tasking prompt
 I $D(ZTQUEUED) D TSK Q 
 ; start here if you need to manually run the extract
EXT ;
 N IBA,ZTRTN,ZTDESC,ZTSK,ZTIO
 S ZTRTN="TSK^IBY519PO",ZTIO="",ZTDESC="Insurance Company Data Extract for NIF Seeding"
 S IBA(1)="",IBA(2)="    Tasking Post-Install Insurance Company Data Extract.....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 D ^%ZTLOAD
 ; If tasking failed, need to notify someone 
 I '$D(ZTSK) S IBA(1)="",IBA(2)="    Tasking Data Extract FAILED.....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA Q
 S IBA(1)="",IBA(2)="    Task #:  "_ZTSK,IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 K ZTRTN,ZTDESC,ZTSK,ZTIO,ZTSAVE
 Q
 ;
TSK ; taskman and queued install comes here
 N IBN,IBDTA,IBND,IBVID,I,MAXSIZE,COUNT,IBSIZE,IBRTN,IBSTN,DTTM,MSGCNT,IBEOL,TOTREC,IBPRD
 K ^TMP("IBY519PO",$J)
 ; Call to XUPROD allowed by IA#4440
 S IBPRD=$S($$PROD^XUPROD(1)=1:"P",1:"T")
 S IBSTN=$$SITE^VASITE(),IBSTN=$P(IBSTN,U,3)_U_$P(IBSTN,U,2)
 ; Set end of line character
 S IBEOL="~"
 ; for testing, set maxsize low - for production Set to 300000
 S MAXSIZE=$S(IBPRD="P":300000,1:100000)
 ; Set record, size and message counters
 S COUNT=1,IBSIZE=0,MSGCNT=0,TOTREC=0,IBRTN="IBY519PO",DTTM=$$FMTE^XLFDT($$NOW^XLFDT)
 S IBN=0 F  S IBN=$O(^DIC(36,IBN)) Q:'IBN  D
 .; don't print if there are no patients associated with this ins.co. OR if there are no groups associated with this insurance co.
 .Q:'$D(^DPT("AB",IBN))
 .Q:'$D(^IBA(355.3,"B",IBN))
 .S IBDTA(0)=$G(^DIC(36,IBN,0))
 .; only active insurance companies
 .Q:$P(IBDTA(0),U,5)=1
 .F IBND=.11,.13,3,6 S IBDTA(IBND)=$G(^DIC(36,IBN,IBND))
 .; Get VA National ID
 .S IBVID=$$VID^IBCNHUT1(IBN)
 .K DATA
 .S COUNT=COUNT+1,TOTREC=TOTREC+1,DATA="INS"_U_$P(IBSTN,U)_U_IBN_U_$P(IBDTA(0),U)
 .F I=2,4 S DATA=DATA_U_$P(IBDTA(3),U,I)
 .F I=1:1:8 S DATA=DATA_U_$P(IBDTA(6),U,I)
 .S DATA=DATA_U_IBVID
 .F I=1,2,4 S DATA=DATA_U_$P(IBDTA(.11),U,I)
 .S DATA=DATA_U_$P($G(^DIC(5,+$P(IBDTA(.11),U,5),0)),U)
 .F I=6,7 S DATA=DATA_U_$P(IBDTA(.11),U,I)
 .S DATA=DATA_U_$P(IBDTA(.13),U)_U_$P($G(^IBE(355.2,+$P(IBDTA(0),U,13),0)),U)
 .S ^TMP(IBRTN,$J,COUNT)=DATA_U_IBEOL,IBSIZE=IBSIZE+$L(^TMP(IBRTN,$J,COUNT))
 .K DATA
 .; if we have exceeded max mail message size, start a new one
 .I IBSIZE>MAXSIZE D 
 ..D EOF,MAIL(IBRTN,"R")
 ..K ^TMP(IBRTN,$J)
 ..S COUNT=1,IBSIZE=0
 ; send final email if it has records, then cleanup
 D EOF I $G(COUNT)>1 D MAIL(IBRTN,"R")
 K ^TMP(IBRTN,$J)
 ; send summary email
 S ^TMP("IBSUM",$J,1)=$P(IBSTN,U,2)_" ("_$P(IBSTN,U)_") "_$S(IBPRD="P":"Prod",1:"Test")_" Extract SUMMARY     Complete Date/Time:  "_$$FMTE^XLFDT($$NOW^XLFDT)
 S ^TMP("IBSUM",$J,2)=""
 S ^TMP("IBSUM",$J,MSGCNT+3)="==============================================================================="
 S ^TMP("IBSUM",$J,MSGCNT+4)="Total Record Count: "_TOTREC
 D MAIL("IBSUM","S")
 K IBN,IBDTA,IBND,IBVID,I,MAXSIZE,COUNT,IBSIZE,IBRTN,IBSTN,DTTM,MSGCNT,IBEOL,TOTREC,XMTEXT,IBPRD
 Q
 ;
EOF ; end one message
 Q:COUNT=1
 S MSGCNT=MSGCNT+1
 S ^TMP(IBRTN,$J,1)="HDR"_U_IBSTN_U_"Message Number: "_MSGCNT_U_"Line Count: "_COUNT_U_DTTM_U_IBRTN_U_IBPRD_U_IBEOL
 S ^TMP("IBSUM",$J,MSGCNT+2)="Message Number: "_MSGCNT_"     Line Count: "_$J(COUNT,6)_"     Sent at:  "_$$FMTE^XLFDT($$NOW^XLFDT)
 S COUNT=COUNT+1
 S ^TMP(IBRTN,$J,COUNT)="EOF"_U_IBSTN_U_IBEOL
 Q
 ;
MAIL(NODE,TYP) ; email message
 N XMSUB,XMZ,XMMG,DIFROM,XMEXT,XMY
 ; this is the mail group to send the extract to in Production
 I IBPRD="P" S:TYP="S" XMY("VHACBONIFINSExtract@domain.ext")=""
 I IBPRD="P" S:TYP'="S" XMY("XXX@Q-NPS.DOMAIN.EXT")=""
 ; for testing, send to these email addresses
 I IBPRD="T" S XMY("GRACE.FIAMENGO@DOMAIN.EXT")="",XMY("FIAMENGO,GRACE")="",XMY("CHRISTOPHER.THAYER@DOMAIN.EXT")="",XMY("THAYER,CHRISTOPHER")=""
 S XMTEXT="^TMP("""_NODE_""","_$J_","
 S XMSUB=$P(IBSTN,U,2)_" ("_$P(IBSTN,U)_") "_$S(IBPRD="P":"Prod",1:"Test")_" Extract "_$S(TYP="R":"Run Date/Time:  "_DTTM,1:"Complete at:  "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ^XMD
 Q
 ;
