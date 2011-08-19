RCDPEAR ;ALB/TMK - ELECTRONIC ERA AGING REPORTS FROM NIGHTLY JOB ;04-NOV-02
 ;;4.5;Accounts Receivable;**173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
AGERPT ; Entry from nightly job to run the AR EDI Lockbox Aging reports
 ; Bulletin is not wanted if aging parameter does not have a value
 ;
 ; ERA Aging Report (summary only)
 I $P($G(^RC(342,1,7)),U,3)'="" D  ; Check for ERA Aging Parameter
 . K ^TMP($J,"RCERAAGE")
 . D RPTOUT^RCDPEAR1(+$P($G(^RC(342,1,7)),U,3),0,"RCERAAGE")
 . D BULL("EDI LBOX ERA UNMATCHED AGING REPORT FOR "_$$FMTE^XLFDT(DT,2),"RCERAAGE")
 . K ^TMP($J,"RCERAAGE")
 ;
 ; EFT Aging Report (summary only)
 I $P($G(^RC(342,1,7)),U,2)'="" D  ; Check for EFT Aging Parameter
 . K ^TMP($J,"RCEFTAGE")
 . D RPTOUT^RCDPEAR2(+$P($G(^RC(342,1,7)),U,2),0,"RCEFTAGE")
 . D BULL("EDI LBOX EFT UNMATCHED AGING REPORT FOR "_$$FMTE^XLFDT(DT,2),"RCEFTAGE")
 . K ^TMP($J,"RCEFTAGE")
 ;
 Q
 ;
BULL(RCSUBJ,RCSUB) ; Send bulletin for aging reports
 N XMBODY,XMB,XMINSTR,XMTYPE,XMFULL,XMTO,RCXM,XMZ,XMERR
 S XMTO("I:G.RCDPE PAYMENTS")=""
 S XMBODY="^TMP("_$J_","""_RCSUB_""")"
 D
 . N DUZ S DUZ=.5,DUZ(0)="@"
 . D SENDMSG^XMXAPI(.5,RCSUBJ,XMBODY,.XMTO,,.XMZ)
 Q
 ;
