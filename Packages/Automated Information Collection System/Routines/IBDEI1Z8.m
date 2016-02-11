IBDEI1Z8 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33097,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,33097,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,33098,0)
 ;;=F13.20^^146^1613^2
 ;;^UTILITY(U,$J,358.3,33098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33098,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33098,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,33098,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,33099,0)
 ;;=F13.21^^146^1613^3
 ;;^UTILITY(U,$J,358.3,33099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33099,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,33099,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,33099,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,33100,0)
 ;;=F13.232^^146^1613^4
 ;;^UTILITY(U,$J,358.3,33100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33100,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,33100,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,33100,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,33101,0)
 ;;=F13.239^^146^1613^5
 ;;^UTILITY(U,$J,358.3,33101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33101,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,33101,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,33101,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,33102,0)
 ;;=F13.24^^146^1613^9
 ;;^UTILITY(U,$J,358.3,33102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33102,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,33102,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,33102,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,33103,0)
 ;;=F13.231^^146^1613^6
 ;;^UTILITY(U,$J,358.3,33103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33103,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,33103,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,33103,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,33104,0)
 ;;=F17.200^^146^1614^1
 ;;^UTILITY(U,$J,358.3,33104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33104,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,33104,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,33104,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,33105,0)
 ;;=F17.201^^146^1614^2
 ;;^UTILITY(U,$J,358.3,33105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33105,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,33105,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,33105,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,33106,0)
 ;;=F17.203^^146^1614^3
 ;;^UTILITY(U,$J,358.3,33106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33106,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,33106,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,33106,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,33107,0)
 ;;=F17.210^^146^1614^4
 ;;^UTILITY(U,$J,358.3,33107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33107,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,33107,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,33107,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,33108,0)
 ;;=F17.211^^146^1614^5
 ;;^UTILITY(U,$J,358.3,33108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33108,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,33108,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,33108,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,33109,0)
 ;;=F17.220^^146^1614^6
 ;;^UTILITY(U,$J,358.3,33109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33109,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
