IBDEI08N ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3929,1,3,0)
 ;;=3^TX, superficial wound dihiscence simple cl
 ;;^UTILITY(U,$J,358.3,3930,0)
 ;;=12021^^32^364^9^^^^1
 ;;^UTILITY(U,$J,358.3,3930,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3930,1,2,0)
 ;;=2^12021
 ;;^UTILITY(U,$J,358.3,3930,1,3,0)
 ;;=3^TX, superficial wound dihiscenc w/ packing
 ;;^UTILITY(U,$J,358.3,3931,0)
 ;;=12041^^32^365^1^^^^1
 ;;^UTILITY(U,$J,358.3,3931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3931,1,2,0)
 ;;=2^12041
 ;;^UTILITY(U,$J,358.3,3931,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,3932,0)
 ;;=12042^^32^365^2^^^^1
 ;;^UTILITY(U,$J,358.3,3932,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3932,1,2,0)
 ;;=2^12042
 ;;^UTILITY(U,$J,358.3,3932,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; 2.6 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,3933,0)
 ;;=12044^^32^365^3^^^^1
 ;;^UTILITY(U,$J,358.3,3933,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3933,1,2,0)
 ;;=2^12044
 ;;^UTILITY(U,$J,358.3,3933,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,3934,0)
 ;;=12045^^32^365^4^^^^1
 ;;^UTILITY(U,$J,358.3,3934,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3934,1,2,0)
 ;;=2^12045
 ;;^UTILITY(U,$J,358.3,3934,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,3935,0)
 ;;=12046^^32^365^5^^^^1
 ;;^UTILITY(U,$J,358.3,3935,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3935,1,2,0)
 ;;=2^12046
 ;;^UTILITY(U,$J,358.3,3935,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,3936,0)
 ;;=12047^^32^365^6^^^^1
 ;;^UTILITY(U,$J,358.3,3936,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3936,1,2,0)
 ;;=2^12047
 ;;^UTILITY(U,$J,358.3,3936,1,3,0)
 ;;=3^Interm Repair Nk/Hd/Ft; over 30 cm
 ;;^UTILITY(U,$J,358.3,3937,0)
 ;;=12051^^32^366^1^^^^1
 ;;^UTILITY(U,$J,358.3,3937,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3937,1,2,0)
 ;;=2^12051
 ;;^UTILITY(U,$J,358.3,3937,1,3,0)
 ;;=3^Interm Repair Face; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,3938,0)
 ;;=12052^^32^366^2^^^^1
 ;;^UTILITY(U,$J,358.3,3938,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3938,1,2,0)
 ;;=2^12052
 ;;^UTILITY(U,$J,358.3,3938,1,3,0)
 ;;=3^Interm Repair Face; 2.6 cm to 5.0 cm
 ;;^UTILITY(U,$J,358.3,3939,0)
 ;;=12053^^32^366^3^^^^1
 ;;^UTILITY(U,$J,358.3,3939,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3939,1,2,0)
 ;;=2^12053
 ;;^UTILITY(U,$J,358.3,3939,1,3,0)
 ;;=3^Interm Repair Face; 5.1 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,3940,0)
 ;;=12054^^32^366^4^^^^1
 ;;^UTILITY(U,$J,358.3,3940,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3940,1,2,0)
 ;;=2^12054
 ;;^UTILITY(U,$J,358.3,3940,1,3,0)
 ;;=3^Interm Repair Face; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,3941,0)
 ;;=12055^^32^366^5^^^^1
 ;;^UTILITY(U,$J,358.3,3941,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3941,1,2,0)
 ;;=2^12055
 ;;^UTILITY(U,$J,358.3,3941,1,3,0)
 ;;=3^Interm Repair Face; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,3942,0)
 ;;=12056^^32^366^6^^^^1
 ;;^UTILITY(U,$J,358.3,3942,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3942,1,2,0)
 ;;=2^12056
 ;;^UTILITY(U,$J,358.3,3942,1,3,0)
 ;;=3^Interm Repair Face; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,3943,0)
 ;;=12057^^32^366^7^^^^1
 ;;^UTILITY(U,$J,358.3,3943,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3943,1,2,0)
 ;;=2^12057
 ;;^UTILITY(U,$J,358.3,3943,1,3,0)
 ;;=3^Interm Repair Face; over 30 cm
 ;;^UTILITY(U,$J,358.3,3944,0)
 ;;=97605^^32^367^3^^^^1
 ;;^UTILITY(U,$J,358.3,3944,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3944,1,2,0)
 ;;=2^97605
 ;;^UTILITY(U,$J,358.3,3944,1,3,0)
 ;;=3^Neg Press Wound Tx <= 50 cm,using wnd vac
