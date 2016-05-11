IBDEI1UP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31442,0)
 ;;=28054^^125^1593^1^^^^1
 ;;^UTILITY(U,$J,358.3,31442,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31442,1,2,0)
 ;;=2^Arthrotomy with biopsy; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,31442,1,3,0)
 ;;=3^28054
 ;;^UTILITY(U,$J,358.3,31443,0)
 ;;=28060^^125^1593^21^^^^1
 ;;^UTILITY(U,$J,358.3,31443,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31443,1,2,0)
 ;;=2^Fasciectomy, plantar fascia; partial 
 ;;^UTILITY(U,$J,358.3,31443,1,3,0)
 ;;=3^28060
 ;;^UTILITY(U,$J,358.3,31444,0)
 ;;=28062^^125^1593^22^^^^1
 ;;^UTILITY(U,$J,358.3,31444,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31444,1,2,0)
 ;;=2^Fasciectomy, plantar fascia; radical
 ;;^UTILITY(U,$J,358.3,31444,1,3,0)
 ;;=3^28062
 ;;^UTILITY(U,$J,358.3,31445,0)
 ;;=28080^^125^1593^20^^^^1
 ;;^UTILITY(U,$J,358.3,31445,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31445,1,2,0)
 ;;=2^Excision, interdigital (Morton) neuroma, single, each
 ;;^UTILITY(U,$J,358.3,31445,1,3,0)
 ;;=3^28080
 ;;^UTILITY(U,$J,358.3,31446,0)
 ;;=28090^^125^1593^6^^^^1
 ;;^UTILITY(U,$J,358.3,31446,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31446,1,2,0)
 ;;=2^Excision of lesion, tendon, tendon sheath, or capsule; foot
 ;;^UTILITY(U,$J,358.3,31446,1,3,0)
 ;;=3^28090
 ;;^UTILITY(U,$J,358.3,31447,0)
 ;;=28092^^125^1593^7^^^^1
 ;;^UTILITY(U,$J,358.3,31447,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31447,1,2,0)
 ;;=2^Excision of lesion, tendon, tendon sheath, or capsule; toe(s), each
 ;;^UTILITY(U,$J,358.3,31447,1,3,0)
 ;;=3^28092
 ;;^UTILITY(U,$J,358.3,31448,0)
 ;;=28100^^125^1593^14^^^^1
 ;;^UTILITY(U,$J,358.3,31448,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31448,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, talus or calcaneus
 ;;^UTILITY(U,$J,358.3,31448,1,3,0)
 ;;=3^28100
 ;;^UTILITY(U,$J,358.3,31449,0)
 ;;=28102^^125^1593^15^^^^1
 ;;^UTILITY(U,$J,358.3,31449,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31449,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, talus or calcaneus; with iliac or other autograft (includes obtaining graft)
 ;;^UTILITY(U,$J,358.3,31449,1,3,0)
 ;;=3^28102
 ;;^UTILITY(U,$J,358.3,31450,0)
 ;;=28103^^125^1593^16^^^^1
 ;;^UTILITY(U,$J,358.3,31450,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31450,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, talus or calcaneus; with allograft
 ;;^UTILITY(U,$J,358.3,31450,1,3,0)
 ;;=3^28103
 ;;^UTILITY(U,$J,358.3,31451,0)
 ;;=28104^^125^1593^17^^^^1
 ;;^UTILITY(U,$J,358.3,31451,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31451,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, tarsal or metatarsal, except talus or calcaneus 
 ;;^UTILITY(U,$J,358.3,31451,1,3,0)
 ;;=3^28104
 ;;^UTILITY(U,$J,358.3,31452,0)
 ;;=28106^^125^1593^18^^^^1
 ;;^UTILITY(U,$J,358.3,31452,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31452,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, tarsal or metatarsal, except talus or calcaneus; with iliac or other autograft
 ;;^UTILITY(U,$J,358.3,31452,1,3,0)
 ;;=3^28106
 ;;^UTILITY(U,$J,358.3,31453,0)
 ;;=28107^^125^1593^13^^^^1
 ;;^UTILITY(U,$J,358.3,31453,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31453,1,2,0)
 ;;=2^Excision or Curettage of bone cyst of benign tumor, tarsal or metatarsal, except talus or calcaneus; with allograft
 ;;^UTILITY(U,$J,358.3,31453,1,3,0)
 ;;=3^28107
 ;;^UTILITY(U,$J,358.3,31454,0)
 ;;=28108^^125^1593^19^^^^1
 ;;^UTILITY(U,$J,358.3,31454,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31454,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, phalanges of foot
