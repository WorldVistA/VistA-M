IBDEI0H8 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7759,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,7759,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,7760,0)
 ;;=I25.709^^39^389^20
 ;;^UTILITY(U,$J,358.3,7760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7760,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,7760,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,7760,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,7761,0)
 ;;=I25.700^^39^389^21
 ;;^UTILITY(U,$J,358.3,7761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7761,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,7761,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,7761,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,7762,0)
 ;;=I82.469^^39^389^24
 ;;^UTILITY(U,$J,358.3,7762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7762,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Acute
 ;;^UTILITY(U,$J,358.3,7762,1,4,0)
 ;;=4^I82.469
 ;;^UTILITY(U,$J,358.3,7762,2)
 ;;=^5158066
 ;;^UTILITY(U,$J,358.3,7763,0)
 ;;=I82.569^^39^389^25
 ;;^UTILITY(U,$J,358.3,7763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7763,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Calf Muscle Vein,Chronic
 ;;^UTILITY(U,$J,358.3,7763,1,4,0)
 ;;=4^I82.569
 ;;^UTILITY(U,$J,358.3,7763,2)
 ;;=^5158074
 ;;^UTILITY(U,$J,358.3,7764,0)
 ;;=I80.259^^39^389^33
 ;;^UTILITY(U,$J,358.3,7764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7764,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis,Unspec Calf Muscle Vein
 ;;^UTILITY(U,$J,358.3,7764,1,4,0)
 ;;=4^I80.259
 ;;^UTILITY(U,$J,358.3,7764,2)
 ;;=^5158058
 ;;^UTILITY(U,$J,358.3,7765,0)
 ;;=I82.409^^39^389^26
 ;;^UTILITY(U,$J,358.3,7765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7765,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Deep Vein,LE Unspec Acute
 ;;^UTILITY(U,$J,358.3,7765,1,4,0)
 ;;=4^I82.409
 ;;^UTILITY(U,$J,358.3,7765,2)
 ;;=^5133625
 ;;^UTILITY(U,$J,358.3,7766,0)
 ;;=I82.509^^39^389^27
 ;;^UTILITY(U,$J,358.3,7766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7766,1,3,0)
 ;;=3^Embolism/Thrombosis,Unspec Deep Vein,LE Unspec Chronic
 ;;^UTILITY(U,$J,358.3,7766,1,4,0)
 ;;=4^I82.509
 ;;^UTILITY(U,$J,358.3,7766,2)
 ;;=^5133628
 ;;^UTILITY(U,$J,358.3,7767,0)
 ;;=E78.1^^39^390^23
 ;;^UTILITY(U,$J,358.3,7767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7767,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,7767,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,7767,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,7768,0)
 ;;=E78.2^^39^390^21
 ;;^UTILITY(U,$J,358.3,7768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7768,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,7768,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,7768,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,7769,0)
 ;;=I10.^^39^390^9
 ;;^UTILITY(U,$J,358.3,7769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7769,1,3,0)
 ;;=3^Essential Primary Hypertension
 ;;^UTILITY(U,$J,358.3,7769,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,7769,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,7770,0)
 ;;=I11.9^^39^390^19
 ;;^UTILITY(U,$J,358.3,7770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7770,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,7770,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,7770,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,7771,0)
 ;;=I11.0^^39^390^18
 ;;^UTILITY(U,$J,358.3,7771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7771,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure
