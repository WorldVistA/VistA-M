LRGP2 ;SLC/CJS/RWF/DALOI/FHS-COMMON PARTS TO INSTRUMENT GROUP VERIFY/CHECK ;2/5/91  13:23
 ;;5.2;LAB SERVICE;**153,221,263,290**;Sep 27, 1994
 Q
 ;
 ;
EXPLODE ; from LRGP1, LRVR
 N %,C,DIC,DIR,DIRUT,DIROUT,DUOUT,LREND,LRI,LRTEST,LRX,I,X,Y
 I $G(LRORDR)'="P" K ^TMP("LR",$J)
 S LRCFL="",LRI=0 S:'$D(LRNX) LRNX=0
 F  S LRI=$O(^LRO(68.2,LRLL,10,LRPROF,1,LRI)) Q:LRI<1  I $D(^(LRI,0))#2 D
 . S LRI(0)=$G(^LRO(68.2,LRLL,10,LRPROF,1,LRI,0))
 . S LRX=$P(LRI(0),"^") K LRTEST
 . I '$P(LRI(0),U,3) D EX6(LRX)
 . S:'$D(^TMP("LR",$J,"VTO",LRX))#2 ^(LRX)=""
 K LRVTS S LRVTS=11,LRI=0 D
 . F  S LRI=+$O(^TMP("LR",$J,"T",LRI)) Q:LRI<1  S X=^(LRI) D
 . . S LRVTS($P(X,";",2))=LRI,LRVTS=LRVTS+1
 . . S ^TMP("LR",$J,"VTO",LRI)=$P(X,";",2)
 Q:$G(LRORDR)="P"
EX3 ;
 G:$G(LREND) STOP
 ;
 K DIR,DIRUT,DIROUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("A")="Would you like to see the test list",DIR("B")="No"
 D ^DIR
 I $S($G(DIRUT):1,$G(LREND):1,1:0) K ^TMP("LR",$J),LRVTS Q
 I Y=1 D
 . W @IOF,!,"The ("_$P(^LRO(68.2,LRLL,0),U)_") ["_$P(^LRO(68.2,LRLL,10,LRPROF,0),U)_"] Profile has"
 . D LIST
 ;
 K DIR
 S DIR("A",1)=" "
 S DIR("A")="Do you wish to modify the test list"
 S DIR("?")="i.e. would you like to add or subtract ATOMIC tests?"
 S DIR("B")="NO"
 S DIR(0)="Y" D ^DIR
 I $D(DIRUT) S LREND=1 G STOP
 I Y=1 D EX1 G:'$G(LREND) EX3
STOP I $G(LREND) K ^TMP("LR",$J),LRVTS S LREND=0 Q
EX2 ;
 K LRVTS,DIC
 S LRVTS=11,LRI=0,C=0
 F  S LRI=$O(^TMP("LR",$J,"T",LRI)) Q:LRI<1  D
 . S X=^TMP("LR",$J,"T",LRI),LRVTS($P(X,";",2))=LRI
 . S LRVTS=LRVTS+1
 . S ^TMP("LR",$J,"VTO",LRI)=$P(X,";",2)
 . S C=C+1
 . I $P($G(^LAB(60,LRI,4)),U,2) S LRCFL=LRCFL_$P(^(4),U,2)_U
 S (X,X1)=0 F  S X=$O(^TMP("LR",$J,"VTO",X)) Q:X<1  S X1=X1+1
 I C>0 W !,"You have selected ",X1," tests to work with."
 I C<1 D
 . W !,$C(7),">> Please check the PROFILE you have selected."
 . W !,">> At least one should be build name only = no "
 K ^TMP("LR",$J,"T")
 Q
 ;
EX1 ;
 K DIR
 S DIR("A")="Do you want to add ATOMIC test(s) to this panel",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 I Y=1 D
 . K LRVTS,DIC
 . S DIC("A")="Select ATOMIC test(s) you wish to add: ",DIC="^LAB(60,",DIC(0)="AEMOQZ" ; ,DIC("S")="I $G(^(.2))"
 . F  D ^DIC Q:Y<1  K LRTEST D EX6(+Y)
 . W @IOF,!?5,"The List now has" D LIST
EX4 ;
 K DIR
 S DIR("A",1)=" "
 S DIR("A")="Do you wish to exclude ATOMIC tests in this panel"
 S DIR("B")="NO",DIR(0)="YO"
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 I Y=1 D
 . N LREXCL,%
 . W !!,$$CJ^XLFSTR("Tests removed from this panel will not be included for review or editing.",IOM),!!
 . K DIC
 . S LREXCL="",DIC("A")="Select ATOMIC test(s) you wish to exclude: ",DIC="^LAB(60,",DIC(0)="AEMOQ"
 . S DIC("S")="I $D(^TMP(""LR"",$J,""T"",Y))"
 . F  D ^DIC Q:Y<1  D
 . . S X1=$P(^TMP("LR",$J,"T",+Y),";",2)
 . . I X1 K LRVTS(X1)
 . . K ^TMP("LR",$J,"VTO",+Y),^TMP("LR",$J,"T",+Y) S LREXCL(+Y)=$P(Y,U,2) D
 . . .N I,X
 . . .S I=0 F  S I=$O(^LAB(60,+Y,2,0)) Q:I<1  I $D(^(I,0)) S X=+^(0) D
 . . . . I X K ^TMP("LR",$J,"VTO",X),^TMP("LR",$J,"T",X) S LREXCL(X)=$P($G(^LAB(60,X,0)),U)
 . I $O(LREXCL(0)) D
 . . N I
 . . W @IOF,!,"Excluding" S I=0 F  S I=$O(LREXCL(I)) Q:I<1  W !,LREXCL(I) K LRVTS(I) H 2
 Q
 ;
LIST ;
 N LRI,DIR,DUOUT,X
 W " the following tests: "
 S LRI=0,DIR(0)="E"
 F  S LRI=$O(^TMP("LR",$J,"VTO",LRI)) Q:LRI<1!($D(DUOUT))  D
 . W !,?10,$P($G(^LAB(60,LRI,0)),U)
 . I $Y>(IOSL-4) W ! D ^DIR W @IOF I $D(DIRUT) S LREND=1
 Q
 ;
 ;
YESNO ;
 W !
 N DIR
 S DIR("B")=$S($G(%)=1:"Yes",$G(%)=2:"No",1:"")
 S DIR(0)="Y" D ^DIR S %=Y
 Q
 ;
 ;
EX6(LRX) ;Expand test list
 S (T1,LRTEST)=LRX,LRTEST(T1)=LRX_U_$G(^LAB(60,T1,0))
 S LRTEST(T1,"P")=LRTEST
 D ^LREXPD
 S:'$D(^TMP("LR",$J,"VTO",LRX))#2 ^(LRX)=""
 Q
