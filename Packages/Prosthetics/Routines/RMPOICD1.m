RMPOICD1 ;ALB/MGD - ICD-10 DIAGNOSIS CODE LOOK UP; 12-06-11
 ;;3.0;PROSTHETICS;**168**;Feb 09, 1996;Build 43
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to $$DIAGSRCH^LEX10CS supported by ICR #5681
 ; Reference to $$IMPDATE^LEXU     supported by ICR #5679
 ; Reference to $$FREQ^LEXU        supported by ICR #5679 
 ; Reference to $$MAX^LEXU         supported by ICR #5679
 ; Reference to LS^ICDEX           supported by ICR #5747
 ; Reference to CSI^ICDEX          supported by ICR #5747
 ;
 ; This routine is based on ^ICDLOOK
 ;
EN ;
 D DEMO
 Q
 ;
 ;this is a demo code,
 ;in your applications you might need to use some or all of the code below,
 ;see comments
DEMO ;
 D INITVARS ;set standards variables, you might not need this if it was already done in your application 
 N RMPQUIT ; to manage demo loop
 N RMPRETV ;to store the selected code information
 N RMPPARAM ; to set your application specific prompts and messages
 N RMPCSYS ;coding system "ICD9" or ICD10"
 N RMPOUT ;to return all available information about the selected code
 N RMPDFLT9 ;default ICD-9 value for demo
 N RMPDFL10 ;default ICD-10 value for demo
 ;settings:
 D SETPARAM(.RMPPARAM) ;edit the SETPARAM subroutine below to set your application specific prompts
 ;starting demo loop
 S RMPQUIT=0 F  Q:RMPQUIT=1  D
 . S RMPRETV=0,RMPOUT=""
 . W @IOF ;reset the screen
 . ;prompt for the date of interest
 . S RMPDT=$$ASKDATE(RMPPARAM("ASKDATE"))
 . I RMPDT=-1 S RMPQUIT=1 Q
 . ;prompt for "try again" with "No" as default if ^ or null entered for the date or if timed out
 . I RMPDT'>0 S:$$QUESTION(2,RMPPARAM("TRY ANOTHER"))'=1 RMPQUIT=1 Q
 . ;determine coding system based on the date of interest 
 . S RMPCSYS=$$ICDSYSDG(RMPDT)
 . ;set default response for your prompt
 . S RMPDFLT9=""
 . S RMPDFL10=""
 . ;run either ICD9 or ICD10 prompt/search/select logic
 . ;ICD9 (1 is a pointer to the ICD-9 diagnosis system entry in the new file #80.4 )
 . I RMPCSYS=1 S RMPRETV=$$DIAG9(RMPDT,RMPDFLT9,.RMPOUT,.RMPPARAM) I RMPRETV=-2 S:$$QUESTION(1,RMPPARAM("TRY ANOTHER"))'=1 RMPQUIT=1 Q
 . ;ICD10 (30 is a pointer to the ICD-10 diagnosis system entry in the new file #80.4 )
 . I RMPCSYS=30 S RMPRETV=$$DIAG10(RMPDT,RMPDFL10,.RMPPARAM)
 . ;display information about the code selected (for demo purposes)
 . I +RMPRETV>0 W !,"SELECTED: " D CODEINFO(RMPRETV) S RMPQUIT=1 Q
 . ;if no data found
 . I +RMPRETV="" W !!,RMPPARAM("NO DATA FOUND") Q
 . ;in ICD10 if the user answered NO for the question "Do you wish to continue(Y/N)?"
 . I +RMPRETV=-4 S RMPQUIT=1 Q
 . ;no changes to the default value 
 . I +RMPRETV=-5 S RMPQUIT=1 Q
 . ;no data or was aborted 
 . I +RMPRETV=-2 S RMPQUIT=1 Q
 . ;if exit due to ^ in the ICD Diagnosis code prompt 
 . I +RMPRETV=-3 S RMPQUIT=1 Q
 . ;if no data found
 . I +RMPRETV=-1,$P(RMPRETV,U,2)=-1 S RMPQUIT=1 Q
 . ;user entered "@" to delete the currently selected ICD code 
 . I +RMPRETV=-6 W !,RMPPARAM("DELETE IT"),! S:$$QUESTION(1,RMPPARAM("TRY ANOTHER"))'=1 RMPQUIT=1 Q
 . ; if continue search
 Q
 ;
 ;//---------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; RMPDT - date of interest (Fileman format)
 ; RMPDFLT - default values for the search string (can be a code by default)
 ; RMPPARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-10 code selected by the user:
 ; IEN file #80;ICD code value;IEN file # 757.01^description
 ; results
 ; or -1 if invalid data(press enter)
 ; "" if not found 
 ; or -2 if time out
 ; or -3 if ^ or ^^
 ; or -4 in ICD10 if the user answered NO for the question "Do you wish to continue(Y/N)?"
 ; or -5 if no changes to the default value
DIAG10(RMPDT,RMPDFLT,RMPPARAM) ;
 N RMPINP
 F  D  Q:RMPINP<0!($L($P(RMPINP,U,2))>1)
 .S RMPINP=$$SRCHSTR(RMPPARAM("SEARCH_PROMPT"),RMPPARAM("HELP ?"),RMPPARAM("HELP ??"),RMPDFLT)
 .I RMPINP'<0 I $L($P(RMPINP,U,2))'>1 W !!,RMPPARAM("ENTER MORE") W:$L(RMPPARAM("ENTER MORE2"))>0 !,RMPPARAM("ENTER MORE2") W ! ;user should enter at least 2 characters
 I RMPINP<0 Q RMPINP_"^-1"
 Q $$LEXICD10($P(RMPINP,U,2),RMPDT,.RMPPARAM)
 ;
 ;//---------
 ;The entry point for ICD-9 FileMan type (^DIC) diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; RMPDT - date of interest
 ; RMPDFLT - default values for the search string (can be a code by default)
 ; RMPOUT - local array to return results(passed as a reference)
 ; RMPPARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-9 code selected by the user:
 ; IEN file #80;ICD code value^description
 ; -1 no data or was aborted
 ; -2 if timeout 
 ; -3 was aborted
 ; -5 if no changes to the default value
DIAG9(RMPDT,RMPDFLT,RMPOUT,RMPPARAM) ;
 N RMPINP,RMPRETV
 S RMPRETV=$$ICD9(RMPDFLT,RMPDT,.RMPOUT,RMPPARAM("SEARCH_PROMPT"))
 Q RMPRETV
 ;
 ;--------------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ; Supported ICR 5681 ($$DIAGSRCH^LEX10CS)
 ;input parameters :
 ; RMPTXT - search string
 ; RMPDATE - date of interest
 ; RMPPAR - array with text messages and other string constants
 ;returns ICD-10 code selected by the user:
 ; IEN file #80;ICD code value^description
 ; or 
 ; "" if not found 
 ; -1 if exit : ^ or ^^
 ; -2 if continue searching
 ;
LEXICD10(RMPTXT,RMPDATE,RMPPAR) ; ICD-10 Search
 N RMPLVTXT
 ;parameters check
 S RMPDATE=+$G(RMPDATE)
 I RMPDATE'?7N Q -1
 S RMPTXT=$G(RMPTXT)
 Q:'$L(RMPTXT) -1
 N RMPNUMB
 S RMPNUMB=$$FREQ^LEXU(RMPTXT) ; Supported ICR #5679
 I RMPNUMB>$$MAX^LEXU(30) D  I $$QUESTION(2,RMPPAR("WISH CONTINUE"))'=1 Q -4  ; Supported ICR #5679
 . W !
 . D FORMWRIT(RMPPAR("EXCEEDS MESSAGE1")_RMPTXT_RMPPAR("EXCEEDS MESSAGE2")_RMPNUMB_RMPPAR("EXCEEDS MESSAGE3")_RMPTXT_""".",0)
 . D FORMWRIT("",2)
 . W !
 ;new and set variables
 N DIROUT,DUOUT,DTOUT,RMPEXIT,RMPICDNT
 N RMPRETV,RMPXX,RMPLEVEL
 S RMPRETV=""
 S RMPEXIT=0
 S RMPLEVEL=1,RMPLVTXT(RMPLEVEL)=RMPTXT ;level 1 stores the original search string
 ; main loop
 F  Q:RMPEXIT>0  D
 .K RMPICDY
 .;W !,"Level #: ",RMPLEVEL,", search string: ",RMPLVTXT(RMPLEVEL)
 .;get the search string from the current level and call LEX API
 .S RMPICDY=$$DIAGSRCH^LEX10CS(RMPLVTXT(RMPLEVEL),.RMPICDY,RMPDATE,30) ; Supported ICR #5681
 .;W !,"Search for: ",RMPLVTXT(RMPLEVEL),"Date: ",RMPDATE,!! ZW RMPICDY W @IOF
 .S:$O(RMPICDY(" "),-1)>0 RMPICDY=+RMPICDY
 .; Nothing found
 .I +RMPICDY'>0 S RMPEXIT=1 S RMPXX=-1 Q
 .; display the list of items and ask the user to select the item from the list
 .S RMPXX=$$SEL^RMPOICD2(.RMPICDY,8)
 .; if ^ was entered 
 .; if this is on the top level then quit 
 .I RMPXX=-2,RMPLEVEL'>1 S RMPRETV=-1 S RMPEXIT=1 Q
 .; if lower level then go one level up
 .I RMPXX=-2,RMPLEVEL>1 S:RMPLEVEL>1 RMPLEVEL=RMPLEVEL-1 Q
 .; If timeout, or not selected, or ^^ then quit
 .I RMPXX=-1 S RMPRETV=-1 S RMPEXIT=1 Q
 .; if Code Found and Selected by the user save selection in RMPRETV and quit
 .I $P(RMPXX,";")'="99:CAT" S RMPRETV=RMPXX S RMPEXIT=1 Q
 .; If Category Found and Selected by the user: 
 .; go to the next inner level
 .; change level number 
 .S RMPLEVEL=RMPLEVEL+1
 .; set the new level with the new search string
 .; and repeat 
 .S RMPLVTXT(RMPLEVEL)=$P($P($G(RMPXX),"^"),";",2)
 Q RMPRETV
 ;----------
 ;ICD-9 lookup (FileMan lookup)
 ;Supported ICR 5773 (FileMan lookup for files #80 and #80.1)
 ;input parameters :
 ; RMPSRCH - search string/ default values
 ; RMPICDT - date of interest 
 ; RMPOUT - local array to return detailed info (passed as a reference)
 ; RMPPRMT - prompt
 ;returns ICD-9 code selected by the user:
 ; IEN file #80;ICD code value^description
 ; or 
 ; -1 if exit : ^ or ^^
 ; -2 if no results (timeout)
 ;the array RMPOUT returns details if the return value >0, here is an example: 
 ; RMPOUT="6065^814.14"
 ; RMPOUT(0)=814.14
 ; RMPOUT(0,0)=814.14
 ; RMPOUT(0,1)="6065^814.14^^FX PISIFORM-OPEN^^8^^1^^1^^^0^^^^2781001^^1^1"
 ; RMPOUT(0,2)="OPEN FRACTURE OF PISIFORM BONE OF WRIST"
 ;Note: this API is not silent because the ICD lookup is not silent
ICD9(RMPSRCH,RMPICDT,RMPOUT) ;
 N KEY,X,Y,DIC,RMPCDS
 ;KEY must be newed as ICD lookup code doesn't kill it
 S DIC="^ICD9(",DIC(0)="EQMNZIA"
 S:$G(RMPPRMT)]"" DIC("A")=RMPPRMT
 S:$G(RMPSRCH)]"" DIC("B")=RMPSRCH
 S RMPCDS="ICD9"
 ;note: you must use Y for the 2nd parameter of $$LS^ICDEX & $$CSI^ICDEX
 S DIC("S")="I $$LS^ICDEX(80,+Y,RMPICDT)>0,$$CSI^ICDEX(80,+Y)=1"
 D ^DIC
 M RMPOUT=Y
 I $G(Y) Q $S($D(DTOUT):-2,$D(DUOUT):-1,$D(DUOUT):-1,Y=-1:-1,Y=-5:"",1:+Y_";"_$P(Y,U,2)_U_$G(Y(0,2)))
 Q X
 ;
 ;---------
 ; Clean up environment and quit
EXIT ;
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
 ;-----------
 ; Look-up help for ?
INPHLP ;
 I $G(X)["???" D INPHLP3 Q
 I $G(X)["??" D INPHLP2 Q
 W !," Enter code or ""text"" for more information." Q
 Q
 ;-----------
 ; Look-up help for ??
INPHLP2 ;
 W !," Enter a ""free text"" term or part of a term such as ""femur fracture""."
 W !!," or "
 W !!," Enter a ""classification code"" (ICD/CPT etc) to find the single term"
 W !," associated with the code."
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
 ; RMPPRMT - prompt
 ;returns YYYMMDD
 ; or -1 if invalid date
 ; or -2 if time out
 ; or -3 if ^
ASKDATE(RMPPRMT) ;
 N %DT,DIROUT,DUOUT,DTOUT
 S %DT="AEX",%DT("A")=$G(RMPPRMT,"Enter a date: ")
 D ^%DT
 Q:Y<0 -1
 Q:$D(DTOUT) -2
 Q:X="^" -3
 Q (+Y)
 ;--------
 ;ask YES/NO questions
 ;input parameters :
 ; RMPDFLT- 0/null- not default, 1- yes, 2 -no
 ; RMPPROM - prompt string
 ;returns 
 ; 2 - no,
 ; 1 - yes,
 ; 0 - no answer (time out)
 ; -3 - ^ or ^^
QUESTION(RMPDFLT,RMPPROM,RMPHELP) ;
 N DIR
 S %=$G(RMPDFLT,2)
 S DIR(0)="Y",DIR("A")=RMPPROM,DIR("B")=$S(%=1:"Yes",%=2:"No",1:"")
 S:$L($G(RMPHELP)) DIR("?")=RMPHELP
 D ^DIR
 Q:Y["^" -3
 Q:Y=1 1
 Q:Y=0 2
 Q 0
 ;
 ;------------
 ;get search string
 ;input parameters :
 ; RMPPRMT prompt text
 ; RMPHLP1 "?" help text
 ; RMPHLP2 "??" help text
 ; RMPDFLT- default response
 ;returns piece1 ^ piece 2
 ; piece1:
 ; 0 if normal input
 ; or -1 if invalid data
 ; or -2 if time out
 ; or -3 if ^
 ; or -5 if user accepts default value then no need to validate it
 ; or -6 if user enters "@"
 ; piece2: string entered by the user
SRCHSTR(RMPPRMT,RMPHLP1,RMPHLP2,RMPDFLT) ;
 N DIR
 S DIR("A")=RMPPRMT
 S:($G(RMPHLP1)]"") DIR("?")=RMPHLP1
 S:($G(RMPHLP2)]"") DIR("??")=RMPHLP2
 I $L($G(RMPDFLT)) S DIR("B")=RMPDFLT
 S DIR(0)="FAOr^0:245"
 D ^DIR
 Q:$D(DTOUT) -2
 Q:$D(DUOUT) -3
 Q:X="@" -6 ;quit if user entered "@" and handle deletion case in your application
 Q:Y["^" -3
 Q:Y="" -1
 Q:(($L($G(RMPDFLT)))&(Y=RMPDFLT)) -5 ;if user accepts default value then no need to validate it
 Q 0_U_Y
 ;
 ;----------
 ;Determines and returns ACTIVE coding system for DIAGNOSES based on date of interest 
 ;input parameters :
 ; RMPICDD - date of interest
 ; if date of interest is null, today's date will be assumed
 ;returns coding system 
 ; as a pointer to the ICD CODING SYSTEM file #80.4 (supported ICR 5780) 
 ; 30 if ICD-10-CM is active system
 ; 1 if ICD-9-CM is active system
ICDSYSDG(RMPICDD) ; 
 N RMPIMPDT
 S RMPICDD=$S(RMPICDD<0!($L(+RMPICDD)'=7):DT,1:+$G(RMPICDD))
 S RMPIMPDT=$$IMPDATE^LEXU("10D")
 Q $S(RMPICDD'<RMPIMPDT:30,1:1)
 ;
 ;set parameters
 ;edit these hardcoded strings that are used for prompts, messages and so on to adjust them to your application's needs
 ;input parameters 
 ; RMPPAR - local array to set and store string constants for your messages and prompts 
SETPARAM(RMPPAR) ;
 S RMPPAR("SEARCH_PROMPT")="ICD-10 DIAGNOSIS CODE: "
 S RMPPAR("HELP ?")="^D INPHLP^RMPOICD1"
 S RMPPAR("HELP ??")="^D INPHLP2^RMPOICD1"
 S RMPPAR("NO DATA FOUND")=" No data found"
 S RMPPAR("EXITING")=" Exiting"
 S RMPPAR("TRY LATER")=" Try again later"
 S RMPPAR("NO DATA SELECTED")=" No data selected"
 S RMPPAR("TRY ANOTHER")="Try another"
 S RMPPAR("WISH CONTINUE")="Do you wish to continue(Y/N)"
 S RMPPAR("EXCEEDS MESSAGE1")="Searching for """
 S RMPPAR("EXCEEDS MESSAGE2")=""" requires inspecting "
 S RMPPAR("EXCEEDS MESSAGE3")=" records to determine if they match the search criteria. This could take quite some time. Suggest refining the search by further specifying """
 S RMPPAR("NO CHANGES")=" No changes made"
 S RMPPAR("DELETE IT")="   SURE YOU WANT TO DELETE"
 S RMPPAR("ENTER MORE")=" Please enter at least the first two characters of the ICD-10 code or code"
 S RMPPAR("ENTER MORE2")=" description to start the search."
 S RMPPAR("YES OR NO")="Answer 'Y' for 'Yes' or 'N' for 'No'"
 Q
 ;
 ;
 ;a wrapper for ^DIWP
 ;accumulates a text and then writes it to the device
 ;input parameters :
 ; X - text
 ; RMPMODE:
 ; 0 - start
 ; 1 - accumulate 
 ; 2 - write
 ;example:
 ;D FORMWRIT^ZZLXDG("this API is a wrapper for ^DIWP, it accumulates a text and then writes it to the device, you can use it in your application code",0)
 ;D FORMWRIT^ZZLXDG("some more text ",1)
 ;D FORMWRIT^ZZLXDG("",2)
FORMWRIT(X,RMPMODE) ;
 N RMPLI1
 ;if "start" mode
 I RMPMODE=0 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=79
 I $L(X)>0 D ^DIWP
 ;if "write" mode
 I RMPMODE=2 D
 . S RMPLI1=0 F  S RMPLI1=$O(^UTILITY($J,"W",1,RMPLI1)) Q:+RMPLI1=0  W !,$G(^UTILITY($J,"W",1,RMPLI1,0))
 . K ^UTILITY($J,"W")
 Q
 ;
 ;---------------
 ;Initialize variables if you need , your application most likely already has this
INITVARS ;
 D HOME^%ZIS
 S:$G(DT)=0 DT=$$DT^XLFDT
 Q
 ;press any key (used for demo)
PRESSKEY ;
 R !!,"Press any key to continue.",RMPKEY:DTIME
 Q
 ;display code info (used for demo)
CODEINFO(RMPXX2) ; Write Output
 N RMPKEY
 W !," ICD Diagnosis code:",?30,$P(RMPXX2,";",2)
 W !," ICD Diagnosis code IEN:",?30,$P(RMPXX2,";",1)
 W !," Lexicon Expression IEN:",?30,+$P(RMPXX2,";",3)
 W !," ICD Diagnosis description:",?30,$P(RMPXX2,"^",2)
 Q
 ;
