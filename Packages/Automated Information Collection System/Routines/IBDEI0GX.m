IBDEI0GX ; ; 19-NOV-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22859,1,3,0)
 ;;=3^28008
 ;;^UTILITY(U,$J,358.3,22860,0)
 ;;=28010^^124^1390^5^^^^1
 ;;^UTILITY(U,$J,358.3,22860,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22860,1,2,0)
 ;;=2^Tenotomy, percutaneous, toe; single tendon
 ;;^UTILITY(U,$J,358.3,22860,1,3,0)
 ;;=3^28010
 ;;^UTILITY(U,$J,358.3,22861,0)
 ;;=28011^^124^1390^6^^^^1
 ;;^UTILITY(U,$J,358.3,22861,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22861,1,2,0)
 ;;=2^Tenotomy, percutaneous, toe; multiple tendons
 ;;^UTILITY(U,$J,358.3,22861,1,3,0)
 ;;=3^28011
 ;;^UTILITY(U,$J,358.3,22862,0)
 ;;=28020^^124^1390^7^^^^1
 ;;^UTILITY(U,$J,358.3,22862,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22862,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; intertarsal or tarsometatarsal joint
 ;;^UTILITY(U,$J,358.3,22862,1,3,0)
 ;;=3^28020
 ;;^UTILITY(U,$J,358.3,22863,0)
 ;;=28022^^124^1390^8^^^^1
 ;;^UTILITY(U,$J,358.3,22863,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22863,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; metatarsophalangeal joint 
 ;;^UTILITY(U,$J,358.3,22863,1,3,0)
 ;;=3^28022
 ;;^UTILITY(U,$J,358.3,22864,0)
 ;;=28024^^124^1390^9^^^^1
 ;;^UTILITY(U,$J,358.3,22864,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22864,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,22864,1,3,0)
 ;;=3^28024
 ;;^UTILITY(U,$J,358.3,22865,0)
 ;;=28035^^124^1390^11^^^^1
 ;;^UTILITY(U,$J,358.3,22865,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22865,1,2,0)
 ;;=2^Release, tarsal tunnel
 ;;^UTILITY(U,$J,358.3,22865,1,3,0)
 ;;=3^28035
 ;;^UTILITY(U,$J,358.3,22866,0)
 ;;=28055^^124^1390^10^^^^1
 ;;^UTILITY(U,$J,358.3,22866,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22866,1,2,0)
 ;;=2^Neurectomy, Foot
 ;;^UTILITY(U,$J,358.3,22866,1,3,0)
 ;;=3^28055
 ;;^UTILITY(U,$J,358.3,22867,0)
 ;;=28043^^124^1391^1^^^^1
 ;;^UTILITY(U,$J,358.3,22867,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22867,1,2,0)
 ;;=2^Excision Tumor-Foot,SQ Tissue >1.5cm
 ;;^UTILITY(U,$J,358.3,22867,1,3,0)
 ;;=3^28043
 ;;^UTILITY(U,$J,358.3,22868,0)
 ;;=28045^^124^1391^2^^^^1
 ;;^UTILITY(U,$J,358.3,22868,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22868,1,2,0)
 ;;=2^Excision Tumor-Foot,Deep Subfascial >1.5cm
 ;;^UTILITY(U,$J,358.3,22868,1,3,0)
 ;;=3^28045
 ;;^UTILITY(U,$J,358.3,22869,0)
 ;;=28050^^124^1391^3^^^^1
 ;;^UTILITY(U,$J,358.3,22869,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22869,1,2,0)
 ;;=2^Arthrotomy with biopsy; intertarsal or tarsometatarsal joint 
 ;;^UTILITY(U,$J,358.3,22869,1,3,0)
 ;;=3^28050
 ;;^UTILITY(U,$J,358.3,22870,0)
 ;;=28052^^124^1391^4^^^^1
 ;;^UTILITY(U,$J,358.3,22870,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22870,1,2,0)
 ;;=2^Arthrotomy with biopsy; metatarsophalangeal joint 
 ;;^UTILITY(U,$J,358.3,22870,1,3,0)
 ;;=3^28052
 ;;^UTILITY(U,$J,358.3,22871,0)
 ;;=28054^^124^1391^5^^^^1
 ;;^UTILITY(U,$J,358.3,22871,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22871,1,2,0)
 ;;=2^Arthrotomy with biopsy; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,22871,1,3,0)
 ;;=3^28054
 ;;^UTILITY(U,$J,358.3,22872,0)
 ;;=28060^^124^1391^6^^^^1
 ;;^UTILITY(U,$J,358.3,22872,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22872,1,2,0)
 ;;=2^Fasciectomy, plantar fascia; partial 
 ;;^UTILITY(U,$J,358.3,22872,1,3,0)
 ;;=3^28060
 ;;^UTILITY(U,$J,358.3,22873,0)
 ;;=28062^^124^1391^7^^^^1
 ;;^UTILITY(U,$J,358.3,22873,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22873,1,2,0)
 ;;=2^Fasciectomy, plantar fascia; radical
 ;;^UTILITY(U,$J,358.3,22873,1,3,0)
 ;;=3^28062
 ;;^UTILITY(U,$J,358.3,22874,0)
 ;;=28080^^124^1391^8^^^^1
 ;;^UTILITY(U,$J,358.3,22874,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22874,1,2,0)
 ;;=2^Excision, interdigital (Morton) neuroma, single, each
 ;;^UTILITY(U,$J,358.3,22874,1,3,0)
 ;;=3^28080
 ;;^UTILITY(U,$J,358.3,22875,0)
 ;;=28090^^124^1391^9^^^^1
 ;;^UTILITY(U,$J,358.3,22875,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22875,1,2,0)
 ;;=2^Excision of lesion, tendon, tendon sheath, or capsule; foot
 ;;^UTILITY(U,$J,358.3,22875,1,3,0)
 ;;=3^28090
 ;;^UTILITY(U,$J,358.3,22876,0)
 ;;=28092^^124^1391^10^^^^1
 ;;^UTILITY(U,$J,358.3,22876,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22876,1,2,0)
 ;;=2^Excision of lesion, tendon, tendon sheath, or capsule; toe(s), each
 ;;^UTILITY(U,$J,358.3,22876,1,3,0)
 ;;=3^28092
 ;;^UTILITY(U,$J,358.3,22877,0)
 ;;=28100^^124^1391^11^^^^1
 ;;^UTILITY(U,$J,358.3,22877,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22877,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, talus or calcaneus
 ;;^UTILITY(U,$J,358.3,22877,1,3,0)
 ;;=3^28100
 ;;^UTILITY(U,$J,358.3,22878,0)
 ;;=28102^^124^1391^12^^^^1
 ;;^UTILITY(U,$J,358.3,22878,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22878,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, talus or calcaneus; with iliac or other autograft (includes obtaining graft)
 ;;^UTILITY(U,$J,358.3,22878,1,3,0)
 ;;=3^28102
 ;;^UTILITY(U,$J,358.3,22879,0)
 ;;=28103^^124^1391^13^^^^1
 ;;^UTILITY(U,$J,358.3,22879,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22879,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, talus or calcaneus; with allograft
 ;;^UTILITY(U,$J,358.3,22879,1,3,0)
 ;;=3^28103
 ;;^UTILITY(U,$J,358.3,22880,0)
 ;;=28104^^124^1391^14^^^^1
 ;;^UTILITY(U,$J,358.3,22880,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22880,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, tarsal or metatarsal, except talus or calcaneus 
 ;;^UTILITY(U,$J,358.3,22880,1,3,0)
 ;;=3^28104
 ;;^UTILITY(U,$J,358.3,22881,0)
 ;;=28106^^124^1391^15^^^^1
 ;;^UTILITY(U,$J,358.3,22881,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22881,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, tarsal or metatarsal, except talus or calcaneus; with iliac or other autograft
 ;;^UTILITY(U,$J,358.3,22881,1,3,0)
 ;;=3^28106
 ;;^UTILITY(U,$J,358.3,22882,0)
 ;;=28107^^124^1391^16^^^^1
 ;;^UTILITY(U,$J,358.3,22882,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22882,1,2,0)
 ;;=2^Excision or Curettage of bone cyst of benign tumor, tarsal or metatarsal, except talus or calcaneus; with allograft
 ;;^UTILITY(U,$J,358.3,22882,1,3,0)
 ;;=3^28107
 ;;^UTILITY(U,$J,358.3,22883,0)
 ;;=28108^^124^1391^17^^^^1
 ;;^UTILITY(U,$J,358.3,22883,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22883,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, phalanges of foot
 ;;^UTILITY(U,$J,358.3,22883,1,3,0)
 ;;=3^28108
 ;;^UTILITY(U,$J,358.3,22884,0)
 ;;=28110^^124^1391^18^^^^1
 ;;^UTILITY(U,$J,358.3,22884,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22884,1,2,0)
 ;;=2^Ostectomy, partial excision, fifth metararsal head
 ;;^UTILITY(U,$J,358.3,22884,1,3,0)
 ;;=3^28110
 ;;^UTILITY(U,$J,358.3,22885,0)
 ;;=28111^^124^1391^19^^^^1
 ;;^UTILITY(U,$J,358.3,22885,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22885,1,2,0)
 ;;=2^Ostectomy, complete excision; 1st metatarsal head
 ;;^UTILITY(U,$J,358.3,22885,1,3,0)
 ;;=3^28111
 ;;^UTILITY(U,$J,358.3,22886,0)
 ;;=28112^^124^1391^20^^^^1
 ;;^UTILITY(U,$J,358.3,22886,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22886,1,2,0)
 ;;=2^Ostectomy, complete excision; other metatarsal head (2nd, 3rd, 4th)
 ;;^UTILITY(U,$J,358.3,22886,1,3,0)
 ;;=3^28112
 ;;^UTILITY(U,$J,358.3,22887,0)
 ;;=28113^^124^1391^21^^^^1
 ;;^UTILITY(U,$J,358.3,22887,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22887,1,2,0)
 ;;=2^Ostectomy, complete excision; 5th metatarsal head
 ;;^UTILITY(U,$J,358.3,22887,1,3,0)
 ;;=3^28113
 ;;^UTILITY(U,$J,358.3,22888,0)
 ;;=28114^^124^1391^22^^^^1
 ;;^UTILITY(U,$J,358.3,22888,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22888,1,2,0)
 ;;=2^Ostectomy, complete excision; all metatarsal heads, with partial proximal phalangectomy, excluding first metatarsal 
 ;;^UTILITY(U,$J,358.3,22888,1,3,0)
 ;;=3^28114
 ;;^UTILITY(U,$J,358.3,22889,0)
 ;;=28140^^124^1391^23^^^^1
 ;;^UTILITY(U,$J,358.3,22889,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22889,1,2,0)
 ;;=2^Metatarsectomy
 ;;^UTILITY(U,$J,358.3,22889,1,3,0)
 ;;=3^28140
 ;;^UTILITY(U,$J,358.3,22890,0)
 ;;=28119^^124^1391^24^^^^1
 ;;^UTILITY(U,$J,358.3,22890,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22890,1,2,0)
 ;;=2^Ostectomy, calcaneus; for spur, with or without plantar fascial release
 ;;^UTILITY(U,$J,358.3,22890,1,3,0)
 ;;=3^28119
 ;;^UTILITY(U,$J,358.3,22891,0)
 ;;=28120^^124^1391^25^^^^1
 ;;^UTILITY(U,$J,358.3,22891,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22891,1,2,0)
 ;;=2^Partial excision bone; talus or calcaneus
 ;;^UTILITY(U,$J,358.3,22891,1,3,0)
 ;;=3^28120
 ;;^UTILITY(U,$J,358.3,22892,0)
 ;;=28122^^124^1391^26^^^^1
 ;;^UTILITY(U,$J,358.3,22892,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22892,1,2,0)
 ;;=2^Partial excision bone; tarsal or metatarsal bone, except talus or calcaneus
 ;;^UTILITY(U,$J,358.3,22892,1,3,0)
 ;;=3^28122
 ;;^UTILITY(U,$J,358.3,22893,0)
 ;;=28124^^124^1391^27^^^^1
 ;;^UTILITY(U,$J,358.3,22893,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22893,1,2,0)
 ;;=2^Partial excision bone; phalanx of toe
 ;;^UTILITY(U,$J,358.3,22893,1,3,0)
 ;;=3^28124
 ;;^UTILITY(U,$J,358.3,22894,0)
 ;;=28153^^124^1391^28^^^^1
 ;;^UTILITY(U,$J,358.3,22894,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22894,1,2,0)
 ;;=2^Resection, condyle(s), distal end of phalanx, each toe
 ;;^UTILITY(U,$J,358.3,22894,1,3,0)
 ;;=3^28153
 ;;^UTILITY(U,$J,358.3,22895,0)
 ;;=28160^^124^1391^29^^^^1
 ;;^UTILITY(U,$J,358.3,22895,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22895,1,2,0)
 ;;=2^Hemiphalangectomy or interphalangeal joint excision, toe, proximal end of phalanx, each
 ;;^UTILITY(U,$J,358.3,22895,1,3,0)
 ;;=3^28160
 ;;^UTILITY(U,$J,358.3,22896,0)
 ;;=64774^^124^1391^30^^^^1
