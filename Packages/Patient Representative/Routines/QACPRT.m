QACPRT ;HISC/RS,CEW - This routine is a print of all contact data ;7/19/95  15:22
 ;;2.0;Patient Representative;;07/25/1995
 K DIR S DIR(0)="SO^C:Contact Number;D:Date Range;"
 S DIR("A")="Select records by"
 S DIR("?",1)="Enter 'C' to select records by contact number."
 S DIR("?",2)="Enter 'D' to select all records over a date range."
 S DIR("?")="Choose the method of record selection."
 W ! D ^DIR G:$D(DIRUT) EXIT S QACSELCT=Y
 I QACSELCT="C" D  G:QAQQUIT EXIT
 . S QAQDIC="^QA(745.1,",QAQDIC(0)="AEMNQZ"
 . S QAQDIC("A")="Select CONTACT NUMBER: "
 . S QAQUTIL="QACPRT" D ^QAQSELCT
 . Q
 I QACSELCT="D" D  G:QAQQUIT EXIT
 . D ^QAQDATE Q:QAQQUIT
 . S Y=$O(^QA(745.1,"D",(QAQNBEG-.0000001)))
 . I (Y'>0)!(Y\1>QAQNEND) D
 .. W !,"No records found within this date range.",$C(7)
 .. S QAQQUIT=1
 .. Q
 . Q
 K %ZIS,IOP S %ZIS="MNQ" W ! D ^%ZIS G:POP EXIT
 I $D(IO("Q")) K IO("Q") D  G EXIT
 . S ZTRTN="ENTSK^QACPRT",ZTDESC="Contact Inquiry"
 . S (ZTSAVE("QAQNBEG"),ZTSAVE("QAQNEND"),ZTSAVE("QACSELCT"))=""
 . S ZTSAVE("^UTILITY($J,")="" D ^%ZTLOAD
 . Q
ENTSK ;TASKED ENTRY POINT
 I $G(QACSELCT)="D" D
 . S QACDT=QAQNBEG-.0000001
 . F  S QACDT=$O(^QA(745.1,"D",QACDT)) Q:QACDT'>0!(QACDT\1>QAQNEND)  D
 .. S QACD0=0
 .. F  S QACD0=$O(^QA(745.1,"D",QACDT,QACD0)) Q:QACD0'>0  D
 ... S X=$P($G(^QA(745.1,QACD0,0)),U)
 ... I X]"" S ^UTILITY($J,"QACPRT",X,QACD0)=""
 ... Q
 .. Q
 . Q
 S QACQUIT=0,QACNUM="",QACIOST=IOST
 S QACIOP=ION_";"_IOST_";"_IOM_";"_IOSL
 S %X="^UTILITY($J,""QACPRT"",",%Y="^TMP($J,""QACPRT""," D %XY^%RCR
 F  S QACNUM=$O(^TMP($J,"QACPRT",QACNUM)) Q:QACNUM=""!QACQUIT  F QACD0=0:0 S QACD0=$O(^TMP($J,"QACPRT",QACNUM,QACD0)) Q:QACD0'>0!QACQUIT  D
 . S DIC="^QA(745.1,",BY="@NUMBER",(FR,TO)=QACD0,FLDS="[CAPTIONED]",L=0
 . S IOP=QACIOP S DIOBEG="S DIQ(0)=""C""" D EN1^DIP
 . S QACHK=$O(^TMP($J,"QACPRT",QACNUM))
 . I $E(QACIOST)="C",(QACHK]"") D
 .. K DIR S DIR(0)="E" D ^DIR
 .. S QACQUIT=$S(Y'>0:1,1:0)
 .. Q
 . Q
EXIT ;
 D ^%ZISC,HOME^%ZIS S:$D(ZTQUEUED) ZTREQ="@"
 K %ZIS,BY,DIC,DIR,FLDS,FR,P,POP,QACHK,QACD0,QACIOP,QACQUIT,QAQDIC
 K QAQQUIT,QACIOST,QACNUM,QAQUTIL,TO,Y,ZTDESC,ZTRTN,ZTSAVE,DA,L
 K ^TMP($J,"QACPRT"),^UTILITY($J,"QACPRT"),%X,%Y,DIOBEG,QACSELCT,QACDT
 D K^QAQDATE
 Q
