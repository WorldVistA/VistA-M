IBDEI015 ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,887,2)
 ;;=Acute MI, Inferopostior, Initial^269651
 ;;^UTILITY(U,$J,358.3,888,0)
 ;;=410.32^^16^73^8
 ;;^UTILITY(U,$J,358.3,888,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,888,1,4,0)
 ;;=4^410.32
 ;;^UTILITY(U,$J,358.3,888,1,5,0)
 ;;=5^Acute MI, Inferoposterior, Subsequent
 ;;^UTILITY(U,$J,358.3,888,2)
 ;;=Acute MI, Inferoposterior, Subsequent^269652
 ;;^UTILITY(U,$J,358.3,889,0)
 ;;=410.41^^16^73^9
 ;;^UTILITY(U,$J,358.3,889,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,889,1,4,0)
 ;;=4^410.41
 ;;^UTILITY(U,$J,358.3,889,1,5,0)
 ;;=5^Acute MI, Inferorposterior, Initial
 ;;^UTILITY(U,$J,358.3,889,2)
 ;;=Acute MI, Inferorposterior, Initial^269655
 ;;^UTILITY(U,$J,358.3,890,0)
 ;;=410.42^^16^73^10
 ;;^UTILITY(U,$J,358.3,890,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,890,1,4,0)
 ;;=4^410.42
 ;;^UTILITY(U,$J,358.3,890,1,5,0)
 ;;=5^Acute MI Inferior, Subsequent
 ;;^UTILITY(U,$J,358.3,890,2)
 ;;=Acute MI Inferior, Subsequent^269656
 ;;^UTILITY(U,$J,358.3,891,0)
 ;;=410.51^^16^73^11
 ;;^UTILITY(U,$J,358.3,891,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,891,1,4,0)
 ;;=4^410.51
 ;;^UTILITY(U,$J,358.3,891,1,5,0)
 ;;=5^Acute MI, Lateral, Initial
 ;;^UTILITY(U,$J,358.3,891,2)
 ;;=Acute MI, Lateral, Initial^269659
 ;;^UTILITY(U,$J,358.3,892,0)
 ;;=410.52^^16^73^12
 ;;^UTILITY(U,$J,358.3,892,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,892,1,4,0)
 ;;=4^410.52
 ;;^UTILITY(U,$J,358.3,892,1,5,0)
 ;;=5^Acute MI, Lateral, Subsequent
 ;;^UTILITY(U,$J,358.3,892,2)
 ;;=Acute MI, Lateral, Subsequent^269660
 ;;^UTILITY(U,$J,358.3,893,0)
 ;;=410.61^^16^73^17
 ;;^UTILITY(U,$J,358.3,893,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,893,1,4,0)
 ;;=4^410.61
 ;;^UTILITY(U,$J,358.3,893,1,5,0)
 ;;=5^AMI Post, Initial
 ;;^UTILITY(U,$J,358.3,893,2)
 ;;=^269663
 ;;^UTILITY(U,$J,358.3,894,0)
 ;;=410.62^^16^73^18
 ;;^UTILITY(U,$J,358.3,894,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,894,1,4,0)
 ;;=4^410.62
 ;;^UTILITY(U,$J,358.3,894,1,5,0)
 ;;=5^AMI Post, Subsequent
 ;;^UTILITY(U,$J,358.3,894,2)
 ;;=^269664
 ;;^UTILITY(U,$J,358.3,895,0)
 ;;=410.71^^16^73^13
 ;;^UTILITY(U,$J,358.3,895,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,895,1,4,0)
 ;;=4^410.71
 ;;^UTILITY(U,$J,358.3,895,1,5,0)
 ;;=5^Acute MI, Non Q Wave, Initial
 ;;^UTILITY(U,$J,358.3,895,2)
 ;;=Acute MI, Non Q Wave, Initial^269667
 ;;^UTILITY(U,$J,358.3,896,0)
 ;;=410.72^^16^73^14
 ;;^UTILITY(U,$J,358.3,896,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,896,1,4,0)
 ;;=4^410.72
 ;;^UTILITY(U,$J,358.3,896,1,5,0)
 ;;=5^Acute MI, Non-Q Wave, Subsequent
 ;;^UTILITY(U,$J,358.3,896,2)
 ;;=Acute MI, Non-Q Wave, Subsequent^269668
 ;;^UTILITY(U,$J,358.3,897,0)
 ;;=410.81^^16^73^15
 ;;^UTILITY(U,$J,358.3,897,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,897,1,4,0)
 ;;=4^410.81
 ;;^UTILITY(U,$J,358.3,897,1,5,0)
 ;;=5^Acute MI, Other, Initial
 ;;^UTILITY(U,$J,358.3,897,2)
 ;;=Acute MI, Other, Initial^269671
 ;;^UTILITY(U,$J,358.3,898,0)
 ;;=410.82^^16^73^16
 ;;^UTILITY(U,$J,358.3,898,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,898,1,4,0)
 ;;=4^410.82
 ;;^UTILITY(U,$J,358.3,898,1,5,0)
 ;;=5^Acute MI, Subseqent
 ;;^UTILITY(U,$J,358.3,898,2)
 ;;=Acute MI, Subseqent^269672
 ;;^UTILITY(U,$J,358.3,899,0)
 ;;=410.91^^16^73^19
 ;;^UTILITY(U,$J,358.3,899,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,899,1,4,0)
 ;;=4^410.91
 ;;^UTILITY(U,$J,358.3,899,1,5,0)
 ;;=5^AMI Unspec
 ;;^UTILITY(U,$J,358.3,899,2)
 ;;=^269674
 ;;^UTILITY(U,$J,358.3,900,0)
 ;;=410.92^^16^73^20
 ;;^UTILITY(U,$J,358.3,900,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,900,1,4,0)
 ;;=4^410.92
 ;;^UTILITY(U,$J,358.3,900,1,5,0)
 ;;=5^AMI Unspec, Subsequent
 ;;^UTILITY(U,$J,358.3,900,2)
 ;;=^269675
 ;;^UTILITY(U,$J,358.3,901,0)
 ;;=428.0^^16^74^1
 ;;^UTILITY(U,$J,358.3,901,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,901,1,4,0)
 ;;=4^428.0
 ;;^UTILITY(U,$J,358.3,901,1,5,0)
 ;;=5^CHF
 ;;^UTILITY(U,$J,358.3,901,2)
 ;;=^54758
 ;;^UTILITY(U,$J,358.3,902,0)
 ;;=428.1^^16^74^18
 ;;^UTILITY(U,$J,358.3,902,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,902,1,4,0)
 ;;=4^428.1
 ;;^UTILITY(U,$J,358.3,902,1,5,0)
 ;;=5^Left Heart Failure
 ;;^UTILITY(U,$J,358.3,902,2)
 ;;=Left Heart Failure^68721
 ;;^UTILITY(U,$J,358.3,903,0)
 ;;=425.4^^16^74^3
 ;;^UTILITY(U,$J,358.3,903,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,903,1,4,0)
 ;;=4^425.4
 ;;^UTILITY(U,$J,358.3,903,1,5,0)
 ;;=5^Cardiomyopa Other Prim
 ;;^UTILITY(U,$J,358.3,903,2)
 ;;=^87808
 ;;^UTILITY(U,$J,358.3,904,0)
 ;;=425.5^^16^74^4
 ;;^UTILITY(U,$J,358.3,904,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,904,1,4,0)
 ;;=4^425.5
 ;;^UTILITY(U,$J,358.3,904,1,5,0)
 ;;=5^Cardiomyopathy Alcohol
 ;;^UTILITY(U,$J,358.3,904,2)
 ;;=^19623
 ;;^UTILITY(U,$J,358.3,905,0)
 ;;=425.9^^16^74^6
 ;;^UTILITY(U,$J,358.3,905,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,905,1,4,0)
 ;;=4^425.9
 ;;^UTILITY(U,$J,358.3,905,1,5,0)
 ;;=5^Cardiomyopathy, Sec UNS
 ;;^UTILITY(U,$J,358.3,905,2)
 ;;=^265123
 ;;^UTILITY(U,$J,358.3,906,0)
 ;;=429.3^^16^74^2
 ;;^UTILITY(U,$J,358.3,906,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,906,1,4,0)
 ;;=4^429.3
 ;;^UTILITY(U,$J,358.3,906,1,5,0)
 ;;=5^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,906,2)
 ;;=^54748
 ;;^UTILITY(U,$J,358.3,907,0)
 ;;=429.4^^16^74^12
 ;;^UTILITY(U,$J,358.3,907,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,907,1,4,0)
 ;;=4^429.4
 ;;^UTILITY(U,$J,358.3,907,1,5,0)
 ;;=5^Heart Fail Post CV Surg
 ;;^UTILITY(U,$J,358.3,907,2)
 ;;=^48524
 ;;^UTILITY(U,$J,358.3,908,0)
 ;;=415.0^^16^74^7
 ;;^UTILITY(U,$J,358.3,908,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,908,1,4,0)
 ;;=4^415.0
 ;;^UTILITY(U,$J,358.3,908,1,5,0)
 ;;=5^Cor Pulmonale, Acute
 ;;^UTILITY(U,$J,358.3,908,2)
 ;;=^269683
 ;;^UTILITY(U,$J,358.3,909,0)
 ;;=415.11^^16^74^20
 ;;^UTILITY(U,$J,358.3,909,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,909,1,4,0)
 ;;=4^415.11
 ;;^UTILITY(U,$J,358.3,909,1,5,0)
 ;;=5^Pulm Embolism, Iatrogenic
 ;;^UTILITY(U,$J,358.3,909,2)
 ;;=Pulm Embolism, Iatrogenic^303284
 ;;^UTILITY(U,$J,358.3,910,0)
 ;;=415.19^^16^74^21
 ;;^UTILITY(U,$J,358.3,910,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,910,1,4,0)
 ;;=4^415.19
 ;;^UTILITY(U,$J,358.3,910,1,5,0)
 ;;=5^Pulm Embolism, Other
 ;;^UTILITY(U,$J,358.3,910,2)
 ;;=Pulm Embolism, Other^303285
 ;;^UTILITY(U,$J,358.3,911,0)
 ;;=416.0^^16^74^10
 ;;^UTILITY(U,$J,358.3,911,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,911,1,4,0)
 ;;=4^416.0
 ;;^UTILITY(U,$J,358.3,911,1,5,0)
 ;;=5^HTN Primary Pulmonary
 ;;^UTILITY(U,$J,358.3,911,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,912,0)
 ;;=416.1^^16^74^17
 ;;^UTILITY(U,$J,358.3,912,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,912,1,4,0)
 ;;=4^416.1
 ;;^UTILITY(U,$J,358.3,912,1,5,0)
 ;;=5^Kyphoscoliotic Heart
 ;;^UTILITY(U,$J,358.3,912,2)
 ;;=^265120
 ;;^UTILITY(U,$J,358.3,913,0)
 ;;=416.8^^16^74^11
 ;;^UTILITY(U,$J,358.3,913,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,913,1,4,0)
 ;;=4^416.8
 ;;^UTILITY(U,$J,358.3,913,1,5,0)
 ;;=5^HTN Sec Pulmonary
 ;;^UTILITY(U,$J,358.3,913,2)
 ;;=^269684
 ;;^UTILITY(U,$J,358.3,914,0)
 ;;=416.9^^16^74^8
 ;;^UTILITY(U,$J,358.3,914,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,914,1,4,0)
 ;;=4^416.9
 ;;^UTILITY(U,$J,358.3,914,1,5,0)
 ;;=5^Cor Pulmonale, Chronic
 ;;^UTILITY(U,$J,358.3,914,2)
 ;;=^24430
 ;;^UTILITY(U,$J,358.3,915,0)
 ;;=996.83^^16^74^9
 ;;^UTILITY(U,$J,358.3,915,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,915,1,4,0)
 ;;=4^996.83
 ;;^UTILITY(U,$J,358.3,915,1,5,0)
 ;;=5^HRT Transplant Comp
 ;;^UTILITY(U,$J,358.3,915,2)
 ;;=^276305
 ;;^UTILITY(U,$J,358.3,916,0)
 ;;=996.84^^16^74^19
 ;;^UTILITY(U,$J,358.3,916,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,916,1,4,0)
 ;;=4^996.84
 ;;^UTILITY(U,$J,358.3,916,1,5,0)
 ;;=5^Lung Transplant Comp
 ;;^UTILITY(U,$J,358.3,916,2)
 ;;=^276306
 ;;^UTILITY(U,$J,358.3,917,0)
 ;;=V42.1^^16^74^16
 ;;^UTILITY(U,$J,358.3,917,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,917,1,4,0)
 ;;=4^V42.1
 ;;^UTILITY(U,$J,358.3,917,1,5,0)
 ;;=5^Heart Transplant S/P
 ;;^UTILITY(U,$J,358.3,917,2)
 ;;=^54832
 ;;^UTILITY(U,$J,358.3,918,0)
 ;;=428.20^^16^74^14
 ;;^UTILITY(U,$J,358.3,918,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,918,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,918,1,5,0)
 ;;=5^Heart Failure, Systolic
 ;;^UTILITY(U,$J,358.3,918,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,919,0)
 ;;=428.30^^16^74^13
 ;;^UTILITY(U,$J,358.3,919,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,919,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,919,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,919,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,920,0)
 ;;=428.40^^16^74^15
 ;;^UTILITY(U,$J,358.3,920,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,920,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,920,1,5,0)
 ;;=5^Heart Failure,Diast/Syst
 ;;^UTILITY(U,$J,358.3,920,2)
 ;;=Heart Failure, Diastolic/Systolic^328596
 ;;^UTILITY(U,$J,358.3,921,0)
 ;;=425.11^^16^74^5
 ;;^UTILITY(U,$J,358.3,921,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,921,1,4,0)
 ;;=4^425.11
 ;;^UTILITY(U,$J,358.3,921,1,5,0)
 ;;=5^Cardiomyopathy, Hypertrophic Obstructive
 ;;^UTILITY(U,$J,358.3,921,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,922,0)
 ;;=426.0^^16^75^5
 ;;^UTILITY(U,$J,358.3,922,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,922,1,4,0)
 ;;=4^426.0
 ;;^UTILITY(U,$J,358.3,922,1,5,0)
 ;;=5^AV Block, Complete
 ;;^UTILITY(U,$J,358.3,922,2)
 ;;=^259621
 ;;^UTILITY(U,$J,358.3,923,0)
 ;;=426.10^^16^75^6
 ;;^UTILITY(U,$J,358.3,923,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,923,1,4,0)
 ;;=4^426.10
 ;;^UTILITY(U,$J,358.3,923,1,5,0)
 ;;=5^AV Block, Incomplete
 ;;^UTILITY(U,$J,358.3,923,2)
 ;;=^11396
 ;;^UTILITY(U,$J,358.3,924,0)
 ;;=426.11^^16^75^4
 ;;^UTILITY(U,$J,358.3,924,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,924,1,4,0)
 ;;=4^426.11
 ;;^UTILITY(U,$J,358.3,924,1,5,0)
 ;;=5^AV Block, 1st Degree
 ;;^UTILITY(U,$J,358.3,924,2)
 ;;=^186726
 ;;^UTILITY(U,$J,358.3,925,0)
 ;;=426.12^^16^75^8
