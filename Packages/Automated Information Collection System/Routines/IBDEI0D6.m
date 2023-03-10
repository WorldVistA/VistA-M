IBDEI0D6 ; ; 03-MAY-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 03, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33057,1,3,0)
 ;;=3^Neopl,Unspec Behav,Right Kidney
 ;;^UTILITY(U,$J,358.3,33057,1,4,0)
 ;;=4^D49.511
 ;;^UTILITY(U,$J,358.3,33057,2)
 ;;=^5138160
 ;;^UTILITY(U,$J,358.3,33058,0)
 ;;=D49.512^^102^1377^9
 ;;^UTILITY(U,$J,358.3,33058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33058,1,3,0)
 ;;=3^Neopl,Unspec Behav,Left Kidney
 ;;^UTILITY(U,$J,358.3,33058,1,4,0)
 ;;=4^D49.512
 ;;^UTILITY(U,$J,358.3,33058,2)
 ;;=^5138161
 ;;^UTILITY(U,$J,358.3,33059,0)
 ;;=Z48.22^^102^1377^2
 ;;^UTILITY(U,$J,358.3,33059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33059,1,3,0)
 ;;=3^Aftercare Following Kidney Transplant
 ;;^UTILITY(U,$J,358.3,33059,1,4,0)
 ;;=4^Z48.22
 ;;^UTILITY(U,$J,358.3,33059,2)
 ;;=^5063039
 ;;^UTILITY(U,$J,358.3,33060,0)
 ;;=Z94.83^^102^1377^11
 ;;^UTILITY(U,$J,358.3,33060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33060,1,3,0)
 ;;=3^Pancreas Transplant Status
 ;;^UTILITY(U,$J,358.3,33060,1,4,0)
 ;;=4^Z94.83
 ;;^UTILITY(U,$J,358.3,33060,2)
 ;;=^5063664
 ;;^UTILITY(U,$J,358.3,33061,0)
 ;;=B17.11^^102^1378^2
 ;;^UTILITY(U,$J,358.3,33061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33061,1,3,0)
 ;;=3^Acute hepatitis C with hepatic coma
 ;;^UTILITY(U,$J,358.3,33061,1,4,0)
 ;;=4^B17.11
 ;;^UTILITY(U,$J,358.3,33061,2)
 ;;=^331777
 ;;^UTILITY(U,$J,358.3,33062,0)
 ;;=B18.2^^102^1378^10
 ;;^UTILITY(U,$J,358.3,33062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33062,1,3,0)
 ;;=3^Chronic viral hepatitis C
 ;;^UTILITY(U,$J,358.3,33062,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,33062,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,33063,0)
 ;;=B17.10^^102^1378^3
 ;;^UTILITY(U,$J,358.3,33063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33063,1,3,0)
 ;;=3^Acute hepatitis C without hepatic coma
 ;;^UTILITY(U,$J,358.3,33063,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,33063,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,33064,0)
 ;;=B19.20^^102^1378^24
 ;;^UTILITY(U,$J,358.3,33064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33064,1,3,0)
 ;;=3^Viral hepatitis C without hepatic coma,Unspec
 ;;^UTILITY(U,$J,358.3,33064,1,4,0)
 ;;=4^B19.20
 ;;^UTILITY(U,$J,358.3,33064,2)
 ;;=^331436
 ;;^UTILITY(U,$J,358.3,33065,0)
 ;;=B19.21^^102^1378^23
 ;;^UTILITY(U,$J,358.3,33065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33065,1,3,0)
 ;;=3^Viral hepatitis C with hepatic coma,Unspec
 ;;^UTILITY(U,$J,358.3,33065,1,4,0)
 ;;=4^B19.21
 ;;^UTILITY(U,$J,358.3,33065,2)
 ;;=^331437
 ;;^UTILITY(U,$J,358.3,33066,0)
 ;;=C22.0^^102^1378^16
 ;;^UTILITY(U,$J,358.3,33066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33066,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,33066,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,33066,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,33067,0)
 ;;=C22.7^^102^1378^8
 ;;^UTILITY(U,$J,358.3,33067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33067,1,3,0)
 ;;=3^Carcinomas of liver NEC
 ;;^UTILITY(U,$J,358.3,33067,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,33067,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,33068,0)
 ;;=C22.8^^102^1378^19
 ;;^UTILITY(U,$J,358.3,33068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33068,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary
 ;;^UTILITY(U,$J,358.3,33068,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,33068,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,33069,0)
 ;;=C22.1^^102^1378^14
 ;;^UTILITY(U,$J,358.3,33069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33069,1,3,0)
 ;;=3^Intrahepatic bile duct carcinoma
 ;;^UTILITY(U,$J,358.3,33069,1,4,0)
 ;;=4^C22.1
 ;;^UTILITY(U,$J,358.3,33069,2)
 ;;=^5000934
 ;;^UTILITY(U,$J,358.3,33070,0)
 ;;=C22.9^^102^1378^18
 ;;^UTILITY(U,$J,358.3,33070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33070,1,3,0)
 ;;=3^Malignant neoplasm of liver
 ;;^UTILITY(U,$J,358.3,33070,1,4,0)
 ;;=4^C22.9
 ;;^UTILITY(U,$J,358.3,33070,2)
 ;;=^267096
 ;;^UTILITY(U,$J,358.3,33071,0)
 ;;=C78.7^^102^1378^22
 ;;^UTILITY(U,$J,358.3,33071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33071,1,3,0)
 ;;=3^Secondary malig neoplasm of liver and intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,33071,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,33071,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,33072,0)
 ;;=K74.60^^102^1378^12
 ;;^UTILITY(U,$J,358.3,33072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33072,1,3,0)
 ;;=3^Cirrhosis of liver,Unspec
 ;;^UTILITY(U,$J,358.3,33072,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,33072,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,33073,0)
 ;;=K76.0^^102^1378^13
 ;;^UTILITY(U,$J,358.3,33073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33073,1,3,0)
 ;;=3^Fatty (change of) liver, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,33073,1,4,0)
 ;;=4^K76.0
 ;;^UTILITY(U,$J,358.3,33073,2)
 ;;=^5008831
 ;;^UTILITY(U,$J,358.3,33074,0)
 ;;=K76.89^^102^1378^15
 ;;^UTILITY(U,$J,358.3,33074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33074,1,3,0)
 ;;=3^Liver Disease NEC
 ;;^UTILITY(U,$J,358.3,33074,1,4,0)
 ;;=4^K76.89
 ;;^UTILITY(U,$J,358.3,33074,2)
 ;;=^5008835
 ;;^UTILITY(U,$J,358.3,33075,0)
 ;;=K70.30^^102^1378^6
 ;;^UTILITY(U,$J,358.3,33075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33075,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver without ascites
 ;;^UTILITY(U,$J,358.3,33075,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,33075,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,33076,0)
 ;;=K70.31^^102^1378^5
 ;;^UTILITY(U,$J,358.3,33076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33076,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver with ascites
 ;;^UTILITY(U,$J,358.3,33076,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,33076,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,33077,0)
 ;;=K75.4^^102^1378^7
 ;;^UTILITY(U,$J,358.3,33077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33077,1,3,0)
 ;;=3^Autoimmune hepatitis
 ;;^UTILITY(U,$J,358.3,33077,1,4,0)
 ;;=4^K75.4
 ;;^UTILITY(U,$J,358.3,33077,2)
 ;;=^336610
 ;;^UTILITY(U,$J,358.3,33078,0)
 ;;=K74.69^^102^1378^11
 ;;^UTILITY(U,$J,358.3,33078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33078,1,3,0)
 ;;=3^Cirrhosis of liver NEC
 ;;^UTILITY(U,$J,358.3,33078,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,33078,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,33079,0)
 ;;=K74.3^^102^1378^21
 ;;^UTILITY(U,$J,358.3,33079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33079,1,3,0)
 ;;=3^Primary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,33079,1,4,0)
 ;;=4^K74.3
 ;;^UTILITY(U,$J,358.3,33079,2)
 ;;=^5008819
 ;;^UTILITY(U,$J,358.3,33080,0)
 ;;=K75.81^^102^1378^20
 ;;^UTILITY(U,$J,358.3,33080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33080,1,3,0)
 ;;=3^Nonalcoholic steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,33080,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,33080,2)
 ;;=K830^5008828
 ;;^UTILITY(U,$J,358.3,33081,0)
 ;;=B16.9^^102^1378^1
 ;;^UTILITY(U,$J,358.3,33081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33081,1,3,0)
 ;;=3^Acute hepatitis B w/o delta-agent and without hepatic coma
 ;;^UTILITY(U,$J,358.3,33081,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,33081,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,33082,0)
 ;;=B18.1^^102^1378^9
 ;;^UTILITY(U,$J,358.3,33082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33082,1,3,0)
 ;;=3^Chronic viral hepatitis B without delta-agent
 ;;^UTILITY(U,$J,358.3,33082,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,33082,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,33083,0)
 ;;=Z94.4^^102^1378^17
 ;;^UTILITY(U,$J,358.3,33083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33083,1,3,0)
 ;;=3^Liver transplant status
 ;;^UTILITY(U,$J,358.3,33083,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,33083,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,33084,0)
 ;;=Z48.23^^102^1378^4
 ;;^UTILITY(U,$J,358.3,33084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33084,1,3,0)
 ;;=3^Aftercare Following Liver Transplant
 ;;^UTILITY(U,$J,358.3,33084,1,4,0)
 ;;=4^Z48.23
 ;;^UTILITY(U,$J,358.3,33084,2)
 ;;=^5063040
 ;;^UTILITY(U,$J,358.3,33085,0)
 ;;=J90.^^102^1379^16
 ;;^UTILITY(U,$J,358.3,33085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33085,1,3,0)
 ;;=3^Pleural effusion, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,33085,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,33085,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,33086,0)
 ;;=C34.91^^102^1379^13
 ;;^UTILITY(U,$J,358.3,33086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33086,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right bronchus or lung
 ;;^UTILITY(U,$J,358.3,33086,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,33086,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,33087,0)
 ;;=C34.92^^102^1379^12
 ;;^UTILITY(U,$J,358.3,33087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33087,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of left bronchus or lung
 ;;^UTILITY(U,$J,358.3,33087,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,33087,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,33088,0)
 ;;=C34.01^^102^1379^11
 ;;^UTILITY(U,$J,358.3,33088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33088,1,3,0)
 ;;=3^Malignant neoplasm of right main bronchus
 ;;^UTILITY(U,$J,358.3,33088,1,4,0)
 ;;=4^C34.01
 ;;^UTILITY(U,$J,358.3,33088,2)
 ;;=^5000958
 ;;^UTILITY(U,$J,358.3,33089,0)
 ;;=C34.02^^102^1379^5
 ;;^UTILITY(U,$J,358.3,33089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33089,1,3,0)
 ;;=3^Malignant neoplasm of left main bronchus
 ;;^UTILITY(U,$J,358.3,33089,1,4,0)
 ;;=4^C34.02
 ;;^UTILITY(U,$J,358.3,33089,2)
 ;;=^5000959
 ;;^UTILITY(U,$J,358.3,33090,0)
 ;;=C34.11^^102^1379^15
 ;;^UTILITY(U,$J,358.3,33090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33090,1,3,0)
 ;;=3^Malignant neoplasm of upper lobe, right bronchus or lung
 ;;^UTILITY(U,$J,358.3,33090,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,33090,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,33091,0)
 ;;=C34.12^^102^1379^14
 ;;^UTILITY(U,$J,358.3,33091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33091,1,3,0)
 ;;=3^Malignant neoplasm of upper lobe, left bronchus or lung
 ;;^UTILITY(U,$J,358.3,33091,1,4,0)
 ;;=4^C34.12
 ;;^UTILITY(U,$J,358.3,33091,2)
 ;;=^5000962
 ;;^UTILITY(U,$J,358.3,33092,0)
 ;;=C34.2^^102^1379^8
 ;;^UTILITY(U,$J,358.3,33092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33092,1,3,0)
 ;;=3^Malignant neoplasm of middle lobe, bronchus or lung
 ;;^UTILITY(U,$J,358.3,33092,1,4,0)
 ;;=4^C34.2
 ;;^UTILITY(U,$J,358.3,33092,2)
 ;;=^267137
 ;;^UTILITY(U,$J,358.3,33093,0)
 ;;=C34.31^^102^1379^7
 ;;^UTILITY(U,$J,358.3,33093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33093,1,3,0)
 ;;=3^Malignant neoplasm of lower lobe, right bronchus or lung
 ;;^UTILITY(U,$J,358.3,33093,1,4,0)
 ;;=4^C34.31
 ;;^UTILITY(U,$J,358.3,33093,2)
 ;;=^5133321
 ;;^UTILITY(U,$J,358.3,33094,0)
 ;;=C34.32^^102^1379^6
 ;;^UTILITY(U,$J,358.3,33094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33094,1,3,0)
 ;;=3^Malignant neoplasm of lower lobe, left bronchus or lung
 ;;^UTILITY(U,$J,358.3,33094,1,4,0)
 ;;=4^C34.32
 ;;^UTILITY(U,$J,358.3,33094,2)
 ;;=^5133322
 ;;^UTILITY(U,$J,358.3,33095,0)
 ;;=C34.81^^102^1379^10
 ;;^UTILITY(U,$J,358.3,33095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33095,1,3,0)
 ;;=3^Malignant neoplasm of ovrlp sites of right bronchus and lung
 ;;^UTILITY(U,$J,358.3,33095,1,4,0)
 ;;=4^C34.81
 ;;^UTILITY(U,$J,358.3,33095,2)
 ;;=^5000964
 ;;^UTILITY(U,$J,358.3,33096,0)
 ;;=C34.82^^102^1379^9
 ;;^UTILITY(U,$J,358.3,33096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33096,1,3,0)
 ;;=3^Malignant neoplasm of ovrlp sites of left bronchus and lung
 ;;^UTILITY(U,$J,358.3,33096,1,4,0)
 ;;=4^C34.82
 ;;^UTILITY(U,$J,358.3,33096,2)
 ;;=^5000965
 ;;^UTILITY(U,$J,358.3,33097,0)
 ;;=Z48.24^^102^1379^2
 ;;^UTILITY(U,$J,358.3,33097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33097,1,3,0)
 ;;=3^Aftercare Following Lung Transplant
 ;;^UTILITY(U,$J,358.3,33097,1,4,0)
 ;;=4^Z48.24
 ;;^UTILITY(U,$J,358.3,33097,2)
 ;;=^5063041
 ;;^UTILITY(U,$J,358.3,33098,0)
 ;;=Z48.280^^102^1379^1
 ;;^UTILITY(U,$J,358.3,33098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33098,1,3,0)
 ;;=3^Aftercare Following Heart & Lung Transplant
 ;;^UTILITY(U,$J,358.3,33098,1,4,0)
 ;;=4^Z48.280
 ;;^UTILITY(U,$J,358.3,33098,2)
 ;;=^5063042
 ;;^UTILITY(U,$J,358.3,33099,0)
 ;;=Z94.3^^102^1379^3
 ;;^UTILITY(U,$J,358.3,33099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33099,1,3,0)
 ;;=3^Heart & Lungs Transplant Status
 ;;^UTILITY(U,$J,358.3,33099,1,4,0)
 ;;=4^Z94.3
 ;;^UTILITY(U,$J,358.3,33099,2)
 ;;=^5063657
 ;;^UTILITY(U,$J,358.3,33100,0)
 ;;=Z94.2^^102^1379^4
 ;;^UTILITY(U,$J,358.3,33100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33100,1,3,0)
 ;;=3^Lung Transplant Status
 ;;^UTILITY(U,$J,358.3,33100,1,4,0)
 ;;=4^Z94.2
 ;;^UTILITY(U,$J,358.3,33100,2)
 ;;=^5063656
 ;;^UTILITY(U,$J,358.3,33101,0)
 ;;=C83.38^^102^1380^22
 ;;^UTILITY(U,$J,358.3,33101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33101,1,3,0)
 ;;=3^Diffuse large B-cell lymphoma, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,33101,1,4,0)
 ;;=4^C83.38
 ;;^UTILITY(U,$J,358.3,33101,2)
 ;;=^5001579
 ;;^UTILITY(U,$J,358.3,33102,0)
 ;;=C83.58^^102^1380^28
 ;;^UTILITY(U,$J,358.3,33102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33102,1,3,0)
 ;;=3^Lymphoblastic (diffuse) lymphoma, lymph nodes mult site
 ;;^UTILITY(U,$J,358.3,33102,1,4,0)
 ;;=4^C83.58
 ;;^UTILITY(U,$J,358.3,33102,2)
 ;;=^5001589
 ;;^UTILITY(U,$J,358.3,33103,0)
 ;;=C83.78^^102^1380^15
 ;;^UTILITY(U,$J,358.3,33103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33103,1,3,0)
 ;;=3^Burkitt lymphoma, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,33103,1,4,0)
 ;;=4^C83.78
 ;;^UTILITY(U,$J,358.3,33103,2)
 ;;=^5001599
 ;;^UTILITY(U,$J,358.3,33104,0)
 ;;=C83.18^^102^1380^34
 ;;^UTILITY(U,$J,358.3,33104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33104,1,3,0)
 ;;=3^Mantle cell lymphoma, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,33104,1,4,0)
 ;;=4^C83.18
 ;;^UTILITY(U,$J,358.3,33104,2)
 ;;=^5001569
 ;;^UTILITY(U,$J,358.3,33105,0)
 ;;=C84.68^^102^1380^12
 ;;^UTILITY(U,$J,358.3,33105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33105,1,3,0)
 ;;=3^Anaplastic large cell lymphoma, ALK-pos, nodes mult site
 ;;^UTILITY(U,$J,358.3,33105,1,4,0)
 ;;=4^C84.68
 ;;^UTILITY(U,$J,358.3,33105,2)
 ;;=^5001659
 ;;^UTILITY(U,$J,358.3,33106,0)
 ;;=C84.78^^102^1380^11
 ;;^UTILITY(U,$J,358.3,33106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33106,1,3,0)
 ;;=3^Anaplastic large cell lymphoma, ALK-neg, nodes mult site
 ;;^UTILITY(U,$J,358.3,33106,1,4,0)
 ;;=4^C84.78
 ;;^UTILITY(U,$J,358.3,33106,2)
 ;;=^5001669
 ;;^UTILITY(U,$J,358.3,33107,0)
 ;;=C81.08^^102^1380^47
 ;;^UTILITY(U,$J,358.3,33107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33107,1,3,0)
 ;;=3^Nodular lymphocyte predom Hodgkin lymphoma, nodes mult site
 ;;^UTILITY(U,$J,358.3,33107,1,4,0)
 ;;=4^C81.08
 ;;^UTILITY(U,$J,358.3,33107,2)
 ;;=^5001399
 ;;^UTILITY(U,$J,358.3,33108,0)
 ;;=C81.48^^102^1380^27
 ;;^UTILITY(U,$J,358.3,33108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33108,1,3,0)
 ;;=3^Lymp-rich classical Hodgkin lymphoma, lymph nodes mult site
 ;;^UTILITY(U,$J,358.3,33108,1,4,0)
 ;;=4^C81.48
 ;;^UTILITY(U,$J,358.3,33108,2)
 ;;=^5001439
 ;;^UTILITY(U,$J,358.3,33109,0)
 ;;=C81.18^^102^1380^48
 ;;^UTILITY(U,$J,358.3,33109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33109,1,3,0)
 ;;=3^Nodular sclerosis class Hodgkin lymphoma, nodes mult site
 ;;^UTILITY(U,$J,358.3,33109,1,4,0)
 ;;=4^C81.18
 ;;^UTILITY(U,$J,358.3,33109,2)
 ;;=^5001409
 ;;^UTILITY(U,$J,358.3,33110,0)
 ;;=C81.28^^102^1380^38
 ;;^UTILITY(U,$J,358.3,33110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33110,1,3,0)
 ;;=3^Mixed cellular classical Hodgkin lymphoma, nodes mult site
 ;;^UTILITY(U,$J,358.3,33110,1,4,0)
 ;;=4^C81.28
 ;;^UTILITY(U,$J,358.3,33110,2)
 ;;=^5001419
 ;;^UTILITY(U,$J,358.3,33111,0)
 ;;=C81.38^^102^1380^29
 ;;^UTILITY(U,$J,358.3,33111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33111,1,3,0)
 ;;=3^Lymphocy depleted class Hodgkin lymphoma, nodes mult site
 ;;^UTILITY(U,$J,358.3,33111,1,4,0)
 ;;=4^C81.38
 ;;^UTILITY(U,$J,358.3,33111,2)
 ;;=^5001429
 ;;^UTILITY(U,$J,358.3,33112,0)
 ;;=C82.98^^102^1380^25
 ;;^UTILITY(U,$J,358.3,33112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33112,1,3,0)
 ;;=3^Follicular lymphoma, unsp, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,33112,1,4,0)
 ;;=4^C82.98
 ;;^UTILITY(U,$J,358.3,33112,2)
 ;;=^5001549
 ;;^UTILITY(U,$J,358.3,33113,0)
 ;;=C84.08^^102^1380^44
 ;;^UTILITY(U,$J,358.3,33113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33113,1,3,0)
 ;;=3^Mycosis fungoides, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,33113,1,4,0)
 ;;=4^C84.08
 ;;^UTILITY(U,$J,358.3,33113,2)
 ;;=^5001629
 ;;^UTILITY(U,$J,358.3,33114,0)
 ;;=C84.18^^102^1380^53
 ;;^UTILITY(U,$J,358.3,33114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33114,1,3,0)
 ;;=3^Sezary disease, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,33114,1,4,0)
 ;;=4^C84.18
 ;;^UTILITY(U,$J,358.3,33114,2)
 ;;=^5001639
 ;;^UTILITY(U,$J,358.3,33115,0)
 ;;=C91.40^^102^1380^26
 ;;^UTILITY(U,$J,358.3,33115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33115,1,3,0)
 ;;=3^Hairy cell leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,33115,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,33115,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,33116,0)
 ;;=C96.0^^102^1380^41
 ;;^UTILITY(U,$J,358.3,33116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33116,1,3,0)
 ;;=3^Multifocal and multisystemic Langerhans-cell histiocytosis
 ;;^UTILITY(U,$J,358.3,33116,1,4,0)
 ;;=4^C96.0
 ;;^UTILITY(U,$J,358.3,33116,2)
 ;;=^5001859
 ;;^UTILITY(U,$J,358.3,33117,0)
 ;;=C84.48^^102^1380^49
 ;;^UTILITY(U,$J,358.3,33117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33117,1,3,0)
 ;;=3^Peripheral T-cell lymphoma, not classified, nodes mult site
 ;;^UTILITY(U,$J,358.3,33117,1,4,0)
 ;;=4^C84.48
 ;;^UTILITY(U,$J,358.3,33117,2)
 ;;=^5001649
 ;;^UTILITY(U,$J,358.3,33118,0)
 ;;=C90.01^^102^1380^43
 ;;^UTILITY(U,$J,358.3,33118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33118,1,3,0)
 ;;=3^Multiple myeloma in remission
 ;;^UTILITY(U,$J,358.3,33118,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,33118,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,33119,0)
 ;;=C90.02^^102^1380^42
 ;;^UTILITY(U,$J,358.3,33119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33119,1,3,0)
 ;;=3^Multiple myeloma in relapse
 ;;^UTILITY(U,$J,358.3,33119,1,4,0)
 ;;=4^C90.02
 ;;^UTILITY(U,$J,358.3,33119,2)
 ;;=^5001753
 ;;^UTILITY(U,$J,358.3,33120,0)
 ;;=C90.11^^102^1380^51
 ;;^UTILITY(U,$J,358.3,33120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33120,1,3,0)
 ;;=3^Plasma cell leukemia in remission
 ;;^UTILITY(U,$J,358.3,33120,1,4,0)
 ;;=4^C90.11
 ;;^UTILITY(U,$J,358.3,33120,2)
 ;;=^267517
 ;;^UTILITY(U,$J,358.3,33121,0)
 ;;=C90.12^^102^1380^50
 ;;^UTILITY(U,$J,358.3,33121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33121,1,3,0)
 ;;=3^Plasma cell leukemia in relapse
 ;;^UTILITY(U,$J,358.3,33121,1,4,0)
 ;;=4^C90.12
 ;;^UTILITY(U,$J,358.3,33121,2)
 ;;=^5001755
 ;;^UTILITY(U,$J,358.3,33122,0)
 ;;=C90.21^^102^1380^24
 ;;^UTILITY(U,$J,358.3,33122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33122,1,3,0)
 ;;=3^Extramedullary plasmacytoma in remission
 ;;^UTILITY(U,$J,358.3,33122,1,4,0)
 ;;=4^C90.21
 ;;^UTILITY(U,$J,358.3,33122,2)
 ;;=^5001757
 ;;^UTILITY(U,$J,358.3,33123,0)
 ;;=C90.31^^102^1380^55
