IBDEI003 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358)
 ;;=^IBE(358,
 ;;^UTILITY(U,$J,358,0)
 ;;=IMP/EXP ENCOUNTER FORM^358I^57^57
 ;;^UTILITY(U,$J,358,1,0)
 ;;=NATIONAL ADDICTION FY14-Q4^1^National Addiction form July 2014^1^0^1^1^^133^80^4^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,1,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,1,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,1,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,2,0)
 ;;=NATIONAL ALLERGY FY14-Q4^1^National Allergy Clinic June 2014^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,2,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,2,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,2,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,2,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,2,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,2,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,2,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,3,0)
 ;;=NATIONAL ANESTHESIA FY14-Q4^0^National Anesthesia August 2014^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,4,0)
 ;;=NATIONAL AUDIO FY14-Q4^1^National Audiology July 2014^1^0^1^1^^133^80^3^1^^1^p^1
 ;;^UTILITY(U,$J,358,4,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,4,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,4,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,4,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,5,0)
 ;;=NATIONAL CARD CATH FY14-Q4^1^National Cardiac Cath/Interventional Rad August 2014^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,6,0)
 ;;=NATL HT NURSE FY14-Q4^0^National CCHT Nursing August 2014^1^0^^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,7,0)
 ;;=NATL HT SWS FY14-Q4^0^National CCHT Social Work Services August 2014^1^0^^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,8,0)
 ;;=NATIONAL CHIROPRACTIC FY14-Q4^2^National Chiropractic June 2014^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,8,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,8,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,9,0)
 ;;=NATIONAL CLC FY14-Q4^2^National Community Living Center August 2014^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,9,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,9,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,9,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,10,0)
 ;;=NATIONAL C&P FY14-Q4^2^NATIONAL COMPENSATION AND PENSION-June 2014^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,10,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,10,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,11,0)
 ;;=NATIONAL CRITICAL CARE FY14-Q4^1^National Critical Care Form August 2014^1^0^1^1^^133^80^8^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,11,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,11,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,11,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,11,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,11,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,11,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,11,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,12,0)
 ;;=NATIONAL DAY SURGERY FY14-Q4^0^National Minor Procedures July 2014^1^0^1^1^^133^80^5^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,12,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,12,2,1,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,13,0)
 ;;=NATIONAL DERMATOLOGY FY14-Q4^0^National Derm Form-June 2014^1^0^^1^^133^80^7^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,14,0)
 ;;=NATIONAL DIABETES FY14-Q4^2^NATIONAL DIABETES-July 2014^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,14,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,14,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,14,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,15,0)
 ;;=NATIONAL EMP HEALTH FY14-Q4^1^National Employee Health June 2014^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,15,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,15,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,15,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,15,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,15,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,15,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,15,2,6,0)
 ;;=5^1
