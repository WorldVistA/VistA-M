IBDEI0KV ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9225,1,2,0)
 ;;=2^32555
 ;;^UTILITY(U,$J,358.3,9225,1,3,0)
 ;;=3^Thoracentesis w/ Imaging Guidance
 ;;^UTILITY(U,$J,358.3,9226,0)
 ;;=31605^^70^627^13^^^^1
 ;;^UTILITY(U,$J,358.3,9226,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9226,1,2,0)
 ;;=2^31605
 ;;^UTILITY(U,$J,358.3,9226,1,3,0)
 ;;=3^Trachestomy,Emergent,Cricothyroid
 ;;^UTILITY(U,$J,358.3,9227,0)
 ;;=32551^^70^627^14^^^^1
 ;;^UTILITY(U,$J,358.3,9227,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9227,1,2,0)
 ;;=2^32551
 ;;^UTILITY(U,$J,358.3,9227,1,3,0)
 ;;=3^Chest Tube Insertion
 ;;^UTILITY(U,$J,358.3,9228,0)
 ;;=99152^^70^627^17^^^^1
 ;;^UTILITY(U,$J,358.3,9228,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9228,1,2,0)
 ;;=2^99152
 ;;^UTILITY(U,$J,358.3,9228,1,3,0)
 ;;=3^Moderate Sedation,1st 15 min
 ;;^UTILITY(U,$J,358.3,9229,0)
 ;;=99153^^70^627^18^^^^1
 ;;^UTILITY(U,$J,358.3,9229,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9229,1,2,0)
 ;;=2^99153
 ;;^UTILITY(U,$J,358.3,9229,1,3,0)
 ;;=3^Moderate Sedation,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,9230,0)
 ;;=99292^^70^627^2^^^^1
 ;;^UTILITY(U,$J,358.3,9230,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9230,1,2,0)
 ;;=2^99292
 ;;^UTILITY(U,$J,358.3,9230,1,3,0)
 ;;=3^Critical Care,Ea Addl 30 Min
 ;;^UTILITY(U,$J,358.3,9231,0)
 ;;=43753^^70^628^7^^^^1
 ;;^UTILITY(U,$J,358.3,9231,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9231,1,2,0)
 ;;=2^43753
 ;;^UTILITY(U,$J,358.3,9231,1,3,0)
 ;;=3^Gastric Lavage
 ;;^UTILITY(U,$J,358.3,9232,0)
 ;;=45915^^70^628^4^^^^1
 ;;^UTILITY(U,$J,358.3,9232,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9232,1,2,0)
 ;;=2^45915
 ;;^UTILITY(U,$J,358.3,9232,1,3,0)
 ;;=3^Fecal Impaction Removal or FB
 ;;^UTILITY(U,$J,358.3,9233,0)
 ;;=46050^^70^628^9^^^^1
 ;;^UTILITY(U,$J,358.3,9233,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9233,1,2,0)
 ;;=2^46050
 ;;^UTILITY(U,$J,358.3,9233,1,3,0)
 ;;=3^Perianal Abscess I&D
 ;;^UTILITY(U,$J,358.3,9234,0)
 ;;=46320^^70^628^8^^^^1
 ;;^UTILITY(U,$J,358.3,9234,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9234,1,2,0)
 ;;=2^46320
 ;;^UTILITY(U,$J,358.3,9234,1,3,0)
 ;;=3^Hemorrhoid Excision,Thrombosed,External
 ;;^UTILITY(U,$J,358.3,9235,0)
 ;;=49082^^70^628^2^^^^1
 ;;^UTILITY(U,$J,358.3,9235,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9235,1,2,0)
 ;;=2^49082
 ;;^UTILITY(U,$J,358.3,9235,1,3,0)
 ;;=3^Abdominal Paracentesis w/o Imaging
 ;;^UTILITY(U,$J,358.3,9236,0)
 ;;=49083^^70^628^1^^^^1
 ;;^UTILITY(U,$J,358.3,9236,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9236,1,2,0)
 ;;=2^49083
 ;;^UTILITY(U,$J,358.3,9236,1,3,0)
 ;;=3^Abdominal Paracentesis w/ Imaging
 ;;^UTILITY(U,$J,358.3,9237,0)
 ;;=56420^^70^628^3^^^^1
 ;;^UTILITY(U,$J,358.3,9237,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9237,1,2,0)
 ;;=2^56420
 ;;^UTILITY(U,$J,358.3,9237,1,3,0)
 ;;=3^Bartholin's Cyst I&D
 ;;^UTILITY(U,$J,358.3,9238,0)
 ;;=56405^^70^628^11^^^^1
 ;;^UTILITY(U,$J,358.3,9238,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9238,1,2,0)
 ;;=2^56405
 ;;^UTILITY(U,$J,358.3,9238,1,3,0)
 ;;=3^Vulva/Perineum Abscess I&D
 ;;^UTILITY(U,$J,358.3,9239,0)
 ;;=58301^^70^628^10^^^^1
 ;;^UTILITY(U,$J,358.3,9239,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9239,1,2,0)
 ;;=2^58301
 ;;^UTILITY(U,$J,358.3,9239,1,3,0)
 ;;=3^Removal IUD
 ;;^UTILITY(U,$J,358.3,9240,0)
 ;;=43762^^70^628^6^^^^1
 ;;^UTILITY(U,$J,358.3,9240,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9240,1,2,0)
 ;;=2^43762
