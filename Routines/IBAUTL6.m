IBAUTL6 ;AAS/ALB-RX EXEMPTION UTILITY ROUTINE (CONT.);2-NOV-92
 ;;2.0;INTEGRATED BILLING;**34,195**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ADDP ; -- Add patient to file 354
 ; -- Input    : dfn    =  entry in patient file
 ;    returns  : ibadd  =  0 if not added, 1 if added
 ;
 N DINUM,DLAYGO,X
 I '$D(DT) D DT^DICRW
 S IBWHER=11,IBEXERR=""
 S IBADD=0
 I $S('$D(DFN):1,'$D(^IBA(354)):1,$D(^IBA(354,DFN)):1,1:0) G ADDPQ
 K DO,DD,DIC,DR,DA,DIE S DIC="^IBA(354,",DIC(0)="L",DLAYGO=354
 L +^IBA(354,DFN):15 I $T,'$D(^IBA(354,DFN)) S (DINUM,X)=DFN D FILE^DICN I +Y>0 S IBADD=1
 I IBADD'=1 S IBEXERR=9
 L -^IBA(354,DFN)
 ;
ADDPQ K DO,DD,DIC,DR,DIE,DA
 Q
 ;
ADDEX(IBEXREA,IBDT,IBHOW,IBTYPE,IBOLDAUT) ; -- add entry to 354.1 and update
 ;  -- this will become the active entry for this effective date
 ;     other entries for this effective date should be cancelled
 ;     prior to making this call
 ;
 ;  -- input      dfn  =  pt ien (required)
 ;            ibexrea  =  pointer to exemption reason file (required)
 ;               ibdt  =  internal form of effective date (required)
 ;              ibhow  =  1=system added, 2=user override (optional) default =1
 ;             ibtype  =  type of exemption (optional)  default =1 (copay)
 ;           iboldaut  = date (optional)  if defined is the date of a previous exemption status (automatic) that needs to be inactivated
 ;
 ;  -- returns  ibadde = ibexrea^ibdt or null if not added
 ;              iberr  = error if occurs else null
 ;
 L +^IBA(354,DFN):30 I '$T S IBEXERR=1 W:$D(IBTALK)&('$D(ZTQUEUED)) !,"ENTRY LOCKED" G ADDEXQ
A1 I '$D(^IBA(354,DFN,0)) D ADDP G ADDEXQ:$G(IBEXERR)
 ;
 N IBDGMTA,IBDGMTP,IBDGMTF
 I $D(DGMTA) S IBDGMTA=$G(DGMTA),IBDGMTP=$G(DGMTP),IBDGMTF=$G(DGMTINF)
 N X,X1,X2,Y,IBCNT,DGMTA,DGMTP,DGMTINF
 I $D(IBDGMTA) S DGMTA=$G(IBDGMTA),DGMTP=$G(IBDGMTP),DGMTINF=$G(IBDGMTF)
 S IBWHER=12,IBEXERR="",IBADDE=""
 ;
 ;  - one last quick check
 I IBDT'?7N S IBEXERR=3 G ADDEXQ
 I DUZ,$G(^VA(200,+DUZ,0))="" S IBEXERR=8 G ADDEXQ
 ; if DUZ=0, it will be considered as .5 (POSTMASTER) by the input template [IB NEW EXEMPTION]
 ;
 D BEFORE^IBARXEVT ;get prior exemption
 ;
 N IBSTAT,IBEXDA
 S IBSTAT=$P($G(^IBE(354.2,+IBEXREA,0)),"^",4)
 S IBHOW=$S('$D(IBHOW):1,IBHOW="":1,IBHOW>2:1,IBHOW<1:1,1:IBHOW)
 S IBTYPE=$S('$D(IBTYPE):1,IBTYPE="":1,1:IBTYPE)
 ;I '$D(IBACTION) S IBACTION="ADD"
 ;
 ; -- inactivate a current autoexempt of no longer autoexempt
 I $G(IBOLDAUT)?7N D INACT^IBAUTL7(IBOLDAUT) ;I '$D(ZTQUEUED),$D(IBTALK) W !,"Inactivating current non-income based exemption for patient"
 ;
 ; -- if forcing a new entry to correct problems
 I $G(IBFORCE)?7N D INACT^IBAUTL7(IBFORCE)
 ;
 ; -- check for duplicate entry
 I $G(IBOLDAUT)'?7N,$G(IBFORCE)'?7N,$$DUPL() W:'$D(ZTQUEUED)&($D(IBTALK)) !,"Exemption Attempting to Add is a duplicate, nothing added!",! G ADDEXQ
 ;
 ; -- inactivate previous active entries
 D INACT^IBAUTL7(IBDT) I $G(IBEXERR) G ADDEXQ
 ;
 ; -- if no income data from conversion set date = start date
 I $D(IBCONVER),$P($G(^IBE(354.2,+IBEXREA,0)),"^",5)=210 S IBDT=$$STDATE^IBARXEU
 ;
 ; -- add entry
 S DIC="^IBA(354.1,",DIC(0)="L",X=IBDT K DO,DD D FILE^DICN
 S (IBEXDA,DA)=+Y I Y<1 W:'$D(ZTQUEUED)&($D(IBTALK)) !,"Can't add entry to exemption file" S IBEXERR=4 G ADDEXQ
 ;
 ; -- edit new entry
 S DIE="^IBA(354.1,",DR="[IB NEW EXEMPTION]" ; use compiled template
 ;
 ;DR=".02////"_DFN_";.03////"_IBTYPE_";.04////"_IBSTAT_";.05////"_IBEXREA_";.06////"_IBHOW_";.07////"_DUZ_";.08///NOW;.1////1;.11////"_$G(IBASIG)
 ;
 D ^DIE K DIC,DIE,DA,DR
 I $D(Y) S IBEXERR=5 G ADDEXQ
 S IBADDE=IBEXREA_"^"_IBDT
 ;
 ; --if effective date is in last 365 days make current
 I IBDT>$$MINUS^IBARXEU0(DT) D CURREX^IBAUTL7(IBSTAT,IBDT) I $G(IBEXERR) G ADDEXQ
 ;
 I '$D(ZTQUEUED),$G(IBADDE),$D(IBTALK) W !!,"Medication Copayment Exemption Status Updated: ",$P(^IBE(354.2,+IBADDE,0),"^"),"   ",$$DAT1^IBOUTL($P(IBADDE,"^",2))
 ; -- setup and call event driver
 I '$D(IBCONVER) D  ;if not from conversion do following
 .D AFTER^IBARXEVT
 .S IBEVT=$$RXST^IBARXEU(DFN,$S(IBDT<$$STDATE^IBARXEU:$$STDATE^IBARXEU,1:IBDT))
 .D ^IBARXEVT
 .I IBSTAT D CANCEL^IBARXEU3 ;exempt patient cancel old charges
 .D ^IBARXEB ; process bulletins and alerts
 ;
ADDEXQ ;
 L -^IBA(354,DFN)
 I $G(IBEXERR) D ^IBAERR
 K DO,DD,DIC,DIE,DA,DR,IBEVT,IBEVTP,IBEVTA,IBASIG,IBARCAN
 Q
 ;
DUPL() ; -- see if entry is a duplicate
 N X,Y
 S X=0
 S Y=$$LST^IBARXEU0(DFN,IBDT)
 I IBDT=+Y,+IBEXREA=+$P(Y,"^",5),IBTYPE=$P(Y,"^",3) S X=1
 Q X
