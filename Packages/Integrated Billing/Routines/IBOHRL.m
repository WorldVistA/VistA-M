IBOHRL ;ALB/EMG-AUTO-RELEASE CHARGES ON HOLD > 90 DAYS ;APR 11 1997
 ;;2.0;INTEGRATED BILLING;**70,215,464,663**;21-MAR-94;Build 27
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; 
EN ;
 N DFN,IBDT,IBDUZ,IBDYS,IBEND,IBGRP,IBN,IBND,IBNOS,IBNUM,IBRCOUNT
 N IBSEQNO,IBSTJB,IBT,IBTO,X,X1,X2,XMDUZ,XMSUB,XMTEXT,XMY
 S IBQUIT=0
 ;
 D NOW^%DTC S IBSTJB=$$DAT2^IBOUTL(%)
 ;***
 K ^TMP($J)
 D CHRGS
 D:'$G(IBQUIT) REL,MAIL
 ;***
EXIT ;
 K ^TMP($J)
 K DFN,IBDT,IBDUZ,IBDYS,IBEND,IBGRP,IBN,IBND,IBNOS,IBNUM,IBRCOUNT,IBDIFROM
 K IBQUIT,IBSEQNO,IBSTJB,IBT,IBTO,X,X1,X2,XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
CHRGS ; indexes charges on hold longer than the number specified in the NUMBER OF DAYS PT CHARGES HELD field (#7.04) of file #350.9
 ; 
 S IBDYS=$P($G(^IBE(350.9,1,7)),U,4)
 I IBDYS="" S IBQUIT=1 D E4^IBAERR Q  ;quit/send notice if number of days held is unknown
 S X1=DT,X2=-(IBDYS+1) D C^%DTC S IBTO=X
 S DFN=0 F  S DFN=$O(^IB("AHDT",DFN)) Q:'DFN  S IBDT=0 F  S IBDT=$O(^IB("AHDT",DFN,8,IBDT)) Q:'IBDT!(IBDT>IBTO)  S IBN=0 F  S IBN=$O(^IB("AHDT",DFN,8,IBDT,IBN)) Q:IBN=""  D
 .S IBND=$G(^IB(IBN,0)) Q:'IBND
 .Q:$P(IBND,"^",5)'=8
 .S ^TMP($J,"IBHOLD",DFN,IBN)=""
 .Q
 Q
REL ; release charges to AR
 S (DFN,IBNUM,IBSEQNO,IBNOS)="",IBSEQNO=1,IBRCOUNT=0
 S DFN=0 F  S DFN=$O(^TMP($J,"IBHOLD",DFN)) Q:'DFN  S IBNUM=0 F  S IBNUM=$O(^TMP($J,"IBHOLD",DFN,IBNUM)) Q:'IBNUM  D
 .S IBNOS=IBNUM
 .S IBDUZ=$P($G(^IB(IBNOS,1)),U) I IBDUZ="" S IBDUZ=DUZ
 .D ^IBR
 .D UPDUCDB^IBRREL(IBNUM)  ;IB*2.0*663 allow for update of UC Visit DB 
 .I $P($G(^IB(IBNUM,0)),"^",5)=3 D
 ..S IBRCOUNT=IBRCOUNT+1
 ..I $G(IBR60) S IBNDE=^IB(IBNUM,0) D IVM^IBAMTV32(IBNDE) K IBNDE
 .Q
 Q
 ;
MAIL ; send bulletin when job is complete
 D NOW^%DTC S IBEND=$$DAT2^IBOUTL(%)
 S XMSUB=$S($G(IBR60):"CHARGES PENDING REVIEW",1:"HELD CHARGES")_" PASSED TO AR "_$P(IBSTJB,"@",1)
 S XMDUZ="INTEGRATED BILLING PACKAGE",IBDUZ=DUZ
 K IBT,XMY
 S IBGRP=$P($G(^XMB(3.8,+$P($G(^IBE(350.9,1,0)),"^",11),0)),"^")
 I IBGRP]"" S XMY("G."_IBGRP_"@"_^XMB("NETNAME"))=""
 S XMTEXT="IBT("
 S XMY(IBDUZ)=""
 S IBT(1)="The job that passes "_$S($G(IBR60):"charges pending review",1:"held charges")_" to accounts receivable is complete."
 S IBT(2)="[ "_IBRCOUNT_" ] charge"_$S(IBRCOUNT=1:" has",1:"s have")_" been passed to accounts receivable."
 S IBT(3)=" "
 S IBT(4)="Job started on "_$P(IBSTJB,"@",1)_" at "_$P(IBSTJB,"@",2)
 S IBT(5)="Job finished on "_$P(IBEND,"@",1)_" at "_$P(IBEND,"@",2)
 S IBT(6)=" "
 S IBT(7)=" "
 I IBRCOUNT>0 D
 .S IBT(8)="* Use option 'On Hold/Hold-Review Charges Released to AR' to print a detailed"
 .S IBT(9)="  list of charges auto-released by this tasked job."
 ;
 I $G(DIFROM) S IBDIFROM=DIFROM K DIFROM
 D ^XMD
 I $G(IBDIFROM) S DIFROM=IBDIFROM
