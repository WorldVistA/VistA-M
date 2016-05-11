IBDEI1IC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25575,0)
 ;;=F17.211^^95^1172^3
 ;;^UTILITY(U,$J,358.3,25575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25575,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,25575,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,25575,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,25576,0)
 ;;=F17.220^^95^1172^2
 ;;^UTILITY(U,$J,358.3,25576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25576,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25576,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,25576,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,25577,0)
 ;;=F17.221^^95^1172^1
 ;;^UTILITY(U,$J,358.3,25577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25577,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,25577,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,25577,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,25578,0)
 ;;=F17.290^^95^1172^5
 ;;^UTILITY(U,$J,358.3,25578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25578,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25578,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,25578,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,25579,0)
 ;;=F17.291^^95^1172^6
 ;;^UTILITY(U,$J,358.3,25579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25579,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,25579,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,25579,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,25580,0)
 ;;=F17.208^^95^1172^7
 ;;^UTILITY(U,$J,358.3,25580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25580,1,3,0)
 ;;=3^Nicotine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25580,1,4,0)
 ;;=4^F17.208
 ;;^UTILITY(U,$J,358.3,25580,2)
 ;;=^5003363
 ;;^UTILITY(U,$J,358.3,25581,0)
 ;;=F17.209^^95^1172^8
 ;;^UTILITY(U,$J,358.3,25581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25581,1,3,0)
 ;;=3^Nicotine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25581,1,4,0)
 ;;=4^F17.209
 ;;^UTILITY(U,$J,358.3,25581,2)
 ;;=^5003364
 ;;^UTILITY(U,$J,358.3,25582,0)
 ;;=F14.10^^95^1173^1
 ;;^UTILITY(U,$J,358.3,25582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25582,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25582,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,25582,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,25583,0)
 ;;=F14.14^^95^1173^5
 ;;^UTILITY(U,$J,358.3,25583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25583,1,3,0)
 ;;=3^Cocaine-Induced Depressive,Bipolar or Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25583,1,4,0)
 ;;=4^F14.14
 ;;^UTILITY(U,$J,358.3,25583,2)
 ;;=^5003244
 ;;^UTILITY(U,$J,358.3,25584,0)
 ;;=F14.182^^95^1173^6
 ;;^UTILITY(U,$J,358.3,25584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25584,1,3,0)
 ;;=3^Cocaine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25584,1,4,0)
 ;;=4^F14.182
 ;;^UTILITY(U,$J,358.3,25584,2)
 ;;=^5003250
 ;;^UTILITY(U,$J,358.3,25585,0)
 ;;=F14.20^^95^1173^3
 ;;^UTILITY(U,$J,358.3,25585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25585,1,3,0)
 ;;=3^Cocaine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25585,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,25585,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,25586,0)
 ;;=F14.21^^95^1173^2
 ;;^UTILITY(U,$J,358.3,25586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25586,1,3,0)
 ;;=3^Cocaine Use Disorder,Mod-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,25586,1,4,0)
 ;;=4^F14.21
 ;;^UTILITY(U,$J,358.3,25586,2)
 ;;=^5003254
 ;;^UTILITY(U,$J,358.3,25587,0)
 ;;=F14.23^^95^1173^4
 ;;^UTILITY(U,$J,358.3,25587,1,0)
 ;;=^358.31IA^4^2
