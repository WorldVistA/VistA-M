RCDPEM1 ;ALB/TMK - ERA MATCH TO EFT (cont) ;05-NOV-02
 ;;4.5;Accounts Receivable;**173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
BULL(RCFILE,RC0,RCER) ; Add the error to the bulletin text array
 ; RCFILE = null, 344.3 or 344.31, depending on the file being worked
 ; RC0 = the 0-node of the RCFILE entry
 ; RCER = the error text to be placed in the bulletin (passed by ref)
 ;
 N RCHCT,CT,Z
 I '$O(^TMP($J,"RCXM",0)) S ^TMP($J,"RCXM",1)="The following exceptions were encountered attempting",^TMP($J,"RCXM",2)="to post EFT deposits OR to match EFT's with ERA's:",^TMP($J,"RCXM",3)=" "
 S (RCHCT,CT)=+$O(^TMP($J,"RCXM",""),-1)
 S ^TMP($J,"RCXM",0)=$G(^TMP($J,"RCXM",0))+1
 I RC0'="" D
 . D BLD("^TMP($J,""RCXM"")",.CT,RCFILE,RC0)
 . S RCER=$G(RCER)+1,RCHCT=RCHCT+1
 . S ^TMP($J,"RCXM",RCHCT)=$E(^TMP($J,"RCXM",0)_$J("",4),1,4)_$G(^TMP($J,"RCXM",RCHCT))
 S Z=1 F  S Z=$O(RCER(Z)) Q:'Z  S CT=CT+1,^TMP($J,"RCXM",CT)="  "_RCER(Z)
 S CT=CT+1,^TMP($J,"RCXM",CT)="  "
 Q
 ;
SENDBULL ; Sends the bulletin when all processing is complete
 N XMBODY,XMB,XMINSTR,XMTYPE,XMFULL,XMTO,XMZ,XMERR,XMSUBJ
 S XMTO("I:G.RCDPE PAYMENTS")=""
 S XMBODY="^TMP($J,""RCXM"")"
 S XMSUBJ="EDI LBOX "_$$FMTE^XLFDT(DT,2)_" EXCEPTIONS EFT DEP/MATCH EFTs TO ERAs"
 D  ;
 . N DUZ
 . S DUZ=.5,DUZ(0)="@"
 . D SENDMSG^XMXAPI(.5,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 K ^TMP($J,"RCXM")
 Q
 ;
BLD(RCARRAY,RCT,RCFILE,RC0) ; Build the array for entry 344.31 detail
 ; RCARRAY = the name of the array to be set
 ; RCT = the # of lines already output into this array
 ; RCFILE = 344.3 or 344.31
 ; RC0 = the 0-node of the entry in RCFILE
 ;
 N Z,RC00
 I RCFILE=344.31 D
 . S RC00=$G(^RCY(344.3,+RC0,0))
 . S Z=$$SETSTR^VALM1("  TRACE #: "_$P(RC0,U,4),"",1,31)
 . S Z=$$SETSTR^VALM1("  INS CO: "_$E($P(RC0,U,2),1,22)_"/"_$P(RC0,U,3),Z,32,43)
 . S RCT=RCT+1,@RCARRAY@(RCT)=Z
 . S Z=$$SETSTR^VALM1("  DEPOSIT DATE: "_$$FMTE^XLFDT($P(RC00,U,7),2),"",1,24)
 . S Z=$$SETSTR^VALM1("  DATE REC'D: "_$S($P(RC00,U,13):$$FMTE^XLFDT($P(RC00,U,13)\1,2),1:""),Z,25,22)
 . S Z=$$SETSTR^VALM1("  PAYMENT AMT: "_$TR($J($P(RC0,U,7),15,2)," "),Z,47,30)
 . S RCT=RCT+1,@RCARRAY@(RCT)=Z
 ;
 I RCFILE=344.3 D
 . S Z=$$SETSTR^VALM1("  DEPOSIT #: "_$P(RC0,U,6),"",1,13)
 . S Z=$$SETSTR^VALM1("  DEPOSIT DATE: "_$$FMTE^XLFDT($P(RC0,U,7),2),Z,16,24)
 . S RCT=RCT+1,@RCARRAY@(RCT)=Z
 . S Z=$$SETSTR^VALM1("  DATE REC'D: "_$S($P(RC0,U,13):$$FMTE^XLFDT($P(RC0,U,13)\1,2),1:""),"",25,22)
 . S Z=$$SETSTR^VALM1("  DEPOSIT AMT: "_$TR($J($P(RC0,U,8),15,2)," "),Z,47,30)
 . S RCT=RCT+1,@RCARRAY@(RCT)=Z
 ;
 Q
 ;
EN1 ; Queue match job for run on demand
 N DIR,X,Y,ZTIO,ZTRTN,ZTSK,ZTDESC,ZTDTH
 S DIR(0)="YA",DIR("A",1)="THIS OPTION QUEUES THE JOB TO MATCH EFTs TO ELECTRONIC ERAs"
 S DIR("A")="ARE YOU SURE YOU WANT TO RUN THIS JOB?: ",DIR("B")="NO"
 W ! D ^DIR K DIR
 I Y'=1 G EN1Q
 L +^RCY(344.3,"ALOCK"):5 I '$T D  G EN1Q
 . S DIR(0)="EA",DIR("A",1)="This job is currently running ... try again later",DIR("A")="Press ENTER to continue: " D ^DIR K DIR
 S ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTRTN="MATCH^RCDPEM(1,1)",ZTDESC="AR - MANUAL EFT-ERA MATCH EDI LOCKBOX"
 D ^%ZTLOAD
 W !!,$S($D(ZTSK):"Your job has been queued - task number "_ZTSK,1:"Unable to queue this job.")
 U IO
EN1Q L -^RCY(344.3,"ALOCK")
 Q
 ;
EN2 ; Entrypoint from nightly job to put Nightly and Daily Activity Report
 ; data into the nightly job's status bulletin
 N CT,DATA,Z,Z0,RCHD,T,T0
 S CT=+$O(^TMP($J,"RCXM",""),-1)
 S CT=CT+1,^TMP($J,"RCXM",CT)=""
 I $D(^TMP($J,"RCTOT","EFT_DEP")) D
 . S CT=CT+1,^TMP($J,"RCXM",CT)=$J("",12)_"********** TOTALS **********"
 . S CT=CT+1,^TMP($J,"RCXM",CT)="DEPOSITS"
 . S CT=CT+1,^TMP($J,"RCXM",CT)="  TOTAL # UNPOSTED EFT DEPOSITS FOUND: "_+$G(^TMP($J,"RCTOT","EFT_DEP"))
 . S CT=CT+1,^TMP($J,"RCXM",CT)="  TOTAL # NEW EFT DEPOSITS CREATED: "_+$G(^TMP($J,"RCTOT","DEPOSIT"))
 . S CT=CT+1,^TMP($J,"RCXM",CT)="  TOTAL # NEW EFT DEPOSIT RECEIPTS CREATED: "_+$G(^TMP($J,"RCTOT","EFT_RECPT"))
 . S CT=CT+1,^TMP($J,"RCXM",CT)="  TOTAL # EFT DEPOSITS WITH CHECK SUM ERRORS: "_+$G(^TMP($J,"RCTOT","CSUM"))
 . S CT=CT+1,^TMP($J,"RCXM",CT)="  TOTAL # EFT DEPOSITS WITH OTHER ERRORS: "_+$G(^TMP($J,"RCTOT","ERR"))
 . S CT=CT+1,^TMP($J,"RCXM",CT)="  TOTAL EFT DEPOSIT AMOUNT POSTED TO REV SRC CD 8NZZ: "_$J(+$G(^TMP($J,"RCTOT","SUSPAMT")),"",2)
 . S CT=CT+1,^TMP($J,"RCXM",CT)=""
 S CT=CT+1,^TMP($J,"RCXM",CT)="EFT-ERA MATCHES"
 S CT=CT+1,^TMP($J,"RCXM",CT)="  TOTAL # UNMATCHED ERAs CHECKED: "_+$G(^TMP($J,"RCTOT","EFT"))
 S CT=CT+1,^TMP($J,"RCXM",CT)="  TOTAL # ERAs MATCHED TO EFTs: "_+$G(^TMP($J,"RCTOT","MATCH"))_$S($G(^TMP($J,"RCTOT","MATCH"))&$G(^TMP($J,"RCTOT","TOTMIS")):" INCLUDING "_+$G(^TMP($J,"RCTOT","TOTMIS"))_" WITH MISMATCHED TOTALS",1:"")
 S CT=CT+1,^TMP($J,"RCXM",CT)="  TOTAL # ERAs STILL UNMATCHED: "_+$G(^TMP($J,"RCTOT","NO_MATCH"))
 S CT=CT+1,^TMP($J,"RCXM",CT)=""
 K ^TMP("RCDAILYACT",$J),^TMP($J,"RC1")
 ;
 S Z=0 F  S Z=$O(^TMP($J,"RCDPETOT",344.31,Z)) Q:'Z  S Z0=$G(^RCY(344.31,Z,0)) I Z0 S ^TMP($J,"RC1",+Z0,Z)=Z0
 ;
 S (RCHD,Z)=0 F  S Z=$O(^TMP($J,"RCDPETOT",344.3,Z)) Q:'Z  S DATA=$G(^(Z)) D
 . I 'RCHD D HDR(.CT,.RCHD) ; Add headers
 . S Z0=$G(^RCY(344.3,Z,0))
 . S CT=CT+1
 . S ^TMP($J,"RCXM",CT)=""
 . I '$G(DATA) D
 .. S CT=CT+1
 .. S ^TMP($J,"RCXM",CT)=^TMP($J,"RCXM",CT)_"  "_$E($P($G(^RCY(344.1,+$P(Z0,U,3),0)),U)_$J("",15),1,15)_"  "_$E($P($G(^RCY(344,+$O(^RCY(344,"AD",+$P(Z0,U,3),0)),0)),U)_$J("",15),1,15)_"  "
 .. S ^TMP($J,"RCXM",CT)=^TMP($J,"RCXM",CT)_$J(+$P(Z0,U,12),"",2)
 . I $G(DATA) D
 .. S ^TMP($J,"RCXM",CT)=^TMP($J,"RCXM",CT)_"  "_$E($P($G(^RCY(344.1,+$P(DATA,U,5),0)),U)_$J("",15),1,15)_"  "_$E($S($P(DATA,U,5):$P($G(^RCY(344,+DATA,0)),U),1:"")_$J("",15),1,15)_"  "
 .. S ^TMP($J,"RCXM",CT)=^TMP($J,"RCXM",CT)_$J($S($P(DATA,U,3):+$P(DATA,U,2),1:0),"",2)
 . I $P(DATA,U,4) S CT=CT+1,^TMP($J,"RCXM",CT)="    ERROR # REFERENCED ABOVE : "_$P(DATA,U,4)
 . S T=0 F  S T=$O(^TMP($J,"RC1",Z,T)) Q:'T  S T0=$G(^(T)) D
 .. S CT=CT+1
 .. S ^TMP($J,"RCXM",CT)=$J("",5)_$E($P(T0,U,4)_$J("",20),1,20)_"  "_$P(T0,U,2)_"/"_$P(T0,U,3)
 .. S CT=CT+1,^TMP($J,"RCXM",CT)=$J("",10)_"PAYMENT AMOUNT: "_$J(+$P(T0,U,7),"",2)_"  MATCH STATUS: "_$$EXTERNAL^DILFD(344.31,.08,,$P(T0,U,8))
 .. S:$O(^TMP($J,"RCDPETOT",344.3,Z)) CT=CT+1,^TMP($J,"RCXM",CT)=" "
 . I $P(DATA,U,3) S ^TMP("RCDAILYACT",$J,DT,Z)=Z0
 ;
 K ^TMP($J,"RC1")
 I $O(^TMP("RCDAILYACT",$J,0)) D  ; Daily activity rep automatic bulletin
 . N XMBODY,XMB,XMINSTR,XMTYPE,XMFULL,XMTO,XMZ,XMERR,XMSUBJ
 . K ^TMP($J,"RCDPE_DAR")
 . D RPT1^RCDPEDAR(1,0,DT,DT)
 . K ^TMP("RCDAILYACT",$J)
 . Q:'$O(^TMP($J,"RCDPE_DAR",0))
 . S XMTO("I:G.RCDPE PAYMENTS")=""
 . S XMBODY="^TMP($J,""RCDPE_DAR"")"
 . S XMSUBJ="EDI LBOX - AUTO DAILY ACTIVITY SUMMARY - "_$$FMTE^XLFDT(DT,2)
 . D  ;
 .. N DUZ
 .. S DUZ=.5,DUZ(0)="@"
 .. D SENDMSG^XMXAPI(.5,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 . K ^TMP($J,"RCDPE_DAR")
 Q
 ;
HDR(CT,HD) ; Header array set
 ; CT = line count, passed by reference
 ; HD = flag returned as 1 so the header is only output once
 N Q
 S CT=CT+1,^TMP($J,"RCXM",CT)=" "
 S CT=CT+1,^TMP($J,"RCXM",CT)=$J("",20)_"********** EFT DEPOSIT RECORDS **********"
 S CT=CT+1,^TMP($J,"RCXM",CT)="  EFT DEPOSIT      EFT RECEIPT      POSTED AMOUNT"
 S CT=CT+1,^TMP($J,"RCXM",CT)=" "
 S CT=CT+1,^TMP($J,"RCXM",CT)="     TRACE #               PAYER NAME/ID"
 S CT=CT+1,Q="",$P(Q,"=",79)="",^TMP($J,"RCXM",CT)=Q
 S HD=1
 Q
 ;
