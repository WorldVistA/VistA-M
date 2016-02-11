IBDEI0D2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5674,1,4,0)
 ;;=4^D03.51
 ;;^UTILITY(U,$J,358.3,5674,2)
 ;;=^5001898
 ;;^UTILITY(U,$J,358.3,5675,0)
 ;;=D03.52^^40^373^19
 ;;^UTILITY(U,$J,358.3,5675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5675,1,3,0)
 ;;=3^Melanoma in Situ of Breast
 ;;^UTILITY(U,$J,358.3,5675,1,4,0)
 ;;=4^D03.52
 ;;^UTILITY(U,$J,358.3,5675,2)
 ;;=^5001899
 ;;^UTILITY(U,$J,358.3,5676,0)
 ;;=D03.59^^40^373^33
 ;;^UTILITY(U,$J,358.3,5676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5676,1,3,0)
 ;;=3^Melanoma in Situ of Trunk NEC
 ;;^UTILITY(U,$J,358.3,5676,1,4,0)
 ;;=4^D03.59
 ;;^UTILITY(U,$J,358.3,5676,2)
 ;;=^5001900
 ;;^UTILITY(U,$J,358.3,5677,0)
 ;;=D03.61^^40^373^31
 ;;^UTILITY(U,$J,358.3,5677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5677,1,3,0)
 ;;=3^Melanoma in Situ of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,5677,1,4,0)
 ;;=4^D03.61
 ;;^UTILITY(U,$J,358.3,5677,2)
 ;;=^5001902
 ;;^UTILITY(U,$J,358.3,5678,0)
 ;;=D03.62^^40^373^25
 ;;^UTILITY(U,$J,358.3,5678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5678,1,3,0)
 ;;=3^Melanoma in Situ of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,5678,1,4,0)
 ;;=4^D03.62
 ;;^UTILITY(U,$J,358.3,5678,2)
 ;;=^5001903
 ;;^UTILITY(U,$J,358.3,5679,0)
 ;;=D03.71^^40^373^30
 ;;^UTILITY(U,$J,358.3,5679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5679,1,3,0)
 ;;=3^Melanoma in Situ of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,5679,1,4,0)
 ;;=4^D03.71
 ;;^UTILITY(U,$J,358.3,5679,2)
 ;;=^5001905
 ;;^UTILITY(U,$J,358.3,5680,0)
 ;;=D03.72^^40^373^24
 ;;^UTILITY(U,$J,358.3,5680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5680,1,3,0)
 ;;=3^Melanoma in Situ of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,5680,1,4,0)
 ;;=4^D03.72
 ;;^UTILITY(U,$J,358.3,5680,2)
 ;;=^5001906
 ;;^UTILITY(U,$J,358.3,5681,0)
 ;;=D03.8^^40^373^27
 ;;^UTILITY(U,$J,358.3,5681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5681,1,3,0)
 ;;=3^Melanoma in Situ of Other Sites
 ;;^UTILITY(U,$J,358.3,5681,1,4,0)
 ;;=4^D03.8
 ;;^UTILITY(U,$J,358.3,5681,2)
 ;;=^5001907
 ;;^UTILITY(U,$J,358.3,5682,0)
 ;;=C4A.0^^40^374^8
 ;;^UTILITY(U,$J,358.3,5682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5682,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Lip
 ;;^UTILITY(U,$J,358.3,5682,1,4,0)
 ;;=4^C4A.0
 ;;^UTILITY(U,$J,358.3,5682,2)
 ;;=^5001137
 ;;^UTILITY(U,$J,358.3,5683,0)
 ;;=C4A.11^^40^374^12
 ;;^UTILITY(U,$J,358.3,5683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5683,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Right Eyelid
 ;;^UTILITY(U,$J,358.3,5683,1,4,0)
 ;;=4^C4A.11
 ;;^UTILITY(U,$J,358.3,5683,2)
 ;;=^5001139
 ;;^UTILITY(U,$J,358.3,5684,0)
 ;;=C4A.12^^40^374^5
 ;;^UTILITY(U,$J,358.3,5684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5684,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Left Eyelid
 ;;^UTILITY(U,$J,358.3,5684,1,4,0)
 ;;=4^C4A.12
 ;;^UTILITY(U,$J,358.3,5684,2)
 ;;=^5001140
 ;;^UTILITY(U,$J,358.3,5685,0)
 ;;=C4A.21^^40^374^11
 ;;^UTILITY(U,$J,358.3,5685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5685,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Right Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,5685,1,4,0)
 ;;=4^C4A.21
 ;;^UTILITY(U,$J,358.3,5685,2)
 ;;=^5001142
 ;;^UTILITY(U,$J,358.3,5686,0)
 ;;=C4A.22^^40^374^4
 ;;^UTILITY(U,$J,358.3,5686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5686,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Left Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,5686,1,4,0)
 ;;=4^C4A.22
 ;;^UTILITY(U,$J,358.3,5686,2)
 ;;=^5001143
 ;;^UTILITY(U,$J,358.3,5687,0)
 ;;=C4A.30^^40^374^3
 ;;^UTILITY(U,$J,358.3,5687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5687,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Face,Unspec
 ;;^UTILITY(U,$J,358.3,5687,1,4,0)
 ;;=4^C4A.30
