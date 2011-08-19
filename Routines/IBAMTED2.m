IBAMTED2 ;ALB/GN - RX COPAY TEST EVENT DRIVER - Z06 EXEMPTION PROCESSING ; 6/5/04 2:32pm
 ;;2.0;INTEGRATED BILLING;**269**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;IB*2*269 add this new API to handle updating IVM converted RX Copay
 ;         Tests via Z06 transmissions.
 ;
 ;
EN N IBAD,IBADDE,IBADD,IBDT,IBEXREA,IBAUTO,IBAX,IBAX1,IBOLDAUT,IBWHER
 N IBEXERR,IBJOB,IBON,IBAFY,IBATYP,IBBDT,IBCANDT,IBCHRG,IBCODA,IBCODP
 N IBCRES,IBDEPEN,IBFAC,IBIL,IBL,IBAST,IBLDT,IBN,IBND,IBNN,IBNOW
 N IBPARNT,IBPARNT1,IBSEQNO,IBSITE,IBUNIT
 N DA,DR,DIC,DIE,I,J,X,Y,X1
 ;
 ;
 ;check if add and/or delete of a Z06 was performed by ^EASPREC7
 I DGMTACT="UPL",+DGMTA,'$G(EASZ06D) D ADD
 I DGMTACT="DEL",+DGMTP,$G(EASZ06D) D DEL
 Q
 ;
ADD ;quit if before start date
 Q:+$$PLUS^IBARXEU0(+DGMTA)<$$STDATE^IBARXEU
 ;
 ;if no patient add patient
 I '+$G(^IBA(354,DFN,0)) D ADDP^IBAUTL6 I $G(IBEXERR) D ^IBAERR  Q
 ;
 ;see if last reason is auto type and save date, used by ADDEX tag
 N IB0 S IB0=$$LSTAC^IBARXEU0(DFN)
 I $L(+IB0)=2,$P(IB0,"^",2)>+DGMTA S IBOLDAUT=$P(IB0,"^",2)
 ;
 ;set IVM converted case to reason: Income>Threshold (Not Exempt)
 S IBEXREA=$O(^IBE(354.2,"ACODE",110,0))
 ;
 ;inactivate most recent exemption test
 D MOSTR^IBARXEU5(+DGMTA,+IBEXREA)
 ;
 ;add new IVM converted test
 D ADDEX^IBAUTL6(+IBEXREA,+DGMTA,1,1,$G(IBOLDAUT))
 ;
 Q
 ;
DEL ; Converted Copay test deleted.  Now inactivate that exemption for
 ; that date & update current exemption status for this date
 ;
 ;force inactivate entries for deleted date
 N IBFORCE
 Q:'$D(^IBA(354.1,"AIVDT",1,DFN,-DGMTP))
 S IBFORCE=+DGMTP
 ;
 ;test in DGMT(408.31) has been deleted at this point, now get
 ;the last test that remains on file in order to activate it
 S IBEXREA=$$STATUS^IBARXEU1(DFN,+DGMTP)
 S IBSTAT=$P($G(^IBE(354.2,+IBEXREA,0)),"^",4)
 ;
 ;if last date is older than 1 year, then cancel prior exemption
 ;cancel prior exemption with a no exemption
 I $$PLUS^IBARXEU0($P(IBEXREA,"^",2))<DT D  Q
 . D ADDEX^IBAUTL6(+$O(^IBE(354.2,"ACODE",210,0)),+DGMTP)
 ;
 ;else, add correct exemption and update current status
 D ADDEX^IBAUTL6(+IBEXREA,+$P(IBEXREA,"^",2))
 Q
