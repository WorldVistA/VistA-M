RCDPEWL4 ;ALB/TMK/PJH - ELECTRONIC EOB WORKLIST ACTIONS ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,208,269,298,303,318,326,349,367**;Mar 20, 1995;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ; RCSCR variable must be defined for this routine
 Q
 ;
DISTADJ(RCFR,RCTO,RCAMT,RCCOM) ; Action that distributes an adjustment amount
 ; against another line item's payment
 ; Assumes RCSCR = ien of the entry in file 344.49
 ; RCFR = ien of entry in 344.491 that has a negative net
 ; RCTO = ien of entry in 344.491 that will be decremented
 ; RCAMT = the amount being adjusted (positive #)
 ; RCCOM = the comment to place on the decrease adjustment
 ;
 N RCFRX,RCREF,RCFR0,RCFR1,RCFR10,RCTO0,RCTO1,RCTO10,RCY
 N DA,DD,DIK,DR,DIC,DIE,DIK,DIR,DLAYGO,DO,NONVA,X,Y ; PRCA*4.5*326
 I $G(^TMP("RCBATCH_SELECTED",$J)) D NOBATCH^RCDPEWL Q
 S RCFR0=$G(^RCY(344.49,RCSCR,1,RCFR,0)),RCTO0=$G(^RCY(344.49,RCSCR,1,RCTO,0)),RCFRX=+$O(^RCY(344.49,RCSCR,1,"B",RCFR0\1,0)),RCFRX=$G(^RCY(344.49,RCSCR,1,RCFRX,0))
 S RCREF=$P($P(RCFRX,U,2),"**ADJ",2),RCREF=$S(RCREF="":"",RCREF=0:$P(RCFRX,U,9),1:$P($G(^RCY(344.4,RCSCR,2,+RCREF,0)),U))
 S RCFR1=+$O(^RCY(344.49,RCSCR,1,"B",RCFR0\1,0)),RCTO1=+$O(^RCY(344.49,RCSCR,1,"B",RCTO0\1,0))
 S RCFR10=$G(^RCY(344.49,RCSCR,1,RCFR1,0)),RCTO10=$G(^RCY(344.49,RCSCR,1,RCTO1,0))
 S RCFR0=$G(^RCY(344.49,RCSCR,1,RCFR,0)),RCTO0=$G(^RCY(344.49,RCSCR,1,RCTO,0))
 S DA(2)=RCSCR,DA(1)=RCFR
 S DIC("DR")=".02////1;.03////"_RCAMT_";.04////"_$S($P(RCTO0,U,2)'="":$P(RCTO0,U,2),RCREF'="":RCREF,1:"UNKNOWN")
 S DIC("DR")=DIC("DR")_";.05////0;.06////0;.09////RETRACTED FUNDS DEDUCTED FROM OTHER PAYMENT ON THIS ERA",DIC="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",1,"
 S DLAYGO=344.4911,DIC(0)="L",X=+$O(^RCY(344.49,RCSCR,1,RCFR,1,"B",""),-1)+1
 D FILE^DICN K DIC,DD,DO,DLAYGO
 S RCY=+Y
 I RCY'>0 D  Q
 . S DIR(0)="EA",DIR("A",1)="PROBLEM ADDING ADJUSTMENT - NO DISTRIBUTION PERFORMED",DIR("A")="PRESS RETURN TO CONTINUE " D ^DIR K DIR
 ;
 S DA(2)=RCSCR,DA(1)=RCTO
 ; BEGIN PRCA*4.5*326
 ; Check if the distribution is to a non-VA claim
 S NONVA=0 I $P($G(^RCY(344.49,RCSCR,1,RCTO1,0)),U,2)'["**ADJ",'$P(RCTO0,U,7) S NONVA=1
 S DIC("DR")=".02////0;.03////"_$J(-RCAMT,"",2)
 S DIC("DR")=DIC("DR")_";.04////"_$S($P(RCFR0,U,2)'="":$P(RCFR0,U,2),RCREF'="":RCREF,1:"UNKNOWN")
 ; If a non-VA distribution the background action is set none - comment is fixed text concatenated with PLB comment
 S DIC("DR")=DIC("DR")_";.05////"_$S(NONVA:0,$P($G(^RCY(344.49,RCSCR,1,RCTO1,0)),U,2)'["**ADJ":"1;.08////0",1:0)
 S DIC("DR")=DIC("DR")_";.06////0"_$S(RCCOM'="":";.09////"_RCCOM,1:"")
 ; END PRCA*4.5*326
 ; 
 S DIC="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",1,"
 S DLAYGO=344.4911,DIC(0)="L",X=+$O(^RCY(344.49,RCSCR,1,RCTO,1,"B",""),-1)+1
 D FILE^DICN K DIC,DD,DO,DLAYGO
 S RCY=+Y
 ;
 I RCY'>0 D  Q
 . N DA
 . S DA(2)=RCSCR,DA(1)=RCFR,DA=RCY,DIK="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",1," D ^DIK
 . S DIR(0)="EA",DIR("A",1)="PROBLEM ADDING ADJUSTMENT - NO DISTRIBUTION PERFORMED",DIR("A")="PRESS RETURN TO CONTINUE " D ^DIR K DIR
 ;
 S DA(1)=RCSCR,DA=RCFR,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".06////"_$J($P(RCFR0,U,6)+RCAMT,"",2)_";.08////"_$J($P(RCFR0,U,8)+RCAMT,"",2) D ^DIE
 S DA=RCFR1,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".06////"_$J($P(RCFR10,U,6)+RCAMT,"",2) D ^DIE
 S DA(1)=RCSCR,DA=RCTO,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".06////"_$J($P(RCTO0,U,6)-RCAMT,"",2)_";.03////"_$J($P(RCTO0,U,3)-RCAMT,"",2)_";.08////"_$J($P(RCTO0,U,8)-RCAMT,"",2) D ^DIE
 S DA(1)=RCSCR,DA=RCTO1,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".06////"_$J($P(RCTO10,U,6)-RCAMT,"",2)_";.03////"_$J($P(RCTO10,U,3)-RCAMT,"",2)_";.08////"_$J($P(RCTO10,U,8)-RCAMT,"",2) D ^DIE
 ;
 ; If the distribution is to a none-VA claim set the receipt line comment - this is picked up in DET^RCDPEM when the receipt is created
 I NONVA S DA(1)=RCSCR,DA=RCTO,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".1///"_RCCOM D ^DIE ; PRCA*4.5*326
 D BLD^RCDPEWL1($G(^TMP($J,"RC_SORTPARM")))
 Q
 ;
NEWREC ; Create a new receipt from scratch pad entry
 N CT,DA,DIC,DIE,DIR,DR,RCDEP,RCER,RCHAC,RCOK,RCPAYTY,RCRECTDA,RCSTOP,RECTDA,X,Y,Z,Z0  ; PRCA*4.5*367
 D FULL^VALM1
 I $G(RCSCR("NOEDIT"))=2 D NOTAV^RCDPEWL2 G NEWRECQ
 S (RCSTOP,RCOK)=0,VALMBCK="R"
 S RECTDA=$P($G(^RCY(344.49,RCSCR,0)),U,2)
 I 'RECTDA S RECTDA=$P($G(^RCY(344.4,RCSCR,0)),U,8)
 ; PRCA*4.5*303 - Corrected receipt number display to use RECTDA in the DIR("A",1) variable
 I RECTDA D  G NEWRECQ
 . S DIR(0)="EA",DIR("A",1)="THIS ERA ALREADY HAS A RECEIPT - "_$P($G(^RCY(344,RECTDA,0)),U)_" - NO RECEIPT CREATED",DIR("A")="PRESS RETURN TO CONTINUE" W ! D ^DIR K DIR
 S DIR("A",1)="THIS ACTION WILL CREATE THE RECEIPT FOR THIS ERA.  ONCE THE RECEIPT IS",DIR("A",2)=" CREATED HERE, NO MORE AUTOMATIC ADJUSTMENTS MAY BE MADE FOR THIS ERA.",DIR("A",3)=" "
 S DIR("A")="ARE YOU SURE YOU ARE READY TO CREATE THIS RECEIPT?: ",DIR("B")="NO",DIR(0)="YA"
 W ! D ^DIR K DIR W !
 I Y'=1 S DIR(0)="EA",DIR("A")="NO RECEIPT CREATED - PRESS RETURN TO CONTINUE" W ! D ^DIR K DIR G NEWRECQ
 I $$HASADJ^RCDPEWL8(RCSCR,.RCOK) D  G NEWRECQ
 . S DIR(0)="EA",DIR("A",1)="AT LEAST ONE LINE ITEM WAS FOUND WITH A NEGATIVE PAYMENT AMOUNT",DIR("A")="NO RECEIPT CAN BE CREATED - PRESS RETURN TO CONTINUE " D ^DIR K DIR S RCSTOP=1
 I 'RCOK S DIR(0)="EA",DIR("A")="NO RECEIPT CAN BE CREATED - NO POSTABLE LINE ITEMS WERE FOUND" W ! D ^DIR K DIR G NEWRECQ
 ;
 S RCHAC=$$HACERA^RCDPEU(RCSCR)
 S RCPAYTY=$S(RCHAC:17,$P($G(^RCY(344.4,+RCSCR,5)),U,2)="":14,1:4) ; PRCA*4.5*367 - Use CHAMPVA receipt type for CHAMPVA payments
 S RCDEP=""
 I RCPAYTY=4 D
 . N RCOK1
 . F  D  Q:RCOK1
 .. S RCOK1=1
 .. S DIC="^RCY(344.1,",DIC("S")="I $P(^(0),U,12)=1",DIC(0)="AEMQ" D ^DIC
 .. Q:Y'>0
 .. S RCDEP=+Y
 .. I RCDEP,$$TOOOLD^RCDPEWLA(RCDEP) S RCOK1=0,RCDEP=""
 S RECTDA=$$BLDRCPT^RCDPUREC(DT,+RCDEP_$S(RCPAYTY=4:"ERACHK",1:""),+$O(^RC(341.1,"AC",+RCPAYTY,0))) ; Note:ERA with paper check is type 4, but receipt needs to start with an 'E'
 I 'RECTDA W ! S DIR(0)="EA",DIR("A",1)="A PROBLEM WAS ENCOUNTERED ADDING THE RECEIPT - NO RECEIPT ADDED",DIR("A")="PRESS RETURN TO CONTINUE" W ! D ^DIR K DIR G NEWRECQ
 ;
 D RCPTDET^RCDPEM(RCSCR,RECTDA,.RCER)
 ;PRCA*4.5*367 - Calculate Receipt Total for CHAMPVA Receipts
 I RCHAC D
 . N RCFDA,RCPTOT,I
 . S (RCPTOT,I)=0
 . F  S I=$O(^RCY(344.49,RCSCR,1,I)) Q:'I  D
 .. Q:$P(^RCY(344.49,RCSCR,1,I,0),U)'["."
 .. S RCPTOT=RCPTOT+$P(^RCY(344.49,RCSCR,1,I,0),U,3)
 . S RCFDA(344,RECTDA_",",.22)=RCPTOT
 . D FILE^DIE(,"RCFDA")
 ;
 S DIE="^RCY(344.49,",DA=RCSCR,DR=".02////"_RECTDA D ^DIE
 S DIE="^RCY(344.4,",DA=RCSCR,DR=".08////"_RECTDA D ^DIE
 S Z=+$O(^RCY(344.31,"AERA",RCSCR,0))
 S DIE="^RCY(344,",DA=RECTDA,DR=".18////"_RCSCR_$S(Z:";.17////"_Z,1:"")_$S(RCPAYTY=4:";.06////"_RCDEP,1:"")_$S($P($G(^RCY(344.31,Z,0)),U,15)'="":";.16////"_$P(^RCY(344.31,Z,0),U,15),1:"") D ^DIE
 ;
 I $O(RCER(0)) D
 . S CT=1,DIR(0)="EA",DIR("A",1)="THE FOLLOWING PROBLEMS OCCURRED WHILE ADDING THE RECEIPT: "
 . S Z=0 F  S Z=$O(RCER(Z)) Q:'Z  S CT=CT+1,DIR("A",CT)=RCER(Z)
 . S DIR("A")="PRESS RETURN TO CONTINUE "
 . W ! D ^DIR K DIR
 ;
 S DIR(0)="YA",DIR("A")="DO YOU WANT TO GO TO RECEIPT PROCESSING NOW? ",DIR("A",1)=" ",DIR("A",2)="RECEIPT "_$P($G(^RCY(344,+RECTDA,0)),U)_" HAS BEEN CREATED FOR THIS ERA",DIR("B")="YES" W ! D ^DIR K DIR
 I Y=1 S RCRECTDA=RECTDA D EN^VALM("RCDP RECEIPT PROFILE")
 S RCSCR=0
 S VALMBCK="Q"
 ;
NEWRECQ Q
 ;
VRECPT ;EP - Protocol action - RCDPE EOB WL RECEIPT VIEW
 ; Preview receipt lines
 ; Assume RCSCR = ien from file 344.49 (and 344.4)
 N DIR,RCOK,RCZ,X,Y,Z,Z0
 D FULL^VALM1
 S VALMBCK="R"
 I $S($P($G(^RCY(344.4,RCSCR,4)),U,2)]"":1,1:0) D VR^RCDPEWLP(RCSCR) G VRECPTQ   ; prca*4.5*298  auto-posted ERAs are handled differently
 ;
 ;
 ; prca*4.5*298  per patch requirements, keep code related to creating/maintaining
 ; batches but just remove from execution.
 ; I $G(^TMP("RCBATCH_SELECTED",$J)) D NOBATCH^RCDPEWL Q
 ;I $O(^RCY(344.49,RCSCR,3,0)) D  Q:'RCOK
 ;. S RCOK=1
 ;. S Z=0 F  S Z=$O(^RCY(344.49,RCSCR,3,Z)) Q:'Z  I '$P($G(^(Z,0)),U,3) S RCOK=0 Q
 ;. I 'RCOK S DIR(0)="EA",DIR("A",1)="A RECEIPT CANNOT BE PREVIEWED UNTIL ALL BATCHES FOR THIS ERA ARE MARKED AS",DIR("A",2)="'READY TO POST'",DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR
 ; end of prca*4.5*298
 S Z=0 F  S Z=$O(^RCY(344.49,RCSCR,1,Z)) Q:'Z  I $P(Z,".",2) S Z0=$G(^(Z,0)) I $P(Z0,U,6)<0 S RCZ($P(Z0,U))=$P(Z0,U,2)_U_$P(Z0,U,6)
 I $O(RCZ(""))'="" D
 . W !,"THE FOLLOWING LINES HAVE A NET PAYMENT LESS THAN 0.  THESE LINES MUST HAVE",!,"THIS NEGATIVE AMOUNT DISTRIBUTED TO OTHER LINE(S) IN THE ERA BEFORE A",!,"RECEIPT CAN BE CREATED."
 . S Z="" F  S Z=$O(RCZ(Z)) Q:Z=""  W !,$J("",5)_$J(Z,10)_"  "_$E($P(RCZ(Z),U)_$J("",15),1,15)_"  "_$J(+$P(RCZ(Z),U,2),"",2)
 . W !
 . S DIR(0)="E" D ^DIR K DIR
 ;
 I '$D(^XUSEC("RCDPEPP",DUZ)) D  Q          ; PRCA*4.5*349 - Added AM worklist preview
 . D EN^VALM("RCDPE EOB RECEIPT PREVIEW AM"),VRECPTQ
 D EN^VALM("RCDPE EOB RECEIPT PREVIEW")
VRECPTQ ;
 S VALMBCK=$S('$G(RCSCR):"Q",1:"R")
 Q
 ;
 ; PRCA*4.5*303 - Receipt Processing 
RECPROC ;EP - Protocol action -  RCDPE EON WORKLIST RECEIPT PROCESSING
 ; Receipt Processing
 ; Called by RCDPE EOB WORKLIST RECEIPT PROCESSING protocol
 ; Assume RCSCR is the IEN from file 344.49 (and 344.4)
 ; Variable RCRECTDA is needed by RECEIPT PROFILE so is not newed
 ; Variable RCDPFXIT is used by RCDPLPLM for immediate exit so newed it here so that does not happen
 ;
 N ARRAY,RECIEN,RECEIPT,CNT,DIR,X,Y,DTOUT,DUOUT,DROUT,DIRUT,I,LIST,RCDPFXIT
 D FULL^VALM1
 S VALMBCK="R"
 I '$D(^XUSEC("RCDPEPP",DUZ)) D  Q  ; PRCA*4.5*318 Added security key check
 . W !!,"This action can only be taken by users that have the RCDPEPP security key.",!
 . D PAUSE^VALM1
 ;
 ; Get list of receipts from the ERA detail multiple
 S RECIEN=0,CNT=0
 F  S RECIEN=$O(^RCY(344.4,RCSCR,1,"RECEIPT",RECIEN)) Q:'RECIEN  D
 . S RECEIPT=$P($G(^RCY(344,RECIEN,0)),U)
 . I RECEIPT]"" S CNT=CNT+1,ARRAY(CNT)=RECEIPT_"^"_RECIEN
 ;
 ; The array of receipts does not exist, this could be a non auto-posted ERA; so only 1 receipt will be assigned; retrieve at 344.4, .08
 I '$D(ARRAY),$$GET1^DIQ(344.4,RCSCR_",",.08)'="" S CNT=1,ARRAY(1)=$$GET1^DIQ(344.4,RCSCR_",",.08,"E")_"^"_$$GET1^DIQ(344.4,RCSCR_",",.08,"I")
 ;
 ; No receipt - display mesage and quit
 I CNT=0 K DIR S DIR("A",1)="No receipts exist for this ERA." G RECPROCQ
 ;
 ; One receipt - Use it
 I CNT=1 S RCRECTDA=$P(ARRAY(1),U,2) G RECPROC1
 ;
 ; Multiple receipts - User needs to select
 W !
 S LIST=""
 F I=1:1:CNT S LIST=LIST_$S(LIST]"":";",1:"")_I_":"_$P(ARRAY(I),U,1)
 S DIR(0)="SO^"_LIST,DIR("A")="Select Receipt"
 D ^DIR
 I Y<1!(Y>CNT) K DIR S DIR("A",1)="No selection made" G RECPROCQ
 S RCRECTDA=$P(ARRAY(Y),U,2)
RECPROC1 ;
 D EN^VALM("RCDP RECEIPT PROFILE")
 ; If RCDPFXIT is set, exit option entirely was selected so quit back to the menu
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
RECPROCQ ;
 ; Display the message in DIR("A",1) and then press enter
 S DIR(0)="EA",DIR("A")="Press ENTER to continue: "
 W ! D ^DIR K DIR
 Q
