IBDEI1HC ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23662,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,23662,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,23663,0)
 ;;=F19.11^^105^1182^3
 ;;^UTILITY(U,$J,358.3,23663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23663,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,In Remission
 ;;^UTILITY(U,$J,358.3,23663,1,4,0)
 ;;=4^F19.11
 ;;^UTILITY(U,$J,358.3,23663,2)
 ;;=^5151306
 ;;^UTILITY(U,$J,358.3,23664,0)
 ;;=F13.10^^105^1183^2
 ;;^UTILITY(U,$J,358.3,23664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23664,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,23664,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,23664,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,23665,0)
 ;;=F13.14^^105^1183^8
 ;;^UTILITY(U,$J,358.3,23665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23665,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,23665,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,23665,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,23666,0)
 ;;=F13.182^^105^1183^9
 ;;^UTILITY(U,$J,358.3,23666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23666,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23666,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,23666,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,23667,0)
 ;;=F13.20^^105^1183^3
 ;;^UTILITY(U,$J,358.3,23667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23667,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,23667,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,23667,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,23668,0)
 ;;=F13.21^^105^1183^4
 ;;^UTILITY(U,$J,358.3,23668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23668,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,23668,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,23668,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,23669,0)
 ;;=F13.232^^105^1183^5
 ;;^UTILITY(U,$J,358.3,23669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23669,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,23669,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,23669,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,23670,0)
 ;;=F13.239^^105^1183^6
 ;;^UTILITY(U,$J,358.3,23670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23670,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,23670,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,23670,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,23671,0)
 ;;=F13.24^^105^1183^10
 ;;^UTILITY(U,$J,358.3,23671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23671,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,23671,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,23671,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,23672,0)
 ;;=F13.231^^105^1183^7
 ;;^UTILITY(U,$J,358.3,23672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23672,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,23672,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,23672,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,23673,0)
 ;;=F13.11^^105^1183^1
 ;;^UTILITY(U,$J,358.3,23673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23673,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Abuse,In Remission
