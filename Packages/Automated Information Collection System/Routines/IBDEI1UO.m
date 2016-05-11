IBDEI1UO ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31428,1,2,0)
 ;;=2^Incision and Drainage below fascia, with/without tendon sheath involvement, foot; single bursal space 
 ;;^UTILITY(U,$J,358.3,31428,1,3,0)
 ;;=3^28002
 ;;^UTILITY(U,$J,358.3,31429,0)
 ;;=28003^^125^1592^3^^^^1
 ;;^UTILITY(U,$J,358.3,31429,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31429,1,2,0)
 ;;=2^Incision and Drainage below fascia, with/without tendon sheath involvement, foot; multiple areas 
 ;;^UTILITY(U,$J,358.3,31429,1,3,0)
 ;;=3^28003
 ;;^UTILITY(U,$J,358.3,31430,0)
 ;;=28008^^125^1592^4^^^^1
 ;;^UTILITY(U,$J,358.3,31430,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31430,1,2,0)
 ;;=2^Fasciotomy, foot and/or toe
 ;;^UTILITY(U,$J,358.3,31430,1,3,0)
 ;;=3^28008
 ;;^UTILITY(U,$J,358.3,31431,0)
 ;;=28010^^125^1592^5^^^^1
 ;;^UTILITY(U,$J,358.3,31431,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31431,1,2,0)
 ;;=2^Tenotomy, percutaneous, toe; single tendon
 ;;^UTILITY(U,$J,358.3,31431,1,3,0)
 ;;=3^28010
 ;;^UTILITY(U,$J,358.3,31432,0)
 ;;=28011^^125^1592^6^^^^1
 ;;^UTILITY(U,$J,358.3,31432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31432,1,2,0)
 ;;=2^Tenotomy, percutaneous, toe; multiple tendons
 ;;^UTILITY(U,$J,358.3,31432,1,3,0)
 ;;=3^28011
 ;;^UTILITY(U,$J,358.3,31433,0)
 ;;=28020^^125^1592^7^^^^1
 ;;^UTILITY(U,$J,358.3,31433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31433,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; intertarsal or tarsometatarsal joint
 ;;^UTILITY(U,$J,358.3,31433,1,3,0)
 ;;=3^28020
 ;;^UTILITY(U,$J,358.3,31434,0)
 ;;=28022^^125^1592^8^^^^1
 ;;^UTILITY(U,$J,358.3,31434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31434,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; metatarsophalangeal joint 
 ;;^UTILITY(U,$J,358.3,31434,1,3,0)
 ;;=3^28022
 ;;^UTILITY(U,$J,358.3,31435,0)
 ;;=28024^^125^1592^9^^^^1
 ;;^UTILITY(U,$J,358.3,31435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31435,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,31435,1,3,0)
 ;;=3^28024
 ;;^UTILITY(U,$J,358.3,31436,0)
 ;;=28035^^125^1592^11^^^^1
 ;;^UTILITY(U,$J,358.3,31436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31436,1,2,0)
 ;;=2^Release, tarsal tunnel
 ;;^UTILITY(U,$J,358.3,31436,1,3,0)
 ;;=3^28035
 ;;^UTILITY(U,$J,358.3,31437,0)
 ;;=28055^^125^1592^10^^^^1
 ;;^UTILITY(U,$J,358.3,31437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31437,1,2,0)
 ;;=2^Neurectomy, Foot
 ;;^UTILITY(U,$J,358.3,31437,1,3,0)
 ;;=3^28055
 ;;^UTILITY(U,$J,358.3,31438,0)
 ;;=28043^^125^1593^5^^^^1
 ;;^UTILITY(U,$J,358.3,31438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31438,1,2,0)
 ;;=2^Excision Tumor-Foot,SQ Tissue >1.5cm
 ;;^UTILITY(U,$J,358.3,31438,1,3,0)
 ;;=3^28043
 ;;^UTILITY(U,$J,358.3,31439,0)
 ;;=28045^^125^1593^4^^^^1
 ;;^UTILITY(U,$J,358.3,31439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31439,1,2,0)
 ;;=2^Excision Tumor-Foot,Deep Subfascial >1.5cm
 ;;^UTILITY(U,$J,358.3,31439,1,3,0)
 ;;=3^28045
 ;;^UTILITY(U,$J,358.3,31440,0)
 ;;=28050^^125^1593^2^^^^1
 ;;^UTILITY(U,$J,358.3,31440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31440,1,2,0)
 ;;=2^Arthrotomy with biopsy; intertarsal or tarsometatarsal joint 
 ;;^UTILITY(U,$J,358.3,31440,1,3,0)
 ;;=3^28050
 ;;^UTILITY(U,$J,358.3,31441,0)
 ;;=28052^^125^1593^3^^^^1
 ;;^UTILITY(U,$J,358.3,31441,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31441,1,2,0)
 ;;=2^Arthrotomy with biopsy; metatarsophalangeal joint 
 ;;^UTILITY(U,$J,358.3,31441,1,3,0)
 ;;=3^28052
