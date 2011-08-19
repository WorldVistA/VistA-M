IBCNSA2 ;ALB/NLR - ANNUAL BENEFITS EDIT, DIE CALLS ; 28-MAY-1993
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ED(IBT) ;
 D FULL^VALM1 W !!
 D SAVEAB
 L +^IBA(355.4,+IBCAB):5 I '$T D LOCKED^IBTRCD1 G EDQ
 S DIE="^IBA(355.4,",DA=IBCAB
 S DR=IBT
 D ^DIE K DIE,DIC,DA,DR
 D COMP
 I IBDIF=1 D EDUP
 D EXIT
 L -^IBA(355.4,+IBCAB)
EDQ Q
 ;
SAVEAB ;
 K ^TMP($J,"IBAB")
 S ^TMP($J,"IBAB",355.4,IBCAB,0)=$G(^IBA(355.4,IBCAB,0))
 S ^TMP($J,"IBAB",355.4,IBCAB,1)=$G(^IBA(355.4,IBCAB,1))
 S ^TMP($J,"IBAB",355.4,IBCAB,2)=$G(^IBA(355.4,IBCAB,2))
 S ^TMP($J,"IBAB",355.4,IBCAB,3)=$G(^IBA(355.4,IBCAB,3))
 S ^TMP($J,"IBAB",355.4,IBCAB,4)=$G(^IBA(355.4,IBCAB,4))
 S ^TMP($J,"IBAB",355.4,IBCAB,5)=$G(^IBA(355.4,IBCAB,5))
 Q
COMP ;
 S IBDIF=0
 I $G(^IBA(355.4,IBCAB,0))'=^TMP($J,"IBAB",355.4,IBCAB,0) S IBDIF=1 Q
 I $G(^IBA(355.4,IBCAB,1))'=^TMP($J,"IBAB",355.4,IBCAB,1) S IBDIF=1 Q
 I $G(^IBA(355.4,IBCAB,2))'=^TMP($J,"IBAB",355.4,IBCAB,2) S IBDIF=1 Q
 I $G(^IBA(355.4,IBCAB,3))'=^TMP($J,"IBAB",355.4,IBCAB,3) S IBDIF=1 Q
 I $G(^IBA(355.4,IBCAB,4))'=^TMP($J,"IBAB",355.4,IBCAB,4) S IBDIF=1 Q
 I $G(^IBA(355.4,IBCAB,5))'=^TMP($J,"IBAB",355.4,IBCAB,5) S IBDIF=1 Q
 Q
EDUP ;  -- enter date and user if editing has taken place
 S DIE="^IBA(355.4,",DA=IBCAB
 S DR="1.05///NOW;1.06////"_DUZ
 D ^DIE K DIE,DIC,DA,DR
 Q
CY ;
 D FULL^VALM1 W !!
 S IBYR1=IBYR K IBYR D INIT^IBCNSA
 I $D(VALMQUIT) S IBYR=IBYR1 K VALMQUIT D EXITRP
 I IBYR=IBYR1 D
 .K IBYR1,VALMQUIT D EXITRP
 E  D EXIT
 Q
 ;
 ;
EXIT D HDR^IBCNSA("Annual Benefits"),BLD^IBCNSA
EXITRP K VALMQUIT S VALMBCK="R"
 Q
 ;
DATECHK ; -- called from input transform from annual benefits (355.4,.01)
 ;    make sure benefit years do not overlap
 ;    kills x if not okay
 ;
 Q:'$D(X)
 N BEFORE,AFTER,MINUS,PLUS,ZZ
 S MINUS=X-10000
 S PLUS=X+10000
 I '$G(IBCPOL) S IBCPOL=$P($G(^IBA(355.4,$G(DA),0)),"^",2)
 Q:'IBCPOL
 ;
 ; -- find most recent entry
 S ZZ=-$O(^IBA(355.4,"APY",IBCPOL,""))
 I 'ZZ Q  ;if not prior entires quit.
 ;
 ; -- if x>most recent entry
 I X>ZZ K:X<(ZZ+10000) X Q
 ;
 Q:'$D(X)
 ;
 ; -- find policy date prior to (before or less than) x
 S BEFORE=-$O(^IBA(355.4,"APY",+IBCPOL,-X))
 S AFTER=-$O(^IBA(355.4,"APY",+IBCPOL,-PLUS))
 ;
 I 'BEFORE D  Q
 .I AFTER=X Q
 .I AFTER,AFTER>X K X
 .Q
 ;
 ; -- if it exists,not exactly one year,if within one year of prior year
 I BEFORE D  Q
 .I BEFORE=MINUS Q
 .I BEFORE>MINUS K X Q
 .I X=AFTER Q
 .I AFTER>X K X
 .Q 
 ;
 Q
