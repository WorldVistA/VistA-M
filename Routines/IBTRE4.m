IBTRE4 ;ALB/AAS - CLAIMS TRACKING EDIT PROCEDURE ;1-SEP-93
 ;;2.0;INTEGRATED BILLING;**10,210,266**;21-MAR-94
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
 S IBTRND=$G(^IBT(356,IBTRN,0)),IBDGPM=$P(IBTRND,"^",5)
 ;
 S IBETYP=$$TRTP^IBTRE1(IBTRN)
 I IBETYP>2 W !!,"Clinical Information comes from the parent package." D PAUSE^VALM1 G ENQ
 ;
 ; -- outpatient procedure
 I IBETYP=2 D  G ENQ
 .W !!,*7,"You must use the add/edit action on Check-out to add procedures to Outpatient Encounters.",!
 .S VALMBCK="R"
 ;
 ; -- Inpatient procedure
 Q:'IBDGPM
 I IBETYP=1 D PROC(IBTRN,IBETYP) S VALMBCK="R"
 ;
ENQ ;
 Q
 ;
PROC(IBTRN,IBETYP) ; -- add/edit procedure
 Q:'IBTRN
 I $G(IBETYP)'=1 Q
 N DA,DR,DIC,DIE
 ;S IBDGPM=$P(^IBT(356,+IBTRN,0),"^",5)
 I IBETYP'=1!('IBDGPM) W !!,"You can only enter a procedure for an admission",! D PAUSE^VALM1 G PROCQ
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 W !!,"--- ",IOINHI,"Procedure",IOINORM," --- "
 S IBSEL="Add"
 D SET(IBTRN) I $D(IBXY) D LIST(.IBXY) S IBSEL=$$ASK(IBCNT,"A")
 I IBSEL["^"!(IBSEL["Return") S:IBSEL["^" IBQUIT=1 G PROCQ
 I IBSEL="Add" D ADD(IBTRN)
 I IBSEL D EDT(+$G(IBXY(+IBSEL)),".01;.03;"),CHECK(+$G(IBXY(+IBSEL)))
PROCQ Q
 ;
CHECK(IBADG) ; Check active status of the ICD0 code (Code Set Versioning)
 N IBZ,DIR,X,Y
 S IBZ=$G(^IBT(356.91,+$G(IBADG),0)) Q:'IBZ
 Q:$$ICD0ACT^IBACSV(+IBZ,$P(IBZ,U,3))
 W !!,*7,"Warning! The Procedure Code ",$P($$ICD0^IBACSV(+IBZ),U)," is inactive on this date!"
 S DIR(0)="EA",DIR("A")="Press <Enter> to continue" D ^DIR
 Q
 ;
ADD(IBTRN,TYPE) ; -- Add a new procedure
 ;
 N DTOUT,DUTOU,X,Y,DIC,DIR,IBDATE,IBP,IBPN,IBPDT,IBADT,ICDVDT
 ;Service date (for CSV)
 S IBDATE=$$TRNDATE^IBACSV(IBTRN)
 S IBADT=$G(^DGPM(+$$DGPM^IBTRE3(IBTRN),0)) ;Admission Date
 S IBCNT=0
 I '$G(TYPE) S TYPE=""
NXT ; The Procedure Date has to be asked first for the Code Set Versioning requirements
 ; Input Procedure Date
 S DIR(0)="D",DIR("A")=$S(IBCNT<1:"Procedure Date",1:"Next Procedure Date")
 S DIR("B")=$$DAT3^IBOUTL(IBDATE)
 W:$G(IBCNT) !
 S IBPDT=IBDATE D ^DIR K DIR G ADDQ:Y'?7N S IBPDT=+Y W "  ",$$DAT2^IBOUTL(IBPDT)
 ; The same checking as in the Data Dictionary, file #356.91, field #.03 (PROCEDURE DATE):
 I IBADT,(IBPDT+.9)<IBADT W !!,*7,"The Procedure Date cannot be earlier than Admission (",$$DAT3^IBOUTL(IBADT),")",! G NXT
 ; Input Procedure (ICD0)
 S DIC("A")="Select Procedure: "
 S DIC("S")="I $$ICD0ACT^IBACSV(+Y,IBPDT)"
 S ICDVDT=IBPDT ; for DD ID (versioned text)
 S DIC="^ICD0(",DIC(0)="AEMQ",X=""
 D ^DIC K DIC G ADDQ:Y'>0
 S IBP=+Y,IBPN=$P(Y,U,2) ; Procedure IEN and name
 ;I '$$ICD0ACT^IBACSV(IBP,IBPDT) W !!,*7,IBPN," is not active for the procedure date ("_$$DAT3^IBOUTL(IBPDT),").",! G NXT
 I $D(^IBT(356.91,"ADGPM",$$DGPM^IBTRE3(IBTRN),IBP)) W !!,*7,IBPN," is already a procedure.",!
 S IBCNT=IBCNT+1
 S IBADG=$$NEW(IBP,IBTRN,TYPE,IBPDT)
 I IBADG>0,TYPE'=3 G NXT ;D EDT(IBADG) G NXT
ADDQ Q
 ;
NEW(ICDI,IBTRN,TYPE,IBPDT) ; -- file new entry
 ;
 N DA,DD,DO,DIC,DIK,DINUM,DLAYGO,X,Y,I,J
 S X=ICDI,(DIC,DIK)="^IBT(356.91,",DIC(0)="L",DLAYGO=356.91
 D FILE^DICN S IBADG=+Y I Y'>0 G NEWQ
 I '$G(IBPDT) S IBPDT=$P($P(^IBT(356,IBTRN,0),"^",6),".")
 L +^IBT(356.91,IBADG) S $P(^IBT(356.91,IBADG,0),"^",2,3)=$$DGPM^IBTRE3(IBTRN)_"^"_IBPDT,DA=IBADG D IX1^DIK L -^IBT(356.91,IBADG)
NEWQ Q IBADG
 ;
EDT(IBADG,IBDR) ; -- edit entry
 ;
 N DR,DIE,DA,DIDEL
 S DR=$G(IBDR),DIDEL=356.91 I DR="" S DR=".03;"
 S DA=IBADG,DIE="^IBT(356.91,"
 Q:'$G(^IBT(356.91,DA,0))
 L +^IBT(356.91,IBADG):5 I '$T D LOCKED^IBTRCD1 G EDTQ
 D ^DIE
 L -^IBT(356.91,IBADG)
EDTQ Q
 ;
SET(IBTRN) ; -- set array
 N IBDGPM,IBICD
 S IBDGPM=$$DGPM^IBTRE3(IBTRN)
 S (IBICD,IBDA,IBCNT)=0
 F  S IBICD=$O(^IBT(356.91,"ADGPM",IBDGPM,IBICD)) Q:'IBICD  S IBDA=0 F  S IBDA=$O(^IBT(356.91,"ADGPM",IBDGPM,IBICD,IBDA)) Q:'IBDA  D
 .Q:'$D(^IBT(356.91,+IBDA,0))
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
 . S IBTNOD=$G(^IBT(356.91,+IBXY(I),0))
 . S IBDATE=$P($P(IBTNOD,U,3),".") ; Procedure date
 . S IBXD=$$ICD0^IBACSV(+$P(IBXY(I),U,2),IBDATE)
 . W !?2,I,"  ",$P(IBXD,U),?15,$E($P(IBXD,U,4),1,43),?60,$$DAT1^IBOUTL(IBDATE)
 Q
 ;
ASK(IBCNT,IBPAR,IBSELDF) ;Ask user to select from list
 ; Input  -- SDCNT    Number of Entities
 ;           SDPAR    Selection Parameters (A=Add)
 ;           SDSELDF  Selection Default  [Optional]
 ; Output -- Selection
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
REASK S DIR("?")="Enter "_$S($G(IBSELDF)]"":"<RETURN> for '"_IBSELDF_"', ",1:"")_$S(IBCNT=1:"1",1:"1-"_IBCNT)_" to Edit"_$S(IBPAR["A":", or 'A' to Add",1:"")
 S DIR("A")="Enter "_$S(IBCNT=1:"1",1:"1-"_IBCNT)_" to Edit"_$S(IBPAR["A":", or 'A' to Add",1:"")_": "_$S($G(IBSELDF)]"":IBSELDF_"// ",1:"")
 S DIR(0)="FAO^1:30"
 D ^DIR I $D(DTOUT)!($D(DUOUT)) S Y="^" G ASKQ
 S Y=$$UPPER^VALM1(Y)
 I Y?.N,Y,Y'>IBCNT G ASKQ
 I IBPAR["A",$E(Y)="A" S Y="Add" G ASKQ
 I Y="" S Y=$S($G(IBSELDF)]"":IBSELDF,1:"Return") G ASKQ
 W !!?5,DIR("?"),".",! G REASK
ASKQ Q $G(Y)
