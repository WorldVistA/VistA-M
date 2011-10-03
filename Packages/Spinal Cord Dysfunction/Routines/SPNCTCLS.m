SPNCTCLS ;WDE/SD CLOSE OPEN CARE EPISODES 154.1 ;6/18/2002
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 ;   
 ;   
 ;---------------------------------------------------------------------
CHK ;Calling routine SPNFEDT0
 ;
 ;        Called when the user is adding a new outcome to the group
 ;        If the outcome has a record type of outpatient follow up
 ;        then prompt to ask them if they want to close this episode
 ;        If Yes then prompt for date and Assign to all outcomes in 
 ;        this episode
 ;        
 ;        spnxmit=0 for just the one or 1 for all in the group
 ;        spnclose 0 no to close 1 to close    
 ;        Note that spndate is the date recorded asked in the calling rtn
 ;
 S (SPNXMIT,SPNCLOSE,SPNEXIT)=0
 I $P($G(^TMP($J,0)),U,3)'="" S SPNXMIT=0 Q  ;episode is closed
 S %=1 W !,"Do you wish to close this episode of care"
 D YN^DICN
 I %Y["?" W !!,"Enter Yes to close this episode or No to leave it open.",! G CHK
 I %=-1 S SPNEXIT=1 Q
 S SPNYN=$S(%=1:"Y",1:"N")
 I SPNYN="Y" D
 .I $P($G(^TMP($J,0)),U,3)="" S (SPNXMIT,SPNCLOSE)=1 S $P(^TMP($J,0),U,3)=SPNDATE Q
 ;
 I SPNYN="N" S SPNXMIT=0,SPNCLOSE=0  ;spnxmit is = 1 to transmit all outcome
 ;                       ;in the group
 ;                       ;or its set to 0 to just transmit the
        ;                        ;current outcome
 ;I SPNYN="^" S SPNEXIT=1 Q
 ;I SPNYN="" S SPNEXIT=1 Q
 I SPNYN="N" I SPNCT=1 D ZAP^SPNOGRDA G RESTART^SPNCTINA
 I SPNYN="N" I SPNCT=2 D ZAP^SPNOGRDA G RESTART^SPNCTOUA
 Q
 ;-------------------------------------------------------------------
CLOSE ;
 ;loop through 154.1 and get outcomes with the same care date
 S SPNA=0 F  S SPNA=$O(^TMP($J,SPNA)) Q:SPNA=""  S SPNB=0 S SPNB=$O(^TMP($J,SPNA,SPNB)) Q:SPNB=""  S SPNC="" S SPNC=$O(^TMP($J,SPNA,SPNB,SPNC)) Q:SPNC=""  D
 .S SPNFIEN=$P($G(^TMP($J,SPNA,SPNB,SPNC)),U,1)
 .Q:SPNFIEN=""
 .S DIE="^SPNL(154.1,"
 .S DA=SPNFIEN,DR="1002///"_$P($G(^TMP($J,0)),U,3)
 .D ^DIE
 .K DIE,DA,DR
 .Q
 Q
ZAP ;
