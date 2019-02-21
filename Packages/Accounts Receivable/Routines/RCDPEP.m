RCDPEP ;AITC/CJE - FLAG PAYERS AS PHARMACY/TRICARE ; 19-APR-2017
 ;;4.5;Accounts Receivable;**321,326**;;Build 26
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN(FILTER,DATEFILT) ; -- main entry point for RCDPE PAYER FLAGS template
 ; Input: FILTER - A=All payers, P=Pharmacy payers, T=Tricare payers,
 ; M=Medical (Neither Pharmacy nor Tricare)
 ; DATEFILT - Additional Filter by Date. Has 3 pieces by '^'
 ;            Piece 1 - 1=Filter by date, 0=Don't
 ;            Piece 2 - START - First DATE ADDED to include(FM format)
 ;            Piece 3 - END - Last DATE ADDED to include (FM format)
 ; 
 I '$D(DATEFILT) S DATEFILT=$$GETDATE()
 I DATEFILT=-1 Q  ;
 I '$D(FILTER) S FILTER=$$GETFILT()
 I FILTER=-1 Q  ;
 ;
 D EN^VALM("RCDPE PAYER FLAGS")
 Q
 ;
GETDATE() ; Ask if the user wants to filter by date. If so prompt for start
          ; and end dates.
 ; Input: None
 ; Output: Return value=date filter parameters delimiter by '^'
 ;         Piece 1 - 1=Filter by date, 0=Don't
 ;         Piece 2 - START - First DATE ADDED to include(FM format)
 ;         Piece 3 - END - Last DATE ADDED to include (FM format)
 ; 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FD1,FD2,FILTER,OLDDATE,OD1,OD2,RETURN,X,XX,Y
 D FULL^VALM1
 S VALMBCK="R"
 S RETURN="0"
 ;
 S XX=$P($P($G(XQORNOD(0)),"^",4),"=",2) ; User selection with action
 S FD1=$P(XX,";",2),FD2=$P(XX,";",3)
 ; See if user selection is valid (must be T + or - N days)
 S FD1=$$PARSED(FD1)
 S FD2=$$PARSED(FD2)
 I FD1,FD2 Q 1_"^"_FD1_"^"_FD2
 ;
 S OLDDATE=$G(DATEFILT,0)
 S OD1=$P(OLDDATE,"^",2),OD2=$P(OLDDATE,"^",3)
 ;
 S DIR(0)="YA"
 S DIR("A")="Filter by Date Added? "
 S DIR("B")=$S(OLDDATE:"YES",1:"NO")
 S DIR("?",1)="Enter 'Y' or 'Yes' to filter the list by DATE ADDED"
 S DIR("?")="Enter 'N' or 'No' if you do not wish to filter the list by date"
 D ^DIR
 I $D(DIRUT) Q -1
 I Y=0 Q 0
 S RETURN=1
 ;
 ; Prompt for start and end date
 K DIR
 S DIR(0)="DA^"
 S DIR("A")="Filter start date: "
 ; set default to existing filter start date if it is set.
 I OD1'="" S DIR("B")=$$FMTE^XLFDT(OD1,"2DZ")
 D ^DIR
 I $D(DIRUT) Q -1
 S (FD1,$P(RETURN,"^",2))=Y
 ;
 K DIR
 S DIR(0)="DA^"_FD1_":"_DT
 S DIR("A")="Filter end date ("
 S DIR("A")=DIR("A")_$$FMTE^XLFDT(FD1,"2DZ")_"-"
 S DIR("A")=DIR("A")_$$FMTE^XLFDT(DT,"2DZ")_"): "
 ; Set default to existing filter end date if it is valid.
 ; (it must follow the selected start date). Otherwise default to today.
 I OD2'="",OD2'<FD1 S DIR("B")=$$FMTE^XLFDT(OD2,"2DZ")
 I '$D(DIR("B")) S DIR("B")="T"
 D ^DIR
 I $D(DIRUT) Q -1
 S (FD2,$P(RETURN,"^",3))=Y
 ;
 Q RETURN
 ;
GETFILT() ; Get filter on payer type
 ; Input: None
 ; Return: Filter type.
 ;         A=All payers, P=Pharmacy payers, T=Tricare payers,
 ;         M=Medical (Neither Pharmacy nor Tricare)
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILTER,X,XX,Y
 ; Check for value specified on protocol
 S XX=$P($P($G(XQORNOD(0)),"^",4),"=",2) ; User selection with action
 S XX=$E(XX)
 I XX'="","APTM"[XX Q XX
 ;
 S DIR(0)="SA^A:All;P:Pharmacy only;T:Tricare only;M:Medical"
 S DIR("A")="Select payers to show. (A)ll, (P)harmacy, (T)ricare, (M)edical: "
 S DIR("B")="A"
 S DIR("?",1)="Select the type of filter to determine what payers will"
 S DIR("?",2)="be displayed as follows:"
 S DIR("?",3)=" A - All payers including those with and without a flag"
 S DIR("?",4)=" P - Only payers flagged for Pharmacy"
 S DIR("?",5)=" T - Only payers flagged for Tricare"
 S DIR("?")=" M - Payers NOT flagged for Pharmacy or Tricare"
 ; S DIR("??")="RCDPE PAYER FLAGS FILTER"
 ;
 D ^DIR
 I $D(DIRUT) Q -1
 Q Y
 ;
HDR ; EP - header code for RCDPE PAYER FLAGS template
 ; Input: Variables FILTER and DATEFILT are assumed to exist
 ; Output: ListMan template header in VALMHDR array
 ;
 ; Show active filters in the template header
 N FTEXT
 S FTEXT=$S(FILTER="P":"Pharmacy",FILTER="T":"Tricare",FILTER="M":"Medical",1:"All")
 S FTEXT=$$UP^XLFSTR(FTEXT)
 S FTEXT=FTEXT_" Payers"
 I DATEFILT D  ;
 . S FTEXT=FTEXT_" added between "
 . S FTEXT=FTEXT_$$FMTE^XLFDT($P(DATEFILT,"^",2),"2DZ")
 . S FTEXT=FTEXT_" and "_$$FMTE^XLFDT($P(DATEFILT,"^",3),"2DZ")
 S VALMHDR(1)="Current Filter: "_FTEXT
 Q
 ;
INIT ; EP - init variables and list array for RCDPE PAYER FLAGS template
 ; Input: Variables FILTER and DATEFILT are assumed to exist
 ; Output: ^TMP("RCDPEP",$J) - Body lines to display for selected template
 ;                             ^TMP($J,"RCDPEPIX") - Index of displayed payers
 S SORT="B"
 I $G(FILTER)="" S FILTER="A"
 I $G(DATEFILT)="" S DATEFILT=0
 K ^TMP("RCDPEP",$J),^TMP($J,"RCDPEPIX")
 D BLD(SORT,FILTER,DATEFILT)
 Q  ;
 ;
BLD(SORT,FILTER,DATEFILT) ; - Build the listman body template
 ; Input: SORT=Index on 344.6 to use for display order
 ; FILTER=Filter based on FLAG (see EN subroutine for detail)
 ; DATEFILT=Filter based on date added.
 N CNT,LINE,LN,XX
 D GETPAY(FILTER,DATEFILT) ; get the list of payers sorted and filtered.
 S VALMBG=1,VALMCNT=0,LINE="",CNT=""
 ;
 F  D  Q:CNT=""  ;
 . S CNT=$O(^TMP($J,"RCDPEPIX",CNT))
 . Q:CNT=""  ;
 . S VALMCNT=VALMCNT+1
 . D BLD1PAY(CNT)
 Q
 ;
BLD1PAY(PAYCNT) ; (Re)build one payor line into the listman array
 ; Input PAYCNT - The sequence number of the payer being built
 ; Output - Lines set into template array (^TMP("RCDPEP",$J)).
 N DATALN,LINE,XX
 S LINE=$$SETSTR^VALM1(" "_PAYCNT,"",1,4)
 S DATALN=^TMP($J,"RCDPEPIX",PAYCNT)
 S XX=$P(DATALN,"^",2) ; Name
 S XX=$E(XX,1,55) ; Truncate name to 55 characters to fit
 S LINE=$$SETSTR^VALM1(XX,LINE,6,55)
 S XX=$P(DATALN,"^",3) ; Payer ID
 S LINE=$$SETSTR^VALM1(XX,LINE,63,10)
 S XX=$P(DATALN,"^",5) ; Phamacy payer flag
 S LINE=$$SETSTR^VALM1(XX,LINE,75,2)
 S XX=$P(DATALN,"^",6) ; Tricare payer flag
 S LINE=$$SETSTR^VALM1(XX,LINE,79,2)
 S XX=$P(DATALN,"^",4) ; Date added
 S LINE=$$SETSTR^VALM1(XX,LINE,82,10)
 D SET^VALM10(PAYCNT,LINE,PAYCNT)
 S XX=$P(DATALN,"^",7) ; EFT only payer
 S LINE=$$SETSTR^VALM1(XX,LINE,93,3)
 D SET^VALM10(PAYCNT,LINE,PAYCNT)
 Q
 ;
GETPAY(FILTER,DATEFILT) ; Retrieve the payors sorted and filtered
 ; Input: FILTER=Type of filter by Pharmacy or Tricare flag
 ; DATEFILT=Filter by date added
 ; Output: ^TMP($J,"RCDPEPIX")=PIEN^NAME^PHARMACY_FLAG^TRICARE_FLAG
 N CNT,NAME,PIEN
 S CNT=0,NAME=""
 I $G(SORT)="" S SORT="B"
 S FILTER=$G(FILTER)
 F  D  Q:NAME=""  ;
 . S NAME=$O(^RCY(344.6,SORT,NAME))
 . Q:NAME=""
 . S PIEN=""
 . F  S PIEN=$O(^RCY(344.6,SORT,NAME,PIEN)) Q:PIEN=""  D  ; PRCA*4.5*326
 . . I '$$CHKPAY(PIEN,FILTER,DATEFILT) Q  ;
 . . S CNT=CNT+1 D GET1PAY(PIEN,CNT)
 Q  ;
 ;
GET1PAY(PIEN,CNT) ; Get the data for one payer and add it to the list
 ; Input: PIEN - Internal entry number to file 344.6
 ; CNT - Incremental counter
 ; Output: ^TMP($J,"RCDPEPIX",CNT)=A1^A2^A3^A4^A5^A6
 ; Where A1=PIEN - The payer internal entry number on file 344.6
 ;       A2=NAME - The payer name
 ;       A3=PAYER ID (also known as TIN)
 ;       A4=DATE ADDED
 ;       A5=PHARMACY PAYER - A Yes/No/Null field to flag a payer as pharmacy
 ;       A6=TRICARE PAYER - A Yes/No/Null filed to flag a payer as tricare
 ;
 N DATAOUT,DATEA,OUTARR,RCID,RCNAME,RCPF,RCTF
 D GETS^DIQ(344.6,PIEN_",",".01;.02;.03;.09;.1","EI","OUTARR")
 S RCNAME=OUTARR(344.6,PIEN_",",.01,"E")
 S RCID=OUTARR(344.6,PIEN_",",.02,"E")
 S DATAOUT=PIEN
 S DATAOUT=DATAOUT_"^"_RCNAME ; Name
 S DATAOUT=DATAOUT_"^"_RCID ; Payer ID
 S DATEA=OUTARR(344.6,PIEN_",",.03,"I") ; Date added
 S DATEA=$$FMTE^XLFDT(DATEA,"2DZ") ; Format as MM/DD/YY
 S DATAOUT=DATAOUT_"^"_DATEA
 S RCPF=$S(OUTARR(344.6,PIEN_",",.09,"I"):"Y",1:"")
 S DATAOUT=DATAOUT_"^"_RCPF ; Pharmacy payer flag
 S RCTF=$S(OUTARR(344.6,PIEN_",",.1,"I"):"Y",1:"")
 S DATAOUT=DATAOUT_"^"_RCTF ; Tricare payer flag
 S DATAOUT=DATAOUT_"^"_$S('$D(^RCY(344.4,"APT",RCNAME,RCID)):"YES",1:"") ; EFT ONLY PAYER/TIN 
 S ^TMP($J,"RCDPEPIX",CNT)=DATAOUT
 Q
 ;
CHKPAY(PIEN,FILTER,DATEFILT) ; Apply selected filters to a payer
 ; Input: PIEN - Internal entry number to file 344.6
 ; FILTER - A=All payers, P=Pharmacy payers, T=Tricare payers,
 ;          M=Medical (Neither Pharmacy nor Tricare)
 ; DATEFILT - Additional Filter by Date. Has 3 pieces by '^'
 ;            Piece 1 - 1=Filter by date, 0=Don't
 ;            Piece 2 - START - First DATE ADDED to include(FM format)
 ;            Piece 3 - END - Last DATE ADDED to include (FM format)
 ; Returns: 1 if record matches filter, otherwise 0.
 N D1,D2,DC,CREATED,MATCHT,MATCHD,PFLAG,TFLAG
 S (MATCHT,MATCHD)=0
 I FILTER="A" D  ;
 . S MATCHT=1
 E  D  ;
 . S PFLAG=$$GET1^DIQ(344.6,PIEN_",",.09,"I")
 . S TFLAG=$$GET1^DIQ(344.6,PIEN_",",.1,"I")
 . I FILTER="P",PFLAG S MATCHT=1
 . I FILTER="T",TFLAG S MATCHT=1
 . I FILTER="M",'PFLAG,'TFLAG S MATCHT=1
 ;
 I 'DATEFILT D  ;
 . S MATCHD=1
 E  D  ;
 . S D1=$P(DATEFILT,"^",2)
 . S D2=$P(DATEFILT,"^",3)
 . S DC=$$GET1^DIQ(344.6,PIEN_",",.03,"I")
 . S DC=$P(DC,".",1) ; strip off the time portion for comparison
 . I DC=D1!(DC=D2)!(DC>D1&(DC<D2)) S MATCHD=1
 ; 
 Q MATCHT&MATCHD
 ;
CHKKEY() ; Check security key for editing
 ; Inputs: None
 ; Returns: 1 - User has security key editing, 0 - User does not have key
 ;
 Q 1 ; Always return 1 since security key is no longer required.
 N RET
 D OWNSKEY^XUSRB(.RET,"RCDPE PAYER IDENTIFY")
 I 'RET(0) D  ;
 . W !!,*7,">>>> Security key RCDPE PAYER IDENTIFY is required for this action"
 . D PAUSE^VALM1
 Q RET(0)
 ;
EDIT ; EP - for RCDPE PAYER FLAGS EDIT protocol
 ; Input: None
 ; Output: File 344.6 is updated
 ;         Listman array is updated
 ;
 N DA,DIC,DIE,DO,DR,DTOUT,EDT,LINE,PCNT,PIEN,PROMPT,RET,SEL,X,XX,Y
 S VALMBCK="R"
 D FULL^VALM1
 ; Check security key for edit access
 I '$$CHKKEY() Q  ;
 ;
 S PROMPT="Select a Payer Entry to edit: "
 S PIEN=$$SELENT(1,PROMPT,VALMBG,VALMLST,.SEL,"RCDPEPIX",0)
 Q:'PIEN
 ;
 ; Lock Editing of this payer entry
 L +^RCY(344.6,PIEN):3 I '$T D  Q
  . W !!,*7,"Someone else is editing this Payer Entry."
  . W !,"Try again later."
  . D PAUSE^VALM1
 ;
 ; Let the user edit the payer entry
 S DIE="^RCY(344.6,"
 W !!,"Edit flags for payer : "_$$GET1^DIQ(344.6,PIEN_",",.01,"E"),!
 S DA=PIEN
 S DR=".09Pharmacy Flag;.1Tricare Flag"
 D ^DIE
 ;
 L -^RCY(344.6,PIEN)
 D GET1PAY(PIEN,+SEL)
 D BLD1PAY(+SEL)
 Q
 ;
SELENT(FULL,PROMPT,START,END,PCNT,WLIST,MULT) ; EP - Protocol Action
 ; Select Entry(s) to perform an action upon
 ; Called from protocols : RCDPE PAYER FLAGS EDIT
 ; RCDPE PAYER FLAG PHARM
 ; RCDPE PAYER FLAG TRIC
 ; Input: FULL - 1 - full screen mode, 0 otherwise
 ;        PROMPT - Prompt to be displayed to the user
 ;        START - Starting selection value
 ;        END - Ending selection value
 ;        WLIST - Worklist, the user is selecting from
 ;                Optional, defaults to 'RCDPEPIX'
 ;        MULT - 1 to allow multiple selection,
 ;               0 or null otherwise
 ;               Optional defaults to 0
 ; Output: PCNT - Selected Phone Book Entry line(s)
 ; Returns: Selected Payer Entry IEN(s)
 ;          Error message if invalid selection
 N CTR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,PIEN,PIENS,X,XX,Y,YY
 S:'$D(WLIST) WLIST="RCDPEPIX"
 S:'$D(MULT) MULT=0
 D:FULL FULL^VALM1
 ; Check for multi-selection
 S PCNT=$$PARSEL($G(XQORNOD(0)),START,END)
 ;
 ; W !!!,"PCNT="_PCNT_" MULT="_MULT H 10
 I 'MULT,$P(PCNT,",",2) D  Q ""                      ; Invalid multi-selection
 . W !,*7,">>>> Only single entry selection is allowed"
 . K DIR
 . D PAUSE^VALM1
 S:PCNT="" PCNT=$$SELENTRY(PROMPT,START,END,MULT)
 Q:'PCNT ""
 ;
 S PIENS=""
 F CTR=1:1:$L(PCNT,",") D
 . S XX=$P(PCNT,",",CTR)
 . I XX'="" D  ;
 . . S YY=$P(^TMP($J,WLIST,XX),"^",1)
 . . S PIENS=$S(PIENS="":YY,1:PIENS_","_YY)
 Q PIENS
 ;
SELENTRY(PROMPT,START,END,MULT) ; Select a line 
 ; Input: PROMPT - Prompt to be displayed to the user
 ; START - Start comment # that can be selected
 ; END - Ending comment # that can be selected
 ; MULT - 1=Multiple selection allowed, 0=otherwise
 ; Returns: Selected Comment # or "" if not selected
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S MULT=+$G(MULT)
 S DIR(0)=$S(MULT:"L",1:"N")_"O^"_START_":"_END_":0"
 S DIR("A")=PROMPT
 D ^DIR K DIR
 Q Y
 ;
FLAGP ; EP - for RCDPE PAYER FLAG PHARM protocol
 ; Toggle pharmacy flag on selected lines
 ; Input: None
 ; Output: None 
 D FLAG("P")
 Q
 ;
FLAGT ; EP - for RCDPE PAYER FLAG TRIC protocol
 ; Toggle Tricare flag on selected lines
 ; Input: None
 ; Output: None 
 D FLAG("T")
 Q
 ;
FLAG(TYPE) ; Flag a list of entries as Pharmacy or Tricare
 ; Input: TYPE - P=Pharmacy, T=Tricare
 ; Output: File 344.6 is updated
 ; ListMan array is updated
 N CONTINUE,CTR,FIELD,PERR,PIEN,PIENS,PROMPT,SELS,STOP,XX,ZS,ZZ
 S FIELD=$S(TYPE="P":.09,1:.1)
 S VALMBCK="R"
 ; Check security key for edit access
 I '$$CHKKEY() Q  ;
 ;
 S PROMPT="Select lines on which to toggle "
 S PROMPT=PROMPT_$S(TYPE="P":"Pharmacy",1:"Tricare")_" Flag"
 S PIENS=$$SELENT(1,PROMPT,VALMBG,VALMLST,.SELS,"RCDPEPIX",1)
 Q:PIENS=""  ;
 S (PERR,PIEN,ZZ,ZS)=""
 ;
 ; First lock all entries to be deleted
 F CTR=1:1:$L(PIENS,",") D
 . S PIEN=$P(PIENS,",",CTR) I PIEN="" Q  ;
 . S XX=$P(SELS,",",CTR)
 . ;
 . ; Lock this payer exclusion for editing 
 . L +^RCY(344.6,PIEN):3 I '$T D  Q
 . . S PERR=$S(PERR="":XX,1:PERR_","_XX)
 . S ZZ=$S(ZZ="":PIEN,1:ZZ_","_PIEN)
 . S ZS=$S(ZS="":XX,1:ZS_","_XX)
 S PIENS=ZZ                                ; Entry(s) that can be deleted
 S SELS=ZS
 ;
 ; Did we lock at least one entry?
 I PIENS="" D  Q
 . W !!,*7,"All entries are being edited by another user - Nothing done."
 . D PAUSE^VALM1
 ;
 ; Next warn the user if we couldn't lock them all
 I PERR'="" D  Q:STOP
 . S STOP=0
 . W !!,*7,"Warning: The following entries: ",PERR," are being edited by another user"
 . W !,"These entries will not be updated."
 . S CONTINUE=$$ASKYN("Continue with update of other payers?")
 . I 'CONTINUE D
 . . S STOP=1
 . . F CTR=1:1:$L(PIENS,",") D
 . . . S PIEN=$P(PIENS,",",CTR)
 . . . L -^RCY(344.6,PIEN)
 ;
 ; Flag selected entries
 F CTR=1:1:$L(PIENS,",") D  ;
 . N FDA,IENS,OLDVAL,VALUE
 . S PIEN=$P(PIENS,",",CTR)
 . S IENS=PIEN_","
 . S SEL=$P(SELS,",",CTR)
 . S OLDVAL=$$GET1^DIQ(344.6,IENS,FIELD,"I")
 . S VALUE=$S('OLDVAL:1,1:0)
 . S FDA(344.6,IENS,FIELD)=VALUE
 . L -^RCY(344.6,PIEN)
 . D FILE^DIE("","FDA")
 . D GET1PAY(PIEN,SEL)
 . D BLD1PAY(SEL)
 Q
 ;
FILTER ; EP - for RCDPE PAYER FLAGS FILTER protocol
 ; Change the filter from a protocol
 ; Inputs - None
 ; Output - Sets variables FILTER and DATEFILT
 N NEWDATE,NEWFILT
 S VALMBCK="R"
 D FULL^VALM1
 S NEWDATE=$$GETDATE()
 I NEWDATE=-1 Q  ;
 S NEWFILT=$$GETFILT()
 I NEWFILT=-1 Q  ;
 S DATEFILT=NEWDATE
 S FILTER=NEWFILT
 D HDR,INIT
 Q
 ;
PARSEL(VALMNOD,BEG,END) ; -- split out pre-answers from user
 ; Inputs - VALMNOD= User input from protocol menu including pre-answers
 ;          BEG=Begining of the valid numeric range
 ;          END=End of the valid numeric range
 ; Returns - Y=Comma separated list of valid numeric entries
 ;
 ; This code is adapted from VALM2. 
 N I,J,L,X,Y
 S Y=$TR($P($P(VALMNOD,U,4),"=",2),"/\; .",",,,,,")
 ; Run through the list, skip invalid selections and expand ranges
 S X=Y,Y=""
 F I=1:1 S J=$P(X,",",I) Q:J=""  D  ;
 . I J'["-",J>(BEG-1),J<(END+1) S Y=Y_J_"," ; single valid selection 
 . I J["-",J,J<$P(J,"-",2) D  ;
 . . F L=+J:1:+$P(J,"-",2) D  ;
 . . . I L>(BEG-1),L<(END+1) S Y=Y_L_"," ; valid selection from expanded range
 Q Y
 ;
PARSED(X) ; Take a date in external format and check if it is a valid
          ; DATE ADDED (.03) in file 344.6
 ; Input - Date in External format
 ; Output - Date in Fileman format or 0 if the input was invalid
 D VAL^DIE(344.6,"+1,",.03,"",X,.RET)
 Q RET
 ;
ASKYN(PROMPT,DEFAULT) ; Ask a yes/no question
 ; Input: PROMPT - Question to be asked
 ;        DEFAULT - Default Answer
 ;        1 - YES, 0 - NO
 ;        Optional, defaults to 0
 ; Returns: 1 - User answered YES, 0 othewise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S:$G(DEFAULT)'=1 DEFAULT=0
 S DIR(0)="Y",DIR("A")=PROMPT
 S DIR("B")=$S(DEFAULT:"YES",1:"NO")
 D ^DIR
 Q Y
 ;
HELP ; EP - for template RCDPE PAYER FLAGS help
 ; Input: None
 ; Output: Text from a help frame displayed to the screen
 N FILTER,DATEFILT,XQH
 S VALMBCK="R"
 S XQH="RCDPE PAYER FLAGS GENERAL"
 D EN^XQH
 Q
 ;
EXIT ; -- exit code
 D FULL^VALM1
 Q
