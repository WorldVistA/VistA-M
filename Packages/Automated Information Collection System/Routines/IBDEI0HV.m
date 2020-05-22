IBDEI0HV ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7782,1,4,0)
 ;;=4^E87.70
 ;;^UTILITY(U,$J,358.3,7782,2)
 ;;=^5003023
 ;;^UTILITY(U,$J,358.3,7783,0)
 ;;=E87.79^^63^502^8
 ;;^UTILITY(U,$J,358.3,7783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7783,1,3,0)
 ;;=3^Fluid Overload,Other
 ;;^UTILITY(U,$J,358.3,7783,1,4,0)
 ;;=4^E87.79
 ;;^UTILITY(U,$J,358.3,7783,2)
 ;;=^5003025
 ;;^UTILITY(U,$J,358.3,7784,0)
 ;;=R73.09^^63^502^1
 ;;^UTILITY(U,$J,358.3,7784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7784,1,3,0)
 ;;=3^Abnormal Glucose
 ;;^UTILITY(U,$J,358.3,7784,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,7784,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,7785,0)
 ;;=D62.^^63^502^2
 ;;^UTILITY(U,$J,358.3,7785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7785,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,7785,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,7785,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,7786,0)
 ;;=F06.8^^63^502^13
 ;;^UTILITY(U,$J,358.3,7786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7786,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition NEC
 ;;^UTILITY(U,$J,358.3,7786,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,7786,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,7787,0)
 ;;=F05.^^63^502^5
 ;;^UTILITY(U,$J,358.3,7787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7787,1,3,0)
 ;;=3^Delirium d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,7787,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,7787,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,7788,0)
 ;;=R73.9^^63^502^10
 ;;^UTILITY(U,$J,358.3,7788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7788,1,3,0)
 ;;=3^Hyperglycemia,Unspec
 ;;^UTILITY(U,$J,358.3,7788,1,4,0)
 ;;=4^R73.9
 ;;^UTILITY(U,$J,358.3,7788,2)
 ;;=^5019564
 ;;^UTILITY(U,$J,358.3,7789,0)
 ;;=K56.0^^63^502^14
 ;;^UTILITY(U,$J,358.3,7789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7789,1,3,0)
 ;;=3^Paralytic Ileus
 ;;^UTILITY(U,$J,358.3,7789,1,4,0)
 ;;=4^K56.0
 ;;^UTILITY(U,$J,358.3,7789,2)
 ;;=^89879
 ;;^UTILITY(U,$J,358.3,7790,0)
 ;;=I97.710^^63^503^20
 ;;^UTILITY(U,$J,358.3,7790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7790,1,3,0)
 ;;=3^Intraoperative Cardiac Arrest During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,7790,1,4,0)
 ;;=4^I97.710
 ;;^UTILITY(U,$J,358.3,7790,2)
 ;;=^5008103
 ;;^UTILITY(U,$J,358.3,7791,0)
 ;;=I97.790^^63^503^21
 ;;^UTILITY(U,$J,358.3,7791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7791,1,3,0)
 ;;=3^Intraoperative Cardiac Function Disturbance During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,7791,1,4,0)
 ;;=4^I97.790
 ;;^UTILITY(U,$J,358.3,7791,2)
 ;;=^5008105
 ;;^UTILITY(U,$J,358.3,7792,0)
 ;;=I97.88^^63^503^22
 ;;^UTILITY(U,$J,358.3,7792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7792,1,3,0)
 ;;=3^Intraoperative Complications of the Circ System
 ;;^UTILITY(U,$J,358.3,7792,1,4,0)
 ;;=4^I97.88
 ;;^UTILITY(U,$J,358.3,7792,2)
 ;;=^5008111
 ;;^UTILITY(U,$J,358.3,7793,0)
 ;;=I97.89^^63^503^30
 ;;^UTILITY(U,$J,358.3,7793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7793,1,3,0)
 ;;=3^Postprocedure Complication/Disorder of the Circ System
 ;;^UTILITY(U,$J,358.3,7793,1,4,0)
 ;;=4^I97.89
 ;;^UTILITY(U,$J,358.3,7793,2)
 ;;=^5008112
 ;;^UTILITY(U,$J,358.3,7794,0)
 ;;=T82.817A^^63^503^10
 ;;^UTILITY(U,$J,358.3,7794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7794,1,3,0)
 ;;=3^Embolism of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,7794,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,7794,2)
 ;;=^5054914
