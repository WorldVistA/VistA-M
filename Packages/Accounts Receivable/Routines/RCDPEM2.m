RCDPEM2 ;ALB/TMK/PJH - MANUAL ERA AND EFT MATCHING ;Jun 11, 2014@13:24:36
 ;;4.5;Accounts Receivable;**173,208,276,284,293,298,303,304,321,326**;Mar 20, 1995;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; PRCA*4.5*303 - Manually Match EFT from Worklist screen
MATCHWL ; Manually 'match' ERA to an EFT that originates from [RCDPE WORKLIST ERA LIST]
 N DA,DIC,DIE,DIR,DR,DTRNG,DTOUT,DUOUT,EFTTOT,END,ERATOT,RCEFT,RCERA,RCMBG,RCMATCH,RCNAME,RCQUIT,START,X,Y
 D FULL^VALM1
 ;
 ; PRCA*4.5*303 moved code out because this routine grew too large
 I $$ML0^RCDPRU() G MWQ ; if true then quit, othewise continue
 ;
ML1 ; Select EFT to Match to this ERA
 ; BEGIN PRCA*4.5*326 - replace ^DIC call to EFT picker utility
 S DIC("A")="SELECT THE UNMATCHED EFT TO MATCH TO AN ERA: "
 S DIC("S")="I ('$P(^(0),U,8))&($P($G(^(0)),U,7))&('$P($G(^(3)),U))"
 S:$G(DTRNG) DIC("S")=DIC("S")_"&'($P($G(^(0)),U,13)<START)&'($P($G(^(0)),U,13)>END)"
 ; end PRCA*4.5*293
 ;
 W !
 S Y=$$ASKEFT^RCDPEU2(DIC("A"),DIC("S"))
 I Y'>0 G MWQ
 S RCEFT=+Y,RCEFT(0)=$G(^RCY(344.31,+Y,0))
 ; END PRCA*4.5*326
 W !
 S DIC="^RCY(344.31,",DR="0",DA=RCEFT D EN^DIQ
 W !
 S DIR("A")="ARE YOU SURE THIS IS THE EFT YOU WANT TO MATCH?: ",DIR(0)="YA",DIR("B")="YES" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G MWQ
 I Y'=1 G ML1
 ; Go to the Manual match, we have the ERA and EFT
 D M12A
 ;
 ; Quit back to the worklist VALMBCK will be killed by List Manager.
 ; Rebuild the screen because we may have changed it.
MWQ D INIT^RCDPEWL7
 S VALMBCK="R",VALMBG=RCMBG
 Q
 ;
MATCH1 ; Manually 'match' an ERA to an EFT
 N DA,DIC,DIE,DIR,DIROUT,DR,DTRNG,DTOUT,DUOUT,EFTTOT,END,ERATOT
 N RCEFT,RCERA,RCMATCH,RCMTFLG,RCNAME,RCQUIT,START,X,XX,Y,YY
 W !,"THIS OPTION WILL ALLOW YOU TO MANUALLY MATCH AN EFT DETAIL RECORD"
 W !,"WITH AN ERA RECORD."
 ; PRCA*4.5*298 - Add ability to specify a date range
 S DIR("A")="Select by date Range? (Y/N) ",DIR(0)="YA",DIR("B")="NO"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G M1Q
 I Y<1 G M1
 S DTRNG=Y  ; flag indicating date range selected
 K DIR
 S DIR("?")="Enter the earliest date for the selection range."
 ; value in DIR(0) for %DT = APE: ask date, past assumed, echo answer
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start Date: "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G M1Q
 S START=Y
 K DIR,X,Y
 S DIR("?")="Enter the latest date for the selection range."
 S DIR(0)="DAO^"_START_":"_DT_":APE",DIR("A")="End Date: ",DIR("B")=$$FMTE^XLFDT(DT)
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G M1Q
 S END=Y
 ;
 ; Replace DIC call to EFT selector utility - PRCA*4.5*326
M1 S DIC("A")="SELECT THE UNMATCHED EFT TO MATCH TO AN ERA: "
 ;
 ; start PRCA*4.5*293 Add extra checks to filter out EFTs that have 
 ; a payment amount of zero or EFTs that have been removed.
 ; Only UNMATCHED EFTs with payment amt >0 and not removed should
 ; be selectable by the user.
 ;
 S DIC("S")="I ('$P(^(0),U,8))&($P($G(^(0)),U,7))&('$P($G(^(3)),U))"
 S:$G(DTRNG) DIC("S")=DIC("S")_"&'($P($G(^(0)),U,13)<START)&'($P($G(^(0)),U,13)>END)"
 S Y=$$ASKEFT^RCDPEU2(DIC("A"),DIC("S"))
 I Y'>0 G M1Q
 S RCEFT=+Y
 ; end PRCA*4.5*293
 W !
 S DIC="^RCY(344.31,",DR="0",DA=RCEFT D EN^DIQ
 W !
 S DIR("A")="ARE YOU SURE THIS IS THE EFT YOU WANT TO MATCH?: "
 S DIR(0)="YA",DIR("B")="YES"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G M1Q
 I Y'=1 G M1
 ; Add EFT line identifier - PRCA*4.5*326
M12 S DIR("A")="SELECT THE UNMATCHED ERA TO MATCH TO EFT #" ; PRCA*4.5*326
 S DIR("A")=DIR("A")_$$GET1^DIQ(344.31,RCEFT,.01,"E")_": " ; PRCA*4.5*326
 S DIR(0)="PAO^RCY(344.4,:AEMQ",DIR("S")="I '$P(^(0),U,9),'$P(^(0),U,8)"
 W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y<0) G M1Q
 S RCERA=+Y
 W !
 S DIC="^RCY(344.4,",DR="0",DA=RCERA D EN^DIQ
 W !
 S DIR("A")="ARE YOU SURE THIS IS THE CORRECT ERA TO MATCH TO?: ",DIR(0)="YA",DIR("B")="YES" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G M1Q
 I Y'=1 G M12
 ;
M12A ; PRCA*4.5*303 - MATCH WL jumps here to complete the manual match
 ; BEGIN PRCA*4.5*326
 S ERATOT=$$GET1^DIQ(344.4,RCERA,.05,"I") ; ERA Paid Amount
 S EFTTOT=$$GET1^DIQ(344.31,RCEFT,.07,"I") ; EFT Amount of Payment
 S RCMATCH=(+ERATOT=+EFTTOT) ; Do the Totals Match
 ;
 ; If the totals don't match, manual match is not allowed
 ;I 'RCMATCH D  G M1Q
 ;. W !,*7,$J("",3)_"> The amount of payment on these two records do not agree."
 ;. K DIR S DIR(0)="EA",DIR("A")="Press ENTER to continue: "
 ;. D ^DIR
 ;. S RCQUIT=1
 ;
 S XX=$$GET1^DIQ(344.4,RCERA,.06,"I") ; ERA Payer Name
 S YY=$$GET1^DIQ(344.31,RCEFT,.02,"I") ; EFT Payer Name
 S RCNAME=(XX=YY) ; Do the Payer Names Match
 I 'RCNAME D  G:RCQUIT M1Q
 . N Z
 . S RCQUIT=0,Z=1
 . S DIR("A",1)="***WARNING***"
 . I 'RCNAME S Z=Z+1,DIR("A",Z)=$J("",3)_"> The payer names on these two records do not agree"
 . S DIR(0)="YA",DIR("B")="NO",DIR("A")="ARE YOU SURE YOU WANT TO MATCH THESE 2 RECORDS?: "
 . W ! D ^DIR K DIR
 . I $S($D(DUOUT)!$D(DTOUT):1,Y'=1:1,1:0) S RCQUIT=1 Q
 ; END PRCA*4.5*326
 S DIE="^RCY(344.4,",DR=".09////1",DA=RCERA D ^DIE
 I '$D(Y) S DIE="^RCY(344.31,",DR=".08////1;.1////"_RCERA,DA=RCEFT D ^DIE
 S RCMTFLG=$S('$D(Y):1,1:0)
 ; PRCA*4.5*326 - Add EFT suffix
 W !,"EFT #"_$$GET1^DIQ(344.31,RCEFT,.01,"E")_" WAS "_$S(RCMTFLG:"SUCCESSFULLY",1:"NOT")_" MATCHED TO ERA #"_RCERA ; PRCA*4.5*326
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
 S AUTOPOST=$$AUTOCHK2^RCDPEAP1(RCERA,1) ; Allow auto-post for CHK and ACH type ERA - PRCA*4.5*321
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
 ; BEGIN PRCA*4.5*326
M2 S DIC("A")="SELECT THE UNMATCHED 0-BALANCE EFT TO MARK AS MATCHED TO PAPER EOB: "
 S DIC("S")="I '$P(^(0),U,8),'$P(^(0),U,7)"
 S Y=$$ASKEFT^RCDPEU2(DIC("A"),DIC("S"))
 I Y'>0 G M2Q
 ; END PRCA*4.5*326
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
 ;
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
 N AUTOPOST,DA,DIC,DIE,DIK,DIR,DIROUT,DR,DTOUT,DUOUTX,RCEFT,RCQUIT,RCWL,X,XX,Y
 S DIC(0)="AEMQ",DIC="^RCY(344.4,"
 S DIC("S")="I '$P(^(0),U,8),$S('$P(^(0),U,14):1,1:$P(^(0),U,9)=3),$P(^(0),U,9)"
 D ^DIC K DIC
 Q:Y'>0
 S RCWL=+Y,RCQUIT=0
 I $D(^RCY(344.49,RCWL,0)) D  Q:RCQUIT
 . S DIR(0)="YA"
 . S XX="THIS ERA ALREADY HAS A SCRATCH PAD ENTRY AND MUST BE DELETED BEFORE IT CAN BE"
 . S DIR("A",1)=XX
 . S DIR("A")="UNMATCHED. DO YOU WANT TO DELETE THE SCRATCH PAD ENTRY FOR THIS ERA NOW? "
 . W ! D ^DIR K DIR
 . I Y'=1 S RCQUIT=1 Q
 . S DIK="^RCY(344.49,",DA=RCWL D ^DIK
 S AUTOPOST=""
 I $O(^RCY(344.31,"AERA",RCWL,0)) S RCEFT=+$O(^(0)) D  Q:RCQUIT
 . S AUTOPOST=$$GET1^DIQ(344.4,RCWL_",",4.02,"I")
 . W !!,"THIS ERA IS MATCHED TO EFT #"_$$OUT^RCDPEM3(RCEFT)
 . I AUTOPOST=0 W !,"* WARNING: This ERA will be Un-Marked as an Auto-Post CANDIDATE"
 . S DIR("A")="ARE YOU SURE YOU WANT TO UNMATCH THEM? ",DIR(0)="YA"
 . D ^DIR K DIR
 . I Y'=1 S RCQUIT=1 Q
 . S DIE="^RCY(344.31,",DR=".1///@;.08////0",DA=RCEFT D ^DIE
 . W !,"EFT #"_$$OUT^RCDPEM3(RCEFT)_" IS NOW UNMATCHED",!
 ; PRCA*4.5*326 - If check if unmatched, delete date matched and user
 S DIE="^RCY(344.4,",DR=".09////0;.13///@;.14////0;5.03///@;5.04///@"
 S DA=RCWL
 D ^DIE
 I AUTOPOST=0 D SETSTA^RCDPEAP(RCWL,"@","Unmatch: Removed as Auto-Post Candidate")
 S DIR("A")="ERA HAS BEEN SUCCESSFULLY UNMATCHED - Press ENTER to continue: "
 S DIR(0)="EA" W ! D ^DIR K DIR
 Q
 ;
 ; PRCA*4.5*284 - Changed option name from 'Mark ERA Return to Payer' to 'Remove ERA from Active Worklist'
RETN ; Entrypoint for Remove ERA from Active Worklist
 N DIR,X,Y,DTOUT,DUOUT,DIC,RCY,DIE,DA,DR,MSG,%
 D OWNSKEY^XUSRB(.MSG,"RCDPE MARK ERA",DUZ)
 I 'MSG(0) W !!,"SORRY, YOU ARE NOT AUTHORIZED TO USE THIS OPTION",!,"This option is locked with RCDPE MARK ERA key.",! S DIR(0)="E" D ^DIR K DIR Q
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
 I $D(DUOUT)!$D(DTOUT)!(Y=0) D NOCHNG^RCDPEMB Q
 S DIE="^RCY(344.4,",DA=RCY,DR=".18" D ^DIE
 I $D(Y) D NOCHNG^RCDPEMB Q
 ; PRCA*4.5*284 Set EFT MATCH STATUS (#344.4,.09) as '4' FOR REMOVED rather than '2' FOR MATCHED TO PAPER CHECK
 D NOW^%DTC S DR=".14////4;.09////4;.16////"_DUZ_";.17////"_% D ^DIE
 S DIR(0)="EA",DIR("A")="Press ENTER to continue: "
 W ! D ^DIR
 Q
