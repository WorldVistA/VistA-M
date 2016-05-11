IBDEI1C5 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22702,0)
 ;;=J20.6^^87^983^15
 ;;^UTILITY(U,$J,358.3,22702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22702,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,22702,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,22702,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,22703,0)
 ;;=J18.9^^87^983^67
 ;;^UTILITY(U,$J,358.3,22703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22703,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,22703,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,22703,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,22704,0)
 ;;=J18.8^^87^983^68
 ;;^UTILITY(U,$J,358.3,22704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22704,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,22704,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,22704,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,22705,0)
 ;;=J11.00^^87^983^28
 ;;^UTILITY(U,$J,358.3,22705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22705,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,22705,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,22705,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,22706,0)
 ;;=J12.9^^87^983^69
 ;;^UTILITY(U,$J,358.3,22706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22706,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,22706,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,22706,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,22707,0)
 ;;=J10.08^^87^983^41
 ;;^UTILITY(U,$J,358.3,22707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22707,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,22707,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,22707,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,22708,0)
 ;;=J10.00^^87^983^40
 ;;^UTILITY(U,$J,358.3,22708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22708,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,22708,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,22708,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,22709,0)
 ;;=J11.08^^87^983^43
 ;;^UTILITY(U,$J,358.3,22709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22709,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,22709,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,22709,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,22710,0)
 ;;=J10.1^^87^983^42
 ;;^UTILITY(U,$J,358.3,22710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22710,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,22710,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,22710,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,22711,0)
 ;;=J10.01^^87^983^39
 ;;^UTILITY(U,$J,358.3,22711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22711,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,22711,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,22711,2)
 ;;=^5008149
 ;;^UTILITY(U,$J,358.3,22712,0)
 ;;=J11.1^^87^983^44
 ;;^UTILITY(U,$J,358.3,22712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22712,1,3,0)
 ;;=3^Influenza d/t Unident Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,22712,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,22712,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,22713,0)
 ;;=N12.^^87^983^85
 ;;^UTILITY(U,$J,358.3,22713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22713,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,22713,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,22713,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,22714,0)
 ;;=N11.9^^87^983^86
 ;;^UTILITY(U,$J,358.3,22714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22714,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis,Chronic
