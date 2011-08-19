IBARXEU4 ;ALB/AAS - RX COPAY EXEMPTION CHECK IF PREVIOUSLY CANCELED ; 12-JAN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**34**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CANDT ; -- set beginning and ending dates
 ;    input     dfn     =: patient internal number
 ;              ibedt   =: end date to cancel
 ;              ibdt    =: beging date to cancel
 ;
 ;    output    ibcandt =: begin date^end date to cancel
 ;
 N X
 ;S IBCANDT=IBDT_"^"_IBEDT
 ;
 ; -- get last end date
 S X=+$O(^IBA(354.1,"ACAN",DFN,"")) S:X<0 X=-X D:'X CONV ;never previously cancelled
 I X,X>IBDT S IBDT=X
 ;
 ; -- only cancel back 1 year from today, or eff. legislation max
 I IBDT<$$MINUS^IBARXEU0(DT) S IBDT=$$MINUS^IBARXEU0(DT)
 I IBDT<$$STDATE^IBARXEU S IBDT=$$STDATE^IBARXEU
 S IBCANDT=IBDT_"^"_IBEDT
CANDTQ Q
 ;
CONV ; -- see if conversion done
 N X
 S X=$G(^IBE(350.9,1,3)) G:$P(X,"^",14) CONVQ ; conversion complete
 I $P(X,"^",3),DFN<$P(X,"^",4) G CONVQ ; patient already converted
 ;
 ; -- need to convert patient on the fly
 S IBDT=$$STDATE^IBARXEU
CONVQ Q
 ;
ARCAN(DFN,IBSTAT,IBDT,IBEDT) ; -- process cancellation with ar logic here
 ;
 ;   Input =:     dfn      patient internal entry number
 ;             ibstat      patient status from $$rxexmt or $$rxst
 ;               ibdt      beginning date to cancel
 ;              ibedt      ending date to cancel
 ;
 Q:'+IBSTAT  ; non-exempt patient
 ;
 S:IBEDT>DT IBEDT=DT S:IBDT<$$STDATE^IBARXEU IBDT=$$STDATE^IBARXEU
 ;
 ; -- set begin and ending date, check x-ref
 S X=+$O(^IBA(354.1,"ACAN",DFN,"")) S:X<0 X=-X
 I X,X>IBDT S IBDT=X
 ;
 ; -- end date must be after begin date
 I IBDT>IBEDT G ARCANQ
 ;
 ; -- set begin and ending dates in last entry created
 D UPCAN
 ;
 N IBWHER
 S ERR=0,IBWHER=17
 D EN1^PRCAX(DFN,IBDT,IBEDT,.ERR)
 I ERR]"",+ERR'=ERR S ^TMP("IB-ERROR",$J,DFN)=ERR,IBEXERR=10 S:'$D(IBJOB) IBJOB=11 D ^IBAERR K IBEXERR
ARCANQ Q
 ;
UPCAN ; -- update canceled date fields
 N X2
 S DIE="^IBA(354.1,",DR=".13////"_IBDT_";.14////"_IBEDT
 S DA=+$O(^(+$O(^IBA(354.1,"AIVDT",1,DFN,"")),0))
 S X2=$G(^IBA(354.1,DA,0))
 I $P(X2,"^",2)'=DFN!($P(X2,"^",14)) G UPCANQ
 D ^DIE
 K DIC,DIE,DA,DR,X
UPCANQ Q
