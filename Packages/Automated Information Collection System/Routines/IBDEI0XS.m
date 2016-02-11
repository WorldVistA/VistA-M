IBDEI0XS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15573,1,3,0)
 ;;=3^Malig Neop of Skin of Face,Other Parts
 ;;^UTILITY(U,$J,358.3,15573,1,4,0)
 ;;=4^C44.309
 ;;^UTILITY(U,$J,358.3,15573,2)
 ;;=^5001042
 ;;^UTILITY(U,$J,358.3,15574,0)
 ;;=C44.300^^85^821^89
 ;;^UTILITY(U,$J,358.3,15574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15574,1,3,0)
 ;;=3^Malig Neop of Skin of Face,Unspec Part
 ;;^UTILITY(U,$J,358.3,15574,1,4,0)
 ;;=4^C44.300
 ;;^UTILITY(U,$J,358.3,15574,2)
 ;;=^5001040
 ;;^UTILITY(U,$J,358.3,15575,0)
 ;;=C44.301^^85^821^90
 ;;^UTILITY(U,$J,358.3,15575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15575,1,3,0)
 ;;=3^Malig Neop of Skin of Nose
 ;;^UTILITY(U,$J,358.3,15575,1,4,0)
 ;;=4^C44.301
 ;;^UTILITY(U,$J,358.3,15575,2)
 ;;=^5001041
 ;;^UTILITY(U,$J,358.3,15576,0)
 ;;=E10.621^^85^821^80
 ;;^UTILITY(U,$J,358.3,15576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15576,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,15576,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,15576,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,15577,0)
 ;;=T81.31XA^^85^822^3
 ;;^UTILITY(U,$J,358.3,15577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15577,1,3,0)
 ;;=3^Disruption of External Surgical Wound,Init Encntr
 ;;^UTILITY(U,$J,358.3,15577,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,15577,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,15578,0)
 ;;=T81.33XA^^85^822^4
 ;;^UTILITY(U,$J,358.3,15578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15578,1,3,0)
 ;;=3^Disruption of Traumatic Injury Wound Repair,Init Encntr
 ;;^UTILITY(U,$J,358.3,15578,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,15578,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,15579,0)
 ;;=T81.4XXA^^85^822^5
 ;;^UTILITY(U,$J,358.3,15579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15579,1,3,0)
 ;;=3^Infection Following a Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,15579,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,15579,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,15580,0)
 ;;=T81.89XA^^85^822^1
 ;;^UTILITY(U,$J,358.3,15580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15580,1,3,0)
 ;;=3^Complications of Procedures NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,15580,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,15580,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,15581,0)
 ;;=K91.89^^85^822^7
 ;;^UTILITY(U,$J,358.3,15581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15581,1,3,0)
 ;;=3^Postprocedural Complications/Disorders of Digestive System
 ;;^UTILITY(U,$J,358.3,15581,1,4,0)
 ;;=4^K91.89
 ;;^UTILITY(U,$J,358.3,15581,2)
 ;;=^5008912
 ;;^UTILITY(U,$J,358.3,15582,0)
 ;;=T88.8XXA^^85^822^2
 ;;^UTILITY(U,$J,358.3,15582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15582,1,3,0)
 ;;=3^Complications of Surgical/Medical Care NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,15582,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,15582,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,15583,0)
 ;;=T81.83XA^^85^822^6
 ;;^UTILITY(U,$J,358.3,15583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15583,1,3,0)
 ;;=3^Persistent Postprocedural Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,15583,1,4,0)
 ;;=4^T81.83XA
 ;;^UTILITY(U,$J,358.3,15583,2)
 ;;=^5054659
 ;;^UTILITY(U,$J,358.3,15584,0)
 ;;=I97.610^^85^822^9
 ;;^UTILITY(U,$J,358.3,15584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15584,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System Following Cardiac Cath
 ;;^UTILITY(U,$J,358.3,15584,1,4,0)
 ;;=4^I97.610
 ;;^UTILITY(U,$J,358.3,15584,2)
 ;;=^5008099
 ;;^UTILITY(U,$J,358.3,15585,0)
 ;;=H95.42^^85^822^13
 ;;^UTILITY(U,$J,358.3,15585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15585,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Ear/Mastoid
