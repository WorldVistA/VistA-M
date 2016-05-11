IBDEI0A4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4496,1,3,0)
 ;;=3^Pressure Ulcer Unspec Site,Stage Unspec
 ;;^UTILITY(U,$J,358.3,4496,1,4,0)
 ;;=4^L89.90
 ;;^UTILITY(U,$J,358.3,4496,2)
 ;;=^5133666
 ;;^UTILITY(U,$J,358.3,4497,0)
 ;;=L89.91^^21^279^24
 ;;^UTILITY(U,$J,358.3,4497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4497,1,3,0)
 ;;=3^Pressure Ulcer Unspec Site,Stage 1
 ;;^UTILITY(U,$J,358.3,4497,1,4,0)
 ;;=4^L89.91
 ;;^UTILITY(U,$J,358.3,4497,2)
 ;;=^5133664
 ;;^UTILITY(U,$J,358.3,4498,0)
 ;;=L76.21^^21^279^22
 ;;^UTILITY(U,$J,358.3,4498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4498,1,3,0)
 ;;=3^Postprocedure Hemor/Hemtom of Skin/SQ Tissue Following Derm Procedure
 ;;^UTILITY(U,$J,358.3,4498,1,4,0)
 ;;=4^L76.21
 ;;^UTILITY(U,$J,358.3,4498,2)
 ;;=^5009306
 ;;^UTILITY(U,$J,358.3,4499,0)
 ;;=L76.22^^21^279^23
 ;;^UTILITY(U,$J,358.3,4499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4499,1,3,0)
 ;;=3^Postprocedure Hemor/Hemtom of Skin/SQ Tissue Following Oth Procedure
 ;;^UTILITY(U,$J,358.3,4499,1,4,0)
 ;;=4^L76.22
 ;;^UTILITY(U,$J,358.3,4499,2)
 ;;=^5009307
 ;;^UTILITY(U,$J,358.3,4500,0)
 ;;=L41.9^^21^279^3
 ;;^UTILITY(U,$J,358.3,4500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4500,1,3,0)
 ;;=3^Parapsoriasis,Unspec
 ;;^UTILITY(U,$J,358.3,4500,1,4,0)
 ;;=4^L41.9
 ;;^UTILITY(U,$J,358.3,4500,2)
 ;;=^5009177
 ;;^UTILITY(U,$J,358.3,4501,0)
 ;;=L70.5^^21^279^13
 ;;^UTILITY(U,$J,358.3,4501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4501,1,3,0)
 ;;=3^Picker's Acne
 ;;^UTILITY(U,$J,358.3,4501,1,4,0)
 ;;=4^L70.5
 ;;^UTILITY(U,$J,358.3,4501,2)
 ;;=^5009272
 ;;^UTILITY(U,$J,358.3,4502,0)
 ;;=L81.9^^21^279^14
 ;;^UTILITY(U,$J,358.3,4502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4502,1,3,0)
 ;;=3^Pigmentation Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,4502,1,4,0)
 ;;=4^L81.9
 ;;^UTILITY(U,$J,358.3,4502,2)
 ;;=^5009319
 ;;^UTILITY(U,$J,358.3,4503,0)
 ;;=L66.3^^21^279^7
 ;;^UTILITY(U,$J,358.3,4503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4503,1,3,0)
 ;;=3^Perifolliculitis Capitis Abscedens
 ;;^UTILITY(U,$J,358.3,4503,1,4,0)
 ;;=4^L66.3
 ;;^UTILITY(U,$J,358.3,4503,2)
 ;;=^5009255
 ;;^UTILITY(U,$J,358.3,4504,0)
 ;;=L71.9^^21^280^7
 ;;^UTILITY(U,$J,358.3,4504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4504,1,3,0)
 ;;=3^Rosacea,Unspec
 ;;^UTILITY(U,$J,358.3,4504,1,4,0)
 ;;=4^L71.9
 ;;^UTILITY(U,$J,358.3,4504,2)
 ;;=^5009276
 ;;^UTILITY(U,$J,358.3,4505,0)
 ;;=L71.1^^21^280^6
 ;;^UTILITY(U,$J,358.3,4505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4505,1,3,0)
 ;;=3^Rhinophyma
 ;;^UTILITY(U,$J,358.3,4505,1,4,0)
 ;;=4^L71.1
 ;;^UTILITY(U,$J,358.3,4505,2)
 ;;=^106083
 ;;^UTILITY(U,$J,358.3,4506,0)
 ;;=I73.00^^21^280^2
 ;;^UTILITY(U,$J,358.3,4506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4506,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,4506,1,4,0)
 ;;=4^I73.00
 ;;^UTILITY(U,$J,358.3,4506,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,4507,0)
 ;;=I73.01^^21^280^1
 ;;^UTILITY(U,$J,358.3,4507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4507,1,3,0)
 ;;=3^Raynaud's Syndrome w/ Gangrene
 ;;^UTILITY(U,$J,358.3,4507,1,4,0)
 ;;=4^I73.01
 ;;^UTILITY(U,$J,358.3,4507,2)
 ;;=^5007797
 ;;^UTILITY(U,$J,358.3,4508,0)
 ;;=Z48.01^^21^280^4
 ;;^UTILITY(U,$J,358.3,4508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4508,1,3,0)
 ;;=3^Removal/Change Surgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,4508,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,4508,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,4509,0)
 ;;=Z48.02^^21^280^3
 ;;^UTILITY(U,$J,358.3,4509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4509,1,3,0)
 ;;=3^Removal of Sutures
