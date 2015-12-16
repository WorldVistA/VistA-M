IBDEI1O0 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29569,0)
 ;;=G97.51^^176^1890^12
 ;;^UTILITY(U,$J,358.3,29569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29569,1,3,0)
 ;;=3^Postproc hemor/hemtom of a nrv sys org fol a nrv sys proc
 ;;^UTILITY(U,$J,358.3,29569,1,4,0)
 ;;=4^G97.51
 ;;^UTILITY(U,$J,358.3,29569,2)
 ;;=^5004209
 ;;^UTILITY(U,$J,358.3,29570,0)
 ;;=G97.52^^176^1890^13
 ;;^UTILITY(U,$J,358.3,29570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29570,1,3,0)
 ;;=3^Postproc hemor/hemtom of a nrv sys org fol oth procedure
 ;;^UTILITY(U,$J,358.3,29570,1,4,0)
 ;;=4^G97.52
 ;;^UTILITY(U,$J,358.3,29570,2)
 ;;=^5004210
 ;;^UTILITY(U,$J,358.3,29571,0)
 ;;=G97.81^^176^1890^8
 ;;^UTILITY(U,$J,358.3,29571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29571,1,3,0)
 ;;=3^Intraoperative complications of nervous system NEC
 ;;^UTILITY(U,$J,358.3,29571,1,4,0)
 ;;=4^G97.81
 ;;^UTILITY(U,$J,358.3,29571,2)
 ;;=^5004211
 ;;^UTILITY(U,$J,358.3,29572,0)
 ;;=G97.82^^176^1890^11
 ;;^UTILITY(U,$J,358.3,29572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29572,1,3,0)
 ;;=3^Postproc complications and disorders of nervous sys NEC
 ;;^UTILITY(U,$J,358.3,29572,1,4,0)
 ;;=4^G97.82
 ;;^UTILITY(U,$J,358.3,29572,2)
 ;;=^5004212
 ;;^UTILITY(U,$J,358.3,29573,0)
 ;;=G71.9^^176^1890^14
 ;;^UTILITY(U,$J,358.3,29573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29573,1,3,0)
 ;;=3^Primary disorder of muscle, unspecified
 ;;^UTILITY(U,$J,358.3,29573,1,4,0)
 ;;=4^G71.9
 ;;^UTILITY(U,$J,358.3,29573,2)
 ;;=^5004094
 ;;^UTILITY(U,$J,358.3,29574,0)
 ;;=G83.5^^176^1890^9
 ;;^UTILITY(U,$J,358.3,29574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29574,1,3,0)
 ;;=3^Locked-in state
 ;;^UTILITY(U,$J,358.3,29574,1,4,0)
 ;;=4^G83.5
 ;;^UTILITY(U,$J,358.3,29574,2)
 ;;=^5004146
 ;;^UTILITY(U,$J,358.3,29575,0)
 ;;=G83.81^^176^1890^4
 ;;^UTILITY(U,$J,358.3,29575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29575,1,3,0)
 ;;=3^Brown-Sequard syndrome
 ;;^UTILITY(U,$J,358.3,29575,1,4,0)
 ;;=4^G83.81
 ;;^UTILITY(U,$J,358.3,29575,2)
 ;;=^5004147
 ;;^UTILITY(U,$J,358.3,29576,0)
 ;;=G83.82^^176^1890^3
 ;;^UTILITY(U,$J,358.3,29576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29576,1,3,0)
 ;;=3^Anterior cord syndrome
 ;;^UTILITY(U,$J,358.3,29576,1,4,0)
 ;;=4^G83.82
 ;;^UTILITY(U,$J,358.3,29576,2)
 ;;=^5004148
 ;;^UTILITY(U,$J,358.3,29577,0)
 ;;=G83.83^^176^1890^10
 ;;^UTILITY(U,$J,358.3,29577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29577,1,3,0)
 ;;=3^Posterior cord syndrome
 ;;^UTILITY(U,$J,358.3,29577,1,4,0)
 ;;=4^G83.83
 ;;^UTILITY(U,$J,358.3,29577,2)
 ;;=^5004149
 ;;^UTILITY(U,$J,358.3,29578,0)
 ;;=G83.84^^176^1890^15
 ;;^UTILITY(U,$J,358.3,29578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29578,1,3,0)
 ;;=3^Todd's paralysis (postepileptic)
 ;;^UTILITY(U,$J,358.3,29578,1,4,0)
 ;;=4^G83.84
 ;;^UTILITY(U,$J,358.3,29578,2)
 ;;=^5004150
 ;;^UTILITY(U,$J,358.3,29579,0)
 ;;=D33.0^^176^1891^2
 ;;^UTILITY(U,$J,358.3,29579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29579,1,3,0)
 ;;=3^Benign neoplasm of brain, supratentorial
 ;;^UTILITY(U,$J,358.3,29579,1,4,0)
 ;;=4^D33.0
 ;;^UTILITY(U,$J,358.3,29579,2)
 ;;=^5002136
 ;;^UTILITY(U,$J,358.3,29580,0)
 ;;=D33.1^^176^1891^1
 ;;^UTILITY(U,$J,358.3,29580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29580,1,3,0)
 ;;=3^Benign neoplasm of brain, infratentorial
 ;;^UTILITY(U,$J,358.3,29580,1,4,0)
 ;;=4^D33.1
 ;;^UTILITY(U,$J,358.3,29580,2)
 ;;=^5002137
 ;;^UTILITY(U,$J,358.3,29581,0)
 ;;=C71.9^^176^1891^6
 ;;^UTILITY(U,$J,358.3,29581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29581,1,3,0)
 ;;=3^Malignant neoplasm of brain, unspecified
