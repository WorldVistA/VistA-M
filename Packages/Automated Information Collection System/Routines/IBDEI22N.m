IBDEI22N ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34735,1,3,0)
 ;;=3^Complex regional pain syndrome I, unspecified
 ;;^UTILITY(U,$J,358.3,34735,1,4,0)
 ;;=4^G90.50
 ;;^UTILITY(U,$J,358.3,34735,2)
 ;;=^5004163
 ;;^UTILITY(U,$J,358.3,34736,0)
 ;;=G57.71^^160^1767^3
 ;;^UTILITY(U,$J,358.3,34736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34736,1,3,0)
 ;;=3^Causalgia of right lower limb
 ;;^UTILITY(U,$J,358.3,34736,1,4,0)
 ;;=4^G57.71
 ;;^UTILITY(U,$J,358.3,34736,2)
 ;;=^5133365
 ;;^UTILITY(U,$J,358.3,34737,0)
 ;;=G57.72^^160^1767^1
 ;;^UTILITY(U,$J,358.3,34737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34737,1,3,0)
 ;;=3^Causalgia of left lower limb
 ;;^UTILITY(U,$J,358.3,34737,1,4,0)
 ;;=4^G57.72
 ;;^UTILITY(U,$J,358.3,34737,2)
 ;;=^5133366
 ;;^UTILITY(U,$J,358.3,34738,0)
 ;;=G56.41^^160^1767^4
 ;;^UTILITY(U,$J,358.3,34738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34738,1,3,0)
 ;;=3^Causalgia of right upper limb
 ;;^UTILITY(U,$J,358.3,34738,1,4,0)
 ;;=4^G56.41
 ;;^UTILITY(U,$J,358.3,34738,2)
 ;;=^5004030
 ;;^UTILITY(U,$J,358.3,34739,0)
 ;;=G56.42^^160^1767^2
 ;;^UTILITY(U,$J,358.3,34739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34739,1,3,0)
 ;;=3^Causalgia of left upper limb
 ;;^UTILITY(U,$J,358.3,34739,1,4,0)
 ;;=4^G56.42
 ;;^UTILITY(U,$J,358.3,34739,2)
 ;;=^5004031
 ;;^UTILITY(U,$J,358.3,34740,0)
 ;;=G40.909^^160^1768^5
 ;;^UTILITY(U,$J,358.3,34740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34740,1,3,0)
 ;;=3^Epilepsy, unsp, not intractable, without status epilepticus
 ;;^UTILITY(U,$J,358.3,34740,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,34740,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,34741,0)
 ;;=G97.31^^160^1768^6
 ;;^UTILITY(U,$J,358.3,34741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34741,1,3,0)
 ;;=3^Intraop hemor/hemtom of a nervous sys org comp nrv sys proc
 ;;^UTILITY(U,$J,358.3,34741,1,4,0)
 ;;=4^G97.31
 ;;^UTILITY(U,$J,358.3,34741,2)
 ;;=^5004204
 ;;^UTILITY(U,$J,358.3,34742,0)
 ;;=G97.32^^160^1768^7
 ;;^UTILITY(U,$J,358.3,34742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34742,1,3,0)
 ;;=3^Intraop hemor/hemtom of a nervous sys org comp oth procedure
 ;;^UTILITY(U,$J,358.3,34742,1,4,0)
 ;;=4^G97.32
 ;;^UTILITY(U,$J,358.3,34742,2)
 ;;=^5004205
 ;;^UTILITY(U,$J,358.3,34743,0)
 ;;=G97.41^^160^1768^1
 ;;^UTILITY(U,$J,358.3,34743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34743,1,3,0)
 ;;=3^Acc pnctr/lac of dura during a procedure
 ;;^UTILITY(U,$J,358.3,34743,1,4,0)
 ;;=4^G97.41
 ;;^UTILITY(U,$J,358.3,34743,2)
 ;;=^5004206
 ;;^UTILITY(U,$J,358.3,34744,0)
 ;;=G97.48^^160^1768^2
 ;;^UTILITY(U,$J,358.3,34744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34744,1,3,0)
 ;;=3^Acc pnctr/lac of nervous sys org during a nervous sys proc
 ;;^UTILITY(U,$J,358.3,34744,1,4,0)
 ;;=4^G97.48
 ;;^UTILITY(U,$J,358.3,34744,2)
 ;;=^5004207
 ;;^UTILITY(U,$J,358.3,34745,0)
 ;;=G97.51^^160^1768^12
 ;;^UTILITY(U,$J,358.3,34745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34745,1,3,0)
 ;;=3^Postproc hemor/hemtom of a nrv sys org fol a nrv sys proc
 ;;^UTILITY(U,$J,358.3,34745,1,4,0)
 ;;=4^G97.51
 ;;^UTILITY(U,$J,358.3,34745,2)
 ;;=^5004209
 ;;^UTILITY(U,$J,358.3,34746,0)
 ;;=G97.52^^160^1768^13
 ;;^UTILITY(U,$J,358.3,34746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34746,1,3,0)
 ;;=3^Postproc hemor/hemtom of a nrv sys org fol oth procedure
 ;;^UTILITY(U,$J,358.3,34746,1,4,0)
 ;;=4^G97.52
 ;;^UTILITY(U,$J,358.3,34746,2)
 ;;=^5004210
 ;;^UTILITY(U,$J,358.3,34747,0)
 ;;=G97.81^^160^1768^8
 ;;^UTILITY(U,$J,358.3,34747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34747,1,3,0)
 ;;=3^Intraoperative complications of nervous system NEC
