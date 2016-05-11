IBDEI1L9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26933,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,26933,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,26934,0)
 ;;=F19.21^^100^1296^5
 ;;^UTILITY(U,$J,358.3,26934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26934,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,26934,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,26934,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,26935,0)
 ;;=F19.24^^100^1296^4
 ;;^UTILITY(U,$J,358.3,26935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26935,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,26935,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,26935,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,26936,0)
 ;;=F13.10^^100^1297^1
 ;;^UTILITY(U,$J,358.3,26936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26936,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,26936,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,26936,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,26937,0)
 ;;=F13.14^^100^1297^7
 ;;^UTILITY(U,$J,358.3,26937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26937,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,26937,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,26937,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,26938,0)
 ;;=F13.182^^100^1297^8
 ;;^UTILITY(U,$J,358.3,26938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26938,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,26938,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,26938,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,26939,0)
 ;;=F13.20^^100^1297^2
 ;;^UTILITY(U,$J,358.3,26939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26939,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,26939,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,26939,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,26940,0)
 ;;=F13.21^^100^1297^3
 ;;^UTILITY(U,$J,358.3,26940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26940,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,26940,1,4,0)
 ;;=4^F13.21
 ;;^UTILITY(U,$J,358.3,26940,2)
 ;;=^331934
 ;;^UTILITY(U,$J,358.3,26941,0)
 ;;=F13.232^^100^1297^4
 ;;^UTILITY(U,$J,358.3,26941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26941,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,26941,1,4,0)
 ;;=4^F13.232
 ;;^UTILITY(U,$J,358.3,26941,2)
 ;;=^5003208
 ;;^UTILITY(U,$J,358.3,26942,0)
 ;;=F13.239^^100^1297^5
 ;;^UTILITY(U,$J,358.3,26942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26942,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,26942,1,4,0)
 ;;=4^F13.239
 ;;^UTILITY(U,$J,358.3,26942,2)
 ;;=^5003209
 ;;^UTILITY(U,$J,358.3,26943,0)
 ;;=F13.24^^100^1297^9
 ;;^UTILITY(U,$J,358.3,26943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26943,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Dep,Bip or Related Disorder w/ Mod-Sev Use Disorder
 ;;^UTILITY(U,$J,358.3,26943,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,26943,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,26944,0)
 ;;=F13.231^^100^1297^6
 ;;^UTILITY(U,$J,358.3,26944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26944,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,26944,1,4,0)
 ;;=4^F13.231
 ;;^UTILITY(U,$J,358.3,26944,2)
 ;;=^5003207
 ;;^UTILITY(U,$J,358.3,26945,0)
 ;;=F17.200^^100^1298^9
