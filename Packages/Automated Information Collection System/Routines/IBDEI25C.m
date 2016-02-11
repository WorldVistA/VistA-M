IBDEI25C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36004,1,4,0)
 ;;=4^O41.03X5
 ;;^UTILITY(U,$J,358.3,36004,2)
 ;;=^5017239
 ;;^UTILITY(U,$J,358.3,36005,0)
 ;;=O41.03X9^^166^1828^57
 ;;^UTILITY(U,$J,358.3,36005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36005,1,3,0)
 ;;=3^Oligohydramnios, third trimester, other fetus
 ;;^UTILITY(U,$J,358.3,36005,1,4,0)
 ;;=4^O41.03X9
 ;;^UTILITY(U,$J,358.3,36005,2)
 ;;=^5017240
 ;;^UTILITY(U,$J,358.3,36006,0)
 ;;=O42.00^^166^1828^77
 ;;^UTILITY(U,$J,358.3,36006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36006,1,3,0)
 ;;=3^Prem ROM, onset labor w/n 24 hr of rupt, unsp weeks of gest
 ;;^UTILITY(U,$J,358.3,36006,1,4,0)
 ;;=4^O42.00
 ;;^UTILITY(U,$J,358.3,36006,2)
 ;;=^5017372
 ;;^UTILITY(U,$J,358.3,36007,0)
 ;;=O42.011^^166^1828^82
 ;;^UTILITY(U,$J,358.3,36007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36007,1,3,0)
 ;;=3^Pretrm prem ROM, onset labor w/n 24 hours of rupt, first tri
 ;;^UTILITY(U,$J,358.3,36007,1,4,0)
 ;;=4^O42.011
 ;;^UTILITY(U,$J,358.3,36007,2)
 ;;=^5017373
 ;;^UTILITY(U,$J,358.3,36008,0)
 ;;=O42.012^^166^1828^83
 ;;^UTILITY(U,$J,358.3,36008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36008,1,3,0)
 ;;=3^Pretrm prem ROM, onset labor w/n 24 hours of rupt, 2nd tri
 ;;^UTILITY(U,$J,358.3,36008,1,4,0)
 ;;=4^O42.012
 ;;^UTILITY(U,$J,358.3,36008,2)
 ;;=^5017374
 ;;^UTILITY(U,$J,358.3,36009,0)
 ;;=O42.013^^166^1828^84
 ;;^UTILITY(U,$J,358.3,36009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36009,1,3,0)
 ;;=3^Pretrm prem ROM, onset labor w/n 24 hours of rupt, third tri
 ;;^UTILITY(U,$J,358.3,36009,1,4,0)
 ;;=4^O42.013
 ;;^UTILITY(U,$J,358.3,36009,2)
 ;;=^5017375
 ;;^UTILITY(U,$J,358.3,36010,0)
 ;;=O42.10^^166^1828^76
 ;;^UTILITY(U,$J,358.3,36010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36010,1,3,0)
 ;;=3^Prem ROM, onset labor > 24 hr fol rupt, unsp weeks of gest
 ;;^UTILITY(U,$J,358.3,36010,1,4,0)
 ;;=4^O42.10
 ;;^UTILITY(U,$J,358.3,36010,2)
 ;;=^5017378
 ;;^UTILITY(U,$J,358.3,36011,0)
 ;;=O42.111^^166^1828^78
 ;;^UTILITY(U,$J,358.3,36011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36011,1,3,0)
 ;;=3^Pretrm prem ROM, onset labor > 24 hours fol rupt, first tri
 ;;^UTILITY(U,$J,358.3,36011,1,4,0)
 ;;=4^O42.111
 ;;^UTILITY(U,$J,358.3,36011,2)
 ;;=^5017379
 ;;^UTILITY(U,$J,358.3,36012,0)
 ;;=O42.112^^166^1828^79
 ;;^UTILITY(U,$J,358.3,36012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36012,1,3,0)
 ;;=3^Pretrm prem ROM, onset labor > 24 hours fol rupt, second tri
 ;;^UTILITY(U,$J,358.3,36012,1,4,0)
 ;;=4^O42.112
 ;;^UTILITY(U,$J,358.3,36012,2)
 ;;=^5017380
 ;;^UTILITY(U,$J,358.3,36013,0)
 ;;=O42.113^^166^1828^80
 ;;^UTILITY(U,$J,358.3,36013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36013,1,3,0)
 ;;=3^Pretrm prem ROM, onset labor > 24 hours fol rupt, third tri
 ;;^UTILITY(U,$J,358.3,36013,1,4,0)
 ;;=4^O42.113
 ;;^UTILITY(U,$J,358.3,36013,2)
 ;;=^5017381
 ;;^UTILITY(U,$J,358.3,36014,0)
 ;;=O42.119^^166^1828^81
 ;;^UTILITY(U,$J,358.3,36014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36014,1,3,0)
 ;;=3^Pretrm prem ROM, onset labor > 24 hours fol rupt, unsp tri
 ;;^UTILITY(U,$J,358.3,36014,1,4,0)
 ;;=4^O42.119
 ;;^UTILITY(U,$J,358.3,36014,2)
 ;;=^5017382
 ;;^UTILITY(U,$J,358.3,36015,0)
 ;;=O75.5^^166^1828^20
 ;;^UTILITY(U,$J,358.3,36015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36015,1,3,0)
 ;;=3^Delayed delivery after artificial rupture of membranes
 ;;^UTILITY(U,$J,358.3,36015,1,4,0)
 ;;=4^O75.5
 ;;^UTILITY(U,$J,358.3,36015,2)
 ;;=^271331
 ;;^UTILITY(U,$J,358.3,36016,0)
 ;;=O41.1010^^166^1828^21
 ;;^UTILITY(U,$J,358.3,36016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36016,1,3,0)
 ;;=3^Infct of amniotic sac/membrns, first tri, unsp
