IBDEI1G5 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23400,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,23400,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,23401,0)
 ;;=Z51.81^^78^1009^25
 ;;^UTILITY(U,$J,358.3,23401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23401,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,23401,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,23401,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,23402,0)
 ;;=D68.51^^78^1009^1
 ;;^UTILITY(U,$J,358.3,23402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23402,1,3,0)
 ;;=3^Activated Protein C Resistance
 ;;^UTILITY(U,$J,358.3,23402,1,4,0)
 ;;=4^D68.51
 ;;^UTILITY(U,$J,358.3,23402,2)
 ;;=^5002358
 ;;^UTILITY(U,$J,358.3,23403,0)
 ;;=I82.402^^78^1009^2
 ;;^UTILITY(U,$J,358.3,23403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23403,1,3,0)
 ;;=3^Acute Embolism/Thrombos Deep Veins Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,23403,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,23403,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,23404,0)
 ;;=I82.401^^78^1009^3
 ;;^UTILITY(U,$J,358.3,23404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23404,1,3,0)
 ;;=3^Acute Embolism/Thrombos Deep Veins Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,23404,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,23404,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,23405,0)
 ;;=I82.890^^78^1009^4
 ;;^UTILITY(U,$J,358.3,23405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23405,1,3,0)
 ;;=3^Acute Embolism/Thrombosis of Specified Veins
 ;;^UTILITY(U,$J,358.3,23405,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,23405,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,23406,0)
 ;;=D68.61^^78^1009^6
 ;;^UTILITY(U,$J,358.3,23406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23406,1,3,0)
 ;;=3^Antiphospholipid Syndrome
 ;;^UTILITY(U,$J,358.3,23406,1,4,0)
 ;;=4^D68.61
 ;;^UTILITY(U,$J,358.3,23406,2)
 ;;=^185421
 ;;^UTILITY(U,$J,358.3,23407,0)
 ;;=I63.50^^78^1009^7
 ;;^UTILITY(U,$J,358.3,23407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23407,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenos of Cereb Artery
 ;;^UTILITY(U,$J,358.3,23407,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,23407,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,23408,0)
 ;;=I82.91^^78^1009^8
 ;;^UTILITY(U,$J,358.3,23408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23408,1,3,0)
 ;;=3^Chronic Embolism/Thrombosis Unspec Vein
 ;;^UTILITY(U,$J,358.3,23408,1,4,0)
 ;;=4^I82.91
 ;;^UTILITY(U,$J,358.3,23408,2)
 ;;=^5007941
 ;;^UTILITY(U,$J,358.3,23409,0)
 ;;=I25.9^^78^1009^10
 ;;^UTILITY(U,$J,358.3,23409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23409,1,3,0)
 ;;=3^Chronic Ischemic Heart Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23409,1,4,0)
 ;;=4^I25.9
 ;;^UTILITY(U,$J,358.3,23409,2)
 ;;=^5007144
 ;;^UTILITY(U,$J,358.3,23410,0)
 ;;=D68.9^^78^1009^11
 ;;^UTILITY(U,$J,358.3,23410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23410,1,3,0)
 ;;=3^Coagulation Defect,Unspec
 ;;^UTILITY(U,$J,358.3,23410,1,4,0)
 ;;=4^D68.9
 ;;^UTILITY(U,$J,358.3,23410,2)
 ;;=^5002364
 ;;^UTILITY(U,$J,358.3,23411,0)
 ;;=D68.8^^78^1009^12
 ;;^UTILITY(U,$J,358.3,23411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23411,1,3,0)
 ;;=3^Coagulation Defects,Other Spec
 ;;^UTILITY(U,$J,358.3,23411,1,4,0)
 ;;=4^D68.8
 ;;^UTILITY(U,$J,358.3,23411,2)
 ;;=^5002363
 ;;^UTILITY(U,$J,358.3,23412,0)
 ;;=D68.318^^78^1009^13
 ;;^UTILITY(U,$J,358.3,23412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23412,1,3,0)
 ;;=3^Hemorrhagic Disorder d/t Intrinsic Circ Anticoagulants
