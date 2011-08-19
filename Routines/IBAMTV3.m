IBAMTV3 ;ALB/CPM-RELEASE CHARGES PENDING REVIEW ;03-JUN-94
 ;;2.0;INTEGRATED BILLING;**15,153,183,215**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Release Charges 'Pending Review' -- invoke the List Manager.
 I '$$CHECK^IBECEAU(1) G ENQ
 I '$D(^IB("AJ")) W !!,"There are no patients with charges pending review.",! G ENQ
 D EN^VALM("IB MT REVIEW PATIENT")
ENQ K IBSITE,IBSERV,IBFAC
 Q
 ;
HDR ; Build screen header.
 S VALMHDR(1)="Release Charges 'Pending Review'"
 S VALMHDR(2)=$J("",45)_"Date of     MT            Active"
 Q
 ;
INIT ; Build list.
 N DFN,IBAX,IBMTS,IBPT,IBN,IBDT
 S VALMBG=1,VALMCNT=0,VALMBCK="R"
 K ^TMP("IBAMTV3",$J)
 S DFN=0 F  S DFN=$O(^IB("AJ",DFN)) Q:'DFN  D
 .S IBPT=$$PT^IBEFUNC(DFN) Q:IBPT=""
 .S IBN=$O(^IB("AJ",DFN,0)) Q:'IBN
 .S IBDT=$P($G(^IB(IBN,0)),"^",14) Q:'IBDT
 .S VALMCNT=VALMCNT+1
 .S IBAX=$$SETSTR^VALM1($P(IBPT,"^"),VALMCNT,+$P(VALMDDF("PATIENT"),"^",2),+$P(VALMDDF("PATIENT"),"^",3))
 .S IBAX=$$SETSTR^VALM1($E(IBPT)_$P(IBPT,"^",3),IBAX,+$P(VALMDDF("PID"),"^",2),+$P(VALMDDF("PID"),"^",3))
 .S IBAX=$$SETSTR^VALM1($$DAT1^IBOUTL($P($$LST^DGMTU(DFN,IBDT),"^",2)),IBAX,+$P(VALMDDF("MT DATE"),"^",2),+$P(VALMDDF("MT DATE"),"^",3))
 .S IBMTS=$P($$LST^DGMTU(DFN),"^",4),IBMTS=$S(IBMTS="P":"PEN",IBMTS="G":"GMT",IBMTS="C":"YES",IBMTS="R":"REQ",1:"NO")
 .S IBAX=$$SETSTR^VALM1(IBMTS,IBAX,+$P(VALMDDF("MT STAT"),"^",2),+$P(VALMDDF("MT STAT"),"^",3))
 .S IBAX=$$SETSTR^VALM1($S($$INSURED^IBCNS1(DFN):"YES",1:" NO"),IBAX,+$P(VALMDDF("INS"),"^",2),+$P(VALMDDF("INS"),"^",3))
 .S ^TMP("IBAMTV3",$J,VALMCNT,0)=IBAX
 .S ^TMP("IBAMTV3",$J,"IDX",VALMCNT,VALMCNT)=DFN
 I '$D(^TMP("IBAMTV3",$J)) S ^TMP("IBAMTV3",$J,1,0)=" ",^TMP("IBAMTV3",$J,2,0)="  There are no patients with charges pending review.",VALMCNT=2 ; ,@VALMIDX@(1)=1,@VALMIDX@(2)=2
 Q
 ;
HELP ; Help code.
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; Exit action.
 K ^TMP("IBAMTV3",$J)
 D FULL^VALM1,CLEAN^VALM10
 Q
 ;
RELPR ; Release charges on hold at least 60 days old.
 K ^TMP($J,"IBHOLD") D NOW^%DTC S TDY=%
 S IBN=0 F  S IBN=$O(^IB("AC",21,IBN)) Q:'IBN  D
 .S DFN=+$P($G(^IB(IBN,0)),U,2),X2=+$P($G(^IB(IBN,1)),U,4) Q:'DFN!('X2)
 .S X1=TDY D ^%DTC Q:X<60  S ^TMP($J,"IBHOLD",DFN,IBN)=""
 ;
 I '$D(^TMP($J,"IBHOLD")) G RELQ
 S IBR60=1 D REL^IBOHRL ;                    Release charges
 S IBSTJB=$$DAT2^IBOUTL(TDY) D MAIL^IBOHRL ; Send bullletin
 ;
RELQ K DFN,IBDUZ,IBEND,IBN,IBDIFROM,IBNOS,IBNUM,IBRCOUNT,IBR60,IBSEQNO,IBSTJB
 K IBT,TDY,XMDUZ,XMGRP,XMSUB,XMTEXT,XMY,X,X1,X2,%,^TMP($J,"IBHOLD")
 Q
