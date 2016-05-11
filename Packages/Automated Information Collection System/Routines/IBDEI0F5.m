IBDEI0F5 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6982,0)
 ;;=R56.9^^30^401^4
 ;;^UTILITY(U,$J,358.3,6982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6982,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,6982,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,6982,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,6983,0)
 ;;=R25.0^^30^401^1
 ;;^UTILITY(U,$J,358.3,6983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6983,1,3,0)
 ;;=3^Abnormal Head Movements
 ;;^UTILITY(U,$J,358.3,6983,1,4,0)
 ;;=4^R25.0
 ;;^UTILITY(U,$J,358.3,6983,2)
 ;;=^5019299
 ;;^UTILITY(U,$J,358.3,6984,0)
 ;;=R25.1^^30^401^7
 ;;^UTILITY(U,$J,358.3,6984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6984,1,3,0)
 ;;=3^Tremor,Unspec
 ;;^UTILITY(U,$J,358.3,6984,1,4,0)
 ;;=4^R25.1
 ;;^UTILITY(U,$J,358.3,6984,2)
 ;;=^5019300
 ;;^UTILITY(U,$J,358.3,6985,0)
 ;;=R25.9^^30^401^3
 ;;^UTILITY(U,$J,358.3,6985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6985,1,3,0)
 ;;=3^Abnormal Involuntary Movements,Unspec
 ;;^UTILITY(U,$J,358.3,6985,1,4,0)
 ;;=4^R25.9
 ;;^UTILITY(U,$J,358.3,6985,2)
 ;;=^5019303
 ;;^UTILITY(U,$J,358.3,6986,0)
 ;;=R25.3^^30^401^5
 ;;^UTILITY(U,$J,358.3,6986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6986,1,3,0)
 ;;=3^Fasciculation/Twitching
 ;;^UTILITY(U,$J,358.3,6986,1,4,0)
 ;;=4^R25.3
 ;;^UTILITY(U,$J,358.3,6986,2)
 ;;=^44985
 ;;^UTILITY(U,$J,358.3,6987,0)
 ;;=R25.8^^30^401^2
 ;;^UTILITY(U,$J,358.3,6987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6987,1,3,0)
 ;;=3^Abnormal Involuntary Movements,Other
 ;;^UTILITY(U,$J,358.3,6987,1,4,0)
 ;;=4^R25.8
 ;;^UTILITY(U,$J,358.3,6987,2)
 ;;=^5019302
 ;;^UTILITY(U,$J,358.3,6988,0)
 ;;=M02.30^^30^402^132
 ;;^UTILITY(U,$J,358.3,6988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6988,1,3,0)
 ;;=3^Reiter's Disease,Unspec Site
 ;;^UTILITY(U,$J,358.3,6988,1,4,0)
 ;;=4^M02.30
 ;;^UTILITY(U,$J,358.3,6988,2)
 ;;=^5009790
 ;;^UTILITY(U,$J,358.3,6989,0)
 ;;=M10.9^^30^402^40
 ;;^UTILITY(U,$J,358.3,6989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6989,1,3,0)
 ;;=3^Gout,Unspec
 ;;^UTILITY(U,$J,358.3,6989,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,6989,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,6990,0)
 ;;=G90.59^^30^402^34
 ;;^UTILITY(U,$J,358.3,6990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6990,1,3,0)
 ;;=3^Complex Regional Pain Syndrome I,Unspec
 ;;^UTILITY(U,$J,358.3,6990,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,6990,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,6991,0)
 ;;=G56.01^^30^402^12
 ;;^UTILITY(U,$J,358.3,6991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6991,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,6991,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,6991,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,6992,0)
 ;;=G56.02^^30^402^11
 ;;^UTILITY(U,$J,358.3,6992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6992,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,6992,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,6992,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,6993,0)
 ;;=G56.21^^30^402^56
 ;;^UTILITY(U,$J,358.3,6993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6993,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,6993,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,6993,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,6994,0)
 ;;=G56.22^^30^402^55
 ;;^UTILITY(U,$J,358.3,6994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6994,1,3,0)
 ;;=3^Lesion of Ulnar Nerve,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,6994,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,6994,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,6995,0)
 ;;=M26.60^^30^402^171
 ;;^UTILITY(U,$J,358.3,6995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6995,1,3,0)
 ;;=3^Temporomandibular Joint Disorder,Unspec
