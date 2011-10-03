GMPLBLD3 ; SLC/MKB -- Bld PL Selection Lists cont ;3/12/03 13:40
 ;;2.0;Problem List;**28**;Aug 25, 1994
 ;
 ; This routine invokes IA #3991
 ;
ASSIGN ; Assign list to clinic, users: Expects GMPLSLST
 N DIE,DA,DR D FULL^VALM1 G:+$G(GMPLSLST)'>0 ASQ
 I '$$VALLIST^GMPLBLD2(+GMPLSLST) D  G ASQ
 . W !!,$C(7),"This Selection List contains problems with inactive ICD9 codes associated with"
 . W !,"them. The codes must be edited and corrected before the list can be assigned",!,"to users or clinics."
 . W !!,"If you have edited the list during this session to correct inactive codes, "
 . W !,"save the list prior to attempting to assign it."
 . N DIR,DUOUT,DTOUT,DIRUT
 . S DIR(0)="E" D ^DIR
 . Q
 ;
 W !!,"You may assign this list to a clinic as its default selection list,"
 W !,"as well as to individual users as a preferred selection list.",!
 S DA=+GMPLSLST,DR=.03,DIE="^GMPL(125," D ^DIE Q:$D(DTOUT)!($D(DUOUT))
 D USERS("1") ; assign
ASQ S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
 ;
USERS(ADD) ; -- select user(s) to de-/assign list
 N DIR,DIC,DIE,DR,DA,X,Y,GMPLUSER,GMPLI
 Q:+$G(GMPLSLST)'>0  S GMPLUSER=""
 S DIC="^VA(200,",DIC(0)="EQM",DIC("A")="Select USER: "
 F  D READ Q:+Y'>0  S GMPLUSER=GMPLUSER_U_+Y,DIC("A")="ANOTHER ONE: "
 I '$L(GMPLUSER) W !!,"No users selected.",! Q
 S DIR(0)="YA",DIR("A")="Are you ready? ",DIR("B")="NO"
 S DIR("?",1)="Enter YES to "_$S(ADD:"assign",1:"remove")_" the "_$P(GMPLSLST,U,2)_" list "_$S(ADD:"to the",1:"from the")
 S DIR("?")=($L(GMPLUSER,U)-1)_" user(s) selected; enter NO to exit."
 D ^DIR Q:'Y
USR W !,$S(ADD:"Assigning ",1:"Removing ")_$P(GMPLSLST,U,2)_" list ..."
 S DIE="^VA(200,",DR="125.1///"_$S(ADD:"/"_(+GMPLSLST),1:"@")
 F GMPLI=1:1:$L(GMPLUSER,U) S DA=$P(GMPLUSER,U,GMPLI) I DA D
 . W !?4,$P($G(^VA(200,DA,0)),U) D ^DIE
 W !!,"DONE."
 Q
 ;
READ ; prompt for username, respond
 W !,DIC("A") R X:DTIME I '$T!("^"[X) S Y=-1 Q
 I X="?" W !!,"Enter the name of the user you wish this list to be "_$S(ADD:"assigned to;",1:"removed from;"),!,"enter '??' to see users currently assigned this list, or '???' to see",!,"all users on this system.",! G READ
 I X?1"??".E D  G READ
 . I X="??" S DIC("S")="I $P($G(^(125)),U,2)="_+GMPLSLST W !!,"Users currently assigned "_$P(GMPLSLST,U,2)_" list:"
 . S D="B",DZ="??" D DQ^DICQ K D,DZ,DIC("S")
 D ^DIC G:Y'>0 READ
 Q
 ;
DELETE ; Delete Selection List
 N DIR,DIK,DA,X,Y,VIEW,USER,GMPCOUNT,GMPQUIT,GMPLSLST
 S GMPCOUNT=0,GMPLSLST=$$LIST^GMPLBLD2("") Q:GMPLSLST="^"
 W !!,"Checking the New Person file for use of this list ..."
 F USER=0:0 S USER=$O(^VA(200,USER)) Q:USER'>0  D
 . S VIEW=$P($G(^VA(200,USER,125)),U,2) Q:'VIEW  Q:VIEW'=+GMPLSLST
 . S GMPCOUNT=GMPCOUNT+1 W "."
 I GMPCOUNT W $C(7),!!,GMPCOUNT_" user(s) are currently assigned this list!",!,"CANNOT DELETE",! Q
 W !,"0 users found."
DEL1 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you want to delete this list"
 S DIR("?",1)="Enter YES if you wish to completely remove this list; press <return>",DIR("?")="to leave this list unchanged and exit this option."
 W $C(7),! D ^DIR Q:'Y
 W !!,"Deleting "_$P(GMPLSLST,U,2)_" selection list ..."
 S DIK="^GMPL(125.1,",DA=0 ; list contents
 F  S DA=$O(^GMPL(125.1,"B",+GMPLSLST,DA)) Q:DA'>0  D ^DIK W "."
 S DA=+GMPLSLST,DIK="^GMPL(125," D ^DIK W "." ; list
 W !,"DONE.",!
 Q
 ;
MENU ; -- init variables and list array for GMPL LIST MENU list template
 ;    Expects GMPLSLST=selection list
 N GSEQ,PSEQ,GCNT,PCNT,GROUP,HDR,IFN,LCNT,ITEM,TEXT,CODE
 S (GSEQ,GCNT,LCNT)=0 K ^TMP("GMPLMENU",$J)
 W !!,"Retrieving list of "_$P(GMPLSLST,U,2)_" problems ..."
 F  S GSEQ=$O(^GMPL(125.1,"C",+GMPLSLST,GSEQ)) Q:GSEQ'>0  D
 . S IFN=$O(^GMPL(125.1,"C",+GMPLSLST,GSEQ,0)) Q:IFN'>0
 . S ITEM=$G(^GMPL(125.1,IFN,0)),GROUP=$P(ITEM,U,3),HDR=$P(ITEM,U,4,5)
 . S GCNT=GCNT+1,(PSEQ,PCNT)=0,^TMP("GMPLMENU",$J,GCNT,0)=HDR
 . F  S PSEQ=$O(^GMPL(125.12,"C",+GROUP,PSEQ)) Q:PSEQ'>0  D
 . . S IFN=$O(^GMPL(125.12,"C",+GROUP,PSEQ,0)) Q:IFN'>0
 . . S ITEM=$G(^GMPL(125.12,IFN,0)),TEXT=$P(ITEM,U,4),CODE=$P(ITEM,U,5)
 . . I $L(CODE),'$$STATCHK^ICDAPIU(CODE,DT) Q  ; screen inactive codes
 . . S PCNT=PCNT+1,^TMP("GMPLMENU",$J,GCNT,PCNT)=$P(ITEM,U,3,5)
 I '$D(^TMP("GMPLMENU",$J)) W !!,"No items available.  Returning to Problem List ..." H 2 S VALMBCK="Q",VALMQUIT=1 Q
 D BUILD^GMPLMENU
 Q
