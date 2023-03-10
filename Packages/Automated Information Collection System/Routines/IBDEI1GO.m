IBDEI1GO ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23631,1,4,0)
 ;;=4^D68.8
 ;;^UTILITY(U,$J,358.3,23631,2)
 ;;=^5002363
 ;;^UTILITY(U,$J,358.3,23632,0)
 ;;=D68.318^^79^1021^13
 ;;^UTILITY(U,$J,358.3,23632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23632,1,3,0)
 ;;=3^Hemorrhagic Disorder d/t Intrns Circ Anticoag/Antib/Inhib
 ;;^UTILITY(U,$J,358.3,23632,1,4,0)
 ;;=4^D68.318
 ;;^UTILITY(U,$J,358.3,23632,2)
 ;;=^340504
 ;;^UTILITY(U,$J,358.3,23633,0)
 ;;=D68.32^^79^1021^12
 ;;^UTILITY(U,$J,358.3,23633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23633,1,3,0)
 ;;=3^Hemorrhagic Disorder d/t Extrinsic Circulating Anticoagulants
 ;;^UTILITY(U,$J,358.3,23633,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,23633,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,23634,0)
 ;;=I10.^^79^1021^14
 ;;^UTILITY(U,$J,358.3,23634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23634,1,3,0)
 ;;=3^Hypertension,Essential
 ;;^UTILITY(U,$J,358.3,23634,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,23634,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,23635,0)
 ;;=I82.401^^79^1021^3
 ;;^UTILITY(U,$J,358.3,23635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23635,1,3,0)
 ;;=3^Acute Embolism/Thrombos Deep Veins,Rt Lower Extrem,Unspec
 ;;^UTILITY(U,$J,358.3,23635,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,23635,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,23636,0)
 ;;=I82.402^^79^1021^2
 ;;^UTILITY(U,$J,358.3,23636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23636,1,3,0)
 ;;=3^Acute Embolism/Thrombos Deep Veins,Lt Lower Extrem,Unspec
 ;;^UTILITY(U,$J,358.3,23636,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,23636,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,23637,0)
 ;;=I82.890^^79^1021^1
 ;;^UTILITY(U,$J,358.3,23637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23637,1,3,0)
 ;;=3^Acute Embolism/Thromb of Other Specified Veins
 ;;^UTILITY(U,$J,358.3,23637,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,23637,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,23638,0)
 ;;=I82.891^^79^1021^10
 ;;^UTILITY(U,$J,358.3,23638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23638,1,3,0)
 ;;=3^Chronic Embolism/Thrombo of Other Specified Veins
 ;;^UTILITY(U,$J,358.3,23638,1,4,0)
 ;;=4^I82.891
 ;;^UTILITY(U,$J,358.3,23638,2)
 ;;=^5007939
 ;;^UTILITY(U,$J,358.3,23639,0)
 ;;=D68.62^^79^1021^16
 ;;^UTILITY(U,$J,358.3,23639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23639,1,3,0)
 ;;=3^Lupus Anticoagulant Syndrome
 ;;^UTILITY(U,$J,358.3,23639,1,4,0)
 ;;=4^D68.62
 ;;^UTILITY(U,$J,358.3,23639,2)
 ;;=^5002361
 ;;^UTILITY(U,$J,358.3,23640,0)
 ;;=I48.20^^79^1021^4
 ;;^UTILITY(U,$J,358.3,23640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23640,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,23640,1,4,0)
 ;;=4^I48.20
 ;;^UTILITY(U,$J,358.3,23640,2)
 ;;=^5158048
 ;;^UTILITY(U,$J,358.3,23641,0)
 ;;=I48.21^^79^1021^8
 ;;^UTILITY(U,$J,358.3,23641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23641,1,3,0)
 ;;=3^Atrial Fibrillation,Permanent
 ;;^UTILITY(U,$J,358.3,23641,1,4,0)
 ;;=4^I48.21
 ;;^UTILITY(U,$J,358.3,23641,2)
 ;;=^304710
 ;;^UTILITY(U,$J,358.3,23642,0)
 ;;=I48.11^^79^1021^5
 ;;^UTILITY(U,$J,358.3,23642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23642,1,3,0)
 ;;=3^Atrial Fibrillation,Longstanding Persistent
 ;;^UTILITY(U,$J,358.3,23642,1,4,0)
 ;;=4^I48.11
 ;;^UTILITY(U,$J,358.3,23642,2)
 ;;=^5158046
 ;;^UTILITY(U,$J,358.3,23643,0)
 ;;=I48.19^^79^1021^6
 ;;^UTILITY(U,$J,358.3,23643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23643,1,3,0)
 ;;=3^Atrial Fibrillation,Other Persistent
