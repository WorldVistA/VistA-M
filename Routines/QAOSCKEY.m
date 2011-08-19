QAOSCKEY ;HISC/DAD-ALLOCATE/DEALLOCATE CLINICAL REVIEWER KEY ;11/9/92  10:38
 ;;3.0;Occurrence Screen;;09/14/1993
 S QAOSCLIN(0)="QAOSCLIN",QAOSCLIN=+$O(^DIC(19.1,"B",QAOSCLIN(0),0))
 I $P($G(^DIC(19.1,QAOSCLIN,0)),"^")'=QAOSCLIN(0) D  G EXIT
 . W !!?5,"*** The Clinical Reviewer key was not found !! ***",*7
 . Q
 K ^TMP($J,"QAOSCLIN ADD"),^TMP($J,"QAOSCLIN DEL") S QAOCOUNT=0
 W !!,"Checking for current holders of the Clinical Reviewer key"
 F QAOSDUZ=0:0 S QAOSDUZ=$O(^XUSEC(QAOSCLIN(0),QAOSDUZ)) Q:QAOSDUZ'>0  D
 . W "." S X=$G(^VA(200,QAOSDUZ,0))
 . I $P(X,"^")]"" D
 .. S ^TMP($J,"QAOSCLIN ADD",$P(X,"^"),QAOSDUZ)=""
 .. S QAOCOUNT=QAOCOUNT+1
 .. Q
 . Q
 W !,QAOCOUNT," found.  " W:QAOCOUNT "Type a '?' to list their names."
ASK ;
 R !!,"Select CLINICAL REVIEWER: ",X:DTIME S:'$T X="^"
 G EXIT:$E(X)="^",OK:X=""
 S QADELETE=($E(X)="-"),X=$S(QADELETE:$E(X,2,999),1:X)
 I $E(X)="?" D HELP G ASK
 S DIC="^VA(200,",DIC(0)="EMNQZ" D ^DIC K DIC G:Y'>0 ASK
 S QAOSDUZ=+Y,QAOSDUZ(0)=$P(Y(0),"^")
 I QAOSDUZ(0)="" W " ??",*7 G ASK
 I QADELETE D
 . I $D(^TMP($J,"QAOSCLIN ADD",QAOSDUZ(0),QAOSDUZ))[0 W " ??",*7 Q
 . S ^TMP($J,"QAOSCLIN DEL",QAOSDUZ(0),QAOSDUZ)=""
 . K ^TMP($J,"QAOSCLIN ADD",QAOSDUZ(0),QAOSDUZ)
 . Q
 E  D
 . S ^TMP($J,"QAOSCLIN ADD",QAOSDUZ(0),QAOSDUZ)=""
 . K ^TMP($J,"QAOSCLIN DEL",QAOSDUZ(0),QAOSDUZ)
 . Q
 G ASK
OK ;
 I $O(^TMP($J,"QAOSCLIN ADD",""))="",$O(^TMP($J,"QAOSCLIN DEL",""))="" W !!?3,"*** No Clinical Reviewers selected !! ***",*7 G EXIT
ASKOK W !!,"Allocate / Deallocate Clinical Reviewer key"
 S %=2 D YN^DICN G:(%=-1)!(%=2) EXIT
 I '% W !!?5,"Please answer Y(es) or N(o)" G ASKOK
DOIT ; Entry point from postinit: convert file #741.3
 W !!,"Allocating key:"
 I $O(^TMP($J,"QAOSCLIN ADD",""))]"" D
 . S QAOSDUZ(0)=""
 . F  S QAOSDUZ(0)=$O(^TMP($J,"QAOSCLIN ADD",QAOSDUZ(0))) Q:QAOSDUZ(0)=""   F QAOSDUZ=0:0 S QAOSDUZ=$O(^TMP($J,"QAOSCLIN ADD",QAOSDUZ(0),QAOSDUZ)) Q:QAOSDUZ'>0  D
 .. K DD,DIC,DINUM,DO
 .. S:$D(^VA(200,QAOSDUZ,51,0))[0 ^(0)="^200.051PA^^"
 .. S DA(1)=QAOSDUZ,DIC="^VA(200,"_QAOSDUZ_",51,"
 .. S DIC(0)="LM",DLAYGO=200,(X,DINUM)=QAOSCLIN
 .. D:$O(^VA(200,QAOSDUZ,51,"B",QAOSCLIN,0))'>0 FILE^DICN
 .. W !?3,QAOSDUZ(0)
 .. Q
 . Q
 E  W !?3,"*** None ***"
 W !!,"Deallocating key:"
 I $O(^TMP($J,"QAOSCLIN DEL",""))]"" D
 . S QAOSDUZ(0)=""
 . F  S QAOSDUZ(0)=$O(^TMP($J,"QAOSCLIN DEL",QAOSDUZ(0))) Q:QAOSDUZ(0)=""   F QAOSDUZ=0:0 S QAOSDUZ=$O(^TMP($J,"QAOSCLIN DEL",QAOSDUZ(0),QAOSDUZ)) Q:QAOSDUZ'>0  D
 .. F QAOSD1=0:0 S QAOSD1=$O(^VA(200,QAOSDUZ,51,"B",QAOSCLIN,QAOSD1)) Q:QAOSD1'>0  D
 ... S DA(1)=QAOSDUZ,DA=QAOSD1,DIDEL=200
 ... S DIK="^VA(200,"_QAOSDUZ_",51,"
 ... D ^DIK
 ... Q
 .. W !?3,QAOSDUZ(0)
 .. Q
 . Q
 E  W !?3,"*** None ***"
EXIT ;
 K %,D,DA,DD,DIC,DIDEL,DIK,DINUM,DIR,DLAYGO,DO,DZ,QADELETE
 K QAOCOUNT,QAOSCLIN,QAOSD1,QAOSDUZ,QAOSLINE,QAOSLIST,X,Y
 K ^TMP($J,"QAOSCLIN ADD"),^TMP($J,"QAOSCLIN DEL")
 Q
HELP ;
 W !!," Enter the name of a Clinical Reviewer to add to the list."
 W !," Enter a minus (-) Clinical Reviewer name to remove a name"
 W " from the list."
 W !!,"Clinical Reviewers selected for key ALLOCATION:" D HLP("ADD")
 W !!,"Clinical Reviewers selected for key DEALLOCATION:" D HLP("DEL")
 Q:X'?1"??".E
 K DIR S DIR(0)="E" W ! D ^DIR K DIR Q:Y'>0
 S DIC="^VA(200,",DIC(0)="AEMNQ",D="B",DZ="??" D DQ^DICQ
 Q
HLP(QAOSLIST) ; DISPLAY CLINICAL REVIEWERS
 N DIR,QAOSLINE,QAOSDUZ,X,Y
 S QAOSLIST="QAOSCLIN "_QAOSLIST
 I $O(^TMP($J,QAOSLIST,""))]"" D
 . S QAOSLINE=$Y,Y=1,QAOSDUZ(0)=""
 . F  S QAOSDUZ(0)=$O(^TMP($J,QAOSLIST,QAOSDUZ(0))) Q:(QAOSDUZ(0)="")!(Y'>0)  F QAOSDUZ=0:0 S QAOSDUZ=$O(^TMP($J,QAOSLIST,QAOSDUZ(0),QAOSDUZ)) Q:(QAOSDUZ'>0)!(Y'>0)  D
 .. W !?3,QAOSDUZ(0)
 .. I $Y>(IOSL+QAOSLINE-3),(($O(^TMP($J,QAOSLIST,QAOSDUZ(0)))]"")!($O(^TMP($J,QAOSLIST,QAOSDUZ(0),QAOSDUZ)))) K DIR S DIR(0)="E",QAOSLINE=$Y D ^DIR K DIR
 .. Q
 . Q
 E  W !?3,"*** None ***"
 Q
