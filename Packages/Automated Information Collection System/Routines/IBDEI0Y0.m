IBDEI0Y0 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34214,1,2,0)
 ;;=2^94640
 ;;^UTILITY(U,$J,358.3,34214,1,3,0)
 ;;=3^Inhalation Treatment
 ;;^UTILITY(U,$J,358.3,34214,3,0)
 ;;=^358.33^1^1
 ;;^UTILITY(U,$J,358.3,34214,3,1,0)
 ;;=76
 ;;^UTILITY(U,$J,358.3,34215,0)
 ;;=94664^^123^1618^2
 ;;^UTILITY(U,$J,358.3,34215,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34215,1,2,0)
 ;;=2^94664
 ;;^UTILITY(U,$J,358.3,34215,1,3,0)
 ;;=3^Demo/Eval Pt use of Nebulizer
 ;;^UTILITY(U,$J,358.3,34216,0)
 ;;=94667^^123^1618^3
 ;;^UTILITY(U,$J,358.3,34216,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34216,1,2,0)
 ;;=2^94667
 ;;^UTILITY(U,$J,358.3,34216,1,3,0)
 ;;=3^Manipulation of Chest Wall
 ;;^UTILITY(U,$J,358.3,34217,0)
 ;;=94660^^123^1618^4^^^^1
 ;;^UTILITY(U,$J,358.3,34217,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34217,1,2,0)
 ;;=2^94660
 ;;^UTILITY(U,$J,358.3,34217,1,3,0)
 ;;=3^CPAP Management
 ;;^UTILITY(U,$J,358.3,34218,0)
 ;;=31622^^123^1619^7^^^^1
 ;;^UTILITY(U,$J,358.3,34218,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34218,1,2,0)
 ;;=2^31622
 ;;^UTILITY(U,$J,358.3,34218,1,3,0)
 ;;=3^Bronchoscopy Diag w/ Wash
 ;;^UTILITY(U,$J,358.3,34219,0)
 ;;=31623^^123^1619^16^^^^1
 ;;^UTILITY(U,$J,358.3,34219,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34219,1,2,0)
 ;;=2^31623
 ;;^UTILITY(U,$J,358.3,34219,1,3,0)
 ;;=3^Bronchoscopy w/ Brushings
 ;;^UTILITY(U,$J,358.3,34220,0)
 ;;=31624^^123^1619^18^^^^1
 ;;^UTILITY(U,$J,358.3,34220,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34220,1,2,0)
 ;;=2^31624
 ;;^UTILITY(U,$J,358.3,34220,1,3,0)
 ;;=3^Bronchoscopy w/ Lavage
 ;;^UTILITY(U,$J,358.3,34221,0)
 ;;=31625^^123^1619^15^^^^1
 ;;^UTILITY(U,$J,358.3,34221,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34221,1,2,0)
 ;;=2^31625
 ;;^UTILITY(U,$J,358.3,34221,1,3,0)
 ;;=3^Bronchoscopy w/ Biopsy
 ;;^UTILITY(U,$J,358.3,34222,0)
 ;;=31628^^123^1619^21^^^^1
 ;;^UTILITY(U,$J,358.3,34222,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34222,1,2,0)
 ;;=2^31628
 ;;^UTILITY(U,$J,358.3,34222,1,3,0)
 ;;=3^Bronchoscopy w/ Transbronch Bx
 ;;^UTILITY(U,$J,358.3,34223,0)
 ;;=31629^^123^1619^22^^^^1
 ;;^UTILITY(U,$J,358.3,34223,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34223,1,2,0)
 ;;=2^31629
 ;;^UTILITY(U,$J,358.3,34223,1,3,0)
 ;;=3^Bronchoscopy w/ Transbronch Needle Aspiration
 ;;^UTILITY(U,$J,358.3,34224,0)
 ;;=31635^^123^1619^17^^^^1
 ;;^UTILITY(U,$J,358.3,34224,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34224,1,2,0)
 ;;=2^31635
 ;;^UTILITY(U,$J,358.3,34224,1,3,0)
 ;;=3^Bronchoscopy w/ FB Removal
 ;;^UTILITY(U,$J,358.3,34225,0)
 ;;=31899^^123^1619^1^^^^1
 ;;^UTILITY(U,$J,358.3,34225,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34225,1,2,0)
 ;;=2^31899
 ;;^UTILITY(U,$J,358.3,34225,1,3,0)
 ;;=3^Airways Surgical Procedure
 ;;^UTILITY(U,$J,358.3,34226,0)
 ;;=31630^^123^1619^9^^^^1
 ;;^UTILITY(U,$J,358.3,34226,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34226,1,2,0)
 ;;=2^31630
 ;;^UTILITY(U,$J,358.3,34226,1,3,0)
 ;;=3^Bronchoscopy Dilate/Fx Repair
 ;;^UTILITY(U,$J,358.3,34227,0)
 ;;=31640^^123^1619^23^^^^1
 ;;^UTILITY(U,$J,358.3,34227,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34227,1,2,0)
 ;;=2^31640
 ;;^UTILITY(U,$J,358.3,34227,1,3,0)
 ;;=3^Bronchoscopy w/ Tumor Excise
 ;;^UTILITY(U,$J,358.3,34228,0)
 ;;=31636^^123^1619^4^^^^1
 ;;^UTILITY(U,$J,358.3,34228,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34228,1,2,0)
 ;;=2^31636
 ;;^UTILITY(U,$J,358.3,34228,1,3,0)
 ;;=3^Bronchoscopy Bronch Stents
 ;;^UTILITY(U,$J,358.3,34229,0)
 ;;=31643^^123^1619^26^^^^1
 ;;^UTILITY(U,$J,358.3,34229,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34229,1,2,0)
 ;;=2^31643
 ;;^UTILITY(U,$J,358.3,34229,1,3,0)
 ;;=3^Diag Bronchoscope/Catheter
 ;;^UTILITY(U,$J,358.3,34230,0)
 ;;=31645^^123^1619^6^^^^1
 ;;^UTILITY(U,$J,358.3,34230,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34230,1,2,0)
 ;;=2^31645
 ;;^UTILITY(U,$J,358.3,34230,1,3,0)
 ;;=3^Bronchoscopy Clear Airways
 ;;^UTILITY(U,$J,358.3,34231,0)
 ;;=31631^^123^1619^8^^^^1
 ;;^UTILITY(U,$J,358.3,34231,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34231,1,2,0)
 ;;=2^31631
 ;;^UTILITY(U,$J,358.3,34231,1,3,0)
 ;;=3^Bronchoscopy Dilate w/ Stent
 ;;^UTILITY(U,$J,358.3,34232,0)
 ;;=31638^^123^1619^12^^^^1
 ;;^UTILITY(U,$J,358.3,34232,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34232,1,2,0)
 ;;=2^31638
 ;;^UTILITY(U,$J,358.3,34232,1,3,0)
 ;;=3^Bronchoscopy Revise Stent
 ;;^UTILITY(U,$J,358.3,34233,0)
 ;;=31637^^123^1619^5^^^^1
 ;;^UTILITY(U,$J,358.3,34233,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34233,1,2,0)
 ;;=2^31637
 ;;^UTILITY(U,$J,358.3,34233,1,3,0)
 ;;=3^Bronchoscopy Bronch Stents,Ea Addl Stent
 ;;^UTILITY(U,$J,358.3,34234,0)
 ;;=31641^^123^1619^13^^^^1
 ;;^UTILITY(U,$J,358.3,34234,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34234,1,2,0)
 ;;=2^31641
 ;;^UTILITY(U,$J,358.3,34234,1,3,0)
 ;;=3^Bronchoscopy Treat Blockage
 ;;^UTILITY(U,$J,358.3,34235,0)
 ;;=31632^^123^1619^10^^^^1
 ;;^UTILITY(U,$J,358.3,34235,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34235,1,2,0)
 ;;=2^31632
 ;;^UTILITY(U,$J,358.3,34235,1,3,0)
 ;;=3^Bronchoscopy Lung Bx,Ea Addl
 ;;^UTILITY(U,$J,358.3,34236,0)
 ;;=32999^^123^1619^24^^^^1
 ;;^UTILITY(U,$J,358.3,34236,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34236,1,2,0)
 ;;=2^32999
 ;;^UTILITY(U,$J,358.3,34236,1,3,0)
 ;;=3^Chest Surgery Procedure
 ;;^UTILITY(U,$J,358.3,34237,0)
 ;;=76499^^123^1619^28^^^^1
 ;;^UTILITY(U,$J,358.3,34237,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34237,1,2,0)
 ;;=2^76499
 ;;^UTILITY(U,$J,358.3,34237,1,3,0)
 ;;=3^Radiographic Procedure
 ;;^UTILITY(U,$J,358.3,34238,0)
 ;;=31633^^123^1619^11^^^^1
 ;;^UTILITY(U,$J,358.3,34238,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34238,1,2,0)
 ;;=2^31633
 ;;^UTILITY(U,$J,358.3,34238,1,3,0)
 ;;=3^Bronchoscopy Needle Bx,Ea Addl Bx
 ;;^UTILITY(U,$J,358.3,34239,0)
 ;;=31615^^123^1619^14^^^^1
 ;;^UTILITY(U,$J,358.3,34239,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34239,1,2,0)
 ;;=2^31615
 ;;^UTILITY(U,$J,358.3,34239,1,3,0)
 ;;=3^Bronchoscopy thru Est Trach
 ;;^UTILITY(U,$J,358.3,34240,0)
 ;;=31645^^123^1619^19^^^^1
 ;;^UTILITY(U,$J,358.3,34240,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34240,1,2,0)
 ;;=2^31645
 ;;^UTILITY(U,$J,358.3,34240,1,3,0)
 ;;=3^Bronchoscopy w/ Therap Aspiration,Init
 ;;^UTILITY(U,$J,358.3,34241,0)
 ;;=31646^^123^1619^20^^^^1
 ;;^UTILITY(U,$J,358.3,34241,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34241,1,2,0)
 ;;=2^31646
 ;;^UTILITY(U,$J,358.3,34241,1,3,0)
 ;;=3^Bronchoscopy w/ Therap Aspiration,Subseq
 ;;^UTILITY(U,$J,358.3,34242,0)
 ;;=31231^^123^1619^27^^^^1
 ;;^UTILITY(U,$J,358.3,34242,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34242,1,2,0)
 ;;=2^31231
 ;;^UTILITY(U,$J,358.3,34242,1,3,0)
 ;;=3^Nasal Endoscopy,Diag,Uni/Bilateral
 ;;^UTILITY(U,$J,358.3,34243,0)
 ;;=31627^^123^1619^25^^^^1
 ;;^UTILITY(U,$J,358.3,34243,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34243,1,2,0)
 ;;=2^31627
 ;;^UTILITY(U,$J,358.3,34243,1,3,0)
 ;;=3^Computer Assisted Image-Guided Nav,Add-On
 ;;^UTILITY(U,$J,358.3,34244,0)
 ;;=31652^^123^1619^2^^^^1
 ;;^UTILITY(U,$J,358.3,34244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34244,1,2,0)
 ;;=2^31652
 ;;^UTILITY(U,$J,358.3,34244,1,3,0)
 ;;=3^Bronch w/ EBUS Trnstrch/Bronch Sample 1-2 Med/Hilar LN
 ;;^UTILITY(U,$J,358.3,34245,0)
 ;;=31653^^123^1619^3^^^^1
 ;;^UTILITY(U,$J,358.3,34245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34245,1,2,0)
 ;;=2^31653
 ;;^UTILITY(U,$J,358.3,34245,1,3,0)
 ;;=3^Bronch w/ EBUS Trntch/Bronch Sample=>3 Med/Hil LN
 ;;^UTILITY(U,$J,358.3,34246,0)
 ;;=93015^^123^1620^3^^^^1
 ;;^UTILITY(U,$J,358.3,34246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34246,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,34246,1,3,0)
 ;;=3^Cardiovascular Stress test, Complete
 ;;^UTILITY(U,$J,358.3,34247,0)
 ;;=93017^^123^1620^2^^^^1
