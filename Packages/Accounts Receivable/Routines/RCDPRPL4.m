RCDPRPL4 ;WISC/RFJ-receipt profile listmanager options ;1 Apr 01
 ;;4.5;Accounts Receivable;**169,172,173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;  this routine contains the entry points for receipt management
 ;
 ;
ONLINE ;  allow the supervisor to mark the CR document as input on line
 D FULL^VALM1
 S VALMBCK="R"
 ;
 ;  get fms document and status
 N %,FMSDOC,GECSDATA
 S FMSDOC=$$FMSSTAT^RCDPUREC(RCRECTDA)
 ;
 W !!,"This option will allow you to mark a rejected Cash Receipt document as"
 W !,"entered on line.  This will prevent the document from being listed on"
 W !,"the nightly mailman message used to help manage the receipts and deposits."
 ;
 W !!,"FMS Cash Receipt Document: ",$P(FMSDOC,"^"),?48,"Status: ",$P(FMSDOC,"^",2)
 ;
 I '$D(^XUSEC("PRCAY PAYMENT SUP",DUZ)) W !!,"You are not an owner of the supervisor PRCAY PAYMENT SUP security key." D QUIT Q
 ;
 ;  cr accepted
 I $E($P(FMSDOC,"^",2))="A" W !!,"You CANNOT mark the Cash Receipt document as entered on line.",!,"The CR document is ACCEPTED ??" D QUIT Q
 ;
 ;  not been transmitted for 2 days
 I $E($P(FMSDOC,"^",2))="T",$$FMDIFF^XLFDT(DT,$P(^RCY(344,RCRECTDA,0),"^",8))'>2 W !!,"You CANNOT mark the Cash Receipt document as entered on line.",!,"The CR document has NOT been TRANSMITTED for 2 days ??" D QUIT Q
 ;
 ;  cr queued for transmission
 I $E($P(FMSDOC,"^",2))="Q"!($E($P(FMSDOC,"^",2))="M") W !!,"You CANNOT mark the Cash Receipt document as entered on line.",!,"The CR document is waiting to be TRANSMITTED ??" D QUIT Q
 ;
 ;  check to see if already marked as entered on line
 I $E($P(FMSDOC,"^",2))="O" D  Q
 .   I $$ASKSTAT("REMOVE")'=1 Q
 .   W !,"... removing CR status as entered on line ..."
 .   ;  remove the status on field 201
 .   D EDITREC^RCDPUREC(RCRECTDA,"201////0;")
 .   ;  show the new status
 .   S FMSDOC=$$FMSSTAT^RCDPUREC(RCRECTDA)
 .   W !!,"FMS Cash Receipt Document: ",$P(FMSDOC,"^"),?48,"Status: ",$P(FMSDOC,"^",2)
 .   D QUIT
 ;
 ;  ask to change the status to entered on line
 I $$ASKSTAT("ENTER")'=1 D QUIT Q
 ;
 ;  change the status to entered on line
 W !,"... changing status to entered on line ..."
 W !,"... changing the generic code sheet stack file status to ACCEPTED ..."
 ;
 ;  set the status to entered on line in field 201
 D EDITREC^RCDPUREC(RCRECTDA,"201////1;")
 ;
 ;  set the generic code sheet status as accepted
 ;  get the document ien
 D DATA^GECSSGET($P(FMSDOC,"^"))
 I $G(GECSDATA) D SETSTAT^GECSSTAA(GECSDATA,"A")
 ;
 ;  show the new status
 S FMSDOC=$$FMSSTAT^RCDPUREC(RCRECTDA)
 W !!,"FMS Cash Receipt Document: ",$P(FMSDOC,"^"),?48,"Status: ",$P(FMSDOC,"^",2)
 ;
QUIT ;  pause and rebuild the header
 W !!,"press RETURN to continue: "
 R %:DTIME
 D HDR^RCDPRPLM
 Q
 ;
 ;
ASKSTAT(ACTION) ;  ask if its okay to remove or change the entered online status
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A",1)="  Do you want to "_ACTION_" the status showing the Cash Receipt"
 S DIR("A")="  document was entered ON LINE"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
ERAWL(RCSCR) ; Generate automatic dec adj from ERA Worklist in RCSCR
 ; RCADJ returned = 1 if passed by reference and adjustment successful
 ;       returned = 2 if passed by ref and adjustments aborted
 ;       returned = -1 if error
 ;       returned = 0 if no WL adjustments found
 N RCZ,RCZ0,Z00,V00,RCCOM,RC1,RCADJ,RCOK
 S RC1=1,RCZ=0,RCADJ=0
 F  S RCZ=$O(^RCY(344.49,RCSCR,1,RCZ)) Q:'RCZ!(RCADJ=2)  S V00=$G(^(RCZ,0)),RCZ0=0 F  S RCZ0=$O(^RCY(344.49,RCSCR,1,RCZ,1,RCZ0)) Q:'RCZ0!(RCADJ=2)  S Z00=$G(^(RCZ0,0)) Q:"12"'[+$P(Z00,U,5)  D
 . S RCCOM(1)=$P(Z00,U,9)
 . I RC1,$P(Z00,U,5)=1 D  Q:RCADJ=2
 .. S RC1=0
 .. S DIR(0)="YA",DIR("B")="YES",DIR("A",1)="Generating automatic decrease adjustments from EDI Lbox Worklist ...",DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE?: "
 .. D ^DIR K DIR
 .. I Y'=1 S RCADJ=2
 . I $P(Z00,U,8)=1 D  Q  ; previously done
 .. I $P(Z00,U,5)=1 W !,"  Automatic decrease adj from ERA Worklist for bill #"_$P($G(^PRCA(430,+$P(V00,U,7),0)),U),!,"    for amount of "_$J(+$P(Z00,U,3),"",2)_" was previously completed" S RCADJ=1
 . I $P(Z00,U,5)=1 D  Q  ; Decrease adj
 .. I '$$INCDEC^RCBEUTR1($P(V00,U,7),$P(Z00,U,3),.RCCOM) D
 ... W !,"  Could not perform automatic decrease adj from ERA Worklist for ",!,"    bill # "_$P($G(^PRCA(430,+$P(V00,U,7),0)),U)_" for amount of "_$J(+$P(Z00,U,3),"",2)
 ... S RCADJ=-1
 .. E  D  ; success
 ... D UPD(RCSCR,RCZ,RCZ0)
 ... S RCADJ=1
 ... W !,"  EDI Lbox Worklist automatic dec adjustment made to "_$P($G(^PRCA(430,+$P(V00,U,7),0)),U)_": "_$J(+$P(Z00,U,3),"",2)
 . I $P(Z00,U,5)=2 D  Q  ; Bill comment
 .. D ADDCOMM^RCBEUTRA($P(V00,U,7),.RCCOM),UPD(RCSCR,RCZ,RCZ0)
 ;
 Q $G(RCADJ)
 ;
UPD(RCSCR,Z,Z0) ; Mark as complete so it doesn't get done twice
 N DA,DIE,DR
 S DA(2)=RCSCR,DA(1)=Z,DA=Z0
 S DIE="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",1,",DR=".08////1" D ^DIE
 Q
 ;
