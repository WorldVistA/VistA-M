IBDEI22O ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34747,1,4,0)
 ;;=4^G97.81
 ;;^UTILITY(U,$J,358.3,34747,2)
 ;;=^5004211
 ;;^UTILITY(U,$J,358.3,34748,0)
 ;;=G97.82^^160^1768^11
 ;;^UTILITY(U,$J,358.3,34748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34748,1,3,0)
 ;;=3^Postproc complications and disorders of nervous sys NEC
 ;;^UTILITY(U,$J,358.3,34748,1,4,0)
 ;;=4^G97.82
 ;;^UTILITY(U,$J,358.3,34748,2)
 ;;=^5004212
 ;;^UTILITY(U,$J,358.3,34749,0)
 ;;=G71.9^^160^1768^14
 ;;^UTILITY(U,$J,358.3,34749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34749,1,3,0)
 ;;=3^Primary disorder of muscle, unspecified
 ;;^UTILITY(U,$J,358.3,34749,1,4,0)
 ;;=4^G71.9
 ;;^UTILITY(U,$J,358.3,34749,2)
 ;;=^5004094
 ;;^UTILITY(U,$J,358.3,34750,0)
 ;;=G83.5^^160^1768^9
 ;;^UTILITY(U,$J,358.3,34750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34750,1,3,0)
 ;;=3^Locked-in state
 ;;^UTILITY(U,$J,358.3,34750,1,4,0)
 ;;=4^G83.5
 ;;^UTILITY(U,$J,358.3,34750,2)
 ;;=^5004146
 ;;^UTILITY(U,$J,358.3,34751,0)
 ;;=G83.81^^160^1768^4
 ;;^UTILITY(U,$J,358.3,34751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34751,1,3,0)
 ;;=3^Brown-Sequard syndrome
 ;;^UTILITY(U,$J,358.3,34751,1,4,0)
 ;;=4^G83.81
 ;;^UTILITY(U,$J,358.3,34751,2)
 ;;=^5004147
 ;;^UTILITY(U,$J,358.3,34752,0)
 ;;=G83.82^^160^1768^3
 ;;^UTILITY(U,$J,358.3,34752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34752,1,3,0)
 ;;=3^Anterior cord syndrome
 ;;^UTILITY(U,$J,358.3,34752,1,4,0)
 ;;=4^G83.82
 ;;^UTILITY(U,$J,358.3,34752,2)
 ;;=^5004148
 ;;^UTILITY(U,$J,358.3,34753,0)
 ;;=G83.83^^160^1768^10
 ;;^UTILITY(U,$J,358.3,34753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34753,1,3,0)
 ;;=3^Posterior cord syndrome
 ;;^UTILITY(U,$J,358.3,34753,1,4,0)
 ;;=4^G83.83
 ;;^UTILITY(U,$J,358.3,34753,2)
 ;;=^5004149
 ;;^UTILITY(U,$J,358.3,34754,0)
 ;;=G83.84^^160^1768^15
 ;;^UTILITY(U,$J,358.3,34754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34754,1,3,0)
 ;;=3^Todd's paralysis (postepileptic)
 ;;^UTILITY(U,$J,358.3,34754,1,4,0)
 ;;=4^G83.84
 ;;^UTILITY(U,$J,358.3,34754,2)
 ;;=^5004150
 ;;^UTILITY(U,$J,358.3,34755,0)
 ;;=D33.0^^160^1769^2
 ;;^UTILITY(U,$J,358.3,34755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34755,1,3,0)
 ;;=3^Benign neoplasm of brain, supratentorial
 ;;^UTILITY(U,$J,358.3,34755,1,4,0)
 ;;=4^D33.0
 ;;^UTILITY(U,$J,358.3,34755,2)
 ;;=^5002136
 ;;^UTILITY(U,$J,358.3,34756,0)
 ;;=D33.1^^160^1769^1
 ;;^UTILITY(U,$J,358.3,34756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34756,1,3,0)
 ;;=3^Benign neoplasm of brain, infratentorial
 ;;^UTILITY(U,$J,358.3,34756,1,4,0)
 ;;=4^D33.1
 ;;^UTILITY(U,$J,358.3,34756,2)
 ;;=^5002137
 ;;^UTILITY(U,$J,358.3,34757,0)
 ;;=C71.9^^160^1769^6
 ;;^UTILITY(U,$J,358.3,34757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34757,1,3,0)
 ;;=3^Malignant neoplasm of brain, unspecified
 ;;^UTILITY(U,$J,358.3,34757,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,34757,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,34758,0)
 ;;=C79.31^^160^1769^26
 ;;^UTILITY(U,$J,358.3,34758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34758,1,3,0)
 ;;=3^Secondary malignant neoplasm of brain
 ;;^UTILITY(U,$J,358.3,34758,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,34758,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,34759,0)
 ;;=D32.9^^160^1769^3
 ;;^UTILITY(U,$J,358.3,34759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34759,1,3,0)
 ;;=3^Benign neoplasm of meninges, unspecified
 ;;^UTILITY(U,$J,358.3,34759,1,4,0)
 ;;=4^D32.9
 ;;^UTILITY(U,$J,358.3,34759,2)
 ;;=^5002135
 ;;^UTILITY(U,$J,358.3,34760,0)
 ;;=D35.2^^160^1769^4
 ;;^UTILITY(U,$J,358.3,34760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34760,1,3,0)
 ;;=3^Benign neoplasm of pituitary gland
