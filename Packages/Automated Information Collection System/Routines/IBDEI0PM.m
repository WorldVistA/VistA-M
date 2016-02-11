IBDEI0PM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11733,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,11733,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,11733,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,11734,0)
 ;;=F14.23^^68^689^22
 ;;^UTILITY(U,$J,358.3,11734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11734,1,3,0)
 ;;=3^Cocaine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,11734,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,11734,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,11735,0)
 ;;=F14.229^^68^689^19
 ;;^UTILITY(U,$J,358.3,11735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11735,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,11735,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,11735,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,11736,0)
 ;;=F14.222^^68^689^17
 ;;^UTILITY(U,$J,358.3,11736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11736,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,11736,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,11736,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,11737,0)
 ;;=F14.221^^68^689^16
 ;;^UTILITY(U,$J,358.3,11737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11737,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,11737,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,11737,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,11738,0)
 ;;=F14.220^^68^689^18
 ;;^UTILITY(U,$J,358.3,11738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11738,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11738,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,11738,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,11739,0)
 ;;=F14.20^^68^689^23
 ;;^UTILITY(U,$J,358.3,11739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11739,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,11739,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,11739,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,11740,0)
 ;;=F10.120^^68^689^1
 ;;^UTILITY(U,$J,358.3,11740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11740,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11740,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,11740,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,11741,0)
 ;;=F10.10^^68^689^2
 ;;^UTILITY(U,$J,358.3,11741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11741,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11741,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,11741,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,11742,0)
 ;;=F17.201^^68^689^28
 ;;^UTILITY(U,$J,358.3,11742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11742,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,11742,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,11742,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,11743,0)
 ;;=F17.210^^68^689^27
 ;;^UTILITY(U,$J,358.3,11743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11743,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,11743,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,11743,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,11744,0)
 ;;=F17.291^^68^689^29
 ;;^UTILITY(U,$J,358.3,11744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11744,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,11744,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,11744,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,11745,0)
 ;;=F17.290^^68^689^30
 ;;^UTILITY(U,$J,358.3,11745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11745,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
