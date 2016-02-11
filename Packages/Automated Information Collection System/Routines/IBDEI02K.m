IBDEI02K ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,432,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,432,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,433,0)
 ;;=F13.182^^3^55^8
 ;;^UTILITY(U,$J,358.3,433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,433,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,433,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,433,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,434,0)
 ;;=F13.20^^3^55^2
 ;;^UTILITY(U,$J,358.3,434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,434,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,434,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,434,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,435,0)
 ;;=F13.21^^3^55^3
 ;;^UTILITY(U,$J,358.3,435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,435,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,435,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,435,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,436,0)
 ;;=F13.232^^3^55^4
 ;;^UTILITY(U,$J,358.3,436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,436,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,436,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,436,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,437,0)
 ;;=F13.239^^3^55^5
 ;;^UTILITY(U,$J,358.3,437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,437,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,437,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,437,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,438,0)
 ;;=F13.24^^3^55^9
 ;;^UTILITY(U,$J,358.3,438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,438,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,438,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,438,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,439,0)
 ;;=F13.231^^3^55^6
 ;;^UTILITY(U,$J,358.3,439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,439,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,439,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,439,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,440,0)
 ;;=F17.200^^3^56^1
 ;;^UTILITY(U,$J,358.3,440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,440,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,440,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,440,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,441,0)
 ;;=F17.201^^3^56^2
 ;;^UTILITY(U,$J,358.3,441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,441,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,441,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,441,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,442,0)
 ;;=F17.203^^3^56^3
 ;;^UTILITY(U,$J,358.3,442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,442,1,3,0)
 ;;=3^Tobacco Withdrawal
 ;;^UTILITY(U,$J,358.3,442,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,442,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,443,0)
 ;;=F17.210^^3^56^4
 ;;^UTILITY(U,$J,358.3,443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,443,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,443,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,443,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,444,0)
 ;;=F17.211^^3^56^5
 ;;^UTILITY(U,$J,358.3,444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,444,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,444,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,444,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,445,0)
 ;;=F17.220^^3^56^6
