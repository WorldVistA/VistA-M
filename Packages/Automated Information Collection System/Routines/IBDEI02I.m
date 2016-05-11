IBDEI02I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,682,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,683,0)
 ;;=F15.980^^3^68^3
 ;;^UTILITY(U,$J,358.3,683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,683,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,683,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,683,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,684,0)
 ;;=F15.182^^3^68^4
 ;;^UTILITY(U,$J,358.3,684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,684,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,684,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,684,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,685,0)
 ;;=F15.282^^3^68^5
 ;;^UTILITY(U,$J,358.3,685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,685,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,685,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,685,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,686,0)
 ;;=F15.982^^3^68^6
 ;;^UTILITY(U,$J,358.3,686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,686,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,686,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,686,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,687,0)
 ;;=F15.99^^3^68^9
 ;;^UTILITY(U,$J,358.3,687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,687,1,3,0)
 ;;=3^Caffeinie Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,687,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,687,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,688,0)
 ;;=99212^^4^69^2
 ;;^UTILITY(U,$J,358.3,688,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,688,1,1,0)
 ;;=1^Expanded Problem Focused
 ;;^UTILITY(U,$J,358.3,688,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,689,0)
 ;;=99213^^4^69^3
 ;;^UTILITY(U,$J,358.3,689,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,689,1,1,0)
 ;;=1^Detailed Visit
 ;;^UTILITY(U,$J,358.3,689,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,690,0)
 ;;=99214^^4^69^4
 ;;^UTILITY(U,$J,358.3,690,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,690,1,1,0)
 ;;=1^Comprehensive,Mod Complexity
 ;;^UTILITY(U,$J,358.3,690,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,691,0)
 ;;=99211^^4^69^1
 ;;^UTILITY(U,$J,358.3,691,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,691,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,691,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,692,0)
 ;;=99242^^4^70^1
 ;;^UTILITY(U,$J,358.3,692,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,692,1,1,0)
 ;;=1^Expanded Problem Focused
 ;;^UTILITY(U,$J,358.3,692,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,693,0)
 ;;=99243^^4^70^2
 ;;^UTILITY(U,$J,358.3,693,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,693,1,1,0)
 ;;=1^Detailed Visit
 ;;^UTILITY(U,$J,358.3,693,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,694,0)
 ;;=99244^^4^70^3
 ;;^UTILITY(U,$J,358.3,694,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,694,1,1,0)
 ;;=1^Comprehensive,Mod Complexity
 ;;^UTILITY(U,$J,358.3,694,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,695,0)
 ;;=99024^^4^71^1
 ;;^UTILITY(U,$J,358.3,695,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,695,1,1,0)
 ;;=1^Post Op visit in Global
 ;;^UTILITY(U,$J,358.3,695,1,2,0)
 ;;=2^99024
 ;;^UTILITY(U,$J,358.3,696,0)
 ;;=64415^^5^72^4^^^^1
 ;;^UTILITY(U,$J,358.3,696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,696,1,2,0)
 ;;=2^NERVE BLK BRACHIAL PLEXUS,SNGL INJ
 ;;^UTILITY(U,$J,358.3,696,1,4,0)
 ;;=4^64415
 ;;^UTILITY(U,$J,358.3,697,0)
 ;;=64416^^5^72^3^^^^1
 ;;^UTILITY(U,$J,358.3,697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,697,1,2,0)
 ;;=2^NERVE BLK BRACHIAL PLEXUS,CONT INFUSION
 ;;^UTILITY(U,$J,358.3,697,1,4,0)
 ;;=4^64416
 ;;^UTILITY(U,$J,358.3,698,0)
 ;;=64413^^5^72^7^^^^1
