IBDEI1IB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25563,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,25563,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,25563,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,25564,0)
 ;;=F13.182^^95^1171^8
 ;;^UTILITY(U,$J,358.3,25564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25564,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25564,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,25564,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,25565,0)
 ;;=F13.20^^95^1171^2
 ;;^UTILITY(U,$J,358.3,25565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25565,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25565,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,25565,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,25566,0)
 ;;=F13.21^^95^1171^3
 ;;^UTILITY(U,$J,358.3,25566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25566,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,25566,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,25566,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,25567,0)
 ;;=F13.232^^95^1171^4
 ;;^UTILITY(U,$J,358.3,25567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25567,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25567,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,25567,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,25568,0)
 ;;=F13.239^^95^1171^5
 ;;^UTILITY(U,$J,358.3,25568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25568,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25568,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,25568,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,25569,0)
 ;;=F13.24^^95^1171^9
 ;;^UTILITY(U,$J,358.3,25569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25569,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,25569,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,25569,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,25570,0)
 ;;=F13.231^^95^1171^6
 ;;^UTILITY(U,$J,358.3,25570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25570,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,25570,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,25570,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,25571,0)
 ;;=F17.200^^95^1172^9
 ;;^UTILITY(U,$J,358.3,25571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25571,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25571,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,25571,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,25572,0)
 ;;=F17.201^^95^1172^10
 ;;^UTILITY(U,$J,358.3,25572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25572,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,25572,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,25572,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,25573,0)
 ;;=F17.203^^95^1172^11
 ;;^UTILITY(U,$J,358.3,25573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25573,1,3,0)
 ;;=3^Nicotine Withdrawal
 ;;^UTILITY(U,$J,358.3,25573,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,25573,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,25574,0)
 ;;=F17.210^^95^1172^4
 ;;^UTILITY(U,$J,358.3,25574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25574,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25574,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,25574,2)
 ;;=^5003365
