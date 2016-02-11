IBDEI1JB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25647,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,25647,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,25648,0)
 ;;=F13.21^^124^1256^3
 ;;^UTILITY(U,$J,358.3,25648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25648,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,25648,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,25648,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,25649,0)
 ;;=F13.232^^124^1256^4
 ;;^UTILITY(U,$J,358.3,25649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25649,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25649,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,25649,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,25650,0)
 ;;=F13.239^^124^1256^5
 ;;^UTILITY(U,$J,358.3,25650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25650,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25650,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,25650,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,25651,0)
 ;;=F13.24^^124^1256^9
 ;;^UTILITY(U,$J,358.3,25651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25651,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,25651,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,25651,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,25652,0)
 ;;=F13.231^^124^1256^6
 ;;^UTILITY(U,$J,358.3,25652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25652,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,25652,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,25652,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,25653,0)
 ;;=F17.200^^124^1257^1
 ;;^UTILITY(U,$J,358.3,25653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25653,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25653,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,25653,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,25654,0)
 ;;=F17.201^^124^1257^2
 ;;^UTILITY(U,$J,358.3,25654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25654,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,25654,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,25654,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,25655,0)
 ;;=F17.203^^124^1257^3
 ;;^UTILITY(U,$J,358.3,25655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25655,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,25655,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,25655,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,25656,0)
 ;;=F17.210^^124^1257^4
 ;;^UTILITY(U,$J,358.3,25656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25656,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25656,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,25656,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,25657,0)
 ;;=F17.211^^124^1257^5
 ;;^UTILITY(U,$J,358.3,25657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25657,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,25657,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,25657,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,25658,0)
 ;;=F17.220^^124^1257^6
 ;;^UTILITY(U,$J,358.3,25658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25658,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25658,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,25658,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,25659,0)
 ;;=F17.221^^124^1257^7
 ;;^UTILITY(U,$J,358.3,25659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25659,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
