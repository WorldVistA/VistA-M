IBDEI0S6 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12565,1,3,0)
 ;;=3^Malig Neop of Skin of Nose
 ;;^UTILITY(U,$J,358.3,12565,1,4,0)
 ;;=4^C44.301
 ;;^UTILITY(U,$J,358.3,12565,2)
 ;;=^5001041
 ;;^UTILITY(U,$J,358.3,12566,0)
 ;;=E10.621^^80^782^80
 ;;^UTILITY(U,$J,358.3,12566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12566,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,12566,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,12566,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,12567,0)
 ;;=M72.6^^80^782^92
 ;;^UTILITY(U,$J,358.3,12567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12567,1,3,0)
 ;;=3^Necrotizing Fasciitis
 ;;^UTILITY(U,$J,358.3,12567,1,4,0)
 ;;=4^M72.6
 ;;^UTILITY(U,$J,358.3,12567,2)
 ;;=^303314
 ;;^UTILITY(U,$J,358.3,12568,0)
 ;;=T81.31XA^^80^783^3
 ;;^UTILITY(U,$J,358.3,12568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12568,1,3,0)
 ;;=3^Disruption of External Surgical Wound,Init Encntr
 ;;^UTILITY(U,$J,358.3,12568,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,12568,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,12569,0)
 ;;=T81.33XA^^80^783^4
 ;;^UTILITY(U,$J,358.3,12569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12569,1,3,0)
 ;;=3^Disruption of Traumatic Injury Wound Repair,Init Encntr
 ;;^UTILITY(U,$J,358.3,12569,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,12569,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,12570,0)
 ;;=T81.89XA^^80^783^1
 ;;^UTILITY(U,$J,358.3,12570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12570,1,3,0)
 ;;=3^Complications of Procedures NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,12570,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,12570,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,12571,0)
 ;;=K91.89^^80^783^7
 ;;^UTILITY(U,$J,358.3,12571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12571,1,3,0)
 ;;=3^Postprocedural Complications/Disorders of Digestive System
 ;;^UTILITY(U,$J,358.3,12571,1,4,0)
 ;;=4^K91.89
 ;;^UTILITY(U,$J,358.3,12571,2)
 ;;=^5008912
 ;;^UTILITY(U,$J,358.3,12572,0)
 ;;=T88.8XXA^^80^783^2
 ;;^UTILITY(U,$J,358.3,12572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12572,1,3,0)
 ;;=3^Complications of Surgical/Medical Care NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,12572,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,12572,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,12573,0)
 ;;=T81.83XA^^80^783^6
 ;;^UTILITY(U,$J,358.3,12573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12573,1,3,0)
 ;;=3^Persistent Postprocedural Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,12573,1,4,0)
 ;;=4^T81.83XA
 ;;^UTILITY(U,$J,358.3,12573,2)
 ;;=^5054659
 ;;^UTILITY(U,$J,358.3,12574,0)
 ;;=I97.610^^80^783^11
 ;;^UTILITY(U,$J,358.3,12574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12574,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System Following Cardiac Cath
 ;;^UTILITY(U,$J,358.3,12574,1,4,0)
 ;;=4^I97.610
 ;;^UTILITY(U,$J,358.3,12574,2)
 ;;=^5008099
 ;;^UTILITY(U,$J,358.3,12575,0)
 ;;=H95.42^^80^783^14
 ;;^UTILITY(U,$J,358.3,12575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12575,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Ear/Mastoid
 ;;^UTILITY(U,$J,358.3,12575,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,12575,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,12576,0)
 ;;=I97.611^^80^783^12
 ;;^UTILITY(U,$J,358.3,12576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12576,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System Following Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,12576,1,4,0)
 ;;=4^I97.611
 ;;^UTILITY(U,$J,358.3,12576,2)
 ;;=^5008100
