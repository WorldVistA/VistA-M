PRCPURS2 ;WISC/RFJ-select dates ;24 May 93
 ;;5.1;IFCAP;**84**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DATESEL(V1) ;  select starting and ending dates in days
 ;  returns datestrt and dateend
 N %,%DT,%H,%I,DEFAULT,X,Y
 K DATEEND,DATESTRT
START S Y=$E(DT,1,5)_"01" D DD^%DT S DEFAULT=Y
 S %DT("A")="Start with "_$S(V1'="":V1_" ",1:"")_"Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 S DATESTRT=Y
 S Y=DT D DD^%DT S DEFAULT=Y
 S %DT("A")="  End with "_$S(V1'="":V1_" ",1:"")_"Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 I Y<DATESTRT W !,"END DATE MUST BE GREATER THAN OR EQUAL TO THE START DATE.",! G START
 S DATEEND=Y,Y=DATESTRT D DD^%DT
 W !?5,"***  Selected date range from ",Y," to " S Y=DATEEND D DD^%DT W Y,"  ***"
 Q
 ;
 ;
MONTHSEL ;  select starting and ending dates in months
 ;  returns datestrt and dateend
 ; modified 5/27/05 to actually restrict selections to month & year
 ; and return DATESTRT as 1st of beginning month and DATEEND as last day of ending month. - T. Holloway
 N %,%DT,%H,%I,DEFAULT,PRCLP,PRCMN,X,Y
 K DATEEND,DATESTRT
START1 S X1=DT,X2=-90 D C^%DTC S Y=$E(X,1,5)_"00" D DD^%DT S DEFAULT=Y
 S %DT("A")="Start with Date: ",%DT("B")=DEFAULT,%DT="AEPM",%DT(0)=-DT D ^%DT I Y<0 Q
 S DATESTRT=Y
 S Y=$E(DT,1,5)_"00" D DD^%DT S DEFAULT=Y
 S %DT("A")="  End with Date: ",%DT("B")=DEFAULT,%DT="AEPM",%DT(0)=-DT D ^%DT I Y<0 Q
 I Y<DATESTRT W !,"END DATE MUST BE GREATER THAN OR EQUAL TO THE START DATE.",! G START1
 S PRCLP=$$LEAP^DIDTC($E(Y,1,3)),PRCMN=+$E(Y,4,5),DATESTRT=DATESTRT+1
 S DATEEND=$E(Y,1,5)_$P("31^28^31^30^31^30^31^31^30^31^30^31","^",PRCMN) ; set end date to last day of month
 S:PRCMN=2 DATEEND=DATEEND+PRCLP ; if February and Leap Year, add 1 to get 29th
 S:DATEEND>DT DATEEND=DT-1 ; if end month is current month, set DATEEND to yesterday
 I $E(DATEEND,6,7)="00" W !,"  You may not include the current month until at least 1 full day",!,"  has passed.",! G START1
 S Y=DATESTRT D DD^%DT
 W !?5,"***  Selected date range from ",Y," to " S Y=DATEEND D DD^%DT W Y,"  ***"
 Q
