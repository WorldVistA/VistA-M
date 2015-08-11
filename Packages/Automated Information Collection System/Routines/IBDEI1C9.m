IBDEI1C9 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24005,1,3,0)
 ;;=3^28008
 ;;^UTILITY(U,$J,358.3,24006,0)
 ;;=28010^^142^1494^5^^^^1
 ;;^UTILITY(U,$J,358.3,24006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24006,1,2,0)
 ;;=2^Tenotomy, percutaneous, toe; single tendon
 ;;^UTILITY(U,$J,358.3,24006,1,3,0)
 ;;=3^28010
 ;;^UTILITY(U,$J,358.3,24007,0)
 ;;=28011^^142^1494^6^^^^1
 ;;^UTILITY(U,$J,358.3,24007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24007,1,2,0)
 ;;=2^Tenotomy, percutaneous, toe; multiple tendons
 ;;^UTILITY(U,$J,358.3,24007,1,3,0)
 ;;=3^28011
 ;;^UTILITY(U,$J,358.3,24008,0)
 ;;=28020^^142^1494^7^^^^1
 ;;^UTILITY(U,$J,358.3,24008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24008,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; intertarsal or tarsometatarsal joint
 ;;^UTILITY(U,$J,358.3,24008,1,3,0)
 ;;=3^28020
 ;;^UTILITY(U,$J,358.3,24009,0)
 ;;=28022^^142^1494^8^^^^1
 ;;^UTILITY(U,$J,358.3,24009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24009,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; metatarsophalangeal joint 
 ;;^UTILITY(U,$J,358.3,24009,1,3,0)
 ;;=3^28022
 ;;^UTILITY(U,$J,358.3,24010,0)
 ;;=28024^^142^1494^9^^^^1
 ;;^UTILITY(U,$J,358.3,24010,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24010,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,24010,1,3,0)
 ;;=3^28024
 ;;^UTILITY(U,$J,358.3,24011,0)
 ;;=28035^^142^1494^11^^^^1
 ;;^UTILITY(U,$J,358.3,24011,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24011,1,2,0)
 ;;=2^Release, tarsal tunnel
 ;;^UTILITY(U,$J,358.3,24011,1,3,0)
 ;;=3^28035
 ;;^UTILITY(U,$J,358.3,24012,0)
 ;;=28055^^142^1494^10^^^^1
 ;;^UTILITY(U,$J,358.3,24012,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24012,1,2,0)
 ;;=2^Neurectomy, Foot
 ;;^UTILITY(U,$J,358.3,24012,1,3,0)
 ;;=3^28055
 ;;^UTILITY(U,$J,358.3,24013,0)
 ;;=28043^^142^1495^1^^^^1
 ;;^UTILITY(U,$J,358.3,24013,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24013,1,2,0)
 ;;=2^Excision Tumor-Foot,SQ Tissue >1.5cm
 ;;^UTILITY(U,$J,358.3,24013,1,3,0)
 ;;=3^28043
 ;;^UTILITY(U,$J,358.3,24014,0)
 ;;=28045^^142^1495^2^^^^1
 ;;^UTILITY(U,$J,358.3,24014,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24014,1,2,0)
 ;;=2^Excision Tumor-Foot,Deep Subfascial >1.5cm
 ;;^UTILITY(U,$J,358.3,24014,1,3,0)
 ;;=3^28045
 ;;^UTILITY(U,$J,358.3,24015,0)
 ;;=28050^^142^1495^3^^^^1
 ;;^UTILITY(U,$J,358.3,24015,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24015,1,2,0)
 ;;=2^Arthrotomy with biopsy; intertarsal or tarsometatarsal joint 
 ;;^UTILITY(U,$J,358.3,24015,1,3,0)
 ;;=3^28050
 ;;^UTILITY(U,$J,358.3,24016,0)
 ;;=28052^^142^1495^4^^^^1
 ;;^UTILITY(U,$J,358.3,24016,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24016,1,2,0)
 ;;=2^Arthrotomy with biopsy; metatarsophalangeal joint 
 ;;^UTILITY(U,$J,358.3,24016,1,3,0)
 ;;=3^28052
 ;;^UTILITY(U,$J,358.3,24017,0)
 ;;=28054^^142^1495^5^^^^1
 ;;^UTILITY(U,$J,358.3,24017,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24017,1,2,0)
 ;;=2^Arthrotomy with biopsy; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,24017,1,3,0)
 ;;=3^28054
 ;;^UTILITY(U,$J,358.3,24018,0)
 ;;=28060^^142^1495^6^^^^1
 ;;^UTILITY(U,$J,358.3,24018,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24018,1,2,0)
 ;;=2^Fasciectomy, plantar fascia; partial 
 ;;^UTILITY(U,$J,358.3,24018,1,3,0)
 ;;=3^28060
 ;;^UTILITY(U,$J,358.3,24019,0)
 ;;=28062^^142^1495^7^^^^1
 ;;^UTILITY(U,$J,358.3,24019,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24019,1,2,0)
 ;;=2^Fasciectomy, plantar fascia; radical
