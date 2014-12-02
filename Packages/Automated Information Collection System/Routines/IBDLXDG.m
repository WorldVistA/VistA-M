IBDLXDG ;ALB/CFS - ICD-10 DIAGNOSIS CODE LOOK UP ;03/27/2012
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;APR 24, 1997;Build 80
 ;
 ;
 ;ICRs 
 ; Reference to $$DIAGSRCH^LEX10CS supported by ICR #5681
 ; Reference to $$IMPDATE^LEXU supported by ICR #5679
 ; Reference to $$FREQ^LEXU supported by ICR #5679 
 ; Reference to $$MAX^LEXU supported by ICR #5679
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ; Reference to ^DISV supported by ICR #510
 ;
 ;//---------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; IBDDT - date of interest  (Fileman format)
 ; IBDDFLT - default values for the search string (can be a code by default)
 ; IBDPARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value;IEN file # 757.01^description
 ; results
 ; or -1 if invalid data(press enter)
 ; "" if not found 
 ; or -2 if time out
 ; or -3 if ^ or ^^
 ; or -4 in ICD10 if the user answered NO for the question "Do you wish to continue(Y/N)?"
 ; or -5 if no changes to the default value
DIAG10(IBDDT,IBDDFLT,IBDPARAM) ;
 N IBDROOT,IBDRETV,IBDSPACE S IBDROOT="^ICD9("
 N IBDINP
 F  D  Q:IBDINP<0!($L($P(IBDINP,U,2))>1)!(IBDSPACE=1)
 . ;user enters ANY text like "diabetes" or code or space
 . S IBDSPACE=0
 . S IBDINP=$$SRCHSTR(IBDPARAM("SEARCH_PROMPT"),IBDPARAM("HELP ?"),IBDPARAM("HELP ??"),IBDDFLT)
 . ;process the space  bar recall 
 . I $P(IBDINP,U,2)=" ",$G(IBDROOT)]"" D  S:IBDRETV>0 IBDSPACE=1 Q
 . . ;if space bar was entered then get the last code entered  by the user from ^DISV
 . . S IBDRETV=$$SPACEBAR(IBDDT,IBDROOT,30)
 . . I IBDRETV<0 W "??" Q
 . . W $P(IBDRETV,";",2)
 . I IBDINP'<0 I $L($P(IBDINP,U,2))'>1 W !!,IBDPARAM("ENTER MORE") W:$L(IBDPARAM("ENTER MORE2"))>0 !,IBDPARAM("ENTER MORE2") W ! ;user should enter at least 2 characters
 ;if space bar was entered then get the last code entered  by the user from ^DISV and quit
 I IBDSPACE=1,IBDRETV>0 Q IBDRETV
 I IBDINP<0 Q +IBDINP
 ;
 ;send the search test to Lexicon and let the user pick one
 S IBDRETV=$$LEXICD10($P(IBDINP,U,2),IBDDT,.IBDPARAM)
 ;
 ;if spacebar recall is supported, if code is selected, if it is valid then 
 ;save selection in ^DISV
 I $G(IBDROOT)]"",IBDRETV>0 D SAVSPACE(IBDROOT,+IBDRETV)
 ;
 Q IBDRETV
 ;
 ;
 ;retrieves the last code selected by the user - space bar recall logic here
 ; if nothing then returns -1
 ;IBDDT - date of service
 ;IBDROOT - global root is used in ^DISV (ex. "^ICD9("   ) 
 ;IBDCODSY - coding system for which the user is trying to enter an ICD code. It is used to check 
 ; if the code stored in ^DISV matches the coding system the user is using at the prompt.
 ; 30 - for ICD-10 diagnoses
 ; 1 - for ICD-9  diagnoses
SPACEBAR(IBDDT,IBDROOT,IBDCODSY) ;
 N IBDCODE,IBDRTV,IBDX
 I IBDROOT="^ICD9(" D
 . S IBDCODE=$G(^DISV(DUZ,IBDROOT)) ;needs ICR #510 subscription
 . I +IBDCODE=0 S IBDRTV=-1 Q
 . ;check if the code in ^DISV for the ICD-10 coding system (30 in the 3rd parameter) 
 . ;we don't need to check this for ICD-9 becuase
 . S IBDX=$$ICDDX^ICDEX(IBDCODE,IBDDT,IBDCODSY,"I")
 . S IBDRTV=$P(IBDX,U,1)_";"_$P(IBDX,U,2)_";"_$P(IBDX,U,4)
 ;if IBDROOT is different then implement your own logic here
 Q IBDRTV
 ;
 ;store the selected code for the space bar recall feature
 ;IBDROOT - global root is used in ^DISV (ex. "^ICD9("   ) 
 ;IBDRETV - IEN of the top level entry wiht ICD code field
SAVSPACE(IBDROOT,IBDRETV) ;
 I +$G(DUZ)=0 Q
 I IBDROOT="^ICD9(" D RECALL^DILFD(80,(+IBDRETV)_",",+DUZ) Q  ;need subscription  to ICR #510 
 ;if IBDROOT is different then implement your own logic here
 Q
 ;
 ;
 ;--------------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ; Supported ICR 5681 ($$DIAGSRCH^LEX10CS)
 ;input parameters :
 ; IBDTXT - search string
 ; IBDDATE - date of interest
 ; IBDPAR - array with text messages and other string constants
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; or 
 ; "" if not found 
 ; -1 if exit : ^ or ^^
 ; -2 if continue searching
 ;
LEXICD10(IBDTXT,IBDDATE,IBDPAR) ; ICD-10 Search
 N IBDLVTXT
 ;parameters check
 S IBDDATE=+$G(IBDDATE)
 I IBDDATE'?7N Q -1
 S IBDTXT=$G(IBDTXT)
 Q:'$L(IBDTXT) -1
 N IBDNUMB
 S IBDNUMB=$$FREQ^LEXU(IBDTXT)
 I IBDNUMB>$$MAX^LEXU(30) D  I $$QUESTION(2,IBDPARAM("WISH CONTINUE"),IBDPARAM("YES OR NO"))'=1 Q -4
 . W !
 . D FORMWRIT(IBDPAR("EXCEEDS MESSAGE1")_IBDTXT_IBDPAR("EXCEEDS MESSAGE2")_IBDNUMB_IBDPAR("EXCEEDS MESSAGE3")_IBDTXT_""".",0)
 . D FORMWRIT("",2)
 . W !
 ;new and set variables
 N DIROUT,DUOUT,DTOUT,IBDEXIT,IBDICDNT
 N IBDRETV,IBDXX,IBDLEVEL
 S IBDRETV=""
 S IBDEXIT=0
 S IBDLEVEL=1,IBDLVTXT(IBDLEVEL)=IBDTXT ;level 1 stores the original search string
 ; main loop
 F  Q:IBDEXIT>0  D
 .K IBDICDY
 .;get the search string from the current level and call LEX API
 .;don't pass the date - this will initiate the unversioned lookup for AICS to get all codes - active and inactive
 .S IBDICDY=$$DIAGSRCH^LEX10CS(IBDLVTXT(IBDLEVEL),.IBDICDY,,30)
 .;cleanup the output array:
 .; - leave codes active on the date
 .; - leave codes inactive on the date if their last status is ACTIVE 
 .; - remove codes inactive on the date if their last status is INACTIVE
 .I IBDICDY>0 S IBDICDY=$$REMINARR^IBDUTICD(.IBDICDY,IBDDATE)
 .S:$O(IBDICDY(" "),-1)>0 IBDICDY=+IBDICDY
 .; Nothing found
 .I +IBDICDY'>0 S IBDEXIT=1 S IBDXX=-1 Q
 .; display the list of items and ask the user to select the item from the list
 .S IBDXX=$$SEL^IBDLXDG2(.IBDICDY,4)
 .; if ^ was entered 
 .;   if this is on the top level then quit 
 .I IBDXX=-2,IBDLEVEL'>1 S IBDRETV=-1 S IBDEXIT=1 Q
 .;   if lower level then go one level up
 .I IBDXX=-2,IBDLEVEL>1 S:IBDLEVEL>1 IBDLEVEL=IBDLEVEL-1 Q
 .; If timeout, or not selected, or ^^ then quit
 .I IBDXX=-1 S IBDRETV=-1 S IBDEXIT=1 Q
 .; if Code Found and Selected by the user save selection in IBDRETV and quit
 .I $P(IBDXX,";")'="99:CAT" S IBDRETV=IBDXX S IBDEXIT=1 Q
 .; If Category Found and Selected by the user:  
 .;  go to the next inner level
 .;  change level number 
 .S IBDLEVEL=IBDLEVEL+1
 .;  set the new level with the new search string
 .;  and repeat 
 .S IBDLVTXT(IBDLEVEL)=$P($P($G(IBDXX),"^"),";",2)
 Q IBDRETV
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
 W !!," 19 matches found"
 W !!," M91. - Juvenile osteochondrosis of hip and pelvis (19)"
 W !!," This indicates that 19 unique matches or matching groups have been found"
 W !," and will be displayed."
 W !!," M91. - the ""-"" indicates that there are additional characters that specify"
 W !," unique ICD-10 codes available."
 W !!," (19) Indicates that there are 19 additional ICD-10 codes in the M91 ""family"""
 W !," that are possible selections."
 Q
 ;--------
 ;prompt the user for a date of interest 
 ;input parameters :
 ; IBDPRMT - prompt
 ;returns YYYMMDD
 ; or -1 if invalid date
 ; or -2 if time out
 ; or -3 if ^
ASKDATE(IBDPRMT) ;
 N %DT,DIROUT,DUOUT,DTOUT
 S %DT="AEX",%DT("A")=$G(IBDPRMT,"Enter a date: ")
 D ^%DT
 Q:Y<0 -1
 Q:$D(DTOUT) -2
 Q:X="^" -3
 Q (+Y)
 ;--------
 ;ask YES/NO questions
 ;input parameters :
 ; IBDDFLT- 0/null- not default, 1- yes, 2 -no
 ; IBDPROM - prompt string
 ;returns 
 ; 2 - no,
 ; 1 - yes,
 ; 0 - no answer (time out)
 ; -3 - ^ or ^^
QUESTION(IBDDFLT,IBDPROM,IBDHELP) ;
 N DIR
 S %=$G(IBDDFLT,2)
 S DIR(0)="Y",DIR("A")=IBDPROM,DIR("B")=$S(%=1:"Yes",%=2:"No",1:"")
 S:$L($G(IBDHELP)) DIR("?")=IBDHELP
 D ^DIR
 Q:Y["^" -3
 Q:Y=1 1
 Q:Y=0 2
 Q 0
 ;
 ;------------
 ;get search string
 ;input parameters :
 ; IBDPRMT prompt text
 ; IBDHLP1 "?" help text
 ; IBDHLP2 "??" help text
 ; IBDDFLT- default response
 ;returns piece1 ^ piece 2
 ; piece1:
 ; 0 if normal input
 ; or -1 if invalid data
 ; or -2 if time out
 ; or -3 if ^
 ; or -5 if user accepts default value then no need to validate it
 ; or -6 if user enters "@"
 ; piece2: string entered by the user
SRCHSTR(IBDPRMT,IBDHLP1,IBDHLP2,IBDDFLT) ;
 N DIR
 S DIR("A")=IBDPRMT
 S:($G(IBDHLP1)]"") DIR("?")=IBDHLP1
 S:($G(IBDHLP2)]"") DIR("??")=IBDHLP2
 I $L($G(IBDDFLT)) S DIR("B")=IBDDFLT
 S DIR(0)="FAOR^0:245"
 D ^DIR
 Q:$D(DTOUT) -2
 Q:$D(DUOUT) -3
 ;Q:X="@" -6 ;quit if user entered "@" and handle deletion case in your application  - not used in AICS
 Q:Y["^" -3
 Q:Y="" -1
 ;Q:(($L($G(IBDDFLT)))&(Y=IBDDFLT)) -5 ;if user accepts default value then no need to validate it - not used in AICS
 Q 0_U_Y
 ;
 ;----------
 ;Determines and returns ACTIVE coding system for DIAGNOSES based on date of interest 
 ;input parameters :
 ; IBDICDD - date of interest
 ; if date of interest is null, today's date will be assumed
 ;returns coding system  
 ; as a pointer to the ICD CODING SYSTEM file #80.4 (supported ICR 5780) 
 ; 30  if ICD-10-CM is active system
 ; 1   if ICD-9-CM is active system
ICDSYSDG(IBDICDD) ; 
 N IBDIMPDT
 S IBDICDD=$S(IBDICDD<0!($L(+IBDICDD)'=7):DT,1:+$G(IBDICDD))
 S IBDIMPDT=$$IMPDATE^LEXU("10D")
 Q $S(IBDICDD'<IBDIMPDT:30,1:1)
 ;
 ;set parameters
 ;edit these hardcoded strings that are used for prompts, messages and so on to adjust them to your application's needs
 ;input parameters 
 ; IBDPAR - local array to sets and store string constants for your messages and prompts 
SETPARAM(IBDPAR) ;
 S IBDPAR("ASKDATE")="Date of interest? "
 S IBDPAR("SEARCH_PROMPT")="Enter Diagnosis, a Code or a Code Fragment: "
 S IBDPAR("HELP ?")="^D INPHLP^IBDLXDG"
 S IBDPAR("HELP ??")="^D INPHLP2^IBDLXDG"
 S IBDPAR("NO DATA FOUND")=" No records found matching the value entered, revise search or enter ""?"" for"
 S IBDPAR("NO DATA FOUND 2")=" help."
 S IBDPAR("EXITING")="  Exiting"
 S IBDPAR("TRY LATER")="  Try again later"
 S IBDPAR("NO DATA SELECTED")="  No data selected"
 S IBDPAR("TRY ANOTHER")="Try another"
 S IBDPAR("WISH CONTINUE")="Do you wish to continue (Y/N)"
 S IBDPAR("EXCEEDS MESSAGE1")="Searching for """
 S IBDPAR("EXCEEDS MESSAGE2")=""" requires inspecting "
 S IBDPAR("EXCEEDS MESSAGE3")=" records to determine if they match the search criteria.  This could take quite some time.  Suggest refining the search by further specifying """
 S IBDPAR("ENTER MORE")=" Please enter at least the first two characters of the ICD-10 code or code"
 S IBDPAR("ENTER MORE2")=" description to start the search."
 S IBDPAR("YES OR NO")="Answer 'Y' for 'Yes' or 'N' for 'No'"
 Q
 ;
 ;
 ;a wrapper for ^DIWP
 ;accumulates a text and then writes it to the device
 ;input parameters :
 ; X - text
 ; IBDMODE:
 ;  0 - start
 ;  1 - accumulate 
 ;  2 - write
 ;example:
 ;D FORMWRIT^IBDLXDG("this API is a wrapper for ^DIWP, it accumulates a text and then writes it to the device, you can use it in your application code",0)
 ;D FORMWRIT^IBDLXDG("some more text ",1)
 ;D FORMWRIT^IBDLXDG("",2)
FORMWRIT(X,IBDMODE) ;
 N IBDLI1,DIWL,DIWR
 ;if "start" mode
 I IBDMODE=0 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=79
 I $L(X)>0 D ^DIWP
 ;if "write" mode
 I IBDMODE=2 D
 . S IBDLI1=0 F  S IBDLI1=$O(^UTILITY($J,"W",1,IBDLI1)) Q:+IBDLI1=0  W !,$G(^UTILITY($J,"W",1,IBDLI1,0))
 . K ^UTILITY($J,"W")
 Q
 ;
 ;---------------
 ;Initialize variables if you need , your application most likely already has this
INITVARS ;
 D HOME^%ZIS
 S:$G(DT)=0 DT=$$DT^XLFDT
 Q
 ;
