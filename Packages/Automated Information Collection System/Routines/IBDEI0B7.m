IBDEI0B7 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5257,1,3,0)
 ;;=3^TX, superficial wound dihiscence simple cl
 ;;^UTILITY(U,$J,358.3,5258,0)
 ;;=12021^^40^446^9^^^^1
 ;;^UTILITY(U,$J,358.3,5258,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5258,1,2,0)
 ;;=2^12021
 ;;^UTILITY(U,$J,358.3,5258,1,3,0)
 ;;=3^TX, superficial wound dihiscenc w/ packing
 ;;^UTILITY(U,$J,358.3,5259,0)
 ;;=12041^^40^447^1^^^^1
 ;;^UTILITY(U,$J,358.3,5259,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5259,1,2,0)
 ;;=2^12041
 ;;^UTILITY(U,$J,358.3,5259,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,5260,0)
 ;;=12042^^40^447^2^^^^1
 ;;^UTILITY(U,$J,358.3,5260,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5260,1,2,0)
 ;;=2^12042
 ;;^UTILITY(U,$J,358.3,5260,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5261,0)
 ;;=12044^^40^447^3^^^^1
 ;;^UTILITY(U,$J,358.3,5261,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5261,1,2,0)
 ;;=2^12044
 ;;^UTILITY(U,$J,358.3,5261,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,5262,0)
 ;;=12045^^40^447^4^^^^1
 ;;^UTILITY(U,$J,358.3,5262,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5262,1,2,0)
 ;;=2^12045
 ;;^UTILITY(U,$J,358.3,5262,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,5263,0)
 ;;=12046^^40^447^5^^^^1
 ;;^UTILITY(U,$J,358.3,5263,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5263,1,2,0)
 ;;=2^12046
 ;;^UTILITY(U,$J,358.3,5263,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,5264,0)
 ;;=12047^^40^447^6^^^^1
 ;;^UTILITY(U,$J,358.3,5264,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5264,1,2,0)
 ;;=2^12047
 ;;^UTILITY(U,$J,358.3,5264,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; over 30 cm
 ;;^UTILITY(U,$J,358.3,5265,0)
 ;;=12051^^40^448^1^^^^1
 ;;^UTILITY(U,$J,358.3,5265,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5265,1,2,0)
 ;;=2^12051
 ;;^UTILITY(U,$J,358.3,5265,1,3,0)
 ;;=3^Interm Repair Face; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,5266,0)
 ;;=12052^^40^448^2^^^^1
 ;;^UTILITY(U,$J,358.3,5266,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5266,1,2,0)
 ;;=2^12052
 ;;^UTILITY(U,$J,358.3,5266,1,3,0)
 ;;=3^Interm Repair Face; 2.6 cm to 5.0 cm
 ;;^UTILITY(U,$J,358.3,5267,0)
 ;;=12053^^40^448^3^^^^1
 ;;^UTILITY(U,$J,358.3,5267,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5267,1,2,0)
 ;;=2^12053
 ;;^UTILITY(U,$J,358.3,5267,1,3,0)
 ;;=3^Interm Repair Face; 5.1 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5268,0)
 ;;=12054^^40^448^4^^^^1
 ;;^UTILITY(U,$J,358.3,5268,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5268,1,2,0)
 ;;=2^12054
 ;;^UTILITY(U,$J,358.3,5268,1,3,0)
 ;;=3^Interm Repair Face; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,5269,0)
 ;;=12055^^40^448^5^^^^1
 ;;^UTILITY(U,$J,358.3,5269,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5269,1,2,0)
 ;;=2^12055
 ;;^UTILITY(U,$J,358.3,5269,1,3,0)
 ;;=3^Interm Repair Face; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,5270,0)
 ;;=12056^^40^448^6^^^^1
 ;;^UTILITY(U,$J,358.3,5270,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5270,1,2,0)
 ;;=2^12056
 ;;^UTILITY(U,$J,358.3,5270,1,3,0)
 ;;=3^Interm Repair Face; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,5271,0)
 ;;=12057^^40^448^7^^^^1
 ;;^UTILITY(U,$J,358.3,5271,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5271,1,2,0)
 ;;=2^12057
 ;;^UTILITY(U,$J,358.3,5271,1,3,0)
 ;;=3^Interm Repair Face; over 30 cm
 ;;^UTILITY(U,$J,358.3,5272,0)
 ;;=97605^^40^449^2^^^^1
 ;;^UTILITY(U,$J,358.3,5272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5272,1,2,0)
 ;;=2^97605
 ;;^UTILITY(U,$J,358.3,5272,1,3,0)
 ;;=3^Neg Press Wound Tx < 50 cm
