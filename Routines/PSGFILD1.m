PSGFILD1 ;BIR/CML3-AUTO CANCEL SET UP HELP ;03 AUG 94 / 5:18 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
ENWAI ;
 W:$Y @IOF W !?67,"Page: 1 of 4",! F Q=1:1:18 S X=$P($T(WAI+Q),";",3) W !,X
 R !!,"Press RETURN to continue, enter '^' to end instructions: ",X:DTIME S:'$T X="^" W:'$T $C(7) I X="^" K Q,X Q
 W:$Y @IOF W !?67,"Page: 2 of 4",! F Q=20:1:38 S X=$P($T(WAI+Q),";",3) W !,X
 R !!,"Press RETURN to continue, enter '^' to end instructions: ",X:DTIME S:'$T X="^" W:'$T $C(7) I X="^" K Q,X Q
 G ENWAI^PSGFILD2
 ;
WAI ;
 ;;
 ;;                      ORDER  ACTION  ON  PATIENT  TRANSFER
 ;;
 ;;  The Inpatient Medications package has changed the criteria for the auto
 ;;discontinuing of a patient's IV & Unit Dose orders whenever the patient is
 ;;transferred between wards and/or services.
 ;;  The decision to d/c Inpatient orders is now determined by the site on a
 ;;ward by ward (or service by service) basis.  While this new process will entail
 ;;initial extra set up on the site's part, it will allow the site almost complete
 ;;control of the auto discontinue process.
 ;;  The set up for this process involves three main steps:
 ;;
 ;;1. If your site wishes to have Inpatient orders d/c'd on all or most ward
 ;;transfers, you can have the package automatically set up all wards as 'from'
 ;;and 'to' wards for you, saving some time.  If you choose to do this, all wards
 ;;currently marked as inactive will be included.  Also, if you choose to do so,
 ;;you can still delete, edit, or add 'from' and 'to' wards at any time.  See 
 ;;step 2c for further information.
 ;;
 ;;2. Ward transfers - Select a 'from' ward.  This is a ward from which a patient
 ;;may be transferred.  For each 'from' ward, you can:
 ;; A. Select an 'On Pass' action.  This is the action the Inpatient Medications
 ;;package will take on a patient's orders whenever the patient is transferred
 ;;from the selected 'from' ward to authorized absence less than 96 hours (known
 ;;as 'on pass').  The actions include:
 ;;    1. discontinue the orders
 ;;    2. place the orders on hold
 ;;    3. take no action
 ;; B. Select an 'Authorized Absence' action.  This is the action the Inpatient
 ;;Medications package will take on a patient's orders whenever the patient is
 ;;transferred from the selected 'from' ward to authorized absence greater than
 ;;96 hours.  The actions include:
 ;;    1. discontinue the orders
 ;;    2. place the orders on hold
 ;;    3. take no action
 ;; C. Select the 'To' wards.  Whenever a patient is transferred from the selected
 ;;'from' ward to any of the selected 'to' wards, the patient's IV and Unit Dose
 ;;orders will be d/c'd.  For example, if '1 North' is selected as a 'from'
