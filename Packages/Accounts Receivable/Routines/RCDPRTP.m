RCDPRTP ;ALB/LDB-CLAIMS MATCHING REPORT ;1/11/01  2:03 PM
 ;;4.5;Accounts Receivable;**151,186**;Mar 20, 1995
 ;
 ;
EN N DATEEND,DATESTRT,DIC,DIR,DIRUT,POP,RCAN,RCBILL,RCDEBT,RCDFN,RCPT,RCSORT,RCQUIT,%ZIS,ZTDESC,ZTSAVE,ZTRTN,Y
 W !
 K DIRUT S DIR(0)="S^1:Patient;2:Bill Number;3:Payment dates;4:Receipt Number",DIR("A")="Sort by" D ^DIR K DIR Q:$D(DIRUT)
 S RCSORT=Y,RCQUIT=""
 D @RCSORT Q:RCQUIT  W !
 K DIRUT S DIR(0)="Y",DIR("A")="Include cancelled bills",DIR("B")="NO" D ^DIR S RCAN=+Y Q:$D(DIRUT)
 ;
 ;  select device
 W !!,"This report requires 132 columns.",!
 W ! S %ZIS="Q" D ^%ZIS I POP Q
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .S ZTDESC="Claims Matching Report",ZTRTN="DQ^RCDPRTP"
 .S ZTSAVE("RCSORT")=""
 .I RCSORT=1 S ZTSAVE("RCDEBT")="",ZTSAVE("RCDFN")="",ZTSAVE("DATE*")=""
 .I RCSORT=2 S ZTSAVE("RCBILL")="",ZTSAVE("RCDFN")="",ZTSAVE("RCDEBT")=""
 .I RCSORT=3 S ZTSAVE("DATE*")=""
 .I RCSORT=4 S ZTSAVE("RCPT")=""
 .S ZTSAVE("RCAN")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  queued report starts here
 U IO
 K ^TMP("RCDPRTPB",$J)
 K ^TMP("IBRBT",$J)
 K ^TMP("IBRBF",$J)
 N DAT,RCBIL,RCBIL0,RCNAM,RCPAY,RCPAY1,RCREC,RCREC1,RCRECTDA,RCSSN,RCTYP
 D @($S(RCSORT=1:"PAT",RCSORT=2:"BILL",RCSORT=3:"DATE",1:"REC")_"^RCDPRTP0")
 D EN^RCDPRTP1
 K DATESTRT,DATEEND,^TMP("RCDPRTPB",$J)
 D ^%ZISC
 Q
 ;
 ;
1 S DIC(0)="QEAMZ",DIC=340,DIC("S")="I ^RCD(340,+Y,0)[""DPT""",DIC("A")="Patient name: " D ^DIC I Y<0 S RCQUIT=1 Q
 S RCDEBT=+Y,RCDFN=+$P(Y,"^",2)
 D DATESEL^RCRJRTRA("Payment")
 I '$G(DATESTRT)!('$G(DATEEND)) S RCQUIT=1
 Q
 ;
3 D DATESEL^RCRJRTRA("Payment")
 I '$G(DATESTRT)!('$G(DATEEND)) S RCQUIT=1
 Q
 ;
2 N DIC,DUOUT
 K ^TMP("IBRBF",$J)
 S DIC(0)="QEAM",DIC=430,DIC("S")="I $P(^(0),U,2)=9" D ^DIC I Y<0 S RCQUIT=1 Q
 S RCBILL=+Y,RCDFN=$P($G(^PRCA(430,+RCBILL,0)),"^",7) Q:'RCDFN
 S RCDEBT=$O(^RCD(340,"B",RCDFN_";DPT(",0))
 I (RCDFN="")!(RCDEBT="") W !,"This bill has no matching first party bills." G 2
 D RELBILL^IBRFN(RCBILL)
 I '$O(^TMP("IBRBF",$J,RCBILL,0)) W !,"This bill has no matching first party debts." K ^TMP("IBRBF",$J) G 2
 K ^TMP("IBRBF",$J)
 Q
 ;
4 N DIC,X,Y
 S DIC(0)="QEAM",DIC=344 D ^DIC I Y<0 S RCQUIT=1 Q
 S RCPT=$P(Y,"^",2)
 Q
