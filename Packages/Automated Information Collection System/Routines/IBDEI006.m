IBDEI006 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358,42,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,42,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,42,2,5,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,42,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,43,0)
 ;;=NATIONAL PAIN FY15-Q3^0^National Pain May 2015^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,44,0)
 ;;=NATL PHYSIATRIST INPT FY15-Q3^2^National Inpatient Rehab Physiatrist May 2015^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,44,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,44,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,44,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,44,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,45,0)
 ;;=NATL PHYSIATRIST OTPT FY15-Q3^2^National Rehab Physiatrist Outpatient May 2015^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,45,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,45,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,45,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,45,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,46,0)
 ;;=NATIONAL PLASTIC SURG FY15-Q3^2^National Plastic Surgery April 2015^1^0^1^1^^133^80^5^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,47,0)
 ;;=NATIONAL POD NAIL NURS FY15-Q3^0^National Podiatry Nail Clinic Nursing May 2015^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,47,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,47,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,47,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,47,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,47,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,47,2,5,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,47,2,6,0)
 ;;=6^1
 ;;^UTILITY(U,$J,358,48,0)
 ;;=NATIONAL PODIATRY FY15-Q3^0^National Podiatry May 2015^1^0^1^1^^133^80^5^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,48,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,48,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,48,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,48,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,48,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,48,2,5,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,48,2,6,0)
 ;;=6^1
 ;;^UTILITY(U,$J,358,49,0)
 ;;=NATIONAL PRIMARY CARE FY15-Q3^1^National Primary Care Form May 2015^1^0^1^1^^133^80^11^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,49,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,49,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,49,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,49,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,49,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,49,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,49,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,50,0)
 ;;=NATIONAL PULMONARY FY15-Q3^0^National Pulmonary April 2015^1^0^0^1^^133^80^3^1^^1^p^1
 ;;^UTILITY(U,$J,358,50,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,50,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,50,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,51,0)
 ;;=NATL REC THERAPY GRP FY15-Q3^2^National Recreation Therapy Group May 2015^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,51,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,51,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,51,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,51,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,52,0)
 ;;=NATL REC THERAPY IND FY15-Q3^2^National Recreation Therapy May 2015^1^0^1^1^^133^80^2^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,52,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,52,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,52,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,52,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,53,0)
 ;;=NATL REHAB-PT/OT/KT FY15-Q3^2^National Rehab PT/OT/KT May 2015^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,53,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,53,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,53,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,53,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,54,0)
 ;;=NATIONAL RESP THERAPY FY15-Q3^0^National Repiratory Therapy (PFT/Sleep/Oxygen) March 2015^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,54,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,54,2,1,0)
 ;;=2^1
