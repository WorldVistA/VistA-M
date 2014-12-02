YSLXDG ; ALB/RBD - ICD-10 DIAGNOSIS CODE LOOK UP FOR MENTAL HEALTH ;10 May 2013  11:17 AM
 ;;5.01;MENTAL HEALTH;**107**;Dec 30, 1994;Build 23
 ;
 ;based on ^ZZLXDG which is the standard Diagnosis Search Protocol
 ;beginning routine.
 ;
 Q
 ;
EN ;
 D INITVARS ;set standards variables, you might not need this if it
 ; was already done in your application
 N YSQUIT ; to manage loop
 K YSRETV ;to store the selected code information
 N YSPARAM ;  to set your application specific prompts and messages
 N YSCSYS ;coding system "ICD9" or ICD10"
 N YSOUT ;to return all available information about the selected code
 ;settings:
 D SETPARAM(.YSPARAM) ;edit the SETPARAM subroutine below to set your
 ; application specific prompts
 I YSDT'>0 S YSRETV=-1 Q
 ;starting main loop
 S YSQUIT=0 F  Q:YSQUIT=1  D
 . S YSRETV=0,YSOUT=""
 . W !!   ;reprompt a few lines down
 . ;prompt for the date of interest (date should be available for MH)
 . I YSDT'>0 S YSRETV=-1,YSQUIT=1 Q
 . ;S YSDT=$$ASKDATE(YSPARAM("ASKDATE"))
 . ;prompt for "try again" with "No" as default if ^ or null entered
 . ;for the date or if timed out
 . I YSDT'>0 S:$$QUESTION(2,YSPARAM("TRY ANOTHER"))'=1 YSQUIT=1 Q
 . ;determine coding system based on the date of interest
 . ;If coding system not ICD-10 or greater, then Quit (let MH code
 . ; handle it as before for now)
 . S YSCSYS=$$ICDSYSDG(YSDT) I YSCSYS=1 S YSRETV=-1,YSQUIT=1 Q
 . ;set default response for your prompt
 . S YSDFLT=""
 . ;run either ICD9 or ICD10 prompt/search/select logic
 . ;ICD9 (1 is a pointer to the ICD-9 diagnosis system entry in the
 . ;new file #80.4)
 . I YSCSYS=1 S YSRETV=$$DIAG9(YSDT,YSDFLT,.YSOUT,.YSPARAM) I YSRETV=-2 S:$$QUESTION(1,YSPARAM("TRY ANOTHER"))'=1 YSQUIT=1 Q
 . ;ICD10 (30 is a pointer to the ICD-10 diagnosis system entry in the new file #80.4)
 . I YSCSYS=30 S YSRETV=$$DIAG10(YSDT,YSDFLT,.YSPARAM)
 . I $P(YSRETV,U,2)="LIST CHOICE" S YSRETV=$P(YSRETV,U,1),YSQUIT=1 Q
 . ;display information about the code selected
 . I YSRETV>0 W !,"SELECTED: " D CODEINFO(YSRETV) S YSQUIT=1 Q
 . ;if no data found
 . I YSRETV="" W !!,YSPARAM("NO DATA FOUND") S:$$QUESTION(1,YSPARAM("TRY ANOTHER"))'=1 YSQUIT=1,YSRETV=-1 Q
 . ;in ICD10 if the user answered NO for the question "Do you wish to continue(Y/N)?"
 . I YSRETV=-4 S:$$QUESTION(1,YSPARAM("TRY ANOTHER"))'=1 YSQUIT=1 Q
 . ;no data or was aborted
 . I YSRETV=-2 S:$$QUESTION(1,YSPARAM("TRY ANOTHER"))'=1 YSQUIT=1 Q
 . ;if exit due to ^ in the ICD Diagnosis code prompt
 . I YSRETV=-3 S:$$QUESTION(2,YSPARAM("TRY ANOTHER"))'=1 YSQUIT=1 Q
 . ;if no data found
 . I YSRETV=-1 S:$$QUESTION(2,YSPARAM("TRY ANOTHER"))'=1 YSQUIT=1 Q
 . ; if continue search
 Q
 ;
 ;//---------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; YSDT - date of interest
 ; YSDFLT - default values for the search string (can be a code by default)
 ; YSOUT - local array to return results (passed as a reference)
 ; YSPARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; results
 ; or -1 if invalid data(press enter)
 ; "" if not found
 ; or -2 if time out
 ; or -3 if ^ or ^^
 ; or -4 in ICD10 if the user answered NO for the question "Do you wish to continue(Y/N)?"
 ; 
DIAG10(YSDT,YSDFLT,YSPARAM) ;
 N YSINP
 S YSINP=$$SRCHSTR(YSPARAM("SEARCH_PROMPT"),YSPARAM("HELP ?"),YSPARAM("HELP ??"),YSDFLT)
 I YSINP<0 Q +YSINP
 I $P(YSINP,U,2)?.N Q $P(YSINP,U,2)_U_"LIST CHOICE"
 Q $$LEXICD10($P(YSINP,U,2),YSDT,.YSPARAM)
 ;
 ;//---------
 ;The entry point for ICD-9 FileMan type (^DIC) diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; YSDT - date of interest
 ; YSDFLT - default values for the search string (can be a code by default)
 ; YSOUT - local array to return results(passed as a reference)
 ; YSPARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-9 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ;  -2 no data or was aborted
 ;  -1 if timeout
DIAG9(YSDT,YSDFLT,YSOUT,YSPARAM) ;
 N YSINP,YSRETV
 S YSINP=$$SRCHSTR(YSPARAM("SEARCH_PROMPT"),YSPARAM("HELP ?"),YSPARAM("HELP ??"),YSDFLT)
 I YSINP=-1 Q -1  ;enter
 I YSINP=-3 Q -1  ;^ or ^^
 I YSINP=-2 Q -2  ;timeout or not found
 I YSINP=-1!(YSINP=-3) Q -2
 I YSINP<0 Q +YSINP
 S YSRETV=$$ICD9($P(YSINP,U,2),YSDT,.YSOUT)
 I YSRETV=-1 Q -2
 Q YSRETV
 ;
 ;--------------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ; Supported ICR 5681 ($$DIAGSRCH^LEX10CS)
 ;input parameters :
 ; YSTXT - search string
 ; YSDATE - date of interest
 ; YSPAR - array with text messages and other string constants
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; or
 ; "" if not found
 ; -1 if exit : ^ or ^^
 ; -2 if continue searching
 ;
LEXICD10(YSTXT,YSDATE,YSPAR) ; ICD-10 Search
 N YSLVTXT
 ;parameters check
 S YSDATE=+$G(YSDATE)
 S YSDATE=$P(YSDATE,".",1)
 I YSDATE'?7N Q -1
 S YSTXT=$G(YSTXT)
 Q:'$L(YSTXT) -1
 N YSNUMB
 S YSNUMB=$$FREQ^LEXU(YSTXT)
 I YSNUMB>$$MAX^LEXU(30) D  I $$QUESTION("N",YSPARAM("WISH CONTINUE"))'=1 Q -4
 . W ! D FORMWRIT(YSPAR("EXCEEDS MESSAGE1")_YSTXT_YSPAR("EXCEEDS MESSAGE2")_YSNUMB_YSPAR("EXCEEDS MESSAGE3")_YSTXT_""".",0)
 . D FORMWRIT("",2) W !
 ;new and set variables
 N DIROUT,DUOUT,DTOUT,YSEXIT,YSICDNT
 N YSRETV,YSXX,YSLEVEL
 S YSRETV=""
 S YSEXIT=0
 S YSLEVEL=1,YSLVTXT(YSLEVEL)=YSTXT ;level 1 stores the original search string
 ; main loop
 F  Q:YSEXIT>0  D
 .K YSICDY
 .;W !,"Level #: ",YSLEVEL,", search string: ",YSLVTXT(YSLEVEL)
 .;get the search string from the current level and call LEX API
 .S YSICDY=$$DIAGSRCH^LEX10CS(YSLVTXT(YSLEVEL),.YSICDY,YSDATE,30)
 .S:$O(YSICDY(" "),-1)>0 YSICDY=+YSICDY
 .; Nothing found
 .I +YSICDY'>0 S YSEXIT=1 S YSXX=-1 Q
 .; display the list of items and ask the user to select the item from the list
 .S YSXX=$$SEL^YSLXDG2(.YSICDY,8)
 .; if ^ was entered
 .;   if this is on the top level then quit
 .I YSXX=-2,YSLEVEL'>1 S YSRETV=-1 S YSEXIT=1 Q
 .;   if lower level then go one level up
 .I YSXX=-2,YSLEVEL>1 S:YSLEVEL>1 YSLEVEL=YSLEVEL-1 Q
 .; If timeout, or not selected, or ^^ then quit
 .I YSXX=-1 S YSRETV=-1 S YSEXIT=1 Q
 .; if Code Found and Selected by the user save selection in YSRETV and quit
 .I $P(YSXX,";")'="99:CAT" S YSRETV=YSXX S YSEXIT=1 Q
 .; If Category Found and Selected by the user:
 .;  go to the next inner level
 .;  change level number
 .S YSLEVEL=YSLEVEL+1
 .;  set the new level with the new search string
 .;  and repeat
 .S YSLVTXT(YSLEVEL)=$P($P($G(YSXX),"^"),";",2)
 Q YSRETV
 ;----------
 ;ICD-9 lookup (FileMan lookup)
 ;Supported ICR 5773 (FileMan lookup for files #80 nad #80.1)
 ;Supported ICR 5699 ($$ICDDATA^ICDXCODE)
 ;input parameters :
 ; YSSRCH - search string
 ; YSICDT - date of interest
 ; YSOUT - local array to return detailed info (passed as a reference)
 ;returns ICD-9 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; or
 ; "" if not found
 ; -1 if exit : ^ or ^^
 ; -2 if continue search
 ;the array YSOUT returns details if the return value >0, here is an example:
 ; YSOUT="6065^814.14"
 ; YSOUT(0)=814.14
 ; YSOUT(0,0)=814.14
 ; YSOUT(0,1)="6065^814.14^^FX PISIFORM-OPEN^^8^^1^^1^^^0^^^^2781001^^1^1"
 ; YSOUT(0,2)="OPEN FRACTURE OF PISIFORM BONE OF WRIST"
 ;Note: this API is not silent because the ICD lookup is not silent
ICD9(YSSRCH,YSICDT,YSOUT) ;
 N KEY,X,Y,DIC,YSCDS
 ;KEY must be newed as ICD lookup code doesn't kill it
 S DIC="^ICD9(",DIC(0)="EQXZ"
 S YSCDS="ICD9"
 ;note: you must use Y for the 2nd parameter of $$ICDDATA^ICDXCODE
 S DIC("S")="I $P($$ICDDATA^ICDXCODE(YSCDS,Y,YSICDT),U,10)=1"
 ; both X and Y should be set to the search string
 S (X,Y)=YSSRCH
 D ^DIC
 M YSOUT=Y
 I $G(Y) Q $S(Y=-1:-1,1:+Y_";"_$P(Y,U,2)_U_$G(Y(0,2)))
 Q X
 ;
 ;---------
 ; Clean up environment and quit
EXIT ;
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
 ;-----------
 ; Look-up help for ICD10s.
INPHLP ; Help text controller for ICD-10
 I X["???" D QM3 Q
 I X["??" D QM2 Q
 I X["?" D QM1 Q
 Q
QM ; Diagnosis help text
QM1 ; simple help text for 1 question mark
 W !,"Enter code or ""text"" for more information.",!
 Q
QM2 ; enhanced help text for 2 question marks
 W !,"Enter a ""free text"" term or part of a term such as ""femur fracture"".",!
 W !,"  or",!
 W !,"Enter a ""classification code"" (ICD/CPT etc) to find the single term associated"
 W !,"with the code.",!
 W !," or",!
 W !,"Enter a ""partial code"". Include the decimal when a search criterion includes"
 W !,"3 characters or more for code searches.",!
 Q
QM3 ; further explanation of format when there are multiple returns, displayed for 3 question marks.
 W !,"Number of Code Matches"
 W !,"----------------------",!
 W !,"The ICD-10 Diagnosis Code search will show the user the number of matches"
 W !,"found, indicate if additional characters in ICD code exist, and the number"
 W !,"of codes within the category or subcategory that are available for selection."
 W !,"For example:",!
 W !,"14 matches found",!
 W !,"M91. -    Juvenile osteochondrosis of hip and pelvis (19)",!
 W !,"This indicates that 14 unique matches or matching groups have been found and"
 W !,"will be displayed.",!
 W !,"M91. -   the ""-"" indicates that there are additional characters that specify"
 W !,"         unique ICD-10 codes available.",!
 W !,"(19)     Indicates that there are 19 additional ICD-10 codes in the M91"
 W !,"         ""family"" that are possible selections.",!
 Q
 ;
MIN2 ; Minimum length of 2 characters message
 W $C(7),"  ??",!
 W !,"Please enter at least the first two characters of the ICD-10 code or "
 W !,"code description to start the search.",!
 Q
 ;
INPHLP2 ; Look-up help for ICD9s
 W !," Enter a ""free text"" term. Best results occur using one to "
 W !," three full or partial words without a suffix"
 W:$G(X)'["??" "."
 W:$G(X)["??" " (i.e., ""DIABETES"","
 W:$G(X)["??" !," ""DIAB MELL"",""DIAB MELL INSUL"")"
 W !," or "
 W !," Enter a classification code (ICD/CPT etc) to find the single "
 W !," term associated with the code."
 W:$G(X)["??" " Example, a lookup of code 239.0 "
 W:$G(X)["??" !," returns one and only one term, that is the preferred "
 W:$G(X)["??" !," term for the code 239.0, ""Neoplasm of unspecified nature "
 W:$G(X)["??" !," of digestive system"""
 W !," or "
 W !," Enter a classification code (ICD/CPT etc) followed by a plus"
 W !," sign (+) to retrieve all terms associated with the code."
 W:$G(X)["??" " Example,"
 W:$G(X)["??" !," a lookup of 239.0+ returns all terms that are linked to the "
 W:$G(X)["??" !," code 239.0."
 Q
 ;--------
 ;prompt the user for a date of interest
 ;input parameters :
 ; YSPRMT - prompt
 ;returns YYYMMDD
 ; or -1 if invalid date
 ; or -2 if time out
 ; or -3 if ^
ASKDATE(YSPRMT) ;
 N %DT,DIROUT,DUOUT,DTOUT
 S %DT="AEX",%DT("A")=$G(YSPRMT,"Enter a date: ")
 D ^%DT
 Q:Y<0 -1
 Q:$D(DTOUT) -2
 Q:X="^" -3
 Q (+Y)
 ;--------
 ;ask YES/NO questions
 ;input parameters :
 ; YSDFLT- 0/null- not default, 1- yes, 2 -no
 ; YSPROM - prompt string
 ;returns
 ; 2 - no,
 ; 1 -yes,
 ; 0 - no answer
QUESTION(YSDFLT,YSPROM) ;
 W:$L($G(YSPROM)) !,YSPROM
 S %=$G(YSDFLT,2)
 D YN^DICN
 Q:%Y["^" -3
 I %=2!(%=1) Q %
 Q -2
 ;
 ;------------
 ;get search string
 ;input parameters :
 ; YSPRMT prompt text
 ; YSHLP1 "?" help text
 ; YSHLP2 "??" help text
 ; YSDFLT- default response
 ;returns piece1 ^ piece 2
 ; piece1:
 ; 0 if normal input
 ; or -1 if invalid data
 ; or -2 if time out
 ; or -3 if ^
 ; piece2: string entered by the user
SRCHSTR(YSPRMT,YSHLP1,YSHLP2,YSDFLT) ;
SRCHST2 N DIR
 S DIR("A")=YSPRMT
 S DIR("?")=YSHLP1
 S DIR("??")=YSHLP2
 I $L($G(YSDFLT)) S DIR("B")=YSDFLT
 S DIR(0)="FAO^0:245"
 D ^DIR
 Q:$D(DTOUT) -2
 Q:$D(DUOUT) -3
 Q:Y["^" -3
 I $L(Y)=1 D MIN2 G SRCHST2
 Q:Y="" -1
 Q 0_U_Y
 ;
 ;----------
 ;Determines and returns ACTIVE coding system for DIAGNOSES based on date of interest
 ;input parameters :
 ; YSICDD - date of interest
 ; if date of interest is null, today's date will be assumed
 ;returns coding system
 ; as a pointer to the ICD CODING SYSTEM file #80.4 (suppported ICR 5780)
 ; 30  if ICD-10-CM is active system
 ; 1   if ICD-9-CM is active system
ICDSYSDG(YSICDD) ;
 N YSIMPDT
 S YSICDD=$S(YSICDD<0!($L($P(YSICDD,".",1))'=7):DT,1:+$G(YSICDD))
 S YSIMPDT=$$IMPDATE^LEXU("10D")
 Q $S(YSICDD'<YSIMPDT:30,1:1)
 ;
 ;set parameters
 ;edit these hardcoded strings that areused for prompts, messages and so on to adjust
 ;them to your applicaion's needs
 ;input parameters
 ; YSPAR - local array to sets and store string constants for your messages and prompts 
SETPARAM(YSPAR) ;
 S YSPAR("ASKDATE")="Date of interest? "
 S YSPAR("SEARCH_PROMPT")="Enter ICD-10 DIAGNOSIS: "   ; assume ICD-10
 S YSPAR("HELP ?")="^D INPHLP^YSLXDG"
 S YSPAR("HELP ??")="^D INPHLP^YSLXDG"
 S YSPAR("NO DATA FOUND")="  No data found"
 S YSPAR("EXITING")="  Exiting"
 S YSPAR("TRY LATER")="  Try again later"
 S YSPAR("NO DATA SELECTED")="  No data selected"
 S YSPAR("TRY ANOTHER")="Try another"
 S YSPAR("WISH CONTINUE")="Do you wish to continue (Y/N)"
 S YSPAR("EXCEEDS MESSAGE1")="Searching for """
 S YSPAR("EXCEEDS MESSAGE2")=""" requires inspecting "
 S YSPAR("EXCEEDS MESSAGE3")=" records to determine if they match the search criteria.  This could take quite some time.  Suggest refining the search by further specifying """
 Q
 ;
 ;
 ;a wrapper for ^DIWP
 ;accumulates a text and then writes it to the device
 ;input parameters :
 ; X - text
 ; YSMODE:
 ;  0 - start
 ;  1 - accumulate
 ;  2 - write
 ;example:
 ;D FORMWRIT^ZZLXDG("this API is a wrapper for ^DIWP, it accumulates a text and then writes it to the device, you can use it in your application code",0)
 ;D FORMWRIT^ZZLXDG("some more text ",1)
 ;D FORMWRIT^ZZLXDG("",2)
FORMWRIT(X,YSMODE) ;
 N YSLI1
 ;if "start" mode
 I YSMODE=0 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=79
 I $L(X)>0 D ^DIWP
 ;if "write" mode
 I YSMODE=2 D
 . S YSLI1=0 F  S YSLI1=$O(^UTILITY($J,"W",1,YSLI1)) Q:+YSLI1=0  W !,$G(^UTILITY($J,"W",1,YSLI1,0))
 . K ^UTILITY($J,"W")
 Q
 ;
 ;---------------
 ;Initialize variables if you need , your application most likely already has this
INITVARS ;
 D HOME^%ZIS
 S:$G(DT)=0 DT=$$DT^XLFDT
 Q
 ;press any key
PRESSKEY ;
 R !!,"Press any key to continue.",YSKEY:DTIME
 Q
 ;display code info
CODEINFO(YSXX2) ; Write Output
 N YSKEY,YSICDSTR
 S YSICDSTR="ICD"_$S(YSCSYS="30":"10",1:"9")
 N YSTXT,YSI S YSTXT(1)=$P($P(YSXX2,";",2),U,2)
 D PR^YSLXDG2(.YSTXT,48)
 W !," ",YSICDSTR," Diagnosis code:",?31,$P($P(YSXX2,";",2),U,1)
 W !," ",YSICDSTR," Diagnosis description:",?31,YSTXT(1)
 S YSI=1 F  S YSI=$O(YSTXT(YSI)) Q:+YSI'>0  W !,?31,$G(YSTXT(YSI))
 Q
 ;
