IBDEI1GI ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.6,4,7,1,0)
 ;;=DFN
 ;;^UTILITY(U,$J,358.6,5,0)
 ;;=DPT PATIENT'S DOB/AGE^VADPT^IBDFN^REGISTRATION^1^2^2^^1^^^1
 ;;^UTILITY(U,$J,358.6,5,1,0)
 ;;=^^2^2^2951023^
 ;;^UTILITY(U,$J,358.6,5,1,1,0)
 ;;=Patient's DOB in MM DD, YYYY format
 ;;^UTILITY(U,$J,358.6,5,1,2,0)
 ;;=Patient's age in years.
 ;;^UTILITY(U,$J,358.6,5,2)
 ;;=Patient's DOB^12^Patient's Age^3^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,5,3)
 ;;=PATIENT DOB AGE PIMS
 ;;^UTILITY(U,$J,358.6,5,7,0)
 ;;=^358.67^1^1
 ;;^UTILITY(U,$J,358.6,5,7,1,0)
 ;;=DFN
 ;;^UTILITY(U,$J,358.6,5,15,0)
 ;;=^358.615I^1^1
 ;;^UTILITY(U,$J,358.6,5,15,1,0)
 ;;=Patient's Age^3^2
 ;;^UTILITY(U,$J,358.6,6,0)
 ;;=DG SELECT VISIT TYPE CPT PROCEDURES^VSIT^IBDFN4^SCHEDULING^^3^2^^1^^^1^7^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,6,1,0)
 ;;=^^1^1^2941116^^^^
 ;;^UTILITY(U,$J,358.6,6,1,1,0)
 ;;=Allows for select of just Visit type CPT codes from the CPT file.
 ;;^UTILITY(U,$J,358.6,6,2)
 ;;=CODE^5^RECOMMENDED TEXT-SHORT NAME^40^RECOMMENDED HEADER^30^SHORT NAME FROM CPT FILE^28^^^^^^^^^1^1
 ;;^UTILITY(U,$J,358.6,6,3)
 ;;=SELECT TYPE OF VISIT CPT
 ;;^UTILITY(U,$J,358.6,6,11)
 ;;=D TESTVST^IBDFN7
 ;;^UTILITY(U,$J,358.6,6,15,0)
 ;;=^358.615I^4^3
 ;;^UTILITY(U,$J,358.6,6,15,2,0)
 ;;=RECOMMENDED TEXT-SHORT NAME^40^2
 ;;^UTILITY(U,$J,358.6,6,15,3,0)
 ;;=RECOMMENDED HEADER^30^3
 ;;^UTILITY(U,$J,358.6,6,15,4,0)
 ;;=SHORT NAME FROM CPT FILE^28^4
 ;;^UTILITY(U,$J,358.6,7,0)
 ;;=INPUT VISIT TYPE^^^PATIENT CARE ENCOUNTER^^1^^^1^^^1^^^^SMP
 ;;^UTILITY(U,$J,358.6,7,1,0)
 ;;=^^1^1^2951023^
 ;;^UTILITY(U,$J,358.6,7,1,1,0)
 ;;=Used for inputting the visit type that applies to the visit.
 ;;^UTILITY(U,$J,358.6,7,2)
 ;;=^^^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,7,3)
 ;;=VISIT TYPE OF VISIT
 ;;^UTILITY(U,$J,358.6,7,9)
 ;;=D INPUTCPT^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,7,10)
 ;;=Enter an active Visit Type code.
 ;;^UTILITY(U,$J,358.6,7,11)
 ;;=D TESTVST^IBDFN7
 ;;^UTILITY(U,$J,358.6,7,12)
 ;;=ENCOUNTER^5
 ;;^UTILITY(U,$J,358.6,7,14)
 ;;=S Y=$$DSPLYCPT^IBDFN9(Y)
 ;;^UTILITY(U,$J,358.6,7,17)
 ;;=D SLCTVST^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,7,18)
 ;;=S IBDF("OTHER")="357.69^I '$P(^(0),U,4)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Visit Type (EM) Code")
 ;;^UTILITY(U,$J,358.6,7,19)
 ;;=D VST^IBDFN14(X)
 ;;^UTILITY(U,$J,358.6,8,0)
 ;;=DG SELECT CPT PROCEDURE CODES^CPT^IBDFN4^SCHEDULING^^3^2^^1^^^1^9^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,8,1,0)
 ;;=^^2^2^2961007^^^^
 ;;^UTILITY(U,$J,358.6,8,1,1,0)
 ;;=Allows for the selection of CPT codes from the CPT file. Only active codes
 ;;^UTILITY(U,$J,358.6,8,1,2,0)
 ;;=are allowed.
 ;;^UTILITY(U,$J,358.6,8,2)
 ;;=CODE^5^SHORT NAME^28^DESCRIPTION^161^^^^^^^^^^CODE^1^1
 ;;^UTILITY(U,$J,358.6,8,3)
 ;;=SELECT CPT PROCEDURE CODES
 ;;^UTILITY(U,$J,358.6,8,9)
 ;;=S X=$$CPT^IBDFN12(X)
 ;;^UTILITY(U,$J,358.6,8,11)
 ;;=D TESTCPT^IBDFN7
 ;;^UTILITY(U,$J,358.6,8,15,0)
 ;;=^358.615I^2^2
 ;;^UTILITY(U,$J,358.6,8,15,1,0)
 ;;=SHORT NAME^28^2^^PROCEDURE
 ;;^UTILITY(U,$J,358.6,8,15,2,0)
 ;;=DESCRIPTION^161^3^^PROCEDURE
 ;;^UTILITY(U,$J,358.6,8,16)
 ;;=o^4^Procedure Narrative^^r^5^CPT CODE^1
 ;;^UTILITY(U,$J,358.6,9,0)
 ;;=INPUT PROCEDURE CODE (CPT4)^^^PATIENT CARE ENCOUNTER^^1^4^^1^0^^1^^^^SMP
 ;;^UTILITY(U,$J,358.6,9,1,0)
 ;;=^^1^1^2960205^^^^
 ;;^UTILITY(U,$J,358.6,9,1,1,0)
 ;;=Used for inputting CPT coded procedures performed on the patient.
 ;;^UTILITY(U,$J,358.6,9,2)
 ;;=^^^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,9,3)
 ;;=CPT4 PROCEDURE CODES
 ;;^UTILITY(U,$J,358.6,9,9)
 ;;=D INPUTCPT^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,9,10)
 ;;=Enter an active CPT procedure code.
 ;;^UTILITY(U,$J,358.6,9,11)
 ;;=D TESTCPT^IBDFN7
