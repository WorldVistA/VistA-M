IBDEI24O ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33990,1,3,0)
 ;;=3^Thoracogenic Scoliosis,Thoracic Region
 ;;^UTILITY(U,$J,358.3,33990,1,4,0)
 ;;=4^M41.34
 ;;^UTILITY(U,$J,358.3,33990,2)
 ;;=^5011865
 ;;^UTILITY(U,$J,358.3,33991,0)
 ;;=M41.35^^132^1718^69
 ;;^UTILITY(U,$J,358.3,33991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33991,1,3,0)
 ;;=3^Thoracogenic Scoliosis,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,33991,1,4,0)
 ;;=4^M41.35
 ;;^UTILITY(U,$J,358.3,33991,2)
 ;;=^5011866
 ;;^UTILITY(U,$J,358.3,33992,0)
 ;;=M41.41^^132^1718^11
 ;;^UTILITY(U,$J,358.3,33992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33992,1,3,0)
 ;;=3^Neuromuscular Scoliosis,Occipito-Atlanto-Axial Region
 ;;^UTILITY(U,$J,358.3,33992,1,4,0)
 ;;=4^M41.41
 ;;^UTILITY(U,$J,358.3,33992,2)
 ;;=^5011868
 ;;^UTILITY(U,$J,358.3,33993,0)
 ;;=M41.42^^132^1718^7
 ;;^UTILITY(U,$J,358.3,33993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33993,1,3,0)
 ;;=3^Neuromuscular Scoliosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,33993,1,4,0)
 ;;=4^M41.42
 ;;^UTILITY(U,$J,358.3,33993,2)
 ;;=^5011869
 ;;^UTILITY(U,$J,358.3,33994,0)
 ;;=M41.43^^132^1718^8
 ;;^UTILITY(U,$J,358.3,33994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33994,1,3,0)
 ;;=3^Neuromuscular Scoliosis,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,33994,1,4,0)
 ;;=4^M41.43
 ;;^UTILITY(U,$J,358.3,33994,2)
 ;;=^5011870
 ;;^UTILITY(U,$J,358.3,33995,0)
 ;;=M41.44^^132^1718^12
 ;;^UTILITY(U,$J,358.3,33995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33995,1,3,0)
 ;;=3^Neuromuscular Scoliosis,Thoracic Region
 ;;^UTILITY(U,$J,358.3,33995,1,4,0)
 ;;=4^M41.44
 ;;^UTILITY(U,$J,358.3,33995,2)
 ;;=^5011871
 ;;^UTILITY(U,$J,358.3,33996,0)
 ;;=M41.45^^132^1718^13
 ;;^UTILITY(U,$J,358.3,33996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33996,1,3,0)
 ;;=3^Neuromuscular Scoliosis,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,33996,1,4,0)
 ;;=4^M41.45
 ;;^UTILITY(U,$J,358.3,33996,2)
 ;;=^5011872
 ;;^UTILITY(U,$J,358.3,33997,0)
 ;;=M41.46^^132^1718^9
 ;;^UTILITY(U,$J,358.3,33997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33997,1,3,0)
 ;;=3^Neuromuscular Scoliosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,33997,1,4,0)
 ;;=4^M41.46
 ;;^UTILITY(U,$J,358.3,33997,2)
 ;;=^5011873
 ;;^UTILITY(U,$J,358.3,33998,0)
 ;;=M41.47^^132^1718^10
 ;;^UTILITY(U,$J,358.3,33998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33998,1,3,0)
 ;;=3^Neuromuscular Scoliosis,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,33998,1,4,0)
 ;;=4^M41.47
 ;;^UTILITY(U,$J,358.3,33998,2)
 ;;=^5011874
 ;;^UTILITY(U,$J,358.3,33999,0)
 ;;=M41.52^^132^1718^38
 ;;^UTILITY(U,$J,358.3,33999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33999,1,3,0)
 ;;=3^Secondary Scoliosis,Other,Cervical Region
 ;;^UTILITY(U,$J,358.3,33999,1,4,0)
 ;;=4^M41.52
 ;;^UTILITY(U,$J,358.3,33999,2)
 ;;=^5011876
 ;;^UTILITY(U,$J,358.3,34000,0)
 ;;=M41.53^^132^1718^39
 ;;^UTILITY(U,$J,358.3,34000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34000,1,3,0)
 ;;=3^Secondary Scoliosis,Other,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,34000,1,4,0)
 ;;=4^M41.53
 ;;^UTILITY(U,$J,358.3,34000,2)
 ;;=^5011877
 ;;^UTILITY(U,$J,358.3,34001,0)
 ;;=M41.54^^132^1718^42
 ;;^UTILITY(U,$J,358.3,34001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34001,1,3,0)
 ;;=3^Secondary Scoliosis,Other,Thoracic Region
 ;;^UTILITY(U,$J,358.3,34001,1,4,0)
 ;;=4^M41.54
 ;;^UTILITY(U,$J,358.3,34001,2)
 ;;=^5011878
