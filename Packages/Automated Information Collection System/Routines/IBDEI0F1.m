IBDEI0F1 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6472,1,4,0)
 ;;=4^I63.132
 ;;^UTILITY(U,$J,358.3,6472,2)
 ;;=^5007309
 ;;^UTILITY(U,$J,358.3,6473,0)
 ;;=I63.231^^53^417^61
 ;;^UTILITY(U,$J,358.3,6473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6473,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occl/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,6473,1,4,0)
 ;;=4^I63.231
 ;;^UTILITY(U,$J,358.3,6473,2)
 ;;=^5007316
 ;;^UTILITY(U,$J,358.3,6474,0)
 ;;=I63.232^^53^417^62
 ;;^UTILITY(U,$J,358.3,6474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6474,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occl/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,6474,1,4,0)
 ;;=4^I63.232
 ;;^UTILITY(U,$J,358.3,6474,2)
 ;;=^5007317
 ;;^UTILITY(U,$J,358.3,6475,0)
 ;;=I63.211^^53^417^63
 ;;^UTILITY(U,$J,358.3,6475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6475,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occl/Stenosis of Right Vertebral Artery
 ;;^UTILITY(U,$J,358.3,6475,1,4,0)
 ;;=4^I63.211
 ;;^UTILITY(U,$J,358.3,6475,2)
 ;;=^5007313
 ;;^UTILITY(U,$J,358.3,6476,0)
 ;;=I63.212^^53^417^64
 ;;^UTILITY(U,$J,358.3,6476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6476,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occl/Stenosis of Left Vertebral Artery
 ;;^UTILITY(U,$J,358.3,6476,1,4,0)
 ;;=4^I63.212
 ;;^UTILITY(U,$J,358.3,6476,2)
 ;;=^5007314
 ;;^UTILITY(U,$J,358.3,6477,0)
 ;;=G45.9^^53^417^106
 ;;^UTILITY(U,$J,358.3,6477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6477,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attack,Unspec
 ;;^UTILITY(U,$J,358.3,6477,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,6477,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,6478,0)
 ;;=I70.0^^53^417^16
 ;;^UTILITY(U,$J,358.3,6478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6478,1,3,0)
 ;;=3^Atherosclerosis of Aorta
 ;;^UTILITY(U,$J,358.3,6478,1,4,0)
 ;;=4^I70.0
 ;;^UTILITY(U,$J,358.3,6478,2)
 ;;=^269759
 ;;^UTILITY(U,$J,358.3,6479,0)
 ;;=I70.1^^53^417^18
 ;;^UTILITY(U,$J,358.3,6479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6479,1,3,0)
 ;;=3^Atherosclerosis of Renal Artery
 ;;^UTILITY(U,$J,358.3,6479,1,4,0)
 ;;=4^I70.1
 ;;^UTILITY(U,$J,358.3,6479,2)
 ;;=^269760
 ;;^UTILITY(U,$J,358.3,6480,0)
 ;;=I70.211^^53^417^38
 ;;^UTILITY(U,$J,358.3,6480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6480,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,6480,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,6480,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,6481,0)
 ;;=I70.212^^53^417^34
 ;;^UTILITY(U,$J,358.3,6481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6481,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,6481,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,6481,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,6482,0)
 ;;=I70.213^^53^417^30
 ;;^UTILITY(U,$J,358.3,6482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6482,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,6482,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,6482,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,6483,0)
 ;;=I70.221^^53^417^39
 ;;^UTILITY(U,$J,358.3,6483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6483,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,6483,1,4,0)
 ;;=4^I70.221
 ;;^UTILITY(U,$J,358.3,6483,2)
 ;;=^5007583
 ;;^UTILITY(U,$J,358.3,6484,0)
 ;;=I70.222^^53^417^35
 ;;^UTILITY(U,$J,358.3,6484,1,0)
 ;;=^358.31IA^4^2
