IBDEI0ZK ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46639,1,2,0)
 ;;=2^Ostectomy, complete excision; all metatarsal heads, with partial proximal phalangectomy, excluding first metatarsal 
 ;;^UTILITY(U,$J,358.3,46639,1,3,0)
 ;;=3^28114
 ;;^UTILITY(U,$J,358.3,46640,0)
 ;;=28140^^138^1968^24^^^^1
 ;;^UTILITY(U,$J,358.3,46640,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46640,1,2,0)
 ;;=2^Metatarsectomy
 ;;^UTILITY(U,$J,358.3,46640,1,3,0)
 ;;=3^28140
 ;;^UTILITY(U,$J,358.3,46641,0)
 ;;=28119^^138^1968^25^^^^1
 ;;^UTILITY(U,$J,358.3,46641,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46641,1,2,0)
 ;;=2^Ostectomy, calcaneus; for spur, with or without plantar fascial release
 ;;^UTILITY(U,$J,358.3,46641,1,3,0)
 ;;=3^28119
 ;;^UTILITY(U,$J,358.3,46642,0)
 ;;=28120^^138^1968^32^^^^1
 ;;^UTILITY(U,$J,358.3,46642,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46642,1,2,0)
 ;;=2^Partial excision bone; talus or calcaneus
 ;;^UTILITY(U,$J,358.3,46642,1,3,0)
 ;;=3^28120
 ;;^UTILITY(U,$J,358.3,46643,0)
 ;;=28122^^138^1968^33^^^^1
 ;;^UTILITY(U,$J,358.3,46643,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46643,1,2,0)
 ;;=2^Partial excision bone; tarsal or metatarsal bone, except talus or calcaneus
 ;;^UTILITY(U,$J,358.3,46643,1,3,0)
 ;;=3^28122
 ;;^UTILITY(U,$J,358.3,46644,0)
 ;;=28124^^138^1968^31^^^^1
 ;;^UTILITY(U,$J,358.3,46644,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46644,1,2,0)
 ;;=2^Partial excision bone; phalanx of toe
 ;;^UTILITY(U,$J,358.3,46644,1,3,0)
 ;;=3^28124
 ;;^UTILITY(U,$J,358.3,46645,0)
 ;;=28153^^138^1968^34^^^^1
 ;;^UTILITY(U,$J,358.3,46645,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46645,1,2,0)
 ;;=2^Resection, condyle(s), distal end of phalanx, each toe
 ;;^UTILITY(U,$J,358.3,46645,1,3,0)
 ;;=3^28153
 ;;^UTILITY(U,$J,358.3,46646,0)
 ;;=28160^^138^1968^23^^^^1
 ;;^UTILITY(U,$J,358.3,46646,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46646,1,2,0)
 ;;=2^Hemiphalangectomy or interphalangeal joint excision, toe, proximal end of phalanx, each
 ;;^UTILITY(U,$J,358.3,46646,1,3,0)
 ;;=3^28160
 ;;^UTILITY(U,$J,358.3,46647,0)
 ;;=64774^^138^1968^8^^^^1
 ;;^UTILITY(U,$J,358.3,46647,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46647,1,2,0)
 ;;=2^Excision of neuroma; cutaneous nerve, surgically identifiable
 ;;^UTILITY(U,$J,358.3,46647,1,3,0)
 ;;=3^64774
 ;;^UTILITY(U,$J,358.3,46648,0)
 ;;=64776^^138^1968^9^^^^1
 ;;^UTILITY(U,$J,358.3,46648,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46648,1,2,0)
 ;;=2^Excision of neuroma; digital nerve, one or both, same digit
 ;;^UTILITY(U,$J,358.3,46648,1,3,0)
 ;;=3^64776
 ;;^UTILITY(U,$J,358.3,46649,0)
 ;;=64778^^138^1968^10^^^^1
 ;;^UTILITY(U,$J,358.3,46649,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46649,1,2,0)
 ;;=2^Excision of neuroma; digital nerve, each additional digit (list separately in addition to code for primary procedure)
 ;;^UTILITY(U,$J,358.3,46649,1,3,0)
 ;;=3^64778
 ;;^UTILITY(U,$J,358.3,46650,0)
 ;;=64782^^138^1968^11^^^^1
 ;;^UTILITY(U,$J,358.3,46650,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46650,1,2,0)
 ;;=2^Excision of neuroma; hand or foot, except digital nerve
 ;;^UTILITY(U,$J,358.3,46650,1,3,0)
 ;;=3^64782
 ;;^UTILITY(U,$J,358.3,46651,0)
 ;;=64783^^138^1968^12^^^^1
 ;;^UTILITY(U,$J,358.3,46651,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46651,1,2,0)
 ;;=2^Excision of neuroma; hand or foot, each additional nerve, except same digit
 ;;^UTILITY(U,$J,358.3,46651,1,3,0)
 ;;=3^64783
 ;;^UTILITY(U,$J,358.3,46652,0)
 ;;=29999^^138^1969^19^^^^1
 ;;^UTILITY(U,$J,358.3,46652,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46652,1,2,0)
 ;;=2^Unlisted procedure, arthroscopy
 ;;^UTILITY(U,$J,358.3,46652,1,3,0)
 ;;=3^29999
 ;;^UTILITY(U,$J,358.3,46653,0)
 ;;=29893^^138^1969^11^^^^1
 ;;^UTILITY(U,$J,358.3,46653,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46653,1,2,0)
 ;;=2^Endoscopic plantar fasciotomy
 ;;^UTILITY(U,$J,358.3,46653,1,3,0)
 ;;=3^29893
 ;;^UTILITY(U,$J,358.3,46654,0)
 ;;=29894^^138^1969^3^^^^1
 ;;^UTILITY(U,$J,358.3,46654,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46654,1,2,0)
 ;;=2^Arthroscopy, ankle, surgical; w/removalof loose body or foreign body
 ;;^UTILITY(U,$J,358.3,46654,1,3,0)
 ;;=3^29894
 ;;^UTILITY(U,$J,358.3,46655,0)
 ;;=29897^^138^1969^1^^^^1
 ;;^UTILITY(U,$J,358.3,46655,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46655,1,2,0)
 ;;=2^Arthroscopy, ankle, surgical; debridement, limited
 ;;^UTILITY(U,$J,358.3,46655,1,3,0)
 ;;=3^29897
 ;;^UTILITY(U,$J,358.3,46656,0)
 ;;=29898^^138^1969^2^^^^1
 ;;^UTILITY(U,$J,358.3,46656,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46656,1,2,0)
 ;;=2^Arthroscopy, ankle, surgical; debridement, extensive
 ;;^UTILITY(U,$J,358.3,46656,1,3,0)
 ;;=3^29898
 ;;^UTILITY(U,$J,358.3,46657,0)
 ;;=20220^^138^1969^8^^^^1
 ;;^UTILITY(U,$J,358.3,46657,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46657,1,2,0)
 ;;=2^Biopsy, bone, trocar, or needle; superficial
 ;;^UTILITY(U,$J,358.3,46657,1,3,0)
 ;;=3^20220
 ;;^UTILITY(U,$J,358.3,46658,0)
 ;;=20650^^138^1969^14^^^^1
 ;;^UTILITY(U,$J,358.3,46658,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46658,1,2,0)
 ;;=2^Insertion of wire or pin with application of skeletal traction, including removal
 ;;^UTILITY(U,$J,358.3,46658,1,3,0)
 ;;=3^20650
 ;;^UTILITY(U,$J,358.3,46659,0)
 ;;=64726^^138^1969^10^^^^1
 ;;^UTILITY(U,$J,358.3,46659,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46659,1,2,0)
 ;;=2^Decompression; plantar digital nerve
 ;;^UTILITY(U,$J,358.3,46659,1,3,0)
 ;;=3^64726
 ;;^UTILITY(U,$J,358.3,46660,0)
 ;;=64999^^138^1969^20^^^^1
 ;;^UTILITY(U,$J,358.3,46660,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46660,1,2,0)
 ;;=2^Unlisted procedure, nervous system
 ;;^UTILITY(U,$J,358.3,46660,1,3,0)
 ;;=3^64999
 ;;^UTILITY(U,$J,358.3,46661,0)
 ;;=93922^^138^1969^18^^^^1
 ;;^UTILITY(U,$J,358.3,46661,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46661,1,2,0)
 ;;=2^Non-invasive physiologic studies of upper or lower extremity arteries, single level, bilateral
 ;;^UTILITY(U,$J,358.3,46661,1,3,0)
 ;;=3^93922
 ;;^UTILITY(U,$J,358.3,46662,0)
 ;;=29904^^138^1969^6^^^^1
 ;;^UTILITY(U,$J,358.3,46662,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46662,1,2,0)
 ;;=2^Arthroscopy,subtalar jt,w/rem of foreign body
 ;;^UTILITY(U,$J,358.3,46662,1,3,0)
 ;;=3^29904
 ;;^UTILITY(U,$J,358.3,46663,0)
 ;;=29905^^138^1969^5^^^^1
 ;;^UTILITY(U,$J,358.3,46663,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46663,1,2,0)
 ;;=2^Arthroscopy,subtalar jt,w/ Synovectomy
 ;;^UTILITY(U,$J,358.3,46663,1,3,0)
 ;;=3^29905
 ;;^UTILITY(U,$J,358.3,46664,0)
 ;;=29906^^138^1969^4^^^^1
 ;;^UTILITY(U,$J,358.3,46664,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46664,1,2,0)
 ;;=2^Arthroscopy, subtalar jt,w/ debridement
 ;;^UTILITY(U,$J,358.3,46664,1,3,0)
 ;;=3^29906
 ;;^UTILITY(U,$J,358.3,46665,0)
 ;;=29907^^138^1969^7^^^^1
 ;;^UTILITY(U,$J,358.3,46665,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46665,1,2,0)
 ;;=2^Arthroscopy,subtalar w/ fusion
 ;;^UTILITY(U,$J,358.3,46665,1,3,0)
 ;;=3^29907
 ;;^UTILITY(U,$J,358.3,46666,0)
 ;;=97605^^138^1969^16^^^^1
 ;;^UTILITY(U,$J,358.3,46666,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46666,1,2,0)
 ;;=2^Neg Press Wound Tx <= 50 cm
 ;;^UTILITY(U,$J,358.3,46666,1,3,0)
 ;;=3^97605
 ;;^UTILITY(U,$J,358.3,46667,0)
 ;;=97606^^138^1969^17^^^^1
 ;;^UTILITY(U,$J,358.3,46667,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46667,1,2,0)
 ;;=2^Neg Press Wound Tx > 50 cm
 ;;^UTILITY(U,$J,358.3,46667,1,3,0)
 ;;=3^97606
 ;;^UTILITY(U,$J,358.3,46668,0)
 ;;=2028F^^138^1969^12^^^^1
 ;;^UTILITY(U,$J,358.3,46668,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46668,1,2,0)
 ;;=2^Foot Exam Performed
 ;;^UTILITY(U,$J,358.3,46668,1,3,0)
 ;;=3^2028F
 ;;^UTILITY(U,$J,358.3,46669,0)
 ;;=G8883^^138^1969^9^^^^1
 ;;^UTILITY(U,$J,358.3,46669,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46669,1,2,0)
 ;;=2^Bx Result RVW,Comm,Tracked
 ;;^UTILITY(U,$J,358.3,46669,1,3,0)
 ;;=3^G8883
 ;;^UTILITY(U,$J,358.3,46670,0)
 ;;=S0395^^138^1969^13^^^^1
 ;;^UTILITY(U,$J,358.3,46670,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46670,1,2,0)
 ;;=2^Impression Cast
 ;;^UTILITY(U,$J,358.3,46670,1,3,0)
 ;;=3^S0395
 ;;^UTILITY(U,$J,358.3,46671,0)
 ;;=E2402^^138^1969^15^^^^1
 ;;^UTILITY(U,$J,358.3,46671,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46671,1,2,0)
 ;;=2^Neg Press Wound Therapy Pump
 ;;^UTILITY(U,$J,358.3,46671,1,3,0)
 ;;=3^E2402
 ;;^UTILITY(U,$J,358.3,46672,0)
 ;;=28400^^138^1970^4^^^^1
 ;;^UTILITY(U,$J,358.3,46672,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46672,1,2,0)
 ;;=2^Closed TX of calcaneal fracture; without manipulation
 ;;^UTILITY(U,$J,358.3,46672,1,3,0)
 ;;=3^28400
 ;;^UTILITY(U,$J,358.3,46673,0)
 ;;=28405^^138^1970^3^^^^1
 ;;^UTILITY(U,$J,358.3,46673,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46673,1,2,0)
 ;;=2^Closed TX of calcaneal fracture; with manipulation
 ;;^UTILITY(U,$J,358.3,46673,1,3,0)
 ;;=3^28405
 ;;^UTILITY(U,$J,358.3,46674,0)
 ;;=28406^^138^1970^66^^^^1
 ;;^UTILITY(U,$J,358.3,46674,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46674,1,2,0)
 ;;=2^Perc Fixation of Calcaneous Fx
 ;;^UTILITY(U,$J,358.3,46674,1,3,0)
 ;;=3^28406
 ;;^UTILITY(U,$J,358.3,46675,0)
 ;;=28415^^138^1970^34^^^^1
 ;;^UTILITY(U,$J,358.3,46675,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46675,1,2,0)
 ;;=2^Open TX of calcaneal fracture, with or without internal or external fixation;
 ;;^UTILITY(U,$J,358.3,46675,1,3,0)
 ;;=3^28415
 ;;^UTILITY(U,$J,358.3,46676,0)
 ;;=28420^^138^1970^35^^^^1
 ;;^UTILITY(U,$J,358.3,46676,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46676,1,2,0)
 ;;=2^Open TX of calcaneal fracture, with or without internal or external fixation; with primary iliac or other autogenous bone graft
 ;;^UTILITY(U,$J,358.3,46676,1,3,0)
 ;;=3^28420
 ;;^UTILITY(U,$J,358.3,46677,0)
 ;;=28430^^138^1970^17^^^^1
 ;;^UTILITY(U,$J,358.3,46677,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46677,1,2,0)
 ;;=2^Closed TX of talus fracture; without manipulation 
