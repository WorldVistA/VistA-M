IBDEI0BC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4822,1,3,0)
 ;;=3^Alcohol Dependence w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,4822,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,4822,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,4823,0)
 ;;=R56.9^^37^319^4
 ;;^UTILITY(U,$J,358.3,4823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4823,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,4823,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,4823,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,4824,0)
 ;;=K70.30^^37^319^3
 ;;^UTILITY(U,$J,358.3,4824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4824,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,4824,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,4824,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,4825,0)
 ;;=K72.90^^37^319^5
 ;;^UTILITY(U,$J,358.3,4825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4825,1,3,0)
 ;;=3^Hepatic Failure
 ;;^UTILITY(U,$J,358.3,4825,1,4,0)
 ;;=4^K72.90
 ;;^UTILITY(U,$J,358.3,4825,2)
 ;;=^5008809
 ;;^UTILITY(U,$J,358.3,4826,0)
 ;;=K72.91^^37^319^6
 ;;^UTILITY(U,$J,358.3,4826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4826,1,3,0)
 ;;=3^Hepatic Failure w/ Coma
 ;;^UTILITY(U,$J,358.3,4826,1,4,0)
 ;;=4^K72.91
 ;;^UTILITY(U,$J,358.3,4826,2)
 ;;=^5008810
 ;;^UTILITY(U,$J,358.3,4827,0)
 ;;=J96.00^^37^320^16
 ;;^UTILITY(U,$J,358.3,4827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4827,1,3,0)
 ;;=3^Respiratory Failure,Acute
 ;;^UTILITY(U,$J,358.3,4827,1,4,0)
 ;;=4^J96.00
 ;;^UTILITY(U,$J,358.3,4827,2)
 ;;=^5008347
 ;;^UTILITY(U,$J,358.3,4828,0)
 ;;=J96.90^^37^320^19
 ;;^UTILITY(U,$J,358.3,4828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4828,1,3,0)
 ;;=3^Respiratory Failure,Unspec
 ;;^UTILITY(U,$J,358.3,4828,1,4,0)
 ;;=4^J96.90
 ;;^UTILITY(U,$J,358.3,4828,2)
 ;;=^5008356
 ;;^UTILITY(U,$J,358.3,4829,0)
 ;;=J96.20^^37^320^17
 ;;^UTILITY(U,$J,358.3,4829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4829,1,3,0)
 ;;=3^Respiratory Failure,Acute/Chronic
 ;;^UTILITY(U,$J,358.3,4829,1,4,0)
 ;;=4^J96.20
 ;;^UTILITY(U,$J,358.3,4829,2)
 ;;=^5008353
 ;;^UTILITY(U,$J,358.3,4830,0)
 ;;=J95.822^^37^320^18
 ;;^UTILITY(U,$J,358.3,4830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4830,1,3,0)
 ;;=3^Respiratory Failure,Postprocedural,Acute/Chronic
 ;;^UTILITY(U,$J,358.3,4830,1,4,0)
 ;;=4^J95.822
 ;;^UTILITY(U,$J,358.3,4830,2)
 ;;=^5008339
 ;;^UTILITY(U,$J,358.3,4831,0)
 ;;=J44.1^^37^320^1
 ;;^UTILITY(U,$J,358.3,4831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4831,1,3,0)
 ;;=3^COPD w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,4831,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,4831,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,4832,0)
 ;;=J90.^^37^320^11
 ;;^UTILITY(U,$J,358.3,4832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4832,1,3,0)
 ;;=3^Pleural Effusion NEC
 ;;^UTILITY(U,$J,358.3,4832,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,4832,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,4833,0)
 ;;=J18.9^^37^320^13
 ;;^UTILITY(U,$J,358.3,4833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4833,1,3,0)
 ;;=3^Pneumonia,Organism Unspec
 ;;^UTILITY(U,$J,358.3,4833,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,4833,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,4834,0)
 ;;=J15.9^^37^320^12
 ;;^UTILITY(U,$J,358.3,4834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4834,1,3,0)
 ;;=3^Pneumonia,Bacterial
 ;;^UTILITY(U,$J,358.3,4834,1,4,0)
 ;;=4^J15.9
 ;;^UTILITY(U,$J,358.3,4834,2)
 ;;=^5008178
 ;;^UTILITY(U,$J,358.3,4835,0)
 ;;=J69.0^^37^320^14
 ;;^UTILITY(U,$J,358.3,4835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4835,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Food/Vomit
 ;;^UTILITY(U,$J,358.3,4835,1,4,0)
 ;;=4^J69.0
