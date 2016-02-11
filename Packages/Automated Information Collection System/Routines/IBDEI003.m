IBDEI003 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358)
 ;;=^IBE(358,
 ;;^UTILITY(U,$J,358,0)
 ;;=IMP/EXP ENCOUNTER FORM^358I^98^98
 ;;^UTILITY(U,$J,358,1,0)
 ;;=NATIONAL ADDICTION FY16-Q1^1^National Addiction form October 2015^1^0^1^1^^133^80^7^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,1,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,1,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,1,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,2,0)
 ;;=NATIONAL ADHC FY16-Q1^2^National Adult Day Health Care October 2015^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,3,0)
 ;;=NATIONAL ALLERGY FY16-Q1^1^National Allergy Clinic October 2015^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,3,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,3,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,3,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,3,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,3,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,3,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,3,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,4,0)
 ;;=NATIONAL ANESTHESIA FY16-Q1^0^National Anesthesia October 2015^1^0^1^1^^133^80^6^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,5,0)
 ;;=NATIONAL AUDIO FY16-Q1^1^National Audiology November 2015^1^0^1^1^^133^80^5^1^^1^p^1
 ;;^UTILITY(U,$J,358,5,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,5,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,5,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,5,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,6,0)
 ;;=NATIONAL BLIND REHAB FY16-Q1^0^National Blind Rehab Service Encounter form-Updated October 2015^1^0^0^1^^133^80^2^1^^1^p^1
 ;;^UTILITY(U,$J,358,6,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,6,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,7,0)
 ;;=NATL CARDIOLOGY/CATH FY16-Q1^1^National Cardiology/Card Cath November 2015^1^0^1^1^^133^80^8^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,8,0)
 ;;=NATL CAREGIVER ASSESS FY16-Q1^1^National Care Giver Support October 2015^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,8,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,8,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,8,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,8,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,8,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,8,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,8,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,9,0)
 ;;=NATIONAL CHIROPRACTIC FY16-Q1^2^National Chiropractic November 2015^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,9,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,9,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,10,0)
 ;;=NATIONAL CLC FY16-Q1^2^National Community Living Center October 2015^1^0^1^1^^133^80^20^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,10,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,10,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,10,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,11,0)
 ;;=NATIONAL CLIN PHARM FY16-Q1^2^NATIONAL CLINICAL PHARMACIST-REVIEWED/REVISED October 2015^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,11,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,11,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,12,0)
 ;;=NATIONAL C&P FY16-Q1^2^NATIONAL COMPENSATION AND PENSION-November 2015^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,12,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,12,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,13,0)
 ;;=NATIONAL CRITICAL CARE FY16-Q1^1^National Critical Care Form October 2015^1^0^1^1^^133^80^4^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,13,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,13,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,13,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,13,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,13,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,13,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,13,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,14,0)
 ;;=NATIONAL DAY SURGERY FY16-Q1^0^National Minor Procedures October 2015^1^0^1^1^^133^80^19^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,14,2,0)
 ;;=^358.02I^1^1
