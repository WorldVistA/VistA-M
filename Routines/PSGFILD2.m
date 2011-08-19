PSGFILD2 ;BIR/CML3-AUTO CANCEL HELP (CONT.) ;03 AUG 94 / 5:18 PM
 ;;5.0; INPATIENT MEDICATIONS ;**41**;16 DEC 97
 ;
ENWAI ;
 W:$Y @IOF W !?67,"Page: 3 of 4",! F Q=1:1:18 S X=$P($T(WAI+Q),";",3) W !,X
 R !!,"Press RETURN to continue, enter '^' to end instructions: ",X:DTIME S:'$T X="^" W:'$T $C(7) I X="^" K Q,X Q
 W:$Y @IOF W !?67,"Page: 4 of 4",! F Q=19:1:36 S X=$P($T(WAI+Q),";",3) W !,X
 R !!,"Press RETURN to continue: ",X:DTIME K Q,X Q
 ;
WAI ;
 ;;ward and '1 South' is selected as a 'to' ward, any time a patient is transferred
 ;;FROM 1 North TO 1 South, the patient's Inpatient orders will be discontinued.
 ;;
 ;;  This process is 'one way' only.  For example, if your site also wants orders
 ;;to be d/c'd whenever a patient is transferred FROM 1 South TO 1 North, you
 ;;will have to enter 1 South as a 'from' ward and then enter 1 North as one of
 ;;its 'to' wards.  An example for when this would be useful might be to have
 ;;orders d/c'd when patients are transferred from Medicine wards to Surgery wards,
 ;;but not d/c'd when patients are transferred from Surgery wards to Medicine
 ;;wards.
 ;;
 ;;3. Service transfers - Select a 'from' service.  This is a service from which
 ;;a patient may be transferred.  For each 'from' service, you can:
 ;; A. Select the 'To' services.  Whenever a patient is transferred from the
 ;;selected 'from' service to any of the selected 'to' services, the patient's IV
 ;;and Unit Dose orders will be d/c'd.  For example, if 'Medicine' is
 ;;selected as a 'from' service and 'Surgery' is selected as a 'to' service, any
 ;;time a patient is transferred FROM Medicine TO Surgery, the patient's Inpatient
 ;;orders will be discontinued.
 ;;  This process is also 'one way' only.  For example, if your site also wants
 ;;orders to be d/c'd whenever a patient is transferred FROM Surgery TO Medicine,
 ;;you will have to enter Surgery as a 'from' service and then enter Medicine as
 ;;one of its 'to' services.
 ;;  If all of your wards are set for auto d/c, it is not necessary to enter
 ;;services.
 ;;
 ;;  If there is a specific ward or service for which your site does not want
 ;;Inpatient orders d/c'd, you need only delete the 'to' ward or service.
 ;;
 ;;  Inpatient orders are always automatically d/c'd whenever the patient is
 ;;admitted, discharged, or transferred to unauthorized absence.
