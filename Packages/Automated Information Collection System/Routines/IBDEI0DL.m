IBDEI0DL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5920,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,5921,0)
 ;;=C44.309^^40^379^88
 ;;^UTILITY(U,$J,358.3,5921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5921,1,3,0)
 ;;=3^Malig Neop of Skin of Face,Other Parts
 ;;^UTILITY(U,$J,358.3,5921,1,4,0)
 ;;=4^C44.309
 ;;^UTILITY(U,$J,358.3,5921,2)
 ;;=^5001042
 ;;^UTILITY(U,$J,358.3,5922,0)
 ;;=C44.300^^40^379^89
 ;;^UTILITY(U,$J,358.3,5922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5922,1,3,0)
 ;;=3^Malig Neop of Skin of Face,Unspec Part
 ;;^UTILITY(U,$J,358.3,5922,1,4,0)
 ;;=4^C44.300
 ;;^UTILITY(U,$J,358.3,5922,2)
 ;;=^5001040
 ;;^UTILITY(U,$J,358.3,5923,0)
 ;;=C44.301^^40^379^90
 ;;^UTILITY(U,$J,358.3,5923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5923,1,3,0)
 ;;=3^Malig Neop of Skin of Nose
 ;;^UTILITY(U,$J,358.3,5923,1,4,0)
 ;;=4^C44.301
 ;;^UTILITY(U,$J,358.3,5923,2)
 ;;=^5001041
 ;;^UTILITY(U,$J,358.3,5924,0)
 ;;=E10.621^^40^379^80
 ;;^UTILITY(U,$J,358.3,5924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5924,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,5924,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,5924,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,5925,0)
 ;;=T81.31XA^^40^380^3
 ;;^UTILITY(U,$J,358.3,5925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5925,1,3,0)
 ;;=3^Disruption of External Surgical Wound,Init Encntr
 ;;^UTILITY(U,$J,358.3,5925,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,5925,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,5926,0)
 ;;=T81.33XA^^40^380^4
 ;;^UTILITY(U,$J,358.3,5926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5926,1,3,0)
 ;;=3^Disruption of Traumatic Injury Wound Repair,Init Encntr
 ;;^UTILITY(U,$J,358.3,5926,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,5926,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,5927,0)
 ;;=T81.4XXA^^40^380^5
 ;;^UTILITY(U,$J,358.3,5927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5927,1,3,0)
 ;;=3^Infection Following a Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,5927,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,5927,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,5928,0)
 ;;=T81.89XA^^40^380^1
 ;;^UTILITY(U,$J,358.3,5928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5928,1,3,0)
 ;;=3^Complications of Procedures NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,5928,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,5928,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,5929,0)
 ;;=K91.89^^40^380^7
 ;;^UTILITY(U,$J,358.3,5929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5929,1,3,0)
 ;;=3^Postprocedural Complications/Disorders of Digestive System
 ;;^UTILITY(U,$J,358.3,5929,1,4,0)
 ;;=4^K91.89
 ;;^UTILITY(U,$J,358.3,5929,2)
 ;;=^5008912
 ;;^UTILITY(U,$J,358.3,5930,0)
 ;;=T88.8XXA^^40^380^2
 ;;^UTILITY(U,$J,358.3,5930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5930,1,3,0)
 ;;=3^Complications of Surgical/Medical Care NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,5930,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,5930,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,5931,0)
 ;;=T81.83XA^^40^380^6
 ;;^UTILITY(U,$J,358.3,5931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5931,1,3,0)
 ;;=3^Persistent Postprocedural Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,5931,1,4,0)
 ;;=4^T81.83XA
 ;;^UTILITY(U,$J,358.3,5931,2)
 ;;=^5054659
 ;;^UTILITY(U,$J,358.3,5932,0)
 ;;=I97.610^^40^380^9
 ;;^UTILITY(U,$J,358.3,5932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5932,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System Following Cardiac Cath
 ;;^UTILITY(U,$J,358.3,5932,1,4,0)
 ;;=4^I97.610
 ;;^UTILITY(U,$J,358.3,5932,2)
 ;;=^5008099
 ;;^UTILITY(U,$J,358.3,5933,0)
 ;;=H95.42^^40^380^13
 ;;^UTILITY(U,$J,358.3,5933,1,0)
 ;;=^358.31IA^4^2
