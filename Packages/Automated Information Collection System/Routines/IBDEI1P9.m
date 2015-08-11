IBDEI1P9 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30497,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,30497,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,30497,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,30498,0)
 ;;=C44.309^^189^1917^88
 ;;^UTILITY(U,$J,358.3,30498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30498,1,3,0)
 ;;=3^Malig Neop of Skin of Face,Other Parts
 ;;^UTILITY(U,$J,358.3,30498,1,4,0)
 ;;=4^C44.309
 ;;^UTILITY(U,$J,358.3,30498,2)
 ;;=^5001042
 ;;^UTILITY(U,$J,358.3,30499,0)
 ;;=C44.300^^189^1917^89
 ;;^UTILITY(U,$J,358.3,30499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30499,1,3,0)
 ;;=3^Malig Neop of Skin of Face,Unspec Part
 ;;^UTILITY(U,$J,358.3,30499,1,4,0)
 ;;=4^C44.300
 ;;^UTILITY(U,$J,358.3,30499,2)
 ;;=^5001040
 ;;^UTILITY(U,$J,358.3,30500,0)
 ;;=C44.301^^189^1917^90
 ;;^UTILITY(U,$J,358.3,30500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30500,1,3,0)
 ;;=3^Malig Neop of Skin of Nose
 ;;^UTILITY(U,$J,358.3,30500,1,4,0)
 ;;=4^C44.301
 ;;^UTILITY(U,$J,358.3,30500,2)
 ;;=^5001041
 ;;^UTILITY(U,$J,358.3,30501,0)
 ;;=T81.31XA^^189^1918^3
 ;;^UTILITY(U,$J,358.3,30501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30501,1,3,0)
 ;;=3^Disruption of External Surgical Wound,Init Encntr
 ;;^UTILITY(U,$J,358.3,30501,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,30501,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,30502,0)
 ;;=T81.33XA^^189^1918^4
 ;;^UTILITY(U,$J,358.3,30502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30502,1,3,0)
 ;;=3^Disruption of Traumatic Injury Wound Repair,Init Encntr
 ;;^UTILITY(U,$J,358.3,30502,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,30502,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,30503,0)
 ;;=T81.4XXA^^189^1918^5
 ;;^UTILITY(U,$J,358.3,30503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30503,1,3,0)
 ;;=3^Infection Following a Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,30503,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,30503,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,30504,0)
 ;;=T81.89XA^^189^1918^1
 ;;^UTILITY(U,$J,358.3,30504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30504,1,3,0)
 ;;=3^Complications of Procedures NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,30504,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,30504,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,30505,0)
 ;;=K91.89^^189^1918^7
 ;;^UTILITY(U,$J,358.3,30505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30505,1,3,0)
 ;;=3^Postprocedural Complications/Disorders of Digestive System
 ;;^UTILITY(U,$J,358.3,30505,1,4,0)
 ;;=4^K91.89
 ;;^UTILITY(U,$J,358.3,30505,2)
 ;;=^5008912
 ;;^UTILITY(U,$J,358.3,30506,0)
 ;;=T88.8XXA^^189^1918^2
 ;;^UTILITY(U,$J,358.3,30506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30506,1,3,0)
 ;;=3^Complications of Surgical/Medical Care NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,30506,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,30506,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,30507,0)
 ;;=T81.83XA^^189^1918^6
 ;;^UTILITY(U,$J,358.3,30507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30507,1,3,0)
 ;;=3^Persistent Postprocedural Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,30507,1,4,0)
 ;;=4^T81.83XA
 ;;^UTILITY(U,$J,358.3,30507,2)
 ;;=^5054659
 ;;^UTILITY(U,$J,358.3,30508,0)
 ;;=I97.610^^189^1918^9
 ;;^UTILITY(U,$J,358.3,30508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30508,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System Following Cardiac Cath
 ;;^UTILITY(U,$J,358.3,30508,1,4,0)
 ;;=4^I97.610
 ;;^UTILITY(U,$J,358.3,30508,2)
 ;;=^5008099
 ;;^UTILITY(U,$J,358.3,30509,0)
 ;;=H95.42^^189^1918^13
 ;;^UTILITY(U,$J,358.3,30509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30509,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Ear/Mastoid
