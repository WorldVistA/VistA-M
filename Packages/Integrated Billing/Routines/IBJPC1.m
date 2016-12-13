IBJPC1 ;ALB/FA - Site Parameter HCSR Screens, Nodes 63-66 ;03-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
EN(WHICH) ;EP
 ; Main entry point for HCSR Site Parameters, nodes 63-66
 ; Input: WHICH     - 1 - Using template IBJP HCSR CLINICS
 ;                    2 - Using template IBJP HCSR WARDS
 ;                    3 - Using template IBJP HCSR ADM INSCO
 ;                    4 - Using template IBJP HCSR APPT INSCO
 N TEMPLATE
 S TEMPLATE=$S(WHICH=1:"IBJP HCSR CLINICS",WHICH=2:"IBJP HCSR WARDS",1:"")
 S:TEMPLATE="" TEMPLATE=$S(WHICH=3:"IBJP HCSR ADM INSCO",1:"IBJP HCSR APPT INSCO")
 D EN^VALM(TEMPLATE)
 Q
 ;
HDR(WHICH) ;EP
 ; Header code for HCSR Site Parameters, nodes 63-66
 ; Input: WHICH     - 1 - Using template IBJP HCSR CLINICS
 ;                    2 - Using template IBJP HCSR WARDS
 ;                    3 - Using template IBJP HCSR ADM INSCO
 ;                    4 - Using template IBJP HCSR APPT INSCO
 ;
 S VALMHDR(1)="Only authorized persons may edit this data."
 S:WHICH=1 VALMHDR(2)="Clinics Included in the Search:"
 S:WHICH=2 VALMHDR(2)="Wards Included in the Search:"
 S:WHICH=3 VALMHDR(2)="Insurance Companies Included in the Admissions Search:"
 S:WHICH=4 VALMHDR(2)="Insurance Companies Included in the Appointment Search:"
 Q
 ;
INIT(WHICH) ;EP
 ; Initialize variables and list array
 ; Input:   WHICH               - 1 - Using template IBJP HCSR CLINICS
 ;                                2 - Using template IBJP HCSR WARDS
 ;                                3 - Using template IBJP HCSR ADM INSCO
 ;                                4 - Using template IBJP HCSR APPT INSCO
 ; Output:  ^TMP("IBJPC1",$J)   - Body lines to display for specified template
 K ^TMP("IBJPC1",$J),^TMP($J,"IBJPC1IX")
 D BLD(WHICH)
 Q
 ;
BLD(WHICH) ; Build screen array, no variables required for input
 ; Input:   WHICH               - 1 - Using template IBJP HCSR CLINICS
 ;                                2 - Using template IBJP HCSR WARDS
 ;                                3 - Using template IBJP HCSR ADM INSCO
 ;                                4 - Using template IBJP HCSR APPT INSCO
 ; Output:  ^TMP("IBJPC1",$J)   - Body lines to display for specified template
 ;
 N ALLPYR,CNT,ENTRIES,LINE,NAME,NAMEIEN,NODE,NODE0,TOTPYR,Z
 S VALMCNT=0
 S NODE=$S(WHICH=1:63,WHICH=2:64,WHICH=3:66,1:65)
 S (Z,CNT)=0
 F  D  Q:+Z=0
 . S Z=$O(^IBE(350.9,1,NODE,Z))
 . Q:+Z=0
 . S NODE0=$G(^IBE(350.9,1,NODE,Z,0)),NAMEIEN=+$P(NODE0,"^",1)
 . I NAMEIEN>0 D
 . . S CNT=CNT+1,NAME=$$EXTERNAL^DILFD(350.9_NODE,.01,"",NAMEIEN)
 . . I NAME'="" D
 . . . S ENTRIES(NAME,CNT)=NAMEIEN,ENTRIES(NAME,CNT,"IEN")=Z
 I '$D(ENTRIES) D  Q
 . S LINE=$$SETL("","","** No entries found **",29,22)
 . S ^TMP("IBJPC1",$J,1,0)=LINE
 S NAME=""
 F  D  Q:NAME=""
 .S NAME=$O(ENTRIES(NAME)) Q:NAME=""
 .S Z=0 F  D  Q:Z=""
 ..S Z=$O(ENTRIES(NAME,Z)) Q:Z=""
 ..S VALMCNT=VALMCNT+1
 ..;
 ..; Build the display line - Insurances have multi-columns
 ..I WHICH<3 D
 ...S LINE=$$SETL("",VALMCNT,"",1,4)
 ...S LINE=$$SETL(LINE,NAME,"",6,30)
 ...S ALLPYR=$$ISALL^IBJPC3(NODE,ENTRIES(NAME,Z,"IEN"))
 ...I ALLPYR S LINE=$$SETL(LINE,"- for all payers","",37,42)
 ...I 'ALLPYR D
 ....S TOTPYR=$$GETTOT^IBJPC3(NODE,ENTRIES(NAME,Z,"IEN"))
 ....I 'TOTPYR S LINE=$$SETL(LINE,"- for no payers","",37,42) Q
 ....S LINE=$$SETL(LINE,"- for "_TOTPYR_" payer"_$S(TOTPYR>1:"s",1:""),"",37,42)
 ....Q
 ...Q
 ..E  S LINE=$$BLDLN(VALMCNT,NAME,ENTRIES(NAME,Z))
 ..D SET^VALM10(VALMCNT,LINE,VALMCNT)
 ..S ^TMP($J,"IBJPC1IX",VALMCNT)=ENTRIES(NAME,Z,"IEN")
 ..Q
 .Q
 Q
 ;
BLDLN(CTR,NAME,IEN) ; Builds a line to display and insurance
 ; Input:   CTR     - Current Line Counter
 ;          NAME    - Insurance Company Name
 ;          IEN     - IEN of the insurance to be displayed
 ; Output:  LINE    - Formatted for setting into the list display
 N LINE,XX
 S LINE=$$SETSTR^VALM1(CTR,"",1,4)                  ; Entry #
 S LINE=$$SETSTR^VALM1(NAME,LINE,6,30)              ; Insurance Name
 S XX=$$GET1^DIQ(36,IEN_",",.111)
 S LINE=$$SETSTR^VALM1(XX,LINE,39,35)               ; Address line1
 S XX=$$GET1^DIQ(36,IEN_",",.115,"I")
 S XX=$$GET1^DIQ(5,XX_",",1)                        ; State Abbreviation
 S LINE=$$SETSTR^VALM1(XX,LINE,77,2)                ; State
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
HELP(WHICH) ;EP
 ; Help code
 ; Input: WHICH     - 1 - Using template IBJP HCSR CLINICS
 ;                    2 - Using template IBJP HCSR WARDS
 ;                    3 - Using template IBJP HCSR ADM INSCO
 ;                    4 - Using template IBJP HCSR APPT INSCO
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT(WHICH) ;EP
 ; Exit code
 ; Input: WHICH     - 1 - Using template IBJP HCSR CLINICS
 ;                    2 - Using template IBJP HCSR WARDS
 ;                    3 - Using template IBJP HCSR ADM INSCO
 ;                    4 - Using template IBJP HCSR APPT INSCO
 K ^TMP("IBJPC1",$J),^TMP($J,"IBJPC1IX")
 D CLEAR^VALM1
 Q
 ;
ADD(WHICH) ;EP
 ; Listman Protocol Action to add an entry to the specified Site Parameter node
 ; Input:   WHICH   - 1 - Adding to the Clinic Search inclusion list
 ;                    2 - Adding to the Ward Search inclusion list
 ;                    3 - Adding to the Admission Search inclusion list
 ;                    4 - Adding to the Appointment Search inclusion list
 N DA,DIK,DIR
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FDA,IEN,IENS,INSM,INSMC
 N NODE,NAME,NAMEU,NODE0,TYPE,X,XX,Y,Z,Z1,CNT
 S NODE=$S(WHICH=1:63,WHICH=2:64,WHICH=3:66,1:65)
 S TYPE=$S(WHICH=1:"Clinic",WHICH=2:"Ward",1:"Insurance Company")
 S VALMBCK="R"       ; Refresh screen on return
 Q:'$$LOCK(NODE)     ; Couldn't lock for adding
 D FULL^VALM1
 D WARNMSG           ; Display warning message
 ;
 I '$$ENTSEL(NODE,.IENS,WHICH) D  Q  ; Select entry(s) to be added
 . S VALMSG="No "_TYPE_" selected"
 . D UNLOCK(NODE)
 I ($O(IENS(""))'=$O(IENS(""),-1)) D
 . I NODE>64 S TYPE="Insurance Companies" Q
 . S TYPE=TYPE_"s"
 ;
 ; check for 'MEDICARE/MEDICAID' insurance companies
 I WHICH>2 D
 .S INSMC=0,IEN=0 F  D  Q:'IEN
 ..S IEN=$O(IENS(IEN)) Q:'IEN
 ..S NAME=$$EXTERNAL^DILFD(350.9_NODE,.01,"",+IEN)
 ..S NAMEU=$$UP^XLFSTR(NAME)
 ..I (NAMEU["MEDICAID")!(NAMEU["MEDICARE") S INSMC=INSMC+1,INSM(INSMC)=NAME
 ..Q
 .I $D(INSM) D
 ..S:INSMC=1 XX="The following Insurance Company record"
 ..S:INSMC>1 XX="The following "_INSMC_" Insurance Company records"
 ..S XX=XX_$S(INSMC>1:" are ",1:" is ")_"for MEDICARE or MEDICAID:"
 ..S DIR(0)="EA",DIR("A",1)=XX
 ..S Z1=0,Z=1 F  D  Q:'Z1
 ...S Z1=$O(INSM(Z1)) Q:'Z1
 ...S Z=Z+1,DIR("A",Z)=INSM(Z1)
 ...Q
 ..S DIR("A")="Press RETURN to continue "
 ..D ^DIR
 ..Q
 .; Add the selected entries into the list for ins. companies
 .S IEN="",CNT=0 F  D  Q:IEN=""
 ..S IEN=$O(IENS(IEN)) Q:IEN=""
 ..S CNT=CNT+1
 ..S FDA("350.9"_NODE,"+1,1,",.01)=IEN
 ..S FDA("350.9"_NODE,"+1,1,",.02)=0
 ..D UPDATE^DIE("","FDA")
 ..Q
 .Q
 D UNLOCK(NODE) ; Unlock the Node
 ;
 I WHICH>2,$D(IENS) D
 . S DIR(0)="EA",Z=1
 . S DIR("A",Z)=" ",Z=Z+1
 . S DIR("A",Z)="The following "_CNT_" "_TYPE_" record"_$S(CNT>1:"s",1:"")_" added:",Z=Z+1
 . S Z1=0
 . F  S Z1=$O(IENS(Z1)) Q:'Z1  D
 .. S NAME=$$EXTERNAL^DILFD(350.9_NODE,.01,"",+Z1)
 .. S IENS(Z1)=NAME,DIR("A",Z)=NAME,Z=Z+1
 .. Q
 . S DIR("A",Z)=" ",Z=Z+1
 . S DIR("A")="Press RETURN to continue "
 . D ^DIR
 ;
 D INIT(WHICH) ; Rebuild list body
 S VALMSG="Added "_TYPE
 Q
 ;
DEL(WHICH) ;EP
 ; Listman Protocol Action to delete an entry from the specified Site Parameter
 ; node
 ; Input:   WHICH   - 1 - Deleting from the Clinic Search inclusion list
 ;                    2 - Deleting from the Ward Search inclusion list
 ;                    3 - Deleting from the Admission Search inclusion list
 ;                    4 - Deleting from to the Appt Search exclusion list
 ;
 N CNT,DA,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIST,NAME
 N NODE,NODE0,SELSTR,STR,TYPE,X,XX,Y,Z,Z1
 S NODE=$S(WHICH=1:63,WHICH=2:64,WHICH=3:66,1:65)
 S TYPE=$S(WHICH=1:"Clinic",WHICH=2:"Ward",1:"Insurance Company")
 S VALMBCK="R"    ; Refresh screen on return
 Q:'$$LOCK(NODE)  ; Couldn't lock for deletion
 D FULL^VALM1
 D WARNMSG       ; Display warning message
 S STR=$$SELEVENT^IBTRH1(0,"",.SELSTR,1,"IBJPC1IX")
 ;
 ; Check for 'MEDICARE/MEDICAID' entries (ins. companies only)
 I STR'="" D
 . F Z=1:1:$L(STR,",") D
 . . S Z1=$P(STR,",",Z),NODE0=$G(^IBE(350.9,1,NODE,Z1,0))
 . . S NAME=$$EXTERNAL^DILFD(350.9_NODE,.01,"",+$P(NODE0,"^",1))
 . . S LIST(Z1)=NAME
 ;
 ; Delete the selected entries from the list
 S DA(1)=1,(CNT,DA)=0
 F  S DA=$O(LIST(DA)) Q:'DA  D
 . S CNT=CNT+1,DIK="^IBE(350.9,"_DA(1)_","_NODE_","
 . D ^DIK
 S DIR(0)="EA",Z=1
 S DIR("A",Z)=" ",Z=Z+1
 I STR="" S DIR("A",Z)="No "_TYPE_" records selected",Z=Z+1
 I STR'="" D
 . I $D(LIST) D 
 . . S DIR("A",Z)="The following "_CNT_" "_TYPE_" record"_$S(CNT>1:"s",1:"")_" deleted:",Z=Z+1
 . . S Z1=0
 . . F  S Z1=$O(LIST(Z1)) Q:'Z1  S DIR("A",Z)=LIST(Z1),Z=Z+1
 S DIR("A",Z)=" ",Z=Z+1
 S DIR("A")="Press RETURN to continue "
 D ^DIR
 D UNLOCK(NODE)          ; Unlock Site Parameter node
 I STR'="" D INIT(WHICH) ; Rebuild list body
 Q
 ;
WARNMSG ;EP
 ; Displays a warning message to the user when they modify site parameters
 ; Input:   None
 ; Output:  Warning message displayed
 W !!,"**Warning**"
 W !,"Changing the value in CPAC/TRICARE/CHAMPVA parameters will affect the Health"
 W !,"Care Services Review Worklist.",!!
 Q
 ;
ENTSEL(NODE,IENS,WHICHF)   ; Selects an entry to be added to the specified Site Parameter Node
 ; Input:
 ;      NODE        - Site Parameter node where the data resides
 ;      WHICHF      - 1 - Adding/Deleting to the Clinic Search 
 ;                        inclusion list
 ;                    2 - Adding/Deleting to the Ward Search inclusion
 ;                        list
 ;                    3 - Adding/Deleting to the Admission Search
 ;                        exclusion list
 ;                    4 - Adding/Deleting to the Appointment Search
 ;                        exclusion list
 ; Output:   IENS       - Array of selected IEN(s), "" if not selected
 ; Returns:  1          - At least one IEN selected, 0 otherwise
 N DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FDA,IENARY,IX,STOP,STOP2,TYPE,X,XX,Y,Z
 K IENS
 S STOP=0
 S TYPE=$S(NODE=63:"a Clinic",NODE=64:"a Ward",1:"an Insurance Company")
 S DIC=$S(NODE=63:44,NODE=64:42,1:36)
 S DIC(0)="AEQM"
 S DIC("A")="Select "_TYPE_" to be added: "
 ;
 ; Set the Add filter
 S XX="I '$D(^IBE(350.9,1,"_NODE_",""B"",Y))"
 S XX=XX_"&'$D(IENS(+Y))"
 S DIC("S")=XX
 F  D  Q:STOP
 .D ^DIC
 .I Y'>0 S STOP=1 Q
 .S IENS(+Y)=""
 .D:WHICHF>2 ADDBYEID(+Y,.IENS)
 .; create entry for clinic / ward - need to do it here for payer assoc.
 .I WHICHF'>2 D
 ..K FDA,IENARY
 ..S FDA("350.9"_NODE,"+1,1,",.01)=+Y
 ..S FDA("350.9"_NODE,"+1,1,",.02)=0
 ..D UPDATE^DIE("","FDA","IENARY")
 ..I +$G(IENARY(1)) D ADDPYR1^IBJPC3(NODE,IENARY(1))
 ..Q
 .Q
 ;
 I '$D(IENS) Q 0  ; No IENS selected
 Q 1
 ;
ADDBYEID(IEN,IENS)   ; Asks the user if they also want to add all Insurance
 ; companies with the same electronic payer ID.
 ; Input:   IEN     - IEN of the insurance company to be added
 ;          IENS()  - Current array of insurance companies to be added
 ; Output:  IENS()  - Updated array of insurance companies to be added
 N DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,PAYID,SPAYIEN,X,XX,Y
 S XX="Select YES to also add every insurance company with the same "
 S XX=XX_"electronic Payer ID."
 S DIR("?")=XX
 S DIR(0)="Y"
 S DIR("A")="Include all payers with the same electronic Payer ID?"
 S DIR("B")="NO"
 D ^DIR
 Q:Y=0
 S PAYID=$$GET1^DIQ(36,IEN_",",3.1,"I")
 Q:PAYID=""
 S SPAYIEN=""
 F  D  Q:SPAYIEN=""
 . S SPAYIEN=$O(^DIC(36,"AC",PAYID,SPAYIEN))
 . Q:SPAYIEN=""
 . I $D(^IBE(350.9,1,NODE,"B",SPAYIEN)) Q  ;eliminate duplicates
 . S IENS(SPAYIEN)=""
 Q
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
 . S:NODE=62 TEXT="Other Parameters."
 . S:NODE=63 TEXT="Clinics Included in the Search List."
 . S:NODE=64 TEXT="Ward Included in the Search List."
 . S:NODE=65 TEXT="Insurances Included in the Appointment Search List."
 . S:NODE=66 TEXT="Insurances Included in the Admissions Search List."
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
