IBDEI05J ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6859,1,4,0)
 ;;=4^J03.91
 ;;^UTILITY(U,$J,358.3,6859,2)
 ;;=^5008136
 ;;^UTILITY(U,$J,358.3,6860,0)
 ;;=J06.9^^26^404^2
 ;;^UTILITY(U,$J,358.3,6860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6860,1,3,0)
 ;;=3^Acute Upper Respiratory Infection,Unspec
 ;;^UTILITY(U,$J,358.3,6860,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,6860,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,6861,0)
 ;;=J02.0^^26^404^68
 ;;^UTILITY(U,$J,358.3,6861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6861,1,3,0)
 ;;=3^Pharyngitis,Streptococcal
 ;;^UTILITY(U,$J,358.3,6861,1,4,0)
 ;;=4^J02.0
 ;;^UTILITY(U,$J,358.3,6861,2)
 ;;=^114607
 ;;^UTILITY(U,$J,358.3,6862,0)
 ;;=J02.8^^26^404^67
 ;;^UTILITY(U,$J,358.3,6862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6862,1,3,0)
 ;;=3^Pharyngitis,Acute,d/t Oth Organisms
 ;;^UTILITY(U,$J,358.3,6862,1,4,0)
 ;;=4^J02.8
 ;;^UTILITY(U,$J,358.3,6862,2)
 ;;=^5008129
 ;;^UTILITY(U,$J,358.3,6863,0)
 ;;=J02.9^^26^404^66
 ;;^UTILITY(U,$J,358.3,6863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6863,1,3,0)
 ;;=3^Pharyngitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,6863,1,4,0)
 ;;=4^J02.9
 ;;^UTILITY(U,$J,358.3,6863,2)
 ;;=^5008130
 ;;^UTILITY(U,$J,358.3,6864,0)
 ;;=K70.0^^26^405^3
 ;;^UTILITY(U,$J,358.3,6864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6864,1,3,0)
 ;;=3^Alcoholic Fatty Liver
 ;;^UTILITY(U,$J,358.3,6864,1,4,0)
 ;;=4^K70.0
 ;;^UTILITY(U,$J,358.3,6864,2)
 ;;=^5008784
 ;;^UTILITY(U,$J,358.3,6865,0)
 ;;=K70.11^^26^405^7
 ;;^UTILITY(U,$J,358.3,6865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6865,1,3,0)
 ;;=3^Alcoholic Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,6865,1,4,0)
 ;;=4^K70.11
 ;;^UTILITY(U,$J,358.3,6865,2)
 ;;=^5008786
 ;;^UTILITY(U,$J,358.3,6866,0)
 ;;=K70.10^^26^405^8
 ;;^UTILITY(U,$J,358.3,6866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6866,1,3,0)
 ;;=3^Alcoholic Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,6866,1,4,0)
 ;;=4^K70.10
 ;;^UTILITY(U,$J,358.3,6866,2)
 ;;=^5008785
 ;;^UTILITY(U,$J,358.3,6867,0)
 ;;=K70.2^^26^405^4
 ;;^UTILITY(U,$J,358.3,6867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6867,1,3,0)
 ;;=3^Alcoholic Fibrosis & Sclerosis of Liver
 ;;^UTILITY(U,$J,358.3,6867,1,4,0)
 ;;=4^K70.2
 ;;^UTILITY(U,$J,358.3,6867,2)
 ;;=^5008787
 ;;^UTILITY(U,$J,358.3,6868,0)
 ;;=K70.30^^26^405^2
 ;;^UTILITY(U,$J,358.3,6868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6868,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,6868,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,6868,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,6869,0)
 ;;=K70.31^^26^405^1
 ;;^UTILITY(U,$J,358.3,6869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6869,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/ Ascites
 ;;^UTILITY(U,$J,358.3,6869,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,6869,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,6870,0)
 ;;=K70.9^^26^405^9
 ;;^UTILITY(U,$J,358.3,6870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6870,1,3,0)
 ;;=3^Alcoholic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6870,1,4,0)
 ;;=4^K70.9
 ;;^UTILITY(U,$J,358.3,6870,2)
 ;;=^5008792
 ;;^UTILITY(U,$J,358.3,6871,0)
 ;;=K70.40^^26^405^6
 ;;^UTILITY(U,$J,358.3,6871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6871,1,3,0)
 ;;=3^Alcoholic Hepatic Failure w/o Coma
 ;;^UTILITY(U,$J,358.3,6871,1,4,0)
 ;;=4^K70.40
 ;;^UTILITY(U,$J,358.3,6871,2)
 ;;=^5008790
 ;;^UTILITY(U,$J,358.3,6872,0)
 ;;=K70.41^^26^405^5
 ;;^UTILITY(U,$J,358.3,6872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6872,1,3,0)
 ;;=3^Alcoholic Hepatic Failure w/ Coma
 ;;^UTILITY(U,$J,358.3,6872,1,4,0)
 ;;=4^K70.41
 ;;^UTILITY(U,$J,358.3,6872,2)
 ;;=^5008791
 ;;^UTILITY(U,$J,358.3,6873,0)
 ;;=K73.0^^26^405^15
 ;;^UTILITY(U,$J,358.3,6873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6873,1,3,0)
 ;;=3^Hepatitis, Chronic Persistent NEC
 ;;^UTILITY(U,$J,358.3,6873,1,4,0)
 ;;=4^K73.0
 ;;^UTILITY(U,$J,358.3,6873,2)
 ;;=^5008811
 ;;^UTILITY(U,$J,358.3,6874,0)
 ;;=K74.0^^26^405^14
 ;;^UTILITY(U,$J,358.3,6874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6874,1,3,0)
 ;;=3^Hepatic Fibrosis
 ;;^UTILITY(U,$J,358.3,6874,1,4,0)
 ;;=4^K74.0
 ;;^UTILITY(U,$J,358.3,6874,2)
 ;;=^5008816
 ;;^UTILITY(U,$J,358.3,6875,0)
 ;;=K74.69^^26^405^10
 ;;^UTILITY(U,$J,358.3,6875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6875,1,3,0)
 ;;=3^Cirrhosis of Liver,Oth
 ;;^UTILITY(U,$J,358.3,6875,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,6875,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,6876,0)
 ;;=K74.60^^26^405^11
 ;;^UTILITY(U,$J,358.3,6876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6876,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,6876,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,6876,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,6877,0)
 ;;=K76.0^^26^405^12
 ;;^UTILITY(U,$J,358.3,6877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6877,1,3,0)
 ;;=3^Fatty Liver NEC
 ;;^UTILITY(U,$J,358.3,6877,1,4,0)
 ;;=4^K76.0
 ;;^UTILITY(U,$J,358.3,6877,2)
 ;;=^5008831
 ;;^UTILITY(U,$J,358.3,6878,0)
 ;;=K76.89^^26^405^18
 ;;^UTILITY(U,$J,358.3,6878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6878,1,3,0)
 ;;=3^Liver Disease NEC
 ;;^UTILITY(U,$J,358.3,6878,1,4,0)
 ;;=4^K76.89
 ;;^UTILITY(U,$J,358.3,6878,2)
 ;;=^5008835
 ;;^UTILITY(U,$J,358.3,6879,0)
 ;;=K71.6^^26^405^32
 ;;^UTILITY(U,$J,358.3,6879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6879,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,6879,1,4,0)
 ;;=4^K71.6
 ;;^UTILITY(U,$J,358.3,6879,2)
 ;;=^5008801
 ;;^UTILITY(U,$J,358.3,6880,0)
 ;;=K75.9^^26^405^17
 ;;^UTILITY(U,$J,358.3,6880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6880,1,3,0)
 ;;=3^Inflammatory Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6880,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,6880,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,6881,0)
 ;;=K71.0^^26^405^24
 ;;^UTILITY(U,$J,358.3,6881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6881,1,3,0)
 ;;=3^Toxic Liver Disease w/ Cholestasis
 ;;^UTILITY(U,$J,358.3,6881,1,4,0)
 ;;=4^K71.0
 ;;^UTILITY(U,$J,358.3,6881,2)
 ;;=^5008793
 ;;^UTILITY(U,$J,358.3,6882,0)
 ;;=K71.10^^26^405^30
 ;;^UTILITY(U,$J,358.3,6882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6882,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/o Coma
 ;;^UTILITY(U,$J,358.3,6882,1,4,0)
 ;;=4^K71.10
 ;;^UTILITY(U,$J,358.3,6882,2)
 ;;=^5008794
 ;;^UTILITY(U,$J,358.3,6883,0)
 ;;=K71.11^^26^405^31
 ;;^UTILITY(U,$J,358.3,6883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6883,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/ Coma
 ;;^UTILITY(U,$J,358.3,6883,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,6883,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,6884,0)
 ;;=K71.2^^26^405^23
 ;;^UTILITY(U,$J,358.3,6884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6884,1,3,0)
 ;;=3^Toxic Liver Disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,6884,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,6884,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,6885,0)
 ;;=K71.3^^26^405^28
 ;;^UTILITY(U,$J,358.3,6885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6885,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,6885,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,6885,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,6886,0)
 ;;=K71.4^^26^405^27
 ;;^UTILITY(U,$J,358.3,6886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6886,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,6886,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,6886,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,6887,0)
 ;;=K75.81^^26^405^19
 ;;^UTILITY(U,$J,358.3,6887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6887,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,6887,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,6887,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,6888,0)
 ;;=K75.89^^26^405^16
 ;;^UTILITY(U,$J,358.3,6888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6888,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,6888,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,6888,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,6889,0)
 ;;=K76.4^^26^405^21
 ;;^UTILITY(U,$J,358.3,6889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6889,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,6889,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,6889,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,6890,0)
 ;;=K71.50^^26^405^25
 ;;^UTILITY(U,$J,358.3,6890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6890,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,6890,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,6890,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,6891,0)
 ;;=K71.51^^26^405^26
 ;;^UTILITY(U,$J,358.3,6891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6891,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,6891,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,6891,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,6892,0)
 ;;=K71.7^^26^405^29
 ;;^UTILITY(U,$J,358.3,6892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6892,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,6892,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,6892,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,6893,0)
 ;;=K71.8^^26^405^33
 ;;^UTILITY(U,$J,358.3,6893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6893,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,6893,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,6893,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,6894,0)
 ;;=K71.9^^26^405^34
 ;;^UTILITY(U,$J,358.3,6894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6894,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6894,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,6894,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,6895,0)
 ;;=K75.2^^26^405^20
 ;;^UTILITY(U,$J,358.3,6895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6895,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,6895,1,4,0)
 ;;=4^K75.2
