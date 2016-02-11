IBDEI24E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35601,1,3,0)
 ;;=3^Gestational edema with proteinuria, second trimester
 ;;^UTILITY(U,$J,358.3,35601,1,4,0)
 ;;=4^O12.22
 ;;^UTILITY(U,$J,358.3,35601,2)
 ;;=^5016156
 ;;^UTILITY(U,$J,358.3,35602,0)
 ;;=O12.23^^166^1824^25
 ;;^UTILITY(U,$J,358.3,35602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35602,1,3,0)
 ;;=3^Gestational edema with proteinuria, third trimester
 ;;^UTILITY(U,$J,358.3,35602,1,4,0)
 ;;=4^O12.23
 ;;^UTILITY(U,$J,358.3,35602,2)
 ;;=^5016157
 ;;^UTILITY(U,$J,358.3,35603,0)
 ;;=O26.01^^166^1824^20
 ;;^UTILITY(U,$J,358.3,35603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35603,1,3,0)
 ;;=3^Excessive weight gain in pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,35603,1,4,0)
 ;;=4^O26.01
 ;;^UTILITY(U,$J,358.3,35603,2)
 ;;=^5016298
 ;;^UTILITY(U,$J,358.3,35604,0)
 ;;=O26.02^^166^1824^21
 ;;^UTILITY(U,$J,358.3,35604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35604,1,3,0)
 ;;=3^Excessive weight gain in pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,35604,1,4,0)
 ;;=4^O26.02
 ;;^UTILITY(U,$J,358.3,35604,2)
 ;;=^5016299
 ;;^UTILITY(U,$J,358.3,35605,0)
 ;;=O26.03^^166^1824^22
 ;;^UTILITY(U,$J,358.3,35605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35605,1,3,0)
 ;;=3^Excessive weight gain in pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,35605,1,4,0)
 ;;=4^O26.03
 ;;^UTILITY(U,$J,358.3,35605,2)
 ;;=^5016300
 ;;^UTILITY(U,$J,358.3,35606,0)
 ;;=O26.831^^166^1824^72
 ;;^UTILITY(U,$J,358.3,35606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35606,1,3,0)
 ;;=3^Pregnancy related renal disease, first trimester
 ;;^UTILITY(U,$J,358.3,35606,1,4,0)
 ;;=4^O26.831
 ;;^UTILITY(U,$J,358.3,35606,2)
 ;;=^5016341
 ;;^UTILITY(U,$J,358.3,35607,0)
 ;;=O26.832^^166^1824^73
 ;;^UTILITY(U,$J,358.3,35607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35607,1,3,0)
 ;;=3^Pregnancy related renal disease, second trimester
 ;;^UTILITY(U,$J,358.3,35607,1,4,0)
 ;;=4^O26.832
 ;;^UTILITY(U,$J,358.3,35607,2)
 ;;=^5016342
 ;;^UTILITY(U,$J,358.3,35608,0)
 ;;=O26.833^^166^1824^74
 ;;^UTILITY(U,$J,358.3,35608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35608,1,3,0)
 ;;=3^Pregnancy related renal disease, third trimester
 ;;^UTILITY(U,$J,358.3,35608,1,4,0)
 ;;=4^O26.833
 ;;^UTILITY(U,$J,358.3,35608,2)
 ;;=^5016343
 ;;^UTILITY(U,$J,358.3,35609,0)
 ;;=O26.21^^166^1824^66
 ;;^UTILITY(U,$J,358.3,35609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35609,1,3,0)
 ;;=3^Preg care for patient w recurrent preg loss, first trimester
 ;;^UTILITY(U,$J,358.3,35609,1,4,0)
 ;;=4^O26.21
 ;;^UTILITY(U,$J,358.3,35609,2)
 ;;=^5016306
 ;;^UTILITY(U,$J,358.3,35610,0)
 ;;=O26.22^^166^1824^67
 ;;^UTILITY(U,$J,358.3,35610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35610,1,3,0)
 ;;=3^Preg care for patient w recurrent preg loss, second trimester
 ;;^UTILITY(U,$J,358.3,35610,1,4,0)
 ;;=4^O26.22
 ;;^UTILITY(U,$J,358.3,35610,2)
 ;;=^5016307
 ;;^UTILITY(U,$J,358.3,35611,0)
 ;;=O26.23^^166^1824^68
 ;;^UTILITY(U,$J,358.3,35611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35611,1,3,0)
 ;;=3^Preg care for patient w recurrent preg loss, third trimester
 ;;^UTILITY(U,$J,358.3,35611,1,4,0)
 ;;=4^O26.23
 ;;^UTILITY(U,$J,358.3,35611,2)
 ;;=^5016308
 ;;^UTILITY(U,$J,358.3,35612,0)
 ;;=O26.821^^166^1824^69
 ;;^UTILITY(U,$J,358.3,35612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35612,1,3,0)
 ;;=3^Pregnancy related peripheral neuritis, first trimester
 ;;^UTILITY(U,$J,358.3,35612,1,4,0)
 ;;=4^O26.821
 ;;^UTILITY(U,$J,358.3,35612,2)
 ;;=^5016337
 ;;^UTILITY(U,$J,358.3,35613,0)
 ;;=O26.822^^166^1824^70
