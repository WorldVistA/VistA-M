RCDPRTP  ;ALB/LDB-CLAIMS MATCHING REPORT ;1/11/01  2:03 PM
 ;;4.5;Accounts Receivable;**151,186,315,339,338**;Mar 20, 1995;Build 69
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;
 N DATEEND,DATESTRT,DIC,DIR,DIRUT,POP,RCBILL,RCDEBT,RCDFN,RCPT,RCSORT,RCQUIT,%ZIS,ZTDESC,ZTSAVE,ZTRTN,Y,RCAN,DIOEND,ZTIO,RCTYPE
 W !
 K DIRUT S DIR(0)="S^1:Patient;2:Bill Number;3:Payment dates;4:Receipt Number;5:Care Types",DIR("A")="Sort by" D ^DIR K DIR Q:$D(DIRUT)
 S RCSORT=Y,RCQUIT=""
 D @RCSORT Q:RCQUIT  W !
 K DIRUT S DIR(0)="Y",DIR("A")="Include cancelled bills",DIR("B")="NO" D ^DIR S RCAN=+Y Q:$D(DIRUT)
 ;
 ; if user wants Excel output, then call the device question for Excel and then quit
 I $$FORMAT^RCDPRTP0(.RCEXCEL) D DEVICE^RCDPRTP0 Q   ; exit point for Excel output
 Q:RCQUIT
 ;
 ; At this point, the user wants non-Excel output.  Ask device question for non-Excel output.
 W !!,"This report requires 132 columns.",!!
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .S ZTDESC="Claims Matching Report",ZTRTN="DQ^RCDPRTP"
 .S ZTSAVE("RCSORT")=""
 . I RCSORT=1 S ZTSAVE("RCDEBT")="",ZTSAVE("RCDFN")="",ZTSAVE("RCTYPE*")=""
 . I RCSORT=2 S ZTSAVE("RCBILL")="",ZTSAVE("RCDFN")="",ZTSAVE("RCDEBT")=""
 . I RCSORT=4 S ZTSAVE("RCPT")=""
 . I RCSORT=5 S ZTSAVE("RCTYPE*")=""
 . S ZTSAVE("RCAN")="",ZTSAVE("ZTREQ")="@",ZTSAVE("^TMP(""RCDPRTPB"",$J,")=""
 . S ZTSAVE("DATEEND")="",ZTSAVE("DATESTRT")="",ZTSAVE("RCQUIT")="",ZTSAVE("RCSORT")="",ZTSAVE("RCEXCEL")=""
 . S ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL
 . S DIOEND="K ^TMP(""RCDPRTPB"",$J)"
 .D ^%ZTLOAD,HOME^%ZIS K IO("Q") W !,"Task# ",ZTSK
 W !!,?20,"<*> please wait <*>"
DQ     ;  queued report starts here
 U IO
 K ^TMP("RCDPRTPB",$J),^TMP("IBRBT",$J),^TMP("IBRBF",$J)
 N DAT,RCBIL,RCBIL0,RCNAM,RCPAY,RCPAY1,RCREC,RCREC1,RCRECTDA,RCSSN,RCTYP
 D @($S(RCSORT=1:"PAT",RCSORT=2:"BILL",RCSORT=3:"DATE",RCSORT=4:"REC",RCSORT=5:"TYPE")_"^RCDPRTP0")
 Q:RCQUIT
 D EN^RCDPRTP1
 W !!,?20,"<End of report>",!
 K DATESTRT,DATEEND,^TMP("RCDPRTPB",$J),RCTYPE
 D ^%ZISC
 Q
 ;
1 ; 
 S DIC(0)="QEAMZ",DIC=340,DIC("S")="I ^RCD(340,+Y,0)[""DPT""",DIC("A")="Patient name: " D ^DIC I Y<0 S RCQUIT=1 Q
 S RCDEBT=+Y,RCDFN=+$P(Y,"^",2)
 D TYPEPIC^RCDPRTP0(.RCTYPE) I '$D(RCTYPE) S RCQUIT=1 Q
 D DATESEL^RCRJRTRA("Payment")
 I '$G(DATESTRT)!('$G(DATEEND)) S RCQUIT=1
 Q
 ;
3 ; 
 D DATESEL^RCRJRTRA("Payment")
 I '$G(DATESTRT)!('$G(DATEEND)) S RCQUIT=1
 Q
 ;
2 ; 
 N DIC,DUOUT
 K ^TMP("IBRBF",$J)
 S DIC(0)="QEAM",DIC=430,DIC("S")="I $$SCRNARCT^RCDPRTP($P(^(0),U,2))" D ^DIC I Y<0 S RCQUIT=1 Q
 S RCBILL=+Y,RCDFN=$P($G(^PRCA(430,+RCBILL,0)),"^",7) Q:'RCDFN
 S RCDEBT=$O(^RCD(340,"B",RCDFN_";DPT(",0))
 I (RCDFN="")!(RCDEBT="") W !,"This bill has no matching first party bills." G 2
 D RELBILL^IBRFN(RCBILL)
 I '$O(^TMP("IBRBF",$J,RCBILL,0)) W !,"This bill has no matching first party debts." K ^TMP("IBRBF",$J) G 2
 K ^TMP("IBRBF",$J)
 Q
 ;
4 ;  
 N DIC,X,Y
 S DIC(0)="QEAM",DIC=344 D ^DIC I Y<0 S RCQUIT=1 Q
 S RCPT=$P(Y,"^",2)
 Q
 ;
5 ; Select care type - added in patch 315
 D TYPEPIC^RCDPRTP0(.RCTYPE) I '$D(RCTYPE) S RCQUIT=1 Q
 Q:RCQUIT
 D DATESEL^RCRJRTRA("Payment")
 I '$G(DATESTRT)!('$G(DATEEND)) S RCQUIT=1
 Q
 ;
EXIT ;  
 K DATESTRT,DATEEND,RCEXCEL,^TMP("RCDPRTPB",$J),^TMP("IBRBT",$J)
 K ^TMP("IBRBT1",$J),^TMP("IBRBF",$J),^TMP("IBRBF1",$J),RCTYPE
 Q
 ;
 ;PRCA*4.5*338 - update AR Cat screen to include FEE and CC Reimb Ins Types
SCRNARCT(RCARCT) ;
 ;
 Q:RCARCT=9 1       ;Allow Reimb Insurance
 Q:RCARCT=45 1      ;Allow FEE Reimb Insurance
 I RCARCT>47,(RCARCT<52) Q 1    ;Allow CC Reimb Insurances
 Q 0                ;Disallow everything else
