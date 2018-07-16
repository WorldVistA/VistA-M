RCDPESP5 ;ALB/SAB - ePayment Lockbox Site Parameters Definition - Files 344.71 ;03/19/2015
 ;;4.5;Accounts Receivable;**304,321**;Mar 20, 1995;Build 48
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CARC(RCQUIT) ;Update the CARC/RARC inclusion table - added RCQUIT as input parameter - PRCA*4.5*321
 ;
 ;initialize
 N RCANS,RCCARC,RCCHG,RCCDATA,RCCIEN,RCEDIT,RCRSN,RCSTAT
 N RCAMT,RCNAMT,RCAUDARY,RCCARCDS,RCYN,RCVAL,RCINACT,RCACTV
 S RCEDIT="",RCANS=""
 ;
 ;Display initial entry line.
 W !,"AUTO-DECREASE MEDICAL CLAIMS FOR THE FOLLOWING CARC/AMOUNTS ONLY:",!
 ;
 ;
 ;Loop until the user quits
 F  D  Q:RCANS="Q"
 . ;
 . ;display list of currently enabled/disabled CARCs/RARCs
 . D PRTCARC()
 . ;
 . ; add some spacing
 . W !!
 . ;
 . ;Ask user for the CARC/RARC to enable/disable (QUIT) [default] to exit
 . ;
 . S RCCARC=$$GETCARC()
 . I RCCARC=-1 S RCQUIT=1,RCANS="Q" Q
 . I RCCARC=0 S RCANS="Q" Q
 . ;
 . ;Validate CARC entered
 . S RCVAL=$$VAL^RCDPCRR(345,RCCARC)  ; Validate the CARC against File 345
 . S RCACTV=$$ACT^RCDPRU(345,RCCARC,)  ; Check if CARC is an active code
 . ;
 . ;If the CARC is invalid, warn user and exit back to the CARC prompt
 . I 'RCVAL W !,"The CARC code you have entered is not a valid CARC code.  Please try again" Q
 . ;
 . ; Print CARC and description and initialize inactive variable
 . S RCCARCDS="",RCINACT=""
 . D GETCODES^RCDPCRR(RCCARC,"","A",$$DT^XLFDT,"RCCARCDS","1^70")
 . I $D(RCCARCDS("CARC",RCCARC))'=10 D
 . . S RCINACT=1
 . . D GETCODES^RCDPCRR(RCCARC,"","I",$$DT^XLFDT,"RCCARCDS","1^70")
 . S RCCIEN=$O(RCCARCDS("CARC",RCCARC,""))
 . S RCDESC=$P(RCCARCDS("CARC",RCCARC,RCCIEN),U,6)
 . ;
 . ; If the description is 70 characters, add ellipsis to the string to indicate there is more to the description
 . S:$E(RCDESC)=70 RCDESC=RCDESC_" ..."
 . W !,?3,RCDESC,!
 . I 'RCACTV W "   *** WARNING: CARC code "_RCCARC_" is no longer active.",!
 . ;
 . ; Look up CARC/RARC in table.
 . S RCCIEN=$O(^RCY(344.62,"B",RCCARC,""))
 . S (RCAMT,RCSTAT)=0  ; Initialize if new code entry for table
 . I RCCIEN D         ; Code exists in table
 . . S RCCDATA=$G(^RCY(344.62,RCCIEN,0))
 . . ;
 . . ; Get current Auto-decrease status and Max decrease amount
 . . S RCSTAT=$P(RCCDATA,U,2)
 . . S RCAMT=$P(RCCDATA,U,6)
 . ;
 . ; Init Audit array to send each update individually
 . S RCAUDARY(1)=""
 . S RCAUDARY(2)=""
 . ;
 . ; If present and enabled
 . I RCCIEN,RCSTAT D  Q
 . . ;
 . . S RCNAMT=0,RCRSN=""  ;Initialize variables
 . . ;
 . . ; Confirm that this is the correct CARC
 . . S RCYN=$$CONFIRM(4)
 . . Q:RCYN=-1
 . . ;
 . . ; Ask for reason
 . . S RCRSN=$$GETREASN(RCCARC)
 . . Q:RCRSN=-1   ; User requested to quit
 . . ;
 . . ; Confirm the disabling
 . . S RCYN=$$CONFIRM(3)
 . . Q:RCYN=-1
 . . ;
 . . D UPDDATA(RCCIEN,0,RCAMT,RCRSN) ; If disabling
 . . ;
 . . ;At least 1 item was change/updated/added so set flag for reprint
 . . I 'RCEDIT S RCEDIT=1
 . . ;
 . . ;Don't need a second entry in the audit file so kill it to prevent audit logging from crashing
 . . K RCAUDARY(2)
 . . ;
 . . ; Update audit log for disable CARC
 . . ; Order - File ; Field ; IEN ; New Value ; Old Value ; Comment
 . . S RCAUDARY(1)="344.62^.02^"_RCCIEN_"^0^1^"_RCRSN
 . . D AUDIT^RCDPESP(.RCAUDARY)
 . ;
 . ; Confirm that this is the correct CARC to Enable
 . S RCYN=$$CONFIRM(1)
 . Q:RCYN=-1
 . ;
 . ; Ask for new amount
 . S RCNAMT=$$GETAMT()
 . Q:RCNAMT=-1   ; User requested to quit
 . ;
 . ; Ask for reason
 . S RCRSN=$$GETREASN(RCCARC)
 . Q:RCRSN=-1   ; User requested to quit
 . ;
 . ; Confirm save
 . S RCYN=$$CONFIRM(2)
 . I (RCYN="N")!(RCYN=-1) W !,"NOT SAVED",!! Q
 . ;   
 . ; Re-enable if disabled and quit
 . I RCCIEN D  Q
 . . D UPDDATA(RCCIEN,1,RCNAMT,RCRSN)  ; Renable and update amount
 . . ;
 . . ;Update audit file with reason and amount changes.
 . . ; Order - File ; Field ; IEN ; New Value ; Old Value ; Comment
 . . S RCAUDARY(1)="344.62^.02^"_RCCIEN_"^1^"_RCSTAT_"^"_RCRSN
 . . S RCAUDARY(2)="344.62^.06^"_RCCIEN_"^"_RCNAMT_"^"_RCAMT_"^"_RCRSN
 . . D AUDIT^RCDPESP(.RCAUDARY)
 . . ;
 . . ;At least 1 item was change/updated/added so set flag for reprint
 . . I 'RCEDIT S RCEDIT=1
 . ;
 . ; Store new entry
 . D ADDDATA(RCCARC,RCNAMT,RCRSN)
 . ;
 . ;Update audit file with reason and amount changes.
 . S RCCIEN=$$FIND1^DIC(344.62,"","",RCCARC,"","","RCERR") I RCCIEN="" S RCCIEN="ERROR"
 . ;
 . ; Order - File ; Field ; IEN ; New Value ; Old Value ; Comment
 . S RCAUDARY(1)="344.62^.02^"_RCCIEN_"^1^0^"_RCRSN
 . S RCAUDARY(2)="344.62^.06^"_RCCIEN_"^"_RCNAMT_"^0^"_RCRSN
 . D AUDIT^RCDPESP(.RCAUDARY)
 . ;
 . ;At least 1 item was change/updated/added so set flag for reprint
 . I 'RCEDIT S RCEDIT=1
 ;
 Q
 ;
PRTCARC() ;Display current entries that have been defined for inclusion or exclusion into 
 ;
 N RCI,RCCT,RCSTRING,RCDATA,RCINACT,RCCARCD,RCDESC,RCCIEN,RCSTAT,RCCODE
 ;
 S RCI=0,RCCT=0,RCSTRING=""
 S RCSTRING=$TR($J("",73)," ","-")
 ;
 ; Print Header
 ;
 W !!,?3,"CARC ",?9,"Description",?65,"Max. Amt"
 W !,?3,RCSTRING
 ;
 ; Loop and print entries
 F  S RCI=$O(^RCY(344.62,RCI)) Q:'RCI  D
 . S RCDATA=$G(^RCY(344.62,RCI,0))
 . Q:RCDATA=""
 . S RCCODE=$P(RCDATA,U),RCCIEN=$O(^RC(345,"B",RCCODE,""))
 . S RCDESC=$G(^RC(345,RCCIEN,1,1,0))
 . S RCSTAT=$P(RCDATA,U,2)
 . Q:RCSTAT'=1
 . S RCCT=RCCT+1
 . I $L(RCDESC)>50 S RCDESC=$E(RCDESC,1,50)_" ..."
 . D GETCODES^RCDPCRR(RCCODE,"","B",$$DT^XLFDT,"RCCARCD","1^70")
 . W !,?3,RCCODE,?9,$E(RCDESC,1,55),?63,$J($P(RCDATA,U,6),10,0)
 . I $P(RCCARCD("CARC",RCCODE,RCCIEN),U,3)'="" W " (I)"  ; if inactive, display (I)
 . K RCCARCD
 ;
 I RCCT=0 W !,?5,"NO CARC/AMOUNTS ENTERED"
 Q
 ;
 ;Retrieve the next CARC code to enable/disable
GETCARC() ;
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT
 S DIR("?")="Enter a CARC code to enable/disable or Q to Quit."
 S DIR(0)="FAO"
 S DIR("??")="^D LIST^RCDPCRR(345)"
 S DIR("A")="CARC: "
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 I Y="" Q 0
 Q Y
 ;
 ;Ask user to change or disable an enabled CARC auto-decrement
CHGDIS() ;
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT
 S DIR("?")="Either (D)isable the CARC from Auto-Decrease or (C)hange the maximum amount of Auto-Decrease."
 S DIR(0)="FA"
 S DIR("A")="(C)hange or (D)isable: "
 S DIR("S")="C:Change;D:Disable"
 D ^DIR
 K DIR
 Q Y
 ;
 ;Ask user to change or disable an enabled CARC auto-decrement
CONFIRM(RCIDX) ;
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT
 ;
 ; Confirm if the CARC code is correct
 I RCIDX=1 D
 . S DIR("?")="Either (Y)es to confirm that this is the correct code or (N)o to enter a different code."
 . S DIR("A")="ENABLE this CARC for Auto-Decrease of Medical Claims (Y/N)? "
 ;
 ; Confirm if the user wishes to Enable the changes
 I RCIDX=2 D
 . S DIR("?")="Either (Y)es to confirm changes or (N)o to exit without saving."
 . S DIR("A")="Save this CARC? (Y)es or (N)o: "
 ;
 ; Confirm if the user wishes to Disable the changes
 I RCIDX=3 D
 . S DIR("?")="Either (Y)es to confirm changes or (N)o to exit without saving."
 . S DIR("A")="Remove this CARC? (Y)es or (N)o: "
 ;
 ; Confirm if the CARC code is correct
 I RCIDX=4 D
 . S DIR("?")="Either (Y)es to confirm that this is the correct code or (N)o to enter a different code."
 . S DIR("A")="DISABLE this CARC for Auto-Decrease of Medical Claims (Y/N)? "
 ;
 S DIR(0)="YA"
 S DIR("S")="Y:Yes;N:No"
 D ^DIR
 K DIR
 I $G(DTOUT)!$G(DUOUT) S Y=-1
 I Y="0" S Y=-1
 Q Y
 ;
 ;Ask user the maximum amount to allow for auto-decrease
GETAMT() ;
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT
 S DIR("?")="Enter the maximum amount the CARC can be auto-decreased between $1 and $1500"
 S DIR(0)="NA^1:1500:0"
 S DIR("A")="MAXIMUM DOLLAR AMOUNT TO AUTO-DECREASE (1-1500): "
 D ^DIR
 K DIR
 I $G(DUOUT) S Y=-1
 Q Y
 ;
 ;Get the reason for modification
GETREASN(RCCARC) ;
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT
 S DIR("?")="Enter reason for enabling/disabling, or changing the Maximum Dollar decrease amount for CARC "_RCCARC_" (3-50 chars)."
 S DIR(0)="FA^3:50"
 S DIR("A")="COMMENT: "
 S DIR("PRE")="S X=$$TRIM^XLFSTR(X,""LR"")" ; comment required and should be significant
 D ^DIR
 K DIR
 I $G(DUOUT) S Y=-1
 Q Y
 ;
 ;Update the database and audit log
UPDDATA(RCCIEN,RCSTAT,RCAMT,RCRSN) ;
 N DA,DR,DIE,DTOUT,X,Y,DIC
 ; replaced //// with /// in following 5 lines - PRCA*4.5*321
 S DA=RCCIEN,(DIC,DIE)="^RCY(344.62,"
 S DR=".02///"_RCSTAT_";"
 S DR=DR_".05///"_$$DT^XLFDT_";"
 S DR=DR_".04///"_DUZ_";"
 S DR=DR_".06///"_RCAMT_";"
 S DR=DR_".07///"_RCRSN_";"
 ;
 L +^RCY(344.62,RCCIEN):10
 D ^DIE
 L -^RCY(344.62,RCCIEN)
 Q $D(Y)=0
 ;
 ;Add new entry to the table
ADDDATA(RCCARC,RCAMT,RCRSN) ;
 N RCENTRY,RCROOT,MSGROOT
 ;
 ; set up array
 S RCENTRY(344.62,"+1,",.01)=RCCARC        ;CARC Code
 S RCENTRY(344.62,"+1,",.02)=1             ;Enabled status
 S RCENTRY(344.62,"+1,",.03)=$$DT^XLFDT    ;Date added
 S RCENTRY(344.62,"+1,",.04)=DUZ           ;User
 S RCENTRY(344.62,"+1,",.06)=RCAMT         ;Max amount
 S RCENTRY(344.62,"+1,",.07)=RCRSN         ;Comment
 ;
 ;file entry
 D UPDATE^DIE(,"RCENTRY","RCROOT","MSGROOT")
 Q
AUDIT() ;
 ;
 N EMEDANS,EOLDMED,EOLDRX,ERXANS,MEDANS,OLDMED,OLDRX,RXANS ; PRCA*4.5*321
 ;
 ; Get existing answers for Medical and Pharmacy paper bills
 S OLDMED=$$GET1^DIQ(342,"1,",7.05,"I")
 S OLDRX=$$GET1^DIQ(342,"1,",7.06,"I")
 ;
 ; Get existing answers for Medical and Pharmacy EDI (electronic) bills ; PRCA*4.5*321
 S EOLDMED=$$GET1^DIQ(342,"1,",7.07,"I") ; PRCA*4.5*321
 S EOLDRX=$$GET1^DIQ(342,"1,",7.08,"I") ; PRCA*4.5*321
 ;
 ; Get Medical paper bills
 S MEDANS=$$GETAUDIT(1)
 Q:MEDANS=-1 1
 ; File Medical paper bills
 I MEDANS'=OLDMED D
 . N RCAUDVAL
 . D FILEANS(7.05,MEDANS)
 . ; FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE^COMMENT
 . S RCAUDVAL(1)="342^7.05^1^"_MEDANS_U_OLDMED_U_"Updating the Medical Auto-Audit of paper bills"
 . D AUDIT^RCDPESP(.RCAUDVAL)
 ;
 ; Get Pharmacy paper bills
 S RXANS=$$GETAUDIT(2)
 Q:RXANS=-1 1
 ;
 ; File Pharmacy paper bills
 I RXANS'=OLDRX D
 . N RCAUDVAL
 . D FILEANS(7.06,RXANS)
 . S RCAUDVAL(1)="342^7.06^1^"_RXANS_U_OLDRX_U_"Updating the Pharmacy Auto-Audit of paper bills"
 . D AUDIT^RCDPESP(.RCAUDVAL)
 ; 
 ; BEGIN PRCA*4.5*321
 ; Get Medical electronic bills
 S EMEDANS=$$GETAUDIT(3)
 Q:EMEDANS=-1 1
 ; File Medical electronic bills
 I EMEDANS'=EOLDMED D
 . N RCAUDVAL
 . D FILEANS(7.07,EMEDANS)
 . ; FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE^COMMENT
 . S RCAUDVAL(1)="342^7.07^1^"_EMEDANS_U_EOLDMED_U_"Updating the Medical Auto-Audit of electronic bills"
 . D AUDIT^RCDPESP(.RCAUDVAL)
 ;
 ; Get Pharmacy electronic bills
 S ERXANS=$$GETAUDIT(4)
 Q:ERXANS=-1 1
 ;
 ; File Pharmacy electronic bills
 I ERXANS'=EOLDRX D
 . N RCAUDVAL
 . D FILEANS(7.08,ERXANS)
 . S RCAUDVAL(1)="342^7.08^1^"_ERXANS_U_EOLDRX_U_"Updating the Pharmacy Auto-Audit of electronic bills"
 . D AUDIT^RCDPESP(.RCAUDVAL)
 ; END PRCA*4.5*321
 ;
 Q 0
 ;
 ;Retrieve the parameter for the bill type
GETAUDIT(FLAG) ;
 ; BEGIN PRCA*4.5*321
 ;FLAG - What audit type (1=Med Paper, 2=RX Paper, 3=Med EDI, 4=Rx EDI)
 Q:'$G(FLAG) -1
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FLDNO,RCANS,TYPL,TYPU,X,Y
 S TYPL=$S(FLAG>2:"electronic",1:"paper")
 S TYPU=$S(FLAG>2:"ELECTRONIC",1:"PAPER")
 S FLDNO=$S(FLAG=1:7.05,FLAG=2:7.06,FLAG=3:7.07,FLAG=4:7.08,1:0)
 Q:'FLDNO -1
 ;
 ; Prompt for Medical Auto-audit
 D:$G(FLAG)#2=1
 . S DIR("A")="ENABLE AUTO-AUDIT FOR MEDICAL "_TYPU_" BILLS (Y/N): "
 . S DIR("?",1)="Allow a site to automatically audit their Medical "_TYPL_" Bills"
 . S DIR("?",2)="during the AR Nightly Process."
 . S DIR("?",3)=" "
 . S RCANS=$$GET1^DIQ(342,"1,",FLDNO)
 ;
 ; Prompt for Pharmacy Auto-audit
 D:$G(FLAG)#2=0
 . S DIR("A")="ENABLE AUTO-AUDIT FOR PHARMACY "_TYPU_" BILLS (Y/N): "
 . S DIR("?",1)="Allow a site to automatically audit their Pharmacy "_TYPL_" Bills"
 . S DIR("?",2)="during the AR Nightly Process."
 . S DIR("?",3)=" "
 . S RCANS=$$GET1^DIQ(342,"1,",FLDNO)
 ; END PRCA*4.5*321
 ;
 S DIR(0)="YAO"
 S DIR("?")="Enter Yes or No to select automatic processing of "_TYPL_" bills." ; PRCA*4.5*321
 S DIR("B")=$S($G(RCANS)'="":RCANS,1:"No")
 D ^DIR K DIR
 I Y="" Q ""
 I $D(DTOUT)!$D(DUOUT)!(Y="")  Q -1
 Q Y
 ;
 ;File the answer
FILEANS(FIELD,ANS) ;
 ;
 N DR,DIE,DA,DTOUT,DIDEL,X,Y
 ;
 ;Update Transaction
 S DR=FIELD_"///"_ANS           ;Original Confirmation #
 S DIE="^RC(342,"
 S DA=1
 D ^DIE
 ;
 Q
