IBDEI0TB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13745,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,13746,0)
 ;;=J20.4^^53^595^13
 ;;^UTILITY(U,$J,358.3,13746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13746,1,3,0)
 ;;=3^Bronchitis,Acute d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,13746,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,13746,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,13747,0)
 ;;=J20.3^^53^595^8
 ;;^UTILITY(U,$J,358.3,13747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13747,1,3,0)
 ;;=3^Bronchitis,Acute d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,13747,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,13747,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,13748,0)
 ;;=J20.9^^53^595^7
 ;;^UTILITY(U,$J,358.3,13748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13748,1,3,0)
 ;;=3^Bronchitis,Acute Unspec
 ;;^UTILITY(U,$J,358.3,13748,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,13748,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,13749,0)
 ;;=J20.8^^53^595^12
 ;;^UTILITY(U,$J,358.3,13749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13749,1,3,0)
 ;;=3^Bronchitis,Acute d/t Oth Spec Organisms
 ;;^UTILITY(U,$J,358.3,13749,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,13749,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,13750,0)
 ;;=J20.5^^53^595^14
 ;;^UTILITY(U,$J,358.3,13750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13750,1,3,0)
 ;;=3^Bronchitis,Acute d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,13750,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,13750,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,13751,0)
 ;;=J20.7^^53^595^9
 ;;^UTILITY(U,$J,358.3,13751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13751,1,3,0)
 ;;=3^Bronchitis,Acute d/t Echovirus
 ;;^UTILITY(U,$J,358.3,13751,1,4,0)
 ;;=4^J20.7
 ;;^UTILITY(U,$J,358.3,13751,2)
 ;;=^5008193
 ;;^UTILITY(U,$J,358.3,13752,0)
 ;;=J20.6^^53^595^15
 ;;^UTILITY(U,$J,358.3,13752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13752,1,3,0)
 ;;=3^Bronchitis,Acute d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,13752,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,13752,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,13753,0)
 ;;=J18.9^^53^595^67
 ;;^UTILITY(U,$J,358.3,13753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13753,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,13753,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,13753,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,13754,0)
 ;;=J18.8^^53^595^68
 ;;^UTILITY(U,$J,358.3,13754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13754,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,13754,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,13754,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,13755,0)
 ;;=J11.00^^53^595^28
 ;;^UTILITY(U,$J,358.3,13755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13755,1,3,0)
 ;;=3^Flu d/t Unidentified Flu Virus w/ Unspec Type Pneumonia
 ;;^UTILITY(U,$J,358.3,13755,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,13755,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,13756,0)
 ;;=J12.9^^53^595^69
 ;;^UTILITY(U,$J,358.3,13756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13756,1,3,0)
 ;;=3^Pneumonia,Viral Unspec
 ;;^UTILITY(U,$J,358.3,13756,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,13756,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,13757,0)
 ;;=J10.08^^53^595^41
 ;;^UTILITY(U,$J,358.3,13757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13757,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Influenza Virus w/ Oth Pneumonia
 ;;^UTILITY(U,$J,358.3,13757,1,4,0)
 ;;=4^J10.08
 ;;^UTILITY(U,$J,358.3,13757,2)
 ;;=^5008150
 ;;^UTILITY(U,$J,358.3,13758,0)
 ;;=J10.00^^53^595^40
 ;;^UTILITY(U,$J,358.3,13758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13758,1,3,0)
 ;;=3^Influenza d/t Oth ID'd Flu Virus w/ Unspec Type Pneumonia
