FBASF ;AISC/JLG - ICD10 DIAGNOSIS CODE ASF (Advanced Search Functionality) ;3/26/2012
 ;;3.5;FEE BASIS;**139**;JAN 30, 1995;Build 127
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to API $$CODEN^ICDEX supported by ICR #5747
 ;
 ;Prompt for ICD10 diagnosis entries  
 ; params, 1-Diagnosis prompt
 ;         2-prompt line number (null if no number)
 ;         3-allow up arrow (^) flag (optional) -if this is set to "Y" then the up arrow will be accepted for early exit
 ;         4-allow deletion of DX field? (optional)  -if this is set to "Y", @ is an acceptable entry
 ;         5-allow forcing a field to be required (optional)  -if this is set to "Y", the field will be forced to be required
ASKICD10(DXPRMPT,LNNUM,ALWUPA,ALDEL,ALFREQ) ;
 N FBOUT,FBDC,ICDRET,FBTMP,FBPRMPT  S FBDC=""
 S FBPRMPT=DXPRMPT_LNNUM
 S ICDRET=$$EN(EDATE,FBDC) ; EDATE must be assigned prior to calling this s/r. It represents 'date of interest'
 D EXIT
 Q ICDRET ;returns the value of ien or -1
 ; 
EN(EFFDATE,X) ; -- params 1-date of interest 2-diagnosis code
 N FBQUIT,FBRETV,FBPARAM,FBCSYS,FBOUT,FBDFN
 D SETPARAM(.FBPARAM) ; set screen messages
 S FBDT=EFFDATE,FBFILE=DP,FBIEN=DA,FBDFLT="",FBRETV=0,FBOUT=""
 S:$D(DFN) FBDFN=DFN
 ; 161.01 is the sub-field authorization in fee basis patient file
 S:FBFILE="161.01" FBDFLT=$$GETDC^FBASFU(FBFILE,FBDFN,FBIEN)
 ; 162.7 is the unauthorized claim funds file
 S:FBFILE="162.7" FBDFLT=$$GETDCUC^FBASFU(FBFILE,FBIEN)
 S:FBDFLT']"" FBDFLT=$$GETVAL^FBASFU(FBFILE,FBIEN,FBPARAM("FIELD_NAME")) ; set default value if applicable
 ;
EN1 ; 
 S FBRETV=$$DIAG10(FBDT,FBDFLT,.FBPARAM)
 I (FBRETV']"")!(FBRETV<0) Q FBRETV
 I FBRETV="@" Q FBRETV ; don't print labels for deletions
 S FBRETV=$$PRTICD10^FBASFU(FBRETV) ; prints ICD code and description to the screen
 S FBRETV=$P($P(FBRETV,"^"),";")
 G:FBRETV=-1 EN1
 Q FBRETV ; returns IEN file #80 or -1
 ;//---------
 ;The entry point for ICD-10 diagnosis search functionality
 ;input parameters :
 ; FBDT - date of interest
 ; FBDFLT - default values for the search string (can be a code by default)
 ; FBPARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; results
 ; or -1 if invalid data(press enter)
 ; "" if not found 
 ; or -2 if time out
 ; or -3 if ^ or ^^
 ; or -4 in ICD10 if the usre answered NO for the question "Do you wish to continue(Y/N)?"
 ; or -5 if deletion of DX field is attempted
 ; 
DIAG10(FBDT,FBDFLT,FBPARAM) ;
 N FBINP,FBTMP,FBREQFLDMP
 S:'$D(ALWUPA) ALWUPA="N" ; up arrow allow flag
 S:'$D(ALDEL) ALDEL="N" ; delete allow flag
 S:'$D(ALFREQ) ALFREQ="N" ; force required allow flag
ASKAGAIN ;
 S FBINP=$$SRCHSTR(FBPARAM("SEARCH_PROMPT"),FBPARAM("HELP ?"),FBPARAM("HELP ??"),FBDFLT)
 ;user should enter at least 2 characters
 I FBINP'<0 I $L($P(FBINP,U,2))'>1 W !!,FBPARAM("ENTER MORE") W:$L(FBPARAM("ENTER MORE2"))>0 !,FBPARAM("ENTER MORE2") W ! G ASKAGAIN
 ; return values from SRCHSTR function ... $D(DTOUT) -2, $D(DUOUT) -3, Y["^" -3, Y="" -1, otherwise 0_U_Y
 Q:FBINP=-2 FBINP ; timed out
 Q:(ALWUPA="Y")&(FBINP=-3) FBINP ; "^" entered
 S FBREQFLD=$$REQFLD^FBASFU(FBFILE,FBPARAM("FIELD_NAME"))
 I ((ALFREQ="Y")&(FBINP=-5)) S FBREQFLD=0
 I ((FBINP=-5)&('FBREQFLD)) W FBPARAM("REQUIRED") G ASKAGAIN
 I ALDEL="Y",FBINP=-5,$G(FBDFLT)="" S ALDEL="N"
 I ALDEL="Y",FBINP=-5 N FBYN D  Q:FBYN=1 "@" G ASKAGAIN
 . S FBYN=$$QUESTION^FBASF(2,"SURE YOU WANT TO DELETE")
 . I FBYN'=1 W FBPARAM("NOTHING DELETED")
 I FBINP=-5 W "??" G ASKAGAIN
 I ((FBREQFLD=-1)&(FBINP=-3)) W !,FBPARAM("EXIT NOT ALLOWED") G ASKAGAIN
 Q:((FBREQFLD=-1)&(FBINP'[U)) FBINP ; if not a required field and NOT a valid search string for icd code
 I FBINP=-1 D   ; if a space is entered for a required field
 . W "??"
 . I FBPARAM("SEARCH_PROMPT")["ADMITTING DIAGNOSIS" W !,FBPARAM("ENTER ADM DIAG")
 I ((FBREQFLD=0)&(FBINP=-1)) G ASKAGAIN ;space entered for required field
 I FBINP=-3 W !,FBPARAM("EXIT NOT ALLOWED") G ASKAGAIN ;^ entered for all ICD fields
 S FBTMP=$$STATCHK^FBASFU($P(FBINP,U,2),FBDT) ; check if icd code is inactive
 G:FBTMP=-1 ASKAGAIN ; If icd code is inactive
 N FBMATCH S FBMATCH=$$ISMATCH($P(FBINP,U,2))
 S FBINP=$$LEXICD10($P(FBINP,U,2),FBDT,.FBPARAM)
 G:FBINP=-4 ASKAGAIN ; if the threshold for the results is reached and user wants to refine search criteria
 I FBINP']"" W !,FBPARAM("NO MATCHES FOUND") I FBPARAM("SEARCH_PROMPT")["ADMITTING DIAGNOSIS" W !,"  ",FBPARAM("ENTER ADM DIAG")
 G:FBINP']"" ASKAGAIN
 G:FBINP=-1 ASKAGAIN
 Q FBINP_"^"_FBMATCH
 ;
 ;input parameter - diagnosis code
 ;Returns 0 (zero) if diagnosis code is an exact match, otherwise return -1
ISMATCH(FBDCDE) ;
 N FBMFLG S FBMFLG=-1 ;set default to -1
 S:$$CODEN^ICDEX(FBDCDE,80)>0 FBMFLG=0
 Q FBMFLG
 ;--------------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ; Supported ICR 5681 ($$DIAGSRCH^LEX10CS)
 ;input parameters :
 ; FBTXT - search string
 ; FBDATE - date of interest
 ; FBPAR - array with text messages and other string constants
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; or 
 ; "" if not found 
 ; -1 if exit : ^ or ^^
 ; -2 if continue searching
 ;
LEXICD10(FBTXT,FBDATE,FBPAR) ; ICD-10 Search
 N FBLVTXT
 ;parameters check
 S FBDATE=+$G(FBDATE)
 I FBDATE'?7N Q -1
 S FBTXT=$G(FBTXT)
 Q:'$L(FBTXT) -1
 N FBNUMB
 S FBNUMB=$$FREQ^LEXU(FBTXT)
 I FBNUMB>$$MAX^LEXU(30) D  I $$QUESTION(2,FBPARAM("WISH CONTINUE"),FBPARAM("YES OR NO"))'=1 Q -4
 . D FORMWRIT(FBPAR("EXCEEDS MESSAGE1")_FBTXT_FBPAR("EXCEEDS MESSAGE2")_FBNUMB_FBPAR("EXCEEDS MESSAGE3")_FBTXT_""".",0)
 . D FORMWRIT("",2)
 ;new and set variables
 N DIROUT,DUOUT,DTOUT,FBEXIT,FBICDNT
 N FBRETV,FBXX,FBLEVEL
 S FBRETV=""
 S FBEXIT=0
 S FBLEVEL=1,FBLVTXT(FBLEVEL)=FBTXT ;level 1 stores the original search string
 ; main loop
 F  Q:FBEXIT>0  D
 .K FBICDY
 .;get the search string from the current level and call LEX API
 .S FBICDY=$$DIAGSRCH^LEX10CS(FBLVTXT(FBLEVEL),.FBICDY,FBDATE,30)
 .S:$O(FBICDY(" "),-1)>0 FBICDY=+FBICDY
 .; Nothing found
 .I +FBICDY'>0 S FBEXIT=1 S FBXX=-1 Q
 .; Single match found for partial text search
 .I FBMATCH<0,FBLEVEL=1,FBICDY=1 S FBMATCH=0
 .; display the list of items and ask the user to select the item from the list
 .S FBXX=$$SEL^FBASFL(.FBICDY,8)
 .; if ^ was entered 
 .;   if this is on the top level then quit 
 .I FBXX=-2,FBLEVEL'>1 S FBRETV=-1 S FBEXIT=1 Q
 .;   if lower level then go one level up
 .I FBXX=-2,FBLEVEL>1 S:FBLEVEL>1 FBLEVEL=FBLEVEL-1 Q
 .; If timeout, or not selected, or ^^ then quit
 .I FBXX=-1 S FBRETV=-1 S FBEXIT=1 Q
 .; if Code Found and Selected by the user save selection in FBRETV and quit
 .I $P(FBXX,";")'="99:CAT" S FBRETV=FBXX S FBEXIT=1 Q
 .; If Category Found and Selected by the user:  
 .;  go to the next inner level
 .;  change level number 
 .S FBLEVEL=FBLEVEL+1
 .;  set the new level with the new search string
 .;  and repeat 
 .S FBLVTXT(FBLEVEL)=$P($P($G(FBXX),"^"),";",2)
 Q FBRETV
 ;
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
 ;ask YES/NO questions
 ;input parameters :
 ; FBDFLT- 0/null- not default, 1- yes, 2 -no
 ; FBPROM - prompt string
 ; FBHELP - help text
 ;returns 
 ; 2 - no,
 ; 1 -yes,
 ; 0 - no answer (time out)
 ; -3 - ^ or ^^
 ; 0 - no answer
QUESTION(FBDFLT,FBPROM,FBHELP) ;
 N DIR
 S %=$G(FBDFLT,2)
 S DIR(0)="Y",DIR("A")=FBPROM,DIR("B")=$S(%=1:"Yes",%=2:"No",1:"")
 S:$L($G(FBHELP)) DIR("?")=FBHELP
 D ^DIR
 Q:Y["^" -3
 Q:Y=1 1
 Q:Y=0 2
 Q 0
 ;
 ;------------
 ;get search string
 ;input parameters :
 ; FBPRMT prompt text
 ; FBHLP1 "?" help text
 ; FBHLP2 "??" help text
 ; FBDFLT- default response
 ;returns piece1 ^ piece 2
 ; piece1:
 ; 0 if normal input
 ; or -1 if invalid data
 ; or -2 if time out
 ; or -3 if ^
 ; or -5 if @
 ; piece2: string entered by the user
SRCHSTR(FBPRMT,FBHLP1,FBHLP2,FBDFLT) ;
 N DIR
 S DIR("A")=FBPRMT
 S DIR("?")=FBHLP1
 S DIR("??")=FBHLP2
 I $L($G(FBDFLT)) S DIR("B")=FBDFLT
 S DIR(0)="FAOr^0:245"
 D ^DIR
 Q:$D(DTOUT) -2
 Q:$D(DUOUT) -3
 Q:X="@" -5
 Q:Y["^" -3
 Q:Y="" -1
 Q 0_U_Y
 ;
 ;set parameters
 ;input parameters 
 ; FBPAR - local array to sets and store string constants for your messages and prompts 
SETPARAM(FBPAR) ;
 S FBPAR("ASKDATE")="Date of interest? "
 I FBPRMPT'[":" S FBPRMPT=FBPRMPT_": "
 S FBPAR("SEARCH_PROMPT")=FBPRMPT
 S FBPAR("HELP ?")="^D INPHLP^FBASF"
 S FBPAR("HELP ??")="^D INPHLP2^FBASF"
 S FBPAR("NO DATA FOUND")="  No data found"
 S FBPAR("EXITING")="  Exiting"
 S FBPAR("TRY LATER")="  Try again later"
 S FBPAR("NO DATA SELECTED")="  No data selected"
 S FBPAR("TRY ANOTHER")="Try another"
 S FBPAR("WISH CONTINUE")="Do you wish to continue(Y/N)"
 S FBPAR("EXCEEDS MESSAGE1")="Searching for """
 S FBPAR("EXCEEDS MESSAGE2")=""" requires inspecting "
 S FBPAR("EXCEEDS MESSAGE3")=" records to determine if they match the search criteria.  This could take quite some time.  Suggest refining the search by further specifying """
 S FBPAR("NO MATCHES FOUND")="  No matches found??"
 S FBPAR("ENTER ADM DIAG")="  Enter the admitting diagnosis for this claim."
 S FBPAR("EXIT NOT ALLOWED")="   Exit not allowed??"
 S FBPAR("ENTER MORE")=" Please enter at least the first two characters of the ICD-10 code or code"
 S FBPAR("ENTER MORE2")=" description to start the search."
 S FBPAR("YES OR NO")="Answer 'Y' for 'Yes' or 'N' for 'No'"
 S FBPAR("NOTHING DELETED")="  <NOTHING DELETED>"
 S FBPAR("REQUIRED")="??  Required"
 N FBX S FBX=FBPRMPT
 F  Q:(($E(FBX)'=" ")&($E(FBX)'?1C))  S FBX=$E(FBX,2,99) ; remove leading space or control chars.
 S FBPAR("FIELD_NAME")=$P(FBX,":")
 Q
 ;
 ;
 ;a wrapper for ^DIWP
 ;accumulates a text and then writes it to the device
 ;input parameters :
 ; X - text
 ; FBMODE:
 ;  0 - start
 ;  1 - accumulate 
 ;  2 - write
 ;example:
 ;D FORMWRIT^FBASF("this API is a wrapper for ^DIWP, it accumulates a text and then writes it to the device, you can use it in your application code",0)
 ;D FORMWRIT^FBASF("some more text ",1)
 ;D FORMWRIT^FBASF("",2)
FORMWRIT(X,FBMODE) ;
 N FBLI1
 ;if "start" mode
 I FBMODE=0 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=79
 I $L(X)>0 D ^DIWP
 ;if "write" mode
 I FBMODE=2 D
 . S FBLI1=0 F  S FBLI1=$O(^UTILITY($J,"W",1,FBLI1)) Q:+FBLI1=0  W !,$G(^UTILITY($J,"W",1,FBLI1,0))
 . K ^UTILITY($J,"W")
 Q
 ;
 ; Clean up environment and quit
EXIT ;
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,%Y,FBDT,FBFILE,FBIEN,FBDFLT,FBOUT,FBREQFLD,DXPRMPT,LNNUM,DIWL,DIWR
 Q
 ;
