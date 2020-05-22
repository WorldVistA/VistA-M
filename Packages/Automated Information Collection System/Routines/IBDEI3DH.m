IBDEI3DH ; ; 05-NOV-2019
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;NOV 05, 2019
 Q:'DIFQR(358.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.6,9,11)
 ;;=D TESTICD0^IBDFN7
 ;;^UTILITY(U,$J,358.6,9,12)
 ;;=DIAGNOSIS/PROBLEM^1^13^14^2^
 ;;^UTILITY(U,$J,358.6,9,13,0)
 ;;=^357.613V^10^10
 ;;^UTILITY(U,$J,358.6,9,13,1,0)
 ;;=1;IBD(358.98,^^1^^^^^2
 ;;^UTILITY(U,$J,358.6,9,13,2,0)
 ;;=2;IBD(358.98,^^1^^^^^2
 ;;^UTILITY(U,$J,358.6,9,13,3,0)
 ;;=3;IBD(358.98,^^1^^^^^9
 ;;^UTILITY(U,$J,358.6,9,13,4,0)
 ;;=3;IBE(358.99,^^0^^^^^
 ;;^UTILITY(U,$J,358.6,9,13,5,0)
 ;;=4;IBD(358.98,^^1^^^^^10
 ;;^UTILITY(U,$J,358.6,9,13,6,0)
 ;;=5;IBD(358.98,^^1^^^^^11
 ;;^UTILITY(U,$J,358.6,9,13,7,0)
 ;;=6;IBD(358.98,^^1^^^^^12
 ;;^UTILITY(U,$J,358.6,9,13,8,0)
 ;;=7;IBD(358.98,^^1^^^^^5
 ;;^UTILITY(U,$J,358.6,9,13,9,0)
 ;;=8;IBD(358.98,^^1^^^^^6
 ;;^UTILITY(U,$J,358.6,9,13,10,0)
 ;;=9;IBD(358.98,^^1^^^^^6
 ;;^UTILITY(U,$J,358.6,9,14)
 ;;=S Y=$$DSPICD10^IBDFN9(Y)
 ;;^UTILITY(U,$J,358.6,9,16)
 ;;=^^^^^^^^
 ;;^UTILITY(U,$J,358.6,9,17)
 ;;=D SLCTDX10^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,9,18)
 ;;=S IBDF("OTHER")="80^I '$P(^(0),U,9)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"ICD-10 Diagnosis Code")
 ;;^UTILITY(U,$J,358.6,9,19)
 ;;=D DX10^IBDFN14(X)
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
