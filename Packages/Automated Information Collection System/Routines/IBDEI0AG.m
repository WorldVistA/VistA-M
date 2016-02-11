IBDEI0AG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4364,1,3,0)
 ;;=3^Cardiomyopathies,Other
 ;;^UTILITY(U,$J,358.3,4364,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,4364,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,4365,0)
 ;;=I42.5^^30^271^26
 ;;^UTILITY(U,$J,358.3,4365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4365,1,3,0)
 ;;=3^Restrictive Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,4365,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,4365,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,4366,0)
 ;;=I48.91^^30^271^6
 ;;^UTILITY(U,$J,358.3,4366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4366,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,4366,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,4366,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,4367,0)
 ;;=I48.92^^30^271^7
 ;;^UTILITY(U,$J,358.3,4367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4367,1,3,0)
 ;;=3^Atrial Flutter,Unspec
 ;;^UTILITY(U,$J,358.3,4367,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,4367,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,4368,0)
 ;;=I63.50^^30^271^9
 ;;^UTILITY(U,$J,358.3,4368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4368,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenos of Cereb Artery
 ;;^UTILITY(U,$J,358.3,4368,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,4368,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,4369,0)
 ;;=G45.9^^30^271^27
 ;;^UTILITY(U,$J,358.3,4369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4369,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attack,Unspec
 ;;^UTILITY(U,$J,358.3,4369,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,4369,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,4370,0)
 ;;=I73.9^^30^271^19
 ;;^UTILITY(U,$J,358.3,4370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4370,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,4370,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,4370,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,4371,0)
 ;;=I82.401^^30^271^3
 ;;^UTILITY(U,$J,358.3,4371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4371,1,3,0)
 ;;=3^Acute Embolism/Thrombos Deep Veins Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,4371,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,4371,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,4372,0)
 ;;=I82.402^^30^271^2
 ;;^UTILITY(U,$J,358.3,4372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4372,1,3,0)
 ;;=3^Acute Embolism/Thrombos Deep Veins Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,4372,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,4372,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,4373,0)
 ;;=I82.890^^30^271^4
 ;;^UTILITY(U,$J,358.3,4373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4373,1,3,0)
 ;;=3^Acute Embolism/Thrombosis of Specified Veins
 ;;^UTILITY(U,$J,358.3,4373,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,4373,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,4374,0)
 ;;=I82.91^^30^271^10
 ;;^UTILITY(U,$J,358.3,4374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4374,1,3,0)
 ;;=3^Chronic Embolism/Thrombosis Unspec Vein
 ;;^UTILITY(U,$J,358.3,4374,1,4,0)
 ;;=4^I82.91
 ;;^UTILITY(U,$J,358.3,4374,2)
 ;;=^5007941
 ;;^UTILITY(U,$J,358.3,4375,0)
 ;;=Z86.718^^30^271^22
 ;;^UTILITY(U,$J,358.3,4375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4375,1,3,0)
 ;;=3^Personal Hx of Venous Thrombosis/Embolism
 ;;^UTILITY(U,$J,358.3,4375,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,4375,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,4376,0)
 ;;=Z86.711^^30^271^21
 ;;^UTILITY(U,$J,358.3,4376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4376,1,3,0)
 ;;=3^Personal Hx of Pulmonary Embolism
 ;;^UTILITY(U,$J,358.3,4376,1,4,0)
 ;;=4^Z86.711
 ;;^UTILITY(U,$J,358.3,4376,2)
 ;;=^5063474
 ;;^UTILITY(U,$J,358.3,4377,0)
 ;;=Z86.79^^30^271^20
 ;;^UTILITY(U,$J,358.3,4377,1,0)
 ;;=^358.31IA^4^2
