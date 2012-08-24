IBDEI00T ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,606,2)
 ;;=Acute MI, Inferoposterior, Subsequent^269652
 ;;^UTILITY(U,$J,358.3,607,0)
 ;;=410.41^^10^52^9
 ;;^UTILITY(U,$J,358.3,607,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,607,1,4,0)
 ;;=4^410.41
 ;;^UTILITY(U,$J,358.3,607,1,5,0)
 ;;=5^Acute MI, Inferorposterior, Initial
 ;;^UTILITY(U,$J,358.3,607,2)
 ;;=Acute MI, Inferorposterior, Initial^269655
 ;;^UTILITY(U,$J,358.3,608,0)
 ;;=410.42^^10^52^10
 ;;^UTILITY(U,$J,358.3,608,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,608,1,4,0)
 ;;=4^410.42
 ;;^UTILITY(U,$J,358.3,608,1,5,0)
 ;;=5^Acute MI Inferior, Subsequent
 ;;^UTILITY(U,$J,358.3,608,2)
 ;;=Acute MI Inferior, Subsequent^269656
 ;;^UTILITY(U,$J,358.3,609,0)
 ;;=410.51^^10^52^11
 ;;^UTILITY(U,$J,358.3,609,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,609,1,4,0)
 ;;=4^410.51
 ;;^UTILITY(U,$J,358.3,609,1,5,0)
 ;;=5^Acute MI, Lateral, Initial
 ;;^UTILITY(U,$J,358.3,609,2)
 ;;=Acute MI, Lateral, Initial^269659
 ;;^UTILITY(U,$J,358.3,610,0)
 ;;=410.52^^10^52^12
 ;;^UTILITY(U,$J,358.3,610,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,610,1,4,0)
 ;;=4^410.52
 ;;^UTILITY(U,$J,358.3,610,1,5,0)
 ;;=5^Acute MI, Lateral, Subsequent
 ;;^UTILITY(U,$J,358.3,610,2)
 ;;=Acute MI, Lateral, Subsequent^269660
 ;;^UTILITY(U,$J,358.3,611,0)
 ;;=410.61^^10^52^17
 ;;^UTILITY(U,$J,358.3,611,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,611,1,4,0)
 ;;=4^410.61
 ;;^UTILITY(U,$J,358.3,611,1,5,0)
 ;;=5^AMI Post, Initial
 ;;^UTILITY(U,$J,358.3,611,2)
 ;;=^269663
 ;;^UTILITY(U,$J,358.3,612,0)
 ;;=410.62^^10^52^18
 ;;^UTILITY(U,$J,358.3,612,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,612,1,4,0)
 ;;=4^410.62
 ;;^UTILITY(U,$J,358.3,612,1,5,0)
 ;;=5^AMI Post, Subsequent
 ;;^UTILITY(U,$J,358.3,612,2)
 ;;=^269664
 ;;^UTILITY(U,$J,358.3,613,0)
 ;;=410.71^^10^52^13
 ;;^UTILITY(U,$J,358.3,613,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,613,1,4,0)
 ;;=4^410.71
 ;;^UTILITY(U,$J,358.3,613,1,5,0)
 ;;=5^Acute MI, Non Q Wave, Initial
 ;;^UTILITY(U,$J,358.3,613,2)
 ;;=Acute MI, Non Q Wave, Initial^269667
 ;;^UTILITY(U,$J,358.3,614,0)
 ;;=410.72^^10^52^14
 ;;^UTILITY(U,$J,358.3,614,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,614,1,4,0)
 ;;=4^410.72
 ;;^UTILITY(U,$J,358.3,614,1,5,0)
 ;;=5^Acute MI, Non-Q Wave, Subsequent
 ;;^UTILITY(U,$J,358.3,614,2)
 ;;=Acute MI, Non-Q Wave, Subsequent^269668
 ;;^UTILITY(U,$J,358.3,615,0)
 ;;=410.81^^10^52^15
 ;;^UTILITY(U,$J,358.3,615,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,615,1,4,0)
 ;;=4^410.81
 ;;^UTILITY(U,$J,358.3,615,1,5,0)
 ;;=5^Acute MI, Other, Initial
 ;;^UTILITY(U,$J,358.3,615,2)
 ;;=Acute MI, Other, Initial^269671
 ;;^UTILITY(U,$J,358.3,616,0)
 ;;=410.82^^10^52^16
 ;;^UTILITY(U,$J,358.3,616,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,616,1,4,0)
 ;;=4^410.82
 ;;^UTILITY(U,$J,358.3,616,1,5,0)
 ;;=5^Acute MI, Subseqent
 ;;^UTILITY(U,$J,358.3,616,2)
 ;;=Acute MI, Subseqent^269672
 ;;^UTILITY(U,$J,358.3,617,0)
 ;;=410.91^^10^52^19
 ;;^UTILITY(U,$J,358.3,617,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,617,1,4,0)
 ;;=4^410.91
 ;;^UTILITY(U,$J,358.3,617,1,5,0)
 ;;=5^AMI Unspec
 ;;^UTILITY(U,$J,358.3,617,2)
 ;;=^269674
 ;;^UTILITY(U,$J,358.3,618,0)
 ;;=410.92^^10^52^20
 ;;^UTILITY(U,$J,358.3,618,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,618,1,4,0)
 ;;=4^410.92
 ;;^UTILITY(U,$J,358.3,618,1,5,0)
 ;;=5^AMI Unspec, Subsequent
 ;;^UTILITY(U,$J,358.3,618,2)
 ;;=^269675
 ;;^UTILITY(U,$J,358.3,619,0)
 ;;=428.0^^10^53^1
 ;;^UTILITY(U,$J,358.3,619,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,619,1,4,0)
 ;;=4^428.0
 ;;^UTILITY(U,$J,358.3,619,1,5,0)
 ;;=5^CHF
 ;;^UTILITY(U,$J,358.3,619,2)
 ;;=^54758
 ;;^UTILITY(U,$J,358.3,620,0)
 ;;=428.1^^10^53^18
 ;;^UTILITY(U,$J,358.3,620,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,620,1,4,0)
 ;;=4^428.1
 ;;^UTILITY(U,$J,358.3,620,1,5,0)
 ;;=5^Left Heart Failure
 ;;^UTILITY(U,$J,358.3,620,2)
 ;;=Left Heart Failure^68721
 ;;^UTILITY(U,$J,358.3,621,0)
 ;;=425.4^^10^53^3
 ;;^UTILITY(U,$J,358.3,621,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,621,1,4,0)
 ;;=4^425.4
 ;;^UTILITY(U,$J,358.3,621,1,5,0)
 ;;=5^Cardiomyopa Other Prim
 ;;^UTILITY(U,$J,358.3,621,2)
 ;;=^87808
 ;;^UTILITY(U,$J,358.3,622,0)
 ;;=425.5^^10^53^4
 ;;^UTILITY(U,$J,358.3,622,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,622,1,4,0)
 ;;=4^425.5
 ;;^UTILITY(U,$J,358.3,622,1,5,0)
 ;;=5^Cardiomyopathy Alcohol
 ;;^UTILITY(U,$J,358.3,622,2)
 ;;=^19623
 ;;^UTILITY(U,$J,358.3,623,0)
 ;;=425.9^^10^53^6
 ;;^UTILITY(U,$J,358.3,623,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,623,1,4,0)
 ;;=4^425.9
 ;;^UTILITY(U,$J,358.3,623,1,5,0)
 ;;=5^Cardiomyopathy, Sec UNS
 ;;^UTILITY(U,$J,358.3,623,2)
 ;;=^265123
 ;;^UTILITY(U,$J,358.3,624,0)
 ;;=429.3^^10^53^2
 ;;^UTILITY(U,$J,358.3,624,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,624,1,4,0)
 ;;=4^429.3
 ;;^UTILITY(U,$J,358.3,624,1,5,0)
 ;;=5^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,624,2)
 ;;=^54748
 ;;^UTILITY(U,$J,358.3,625,0)
 ;;=429.4^^10^53^12
 ;;^UTILITY(U,$J,358.3,625,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,625,1,4,0)
 ;;=4^429.4
 ;;^UTILITY(U,$J,358.3,625,1,5,0)
 ;;=5^Heart Fail Post CV Surg
 ;;^UTILITY(U,$J,358.3,625,2)
 ;;=^48524
 ;;^UTILITY(U,$J,358.3,626,0)
 ;;=415.0^^10^53^7
 ;;^UTILITY(U,$J,358.3,626,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,626,1,4,0)
 ;;=4^415.0
 ;;^UTILITY(U,$J,358.3,626,1,5,0)
 ;;=5^Cor Pulmonale, Acute
 ;;^UTILITY(U,$J,358.3,626,2)
 ;;=^269683
 ;;^UTILITY(U,$J,358.3,627,0)
 ;;=415.11^^10^53^20
 ;;^UTILITY(U,$J,358.3,627,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,627,1,4,0)
 ;;=4^415.11
 ;;^UTILITY(U,$J,358.3,627,1,5,0)
 ;;=5^Pulm Embolism, Iatrogenic
 ;;^UTILITY(U,$J,358.3,627,2)
 ;;=Pulm Embolism, Iatrogenic^303284
 ;;^UTILITY(U,$J,358.3,628,0)
 ;;=415.19^^10^53^21
 ;;^UTILITY(U,$J,358.3,628,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,628,1,4,0)
 ;;=4^415.19
 ;;^UTILITY(U,$J,358.3,628,1,5,0)
 ;;=5^Pulm Embolism, Other
 ;;^UTILITY(U,$J,358.3,628,2)
 ;;=Pulm Embolism, Other^303285
 ;;^UTILITY(U,$J,358.3,629,0)
 ;;=416.0^^10^53^10
 ;;^UTILITY(U,$J,358.3,629,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,629,1,4,0)
 ;;=4^416.0
 ;;^UTILITY(U,$J,358.3,629,1,5,0)
 ;;=5^HTN Primary Pulmonary
 ;;^UTILITY(U,$J,358.3,629,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,630,0)
 ;;=416.1^^10^53^17
 ;;^UTILITY(U,$J,358.3,630,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,630,1,4,0)
 ;;=4^416.1
 ;;^UTILITY(U,$J,358.3,630,1,5,0)
 ;;=5^Kyphoscoliotic Heart
 ;;^UTILITY(U,$J,358.3,630,2)
 ;;=^265120
 ;;^UTILITY(U,$J,358.3,631,0)
 ;;=416.8^^10^53^11
 ;;^UTILITY(U,$J,358.3,631,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,631,1,4,0)
 ;;=4^416.8
 ;;^UTILITY(U,$J,358.3,631,1,5,0)
 ;;=5^HTN Sec Pulmonary
 ;;^UTILITY(U,$J,358.3,631,2)
 ;;=^269684
 ;;^UTILITY(U,$J,358.3,632,0)
 ;;=416.9^^10^53^8
 ;;^UTILITY(U,$J,358.3,632,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,632,1,4,0)
 ;;=4^416.9
 ;;^UTILITY(U,$J,358.3,632,1,5,0)
 ;;=5^Cor Pulmonale, Chronic
 ;;^UTILITY(U,$J,358.3,632,2)
 ;;=^24430
 ;;^UTILITY(U,$J,358.3,633,0)
 ;;=996.83^^10^53^9
 ;;^UTILITY(U,$J,358.3,633,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,633,1,4,0)
 ;;=4^996.83
 ;;^UTILITY(U,$J,358.3,633,1,5,0)
 ;;=5^HRT Transplant Comp
 ;;^UTILITY(U,$J,358.3,633,2)
 ;;=^276305
 ;;^UTILITY(U,$J,358.3,634,0)
 ;;=996.84^^10^53^19
 ;;^UTILITY(U,$J,358.3,634,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,634,1,4,0)
 ;;=4^996.84
 ;;^UTILITY(U,$J,358.3,634,1,5,0)
 ;;=5^Lung Transplant Comp
 ;;^UTILITY(U,$J,358.3,634,2)
 ;;=^276306
 ;;^UTILITY(U,$J,358.3,635,0)
 ;;=V42.1^^10^53^16
 ;;^UTILITY(U,$J,358.3,635,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,635,1,4,0)
 ;;=4^V42.1
 ;;^UTILITY(U,$J,358.3,635,1,5,0)
 ;;=5^Heart Transplant S/P
 ;;^UTILITY(U,$J,358.3,635,2)
 ;;=^54832
 ;;^UTILITY(U,$J,358.3,636,0)
 ;;=428.20^^10^53^14
 ;;^UTILITY(U,$J,358.3,636,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,636,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,636,1,5,0)
 ;;=5^Heart Failure, Systolic
 ;;^UTILITY(U,$J,358.3,636,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,637,0)
 ;;=428.30^^10^53^13
 ;;^UTILITY(U,$J,358.3,637,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,637,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,637,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,637,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,638,0)
 ;;=428.40^^10^53^15
 ;;^UTILITY(U,$J,358.3,638,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,638,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,638,1,5,0)
 ;;=5^Heart Failure,Diast/Syst
 ;;^UTILITY(U,$J,358.3,638,2)
 ;;=Heart Failure, Diastolic/Systolic^328596
 ;;^UTILITY(U,$J,358.3,639,0)
 ;;=425.11^^10^53^5
 ;;^UTILITY(U,$J,358.3,639,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,639,1,4,0)
 ;;=4^425.11
 ;;^UTILITY(U,$J,358.3,639,1,5,0)
 ;;=5^Cardiomyopathy, Hypertrophic Obstructive
 ;;^UTILITY(U,$J,358.3,639,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,640,0)
 ;;=426.0^^10^54^5
 ;;^UTILITY(U,$J,358.3,640,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,640,1,4,0)
 ;;=4^426.0
 ;;^UTILITY(U,$J,358.3,640,1,5,0)
 ;;=5^AV Block, Complete
 ;;^UTILITY(U,$J,358.3,640,2)
 ;;=^259621
 ;;^UTILITY(U,$J,358.3,641,0)
 ;;=426.10^^10^54^6
 ;;^UTILITY(U,$J,358.3,641,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,641,1,4,0)
 ;;=4^426.10
 ;;^UTILITY(U,$J,358.3,641,1,5,0)
 ;;=5^AV Block, Incomplete
 ;;^UTILITY(U,$J,358.3,641,2)
 ;;=^11396
 ;;^UTILITY(U,$J,358.3,642,0)
 ;;=426.11^^10^54^4
 ;;^UTILITY(U,$J,358.3,642,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,642,1,4,0)
 ;;=4^426.11
 ;;^UTILITY(U,$J,358.3,642,1,5,0)
 ;;=5^AV Block, 1st Degree
 ;;^UTILITY(U,$J,358.3,642,2)
 ;;=^186726
 ;;^UTILITY(U,$J,358.3,643,0)
 ;;=426.12^^10^54^8
 ;;^UTILITY(U,$J,358.3,643,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,643,1,4,0)
 ;;=4^426.12
 ;;^UTILITY(U,$J,358.3,643,1,5,0)
 ;;=5^AV block, Type II
 ;;^UTILITY(U,$J,358.3,643,2)
 ;;=^269719
 ;;^UTILITY(U,$J,358.3,644,0)
 ;;=426.13^^10^54^7
 ;;^UTILITY(U,$J,358.3,644,1,0)
 ;;=^358.31IA^5^2
