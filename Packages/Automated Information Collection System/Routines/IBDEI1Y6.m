IBDEI1Y6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32599,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,32599,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,32599,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,32600,0)
 ;;=F13.239^^143^1549^5
 ;;^UTILITY(U,$J,358.3,32600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32600,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,32600,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,32600,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,32601,0)
 ;;=F13.24^^143^1549^9
 ;;^UTILITY(U,$J,358.3,32601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32601,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,32601,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,32601,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,32602,0)
 ;;=F13.231^^143^1549^6
 ;;^UTILITY(U,$J,358.3,32602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32602,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,32602,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,32602,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,32603,0)
 ;;=F17.200^^143^1550^1
 ;;^UTILITY(U,$J,358.3,32603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32603,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,32603,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,32603,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,32604,0)
 ;;=F17.201^^143^1550^2
 ;;^UTILITY(U,$J,358.3,32604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32604,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,32604,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,32604,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,32605,0)
 ;;=F17.203^^143^1550^3
 ;;^UTILITY(U,$J,358.3,32605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32605,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,32605,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,32605,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,32606,0)
 ;;=F17.210^^143^1550^4
 ;;^UTILITY(U,$J,358.3,32606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32606,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32606,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,32606,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,32607,0)
 ;;=F17.211^^143^1550^5
 ;;^UTILITY(U,$J,358.3,32607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32607,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,32607,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,32607,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,32608,0)
 ;;=F17.220^^143^1550^6
 ;;^UTILITY(U,$J,358.3,32608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32608,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32608,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,32608,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,32609,0)
 ;;=F17.221^^143^1550^7
 ;;^UTILITY(U,$J,358.3,32609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32609,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,32609,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,32609,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,32610,0)
 ;;=F17.290^^143^1550^8
 ;;^UTILITY(U,$J,358.3,32610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32610,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,Uncomplicated
 ;;^UTILITY(U,$J,358.3,32610,1,4,0)
 ;;=4^F17.290
 ;;^UTILITY(U,$J,358.3,32610,2)
 ;;=^5003375
 ;;^UTILITY(U,$J,358.3,32611,0)
 ;;=F17.291^^143^1550^9
 ;;^UTILITY(U,$J,358.3,32611,1,0)
 ;;=^358.31IA^4^2
