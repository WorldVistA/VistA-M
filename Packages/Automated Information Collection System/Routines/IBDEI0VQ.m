IBDEI0VQ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41670,0)
 ;;=C64.2^^124^1800^6
 ;;^UTILITY(U,$J,358.3,41670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41670,1,3,0)
 ;;=3^Malignant neoplasm of left kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,41670,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,41670,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,41671,0)
 ;;=N18.6^^124^1800^3
 ;;^UTILITY(U,$J,358.3,41671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41671,1,3,0)
 ;;=3^ESRD
 ;;^UTILITY(U,$J,358.3,41671,1,4,0)
 ;;=4^N18.6
 ;;^UTILITY(U,$J,358.3,41671,2)
 ;;=^303986
 ;;^UTILITY(U,$J,358.3,41672,0)
 ;;=B17.11^^124^1801^2
 ;;^UTILITY(U,$J,358.3,41672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41672,1,3,0)
 ;;=3^Acute hepatitis C with hepatic coma
 ;;^UTILITY(U,$J,358.3,41672,1,4,0)
 ;;=4^B17.11
 ;;^UTILITY(U,$J,358.3,41672,2)
 ;;=^331777
 ;;^UTILITY(U,$J,358.3,41673,0)
 ;;=B18.2^^124^1801^9
 ;;^UTILITY(U,$J,358.3,41673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41673,1,3,0)
 ;;=3^Chronic viral hepatitis C
 ;;^UTILITY(U,$J,358.3,41673,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,41673,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,41674,0)
 ;;=B17.10^^124^1801^3
 ;;^UTILITY(U,$J,358.3,41674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41674,1,3,0)
 ;;=3^Acute hepatitis C without hepatic coma
 ;;^UTILITY(U,$J,358.3,41674,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,41674,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,41675,0)
 ;;=B19.20^^124^1801^23
 ;;^UTILITY(U,$J,358.3,41675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41675,1,3,0)
 ;;=3^Viral hepatitis C without hepatic coma,Unspec
 ;;^UTILITY(U,$J,358.3,41675,1,4,0)
 ;;=4^B19.20
 ;;^UTILITY(U,$J,358.3,41675,2)
 ;;=^331436
 ;;^UTILITY(U,$J,358.3,41676,0)
 ;;=B19.21^^124^1801^22
 ;;^UTILITY(U,$J,358.3,41676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41676,1,3,0)
 ;;=3^Viral hepatitis C with hepatic coma,Unspec
 ;;^UTILITY(U,$J,358.3,41676,1,4,0)
 ;;=4^B19.21
 ;;^UTILITY(U,$J,358.3,41676,2)
 ;;=^331437
 ;;^UTILITY(U,$J,358.3,41677,0)
 ;;=C22.0^^124^1801^15
 ;;^UTILITY(U,$J,358.3,41677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41677,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,41677,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,41677,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,41678,0)
 ;;=C22.7^^124^1801^7
 ;;^UTILITY(U,$J,358.3,41678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41678,1,3,0)
 ;;=3^Carcinomas of liver NEC
 ;;^UTILITY(U,$J,358.3,41678,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,41678,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,41679,0)
 ;;=C22.8^^124^1801^18
 ;;^UTILITY(U,$J,358.3,41679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41679,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary
 ;;^UTILITY(U,$J,358.3,41679,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,41679,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,41680,0)
 ;;=C22.1^^124^1801^13
 ;;^UTILITY(U,$J,358.3,41680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41680,1,3,0)
 ;;=3^Intrahepatic bile duct carcinoma
 ;;^UTILITY(U,$J,358.3,41680,1,4,0)
 ;;=4^C22.1
 ;;^UTILITY(U,$J,358.3,41680,2)
 ;;=^5000934
 ;;^UTILITY(U,$J,358.3,41681,0)
 ;;=C22.9^^124^1801^17
 ;;^UTILITY(U,$J,358.3,41681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41681,1,3,0)
 ;;=3^Malignant neoplasm of liver
 ;;^UTILITY(U,$J,358.3,41681,1,4,0)
 ;;=4^C22.9
 ;;^UTILITY(U,$J,358.3,41681,2)
 ;;=^267096
 ;;^UTILITY(U,$J,358.3,41682,0)
 ;;=C78.7^^124^1801^21
 ;;^UTILITY(U,$J,358.3,41682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41682,1,3,0)
 ;;=3^Secondary malig neoplasm of liver and intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,41682,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,41682,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,41683,0)
 ;;=K74.60^^124^1801^11
 ;;^UTILITY(U,$J,358.3,41683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41683,1,3,0)
 ;;=3^Cirrhosis of liver,Unspec
 ;;^UTILITY(U,$J,358.3,41683,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,41683,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,41684,0)
 ;;=K76.0^^124^1801^12
 ;;^UTILITY(U,$J,358.3,41684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41684,1,3,0)
 ;;=3^Fatty (change of) liver, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,41684,1,4,0)
 ;;=4^K76.0
 ;;^UTILITY(U,$J,358.3,41684,2)
 ;;=^5008831
 ;;^UTILITY(U,$J,358.3,41685,0)
 ;;=K76.89^^124^1801^14
 ;;^UTILITY(U,$J,358.3,41685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41685,1,3,0)
 ;;=3^Liver Disease NEC
 ;;^UTILITY(U,$J,358.3,41685,1,4,0)
 ;;=4^K76.89
 ;;^UTILITY(U,$J,358.3,41685,2)
 ;;=^5008835
 ;;^UTILITY(U,$J,358.3,41686,0)
 ;;=K70.30^^124^1801^5
 ;;^UTILITY(U,$J,358.3,41686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41686,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver without ascites
 ;;^UTILITY(U,$J,358.3,41686,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,41686,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,41687,0)
 ;;=K70.31^^124^1801^4
 ;;^UTILITY(U,$J,358.3,41687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41687,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver with ascites
 ;;^UTILITY(U,$J,358.3,41687,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,41687,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,41688,0)
 ;;=K75.4^^124^1801^6
 ;;^UTILITY(U,$J,358.3,41688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41688,1,3,0)
 ;;=3^Autoimmune hepatitis
 ;;^UTILITY(U,$J,358.3,41688,1,4,0)
 ;;=4^K75.4
 ;;^UTILITY(U,$J,358.3,41688,2)
 ;;=^336610
 ;;^UTILITY(U,$J,358.3,41689,0)
 ;;=K74.69^^124^1801^10
 ;;^UTILITY(U,$J,358.3,41689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41689,1,3,0)
 ;;=3^Cirrhosis of liver NEC
 ;;^UTILITY(U,$J,358.3,41689,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,41689,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,41690,0)
 ;;=K74.3^^124^1801^20
 ;;^UTILITY(U,$J,358.3,41690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41690,1,3,0)
 ;;=3^Primary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,41690,1,4,0)
 ;;=4^K74.3
 ;;^UTILITY(U,$J,358.3,41690,2)
 ;;=^5008819
 ;;^UTILITY(U,$J,358.3,41691,0)
 ;;=K75.81^^124^1801^19
 ;;^UTILITY(U,$J,358.3,41691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41691,1,3,0)
 ;;=3^Nonalcoholic steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,41691,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,41691,2)
 ;;=K830^5008828
 ;;^UTILITY(U,$J,358.3,41692,0)
 ;;=B16.9^^124^1801^1
 ;;^UTILITY(U,$J,358.3,41692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41692,1,3,0)
 ;;=3^Acute hepatitis B w/o delta-agent and without hepatic coma
 ;;^UTILITY(U,$J,358.3,41692,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,41692,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,41693,0)
 ;;=B18.1^^124^1801^8
 ;;^UTILITY(U,$J,358.3,41693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41693,1,3,0)
 ;;=3^Chronic viral hepatitis B without delta-agent
 ;;^UTILITY(U,$J,358.3,41693,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,41693,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,41694,0)
 ;;=Z94.4^^124^1801^16
 ;;^UTILITY(U,$J,358.3,41694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41694,1,3,0)
 ;;=3^Liver transplant status
 ;;^UTILITY(U,$J,358.3,41694,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,41694,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,41695,0)
 ;;=J90.^^124^1802^12
 ;;^UTILITY(U,$J,358.3,41695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41695,1,3,0)
 ;;=3^Pleural effusion, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,41695,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,41695,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,41696,0)
 ;;=C34.91^^124^1802^9
 ;;^UTILITY(U,$J,358.3,41696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41696,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right bronchus or lung
 ;;^UTILITY(U,$J,358.3,41696,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,41696,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,41697,0)
 ;;=C34.92^^124^1802^8
 ;;^UTILITY(U,$J,358.3,41697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41697,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of left bronchus or lung
 ;;^UTILITY(U,$J,358.3,41697,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,41697,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,41698,0)
 ;;=C34.01^^124^1802^7
 ;;^UTILITY(U,$J,358.3,41698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41698,1,3,0)
 ;;=3^Malignant neoplasm of right main bronchus
 ;;^UTILITY(U,$J,358.3,41698,1,4,0)
 ;;=4^C34.01
 ;;^UTILITY(U,$J,358.3,41698,2)
 ;;=^5000958
 ;;^UTILITY(U,$J,358.3,41699,0)
 ;;=C34.02^^124^1802^1
 ;;^UTILITY(U,$J,358.3,41699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41699,1,3,0)
 ;;=3^Malignant neoplasm of left main bronchus
 ;;^UTILITY(U,$J,358.3,41699,1,4,0)
 ;;=4^C34.02
 ;;^UTILITY(U,$J,358.3,41699,2)
 ;;=^5000959
 ;;^UTILITY(U,$J,358.3,41700,0)
 ;;=C34.11^^124^1802^11
 ;;^UTILITY(U,$J,358.3,41700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41700,1,3,0)
 ;;=3^Malignant neoplasm of upper lobe, right bronchus or lung
 ;;^UTILITY(U,$J,358.3,41700,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,41700,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,41701,0)
 ;;=C34.12^^124^1802^10
 ;;^UTILITY(U,$J,358.3,41701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41701,1,3,0)
 ;;=3^Malignant neoplasm of upper lobe, left bronchus or lung
 ;;^UTILITY(U,$J,358.3,41701,1,4,0)
 ;;=4^C34.12
 ;;^UTILITY(U,$J,358.3,41701,2)
 ;;=^5000962
 ;;^UTILITY(U,$J,358.3,41702,0)
 ;;=C34.2^^124^1802^4
 ;;^UTILITY(U,$J,358.3,41702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41702,1,3,0)
 ;;=3^Malignant neoplasm of middle lobe, bronchus or lung
 ;;^UTILITY(U,$J,358.3,41702,1,4,0)
 ;;=4^C34.2
 ;;^UTILITY(U,$J,358.3,41702,2)
 ;;=^267137
 ;;^UTILITY(U,$J,358.3,41703,0)
 ;;=C34.31^^124^1802^3
 ;;^UTILITY(U,$J,358.3,41703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41703,1,3,0)
 ;;=3^Malignant neoplasm of lower lobe, right bronchus or lung
 ;;^UTILITY(U,$J,358.3,41703,1,4,0)
 ;;=4^C34.31
 ;;^UTILITY(U,$J,358.3,41703,2)
 ;;=^5133321
 ;;^UTILITY(U,$J,358.3,41704,0)
 ;;=C34.32^^124^1802^2
 ;;^UTILITY(U,$J,358.3,41704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41704,1,3,0)
 ;;=3^Malignant neoplasm of lower lobe, left bronchus or lung
 ;;^UTILITY(U,$J,358.3,41704,1,4,0)
 ;;=4^C34.32
