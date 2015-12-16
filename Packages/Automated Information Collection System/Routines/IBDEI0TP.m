IBDEI0TP ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14382,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14382,1,2,0)
 ;;=2^Excision of neuroma; hand or foot, except digital nerve
 ;;^UTILITY(U,$J,358.3,14382,1,3,0)
 ;;=3^64782
 ;;^UTILITY(U,$J,358.3,14383,0)
 ;;=64783^^75^886^12^^^^1
 ;;^UTILITY(U,$J,358.3,14383,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14383,1,2,0)
 ;;=2^Excision of neuroma; hand or foot, each additional nerve, except same digit
 ;;^UTILITY(U,$J,358.3,14383,1,3,0)
 ;;=3^64783
 ;;^UTILITY(U,$J,358.3,14384,0)
 ;;=29999^^75^887^19^^^^1
 ;;^UTILITY(U,$J,358.3,14384,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14384,1,2,0)
 ;;=2^Unlisted procedure, arthroscopy
 ;;^UTILITY(U,$J,358.3,14384,1,3,0)
 ;;=3^29999
 ;;^UTILITY(U,$J,358.3,14385,0)
 ;;=29893^^75^887^11^^^^1
 ;;^UTILITY(U,$J,358.3,14385,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14385,1,2,0)
 ;;=2^Endoscopic plantar fasciotomy
 ;;^UTILITY(U,$J,358.3,14385,1,3,0)
 ;;=3^29893
 ;;^UTILITY(U,$J,358.3,14386,0)
 ;;=29894^^75^887^3^^^^1
 ;;^UTILITY(U,$J,358.3,14386,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14386,1,2,0)
 ;;=2^Arthroscopy, ankle, surgical; w/removalof loose body or foreign body
 ;;^UTILITY(U,$J,358.3,14386,1,3,0)
 ;;=3^29894
 ;;^UTILITY(U,$J,358.3,14387,0)
 ;;=29897^^75^887^1^^^^1
 ;;^UTILITY(U,$J,358.3,14387,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14387,1,2,0)
 ;;=2^Arthroscopy, ankle, surgical; debridement, limited
 ;;^UTILITY(U,$J,358.3,14387,1,3,0)
 ;;=3^29897
 ;;^UTILITY(U,$J,358.3,14388,0)
 ;;=29898^^75^887^2^^^^1
 ;;^UTILITY(U,$J,358.3,14388,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14388,1,2,0)
 ;;=2^Arthroscopy, ankle, surgical; debridement, extensive
 ;;^UTILITY(U,$J,358.3,14388,1,3,0)
 ;;=3^29898
 ;;^UTILITY(U,$J,358.3,14389,0)
 ;;=20220^^75^887^8^^^^1
 ;;^UTILITY(U,$J,358.3,14389,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14389,1,2,0)
 ;;=2^Biopsy, bone, trocar, or needle; superficial
 ;;^UTILITY(U,$J,358.3,14389,1,3,0)
 ;;=3^20220
 ;;^UTILITY(U,$J,358.3,14390,0)
 ;;=20650^^75^887^14^^^^1
 ;;^UTILITY(U,$J,358.3,14390,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14390,1,2,0)
 ;;=2^Insertion of wire or pin with application of skeletal traction, including removal
 ;;^UTILITY(U,$J,358.3,14390,1,3,0)
 ;;=3^20650
 ;;^UTILITY(U,$J,358.3,14391,0)
 ;;=64726^^75^887^10^^^^1
 ;;^UTILITY(U,$J,358.3,14391,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14391,1,2,0)
 ;;=2^Decompression; plantar digital nerve
 ;;^UTILITY(U,$J,358.3,14391,1,3,0)
 ;;=3^64726
 ;;^UTILITY(U,$J,358.3,14392,0)
 ;;=64999^^75^887^20^^^^1
 ;;^UTILITY(U,$J,358.3,14392,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14392,1,2,0)
 ;;=2^Unlisted procedure, nervous system
 ;;^UTILITY(U,$J,358.3,14392,1,3,0)
 ;;=3^64999
 ;;^UTILITY(U,$J,358.3,14393,0)
 ;;=93922^^75^887^18^^^^1
 ;;^UTILITY(U,$J,358.3,14393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14393,1,2,0)
 ;;=2^Non-invasive physiologic studies of upper or lower extremity arteries, single level, bilateral
 ;;^UTILITY(U,$J,358.3,14393,1,3,0)
 ;;=3^93922
 ;;^UTILITY(U,$J,358.3,14394,0)
 ;;=29904^^75^887^6^^^^1
 ;;^UTILITY(U,$J,358.3,14394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14394,1,2,0)
 ;;=2^Arthroscopy,subtalar jt,w/rem of foreign body
 ;;^UTILITY(U,$J,358.3,14394,1,3,0)
 ;;=3^29904
 ;;^UTILITY(U,$J,358.3,14395,0)
 ;;=29905^^75^887^5^^^^1
 ;;^UTILITY(U,$J,358.3,14395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14395,1,2,0)
 ;;=2^Arthroscopy,subtalar jt,w/ Synovectomy
 ;;^UTILITY(U,$J,358.3,14395,1,3,0)
 ;;=3^29905
 ;;^UTILITY(U,$J,358.3,14396,0)
 ;;=29906^^75^887^4^^^^1
 ;;^UTILITY(U,$J,358.3,14396,1,0)
 ;;=^358.31IA^3^2
