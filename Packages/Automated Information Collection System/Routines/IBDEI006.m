IBDEI006 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358,44,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,44,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,44,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,44,2,5,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,44,2,6,0)
 ;;=6^1
 ;;^UTILITY(U,$J,358,45,0)
 ;;=NATL PREVENTIVE HEALTH FY16-Q2^1^National Preventive Health January 2016^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,45,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,45,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,45,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,45,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,45,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,45,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,45,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,46,0)
 ;;=NATIONAL PRIMARY CARE FY16-Q2^1^National Primary Care Form February 2016^1^0^1^1^^133^80^30^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,46,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,46,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,46,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,46,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,46,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,46,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,46,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,47,0)
 ;;=NATIONAL PULMONARY FY16-Q2^0^National Pulmonary February 2016^1^0^0^1^^133^80^12^1^^1^p^1
 ;;^UTILITY(U,$J,358,47,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,47,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,47,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,48,0)
 ;;=NATIONAL RESP THERAPY FY16-Q2^0^National Repiratory Therapy (PFT/Sleep/Oxygen) February 2016^1^0^1^1^^133^80^12^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,48,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,48,2,1,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,48,2,2,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,49,0)
 ;;=NATIONAL RHEUMATOLOGY FY16-Q2^1^National Rheumatology January 2016^1^0^1^1^^133^80^10^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,49,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,49,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,49,2,2,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,49,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,50,0)
 ;;=NATIONAL SLEEP MED FY16-Q2^0^NATIONAL SLEEP MEDICINE January 2016^1^0^1^1^^133^80^2^0^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,50,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,50,2,1,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,50,2,2,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,51,0)
 ;;=NATIONAL SWS MH FY16-Q2^0^National Social Work Service Mental Health February 2016^1^0^1^1^^133^80^9^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,51,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,51,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,51,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,52,0)
 ;;=NATIONAL TBI FY16-Q2^1^National Traumatic Brain Injury January 2016^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,52,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,52,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,52,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,52,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,52,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,52,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,52,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,53,0)
 ;;=NATIONAL TELEDERM FY16-Q2^0^National Telederm January 2016^1^0^^1^^133^80^6^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,54,0)
 ;;=NATIONAL TELERETINAL FY16-Q2^2^National Teleretinal Exams-February 2016^1^0^1^1^^133^80^12^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,54,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,54,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,54,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,55,0)
 ;;=NATIONAL TRANSPLANT FY16-Q2^0^National Transplant February 2016^1^0^1^1^^133^80^4^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,56,0)
 ;;=NATIONAL URGENT CARE FY16-Q2^2^NATIONAL URGENT CARE February 2016^1^0^0^1^^133^80^30^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,56,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,56,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,56,2,2,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,56,2,3,0)
 ;;=2^1
