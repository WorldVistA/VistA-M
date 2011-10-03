IBARXEPS ;ALB/RM/PHH,EG - RX COPAY EXEMPTION UPDATE STATUS ; 12/13/2005
 ;;2.0;INTEGRATED BILLING;**321**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine was copied/modified from IBARXEPV.
 ;
 Q
POST ; Entry point from TaskMan
 I '$D(DT) D
 .N %,%H,%I,X,DT
 .D NOW^%DTC
 .S DT=X
 N NAMESPC
 S NAMESPC=$$NAMESPC()
 D UPDT($E(DT,1,3)_"0101",DT,1)
 K ^XTMP(NAMESPC,"RUNNING")
 Q
START ;Entry Point from post-install
 N QTIME,X,NAMESPC
 S NAMESPC=$$NAMESPC()
 Q:$$RUNCHK(NAMESPC)   ; Quit if already running or has run to completion
 K ^XTMP(NAMESPC)
 S X=$$QTIME(.QTIME)
 S ^XTMP(NAMESPC,"USER")=$S($G(DUZ)'="":DUZ,1:"UNKNOWN")
 S:'$$QUEUE(QTIME) ^XTMP(NAMESPC,"RUNNING")=""
 Q
NAMESPC() ; API returns the name space for this patch
 Q "IBARXEPS"
RUNCHK(NAMESPC) ; Check to see if clean up is already running
 Q:NAMESPC="" 1                   ; Name Space must be defined
 Q:$D(^XTMP(NAMESPC,"RUNNING")) 1
 Q 0
QTIME(WHEN) ; Get the run time for queuing
 N %,%H,%I,X
 D NOW^%DTC
 S WHEN=$P(%,".")_"."_$E($P(%,".",2),1,4)
 Q 0
QUEUE(ZTDTH) ; Queue the process
 N NAMESPC,QUEERR,ZTDESC,ZTRTN,ZTSK
 S NAMESPC=$$NAMESPC
 S QUEERR=0
 S ZTRTN="POST^IBARXEPS"
 S ZTDESC=NAMESPC_" - RX COPAY EXEMPTION UPDATE STATUS"
 S ZTIO=""
 D ^%ZTLOAD
 K ^XTMP(NAMESPC,"ZTSK")
 I '$D(ZTSK) S ^XTMP(NAMESPC,"ZTSK")="Unable to queue post-install process.",QUEERR=1
 I $D(ZTSK) D
 . S ^XTMP(NAMESPC,"ZTSK")="Post-install queued. Task ID: "_$G(ZTSK)
 . D MES^XPDUTL(" This request queued as Task # "_ZTSK)
    . D MES^XPDUTL("")
    . Q
 Q QUEERR
 ;
UPDT(IBBDT,IBEDT,IBUP) ;
 ; IBBDT - Beginning Date for the process
 ; IBEDT - Ending Date for the process
 ; IBUP  - Update mode (1 - Update, 0 - Report only)
 ;
 ; All three input parameters are required
 I 'IBBDT!('IBEDT)!(IBEDT<IBBDT) Q
 ;
 ; Entry point to start comparison
 N IBJOB,IBWHER,%
 S (IBPCNT,IBPAG)=0,IBOK=1 D NOW^%DTC S Y=% D D^DIQ
 S IBPDAT=$P(Y,"@")_" "_$E($P(Y,"@",2),1,5)
 K ^TMP($J,"IBUNVER")
 ;
 ; Look through EFFECTIVE DATE x-ref in BILLING EXEMPTIONS File #354.1
 S IBDT=IBBDT-.00001
 F  S IBDT=$O(^IBA(354.1,"B",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.9))  D
 .S IBDA=0 F   S IBDA=$O(^IBA(354.1,"B",IBDT,IBDA)) Q:'IBDA  D 
 ..D CHK I 'IBOK D UP:IBUP,SET
 D REPORT
 ;
 K ^TMP($J,"IBUNVER")
 K DFN,DIR,DIRUT,DIC,DIE,DA,DR,X,Y
 K IBBDT,IBDA,IBDATA,IBDEPEN,IBDFN,IBDT,IBEDT,IBER,IBERR,IBEXREA,IBEXREAN,IBEXREAO,IBJ,IBMESS,IBNAM,IBOK,IBP,IBPAG,IBPCNT,IBPDAT,IBQUIT,IBUP
 Q
 ;
CHK ; Check if current status = computed status
 S IBOK=1,IBMESS="Nothing Updated",IBERR=""
 S X=$G(^IBA(354.1,+IBDA,0)) G CHKQ:'$P(X,"^",10) ;not active skip
 S DFN=$P(X,"^",2)
 S Y=$G(^IBA(354,DFN,0)) I +X<$P(Y,"^",3) G CHKQ ;not current exemption
 ;
 N DGMT,CONV,CLN S (CLN,CONV)=0,DGMT=$$LST^DGMTU(DFN,+X,1)
 I $P(DGMT,U,5)=2 D  G:CONV CHKQ           ; skip Edb conv. tests
 .; Loop through the MT comments, Check for EDB converted test 
 .; No comments to check
 .Q:'$D(^DGMT(408.31,+DGMT,"C",1,0))
 .F  S CLN=$O(^DGMT(408.31,+DGMT,"C",CLN)) Q:'CLN!(CONV)  D
 ..I ^DGMT(408.31,+DGMT,"C",CLN,0)["Z06 MT via Edb" S CONV=1
 ;
 S IBPCNT=IBPCNT+1
 I '+Y S IBOK=0,IBERR=4
 S IBEXREAO=$P(X,"^",5)_"^"_+X ;current exemption
 I $P($G(^IBE(354.2,+IBEXREAO,0)),"^",5)=2010 G CHKQ ; hardships don't report
 I +X>$P(Y,"^",3) S IBOK=0,IBERR=1 ;most current exemption not in 354
 I $P(X,"^",5)'=$P(Y,"^",5) S IBOK=0,IBERR=2 ;Current exemption not in 354
 I $P(X,"^",4)'=$P(Y,"^",4) S IBOK=0,IBERR=5 ;current status in exemption not in 354
 S IBEXREAN=$$STATUS^IBARXEU1(DFN,DT)
 I +IBEXREAO'=+IBEXREAN S IBOK=0,IBERR=3
CHKQ Q
 ;
UP ; -- update current exemption status
 Q:IBOK
 S IBJOB=15,IBWHER=16
 I IBERR=4 D  G UPQ
 .S DIE="^IBA(354,",DA=DFN,DR=".01////"_DFN D ^DIE
 .K DIE,DA,DR,DIC
 .S IBMESS="Name Corrected"
UP1 N IBOLDAUT S IBOLDAUT=""
 ;
 ; -- if currently not auto exempt make sure not more recent auto exempt
 I $L($P($G(^IBE(354.2,+IBEXREAN,0)),"^",5))>2 D OLDAUT^IBARXEX1(IBEXREAN)
 S IBFORCE=$P(IBEXREAN,"^",2)
 D MOSTR^IBARXEU5($P(IBEXREAN,"^",2),+IBEXREAN)
 D ADDEX^IBAUTL6(+IBEXREAN,$P(IBEXREAN,"^",2),1,1,IBOLDAUT)
 S IBMESS="Updated"
UPQ K IBFORCE Q
 ;
SET ; Set ^tmp node if not okay
 Q:IBOK
 S IBP=$$PT^IBEFUNC(DFN)
 S IBDFN=DFN
 I $D(^TMP($J,"IBUNVER",$P(IBP,"^"),DFN)) S IBDFN=DFN_"-"_IBPCNT
 S ^TMP($J,"IBUNVER",$P(IBP,"^"),IBDFN)=IBEXREAO_"^"_IBEXREAN_"^"_IBERR_"^"_IBMESS_"^"_IBP
 Q
 ;
REPORT ; Send MailMan recap report of updated records
 N IBMGRP,XMDUZ,XMTEXT,XMY,XMSUB,LNCNT,IBPDAT,IBDCNT,MSG,TXT,EXRSN,XMDUZ
 S IBMGRP=$$GET1^DIQ(350.9,1,.13)
 Q:IBMGRP=""
 S IBMGRP=$O(^XMB(3.8,"B",IBMGRP,""))
 Q:'IBMGRP
 D XMY^DGMTUTL(IBMGRP,0,1)
 S XMDUZ="IB PACKAGE",XMTEXT="MSG(",LNCNT=1,IBDCNT=0
 S XMY(DUZ)="",XMSUB="IB RX COPAY EXEMPT UPDATE"
 D NOW^%DTC S Y=% D D^DIQ S IBPDAT=$P(Y,"@")_" "_$E($P(Y,"@",2),1,5)
 S MSG(LNCNT)="     Medication Copayment Exemption Problem Report "_IBPDAT
 S LNCNT=LNCNT+1,MSG(LNCNT)=" "
 S TXT="Patient               PT. ID       Error         Current/Calc Exemption"
 S LNCNT=LNCNT+1,MSG(LNCNT)=TXT
 S LNCNT=LNCNT+1,MSG(LNCNT)=$TR($J(" ",78)," ","-")
 D EXRSN
 S IBNAM="" F  S IBNAM=$O(^TMP($J,"IBUNVER",IBNAM)) Q:IBNAM=""  D
 .S IBDFN="" F  S IBDFN=$O(^TMP($J,"IBUNVER",IBNAM,IBDFN)) Q:IBDFN=""  D
 ..S IBER=^(IBDFN) D MSGLN(IBNAM,IBER)
 ;
 I $D(^TMP($J,"IBUNVER")) D
 .S LNCNT=LNCNT+1,MSG(LNCNT)=" "
 .S LNCNT=LNCNT+1,MSG(LNCNT)="There were "_IBDCNT_" discrepancies found in "_IBPCNT_" exemptions checked."
 I '$D(^TMP($J,"IBUNVER")) S LNCNT=LNCNT+1,MSG(LNCNT)=" No discrepancies found in "_IBPCNT_" exemptions checked."
 D ^XMD
REPORTQ Q
 ;
MSGLN(IBNAM,IBER) ; Create the body of the report
 N IBSSN,IBCURX,IBCALX,RECORD
 S IBNAM=$E(IBNAM,1,20),IBDCNT=IBDCNT+1
 S IBSSN=$P(IBER,U,8)
 S X=$P(IBER,U,5),X=$E($S(X=3:"Incorr Exmpt",X=1!(X=2)!(X=5):"Not Curr Stat",X=4:"Name Missing",1:"Hmmmm"),1,13)
 S IBCURX=EXRSN($P(IBER,U))
 S IBCALX=EXRSN($P(IBER,U,3))
 S RECORD=$$LJ^XLFSTR(IBNAM,22," ")_IBSSN_"  "_$$LJ^XLFSTR(X,15," ")_IBCURX_"/"_IBCALX
 S LNCNT=LNCNT+1,MSG(LNCNT)=RECORD
 Q
 ;
EXRSN ; Exempt Reason Array for MailMan Message
 N IBIEN S IBIEN=0
 F  S IBIEN=$O(^IBE(354.2,IBIEN)) Q:'IBIEN  S EXRSN(IBIEN)=$E($P(^IBE(354.2,IBIEN,0),U),1,15)
 Q
 ;
