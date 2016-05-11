IBDEI003 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358)
 ;;=^IBE(358,
 ;;^UTILITY(U,$J,358,0)
 ;;=IMP/EXP ENCOUNTER FORM^358I^60^60
 ;;^UTILITY(U,$J,358,1,0)
 ;;=NATIONAL ADDICTION FY16-Q2^1^National Addiction form February 2016^1^0^1^1^^133^80^9^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,1,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,1,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,1,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,2,0)
 ;;=NATIONAL ANESTHESIA FY16-Q2^0^National Anesthesia January 2016^1^0^1^1^^133^80^6^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,3,0)
 ;;=NATIONAL AUDIO FY16-Q2^1^National Audiology February 2016^1^0^1^1^^133^80^5^1^^1^p^1
 ;;^UTILITY(U,$J,358,3,2,0)
 ;;=^358.02I^3^3
 ;;^UTILITY(U,$J,358,3,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,3,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,3,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,4,0)
 ;;=NATL CARDIOLOGY/CATH FY16-Q2^1^National Cardiology/Card Cath January 2016^1^0^1^1^^133^80^8^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,5,0)
 ;;=NATIONAL CHIROPRACTIC FY16-Q2^2^National Chiropractic February 2016^1^0^1^1^^133^80^4^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,5,2,0)
 ;;=^358.02I^1^1
 ;;^UTILITY(U,$J,358,5,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,6,0)
 ;;=NATIONAL CLC FY16-Q2^2^National Community Living Center January 2016^1^0^1^1^^133^80^20^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,6,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,6,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,6,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,7,0)
 ;;=NATIONAL DERMATOLOGY FY16-Q2^0^National Derm Form-January 2016^1^0^^1^^133^80^9^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,8,0)
 ;;=NATIONAL DIABETES FY16-Q2^2^NATIONAL DIABETES-February 2016^1^0^1^1^^133^80^3^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,8,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,8,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,8,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,9,0)
 ;;=NATIONAL DIALYSIS FY16-Q2^2^National Dialysis February 2016^1^0^1^1^^133^80^7^1^^1^p^1^3
 ;;^UTILITY(U,$J,358,9,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,9,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,9,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,10,0)
 ;;=NATIONAL ED FY16-Q2^1^National Emergency Dept Form January 2016^1^0^1^1^^133^80^31^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,10,2,0)
 ;;=^358.02I^6^6
 ;;^UTILITY(U,$J,358,10,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,10,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,10,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,10,2,4,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,10,2,5,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,10,2,6,0)
 ;;=5^1
 ;;^UTILITY(U,$J,358,11,0)
 ;;=NATIONAL EMP HEALTH FY16-Q2^1^National Employee Health February 2016^1^0^1^1^^133^80^5^1^^1^p^1^2.1
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
 ;;=NATIONAL ENDOCRINOLOGY FY16-Q2^0^National Endocrinology February 2016^1^0^1^1^^133^80^2^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,13,0)
 ;;=NATIONAL ENT FY16-Q2^2^NATIONAL ENT-REVIEWED/REVISED February 2016^1^0^1^1^^133^80^3^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,13,2,0)
 ;;=^358.02I^2^2
 ;;^UTILITY(U,$J,358,13,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,13,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,14,0)
 ;;=NATIONAL EYE TECH FY16-Q2^1^National Eye Technician February 2016^1^0^1^1^^133^80^12^1^^1^p^1^2.1
 ;;^UTILITY(U,$J,358,14,2,0)
 ;;=^358.02I^4^4
 ;;^UTILITY(U,$J,358,14,2,1,0)
 ;;=1^1
 ;;^UTILITY(U,$J,358,14,2,2,0)
 ;;=2^1
 ;;^UTILITY(U,$J,358,14,2,3,0)
 ;;=3^1
 ;;^UTILITY(U,$J,358,14,2,4,0)
 ;;=4^1
 ;;^UTILITY(U,$J,358,15,0)
 ;;=NATIONAL EYE FY16-Q2^1^National Eye February 2016^1^0^1^1^^133^80^13^1^^1^p^1^2.1
