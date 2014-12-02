HBHCLKU1 ;ALB/KG - DIAGNOSIS VALIDATION AND LOOK UP ;5/15/12
 ;;1.0;HOSPITAL BASED HOME CARE;**25**;NOV 01, 1993;Build 45
 ;
 ; This routine references the following supported ICRs:
 ; 5747    $$CODEC^ICDEX
 ; 5747    $$VSTD^ICDEX
 ; 5747    $$CSI^ICDEX
 ; 5747    $$SYS^ICDEX
 ; 5747    $$SAI^ICDEX
 ; 5681    $$DIAGSRCH^LEX10CS
 ; 5679    $$FREQ^LEXU
 ; 5679    $$MAX^LEXU
 ; 5773    FileMan lookup for file #80
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;HBH*1.0*25   APR  2012   K GUPTA      Support for ICD-10 Coding System
 ;******************************************************************************
 ;******************************************************************************
 ;
 ;---------
 ;Diagnosis validation based on Evaluation/Admission date
 ;Called by:
 ; - PROMPT^HBHCADM
ADMDXVLD ;
 D DXVLD(1,HBHCDFN)
 Q
 ;
 ;---------
 ;Diagnosis validation based on Discharge date
 ;Called by:
 ; - HBHC DISCHARGE Input Template
 ; - HBHC UPDATE DISCHARGE Input Template
 ;Input parameters:
 ; HBHCDFN1  - ^HBHC(631 IEN
DCDXVLD(HBHCDFN1) ;
 D DXVLD(2,HBHCDFN1)
 Q
 ;
 ;---------
 ;Diagnosis validation based on date entry
 ;Input parameters:
 ; HBHCMODE - Admission or Discharge
 ; HBHCDFN1  - ^HBHC(631 IEN
DXVLD(HBHCMODE,HBHCDFN1) ;
 N HBHCDT,HBHCCURDXIEN
 ;date of interest
 I HBHCMODE=1 S HBHCDT=$P($G(^HBHC(631,HBHCDFN1,0)),U,18) I 1  ;admission date
 E  I HBHCMODE=2 S HBHCDT=$P($G(^HBHC(631,HBHCDFN1,0)),U,40)  ;discharge date
 S HBHCCURDXIEN=$$GETDX(HBHCMODE,HBHCDFN1)
 ;check if dx's coding system is still valid based on date of interest
 ;if not valid then clear out old value
 I HBHCCURDXIEN>0,'$$CHECKDX(HBHCCURDXIEN,HBHCDT) D SAVEDX(HBHCMODE,HBHCDFN1,"","")
 Q
 ;
 ;Diagnosis defaulting for Discharge
 ;Called by:
 ; - HBHC DISCHARGE Input Template
 ; - HBHC UPDATE DISCHARGE Input Template
 ;Input parameters:
 ; HBHCDFN1 - File #631 - patient identifier
 ;Output value:
 ; Admission dx if coding system matches with coding system of discharge date
 ;
DFLTDCDX(HBHCDFN1) ;
 N HBHCDCDX,HBHCADMDX,HBHCDCDT
 S HBHCDCDX=$P($G(^HBHC(631,HBHCDFN1,0)),U,47) ; PRIMARY DIAGNOSIS @ DISCHARGE
 I HBHCDCDX="" D
 . S HBHCADMDX=$P($G(^HBHC(631,HBHCDFN1,0)),U,19)  ;admission dx
 . Q:HBHCADMDX=""
 . S HBHCDCDT=$P($G(^HBHC(631,HBHCDFN1,0)),U,40)  ;discharge date
 . ;default adm dx only if dx coding system matches with discharge date's coding system
 . S:$$CHECKDX(HBHCADMDX,HBHCDCDT) HBHCDCDX=HBHCADMDX
 Q HBHCDCDX
 ;
 ;Diagnosis validation based on date of interest
 ;Input parameters:
 ; HBHCDX - Diagnosis IEN
 ; HBHCDT - Date of interest
 ;Output value:
 ; "1" - if coding system matches
 ; ""  - error or if coding system don't match
 ;
CHECKDX(HBHCDX,HBHCDT) ;
 N HBHCDXCS,HBHCDTCS
 Q:(HBHCDX="")!(HBHCDT="") ""
 S HBHCDXCS=$$CSI^ICDEX("80",HBHCDX)  ;determine coding system for dx
 Q:HBHCDXCS="" ""
 S HBHCDTCS=$$SYS^ICDEX("80",HBHCDT,"I")  ;determine coding system for date
 Q:HBHCDTCS=-1 ""
 Q:HBHCDXCS=HBHCDTCS "1"  ;if two coding system matches
 Q ""
 ;
 ;---------
 ;Diagnosis entry for Evaluation/Admission
 ;Called by:
 ; - PROMPT^HBHCADM
ADMDX ;
 D ICD(1,HBHCDFN)
 Q
 ;
 ;---------
 ;Diagnosis entry for Discharge
 ;Called by:
 ; - HBHC DISCHARGE Input Template
 ; - HBHC UPDATE DISCHARGE Input Template
 ;Input parameters:
 ; HBHCDFN1  - ^HBHC(631 IEN
DCDX(HBHCDFN1) ;
 D ICD(2,HBHCDFN1)
 Q
 ;
 ;---------
 ;Diagnosis entry
 ;Input parameters
 ; HBHCMODE - Admission or Discharge
 ; HBHCDFN1  - ^HBHC(631 IEN
ICD(HBHCMODE,HBHCDFN1) ;
 D INITVARS ;set standards variables, you might not need this if it was already done in your application  
 N HBHCRETV,HBHCPARAM,HBHCDT,HBHCSYS,HBHCDFLT,HBHCCURDXIEN,HBHCQUIT,HBHCNEWDXIEN
 ;date of interest
 I HBHCMODE=1 S HBHCDT=$P($G(^HBHC(631,HBHCDFN1,0)),U,18) I 1  ;admission date
 E  I HBHCMODE=2 S HBHCDT=$P($G(^HBHC(631,HBHCDFN1,0)),U,40)   ;discharge date
 S HBHCSYS=$$SYS^ICDEX("80",HBHCDT,"I")  ;determine coding system based on the date of interest
 ;settings
 D SETPARAM(.HBHCPARAM,HBHCMODE,HBHCSYS)
 ;default response for the prompt
 S HBHCDFLT=""
 S HBHCCURDXIEN=+$$GETDX(HBHCMODE,HBHCDFN1)
 S:HBHCCURDXIEN>0 HBHCDFLT=$$CODEC^ICDEX(80,HBHCCURDXIEN)_"  "_$$VSTD^ICDEX(HBHCCURDXIEN,HBHCDT)
 S HBHCQUIT=0 F  Q:HBHCQUIT=1  D
 . S HBHCRETV=0
 . ;run either ICD9 or ICD10 prompt/search/select logic
 . ;ICD9 (1 is a pointer to the ICD-9 diagnosis system entry in the new file #80.4 )
 . I HBHCSYS=1 S HBHCRETV=$$DIAG9(HBHCDT,HBHCDFLT,.HBHCPARAM) I 1
 . ;ICD10 (30 is a pointer to the ICD-10 diagnosis system entry in the new file #80.4 )
 . E  I HBHCSYS=30 S HBHCRETV=$$DIAG10(HBHCDT,HBHCDFLT,.HBHCPARAM)
 . D CLEANUP
 . S HBHCNEWDXIEN=$P(HBHCRETV,";",1)
 . I HBHCNEWDXIEN>0 D SAVEDX(HBHCMODE,HBHCDFN1,HBHCNEWDXIEN,HBHCDT) S HBHCQUIT=1 Q   ;if a new dx is selected
 . I HBHCNEWDXIEN=-1 S HBHCQUIT=1 Q      ;Dx entry prompt: user pressed "enter" with no default, so quit dx entry and go to next prompt
 . I HBHCNEWDXIEN=-2 S Y=0,HBHCQUIT=1 Q  ;Dx entry prompt: timed out, so quit dx entry and quit entire admission entry
 . I HBHCNEWDXIEN=-3 S Y=0,HBHCQUIT=1 Q  ;Dx entry prompt: user entered "^", so quit entry and quit entire admission entry
 . I HBHCNEWDXIEN=-4 S HBHCQUIT=1 Q      ;Dx entry prompt: user pressed "enter" with default value
 . I HBHCNEWDXIEN=-5 D  Q                ;Dx entry prompt: user entered "@", so ask Y/N question to user
 . . I HBHCCURDXIEN'>0 S HBHCQUIT=0 Q
 . . I $$QUESTION("",HBHCPARAM("DELETE?"))=1 D  I 1
 . . . D SAVEDX(HBHCMODE,HBHCDFN1,"",HBHCDT)
 . . . S HBHCQUIT=1
 . . E  S HBHCQUIT=0
 . I HBHCNEWDXIEN=-6 S Y=0,HBHCQUIT=1 Q  ;Dx search prompt: timed out, so quit dx entry and quit entire admission entry
 . I HBHCNEWDXIEN=-7 S HBHCQUIT=0 Q      ;Dx search prompt: user entered "^" or "^^", so quit search, ask dx entry again
 . I HBHCNEWDXIEN=-8 S HBHCQUIT=0 Q      ;Dx search prompt: user selected nothing, so ask dx entry again
 . I HBHCNEWDXIEN=-9 S HBHCQUIT=0 Q      ;Dx search prompt: in ICD10 if the user answered NO when warned about lot of result found
 . I HBHCNEWDXIEN="" W "  No data found",! S HBHCQUIT=0 Q  ;Dx search prompt: no data found when user searched, so ask dx entry again
 Q
 ;
 ;---------
 ;Save Admission or Discharge diagnosis
 ;Input parameters
 ; HBHCMODE  - Admission or Discharge
 ; HBHCDFN1   - ^HBHC(631 IEN
 ; HBHCDXIEN - Diagnosis IEN
 ; HBHCDT    - Date of interest
SAVEDX(HBHCMODE,HBHCDFN1,HBHCDXIEN,HBHCDT) ;
 N HBHCPC
 I HBHCMODE=1 S HBHCPC=19 I 1
 E  I HBHCMODE=2 S HBHCPC=47
 S $P(^HBHC(631,HBHCDFN1,0),U,HBHCPC)=HBHCDXIEN
 W:HBHCDXIEN>0 "  "_$$CODEC^ICDEX(80,HBHCDXIEN)_"  "_$$VSTD^ICDEX(HBHCDXIEN,HBHCDT)
 Q
 ;
 ;---------
 ;Get Admission or Discharge diagnosis
 ;Input parameters
 ; HBHCMODE  - Admission or Discharge
 ; HBHCDFN1   - ^HBHC(631 IEN
GETDX(HBHCMODE,HBHCDFN1) ;
 N HBHCPC
 I HBHCMODE=1 S HBHCPC=19 I 1
 E  I HBHCMODE=2 S HBHCPC=47
 Q $P($G(^HBHC(631,HBHCDFN1,0)),U,HBHCPC)
 ;
 ;---------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; HBHCDT - date of interest (Fileman format)
 ; HBHCDFLT - default values for the search string (can be a code by default)
 ; HBHCPARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-10 code selected by the user:
 ; IEN file #80;ICD code value;IEN file #757.01^description
 ; results
 ; or -1 Dx entry prompt: if invalid data(press enter)
 ; or -2 Dx entry prompt: if time out
 ; or -3 Dx entry prompt: if ^ or ^^
 ; or -4 Dx entry prompt: if no changes to the default value
 ; or -5 Dx entry prompt: if user enters "@"
 ; or -6 Dx search prompt: if timed out
 ; or -7 Dx search prompt: search was aborted by user by entering "^" or "^^"
 ; or -8 Dx search prompt: user selected nothing
 ; or -9 Dx search prompt: if the user answered NO for the question "Do you wish to continue(Y/N)?"
 ; or "" Dx search prompt: if not found
 ; 
DIAG10(HBHCDT,HBHCDFLT,HBHCPARAM) ;
 N HBHCINP,HBHCRETV
 F  D  Q:HBHCINP<0!($L($P(HBHCINP,U,2))>1)
 . S HBHCINP=$$SRCHSTR(HBHCPARAM("SEARCH_PROMPT"),HBHCPARAM("HELP ?"),HBHCPARAM("HELP ??"),HBHCDFLT)
 . I HBHCINP'<0 I $L($P(HBHCINP,U,2))'>1 W !!,HBHCPARAM("ENTER MORE") W:$L(HBHCPARAM("ENTER MORE2"))>0 !,HBHCPARAM("ENTER MORE2") W ! ;user should enter at least 2 characters
 I HBHCINP<0 Q +HBHCINP
 S HBHCRETV=$$LEXICD10($P(HBHCINP,U,2),HBHCDT,.HBHCPARAM)
 I HBHCRETV=-1 Q -8   ;non selection
 I HBHCRETV=-2 Q -6   ;search timed out
 I HBHCRETV=-3 Q -7   ;search was aborted by user by entering "^" or "^^"
 I HBHCRETV=-4 Q -9   ;user answered NO for the question "Do you wish to continue(Y/N)?" when search returned lot of values
 Q HBHCRETV
 ;
 ;---------
 ;The entry point for ICD-9 FileMan type (^DIC) diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; HBHCDT - date of interest
 ; HBHCDFLT - default values for the search string (can be a code by default)
 ; HBHCPARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-9 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; or -1 Dx entry prompt: if invalid data(press enter)
 ; or -2 Dx entry prompt: if time out
 ; or -3 Dx entry prompt: if ^ or ^^
 ; or -4 Dx entry prompt: if no changes to the default value
 ; or -5 Dx entry prompt: if user enters "@"
 ; or -6 Dx search prompt: if time out
 ; or -7 Dx search prompt: search was aborted by user by entering "^" or "^^"
 ; or -8 Dx search prompt: user selected nothing
 ; or "" Dx search prompt: if not found
 ;
DIAG9(HBHCDT,HBHCDFLT,HBHCPARAM) ;
 N HBHCINP,HBHCRETV
 S HBHCINP=$$SRCHSTR(HBHCPARAM("SEARCH_PROMPT"),HBHCPARAM("HELP ?"),HBHCPARAM("HELP ??"),HBHCDFLT)
 I +HBHCINP<0 Q +HBHCINP
 S HBHCRETV=$$FMICD9($P(HBHCINP,U,2),HBHCDT)
 S HBHCRETV=$P(HBHCRETV,U,1)
 I HBHCRETV=-3 Q -6  ;search timed-out
 I HBHCRETV=-2 Q -7  ;search was aborted by user by entering "^" or "^^"
 I HBHCRETV=-1 Q -8  ;user selected nothing or no values found
 Q HBHCRETV
 ;
 ;---------
 ;The entry point for ICD-10 diagnosis search functionality
 ;input parameters :
 ; HBHCTXT - search string
 ; HBHCDATE - date of interest
 ; HBHCPAR - array with text messages and other string constants
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; or 
 ; "" if not found 
 ; -1 if non selection
 ; -2 if search timed out
 ; -3 if search was aborted by user by entering "^" or "^^"
 ; -4 if user answered NO for the question "Do you wish to continue(Y/N)?" when search returned lot of values
 ;
LEXICD10(HBHCTXT,HBHCDATE,HBHCPAR) ; ICD-10 Search
 N HBHCLVTXT
 ;parameters check
 S HBHCDATE=+$G(HBHCDATE)
 I HBHCDATE'?7N Q -1
 S HBHCTXT=$G(HBHCTXT)
 Q:'$L(HBHCTXT) -1
 N HBHCNUMB
 S HBHCNUMB=$$FREQ^LEXU(HBHCTXT)
 I HBHCNUMB>$$MAX^LEXU(30) D  I $$QUESTION("N",HBHCPARAM("WISH CONTINUE"))'=1 Q -4
 . D FORMWRIT(HBHCPAR("EXCEEDS MESSAGE1")_HBHCTXT_HBHCPAR("EXCEEDS MESSAGE2")_HBHCNUMB_HBHCPAR("EXCEEDS MESSAGE3")_HBHCTXT_""".",0)
 . D FORMWRIT("",2)
 ;new and set variables
 N DIROUT,DUOUT,DTOUT,HBHCEXIT,HBHCICDNT
 N HBHCRETV,HBHCXX,HBHCLEVEL
 S HBHCRETV=""
 S HBHCEXIT=0
 S HBHCLEVEL=1,HBHCLVTXT(HBHCLEVEL)=HBHCTXT ;level 1 stores the original search string
 ; main loop
 F  Q:HBHCEXIT>0  D
 . K HBHCICDY
 . ;get the search string from the current level and call LEX API
 . S HBHCICDY=$$DIAGSRCH^LEX10CS(HBHCLVTXT(HBHCLEVEL),.HBHCICDY,HBHCDATE,30)
 . S:$O(HBHCICDY(" "),-1)>0 HBHCICDY=+HBHCICDY
 . ; Nothing found
 . I +HBHCICDY'>0 S HBHCEXIT=1 S HBHCXX=-1 Q
 . ; display the list of items and ask the user to select the item from the list
 . S HBHCXX=$$SEL^HBHCLKU2(.HBHCICDY,8)
 . ; if ^ was entered 
 . ;   if this is on the top level then quit 
 . I HBHCXX=-2,HBHCLEVEL'>1 S HBHCRETV=-3 S HBHCEXIT=1 Q
 . ;   if lower level then go one level up
 . I HBHCXX=-2,HBHCLEVEL>1 S HBHCLEVEL=HBHCLEVEL-1 Q
 . ; If timeout then quit
 . I HBHCXX=-3 S HBHCRETV=-2 S HBHCEXIT=1 Q
 . ; If not selected then quit
 . I HBHCXX=-1 S HBHCRETV=-1 S HBHCEXIT=1 Q
 . ; If ^^ then quit
 . I HBHCXX=-5 S HBHCRETV=-3 S HBHCEXIT=1 Q
 . ; if Code Found and Selected by the user save selection in HBHCRETV and quit
 . I $P(HBHCXX,";")'="99:CAT" S HBHCRETV=HBHCXX S HBHCEXIT=1 Q
 . ; If Category Found and Selected by the user:  
 . ;  go to the next inner level
 . ;  change level number 
 . S HBHCLEVEL=HBHCLEVEL+1
 . ;  set the new level with the new search string
 . ;  and repeat 
 . S HBHCLVTXT(HBHCLEVEL)=$P($P($G(HBHCXX),"^"),";",2)
 Q HBHCRETV
 ;
 ;---------
 ;ICD-9 lookup (FileMan lookup)
 ;Input parameters :
 ; HBHCSRCH - search string 
 ; HBHCICDT - date of interest  
 ;returns ICD-9 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; or 
 ; -1 if error like no selection made or search found nothing
 ; -2 if exit : ^ or ^^
 ; -3 if timed out
 ;Note: this API is not silent because the ICD lookup is not silent
FMICD9(HBHCSRCH,HBHCICDT) ;
 N KEY,X,Y,DIC,HBHCCDS
 ;KEY must be newed as ICD lookup code doesn't kill it
 S DIC="^ICD9(",DIC(0)="EQZ"
 ; Set screening of inactive codes!!
 S HBHCCDS="ICD9"
 S DIC("S")="I $$CSI^ICDEX(80,Y)=1"
 ; both X and Y should be set to the search string
 S (X,Y)=HBHCSRCH
 D ^DIC
 I $G(Y) D  Q Y
 . I $P(Y,U,1)<0 D
 . . S:$D(DUOUT) Y=-2  ;search aborted
 . . S:$D(DTOUT) Y=-3  ;timed out
 Q X
 ;
 ;---------
 ; Clean up environment and quit
CLEANUP ;
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,%Y,DIWL,DIWR
 Q
 ;
 ;---------
 ;ask YES/NO questions
 ;input parameters :
 ; HBHCDFLT- 0/null- not default, 1- yes, 2 -no
 ; HBHCPROM - prompt string
 ;returns 
 ; 2 - no,
 ; 1 -yes,
 ; 0 - no answer
QUESTION(HBHCDFLT,HBHCPROM) ;
 W:$L($G(HBHCPROM)) !,HBHCPROM
 S %=$G(HBHCDFLT,2)
 D YN^DICN
 Q:%Y["^" -3
 I %=2!(%=1) Q %
 Q -2
 ;
 ;---------
 ;get search string
 ;input parameters :
 ; HBHCPRMT prompt text
 ; HBHCHLP1 "?" help text
 ; HBHCHLP2 "??" help text
 ; HBHCDFLT- default response
 ;returns piece1 ^ piece 2
 ; piece1:
 ; 0 if normal input
 ; or -1 if invalid data
 ; or -2 if time out
 ; or -3 if ^
 ; or -4 if user accepts default value
 ; or -5 if user enters "@"
 ; piece2: string entered by the user
SRCHSTR(HBHCPRMT,HBHCHLP1,HBHCHLP2,HBHCDFLT) ;
 N DIR
 S DIR("A")=HBHCPRMT
 S DIR("?")=HBHCHLP1
 S DIR("??")=HBHCHLP2
 I $L($G(HBHCDFLT)) S DIR("B")=HBHCDFLT
 S DIR(0)="FAOr^0:245"
 D ^DIR
 Q:$D(DTOUT) -2
 Q:$D(DUOUT) -3
 Q:X="@" -5
 Q:Y["^" -3
 Q:Y="" -1
 Q:(($L($G(HBHCDFLT)))&(Y=HBHCDFLT)) -4  ;if user accepts default value then no need to validate it
 Q 0_U_Y
 ;
 ;---------
 ;set parameters
 ;edit these hardcoded strings that are used for prompts, messages and so on to adjust them to your application's needs
 ;input parameters 
 ; HBHCPAR  - local array to sets and store string constants for your messages and prompts 
 ; HBHCMODE - Admission or Discharge entry
 ; HBHCCS   - Search coding system
SETPARAM(HBHCPAR,HBHCMODE,HBHCCS) ;
 I HBHCMODE=1 S HBHCPAR("SEARCH_PROMPT")="PRIMARY DIAGNOSIS @ ADMISSION: " I 1
 E  I HBHCMODE=2 S HBHCPAR("SEARCH_PROMPT")="PRIMARY DIAGNOSIS @ DISCHARGE: " I 1
 E  S HBHCPAR("SEARCH_PROMPT")="Enter Diagnosis, a Code or a Code Fragment: "
 I HBHCCS=1 D  I 1
 . S HBHCPAR("HELP ?")="^D HLPICD9^HBHCLKU1"
 . S HBHCPAR("HELP ??")="^D HLPICD9^HBHCLKU1"
 E  I HBHCCS=30 D  I 1
 . S HBHCPAR("HELP ?")="^D HLPICD10^HBHCLKU1"
 . S HBHCPAR("HELP ??")="^D HLPICD10^HBHCLKU1"
 S HBHCPAR("WISH CONTINUE")="Do you wish to continue(Y/N)"
 S HBHCPAR("EXCEEDS MESSAGE1")="Searching for """
 S HBHCPAR("EXCEEDS MESSAGE2")=""" requires inspecting "
 S HBHCPAR("EXCEEDS MESSAGE3")=" records to determine if they match the search criteria.  This could take quite some time.  Suggest refining the search by further specifying """
 S HBHCPAR("DELETE?")="   SURE YOU WANT TO DELETE"
 S HBHCPAR("ENTER MORE")=" Please enter at least the first two characters of the ICD-10 code or code"
 S HBHCPAR("ENTER MORE2")=" description to start the search."
 Q
 ;
 ;---------
 ; Look-up help for ICD-10
HLPICD10 ;
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
 ;
 ;---------
 ; Look-up help for ICD-9
HLPICD9 ;
 N DIC,D,DIFORMAT,DZ
 I $G(X)["??" D  I 1
 . W "        This field represents patient's primary diagnosis at time of admission,"
 . W !,"        referencing ICD Diagnosis (80) file entries."
 . S DZ="??"
 E  D
 . W "     Answer with ICD diagnosis code, or diagnosis description, of patient's"
 . W !,"     primary diagnosis at time of admission."
 S D="B"
 S DIC="^ICD9(",DIC(0)="IMEQXZ"
 S DIC("S")="I $$CSI^ICDEX(80,Y)=1"
 D DQ^DICQ
 Q
 ;
 ;---------
 ;a wrapper for ^DIWP
 ;accumulates a text and then writes it to the device
 ;input parameters :
 ; X - text
 ; HBHCMODE:
 ;  0 - start
 ;  1 - accumulate 
 ;  2 - write
 ;example:
 ;D FORMWRIT^HBHCLKU1("this API is a wrapper for ^DIWP, it accumulates a text and then writes it to the device, you can use it in your application code",0)
 ;D FORMWRIT^HBHCLKU1("some more text ",1)
 ;D FORMWRIT^HBHCLKU1("",2)
FORMWRIT(X,HBHCMODE) ;
 N HBHCLI1
 ;if "start" mode
 I HBHCMODE=0 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=79
 I $L(X)>0 D ^DIWP
 ;if "write" mode
 I HBHCMODE=2 D
 . S HBHCLI1=0 F  S HBHCLI1=$O(^UTILITY($J,"W",1,HBHCLI1)) Q:+HBHCLI1=0  W !,$G(^UTILITY($J,"W",1,HBHCLI1,0))
 . K ^UTILITY($J,"W")
 Q
 ;
 ;---------
 ;Initialize variables if you need , your application most likely already has this
INITVARS ;
 D HOME^%ZIS
 S:$G(DT)=0 DT=$$DT^XLFDT
 Q
 ;
