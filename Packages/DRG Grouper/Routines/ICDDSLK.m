ICDDSLK ;KUM/SJA/SS - ICD-10 DIAGNOSIS CODE LOOK UP;12-06-11
 ;;18.0;DRG Grouper;**64**;Oct 20, 2000;Build 103
 ;
 ; ICDDATE is EFFECTIVE DATE that passed from Calling routine
EN ; ENTRY
 D INITVARS ;set standards variables, you might not need this if it was already done in your application  
 N ICDQUIT ; to manage demo loop
 N ICDRETV ;to store the selected code information
 N ICDPARAM ;  to set your application specific prompts and messages
 N ICDCSYS ;coding system "ICD9" or ICD10"
 N ICDOUT ;to return all available information about the selected code
 ;settings:
 D SETPARAM(.ICDPARAM) ;edit the SETPARAM subroutine below to set your application specific prompts
 ;starting demo loop
 S ICDQUIT=0 F  Q:ICDQUIT=1  D
 . S ICDRETV=0,ICDOUT=""
 . W @IOF ;reset the screen
 . ;prompt for the date of interest
 . I $G(ICDDATE)="" D EFFDATE^ICDDRGM G EXIT:$D(DUOUT),EXIT:$D(DTOUT)
 . I $G(ICDDATE)'="" S ICDDT=ICDDATE
 . ;prompt for "try again" with "No" as default if ^ or null entered for the date or if timed out
 . I ICDDT'>0 S:$$QUESTION(2,ICDPARAM("TRY ANOTHER"))'=1 ICDQUIT=1 Q
 . ;determine coding system based on the date of interest 
 . S ICDCSYS=$$ICDSYSDG(ICDDT)
 . ;set default response for your prompt
 . S ICDDFLT=""
 . ;If coding system is ICD9 change ICDDT and prompt for ICD-10 so that user can query ICD-10 codes before ICD-10 implementaiton date
 . I ICDCSYS=1 S ICDCSYS=30 S ICDDT=$$IMPDATE^LEXU("10D")
 . ;run either ICD9 or ICD10 prompt/search/select logic
 . ;ICD9 (1 is a pointer to the ICD-9-CM diagnosis system entry in the new file #80.4 )
 . I ICDCSYS=1 S ICDRETV=$$DIAG9(ICDDT,ICDDFLT,.ICDOUT,.ICDPARAM) I ICDRETV=-2 S:$$QUESTION(1,ICDPARAM("TRY ANOTHER"))'=1 ICDQUIT=1 Q
 . ;ICD10 (30 is a pointer to the ICD-10-CM diagnosis system entry in the new file #80.4 )
 . I ICDCSYS=30 S ICDRETV=$$DIAG10(ICDDT,ICDDFLT,.ICDPARAM)
 . ;display information about the code selected (for demo purposes)
 . I ICDRETV>0 W !,"SELECTED: " D CODEINFO(ICDRETV) S:$$QUESTION(1,ICDPARAM("TRY ANOTHER"))'=1 ICDQUIT=1 Q
 . ;no changes to the default value 
 . I ICDRETV=-5 S:$$QUESTION(1,ICDPARAM("NO CHANGES"))'=1 ICDQUIT=1 Q
 . ;if no data found
 . I ICDRETV="" W !!,ICDPARAM("NO DATA FOUND") S:$$QUESTION(1,ICDPARAM("TRY ANOTHER"))'=1 ICDQUIT=1 Q
 . ;in ICD10 if the user answered NO for the question "Do you wish to continue(Y/N)?"
 . I ICDRETV=-4 S:$$QUESTION(1,ICDPARAM("TRY ANOTHER"))'=1 ICDQUIT=1 Q
 . ;no data or was aborted 
 . I ICDRETV=-2 S:$$QUESTION(1,ICDPARAM("TRY ANOTHER"))'=1 ICDQUIT=1 Q
 . ;if exit due to ^ in the ICD Diagnosis code prompt 
 . I ICDRETV=-3 S:$$QUESTION(2,ICDPARAM("TRY ANOTHER"))'=1 ICDQUIT=1 Q
 . ;if no data found
 . I ICDRETV=-1 S:$$QUESTION(2,ICDPARAM("TRY ANOTHER"))'=1 ICDQUIT=1 Q
 . ; if continue search
 . I ICDRETV=-6 W !,ICDPARAM("DELETE IT"),! S:$$QUESTION(1,ICDPARAM("TRY ANOTHER"))'=1 ICDQUIT=1 Q
 Q
 ;//---------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; ICDDT - date of interest, ICDDFLT - default values for hter search string (can be a code by default)
 ; ICDOUT - local array to return results (passed as a reference)
 ; ICDPARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; results
 ; or -1 if invalid data(press enter), "" if not found, or -2 if time out, or -3 if ^ or ^^, or -4 in ICD10 if the usre answered NO for the question "Do you wish to continue(Y/N)?", or -5 if no changes to the default value
DIAG10(ICDDT,ICDDFLT,ICDPARAM) ;
 N ICDINP
 F  D  Q:ICDINP<0!($L($P(ICDINP,U,2))>1)
 . S ICDINP=$$SRCHSTR(ICDPARAM("SEARCH_PROMPT"),ICDPARAM("HELP ?"),ICDPARAM("HELP ??"),ICDDFLT)
 . I ICDINP'<0 I $L($P(ICDINP,U,2))'>1 W !,ICDPARAM("ENTER MORE") W:$L(ICDPARAM("ENTER MORE2"))>0 !,ICDPARAM("ENTER MORE2") ;user should enter at least 2 characters
 I ICDINP<0 Q ICDINP
 Q $$LEXICD10($P(ICDINP,U,2),ICDDT,.ICDPARAM)
 ;//---------
 ;The entry point for ICD-9 FileMan type (^DIC) diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; ICDDT - date of interest, ICDDFLT - default values for hter search string (can be a code by default), ICDOUT - local array to return results(passed as a reference)
 ; ICDPARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-9 code selected by the user:
 ;  IEN file #80;ICD code value^description, -2 no data or was aborted, -1 if timeout, -3 was aborted, -5 if no changes to the default value
DIAG9(ICDDT,ICDDFLT,ICDOUT,ICDPARAM) ;
 N ICDINP,ICDRETV
 S ICDINP=$$SRCHSTR(ICDPARAM("SEARCH_PROMPT"),"","",ICDDFLT)
 I ICDINP=-1 Q -1  ;enter
 I ICDINP=-3 Q -1  ;^ or ^^
 I ICDINP=-2 Q -2  ;timeout or not found
 I ICDINP=-1!(ICDINP=-3) Q -2
 I ICDINP<0 Q +ICDINP
 S ICDRETV=$$ICD9($P(ICDINP,U,2),ICDDT,.ICDOUT)
 I ICDRETV=-1 Q -2
 Q ICDRETV
 ;--------------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ; Supported ICR 5681 ($$DIAGSRCH^LEX10CS)
 ;input parameters :
 ; ICDTXT - search string, ICDDATE - date of interest, ICDPAR - array with text messages and other string constants
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value^description, "" if not found, -1 if exit : ^ or ^^, -2 if continue searching
LEXICD10(ICDTXT,ICDDATE,ICDPAR) ; ICD-10 Search
 N ICDLVTXT
 ;parameters check
 S ICDDATE=+$G(ICDDATE)
 I ICDDATE'?7N Q -1
 S ICDTXT=$G(ICDTXT)
 Q:'$L(ICDTXT) -1
 N ICDNUMB
 S ICDNUMB=$$FREQ^LEXU(ICDTXT)
 I ICDNUMB>$$MAX^LEXU(30) D  I $$QUESTION("N",ICDPARAM("WISH CONTINUE"))'=1 Q -4
 . W !
 . D FORMWRIT(ICDPAR("EXCEEDS MESSAGE1")_ICDTXT_ICDPAR("EXCEEDS MESSAGE2")_ICDNUMB_ICDPAR("EXCEEDS MESSAGE3")_ICDTXT_""".",0)
 . D FORMWRIT("",2)
 . W !
 ;new and set variables
 N DIROUT,DUOUT,DTOUT,ICDEXIT,ICDICDNT
 N ICDRETV,ICDXX,ICDLEVEL
 S ICDRETV=""
 S ICDEXIT=0
 S ICDLEVEL=1,ICDLVTXT(ICDLEVEL)=ICDTXT ;level 1 stores the original search string
 ; main loop
 F  Q:ICDEXIT>0  D
 .K ICDICDY
 .;W !,"Level #: ",ICDLEVEL,", search string: ",ICDLVTXT(ICDLEVEL)
 .;get the search string from the current level and call LEX API
 .S ICDICDY=$$DIAGSRCH^LEX10CS(ICDLVTXT(ICDLEVEL),.ICDICDY,ICDDATE,30)
 .S:$O(ICDICDY(" "),-1)>0 ICDICDY=+ICDICDY
 .; Nothing found
 .I +ICDICDY'>0 S ICDEXIT=1 S ICDXX=-1 Q
 .; display the list of items and ask the user to select the item from the list
 .S ICDXX=$$SEL^ICDSELDS(.ICDICDY,8)
 .; if ^ was entered 
 .;   if this is on the top level then quit 
 .I ICDXX=-2,ICDLEVEL'>1 S ICDRETV=-1 S ICDEXIT=1 Q
 .;   if lower level then go one level up
 .I ICDXX=-2,ICDLEVEL>1 S:ICDLEVEL>1 ICDLEVEL=ICDLEVEL-1 Q
 .; If timeout, or not selected, or ^^ then quit
 .I ICDXX=-1 S ICDRETV=-1 S ICDEXIT=1 Q
 .; if Code Found and Selected by the user save selection in ICDRETV and quit
 .I $P(ICDXX,";")'="99:CAT" S ICDRETV=ICDXX S ICDEXIT=1 Q
 .; If Category Found and Selected by the user:  
 .;  go to the next inner level
 .;  change level number 
 .S ICDLEVEL=ICDLEVEL+1
 .;  set the new level with the new search string
 .;  and repeat 
 .S ICDLVTXT(ICDLEVEL)=$P($P($G(ICDXX),"^"),";",2)
 Q ICDRETV
 ;----------
 ;ICD-9 lookup (FileMan lookup)
 ;Supported ICR 5773 (FileMan lookup for files #80 nad #80.1)
 ;Supported ICR 5699 ($$ICDDATA^ICDXCODE)
 ;input parameters :
 ; ICDSRCH - search string 
 ; ICDICDT - date of interest  
 ; ICDOUT - local array to return detailed info (passed as a reference)
 ;returns ICD-9 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; or "" if not found, -1 if exit : ^ or ^^, -2 if continue search
 ;the array ICDOUT returns details if the return value >0, here is an example: 
 ; ICDOUT="6065^814.14", ICDOUT(0)=814.14, ICDOUT(0,0)=814.14, ICDOUT(0,1)="6065^814.14^^FX PISIFORM-OPEN^^8^^1^^1^^^0^^^^2781001^^1^1"
 ; ICDOUT(0,2)="OPEN FRACTURE OF PISIFORM BONE OF WRIST"
 ;Note: this API is not silent because the ICD lookup is not silent
ICD9(ICDSRCH,ICDICDT,ICDOUT) ;
 N ICDKEY,X,Y,DIC,ICDCDS
 ;KEY must be newed as ICD lookup code doesn't kill it
 S DIC="^ICD9(",DIC(0)="EQXZ"
 S ICDCDS="ICD9"
 ;note: you must use Y for the 2nd parameter of $$ICDDATA^ICDXCODE
 S DIC("S")="I $P($$ICDDATA^ICDXCODE(ICDCDS,Y,ICDICDT),U,10)=1"
 ; both X and Y should be set to the search string
 S (X,Y)=ICDSRCH
 D ^DIC
 M ICDOUT=Y
 I $G(Y) Q $S(Y=-1:-1,1:+Y_";"_$P(Y,U,2)_U_$G(Y(0,2)))
 Q X
 ;---------
 ; Look-up help
 ; Look-up help for ?
INPHLP ;
 I $G(X)["???" D INPHLP3 Q
 I $G(X)["??" D INPHLP2 Q
 W !," Enter code or ""text"" for more information." Q
 Q
 ;-----------
 ; Look-up help for ??
INPHLP2 ;
 W !," Enter a ""free text"" term or part of a term such as ""femur fracture"""
 W !!," or "
 W !!," Enter a ""classification code"" (ICD/CPT, etc.) to find the single term"
 W !," associated with the code"
 W !!," or "
 W !!," Enter a ""partial code"". Include the decimal when a search criterion"
 W !," includes 3 characters or more for code searches."
 Q
 ;--------
 ; Look-up help for ???
INPHLP3 ;
 W !," Number of Code Matches"
 W !," ----------------------"
 W !!," The ICD-10 Diagnosis Code search will show the user the number of matches"
 W !," found, indicate if additional characters in ICD code exist, and the number"
 W !," of codes within the category or subcategory that are available for selection."
 W !," For example:"
 W !!," 14 matches found"
 W !!," M91. - Juvenile osteochondrosis of hip and pelvis (19)"
 W !!," This indicates that 14 unique matches or matching groups have been found"
 W !," and will be displayed."
 W !!," M91. - the ""-"" indicates that there are additional characters that specify"
 W !," unique ICD-10 codes available."
 W !!," (19) Indicates that there are 19 additional ICD-10 codes in the M91 ""family"""
 W !," that are possible selections."
 Q
 ;--------
 ;prompt the user for a date of interest 
 ;input parameters :
 ; ICDPRMT - prompt
 ;returns YYYMMDD, or -1 if invalid date, or -2 if time out, or -3 if ^
ASKDATE(ICDPRMT) ;
 N %DT,DIROUT,DUOUT,DTOUT
 S %DT="AEX",%DT("A")=$G(ICDPRMT,"Enter a date: ")
 D ^%DT
 Q:Y<0 -1
 Q:$D(DTOUT) -2
 Q:X="^" -3
 Q (+Y)
 ;--------
 ;ask YES/NO questions
 ;input parameters :
 ; ICDDFLT- 0/null- not default, 1- yes, 2 -no
 ; ICDPROM - prompt string
 ;returns 2 - no, 1 -yes, 0 - no answer
QUESTION(ICDDFLT,ICDPROM) ;
 W:$L($G(ICDPROM)) !,ICDPROM
 S %=$G(ICDDFLT,2)
 D YN^DICN
 Q:%Y["^" -3
 I %=2!(%=1) Q %
 Q -2
 ;------------
 ;get search string
 ;input parameters :
 ; ICDPRMT prompt text
 ; ICDHLP1 "?" help text
 ; ICDHLP2 "??" help text
 ; ICDDFLT- default response
 ;returns piece1 ^ piece 2
 ; piece1:
 ; 0 if normal input, or -1 if invalid data, or -2 if time out, or -3 if ^
 ; piece2: string entered by the user
 ; or -5 if user accepts default value then no need to validate it, or -6 if user enters "@"
SRCHSTR(ICDPRMT,ICDHLP1,ICDHLP2,ICDDFLT) ;
 N DIR
 S DIR("A")=ICDPRMT
 S:($G(ICDHLP1)]"") DIR("?")=ICDHLP1
 S:($G(ICDHLP1)]"") DIR("??")=ICDHLP2
 I $L($G(ICDDFLT)) S DIR("B")=ICDDFLT
 S DIR(0)="FAO^0:245"
 D ^DIR
 Q:$D(DTOUT) -2
 Q:$D(DUOUT) -3
 Q:X="@" -6 ;quit if user entered "@" and handle deletion case in your application 
 Q:Y["^" -3
 Q:Y="" -1
 Q 0_U_Y
 ;----------
 ;Determines and returns ACTIVE coding system for DIAGNOSES based on date of interest 
 ;input parameters :
 ; ICDICDD - date of interest
 ; if date of interest is null, today's date will be assumed
 ;returns coding system  
 ; as a pointer to the ICD CODING SYSTEM file #80.4 (supported ICR 5780) 
 ; 30  if ICD-10-CM is active system, 1   if ICD-9-CM is active system
ICDSYSDG(ICDICDD) ; 
 N ICDIMPDT
 S ICDICDD=$S(ICDICDD<0!($L(+ICDICDD)'=7):DT,1:+$G(ICDICDD))
 S ICDIMPDT=$$IMPDATE^LEXU("10D")
 Q $S(ICDICDD'<ICDIMPDT:30,1:1)
 ;
 ;set parameters
 ;edit these hardcoded strings that are used for prompts, messages and so on to adjust them to your applicaion's needs
 ;input parameters 
 ; ICDPAR - local array to sets and store string constants for your messages and prompts 
SETPARAM(ICDPAR) ;
 S ICDPAR("ASKDATE")="Effective Date: "
 S ICDPAR("SEARCH_PROMPT")="ICD-10 Diagnosis Code or a Code Fragment: "
 S ICDPAR("HELP ?")="^D INPHLP^ICDDSLK"
 S ICDPAR("HELP ??")="^D INPHLP2^ICDDSLK"
 S ICDPAR("NO DATA FOUND")="  No data found"
 S ICDPAR("EXITING")="  Exiting"
 S ICDPAR("TRY LATER")="  Try again later"
 S ICDPAR("NO DATA SELECTED")="  No data selected"
 S ICDPAR("TRY ANOTHER")="Try another"
 S ICDPAR("WISH CONTINUE")="Do you wish to continue (Y/N)"
 S ICDPAR("EXCEEDS MESSAGE1")="Searching for """
 S ICDPAR("EXCEEDS MESSAGE2")=""" requires inspecting "
 S ICDPAR("EXCEEDS MESSAGE3")=" records to determine if they match the search criteria.  This could take quite some time.  Suggest refining the search by further specifying """
 S ICDPAR("NO CHANGES")=" No changes made"
 S ICDPAR("DELETE IT")=" User has requested deletion of the code"
 S ICDPAR("ENTER MORE")=" Please enter at least the first two characters of the ICD-10 code or code"
 S ICDPAR("ENTER MORE2")=" description to start the search."
 Q
 ;a wrapper for ^DIWP
 ;accumulates a text and then writes it to the device
 ;input parameters :
 ; X - text
 ; ICDMODE:
 ;  0 - start, 1 - accumulate, 2 - write
 ;example:
 ;D FORMWRIT^ICDDSLK("this API is a wrapper for ^DIWP, it accumulates a text and then writes it to the device, you can use it in your application code",0)
 ;D FORMWRIT^ICDDSLK("some more text ",1)
 ;D FORMWRIT^ICDDSLK("",2)
FORMWRIT(X,ICDMODE) ;
 N ICDLI1
 ;if "start" mode
 I ICDMODE=0 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=79
 I $L(X)>0 D ^DIWP
 ;if "write" mode
 I ICDMODE=2 D
 . S ICDLI1=0 F  S ICDLI1=$O(^UTILITY($J,"W",1,ICDLI1)) Q:+ICDLI1=0  W !,$G(^UTILITY($J,"W",1,ICDLI1,0))
 . K ^UTILITY($J,"W")
 Q
 ;Initialize variables if you need , your application most likely already has this
INITVARS ;
 D HOME^%ZIS
 S:$G(DT)=0 DT=$$DT^XLFDT
 Q
 ;press any key (used for demo)
PRESSKEY ;
 R !!,"Press any key to continue.",ICDKEY:DTIME
 Q
 ;display code info (used for demo)
CODEINFO(ICDXX2) ; Write Output
 N ICDKEY,ICDTMP
 S ICDTMP=$$ICDDX^ICDEX($P($P(ICDXX2,";",2),U,1),$G(ICDDT),30,"E")
 S $P(ICDTMP,"^",3)=$TR($P(ICDTMP,"^",3),";","")
 W !!,$P($P(ICDXX2,";",2),U,1),?15,$P($P(ICDXX2,";",2),U,2),!  ;add printing of descript disclaimer msg
 I '$P(ICDTMP,U,10) W "   **CODE INACTIVE" I $P(ICDTMP,U,12)'="" S Y=$P(ICDTMP,U,12) D DD^%DT W " AS OF   ",Y," **",!
 Q
 ; Clean up environment and quit
EXIT ;
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
