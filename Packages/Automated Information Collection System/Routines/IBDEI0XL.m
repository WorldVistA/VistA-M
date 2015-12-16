IBDEI0XL ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16339,1,3,0)
 ;;=3^Bronchoscopy Dilate/Fx Repair
 ;;^UTILITY(U,$J,358.3,16340,0)
 ;;=31640^^82^965^21^^^^1
 ;;^UTILITY(U,$J,358.3,16340,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16340,1,2,0)
 ;;=2^31640
 ;;^UTILITY(U,$J,358.3,16340,1,3,0)
 ;;=3^Bronchoscopy w/ Tumor Excise
 ;;^UTILITY(U,$J,358.3,16341,0)
 ;;=31636^^82^965^2^^^^1
 ;;^UTILITY(U,$J,358.3,16341,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16341,1,2,0)
 ;;=2^31636
 ;;^UTILITY(U,$J,358.3,16341,1,3,0)
 ;;=3^Bronchoscopy Bronch Stents
 ;;^UTILITY(U,$J,358.3,16342,0)
 ;;=31643^^82^965^23^^^^1
 ;;^UTILITY(U,$J,358.3,16342,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16342,1,2,0)
 ;;=2^31643
 ;;^UTILITY(U,$J,358.3,16342,1,3,0)
 ;;=3^Diag Bronchoscope/Catheter
 ;;^UTILITY(U,$J,358.3,16343,0)
 ;;=31645^^82^965^4^^^^1
 ;;^UTILITY(U,$J,358.3,16343,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16343,1,2,0)
 ;;=2^31645
 ;;^UTILITY(U,$J,358.3,16343,1,3,0)
 ;;=3^Bronchoscopy Clear Airways
 ;;^UTILITY(U,$J,358.3,16344,0)
 ;;=31631^^82^965^6^^^^1
 ;;^UTILITY(U,$J,358.3,16344,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16344,1,2,0)
 ;;=2^31631
 ;;^UTILITY(U,$J,358.3,16344,1,3,0)
 ;;=3^Bronchoscopy Dilate w/ Stent
 ;;^UTILITY(U,$J,358.3,16345,0)
 ;;=31638^^82^965^10^^^^1
 ;;^UTILITY(U,$J,358.3,16345,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16345,1,2,0)
 ;;=2^31638
 ;;^UTILITY(U,$J,358.3,16345,1,3,0)
 ;;=3^Bronchoscopy Revise Stent
 ;;^UTILITY(U,$J,358.3,16346,0)
 ;;=31637^^82^965^3^^^^1
 ;;^UTILITY(U,$J,358.3,16346,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16346,1,2,0)
 ;;=2^31637
 ;;^UTILITY(U,$J,358.3,16346,1,3,0)
 ;;=3^Bronchoscopy Bronch Stents,Ea Addl Stent
 ;;^UTILITY(U,$J,358.3,16347,0)
 ;;=31641^^82^965^11^^^^1
 ;;^UTILITY(U,$J,358.3,16347,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16347,1,2,0)
 ;;=2^31641
 ;;^UTILITY(U,$J,358.3,16347,1,3,0)
 ;;=3^Bronchoscopy Treat Blockage
 ;;^UTILITY(U,$J,358.3,16348,0)
 ;;=31632^^82^965^8^^^^1
 ;;^UTILITY(U,$J,358.3,16348,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16348,1,2,0)
 ;;=2^31632
 ;;^UTILITY(U,$J,358.3,16348,1,3,0)
 ;;=3^Bronchoscopy Lung Bx,Ea Addl
 ;;^UTILITY(U,$J,358.3,16349,0)
 ;;=32999^^82^965^22^^^^1
 ;;^UTILITY(U,$J,358.3,16349,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16349,1,2,0)
 ;;=2^32999
 ;;^UTILITY(U,$J,358.3,16349,1,3,0)
 ;;=3^Chest Surgery Procedure
 ;;^UTILITY(U,$J,358.3,16350,0)
 ;;=76499^^82^965^26^^^^1
 ;;^UTILITY(U,$J,358.3,16350,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16350,1,2,0)
 ;;=2^76499
 ;;^UTILITY(U,$J,358.3,16350,1,3,0)
 ;;=3^Radiographic Procedure
 ;;^UTILITY(U,$J,358.3,16351,0)
 ;;=31633^^82^965^9^^^^1
 ;;^UTILITY(U,$J,358.3,16351,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16351,1,2,0)
 ;;=2^31633
 ;;^UTILITY(U,$J,358.3,16351,1,3,0)
 ;;=3^Bronchoscopy Needle Bx,Ea Addl Bx
 ;;^UTILITY(U,$J,358.3,16352,0)
 ;;=31615^^82^965^12^^^^1
 ;;^UTILITY(U,$J,358.3,16352,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16352,1,2,0)
 ;;=2^31615
 ;;^UTILITY(U,$J,358.3,16352,1,3,0)
 ;;=3^Bronchoscopy thru Est Trach
 ;;^UTILITY(U,$J,358.3,16353,0)
 ;;=31645^^82^965^17^^^^1
 ;;^UTILITY(U,$J,358.3,16353,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16353,1,2,0)
 ;;=2^31645
 ;;^UTILITY(U,$J,358.3,16353,1,3,0)
 ;;=3^Bronchoscopy w/ Therap Aspiration,Init
 ;;^UTILITY(U,$J,358.3,16354,0)
 ;;=31646^^82^965^18^^^^1
 ;;^UTILITY(U,$J,358.3,16354,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16354,1,2,0)
 ;;=2^31646
 ;;^UTILITY(U,$J,358.3,16354,1,3,0)
 ;;=3^Bronchoscopy w/ Therap Aspiration,Subseq
 ;;^UTILITY(U,$J,358.3,16355,0)
 ;;=31620^^82^965^24^^^^1
