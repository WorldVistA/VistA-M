IBDEI207 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33549,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,33549,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,33549,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,33550,0)
 ;;=F13.24^^148^1663^9
 ;;^UTILITY(U,$J,358.3,33550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33550,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,33550,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,33550,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,33551,0)
 ;;=F13.231^^148^1663^6
 ;;^UTILITY(U,$J,358.3,33551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33551,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,33551,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,33551,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,33552,0)
 ;;=F17.200^^148^1664^1
 ;;^UTILITY(U,$J,358.3,33552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33552,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33552,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,33552,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,33553,0)
 ;;=F17.201^^148^1664^2
 ;;^UTILITY(U,$J,358.3,33553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33553,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,33553,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,33553,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,33554,0)
 ;;=F17.203^^148^1664^3
 ;;^UTILITY(U,$J,358.3,33554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33554,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,33554,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,33554,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,33555,0)
 ;;=F17.210^^148^1664^4
 ;;^UTILITY(U,$J,358.3,33555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33555,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33555,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,33555,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,33556,0)
 ;;=F17.211^^148^1664^5
 ;;^UTILITY(U,$J,358.3,33556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33556,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,33556,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,33556,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,33557,0)
 ;;=F17.220^^148^1664^6
 ;;^UTILITY(U,$J,358.3,33557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33557,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33557,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,33557,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,33558,0)
 ;;=F17.221^^148^1664^7
 ;;^UTILITY(U,$J,358.3,33558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33558,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,33558,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,33558,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,33559,0)
 ;;=F17.290^^148^1664^8
 ;;^UTILITY(U,$J,358.3,33559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33559,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33559,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,33559,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,33560,0)
 ;;=F17.291^^148^1664^9
 ;;^UTILITY(U,$J,358.3,33560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33560,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
 ;;^UTILITY(U,$J,358.3,33560,1,4,0)
 ;;=4^F17.291
 ;;^UTILITY(U,$J,358.3,33560,2)
 ;;=^5003376
 ;;^UTILITY(U,$J,358.3,33561,0)
 ;;=F14.10^^148^1665^1
 ;;^UTILITY(U,$J,358.3,33561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33561,1,3,0)
 ;;=3^Cocaine Use Disorder,Mild
