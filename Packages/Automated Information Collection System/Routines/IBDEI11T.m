IBDEI11T ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18787,1,2,0)
 ;;=2^Arthrotomy with biopsy; metatarsophalangeal joint 
 ;;^UTILITY(U,$J,358.3,18787,1,3,0)
 ;;=3^28052
 ;;^UTILITY(U,$J,358.3,18788,0)
 ;;=28054^^122^1203^5^^^^1
 ;;^UTILITY(U,$J,358.3,18788,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18788,1,2,0)
 ;;=2^Arthrotomy with biopsy; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,18788,1,3,0)
 ;;=3^28054
 ;;^UTILITY(U,$J,358.3,18789,0)
 ;;=28060^^122^1203^6^^^^1
 ;;^UTILITY(U,$J,358.3,18789,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18789,1,2,0)
 ;;=2^Fasciectomy, plantar fascia; partial 
 ;;^UTILITY(U,$J,358.3,18789,1,3,0)
 ;;=3^28060
 ;;^UTILITY(U,$J,358.3,18790,0)
 ;;=28062^^122^1203^7^^^^1
 ;;^UTILITY(U,$J,358.3,18790,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18790,1,2,0)
 ;;=2^Fasciectomy, plantar fascia; radical
 ;;^UTILITY(U,$J,358.3,18790,1,3,0)
 ;;=3^28062
 ;;^UTILITY(U,$J,358.3,18791,0)
 ;;=28080^^122^1203^8^^^^1
 ;;^UTILITY(U,$J,358.3,18791,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18791,1,2,0)
 ;;=2^Excision, interdigital (Morton) neuroma, single, each
 ;;^UTILITY(U,$J,358.3,18791,1,3,0)
 ;;=3^28080
 ;;^UTILITY(U,$J,358.3,18792,0)
 ;;=28090^^122^1203^9^^^^1
 ;;^UTILITY(U,$J,358.3,18792,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18792,1,2,0)
 ;;=2^Excision of lesion, tendon, tendon sheath, or capsule; foot
 ;;^UTILITY(U,$J,358.3,18792,1,3,0)
 ;;=3^28090
 ;;^UTILITY(U,$J,358.3,18793,0)
 ;;=28092^^122^1203^10^^^^1
 ;;^UTILITY(U,$J,358.3,18793,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18793,1,2,0)
 ;;=2^Excision of lesion, tendon, tendon sheath, or capsule; toe(s), each
 ;;^UTILITY(U,$J,358.3,18793,1,3,0)
 ;;=3^28092
 ;;^UTILITY(U,$J,358.3,18794,0)
 ;;=28100^^122^1203^11^^^^1
 ;;^UTILITY(U,$J,358.3,18794,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18794,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, talus or calcaneus
 ;;^UTILITY(U,$J,358.3,18794,1,3,0)
 ;;=3^28100
 ;;^UTILITY(U,$J,358.3,18795,0)
 ;;=28102^^122^1203^12^^^^1
 ;;^UTILITY(U,$J,358.3,18795,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18795,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, talus or calcaneus; with iliac or other autograft (includes obtaining graft)
 ;;^UTILITY(U,$J,358.3,18795,1,3,0)
 ;;=3^28102
 ;;^UTILITY(U,$J,358.3,18796,0)
 ;;=28103^^122^1203^13^^^^1
 ;;^UTILITY(U,$J,358.3,18796,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18796,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, talus or calcaneus; with allograft
 ;;^UTILITY(U,$J,358.3,18796,1,3,0)
 ;;=3^28103
 ;;^UTILITY(U,$J,358.3,18797,0)
 ;;=28104^^122^1203^14^^^^1
 ;;^UTILITY(U,$J,358.3,18797,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18797,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, tarsal or metatarsal, except talus or calcaneus 
 ;;^UTILITY(U,$J,358.3,18797,1,3,0)
 ;;=3^28104
 ;;^UTILITY(U,$J,358.3,18798,0)
 ;;=28106^^122^1203^15^^^^1
 ;;^UTILITY(U,$J,358.3,18798,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18798,1,2,0)
 ;;=2^Excision or Curettage of bone cyst or benign tumor, tarsal or metatarsal, except talus or calcaneus; with iliac or other autograft
 ;;^UTILITY(U,$J,358.3,18798,1,3,0)
 ;;=3^28106
 ;;^UTILITY(U,$J,358.3,18799,0)
 ;;=28107^^122^1203^16^^^^1
 ;;^UTILITY(U,$J,358.3,18799,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18799,1,2,0)
 ;;=2^Excision or Curettage of bone cyst of benign tumor, tarsal or metatarsal, except talus or calcaneus; with allograft
 ;;^UTILITY(U,$J,358.3,18799,1,3,0)
 ;;=3^28107
 ;;^UTILITY(U,$J,358.3,18800,0)
 ;;=28108^^122^1203^17^^^^1
