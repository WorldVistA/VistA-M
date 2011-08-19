QAOSPRD0 ;HISC/DAD-INTER-REVIEWER RELIABILITY ASSESSMENT REPORT ;4/30/93  09:25
 ;;3.0;Occurrence Screen;;09/14/1993
 ;
 ; ^TMP($J , "QAOSPRD0" , ["N","L","1"] , ["CLIN","PEER"]) =
 ;         Total_records ^ Records_selected
 ;
 ; ^TMP($J , "QAOSPRD0" , ["N","L","1"] , ["CLIN","PEER"] , SEQUENCE#) =
 ;         IEN_in_file_#741 ^ $S(Selected:"*",1:"")
 ;
EN ; *** Select the date range
 W !!,"Select the date range that the occurrences will be chosen from."
 D ^QAQDATE G:QAQQUIT EXIT
 ; *** Select the screens to include
 K DIR S DIR(0)="LO^1:3^K:X[""."" X",DIR("A")="Select screens to include"
 S DIR("?",1)="Choose from:",DIR("?",2)="  1  National screens"
 S DIR("?",3)="  2  Local screens",DIR("?",4)="  3  Inactive screens"
 S DIR("?")="Choose any combination of the above, e.g., 1, 1-3, etc."
 S DIR("B")=1 D ^DIR G:$D(DIRUT) EXIT S QAOSTYPE="^"_$TR(Y,"123,","NL1^")
 ; *** Select the total number of records to capture
 K DIR S DIR(0)="NOA^1:999:0"
 S DIR("A")="Select number of occurrences to capture: ",DIR("B")=30
 S DIR("?",1)="Enter the number of occurrences to be printed out"
 S DIR("?")="for the inter-reviewer reliability assessment study."
 W ! D ^DIR G:$D(DIRUT) EXIT S QAOSNUM=Y
BLANK ; *** Print blank worksheet
 W !!,"Include blank worksheets" S %=2 D YN^DICN G:%=-1 EXIT
 S QAOBLANK=$S(%=1:1,1:0) I '% D  G BLANK
 . W !!,"Answer Y(es) to print blank worksheets in addition to the"
 . W !,"worksheets that are printed with data from the previous"
 . W !,"reviews.  Answer N(o) to skip printing of blank worksheets."
 . Q
DEV ; *** Select output device, force queueing
 K %ZIS S %ZIS="QM",%ZIS("B")="",IOP="Q" W !! D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . K IO("Q")
 . S ZTRTN="ENTSK^QAOSPRD0"
 . S ZTSAVE("QAQ*")="",ZTSAVE("QAO*")=""
 . S ZTDESC="Inter-reviewer reliability assessment report"
 . D ^%ZTLOAD
 . Q
 E  D  G DEV
 . D ^%ZISC
 . W !?5,"This is a very long and time consuming"
 . W !?5,"report, it must be queued to print.",*7
 . Q
ENTSK ; *** Tasked entry point
 K ^TMP($J,"QAOSPRD0")
 S QAOSCLIN=+$O(^QA(741.2,"C",1,0)),QAOSPEER=+$O(^QA(741.2,"C",2,0))
 S QAOSEXCP=+$O(^QA(741.6,"B",3,0)),QAOSDATE=QAQNBEG-.0000001
 ; *** Select all records that meet the user's specifications
 F  S QAOSDATE=$O(^QA(741,"C",QAOSDATE)) Q:(QAOSDATE'>0)!(QAOSDATE>(QAQNEND+.9999999))  F QAOSD0=0:0 S QAOSD0=$O(^QA(741,"C",QAOSDATE,QAOSD0)) Q:QAOSD0'>0  D
 . S QAOSZERO=$G(^QA(741,QAOSD0,0)) Q:QAOSZERO=""!($P(QAOSZERO,"^",11)=2)
 . S QAOSSCRN=$G(^QA(741,QAOSD0,"SCRN")) Q:QAOSSCRN=""
 . S QAOSTYPE(0)=$P($G(^QA(741.1,+QAOSSCRN,0)),"^",4)
 . Q:QAOSTYPE'[("^"_QAOSTYPE(0)_"^")
 . S QAOSCD1=+$O(^QA(741,QAOSD0,"REVR","B",QAOSCLIN,0))
 . Q:$P($G(^QA(741,QAOSD0,"REVR",QAOSCD1,0)),"^",5)=QAOSEXCP
 . S QAOSPD1=+$O(^QA(741,QAOSD0,"REVR","B",QAOSPEER,0))
 . D SET("CLIN"):QAOSCD1,SET("PEER"):QAOSPD1
 . Q
 ; *** Randomly select the the specified number of records
 F QAOSTYP=2:1:$L(QAOSTYPE,"^")-1 F QAOSREVR="CLIN","PEER" D
 . S QAOSTYPE(0)=$P(QAOSTYPE,"^",QAOSTYP)
 . S QAOSTOT=+$G(^TMP($J,"QAOSPRD0",QAOSTYPE(0),QAOSREVR)) Q:QAOSTOT'>0
 . F QAOSSEQ=$S(QAOSTOT>QAOSNUM:QAOSNUM,1:QAOSTOT):-1:1 D
 .. F  S QAOSRAND=$S(QAOSTOT>QAOSNUM:$R(QAOSTOT)+1,1:QAOSSEQ),X=$G(^TMP($J,"QAOSPRD0",QAOSTYPE(0),QAOSREVR,QAOSRAND)) I X,$P(X,"^",2)="" D  Q
 ... S $P(^TMP($J,"QAOSPRD0",QAOSTYPE(0),QAOSREVR,QAOSRAND),"^",2)="*"
 ... S X=1+$P($G(^TMP($J,"QAOSPRD0",QAOSTYPE(0),QAOSREVR)),"^",2)
 ... S $P(^TMP($J,"QAOSPRD0",QAOSTYPE(0),QAOSREVR),"^",2)=X
 ... Q
 .. Q
 . Q
PRINT ;
 U IO D ^QAOSPRD1
EXIT ;
 D ^%ZISC
 K %,%ZIS,DIR,DIRUT,IOP,POP,QAOBLANK,QAOSCD1,QAOSCLIN,QAOSCNUM,QAOSD0
 K QAOSDATA,QAOSDATE,QAOSEXCP,QAOSHOW,QAOSNUM,QAOSPD1,QAOSPEER,QAOSPNUM
 K QAOSRAND,QAOSREVR,QAOSSCRN,QAOSSEQ,QAOSTOT,QAOSTYP,QAOSTYPE,QAOSZERO
 K QAOTODAY,X,Y,ZTDESC,ZTRTN,ZTSAVE,^TMP($J,"QAOSPRD0")
 D K^QAQDATE S:$D(ZTQUEUED) ZTREQ="@"
 Q
SET(REVIEWER) ; *** Accumulate and count reviews
 N X S X=1+$G(^TMP($J,"QAOSPRD0",QAOSTYPE(0),REVIEWER))
 S ^TMP($J,"QAOSPRD0",QAOSTYPE(0),REVIEWER)=X
 S ^TMP($J,"QAOSPRD0",QAOSTYPE(0),REVIEWER,X)=QAOSD0
 Q
