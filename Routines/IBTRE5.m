IBTRE5 ;ALB/AAS - CLAIMS TRACKING EDIT PROVIDER ; 1-SEP-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**10,60**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G ^IBTRE
 ;
EN(IBTRN) ; -- entry point for protocols
 ;    must do own rebuild actions
 ; -- Input - pointer to 356
 ;
 N IBETYP,IBTRND,IBXY,IBCNT,IBDGPM
 D FULL^VALM1
 S VALMBCK=""
 S IBTRND=$G(^IBT(356,IBTRN,0)),IBDGPM=$P(IBTRND,"^",5)
 ;
 S IBETYP=$$TRTP^IBTRE1(IBTRN)
 I IBETYP>2 W !!,"Clinical Information comes from the parent package." D PAUSE^VALM1 G ENQ
 ;
 ; -- outpatient provider
 I IBETYP=2 D  G ENQ
 .I $P(IBTRND,"^",4) D ASK^IBTUTL4(IBTRN,1)
 .I '$P(IBTRND,"^",4) W !!,"Can not add provider to outpatient visits prior to Check-out.",! D PAUSE^VALM1
 .S VALMBCK="R"
 ;
 ; -- Inpatient provider
 I IBETYP=1 D
 .Q:'IBDGPM
 .; -- ask admitting provider
 .I '$O(^IBT(356.94,"ADG",IBDGPM,0)) D APRVD(IBTRN,IBETYP)
 .I $G(IBSEL)="^" Q
 .;
 .; -- edit other provider
 .D PRVD(IBTRN,IBETYP)
 .S VALMBCK="R"
 ;
ENQ ;
 Q
APRVD(IBTRN,IBETYP) ; -- add admitting provider
 ;
 N IBAPR,DA,DR,DIC,DIE,DD,DO,IOINHI,IOINORM
 S IBAPR=""
 ;
 I IBETYP'=1!('IBDGPM) W !!,"You can only enter and admitting provider for an admission",! D PAUSE^VALM1 G APRVDQ
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S IBAPR=$O(^IBT(356.94,"ADG",IBDGPM,0)) I IBAPR S IBDA=$O(^IBT(356.94,"ADG",IBDGPM,IBAPR,0))
 W !!,"--- ",IOINHI,"Admitting Physician",IOINORM," --- ",$S('IBAPR:"Unspecified",1:$P($G(^VA(200,+$P(IBAPR,"^",3),0)),"^"))
 I +IBAPR D EDT(IBDA,".03;") W !
 I '$O(^IBT(356.94,"ADG",IBDGPM,0)) D ADD(IBTRN,3)
 ;
 W !
APRVDQ Q
 ;
PRVD(IBTRN,IBETYP) ; -- add/edit provider
 Q:'IBTRN
 I $G(IBETYP)'=1 Q
 N DA,DR,DIC,DIE
 I IBETYP'=1!('IBDGPM) W !!,"You can only enter a provider for an admission",! D PAUSE^VALM1 G PRVDQ
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 W !!,"--- ",IOINHI,"Provider",IOINORM," --- "
 S IBSEL="Add"
 D SET(IBTRN) I $D(IBXY) D LIST(.IBXY) S IBSEL=$$ASK^IBTRE4(IBCNT,"A")
 I IBSEL["^"!(IBSEL["Return") S:IBSEL["^" IBQUIT=1 G PRVDQ
 I IBSEL="Add" D ADD(IBTRN)
 D:IBSEL EDT(+$G(IBXY(+IBSEL)),".01;.03;.04")
PRVDQ Q
 ;
ADD(IBTRN,TYPE) ; -- Add a new provider
 ;
 N DTOUT,DUTOU,X,Y,DIC
 S IBCNT=0
 I '$G(TYPE) S TYPE=""
NXT S DIC("A")=$S(TYPE=3:"Admitting Provider: ",IBCNT<1:"Select Provider: ",1:"Next Provider: ")
 S DIC("S")="I $D(^VA(200,""AK.PROVIDER"",$P(^(0),U,1),+Y))"
 S DIC="^VA(200,",DIC(0)="AEMQ",X=""
 W:$G(IBCNT) ! D ^DIC K DIC G ADDQ:Y<0
 S IBCNT=IBCNT+1
 S IBAPR=$$NEW(+Y,IBTRN,TYPE)
 I IBAPR,TYPE'=3 D EDT(IBAPR) G NXT
ADDQ I $D(DUOUT)!($D(DTOUT)) S IBSEL="^"
 Q
 ;
NEW(VA200,IBTRN,TYPE) ; -- file new entry
 ;
 N DA,DD,DO,DIC,DIK,DINUM,DLAYGO,X,Y,I,J
 ;
 ; -- default date = episode date
 S X=$P($P(^IBT(356,IBTRN,0),"^",6),".")
 S (DIC,DIK)="^IBT(356.94,",DIC(0)="L",DLAYGO=356.94
 D FILE^DICN S IBAPR=+Y
 I IBAPR>0 L +^IBT(356.94,IBAPR) S $P(^IBT(356.94,IBAPR,0),"^",2,4)=$$DGPM^IBTRE3(IBTRN)_"^"_VA200_"^"_$G(TYPE),DA=IBAPR D IX1^DIK L -^IBT(356.94,IBAPR)
NEWQ Q IBAPR
 ;
EDT(IBAPR,IBDR) ; -- edit entry
 ;
 N DR,DIE,DA,DIDEL
 S DR=$G(IBDR),DIDEL=356.94 I DR="" S DR=".01;.03;.04"
 S DA=IBAPR,DIE="^IBT(356.94,"
 Q:'$G(^IBT(356.94,DA,0))
 L +^IBT(356.94,IBAPR):5 I '$T D LOCKED^IBTRCD1 G EDTQ
 D ^DIE
 L -^IBT(356.94,IBAPR)
EDTQ Q
 ;
SET(IBTRN) ; -- set array
 N IBDGPM,IBPRV
 S IBDGPM=$$DGPM^IBTRE3(IBTRN)
 S (IBPRV,IBCNT)=0
 F  S IBPRV=$O(^IBT(356.94,"ADGPM",IBDGPM,IBPRV)) Q:'IBPRV  S IBDA=0 F  S IBDA=$O(^IBT(356.94,"ADGPM",IBDGPM,IBPRV,IBDA)) Q:'IBDA  D
 .Q:'$D(^IBT(356.94,+IBDA,0))
 .S IBCNT=IBCNT+1
 .S IBXY(IBCNT)=IBDA
SETQ Q
 ;
LIST(IBXY) ;List Provider Array
 ; Input  -- IBXY     Provider Array Subscripted by a Number
 ; Output -- List Provider Array
 N I,IBXD,IBTNOD
 W !
 S I=0 F  S I=$O(IBXY(I)) Q:'I  D
 .S IBTNOD=$G(^IBT(356.94,+IBXY(I),0))
 .S IBXD=$P($G(^VA(200,$P(IBTNOD,"^",3),0)),"^")
 .W !?2,I,"  ",IBXD,?40,$$DAT1^IBOUTL($P($P(IBTNOD,"^",1),"."),2),?60,$$EXPAND^IBTRE(356.94,.04,$P(IBTNOD,"^",4))
 Q
 ;
DICS(Y) ; -- called by input transform and screen logic for type of provider
 N IBY
 S IBY=0
 I Y<3 S IBY=1 G DICSQ
 I Y=3 I '$D(^IBT(356.94,"ATP",+$P($G(^IBT(356.94,DA,0)),U,2),3))!($O(^IBT(356.94,"ATP",+$P($G(^IBT(356.94,DA,0)),U,2),3,0))=DA) S IBY=1
DICSQ Q IBY
 ;
DTCHK(DA,X) ; -- input transform for 356.94;.01.  date not before admission or after discharge
 N IBTRN,IBOK,IBCDT
 S IBOK=1
 G:'DA!($G(X)<1) DTCHKQ
 S IBTRN=+$O(^IBT(356,"AD",+$P(^IBT(356.94,DA,0),"^",2),0))
 G:'IBTRN DTCHKQ
 S IBCDT=$$CDT^IBTODD1(IBTRN)
 I X<$P(+IBCDT,".") S IBOK=0 G DTCHKQ ;before adm
 I $P(IBCDT,"^",2),X>$P(IBCDT,"^",2) S IBOK=0 G DTCHKQ ; after disch
 I X>$$FMADD^XLFDT(DT,7) S IBOK=0 G DTCHKQ
 ;
DTCHKQ Q IBOK
