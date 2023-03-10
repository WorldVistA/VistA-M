RCRPTLR ;EDE/YMG - REPAYMENT PLAN TERM LENGTH EXCEEDED REPORT; 11/23/2020
 ;;4.5;Accounts Receivable;**378**;Mar 20, 1995;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 N EXCEL,POP,SORT,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 K ^TMP("RCRPTLR",$J)
 W !!,"Repayment Plan Term Length Exceeded Report",!
 ; sort by?
 S SORT=$$ASKSORT() I SORT=-1 Q
 ; export to Excel?
 S EXCEL=$$ASKEXCEL^RCRPRPU() I EXCEL<0 Q
 I EXCEL D EXCMSG^RCTCSJR    ; Display Excel display message I EXCEL
 I 'EXCEL W !!,"This report requires 132 characters",!
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued report
 .S ZTDESC="Repayment Plan Term Length Exceeded Report",ZTRTN="COMPILE^RCRPTLR"
 .S ZTSAVE("EXCEL")="",ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! D PAUSE^RCRPRPU
 .Q
 D COMPILE
 ;
 Q
 ;
COMPILE ; compile report
 N CNT,DEBTOR,N0,NAME,RPIEN,RPPID,SSN,TEDT,Z
 S (CNT,TEDT)=0 F  S TEDT=$O(^RCRP(340.5,"C",TEDT)) Q:'TEDT  D
 .S RPIEN=0 F  S RPIEN=$O(^RCRP(340.5,"C",TEDT,RPIEN)) Q:'RPIEN  D
 ..S N0=^RCRP(340.5,RPIEN,0)              ; 0-node in file 340.5
 ..I "^6^7^8^"[(U_$P(N0,U,7)_U) Q         ; skip plans in Closed, Paid in Full, or Terminated status
 ..S DEBTOR=$P(N0,U,2)                    ; pointer to file 340
 ..S NAME=$$NAM^RCFN01(DEBTOR) Q:NAME=""  ; debtor name
 ..S SSN=$$SSN^RCFN01(DEBTOR) Q:SSN'>0    ; debtor SSN
 ..S RPPID=$P(N0,U)                       ; RPP ID
 ..; each entry is: ^TMP("RCRPTLR",$J,n) = RPP ID ^ name ^ ssn ^ term length (# of payments) ^ term limit exceeded date
 ..S CNT=CNT+1,^TMP("RCRPTLR",$J,CNT)=RPPID_U_NAME_U_SSN_U_$P(N0,U,5)_U_TEDT
 ..S Z=$S(SORT="N":NAME,SORT="S":SSN,1:RPPID) Q:Z=""
 ..S Z=" "_Z    ;Add space to force correct sort order
 ..S ^TMP("RCRPTLR",$J,"IDX",Z,CNT)=""
 ..Q
 .Q
 D PRINT
 K ^TMP("RCRPTLR",$J)
 Q
 ;
PRINT ; print report
 N CNT,DATA,EXTDT,LN,PAGE,Z
 U IO
 S PAGE=0
 S EXTDT=$$FMTE^XLFDT(DT)
 I EXCEL D
 .W !,"Repayment Plan Term Length Exceeded Report^",EXTDT
 .W !,"Name^SSN^RPP ID^Term Length^Term Limit Exceeded Date"
 .Q
 I 'EXCEL D
 .I $E(IOST,1,2)["C-",'$D(ZTQUEUED) W @IOF
 .D HDR
 .Q
 I '$D(^TMP("RCRPTLR",$J)) D  Q
 .I EXCEL W !!,"No records found." Q
 .W !!,$$CJ^XLFSTR("No records found.",80)
 .Q
 S Z="" F  S Z=$O(^TMP("RCRPTLR",$J,"IDX",Z)) Q:Z=""  D
 .S CNT=0 F  S CNT=$O(^TMP("RCRPTLR",$J,"IDX",Z,CNT)) Q:'CNT  D
 ..S DATA=^TMP("RCRPTLR",$J,CNT)
 ..I EXCEL W !,$P(DATA,U,2),U,$P(DATA,U,3),U,$P(DATA,U),U,$P(DATA,U,4),U,$$FMTE^XLFDT($P(DATA,U,5),"5DZ") Q
 ..S LN=LN+1
 ..W !,$E($P(DATA,U,2),1,26),?28,$P(DATA,U,3),?40,$P(DATA,U),?65,$P(DATA,U,4),?70,$$FMTE^XLFDT($P(DATA,U,5),"5DZ")
 ..I LN>(IOSL-3) D HDR
 ..Q
 .Q
 Q
 ;
HDR ; print header
 I PAGE>0,'$D(ZTQUEUED) D PAUSE^RCRPRPU
 W @IOF
 S PAGE=PAGE+1,LN=4
 W !,"Repayment Plan Term Length Exceeded Report",?50,EXTDT,?68,"Page: ",PAGE
 W !!,"                                                               Term   Term Limit"
 W !,"         Name                  SSN           RPP ID           Length   Exc. Date"
 W ! D DASH^RCRPRPU(80)
 Q
 ;
ASKSORT() ; display "sort by" prompt
 ;
 ; returns N for debtor name, S for status, A for account balance, -1 for user exit / timeout
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SA^N:Name;S:SSN;R:Repayment Plan ID",DIR("B")="N"
 S DIR("A")="Sort By (N)ame, (S)SN or (R)epayment Plan ID: "
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q Y
