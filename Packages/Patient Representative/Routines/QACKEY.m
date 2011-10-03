QACKEY ;HISC/DAD,CEW - Allocate/Deallocate Patient Representative key ;2/10/95  09:42
 ;;2.0;Patient Representative;;07/25/1995
 K DIC S DIC="^DIC(19.1,",DIC(0)="AEMNQZ"
 S DIC("S")="I $E($P(^(0),U,1),1,3)=""QAC"""
 S DIC("A")="Select the key you want to allocate/deallocate: "
 S DIC("W")="W ""    "",$P(^(0),U,2)"
 D ^DIC K DIC G:Y'>0 EXIT S QACKEY(0)=$P(Y,U,2),QACKEY=+Y
 S QACKEY(1)=$P(Y(0),U,2)
 K ^TMP($J,"QACKEY ADD"),^TMP($J,"QACKEY DEL") S QACCOUNT=0
 W !!,"Checking for current holders of the ",QACKEY(1)
 F QACDUZ=0:0 S QACDUZ=$O(^XUSEC(QACKEY(0),QACDUZ)) Q:QACDUZ'>0  D
 . W "." S X=$G(^VA(200,QACDUZ,0))
 . I $P(X,"^")]"" D
 .. S ^TMP($J,"QACKEY ADD",$P(X,"^"),QACDUZ)=""
 .. S QACCOUNT=QACCOUNT+1
 .. Q
 . Q
 W !,QACCOUNT," found.  " W:QACCOUNT "Type a '?' to list their names."
ASK ;
 R !!,"Select PATIENT REPRESENTATIVE: ",X:DTIME S:'$T X="^"
 G EXIT:$E(X)="^",OK:X=""
 S QADELETE=($E(X)="-"),X=$S(QADELETE:$E(X,2,999),1:X)
 I $E(X)="?" D HELP G ASK
 S DIC="^VA(200,",DIC(0)="EMNQZ" D ^DIC K DIC G:Y'>0 ASK
 S QACDUZ=+Y,QACDUZ(0)=$P(Y(0),"^")
 I QACDUZ(0)="" W " ??",*7 G ASK
 I QADELETE D
 . I $D(^TMP($J,"QACKEY ADD",QACDUZ(0),QACDUZ))[0 W " ??",*7 Q
 . S ^TMP($J,"QACKEY DEL",QACDUZ(0),QACDUZ)=""
 . K ^TMP($J,"QACKEY ADD",QACDUZ(0),QACDUZ)
 . Q
 E  D
 . S ^TMP($J,"QACKEY ADD",QACDUZ(0),QACDUZ)=""
 . K ^TMP($J,"QACKEY DEL",QACDUZ(0),QACDUZ)
 . Q
 G ASK
OK ;
 I $O(^TMP($J,"QACKEY ADD",""))="",$O(^TMP($J,"QACKEY DEL",""))="" W !!?3,"*** No Patient Reps. selected !! ***",*7 G EXIT
ASKOK W !!,"Allocate / Deallocate ",QACKEY(1)
 S %=2 D YN^DICN G:(%=-1)!(%=2) EXIT
 I '% W !!?5,"Please answer Y(es) or N(o)" G ASKOK
DOIT ;
 W !!,"Allocating key:"
 I $O(^TMP($J,"QACKEY ADD",""))]"" D
 . S QACDUZ(0)=""
 . F  S QACDUZ(0)=$O(^TMP($J,"QACKEY ADD",QACDUZ(0))) Q:QACDUZ(0)=""   F QACDUZ=0:0 S QACDUZ=$O(^TMP($J,"QACKEY ADD",QACDUZ(0),QACDUZ)) Q:QACDUZ'>0  D
 .. K DD,DIC,DINUM,DO
 .. S:$D(^VA(200,QACDUZ,51,0))[0 ^(0)="^200.051PA^^"
 .. S DA(1)=QACDUZ,DIC="^VA(200,"_QACDUZ_",51,"
 .. S DIC(0)="LM",DLAYGO=200,(X,DINUM)=QACKEY
 .. D:$O(^VA(200,QACDUZ,51,"B",QACKEY,0))'>0 FILE^DICN
 .. W !?3,QACDUZ(0)
 .. Q
 . Q
 E  W !?3,"*** None ***"
 W !!,"Deallocating key:"
 I $O(^TMP($J,"QACKEY DEL",""))]"" D
 . S QACDUZ(0)=""
 . F  S QACDUZ(0)=$O(^TMP($J,"QACKEY DEL",QACDUZ(0))) Q:QACDUZ(0)=""   F QACDUZ=0:0 S QACDUZ=$O(^TMP($J,"QACKEY DEL",QACDUZ(0),QACDUZ)) Q:QACDUZ'>0  D
 .. F QACSD1=0:0 S QACSD1=$O(^VA(200,QACDUZ,51,"B",QACKEY,QACSD1)) Q:QACSD1'>0  D
 ... S DA(1)=QACDUZ,DA=QACSD1,DIDEL=200
 ... S DIK="^VA(200,"_QACDUZ_",51,"
 ... D ^DIK
 ... Q
 .. W !?3,QACDUZ(0)
 .. Q
 . Q
 E  W !?3,"*** None ***"
EXIT ;
 K %,D,DA,DD,DIC,DIDEL,DIK,DINUM,DIR,DLAYGO,DO,DZ,QADELETE
 K QACCOUNT,QACKEY,QACSD1,QACDUZ,QACLINE,QACLIST,X,Y
 K ^TMP($J,"QACKEY ADD"),^TMP($J,"QACKEY DEL")
 Q
HELP ;
 W !!," Enter the name of a Patient Representative to add to the list."
 W !," Enter a minus (-) Patient Representative name to remove a name"
 W " from the list."
 W !!,"Patient Reps. selected for key ALLOCATION:" D HLP("ADD")
 W !!,"Patient Reps. selected for key DEALLOCATION:" D HLP("DEL")
 Q:X'?1"??".E
 K DIR S DIR(0)="E" W ! D ^DIR K DIR Q:Y'>0
 S DIC="^VA(200,",DIC(0)="AEMNQ",D="B",DZ="??" D DQ^DICQ
 Q
HLP(QACLIST) ; Display Patient Representatives
 N DIR,QACLINE,QACDUZ,X,Y
 S QACLIST="QACKEY "_QACLIST
 I $O(^TMP($J,QACLIST,""))]"" D
 . S QACLINE=$Y,Y=1,QACDUZ(0)=""
 . F  S QACDUZ(0)=$O(^TMP($J,QACLIST,QACDUZ(0))) Q:(QACDUZ(0)="")!(Y'>0)  F QACDUZ=0:0 S QACDUZ=$O(^TMP($J,QACLIST,QACDUZ(0),QACDUZ)) Q:(QACDUZ'>0)!(Y'>0)  D
 .. W !?3,QACDUZ(0)
 .. I $Y>(IOSL+QACLINE-3),(($O(^TMP($J,QACLIST,QACDUZ(0)))]"")!($O(^TMP($J,QACLIST,QACDUZ(0),QACDUZ)))) K DIR S DIR(0)="E",QACLINE=$Y D ^DIR K DIR
 .. Q
 . Q
 E  W !?3,"*** None ***"
 Q
