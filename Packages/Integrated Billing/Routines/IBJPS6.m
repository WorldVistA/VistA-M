IBJPS6 ;ALB/WCJ - IB Site Parameters, Administrative Contractors ; 27-AUG-2015
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
 Q
 ;
EN(WHICH) ; -- main entry point for IBJP ALT PRIM PAYER ID TYP
 ; Input: WHICH     - 1 - Using template IBJP ADMIN CONTRACTOR MED
 ;                    2 - Using template IBJP ADMIN CONTRACTOR COM
 N TEMPLATE
 S TEMPLATE=$S(WHICH=1:"IBJP ADMIN CONTRACTOR MED",1:"IBJP ADMIN CONTRACTOR COM")
 D EN^VALM(TEMPLATE)
 Q
 ;
HDR(WHICH) ; -- header code
 ; Input: WHICH     - 1 - Using template IBJP ADMIN CONTRACTOR MED
 ;                    2 - Using template IBJP ADMIN CONTRACTOR COM
 ;
 S:WHICH=1 VALMHDR(1)="Medicare"
 S:WHICH=2 VALMHDR(1)="Commercial"
 Q
 ;
INIT(WHICH) ; Initialize variables and list array
 ; Input: WHICH     - 1 - Using template IBJP ADMIN CONTRACTOR MED
 ;                    2 - Using template IBJP ADMIN CONTRACTOR COM
 ; Output:  ^TMP("IBJPS6",$J)   - Body lines to display for specified template
 K ^TMP("IBJPS6",$J),^TMP($J,"IBJPS6IX")
 D BLD(WHICH)
 Q
 ;
BLD(WHICH) ; Build screen array, no variables required for input
 ; Input: WHICH     - 1 - Using template IBJP ADMIN CONTRACTOR MED
 ;                    2 - Using template IBJP ADMIN CONTRACTOR COM
 ; Output:  ^TMP("IBJPS6",$J)   - Body lines to display for specified template
 ;
 N CNT,ENTRIES,LINE,NAME,NAMEIEN,NODE,NODE0,Z
 S VALMCNT=0
 S NODE=$S(WHICH=1:81,1:82)
 S (Z,CNT)=0
 F  D  Q:+Z=0
 . S Z=$O(^IBE(350.9,1,NODE,Z))
 . Q:+Z=0
 . S NODE0=$G(^IBE(350.9,1,NODE,Z,0)),NAMEIEN=+$P(NODE0,U,1)
 . I NAMEIEN>0 D
 . . S CNT=CNT+1,NAME=$$EXTERNAL^DILFD(350.9_NODE,.01,"",NAMEIEN)
 . . I NAME'="" D
 . . . S ENTRIES(NAME,CNT)=NAMEIEN,ENTRIES(NAME,CNT,"IEN")=Z
 I '$D(ENTRIES) D  Q
 . S LINE=$$SETL("","","** No entries found **",29,22)
 . S ^TMP("IBJPS6",$J,1,0)=LINE
 ;
 S NAME=""
 F  D  Q:NAME=""
 .S NAME=$O(ENTRIES(NAME)) Q:NAME=""
 .S Z=0 F  D  Q:Z=""
 ..S Z=$O(ENTRIES(NAME,Z)) Q:Z=""
 ..S VALMCNT=VALMCNT+1
 ..S LINE=$$BLDLN(VALMCNT,NAME,ENTRIES(NAME,Z))
 ..D SET^VALM10(VALMCNT,LINE,VALMCNT)
 ..S ^TMP($J,"IBJPS6IX",VALMCNT)=ENTRIES(NAME,Z,"IEN")
 ..Q
 .Q
 Q
 ;
BLDLN(CTR,NAME,IEN) ; Builds a line to display and insurance
 ; Input:   CTR     - Current Line Counter
 ;          NAME    - Insurance Company Name
 ;          IEN     - IEN of the insurance to be displayed
 ; Output:  LINE    - Formatted for settng into the list display
 N LINE,XX
 S LINE=$$SETSTR^VALM1(CTR,"",1,4)                  ; Entry #
 S LINE=$$SETSTR^VALM1(NAME,LINE,6,66)              ; Administrative Contractor Type
 Q LINE
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ; Creates a line of data to be set into the body
 ; of the worklist
 ; Input:   LINE    - Current line being created
 ;          DATA    - Information to be added to the end of the current line
 ;          LABEL   - Label to describe the information being added
 ;          COL     - Column position in line to add information add
 ;          LNG     - Maximum length of data information to include on the line
 ; Returns: Line updated with added information
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
HELP(WHICH) ; -- help code
 ; Input: WHICH     - 1 - Using template IBJP ADMIN CONTRACTOR MED
 ;                    2 - Using template IBJP ADMIN CONTRACTOR COM
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT(WHICH) ; Exit code
 ; Input: WHICH     - 1 - Using template IBJP ADMIN CONTRACTOR MED
 ;                    2 - Using template IBJP ADMIN CONTRACTOR COM
 K ^TMP("IBJPS6",$J),^TMP($J,"IBJPS6IX")
 D CLEAR^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
ADD(WHICH) ; Listman Protocol Action to add an entry to the specified Site Parameter node
 ; Input: WHICH     - 1 - Using template IBJP ADMIN CONTRACTOR MED
 ;                    2 - Using template IBJP ADMIN CONTRACTOR COM
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FDA,IEN,IENS,INSM,INSMC
 N NODE,NAME,NAMEU,NODE0,X,XX,Y,Z,Z1
 S NODE=$S(WHICH=1:81,1:82)
 S VALMBCK="R"                                  ; Refresh screen on return
 Q:'$$LOCK(NODE)                                ; Couldn't lock for adding
 D FULL^VALM1
 ;
 I '$$ENTSEL(NODE,.IENS,WHICH) D  Q           ; Select entry(s) to be added
 . S VALMSG="No Primary ID Types selected"
 . D UNLOCK(NODE)
 ;
 ; Add the selected entries into the list
 S IEN=""
 F  D  Q:IEN=""
 . S IEN=$O(IENS(IEN))
 . Q:IEN=""
 . Q:$$FIND1^DIC("350.9"_NODE,",1,","QX",IEN)   ; don't add it, it's already there. 
 . S FDA("350.9"_NODE,"+1,1,",.01)=IEN
 . D UPDATE^DIE("","FDA")
 D UNLOCK(NODE)                                 ; Unlock the Node
 ;
 D INIT(WHICH)                                  ; Rebuild list body
 S VALMSG="Added Primary ID Types"
 Q
 ;
DEL(WHICH) ; Listman Protocol Action to delete an entry from the specified Site Parameter node
 ; Input: WHICH     - 1 - Using template IBJP ADMIN CONTRACTOR MED
 ;                    2 - Using template IBJP ADMIN CONTRACTOR COM
 ;
 N CNT,CNT2,DA,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIST,NAME
 N NODE,NODE0,SELSTR,STR,X,XX,Y,Z,Z1,OTHER,SKIPPED,DELETED
 S NODE=$S(WHICH=1:81,1:82)
 S OTHER=$S(NODE=82:81,1:82)
 S VALMBCK="R"                                  ; Refresh screen on return
 Q:'$$LOCK(NODE)                                ; Couldn't lock for deletion
 D FULL^VALM1                                    ; Display warning message
 S STR=$$SELEVENT(0,"",.SELSTR,1,"IBJPS6IX")
 ; 
 I STR="" D  Q           ; Select entry(s) to be added
 . S VALMSG="No Pimary ID Types selected"
 . S VALMBCK="R"  ; resetting this variable which disappeared to refresh screen
 . D UNLOCK(NODE)
 ;
 I STR'="" D
 . F Z=1:1:$L(STR,",") D
 . . S Z1=$P(STR,",",Z),NODE0=$G(^IBE(350.9,1,NODE,Z1,0))
 . . S NAME=$$EXTERNAL^DILFD(350.9_NODE,.01,"",+$P(NODE0,"^",1))
 . . S LIST(Z1)=NAME
 . . S LIST(Z1,"I")=+NODE0
 ;
 ; Delete the selected entries from the list
 S DA(1)=1,(CNT,CNT2,DA)=0
 S SKIPPED=""
 F  S DA=$O(LIST(DA)) Q:'DA  D
 . I $D(^DIC(36,"AB",LIST(DA,"I")))!($D(^DIC(36,"AD",LIST(DA,"I")))),'$D(^IBE(350.9,1,OTHER,"B",LIST(DA,"I"))) D  Q  ; don't let them delete ones in use
 .. S CNT2=CNT2+1
 .. S SKIPPED=$S($G(SKIPPED)]"":SKIPPED_",",1:"")_LIST(DA)
 .. Q
 . S CNT=CNT+1
 . S DELETED=$S($G(DELETED)]"":DELETED_",",1:"")_LIST(DA)
 . S DIK="^IBE(350.9,"_DA(1)_","_NODE_","
 . D ^DIK
 S DIR(0)="EA",Z=1
 S DIR("A",Z)=" ",Z=Z+1
 I STR="" S DIR("A",Z)="No records selected",Z=Z+1
 I STR'="" D
 . I $D(LIST) D 
 . . S Z1=0
 . . I CNT D
 . . . S DIR("A",Z)="The following "_CNT_" primary ID type"_$S(CNT>1:"s",1:"")_" deleted:",Z=Z+1
 . . . S DIR("A",Z)=DELETED,Z=Z+1
 . . . Q
 . . I CNT2 D
 . . . S DIR("A",Z)="The following "_CNT2_" primary ID type"_$S(CNT2>1:"s are",1:" is")_" in use and cannot be deleted:",Z=Z+1
 . . . S DIR("A",Z)=SKIPPED,Z=Z+1
 . . . S DIR("A",Z)="You must delete the ID from the Insurance Company file first.",Z=Z+1
 S DIR("A",Z)=" ",Z=Z+1
 S DIR("A")="Press RETURN to continue "
 D ^DIR
 D UNLOCK(NODE)                                 ; Unlock Site Parameter node
 I STR]"" D INIT(WHICH)                                  ; Rebuild list body
 Q
 ;
ENTSEL(NODE,IENS,WHICHF)   ; Selects an entry to be added to the specified Site Parameter Node
 ; Input:
 ;              NODE      - Site Parameter node where the data resides
 ;              IENS      - not really being passed in
 ;              WHICHF    - 1 - Using template IBJP ADMIN CONTRACTOR MED
 ;                          2 - Using template IBJP ADMIN CONTRACTOR COM 
 ; Output:      IENS        - Array of selected IEN(s), "" if not selected
 ; Returns:     1           - At least one IEN selected, 0 otherwise
 N DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IX,STOP,STOP2,X,XX,Y
 N TARGET,ERROR,FDA,FDAIEN,IBSAVEX,SCREEN,IBNODE
 K IENS
 S IBNODE=$S(WHICHF=1:81,1:82)
 S STOP=0
 ;
 F  D  Q:STOP
 . K DIR
 . S DIR(0)="355.98,.01O^^S X=$$UP^XLFSTR(X)"   ; "O" is for optional
 . S DIR("A")="Enter a Primary ID Type"
 . D ^DIR
 . I $G(DIRUT) S STOP=1 Q
 . K DILIST,FDA,TARGET,ERROR,FDAIEN
 . S X=$$UP^XLFSTR(X)
 . S IBSAVEX=X
 . S SCREEN="I '$D(^IBE(350.9,1,IBNODE,""B"",+Y))"  ; screen out the ones already there.  After all, this is the add action
 . D FIND^DIC(355.98,,,"O",X,"*",,SCREEN,,"TARGET","ERROR")  ; looks for an exact match 1st.  If not, then look for partials.
 . ;
 . ; There was one match but already in the mulitple.  Can't add it if it's already there.
 . I +$G(TARGET("DILIST",0))=0,$D(^IBA(355.98,"B",IBSAVEX)) Q
 . ;
 . ; found one entry in the file that was not in the mutiple already.  see if that's it
 . I +$G(TARGET("DILIST",0))=1 D  Q:$G(STOP)  Q:Y
 . . W $E($G(TARGET("DILIST",1,1)),$L(IBSAVEX)+1,99) ; only found one so write the rest of it if it was a partial match 
 . . K DIR
 . . S DIR(0)="Y",DIR("B")="YES",DIR("A")="OK" D ^DIR
 . . I $G(DIRUT) S STOP=1 Q
 . . ; they said it wasn't the one so STOP if the entered value was an exact match to one in the file.
 . . ; Don't if it's not; they may want to add later
 . . I 'Y S:IBSAVEX=$G(TARGET("DILIST",1,1)) STOP=1 K TARGET Q
 . . S IENS(+$G(TARGET("DILIST",2,1)))=""
 . ;
 . ; found more than one entry, pick one
 . I +$G(TARGET("DILIST",0))>1 D  Q:$G(STOP)  Q:$D(TARGET)
 . . F I=1:1:+$G(TARGET("DILIST",0)) W !,I,?3,TARGET("DILIST",1,I)
 . . S DIR(0)="NO^1:"_+$G(TARGET("DILIST",0))
 . . D ^DIR
 . . I $G(DUOUT) S STOP=1 Q  ; ^ out
 . . I $G(X) S IENS(+$G(TARGET("DILIST",2,X)))="" Q  ; actually selected one
 . . I X="" S:$D(^IBA(355.98,"B",IBSAVEX)) STOP=1 K TARGET Q  ; set STOP if it was already in the file.  
 . ;
 . ; either found no entries or didn't like the the others.
 . I '+$G(TARGET("DILIST",0)) D  Q  ; no matches so add it to 355.98
 . . K DIR
 . . S DIR(0)="Y",DIR("B")="YES",DIR("A")="OK to Add"_$S($D(TARGET):"",1:" '"_IBSAVEX_"'") D ^DIR
 . . I $G(DIRUT) S STOP=1 Q
 . . I 'Y Q
 . . S FDA("355.98","+1,",.01)=IBSAVEX
 . . D UPDATE^DIE("ES","FDA","FDAIEN")
 . . S IENS(+FDAIEN(1))=""
 . ; I had a list but didn't like any of them.  Should I add?
 .
 ;
 I '$D(IENS) Q 0                                ; No IENS selected
 Q 1
 ;
LOCK(NODE)  ;EP
 ; Attempt to lock the Site Parameter node that is being worked
 ; Input:   NODE        - Site Parameter node where the data resides
 ; Returns: 1           - Successfully locked
 ;          0           - Not successfully locked and an error message is
 ;                        displayed
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,TEXT,X,Y
 L +^IBE(350.9,1,NODE):1
 I '$T D  Q 0
 . S:NODE=81 TEXT="Medicare Primary ID Types"
 . S:NODE=82 TEXT="Commercial Primary ID Types"
 . W @IOF,"Someone else is editing the "_TEXT
 . W !,"Please Try again later"
 . D PAUSE^VALM1
 Q 1
 ;
UNLOCK(NODE) ;EP
 ; Unlocks the Site Parameter node that is being worked
 ; Input:   NODE        - Site Parameter node where the data resides
 L -^IBE(350.9,1,NODE)
 Q
 ;
SELEVENT(FULL,PROMPT,DLINE,MULT,WLIST)    ; Select Entry(s) to perform an action upon
 ; Input:   FULL                - 1 - full screen mode, 0 otherwise
 ;          PROMPT              - Prompt to be displayed to the user
 ;          MULT                - 1 to allow multiple entry selection
 ;                                0 to only allow single entry selection
 ;                                Optional, defaults to 0
 ;          WLIST               - Worklist, the user is selecting from
 ;                                Set to 'IBTRH5IX' when called from the
 ;                                response worklist.
 ;                                Optional, defaults to 'IBTRH1IX' 
 ;          ^TMP($J,"IBJPS6IX") - Index of displayed lines of the HCSR Worklist
 ;                                Only used if WLIST is not 'IBJPS6IX"
 ; Output:  DLINE               - Comma delimitted list of Line #(s) of the 
 ;                                selected entries
 ; Returns: EIN(s) - Comma delimitted string or IENS for the selected entry(s)
 ;          Error message and "" IENS if multi-selection and not allowed
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,EIEN,EIENS,IX,VALMY,X,Y
 S:'$D(WLIST) WLIST="IBJPS6IX"
 D:FULL FULL^VALM1
 S DLINE=$P($P($G(XQORNOD(0)),"^",4),"=",2)     ; User selection with action
 S DLINE=$TR(DLINE,"/\; .",",,,,,")             ; Check for multi-selection
 S EIENS=""
 ;
 I 'MULT,DLINE["," D  Q ""                      ; Invalid multi-selection
 . W !,*7,">>>> Only single entry selection is allowed"
 . S DLINE=""
 . K DIR
 . D PAUSE^VALM1
 ;
 ; Check the user enter their selection(s)
 D EN^VALM2($G(XQORNOD(0)),"O")     ; ListMan generic selector
 I '$D(VALMY) Q ""
 S IX="",DLINE=""
 F  D  Q:IX=""
 . S IX=$O(VALMY(IX))
 . Q:IX=""
 . S DLINE=$S(DLINE="":IX,1:DLINE_","_IX)
 . S EIEN=$G(^TMP($J,WLIST,IX))
 . S EIENS=$S(EIENS="":EIEN,1:EIENS_","_EIEN)
 Q EIENS
