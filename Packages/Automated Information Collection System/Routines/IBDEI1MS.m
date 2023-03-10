IBDEI1MS ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.6,6,1,0)
 ;;=^^2^2^3140327
 ;;^UTILITY(U,$J,358.6,6,1,1,0)
 ;;=Allows the user to select ICD-10 diagnosis codes from the ICD Diagnosis
 ;;^UTILITY(U,$J,358.6,6,1,2,0)
 ;;=file. Allows only active codes to be selected.
 ;;^UTILITY(U,$J,358.6,6,2)
 ;;=CODE^8^^^^^^^^^^^^^^^1^1
 ;;^UTILITY(U,$J,358.6,6,3)
 ;;=SELECT ICD10 ICD-10 CODES DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,6,9)
 ;;=D INPICD10^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,6,11)
 ;;=D TESTICD0^IBDFN7
 ;;^UTILITY(U,$J,358.6,6,12)
 ;;=^^^^^
 ;;^UTILITY(U,$J,358.6,6,13,0)
 ;;=^357.613V^2^2
 ;;^UTILITY(U,$J,358.6,6,13,1,0)
 ;;=1;IBD(358.98,^^^^^^^
 ;;^UTILITY(U,$J,358.6,6,13,2,0)
 ;;=2;IBD(358.98,^^^^^^^
 ;;^UTILITY(U,$J,358.6,6,15,0)
 ;;=^357.615I^2^2
 ;;^UTILITY(U,$J,358.6,6,15,1,0)
 ;;=DIAGNOSIS^60^2^^DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,6,15,2,0)
 ;;=DESCRIPTION^200^3^^DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,6,16)
 ;;=o^2^Diagnosis^^r^3^ICD-10 Code^^1
 ;;^UTILITY(U,$J,358.6,6,17)
 ;;=D SLCTDX10^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,6,19)
 ;;=D DX10^IBDFN14(X)
 ;;^UTILITY(U,$J,358.6,7,0)
 ;;=INPUT DIAGNOSIS CODE (ICD10)^^^PATIENT CARE ENCOUNTER^^1^^^1^^^1^^^^SMP^^^1^^^
 ;;^UTILITY(U,$J,358.6,7,1,0)
 ;;=^^1^1^3140327
 ;;^UTILITY(U,$J,358.6,7,1,1,0)
 ;;=Used for inputting ICD10 diagnosis codes.
 ;;^UTILITY(U,$J,358.6,7,2)
 ;;=^^^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,7,3)
 ;;=INPUT ICD10 ICD-10 DIAGNOSIS CODES
 ;;^UTILITY(U,$J,358.6,7,9)
 ;;=D INPICD10^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,7,10)
 ;;=Enter at least two characters of an active ICD10 diagnosis code.
 ;;^UTILITY(U,$J,358.6,7,11)
 ;;=D TESTICD0^IBDFN7
 ;;^UTILITY(U,$J,358.6,7,12)
 ;;=DIAGNOSIS/PROBLEM^1^13^14^2^
 ;;^UTILITY(U,$J,358.6,7,13,0)
 ;;=^357.613V^10^10
 ;;^UTILITY(U,$J,358.6,7,13,1,0)
 ;;=1;IBD(358.98,^^1^^^^^2
 ;;^UTILITY(U,$J,358.6,7,13,2,0)
 ;;=2;IBD(358.98,^^1^^^^^2
 ;;^UTILITY(U,$J,358.6,7,13,3,0)
 ;;=3;IBD(358.98,^^1^^^^^9
 ;;^UTILITY(U,$J,358.6,7,13,4,0)
 ;;=1;IBE(358.99,^^0^^^^^
 ;;^UTILITY(U,$J,358.6,7,13,5,0)
 ;;=4;IBD(358.98,^^1^^^^^10
 ;;^UTILITY(U,$J,358.6,7,13,6,0)
 ;;=5;IBD(358.98,^^1^^^^^11
 ;;^UTILITY(U,$J,358.6,7,13,7,0)
 ;;=6;IBD(358.98,^^1^^^^^12
 ;;^UTILITY(U,$J,358.6,7,13,8,0)
 ;;=7;IBD(358.98,^^1^^^^^5
 ;;^UTILITY(U,$J,358.6,7,13,9,0)
 ;;=8;IBD(358.98,^^1^^^^^6
 ;;^UTILITY(U,$J,358.6,7,13,10,0)
 ;;=9;IBD(358.98,^^1^^^^^6
 ;;^UTILITY(U,$J,358.6,7,14)
 ;;=S Y=$$DSPICD10^IBDFN9(Y)
 ;;^UTILITY(U,$J,358.6,7,16)
 ;;=^^^^^^^^
 ;;^UTILITY(U,$J,358.6,7,17)
 ;;=D SLCTDX10^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,7,18)
 ;;=S IBDF("OTHER")="80^I '$P(^(0),U,9)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"ICD-10 Diagnosis Code")
 ;;^UTILITY(U,$J,358.6,7,19)
 ;;=D DX10^IBDFN14(X)
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
 ;;=^357.615I^2^2
 ;;^UTILITY(U,$J,358.6,8,15,1,0)
 ;;=SHORT NAME^28^2^^PROCEDURE
 ;;^UTILITY(U,$J,358.6,8,15,2,0)
 ;;=DESCRIPTION^161^3^^PROCEDURE
 ;;^UTILITY(U,$J,358.6,8,16)
 ;;=o^4^Procedure Narrative^^r^5^CPT CODE^1
