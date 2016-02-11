IBDEI1WD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31770,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,31771,0)
 ;;=F13.10^^138^1457^1
 ;;^UTILITY(U,$J,358.3,31771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31771,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31771,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,31771,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,31772,0)
 ;;=F13.14^^138^1457^7
 ;;^UTILITY(U,$J,358.3,31772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31772,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,31772,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,31772,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,31773,0)
 ;;=F13.182^^138^1457^8
 ;;^UTILITY(U,$J,358.3,31773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31773,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31773,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,31773,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,31774,0)
 ;;=F13.20^^138^1457^2
 ;;^UTILITY(U,$J,358.3,31774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31774,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31774,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,31774,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,31775,0)
 ;;=F13.21^^138^1457^3
 ;;^UTILITY(U,$J,358.3,31775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31775,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,31775,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,31775,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,31776,0)
 ;;=F13.232^^138^1457^4
 ;;^UTILITY(U,$J,358.3,31776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31776,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31776,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,31776,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,31777,0)
 ;;=F13.239^^138^1457^5
 ;;^UTILITY(U,$J,358.3,31777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31777,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31777,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,31777,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,31778,0)
 ;;=F13.24^^138^1457^9
 ;;^UTILITY(U,$J,358.3,31778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31778,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,31778,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,31778,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,31779,0)
 ;;=F13.231^^138^1457^6
 ;;^UTILITY(U,$J,358.3,31779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31779,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,31779,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,31779,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,31780,0)
 ;;=F17.200^^138^1458^1
 ;;^UTILITY(U,$J,358.3,31780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31780,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31780,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,31780,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,31781,0)
 ;;=F17.201^^138^1458^2
 ;;^UTILITY(U,$J,358.3,31781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31781,1,3,0)
 ;;=3^Tobacco Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,31781,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,31781,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,31782,0)
 ;;=F17.203^^138^1458^3
 ;;^UTILITY(U,$J,358.3,31782,1,0)
 ;;=^358.31IA^4^2
