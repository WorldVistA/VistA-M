RCDPEU1 ;AITC/CJE - ELECTRONIC PAYER UTILITIES ;05-NOV-02
 ;;4.5;Accounts Receivable;**326**;Mar 20, 1995;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
SELPAY(PARAM) ; EP
 ; New all purpose payer selection subroutine. Based off file 344.6
 ; Including options to include only given payer types (Medical/Pharmacy/Tricare/All)
 ; and to filter selection to include only payers that have entries in file 344.4 or 344.31
 ; This subroutine may be used to replace all previous payer seletion prompts. 
 ; Input - PARAM array of parameters passed by reference
 ;         PARAM("TYPE") - Types of payers to include in the selection (optional defaults to A)
 ;                          P - Pharmacy, T - Tricare, M - Medical (neither P nor T), A - All 
 ;         PARAM("FILE") - Only include payers that have entries on the ERA or EFT file (optional)
 ;                          344.4 -  ERA, 344.31 - EFT
 ;         PARAM("SRCH") - Search by payer name or TIN (optional defaults to N)
 ;                          N - Payer Name, T - TIN 
 ;         PARAM("SELC") - Seclect individual payers, or range of payers (optional defaults to S)
 ;                          S - Selected payers, R - Range of payers
 ;         PARAM("DICA") - Text that will be used to prompt the user (optional)
 ;                         defaults to "Select payer "_$S(PARAM("SRCH")="N":"name",1:"TIN")
 ;
 ; Output - ^TMP("RCDPEU1",$J,PAYERIEN)=""
 ;          ^TMP("RCDPEU1",$J,"N",NAME,PAYERIEN)=""
 ;          ^TMP("RCDPEU1",$J,"T",TIN,PAYERIEN)=""
 ;          Where:
 ;                 PAYERIEN = Internal entry number of the payer from file 344.6
 ;                 NAME     = Payer name, TIN = Payer TIN
 ;                 FLAG     = Pharmacy or Tricare or Medical flag based on Pharmacy and Tricare flags from file 344.6
 ;                            T - has tricare flag, P - has pharmacy flag, M - has neither T or P flag.
 ; 
 ; Returns - 1 - Success, -1 - Abort
 ;
 N RCA,RET,RETURN,QUIT
 ;
 D INIT
 S RETURN=1
 ;
 S QUIT=0
 I PARAM("SELC")="R" D  ;
 . S RCA="Select START range for payer names: "
 . F  S RET=$$PROMPT(.PARAM,RCA) Q:(RET'=0)  D RMESS
 . I RET=-1 S RETURN=-1 Q
 . S RCA="Select END range for payer names: "
 . F  S RET=$$PROMPT(.PARAM,RCA) Q:(RET'=0)  D RMESS
 . I RET=-1 S RETURN=-1 Q
 . D EXPAND
 ;
 I PARAM("SELC")="S" D  ;
 . S QUIT=0
 . F  D  Q:QUIT  ;
 . . S RET=$$PROMPT(.PARAM,PARAM("DICA"))
 . . I RET=-1 S RETURN=-1,QUIT=1 Q
 . . I RET=0 D  ;
 . . . I $D(^TMP("RCDPEU1",$J)) S QUIT=1
 . . . E  D RMESS
 ;
 I RETURN=-1 D CLEAN Q -1
 S RETURN=$S($D(^TMP("RCDPEU1",$J)):1,1:-1)
 Q RETURN
 ;
PROMPT(PARAM,RCA) ; Prompt for a payer from file 344.6 with various filter options
 ; Input: PARAM - array of parameters defined in subroutine SELPAY above
 ; Output: ^TMP("RCDPEU1",$J) as defined in subroutine SELPAY above
 ; Returns:  1 - Payer selected
 ;           0 - No payer selected
 ;          -1 - user typed '^' or timed out
 ;
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RETURN,X,Y
 S RETURN=1
 ;
 I PARAM("SRCH")="N" D  ; Select payers by name
 . S DIC=344.6
 . S DIC(0)="QEA"
 . S DIC("A")=RCA
 . S DIC("S")="I $$CHKPAY^RCDPEU1(Y,"""_PARAM("TYPE")_""","""_PARAM("FILE")_""")"
 . I PARAM("SELC")="R",$D(^TMP("RCDPEU1",$J)) D       ; Choosing second name of a range
 . . S DIC("S")=DIC("S")_",$$CHKRNG^RCDPEU1(Y)"  ; only offer payer names that follow start range 
 . D ^DIC
 . I $D(DTOUT)!$D(DUOUT) S RETURN=-1 Q
 . I Y=-1 S RETURN=0 Q
 . D ADDPAY(+Y)
 ;
 I PARAM("SRCH")="T" D  ; Select payers by TIN
 . N RET
 . S DIR("A")="Select Insurance Company TIN"
 . S DIR(0)="FO^1:30"
 . S DIR("?")="Enter the TIN of the payer or '??' to list payers"
 . S DIR("??")="^D TLIST^RCDPEU1"
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S RETURN=-1 Q
 . I Y="" S RETURN=0 Q
 . S RET=$$SRCHTIN(Y,.PARAM)
 . I RET=-1 S RETURN=-1 Q
 . I RET'="" D ADDTIN(RET)
 Q RETURN
 ;
EXPAND ; Expand range of payer names given start and end points.
 ; Input: Start and end points of the range in the global ^TMP("RCDPEU1",$J) documented in SELPAY above.
 ; Output: More enntries in ^TMP("RCDPEU1",$J), one for each matching payer in the range.
 N K1,NAME
 S NAME(1)=$O(^TMP("RCDPEU1",$J,"N",""))
 S NAME(2)=$O(^TMP("RCDPEU1",$J,"N",""),-1) ; Note if user picks same name as start and end range 1=2
 ;
 D EXPANDX(NAME(1))
 ;
 S K1=NAME(1)
 F  S K1=$O(^RCY(344.6,"B",K1)) Q:K1=""!(K1]NAME(2))  D EXPANDX(K1)
 Q
EXPANDX(NAME) ; Add all payers with the same name into the list
 ; Input: NAME - Payer Name
 ;        PARAM - Input parameters
 ; Output: ^TMP("RCDPEU1",$J)
 N PAYIEN
 S PAYIEN=""
 F  S PAYIEN=$O(^RCY(344.6,"B",NAME,PAYIEN)) Q:PAYIEN=""  D  ;
 . I $$CHKPAY(PAYIEN,PARAM("TYPE"),PARAM("FILE")) D ADDPAY(PAYIEN)
 Q
 ;
ADDPAY(PAYIEN) ; Add payer to the output array.
 ; Input - PAYIEN = Internal entry number from file #344.6
 ; Output - New entries in ^TMP("RCDPEU1",$J
 N NAME,TIN
 S ^TMP("RCDPEU1",$J,PAYIEN)=""
 S NAME=$$GET1^DIQ(344.6,PAYIEN_",",.01,"E")
 S TIN=$$GET1^DIQ(344.6,PAYIEN_",",.02,"E")
 S ^TMP("RCDPEU1",$J,"N",NAME,TIN,PAYIEN)=""
 S ^TMP("RCDPEU1",$J,"T",TIN,NAME,PAYIEN)=""
 Q
ADDTIN(TIN) ; Add all payers with TIN to the output array
 ; Input - Payer Identifer string (TIN) matching one or more entries in file #344.6 
 N PAYIEN
 S PAYIEN=""
 F  S PAYIEN=$O(^RCY(344.6,"C",TIN,PAYIEN)) Q:'PAYIEN  D  ;
 . D ADDPAY(PAYIEN)
 Q
SRCHTIN(RCX,PARAM) ; Given user input narrow down the TIN that the user wants
 ; Input: RCX - User input to use in TIN lookup.
 ;        PARAM - array of input parameters (see subroutine SELPAY for detailed description)
 N CNT,COUNT,DIR,DTOUT,DUOUT,K1,K2,K3,LIST,QUIT,RETURN,SPACE,SX,X,Y
 I $D(^RCY(344.6,"C",RCX_" ")) D CHKTIN(RCX_" ",.PARAM,.LIST)
 S K1=RCX_" "
 F  S K1=$O(^RCY(344.6,"C",K1)) Q:K1=""!($E(K1,1,$L(RCX))'=RCX)  D  ;
 . D CHKTIN(K1,.PARAM,.LIST)
 ;
 I '$D(LIST) D  Q 0
 . W !,"No matching TIN found",!
 ;
 S COUNT=0,K1=""
 F  S K1=$O(LIST("T",K1)) Q:K1=""  D  ; 
 . S COUNT=COUNT+1
 . S LIST(COUNT)=K1
 ; Show results and let user pick a TIN by sequence number or TIN
 S (COUNT,K1,K2,K3,RETURN)="",(CNT,QUIT,SX)=0
 F  S COUNT=$O(LIST(COUNT)) Q:'COUNT  D  I QUIT Q
 . S CNT=CNT+1
 . W !,$J(COUNT_".",4)_"  " S SPACE=0
 . S K1=LIST(COUNT)
 . F  S K2=$O(LIST("T",K1,K2)) Q:K2=""  D  I QUIT Q
 . . I SPACE W !,"      "
 . . W $E(K1_$J("",31),1,30)
 . . W $E(K2,1,42)
 . . I 'SPACE S SPACE=1
 S DIR(0)="NO^1:"_CNT_":0"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 I Y S RETURN=LIST(Y)
 Q RETURN
 ;
CHKPAY(PAYIEN,TYPE,FILE) ; Check if payer meets the filter requirements
 ; Input:  PAYIEN - Internal entry number of the payer from file 344.6
 ;         TYPE   - M - Medical, P - Pharmacy, T- Tricare, A - All
 ;         FILE   - 344.4 - ERA, 344.31 EFT - Payer must have entries in the given file
 ; Return: 1 - Payer matches the filter criteria, otherwise 0.
 ;
 N NAME,FLAG,RETURN,TIN
 I TYPE="A",FILE="" Q 1
 ;
 S RETURN=1
 I TYPE'="A" D  I 'RETURN Q 0
 . S RETURN=$$CHKTYPE(PAYIEN,TYPE)
 ;
 I FILE D  I 'RETURN Q 0
 . S NAME=$$GET1^DIQ(344.6,PAYIEN_",",.01,"I")
 . S TIN=$$GET1^DIQ(344.6,PAYIEN_",",.02,"I")
 . I '$D(^RCY(FILE,"APT",NAME,TIN)) S RETURN=0
 Q 1
CHKRNG(PAYIEN) ; Check if second picked payer name follows the first
 ; Input: PAYIEN = Internal entry number of payer from file #344.6
 ;        ^TMP("RCDPEU1",$J global array contains previously picked payer
 ; Return: 1 - if PAYIEN's name follows that of payer in ^TMP, otherwise 0
 ;
 N NAME,RETURN
 S RETURN=0
 S NAME(1)=$O(^TMP("RCDPEU1",$J,"N",""))
 S NAME(2)=$$GET1^DIQ(344.6,PAYIEN_",",.01,"E")
 I NAME(2)]NAME(1)!(NAME(2)=NAME(1)) S RETURN=1
 Q RETURN
 ;
CHKTIN(TIN,PARAM,OUT) ; Given a TIN check filter criteria and add passing entries to the OUT array
 ; Input: TIN = Payer Identifier string that matches one or more payers in file #344.6
 ;        PARAM = Input parameter array. See subroutine SELPAY for detailed documentation
 ; Output: OUT (passed by reference) array of payers matching filter parameters. Sorted by TIN then NAME
 N PAYIEN
 S PAYIEN=""
 F  S PAYIEN=$O(^RCY(344.6,"C",TIN,PAYIEN)) Q:PAYIEN=""  D  ;
 . I $$CHKPAY(PAYIEN,PARAM("TYPE"),PARAM("FILE")) D  ;
 . . N PNAME
 . . S PNAME=$$GET1^DIQ(344.6,PAYIEN_",",.01,"E")
 . . I PNAME="" Q
 . . S OUT("T",TIN,PNAME,PAYIEN)=""
 Q
TLIST ; List TINS for user help.  Only TINS matching filter criteria are displayed.
 N COUNT,PAYIEN,QUIT,TIN
 S (QUIT,COUNT)=0
 S TIN=""
 F  S TIN=$O(^RCY(344.6,"C",TIN)) Q:TIN=""  D  I QUIT Q
 . S PAYIEN=""
 . F  S PAYIEN=$O(^RCY(344.6,"C",TIN,PAYIEN)) Q:PAYIEN=""  D  I QUIT Q
 . . I '$$CHKPAY(PAYIEN,$G(PARAM("TYPE"),"A"),$G(PARAM("FILE"))) Q
 . . S COUNT=COUNT+1
 . . I COUNT>21 S COUNT=1 I '$$GOON^VALM1() S QUIT=1 Q
 . . W !,$E(TIN_$J("",30),1,30)_" "_$E($$GET1^DIQ(344.6,PAYIEN_",",.01,"E"),1,39)
 Q
INIT ; Initialize parameters and return array
 ; Input - PARAM array see comments for SELPAY above
 ;
 S PARAM("TYPE")=$G(PARAM("TYPE"),"A")
 S PARAM("FILE")=$G(PARAM("FILE"))
 S PARAM("SRCH")=$G(PARAM("SRCH"),"N")
 S PARAM("SELC")=$G(PARAM("SELC"),"S")
 S PARAM("DICA")=$G(PARAM("DICA"),"Select payer "_$S(PARAM("SRCH")="N":"name",1:"TIN")_": ")
 ;
 K ^TMP("RCDPEU1",$J)
 Q
CLEAN ; Clean up output array if user aborts
 K ^TMP("RCDPEU1",$J)
 Q
RTYPE(DEF) ;EP
 ; Input:   DEF     - Value to use a default
 ; Returns: -1      - User ^ or timed out
 ;           A      - User selected ALL
 ;           M      - User selected MEDICAL
 ;           P      - User selected PHARMACY
 ;           B      - User selected BOTH
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT,RCTYPE,RETURN
 S RCTYPE=""
 S DIR("?")="Enter the type of payer to include"
 S DIR(0)="SA^M:MEDICAL;P:PHARMACY;T:TRICARE;A:ALL"
 S DIR("A")="(M)EDICAL, (P)HARMACY, (T)RICARE or (A)LL: "
 S DIR("B")=$S($G(DEF)'="":DEF,1:"ALL")
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 Q:Y="" "A"
 S RETURN=$E(Y)
 ; If Pharmacy or Tricare chosen, check if payer exist and if not give warning
 I (RETURN="P"&('$D(^RCY(344.6,"ARX",1)))) D WARN("pharmacy")
 I (RETURN="T"&('$D(^RCY(344.6,"ATR",1)))) D WARN("tricare")
 Q RETURN
 ;
PAYTYPE(NAME,TIN,TYPE) ; EP
 ; Is a payer Medical, Pharmacy or Tricare based on flags in the payer exclusion file.
 ; Inputs: NAME - The free text name of the payer
 ;         TIN  - The ID if the payer
 ;         TYPE - M : Medical, P : Pharmacy, T: Tricare
 ; Returns : 1 - Yes, payer matches type, 0 - No, payer does not match type
 N IEN,FLAG
 S IEN=$$GETPAY(NAME,TIN)
 I 'IEN Q 0
 Q $$CHKTYPE(IEN,TYPE)
 ;
GETPAY(NAME,TIN) ; EP - Get payer IEN given name and TIN
 ; Inputs: NAME - The free text name of the payer
 ;         TIN  - The ID if the payer
 ; Returns: Internal entry number from file 344.6
 I NAME=""!(TIN)="" Q 0
 Q +$O(^RCY(344.6,"CPID",NAME,TIN,""))
 ;
CHKTYPE(IEN,TYPE) ; EP
 ; Inputs: IEN - Internal entry number from file 344.6
 ;         TYPE - M : Medical, P : Pharmacy, T: Tricare, A: All
 ; Returns: 1 if the payer matches the type, otherwise 0
 I TYPE="A" Q 1
 S FLAG("P")=+$$GET1^DIQ(344.6,IEN_",",.09,"I")
 S FLAG("T")=+$$GET1^DIQ(344.6,IEN_",",.1,"I")
 ;
 I TYPE="T",FLAG("T") Q 1
 I TYPE="P",FLAG("P") Q 1
 I TYPE="M",'FLAG("P"),'FLAG("T") Q 1
 Q 0
ISTYPE(FILE,IEN,TYPE) ; EP
 ; Check if payer is a given type based on IEN from a FILE
 ; Input: FILE - file from which to get Payer name and TIN
 ;               allowed values 344.4 - ERA, 344.31 - EFT, 361.1 - EOB
 ;        IEN  - Internal entry number of entry in FILE
 ;        TYPE - M : Medical, P : Pharmacy, T: Tricare
 ; Return 1 - payer matches type, else 0.
 I TYPE="A" Q 1
 N IEN3444,NAME,TIN
 ; For EOB try to get Payer from associated ERA, if none exists use TIN only to check the type.
 I FILE=361.1 D  I FILE=361.1 Q $$EOBTYP(IEN,TYPE)  ;
 . S IEN3444=$$EOBERA(IEN)
 . I IEN3444 S FILE=344.4,IEN=IEN3444
 ;
 S NAME=$$GETNAME(FILE,IEN)
 S TIN=$$GETTIN(FILE,IEN)
 I NAME=""!(TIN="") Q 0
 Q $$PAYTYPE(NAME,TIN,TYPE)
 ;
ISSEL(FILE,IEN,RCJOB) ; EP
 ; Check if payer was selected by the user give the file and IEN
 ; Input: FILE - file from which to get Payer name and TIN
 ;               allowed values 344.4 - ERA, 344.31 - EFT, 361.1 - EOB
 ;        IEN  - Internal entry number of entry in FILE
 ; Return 1 - payer was selected, else 0.
 ;
 N IEN3444,NAME,RETURN,TIN
 S RETURN=0
 S RCJOB=$G(RCJOB,$J)
 I FILE=361.1 D  I FILE=361.1 Q RETURN
 . S IEN3444=$$EOBERA(IEN)
 . I IEN3444 D  ;
 . . S FILE=344.4,IEN=IEN3444
 . E  D  ;
 . . S TIN=$$GET1^DIQ(361.1,IEN_",",.03,"E")
 . . I $D(^TMP("RCDPEU1",RCJOB,"T",TIN))
 ;
 S NAME=$$GETNAME(FILE,IEN)
 S TIN=$$GETTIN(FILE,IEN)
 I NAME=""!(TIN="") Q 0
 I $D(^TMP("RCDPEU1",RCJOB,"N",NAME,TIN)) S RETURN=1
 Q RETURN
 ;
GETNAME(FILE,IEN) ; Get Payer Name give file and IEN
 N FIELD
 S FIELD=$S(FILE=344.4:.06,1:.02)
 Q $$GET1^DIQ(FILE,IEN_",",FIELD,"E")
 ;
GETTIN(FILE,IEN) ; Get Payer TIN give file and IEN
 N FIELD
 S FIELD=.03
 Q $$GET1^DIQ(FILE,IEN_",",FIELD,"E")
 ;
PAYRNG(MIXED,BLANKLN,NMORTIN) ; How does the user want to select payers?
 ; Input:   MIXED   - 1 to display prompts in mixed case
 ;                    Optional, defaults to 0
 ;          BLANKLN - 0 skip initial blank line
 ;                    Optional, defaults to 1
 ;          NMORTIN - 1 to look-up Payer by Payer Name, 2 to look-up by TIN
 ;                    0 or undefined - pre-326 behavior, look-up by payer name and don't include TIN in output array.
 ;                    Optional, defaults to 0
 ; Output:  ^TMP("RCSELPAY",$J) - Array of selected Payers
 ; Returns: A - All, S - Selected, R - Range, (-1) - User '^' or timeout
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RTNFLG,TIN,X,XX,Y
 S:'$D(MIXED) MIXED=0
 S:'$D(BLANKLN) BLANKLN=1
 S:'$D(NMORTIN) NMORTIN=0
 ;
 S RTNFLG=0
 ;
 ; Select option required (All, Selected or Range)
 I NMORTIN=2 D
 . S DIR(0)="SA^A:ALL;S:SPECIFIC"
 . S:MIXED DIR("A")="Run Report for (A)LL or (S)PECIFIC Insurance Companies?: "
 . S:'MIXED DIR("A")="RUN REPORT FOR (A)LL OR (S)PECIFIC INSURANCE COMPANIES?: "
 E  D
 . S DIR(0)="SA^A:ALL;S:SPECIFIC;R:RANGE"
 . S:MIXED DIR("A")="Run Report for (A)LL, (S)PECIFIC, or (R)ANGE of Insurance Companies?: "
 . S:'MIXED DIR("A")="RUN REPORT FOR (A)LL, (S)PECIFIC, OR (R)ANGE OF INSURANCE COMPANIES?: "
 . S DIR("?",2)="Enter 'RANGE' to select an Insurance Company range."
 S DIR("B")="ALL"
 S DIR("?",1)="Enter 'ALL' to select all Insurance Companies."
 S DIR("?")="Enter 'SPECIFIC' to select specific Insurance Companies."
 W:BLANKLN !         ; PRCA*4.5*318 - Added condition for BLANKLN
 D ^DIR K DIR
 ;
 ; Abort on ^ exit or timeout
 I $D(DTOUT)!$D(DUOUT) S RTNFLG=-1 Q RTNFLG
 ;
 Q Y
EOBERA(IEN3611) ; Get ERA that corresponds to an EOB so we can find payers.
 ; Input IEN3611 - Internal entry from file 361.1 EOB
 ; Returns - Internal entry number from file 344.4 ERA
 ;           use reverse $Order to get the latest ERA in case there is more than one.
 Q $O(^RCY(344.4,"ADET",+IEN3611,"A"),-1)
 ;
EOBTYP(IEN3611,TYPE) ; If EOB has no ERA, use TIN from EOB to determine M/P/T type
 ; Input IEN3611 - Internal entry from file 361.1 EOB
 ;       TYPE - M : Medical, P : Pharmacy, T: Tricare
 ; Returns - 1 at least one payer with TIN is of type TYPE
 N IEN,TIN
 S RETURN=0
 S TIN=$$GET1^DIQ(361.1,IEN3611_",",.03,"E")
 I TIN'="" D  ;
 . S IEN=""
 . F  S IEN=$O(^RCY(344.6,"C",TIN_" ",IEN)) Q:'IEN  D  Q:RETURN=1
 . . S RETURN=$$CHKTYPE(IEN,TYPE)
 Q RETURN
 ;
RMESS ; Output message that entry is required.
 W !!,"You must select "
 W $S(PARAM("SELC")="R":"a",1:"at least one")_" "
 W $S(PARAM("SRCH")="N":"payer",1:"TIN"),*7,!
 Q
 ;
WARN(TYPE) ; Warn user that no payers of TYPE have been flagged
 ; Input: TYPE - P=Pharmacy, T="Tricare"
 ; Output: warning message to screen.
 W !!,"WARNING - There are no "_TYPE_" payers flagged in the system."
 W !,"          Please use the Identify Payers option to flag payers.",*7
 Q
