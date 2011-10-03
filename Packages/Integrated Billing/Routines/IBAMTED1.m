IBAMTED1 ;ALB/AAS - MEANS TEST EVENT DRIVER - EXEMPTION PROCESSING ; 18-DEC-92
 ;;2.0;INTEGRATED BILLING;**15,112,153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN N IBAD,IBADDE,IBADD,IBDT,IBEXREA,IBAUTO,IBAX,IBAX1,IBOLDAUT,IBWHER,IBEXERR,IBJOB,IBON
 N IBAFY,IBATYP,IBBDT,IBCANDT,IBCHRG,IBCODA,IBCODP,IBCRES,IBDEPEN,IBFAC,IBIL,IBL,IBAST,IBLDT,IBN,IBND,IBNN,IBNOW,IBPARNT,IBPARNT1,IBSEQNO,IBSITE,IBUNIT
 N DA,DR,DIC,DIE,I,J,X,Y,X1
 ;
 S IBON=$$ON^IBARXEU0 I IBON<1 G ENQ
 S IBJOB=12,IBWHER=13
 ;
 ; -- quit if nothing different (except completion date)
 Q:'$D(DGMTA)!('$D(DGMTP))
 I $P(DGMTA,"^",1,5)=$P(DGMTP,"^",1,5),$P(DGMTA,"^",10,20)=$P(DGMTP,"^",10,20) Q
 I DGMTA]"",DGMTP]"",DGMTACT="DEL" Q  ; IVM 'delete' transmission
 ;
 ; -- quit if invoked from ib=>mt=>ib
 Q:$D(IBEVT)
 ;
 ; -- quit if before start date
 I +DGMTA G ENQ:+$$PLUS^IBARXEU0(+DGMTA)<$$STDATE^IBARXEU
 I +DGMTP G ENQ:+$$PLUS^IBARXEU0(+DGMTP)<$$STDATE^IBARXEU
 ;
 ;
 I '$D(ZTQUEUED),$D(IBTALK) W !,"Determining Medication Co-Payment Exemption"
 ;
 ; -- if no patient add patient
 I '+$G(^IBA(354,DFN,0)) D ADDP^IBAUTL6 I $G(IBEXERR) G ENQ
 ;
 D AUTO I IBAUTO'="" G ENQ
 ;
 ; -- not auto exempt any more see if is more current auto status
 S X=$$LSTAC^IBARXEU0(DFN) I $L(+X)=2,$P(X,"^",2)>+DGMTA S IBOLDAUT=$P(X,"^",2)
 ; -- if mean test is required or no longer required
 ;    or copay test is incomplete or no longer applicable
 ;    add exemption of no income data
 S X=$P(DGMTA,"^",3) I X=1!(X=3)!(X=10)!(X=9)!($P(DGMTA,"^",14)) D AEX G ENQ
 ;
 I "^ADD^DEL^EDT^ADJ^STA^CAT^COM^UPL^DUP^"[DGMTACT D @DGMTACT
 ;
ENQ ; -- exit copay exemption creation
 I $G(IBEXERR) D ^IBAERR
 I $D(IBADDE),$D(IBTALK) W !!,"Medication Copayment Exemption Status Updated: ",$P(^IBE(354.2,+IBADDE,0),"^"),"   ",$$DAT1^IBOUTL($P(IBADDE,"^",2))
 Q
 ;
ADD ; -- adding a new test
 I DGMTACT="ADD" D AEX
 ;
ADDQ Q
 ;
AEX ; -- add exemption logic
 ;    DO NOT USER FOR AUTOMATICS
 ;
 S IBEXREA=""
 ;
 ; -- if means test required, no longer required,
 ;    or copay test incomplete or no longer applicable
 ;    set up no income data exemption if not automatic.
 ;
 S X=$P(DGMTA,"^",3) I X=1!(X=3)!(X=10)!(X=9)!($P(DGMTA,"^",14)) S IBEXREA=$O(^IBE(354.2,"ACODE",$S($P(DGMTA,"^",14):110,1:210),0))
 ;
 ;
 I $$NETW^IBARXEU1,'IBEXREA S IBEXREA=+$$MTCOMP^IBARXEU5($$INCDT^IBARXEU1(DGMTA),DGMTA)
 I '$$NETW^IBARXEU1,'IBEXREA S IBEXREA=+$P($$INCDT^IBARXEU1(DGMTA),"^",3)
 ;
 ; -- make sure more recent exemption than current test date is inactivetd
 D MOSTR^IBARXEU5(+DGMTA,+IBEXREA)
 D ADDEX^IBAUTL6(+IBEXREA,+DGMTA,1,1,$G(IBOLDAUT))
 Q
 ;
UPL ; -- uploading an IVM-verified means test
DUP ; -- deleting an IVM-verified means test
EDT ; -- editing an old means test
 ;    if data different attempt to add new test
 I DGMTA=DGMTP G EDITQ
 D AEX
EDITQ Q
 ;
DEL ; -- means test deleted
 ;    find exemption for date and inactivate
 ;    update current exemption status
 ;
 N IBFORCE
 Q:'$D(^IBA(354.1,"AIVDT",1,DFN,-DGMTP))
 S IBFORCE=+DGMTP ; force inactivate entries for deleted date
 ;
 S IBEXREA=$$STATUS^IBARXEU1(DFN,+DGMTP),IBSTAT=$P($G(^IBE(354.2,+IBEXREA,0)),"^",4)
 ;
 ; -- cancel prior exemption with a no data exemption if last date older than 1 year
 I $$PLUS^IBARXEU0($P(IBEXREA,"^",2))<DT D ADDEX^IBAUTL6(+$O(^IBE(354.2,"ACODE",210,0)),+DGMTP) G DELQ
 ;
 ; -- add correct exemption and update current status
 D ADDEX^IBAUTL6(+IBEXREA,+$P(IBEXREA,"^",2))
DELQ Q
 ;
COM ; -- complete a required means test
CAT ; -- category change
STA ; -- status change
ADJ ; -- means test adjudication
 ;
 S IBAX1=$$CODE(DGMTP),IBAX=$$CODE(DGMTA)
 ;
 I $$NETW^IBARXEU1,IBAX1="P",IBAX'="P" D  G ADJQ ;treat as an adjudication
 .I $P(DGMTA,"^",19)=1 S IBEXREA=$S(IBAX="C":140,IBAX="A":150,1:"") ; means test codes
 .I $P(DGMTA,"^",19)=2 S IBEXREA=$S(IBAX="N":140,IBAX="E":150,1:"") ; copay exemption test
 .S IBEXREA=$O(^IBE(354.2,"ACODE",+IBEXREA,0))
 .Q:'$G(IBEXREA)
 .D ADDEX^IBAUTL6(IBEXREA,+DGMTA,1,1)
 .Q
 ;
 ;I $P(DGMTA,"^",19)=1,IBAX1="C",IBAX="A" D ADDEX^IBAUTL6($O(^IBE(354.2,"ACODE",2010,0)),+DGMTA) G ADJQ ;is a means test hardship
 ;
 I $P(DGMTA,"^",19)=2,IBAX1="N",IBAX="E" D ADDEX^IBAUTL6($O(^IBE(354.2,"ACODE",2010,0)),+DGMTA) G ADJQ ;is income test hardship
 ;
 D AEX
 ;
ADJQ Q
 ;
CODE(TEST) ; -- return means test status
 I '$G(TEST) S TEST=""
 Q $P($G(^DG(408.32,+$P(TEST,"^",3),0)),"^",2)
 ;
AUTO ; -- if auto status patient
 ;       add auto exemption if needed
 S IBDT=$S(+DGMTA:+DGMTA,+DGMTP:+DGMTP,1:"")
 S IBAUTO=$$AUTOST^IBARXEU1(DFN,IBDT) I IBAUTO'="" D  G AUTOQ
 .S X=$$RXST^IBARXEU(DFN,IBDT)
 .I X=""!($$PLUS^IBARXEU0($P(X,"^",5))<DT) S IBAD=1 D ADDEX^IBAUTL6(+IBAUTO,DT) Q  ; add exemption if none or old
 .I $P(X,"^",3)'=$P($G(^IBE(354.2,+IBAUTO,0)),"^",5) S IBAD=1 D ADDEX^IBAUTL6(+IBAUTO,IBDT) Q  ; if computes different add new exemption
 ;
AUTOQ Q
