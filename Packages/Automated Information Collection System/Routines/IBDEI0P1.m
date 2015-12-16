IBDEI0P1 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11951,1,2,0)
 ;;=2^250.60
 ;;^UTILITY(U,$J,358.3,11951,1,3,0)
 ;;=3^Diabetes W/Neuropathy
 ;;^UTILITY(U,$J,358.3,11951,2)
 ;;=Diabetes w/Neuropathy^267841^357.2
 ;;^UTILITY(U,$J,358.3,11952,0)
 ;;=337.9^^58^702^1
 ;;^UTILITY(U,$J,358.3,11952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11952,1,2,0)
 ;;=2^337.9
 ;;^UTILITY(U,$J,358.3,11952,1,3,0)
 ;;=3^Autonomic Neuropathy
 ;;^UTILITY(U,$J,358.3,11952,2)
 ;;=Autonomic Neuropathy^11827
 ;;^UTILITY(U,$J,358.3,11953,0)
 ;;=355.8^^58^702^6
 ;;^UTILITY(U,$J,358.3,11953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11953,1,2,0)
 ;;=2^355.8
 ;;^UTILITY(U,$J,358.3,11953,1,3,0)
 ;;=3^Compression Neuropathy,Leg
 ;;^UTILITY(U,$J,358.3,11953,2)
 ;;=Compression Neuropathy, Leg^268511
 ;;^UTILITY(U,$J,358.3,11954,0)
 ;;=354.0^^58^702^3
 ;;^UTILITY(U,$J,358.3,11954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11954,1,2,0)
 ;;=2^354.0
 ;;^UTILITY(U,$J,358.3,11954,1,3,0)
 ;;=3^Carpal Tunnel
 ;;^UTILITY(U,$J,358.3,11954,2)
 ;;=Carpal Tunnel^19944
 ;;^UTILITY(U,$J,358.3,11955,0)
 ;;=351.0^^58^702^2
 ;;^UTILITY(U,$J,358.3,11955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11955,1,2,0)
 ;;=2^351.0
 ;;^UTILITY(U,$J,358.3,11955,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,11955,2)
 ;;=Bell's Palsy^13238
 ;;^UTILITY(U,$J,358.3,11956,0)
 ;;=354.9^^58^702^5
 ;;^UTILITY(U,$J,358.3,11956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11956,1,2,0)
 ;;=2^354.9
 ;;^UTILITY(U,$J,358.3,11956,1,3,0)
 ;;=3^Compression Neuropathy,Arm
 ;;^UTILITY(U,$J,358.3,11956,2)
 ;;=Compression Neuropathy, Arm^268509
 ;;^UTILITY(U,$J,358.3,11957,0)
 ;;=356.8^^58^702^10
 ;;^UTILITY(U,$J,358.3,11957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11957,1,2,0)
 ;;=2^356.8
 ;;^UTILITY(U,$J,358.3,11957,1,3,0)
 ;;=3^Peripheral Neuropathy
 ;;^UTILITY(U,$J,358.3,11957,2)
 ;;=Peripheral Neuropathy^268525
 ;;^UTILITY(U,$J,358.3,11958,0)
 ;;=357.0^^58^702^8
 ;;^UTILITY(U,$J,358.3,11958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11958,1,2,0)
 ;;=2^357.0
 ;;^UTILITY(U,$J,358.3,11958,1,3,0)
 ;;=3^Guillain Barre Syndrome
 ;;^UTILITY(U,$J,358.3,11958,2)
 ;;=Guillain Barre Synd^2622
 ;;^UTILITY(U,$J,358.3,11959,0)
 ;;=357.89^^58^702^9
 ;;^UTILITY(U,$J,358.3,11959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11959,1,2,0)
 ;;=2^357.89
 ;;^UTILITY(U,$J,358.3,11959,1,3,0)
 ;;=3^Inflam & Toxic Neuropathy
 ;;^UTILITY(U,$J,358.3,11959,2)
 ;;=^328483
 ;;^UTILITY(U,$J,358.3,11960,0)
 ;;=357.81^^58^702^4
 ;;^UTILITY(U,$J,358.3,11960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11960,1,2,0)
 ;;=2^357.81
 ;;^UTILITY(U,$J,358.3,11960,1,3,0)
 ;;=3^Chr Inflam Demyelin Polyneuropathy
 ;;^UTILITY(U,$J,358.3,11960,2)
 ;;=^328480
 ;;^UTILITY(U,$J,358.3,11961,0)
 ;;=291.2^^58^703^2
 ;;^UTILITY(U,$J,358.3,11961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11961,1,2,0)
 ;;=2^291.2
 ;;^UTILITY(U,$J,358.3,11961,1,3,0)
 ;;=3^Encephalopathy,Alcoholic
 ;;^UTILITY(U,$J,358.3,11961,2)
 ;;=Alcoholic Encephalopathy^268015
 ;;^UTILITY(U,$J,358.3,11962,0)
 ;;=349.89^^58^703^1
 ;;^UTILITY(U,$J,358.3,11962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11962,1,2,0)
 ;;=2^349.89
 ;;^UTILITY(U,$J,358.3,11962,1,3,0)
 ;;=3^Encephalopathy NEC
 ;;^UTILITY(U,$J,358.3,11962,2)
 ;;=Other Encephalopathy^88015
 ;;^UTILITY(U,$J,358.3,11963,0)
 ;;=349.82^^58^703^4
 ;;^UTILITY(U,$J,358.3,11963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11963,1,2,0)
 ;;=2^349.82
 ;;^UTILITY(U,$J,358.3,11963,1,3,0)
 ;;=3^Encephalopathy,Toxic
 ;;^UTILITY(U,$J,358.3,11963,2)
 ;;=Toxic Encephalopathy^259061
