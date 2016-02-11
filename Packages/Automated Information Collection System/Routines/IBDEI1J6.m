IBDEI1J6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25586,1,3,0)
 ;;=3^Osteomyelitis,Subacute,Unspec Site
 ;;^UTILITY(U,$J,358.3,25586,1,4,0)
 ;;=4^M86.20
 ;;^UTILITY(U,$J,358.3,25586,2)
 ;;=^5014535
 ;;^UTILITY(U,$J,358.3,25587,0)
 ;;=M86.8X9^^124^1247^89
 ;;^UTILITY(U,$J,358.3,25587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25587,1,3,0)
 ;;=3^Osteomyelitis,Unspec Sites
 ;;^UTILITY(U,$J,358.3,25587,1,4,0)
 ;;=4^M86.8X9
 ;;^UTILITY(U,$J,358.3,25587,2)
 ;;=^5014655
 ;;^UTILITY(U,$J,358.3,25588,0)
 ;;=N73.5^^124^1247^92
 ;;^UTILITY(U,$J,358.3,25588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25588,1,3,0)
 ;;=3^Peritonitis,Female Pelvic,Unspec
 ;;^UTILITY(U,$J,358.3,25588,1,4,0)
 ;;=4^N73.5
 ;;^UTILITY(U,$J,358.3,25588,2)
 ;;=^5015817
 ;;^UTILITY(U,$J,358.3,25589,0)
 ;;=M00.10^^124^1247^93
 ;;^UTILITY(U,$J,358.3,25589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25589,1,3,0)
 ;;=3^Pneumococcal Arthritis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,25589,1,4,0)
 ;;=4^M00.10
 ;;^UTILITY(U,$J,358.3,25589,2)
 ;;=^5009621
 ;;^UTILITY(U,$J,358.3,25590,0)
 ;;=F10.10^^124^1248^1
 ;;^UTILITY(U,$J,358.3,25590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25590,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25590,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,25590,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,25591,0)
 ;;=F10.14^^124^1248^8
 ;;^UTILITY(U,$J,358.3,25591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25591,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25591,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,25591,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,25592,0)
 ;;=F10.182^^124^1248^10
 ;;^UTILITY(U,$J,358.3,25592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25592,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25592,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,25592,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,25593,0)
 ;;=F10.20^^124^1248^2
 ;;^UTILITY(U,$J,358.3,25593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25593,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,25593,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,25593,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,25594,0)
 ;;=F10.21^^124^1248^3
 ;;^UTILITY(U,$J,358.3,25594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25594,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,25594,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,25594,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,25595,0)
 ;;=F10.230^^124^1248^4
 ;;^UTILITY(U,$J,358.3,25595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25595,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,25595,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,25595,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,25596,0)
 ;;=F10.231^^124^1248^5
 ;;^UTILITY(U,$J,358.3,25596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25596,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,25596,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,25596,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,25597,0)
 ;;=F10.232^^124^1248^6
 ;;^UTILITY(U,$J,358.3,25597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25597,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,25597,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,25597,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,25598,0)
 ;;=F10.239^^124^1248^7
 ;;^UTILITY(U,$J,358.3,25598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25598,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
