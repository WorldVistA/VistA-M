IBDEI2HJ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41706,1,3,0)
 ;;=3^28140
 ;;^UTILITY(U,$J,358.3,41707,0)
 ;;=28119^^191^2121^25^^^^1
 ;;^UTILITY(U,$J,358.3,41707,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41707,1,2,0)
 ;;=2^Ostectomy, calcaneus; for spur, with or without plantar fascial release
 ;;^UTILITY(U,$J,358.3,41707,1,3,0)
 ;;=3^28119
 ;;^UTILITY(U,$J,358.3,41708,0)
 ;;=28120^^191^2121^32^^^^1
 ;;^UTILITY(U,$J,358.3,41708,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41708,1,2,0)
 ;;=2^Partial excision bone; talus or calcaneus
 ;;^UTILITY(U,$J,358.3,41708,1,3,0)
 ;;=3^28120
 ;;^UTILITY(U,$J,358.3,41709,0)
 ;;=28122^^191^2121^33^^^^1
 ;;^UTILITY(U,$J,358.3,41709,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41709,1,2,0)
 ;;=2^Partial excision bone; tarsal or metatarsal bone, except talus or calcaneus
 ;;^UTILITY(U,$J,358.3,41709,1,3,0)
 ;;=3^28122
 ;;^UTILITY(U,$J,358.3,41710,0)
 ;;=28124^^191^2121^31^^^^1
 ;;^UTILITY(U,$J,358.3,41710,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41710,1,2,0)
 ;;=2^Partial excision bone; phalanx of toe
 ;;^UTILITY(U,$J,358.3,41710,1,3,0)
 ;;=3^28124
 ;;^UTILITY(U,$J,358.3,41711,0)
 ;;=28153^^191^2121^34^^^^1
 ;;^UTILITY(U,$J,358.3,41711,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41711,1,2,0)
 ;;=2^Resection, condyle(s), distal end of phalanx, each toe
 ;;^UTILITY(U,$J,358.3,41711,1,3,0)
 ;;=3^28153
 ;;^UTILITY(U,$J,358.3,41712,0)
 ;;=28160^^191^2121^23^^^^1
 ;;^UTILITY(U,$J,358.3,41712,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41712,1,2,0)
 ;;=2^Hemiphalangectomy or interphalangeal joint excision, toe, proximal end of phalanx, each
 ;;^UTILITY(U,$J,358.3,41712,1,3,0)
 ;;=3^28160
 ;;^UTILITY(U,$J,358.3,41713,0)
 ;;=64774^^191^2121^8^^^^1
 ;;^UTILITY(U,$J,358.3,41713,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41713,1,2,0)
 ;;=2^Excision of neuroma; cutaneous nerve, surgically identifiable
 ;;^UTILITY(U,$J,358.3,41713,1,3,0)
 ;;=3^64774
 ;;^UTILITY(U,$J,358.3,41714,0)
 ;;=64776^^191^2121^9^^^^1
 ;;^UTILITY(U,$J,358.3,41714,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41714,1,2,0)
 ;;=2^Excision of neuroma; digital nerve, one or both, same digit
 ;;^UTILITY(U,$J,358.3,41714,1,3,0)
 ;;=3^64776
 ;;^UTILITY(U,$J,358.3,41715,0)
 ;;=64778^^191^2121^10^^^^1
 ;;^UTILITY(U,$J,358.3,41715,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41715,1,2,0)
 ;;=2^Excision of neuroma; digital nerve, each additional digit (list separately in addition to code for primary procedure)
 ;;^UTILITY(U,$J,358.3,41715,1,3,0)
 ;;=3^64778
 ;;^UTILITY(U,$J,358.3,41716,0)
 ;;=64782^^191^2121^11^^^^1
 ;;^UTILITY(U,$J,358.3,41716,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41716,1,2,0)
 ;;=2^Excision of neuroma; hand or foot, except digital nerve
 ;;^UTILITY(U,$J,358.3,41716,1,3,0)
 ;;=3^64782
 ;;^UTILITY(U,$J,358.3,41717,0)
 ;;=64783^^191^2121^12^^^^1
 ;;^UTILITY(U,$J,358.3,41717,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41717,1,2,0)
 ;;=2^Excision of neuroma; hand or foot, each additional nerve, except same digit
 ;;^UTILITY(U,$J,358.3,41717,1,3,0)
 ;;=3^64783
 ;;^UTILITY(U,$J,358.3,41718,0)
 ;;=29999^^191^2122^19^^^^1
 ;;^UTILITY(U,$J,358.3,41718,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41718,1,2,0)
 ;;=2^Unlisted procedure, arthroscopy
 ;;^UTILITY(U,$J,358.3,41718,1,3,0)
 ;;=3^29999
 ;;^UTILITY(U,$J,358.3,41719,0)
 ;;=29893^^191^2122^11^^^^1
 ;;^UTILITY(U,$J,358.3,41719,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41719,1,2,0)
 ;;=2^Endoscopic plantar fasciotomy
 ;;^UTILITY(U,$J,358.3,41719,1,3,0)
 ;;=3^29893
 ;;^UTILITY(U,$J,358.3,41720,0)
 ;;=29894^^191^2122^3^^^^1
 ;;^UTILITY(U,$J,358.3,41720,1,0)
 ;;=^358.31IA^3^2
