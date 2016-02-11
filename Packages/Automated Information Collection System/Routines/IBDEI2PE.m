IBDEI2PE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45370,1,3,0)
 ;;=3^Cocaine Dependence w/ Cocaine-Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,45370,1,4,0)
 ;;=4^F14.24
 ;;^UTILITY(U,$J,358.3,45370,2)
 ;;=^5003260
 ;;^UTILITY(U,$J,358.3,45371,0)
 ;;=F14.23^^200^2242^22
 ;;^UTILITY(U,$J,358.3,45371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45371,1,3,0)
 ;;=3^Cocaine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,45371,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,45371,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,45372,0)
 ;;=F14.229^^200^2242^19
 ;;^UTILITY(U,$J,358.3,45372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45372,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,45372,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,45372,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,45373,0)
 ;;=F14.222^^200^2242^17
 ;;^UTILITY(U,$J,358.3,45373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45373,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,45373,1,4,0)
 ;;=4^F14.222
 ;;^UTILITY(U,$J,358.3,45373,2)
 ;;=^5003257
 ;;^UTILITY(U,$J,358.3,45374,0)
 ;;=F14.221^^200^2242^16
 ;;^UTILITY(U,$J,358.3,45374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45374,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,45374,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,45374,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,45375,0)
 ;;=F14.220^^200^2242^18
 ;;^UTILITY(U,$J,358.3,45375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45375,1,3,0)
 ;;=3^Cocaine Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,45375,1,4,0)
 ;;=4^F14.220
 ;;^UTILITY(U,$J,358.3,45375,2)
 ;;=^5003255
 ;;^UTILITY(U,$J,358.3,45376,0)
 ;;=F14.20^^200^2242^23
 ;;^UTILITY(U,$J,358.3,45376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45376,1,3,0)
 ;;=3^Cocaine Dependence,Uncompicated
 ;;^UTILITY(U,$J,358.3,45376,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,45376,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,45377,0)
 ;;=F10.120^^200^2242^1
 ;;^UTILITY(U,$J,358.3,45377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45377,1,3,0)
 ;;=3^Alcohol Abuse w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,45377,1,4,0)
 ;;=4^F10.120
 ;;^UTILITY(U,$J,358.3,45377,2)
 ;;=^5003069
 ;;^UTILITY(U,$J,358.3,45378,0)
 ;;=F10.10^^200^2242^2
 ;;^UTILITY(U,$J,358.3,45378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45378,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,45378,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,45378,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,45379,0)
 ;;=F17.201^^200^2242^28
 ;;^UTILITY(U,$J,358.3,45379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45379,1,3,0)
 ;;=3^Nicotine Dependence In Remission,Unspec
 ;;^UTILITY(U,$J,358.3,45379,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,45379,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,45380,0)
 ;;=F17.210^^200^2242^27
 ;;^UTILITY(U,$J,358.3,45380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45380,1,3,0)
 ;;=3^Nicotine Dependence Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,45380,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,45380,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,45381,0)
 ;;=F17.291^^200^2242^29
 ;;^UTILITY(U,$J,358.3,45381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45381,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,45381,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,45381,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,45382,0)
 ;;=F17.290^^200^2242^30
 ;;^UTILITY(U,$J,358.3,45382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45382,1,3,0)
 ;;=3^Nicotine Dependence Oth Tobacco Product,Uncomplicated
