IBTRE3 ;ALB/AAS - CLAIMS TRACKING EDIT DIAGNOSIS ;1-SEP-93
 ;;2.0;INTEGRATED BILLING;**10,60,210,266**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G ^IBTRE
 ;
EN(IBTRN) ; -- entry point for protocols
 ;    must do own rebuild actions
 ; -- Input - point to 356
 ;
 N IBETYP,IBTRND,IBXY,IBCNT,IBDGPM
 D FULL^VALM1
 S VALMBCK=""
 S IBTRND=$G(^IBT(356,+IBTRN,0)),IBDGPM=$P(IBTRND,"^",5)
 ;
 S IBETYP=$$TRTP^IBTRE1(IBTRN)
 I IBETYP>2 W !!,"Clinical Information comes from the parent package." D PAUSE^VALM1 G ENQ
 ;
 ; -- outpatient diagnosis
 I IBETYP=2 D  G ENQ
 .I $P(IBTRND,"^",4) D ASK^IBTUTL4(IBTRN,2)
 .I '$P(IBTRND,"^",4) W !!,"Can not add diagnosis to outpatient visits prior to Check-out.",! D PAUSE^VALM1
 .S VALMBCK="R"
 ;
 ; -- Inpatient diagnosis
 I IBETYP=1 D
 .Q:'IBDGPM
 .;
 .; -- ask admitting diagnosis if not already there
 .I '$O(^IBT(356.9,"ADG",+IBDGPM,0)) D ADIAG(IBTRN,IBETYP)
 .I $G(IBSEL)="^" Q
 .;
 .; -- edit other diagnosis
 .D DIAG(IBTRN,IBETYP)
 .S VALMBCK="R"
 ;
ENQ ;
 Q
ADIAG(IBTRN,IBETYP) ; -- add admitting diagnosis
 ;
 N IBADG,DA,DR,DIC,DIE,DD,DO,IOINHI,IOINORM,IBDATE
 S IBADG=""
 ;
 S IBDATE=$$TRNDATE^IBACSV(IBTRN) ; Service date for CSV
 ;
 ;S IBDGPM=$P(^IBT(356,+IBTRN,0),"^",5)
 I IBETYP'=1!('IBDGPM) W !!,"You can only enter an admitting diagnosis for an admission",! D PAUSE^VALM1 G ADGQ
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S IBADG=$O(^IBT(356.9,"ADG",IBDGPM,0)) I IBADG S IBDA=$O(^IBT(356.9,"ADG",IBDGPM,IBADG,0))
 W !!,"--- ",IOINHI,"Admitting Diagnosis",IOINORM," --- "
 I 'IBADG W "Unspecified"
 E  D
 . N IBDX
 . S IBDX=$$ICD9^IBACSV(+IBADG,IBDATE)
 . W $P(IBDX,U)_" -"_$P(IBDX,U,3)
 I +IBADG D EDT(IBDA,".01;") W !
 I '$O(^IBT(356.9,"ADG",+IBDGPM,0)) D ADD(IBTRN,3)
 ;
 W !
ADGQ Q
 ;
DIAG(IBTRN,IBETYP) ; -- add/edit diagnosis
 Q:'IBTRN
 I $G(IBETYP)'=1 Q
 N DA,DR,DIC,DIE
 S IBDGPM=$P(^IBT(356,+IBTRN,0),"^",5)
 I IBETYP'=1!('IBDGPM) W !!,"You can only enter a diagnosis for an admission",! D PAUSE^VALM1 G ADGQ
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 W !!,"--- ",IOINHI,"Diagnosis",IOINORM," --- "
 S IBSEL="Add"
 D SET(IBTRN) I $D(IBXY) D LIST(.IBXY) S IBSEL=$$ASK^IBTRE4(IBCNT,"A")
 I IBSEL["^"!(IBSEL["Return") S:IBSEL["^" IBQUIT=1 G DIAGQ
 I IBSEL="Add" D ADD(IBTRN)
 D:IBSEL EDT(+$G(IBXY(+IBSEL)),".01;.03;.04")
DIAGQ Q
 ;
ADD(IBTRN,TYPE) ; -- Add a new diagnosis
 ;
 N DTOUT,DUOUT,X,Y,DIC,IBDATE,ICDVDT
 S IBCNT=0
 ;Service date (for CSV)
 S IBDATE=$$TRNDATE^IBACSV(IBTRN) S:'IBDATE IBDATE=DT
 S ICDVDT=IBDATE ; for DD ID (versioned text)
 ;
 I '$G(TYPE) S TYPE=""
NXT S DIC("A")=$S(TYPE=3:"Admitting Diagnosis: ",IBCNT<1:"Select Diagnosis: ",1:"Next Diagnosis: ")
 ;All DX codes are visible - no screen ;S DIC("S")="I '$P(^(0),U,9)"
 S DIC="^ICD9(",DIC(0)="AEMQ",X=""
 W:$G(IBCNT) ! D ^DIC K DIC G ADDQ:Y<0
 I Y,'$$ICD9ACT^IBACSV(+Y,IBDATE) W !!,*7,$P(Y,U,2)," is not active for the service date ("_$$DAT3^IBOUTL(IBDATE),").",! G NXT
 I $D(^IBT(356.9,"ADGPM",$$DGPM(IBTRN),+Y)) W !!,*7,$P(Y,"^",2)," is already a diagnosis.",! G NXT
 S IBCNT=IBCNT+1
 S IBADG=$$NEW(+Y,IBTRN,TYPE)
 I IBADG,TYPE'=3 D EDT(IBADG) G NXT
ADDQ I $D(DTOUT)!($D(DUOUT)) S IBSEL="^"
 Q
 ;
DGPM(IBTRN) ; -- return admission pointer
 Q $P(^IBT(356,+IBTRN,0),"^",5)
 ;
 ;
NEW(ICDI,IBTRN,TYPE) ; -- file new entry
 ;
 N DA,DD,DO,DIC,DIK,DINUM,DLAYGO,X,Y,I,J
 S X=ICDI,(DIC,DIK)="^IBT(356.9,",DIC(0)="L",DLAYGO=356.9
 D FILE^DICN S IBADG=+Y
 I IBADG>0 L +^IBT(356.9,IBADG) S $P(^IBT(356.9,IBADG,0),"^",2,4)=$$DGPM(IBTRN)_"^"_$P($P(^IBT(356,IBTRN,0),"^",6),".")_"^"_$G(TYPE),DA=IBADG D IX1^DIK L -^IBT(356.9,IBADG)
NEWQ Q IBADG
 ;
EDT(IBADG,IBDR) ; -- edit entry
 ;
 N DR,DIE,DA,DIDEL
 S DR=$G(IBDR),DIDEL=356.9 I DR="" S DR=".03;.04"
 S DA=IBADG,DIE="^IBT(356.9,"
 Q:'$G(^IBT(356.9,DA,0))
 L +^IBT(356.9,+IBADG):5 I '$T D LOCKED^IBTRCD1 G EDTQ
 D ^DIE
 L -^IBT(356.9,+IBADG)
EDTQ Q
 ;
SET(IBTRN) ; -- set array
 N IBDGPM,IBICD,IBDA
 S IBDGPM=$$DGPM(IBTRN)
 S (IBICD,IBCNT)=0
 F  S IBICD=$O(^IBT(356.9,"ADGPM",IBDGPM,IBICD)) Q:'IBICD  S IBDA=0 F  S IBDA=$O(^IBT(356.9,"ADGPM",IBDGPM,IBICD,IBDA)) Q:'IBDA  D
 .Q:'$D(^IBT(356.9,+IBDA,0))
 .S IBCNT=IBCNT+1
 .S IBXY(IBCNT)=IBDA_"^"_IBICD
SETQ Q
 ;
LIST(IBXY) ;List Diagnosis Array
 ; Input  -- IBXY     Diagnosis Array Subscripted by a Number
 ; Output -- List Diagnosis Array
 N I,IBXD,IBDATE
 W !
 S I=0 F  S I=$O(IBXY(I)) Q:'I  D
 . S IBTNOD=$G(^IBT(356.9,+IBXY(I),0))
 . S IBDATE=$P($P(IBTNOD,U,3),".")
 . S IBXD=$$ICD9^IBACSV(+$P(IBXY(I),U,2),IBDATE)
 . W !?2,I,"  ",$P(IBXD,U),?15,$E($P(IBXD,U,3),1,30),?48,$$DAT1^IBOUTL(IBDATE),?60,$$EXPAND^IBTRE(356.9,.04,$P(IBTNOD,U,4))
 Q
