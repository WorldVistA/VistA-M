IBDEI0G5 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7830,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7830,1,2,0)
 ;;=2^Eyelid lesion,destruction, up to 1 cm
 ;;^UTILITY(U,$J,358.3,7830,1,3,0)
 ;;=3^67850
 ;;^UTILITY(U,$J,358.3,7831,0)
 ;;=67840^^57^598^17^^^^1
 ;;^UTILITY(U,$J,358.3,7831,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7831,1,2,0)
 ;;=2^Eyelid lesion,excision, Simple
 ;;^UTILITY(U,$J,358.3,7831,1,3,0)
 ;;=3^67840
 ;;^UTILITY(U,$J,358.3,7832,0)
 ;;=67930^^57^598^18^^^^1
 ;;^UTILITY(U,$J,358.3,7832,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7832,1,2,0)
 ;;=2^Eyelid wound - repair
 ;;^UTILITY(U,$J,358.3,7832,1,3,0)
 ;;=3^67930
 ;;^UTILITY(U,$J,358.3,7833,0)
 ;;=65205^^57^598^21^^^^1
 ;;^UTILITY(U,$J,358.3,7833,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7833,1,2,0)
 ;;=2^FB removal conj superficial
 ;;^UTILITY(U,$J,358.3,7833,1,3,0)
 ;;=3^65205
 ;;^UTILITY(U,$J,358.3,7834,0)
 ;;=65210^^57^598^20^^^^1
 ;;^UTILITY(U,$J,358.3,7834,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7834,1,2,0)
 ;;=2^FB removal conj embedded*(incl Concretions)
 ;;^UTILITY(U,$J,358.3,7834,1,3,0)
 ;;=3^65210
 ;;^UTILITY(U,$J,358.3,7835,0)
 ;;=65222^^57^598^22^^^^1
 ;;^UTILITY(U,$J,358.3,7835,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7835,1,2,0)
 ;;=2^FB removal corneal w/slit lamp*
 ;;^UTILITY(U,$J,358.3,7835,1,3,0)
 ;;=3^65222
 ;;^UTILITY(U,$J,358.3,7836,0)
 ;;=68020^^57^598^9^^^^1
 ;;^UTILITY(U,$J,358.3,7836,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7836,1,2,0)
 ;;=2^Cyst I&D (Conj)
 ;;^UTILITY(U,$J,358.3,7836,1,3,0)
 ;;=3^68020
 ;;^UTILITY(U,$J,358.3,7837,0)
 ;;=65220^^57^598^19^^^^1
 ;;^UTILITY(U,$J,358.3,7837,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7837,1,2,0)
 ;;=2^FB Removal, Cornea w/o Slit Lamp
 ;;^UTILITY(U,$J,358.3,7837,1,3,0)
 ;;=3^65220
 ;;^UTILITY(U,$J,358.3,7838,0)
 ;;=65410^^57^598^2^^^^1
 ;;^UTILITY(U,$J,358.3,7838,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7838,1,2,0)
 ;;=2^Biopsy of Cornea
 ;;^UTILITY(U,$J,358.3,7838,1,3,0)
 ;;=3^65410
 ;;^UTILITY(U,$J,358.3,7839,0)
 ;;=67710^^57^598^30^^^^1
 ;;^UTILITY(U,$J,358.3,7839,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7839,1,2,0)
 ;;=2^Severing of Tarsorrhaphy
 ;;^UTILITY(U,$J,358.3,7839,1,3,0)
 ;;=3^67710
 ;;^UTILITY(U,$J,358.3,7840,0)
 ;;=67715^^57^598^4^^^^1
 ;;^UTILITY(U,$J,358.3,7840,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7840,1,2,0)
 ;;=2^Canthotomy
 ;;^UTILITY(U,$J,358.3,7840,1,3,0)
 ;;=3^67715
 ;;^UTILITY(U,$J,358.3,7841,0)
 ;;=67515^^57^598^25^^^^1
 ;;^UTILITY(U,$J,358.3,7841,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7841,1,2,0)
 ;;=2^Inject Tenon's capsule
 ;;^UTILITY(U,$J,358.3,7841,1,3,0)
 ;;=3^67515
 ;;^UTILITY(U,$J,358.3,7842,0)
 ;;=68135^^57^598^11^^^^1
 ;;^UTILITY(U,$J,358.3,7842,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7842,1,2,0)
 ;;=2^Destruction, Conj Lesion
 ;;^UTILITY(U,$J,358.3,7842,1,3,0)
 ;;=3^68135
 ;;^UTILITY(U,$J,358.3,7843,0)
 ;;=68760^^57^598^1^^^^1
 ;;^UTILITY(U,$J,358.3,7843,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7843,1,2,0)
 ;;=2^Ablation, Lacrimal Punctum
 ;;^UTILITY(U,$J,358.3,7843,1,3,0)
 ;;=3^68760
 ;;^UTILITY(U,$J,358.3,7844,0)
 ;;=68761^^57^598^26^^^^1
 ;;^UTILITY(U,$J,358.3,7844,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7844,1,2,0)
 ;;=2^Insert Plug, Lacrimal Punctum, each
 ;;^UTILITY(U,$J,358.3,7844,1,3,0)
 ;;=3^68761
 ;;^UTILITY(U,$J,358.3,7845,0)
 ;;=68801^^57^598^12^^^^1
 ;;^UTILITY(U,$J,358.3,7845,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7845,1,2,0)
 ;;=2^Dilate Lacrimal Punctum,w/ or w/o Irr
 ;;^UTILITY(U,$J,358.3,7845,1,3,0)
 ;;=3^68801
 ;;^UTILITY(U,$J,358.3,7846,0)
 ;;=65400^^57^598^31^^^^1
