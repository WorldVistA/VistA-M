IBDEI06C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2369,1,4,0)
 ;;=4^I36.1
 ;;^UTILITY(U,$J,358.3,2369,2)
 ;;=^5007180
 ;;^UTILITY(U,$J,358.3,2370,0)
 ;;=I37.0^^19^200^3
 ;;^UTILITY(U,$J,358.3,2370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2370,1,3,0)
 ;;=3^Nonrheumatic Pulmonary Valve Stenosis
 ;;^UTILITY(U,$J,358.3,2370,1,4,0)
 ;;=4^I37.0
 ;;^UTILITY(U,$J,358.3,2370,2)
 ;;=^5007184
 ;;^UTILITY(U,$J,358.3,2371,0)
 ;;=I51.1^^19^201^1
 ;;^UTILITY(U,$J,358.3,2371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2371,1,3,0)
 ;;=3^Rupture of Chordae Tendineae NEC
 ;;^UTILITY(U,$J,358.3,2371,1,4,0)
 ;;=4^I51.1
 ;;^UTILITY(U,$J,358.3,2371,2)
 ;;=^5007253
 ;;^UTILITY(U,$J,358.3,2372,0)
 ;;=I51.2^^19^201^2
 ;;^UTILITY(U,$J,358.3,2372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2372,1,3,0)
 ;;=3^Rupture of Papillary Muscle NEC
 ;;^UTILITY(U,$J,358.3,2372,1,4,0)
 ;;=4^I51.2
 ;;^UTILITY(U,$J,358.3,2372,2)
 ;;=^5007254
 ;;^UTILITY(U,$J,358.3,2373,0)
 ;;=I38.^^19^202^4
 ;;^UTILITY(U,$J,358.3,2373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2373,1,3,0)
 ;;=3^Endocarditis Valve,Unspec
 ;;^UTILITY(U,$J,358.3,2373,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,2373,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,2374,0)
 ;;=T82.01XA^^19^202^1
 ;;^UTILITY(U,$J,358.3,2374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2374,1,3,0)
 ;;=3^Breakdown of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,2374,1,4,0)
 ;;=4^T82.01XA
 ;;^UTILITY(U,$J,358.3,2374,2)
 ;;=^5054668
 ;;^UTILITY(U,$J,358.3,2375,0)
 ;;=T82.02XA^^19^202^2
 ;;^UTILITY(U,$J,358.3,2375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2375,1,3,0)
 ;;=3^Displacement of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,2375,1,4,0)
 ;;=4^T82.02XA
 ;;^UTILITY(U,$J,358.3,2375,2)
 ;;=^5054671
 ;;^UTILITY(U,$J,358.3,2376,0)
 ;;=T82.03XA^^19^202^5
 ;;^UTILITY(U,$J,358.3,2376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2376,1,3,0)
 ;;=3^Leakage of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,2376,1,4,0)
 ;;=4^T82.03XA
 ;;^UTILITY(U,$J,358.3,2376,2)
 ;;=^5054674
 ;;^UTILITY(U,$J,358.3,2377,0)
 ;;=T82.09XA^^19^202^7
 ;;^UTILITY(U,$J,358.3,2377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2377,1,3,0)
 ;;=3^Mech Compl of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,2377,1,4,0)
 ;;=4^T82.09XA
 ;;^UTILITY(U,$J,358.3,2377,2)
 ;;=^5054677
 ;;^UTILITY(U,$J,358.3,2378,0)
 ;;=T82.817A^^19^202^3
 ;;^UTILITY(U,$J,358.3,2378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2378,1,3,0)
 ;;=3^Embolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2378,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,2378,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,2379,0)
 ;;=T82.867A^^19^202^10
 ;;^UTILITY(U,$J,358.3,2379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2379,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2379,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,2379,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,2380,0)
 ;;=Z95.2^^19^202^9
 ;;^UTILITY(U,$J,358.3,2380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2380,1,3,0)
 ;;=3^Presence of Prosthetic Heart Valve
 ;;^UTILITY(U,$J,358.3,2380,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,2380,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,2381,0)
 ;;=Z98.89^^19^202^8
 ;;^UTILITY(U,$J,358.3,2381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2381,1,3,0)
 ;;=3^Postprocedural States NEC
 ;;^UTILITY(U,$J,358.3,2381,1,4,0)
 ;;=4^Z98.89
 ;;^UTILITY(U,$J,358.3,2381,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,2382,0)
 ;;=Z79.01^^19^202^6
 ;;^UTILITY(U,$J,358.3,2382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2382,1,3,0)
 ;;=3^Long Term Current Use of Anticoagulants
