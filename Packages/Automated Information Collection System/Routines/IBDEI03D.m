IBDEI03D ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7972,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,7973,0)
 ;;=B16.0^^45^445^46
 ;;^UTILITY(U,$J,358.3,7973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7973,1,3,0)
 ;;=3^Hepatitis B,Acute w/ Coma & Delta
 ;;^UTILITY(U,$J,358.3,7973,1,4,0)
 ;;=4^B16.0
 ;;^UTILITY(U,$J,358.3,7973,2)
 ;;=^5000537
 ;;^UTILITY(U,$J,358.3,7974,0)
 ;;=B16.2^^45^445^47
 ;;^UTILITY(U,$J,358.3,7974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7974,1,3,0)
 ;;=3^Hepatitis B,Acute w/ Coma no Delta
 ;;^UTILITY(U,$J,358.3,7974,1,4,0)
 ;;=4^B16.2
 ;;^UTILITY(U,$J,358.3,7974,2)
 ;;=^5000539
 ;;^UTILITY(U,$J,358.3,7975,0)
 ;;=B16.1^^45^445^48
 ;;^UTILITY(U,$J,358.3,7975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7975,1,3,0)
 ;;=3^Hepatitis B,Acute w/ Delta no Coma
 ;;^UTILITY(U,$J,358.3,7975,1,4,0)
 ;;=4^B16.1
 ;;^UTILITY(U,$J,358.3,7975,2)
 ;;=^5000538
 ;;^UTILITY(U,$J,358.3,7976,0)
 ;;=B16.9^^45^445^49
 ;;^UTILITY(U,$J,358.3,7976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7976,1,3,0)
 ;;=3^Hepatitis B,Acute,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7976,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,7976,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,7977,0)
 ;;=B19.10^^45^445^52
 ;;^UTILITY(U,$J,358.3,7977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7977,1,3,0)
 ;;=3^Hepatitis B,Unspec w/o Coma
 ;;^UTILITY(U,$J,358.3,7977,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,7977,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,7978,0)
 ;;=B17.0^^45^445^56
 ;;^UTILITY(U,$J,358.3,7978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7978,1,3,0)
 ;;=3^Hepatitis D,Acute Superinfection
 ;;^UTILITY(U,$J,358.3,7978,1,4,0)
 ;;=4^B17.0
 ;;^UTILITY(U,$J,358.3,7978,2)
 ;;=^5000541
 ;;^UTILITY(U,$J,358.3,7979,0)
 ;;=B17.2^^45^445^57
 ;;^UTILITY(U,$J,358.3,7979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7979,1,3,0)
 ;;=3^Hepatitis E,Acute
 ;;^UTILITY(U,$J,358.3,7979,1,4,0)
 ;;=4^B17.2
 ;;^UTILITY(U,$J,358.3,7979,2)
 ;;=^5000543
 ;;^UTILITY(U,$J,358.3,7980,0)
 ;;=Z12.89^^45^445^59
 ;;^UTILITY(U,$J,358.3,7980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7980,1,3,0)
 ;;=3^Hepatocellular carcinoma screening
 ;;^UTILITY(U,$J,358.3,7980,1,4,0)
 ;;=4^Z12.89
 ;;^UTILITY(U,$J,358.3,7980,2)
 ;;=^5062697
 ;;^UTILITY(U,$J,358.3,7981,0)
 ;;=R16.2^^45^445^61
 ;;^UTILITY(U,$J,358.3,7981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7981,1,3,0)
 ;;=3^Hepatomegaly w/ Splenomegaly NEC
 ;;^UTILITY(U,$J,358.3,7981,1,4,0)
 ;;=4^R16.2
 ;;^UTILITY(U,$J,358.3,7981,2)
 ;;=^5019250
 ;;^UTILITY(U,$J,358.3,7982,0)
 ;;=R16.0^^45^445^60
 ;;^UTILITY(U,$J,358.3,7982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7982,1,3,0)
 ;;=3^Hepatomegaly NEC
 ;;^UTILITY(U,$J,358.3,7982,1,4,0)
 ;;=4^R16.0
 ;;^UTILITY(U,$J,358.3,7982,2)
 ;;=^5019248
 ;;^UTILITY(U,$J,358.3,7983,0)
 ;;=K76.81^^45^445^62
 ;;^UTILITY(U,$J,358.3,7983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7983,1,3,0)
 ;;=3^Hepatopulmonary syndrome
 ;;^UTILITY(U,$J,358.3,7983,1,4,0)
 ;;=4^K76.81
 ;;^UTILITY(U,$J,358.3,7983,2)
 ;;=^340555
 ;;^UTILITY(U,$J,358.3,7984,0)
 ;;=K76.3^^45^445^64
 ;;^UTILITY(U,$J,358.3,7984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7984,1,3,0)
 ;;=3^Infarction of Liver
 ;;^UTILITY(U,$J,358.3,7984,1,4,0)
 ;;=4^K76.3
 ;;^UTILITY(U,$J,358.3,7984,2)
 ;;=^5008833
 ;;^UTILITY(U,$J,358.3,7985,0)
 ;;=R79.89^^45^445^65
 ;;^UTILITY(U,$J,358.3,7985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7985,1,3,0)
 ;;=3^Iron metabolism,Hyperferritinemia
 ;;^UTILITY(U,$J,358.3,7985,1,4,0)
 ;;=4^R79.89
 ;;^UTILITY(U,$J,358.3,7985,2)
 ;;=^5019593
 ;;^UTILITY(U,$J,358.3,7986,0)
 ;;=R79.0^^45^445^66
 ;;^UTILITY(U,$J,358.3,7986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7986,1,3,0)
 ;;=3^Iron metabolism,Iron levels abnormal
 ;;^UTILITY(U,$J,358.3,7986,1,4,0)
 ;;=4^R79.0
 ;;^UTILITY(U,$J,358.3,7986,2)
 ;;=^5019590
 ;;^UTILITY(U,$J,358.3,7987,0)
 ;;=T86.42^^45^445^68
 ;;^UTILITY(U,$J,358.3,7987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7987,1,3,0)
 ;;=3^Liver transplant failure
 ;;^UTILITY(U,$J,358.3,7987,1,4,0)
 ;;=4^T86.42
 ;;^UTILITY(U,$J,358.3,7987,2)
 ;;=^5055726
 ;;^UTILITY(U,$J,358.3,7988,0)
 ;;=T86.43^^45^445^69
 ;;^UTILITY(U,$J,358.3,7988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7988,1,3,0)
 ;;=3^Liver transplant infection
 ;;^UTILITY(U,$J,358.3,7988,1,4,0)
 ;;=4^T86.43
 ;;^UTILITY(U,$J,358.3,7988,2)
 ;;=^5055727
 ;;^UTILITY(U,$J,358.3,7989,0)
 ;;=T86.41^^45^445^70
 ;;^UTILITY(U,$J,358.3,7989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7989,1,3,0)
 ;;=3^Liver transplant rejection
 ;;^UTILITY(U,$J,358.3,7989,1,4,0)
 ;;=4^T86.41
 ;;^UTILITY(U,$J,358.3,7989,2)
 ;;=^5055725
 ;;^UTILITY(U,$J,358.3,7990,0)
 ;;=Z94.4^^45^445^71
 ;;^UTILITY(U,$J,358.3,7990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7990,1,3,0)
 ;;=3^Liver transplant status
 ;;^UTILITY(U,$J,358.3,7990,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,7990,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,7991,0)
 ;;=C22.0^^45^445^58
 ;;^UTILITY(U,$J,358.3,7991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7991,1,3,0)
 ;;=3^Hepatocellular Carcinoma
 ;;^UTILITY(U,$J,358.3,7991,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,7991,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,7992,0)
 ;;=J90.^^45^445^76
 ;;^UTILITY(U,$J,358.3,7992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7992,1,3,0)
 ;;=3^Pleural effusion NEC
 ;;^UTILITY(U,$J,358.3,7992,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,7992,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,7993,0)
 ;;=K74.3^^45^445^80
 ;;^UTILITY(U,$J,358.3,7993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7993,1,3,0)
 ;;=3^Primary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,7993,1,4,0)
 ;;=4^K74.3
 ;;^UTILITY(U,$J,358.3,7993,2)
 ;;=^5008819
 ;;^UTILITY(U,$J,358.3,7994,0)
 ;;=K76.6^^45^445^77
 ;;^UTILITY(U,$J,358.3,7994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7994,1,3,0)
 ;;=3^Portal hypertension
 ;;^UTILITY(U,$J,358.3,7994,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,7994,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,7995,0)
 ;;=K31.89^^45^445^78
 ;;^UTILITY(U,$J,358.3,7995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7995,1,3,0)
 ;;=3^Portal hypertension gastropathy
 ;;^UTILITY(U,$J,358.3,7995,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,7995,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,7996,0)
 ;;=I81.^^45^445^79
 ;;^UTILITY(U,$J,358.3,7996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7996,1,3,0)
 ;;=3^Portal vein thrombosis
 ;;^UTILITY(U,$J,358.3,7996,1,4,0)
 ;;=4^I81.
 ;;^UTILITY(U,$J,358.3,7996,2)
 ;;=^269815
 ;;^UTILITY(U,$J,358.3,7997,0)
 ;;=K74.4^^45^445^81
 ;;^UTILITY(U,$J,358.3,7997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7997,1,3,0)
 ;;=3^Secondary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,7997,1,4,0)
 ;;=4^K74.4
 ;;^UTILITY(U,$J,358.3,7997,2)
 ;;=^5008820
 ;;^UTILITY(U,$J,358.3,7998,0)
 ;;=K65.2^^45^445^83
 ;;^UTILITY(U,$J,358.3,7998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7998,1,3,0)
 ;;=3^Spontaneous bacterial peritonitis
 ;;^UTILITY(U,$J,358.3,7998,1,4,0)
 ;;=4^K65.2
 ;;^UTILITY(U,$J,358.3,7998,2)
 ;;=^332801
 ;;^UTILITY(U,$J,358.3,7999,0)
 ;;=K71.2^^45^445^85
 ;;^UTILITY(U,$J,358.3,7999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7999,1,3,0)
 ;;=3^Toxic liver disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,7999,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,7999,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,8000,0)
 ;;=K71.3^^45^445^87
 ;;^UTILITY(U,$J,358.3,8000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8000,1,3,0)
 ;;=3^Toxic liver disease w/ Chronic Hepatitis
 ;;^UTILITY(U,$J,358.3,8000,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,8000,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,8001,0)
 ;;=K71.0^^45^445^86
 ;;^UTILITY(U,$J,358.3,8001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8001,1,3,0)
 ;;=3^Toxic liver disease w/ Cholestasis
 ;;^UTILITY(U,$J,358.3,8001,1,4,0)
 ;;=4^K71.0
 ;;^UTILITY(U,$J,358.3,8001,2)
 ;;=^5008793
 ;;^UTILITY(U,$J,358.3,8002,0)
 ;;=K71.10^^45^445^89
 ;;^UTILITY(U,$J,358.3,8002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8002,1,3,0)
 ;;=3^Toxic liver disease w/ Hepatic Necrosis
 ;;^UTILITY(U,$J,358.3,8002,1,4,0)
 ;;=4^K71.10
 ;;^UTILITY(U,$J,358.3,8002,2)
 ;;=^5008794
 ;;^UTILITY(U,$J,358.3,8003,0)
 ;;=K71.6^^45^445^90
 ;;^UTILITY(U,$J,358.3,8003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8003,1,3,0)
 ;;=3^Toxic liver disease w/ Hepatitis
 ;;^UTILITY(U,$J,358.3,8003,1,4,0)
 ;;=4^K71.6
 ;;^UTILITY(U,$J,358.3,8003,2)
 ;;=^5008801
 ;;^UTILITY(U,$J,358.3,8004,0)
 ;;=K71.11^^45^445^88
 ;;^UTILITY(U,$J,358.3,8004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8004,1,3,0)
 ;;=3^Toxic liver disease w/ Coma
 ;;^UTILITY(U,$J,358.3,8004,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,8004,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,8005,0)
 ;;=K71.9^^45^445^91
 ;;^UTILITY(U,$J,358.3,8005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8005,1,3,0)
 ;;=3^Toxic liver disease,Uncomplicated
 ;;^UTILITY(U,$J,358.3,8005,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,8005,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,8006,0)
 ;;=E83.01^^45^445^92
 ;;^UTILITY(U,$J,358.3,8006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8006,1,3,0)
 ;;=3^Wilson's disease
 ;;^UTILITY(U,$J,358.3,8006,1,4,0)
 ;;=4^E83.01
 ;;^UTILITY(U,$J,358.3,8006,2)
 ;;=^5002991
 ;;^UTILITY(U,$J,358.3,8007,0)
 ;;=K76.9^^45^445^24
 ;;^UTILITY(U,$J,358.3,8007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8007,1,3,0)
 ;;=3^Disease of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,8007,1,4,0)
 ;;=4^K76.9
 ;;^UTILITY(U,$J,358.3,8007,2)
 ;;=^5008836
 ;;^UTILITY(U,$J,358.3,8008,0)
 ;;=K76.7^^45^445^63
 ;;^UTILITY(U,$J,358.3,8008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8008,1,3,0)
 ;;=3^Hepatorenal syndrome
 ;;^UTILITY(U,$J,358.3,8008,1,4,0)
 ;;=4^K76.7
 ;;^UTILITY(U,$J,358.3,8008,2)
 ;;=^56497
 ;;^UTILITY(U,$J,358.3,8009,0)
 ;;=T86.49^^45^445^67
 ;;^UTILITY(U,$J,358.3,8009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8009,1,3,0)
 ;;=3^Liver transplant complication,Other
 ;;^UTILITY(U,$J,358.3,8009,1,4,0)
 ;;=4^T86.49
 ;;^UTILITY(U,$J,358.3,8009,2)
 ;;=^5055728
 ;;^UTILITY(U,$J,358.3,8010,0)
 ;;=K75.81^^45^445^75
 ;;^UTILITY(U,$J,358.3,8010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8010,1,3,0)
 ;;=3^Nonalcoholic steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,8010,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,8010,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,8011,0)
 ;;=E80.4^^45^445^33
 ;;^UTILITY(U,$J,358.3,8011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8011,1,3,0)
 ;;=3^Gilbert Syndrome
 ;;^UTILITY(U,$J,358.3,8011,1,4,0)
 ;;=4^E80.4
 ;;^UTILITY(U,$J,358.3,8011,2)
 ;;=^5002987
 ;;^UTILITY(U,$J,358.3,8012,0)
 ;;=Z20.5^^45^445^28
 ;;^UTILITY(U,$J,358.3,8012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8012,1,3,0)
 ;;=3^Exposure to Viral Hepatitis
 ;;^UTILITY(U,$J,358.3,8012,1,4,0)
 ;;=4^Z20.5
 ;;^UTILITY(U,$J,358.3,8012,2)
 ;;=^5062767
 ;;^UTILITY(U,$J,358.3,8013,0)
 ;;=R16.1^^45^445^82
 ;;^UTILITY(U,$J,358.3,8013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8013,1,3,0)
 ;;=3^Splenomegaly NEC
 ;;^UTILITY(U,$J,358.3,8013,1,4,0)
 ;;=4^R16.1
 ;;^UTILITY(U,$J,358.3,8013,2)
 ;;=^5019249
 ;;^UTILITY(U,$J,358.3,8014,0)
 ;;=D69.6^^45^445^84
 ;;^UTILITY(U,$J,358.3,8014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8014,1,3,0)
 ;;=3^Thrombocytopenia,Unspec
 ;;^UTILITY(U,$J,358.3,8014,1,4,0)
 ;;=4^D69.6
 ;;^UTILITY(U,$J,358.3,8014,2)
 ;;=^5002370
 ;;^UTILITY(U,$J,358.3,8015,0)
 ;;=K72.91^^45^445^37
 ;;^UTILITY(U,$J,358.3,8015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8015,1,3,0)
 ;;=3^Hepatic Failure w/ Coma,Unspec
 ;;^UTILITY(U,$J,358.3,8015,1,4,0)
 ;;=4^K72.91
 ;;^UTILITY(U,$J,358.3,8015,2)
 ;;=^5008810
 ;;^UTILITY(U,$J,358.3,8016,0)
 ;;=C22.8^^45^445^73
 ;;^UTILITY(U,$J,358.3,8016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8016,1,3,0)
 ;;=3^Malignant Neop Liver,Primary,Unspec Type
 ;;^UTILITY(U,$J,358.3,8016,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,8016,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,8017,0)
 ;;=K86.0^^45^446^31
 ;;^UTILITY(U,$J,358.3,8017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8017,1,3,0)
 ;;=3^Pancreatitis,Chronic Alcohol
 ;;^UTILITY(U,$J,358.3,8017,1,4,0)
 ;;=4^K86.0
 ;;^UTILITY(U,$J,358.3,8017,2)
 ;;=^5008888
 ;;^UTILITY(U,$J,358.3,8018,0)
 ;;=K86.1^^45^446^32
 ;;^UTILITY(U,$J,358.3,8018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8018,1,3,0)
 ;;=3^Pancreatitis,Chronic,Other
 ;;^UTILITY(U,$J,358.3,8018,1,4,0)
 ;;=4^K86.1
 ;;^UTILITY(U,$J,358.3,8018,2)
 ;;=^5008889
 ;;^UTILITY(U,$J,358.3,8019,0)
 ;;=K86.2^^45^446^6
 ;;^UTILITY(U,$J,358.3,8019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8019,1,3,0)
 ;;=3^Cyst of pancreas
 ;;^UTILITY(U,$J,358.3,8019,1,4,0)
 ;;=4^K86.2
 ;;^UTILITY(U,$J,358.3,8019,2)
 ;;=^5008890
 ;;^UTILITY(U,$J,358.3,8020,0)
 ;;=K86.3^^45^446^33
 ;;^UTILITY(U,$J,358.3,8020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8020,1,3,0)
 ;;=3^Pseudocyst of pancreas
 ;;^UTILITY(U,$J,358.3,8020,1,4,0)
 ;;=4^K86.3
 ;;^UTILITY(U,$J,358.3,8020,2)
 ;;=^5008891
 ;;^UTILITY(U,$J,358.3,8021,0)
 ;;=C25.9^^45^446^14
 ;;^UTILITY(U,$J,358.3,8021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8021,1,3,0)
 ;;=3^Malignant neoplasm,Unspec pancreas
 ;;^UTILITY(U,$J,358.3,8021,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,8021,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,8022,0)
 ;;=C25.0^^45^446^9
 ;;^UTILITY(U,$J,358.3,8022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8022,1,3,0)
 ;;=3^Malignant neoplasm,Head
 ;;^UTILITY(U,$J,358.3,8022,1,4,0)
 ;;=4^C25.0
 ;;^UTILITY(U,$J,358.3,8022,2)
 ;;=^267104
 ;;^UTILITY(U,$J,358.3,8023,0)
 ;;=C25.1^^45^446^7
 ;;^UTILITY(U,$J,358.3,8023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8023,1,3,0)
 ;;=3^Malignant neoplasm,Body
 ;;^UTILITY(U,$J,358.3,8023,1,4,0)
 ;;=4^C25.1
 ;;^UTILITY(U,$J,358.3,8023,2)
 ;;=^267105
 ;;^UTILITY(U,$J,358.3,8024,0)
 ;;=C25.2^^45^446^13
 ;;^UTILITY(U,$J,358.3,8024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8024,1,3,0)
 ;;=3^Malignant neoplasm,Tail
 ;;^UTILITY(U,$J,358.3,8024,1,4,0)
 ;;=4^C25.2
 ;;^UTILITY(U,$J,358.3,8024,2)
 ;;=^267106
 ;;^UTILITY(U,$J,358.3,8025,0)
 ;;=C25.3^^45^446^12
 ;;^UTILITY(U,$J,358.3,8025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8025,1,3,0)
 ;;=3^Malignant neoplasm,Pancreatic Duct
 ;;^UTILITY(U,$J,358.3,8025,1,4,0)
 ;;=4^C25.3
 ;;^UTILITY(U,$J,358.3,8025,2)
 ;;=^267107
 ;;^UTILITY(U,$J,358.3,8026,0)
 ;;=C25.4^^45^446^8
 ;;^UTILITY(U,$J,358.3,8026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8026,1,3,0)
 ;;=3^Malignant neoplasm,Endocrine pancreas
 ;;^UTILITY(U,$J,358.3,8026,1,4,0)
 ;;=4^C25.4
 ;;^UTILITY(U,$J,358.3,8026,2)
 ;;=^5000943
 ;;^UTILITY(U,$J,358.3,8027,0)
 ;;=C25.7^^45^446^10
 ;;^UTILITY(U,$J,358.3,8027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8027,1,3,0)
 ;;=3^Malignant neoplasm,Neck
 ;;^UTILITY(U,$J,358.3,8027,1,4,0)
 ;;=4^C25.7
 ;;^UTILITY(U,$J,358.3,8027,2)
 ;;=^5000944
 ;;^UTILITY(U,$J,358.3,8028,0)
 ;;=C25.8^^45^446^11
 ;;^UTILITY(U,$J,358.3,8028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8028,1,3,0)
 ;;=3^Malignant neoplasm,Overlapping sites
 ;;^UTILITY(U,$J,358.3,8028,1,4,0)
 ;;=4^C25.8
 ;;^UTILITY(U,$J,358.3,8028,2)
 ;;=^5000945
 ;;^UTILITY(U,$J,358.3,8029,0)
 ;;=K85.80^^45^446^30
 ;;^UTILITY(U,$J,358.3,8029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8029,1,3,0)
 ;;=3^Pancreatitis,Acute,Other
 ;;^UTILITY(U,$J,358.3,8029,1,4,0)
 ;;=4^K85.80
 ;;^UTILITY(U,$J,358.3,8029,2)
 ;;=^5138758
 ;;^UTILITY(U,$J,358.3,8030,0)
 ;;=K85.81^^45^446^29
 ;;^UTILITY(U,$J,358.3,8030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8030,1,3,0)
 ;;=3^Pancreatitis,Acute Other w/ Uninfected necrosis
 ;;^UTILITY(U,$J,358.3,8030,1,4,0)
 ;;=4^K85.81
 ;;^UTILITY(U,$J,358.3,8030,2)
 ;;=^5138759
 ;;^UTILITY(U,$J,358.3,8031,0)
 ;;=K85.20^^45^446^16
 ;;^UTILITY(U,$J,358.3,8031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8031,1,3,0)
 ;;=3^Pancreatitis,Acute Alcohol 
 ;;^UTILITY(U,$J,358.3,8031,1,4,0)
 ;;=4^K85.20
 ;;^UTILITY(U,$J,358.3,8031,2)
 ;;=^5138752
 ;;^UTILITY(U,$J,358.3,8032,0)
 ;;=K85.21^^45^446^18
 ;;^UTILITY(U,$J,358.3,8032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8032,1,3,0)
 ;;=3^Pancreatitis,Acute Alcohol w/ Uninfected necrosis
 ;;^UTILITY(U,$J,358.3,8032,1,4,0)
 ;;=4^K85.21
 ;;^UTILITY(U,$J,358.3,8032,2)
 ;;=^5138753
 ;;^UTILITY(U,$J,358.3,8033,0)
 ;;=K85.22^^45^446^17
 ;;^UTILITY(U,$J,358.3,8033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8033,1,3,0)
 ;;=3^Pancreatitis,Acute Alcohol w/ Infected necrosis
 ;;^UTILITY(U,$J,358.3,8033,1,4,0)
 ;;=4^K85.22
 ;;^UTILITY(U,$J,358.3,8033,2)
 ;;=^5138754
 ;;^UTILITY(U,$J,358.3,8034,0)
 ;;=K85.10^^45^446^19
 ;;^UTILITY(U,$J,358.3,8034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8034,1,3,0)
 ;;=3^Pancreatitis,Acute Biliary
 ;;^UTILITY(U,$J,358.3,8034,1,4,0)
 ;;=4^K85.10
 ;;^UTILITY(U,$J,358.3,8034,2)
 ;;=^5138749
 ;;^UTILITY(U,$J,358.3,8035,0)
 ;;=K85.11^^45^446^21
 ;;^UTILITY(U,$J,358.3,8035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8035,1,3,0)
 ;;=3^Pancreatitis,Acute Biliary w/ Uninfected necrosis
 ;;^UTILITY(U,$J,358.3,8035,1,4,0)
 ;;=4^K85.11
 ;;^UTILITY(U,$J,358.3,8035,2)
 ;;=^5138750
 ;;^UTILITY(U,$J,358.3,8036,0)
 ;;=K85.12^^45^446^20
 ;;^UTILITY(U,$J,358.3,8036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8036,1,3,0)
 ;;=3^Pancreatitis,Acute Biliary w/ Infected necrosis
 ;;^UTILITY(U,$J,358.3,8036,1,4,0)
 ;;=4^K85.12
 ;;^UTILITY(U,$J,358.3,8036,2)
 ;;=^5138751
 ;;^UTILITY(U,$J,358.3,8037,0)
 ;;=K85.30^^45^446^22
 ;;^UTILITY(U,$J,358.3,8037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8037,1,3,0)
 ;;=3^Pancreatitis,Acute Drug
 ;;^UTILITY(U,$J,358.3,8037,1,4,0)
 ;;=4^K85.30
 ;;^UTILITY(U,$J,358.3,8037,2)
 ;;=^5138755
 ;;^UTILITY(U,$J,358.3,8038,0)
 ;;=K85.31^^45^446^24
 ;;^UTILITY(U,$J,358.3,8038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8038,1,3,0)
 ;;=3^Pancreatitis,Acute Drug w/ Uninfected necrosis
 ;;^UTILITY(U,$J,358.3,8038,1,4,0)
 ;;=4^K85.31
 ;;^UTILITY(U,$J,358.3,8038,2)
 ;;=^5138756
 ;;^UTILITY(U,$J,358.3,8039,0)
 ;;=K85.32^^45^446^23
 ;;^UTILITY(U,$J,358.3,8039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8039,1,3,0)
 ;;=3^Pancreatitis,Acute Drug w/ Infected necrosis
 ;;^UTILITY(U,$J,358.3,8039,1,4,0)
 ;;=4^K85.32
 ;;^UTILITY(U,$J,358.3,8039,2)
 ;;=^5138757
 ;;^UTILITY(U,$J,358.3,8040,0)
 ;;=K85.00^^45^446^25
 ;;^UTILITY(U,$J,358.3,8040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8040,1,3,0)
 ;;=3^Pancreatitis,Acute Idiopathic
 ;;^UTILITY(U,$J,358.3,8040,1,4,0)
 ;;=4^K85.00
 ;;^UTILITY(U,$J,358.3,8040,2)
 ;;=^5138746
 ;;^UTILITY(U,$J,358.3,8041,0)
 ;;=K85.01^^45^446^27
 ;;^UTILITY(U,$J,358.3,8041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8041,1,3,0)
 ;;=3^Pancreatitis,Acute Idiopathic w/ Uninfected necrosis
 ;;^UTILITY(U,$J,358.3,8041,1,4,0)
 ;;=4^K85.01
 ;;^UTILITY(U,$J,358.3,8041,2)
 ;;=^5138747
 ;;^UTILITY(U,$J,358.3,8042,0)
 ;;=K85.02^^45^446^26
 ;;^UTILITY(U,$J,358.3,8042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8042,1,3,0)
 ;;=3^Pancreatitis,Acute Idiopathic w/ Infected necrosis
 ;;^UTILITY(U,$J,358.3,8042,1,4,0)
 ;;=4^K85.02
 ;;^UTILITY(U,$J,358.3,8042,2)
 ;;=^5138748
 ;;^UTILITY(U,$J,358.3,8043,0)
 ;;=R93.3^^45^446^1
 ;;^UTILITY(U,$J,358.3,8043,1,0)
 ;;=^358.31IA^4^2
