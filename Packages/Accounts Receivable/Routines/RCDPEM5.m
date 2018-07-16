RCDPEM5 ;ALB/PJH - EPAYMENTS MOVE EEOB TO NEW CLAIM ;Oct 29, 2014@16:43:51
 ;;4.5;Accounts Receivable;**173,208,276,298,321**;Mar 20, 1995;Build 48
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ;Entry point for EEOB Move/Copy/Remove [RCDPE EEOB MOVE/COPY/REMOVE] option
 ;
 N DIR,X,Y,DIROUT,DUOUT,MODE
 S DIR("A")="Select action"
 S DIR("B")="M"
 S DIR(0)="S^M:Move EEOB to different claim;"
 S DIR(0)=DIR(0)_"C:Copy EEOB to multiple claims;"
 S DIR(0)=DIR(0)_"R:Remove EEOB from claim"
 D ^DIR Q:$G(DIROUT)!$G(DUOUT)
 S MODE=Y
 ;
 ; - PRCA*4.5*298 - OWNSKEY^XUSRB - Supported IA 3277  
 I MODE="R" N MSG D OWNSKEY^XUSRB(.MSG,"RCDPE REMOVE EEOB",DUZ) I 'MSG(0) D  Q
 .W !!,"SORRY, YOU ARE NOT AUTHORIZED TO USE THIS ACTION"
 .W !,"This action is locked with RCDPE REMOVE EEOB key.",!
 .N DIR S DIR(0)="E" D ^DIR
 ;
 ;Read access to file #361.1 under IA 4051
 ;
 N DA,DIC,DIE,DIR,DR,NCLAIM,ORIG,ORIGNAM,X,Y
 ;
 ;Allow selection of a original third party EOB
 S DIC("A")="Select EXPLANATION OF BENEFIT (EEOB) to "_$S(MODE="M":"MOVE",MODE="R":"REMOVE",1:"COPY")_": "
 ; screen to only allow selection of an active EEOB (not marked as deleted) and non-MRA type EOB
 S DIC("S")="I ($P(^(0),U,4)=0)&('$P($G(^(102)),U))",DIC="^IBM(361.1,",DIC(0)="AEMQ"
 W ! D ^DIC K DIC
 ;
 I Y'>0 Q
 ; controlled subscription IA 1992
 S ORIG=+Y,ORIGNAM=$$GET1^DIQ(399,$P(Y,U,2),.01)
 ;
 ;Get current bill payer sequence from claim - IA 3820
 D
 .N CURR,IEN399
 .S IEN399=$P($G(^IBM(361.1,ORIG,0)),U) Q:'IEN399
 .S CURR=$P($G(^DGCR(399,IEN399,0)),U,21) I (CURR'="T")&(CURR'="S") Q
 .W !!,"Warning - selected EEOB has secondary claims and may have tertiary claims"
 ;
 ;Lock Original EOB
 Q:'$$LOCK^IBCEOB4(ORIG)
 ;
 ;Remove Option
 I MODE="R" D REMOVE(ORIG,MODE),EXIT Q
 ;
 ;Select Claim(s) to Move/Copy to
 N RCBILL,RCBILLNM,NCLAIM,NCLAIMX,QUIT,SUB,LIT
 S SUB=0,QUIT=0,LIT=""
 W !
 F  D  Q:QUIT  Q:SUB&(MODE="M")
 .;Allow selection of a third party claim
 .I MODE="M" S DIC("A")="Select A/R Bill to MOVE to: "
 .I MODE="C" S DIC("A")="Select "_LIT_"A/R Bill to COPY to: "
 .S DIC="^PRCA(430,",DIC(0)="AEMQ",DIC("S")="I $D(^DGCR(399,+Y,0))&($$VALSTAT^RCDPEM5(+Y))"
 .D ^DIC K DIC
 .I Y'>0 S QUIT=1 Q
 .S RCBILL=+Y,RCBILLNM=$P($P(Y,U,2),"-",2)
 .I ORIGNAM=RCBILLNM,MODE="M" W !,"Cannot move EEOB to same claim" Q
 .I $D(NCLAIMX(RCBILL)) W !,"Claim already entered" Q
 .S SUB=SUB+1,NCLAIM(SUB)=RCBILL,NCLAIMX(RCBILL)=""
 .S:MODE="C" LIT="another "
 ;
 I $G(DUOUT)!$G(DIROUT) D EXIT Q
 ;
 ;User Exit or no claims selected
 I '$O(NCLAIM("")) D EXIT Q
 ;
 ;Prompt user to continue
 N DIR,X,Y,DIROUT
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")=$$PROMPT(ORIG,.NCLAIM,MODE)
 W ! D ^DIR
 ;
 I $G(DIROUT)!$G(DUOUT)!(Y=0) D EXIT Q
 ;
 ;Enter Justification Comment
 N DIR,DIROUT,DUOUT,JCOM,X,Y
 S DIR(0)="FA^1:100^K:$TR(X,"" "","""")="""" X",DIR("A")="Enter JUSTIFICATION COMMENT: "
 W ! D ^DIR I $G(DIROUT)!$G(DUOUT) W !!,"Update not performed" D EXIT Q
 S JCOM=Y
 ;
 ;Update EOB
 D UPDATE(ORIG,.NCLAIM,MODE,JCOM),EXIT
 ;
 Q
 ;
 ;Unlock original EOB
EXIT D UNLOCK^IBCEOB4(ORIG)
 Q
 ;
 ;File EOB #361.1 changes - Integration Agreement 5671 for IBCEOB4
UPDATE(ORIG,NCLAIM,MODE,JUST) ;
 ; Input - ORIG - Original EOB
 ;       - NCLAIM - New claim (s)
 ;       - MODE M=Move C=Copy
 ;       - JUST = User input justification text
 ; Output -  Updates EOB and Audit log
 N JUST1
 ;Move EOB
 I MODE="M" D
 .;Auto generate text for AR comments on original claim
 .S JUST1=$$JUST1(ORIG,.NCLAIM,"M",0)
 .;Update AR Comments on the 'from bill'
 .D AUDIT^RCDPAYER(ORIG,JUST_"^"_JUST1,MODE)
 .;Change claim number on EEOB
 .D MOVE^IBCEOB4(ORIG,NCLAIM(1),DUZ,$$NOW^XLFDT,JUST,MODE)
 .;Update AR Comments on 'to bill'
 .D AUDIT^RCDPAYER(ORIG,JUST_"^"_JUST1,MODE)
 ;Copy EOB
 I MODE="C" D
 .D COPY^IBCEOB4(ORIG,.NCLAIM,DUZ,$$NOW^XLFDT,JUST,MODE)
 .;Auto generate text for AR comments on original claim
 .S JUST1=$$JUST1(ORIG,.NCLAIM,"C",0)
 .;Update AR Comments on original claim
 .D AUDIT^RCDPAYER(ORIG,JUST_"^"_JUST1,MODE)
 .;Auto generate text for AR comments on new claim
 .S JUST1=$$JUST1(ORIG,.NCLAIM,"C",1)
 .;Update AR Comments on new claims
 .N SUB,NEWEOB
 .S SUB=0
 .F  S SUB=$O(NCLAIM(SUB)) Q:'SUB  D
 ..;Convert Claim pointer to EOB pointer
 ..S NEWEOB=$O(^IBM(361.1,"B",NCLAIM(SUB),0)) Q:'NEWEOB
 ..D AUDIT^RCDPAYER(NEWEOB,JUST_"^"_JUST1,MODE)
 W !!,"EEOB Update Complete" H 1
 Q
 ;
PROMPT(ORIG,NCLAIM,MODE) ;Construct prompt text
 ; Input - ORIG - Original EOB
 ;       - NCLAIM - New claim (s)
 ;       - MODE M=Move C=Copy 
 ; Output - Justification text
 ;
 N FIRST,STR,STR1,SUB,TEXT
 ;Move or copy text
 S TEXT=$$EXTERNAL^DILFD(361.1,.01,,$P($G(^IBM(361.1,ORIG,0)),U))
 I MODE="M" S STR="Move EEOB from claim "_TEXT_" to claim "
 E  S STR="Copy EEOB from claim "_TEXT_" to claim(s) "
 ;Build list of claims
 S STR1="",SUB="",FIRST=1
 F  S SUB=$O(NCLAIM(SUB)) Q:'SUB  D
 .S TEXT=$P($G(^PRCA(430,NCLAIM(SUB),0)),U)
 .I FIRST S STR1=STR1_$P(TEXT,"-",2),FIRST=0 Q
 .S STR1=STR1_", "_$P(TEXT,"-",2)
 ;Return full prompt text
 Q STR_STR1_" "
 ;
JUST(ORIG,NCLAIM,MODE,TYPE,SRC) ;Construct justification text for automatic updates
 ; Input - ORIG - Original EOB
 ;       - NCLAIM - New claim (s)
 ;       - MODE - "M" = Move "C" =Copy "R" = Remove
 ;       - TYPE - 0 = old EOB 1 = new EOB
 ;       - SRC - "W" = Worklist "A" = Auto-post  
 ; Output - Justification text
 N FIRST,STR,STR1,SUB,TEXT
 ;Original bill number
 S TEXT=$$EXTERNAL^DILFD(361.1,.01,,$P($G(^IBM(361.1,ORIG,0)),U))
 ;Justification comment for original EOB
 I TYPE=0 D
 .I MODE="R" S STR="EEOB removed from claim "_TEXT,STR1="" Q  ;PRCA*4.5*321
 .I MODE="M" S STR="EEOB from claim "_TEXT_" moved to claim "
 .I MODE="C" S STR="EEOB from claim "_TEXT_" copied to claim(s) "
 .;Build list of claims
 .S STR1="",SUB="",FIRST=1
 .F  S SUB=$O(NCLAIM(SUB)) Q:'SUB  D
 ..S TEXT=$P($G(^PRCA(430,NCLAIM(SUB),0)),U)
 ..I FIRST S STR1=STR1_$P(TEXT,"-",2),FIRST=0 Q
 ..S STR1=STR1_", "_$P(TEXT,"-",2)
 ;Justification comment for new EOB's
 I TYPE=1 D
 .I MODE="M" S STR="EEOB moved from EEOB for claim "_TEXT,STR1=""
 .I MODE="C" S STR="EEOB copied from EEOB for claim "_TEXT,STR1=""
 ;Return full justification text
 Q STR_STR1_" automatically by "_$S(SRC="A":"Auto-post",1:"Worklist")
 ;
 ;
JUST1(ORIG,NCLAIM,MODE,TYPE) ;Construct AR comment for stand-alone MCR option
 ; Input - ORIG - Original EOB
 ;       - NCLAIM - New claim (s)
 ;       - MODE M=Move C=Copy
 ;       - TYPE = 0 - original EOB 1 - new EOB(s) 
 ; Output - Justification text
 N FIRST,STR,STR1,SUB,TEXT
 ;Original bill number
 S TEXT=$$EXTERNAL^DILFD(361.1,.01,,$P($G(^IBM(361.1,ORIG,0)),U))
 ;Justification comment for original EOB
 I TYPE=0 D
 .I MODE="M" S STR="EEOB from claim "_TEXT_" moved to claim "
 .I MODE="C" S STR="EEOB from claim "_TEXT_" copied to claim(s) "
 .;Build list of claims
 .S STR1="",SUB="",FIRST=1
 .F  S SUB=$O(NCLAIM(SUB)) Q:'SUB  D
 ..S TEXT=$P($G(^PRCA(430,NCLAIM(SUB),0)),U)
 ..I FIRST S STR1=STR1_$P(TEXT,"-",2),FIRST=0 Q
 ..S STR1=STR1_", "_$P(TEXT,"-",2)
 ;Justification comment for new EOB's
 I TYPE=1 D
 .I MODE="M" S STR="EEOB moved from EEOB for claim "_TEXT,STR1=""
 .I MODE="C" S STR="EEOB copied from EEOB for claim "_TEXT,STR1=""
 ;Return comment text
 Q STR_STR1
 ;
FINDEOB(IEN3444,BILL) ;Find EOB for a claim within an ERA
 ; Input - IEN3444 = ERA ien
 ;         BILL = Bill number
 ; Output - IEN of EOB in #361.1
 N IEN3611,SUB
 S (SUB,IEN3611)=0
 F  S SUB=$O(^RCY(344.4,IEN3444,1,"AC",SUB)) Q:'SUB  D  Q:IEN3611
 .I $$EXTERNAL^DILFD(344.41,.02,,SUB)=BILL S IEN3611=SUB
 Q IEN3611
 ;
REMOVE(ORIG,MODE) ; Interactive option to Remove EEOB - PRCA*4.5*298
 ; Input - ORIG = original EOB in #361.1
 ; Output - mode = "R"
 ;
 ;Prompt user to continue
 N DIR,X,Y,DIROUT
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Are you sure you want to remove EEOB from claim "_ORIGNAM_" (Y/N)?"
 W ! D ^DIR
 ;
 I $G(DIROUT)!$G(DUOUT)!(Y=0) Q
 ;
 ;Enter Justification Comment
 N DIR,DIROUT,DUOUT,JUST,X,Y
 S DIR(0)="FA^1:100^K:$TR(X,"" "","""")="""" X",DIR("A")="Enter JUSTIFICATION COMMENT: "
 W ! D ^DIR I $G(DIROUT)!$G(DUOUT) W !!,"Update not performed" D EXIT Q
 S JUST=Y
 ;
 ;Update EEOB
 D REMOVE^IBCEOB4(ORIG,DUZ,JUST)
 ;Update AR Comments for removed claim
 D AUDIT^RCDPAYER(ORIG,JUST,MODE)
 ;
 W !!,"EEOB Update Complete" H 1
 Q
 ; 
VALSTAT(CLIEN) ; validation on current status of the AR claim selected for the move/copy event  
 ; Claims that are in a incomplete state cannot be selected
 ; incomplete states are determined at CURRENT STATUS (8,430) of the AR claim
 ; AR claims with 'BILL INCOMPLETE', 'INCOMPLETE', 'NEW BILL' statuses cannot be selected 
 ; CLIEN=430 ien
 ; returns 0 or 1
 N CSTAT,FLAG
 S CSTAT=$$GET1^DIQ(430,CLIEN,8)
 S FLAG=$S(CSTAT="BILL INCOMPLETE":0,CSTAT="INCOMPLETE":0,CSTAT="NEW BILL":0,1:1)
 Q FLAG
 ;
 ; BEGIN - PRCA*4.5*321
AUTO(OBILL,RCSPLIT,RCERA,SRC,ORIG) ;  Automatic move copy of EOB - EP for RCDPEM and RCDPEMA
 ; Input - OBILL - Original Bill number in #399 
 ;       - RCSPLIT - Array of split lines
 ;       - RCERA - ERA ien #344.4
 ;       - SRC - "W" = Worklist "A" = APAR/Autopost
 ;       - ORIG - IEN of EOB in file #361.1
 ; Output - Update EOBs and audit trail
 N CCLAIM,IFN,NCLAIM,SUB,SUB1,NBILL,MOVE,JUST,JUST1,VALID
 ; EOB for the original claim must be present
 I 'ORIG Q 1
 ; Default operation is move
 S (SUB,SUB1)=0,MOVE=1,VALID=1
 ; Loop through split lines 
 F  S SUB=$O(RCSPLIT(SUB)) Q:'SUB  D
 .; Bill Number on split line
 .S NBILL=$P(RCSPLIT(SUB),U,2)
 .; Ignore suspense claims, piece 7 is pointer to AR claim file 430
 .S IFN=$P(RCSPLIT(SUB),U,7) Q:'IFN
 .; Ignore split lines with zero value
 .Q:+$P(RCSPLIT(SUB),U,3)=0
 .; If original bill is in the array then default operation is copy
 .I OBILL=NBILL S MOVE=0
 .; Save POINTER to AR Claim file 430 (DINUM to 399)
 .S SUB1=SUB1+1,NCLAIM(SUB1)=IFN
 .; Build list of new claims to copy
 .S:OBILL'=NBILL CCLAIM(IFN)=IFN
 ;
 ; If split is between original claim and suspense (and no other claims) -  do nothing
 I SUB1=1,MOVE=0 Q 1
 ; If split was to move entire claim payment to suspense - mark EOB as removed
 I SUB1=0 D AUTOREM(ORIG,$$JUST(ORIG,"","R",0,SRC)) Q 1
 ;
 ; Lock Original EOB
 I '$$LOCK(ORIG) Q 0
 ;
 ; If split to single new claim move EOB - i.e. change claim number on EOB
 I MOVE,SUB1=1 D  Q 1
 .S JUST=$$JUST(ORIG,.NCLAIM,"C",0,SRC) ;Just. Text for original EOB
 .; Change claim number on original EOB attached to ERA
 .D MOVE^IBCEOB4(ORIG,NCLAIM(1),DUZ,$$NOW^XLFDT,JUST,"M")
 .; Update AR Transaction for original claim
 .D AUDIT^RCDPAYER(ORIG,JUST,"W")
 ;
 ; If split was to new claims - copy original EOB to new claims and then mark original EOB as removed
 I MOVE,SUB1>1 D
 .S JUST=$$JUST(ORIG,.NCLAIM,"C",0,SRC) ;Just. Text for original EEOB (copied to claims x,y,z - then removed)
 .S JUST1=$$JUST(ORIG,.NCLAIM,"C",1,SRC) ;Just. Text for copied to EEOB (copied from claim w)
 .; Copy EOB to new EOBs for "to" claims
 .;;D AUTOCOPY^IBCEOB5(ORIG,.CCLAIM,DUZ,$$NOW^XLFDT,JUST1,"C")
 .D COPY^IBCEOB4(ORIG,.CCLAIM,DUZ,$$NOW^XLFDT,JUST1,"C")
 .; Mark original EOB removed but with text of 'copied to claims....'
 .D AUTOREM(ORIG,JUST)
 ;
 ; If split was between original claim and other claims - copy all new claims to new EOBs
 I 'MOVE D
 .S JUST=$$JUST(ORIG,.NCLAIM,"C",0,SRC) ;Just. Text for original EEOB
 .S JUST1=$$JUST(ORIG,.NCLAIM,"C",1,SRC) ;Just. Text for copied to EEOB
 .D COPY^IBCEOB4(ORIG,.CCLAIM,DUZ,$$NOW^XLFDT,JUST,"C")
 .; Update AR Transaction for 'from claim'
 .D AUDIT^RCDPAYER(ORIG,JUST,"W")
 ;
 D UNLOCK(ORIG)
 Q 1
 ;
AUTOREM(ORIG,JUST) ;Silent remove of EEOB where entire payment is suspensed or moved to other claims
 ; Input - ORIG = EOB in #361.1
 ;         JUST = Justification text
 ; Output - Update EOB in #361.1 and audit trail
 ;
 ;Lock Original EOB
 I '$$LOCK(ORIG) Q
 ;Update EEOB
 D REMOVE^IBCEOB4(ORIG,DUZ,JUST)
 ;Update AR Comments for removed claim
 D AUDIT^RCDPAYER(ORIG,JUST,"R")
 ;Unlock original EOB
 D UNLOCK(ORIG)
 ;
 Q
 ;
 ;Read access to file #361.1 under IA 4051
LOCK(EOBIEN) ;Lock Original EOB
 L +^IBM(361.1,EOBIEN):5 I  Q 1
 Q 0
 ;
UNLOCK(EOBIEN) ;Release EOB
 L -^IBM(361.1,EOBIEN)
 Q
 ; END PRCA*4.5*321
 ;
 ;US1394 ADDITIONS - EP RCDPRPL1 and RCDPLPL3
EEOB(RCRCPT,RCTRANDA) ; Option to restore associated suspended/removed EEOB
 ;
 ; INPUT  - RCRCPT - Receipt ien #344
 ;        - RCTRANDA - Receipt line #344.01
 ;
 ; OUTPUT - RCEEOB - selected EEOB ien #361.1 
 ; or 0 if no EEOB
 ; or -1 if ^ abort 
 ;
 N CLAIM,DIROUT,DTOUT,DUOUT,RCEEOB,RCEEOBH,RCERA,RCLINE
 ; Get new claim IEN from receipt line
 S CLAIM=$$GET1^DIQ(344.01,RCTRANDA_","_RCRCPT_",",.09,"I")
 ; Quit if this is not a third party claim payment
 Q:CLAIM'["PRCA" 0
 ; Check if ERA has a suspended EEOB for this line
 S RCEEOB=$$SUSP(RCRCPT,RCTRANDA,.RCERA,.RCLINE)
 ; If no suspended EEOB skip prompt
 Q:'RCEEOB 0
 ;
 ; Get last move/copy history record - Read access to file #361.1 under IA 4051
 S RCEEOBH=$O(^IBM(361.1,RCEEOB,101,"A"),-1)
 ; Quit if EEOB if no history found - should not occur since EEOB is suspended
 Q:'RCEEOBH 0
 ; Display EOB detail
 W !!,"This claim has an associated EEOB on ERA "_RCERA
 W !!,"Claim Number     : ",$$GET1^DIQ(344.41,RCLINE_","_RCERA,.02,"E")
 W !,"Trace Number     : ",$$GET1^DIQ(344.4,RCERA,.02,"E")
 W !,"Total Amount Paid: ",$$GET1^DIQ(361.1,RCEEOB,1.01,"E")
 W !,"Date/Time Removed: ",$$GET1^DIQ(361.1101,RCEEOBH_","_RCEEOB,.01,"E")
 W !,"Removed by       : ",$$GET1^DIQ(361.1101,RCEEOBH_","_RCEEOB,.02,"E")
 W !,"Justification    : ",$$GET1^DIQ(361.1101,RCEEOBH_","_RCEEOB,.03,"E"),!
 ;
 ; Confirm that this is the correct EEOB
 K DIR
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="Is this the correct EEOB to associate with this claim"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) Q -1
 Q:Y'=1 0
 ;
 ;Return selected EEOB
 Q RCEEOB
 ;
SUSP(RCRCPT,RCTRANDA,RCERA,RCLINE) ; Identify suspended EEOB
 ;
 ; INPUT - RCRCPT - Receipt ien #344
 ;       - RCTRANDA - Receipt line #344.01
 ;
 ; OUTPUT - RCEEOB - selected EEOB ien #361.1 
 ;        - RCERA - ERA ien #344.4
 ;        - RCLINE - ERA line #344.41;
 ;
 N RCEEOB,RCORIG,RCRCZ,RCSPLIT
 ; Get ERA from receipt
 S RCERA=$$GET1^DIQ(344,RCRCPT_",",.18,"I")
 ; Quit if no ERA
 Q:'RCERA 0
 ; Get ERA Scratchpad line
 S RCRCZ=$$GET1^DIQ(344.01,RCTRANDA_","_RCRCPT_",",.27,"I")
 ; Quit if ERA scratchpad line missing
 Q:'RCRCZ 0
 ; Get the original line sequence number from before the split was performed
 S RCSPLIT=$$GET1^DIQ(344.491,RCRCZ_","_RCERA_",",.01),RCORIG=RCSPLIT\1
 ; Convert sequence number into original line IEN
 S RCORIG=$O(^RCY(344.49,RCERA,1,"ASEQ",RCORIG,""))
 ; Quit if original scratchpad line not found
 Q:'RCORIG 0
 ; Get ERA line from original scratchpad line
 S RCLINE=$$GET1^DIQ(344.491,RCORIG_","_RCERA_",",.09,"I")
 ; Quit if ERA line not found
 Q:'RCLINE 0
 ; Get EEOB from ERA line
 S RCEEOB=$$GET1^DIQ(344.41,RCLINE_","_RCERA_",",.02,"I")
 ; Quit if ERA line pointer to EEOB is missing
 Q:'RCEEOB 0
 ; Ignore EEOB if status is not removed - read access to file #361.1 under IA 4051
 Q:$$GET1^DIQ(361.1,RCEEOB_",",102,"I")'=1 0
 ; Return suspended EEOB IEN
 Q RCEEOB
 ;
 ; EP RCDPRPL1 and RCDPLPL3
RESTORE(RCPTDA,RCTRANDA,ORIG,SRC) ; Change bill number on EOB and clear 'removed' status
 ;
 ; INPUT - RCPTDA   - Receipt ien #344
 ;       - RCTRANDA - Receipt line #344.01
 ;       - ORIG     - EOB ien #361.1
 ;       - SRC      - 'L' - Link Payments 'R' - Receipt Porcessing
 ;
 Q:'$$LOCK^IBCEOB4(ORIG)
 ;
 W !,"Updating EEOB...."
 ;
 N NCLAIM,JUST
 ; Get new claim IEN from receipt line
 S NCLAIM=$P($$GET1^DIQ(344.01,RCTRANDA_","_RCPTDA_",",.09,"I"),";")
 ; Set up justification text
 S JUST="EEOB restored from suspense in "_$S(SRC="L":"Link Payments",SRC="R":"Edit Payments",1:"Other")
 ; Update AR comments on 'from claim'
 D AUDIT^RCDPAYER(ORIG,JUST,"W")
 ; Change claim number on EOB
 D MOVE^IBCEOB4(ORIG,NCLAIM,DUZ,$$NOW^XLFDT,JUST,"M")
 ; Reset EEOB REMOVED status
 D RESTORE^IBCEOB4(ORIG)
 ;Unlock EOB
 D UNLOCK^IBCEOB4(ORIG)
 ;
 H 1 W "done"
 Q
