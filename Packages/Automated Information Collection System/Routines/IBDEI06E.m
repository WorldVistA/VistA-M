IBDEI06E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2395,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,2395,1,4,0)
 ;;=4^I63.132
 ;;^UTILITY(U,$J,358.3,2395,2)
 ;;=^5007309
 ;;^UTILITY(U,$J,358.3,2396,0)
 ;;=I63.231^^19^203^57
 ;;^UTILITY(U,$J,358.3,2396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2396,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,2396,1,4,0)
 ;;=4^I63.231
 ;;^UTILITY(U,$J,358.3,2396,2)
 ;;=^5007316
 ;;^UTILITY(U,$J,358.3,2397,0)
 ;;=I63.232^^19^203^58
 ;;^UTILITY(U,$J,358.3,2397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2397,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,2397,1,4,0)
 ;;=4^I63.232
 ;;^UTILITY(U,$J,358.3,2397,2)
 ;;=^5007317
 ;;^UTILITY(U,$J,358.3,2398,0)
 ;;=I63.211^^19^203^59
 ;;^UTILITY(U,$J,358.3,2398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2398,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Right Vertebral Artery
 ;;^UTILITY(U,$J,358.3,2398,1,4,0)
 ;;=4^I63.211
 ;;^UTILITY(U,$J,358.3,2398,2)
 ;;=^5007313
 ;;^UTILITY(U,$J,358.3,2399,0)
 ;;=I63.212^^19^203^60
 ;;^UTILITY(U,$J,358.3,2399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2399,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Left Vertebral Artery
 ;;^UTILITY(U,$J,358.3,2399,1,4,0)
 ;;=4^I63.212
 ;;^UTILITY(U,$J,358.3,2399,2)
 ;;=^5007314
 ;;^UTILITY(U,$J,358.3,2400,0)
 ;;=G45.9^^19^203^94
 ;;^UTILITY(U,$J,358.3,2400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2400,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attack,Unspec
 ;;^UTILITY(U,$J,358.3,2400,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,2400,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,2401,0)
 ;;=I70.0^^19^203^14
 ;;^UTILITY(U,$J,358.3,2401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2401,1,3,0)
 ;;=3^Atherosclerosis of Aorta
 ;;^UTILITY(U,$J,358.3,2401,1,4,0)
 ;;=4^I70.0
 ;;^UTILITY(U,$J,358.3,2401,2)
 ;;=^269759
 ;;^UTILITY(U,$J,358.3,2402,0)
 ;;=I70.1^^19^203^16
 ;;^UTILITY(U,$J,358.3,2402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2402,1,3,0)
 ;;=3^Atherosclerosis of Renal Artery
 ;;^UTILITY(U,$J,358.3,2402,1,4,0)
 ;;=4^I70.1
 ;;^UTILITY(U,$J,358.3,2402,2)
 ;;=^269760
 ;;^UTILITY(U,$J,358.3,2403,0)
 ;;=I70.211^^19^203^36
 ;;^UTILITY(U,$J,358.3,2403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2403,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,2403,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,2403,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,2404,0)
 ;;=I70.212^^19^203^32
 ;;^UTILITY(U,$J,358.3,2404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2404,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,2404,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,2404,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,2405,0)
 ;;=I70.213^^19^203^28
 ;;^UTILITY(U,$J,358.3,2405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2405,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,2405,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,2405,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,2406,0)
 ;;=I70.221^^19^203^37
 ;;^UTILITY(U,$J,358.3,2406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2406,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,2406,1,4,0)
 ;;=4^I70.221
 ;;^UTILITY(U,$J,358.3,2406,2)
 ;;=^5007583
 ;;^UTILITY(U,$J,358.3,2407,0)
 ;;=I70.222^^19^203^33
 ;;^UTILITY(U,$J,358.3,2407,1,0)
 ;;=^358.31IA^4^2
