IBDEI1CB ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24032,1,2,0)
 ;;=2^Ostectomy, complete excision; other metatarsal head (2nd, 3rd, 4th)
 ;;^UTILITY(U,$J,358.3,24032,1,3,0)
 ;;=3^28112
 ;;^UTILITY(U,$J,358.3,24033,0)
 ;;=28113^^142^1495^21^^^^1
 ;;^UTILITY(U,$J,358.3,24033,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24033,1,2,0)
 ;;=2^Ostectomy, complete excision; 5th metatarsal head
 ;;^UTILITY(U,$J,358.3,24033,1,3,0)
 ;;=3^28113
 ;;^UTILITY(U,$J,358.3,24034,0)
 ;;=28114^^142^1495^22^^^^1
 ;;^UTILITY(U,$J,358.3,24034,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24034,1,2,0)
 ;;=2^Ostectomy, complete excision; all metatarsal heads, with partial proximal phalangectomy, excluding first metatarsal 
 ;;^UTILITY(U,$J,358.3,24034,1,3,0)
 ;;=3^28114
 ;;^UTILITY(U,$J,358.3,24035,0)
 ;;=28140^^142^1495^23^^^^1
 ;;^UTILITY(U,$J,358.3,24035,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24035,1,2,0)
 ;;=2^Metatarsectomy
 ;;^UTILITY(U,$J,358.3,24035,1,3,0)
 ;;=3^28140
 ;;^UTILITY(U,$J,358.3,24036,0)
 ;;=28119^^142^1495^24^^^^1
 ;;^UTILITY(U,$J,358.3,24036,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24036,1,2,0)
 ;;=2^Ostectomy, calcaneus; for spur, with or without plantar fascial release
 ;;^UTILITY(U,$J,358.3,24036,1,3,0)
 ;;=3^28119
 ;;^UTILITY(U,$J,358.3,24037,0)
 ;;=28120^^142^1495^25^^^^1
 ;;^UTILITY(U,$J,358.3,24037,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24037,1,2,0)
 ;;=2^Partial excision bone; talus or calcaneus
 ;;^UTILITY(U,$J,358.3,24037,1,3,0)
 ;;=3^28120
 ;;^UTILITY(U,$J,358.3,24038,0)
 ;;=28122^^142^1495^26^^^^1
 ;;^UTILITY(U,$J,358.3,24038,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24038,1,2,0)
 ;;=2^Partial excision bone; tarsal or metatarsal bone, except talus or calcaneus
 ;;^UTILITY(U,$J,358.3,24038,1,3,0)
 ;;=3^28122
 ;;^UTILITY(U,$J,358.3,24039,0)
 ;;=28124^^142^1495^27^^^^1
 ;;^UTILITY(U,$J,358.3,24039,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24039,1,2,0)
 ;;=2^Partial excision bone; phalanx of toe
 ;;^UTILITY(U,$J,358.3,24039,1,3,0)
 ;;=3^28124
 ;;^UTILITY(U,$J,358.3,24040,0)
 ;;=28153^^142^1495^28^^^^1
 ;;^UTILITY(U,$J,358.3,24040,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24040,1,2,0)
 ;;=2^Resection, condyle(s), distal end of phalanx, each toe
 ;;^UTILITY(U,$J,358.3,24040,1,3,0)
 ;;=3^28153
 ;;^UTILITY(U,$J,358.3,24041,0)
 ;;=28160^^142^1495^29^^^^1
 ;;^UTILITY(U,$J,358.3,24041,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24041,1,2,0)
 ;;=2^Hemiphalangectomy or interphalangeal joint excision, toe, proximal end of phalanx, each
 ;;^UTILITY(U,$J,358.3,24041,1,3,0)
 ;;=3^28160
 ;;^UTILITY(U,$J,358.3,24042,0)
 ;;=64774^^142^1495^30^^^^1
 ;;^UTILITY(U,$J,358.3,24042,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24042,1,2,0)
 ;;=2^Excision of neuroma; cutaneous nerve, surgically identifiable
 ;;^UTILITY(U,$J,358.3,24042,1,3,0)
 ;;=3^64774
 ;;^UTILITY(U,$J,358.3,24043,0)
 ;;=64776^^142^1495^31^^^^1
 ;;^UTILITY(U,$J,358.3,24043,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24043,1,2,0)
 ;;=2^Excision of neuroma; digital nerve, one or both, same digit
 ;;^UTILITY(U,$J,358.3,24043,1,3,0)
 ;;=3^64776
 ;;^UTILITY(U,$J,358.3,24044,0)
 ;;=64778^^142^1495^32^^^^1
 ;;^UTILITY(U,$J,358.3,24044,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24044,1,2,0)
 ;;=2^Excision of neuroma; digital nerve, each additional digit (list separately in addition to code for primary procedure)
 ;;^UTILITY(U,$J,358.3,24044,1,3,0)
 ;;=3^64778
 ;;^UTILITY(U,$J,358.3,24045,0)
 ;;=64782^^142^1495^33^^^^1
 ;;^UTILITY(U,$J,358.3,24045,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24045,1,2,0)
 ;;=2^Excision of neuroma; hand or foot, except digital nerve
