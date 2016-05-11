IBDEI29I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38366,0)
 ;;=F13.10^^145^1860^1
 ;;^UTILITY(U,$J,358.3,38366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38366,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38366,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,38366,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,38367,0)
 ;;=F13.14^^145^1860^7
 ;;^UTILITY(U,$J,358.3,38367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38367,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,38367,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,38367,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,38368,0)
 ;;=F13.182^^145^1860^8
 ;;^UTILITY(U,$J,358.3,38368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38368,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38368,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,38368,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,38369,0)
 ;;=F13.20^^145^1860^2
 ;;^UTILITY(U,$J,358.3,38369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38369,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38369,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,38369,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,38370,0)
 ;;=F13.21^^145^1860^3
 ;;^UTILITY(U,$J,358.3,38370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38370,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,38370,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,38370,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,38371,0)
 ;;=F13.232^^145^1860^4
 ;;^UTILITY(U,$J,358.3,38371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38371,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,38371,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,38371,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,38372,0)
 ;;=F13.239^^145^1860^5
 ;;^UTILITY(U,$J,358.3,38372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38372,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,38372,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,38372,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,38373,0)
 ;;=F13.24^^145^1860^9
 ;;^UTILITY(U,$J,358.3,38373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38373,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,38373,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,38373,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,38374,0)
 ;;=F13.231^^145^1860^6
 ;;^UTILITY(U,$J,358.3,38374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38374,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,38374,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,38374,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,38375,0)
 ;;=F17.200^^145^1861^9
 ;;^UTILITY(U,$J,358.3,38375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38375,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38375,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,38375,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,38376,0)
 ;;=F17.201^^145^1861^10
 ;;^UTILITY(U,$J,358.3,38376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38376,1,3,0)
 ;;=3^Nicotine Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,38376,1,4,0)
 ;;=4^F17.201
 ;;^UTILITY(U,$J,358.3,38376,2)
 ;;=^5003361
 ;;^UTILITY(U,$J,358.3,38377,0)
 ;;=F17.203^^145^1861^11
 ;;^UTILITY(U,$J,358.3,38377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38377,1,3,0)
 ;;=3^Nicotine Withdrawal
