IBDEI0D1 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5661,1,3,0)
 ;;=3^Malig Melanoma of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,5661,1,4,0)
 ;;=4^C43.61
 ;;^UTILITY(U,$J,358.3,5661,2)
 ;;=^5001009
 ;;^UTILITY(U,$J,358.3,5662,0)
 ;;=C43.62^^40^373^6
 ;;^UTILITY(U,$J,358.3,5662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5662,1,3,0)
 ;;=3^Malig Melanoma of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,5662,1,4,0)
 ;;=4^C43.62
 ;;^UTILITY(U,$J,358.3,5662,2)
 ;;=^5001010
 ;;^UTILITY(U,$J,358.3,5663,0)
 ;;=C43.71^^40^373^12
 ;;^UTILITY(U,$J,358.3,5663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5663,1,3,0)
 ;;=3^Malig Melanoma of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,5663,1,4,0)
 ;;=4^C43.71
 ;;^UTILITY(U,$J,358.3,5663,2)
 ;;=^5001012
 ;;^UTILITY(U,$J,358.3,5664,0)
 ;;=C43.72^^40^373^5
 ;;^UTILITY(U,$J,358.3,5664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5664,1,3,0)
 ;;=3^Malig Melanoma of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,5664,1,4,0)
 ;;=4^C43.72
 ;;^UTILITY(U,$J,358.3,5664,2)
 ;;=^5001013
 ;;^UTILITY(U,$J,358.3,5665,0)
 ;;=C43.8^^40^373^9
 ;;^UTILITY(U,$J,358.3,5665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5665,1,3,0)
 ;;=3^Malig Melanoma of Overlapping Sites of Skin
 ;;^UTILITY(U,$J,358.3,5665,1,4,0)
 ;;=4^C43.8
 ;;^UTILITY(U,$J,358.3,5665,2)
 ;;=^5001014
 ;;^UTILITY(U,$J,358.3,5666,0)
 ;;=D03.0^^40^373^26
 ;;^UTILITY(U,$J,358.3,5666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5666,1,3,0)
 ;;=3^Melanoma in Situ of Lip
 ;;^UTILITY(U,$J,358.3,5666,1,4,0)
 ;;=4^D03.0
 ;;^UTILITY(U,$J,358.3,5666,2)
 ;;=^5001888
 ;;^UTILITY(U,$J,358.3,5667,0)
 ;;=D03.11^^40^373^29
 ;;^UTILITY(U,$J,358.3,5667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5667,1,3,0)
 ;;=3^Melanoma in Situ of Right Eyelid
 ;;^UTILITY(U,$J,358.3,5667,1,4,0)
 ;;=4^D03.11
 ;;^UTILITY(U,$J,358.3,5667,2)
 ;;=^5001890
 ;;^UTILITY(U,$J,358.3,5668,0)
 ;;=D03.12^^40^373^23
 ;;^UTILITY(U,$J,358.3,5668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5668,1,3,0)
 ;;=3^Melanoma in Situ of Left Eyelid
 ;;^UTILITY(U,$J,358.3,5668,1,4,0)
 ;;=4^D03.12
 ;;^UTILITY(U,$J,358.3,5668,2)
 ;;=^5001891
 ;;^UTILITY(U,$J,358.3,5669,0)
 ;;=D03.21^^40^373^28
 ;;^UTILITY(U,$J,358.3,5669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5669,1,3,0)
 ;;=3^Melanoma in Situ of Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,5669,1,4,0)
 ;;=4^D03.21
 ;;^UTILITY(U,$J,358.3,5669,2)
 ;;=^5001893
 ;;^UTILITY(U,$J,358.3,5670,0)
 ;;=D03.22^^40^373^22
 ;;^UTILITY(U,$J,358.3,5670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5670,1,3,0)
 ;;=3^Melanoma in Situ of Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,5670,1,4,0)
 ;;=4^D03.22
 ;;^UTILITY(U,$J,358.3,5670,2)
 ;;=^5001894
 ;;^UTILITY(U,$J,358.3,5671,0)
 ;;=D03.30^^40^373^21
 ;;^UTILITY(U,$J,358.3,5671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5671,1,3,0)
 ;;=3^Melanoma in Situ of Face,Unspec
 ;;^UTILITY(U,$J,358.3,5671,1,4,0)
 ;;=4^D03.30
 ;;^UTILITY(U,$J,358.3,5671,2)
 ;;=^5001895
 ;;^UTILITY(U,$J,358.3,5672,0)
 ;;=D03.39^^40^373^20
 ;;^UTILITY(U,$J,358.3,5672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5672,1,3,0)
 ;;=3^Melanoma in Situ of Face NEC
 ;;^UTILITY(U,$J,358.3,5672,1,4,0)
 ;;=4^D03.39
 ;;^UTILITY(U,$J,358.3,5672,2)
 ;;=^5001896
 ;;^UTILITY(U,$J,358.3,5673,0)
 ;;=D03.4^^40^373^32
 ;;^UTILITY(U,$J,358.3,5673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5673,1,3,0)
 ;;=3^Melanoma in Situ of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,5673,1,4,0)
 ;;=4^D03.4
 ;;^UTILITY(U,$J,358.3,5673,2)
 ;;=^5001897
 ;;^UTILITY(U,$J,358.3,5674,0)
 ;;=D03.51^^40^373^18
 ;;^UTILITY(U,$J,358.3,5674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5674,1,3,0)
 ;;=3^Melanoma in Situ of Anal Skin
