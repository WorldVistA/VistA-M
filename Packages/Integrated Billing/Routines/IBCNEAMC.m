IBCNEAMC ;DAOU/ESG - IIV AUTO MATCH BUFFER LISTING ;11-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,252**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCNE AUTO MATCH BUFFER LIST
 NEW IBCNENIL,COL,CTRLCOL,FINISH,POP,VALMBCK,X,%DT
 D EN^VALM("IBCNE AUTO MATCH BUFFER LIST")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="These are Insurance Company names from the Insurance Buffer file that do not"
 S VALMHDR(2)="exist in the Insurance Company file (either as Names or as Synonyms).  They"
 S VALMHDR(3)="also do not exist or pattern match with any entry in the Auto Match file."
 Q
 ;
INIT ; -- init variables and list array
 NEW ENTDATE,IBBUFDA,BUFFNAME
 KILL ^TMP($J,"IBCNEAMC")
 S IBCNENIL=0        ; initialize the no data flag
 S ENTDATE=0
 F  S ENTDATE=$O(^IBA(355.33,"AEST","E",ENTDATE)) Q:'ENTDATE  S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,"AEST","E",ENTDATE,IBBUFDA)) Q:'IBBUFDA  D
 . S BUFFNAME=$$TRIM($P($G(^IBA(355.33,IBBUFDA,20)),U,1))
 . I BUFFNAME="" Q                       ; no name in buffer file
 . I $D(^DIC(36,"B",BUFFNAME)) Q         ; insurance company name
 . I $D(^DIC(36,"C",BUFFNAME)) Q         ; insurance company synonym
 . I $$AMLOOK^IBCNEUT1(BUFFNAME) Q       ; Auto Match file lookup
 . S ^TMP($J,"IBCNEAMC",2,BUFFNAME)=""   ; name not found so add it
 . Q
 ; Now build the ListMan array for display
 S BUFFNAME="",VALMCNT=0
 F  S BUFFNAME=$O(^TMP($J,"IBCNEAMC",2,BUFFNAME)) Q:BUFFNAME=""  D
 . S VALMCNT=VALMCNT+1
 . S ^TMP($J,"IBCNEAMC",1,VALMCNT,0)=$J(VALMCNT,4)_"  "_BUFFNAME
 . S ^TMP($J,"IBCNEAMC",3,VALMCNT)=BUFFNAME
 . Q
 ;
 ; Check to see if there's no data
 I 'VALMCNT D
 . S IBCNENIL=1     ; no data flag is true
 . S ^TMP($J,"IBCNEAMC",1,1,0)=""
 . S ^TMP($J,"IBCNEAMC",1,2,0)=""
 . S ^TMP($J,"IBCNEAMC",1,3,0)="     There is no data to display."
 . S VALMCNT=3
 . Q
INITX ;
 Q
 ;
 ; For speed reasons, code taken from TRIM^XLFSTR
TRIM(X,SIDE,CHAR) ; Trim chars from left/right of string
 NEW LEFT,RIGHT
 I X="" Q X
 S SIDE=$G(SIDE,"LR"),CHAR=$G(CHAR," "),LEFT=1,RIGHT=$L(X)
 I X=CHAR Q ""
 I SIDE["R" F RIGHT=$L(X):-1:1 Q:$E(X,RIGHT)'=CHAR
 I SIDE["L" F LEFT=1:1:$L(X) Q:$E(X,LEFT)'=CHAR
 Q $E(X,LEFT,RIGHT)
 ;
 ;
HELP ; -- help code
 D FULL^VALM1
 W !!," There are three main actions you may take on this screen."
 W !," You may select an action by typing in the first character of the action."
 W !!,"   Select Entry"
 W !,"     You choose a single insurance company name from the list."
 W !,"     This name becomes the default Auto Match value for a new"
 W !,"     Auto Match entry.  You may then associate this Auto Match value"
 W !,"     with a valid insurance company name."
 W !!,"   Auto Match Enter/Edit"
 W !,"     This action will take you to the Enter/Edit Auto Match Entries"
 W !,"     option.  You may add, edit, or delete multiple Auto Match"
 W !,"     entries in this option."
 W !!,"   Exit"
 W !,"     Exit out of this option."
 D PAUSE^VALM1
 S VALMBCK="R"
HELPX ;
 Q
 ;
 ;
EXIT ; -- exit code
 KILL ^TMP($J,"IBCNEAMC")
 Q
 ;
 ;
SELECT ; -- select an entry from the list
 NEW STOP,AMIEN,NEWENTRY,BUFFNAME,INSNM
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 D FULL^VALM1
 ;
 ; Check for Auto Match security key before allowing selection
 I '$$KCHK^XUSRB("IBCNE IIV AUTO MATCH") D  G SELECTX
 . W !!?5,"You don't hold the proper security key to access this function."
 . W !?5,"The necessary key is IBCNE IIV AUTO MATCH.  Please see your manager."
 . D PAUSE^VALM1
 . Q
 ;
 ; Make sure there is something there
 I IBCNENIL D  G SELECTX
 . W !!?5,"There are no entries in the list."
 . D PAUSE^VALM1
 . Q
 ;
 S DIR(0)="NO^1:"_VALMCNT_":0"
 S DIR("A")="Select Entry"
 S DIR("?",1)=" Please enter the line number corresponding to the insurance company name."
 S DIR("?",2)=" The valid range of line numbers is displayed in the prompt."
 S DIR("?",3)=" "
 S DIR("?",4)=" The insurance company name you select will be used as the default response for"
 S DIR("?",5)=" a new Auto Match entry.  You may either accept this entry as is or you may"
 S DIR("?")=" modify it by changing the spelling or by adding wildcard characters."
 D ^DIR K DIR
 I 'Y G SELECTX
 S BUFFNAME=$G(^TMP($J,"IBCNEAMC",3,Y))
 I BUFFNAME="" W ! G SELECTX
 W "  ",BUFFNAME,!
 ;
 D LOOKUP I STOP G SELECTX ;Prompt user for Insurance Co.
 I $D(^IBCN(365.11,"B",BUFFNAME)) D  G SELECTX ; has entry been added?
 . W !!,BUFFNAME," has already been added to the Auto Match file."
 . S DIR(0)="E" D ^DIR K DIR
 . D INIT ; refresh listing
 D AMADD^IBCNEUT6(INSNM,BUFFNAME)
 D INIT
SELECTX ;
 S VALMBCK="R"
 Q
 ;
LOOKUP ; Prompt for associated Insurance Company
 S STOP=0
 S DIC=36,DIC(0)="AEMVZ"
 D ^DIC
 I Y<1!$D(DTOUT)!$D(DUOUT) S STOP=1 G LOOKX
 S INSNM=$P(Y(0),U)
LOOKX Q
 ;
LINK ; -- link to the Auto Match Enter/Edit option
 D FULL^VALM1
 ;
 ; Check for Auto Match security key before allowing selection
 I '$$KCHK^XUSRB("IBCNE IIV AUTO MATCH") D  G LINKX
 . W !!?5,"You don't hold the proper security key to access this function."
 . W !?5,"The necessary key is IBCNE IIV AUTO MATCH.  Please see your manager."
 . D PAUSE^VALM1
 . Q
 ;
 D ENTER^IBCNEAME
LINKX ;
 D INIT S VALMBCK="R"
 Q
 ;
