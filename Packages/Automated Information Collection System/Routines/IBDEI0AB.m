IBDEI0AB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4591,0)
 ;;=D04.11^^21^285^13
 ;;^UTILITY(U,$J,358.3,4591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4591,1,3,0)
 ;;=3^Carcinoma in Situ Skin Right Eyelid
 ;;^UTILITY(U,$J,358.3,4591,1,4,0)
 ;;=4^D04.11
 ;;^UTILITY(U,$J,358.3,4591,2)
 ;;=^5001910
 ;;^UTILITY(U,$J,358.3,4592,0)
 ;;=D04.12^^21^285^7
 ;;^UTILITY(U,$J,358.3,4592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4592,1,3,0)
 ;;=3^Carcinoma in Situ Skin Left Eyelid
 ;;^UTILITY(U,$J,358.3,4592,1,4,0)
 ;;=4^D04.12
 ;;^UTILITY(U,$J,358.3,4592,2)
 ;;=^5001911
 ;;^UTILITY(U,$J,358.3,4593,0)
 ;;=D04.21^^21^285^12
 ;;^UTILITY(U,$J,358.3,4593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4593,1,3,0)
 ;;=3^Carcinoma in Situ Skin Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,4593,1,4,0)
 ;;=4^D04.21
 ;;^UTILITY(U,$J,358.3,4593,2)
 ;;=^5001913
 ;;^UTILITY(U,$J,358.3,4594,0)
 ;;=D04.22^^21^285^6
 ;;^UTILITY(U,$J,358.3,4594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4594,1,3,0)
 ;;=3^Carcinoma in Situ Skin Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,4594,1,4,0)
 ;;=4^D04.22
 ;;^UTILITY(U,$J,358.3,4594,2)
 ;;=^5001914
 ;;^UTILITY(U,$J,358.3,4595,0)
 ;;=D04.30^^21^285^5
 ;;^UTILITY(U,$J,358.3,4595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4595,1,3,0)
 ;;=3^Carcinoma in Situ Skin Face,Unspec
 ;;^UTILITY(U,$J,358.3,4595,1,4,0)
 ;;=4^D04.30
 ;;^UTILITY(U,$J,358.3,4595,2)
 ;;=^5001915
 ;;^UTILITY(U,$J,358.3,4596,0)
 ;;=D04.39^^21^285^4
 ;;^UTILITY(U,$J,358.3,4596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4596,1,3,0)
 ;;=3^Carcinoma in Situ Skin Face NEC
 ;;^UTILITY(U,$J,358.3,4596,1,4,0)
 ;;=4^D04.39
 ;;^UTILITY(U,$J,358.3,4596,2)
 ;;=^5001916
 ;;^UTILITY(U,$J,358.3,4597,0)
 ;;=D04.4^^21^285^16
 ;;^UTILITY(U,$J,358.3,4597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4597,1,3,0)
 ;;=3^Carcinoma in Situ Skin Scalp/Neck
 ;;^UTILITY(U,$J,358.3,4597,1,4,0)
 ;;=4^D04.4
 ;;^UTILITY(U,$J,358.3,4597,2)
 ;;=^267729
 ;;^UTILITY(U,$J,358.3,4598,0)
 ;;=D04.5^^21^285^17
 ;;^UTILITY(U,$J,358.3,4598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4598,1,3,0)
 ;;=3^Carcinoma in Situ Skin Trunk
 ;;^UTILITY(U,$J,358.3,4598,1,4,0)
 ;;=4^D04.5
 ;;^UTILITY(U,$J,358.3,4598,2)
 ;;=^5001917
 ;;^UTILITY(U,$J,358.3,4599,0)
 ;;=D04.61^^21^285^15
 ;;^UTILITY(U,$J,358.3,4599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4599,1,3,0)
 ;;=3^Carcinoma in Situ Skin Right Upper Limb
 ;;^UTILITY(U,$J,358.3,4599,1,4,0)
 ;;=4^D04.61
 ;;^UTILITY(U,$J,358.3,4599,2)
 ;;=^5001919
 ;;^UTILITY(U,$J,358.3,4600,0)
 ;;=D04.62^^21^285^9
 ;;^UTILITY(U,$J,358.3,4600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4600,1,3,0)
 ;;=3^Carcinoma in Situ Skin Left Upper Limb
 ;;^UTILITY(U,$J,358.3,4600,1,4,0)
 ;;=4^D04.62
 ;;^UTILITY(U,$J,358.3,4600,2)
 ;;=^5001920
 ;;^UTILITY(U,$J,358.3,4601,0)
 ;;=D04.71^^21^285^14
 ;;^UTILITY(U,$J,358.3,4601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4601,1,3,0)
 ;;=3^Carcinoma in Situ Skin Right Lower Limb
 ;;^UTILITY(U,$J,358.3,4601,1,4,0)
 ;;=4^D04.71
 ;;^UTILITY(U,$J,358.3,4601,2)
 ;;=^5001922
 ;;^UTILITY(U,$J,358.3,4602,0)
 ;;=D04.72^^21^285^8
 ;;^UTILITY(U,$J,358.3,4602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4602,1,3,0)
 ;;=3^Carcinoma in Situ Skin Left Lower Limb
 ;;^UTILITY(U,$J,358.3,4602,1,4,0)
 ;;=4^D04.72
 ;;^UTILITY(U,$J,358.3,4602,2)
 ;;=^5001923
 ;;^UTILITY(U,$J,358.3,4603,0)
 ;;=D04.8^^21^285^11
 ;;^UTILITY(U,$J,358.3,4603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4603,1,3,0)
 ;;=3^Carcinoma in Situ Skin Other Sites
 ;;^UTILITY(U,$J,358.3,4603,1,4,0)
 ;;=4^D04.8
 ;;^UTILITY(U,$J,358.3,4603,2)
 ;;=^5001924
