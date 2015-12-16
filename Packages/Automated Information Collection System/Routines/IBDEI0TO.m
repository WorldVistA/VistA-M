IBDEI0TO ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14368,1,3,0)
 ;;=3^28111
 ;;^UTILITY(U,$J,358.3,14369,0)
 ;;=28112^^75^886^29^^^^1
 ;;^UTILITY(U,$J,358.3,14369,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14369,1,2,0)
 ;;=2^Ostectomy, complete excision; other metatarsal head (2nd, 3rd, 4th)
 ;;^UTILITY(U,$J,358.3,14369,1,3,0)
 ;;=3^28112
 ;;^UTILITY(U,$J,358.3,14370,0)
 ;;=28113^^75^886^27^^^^1
 ;;^UTILITY(U,$J,358.3,14370,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14370,1,2,0)
 ;;=2^Ostectomy, complete excision; 5th metatarsal head
 ;;^UTILITY(U,$J,358.3,14370,1,3,0)
 ;;=3^28113
 ;;^UTILITY(U,$J,358.3,14371,0)
 ;;=28114^^75^886^28^^^^1
 ;;^UTILITY(U,$J,358.3,14371,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14371,1,2,0)
 ;;=2^Ostectomy, complete excision; all metatarsal heads, with partial proximal phalangectomy, excluding first metatarsal 
 ;;^UTILITY(U,$J,358.3,14371,1,3,0)
 ;;=3^28114
 ;;^UTILITY(U,$J,358.3,14372,0)
 ;;=28140^^75^886^24^^^^1
 ;;^UTILITY(U,$J,358.3,14372,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14372,1,2,0)
 ;;=2^Metatarsectomy
 ;;^UTILITY(U,$J,358.3,14372,1,3,0)
 ;;=3^28140
 ;;^UTILITY(U,$J,358.3,14373,0)
 ;;=28119^^75^886^25^^^^1
 ;;^UTILITY(U,$J,358.3,14373,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14373,1,2,0)
 ;;=2^Ostectomy, calcaneus; for spur, with or without plantar fascial release
 ;;^UTILITY(U,$J,358.3,14373,1,3,0)
 ;;=3^28119
 ;;^UTILITY(U,$J,358.3,14374,0)
 ;;=28120^^75^886^32^^^^1
 ;;^UTILITY(U,$J,358.3,14374,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14374,1,2,0)
 ;;=2^Partial excision bone; talus or calcaneus
 ;;^UTILITY(U,$J,358.3,14374,1,3,0)
 ;;=3^28120
 ;;^UTILITY(U,$J,358.3,14375,0)
 ;;=28122^^75^886^33^^^^1
 ;;^UTILITY(U,$J,358.3,14375,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14375,1,2,0)
 ;;=2^Partial excision bone; tarsal or metatarsal bone, except talus or calcaneus
 ;;^UTILITY(U,$J,358.3,14375,1,3,0)
 ;;=3^28122
 ;;^UTILITY(U,$J,358.3,14376,0)
 ;;=28124^^75^886^31^^^^1
 ;;^UTILITY(U,$J,358.3,14376,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14376,1,2,0)
 ;;=2^Partial excision bone; phalanx of toe
 ;;^UTILITY(U,$J,358.3,14376,1,3,0)
 ;;=3^28124
 ;;^UTILITY(U,$J,358.3,14377,0)
 ;;=28153^^75^886^34^^^^1
 ;;^UTILITY(U,$J,358.3,14377,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14377,1,2,0)
 ;;=2^Resection, condyle(s), distal end of phalanx, each toe
 ;;^UTILITY(U,$J,358.3,14377,1,3,0)
 ;;=3^28153
 ;;^UTILITY(U,$J,358.3,14378,0)
 ;;=28160^^75^886^23^^^^1
 ;;^UTILITY(U,$J,358.3,14378,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14378,1,2,0)
 ;;=2^Hemiphalangectomy or interphalangeal joint excision, toe, proximal end of phalanx, each
 ;;^UTILITY(U,$J,358.3,14378,1,3,0)
 ;;=3^28160
 ;;^UTILITY(U,$J,358.3,14379,0)
 ;;=64774^^75^886^8^^^^1
 ;;^UTILITY(U,$J,358.3,14379,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14379,1,2,0)
 ;;=2^Excision of neuroma; cutaneous nerve, surgically identifiable
 ;;^UTILITY(U,$J,358.3,14379,1,3,0)
 ;;=3^64774
 ;;^UTILITY(U,$J,358.3,14380,0)
 ;;=64776^^75^886^9^^^^1
 ;;^UTILITY(U,$J,358.3,14380,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14380,1,2,0)
 ;;=2^Excision of neuroma; digital nerve, one or both, same digit
 ;;^UTILITY(U,$J,358.3,14380,1,3,0)
 ;;=3^64776
 ;;^UTILITY(U,$J,358.3,14381,0)
 ;;=64778^^75^886^10^^^^1
 ;;^UTILITY(U,$J,358.3,14381,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14381,1,2,0)
 ;;=2^Excision of neuroma; digital nerve, each additional digit (list separately in addition to code for primary procedure)
 ;;^UTILITY(U,$J,358.3,14381,1,3,0)
 ;;=3^64778
 ;;^UTILITY(U,$J,358.3,14382,0)
 ;;=64782^^75^886^11^^^^1
