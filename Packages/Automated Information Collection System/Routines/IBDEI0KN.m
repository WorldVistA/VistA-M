IBDEI0KN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9617,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9617,1,2,0)
 ;;=2^Eyelid lesion,destruction, up to 1 cm
 ;;^UTILITY(U,$J,358.3,9617,1,3,0)
 ;;=3^67850
 ;;^UTILITY(U,$J,358.3,9618,0)
 ;;=67840^^43^488^17^^^^1
 ;;^UTILITY(U,$J,358.3,9618,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9618,1,2,0)
 ;;=2^Eyelid lesion,excision, Simple
 ;;^UTILITY(U,$J,358.3,9618,1,3,0)
 ;;=3^67840
 ;;^UTILITY(U,$J,358.3,9619,0)
 ;;=67930^^43^488^18^^^^1
 ;;^UTILITY(U,$J,358.3,9619,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9619,1,2,0)
 ;;=2^Eyelid wound - repair
 ;;^UTILITY(U,$J,358.3,9619,1,3,0)
 ;;=3^67930
 ;;^UTILITY(U,$J,358.3,9620,0)
 ;;=65205^^43^488^21^^^^1
 ;;^UTILITY(U,$J,358.3,9620,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9620,1,2,0)
 ;;=2^FB removal conj superficial
 ;;^UTILITY(U,$J,358.3,9620,1,3,0)
 ;;=3^65205
 ;;^UTILITY(U,$J,358.3,9621,0)
 ;;=65210^^43^488^20^^^^1
 ;;^UTILITY(U,$J,358.3,9621,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9621,1,2,0)
 ;;=2^FB removal conj embedded*(incl Concretions)
 ;;^UTILITY(U,$J,358.3,9621,1,3,0)
 ;;=3^65210
 ;;^UTILITY(U,$J,358.3,9622,0)
 ;;=65222^^43^488^22^^^^1
 ;;^UTILITY(U,$J,358.3,9622,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9622,1,2,0)
 ;;=2^FB removal corneal w/slit lamp*
 ;;^UTILITY(U,$J,358.3,9622,1,3,0)
 ;;=3^65222
 ;;^UTILITY(U,$J,358.3,9623,0)
 ;;=68020^^43^488^9^^^^1
 ;;^UTILITY(U,$J,358.3,9623,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9623,1,2,0)
 ;;=2^Cyst I&D (Conj)
 ;;^UTILITY(U,$J,358.3,9623,1,3,0)
 ;;=3^68020
 ;;^UTILITY(U,$J,358.3,9624,0)
 ;;=65220^^43^488^19^^^^1
 ;;^UTILITY(U,$J,358.3,9624,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9624,1,2,0)
 ;;=2^FB Removal, Cornea w/o Slit Lamp
 ;;^UTILITY(U,$J,358.3,9624,1,3,0)
 ;;=3^65220
 ;;^UTILITY(U,$J,358.3,9625,0)
 ;;=65410^^43^488^2^^^^1
 ;;^UTILITY(U,$J,358.3,9625,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9625,1,2,0)
 ;;=2^Biopsy of Cornea
 ;;^UTILITY(U,$J,358.3,9625,1,3,0)
 ;;=3^65410
 ;;^UTILITY(U,$J,358.3,9626,0)
 ;;=67710^^43^488^30^^^^1
 ;;^UTILITY(U,$J,358.3,9626,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9626,1,2,0)
 ;;=2^Severing of Tarsorrhaphy
 ;;^UTILITY(U,$J,358.3,9626,1,3,0)
 ;;=3^67710
 ;;^UTILITY(U,$J,358.3,9627,0)
 ;;=67715^^43^488^4^^^^1
 ;;^UTILITY(U,$J,358.3,9627,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9627,1,2,0)
 ;;=2^Canthotomy
 ;;^UTILITY(U,$J,358.3,9627,1,3,0)
 ;;=3^67715
 ;;^UTILITY(U,$J,358.3,9628,0)
 ;;=67515^^43^488^25^^^^1
 ;;^UTILITY(U,$J,358.3,9628,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9628,1,2,0)
 ;;=2^Inject Tenon's capsule
 ;;^UTILITY(U,$J,358.3,9628,1,3,0)
 ;;=3^67515
 ;;^UTILITY(U,$J,358.3,9629,0)
 ;;=68135^^43^488^11^^^^1
 ;;^UTILITY(U,$J,358.3,9629,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9629,1,2,0)
 ;;=2^Destruction, Conj Lesion
 ;;^UTILITY(U,$J,358.3,9629,1,3,0)
 ;;=3^68135
 ;;^UTILITY(U,$J,358.3,9630,0)
 ;;=68760^^43^488^1^^^^1
 ;;^UTILITY(U,$J,358.3,9630,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9630,1,2,0)
 ;;=2^Ablation, Lacrimal Punctum
 ;;^UTILITY(U,$J,358.3,9630,1,3,0)
 ;;=3^68760
 ;;^UTILITY(U,$J,358.3,9631,0)
 ;;=68761^^43^488^26^^^^1
 ;;^UTILITY(U,$J,358.3,9631,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9631,1,2,0)
 ;;=2^Insert Plug, Lacrimal Punctum, each
 ;;^UTILITY(U,$J,358.3,9631,1,3,0)
 ;;=3^68761
 ;;^UTILITY(U,$J,358.3,9632,0)
 ;;=68801^^43^488^12^^^^1
 ;;^UTILITY(U,$J,358.3,9632,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9632,1,2,0)
 ;;=2^Dilate Lacrimal Punctum,w/ or w/o Irr
 ;;^UTILITY(U,$J,358.3,9632,1,3,0)
 ;;=3^68801
 ;;^UTILITY(U,$J,358.3,9633,0)
 ;;=65400^^43^488^31^^^^1
