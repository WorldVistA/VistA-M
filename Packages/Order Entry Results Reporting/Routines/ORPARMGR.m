ORPARMGR ; SPFO/AJB - ListManager Parameter Display for Notifications ;Jul 19, 2019@07:18:52
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**500**;Dec 17, 1997;Build 24
 ;
 ; Global References
 ;    ^ORD(101,"B"        ICR   3617
 ; External References
 ;    HOME^%ZIS           ICR   10086   $$FIND1^DIC         ICR   2051     FILE^DID            ICR   2051
 ;    $$GET1^DIQ          ICR   2056    ^DIR                ICR   10026    EN^VALM             ICR   10118
 ;    $$SETFLD^VALM1      ICR   10116   $$SETSTR^VALM1      ICR   10116    FULL^VALM1          ICR   10116
 ;    SET^VALM10          ICR   10117   CLEAN^XGF           ICR   3173     PREP^XGF            ICR   3173
 ;    $$UP^XLFSTR         ICR   10104   $$GET^XPAR          ICR   2263     EN^XPAR             ICR   2263
 ;    ENVAL^XPAR          ICR   2263    GETLST^XPAR         ICR   2263     BLDLST^XPAREDIT     ICR   2336
 ;
 Q
PHDR D PREP^XGF W @IOF,!!,?27,IOUON,"BULK PARAMETER EDITOR MENU",IOUOFF D CLEAN^XGF Q
VIEWP ;
 D FULL^VALM1 N ORQ S ORQ=1
 I +ENT,+MVL,SEL="" D  Q  ; show all instances and quit
 . N X,LST,NME,ORQ,VAL
 . D  ; put list in alphabetical order
 . . N LIST D GETLST^XPAR(.LIST,ENT,+PAR,"E")
 . . S X=0 F  S X=$O(LIST(X)) Q:'+X  S LST(LIST(X))=""
 . W @IOF,$$TEXT($P(ENT(0),U,2)_" ["_$P(ENT(0),U,6)_"]","C",""),!!
 . S X=$$TEXT("Instance",1,""),X=$$TEXT("Value","R",X) W IOUON,X,IOUOFF,!
 . S ORQ=1,X="" F  S X=$O(LST(X)) Q:X=""!('+ORQ)  D
 . . S NME=$P(X,U),VAL=$P(X,U,2) W $$TEXT(VAL,"R",NME),!
 . . I $Y>(IOSL-4) W !,IOCUOFF S ORQ=+$$READ("EA",IORVON_"Press <ENTER> to continue or '^' to exit."_IORVOFF) Q:'+ORQ  W @IOF
 . I '+ORQ Q
 . F  Q:$Y>(IOSL-4)  W !
 . W !,IOCUOFF S ORQ=+$$READ("EA",IORVON_"Press <ENTER> to continue or '^' to exit."_IORVOFF) W IOCUON
 ;
 N USERS S USERS="" I PAR["Processing Flag",+ENT(0)=200,$L(SEL,",")>3 D  ; ask to add users to entity list for multiple selections
 . W !!,"Multiple Instance Values selected to view."
 . W !!,"You may add ALL or SOME of the users from all Instances to the Entity List",!,"for editing automatically.",!
 . N DIR S DIR(0)="Y",DIR("?",1)="Adding users to the Entity List automatically bypasses the viewing and"
 . S DIR("?")="will take you directly to the Entity List when complete."
 . I +$$READ(.DIR,"Would you like to do this") D  S:USERS="^" USERS=""
 . . K DIR S DIR(0)="SA^A:ALL;S:SOME",DIR("L")="Please enter (A)LL or (S)OME."
 . . W ! S USERS=$$READ(.DIR,"Add (A)LL or (S)OME Users: ")
 . . I USERS="S^SOME" D
 . . . K DIR S DIR(0)="SA^E:ENABLED;D:DISABLED;M:MANDATORY" ;,DIR("?")="Enter the Notification Value of users to add to the Entity List."
 . . . W ! S USERS=$$READ(.DIR,"Enter the Notification Value of users to add to the Entity List: ")
 ;
 W @IOF I USERS'="" W "Adding users to the list..."
 ; get each entry in the SELection list(s), SEL(#) for large selection lists
 N LEN,LIST0,LVL S LVL="" F  S LVL=$O(SEL(LVL)) Q:LVL=""!('+ORQ)  S LEN=$S(+MVL:($L(SEL(LVL),",")-1),'+MVL:1) N J F J=1:1:LEN D
 . N IEN S IEN=$S(+MVL:$O(@VALMAR@("IDX",$P(SEL(LVL),",",J),"")),1:1)
 . N LIST1 D ENVAL^XPAR(.LIST1,+PAR,$S(+MVL:"`"_IEN,1:IEN)) ; LIST0 main list, LIST1 temp list
 . I '+LIST1 D  Q
 . . W @IOF W:+MVL "Instance: "_$S(+PTR:$$GET1^DIQ(PTR,IEN,.01),1:$P(ENT(0),U,6)),!!
 . . N X S X=$$TEXT($P(ENT(0),U,2),1,""),X=$$TEXT("Value","R",X) W IOUON,X,IOUOFF,!
 . . W !,$$TEXT("No instances currently set.","C","")
 . . F  Q:$Y>(IOSL-4)  W !
 . . W !,IOCUOFF S ORQ=+$$READ("EA",IORVON_"Press <ENTER> to continue or '^' to exit."_IORVOFF) W IOCUON,@IOF S:'MVL ORQ=0 I '+ORQ S X=LEN
 . N X S X="" F  S X=$O(LIST1(X)) Q:'+X  D  ; list1 is in IEN order, list0 is alphabetical order by name
 . . I $P(ENT(1),U,2)'=$P(X,";",2) Q  ; quit if entry in list don't match the entity type
 . . N Y S Y=U_$P(X,";",2)_+X_")" Q:'+$D(@Y)  ; quit if entry is missing global root
 . . S LIST0($$GET1^DIQ(+ENT(0),+X,.01),+X)=$$UP^XLFSTR($$GET^XPAR(X,+PAR,$S(+MVL:"`"_IEN,1:IEN),"E")) ; list0(name,ien)=value
 . I USERS="A^ALL" M ENTRIES=LIST0 K LIST0 S USERS("ADDED")=1 Q  ; add all entries to entities list, kill main list
 . I USERS'="" D  K LIST0 S USERS("ADDED")=1 Q  ; add screened entries to entitiies list, kill main list
 . . N NAME,IEN S (NAME,IEN)="" F  S NAME=$O(LIST0(NAME)) Q:NAME=""  F  S IEN=$O(LIST0(NAME,IEN)) Q:'+IEN  D
 . . . I LIST0(NAME,IEN)=$P(USERS,U,2) S ENTRIES(NAME,IEN)=""
 . ; begin display of data
 . W:+MVL "Instance: "_$S(+PTR:$$GET1^DIQ(PTR,IEN,.01),1:$P(ENT(0),U,6)),!!
 . S X=$$TEXT($P(ENT(0),U,2),1,""),X=$$TEXT("Value","R",X) W IOUON,X,IOUOFF,!
 . N Y S X="" F  S X=$O(LIST0(X)) Q:X=""!('+ORQ)  S Y="" F  S Y=$O(LIST0(X,Y)) Q:'+Y  D
 . . N STR S STR="",STR=$$TEXT($E(X,1,40),1,STR) ; set name
 . . S STR=$$TEXT(LIST0(X,Y),"R",STR) ; set value
 . . W STR,!
 . . I $Y>(IOSL-4) D ASK2ADD W:+ORQ @IOF ; S ORQ=+$$READ("EA",IORVON_"Press <ENTER> to continue or '^' to exit."_IORVOFF) W:+ORQ @IOF
 . I '+ORQ S J=LEN Q
 . F  Q:$Y>(IOSL-4)  W !
 . D ASK2ADD W:+ORQ @IOF
 I +$G(USERS("ADDED")) K USERS W @IOF,"Users have been automatically added as entities...taking you to the list." H 3 D EN^ORPARMG1
 Q
ASK2ADD ;
 I +ENT(0)'=200!(PAR'["Processing Flag") D  Q
 . W !,IOCUOFF S ORQ=+$$READ("EA",IORVON_"Press <ENTER> to continue or '^' to exit."_IORVOFF) ; Q:'+ORQ  W @IOF
 D
 . N DIR W IOCUOFF
 . S DIR("L",1)="Selecting 'A' will add ALL of the users in this list as ENTITIES."
 . S DIR("L")="Selecting 'S' will add SOME of the users based on the selected parameter value."
 . S DIR("?",1)="Press <ENTER> to continue displaying the list."
 . S DIR("?")="Press '^' to exit displaying the list."
 . S DIR(0)="SAO^A:ALL;S:SOME",X("L")="" S ORQ=$$READ(.DIR,IORVON_"Press <ENTER> to continue, 'A', 'S' or '^' to exit"_IORVOFF_" ")
 . I ORQ="" S ORQ=1 W @IOF Q
 . I ORQ="^" S ORQ=0 Q
 . I ORQ="A^ALL" M ENTRIES=LIST0 K LIST0 S ORQ=0,USERS("ADDED")=1 Q
 . W IOCUON K DIR S DIR("?")="Enter the parameter value for users that you would like added to the ENTITY list."
 . S DIR(0)="SAO^E:ENABLED;D:DISABLED;M:MANDATORY" W ! S (USERS,ORQ)=$$READ(.DIR,"Enter the parameter value for users to be added to the ENTITY list: ")
 . I ORQ="" S ORQ=1 W @IOF Q
 . I ORQ="^" S ORQ=0 Q
 . S ORQ=1 N NAME,IEN S (NAME,IEN)="" F  S NAME=$O(LIST0(NAME)) Q:NAME=""  F  S IEN=$O(LIST0(NAME,IEN)) Q:'+IEN  D
 . . I LIST0(NAME,IEN)=$P(USERS,U,2) S ENTRIES(NAME,IEN)="",USERS("ADDED")=1
 . S USERS=""
 Q
UPDATE(TMP) ;
 S VAL=$P(TMP,U),VAL(0)=$P(TMP,U,2),VAL("X")=TMP("X")
 W !!,"Updating entries..."
 N LVL S LVL="" F  S LVL=$O(SEL(LVL)) Q:LVL=""  D
 . N ERR,IEN,LEN S LEN=$L(SEL(LVL),",")-1
 . N J F J=1:1:LEN D
 . . S IEN=$O(@VALMAR@("IDX",$P(SEL(LVL),",",J),"")) Q:'+IEN  ; error here if no IEN
 . . I +ENT D EN^XPAR(ENT,+PAR,$S(+MVL:"`"_IEN,1:IEN),.VAL,.ERR) I +ERR,+ERR'=1 D ERR(.ERR)
 . . I '+ENT,'MVL D EN^XPAR(IEN_ENT,+PAR,1,.VAL,.ERR) I +ERR,+ERR'=1 D ERR(.ERR)
 . . N DA,NAME
 . . S NAME="" F  S NAME=$O(ENTRIES(NAME)) Q:NAME=""  S DA="" F  S DA=$O(ENTRIES(NAME,DA)) Q:'+DA  D
 . . . D EN^XPAR(DA_ENT,+PAR,$S(+MVL:"`"_IEN,1:IEN),.VAL,.ERR) I +ERR,+ERR'=1 D ERR(.ERR)
 W "DONE!",! W IOCUOFF I $$READ("EA",IORVON_"Press <ENTER> to continue."_IORVOFF) W IOCUON
 Q
SELECT(ACT) ;
 D FULL^VALM1
 I ACT="VIEWA" D  Q
 . I '+ENT D  Q
 . . I +MVL W !!,"Select 'Add/Remove/View Entities' to view instance settings per entity.",!
 . . I '+MVL W !!,"Select 'View Instance Value(s)' to view instance settings.",!
 . . I $$READ("EA",IOCUOFF_IORVON_"Press <ENTER> to continue."_IORVOFF) W IOCUON
 . S ACT="VIEWP",SEL="" D @ACT
 I '+ENT,+MVL,'+$D(ENTRIES),ACT'="VIEWP" D  Q
 . W !!,"No entities selected.  Please Add/Remove Entities.",!
 . I $$READ("EA",IOCUOFF_IORVON_"Press <ENTER> to continue."_IORVOFF) W IOCUON
 I VALMCNT=0 Q
 N SEL S SEL=$S(VALMCNT=1:"1,",1:$P(XQORNOD(0),"=",2))
 I 'MVL,ACT="VIEWP" S SEL="1,"
 I '+$D(SEL(0)) S SEL(0)=SEL ; LM default excludes Y(0)
 I SEL="" S SEL=$$LOR(.SEL) Q:'+SEL
 D @ACT
 Q
INIT ;
 K @VALMAR
 I '+PTR,+ENT D  Q  ; single entry
 . N X S VALMCNT=1,X=""
 . S X=$$SETFLD^VALM1(VALMCNT,X,"NUMBER")
 . S X=$$SETFLD^VALM1($P(ENT(0),U,6),X,"INSTANCE")
 . D SET^VALM10(1,X,1)
 N FNM,GBL,SCR
 S FNM=$S(+PTR:PTR,1:+ENT(0))
 D FILE^DID(FNM,,"GLOBAL NAME","GBL")
 S GBL=$P(GBL("GLOBAL NAME"),",")_")",SCR=$$GET1^DIQ(8989.51,+PAR,8)
 N IEN,NAME
 S VALMCNT=0,NAME="" F  S NAME=$O(@GBL@("B",NAME)) Q:NAME=""  S IEN="" F  S IEN=$O(@GBL@("B",NAME,IEN)) Q:'+IEN  D
 . I SCR'="" N RSLT D
 . . N DA,ERR D FIND^DIC(FNM,,".01","PX",NAME,,"B",SCR,,"RSLT","ERR") I $D(ERR) Q
 . . S DA=0 F  S DA=$O(RSLT("DILIST",DA)) Q:'+DA!(+$G(RSLT))  I +RSLT("DILIST",DA,0)=IEN S RSLT=1
 . I SCR'="",'+$G(RSLT) Q
 . S VALMCNT=VALMCNT+1,X=""
 . S X=$$SETFLD^VALM1(VALMCNT,X,"NUMBER")
 . S X=$$SETFLD^VALM1($$GET1^DIQ(FNM,IEN,.01),X,"INSTANCE")
 . D SET^VALM10(VALMCNT,X,IEN)
 . I $$UP^XLFSTR($P(PAR,U,2))["FLAG ITEM" W:VALMCNT=1 !,"Adding instance " D SAY^XGF(1,16,VALMCNT_" to the list.")
 Q
LOR(SEL) ; list or range of numbers
 N DIR,X,Y
 S DIR(0)="LOA^1:"_VALMCNT_":0",DIR("A")="Select Instance(s) (1-"_VALMCNT_"): "
 S DIR("?")="Enter a list or range of numbers from 1 to "_VALMCNT
 D ^DIR
 M SEL=Y
 Q SEL
HDR ;
 S VALMHDR(1)="Parameter: "_$$UP^XLFSTR($P(PAR,U,2))
 S VALMHDR(1)=$$SETSTR^VALM1(VALMHDR(1),"",IOM-$L(VALMHDR(1))/2,$L(VALMHDR(1)))
 S VALMHDR(2)="Entity: "_$$UP^XLFSTR($P(ENT(0),U,2))_" "_$S(+$L($P(ENT(0),U,5)):"["_$P(ENT(0),U,6)_"]",+MVL:"[choose via Add/Remove]",1:"")
 S VALMHDR(2)=$$SETSTR^VALM1(VALMHDR(2),"",IOM-$L(VALMHDR(2))/2,$L(VALMHDR(2)))
 D XQORM
 Q
EXIT ;
 D XQORM
 Q
EXPND ;
 Q
XQORM ;
 S XQORM("#")=$O(^ORD(101,"B","ORNOT DEFAULT SELECTIONS",0))_U_"1:"_VALMCNT
 Q
LU(FILE,NAME,FLAGS,SCREEN,INDEXES) ; $$FIND1^DIC(FILE,IENS,FLAGS,[.]VALUE,[.]INDEXES,[.]SCREEN,MSG_ROOT)
 Q $$FIND1^DIC(FILE,"",$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN),"ERR")
READ(DIR,PROMPT,DEFAULT,HELP,SCREEN) ;
 N X,Y
 S DIR(0)=$S(+$D(DIR(0)):DIR(0),1:DIR)
 I $D(SCREEN) S DIR("S")=SCREEN
 I $G(PROMPT)]"" S DIR("A")=PROMPT
 I $G(DEFAULT)]"" S DIR("B")=DEFAULT
 D ^DIR
 I $G(X)="@" S Y="@" Q Y
 I Y]"",($L($G(Y),U)'=2) S Y=Y_U_$G(Y(0),Y)
 Q Y
ERR(ERROR) ;
 Q
ASK ;
 N DA,DEF,IEN,VAL,X
 S (DEF,IEN)=""
 I $L(SEL,",")-1=1 S IEN=$O(@VALMAR@("IDX",+SEL,""))
 I +IEN D
 . I +ENT S DEF=$$GET^XPAR(ENT,+PAR,$S(+MVL:"`"_IEN,1:IEN),"B") Q:DEF'=""
 . I 'MVL S DEF=$$GET^XPAR(IEN_ENT,+PAR,,"B")
 I '+ENT,$G(ENTRIES)=1 D
 . S VALMEVL=1,DA=$O(@VALMAR@("IDX",1,"")),VALMEVL=0
 . S DEF=$$GET^XPAR(DA_ENT,+PAR,$S(+MVL:"`"_IEN,1:IEN),"B")
 I $L(SEL,",")>2!($G(ENTRIES)>1) W !,"[EDIT] Multiple Values and/or Entries Selected."
 S X="EDITVAL^XPAREDT2(.VAL,+PAR,""V"",DEF)" D @X
 D:VAL'="" UPDATE(.VAL)
 Q
ADDREM ;
 I '+ENT,+MVL D EN^ORPARMG1 Q
 D FULL^VALM1
 W !!,"This parameter is single entity only."
 W !!,"Select 'Edit Instance Value' to change the instance value.",!
 W IOCUOFF I $$READ("EA",IORVON_"Press <ENTER> to continue."_IORVOFF) W IOCUON
 Q
PREP(PAR,ENT) ;
 N IOF,LST D HOME^%ZIS W @IOF
 S ENT="",PAR=PAR_U_$$GET1^DIQ(8989.51,PAR,.02)
 D BLDLST^XPAREDIT(.LST,PAR) ; ICR#2336
 W $P(PAR,U,2),$S($P(PAR,U,2)[".":" M",1:" m")_"ay be set for the following:",!
 N X S X=0 F  S X=$O(LST(X)) Q:'+X  D
 . W !,?10,X,?15,$P(LST(X),U,2)
 . W ?30,$S(+$L($P(LST(X),U,5)):"["_$P(LST(X),U,6)_"]",1:"[choose via ListManager]")
 S X=$$KSP^XUPARAM("WHERE") ; ICR # 2541
 S SYSTEM=$$FIND1^DIC(4.2,"","QX",X)_";DIC(4.2,"
 ;S:+$D(LST("P","SYS")) SYSTEM=$P(LST(LST("P","SYS")),U,5)
 S LST(0)="SAO^" F X=1:1:LST S LST(0)=LST(0)_X_":"_$P(LST(X),U,2)_$S(X<7:";",1:"")
 W ! S X=+$$READ(LST(0),"Enter selection: ","") Q:'+X
 S ENT(0)=LST(X)
 S ENT=$S(+$P(ENT(0),U,5):$P(ENT(0),U,5),1:"")
 N Y D FILE^DID(+ENT(0),,"GLOBAL NAME","Y")
 S:'+ENT ENT=";"_$P(Y("GLOBAL NAME"),U,2)
 S ENT(1)=Y("GLOBAL NAME")
 S MVL=$$GET1^DIQ(8989.51,+PAR,.03,"I") ; multi-valued parameter
 S PTR=$$GET1^DIQ(8989.51,+PAR,6.2) ; pointer to file #
 Q
EN(PAR) ;
 Q:$G(PAR)=""
 N ENT,ENTRIES,MVL,PTR,SYSTEM,TMPLIST,XQORM
 D FULL^VALM1,HOME^%ZIS
 D PREP(.PAR,.ENT) Q:ENT=""
 D PREP^XGF ; ICR # 3173
 D EN^VALM("OR PARAMETER MGR")
 D CLEAN^XGF ; ICR # 3173
 Q
PF ; processing flag
 D EN($$LU(8989.51,"ORB PROCESSING FLAG","X"))
 Q
UR ; urgency
 D EN($$LU(8989.51,"ORB URGENCY","X"))
 Q
DM ; delete mechanism
 D EN($$LU(8989.51,"ORB DELETE MECHANISM","X"))
 Q
DR ; default recipients
 D EN($$LU(8989.51,"ORB DEFAULT RECIPIENTS","X"))
 Q
DRD ; default recipient device(s)
 D EN($$LU(8989.51,"ORB DEFAULT RECIPIENT DEVICES","X"))
 Q
PR ; provider recipients for notifications
 D EN($$LU(8989.51,"ORB PROVIDER RECIPIENTS","X"))
 Q
FIO ; flag inpatient orders
 D EN($$LU(8989.51,"ORB OI ORDERED - INPT","X"))
 Q
FIOPR ; flag inpatient orders for provider recipients
 D EN($$LU(8989.51,"ORB OI ORDERED - INPT PR","X"))
 Q
FIR ; flag inpatient results
 D EN($$LU(8989.51,"ORB OI RESULTS - INPT","X"))
 Q
FIRPR ; flag inpatient results for provider recipients
 D EN($$LU(8989.51,"ORB OI RESULTS - INPT PR","X"))
 Q
FIEO ; flag inpatient expiring orders
 D EN($$LU(8989.51,"ORB OI EXPIRING - INPT","X"))
 Q
FIEOPR ; flag inpatient expiring orders for provider recipients
 D EN($$LU(8989.51,"ORB OI EXPIRING - INPT PR","X"))
 Q
FOO ; flag outpatient orders
 D EN($$LU(8989.51,"ORB OI ORDERED - OUTPT","X"))
 Q
FOOPR ; flag outpatient orders for provider recipients
 D EN($$LU(8989.51,"ORB OI ORDERED - OUTPT PR","X"))
 Q
FOR ; flag outpatient results
 D EN($$LU(8989.51,"ORB OI RESULTS - OUTPT","X"))
 Q
FORPR ; flag outpatient results for provider recipients
 D EN($$LU(8989.51,"ORB OI RESULTS - OUTPT PR","X"))
 Q
FOEO ; flag outpatient expiring orders
 D EN($$LU(8989.51,"ORB OI EXPIRING - OUTPT","X"))
 Q
FOEOPR ; flag outpatient expiring orders for provider recipients
 D EN($$LU(8989.51,"ORB OI EXPIRING - OUTPT PR","X"))
 Q
AP ; archive delete period
 D EN($$LU(8989.51,"ORB ARCHIVE PERIOD","X"))
 Q
FUNSUP ; forward unprocessed notifications to supervisor
 D EN($$LU(8989.51,"ORB FORWARD SUPERVISOR","X"))
 Q
FUNSUR ; forward unprocessed notifications to surrogates
 D EN($$LU(8989.51,"ORB FORWARD SURROGATES","X"))
 Q
FUNBKR ; forward unprocessed notifications to backup reviewer
 D EN($$LU(8989.51,"ORB FORWARD BACKUP REVIEWER","X"))
 Q
DAUO ; set delay for all unverified orders
 D EN($$LU(8989.51,"ORB UNVERIFIED ORDER","X"))
 Q
DUMO ; set dleay for unverified medication orders
 D EN($$LU(8989.51,"ORB UNVERIFIED MED ORDER","X"))
 Q
FOB ; send flag orders bulletin
 D EN($$LU(8989.51,"ORB FLAGGED ORDERS BULLETIN","X"))
 Q
EDSYS ; enable or disable notification system
 D EN($$LU(8989.51,"ORB SYSTEM ENABLE/DISABLE","X"))
 Q
HELP ;
 D FULL^VALM1
 W @IOF
 N TXT,X,Y S Y="HLPT"
 F X=1:1 S TXT=$P($T(@Y+X),";;",2) Q:TXT="EOM"  D
 . W @TXT,!
 F  Q:$Y>(IOSL-3)  W !
 W IOCUOFF I $$READ("EA",IORVON_"Press <ENTER> to continue."_IORVOFF) W IOCUON
 S VALMBCK="R"
 Q
HLPT ;
 ;;IOUON,$$TEXT("Page:    1 of    1","R",$$TEXT($$FMTE^XLFDT($$NOW^XLFDT),"C",VALM("TITLE"))),IOUOFF
 ;;VALMHDR(1)
 ;;VALMHDR(2)
 ;;IOUON,$$TEXT(" ","R",$$TEXT("Instance",8)),IOUOFF
 ;;@VALMAR@(1,0)
 ;;$S(+$L($G(@VALMAR@(2,0))):@VALMAR@(2,0),1:"")
 ;;"."
 ;;"."
 ;;"<end example list>"
 ;;""
 ;;IORVON,$$TEXT(" ","R",$$TEXT("+         Enter ?? for more actions")),IORVOFF
 ;;$$TEXT("Edit Instance Value                     Add/Remove/View Entities",6)
 ;;$$TEXT("View Instance Value(s)                  Show All Instances",6)
 ;;"Select Action:Next Screen//"
 ;;""
 ;;EOM
 Q
TEXT(X,Y,Z) ;TXT,COL,INSERT
 S Z=$S($G(Z)="":"",1:Z)
 S Y=$S($G(Y)="C":((IOM-$L(X))/2),$G(Y)="R":(IOM-$L(X)),+$G(Y)>0:Y,1:0)
 Q $$SETSTR^VALM1(X,Z,Y,$L(X))
