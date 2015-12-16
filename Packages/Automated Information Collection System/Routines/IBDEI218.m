IBDEI218 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35518,1,3,0)
 ;;=3^Disruption of external operation (surgical) wound, NEC, init
 ;;^UTILITY(U,$J,358.3,35518,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,35518,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,35519,0)
 ;;=T81.4XXA^^188^2047^4
 ;;^UTILITY(U,$J,358.3,35519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35519,1,3,0)
 ;;=3^Infection following a procedure, initial encounter
 ;;^UTILITY(U,$J,358.3,35519,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,35519,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,35520,0)
 ;;=T81.89XA^^188^2047^1
 ;;^UTILITY(U,$J,358.3,35520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35520,1,3,0)
 ;;=3^Complications of procedures, NEC, init
 ;;^UTILITY(U,$J,358.3,35520,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,35520,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,35521,0)
 ;;=I25.10^^188^2048^1
 ;;^UTILITY(U,$J,358.3,35521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35521,1,3,0)
 ;;=3^Athscl heart disease of native coronary artery w/o ang pctrs
 ;;^UTILITY(U,$J,358.3,35521,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,35521,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,35522,0)
 ;;=I50.9^^188^2048^3
 ;;^UTILITY(U,$J,358.3,35522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35522,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,35522,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,35522,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,35523,0)
 ;;=I65.21^^188^2048^7
 ;;^UTILITY(U,$J,358.3,35523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35523,1,3,0)
 ;;=3^Occlusion and stenosis of right carotid artery
 ;;^UTILITY(U,$J,358.3,35523,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,35523,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,35524,0)
 ;;=I65.22^^188^2048^5
 ;;^UTILITY(U,$J,358.3,35524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35524,1,3,0)
 ;;=3^Occlusion and stenosis of left carotid artery
 ;;^UTILITY(U,$J,358.3,35524,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,35524,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,35525,0)
 ;;=I70.219^^188^2048^2
 ;;^UTILITY(U,$J,358.3,35525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35525,1,3,0)
 ;;=3^Athscl native arteries of extrm w intrmt claud, unsp extrm
 ;;^UTILITY(U,$J,358.3,35525,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,35525,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,35526,0)
 ;;=I73.9^^188^2048^8
 ;;^UTILITY(U,$J,358.3,35526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35526,1,3,0)
 ;;=3^Peripheral vascular disease, unspecified
 ;;^UTILITY(U,$J,358.3,35526,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,35526,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,35527,0)
 ;;=I65.23^^188^2048^4
 ;;^UTILITY(U,$J,358.3,35527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35527,1,3,0)
 ;;=3^Occlusion and stenosis of bilateral carotid arteries
 ;;^UTILITY(U,$J,358.3,35527,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,35527,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,35528,0)
 ;;=I65.8^^188^2048^6
 ;;^UTILITY(U,$J,358.3,35528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35528,1,3,0)
 ;;=3^Occlusion and stenosis of other precerebral arteries
 ;;^UTILITY(U,$J,358.3,35528,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,35528,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,35529,0)
 ;;=Z13.6^^188^2048^9
 ;;^UTILITY(U,$J,358.3,35529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35529,1,3,0)
 ;;=3^Screening for cardiovascular disorders
 ;;^UTILITY(U,$J,358.3,35529,1,4,0)
 ;;=4^Z13.6
 ;;^UTILITY(U,$J,358.3,35529,2)
 ;;=^5062707
 ;;^UTILITY(U,$J,358.3,35530,0)
 ;;=I26.99^^188^2049^9
 ;;^UTILITY(U,$J,358.3,35530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35530,1,3,0)
 ;;=3^Pulmonary embolism w/o acute cor pulmonale NEC
