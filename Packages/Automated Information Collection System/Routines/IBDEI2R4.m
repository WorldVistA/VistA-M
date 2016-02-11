IBDEI2R4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46180,0)
 ;;=31631^^204^2282^6^^^^1
 ;;^UTILITY(U,$J,358.3,46180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46180,1,2,0)
 ;;=2^31631
 ;;^UTILITY(U,$J,358.3,46180,1,3,0)
 ;;=3^Bronchoscopy Dilate w/ Stent
 ;;^UTILITY(U,$J,358.3,46181,0)
 ;;=31638^^204^2282^10^^^^1
 ;;^UTILITY(U,$J,358.3,46181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46181,1,2,0)
 ;;=2^31638
 ;;^UTILITY(U,$J,358.3,46181,1,3,0)
 ;;=3^Bronchoscopy Revise Stent
 ;;^UTILITY(U,$J,358.3,46182,0)
 ;;=31637^^204^2282^3^^^^1
 ;;^UTILITY(U,$J,358.3,46182,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46182,1,2,0)
 ;;=2^31637
 ;;^UTILITY(U,$J,358.3,46182,1,3,0)
 ;;=3^Bronchoscopy Bronch Stents,Ea Addl Stent
 ;;^UTILITY(U,$J,358.3,46183,0)
 ;;=31641^^204^2282^11^^^^1
 ;;^UTILITY(U,$J,358.3,46183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46183,1,2,0)
 ;;=2^31641
 ;;^UTILITY(U,$J,358.3,46183,1,3,0)
 ;;=3^Bronchoscopy Treat Blockage
 ;;^UTILITY(U,$J,358.3,46184,0)
 ;;=31632^^204^2282^8^^^^1
 ;;^UTILITY(U,$J,358.3,46184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46184,1,2,0)
 ;;=2^31632
 ;;^UTILITY(U,$J,358.3,46184,1,3,0)
 ;;=3^Bronchoscopy Lung Bx,Ea Addl
 ;;^UTILITY(U,$J,358.3,46185,0)
 ;;=32999^^204^2282^22^^^^1
 ;;^UTILITY(U,$J,358.3,46185,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46185,1,2,0)
 ;;=2^32999
 ;;^UTILITY(U,$J,358.3,46185,1,3,0)
 ;;=3^Chest Surgery Procedure
 ;;^UTILITY(U,$J,358.3,46186,0)
 ;;=76499^^204^2282^26^^^^1
 ;;^UTILITY(U,$J,358.3,46186,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46186,1,2,0)
 ;;=2^76499
 ;;^UTILITY(U,$J,358.3,46186,1,3,0)
 ;;=3^Radiographic Procedure
 ;;^UTILITY(U,$J,358.3,46187,0)
 ;;=31633^^204^2282^9^^^^1
 ;;^UTILITY(U,$J,358.3,46187,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46187,1,2,0)
 ;;=2^31633
 ;;^UTILITY(U,$J,358.3,46187,1,3,0)
 ;;=3^Bronchoscopy Needle Bx,Ea Addl Bx
 ;;^UTILITY(U,$J,358.3,46188,0)
 ;;=31615^^204^2282^12^^^^1
 ;;^UTILITY(U,$J,358.3,46188,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46188,1,2,0)
 ;;=2^31615
 ;;^UTILITY(U,$J,358.3,46188,1,3,0)
 ;;=3^Bronchoscopy thru Est Trach
 ;;^UTILITY(U,$J,358.3,46189,0)
 ;;=31645^^204^2282^17^^^^1
 ;;^UTILITY(U,$J,358.3,46189,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46189,1,2,0)
 ;;=2^31645
 ;;^UTILITY(U,$J,358.3,46189,1,3,0)
 ;;=3^Bronchoscopy w/ Therap Aspiration,Init
 ;;^UTILITY(U,$J,358.3,46190,0)
 ;;=31646^^204^2282^18^^^^1
 ;;^UTILITY(U,$J,358.3,46190,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46190,1,2,0)
 ;;=2^31646
 ;;^UTILITY(U,$J,358.3,46190,1,3,0)
 ;;=3^Bronchoscopy w/ Therap Aspiration,Subseq
 ;;^UTILITY(U,$J,358.3,46191,0)
 ;;=31620^^204^2282^24^^^^1
 ;;^UTILITY(U,$J,358.3,46191,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46191,1,2,0)
 ;;=2^31620
 ;;^UTILITY(U,$J,358.3,46191,1,3,0)
 ;;=3^Endobronch Ultrasound,Use w/ Bronchs
 ;;^UTILITY(U,$J,358.3,46192,0)
 ;;=31231^^204^2282^25^^^^1
 ;;^UTILITY(U,$J,358.3,46192,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46192,1,2,0)
 ;;=2^31231
 ;;^UTILITY(U,$J,358.3,46192,1,3,0)
 ;;=3^Nasal Endoscopy,Diag,Uni/Bilateral
 ;;^UTILITY(U,$J,358.3,46193,0)
 ;;=93015^^204^2283^3^^^^1
 ;;^UTILITY(U,$J,358.3,46193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46193,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,46193,1,3,0)
 ;;=3^Cardiovascular Stress test, Complete
 ;;^UTILITY(U,$J,358.3,46194,0)
 ;;=93017^^204^2283^2^^^^1
 ;;^UTILITY(U,$J,358.3,46194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46194,1,2,0)
 ;;=2^93017
 ;;^UTILITY(U,$J,358.3,46194,1,3,0)
 ;;=3^Cardiovascular Stress Test,Tracing Only
 ;;^UTILITY(U,$J,358.3,46195,0)
 ;;=94620^^204^2283^5^^^^1
