IBDEI0FW ; ; 03-MAY-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 03, 2022
 Q:'DIFQR(358.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.6)
 ;;=^IBE(358.6,
 ;;^UTILITY(U,$J,358.6,0)
 ;;=IMP/EXP PACKAGE INTERFACE^358.6I^11^11
 ;;^UTILITY(U,$J,358.6,1,0)
 ;;=DG SELECT VISIT TYPE CPT PROCEDURES^VSIT^IBDFN4^SCHEDULING^^3^2^^1^^^1^2^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,1,1,0)
 ;;=^^1^1^2941116^^^^
 ;;^UTILITY(U,$J,358.6,1,1,1,0)
 ;;=Allows for select of just Visit type CPT codes from the CPT file.
 ;;^UTILITY(U,$J,358.6,1,2)
 ;;=CODE^5^RECOMMENDED TEXT-SHORT NAME^40^RECOMMENDED HEADER^30^SHORT NAME FROM CPT FILE^28^^^^^^^^^1^1
 ;;^UTILITY(U,$J,358.6,1,3)
 ;;=SELECT TYPE OF VISIT CPT
 ;;^UTILITY(U,$J,358.6,1,11)
 ;;=D TESTVST^IBDFN7
 ;;^UTILITY(U,$J,358.6,1,15,0)
 ;;=^357.615I^4^3
 ;;^UTILITY(U,$J,358.6,1,15,2,0)
 ;;=RECOMMENDED TEXT-SHORT NAME^40^2
 ;;^UTILITY(U,$J,358.6,1,15,3,0)
 ;;=RECOMMENDED HEADER^30^3
 ;;^UTILITY(U,$J,358.6,1,15,4,0)
 ;;=SHORT NAME FROM CPT FILE^28^4
 ;;^UTILITY(U,$J,358.6,2,0)
 ;;=INPUT VISIT TYPE^^^PATIENT CARE ENCOUNTER^^1^^^1^^^1^^^^SMP
 ;;^UTILITY(U,$J,358.6,2,1,0)
 ;;=^^1^1^2951023^
 ;;^UTILITY(U,$J,358.6,2,1,1,0)
 ;;=Used for inputting the visit type that applies to the visit.
 ;;^UTILITY(U,$J,358.6,2,2)
 ;;=^^^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,2,3)
 ;;=VISIT TYPE OF VISIT
 ;;^UTILITY(U,$J,358.6,2,9)
 ;;=D INPUTCPT^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,2,10)
 ;;=Enter an active Visit Type code.
 ;;^UTILITY(U,$J,358.6,2,11)
 ;;=D TESTVST^IBDFN7
 ;;^UTILITY(U,$J,358.6,2,12)
 ;;=ENCOUNTER^5
 ;;^UTILITY(U,$J,358.6,2,14)
 ;;=S Y=$$DSPLYCPT^IBDFN9(Y)
 ;;^UTILITY(U,$J,358.6,2,15,0)
 ;;=^357.615I^0^0
 ;;^UTILITY(U,$J,358.6,2,17)
 ;;=D SLCTVST^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,2,18)
 ;;=S IBDF("OTHER")="357.69^I '$P(^(0),U,4)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Visit Type (EM) Code")
 ;;^UTILITY(U,$J,358.6,2,19)
 ;;=D VST^IBDFN14(X)
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
 ;;^UTILITY(U,$J,358.6,6,0)
 ;;=DG SELECT ICD-10 DIAGNOSIS CODES^ICD10^IBDFN4^SCHEDULING^^3^2^^1^^^1^7^^^^1^1^^^^30
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
 ;;^UTILITY(U,$J,358.6,9,12)
 ;;=PROCEDURE^1^6^7^3^2
 ;;^UTILITY(U,$J,358.6,9,13,0)
 ;;=^358.613V^2^2
 ;;^UTILITY(U,$J,358.6,9,13,1,0)
 ;;=1;IBD(358.98,^^0
 ;;^UTILITY(U,$J,358.6,9,13,2,0)
 ;;=2;IBD(358.98,^^0
 ;;^UTILITY(U,$J,358.6,9,14)
 ;;=S Y=$$DSPLYCPT^IBDFN9(Y)
 ;;^UTILITY(U,$J,358.6,9,15,0)
 ;;=^357.615I^0^0
 ;;^UTILITY(U,$J,358.6,9,17)
 ;;=D SLCTCPT^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,9,18)
 ;;=S IBDF("OTHER")="81^I '$P(^(0),U,4)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"CPT Procedure Code")
 ;;^UTILITY(U,$J,358.6,9,19)
 ;;=D CPT^IBDFN14(X)
 ;;^UTILITY(U,$J,358.6,10,0)
 ;;=PX SELECT HEALTH FACTORS^HF^IBDFN10^PATIENT CARE ENCOUNTER^^3^2^^1^^^1^11
 ;;^UTILITY(U,$J,358.6,10,1,0)
 ;;=^^1^1^2951208^^^
 ;;^UTILITY(U,$J,358.6,10,1,1,0)
 ;;=Allows health factors from the HEALTH FACTORS file to be selected.
 ;;^UTILITY(U,$J,358.6,10,2)
 ;;=Internal Number^9^^^^^^^^^^^^^^^0^0
 ;;^UTILITY(U,$J,358.6,10,3)
 ;;=PATIENT HEALTH FACTORS
 ;;^UTILITY(U,$J,358.6,10,11)
 ;;=D TESTHF^PXAPIIB
 ;;^UTILITY(U,$J,358.6,10,15,0)
 ;;=^357.615I^4^4
 ;;^UTILITY(U,$J,358.6,10,15,1,0)
 ;;=Health Factor Name^30^2^^HEALTH FACTOR
 ;;^UTILITY(U,$J,358.6,10,15,2,0)
 ;;=Code^5^3
 ;;^UTILITY(U,$J,358.6,10,15,3,0)
 ;;=Short Name^10^5
 ;;^UTILITY(U,$J,358.6,10,15,4,0)
 ;;=Sex Specific^6^6^^FOR
 ;;^UTILITY(U,$J,358.6,10,16)
 ;;=n^^^^n
 ;;^UTILITY(U,$J,358.6,11,0)
 ;;=PX INPUT HEALTH FACTORS^^^PATIENT CARE ENCOUNTER^^1^^^1^^^1^^^^SMP
 ;;^UTILITY(U,$J,358.6,11,1,0)
 ;;=^^1^1^2951208^^^
 ;;^UTILITY(U,$J,358.6,11,1,1,0)
 ;;=Used for inputting health factors determined to apply to the patient.
 ;;^UTILITY(U,$J,358.6,11,2)
 ;;=^^^^^^^^^^^^^^^^^0
 ;;^UTILITY(U,$J,358.6,11,3)
 ;;=HEALTH FACTORS
 ;;^UTILITY(U,$J,358.6,11,10)
 ;;=Enter a Patient Health Factor.
 ;;^UTILITY(U,$J,358.6,11,11)
 ;;=D TESTHF^PXAPIIB
 ;;^UTILITY(U,$J,358.6,11,12)
 ;;=HEALTH FACTORS^1^^^2
 ;;^UTILITY(U,$J,358.6,11,13,0)
 ;;=^358.613V^3^3
 ;;^UTILITY(U,$J,358.6,11,13,1,0)
 ;;=10;IBD(358.98,^^0
 ;;^UTILITY(U,$J,358.6,11,13,2,0)
 ;;=11;IBD(358.98,^^0
 ;;^UTILITY(U,$J,358.6,11,13,3,0)
 ;;=12;IBD(358.98,^^0
 ;;^UTILITY(U,$J,358.6,11,14)
 ;;=S Y=$$DSPLYHF^PXAPIIB(Y)
 ;;^UTILITY(U,$J,358.6,11,15,0)
 ;;=^357.615I^0^0
 ;;^UTILITY(U,$J,358.6,11,17)
 ;;=D SLCTHF^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,11,18)
 ;;=S IBDF("OTHER")="9999999.64^I '$P(^(0),U,10),$P(^(0),U,10)=""F"",'$P(^(0),U,11)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Health Factors")
 ;;^UTILITY(U,$J,358.6,11,19)
 ;;=D HF^IBDFN14(X)
