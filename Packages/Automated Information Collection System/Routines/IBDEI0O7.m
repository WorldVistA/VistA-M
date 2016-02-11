IBDEI0O7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11068,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,11068,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,11068,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,11069,0)
 ;;=J20.5^^68^677^14
 ;;^UTILITY(U,$J,358.3,11069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11069,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,11069,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,11069,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,11070,0)
 ;;=J20.7^^68^677^9
 ;;^UTILITY(U,$J,358.3,11070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11070,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,11070,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,11070,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,11071,0)
 ;;=J20.6^^68^677^15
 ;;^UTILITY(U,$J,358.3,11071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11071,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,11071,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,11071,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,11072,0)
 ;;=J18.9^^68^677^67
 ;;^UTILITY(U,$J,358.3,11072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11072,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,11072,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,11072,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,11073,0)
 ;;=J18.8^^68^677^68
 ;;^UTILITY(U,$J,358.3,11073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11073,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,11073,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,11073,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,11074,0)
 ;;=J11.00^^68^677^28
 ;;^UTILITY(U,$J,358.3,11074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11074,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,11074,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,11074,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,11075,0)
 ;;=J12.9^^68^677^69
 ;;^UTILITY(U,$J,358.3,11075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11075,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,11075,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,11075,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,11076,0)
 ;;=J10.08^^68^677^41
 ;;^UTILITY(U,$J,358.3,11076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11076,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,11076,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,11076,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,11077,0)
 ;;=J10.00^^68^677^40
 ;;^UTILITY(U,$J,358.3,11077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11077,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,11077,1,4,0)
 ;;=4^J10.00
 ;;^UTILITY(U,$J,358.3,11077,2)
 ;;=^5008148
 ;;^UTILITY(U,$J,358.3,11078,0)
 ;;=J11.08^^68^677^43
 ;;^UTILITY(U,$J,358.3,11078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11078,1,3,0)
 ;;=3^Influenza d/t Unident Flu Virus w/ Spec Pneumonia
 ;;^UTILITY(U,$J,358.3,11078,1,4,0)
 ;;=4^J11.08
 ;;^UTILITY(U,$J,358.3,11078,2)
 ;;=^5008157
 ;;^UTILITY(U,$J,358.3,11079,0)
 ;;=J10.1^^68^677^42
 ;;^UTILITY(U,$J,358.3,11079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11079,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Resp Manifest
 ;;^UTILITY(U,$J,358.3,11079,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,11079,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,11080,0)
 ;;=J10.01^^68^677^39
 ;;^UTILITY(U,$J,358.3,11080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11080,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Same Oth ID'd Flu Virus Pneumonia
 ;;^UTILITY(U,$J,358.3,11080,1,4,0)
 ;;=4^J10.01
 ;;^UTILITY(U,$J,358.3,11080,2)
 ;;=^5008149
