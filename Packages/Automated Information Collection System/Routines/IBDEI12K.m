IBDEI12K ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18180,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,18180,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,18180,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,18181,0)
 ;;=I70.211^^79^874^25
 ;;^UTILITY(U,$J,358.3,18181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18181,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,18181,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,18181,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,18182,0)
 ;;=I70.223^^79^874^13
 ;;^UTILITY(U,$J,358.3,18182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18182,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,18182,1,4,0)
 ;;=4^I70.223
 ;;^UTILITY(U,$J,358.3,18182,2)
 ;;=^5007585
 ;;^UTILITY(U,$J,358.3,18183,0)
 ;;=I70.222^^79^874^22
 ;;^UTILITY(U,$J,358.3,18183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18183,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,18183,1,4,0)
 ;;=4^I70.222
 ;;^UTILITY(U,$J,358.3,18183,2)
 ;;=^5007584
 ;;^UTILITY(U,$J,358.3,18184,0)
 ;;=I70.221^^79^874^26
 ;;^UTILITY(U,$J,358.3,18184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18184,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,18184,1,4,0)
 ;;=4^I70.221
 ;;^UTILITY(U,$J,358.3,18184,2)
 ;;=^5007583
 ;;^UTILITY(U,$J,358.3,18185,0)
 ;;=I70.243^^79^874^15
 ;;^UTILITY(U,$J,358.3,18185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18185,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,18185,1,4,0)
 ;;=4^I70.243
 ;;^UTILITY(U,$J,358.3,18185,2)
 ;;=^5007597
 ;;^UTILITY(U,$J,358.3,18186,0)
 ;;=I70.242^^79^874^16
 ;;^UTILITY(U,$J,358.3,18186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18186,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,18186,1,4,0)
 ;;=4^I70.242
 ;;^UTILITY(U,$J,358.3,18186,2)
 ;;=^5007596
 ;;^UTILITY(U,$J,358.3,18187,0)
 ;;=I70.245^^79^874^17
 ;;^UTILITY(U,$J,358.3,18187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18187,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,18187,1,4,0)
 ;;=4^I70.245
 ;;^UTILITY(U,$J,358.3,18187,2)
 ;;=^5007599
 ;;^UTILITY(U,$J,358.3,18188,0)
 ;;=I70.248^^79^874^21
 ;;^UTILITY(U,$J,358.3,18188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18188,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Lower Leg Ulcer
 ;;^UTILITY(U,$J,358.3,18188,1,4,0)
 ;;=4^I70.248
 ;;^UTILITY(U,$J,358.3,18188,2)
 ;;=^5007600
 ;;^UTILITY(U,$J,358.3,18189,0)
 ;;=I70.241^^79^874^23
 ;;^UTILITY(U,$J,358.3,18189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18189,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,18189,1,4,0)
 ;;=4^I70.241
 ;;^UTILITY(U,$J,358.3,18189,2)
 ;;=^5007595
 ;;^UTILITY(U,$J,358.3,18190,0)
 ;;=I70.244^^79^874^19
 ;;^UTILITY(U,$J,358.3,18190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18190,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,18190,1,4,0)
 ;;=4^I70.244
 ;;^UTILITY(U,$J,358.3,18190,2)
 ;;=^5007598
 ;;^UTILITY(U,$J,358.3,18191,0)
 ;;=I70.25^^79^874^14
 ;;^UTILITY(U,$J,358.3,18191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18191,1,3,0)
 ;;=3^Athscl Native Arteries of Extremities w/ Ulceration
 ;;^UTILITY(U,$J,358.3,18191,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,18191,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,18192,0)
 ;;=I70.233^^79^874^27
 ;;^UTILITY(U,$J,358.3,18192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18192,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ankle Ulcer
