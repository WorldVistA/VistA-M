IBDEI2HD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41623,1,2,0)
 ;;=2^Hydration IV Infus,Ea Add Hr
 ;;^UTILITY(U,$J,358.3,41623,1,3,0)
 ;;=3^96361
 ;;^UTILITY(U,$J,358.3,41624,0)
 ;;=96365^^191^2117^18^^^^1
 ;;^UTILITY(U,$J,358.3,41624,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41624,1,2,0)
 ;;=2^Ther/Proph/Diag IV Inf,Init Hr
 ;;^UTILITY(U,$J,358.3,41624,1,3,0)
 ;;=3^96365
 ;;^UTILITY(U,$J,358.3,41625,0)
 ;;=96366^^191^2117^17^^^^1
 ;;^UTILITY(U,$J,358.3,41625,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41625,1,2,0)
 ;;=2^Ther/Proph/Diag IV Inf,Ea Add Hr
 ;;^UTILITY(U,$J,358.3,41625,1,3,0)
 ;;=3^96366
 ;;^UTILITY(U,$J,358.3,41626,0)
 ;;=96372^^191^2117^19^^^^1
 ;;^UTILITY(U,$J,358.3,41626,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41626,1,2,0)
 ;;=2^Ther/Proph/Diag Inj, SC/IM
 ;;^UTILITY(U,$J,358.3,41626,1,3,0)
 ;;=3^96372
 ;;^UTILITY(U,$J,358.3,41627,0)
 ;;=20501^^191^2117^11^^^^1
 ;;^UTILITY(U,$J,358.3,41627,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41627,1,2,0)
 ;;=2^Injection of sinus tract;diagnostic
 ;;^UTILITY(U,$J,358.3,41627,1,3,0)
 ;;=3^20501
 ;;^UTILITY(U,$J,358.3,41628,0)
 ;;=20604^^191^2117^4^^^^1
 ;;^UTILITY(U,$J,358.3,41628,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41628,1,2,0)
 ;;=2^Arthroc,Aspir/Inj Sm Joint/Bursa,US,Rec/Rpt
 ;;^UTILITY(U,$J,358.3,41628,1,3,0)
 ;;=3^20604
 ;;^UTILITY(U,$J,358.3,41629,0)
 ;;=20606^^191^2117^2^^^^1
 ;;^UTILITY(U,$J,358.3,41629,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41629,1,2,0)
 ;;=2^Arthroc,Aspir/Inj Joint/Bursa,US,Rec/Rpt
 ;;^UTILITY(U,$J,358.3,41629,1,3,0)
 ;;=3^20606
 ;;^UTILITY(U,$J,358.3,41630,0)
 ;;=20612^^191^2117^5^^^^1
 ;;^UTILITY(U,$J,358.3,41630,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41630,1,2,0)
 ;;=2^Aspirate/Inj Ganglion Cyst
 ;;^UTILITY(U,$J,358.3,41630,1,3,0)
 ;;=3^20612
 ;;^UTILITY(U,$J,358.3,41631,0)
 ;;=J0690^^191^2118^2^^^^1
 ;;^UTILITY(U,$J,358.3,41631,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41631,1,2,0)
 ;;=2^Cefazolin Sodium Inj 500mg
 ;;^UTILITY(U,$J,358.3,41631,1,3,0)
 ;;=3^J0690
 ;;^UTILITY(U,$J,358.3,41632,0)
 ;;=S0077^^191^2118^3^^^^1
 ;;^UTILITY(U,$J,358.3,41632,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41632,1,2,0)
 ;;=2^Clindamycin Phosphate Inj 300mg
 ;;^UTILITY(U,$J,358.3,41632,1,3,0)
 ;;=3^S0077
 ;;^UTILITY(U,$J,358.3,41633,0)
 ;;=J3360^^191^2118^5^^^^1
 ;;^UTILITY(U,$J,358.3,41633,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41633,1,2,0)
 ;;=2^Diazepam up to 5mg
 ;;^UTILITY(U,$J,358.3,41633,1,3,0)
 ;;=3^J3360
 ;;^UTILITY(U,$J,358.3,41634,0)
 ;;=J1710^^191^2118^6^^^^1
 ;;^UTILITY(U,$J,358.3,41634,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41634,1,2,0)
 ;;=2^Hydrocortisone Sodium Phosphate Inj up to 50mg
 ;;^UTILITY(U,$J,358.3,41634,1,3,0)
 ;;=3^J1710
 ;;^UTILITY(U,$J,358.3,41635,0)
 ;;=J2550^^191^2118^9^^^^1
 ;;^UTILITY(U,$J,358.3,41635,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41635,1,2,0)
 ;;=2^Promethazinc HCL Inj up to 50mg
 ;;^UTILITY(U,$J,358.3,41635,1,3,0)
 ;;=3^J2550
 ;;^UTILITY(U,$J,358.3,41636,0)
 ;;=J3301^^191^2118^10^^^^1
 ;;^UTILITY(U,$J,358.3,41636,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41636,1,2,0)
 ;;=2^Triamcinolone Acetonide per 10mg
 ;;^UTILITY(U,$J,358.3,41636,1,3,0)
 ;;=3^J3301
 ;;^UTILITY(U,$J,358.3,41637,0)
 ;;=J3302^^191^2118^11^^^^1
 ;;^UTILITY(U,$J,358.3,41637,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41637,1,2,0)
 ;;=2^Triamcinolone Diacetate per 5mg
 ;;^UTILITY(U,$J,358.3,41637,1,3,0)
 ;;=3^J3302
 ;;^UTILITY(U,$J,358.3,41638,0)
 ;;=J3303^^191^2118^12^^^^1
 ;;^UTILITY(U,$J,358.3,41638,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41638,1,2,0)
 ;;=2^Triamcinolone Hexacetonide per 5mg
