LR140P ;DAL/HOAK - TEST REVIEWER;060697 0800 ;
 ;;5.2;LAB SERVICE;**140,171**;Sep 27, 1994
 ;Environment check is done only during the install.
 ;
INIT ;
 K ^TMP("LRBIGD")
 K DIR
 ;
CONTROL ;
 W !!,"I'M EXAMINING YOUR DATA NAMES"
 D LOOK
 W @IOF
 W !!,"Now, lets print a list of the BIG'ns.",!!
 D DEVICE
DONE ;
 ;K ^TMP("LRBIGD")
 K LRQ,LRIEN,LRCNT,OK,LRNODE
 Q
LOOK ;
 ;
 S LRCNT=0
 S LRQ="^DD(63.04,0)"
 F  S LRQ=$Q(@LRQ) Q:LRQ'["DD(63.04"  I @LRQ["K:$L(X)>" D
 .  I +$P(@LRQ,"K:$L(X)>",2)>50 S ^TMP("LRBIGD",LRQ)=@LRQ D
 ..  S LRCNT=LRCNT+1
 .  I IOST["C-" W "::"
 ;
 Q
ADVICE ;
 ;
 ;
 D LRGLIN^LRX
 W ?8,"Review the test set-up of the OFFENDING test(s) and consider"
 W !,?8,"one or more of the following recommendations:"
 W !,?5,"1. Reduce the length of the test name."
 W !,?5,"2. Reduce the length of the test result through the"
 W !,?5,"   [Modify an existing data name] option."
 W !,?5,"3. If the result is lengthy free text consider replacing the"
 W !,?5,"   old CH subscript test with a new test in a different"
 W !,?5,"   subscript area,...to SP for example.",!
 D LRGLIN^LRX
 Q
DEVICE ;
 S OK=1
 S %ZIS="Q"
QUE ;
 S ZTSAVE("LR*")=""
 S ZTRTN="DQ1^LR140P"
 S ZTDESC="Lab Patch 140 ^LR report"
 S ZTSAVE("^TMP(""LRBIGD""")=""
 D IO^LRWU
 QUIT
DQ1 ;
PRINT ;
 S LRPAGE=1
 S OK=1
 U IO
 D HEAD
 S LRIEN=""
 U IO
 F  S LRIEN=$O(^TMP("LRBIGD",LRIEN)) Q:LRIEN=""  S LRNODE=^(LRIEN) D
 .  D CHKPG
 .  W !,LRIEN,"=",LRNODE,!
 QUIT
HEAD ;
 W @IOF
 W $$RJ^XLFSTR("Page "_LRPAGE,IOM),!
 W $$CJ^XLFSTR("List of Data Names greater than 50 characters.",IOM),!
 D ADVICE
 QUIT
CHKPG ;
 Q:'OK
 I IOSL-$Y'>3&($E(IOST,1,2)="C-") S DIR(0)="E" D ^DIR K DIR D
 .  W @IOF
 .  I $D(DTOUT)!($D(DUOUT)) S OK=0
 Q:'OK
 I IOSL-$Y'>3&($E(IOST,1,2)="P-") S LRPAGE=LRPAGE+1 D HEAD
 ;
 QUIT
 Q
