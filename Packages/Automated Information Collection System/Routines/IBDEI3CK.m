IBDEI3CK ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.6)
 ;;=^IBE(358.6,
 ;;^UTILITY(U,$J,358.6,0)
 ;;=IMP/EXP PACKAGE INTERFACE^358.6I^11^11
 ;;^UTILITY(U,$J,358.6,1,0)
 ;;=DPT PATIENT'S NAME^VADPT^IBDFN^REGISTRATION^1^2^1^1^1^^^1
 ;;^UTILITY(U,$J,358.6,1,1,0)
 ;;=^^2^2^2930212^^^^
 ;;^UTILITY(U,$J,358.6,1,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,358.6,1,1,2,0)
 ;;=Patient's Name
 ;;^UTILITY(U,$J,358.6,1,2)
 ;;=Patient's Name^30^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,1,3)
 ;;=PATIENT NAME
 ;;^UTILITY(U,$J,358.6,1,7,0)
 ;;=^357.67^1^1
 ;;^UTILITY(U,$J,358.6,1,7,1,0)
 ;;=DFN
 ;;^UTILITY(U,$J,358.6,1,15,0)
 ;;=^357.615I^0^0
 ;;^UTILITY(U,$J,358.6,2,0)
 ;;=DPT PATIENT'S PID^VADPT^IBDFN^REGISTRATION^1^2^1^1^1^^^1
 ;;^UTILITY(U,$J,358.6,2,1,0)
 ;;=^^1^1^2931015^^
 ;;^UTILITY(U,$J,358.6,2,1,1,0)
 ;;=Used to display the patient identifier.
 ;;^UTILITY(U,$J,358.6,2,2)
 ;;=PATIENT IDENTIFIER^15^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,2,3)
 ;;=PATIENT IDENTIFIER PID
 ;;^UTILITY(U,$J,358.6,2,7,0)
 ;;=^357.67^1^1
 ;;^UTILITY(U,$J,358.6,2,7,1,0)
 ;;=DFN
 ;;^UTILITY(U,$J,358.6,2,15,0)
 ;;=^357.615I^0^0
 ;;^UTILITY(U,$J,358.6,3,0)
 ;;=DPT PATIENT'S DOB/AGE^VADPT^IBDFN^REGISTRATION^1^2^2^^1^^^1
 ;;^UTILITY(U,$J,358.6,3,1,0)
 ;;=^^2^2^2951023^
 ;;^UTILITY(U,$J,358.6,3,1,1,0)
 ;;=Patient's DOB in MM DD, YYYY format
 ;;^UTILITY(U,$J,358.6,3,1,2,0)
 ;;=Patient's age in years.
 ;;^UTILITY(U,$J,358.6,3,2)
 ;;=Patient's DOB^12^Patient's Age^3^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,3,3)
 ;;=PATIENT DOB AGE PIMS
 ;;^UTILITY(U,$J,358.6,3,7,0)
 ;;=^357.67^1^1
 ;;^UTILITY(U,$J,358.6,3,7,1,0)
 ;;=DFN
 ;;^UTILITY(U,$J,358.6,3,15,0)
 ;;=^357.615I^1^1
 ;;^UTILITY(U,$J,358.6,3,15,1,0)
 ;;=Patient's Age^3^2^
 ;;^UTILITY(U,$J,358.6,4,0)
 ;;=DG SELECT ICD-10 DIAGNOSIS CODES^ICD10^IBDFN4^SCHEDULING^^3^2^^1^^^1^5^^^^1^1^^^^30
 ;;^UTILITY(U,$J,358.6,4,1,0)
 ;;=^^2^2^3140327
 ;;^UTILITY(U,$J,358.6,4,1,1,0)
 ;;=Allows the user to select ICD-10 diagnosis codes from the ICD Diagnosis
 ;;^UTILITY(U,$J,358.6,4,1,2,0)
 ;;=file. Allows only active codes to be selected.
 ;;^UTILITY(U,$J,358.6,4,2)
 ;;=CODE^8^^^^^^^^^^^^^^^1^1
 ;;^UTILITY(U,$J,358.6,4,3)
 ;;=SELECT ICD10 ICD-10 CODES DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,4,9)
 ;;=D INPICD10^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,4,11)
 ;;=D TESTICD0^IBDFN7
 ;;^UTILITY(U,$J,358.6,4,12)
 ;;=^^^^^
 ;;^UTILITY(U,$J,358.6,4,13,0)
 ;;=^357.613V^2^2
 ;;^UTILITY(U,$J,358.6,4,13,1,0)
 ;;=1;IBD(358.98,^^^^^^^
 ;;^UTILITY(U,$J,358.6,4,13,2,0)
 ;;=2;IBD(358.98,^^^^^^^
 ;;^UTILITY(U,$J,358.6,4,15,0)
 ;;=^357.615I^2^2
 ;;^UTILITY(U,$J,358.6,4,15,1,0)
 ;;=DIAGNOSIS^60^2^^DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,4,15,2,0)
 ;;=DESCRIPTION^200^3^^DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,4,16)
 ;;=o^2^Diagnosis^^r^3^ICD-10 Code^^1
 ;;^UTILITY(U,$J,358.6,4,17)
 ;;=D SLCTDX10^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,4,19)
 ;;=D DX10^IBDFN14(X)
 ;;^UTILITY(U,$J,358.6,5,0)
 ;;=INPUT DIAGNOSIS CODE (ICD10)^^^PATIENT CARE ENCOUNTER^^1^^^1^^^1^^^^SMP^^^1^^^
 ;;^UTILITY(U,$J,358.6,5,1,0)
 ;;=^^1^1^3140327
 ;;^UTILITY(U,$J,358.6,5,1,1,0)
 ;;=Used for inputting ICD10 diagnosis codes.
 ;;^UTILITY(U,$J,358.6,5,2)
 ;;=^^^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,5,3)
 ;;=INPUT ICD10 ICD-10 DIAGNOSIS CODES
 ;;^UTILITY(U,$J,358.6,5,9)
 ;;=D INPICD10^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,5,10)
 ;;=Enter at least two characters of an active ICD10 diagnosis code.
 ;;^UTILITY(U,$J,358.6,5,11)
 ;;=D TESTICD0^IBDFN7
 ;;^UTILITY(U,$J,358.6,5,12)
 ;;=DIAGNOSIS/PROBLEM^1^13^14^2^
