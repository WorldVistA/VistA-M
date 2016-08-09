RCDPEM2 ;ALB/TMK/PJH - MANUAL ERA AND EFT MATCHING ;Jun 11, 2014@13:24:36
 ;;4.5;Accounts Receivable;**173,208,276,284,293,298,303,304**;Mar 20, 1995;Build 104
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; PRCA*4.5*303 - Manually Match EFT from Worklist screen
MATCHWL ; Manually 'match' ERA to an EFT that originates from [RCDPE WORKLIST ERA LIST]
 N DA,DIC,DIE,DIR,DR,DTRNG,DTOUT,DUOUT,END,RCEFT,RCERA,RCMBG,RCMATCH,RCNAME,RCQUIT,START,X,Y
 D FULL^VALM1
 ;
 ; PRCA*4.5*303 moved code out because this routine grew too large
 I $$ML0^RCDPRU() G MWQ ; if true then quit, othewise continue
 ;
ML1 ; Select EFT to Match to this ERA
 S DIR("A")="SELECT THE UNMATCHED EFT TO MATCH TO AN ERA: "
 ;
 ; See comment in Tag M1 for PRCA*4.5*293.
 S DIR(0)="PAO^RCY(344.31,:AEMQ",DIR("S")="I ('$P(^(0),U,8))&($P($G(^(0)),U,7))&('$P($G(^(3)),U))"
 I $G(DTRNG) S DIR("S")=DIR("S")_"&'($P($G(^(0)),U,13)<START)&'($P($G(^(0)),U,13)>END)"
 ; ** end PRCA*4.5*293
 ;
 W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y<0) G MWQ
 S RCEFT=+Y,RCEFT(0)=$G(^RCY(344.31,+Y,0))
 W !
 S DIC="^RCY(344.31,",DR="0",DA=RCEFT D EN^DIQ
 W !
 S DIR("A")="ARE YOU SURE THIS IS THE EFT YOU WANT TO MATCH?: ",DIR(0)="YA",DIR("B")="YES" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G MWQ
 I Y'=1 G ML1
 ;
 D M12A ; Go to the Manual match, we have the ERA and EFT
 ;
MWQ ; Quit back to the worklist VALMBCK will be killed by List Manager.
 D INIT^RCDPEWL7 ; Rebuild the screen because we may have changed it.
 S VALMBCK="R",VALMBG=RCMBG
 Q
 ;
MATCH1 ; Manually 'match' an ERA to an EFT
 N DA,DIC,DIE,DIR,DR,DTRNG,DTOUT,DUOUT,END,RCEFT,RCERA,RCMATCH,RCNAME,RCQUIT,START,X,Y,RCMTFLG
 W !,"THIS OPTION WILL ALLOW YOU TO MANUALLY MATCH AN EFT DETAIL RECORD",!,"WITH AN ERA RECORD."
 ; PRCA*4.5*298 - Add ability to specify a date range
 S DIR("A")="Select by date Range? (Y/N) ",DIR(0)="YA",DIR("B")="NO" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G M1Q
 I Y<1 G M1
 S DTRNG=Y  ; flag indicating date range selected
 K DIR S DIR("?")="Enter the earliest date for the selection range."
 ; value in DIR(0) for %DT = APE: ask date, past assumed, echo answer
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start Date: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G M1Q
 S START=Y K DIR,X,Y
 S DIR("?")="Enter the latest date for the selection range."
 S DIR(0)="DAO^"_START_":"_DT_":APE",DIR("A")="End Date: ",DIR("B")=$$FMTE^XLFDT(DT)
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G M1Q
 S END=Y
 ;
M1 ; come here if no date range slection 
 S DIR("A")="SELECT THE UNMATCHED EFT TO MATCH TO AN ERA: "
 ;
 ; ** start PRCA*4.5*293 Add extra checks to filter out EFTs that have 
 ;      a payment amount of zero or EFTs that have been removed.
 ;      Only UNMATCHED EFTs with payment amt >0 and not removed should
 ;      be selectable by the user.
 ;
 S DIR(0)="PAO^RCY(344.31,:AEMQ",DIR("S")="I ('$P(^(0),U,8))&($P($G(^(0)),U,7))&('$P($G(^(3)),U))"
 I $G(DTRNG) S DIR("S")=DIR("S")_"&'($P($G(^(0)),U,13)<START)&'($P($G(^(0)),U,13)>END)"
 ; ** end PRCA*4.5*293
 ;
 W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y<0) G M1Q
 S RCEFT=+Y,RCEFT(0)=$G(^RCY(344.31,+Y,0))
 W !
 S DIC="^RCY(344.31,",DR="0",DA=RCEFT D EN^DIQ
 W !
 S DIR("A")="ARE YOU SURE THIS IS THE EFT YOU WANT TO MATCH?: ",DIR(0)="YA",DIR("B")="YES" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G M1Q
 I Y'=1 G M1
M12 S DIR("A")="SELECT THE UNMATCHED ERA TO MATCH TO EFT #"_RCEFT_": "
 S DIR(0)="PAO^RCY(344.4,:AEMQ",DIR("S")="I '$P(^(0),U,9),'$P(^(0),U,8)"
 W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y<0) G M1Q
 S RCERA=+Y,RCERA(0)=$G(^RCY(344.4,+Y,0))
 W !
 S DIC="^RCY(344.4,",DR="0",DA=RCERA D EN^DIQ
 W !
 S DIR("A")="ARE YOU SURE THIS IS THE CORRECT ERA TO MATCH TO?: ",DIR(0)="YA",DIR("B")="YES" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G M1Q
 I Y'=1 G M12
 ;
M12A ; PRCA*4.5*303 - MATCH WL jumps here to complete the manual match
 S RCMATCH=(+$P(RCERA(0),U,5)=+$P(RCEFT(0),U,7))
 S RCNAME=($P(RCERA(0),U,6)=$P(RCEFT(0),U,2))
 I 'RCMATCH!'RCNAME D  G:RCQUIT M1Q
 . N Z
 . S RCQUIT=0,Z=1
 . S DIR("A",1)="***WARNING***"
 . I 'RCNAME S Z=Z+1,DIR("A",Z)=$J("",3)_"> The payer names on these two records do not agree"
 . I 'RCMATCH S Z=Z+1,DIR("A",Z)=$J("",3)_"> The amount of payment on these two records do not agree"
 . S DIR(0)="YA",DIR("B")="NO",DIR("A")="ARE YOU SURE YOU WANT TO MATCH THESE 2 RECORDS?: " W ! D ^DIR K DIR
 . I $S($D(DUOUT)!$D(DTOUT):1,Y'=1:1,1:0) S RCQUIT=1 Q
 S DIE="^RCY(344.4,",DR=".09////1",DA=RCERA D ^DIE
 I '$D(Y) S DIE="^RCY(344.31,",DR=".08////1;.1////"_RCERA,DA=RCEFT D ^DIE
 S RCMTFLG=$S('$D(Y):1,1:0)
 W !,"EFT #"_RCEFT_" WAS "_$S(RCMTFLG:"SUCCESSFULLY",1:"NOT")_" MATCHED TO ERA #"_RCERA
 I 'RCMTFLG S DIR(0)="E" D ^DIR K DIR G M1Q
 ;PRCA*4.5*304 add ability to use auto-posting for a manually matched item
 ;  Only if the amount of payments match.
 I 'RCMATCH D  G M1Q    ;if payment amounts don't match, don't allow for auto-posting.
 . W !,"ERA/EFT balances do not match - cannot Mark for Auto-Post. Press any key." S DIR(0)="E" D ^DIR K DIR
 W !
 K DIR
 S DIR("A")="Do you wish to mark this entry for Auto Posting (Y/N)? "
 S DIR(0)="YA"
 D ^DIR
 I 'Y K DIR S DIR(0)="E" D ^DIR G M1Q
 N AUTOPOST
 S AUTOPOST=$$AUTOCHK2^RCDPEAP1(RCERA)
 I AUTOPOST D
 . D SETSTA^RCDPEAP(RCERA,0,"Manual Match: Marked as Auto-Post Candidate")
 . W !,"ERA has been successfully Marked as an Auto-Post CANDIDATE"
 I 'AUTOPOST D
 . D AUDITLOG^RCDPEAP(RCERA,"","Manual Match: Not Marked as Auto-Post Candidate-"_$P(AUTOPOST,U,2))
 . W !,"ERA was NOT Marked as an Auto-Post CANDIDATE - ",$P(AUTOPOST,U,2)
 K DIR S DIR(0)="E" D ^DIR
M1Q Q
 ;
MATCH2 ; Manually 'match' a 0-balance EFT to a paper EOB
 N DUOUT,DTOUT,DA,DR,DIE,DIC,DIR,X,Y,RCEFT,RCRCPT
 W !,"THIS OPTION WILL ALLOW YOU TO MANUALLY MARK A 0-BALANCE EFT DETAIL RECORD",!,"AS MATCHED TO A PAPER EOB"
M2 S DIR("A")="SELECT THE UNMATCHED 0-BALANCE EFT TO MARK AS MATCHED TO PAPER EOB: "
 S DIR(0)="PAO^RCY(344.31,:AEMQ",DIR("S")="I '$P(^(0),U,8),'$P(^(0),U,7)"
 W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y'>0) G M2Q
 S RCEFT=+Y
 W !
 S DIC="^RCY(344.31,",DR="0",DA=RCEFT D EN^DIQ
 W !
 S DIR("A")="ARE YOU SURE THIS IS THE EFT YOU WANT TO MARK AS MATCHED?: ",DIR(0)="YA",DIR("B")="YES" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G M2Q
 I Y'=1 G M2
 S DIE="^RCY(344.31,",DR=".08////2",DA=RCEFT D ^DIE
 S DIR(0)="EA",DIR("A")="EFT #"_RCEFT_" WAS "_$S('$D(Y):"SUCCESSFULLY",1:"NOT")_" MARKED AS MATCHED TO PAPER EOB" D ^DIR K DIR
M2Q Q
 ;
MANTR ; Mark an EFT detail record as 'TR' posted manually
 N DA,DR,DIC,DIE,DIR,X,Y,RCEFT,DUOUT,DTOUT,RCZ0,RCTR,RCHOW
 ; EFT detail cannot be associated with a receipt or TR document
 ;
 W !,"*****",!," YOU SHOULD ONLY USE THIS OPTION IF YOU HAVE AN EFT DETAIL RECORD ON YOUR",!," UNAPPLIED DEPOSIT REPORT WHOSE DETAIL WAS ENTERED ON LINE VIA A TR DOCUMENT",!,"*****",!
 S DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,16)="""",$P(^(0),U,11)",DIC("A")="SELECT THE EFT DETAIL WHOSE 'TR' DOC WAS MANUALLY ENTERED ON LINE: ",DIC="^RCY(344.31,"
 W ! D ^DIC K DIC
 I Y'>0 G MANTRQ
 S RCEFT=+Y,RCZ0=$G(^RCY(344.31,RCEFT,0))
 S DIR(0)="FA^2:30^K:X'?1""TR"".E X",DIR("A")="ENTER THE TR DOC # THAT WAS ENTERED ON-LINE FOR THE EFT DETAIL: "
 W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G MANTRQ
 S RCTR=Y,DR=""
 ;
 I '$P(RCZ0,U,8) D  G:RCQUIT MANTRQ  ;Unmatched
 . S DIR(0)="SA^E:ELECTRONIC ERA;P:PAPER EOB",DIR("A")="WAS THE EFT DETAIL RECEIVED BY (E)RA or (P)APER EOB?: " W ! D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 . S RCHOW=Y,DR=""
 . I RCHOW="E" D
 .. S DR=";.09R;.08////1"
 . I RCHOW="P" D
 .. S DR=";.08////2"
 ;
 S DIR(0)="YA",DIR("B")="NO",DIR("A",1)="THIS WILL MARK EFT DETAIL #: "_RCEFT_" AS MANUALLY POSTED",DIR("A",2)="  USING TR DOC: "_RCTR
 S DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE?: " W ! D ^DIR K DIR
 I Y'=1 D  G MANTRQ
 . S DIR(0)="EA",DIR("A")="EFT NOT UPDATED - Press ENTER to continue: " W ! D ^DIR K DIR
 S DIE="^RCY(344.31,",DA=RCEFT,DR=".16R"_DR D ^DIE
 I $D(Y) D
 . S DIE="^RCY(344.31,",DA=RCEFT,DR=".16///@;.08///"_$S($P(RCZ0,U,8)'="":$P(RCZ0,U,8),1:"@") D ^DIE
 . S DIR("A")="EFT NOT UPDATED - Press ENTER to continue: "
 E  D
 . S DIR("A")="STATUS UPDATED FOR EFT DETAIL #: "_RCEFT_" - Press ENTER to continue: "
 S DIR(0)="EA"
 W ! D ^DIR K DIR
 ;
MANTRQ Q
 ;
CHK() ; Function returns the ien of CHECK/MO payment type
 Q +$O(^RC(341.1,"AC",4,0))
 ;
 ;; Begin PRCA*4.5*276 - PJH
POSTED ;
 N DIR,X,Y
 S DIR("A")="Select type of receipt to ERA link"
 S DIR("B")="M"
 S DIR(0)="S^M:Manually select receipt to post;"
 S DIR(0)=DIR(0)_"A:Automatic search for receipt to post"
 D ^DIR K DIR
 I Y="M" D MANUAL Q
 I Y="A" D AUTO
 Q
 ;
MANUAL ; Mark an ERA as posted when the data was previously posted using
 ; paper EOB information
 N DIC,DIE,DIR,DA,DR,ERA,RCPT,X,Y,%
 ; Must be unmatched or matched to paper check, must be accepted by FMS, must not be posted yet
 W !!,"THIS OPTION IS USED WHEN YOU HAVE POSTED AN ERA PAID WITH A PAPER CHECK",!,"BY USING THE PAPER EOB AND YOU DID NOT REFERENCE THE ERA IN THE RECEIPT",!!
MAN1 S DIC("S")="I ""02""[+$P(^(0),U,9),$P(^(0),U,14)=0",DIC="^RCY(344.4,",DIC(0)="AEMQ"
 D ^DIC K DIC
 ;
 I Y'>0 G MANUALQ
 ;
 ;Check if ERA is already linked to a receipt
 I $$RCHECK(+Y) G MAN1
 S ERA=+Y
 ;
 S DIC="^RCY(344,",DIC(0)="AEMQ",DIC("A")="RECEIPT: ",DIC("S")="I $$FMS^RCDPEM2(Y,0)"
 D ^DIC K DIC
 I Y'>0 G MANUALQ
 S RCPT=+Y
 ;
 D NOW^%DTC
 ;Update Receipt #, EFT Match Status, Detail Post Status and Paper EOB
 S DIE="^RCY(344.4,",DR=".08////"_RCPT_";.09////2;.14////2;20.03////1",DA=ERA
 ;Update Date/Time Posted and User fields
 S DR=DR_";7.01///"_%_";7.02///"_DUZ
 D ^DIE
 I '$D(Y) D
 . S DIR(0)="EA",DIR("A",1)="ERA HAS BEEN MARKED AS POSTED USING PAPER EOB",DIR("A")="Press ENTER to continue: " D ^DIR K DIR
 ;
MANUALQ Q
 ;
 ;VISN 15 software - created by Karen Flores
 ;
AUTO ;Select ERA's for linking to receipt
 N EXIT
 S EXIT=0 F  D LNKERA Q:EXIT
 Q
 ;
RCHECK(RCSCR) ;Check if already linked to a receipt
 N REC,RNUM,RNAM,AMT
 S REC=$G(^RCY(344.4,RCSCR,0)),RNUM=$P(REC,U,8)
 ;Ignore check if zero amount ERA
 Q:'$P(REC,U,5) 0
 ;Check if already linked to a different receipt
 Q:'RNUM 0
 S RNAM=$P($G(^RCY(344,RNUM,0)),U)
 W !!,"ERA ",RCSCR," is already linked to receipt ",RNAM,!
 Q 1
 ;
LNKERA ;Select ERA
 N ABORT,DIC,DUOUT,DTOUT,REC,RCSCR,X,Y
 ;Must be unposted and either unmatched or matched to paper check
 S DIC("S")="I ""02""[+$P(^(0),U,9),$P(^(0),U,14)=0"
 S DIC="^RCY(344.4,",DIC(0)="AEMQ" W ! D ^DIC K DIC
 S RCSCR=+Y I RCSCR'>0 S EXIT=1 Q
 ;Check if already linked to a different receipt
 Q:$$RCHECK(RCSCR)
 ;
 ;Finds receipt automatically from AR TRANSACTION file #433 
 N AMT,ART,ARTND1,ATTY,BILL,EOB,EOBND,FOUND,RCND,RCSCR1,RECEPT,TAMT
 N TRACE
 ;Trace# from ERA
 S TRACE=$P($G(^RCY(344.4,RCSCR,0)),U,2)
 ;Clear workfile
 K ^TMP("RCDPEM2",$J)
 ;
 S (FOUND,ABORT,RCSCR1)=0
 ;Scan claim lines in ERA for non zero bills
 F  S RCSCR1=$O(^RCY(344.4,RCSCR,1,RCSCR1)) Q:+RCSCR1=0!(FOUND)  D
 .S RCND=$G(^RCY(344.4,RCSCR,1,RCSCR1,0))
 .;Ignore bill if AMOUNT PAID is zero
 .S AMT=$P(RCND,"^",3) Q:+AMT=0
 .;Ignore if EOB has no EOB detail record
 .S EOB=+$P(RCND,"^",2) Q:'EOB
 .;Get EOB detail record
 .S EOBND=$G(^IBM(361.1,EOB,0))
 .;Extract Bill number from EOB detail
 .S BILL=$P(EOBND,"^",1) Q:BILL=""
 .;Ignore duplicate bills on ERA
 .Q:$D(^TMP("RCDPEM2",$J,BILL))
 .S ^TMP("RCDPEM2",$J,BILL)=""
 .;Search AR TRANSACTION file #433 for the bill - newest first
 .S ART=""
 .F  S ART=$O(^PRCA(433,"C",BILL,ART),-1) Q:+ART=0!(FOUND)  D
 ..S ARTND1=$G(^PRCA(433,ART,1))
 ..;Get transaction type
 ..S ATTY=$P(ARTND1,"^",2) Q:'ATTY
 ..;Ignore if not a payment
 ..S ATTY=$P($G(^PRCA(430.3,ATTY,0)),"^",1) Q:ATTY'["PAYMENT"
 ..;Get receipt number
 ..S RECEPT=$P(ARTND1,"^",3) Q:RECEPT=""
 ..;Ignore receipt if status is not 'ACCEPTED BY FMS'
 ..Q:'$$FMS(RECEPT,1)
 ..W !!,"PATIENT: "_$$PNM4^RCDPEWL1(RCSCR,RCSCR1)
 ..W !,"Bill number: ",$P($G(^DGCR(399,BILL,0)),U)
 ..W !,"Check #: ",$$CHQ(RECEPT,BILL)
 ..W !,"Trace #: ",TRACE
 ..W !,"DOS: ",$$FMTE^XLFDT($P($G(^DGCR(399,BILL,0)),U,3))
 ..S TAMT=+$P(ARTND1,"^",5)
 ..W !,"AR Transaction amount: ",TAMT
 ..W !,"RECEIPT#: ",RECEPT
 ..W !,"Date of Receipt: ",$$FMTE^XLFDT($$RCDATE^RCDPRU(RECEPT))
 ..W !,"Total Receipt AMOUNT: ",$J($$AMT^RCDPRU(RECEPT),2,2),!
 .. ; PRCA*4.5*284 Change default response from YES to NO
 ..S DIR(0)="Y",DIR("B")="NO"
 ..S DIR("A")="Link to update Remittance entry # "_RCSCR
 ..S DIR("A")=DIR("A")_" with receipt "_RECEPT
 ..D ^DIR K DIR
 ..;Aborted
 ..I $D(DUOUT)!$D(DTOUT) S ABORT=1,FOUND=1 Q
 ..;Attempt to update ERA - finish if successful
 ..I +Y>0 D UPDERA(RCSCR,RECEPT,.FOUND)
 ;Update failed
 I FOUND=0 W !!,"No matching payment transactions found for this ERA"
 ;Clear workfile
 K ^TMP("RCDPEM2",$J)
 Q
 ;
 ; Moved to RCDPRU because of size issues PRCA*4.5*303
UPDERA(DA,RECEPT,FOUND) ;Mark ERA as posted to paper EOB
 D UPDERA^RCDPRU(DA,RECEPT,.FOUND)
 Q FOUND
 ;
 ;Check FMS status
FMS(RECEPT,FLG) ;
 ; FLG = 1 if RECEPT contains receipt number
 ; FLG = 0 if RECEPT contains ien of the receipt
 N FMSDOCNO,RCRECTDA,RES
 S RES=0 I $G(RECEPT)="" G FMSX
 ;Get receipt IEN
 I 'FLG S RCRECTDA=RECEPT
 I FLG S RCRECTDA=$O(^RCY(344,"B",RECEPT,0))
 I 'RCRECTDA G FMSX
 ;Get FMS document number
 S FMSDOCNO=$$FMSSTAT^RCDPUREC(RCRECTDA)
 ;Ignore if not accepted
 I $P(FMSDOCNO,U,2)'="ACCEPTED BY FMS" G FMSX
 ;Otherwise can be linked
 S RES=1
FMSX ;
 Q RES
 ;
CHQ(RECEPT,BILL) ;Get check number for this bill
 N RCRECTDA,RCTRAN,RCCHK,PATBILL
 ;Get receipt IEN
 S RCRECTDA=$O(^RCY(344,"B",RECEPT,0)) Q:'RCRECTDA ""
 ;Scan Receipt looking for this bill IEN
 S RCTRAN=0,RCCHK=""
 F  S RCTRAN=$O(^RCY(344,RCRECTDA,1,RCTRAN)) Q:'RCTRAN  D  Q:RCCHK]""
 .;Check for match on bill IEN
 .S PATBILL=$P($G(^RCY(344,RCRECTDA,1,RCTRAN,0)),U,3)
 .;Ignore Patient pointers or null field
 .Q:$P(PATBILL,";",2)'="PRCA(430,"
 .;Compare bill IEN399 to IEN430
 .Q:$P(PATBILL,";")'=BILL
 .;Get check number for this line
 .S RCCHK=$P($G(^RCY(344,RCRECTDA,1,RCTRAN,0)),U,7)
 Q RCCHK
 ;
 ;; End PRCA*4.5*276 - PJH
 ;
MATCH3 ; Manually 'match' a 0-balance ERA that has no check or EFT
 N DUOUT,DTOUT,DA,DR,DIE,DIC,DIR,X,Y,RCERA,RCRCPT
 W !,"THIS OPTION WILL ALLOW YOU TO MANUALLY MARK A 0-BALANCE ERA WITH NO",!,"CHECK OR EFT AS 'MATCH-0 PAYMENT' TO REMOVE IT FROM THE ERA AGING REPORT"
M3 S DIR("A")="SELECT THE UNMATCHED 0-BALANCE ERA TO MARK AS MATCHED: "
 S DIR(0)="PAO^RCY(344.4,:AEMQ",DIR("S")="I '$P(^(0),U,9),'$P(^(0),U,5)"
 W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y'>0) G M3Q
 S RCERA=+Y
 W !
 S DIC="^RCY(344.4,",DR="0",DA=RCERA D EN^DIQ
 W !
 S DIR("A")="ARE YOU SURE THIS IS THE ERA YOU WANT TO MARK AS MATCH-0 PAYMENT? (Y/N) ",DIR(0)="YA",DIR("B")="YES" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G M3Q
 I Y'=1 G M3
 S DIE="^RCY(344.4,",DR=".09////3",DA=RCERA D ^DIE
 S DIR(0)="EA",DIR("A")="ERA #"_RCERA_" WAS "_$S('$D(Y):"SUCCESSFULLY",1:"NOT")_" MARKED AS MATCH-0 PAYMENT" D ^DIR K DIR
M3Q Q
 ;
UNMATCH ; Used to 'unmatch' an ERA matched in error
 N X,Y,DIR,DIC,DIE,DIK,DA,DR,RCWL,RCEFT,RCQUIT,AUTOPOST
 S DIC(0)="AEMQ",DIC="^RCY(344.4,",DIC("S")="I '$P(^(0),U,8),$S('$P(^(0),U,14):1,1:$P(^(0),U,9)=3),$P(^(0),U,9)" D ^DIC K DIC
 Q:Y'>0
 S RCWL=+Y,RCQUIT=0
 I $D(^RCY(344.49,RCWL,0)) D  Q:RCQUIT
 . S DIR(0)="YA",DIR("A",1)="THIS ERA ALREADY HAS A WORKLIST ENTRY AND MUST BE DELETED BEFORE IT CAN BE UNMATCHED",DIR("A")="DO YOU WANT TO DELETE THE WORKLIST ENTRY FOR THIS ERA NOW? "
 . W ! D ^DIR K DIR
 . I Y'=1 S RCQUIT=1 Q
 . S DIK="^RCY(344.49,",DA=RCWL D ^DIK
 S AUTOPOST=""
 I $O(^RCY(344.31,"AERA",RCWL,0)) S RCEFT=+$O(^(0)) D  Q:RCQUIT
 . S AUTOPOST=$$GET1^DIQ(344.4,RCWL_",",4.02,"I")
 . W !!,"THIS ERA IS MATCHED TO EFT #"_RCEFT
 . I AUTOPOST=0 W !,"* WARNING: This ERA will be Un-Marked as an Auto-Post CANDIDATE"
 . S DIR("A")="ARE YOU SURE YOU WANT TO UNMATCH THEM? ",DIR(0)="YA"
 . D ^DIR K DIR
 . I Y'=1 S RCQUIT=1 Q
 . S DIE="^RCY(344.31,",DR=".1///@;.08////0",DA=RCEFT D ^DIE
 . W !,"EFT #"_RCEFT_" IS NOW UNMATCHED",!
 S DIE="^RCY(344.4,",DR=".09////0;.13///@;.14////0",DA=RCWL D ^DIE
 I AUTOPOST=0 D SETSTA^RCDPEAP(RCWL,"@","Unmatch: Removed as Auto-Post Candidate")
 S DIR("A")="ERA HAS BEEN SUCCESSFULLY UNMATCHED - Press ENTER to continue: "
 S DIR(0)="EA" W ! D ^DIR K DIR
 Q
 ;
 ;
 ; PRCA*4.5*284 - Changed option name from 'Mark ERA Return to Payer' to 'Remove ERA from Active Worklist'
RETN ; Entrypoint for Remove ERA from Active Worklist
 N DIR,X,Y,DTOUT,DUOUT,DIC,RCY,DIE,DA,DR,MSG,%
 D OWNSKEY^XUSRB(.MSG,"RCDPE MARK ERA",DUZ)
 I 'MSG(0) W !!,"SORRY, YOU ARE NOT AUTHORIZED TO USE THIS OPTION",!,"This option is locked with RCDPE MARK ERA key.",! S DIR(0)="E" D ^DIR K DIR Q
 ; PRCA*4.5*284 - Changed description
 W !!,"Use this option to remove an ERA from the EEOB Worklist that should not have"
 W !,"been sent to your site by the payer; or the ERA cannot be removed off the"
 W !,"Worklist using the 'Update ERA Posted Using Paper EOB' option."
 W !!,"This option is only to be used if the paper check has been sent back to the"
 W !,"payer without being deposited.  Once removed, the ERA can no longer be"
 W !,"accessed for processing, but can be viewed under the posted Worklist. For"
 W !,"auditing purposes, this option requires the user to enter a reason for"
 W !,"removing the ERA.",!
 S DIC="^RCY(344.4,",DIC(0)="AEMQ",DIC("S")="I '$P(^(0),U,9),'$P(^(0),U,14)" D ^DIC K DIC
 Q:Y'>0
 S RCY=+Y
 S DIR(0)="YA",DIR("A",1)="THIS WILL REMOVE THE ERA # "_+Y_" FROM THE ACTIVE WORKLIST",DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE? " W ! D ^DIR K DIR
 W !
 I $D(DUOUT)!$D(DTOUT)!(Y=0) D NOCHNG Q
 S DIE="^RCY(344.4,",DA=RCY,DR=".18" D ^DIE
 I $D(Y) D NOCHNG Q
 ; PRCA*4.5*284 Set EFT MATCH STATUS (#344.4,.09) as '4' FOR REMOVED rather than '2' FOR MATCHED TO PAPER CHECK
 D NOW^%DTC S DR=".14////4;.09////4;.16////"_DUZ_";.17////"_% D ^DIE
 S DIR(0)="EA",DIR("A")="Press ENTER to continue: "
 W ! D ^DIR
 Q
 ;
NOCHNG ;
 N DIR,X,Y,DTOUT,DUOUT
 D EN^DDIOL("NO CHANGES HAVE BEEN MADE.","","!")
 S DIR(0)="EA",DIR("A")="Press ENTER to continue: "
 W !! D ^DIR
 Q
