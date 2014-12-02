IBDEI11U ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18800,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18800,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, phalanges of foot
 ;;^UTILITY(U,$J,358.3,18800,1,3,0)
 ;;=3^28108
 ;;^UTILITY(U,$J,358.3,18801,0)
 ;;=28110^^122^1203^18^^^^1
 ;;^UTILITY(U,$J,358.3,18801,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18801,1,2,0)
 ;;=2^Ostectomy, partial excision, fifth metararsal head
 ;;^UTILITY(U,$J,358.3,18801,1,3,0)
 ;;=3^28110
 ;;^UTILITY(U,$J,358.3,18802,0)
 ;;=28111^^122^1203^19^^^^1
 ;;^UTILITY(U,$J,358.3,18802,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18802,1,2,0)
 ;;=2^Ostectomy, complete excision; 1st metatarsal head
 ;;^UTILITY(U,$J,358.3,18802,1,3,0)
 ;;=3^28111
 ;;^UTILITY(U,$J,358.3,18803,0)
 ;;=28112^^122^1203^20^^^^1
 ;;^UTILITY(U,$J,358.3,18803,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18803,1,2,0)
 ;;=2^Ostectomy, complete excision; other metatarsal head (2nd, 3rd, 4th)
 ;;^UTILITY(U,$J,358.3,18803,1,3,0)
 ;;=3^28112
 ;;^UTILITY(U,$J,358.3,18804,0)
 ;;=28113^^122^1203^21^^^^1
 ;;^UTILITY(U,$J,358.3,18804,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18804,1,2,0)
 ;;=2^Ostectomy, complete excision; 5th metatarsal head
 ;;^UTILITY(U,$J,358.3,18804,1,3,0)
 ;;=3^28113
 ;;^UTILITY(U,$J,358.3,18805,0)
 ;;=28114^^122^1203^22^^^^1
 ;;^UTILITY(U,$J,358.3,18805,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18805,1,2,0)
 ;;=2^Ostectomy, complete excision; all metatarsal heads, with partial proximal phalangectomy, excluding first metatarsal 
 ;;^UTILITY(U,$J,358.3,18805,1,3,0)
 ;;=3^28114
 ;;^UTILITY(U,$J,358.3,18806,0)
 ;;=28140^^122^1203^23^^^^1
 ;;^UTILITY(U,$J,358.3,18806,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18806,1,2,0)
 ;;=2^Metatarsectomy
 ;;^UTILITY(U,$J,358.3,18806,1,3,0)
 ;;=3^28140
 ;;^UTILITY(U,$J,358.3,18807,0)
 ;;=28119^^122^1203^24^^^^1
 ;;^UTILITY(U,$J,358.3,18807,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18807,1,2,0)
 ;;=2^Ostectomy, calcaneus; for spur, with or without plantar fascial release
 ;;^UTILITY(U,$J,358.3,18807,1,3,0)
 ;;=3^28119
 ;;^UTILITY(U,$J,358.3,18808,0)
 ;;=28120^^122^1203^25^^^^1
 ;;^UTILITY(U,$J,358.3,18808,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18808,1,2,0)
 ;;=2^Partial excision bone; talus or calcaneus
 ;;^UTILITY(U,$J,358.3,18808,1,3,0)
 ;;=3^28120
 ;;^UTILITY(U,$J,358.3,18809,0)
 ;;=28122^^122^1203^26^^^^1
 ;;^UTILITY(U,$J,358.3,18809,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18809,1,2,0)
 ;;=2^Partial excision bone; tarsal or metatarsal bone, except talus or calcaneus
 ;;^UTILITY(U,$J,358.3,18809,1,3,0)
 ;;=3^28122
 ;;^UTILITY(U,$J,358.3,18810,0)
 ;;=28124^^122^1203^27^^^^1
 ;;^UTILITY(U,$J,358.3,18810,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18810,1,2,0)
 ;;=2^Partial excision bone; phalanx of toe
 ;;^UTILITY(U,$J,358.3,18810,1,3,0)
 ;;=3^28124
 ;;^UTILITY(U,$J,358.3,18811,0)
 ;;=28153^^122^1203^28^^^^1
 ;;^UTILITY(U,$J,358.3,18811,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18811,1,2,0)
 ;;=2^Resection, condyle(s), distal end of phalanx, each toe
 ;;^UTILITY(U,$J,358.3,18811,1,3,0)
 ;;=3^28153
 ;;^UTILITY(U,$J,358.3,18812,0)
 ;;=28160^^122^1203^29^^^^1
 ;;^UTILITY(U,$J,358.3,18812,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18812,1,2,0)
 ;;=2^Hemiphalangectomy or interphalangeal joint excision, toe, proximal end of phalanx, each
 ;;^UTILITY(U,$J,358.3,18812,1,3,0)
 ;;=3^28160
 ;;^UTILITY(U,$J,358.3,18813,0)
 ;;=64774^^122^1203^30^^^^1
 ;;^UTILITY(U,$J,358.3,18813,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18813,1,2,0)
 ;;=2^Excision of neuroma; cutaneous nerve, surgically identifiable
