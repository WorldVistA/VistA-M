IBDEI0BF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4862,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,4863,0)
 ;;=R73.9^^37^322^10
 ;;^UTILITY(U,$J,358.3,4863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4863,1,3,0)
 ;;=3^Hyperglycemia,Unspec
 ;;^UTILITY(U,$J,358.3,4863,1,4,0)
 ;;=4^R73.9
 ;;^UTILITY(U,$J,358.3,4863,2)
 ;;=^5019564
 ;;^UTILITY(U,$J,358.3,4864,0)
 ;;=K56.0^^37^322^14
 ;;^UTILITY(U,$J,358.3,4864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4864,1,3,0)
 ;;=3^Paralytic Ileus
 ;;^UTILITY(U,$J,358.3,4864,1,4,0)
 ;;=4^K56.0
 ;;^UTILITY(U,$J,358.3,4864,2)
 ;;=^89879
 ;;^UTILITY(U,$J,358.3,4865,0)
 ;;=I97.710^^37^323^17
 ;;^UTILITY(U,$J,358.3,4865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4865,1,3,0)
 ;;=3^Intraoperative Cardiac Arrest During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,4865,1,4,0)
 ;;=4^I97.710
 ;;^UTILITY(U,$J,358.3,4865,2)
 ;;=^5008103
 ;;^UTILITY(U,$J,358.3,4866,0)
 ;;=I97.790^^37^323^18
 ;;^UTILITY(U,$J,358.3,4866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4866,1,3,0)
 ;;=3^Intraoperative Cardiac Function Disturbance During Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,4866,1,4,0)
 ;;=4^I97.790
 ;;^UTILITY(U,$J,358.3,4866,2)
 ;;=^5008105
 ;;^UTILITY(U,$J,358.3,4867,0)
 ;;=I97.88^^37^323^19
 ;;^UTILITY(U,$J,358.3,4867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4867,1,3,0)
 ;;=3^Intraoperative Complications of the Circ System
 ;;^UTILITY(U,$J,358.3,4867,1,4,0)
 ;;=4^I97.88
 ;;^UTILITY(U,$J,358.3,4867,2)
 ;;=^5008111
 ;;^UTILITY(U,$J,358.3,4868,0)
 ;;=I97.89^^37^323^24
 ;;^UTILITY(U,$J,358.3,4868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4868,1,3,0)
 ;;=3^Postprocedure Complication/Disorder of the Circ System
 ;;^UTILITY(U,$J,358.3,4868,1,4,0)
 ;;=4^I97.89
 ;;^UTILITY(U,$J,358.3,4868,2)
 ;;=^5008112
 ;;^UTILITY(U,$J,358.3,4869,0)
 ;;=T82.817A^^37^323^10
 ;;^UTILITY(U,$J,358.3,4869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4869,1,3,0)
 ;;=3^Embolism of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4869,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,4869,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,4870,0)
 ;;=T82.827A^^37^323^12
 ;;^UTILITY(U,$J,358.3,4870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4870,1,3,0)
 ;;=3^Fibrosis of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4870,1,4,0)
 ;;=4^T82.827A
 ;;^UTILITY(U,$J,358.3,4870,2)
 ;;=^5054920
 ;;^UTILITY(U,$J,358.3,4871,0)
 ;;=T82.837A^^37^323^14
 ;;^UTILITY(U,$J,358.3,4871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4871,1,3,0)
 ;;=3^Hemorrhage of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4871,1,4,0)
 ;;=4^T82.837A
 ;;^UTILITY(U,$J,358.3,4871,2)
 ;;=^5054926
 ;;^UTILITY(U,$J,358.3,4872,0)
 ;;=T82.847A^^37^323^20
 ;;^UTILITY(U,$J,358.3,4872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4872,1,3,0)
 ;;=3^Pain from Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4872,1,4,0)
 ;;=4^T82.847A
 ;;^UTILITY(U,$J,358.3,4872,2)
 ;;=^5054932
 ;;^UTILITY(U,$J,358.3,4873,0)
 ;;=T82.857A^^37^323^25
 ;;^UTILITY(U,$J,358.3,4873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4873,1,3,0)
 ;;=3^Stenosis of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4873,1,4,0)
 ;;=4^T82.857A
 ;;^UTILITY(U,$J,358.3,4873,2)
 ;;=^5054938
 ;;^UTILITY(U,$J,358.3,4874,0)
 ;;=T82.867A^^37^323^27
 ;;^UTILITY(U,$J,358.3,4874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4874,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4874,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,4874,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,4875,0)
 ;;=T82.897A^^37^323^9
 ;;^UTILITY(U,$J,358.3,4875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4875,1,3,0)
 ;;=3^Complications of Cardiac Prosth Dev/Graft,Init
