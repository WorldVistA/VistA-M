IBARXEU5 ;AAS/ALB - RX EXEMPTION UTILITY ROUTINE (CONT.) ; 2-NOV-92
 ;;2.0;INTEGRATED BILLING;**20,112,153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DIFF ; -- supported call for mas
 ; -- compare current exemption reason and date with what currently
 ;    computes from the patient record.  Automatically update if needed.
 ;    input:  dfn  = patient to update
 ;            Ibdt = date of change (optional, default is dt)
 ;    output: none
 ;
 N I,J,X,Y,IBADDE,IBEXDA,IBMESS,IBDT,IBX,IBEXREAN,IBEXREAO,IBFORCE,IBOLDAUT,IBJOB,IBWHER
 S IBJOB=16,IBWHER=14
 G:'$G(DFN) DIFFQ
 I $G(IBDT)'?7N S IBDT=DT
 ;
 ; -- if not already in file, wait until an rx is issued
 I '$G(^IBA(354,DFN,0)) G DIFFQ
 ;
 ; -- compute old exemption reason, exemption date
 S IBX=$G(^IBA(354,DFN,0)),IBEXREAO=$P(IBX,"^",5)_"^"_$P(IBX,"^",3)
 I $P($G(^IBE(354.2,+IBEXREAO,0)),"^",5)=2010 G DIFFQ ; is hardship don't update
 ; -- compute new exemption reason
 S IBEXREAN=$$STATUS^IBARXEU1(DFN,IBDT)
 ;
 ; -- quit if not current exemption
 I $$PLUS^IBARXEU0($P(IBEXREAN,"^",2))<DT G DIFFQ
 ;
 ; -- quit if same exemption reason
 I +IBEXREAN=+IBEXREAO G DIFFQ
 ;
 ; -- not same so update
 D UP1^IBARXEPV
 ;I $L($P($G(^IBE(354.2,+IBEXREAN,0)),"^",5))>2 D OLDAUT^IBARXEX1(IBEXREAN)
 ;S IBFORCE=$P(IBEXREAN,"^",2)
 ;D MOSTR($P(IBEXREAN,"^",2),+IBEXREAN)
 ;D ADDEX^IBAUTL6(+IBEXREAN,$P(IBEXREAN,"^",2),1,1,IBOLDAUT)
 ;
DIFFQ Q
 ;
MTCOMP(STATUS,IBDATA) ; -- compare income determination with current mt status
 ;
 I '$$NETW^IBARXEU1 G MTCOMP ; don't use net worth in computation
 ;
 N IBEXREA,CODE S IBEXREA=""
 ;
 ; -- incomplete and required tests are no data
 ;I CODE="I"!(CODE="R") S IBEXREA=210 G MTDONE
 S X=$P(IBDATA,"^",3) I X=1!(X=3)!(X=9)!(X=10)!($P(IBDATA,"^",14)) S IBEXREA=$S($P(IBDATA,"^",14):110,1:210) G MTDONE
 ;
 ; -- quit if not pending adjuducation
 I +STATUS'=3 G MTCOMPQ
 ;
 S CODE=$$CODE^IBAMTED1(IBDATA)
 ;
 ; -- see if mt or income test was adjudicated
 ;    if not sent to ajudication is non-exempt
 ;    if made exempt or cat a is hardship
 I $P(IBDATA,"^",10)="",$P(IBDATA,"^",19)=1 S IBEXREA=$S(CODE="P":130,CODE="C":110,CODE="A":2010,1:"") ; means test logic
 ;
 I $P(IBDATA,"^",10)="",$P(IBDATA,"^",19)=2 S IBEXREA=$S(CODE="P":130,CODE="N":110,CODE="E":2010,1:"") ; income test logic
 ;
 ; -- if adjudicated cat a set to exempt if means test set to non-exempt
 I 'IBEXREA,$P(IBDATA,"^",19)=1 S IBEXREA=$S($$CODE^IBAMTED1(IBDATA)="A":150,$$CODE^IBAMTED1(IBDATA)="C":140,1:"") ; means test logic
 ;
 I 'IBEXREA,$P(IBDATA,"^",19)=2 S IBEXREA=$S($$CODE^IBAMTED1(IBDATA)="E":150,$$CODE^IBAMTED1(IBDATA)="N":140,1:"") ; income test logic
 ;
MTDONE I IBEXREA S $P(STATUS,"^",3)=$O(^IBE(354.2,"ACODE",+IBEXREA,0))
 ;
MTCOMPQ Q $P(STATUS,"^",3)_"^"_$P(STATUS,"^",2)
 ;
MOSTR(X1,IBEXREA) ; -- if status date is most recent but last exemption date
 ;            is later, inactivate last exemption
 ;
 ; -- input X1 = date of most recent status (+dgmta from event driver)
 ;          IBEXREA= point to 354.2 for new exemption
 ;
 ; -- will define IBOLDAUT if not already defined
 ;
 Q:+$G(X1)'?7N
 Q:$G(IBOLDAUT)?7N
 Q:$L($P($G(^IBE(354.2,+IBEXREA,0)),"^",5))'=3  ; only for income exemptions
 N X
 S X=$$LSTAC^IBARXEU0(DFN) ; x =most recent exemption reason ^ date
 Q:+X1'<$P(X,"^",2)  ;test date is less than most recent exemption date
 Q:+X1'>$$MINUS^IBARXEU0(DT)  ; exemption date > year ago - don't inactivate more recent exemptions
 ;
 ; -- get last test date
 S Y=$G(^DGMT(408.31,+$$LST^DGMTCOU1(DFN,DT,3),0))
 ;
 ; -- if most recent test date is this test inactivate exemption
 I +X1=+Y S IBOLDAUT=$P(X,"^",2)
 Q
 ;
REGAUTO ; -- will automatically update in background autoexempt
 ;    called from registration
 ;
 S ZTREQ="@" ; always called as task, delete task
 G:'$G(DFN) REGQ
 N I,J,X,Y,IBEXREA,IBNSTAT,IBFORCE,IBOLDAUT,IBJOB
 S IBJOB=16
 S IBEXREA=$P($G(^IBA(354,DFN,0)),"^",5)
 I $P($G(^IBE(354.2,+IBEXREA,0)),"^",5)=2010 G REGQ ; don't overwrite hardships
 S IBNSTAT=$$STATUS^IBARXEU1(DFN,DT)
 I IBEXREA=+IBNSTAT G REGQ ; computes to same as on file
 ;
 ; -- not same must force new entry
 L +^IBA(354,DFN)
 D OLDAUT^IBARXEX1(IBNSTAT)
 S IBFORCE=$P(IBNSTAT,"^",2)
 D ADDEX^IBAUTL6(+IBNSTAT,$P(IBNSTAT,"^",2),1,1,$G(IBOLDAUT))
 L -^IBA(354,DFN)
REGQ Q
