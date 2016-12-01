IBDEI0RE ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36195,0)
 ;;=31622^^101^1534^7^^^^1
 ;;^UTILITY(U,$J,358.3,36195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36195,1,2,0)
 ;;=2^31622
 ;;^UTILITY(U,$J,358.3,36195,1,3,0)
 ;;=3^Bronchoscopy Diag w/ Wash
 ;;^UTILITY(U,$J,358.3,36196,0)
 ;;=31623^^101^1534^16^^^^1
 ;;^UTILITY(U,$J,358.3,36196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36196,1,2,0)
 ;;=2^31623
 ;;^UTILITY(U,$J,358.3,36196,1,3,0)
 ;;=3^Bronchoscopy w/ Brushings
 ;;^UTILITY(U,$J,358.3,36197,0)
 ;;=31624^^101^1534^19^^^^1
 ;;^UTILITY(U,$J,358.3,36197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36197,1,2,0)
 ;;=2^31624
 ;;^UTILITY(U,$J,358.3,36197,1,3,0)
 ;;=3^Bronchoscopy w/ Lavage
 ;;^UTILITY(U,$J,358.3,36198,0)
 ;;=31625^^101^1534^15^^^^1
 ;;^UTILITY(U,$J,358.3,36198,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36198,1,2,0)
 ;;=2^31625
 ;;^UTILITY(U,$J,358.3,36198,1,3,0)
 ;;=3^Bronchoscopy w/ Biopsy
 ;;^UTILITY(U,$J,358.3,36199,0)
 ;;=31628^^101^1534^22^^^^1
 ;;^UTILITY(U,$J,358.3,36199,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36199,1,2,0)
 ;;=2^31628
 ;;^UTILITY(U,$J,358.3,36199,1,3,0)
 ;;=3^Bronchoscopy w/ Transbronch Bx
 ;;^UTILITY(U,$J,358.3,36200,0)
 ;;=31629^^101^1534^23^^^^1
 ;;^UTILITY(U,$J,358.3,36200,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36200,1,2,0)
 ;;=2^31629
 ;;^UTILITY(U,$J,358.3,36200,1,3,0)
 ;;=3^Bronchoscopy w/ Transbronch Needle Aspiration
 ;;^UTILITY(U,$J,358.3,36201,0)
 ;;=31635^^101^1534^18^^^^1
 ;;^UTILITY(U,$J,358.3,36201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36201,1,2,0)
 ;;=2^31635
 ;;^UTILITY(U,$J,358.3,36201,1,3,0)
 ;;=3^Bronchoscopy w/ FB Removal
 ;;^UTILITY(U,$J,358.3,36202,0)
 ;;=31899^^101^1534^1^^^^1
 ;;^UTILITY(U,$J,358.3,36202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36202,1,2,0)
 ;;=2^31899
 ;;^UTILITY(U,$J,358.3,36202,1,3,0)
 ;;=3^Airways Surgical Procedure
 ;;^UTILITY(U,$J,358.3,36203,0)
 ;;=31630^^101^1534^9^^^^1
 ;;^UTILITY(U,$J,358.3,36203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36203,1,2,0)
 ;;=2^31630
 ;;^UTILITY(U,$J,358.3,36203,1,3,0)
 ;;=3^Bronchoscopy Dilate/Fx Repair
 ;;^UTILITY(U,$J,358.3,36204,0)
 ;;=31640^^101^1534^24^^^^1
 ;;^UTILITY(U,$J,358.3,36204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36204,1,2,0)
 ;;=2^31640
 ;;^UTILITY(U,$J,358.3,36204,1,3,0)
 ;;=3^Bronchoscopy w/ Tumor Excise
 ;;^UTILITY(U,$J,358.3,36205,0)
 ;;=31636^^101^1534^4^^^^1
 ;;^UTILITY(U,$J,358.3,36205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36205,1,2,0)
 ;;=2^31636
 ;;^UTILITY(U,$J,358.3,36205,1,3,0)
 ;;=3^Bronchoscopy Bronch Stents
 ;;^UTILITY(U,$J,358.3,36206,0)
 ;;=31643^^101^1534^26^^^^1
 ;;^UTILITY(U,$J,358.3,36206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36206,1,2,0)
 ;;=2^31643
 ;;^UTILITY(U,$J,358.3,36206,1,3,0)
 ;;=3^Diag Bronchoscope/Catheter
 ;;^UTILITY(U,$J,358.3,36207,0)
 ;;=31645^^101^1534^6^^^^1
 ;;^UTILITY(U,$J,358.3,36207,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36207,1,2,0)
 ;;=2^31645
 ;;^UTILITY(U,$J,358.3,36207,1,3,0)
 ;;=3^Bronchoscopy Clear Airways
 ;;^UTILITY(U,$J,358.3,36208,0)
 ;;=31631^^101^1534^8^^^^1
 ;;^UTILITY(U,$J,358.3,36208,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36208,1,2,0)
 ;;=2^31631
 ;;^UTILITY(U,$J,358.3,36208,1,3,0)
 ;;=3^Bronchoscopy Dilate w/ Stent
 ;;^UTILITY(U,$J,358.3,36209,0)
 ;;=31638^^101^1534^12^^^^1
 ;;^UTILITY(U,$J,358.3,36209,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36209,1,2,0)
 ;;=2^31638
 ;;^UTILITY(U,$J,358.3,36209,1,3,0)
 ;;=3^Bronchoscopy Revise Stent
 ;;^UTILITY(U,$J,358.3,36210,0)
 ;;=31637^^101^1534^5^^^^1
 ;;^UTILITY(U,$J,358.3,36210,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36210,1,2,0)
 ;;=2^31637
 ;;^UTILITY(U,$J,358.3,36210,1,3,0)
 ;;=3^Bronchoscopy Bronch Stents,Ea Addl Stent
 ;;^UTILITY(U,$J,358.3,36211,0)
 ;;=31641^^101^1534^13^^^^1
 ;;^UTILITY(U,$J,358.3,36211,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36211,1,2,0)
 ;;=2^31641
 ;;^UTILITY(U,$J,358.3,36211,1,3,0)
 ;;=3^Bronchoscopy Treat Blockage
 ;;^UTILITY(U,$J,358.3,36212,0)
 ;;=31632^^101^1534^10^^^^1
 ;;^UTILITY(U,$J,358.3,36212,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36212,1,2,0)
 ;;=2^31632
 ;;^UTILITY(U,$J,358.3,36212,1,3,0)
 ;;=3^Bronchoscopy Lung Bx,Ea Addl
 ;;^UTILITY(U,$J,358.3,36213,0)
 ;;=32999^^101^1534^25^^^^1
 ;;^UTILITY(U,$J,358.3,36213,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36213,1,2,0)
 ;;=2^32999
 ;;^UTILITY(U,$J,358.3,36213,1,3,0)
 ;;=3^Chest Surgery Procedure
 ;;^UTILITY(U,$J,358.3,36214,0)
 ;;=76499^^101^1534^28^^^^1
 ;;^UTILITY(U,$J,358.3,36214,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36214,1,2,0)
 ;;=2^76499
 ;;^UTILITY(U,$J,358.3,36214,1,3,0)
 ;;=3^Radiographic Procedure
 ;;^UTILITY(U,$J,358.3,36215,0)
 ;;=31633^^101^1534^11^^^^1
 ;;^UTILITY(U,$J,358.3,36215,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36215,1,2,0)
 ;;=2^31633
 ;;^UTILITY(U,$J,358.3,36215,1,3,0)
 ;;=3^Bronchoscopy Needle Bx,Ea Addl Bx
 ;;^UTILITY(U,$J,358.3,36216,0)
 ;;=31615^^101^1534^14^^^^1
 ;;^UTILITY(U,$J,358.3,36216,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36216,1,2,0)
 ;;=2^31615
 ;;^UTILITY(U,$J,358.3,36216,1,3,0)
 ;;=3^Bronchoscopy thru Est Trach
 ;;^UTILITY(U,$J,358.3,36217,0)
 ;;=31645^^101^1534^20^^^^1
 ;;^UTILITY(U,$J,358.3,36217,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36217,1,2,0)
 ;;=2^31645
 ;;^UTILITY(U,$J,358.3,36217,1,3,0)
 ;;=3^Bronchoscopy w/ Therap Aspiration,Init
 ;;^UTILITY(U,$J,358.3,36218,0)
 ;;=31646^^101^1534^21^^^^1
 ;;^UTILITY(U,$J,358.3,36218,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36218,1,2,0)
 ;;=2^31646
 ;;^UTILITY(U,$J,358.3,36218,1,3,0)
 ;;=3^Bronchoscopy w/ Therap Aspiration,Subseq
 ;;^UTILITY(U,$J,358.3,36219,0)
 ;;=31231^^101^1534^27^^^^1
 ;;^UTILITY(U,$J,358.3,36219,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36219,1,2,0)
 ;;=2^31231
 ;;^UTILITY(U,$J,358.3,36219,1,3,0)
 ;;=3^Nasal Endoscopy,Diag,Uni/Bilateral
 ;;^UTILITY(U,$J,358.3,36220,0)
 ;;=31627^^101^1534^17^^^^1
 ;;^UTILITY(U,$J,358.3,36220,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36220,1,2,0)
 ;;=2^31627
 ;;^UTILITY(U,$J,358.3,36220,1,3,0)
 ;;=3^Bronchoscopy w/ Computer Assisted-Image,Add-On
 ;;^UTILITY(U,$J,358.3,36221,0)
 ;;=31652^^101^1534^2^^^^1
 ;;^UTILITY(U,$J,358.3,36221,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36221,1,2,0)
 ;;=2^31652
 ;;^UTILITY(U,$J,358.3,36221,1,3,0)
 ;;=3^Bronch w/ EBUS Trnstrch/Bronch Sample 1-2 Med/Hilar LN
 ;;^UTILITY(U,$J,358.3,36222,0)
 ;;=31653^^101^1534^3^^^^1
 ;;^UTILITY(U,$J,358.3,36222,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36222,1,2,0)
 ;;=2^31653
 ;;^UTILITY(U,$J,358.3,36222,1,3,0)
 ;;=3^Bronch w/ EBUS Trntch/Bronch Sample=>3 Med/Hil LN
 ;;^UTILITY(U,$J,358.3,36223,0)
 ;;=93015^^101^1535^3^^^^1
 ;;^UTILITY(U,$J,358.3,36223,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36223,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,36223,1,3,0)
 ;;=3^Cardiovascular Stress test, Complete
 ;;^UTILITY(U,$J,358.3,36224,0)
 ;;=93017^^101^1535^2^^^^1
 ;;^UTILITY(U,$J,358.3,36224,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36224,1,2,0)
 ;;=2^93017
 ;;^UTILITY(U,$J,358.3,36224,1,3,0)
 ;;=3^Cardiovascular Stress Test,Tracing Only
 ;;^UTILITY(U,$J,358.3,36225,0)
 ;;=94620^^101^1535^5^^^^1
 ;;^UTILITY(U,$J,358.3,36225,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36225,1,2,0)
 ;;=2^94620
 ;;^UTILITY(U,$J,358.3,36225,1,3,0)
 ;;=3^Pulmonary Stress test, simple
 ;;^UTILITY(U,$J,358.3,36226,0)
 ;;=94621^^101^1535^4^^^^1
 ;;^UTILITY(U,$J,358.3,36226,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36226,1,2,0)
 ;;=2^94621
 ;;^UTILITY(U,$J,358.3,36226,1,3,0)
 ;;=3^Pulmonary Stress Test, Cmplx
 ;;^UTILITY(U,$J,358.3,36227,0)
 ;;=93016^^101^1535^1^^^^1
 ;;^UTILITY(U,$J,358.3,36227,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36227,1,2,0)
 ;;=2^93016
 ;;^UTILITY(U,$J,358.3,36227,1,3,0)
 ;;=3^Cardiovascular Stress Test Only w/o Rpt
 ;;^UTILITY(U,$J,358.3,36228,0)
 ;;=90471^^101^1536^1^^^^1
 ;;^UTILITY(U,$J,358.3,36228,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36228,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,36228,1,3,0)
 ;;=3^Immunization Admin,1st Vaccine
 ;;^UTILITY(U,$J,358.3,36229,0)
 ;;=90472^^101^1536^2^^^^1
 ;;^UTILITY(U,$J,358.3,36229,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36229,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,36229,1,3,0)
 ;;=3^Immunization Admin,Ea Addl Vaccine
 ;;^UTILITY(U,$J,358.3,36230,0)
 ;;=90658^^101^1537^1^^^^1
 ;;^UTILITY(U,$J,358.3,36230,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36230,1,2,0)
 ;;=2^90658
 ;;^UTILITY(U,$J,358.3,36230,1,3,0)
 ;;=3^Flu Vaccine IM (Flulaval)
 ;;^UTILITY(U,$J,358.3,36231,0)
 ;;=90656^^101^1537^2^^^^1
 ;;^UTILITY(U,$J,358.3,36231,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36231,1,2,0)
 ;;=2^90656
 ;;^UTILITY(U,$J,358.3,36231,1,3,0)
 ;;=3^Flu Vaccine Single Dose Syringe (Afluria)
 ;;^UTILITY(U,$J,358.3,36232,0)
 ;;=90662^^101^1537^3^^^^1
 ;;^UTILITY(U,$J,358.3,36232,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36232,1,2,0)
 ;;=2^90662
 ;;^UTILITY(U,$J,358.3,36232,1,3,0)
 ;;=3^Flu Vaccine High Dose Syringe (Fluzone)
 ;;^UTILITY(U,$J,358.3,36233,0)
 ;;=90732^^101^1537^4^^^^1
 ;;^UTILITY(U,$J,358.3,36233,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36233,1,2,0)
 ;;=2^90732
 ;;^UTILITY(U,$J,358.3,36233,1,3,0)
 ;;=3^Pneumovax
 ;;^UTILITY(U,$J,358.3,36234,0)
 ;;=31610^^101^1538^1^^^^1
 ;;^UTILITY(U,$J,358.3,36234,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36234,1,2,0)
 ;;=2^31610
 ;;^UTILITY(U,$J,358.3,36234,1,3,0)
 ;;=3^Trach Fenestration w/ Skin Flaps
 ;;^UTILITY(U,$J,358.3,36235,0)
 ;;=31605^^101^1538^3^^^^1
 ;;^UTILITY(U,$J,358.3,36235,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36235,1,2,0)
 ;;=2^31605
 ;;^UTILITY(U,$J,358.3,36235,1,3,0)
 ;;=3^Tracheostomy,Emerg,Cricothyroid
 ;;^UTILITY(U,$J,358.3,36236,0)
 ;;=31603^^101^1538^2^^^^1
 ;;^UTILITY(U,$J,358.3,36236,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36236,1,2,0)
 ;;=2^31603
 ;;^UTILITY(U,$J,358.3,36236,1,3,0)
 ;;=3^Tracheostomy Emerg,Transtracheal
