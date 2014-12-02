IBDEI0VT ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15734,0)
 ;;=354.0^^98^967^3
 ;;^UTILITY(U,$J,358.3,15734,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15734,1,2,0)
 ;;=2^354.0
 ;;^UTILITY(U,$J,358.3,15734,1,3,0)
 ;;=3^Carpal Tunnel
 ;;^UTILITY(U,$J,358.3,15734,2)
 ;;=Carpal Tunnel^19944
 ;;^UTILITY(U,$J,358.3,15735,0)
 ;;=351.0^^98^967^2
 ;;^UTILITY(U,$J,358.3,15735,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15735,1,2,0)
 ;;=2^351.0
 ;;^UTILITY(U,$J,358.3,15735,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,15735,2)
 ;;=Bell's Palsy^13238
 ;;^UTILITY(U,$J,358.3,15736,0)
 ;;=354.9^^98^967^4
 ;;^UTILITY(U,$J,358.3,15736,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15736,1,2,0)
 ;;=2^354.9
 ;;^UTILITY(U,$J,358.3,15736,1,3,0)
 ;;=3^Compression Neuropathy,Arm
 ;;^UTILITY(U,$J,358.3,15736,2)
 ;;=Compression Neuropathy, Arm^268509
 ;;^UTILITY(U,$J,358.3,15737,0)
 ;;=356.8^^98^967^8
 ;;^UTILITY(U,$J,358.3,15737,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15737,1,2,0)
 ;;=2^356.8
 ;;^UTILITY(U,$J,358.3,15737,1,3,0)
 ;;=3^Peripheral Neuropathy
 ;;^UTILITY(U,$J,358.3,15737,2)
 ;;=Peripheral Neuropathy^268525
 ;;^UTILITY(U,$J,358.3,15738,0)
 ;;=357.0^^98^967^7.5
 ;;^UTILITY(U,$J,358.3,15738,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15738,1,2,0)
 ;;=2^357.0
 ;;^UTILITY(U,$J,358.3,15738,1,3,0)
 ;;=3^Guillain Barre Syndrome
 ;;^UTILITY(U,$J,358.3,15738,2)
 ;;=Guillain Barre Synd^2622
 ;;^UTILITY(U,$J,358.3,15739,0)
 ;;=291.2^^98^968^1
 ;;^UTILITY(U,$J,358.3,15739,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15739,1,2,0)
 ;;=2^291.2
 ;;^UTILITY(U,$J,358.3,15739,1,3,0)
 ;;=3^Alcoholic Encephalopathy
 ;;^UTILITY(U,$J,358.3,15739,2)
 ;;=Alcoholic Encephalopathy^268015
 ;;^UTILITY(U,$J,358.3,15740,0)
 ;;=349.89^^98^968^2
 ;;^UTILITY(U,$J,358.3,15740,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15740,1,2,0)
 ;;=2^349.89
 ;;^UTILITY(U,$J,358.3,15740,1,3,0)
 ;;=3^Other Encephalopathy
 ;;^UTILITY(U,$J,358.3,15740,2)
 ;;=Other Encephalopathy^88015
 ;;^UTILITY(U,$J,358.3,15741,0)
 ;;=349.82^^98^968^3
 ;;^UTILITY(U,$J,358.3,15741,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15741,1,2,0)
 ;;=2^349.82
 ;;^UTILITY(U,$J,358.3,15741,1,3,0)
 ;;=3^Toxic Encephalopathy
 ;;^UTILITY(U,$J,358.3,15741,2)
 ;;=Toxic Encephalopathy^259061
 ;;^UTILITY(U,$J,358.3,15742,0)
 ;;=723.0^^98^969^1
 ;;^UTILITY(U,$J,358.3,15742,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15742,1,2,0)
 ;;=2^723.0
 ;;^UTILITY(U,$J,358.3,15742,1,3,0)
 ;;=3^Cervical Spinal Stenosis
 ;;^UTILITY(U,$J,358.3,15742,2)
 ;;=Cervical Spinal Stenosis^272497
 ;;^UTILITY(U,$J,358.3,15743,0)
 ;;=724.02^^98^969^7
 ;;^UTILITY(U,$J,358.3,15743,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15743,1,2,0)
 ;;=2^724.02
 ;;^UTILITY(U,$J,358.3,15743,1,3,0)
 ;;=3^Lumbar Stenosis
 ;;^UTILITY(U,$J,358.3,15743,2)
 ;;=Lumbar Stenosis^272505
 ;;^UTILITY(U,$J,358.3,15744,0)
 ;;=721.1^^98^969^2
 ;;^UTILITY(U,$J,358.3,15744,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15744,1,2,0)
 ;;=2^721.1
 ;;^UTILITY(U,$J,358.3,15744,1,3,0)
 ;;=3^Cervical Myelopathy
 ;;^UTILITY(U,$J,358.3,15744,2)
 ;;=Cervical Myelopathy^272453
 ;;^UTILITY(U,$J,358.3,15745,0)
 ;;=721.42^^98^969^5
 ;;^UTILITY(U,$J,358.3,15745,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15745,1,2,0)
 ;;=2^721.42
 ;;^UTILITY(U,$J,358.3,15745,1,3,0)
 ;;=3^Lumbar Myelopathy
 ;;^UTILITY(U,$J,358.3,15745,2)
 ;;=Lumbar Myelopathy^272459
 ;;^UTILITY(U,$J,358.3,15746,0)
 ;;=721.41^^98^969^12
 ;;^UTILITY(U,$J,358.3,15746,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15746,1,2,0)
 ;;=2^721.41
 ;;^UTILITY(U,$J,358.3,15746,1,3,0)
 ;;=3^Thoracic Myelopathy
 ;;^UTILITY(U,$J,358.3,15746,2)
 ;;=Thoracic Myelopathy^272458
