RCDPEM5 ;ALB/PJH - EPAYMENTS MOVE EEOB TO NEW CLAIM ;Oct 29, 2014@16:43:51
 ;;4.5;Accounts Receivable;**173,208,276,298**;Mar 20, 1995;Build 121
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
 ;Called from Worklist/Scratchpad option Split/Edit FILESP^RCDPEWL8
UPDWL(OBILL,RCSPLIT,RCERA) ;
 N NCLAIM,SUB,SUB1,NBILL,ORIG,MOVE,JUST,JUST1,VALID
 ;Find EOB for the claim
 S ORIG=$$FINDEOB(RCERA,OBILL) I 'ORIG Q 1
 ;Default operation is move
 S (SUB,SUB1)=0,MOVE=1,VALID=1
 ;Loop through split lines 
 F  S SUB=$O(RCSPLIT(SUB)) Q:'SUB  D
 .;Bill Number
 .S NBILL=$P(RCSPLIT(SUB),U)
 .;Ignore suspense claims, piece 5 is pointer to AR claim file 430
 .Q:$P(RCSPLIT(SUB),U,5)=""
 .;If original bill is in the array then default operation is copy
 .I OBILL=NBILL S MOVE=0 Q
 .;Save POINTER to AR Claim file 430 (DINUM to 399)
 .S SUB1=SUB1+1,NCLAIM(SUB1)=$P(RCSPLIT(SUB),U,5)
 ;If all copied to claims are suspense no further action needed on EOB
 I SUB1=0 Q 1
 ;Prompt user to continue
 N DIR,X,Y,DIROUT,MODE
 S DIR(0)="Y",DIR("B")="YES"
 S MODE=$S(MOVE:"M",1:"C")
 S DIR("A")=$$PROMPT(ORIG,.NCLAIM,MODE)
 W ! D ^DIR
 ;
 I $G(DIROUT)!$G(DUOUT)!(Y=0) D EXIT Q 0
 ;
 ;Lock Original EOB
 I '$$LOCK^IBCEOB4(ORIG) Q 0
 ;
 ;If original EOB is moved - move original EOB to first new claim
 I MOVE D
 .;Automatic creation of justification text
 .S JUST=$$JUST(ORIG,.NCLAIM,"M",0)
 .;Update AR comments on 'from claim'
 .D AUDIT^RCDPAYER(ORIG,JUST,"W")
 .;Change claim number on EOB
 .D MOVE^IBCEOB4(ORIG,NCLAIM(1),DUZ,$$NOW^XLFDT,JUST,MODE) Q:SUB1=1
 .;Copy any additional claims to new EOBs
 .N CCLAIM M CCLAIM=NCLAIM K CCLAIM(1)
 .S JUST1=$$JUST(ORIG,.NCLAIM,"M",1)
 .D COPY^IBCEOB4(ORIG,.CCLAIM,DUZ,$$NOW^XLFDT,JUST1,MODE)
 ;
 ;If original EOB is not moved - copy all new claims to new EOBs
 I 'MOVE D
 .S JUST=$$JUST(ORIG,.NCLAIM,"C",0) ;Just. Text for original EEOB
 .S JUST1=$$JUST(ORIG,.NCLAIM,"C",1) ;Just. Text for copied to EEOB
 .D COPY^IBCEOB4(ORIG,.NCLAIM,DUZ,$$NOW^XLFDT,JUST,MODE)
 ;
 ;Update AR Comments on 'to claim'
 D AUDIT^RCDPAYER(ORIG,JUST,"W")
 ;
 ;Get list of other copied claims
 N OCLAIM,SUB M OCLAIM=NCLAIM
 ;Ignore first of these claim if this was a move
 I MOVE K OCLAIM(1)
 ;Update AR comments for other claims
 N SUB,NEWEOB
 S SUB=0
 F  S SUB=$O(OCLAIM(SUB)) Q:'SUB  D
 .;Convert Claim pointer to EOB pointer
 .S NEWEOB=$O(^IBM(361.1,"B",OCLAIM(SUB),0)) Q:'NEWEOB
 .D AUDIT^RCDPAYER(NEWEOB,JUST1,"W")
 ;
 W !!,"EEOB Update Complete" H 1
 Q 1
 ;
PROMPT(ORIG,NCLAIM,MODE) ;Construct prompt text
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
JUST(ORIG,NCLAIM,MODE,TYPE) ;Construct justification text for worklist option
 N FIRST,STR,STR1,SUB,TEXT
 ;Original bill numbe
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
 ;Return full justification text
 Q STR_STR1_" by Split/Edit Line"
 ;
JUST1(ORIG,NCLAIM,MODE,TYPE) ;Construct AR comment for stand alone option
 N FIRST,STR,STR1,SUB,TEXT
 ;Original bill numbe
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
 N IEN3611,SUB
 S (SUB,IEN3611)=0
 F  S SUB=$O(^RCY(344.4,IEN3444,1,"AC",SUB)) Q:'SUB  D  Q:IEN3611
 .I $$EXTERNAL^DILFD(344.41,.02,,SUB)=BILL S IEN3611=SUB
 Q IEN3611
 ;
REMOVE(ORIG,MODE) ;Option to Remove EEOB - PRCA*4.5*298
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
