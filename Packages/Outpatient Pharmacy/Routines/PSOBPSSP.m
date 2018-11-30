PSOBPSSP ;BIRM/LE - ePharmacy Site Parameters Definition ;04/28/08
 ;;7.0;OUTPATIENT PHARMACY;**289,385,421,427**;DEC 1997;Build 21
 ;
 ; Patch 421 replaced all logic in this module as the original 
 ; screen has been replaced by a List Manager screen.
 ;  
 ; GETDATA^PSOBPSSP - Populates the List Manager Array
 ; EN^PSOBPSSL - Site parameter lister
 ;         
EN ; - Prompt for ePharmacy Site Parameters
 ;
 ; PSODIV is the IEN of the initially selected division
 ; PSOBPSDV is the IEN of the current ePharmacy division being edited.
 ; PSOSITE & PSOPAR are populated by the call to ^PSOLSET in DIV
 ;
 ; LOCK THE SITE PARAMETER FILE
 L +^PS(52.86,"LOCK"):0
 I '$T D  Q
 . W !!?2,"Sorry, another user is currently using the ePharmacy Site Parameters option."
 . W !?2,"Please try again later."
 . D PAUSE^VALM1
 . Q
 ;
 N PSODIV,PSOBPSDV,PSOSITE,PSOPAR
 D DIV
 I '$G(PSOSITE) L -^PS(52.86,"LOCK") Q
 ;
 ; Informational Messages
 D TRCMSG^PSOBPSSL,RRRMSG^PSOBPSSL W !
 ;
 D EN^VALM("PSO EPHARM SITE PARAMS")
 L -^PS(52.86,"LOCK")       ; option level unlock
 Q
 ;
HDR ; -- header code -- PSO EPHARM SITE PARAMS
 S VALMHDR(1)="Pharmacy Division: "_$$GET1^DIQ(52.86,PSOBPSDV_",",.01)
 Q
 ;
INIT ; -- init variables and list array -- PSO EPHARM SITE PARAMS
 ; PSOBPSDV is the IEN of the current division being edited. (NEWed in EN)
 ; Get the division number
 K PSOBPSDV D GETDIV(.PSOBPSDV)
 I '$D(PSOBPSDV) S VALMQUIT=1 Q
 D RBUILD
 Q
 ;
HELP ; -- help code -- PSO EPHARM SITE PARAMS
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 ;
 K PSOBPSDV,PSODIV,^TMP("PSOBPSSP",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
GETDIV(DIV) ; Gets a single division.  If it does not exist, the new division is created
 ; and the user is prompted for worklist days.
 ; Called by INIT on entry and when Change Division action is selected
 ; DIV - ePharmacy site parameter IEN - Parameters for division pointed to in .01 field
 ;
 N DIC,DTOUT,DUOUT,DLAYGO,X,Y ; Variables for ^DIC
 S DIC("A")="Select a Pharmacy Division: " S DIC=52.86,DIC(0)="AEBQL",DLAYGO=52.86 D ^DIC
 Q:($G(DTOUT))!($D(DUOUT)!(Y<0))
 S DIV=$P(Y,U,1)
 Q
 ;
BLDLIST(DIV) ; Rebuilds the List Manager array
 ;
 ; DIV is the IEN of the current division being edited. (NEWed in EN)
 ; LINECT - keeps track of the line count in the display list
 ; LMARRAY - List Manager Array Name
 ;
 N LMARRAY,LINECT
 ;
 ; Initialize the Line Counter
 S LINECT=0
 ;
 ; This is the List Manager Array
 D CLEAN^VALM10
 S LMARRAY=$NA(^TMP("PSOBPSSP",$J)) K @LMARRAY
 ;
 ; Get the current data for the selected division
 D GETDATA^PSOBPSSL(DIV,LMARRAY,.LINECT)
 S VALMCNT=LINECT
 Q
 ;
DIV ; Establish the PSO Site information - Also called by PSOBPSSL Division/Site selection
 ;
 ; PSOSITE and PSOPAR are set by ^PSOLSET - Declared in EN of calling routines
 ;
 I '$G(PSOSITE) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! Q
 W !!
 Q
 ;
CPYSITES(DIVS,CTR,CDIV,SCR) ; Procedure for picking sites for the copy function.
 ; Cloned from SEL^PSOREJU1 with changes for Site Parameter Copy action
 ; 
 ; Input Parameters
 ; DIVS - passed by reference and will hold the divisions to process
 ; CTR - passed by reference, returns the number of divisions picked.
 ; CDIV - source site parameter pharmacy division IEN (ptr to file 59).
 ; SCR - Screen to prevent source division from being selected.
 ;
 ; Variables used by ^DIC
 N DIC,DTOUT,DUOUT,Y,X
 ;
 ; Local Variables
 ; PSOI - Pharmacy IEN from file 59
 ; QT - used to control when to exit
 ; CTR -counts the number of sites selected 
 N PSOI,QT
 ;
 S (QT,CTR)=0
 ;
 ; Instructional message
 W !,"You may select a single or multiple Pharmacy Divisions,"
 W !,"or enter ^ALL to select all Pharmacy Divisions.",!
 ;
 ; Set up ^DIC call
 K DIVS S DIC="^PS(59,",DIC(0)="QEZAM"
 S DIC("A")="Select a Pharmacy Division to be overwritten: "
 S DIC("S")=$G(SCR)
 ; 
 ; Loop through Selections
 F  D ^DIC Q:X=""!QT  D  Q:QT
 . ;
 . ; Special processing if ^ALL was entered
 . I $$UP^XLFSTR(X)="^ALL" K DIVS S CTR=0,DIVS="ALL",QT=1 D  Q
 . . S PSOI=0 F  S PSOI=$O(^PS(59,PSOI)) Q:'PSOI  D:PSOI'=CDIV
 . . . S CTR=CTR+1,DIVS(PSOI)=$$GET1^DIQ(59,PSOI,.01)
 . ;
 . ; Quit if timeout or a ^
 . I $G(DTOUT)!$G(DUOUT) K DIVS S DIVS="^",QT=1 Q
 . ;
 . ; do not save if the source division is picked
 . I +Y=CDIV W !,"The source Pharmacy Division cannot be copied to itself."
 . ;
 . ; Do not allow duplicate selections
 . I +Y'=CDIV,$D(DIVS(+Y)) W $P(Y,U,2)_" is already selected." Q
 . ;
 . ; Processing for selected divisions
 . S DIVS(+Y)=$P(Y,U,2),CTR=CTR+1
 . ;
 . ; prompt for another division
 . W ! S DIC("A")="ANOTHER ONE: " K DIC("B")
 . Q
 ;
 I '$D(DIVS) S DIVS="^"
 Q
 ;
COPYSP ; Action for CP Copy Parameters
 ; From EN
 ; PSOBPSDV - source site parameter IEN of 52.86 - defined in EN
 ;
 ; Local Variables
 ; CDIV - current site parameter division to copy to
 ; CPDIV - source site parameter pharmacy division IEN (ptr to file 59)
 ; CPYDIVS - array pharmacy divisions where to copy parameters
 ;     NOTE: The subscripts for CPYDIVS will be the selected IENS from file 59
 ; CPYFDA - FDA array used in UPDATE^DIE calls
 ; CPNAME - source site parameter pharmacy division name from file 59
 ; DIVCT -  holds the return value of the number so sites picked when CPYSITES is called
 ; IROOT - Returns new IEN after UPDATE^DIE
 ; PARAMS - local array to hold the parameters from the source site
 ; PSOI & PSOJ - loop counters
 N CDIV,CPDIV,CPYFDA,CPYDIVS,CPNAME,DIVCT,IROOT,PARAMS,PSOI,PSOJ
 ;
 ; Used by ^DIK
 N DIK,DA
 ;
 ; Used by ^DIR
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 ; Set Full Screen mode
 D FULL^VALM1
 ;
 ; Get the current ePharmacy Site Parameter IEN and division name
 S CPDIV=$$GET1^DIQ(52.86,PSOBPSDV_",",.01,"I")
 S CPNAME=$$GET1^DIQ(52.86,PSOBPSDV_",",.01,"E")
 ;
 ; FIRST PART OF INSTRUCTION MESSAGE
 W !!,"The parameters will be copied from "_CPNAME_" Division.",!
 W !,"Select the Pharmacy Division(s) to overwrite."
 ;
 ; Select the desired divisions where to copy parameters
 ;    The screen value ("I $QS($NA(^(0)),2)'="_CPDIV) will
 ;    eliminate the source division from the copy to choices
 D CPYSITES(.CPYDIVS,.DIVCT,CPDIV,"I $QS($NA(^(0)),2)'="_CPDIV)
 ;
 ; Quit if no divisions selected
 I $D(CPYDIVS)<10!(+$G(DIVCT)=0) G EXITCPY
 ;
 ; Are you sure code
 ;
 ; Get and display current pharmacy name
 S CPNAME=$$GET1^DIQ(52.86,PSOBPSDV_",",.01)
 W !!,"The parameters from Pharmacy Division "_CPNAME
 W !,"will overwrite the parameters in Pharmacy Division"_$S(DIVCT>1:"s:",1:":")
 ;
 ; Loop through all the divisions returned by CPYSITES and display their names
 S PSOI=0 W ! F  S PSOI=$O(CPYDIVS(PSOI)) Q:'PSOI  W !,CPYDIVS(PSOI)
 ;
 ; Are you sure code
 W !! S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="NO" D ^DIR
 I ('Y)!($G(DUOUT))!($G(DTOUT)) G EXITCPY
 ;
 ; Load the source division parameters
 D GETS^DIQ(52.86,PSOBPSDV_",","**","I","PARAMS")
 ; Copy the division settings (except user updated by and date/times - these are triggered)
 S PSOI=0 F  S PSOI=$O(CPYDIVS(PSOI)) Q:'PSOI  D
 . ;
 . ; If the parameters exist for this division, delete them
 . S CDIV=0,CDIV=$O(^PS(52.86,"B",PSOI,CDIV)) ; Check B index for pharmacy division
 . I CDIV S DA=CDIV,DIK="^PS(52.86," D ^DIK ; Delete parameters if they exist
 . ;
 . ; Create the FDA and file the general parameters
 . K CPYFDA
 . S CPYFDA(52.86,"+1,",.01)=PSOI
 . S CPYFDA(52.86,"+1,",4)=+$G(PARAMS(52.86,PSOBPSDV_",",4,"I"))
 . K IROOT D UPDATE^DIE(,"CPYFDA","IROOT") S CDIV=IROOT(1)
 . ;
 . ; Loop through and copy the transfer reject codes
 . ; Create the FDA and UPDATE the subfile 52.8651
 . I $D(PARAMS(52.8651)) S PSOJ=0 F  S PSOJ=$O(PARAMS(52.8651,PSOJ)) Q:'PSOJ  D
 . . K CPYFDA
 . . S CPYFDA(52.8651,"+1,"_CDIV_",",.01)=PARAMS(52.8651,PSOJ,.01,"I")
 . . S CPYFDA(52.8651,"+1,"_CDIV_",",1)=PARAMS(52.8651,PSOJ,1,"I")
 . . D UPDATE^DIE(,"CPYFDA")
 . . Q
 . ;
 . ; Loop through and copy the reject resolution required codes
 . ; Create the FDA and UPDATE the subfile 52.865
 . I $D(PARAMS(52.865)) S PSOJ="" F  S PSOJ=$O(PARAMS(52.865,PSOJ)) Q:'PSOJ  D
 . . K CPYFDA
 . . S CPYFDA(52.865,"+1,"_CDIV_",",.01)=PARAMS(52.865,PSOJ,.01,"I")
 . . S CPYFDA(52.865,"+1,"_CDIV_",",.02)=PARAMS(52.865,PSOJ,.02,"I")
 . . D UPDATE^DIE(,"CPYFDA")
 . . Q
 . Q
EXITCPY ;
 D RBUILD
 Q
 ;
EDITALL ; Action for EA Edit All Parameters
 ;
 ; Local variable
 ; RET - for control after return from call - if "^" then call RBUILD and quit
 N RET S RET=""
 ;
 ; Call to General Parameter Edit
 D EDITGEN(.RET)
 I RET=U D RBUILD Q
 ;
 ; Call to Transfer Reject Code Edit
 D EDITTRC(.RET)
 I RET=U D RBUILD Q
 ;
 ; Call to Reject Resolution Required Code Edit
 D EDITRRRC
 ;
 D RBUILD
 Q
 ;
EDITGEN(RETURN) ; Action for EG Edit General Parameters
 ;
 ; Input Parameter
 ; RETURN - Null if normal exit, "^" if timeout or "^" entered
 ;
 ; Variables used by DIE
 N DIE,DA,DIC,DUOUT,DTOUT,DEF
 ;
 ; Set Full Screen mode
 D FULL^VALM1
 ;
 ; Get worklist days & update the record
 S DIE="^PS(52.86,",DA=PSOBPSDV,DR="4" D ^DIE
 ; CHECK FOR TIMEOUT OR ^
 I $G(DTOUT)!$D(Y) S RETURN="^"
 ;
 ; Update EPHARMACY RESPONSE PAUSE
 K DTOUT,DUOUT
 S DEF=$$GET1^DIQ(52.86,PSOBPSDV_",",6,"I")
 I DEF="" S DEF=2
 S DIE="^PS(52.86,",DA=PSOBPSDV,DR="6//"_DEF D ^DIE
 ; CHECK FOR TIMEOUT OR ^
 I $G(DTOUT)!$D(Y) S RETURN="^"
 ;
 D RBUILD
 Q
 ;
EDITTRC(RETURN)  ; Action for ET Edit Transfer Reject Code
 ;
 ; Input Parameter
 ; RETURN - Null if normal exit, "^" if timeout or "^" entered
 ;
 ; From EN
 ; PSOBPSDV - current division declared in EN
 ;
 ; Local Variables
 ; PASS1 - used to indicate first pass through edit loop for controlling reject prompt
 ; QT - indicates the loop processing can quit
 ;
 ; Set Full Screen mode
 D FULL^VALM1
 ;
 N QT,PASS1
 S QT=0,PASS1=1
 ;
 ; Informational message
 D TRCMSG^PSOBPSSL
 ;
 ; Loop through Reject Code edits
 F  Q:QT  D
 . ; DIE,DA,DIC,DUOUT,DTOUT,DIR,DIC,X,Y - Used by FileMan
 . N DIE,DR,DA,DUOUT,DTOUT,DIR,DIC,Y,X
 . ; Variables local to this loop
 . ; REJCODE - External Reject code - .01 field from 9002312.93
 . ; REJIEN - Reject code IEN from 9002312.93
 . ; ADD - Flag indicating a new code was selected
 . ; NEWCDPTR - IEN of the Reject Code in 9002313.92 when the user changed the Reject Code
 . ;
 . N REJCODE,REJIEN,ADD,NEWCDPTR
 . ;
 . ; Set up and call Lookup (^DIC)
 . S DIC("A")=$S(PASS1:"",1:"ANOTHER ")_"TRANSFER REJECT CODE: ",PASS1=0
 . S DIC=9002313.93
 . S DIC(0)="QEAZ"
 . S DIC("S")="I '$F("".79.88."","".""_$P($G(^(0)),U,1)_""."")"
 . W ! D ^DIC
 . ;
 . ; Check responses to the lookup
 . I $G(DUOUT)!($G(DTOUT)) S RETURN=U,QT=1 Q  ; user entered a ^, or timed out
 . I Y'>0 S QT=1 Q  ; user entered a blank to get out
 . ;
 . S REJIEN=+Y,REJCODE=$P(Y,U,2)
 . S ADD=0
 . ;
 . ; if new code, set up new node
 . I '$D(^PS(52.86,PSOBPSDV,1,"B",REJIEN)) D
 . . ; TRCFDA - FDA structure used by UPDATE^DIE
 . . N TRCFDA
 . . S ADD=1
 . . ;
 . . ;Set up FDA and File the data 
 . . S TRCFDA(52.8651,"+1,"_PSOBPSDV_",",.01)=REJIEN
 . . S TRCFDA(52.8651,"+1,"_PSOBPSDV_",",1)=0 ; Default AUTO SEND
 . . D UPDATE^DIE(,"TRCFDA")
 . . Q
 . ;
 . ; Edit the transfer reject code entry
 . S DA=$O(^PS(52.86,PSOBPSDV,1,"B",REJIEN,0)) Q:'DA
 . S DA(1)=PSOBPSDV
 . S DIE="^PS(52.86,"_DA(1)_",1,"
 . S DR=".01"
 . I ADD W !!?3,"You are entering a new transfer reject code - "_REJCODE_"."
 . E  W !!?3,"You are editing an existing transfer reject code - "_REJCODE_"."
 . D ^DIE
 . ;
 . I '$G(DA) Q  ; user deleted it so we're done
 . I $G(DTOUT) S RETURN=U,QT=1 Q  ; timeout - exit loop
 . I $D(Y) S RETURN=U,QT=1 Q  ; user entered a ^ to exit loop
 . ;
 . ; If the user changed the reject code, check for duplicate OR 79/88
 . ; Get the current pointer filed by DIE and compare it to the original pointer
 . S DA=+$G(DA),NEWCDPTR=$P($G(^PS(52.86,PSOBPSDV,1,DA,0)),U,1)
 . I NEWCDPTR'=REJIEN D
 . . ; CTR - used in duplicate check. # of records with same code value
 . . ; IEN - used when checking the "B" index for duplicates using $ORDER
 . . N CTR,IEN
 . . ; NEWCDPTR - holds the new reject code after the user changes it
 . . S (CTR,IEN)=0
 . . F  S IEN=$O(^PS(52.86,PSOBPSDV,1,"B",NEWCDPTR,IEN)) Q:'IEN  S CTR=CTR+1
 . . I CTR>1 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"You selected a duplicate reject code.  Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . I $$GET1^DIQ(9002313.93,NEWCDPTR_",",.01)=79 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"Code '79/RTS' is not valid here.  Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . I $$GET1^DIQ(9002313.93,NEWCDPTR_",",.01)=88 D  Q
 . . . W !!?3,"Reject code '88/DUR' is not valid here. Code '"_REJCODE_"' has been restored."
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . Q
 . ; NEWCDPTR will be 0 if the user tried to enter an invalid or duplicate reject code
 . Q:'NEWCDPTR
 . ;
 . ; Now edit the AUTO SAVE parameter
 . S DA(1)=PSOBPSDV
 . S DIE="^PS(52.86,"_DA(1)_",1,"
 . S DR="1"
 . D ^DIE
 . ;
 . I $G(DTOUT) S RETURN=U,QT=1 Q  ; timeout - exit loop
 . I $D(Y) S RETURN=U,QT=1 Q  ; user entered a ^ to exit loop
 . Q
 . ;
 S VALMBG=1
 D RBUILD
 Q
 ;
EDITRRRC(RETURN)  ; Action for ER Edit Reject Resolution Required Code
 ;
 ; Input Parameter
 ; RETURN - Null if normal exit, "^" if timeout or "^" entered
 ;
 ; From EN
 ; PSOBPSDV - current division declared in EN
 ;
 ; Local Variables
 ; PASS1 - used to indicate first pass through edit loop for controlling reject prompt
 ; QT - indicates the loop processing can quit
 ;
 ; Set Full Screen mode
 D FULL^VALM1
 ;
 N QT,PASS1
 S QT=0,PASS1=1
 ;
 ; Informational message
 D RRRMSG^PSOBPSSL
 ;
 ; Loop through Reject Code edits
 F  Q:QT  D
 . ; DIE,DA,DIC,DUOUT,DTOUT,DIR,DIC,X,Y - Used by FileMan
 . N DIE,DR,DA,DUOUT,DTOUT,DIR,DIC,Y,X
 . ; Variables local to this loop
 . ; REJCODE - External Reject code - .01 field from 9002312.93
 . ; REJIEN - Reject code IEN from 9002312.93
 . ; ADD - Flag indicating a new code was selected
 . ; NEWCDPTR - IEN of the Reject Code in 9002313.92 when the user changed the Reject Code
 . ;
 . N REJCODE,REJIEN,ADD,NEWCDPTR
 . ;
 . ; Set up and call Lookup (^DIC)
 . S DIC("A")=$S(PASS1:"",1:"ANOTHER ")_"REJECT RESOLUTION REQUIRED CODE: ",PASS1=0
 . S DIC=9002313.93
 . S DIC(0)="QEAZ"
 . S DIC("S")="I '$F("".79.88."","".""_$P($G(^(0)),U,1)_""."")"
 . W ! D ^DIC
 . ;
 . ; Check responses to the lookup
 . I $G(DUOUT)!($G(DTOUT)) S RETURN=U,QT=1 Q  ; user entered a ^, or timed out
 . I Y'>0 S QT=1 Q  ; user entered a blank to get out
 . ;
 . S REJIEN=+Y,REJCODE=$P(Y,U,2)
 . S ADD=0
 . ;
 . ; if new code, set up new node
 . I '$D(^PS(52.86,PSOBPSDV,5,"B",REJIEN)) D
 . . ; RRRCFDA - FDA structure used by UPDATE^DIE
 . . N RRRCFDA
 . . S ADD=1
 . . ;
 . . ;Set up FDA and File the data 
 . . S RRRCFDA(52.865,"+1,"_PSOBPSDV_",",.01)=REJIEN
 . . S RRRCFDA(52.865,"+1,"_PSOBPSDV_",",.02)=0 ; Default DOLLAR THRESHOLD
 . . D UPDATE^DIE(,"RRRCFDA")
 . . Q
 . ;
 . ; Edit the transfer reject code entry
 . S DA=$O(^PS(52.86,PSOBPSDV,5,"B",REJIEN,0)) Q:'DA
 . S DA(1)=PSOBPSDV
 . S DIE="^PS(52.86,"_DA(1)_",5,"
 . S DR=".01REJECT RESOLUTION REQUIRED CODE"
 . I ADD W !!?3,"You are entering a new reject resolution required code - "_REJCODE_"."
 . E  W !!?3,"You are editing an existing reject resolution required code - "_REJCODE_"."
 . D ^DIE
 . ;
 . I '$G(DA) Q  ; user deleted it so we're done
 . I $G(DTOUT) S RETURN=U,QT=1 Q  ; timeout - exit loop
 . I $D(Y) S RETURN=U,QT=1 Q  ; user entered a ^ to exit loop
 . ;
 . ; If the user changed the reject code, check for duplicate OR 79/88
 . ; Get the current pointer filed by DIE and compare it to the original pointer
 . S DA=+$G(DA),NEWCDPTR=$P($G(^PS(52.86,PSOBPSDV,5,DA,0)),U,1)
 . I NEWCDPTR'=REJIEN D
 . . ; CTR - used in duplicate check. # of records with same code value
 . . ; IEN - used when checking the "B" index for duplicates using $ORDER
 . . N CTR,IEN
 . . ; NEWCDPTR - holds the new reject code after the user changes it
 . . S (CTR,IEN)=0
 . . F  S IEN=$O(^PS(52.86,PSOBPSDV,5,"B",NEWCDPTR,IEN)) Q:'IEN  S CTR=CTR+1
 . . I CTR>1 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"You selected a duplicate reject code.  Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . I $$GET1^DIQ(9002313.93,NEWCDPTR_",",.01)=79 D  Q
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . W !!?3,"Code '79/RTS' is not valid here.  Code '"_REJCODE_"' has been restored."
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . I $$GET1^DIQ(9002313.93,NEWCDPTR_",",.01)=88 D  Q
 . . . W !!?3,"Reject code '88/DUR' is not valid here. Code '"_REJCODE_"' has been restored."
 . . . S DR=".01////"_REJIEN D ^DIE   ; restore the code pointer
 . . . S NEWCDPTR=0 ; Clear the new pointer if it is no longer valid
 . . . Q
 . . Q
 . ; NEWCDPTR will be 0 if the user tried to enter an invalid or duplicate reject code
 . Q:'NEWCDPTR
 . ;
 . ; Now edit the DOLLAR THRESHOLD parameter
 . S DA(1)=PSOBPSDV
 . S DIE="^PS(52.86,"_DA(1)_",5,"
 . S DR=".02"
 . D ^DIE
 . ; Make sure stored value is not null
 . I '$G(DTOUT),$G(^PS(52.86,PSOBPSDV,5,DA,0)) D
 . . S $P(^PS(52.86,PSOBPSDV,5,DA,0),U,2)=+$P(^PS(52.86,PSOBPSDV,5,DA,0),U,2)
 . ;
 . I $G(DTOUT) S RETURN=U,QT=1 Q  ; timeout - exit loop
 . I $D(Y) S RETURN=U,QT=1 Q  ; user entered a ^ to exit loop
 . Q
 . ;
 S VALMBG=1
 D RBUILD
 Q
 ;
CHGDIV ; Action for CD Change Division
 ;
 ; From EN
 ; PSOBPSDV - source site parameter IEN of 52.86 - defined in EN
 ;
 ; Local Variable 
 ; TMPDIV - used to save the current division number in case the user does not pick one
 N TMPDIV
 ;
 ; Set Full Screen mode
 D FULL^VALM1
 ;
 ; save current division
 S TMPDIV=PSOBPSDV
 ;
 ; Kill the current division
 K PSOBPSDV
 ;
 ; Get the division number to process
 D GETDIV(.PSOBPSDV)
 ;
 ; if no division selected, restore current division
 I '$D(PSOBPSDV) D  Q
 . S PSOBPSDV=TMPDIV
 . D RBUILD
 S VALMHDR(1)="Pharmacy Division: "_$$GET1^DIQ(52.86,PSOBPSDV_",",.01)
 S VALMBG=1
 D RBUILD
 Q
 ;
DIVLIST ; Action for DP Display site parameters
 ;
 ; Set Full Screen mode
 D FULL^VALM1
 ;
 ; Call List Manager routine for displaying site parameters for multiple divisions
 D EN^PSOBPSSL
 ;
 D RBUILD
 Q
 ;
RBUILD ; rebuild the list and then exit with a refresh
 ;
 ; From EN
 ; PSOBPSDV - source site parameter IEN of 52.86 - defined in EN
 ;
 ; VALMBK - List Manager variable
 ;
 D BLDLIST(PSOBPSDV)
 ;
 S VALMBCK="R"
 Q
