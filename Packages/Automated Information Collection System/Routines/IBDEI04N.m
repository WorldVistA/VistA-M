IBDEI04N ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.6)
 ;;=^IBE(358.6,
 ;;^UTILITY(U,$J,358.6,0)
 ;;=IMP/EXP PACKAGE INTERFACE^358.6I^5^5
 ;;^UTILITY(U,$J,358.6,1,0)
 ;;=DG SELECT ICD-10 DIAGNOSIS CODES^ICD10^IBDFN4^SCHEDULING^^3^2^^1^^^1^2^^^^1^1^^^^30
 ;;^UTILITY(U,$J,358.6,1,1,0)
 ;;=^^2^2^3140327
 ;;^UTILITY(U,$J,358.6,1,1,1,0)
 ;;=Allows the user to select ICD-10 diagnosis codes from the ICD Diagnosis
 ;;^UTILITY(U,$J,358.6,1,1,2,0)
 ;;=file. Allows only active codes to be selected.
 ;;^UTILITY(U,$J,358.6,1,2)
 ;;=CODE^8^^^^^^^^^^^^^^^1^1
 ;;^UTILITY(U,$J,358.6,1,3)
 ;;=SELECT ICD10 ICD-10 CODES DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,1,9)
 ;;=D INPICD10^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,1,11)
 ;;=D TESTICD0^IBDFN7
 ;;^UTILITY(U,$J,358.6,1,12)
 ;;=^^^^^
 ;;^UTILITY(U,$J,358.6,1,13,0)
 ;;=^357.613V^2^2
 ;;^UTILITY(U,$J,358.6,1,13,1,0)
 ;;=1;IBD(358.98,^^^^^^^
 ;;^UTILITY(U,$J,358.6,1,13,2,0)
 ;;=2;IBD(358.98,^^^^^^^
 ;;^UTILITY(U,$J,358.6,1,15,0)
 ;;=^357.615I^2^2
 ;;^UTILITY(U,$J,358.6,1,15,1,0)
 ;;=DIAGNOSIS^60^2^^DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,1,15,2,0)
 ;;=DESCRIPTION^200^3^^DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,1,16)
 ;;=o^2^Diagnosis^^r^3^ICD-10 Code^^1
 ;;^UTILITY(U,$J,358.6,1,17)
 ;;=D SLCTDX10^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,1,19)
 ;;=D DX10^IBDFN14(X)
 ;;^UTILITY(U,$J,358.6,2,0)
 ;;=INPUT DIAGNOSIS CODE (ICD10)^^^PATIENT CARE ENCOUNTER^^1^^^1^^^1^^^^SMP^^^1^^^
 ;;^UTILITY(U,$J,358.6,2,1,0)
 ;;=^^1^1^3140327
 ;;^UTILITY(U,$J,358.6,2,1,1,0)
 ;;=Used for inputting ICD10 diagnosis codes.
 ;;^UTILITY(U,$J,358.6,2,2)
 ;;=^^^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,2,3)
 ;;=INPUT ICD10 ICD-10 DIAGNOSIS CODES
 ;;^UTILITY(U,$J,358.6,2,9)
 ;;=D INPICD10^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,2,10)
 ;;=Enter at least two characters of an active ICD10 diagnosis code.
 ;;^UTILITY(U,$J,358.6,2,11)
 ;;=D TESTICD0^IBDFN7
 ;;^UTILITY(U,$J,358.6,2,12)
 ;;=DIAGNOSIS/PROBLEM^1^13^14^2^
 ;;^UTILITY(U,$J,358.6,2,13,0)
 ;;=^357.613V^10^10
 ;;^UTILITY(U,$J,358.6,2,13,1,0)
 ;;=1;IBD(358.98,^^1^^^^^2
 ;;^UTILITY(U,$J,358.6,2,13,2,0)
 ;;=2;IBD(358.98,^^1^^^^^2
 ;;^UTILITY(U,$J,358.6,2,13,3,0)
 ;;=3;IBD(358.98,^^1^^^^^9
 ;;^UTILITY(U,$J,358.6,2,13,4,0)
 ;;=1;IBE(358.99,^^0^^^^^
 ;;^UTILITY(U,$J,358.6,2,13,5,0)
 ;;=4;IBD(358.98,^^1^^^^^10
 ;;^UTILITY(U,$J,358.6,2,13,6,0)
 ;;=5;IBD(358.98,^^1^^^^^11
 ;;^UTILITY(U,$J,358.6,2,13,7,0)
 ;;=6;IBD(358.98,^^1^^^^^12
 ;;^UTILITY(U,$J,358.6,2,13,8,0)
 ;;=7;IBD(358.98,^^1^^^^^5
 ;;^UTILITY(U,$J,358.6,2,13,9,0)
 ;;=8;IBD(358.98,^^1^^^^^6
 ;;^UTILITY(U,$J,358.6,2,13,10,0)
 ;;=9;IBD(358.98,^^1^^^^^6
 ;;^UTILITY(U,$J,358.6,2,14)
 ;;=S Y=$$DSPICD10^IBDFN9(Y)
 ;;^UTILITY(U,$J,358.6,2,16)
 ;;=^^^^^^^^
 ;;^UTILITY(U,$J,358.6,2,17)
 ;;=D SLCTDX10^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,2,18)
 ;;=S IBDF("OTHER")="80^I '$P(^(0),U,9)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"ICD-10 Diagnosis Code")
 ;;^UTILITY(U,$J,358.6,2,19)
 ;;=D DX10^IBDFN14(X)
 ;;^UTILITY(U,$J,358.6,3,0)
 ;;=DPT PATIENT'S NAME^VADPT^IBDFN^REGISTRATION^1^2^1^1^1^^^1
 ;;^UTILITY(U,$J,358.6,3,1,0)
 ;;=^^2^2^2930212^^^^
 ;;^UTILITY(U,$J,358.6,3,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,358.6,3,1,2,0)
 ;;=Patient's Name
 ;;^UTILITY(U,$J,358.6,3,2)
 ;;=Patient's Name^30^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,3,3)
 ;;=PATIENT NAME
 ;;^UTILITY(U,$J,358.6,3,7,0)
 ;;=^357.67^1^1
 ;;^UTILITY(U,$J,358.6,3,7,1,0)
 ;;=DFN
 ;;^UTILITY(U,$J,358.6,3,15,0)
 ;;=^357.615I^0^0
 ;;^UTILITY(U,$J,358.6,4,0)
 ;;=DPT PATIENT'S PID^VADPT^IBDFN^REGISTRATION^1^2^1^1^1^^^1
 ;;^UTILITY(U,$J,358.6,4,1,0)
 ;;=^^1^1^2931015^^
 ;;^UTILITY(U,$J,358.6,4,1,1,0)
 ;;=Used to display the patient identifier.
 ;;^UTILITY(U,$J,358.6,4,2)
 ;;=PATIENT IDENTIFIER^15^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,4,3)
 ;;=PATIENT IDENTIFIER PID
 ;;^UTILITY(U,$J,358.6,4,7,0)
 ;;=^357.67^1^1
 ;;^UTILITY(U,$J,358.6,4,7,1,0)
 ;;=DFN
 ;;^UTILITY(U,$J,358.6,4,15,0)
 ;;=^357.615I^0^0
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
 ;;=^357.67^1^1
 ;;^UTILITY(U,$J,358.6,5,7,1,0)
 ;;=DFN
 ;;^UTILITY(U,$J,358.6,5,15,0)
 ;;=^357.615I^1^1
 ;;^UTILITY(U,$J,358.6,5,15,1,0)
 ;;=Patient's Age^3^2^
