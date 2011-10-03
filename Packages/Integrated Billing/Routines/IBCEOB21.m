IBCEOB21 ;ALB/TMP - EOB MAINTENANCE ACTIONS ;18-FEB-99
 ;;2.0;INTEGRATED BILLING;**137,155**;21-MAR-94
 Q
 ;
EDIT ; Edit a previously entered manual EOB
 N IBDA,IB0,DIE,DR,X,Y,DA
 ;
 D FULL^VALM1
 S IBDA=$$SEL()
 G:'IBDA EDITQ
 ;
 S IB0=$G(^IBM(361.1,IBDA,0))
 I $P(IB0,U,17)'=1 D  G EDITQ
 . W !,*7,"Cannot edit an EOB that was not entered manually!!"
 . D PAUSE^VALM1
 ;
 I $P(IB0,U,15)'=$$COBN^IBCEF(IBIFN) D  G EDITQ
 . W !,*7,"Can only edit an EOB for the current insurance sequence"
 . D PAUSE^VALM1
 ;
 S DIE="^IBM(361.1,",DA=IBDA
 S DR="100.03///"_DUZ_";100.04///^S X=""NOW"";.06;.13;.16//^S X=$$EXTERNAL^DILFD(361.1,.16,,3)"_$S($$AMTCHG(DA):";1.01",1:"")_";21"
 D ^DIE
 ;
 D BLD^IBCEOB2
 ;
 D PAUSE^VALM1
EDITQ S VALMBCK="R"
 Q
 ;
DELETE ; Delete a previously entered manual EOB
 N IB0,IBDA,IBE,DIR,X,Y,DA,DIK
 ;
 D FULL^VALM1
 S IBDA=$$SEL(.IBE)
 G:'IBDA DELQ
 ;
 S IB0=$G(^IBM(361.1,IBDA,0))
 I $P(IB0,U,17)'=1 D  G DELQ
 . W !,*7,"Cannot delete an EOB that was not entered manually!!"
 . D PAUSE^VALM1
 ;
 I $P(IB0,U,15)'=$$COBN^IBCEF(IBIFN) D  G DELQ
 . W !,*7,"Cannot only edit an EOB for the current insurance sequence"
 . D PAUSE^VALM1
 ;
 W !!,IBE,!
 S DIR("A")="ARE YOU REALLY SURE YOU WANT TO DELETE THIS EOB?: ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR
 G:Y'=1 DELQ
 ;
 S DIK="^IBM(361.1,",DA=IBDA D ^DIK
 W !!,"EOB Deleted!!",!
 ;
 D BLD^IBCEOB2
 ;
 D PAUSE^VALM1
DELQ S VALMBCK="R"
 Q
 ;
NEW ; Add a manual EOB for the current COB sequence for the claim
 N DO,DD,DIC,DIE,DLAYGO,Y,X,IBEOB,IBOK,IB364
 ;
 D FULL^VALM1
 ;
 K DO,DD
 S IB364=$$LAST364^IBCEF4(IBIFN)
 S DIC="^IBM(361.1,",DIC(0)="L",X=IBIFN,DLAYGO=361.1
 S DIC("DR")=".15////"_$$COBN^IBCEF(IBIFN)_";.04////0;.05////"_$$NOW^XLFDT_";.17////1;.18///"_DUZ_$S(IB364:";.19////"_IB364,1:"")
 D FILE^DICN K DO,DD,DLAYGO,DIC
 G:Y<0 NEWQ
 S DIE="^IBM(361.1,",DA=+Y,DR=".06//^S X=""NOW"";S DIE(""NO^"")="""";.13//^S X=$$EXTERNAL^DILFD(361.1,.13,,1);.16//^S X=$$EXTERNAL^DILFD(361.1,.16,,3);K DIE(""NO^"");1.01;21"
 W ! D ^DIE K DIE
 S IBEOB=$P($G(^IBM(361.1,DA,0)),U,6),IBOK=1
 I IBEOB D
 . I $P($G(^IBM(361.1,DA,1)),U,1)="" D
 .. S DIR(0)="YA",DIR("A",1)="Nothing entered for payer amt paid",DIR("A")="Are you sure you want to file this EOB?: ",DIR("B")="NO"
 .. W ! D ^DIR W ! K DIR
 .. I Y'=1 S (IBEOB,IBOK)=0
 . I IBOK W !,"EOB added",!
 I 'IBEOB D
 . Q:DA'>0
 . S DIK="^IBM(361.1," D ^DIK
 . I IBOK W !!,"EOB Date/Time needed, not entered"
 . W !,"No EOB added!!",!
 D BLD^IBCEOB2
NEWQ D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
VIEW ; View an MRA
 N IBDA,IBSEL,IBIFN,IBEOBIFN,IBIFNSAV
 ;
 D FULL^VALM1
 D SEL(.IBDA,1)     ; select a bill from the main list
 S IBSEL=+$O(IBDA(0)) I 'IBSEL G VIEWQ                    ; list#
 S IBIFN=$P($G(IBDA(IBSEL)),U,1) I 'IBIFN G VIEWQ         ; bill#
 S IBEOBIFN=$P($G(IBDA(IBSEL)),U,3) I 'IBEOBIFN G VIEWQ   ; eob ien
 ;
 ; If only one MRA on file, then call the Listman and quit
 I $$MRACNT^IBCEMU1(IBIFN)=1 D EN^VALM("IBCEM VIEW EOB") G VIEWQ
 ;
VLOOP ; Multiple MRA's on file.  Allow user to select the MRA to view
 D FULL^VALM1
 S IBEOBIFN=$$SEL^IBCEMU1(IBIFN,1)
 I 'IBEOBIFN G VIEWQ
 S IBIFNSAV=IBIFN                 ; save off the bill#
 D EN^VALM("IBCEM VIEW EOB")      ; call the Listman
 S IBIFN=IBIFNSAV                 ; restore the bill# (just in case)
 G VLOOP
 ;
VIEWQ ;
 S VALMBCK="R"
 Q
 ;
AMTCHG(DA) ; Function to determine if amt on EOB can be modified
 ; DA = ien of EOB entry (file 361.1)
 ; Function returns 1 if OK to change, 0 if the next bill in COB
 ;  sequence has already been sent or the bill has been closed.
 N IBOK,IBIFN,IBCOBN,IB0,IBNB
 S IBOK=1
 S IBIFN=+$G(^IBM(361.1,+DA,0)),IB0=$G(^DGCR(399,IBIFN,0))
 I $P(IB0,U,13)=6 S IBOK=0 G AMTQ ; Bill is closed...can't change EOB amt
 S IBCOBN=$$COBN^IBCEF(IBIFN)
 I IBCOBN=3 G AMTQ ; Already the last bill
 S IBNB=+$P($G(^DGCR(399,IBIFN,"M")),U,IBCOBN+5) ; Get next bill #
 I 'IBNB G AMTQ ; No next bill
 I $P($G(^DGCR(399,IBNB,0)),U,13)<3 G AMTQ
 S IBOK=0
 ;
AMTQ Q IBOK
 ;
SEL(IBDA,ONE) ; Select entry(s) from list
 ; IBDA = array returned if selections made
 ; ONE = if set to 1, only one selection can be made at a time
 N VALMY
 K IBDA
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S IBDA=0 F  S IBDA=$O(VALMY(IBDA)) Q:'IBDA  S IBDA(IBDA)=$P($G(^TMP("IBCECOB",$J,+IBDA)),U,2,6)
 Q
 ;
CHANGE ; Select another bill to display
 N IBNULL,IBIFN1
 D FULL^VALM1
 K VALMQUIT
 S IBIFN1=IBIFN
 S IBIFN=$$BILL^IBCEOB2(.VALMQUIT,.IBNULL)
 I '$G(IBNULL) S IBIFN=IBIFN1 K VALMQUIT
 I '$D(VALMQUIT) S VALMBCK="R"
 Q
 ;
