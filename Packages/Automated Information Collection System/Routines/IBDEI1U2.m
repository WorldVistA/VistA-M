IBDEI1U2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31130,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,31130,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,31130,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,31131,0)
 ;;=F13.232^^123^1561^4
 ;;^UTILITY(U,$J,358.3,31131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31131,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31131,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,31131,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,31132,0)
 ;;=F13.239^^123^1561^5
 ;;^UTILITY(U,$J,358.3,31132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31132,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31132,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,31132,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,31133,0)
 ;;=F13.24^^123^1561^9
 ;;^UTILITY(U,$J,358.3,31133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31133,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,31133,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,31133,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,31134,0)
 ;;=F13.231^^123^1561^6
 ;;^UTILITY(U,$J,358.3,31134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31134,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,31134,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,31134,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,31135,0)
 ;;=F17.200^^123^1562^9
 ;;^UTILITY(U,$J,358.3,31135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31135,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31135,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,31135,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,31136,0)
 ;;=F17.201^^123^1562^10
 ;;^UTILITY(U,$J,358.3,31136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31136,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,31136,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,31136,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,31137,0)
 ;;=F17.203^^123^1562^11
 ;;^UTILITY(U,$J,358.3,31137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31137,1,3,0)
 ;;=3^Nicotine Withdrawal
 ;;^UTILITY(U,$J,358.3,31137,1,4,0)
 ;;=4^F17.203
 ;;^UTILITY(U,$J,358.3,31137,2)
 ;;=^5003362
 ;;^UTILITY(U,$J,358.3,31138,0)
 ;;=F17.210^^123^1562^4
 ;;^UTILITY(U,$J,358.3,31138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31138,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31138,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,31138,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,31139,0)
 ;;=F17.211^^123^1562^3
 ;;^UTILITY(U,$J,358.3,31139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31139,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,31139,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,31139,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,31140,0)
 ;;=F17.220^^123^1562^2
 ;;^UTILITY(U,$J,358.3,31140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31140,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,31140,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,31140,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,31141,0)
 ;;=F17.221^^123^1562^1
 ;;^UTILITY(U,$J,358.3,31141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31141,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,31141,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,31141,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,31142,0)
 ;;=F17.290^^123^1562^5
