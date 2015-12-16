IBDEI005 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358,26,0)
 ;;=NATIONAL OB/GYN FY15-Q4^2^NATIONAL OB/GYN July 2015^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,27,0)
 ;;=NATIONAL ORTHOPEDICS FY15-Q4^0^National Orthopedics August 2015^1^0^1^1^^133^80^6^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,27,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,27,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,27,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,27,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,27,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,27,2,5,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,27,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,28,0)
 ;;=NATIONAL PAIN FY15-Q4^0^National Pain July 2015^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,29,0)
 ;;=NATIONAL PLASTIC SURG FY15-Q4^2^National Plastic Surgery July 2015^1^0^1^1^^133^80^5^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,30,0)
 ;;=NATIONAL PODIATRY FY15-Q4^0^National Podiatry July 2015^1^0^1^1^^133^80^5^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,30,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,30,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,30,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,30,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,30,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,30,2,5,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,30,2,6,0)
 ;;=6^1
 ;;^UTILITY(U,$J,358,31,0)
 ;;=NATIONAL POLYTRAUMA FY15-Q4^1^National Polytrauma August 2015^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,31,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,31,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,31,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,31,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,31,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,31,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,31,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,32,0)
 ;;=NATIONAL PRIMARY CARE FY15-Q4^1^National Primary Care Form July 2015^1^0^1^1^^133^80^11^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,32,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,32,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,32,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,32,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,32,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,32,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,32,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,33,0)
 ;;=NATIONAL PULMONARY FY15-Q4^0^National Pulmonary August 2015^1^0^0^1^^133^80^4^1^^1^p^1
 ;;^UTILITY(U,$J,358,33,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,33,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,33,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,34,0)
 ;;=NATIONAL RESP THERAPY FY15-Q4^0^National Repiratory Therapy (PFT/Sleep/Oxygen) August 2015^1^0^1^1^^133^80^4^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,34,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,34,2,1,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,34,2,2,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,35,0)
 ;;=NATIONAL SOCIAL WORK FY15-Q4^1^National Social Work Service (other than MH) Form July 2015^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,35,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,35,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,35,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,35,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,35,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,35,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,35,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,36,0)
 ;;=NATIONAL SPEECH FY15-Q4^1^National Speech August 2015^1^0^1^1^^133^80^2^1^^1^p^1
 ;;^UTILITY(U,$J,358,36,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,36,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,36,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,36,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,37,0)
 ;;=NATIONAL SWS MH FY15-Q4^0^National Social Work Service Mental Health August 2015^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,37,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,37,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,37,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,38,0)
 ;;=NATIONAL TBI FY15-Q4^1^National Traumatic Brain Injury July 2015^1^0^1^1^^133^80^3^1^^1^p^1^2.1
