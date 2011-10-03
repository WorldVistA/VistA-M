PSARDCBA ;BIRM/MFR - Return Drug Batch - ListMan ;07/01/08
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**69,72**;10/24/97;Build 2
 ;References to DRUG file (#50) supported by IA #2095
 ;References to ORDER UNIT file (#51.5) supported by IA #1931
 ;
SB ; - Single Batch View/Process
 N PSAPHLOC,PSABATCH,DIC,Y,X,DA
 ;
 ; - Checking for security keys (PSARET, PSAMGR or PSORPH)
 I '$$CHKEY^PSARDCUT() Q
 ;
 ; - Pharmacy location selection
 S PSAPHLOC=+$$PHLOC^PSARDCUT() I 'PSAPHLOC Q
 ;
 ; - Batch selection
 K DIC,Y,X,DA,DTOUT,DUOUT
 S DIC="^PSD(58.35,"_PSAPHLOC_",""BAT"",",DIC(0)="AQEM",DIC("A")="Select BATCH NUMBER: "
 W ! D ^DIC I X=""!$D(DTOUT)!$D(DUOUT) Q
 S PSABATCH=+Y
 ;
 D EN(PSAPHLOC,PSABATCH)
 Q
 ;
EN(PSAPHLOC,PSABATCH) ; - ListManager entry point
 N PSACTMF,PSACTMFN,PSAREF,PSAQUIT
 ;
 D LOAD()
 W !,"Please wait..."
 D EN^VALM("PSA RETURN DRUG BATCH")
 D FULL^VALM1
 G EXIT
 ;
HDR ; - Header
 D LMHDR^PSARDCUT(PSAPHLOC,PSABATCH)
 D SETHDR()
 Q
 ;
SETHDR() ; - Displays the Header Line
 N HDR
 ;
 ; - Line 1
 S $E(HDR,48)="ORD",$E(HDR,52)="ORDER",$E(HDR,61)="DISP",$E(HDR,66)="DISP"
 S $E(HDR,72)="ACTUAL",$E(HDR,81)="" D INSTR^VALM1(IORVON_HDR_IOINORM,1,6)
 ; - Line 2
 S HDR="  #",$E(HDR,5)="RETURN DRUG (NDC)",$E(HDR,48)="QTY",$E(HDR,52)="UNIT"
 S $E(HDR,62)="QTY",$E(HDR,66)="UNIT",$E(HDR,72)="CREDIT($)"
 S $E(HDR,81)="" D INSTR^VALM1(IORVON_HDR_IOINORM,1,7)
 Q
 ;
INIT ; - Populates the Body section for ListMan
 K ^TMP("PSARDCSR",$J),^TMP("PSARDCBA",$J)
 ;
 S VALMCNT=0
 D SORT,SETLINE
 S VALMSG="Select the entry # to view or ?? for more actions"
 Q
 ;
SORT ; - Sets the line to be displayed in ListMan
 N ITEM,DRUGNAM
 ;
 S (ITEM,SEQ)=0
 F  S ITEM=$O(^PSD(58.35,PSAPHLOC,"BAT",PSABATCH,"ITM",ITEM)) Q:'ITEM  D
 . S DRUGNAM=$$GET1^DIQ(58.3511,ITEM_","_PSABATCH_","_PSAPHLOC,.01) I DRUGNAM="" Q
 . S ^TMP("PSARDCSR",$J,DRUGNAM,ITEM)=""
 Q
 ;
SETLINE ; - Sets the line to be displayed in ListMan
 N DRUGNAM,ITEM,LINE,SEQ,DATA,FLDS,DRUG,NDC,QTY,ORDUNT,DUQTY,DSPUNT,ACTCRD
 ;
 S DRUGNAM="",(ITEM,SEQ)=0
 F  S DRUGNAM=$O(^TMP("PSARDCSR",$J,DRUGNAM)) Q:DRUGNAM=""  D
 . F  S ITEM=$O(^TMP("PSARDCSR",$J,DRUGNAM,ITEM)) Q:'ITEM  D
 . . S SEQ=SEQ+1
 . . D GETS^DIQ(58.3511,ITEM_","_PSABATCH_","_PSAPHLOC_",","*","IE","FLDS")
 . . K DATA M DATA=FLDS(58.3511,ITEM_","_PSABATCH_","_PSAPHLOC_",")
 . . S DRUG=$E(DATA(.01,"E"),1,25),NDC=DATA(3,"E"),QTY=DATA(6,"E")
 . . S ORDUNT=DATA(5,"I") I ORDUNT S ORDUNT=$E($$GET1^DIQ(51.5,ORDUNT,.02),1,6)
 . . S DUQTY=DATA(17,"E"),DSPUNT=$E(DATA(8,"E"),1,6),ACTCRD=DATA(12,"I")
 . . ; - Display Line
 . . S LINE=$J(SEQ,3),$E(LINE,5)=DRUG_" ("_NDC_")",$E(LINE,46)=$J(QTY,5),$E(LINE,52)=ORDUNT
 . . S $E(LINE,59)=$J(DUQTY,6),$E(LINE,66)=DSPUNT,$E(LINE,72)=$J(ACTCRD,9,2)
 . . S ^TMP("PSARDCBA",$J,SEQ,0)=LINE,VALMCNT=VALMCNT+1
 . . S ^TMP("PSARDCBA",$J,SEQ,"ITEM")=ITEM
 . . S ^TMP("PSARDCBA",$J,SEQ,"DISP")=DRUG_" ("_NDC_") - Quantity: "_QTY_" ("_ORDUNT_")"
 ;
 I '$D(^TMP("PSARDCBA",$J)) D
 . S ^TMP("PSARDCBA",$J,6,0)="                      This batch contains no return items."
 . S VALMCNT=0
 Q
 ;
ADD ; - Add New Item action
 N PSAMORE,I,DIR,Y,PSAQUIT
 I '$$LKBAT(PSAPHLOC,PSABATCH) D  Q
 . S VALMSG="This batch is being edited by another user!",VALMBCK="R"
 ;
 I $$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1,"I")'="AP" D  Q
 . S VALMSG="Only AWAITING PICKUP batches can have items added!",VALMBCK="R" W $C(7)
 . D UNLKBAT(PSAPHLOC,PSABATCH)
 ;
 D FULL^VALM1 W !
 S PSAMORE=1,PSAQUIT=0,DIR("A")="Add another Item? ",DIR(0)="YA",DIR("B")="YES"
 F I=1:1 Q:'PSAMORE!PSAQUIT  D
 . D ITEM^PSARDCU1(PSAPHLOC,PSABATCH,,.PSAQUIT) Q:PSAQUIT
 . W ! D ^DIR S PSAMORE=+$G(Y) W !
 ;
 D INIT,UNLKBAT(PSAPHLOC,PSABATCH)
 S VALMBCK="R"
 Q
 ;
CAN ; - Cancel Batch action
 N DIR,DIRUT,DIROUT,ITEM,QTY,DRUG,PSACOMM
 ;
 I '$$LKBAT(PSAPHLOC,PSABATCH) D  Q
 . S VALMSG="This batch is being edited by another user!",VALMBCK="R"
 ;
 I $$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1,"I")="CA" D  Q
 . S VALMSG="Batch is already CANCELLED!",VALMBCK="R" W $C(7)
 . D UNLKBAT(PSAPHLOC,PSABATCH)
 ;
 I $$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1,"I")="CO"!($$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1,"I")="PU") D  Q
 . S VALMSG=$$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1)_" batches cannot be cancelled!",VALMBCK="R" W $C(7)
 . D UNLKBAT(PSAPHLOC,PSABATCH)
 ;
 D FULL^VALM1
 W ! S DIR(0)="FA^3:84",DIR("A")="COMMENTS: "
 D ^DIR I $D(DIRUT)!$D(DIROUT) S VALMBCK="R" D UNLKBAT(PSAPHLOC,PSABATCH) Q
 S PSACOMM=X
 ;
 ; - Confirm?
 W ! S DIR(0)="YA",DIR("B")="NO",DIR("A")="Cancel Batch? "
 D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y=0) S VALMBCK="R" D UNLKBAT(PSAPHLOC,PSABATCH) Q
 ;
 W !!,"Cancelling Batch..."
 S DA(1)=PSAPHLOC,DA=PSABATCH
 S DIE="^PSD(58.35,"_PSAPHLOC_",""BAT"","
 S DR="1///CA;6///"_$$NOW^XLFDT()_";7////"_DUZ_";8///^S X=PSACOMM"
 D ^DIE
 W "OK"
 ; - Cancel Comments / Update Drug Inventory
 S ITEM=0
 F  S ITEM=$O(^PSD(58.35,PSAPHLOC,"BAT",PSABATCH,"ITM",ITEM)) Q:'ITEM  D
 . D LOGACT^PSARDCUT(PSAPHLOC,PSABATCH,ITEM,"C","BATCH CANCELLED: "_PSACOMM)
 . I $$GET1^DIQ(58.3511,ITEM_","_PSABATCH_","_PSAPHLOC,14,"I") D
 . . S DRUG=$$GET1^DIQ(58.3511,ITEM_","_PSABATCH_","_PSAPHLOC,.01,"I")
 . . S QTY=+$$GET1^DIQ(58.3511,ITEM_","_PSABATCH_","_PSAPHLOC,17,"I")
 . . D UPDINV^PSARDCUT(PSAPHLOC,PSABATCH,ITEM,DRUG,QTY,1)
 D UNLKBAT(PSAPHLOC,PSABATCH) H 1
 Q
 ;
PKP ; - Pickup Batch action
 N DIR,DA,X,Y
 ;
 I '$O(^PSD(58.35,PSAPHLOC,"BAT",PSABATCH,"ITM",0)) D  Q
 . S VALMSG="There are no items to be picked up in this batch!",VALMBCK="R" W $C(7)
 . D UNLKBAT(PSAPHLOC,PSABATCH)
 ;
 I $$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1,"I")'="AP" D  Q
 . S VALMSG="Only AWAITING PICKUP batches can be picked up!",VALMBCK="R" W $C(7)
 . D UNLKBAT(PSAPHLOC,PSABATCH)
 ;
 I '$$LKBAT(PSAPHLOC,PSABATCH) D  Q
 . S VALMSG="This batch is being edited by another user!",VALMBCK="R"
 . D UNLKBAT(PSAPHLOC,PSABATCH)
 ;
 D FULL^VALM1
 D EDIT I $G(PSAQUIT) D UNLKBAT(PSAPHLOC,PSABATCH) Q
 ;
 W ! S DIR(0)="YA",DIR("B")="NO",DIR("A")="         Pick up Batch? "
 D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y=0) S VALMBCK="R" D UNLKBAT(PSAPHLOC,PSABATCH) Q
 ;
 S DIE="^PSD(58.35,"_PSAPHLOC_",""BAT"",",DA(1)=PSAPHLOC,DA=PSABATCH
 S DR="1////PU"_";2///^S X=$$NOW^XLFDT();4////^S X=PSACTMF;5////^S X=PSAREF"
 ;
 D ^DIE
 ;
 W ! S DIR(0)="YA",DIR("B")="YES",DIR("A")="Do you want to update credit for items? "
 D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y=0) S VALMBCK="R" D HDR,UNLKBAT(PSAPHLOC,PSABATCH) Q
 ;
 D CRE,UNLKBAT(PSAPHLOC,PSABATCH)
 S VALMBCK="R"
 Q
 ;
CRE ; - Update Credit action
 N TYPE,SEQS,ITEM,DIR,DIE,DR,DA,I,X,Y,DIRUT,DIROUT,OLDSTS,OLDACT,OLDEST,ITEMIEN
 ;
 I $$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1,"I")'="PU" D  Q
 . S VALMSG="Batch status must be PICKED UP to update credit!",VALMBCK="R" W $C(7)
 . D UNLKBAT(PSAPHLOC,PSABATCH)
 ;
 I '$$LKBAT(PSAPHLOC,PSABATCH) D  Q
 . S VALMSG="This batch is being edited by another user!",VALMBCK="R"
 ;
 D FULL^VALM1
 K DIR,DIRUT,DIROUT,X,Y
 S DIR(0)="S^E:ESTIMATED;A:ACTUAL;B:BOTH",DIR("A")="CREDIT TYPE",DIR("B")="A"
 D ^DIR I $D(DIRUT)!$D(DIROUT) S VALMBCK="R" D UNLKBAT(PSAPHLOC,PSABATCH) Q
 S TYPE=Y
 ;
 K DIR,Y,X,DIRUT,DIROUT
 S DIR(0)="L^1:"_VALMCNT,DIR("A")="ITEM(S)"
 S DIR("?",1)="Enter one, multiple or an interval of item(s)"
 S DIR("?",2)="(e.g., '1-3' for items 1, 2 and 3; '1,4,6' for"
 S DIR("?",3)=" items 1, 4 and 6)"
 S DIR("?",4)=""
 S DIR("?")="Enter ?? to see the complete list of items."
 S DIR("??")="^D LIST^PSARDCUT("_PSAPHLOC_","_PSABATCH_")"
 W ! D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y'>0) S VALMBCK="R" D UNLKBAT(PSAPHLOC,PSABATCH) Q
 S SEQS=Y
 ;
 K DA,DR
 S DIE="^PSD(58.35,"_PSAPHLOC_",""BAT"","_PSABATCH_",""ITM"","
 S DA(2)=PSAPHLOC,DA(1)=PSABATCH
 F I=1:1:$L(SEQS,",") S ITEM=$P(SEQS,",",I) Q:'ITEM  D
 . S (ITEMIEN,DA)=+^TMP("PSARDCBA",$J,ITEM,"ITEM")
 . S OLDEST=$$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),11,"I")
 . S OLDACT=$$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),12,"I")
 . W !!,"Item ",ITEM,": ",^TMP("PSARDCBA",$J,ITEM,"DISP")
 . S DR=$S(TYPE="E":11,TYPE="A":12,1:"11;12")
 . W ! D ^DIE S DR=""
 . I +OLDEST'=+$$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),11,"I") D
 . . D LOGACT(11,$$AMT(OLDEST),$$AMT($$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),11,"I")),ITEMIEN)
 . I +OLDACT'=+$$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),12,"I") D
 . . D LOGACT(12,$$AMT(OLDACT),$$AMT($$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),12,"I")),ITEMIEN)
 . S OLDSTS=$$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),10)
 . I $$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),12) D
 . . S DR="10////A" I OLDSTS'="ACTUAL" D LOGACT(10,OLDSTS,"ACTUAL",ITEMIEN)
 . E  I $$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),11) D
 . . S DR="10////E" I OLDSTS'="ESTIMATED" D LOGACT(10,OLDSTS,"ESTIMATED",ITEMIEN)
 . I '$$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),12),'$$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),11) D
 . . I $$GET1^DIQ(58.3511,DA_","_DA(1)_","_DA(2),10,"I")'="D",OLDSTS'="PENDING" D
 . . . S DR="10////P" D LOGACT(10,OLDSTS,"PENDING",ITEMIEN)
 . D ^DIE
 ;
 D HDR,INIT,UNLKBAT(PSAPHLOC,PSABATCH)
 S VALMBCK="R"
 Q
 ;
EDT ; - Edit Batch action
 N DIE,DR,DA,X,Y,DIR,DIRUT,DIROUT
 ;
 I '$$LKBAT(PSAPHLOC,PSABATCH) D  Q
 . S VALMSG="This batch is being edited by another user!",VALMBCK="R"
 ;
 I $$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1,"I")="CO"!($$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1,"I")="CA") D  Q
 . S VALMSG=$$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1)_" batches cannot be edited!",VALMBCK="R" W $C(7)
 . D UNLKBAT(PSAPHLOC,PSABATCH)
 ;
 S PSACTMF=$$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,4,"I")
 S PSACTMFN=$$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,4,"E")
 S PSAREF=$$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,5,"I")
 ;
 D FULL^VALM1
 D EDIT I $G(PSAQUIT) D UNLKBAT(PSAPHLOC,PSABATCH) Q
 ;
 W ! S DIR(0)="YA",DIR("B")="YES",DIR("A")="Save Batch? "
 D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y=0) S VALMBCK="R" D UNLKBAT(PSAPHLOC,PSABATCH) Q
 ;
 W !!,"Saving Batch..."
 S DIE="^PSD(58.35,"_PSAPHLOC_",""BAT"",",DA(1)=PSAPHLOC,DA=PSABATCH
 S DR="4////^S X=PSACTMF;5////^S X=$S(PSAREF="""":""@"",1:PSAREF)"
 ;
 D ^DIE
 W "OK"
 D HDR,UNLKBAT(PSAPHLOC,PSABATCH)
 S VALMBCK="R"
 Q
 ;
EDIT ; - Edit Batch action
 N DIE,DIC,DIR,DR,DA,X,Y
 ;
 S PSAQUIT=0 D FULL^VALM1 W !
 K DIC,Y,X
 S DIC="^PSD(58.36,",DIC(0)="QEAM",DIC("A")="     RETURN CONTRACTOR: "
 S DIC("S")="I $S($P($G(^(0)),""^"",2):$P($G(^(0)),""^"",2)>DT,1:1)!(Y=$G(PSACTMF))"
 I $G(PSACTMFN)'="" S DIC("B")=PSACTMFN
 I $G(DIC("B"))="" S DIC("B")=$P($$DEFCTMF^PSARDCUT(),"^",2) K:DIC("B")="" DIC("B")
 D ^DIC I X=""!$D(DTOUT)!$D(DUOUT) S VALMBCK="R" S PSAQUIT=1 Q
 S PSACTMF=+Y,PSACTMFN=$P(Y,"^",2)
 ;
 K DIR,DIRUT,DIROUT
 I $G(PSAREF)'="" S DIR("B")=PSAREF K:DIR("B")="" DIR("B")
 S DIR(0)="FAO^1:20",DIR("A")="RETURN CONTRACTOR REF#: "
 S DIR("?")="Enter the pickup reference number from this contractor/manufacturer for the batch."
 D ^DIR I X="@" S PSAREF="",VALMBCK="R" Q
 I X'="",$D(DIRUT)!$D(DIROUT) S VALMBCK="R" S PSAQUIT=1 Q
 S PSAREF=X
 ;
 Q
 ;
LKBAT(PHLOC,BATCH) ; - Locks the batch
 L +^PSD(58.35,PHLOC,"BAT",BATCH):+$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3)
 Q ($T)
 ;
UNLKBAT(PHLOC,BATCH) ; - Unlocks the batch
 L -^PSD(58.35,PHLOC,"BAT",BATCH)
 Q
 ;
COM ; - Complete Batch action
 N DIE,DA,DR,DIR,DIRUT,DIROUT,X,Y,ITM,Z
 ;
 I '$$LKBAT(PSAPHLOC,PSABATCH) D  Q
 . S VALMSG="This batch is being edited by another user!",VALMBCK="R"
 ;
 I $$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1,"I")="CO" D  Q
 . S VALMSG="Batch has already been completed!",VALMBCK="R" W $C(7)
 . D UNLKBAT(PSAPHLOC,PSABATCH)
 ;
 I $$GET1^DIQ(58.351,PSABATCH_","_PSAPHLOC,1,"I")'="PU" D  Q
 . S VALMSG="Only PICKED UP batches can be completed!",VALMBCK="R" W $C(7)
 . D UNLKBAT(PSAPHLOC,PSABATCH)
 ;
 D FULL^VALM1,CHKCRE(PSAPHLOC,PSABATCH)
 ;
 ; - Confirm
 W ! S DIR(0)="YA",DIR("B")="NO",DIR("A")="Complete Batch? "
 D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y=0) S VALMBCK="R" D UNLKBAT(PSAPHLOC,PSABATCH) Q
 ;
 W !!,"Completing Batch..."
 S DA(1)=PSAPHLOC,DA=PSABATCH
 S DIE="^PSD(58.35,"_PSAPHLOC_",""BAT"","
 S DR="1///CO;9///"_$$NOW^XLFDT()_";10////"_DUZ
 D ^DIE
 ;
 K DIE,DA,DR
 S DA(2)=PSAPHLOC,DA(1)=PSABATCH
 S ITM=0
 F  S ITM=$O(^PSD(58.35,PSAPHLOC,"BAT",PSABATCH,"ITM",ITM)) Q:'ITM  D
 . S Z=^PSD(58.35,PSAPHLOC,"BAT",PSABATCH,"ITM",ITM,0)
 . I '$P(Z,"^",13),$P(Z,"^",11)'="D" D
 . . D LOGACT(10,$$GET1^DIQ(58.3511,ITM_","_PSABATCH_","_PSAPHLOC,10),"DENIED",ITM)
 . . S DIE="^PSD(58.35,"_PSAPHLOC_",""BAT"","_PSABATCH_",""ITM"","
 . . S DA=ITM,DR="10////D" D ^DIE
 ;
 W "OK"
 ;
 D UNLKBAT(PSAPHLOC,PSABATCH) H 1
 Q
 ;
SEL ; - Select Item action
 N PSASEL,ITEM
 ;
 S PSASEL=+$P($P($G(Y(1)),"^",4),"=",2)
 I $G(PSASEL),'$G(^TMP("PSARDCBA",$J,PSASEL,"ITEM")) D  Q
 . S VALMSG="Invalid selection!",VALMBCK="R" W $C(7)
 ;
 I '$O(^PSD(58.35,PSAPHLOC,"BAT",PSABATCH,"ITM",0)) D  Q
 . S VALMSG="There are no items to be selected in this batch!",VALMBCK="R" W $C(7)
 ;
 I '$G(^TMP("PSARDCBA",$J,PSASEL,"ITEM")) D  I 'PSASEL S VALMBCK="R" Q
 . D FULL^VALM1
 . N DIR,Y,X,DIRUT,DIROUT
 . S DIR(0)="N^1:"_VALMCNT,DIR("A")="SELECT ITEM"
 . S DIR("?",1)="Enter the item number to be selected."
 . S DIR("?",2)=""
 . S DIR("?")="Enter ?? to see the complete list of items."
 . S DIR("??")="^D LIST^PSARDCUT("_PSAPHLOC_","_PSABATCH_")"
 . W ! D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y'>0) S VALMBCK="R" Q
 . S PSASEL=+Y
 ;
 S ITEM=+^TMP("PSARDCBA",$J,PSASEL,"ITEM")
 D  ;
 . N XQORM
 . D EN^PSARDCIT(PSAPHLOC,PSABATCH,ITEM),INIT
 ;
 S VALMBCK="R"
 Q
 ;
EXIT ;
 K ^TMP("PSARDCSR",$J),^TMP("PSARDCBA",$J)
 Q
 ;
HELP Q
 ;
LOAD() ; - Load Batch information
 N FLDS,DATA
 S (PSACTMF,PSACTMFN,PSAREF)=""
 ;
 K FLDS D GETS^DIQ(58.351,PSABATCH_","_PSAPHLOC_",","4;5","IE","FLDS")
 K DATA M DATA=FLDS(58.351,PSABATCH_","_PSAPHLOC_",")
 S PSACTMF=DATA(4,"I"),PSACTMFN=DATA(4,"E"),PSAREF=$G(DATA(5,"I"))
 Q
 ;
CHKCRE(PHLOC,BATCH) ; - Check if Actual Credit have been entered
 N ITM,DSPLN,NOCRED,XX,DIR,Y,X,DIRUT,Z,DRNAM,CNT
 S ITM=0
 F  S ITM=$O(^PSD(58.35,PHLOC,"BAT",BATCH,"ITM",ITM)) Q:'ITM  D
 . S Z=^PSD(58.35,PHLOC,"BAT",BATCH,"ITM",ITM,0)
 . I '$P(Z,"^",13),$P(Z,"^",11)'="D" D
 . . S DSPLN=$E($E($$GET1^DIQ(50,+Z,.01),1,24)_" ("_$P(Z,"^",4)_")",1,40)
 . . S $E(DSPLN,41)=$J($P(Z,"^",18),8),$E(DSPLN,50)=$P(Z,"^",9)
 . . S NOCRED($$GET1^DIQ(50,+Z,.01),ITM)=DSPLN
 ;
 I $D(NOCRED) D
 . W !!,"WARNING: The following items will have their CREDIT STATUS"
 . W !?9,"set to DENIED because no credit amount has been"
 . W !?9,"entered for them:",! S $P(XX,"-",60)=""
 . W !?9,XX,!?9,"RETURN DRUG (NDC)",?49,"DISP QTY",?58,"UNIT",!?9,XX,!
 . S CNT=0,DRNAM="" F  S DRNAM=$O(NOCRED(DRNAM)) Q:DRNAM=""  D  I $G(DIRUT) Q
 . . S ITM=0 F  S ITM=$O(NOCRED(DRNAM,ITM)) Q:'ITM  D  I $G(DIRUT) Q
 . . . S CNT=CNT+1 W ?9,NOCRED(DRNAM,ITM) I '(CNT#15) S DIR(0)="E" D ^DIR W $C(13) Q
 . . . W !
 ;
 Q
LOGACT(FIELD,OLDVALUE,NEWVALUE,ITEM) ; - Log an activity for the return item
 N COMM
 S COMM=$$GET1^DID(58.3511,FIELD,"","LABEL")_" "
 S COMM=COMM_$S(FIELD=10:"automatically ",1:"")_"changed from "_$S(OLDVALUE="":"''",1:OLDVALUE)_" to "_$S(NEWVALUE="":"''",1:NEWVALUE)_"."
 D LOGACT^PSARDCUT(PSAPHLOC,PSABATCH,ITEM,"E",COMM)
 Q
 ;
AMT(VAL) ; Returns the amount formatted
 I $G(VAL) Q $J(VAL,0,2)
 Q $G(VAL)
