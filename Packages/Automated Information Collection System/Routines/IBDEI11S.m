IBDEI11S ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18774,0)
 ;;=28002^^122^1202^2^^^^1
 ;;^UTILITY(U,$J,358.3,18774,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18774,1,2,0)
 ;;=2^Incision and Drainage below fascia, with/without tendon sheath involvement, foot; single bursal space 
 ;;^UTILITY(U,$J,358.3,18774,1,3,0)
 ;;=3^28002
 ;;^UTILITY(U,$J,358.3,18775,0)
 ;;=28003^^122^1202^3^^^^1
 ;;^UTILITY(U,$J,358.3,18775,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18775,1,2,0)
 ;;=2^Incision and Drainage below fascia, with/without tendon sheath involvement, foot; multiple areas 
 ;;^UTILITY(U,$J,358.3,18775,1,3,0)
 ;;=3^28003
 ;;^UTILITY(U,$J,358.3,18776,0)
 ;;=28008^^122^1202^4^^^^1
 ;;^UTILITY(U,$J,358.3,18776,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18776,1,2,0)
 ;;=2^Fasciotomy, foot and/or toe
 ;;^UTILITY(U,$J,358.3,18776,1,3,0)
 ;;=3^28008
 ;;^UTILITY(U,$J,358.3,18777,0)
 ;;=28010^^122^1202^5^^^^1
 ;;^UTILITY(U,$J,358.3,18777,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18777,1,2,0)
 ;;=2^Tenotomy, percutaneous, toe; single tendon
 ;;^UTILITY(U,$J,358.3,18777,1,3,0)
 ;;=3^28010
 ;;^UTILITY(U,$J,358.3,18778,0)
 ;;=28011^^122^1202^6^^^^1
 ;;^UTILITY(U,$J,358.3,18778,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18778,1,2,0)
 ;;=2^Tenotomy, percutaneous, toe; multiple tendons
 ;;^UTILITY(U,$J,358.3,18778,1,3,0)
 ;;=3^28011
 ;;^UTILITY(U,$J,358.3,18779,0)
 ;;=28020^^122^1202^7^^^^1
 ;;^UTILITY(U,$J,358.3,18779,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18779,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; intertarsal or tarsometatarsal joint
 ;;^UTILITY(U,$J,358.3,18779,1,3,0)
 ;;=3^28020
 ;;^UTILITY(U,$J,358.3,18780,0)
 ;;=28022^^122^1202^8^^^^1
 ;;^UTILITY(U,$J,358.3,18780,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18780,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; metatarsophalangeal joint 
 ;;^UTILITY(U,$J,358.3,18780,1,3,0)
 ;;=3^28022
 ;;^UTILITY(U,$J,358.3,18781,0)
 ;;=28024^^122^1202^9^^^^1
 ;;^UTILITY(U,$J,358.3,18781,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18781,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,18781,1,3,0)
 ;;=3^28024
 ;;^UTILITY(U,$J,358.3,18782,0)
 ;;=28035^^122^1202^11^^^^1
 ;;^UTILITY(U,$J,358.3,18782,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18782,1,2,0)
 ;;=2^Release, tarsal tunnel
 ;;^UTILITY(U,$J,358.3,18782,1,3,0)
 ;;=3^28035
 ;;^UTILITY(U,$J,358.3,18783,0)
 ;;=28055^^122^1202^10^^^^1
 ;;^UTILITY(U,$J,358.3,18783,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18783,1,2,0)
 ;;=2^Neurectomy, Foot
 ;;^UTILITY(U,$J,358.3,18783,1,3,0)
 ;;=3^28055
 ;;^UTILITY(U,$J,358.3,18784,0)
 ;;=28043^^122^1203^1^^^^1
 ;;^UTILITY(U,$J,358.3,18784,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18784,1,2,0)
 ;;=2^Excision Tumor-Foot,SQ Tissue >1.5cm
 ;;^UTILITY(U,$J,358.3,18784,1,3,0)
 ;;=3^28043
 ;;^UTILITY(U,$J,358.3,18785,0)
 ;;=28045^^122^1203^2^^^^1
 ;;^UTILITY(U,$J,358.3,18785,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18785,1,2,0)
 ;;=2^Excision Tumor-Foot,Deep Subfascial >1.5cm
 ;;^UTILITY(U,$J,358.3,18785,1,3,0)
 ;;=3^28045
 ;;^UTILITY(U,$J,358.3,18786,0)
 ;;=28050^^122^1203^3^^^^1
 ;;^UTILITY(U,$J,358.3,18786,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18786,1,2,0)
 ;;=2^Arthrotomy with biopsy; intertarsal or tarsometatarsal joint 
 ;;^UTILITY(U,$J,358.3,18786,1,3,0)
 ;;=3^28050
 ;;^UTILITY(U,$J,358.3,18787,0)
 ;;=28052^^122^1203^4^^^^1
 ;;^UTILITY(U,$J,358.3,18787,1,0)
 ;;=^358.31IA^3^2
