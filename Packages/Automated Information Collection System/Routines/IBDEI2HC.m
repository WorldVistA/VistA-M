IBDEI2HC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41608,1,3,0)
 ;;=3^16020
 ;;^UTILITY(U,$J,358.3,41609,0)
 ;;=11100^^191^2116^2^^^^1
 ;;^UTILITY(U,$J,358.3,41609,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41609,1,2,0)
 ;;=2^Biopsy of skin,subq tissue single lesion
 ;;^UTILITY(U,$J,358.3,41609,1,3,0)
 ;;=3^11100
 ;;^UTILITY(U,$J,358.3,41610,0)
 ;;=11101^^191^2116^1^^^^1
 ;;^UTILITY(U,$J,358.3,41610,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41610,1,2,0)
 ;;=2^Biopsy of skin,subq tissue ea addl lesion
 ;;^UTILITY(U,$J,358.3,41610,1,3,0)
 ;;=3^11101
 ;;^UTILITY(U,$J,358.3,41611,0)
 ;;=20220^^191^2116^3^^^^1
 ;;^UTILITY(U,$J,358.3,41611,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41611,1,2,0)
 ;;=2^Biopsy,Bone,Trocar/Needle;Superficial
 ;;^UTILITY(U,$J,358.3,41611,1,3,0)
 ;;=3^20220
 ;;^UTILITY(U,$J,358.3,41612,0)
 ;;=20605^^191^2117^1^^^^1
 ;;^UTILITY(U,$J,358.3,41612,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41612,1,2,0)
 ;;=2^Arthroc,Aspir/Inj Int Joint/Bursa
 ;;^UTILITY(U,$J,358.3,41612,1,3,0)
 ;;=3^20605
 ;;^UTILITY(U,$J,358.3,41613,0)
 ;;=20615^^191^2117^6^^^^1
 ;;^UTILITY(U,$J,358.3,41613,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41613,1,2,0)
 ;;=2^Aspiration and injection for tx of bone cyst
 ;;^UTILITY(U,$J,358.3,41613,1,3,0)
 ;;=3^20615
 ;;^UTILITY(U,$J,358.3,41614,0)
 ;;=20600^^191^2117^3^^^^1
 ;;^UTILITY(U,$J,358.3,41614,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41614,1,2,0)
 ;;=2^Arthroc,Aspir/Inj Sm Joint/Bursa
 ;;^UTILITY(U,$J,358.3,41614,1,3,0)
 ;;=3^20600
 ;;^UTILITY(U,$J,358.3,41615,0)
 ;;=11900^^191^2117^15^^^^1
 ;;^UTILITY(U,$J,358.3,41615,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41615,1,2,0)
 ;;=2^Injection, intralesional; up to and including seven lesion 
 ;;^UTILITY(U,$J,358.3,41615,1,3,0)
 ;;=3^11900
 ;;^UTILITY(U,$J,358.3,41616,0)
 ;;=11901^^191^2117^14^^^^1
 ;;^UTILITY(U,$J,358.3,41616,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41616,1,2,0)
 ;;=2^Injection, intralesional; more than seven lesions
 ;;^UTILITY(U,$J,358.3,41616,1,3,0)
 ;;=3^11901
 ;;^UTILITY(U,$J,358.3,41617,0)
 ;;=64450^^191^2117^13^^^^1
 ;;^UTILITY(U,$J,358.3,41617,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41617,1,2,0)
 ;;=2^Injection, anesthetic agent; other peripheral nerve or branch
 ;;^UTILITY(U,$J,358.3,41617,1,3,0)
 ;;=3^64450
 ;;^UTILITY(U,$J,358.3,41618,0)
 ;;=20550^^191^2117^16^^^^1
 ;;^UTILITY(U,$J,358.3,41618,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41618,1,2,0)
 ;;=2^Injection; tendon sheath, ligament, ganglion cyst
 ;;^UTILITY(U,$J,358.3,41618,1,3,0)
 ;;=3^20550
 ;;^UTILITY(U,$J,358.3,41619,0)
 ;;=20500^^191^2117^10^^^^1
 ;;^UTILITY(U,$J,358.3,41619,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41619,1,2,0)
 ;;=2^Injection of sinus tract; therapeutic diagnostic
 ;;^UTILITY(U,$J,358.3,41619,1,3,0)
 ;;=3^20500
 ;;^UTILITY(U,$J,358.3,41620,0)
 ;;=96402^^191^2117^9^^^^1
 ;;^UTILITY(U,$J,358.3,41620,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41620,1,2,0)
 ;;=2^Injec,IM,anti-neplastic horm
 ;;^UTILITY(U,$J,358.3,41620,1,3,0)
 ;;=3^96402
 ;;^UTILITY(U,$J,358.3,41621,0)
 ;;=64450^^191^2117^12^^^^1
 ;;^UTILITY(U,$J,358.3,41621,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41621,1,2,0)
 ;;=2^Injection, Nerve Block
 ;;^UTILITY(U,$J,358.3,41621,1,3,0)
 ;;=3^64450
 ;;^UTILITY(U,$J,358.3,41622,0)
 ;;=96360^^191^2117^7^^^^1
 ;;^UTILITY(U,$J,358.3,41622,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41622,1,2,0)
 ;;=2^Hydration IV Inf,31-60 min
 ;;^UTILITY(U,$J,358.3,41622,1,3,0)
 ;;=3^96360
 ;;^UTILITY(U,$J,358.3,41623,0)
 ;;=96361^^191^2117^8^^^^1
 ;;^UTILITY(U,$J,358.3,41623,1,0)
 ;;=^358.31IA^3^2
