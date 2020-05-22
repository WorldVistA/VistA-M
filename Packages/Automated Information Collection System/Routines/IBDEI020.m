IBDEI020 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4467,2)
 ;;=^5019338
 ;;^UTILITY(U,$J,358.3,4468,0)
 ;;=R80.9^^34^293^57
 ;;^UTILITY(U,$J,358.3,4468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4468,1,3,0)
 ;;=3^Proteinuria, unspecified
 ;;^UTILITY(U,$J,358.3,4468,1,4,0)
 ;;=4^R80.9
 ;;^UTILITY(U,$J,358.3,4468,2)
 ;;=^5019599
 ;;^UTILITY(U,$J,358.3,4469,0)
 ;;=Z87.442^^34^293^53
 ;;^UTILITY(U,$J,358.3,4469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4469,1,3,0)
 ;;=3^Personal hx of urinary calculi
 ;;^UTILITY(U,$J,358.3,4469,1,4,0)
 ;;=4^Z87.442
 ;;^UTILITY(U,$J,358.3,4469,2)
 ;;=^5063497
 ;;^UTILITY(U,$J,358.3,4470,0)
 ;;=R31.21^^34^293^24
 ;;^UTILITY(U,$J,358.3,4470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4470,1,3,0)
 ;;=3^Hematuria,Microscopic,Asymptomatic
 ;;^UTILITY(U,$J,358.3,4470,1,4,0)
 ;;=4^R31.21
 ;;^UTILITY(U,$J,358.3,4470,2)
 ;;=^5139198
 ;;^UTILITY(U,$J,358.3,4471,0)
 ;;=R31.29^^34^293^25
 ;;^UTILITY(U,$J,358.3,4471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4471,1,3,0)
 ;;=3^Hematuria,Microscopic,Other
 ;;^UTILITY(U,$J,358.3,4471,1,4,0)
 ;;=4^R31.29
 ;;^UTILITY(U,$J,358.3,4471,2)
 ;;=^5019327
 ;;^UTILITY(U,$J,358.3,4472,0)
 ;;=R97.20^^34^293^15
 ;;^UTILITY(U,$J,358.3,4472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4472,1,3,0)
 ;;=3^Elevated PSA
 ;;^UTILITY(U,$J,358.3,4472,1,4,0)
 ;;=4^R97.20
 ;;^UTILITY(U,$J,358.3,4472,2)
 ;;=^334262
 ;;^UTILITY(U,$J,358.3,4473,0)
 ;;=R97.21^^34^293^60
 ;;^UTILITY(U,$J,358.3,4473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4473,1,3,0)
 ;;=3^Rising PSA After Prostate CA Treatment
 ;;^UTILITY(U,$J,358.3,4473,1,4,0)
 ;;=4^R97.21
 ;;^UTILITY(U,$J,358.3,4473,2)
 ;;=^5139228
 ;;^UTILITY(U,$J,358.3,4474,0)
 ;;=C02.9^^34^294^80
 ;;^UTILITY(U,$J,358.3,4474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4474,1,3,0)
 ;;=3^Malignant neoplasm of tongue, unspecified
 ;;^UTILITY(U,$J,358.3,4474,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,4474,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,4475,0)
 ;;=C06.9^^34^294^67
 ;;^UTILITY(U,$J,358.3,4475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4475,1,3,0)
 ;;=3^Malignant neoplasm of mouth, unspecified
 ;;^UTILITY(U,$J,358.3,4475,1,4,0)
 ;;=4^C06.9
 ;;^UTILITY(U,$J,358.3,4475,2)
 ;;=^5000901
 ;;^UTILITY(U,$J,358.3,4476,0)
 ;;=C10.9^^34^294^69
 ;;^UTILITY(U,$J,358.3,4476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4476,1,3,0)
 ;;=3^Malignant neoplasm of oropharynx, unspecified
 ;;^UTILITY(U,$J,358.3,4476,1,4,0)
 ;;=4^C10.9
 ;;^UTILITY(U,$J,358.3,4476,2)
 ;;=^5000909
 ;;^UTILITY(U,$J,358.3,4477,0)
 ;;=C11.9^^34^294^68
 ;;^UTILITY(U,$J,358.3,4477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4477,1,3,0)
 ;;=3^Malignant neoplasm of nasopharynx, unspecified
 ;;^UTILITY(U,$J,358.3,4477,1,4,0)
 ;;=4^C11.9
 ;;^UTILITY(U,$J,358.3,4477,2)
 ;;=^5000911
 ;;^UTILITY(U,$J,358.3,4478,0)
 ;;=C15.9^^34^294^58
 ;;^UTILITY(U,$J,358.3,4478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4478,1,3,0)
 ;;=3^Malignant neoplasm of esophagus, unspecified
 ;;^UTILITY(U,$J,358.3,4478,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,4478,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,4479,0)
 ;;=C16.9^^34^294^78
 ;;^UTILITY(U,$J,358.3,4479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4479,1,3,0)
 ;;=3^Malignant neoplasm of stomach, unspecified
 ;;^UTILITY(U,$J,358.3,4479,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,4479,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,4480,0)
 ;;=C17.9^^34^294^77
 ;;^UTILITY(U,$J,358.3,4480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4480,1,3,0)
 ;;=3^Malignant neoplasm of small intestine, unspecified
 ;;^UTILITY(U,$J,358.3,4480,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,4480,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,4481,0)
 ;;=C18.9^^34^294^54
 ;;^UTILITY(U,$J,358.3,4481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4481,1,3,0)
 ;;=3^Malignant neoplasm of colon, unspecified
 ;;^UTILITY(U,$J,358.3,4481,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,4481,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,4482,0)
 ;;=C20.^^34^294^73
 ;;^UTILITY(U,$J,358.3,4482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4482,1,3,0)
 ;;=3^Malignant neoplasm of rectum
 ;;^UTILITY(U,$J,358.3,4482,1,4,0)
 ;;=4^C20.
 ;;^UTILITY(U,$J,358.3,4482,2)
 ;;=^267090
 ;;^UTILITY(U,$J,358.3,4483,0)
 ;;=C21.0^^34^294^51
 ;;^UTILITY(U,$J,358.3,4483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4483,1,3,0)
 ;;=3^Malignant neoplasm of anus, unspecified
 ;;^UTILITY(U,$J,358.3,4483,1,4,0)
 ;;=4^C21.0
 ;;^UTILITY(U,$J,358.3,4483,2)
 ;;=^5000930
 ;;^UTILITY(U,$J,358.3,4484,0)
 ;;=C22.8^^34^294^66
 ;;^UTILITY(U,$J,358.3,4484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4484,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary, unspecified as to type
 ;;^UTILITY(U,$J,358.3,4484,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,4484,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,4485,0)
 ;;=C22.7^^34^294^22
 ;;^UTILITY(U,$J,358.3,4485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4485,1,3,0)
 ;;=3^Carcinomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,4485,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,4485,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,4486,0)
 ;;=C22.2^^34^294^37
 ;;^UTILITY(U,$J,358.3,4486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4486,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,4486,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,4486,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,4487,0)
 ;;=C22.0^^34^294^44
 ;;^UTILITY(U,$J,358.3,4487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4487,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,4487,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,4487,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,4488,0)
 ;;=C22.4^^34^294^113
 ;;^UTILITY(U,$J,358.3,4488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4488,1,3,0)
 ;;=3^Sarcomas of liver NEC
 ;;^UTILITY(U,$J,358.3,4488,1,4,0)
 ;;=4^C22.4
 ;;^UTILITY(U,$J,358.3,4488,2)
 ;;=^5000937
 ;;^UTILITY(U,$J,358.3,4489,0)
 ;;=C22.3^^34^294^15
 ;;^UTILITY(U,$J,358.3,4489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4489,1,3,0)
 ;;=3^Angiosarcoma of liver
 ;;^UTILITY(U,$J,358.3,4489,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,4489,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,4490,0)
 ;;=C23.^^34^294^60
 ;;^UTILITY(U,$J,358.3,4490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4490,1,3,0)
 ;;=3^Malignant neoplasm of gallbladder
 ;;^UTILITY(U,$J,358.3,4490,1,4,0)
 ;;=4^C23.
 ;;^UTILITY(U,$J,358.3,4490,2)
 ;;=^267098
 ;;^UTILITY(U,$J,358.3,4491,0)
 ;;=C24.0^^34^294^59
 ;;^UTILITY(U,$J,358.3,4491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4491,1,3,0)
 ;;=3^Malignant neoplasm of extrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,4491,1,4,0)
 ;;=4^C24.0
 ;;^UTILITY(U,$J,358.3,4491,2)
 ;;=^5000940
 ;;^UTILITY(U,$J,358.3,4492,0)
 ;;=C24.1^^34^294^50
 ;;^UTILITY(U,$J,358.3,4492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4492,1,3,0)
 ;;=3^Malignant neoplasm of ampulla of Vater
 ;;^UTILITY(U,$J,358.3,4492,1,4,0)
 ;;=4^C24.1
 ;;^UTILITY(U,$J,358.3,4492,2)
 ;;=^267100
 ;;^UTILITY(U,$J,358.3,4493,0)
 ;;=C25.9^^34^294^70
 ;;^UTILITY(U,$J,358.3,4493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4493,1,3,0)
 ;;=3^Malignant neoplasm of pancreas, unspecified
 ;;^UTILITY(U,$J,358.3,4493,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,4493,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,4494,0)
 ;;=C31.9^^34^294^49
 ;;^UTILITY(U,$J,358.3,4494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4494,1,3,0)
 ;;=3^Malignant neoplasm of accessory sinus, unspecified
 ;;^UTILITY(U,$J,358.3,4494,1,4,0)
 ;;=4^C31.9
 ;;^UTILITY(U,$J,358.3,4494,2)
 ;;=^5000953
 ;;^UTILITY(U,$J,358.3,4495,0)
 ;;=C32.9^^34^294^62
 ;;^UTILITY(U,$J,358.3,4495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4495,1,3,0)
 ;;=3^Malignant neoplasm of larynx, unspecified
 ;;^UTILITY(U,$J,358.3,4495,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,4495,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,4496,0)
 ;;=C34.91^^34^294^82
 ;;^UTILITY(U,$J,358.3,4496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4496,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right bronchus or lung
 ;;^UTILITY(U,$J,358.3,4496,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,4496,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,4497,0)
 ;;=C34.92^^34^294^81
 ;;^UTILITY(U,$J,358.3,4497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4497,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of left bronchus or lung
 ;;^UTILITY(U,$J,358.3,4497,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,4497,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,4498,0)
 ;;=C38.4^^34^294^71
 ;;^UTILITY(U,$J,358.3,4498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4498,1,3,0)
 ;;=3^Malignant neoplasm of pleura
 ;;^UTILITY(U,$J,358.3,4498,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,4498,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,4499,0)
 ;;=C45.0^^34^294^86
 ;;^UTILITY(U,$J,358.3,4499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4499,1,3,0)
 ;;=3^Mesothelioma of pleura
 ;;^UTILITY(U,$J,358.3,4499,1,4,0)
 ;;=4^C45.0
 ;;^UTILITY(U,$J,358.3,4499,2)
 ;;=^5001095
 ;;^UTILITY(U,$J,358.3,4500,0)
 ;;=C49.9^^34^294^55
 ;;^UTILITY(U,$J,358.3,4500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4500,1,3,0)
 ;;=3^Malignant neoplasm of connective and soft tissue, unsp
 ;;^UTILITY(U,$J,358.3,4500,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,4500,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,4501,0)
 ;;=C43.9^^34^294^48
 ;;^UTILITY(U,$J,358.3,4501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4501,1,3,0)
 ;;=3^Malignant melanoma of skin, unspecified
 ;;^UTILITY(U,$J,358.3,4501,1,4,0)
 ;;=4^C43.9
 ;;^UTILITY(U,$J,358.3,4501,2)
 ;;=^5001015
 ;;^UTILITY(U,$J,358.3,4502,0)
 ;;=D03.9^^34^294^85
 ;;^UTILITY(U,$J,358.3,4502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4502,1,3,0)
 ;;=3^Melanoma in situ, unspecified
 ;;^UTILITY(U,$J,358.3,4502,1,4,0)
 ;;=4^D03.9
 ;;^UTILITY(U,$J,358.3,4502,2)
 ;;=^5001908
 ;;^UTILITY(U,$J,358.3,4503,0)
 ;;=C50.911^^34^294^84
 ;;^UTILITY(U,$J,358.3,4503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4503,1,3,0)
 ;;=3^Malignant neoplasm of unsp site of right female breast
 ;;^UTILITY(U,$J,358.3,4503,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,4503,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,4504,0)
 ;;=C50.912^^34^294^83
 ;;^UTILITY(U,$J,358.3,4504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4504,1,3,0)
 ;;=3^Malignant neoplasm of unsp site of left female breast
 ;;^UTILITY(U,$J,358.3,4504,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,4504,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,4505,0)
 ;;=C46.9^^34^294^43
 ;;^UTILITY(U,$J,358.3,4505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4505,1,3,0)
 ;;=3^Kaposi's sarcoma, unspecified
 ;;^UTILITY(U,$J,358.3,4505,1,4,0)
 ;;=4^C46.9
 ;;^UTILITY(U,$J,358.3,4505,2)
 ;;=^5001108
 ;;^UTILITY(U,$J,358.3,4506,0)
 ;;=C61.^^34^294^72
 ;;^UTILITY(U,$J,358.3,4506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4506,1,3,0)
 ;;=3^Malignant neoplasm of prostate
 ;;^UTILITY(U,$J,358.3,4506,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,4506,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,4507,0)
 ;;=C62.11^^34^294^57
 ;;^UTILITY(U,$J,358.3,4507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4507,1,3,0)
 ;;=3^Malignant neoplasm of descended right testis
 ;;^UTILITY(U,$J,358.3,4507,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,4507,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,4508,0)
 ;;=C62.12^^34^294^56
 ;;^UTILITY(U,$J,358.3,4508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4508,1,3,0)
 ;;=3^Malignant neoplasm of descended left testis
 ;;^UTILITY(U,$J,358.3,4508,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,4508,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,4509,0)
 ;;=C62.91^^34^294^76
 ;;^UTILITY(U,$J,358.3,4509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4509,1,3,0)
 ;;=3^Malignant neoplasm of right testis, unsp descended or undescended
 ;;^UTILITY(U,$J,358.3,4509,1,4,0)
 ;;=4^C62.91
 ;;^UTILITY(U,$J,358.3,4509,2)
 ;;=^5001237
 ;;^UTILITY(U,$J,358.3,4510,0)
 ;;=C62.92^^34^294^65
 ;;^UTILITY(U,$J,358.3,4510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4510,1,3,0)
 ;;=3^Malignant neoplasm of left testis, unsp descended or undescended
 ;;^UTILITY(U,$J,358.3,4510,1,4,0)
 ;;=4^C62.92
 ;;^UTILITY(U,$J,358.3,4510,2)
 ;;=^5001238
 ;;^UTILITY(U,$J,358.3,4511,0)
 ;;=C67.9^^34^294^52
 ;;^UTILITY(U,$J,358.3,4511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4511,1,3,0)
 ;;=3^Malignant neoplasm of bladder, unspecified
 ;;^UTILITY(U,$J,358.3,4511,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,4511,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,4512,0)
 ;;=C64.2^^34^294^63
 ;;^UTILITY(U,$J,358.3,4512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4512,1,3,0)
 ;;=3^Malignant neoplasm of left kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,4512,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,4512,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,4513,0)
 ;;=C64.1^^34^294^74
 ;;^UTILITY(U,$J,358.3,4513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4513,1,3,0)
 ;;=3^Malignant neoplasm of right kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,4513,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,4513,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,4514,0)
 ;;=C65.1^^34^294^75
 ;;^UTILITY(U,$J,358.3,4514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4514,1,3,0)
 ;;=3^Malignant neoplasm of right renal pelvis
 ;;^UTILITY(U,$J,358.3,4514,1,4,0)
 ;;=4^C65.1
 ;;^UTILITY(U,$J,358.3,4514,2)
 ;;=^5001251
 ;;^UTILITY(U,$J,358.3,4515,0)
 ;;=C65.2^^34^294^64
 ;;^UTILITY(U,$J,358.3,4515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4515,1,3,0)
 ;;=3^Malignant neoplasm of left renal pelvis
 ;;^UTILITY(U,$J,358.3,4515,1,4,0)
 ;;=4^C65.2
 ;;^UTILITY(U,$J,358.3,4515,2)
 ;;=^5001252
 ;;^UTILITY(U,$J,358.3,4516,0)
 ;;=C71.9^^34^294^53
 ;;^UTILITY(U,$J,358.3,4516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4516,1,3,0)
 ;;=3^Malignant neoplasm of brain, unspecified
 ;;^UTILITY(U,$J,358.3,4516,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,4516,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,4517,0)
 ;;=C73.^^34^294^79
 ;;^UTILITY(U,$J,358.3,4517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4517,1,3,0)
 ;;=3^Malignant neoplasm of thyroid gland
 ;;^UTILITY(U,$J,358.3,4517,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,4517,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,4518,0)
 ;;=C76.0^^34^294^61
 ;;^UTILITY(U,$J,358.3,4518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4518,1,3,0)
 ;;=3^Malignant neoplasm of head, face and neck
 ;;^UTILITY(U,$J,358.3,4518,1,4,0)
 ;;=4^C76.0
 ;;^UTILITY(U,$J,358.3,4518,2)
 ;;=^5001324
 ;;^UTILITY(U,$J,358.3,4519,0)
 ;;=C77.0^^34^294^115
 ;;^UTILITY(U,$J,358.3,4519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4519,1,3,0)
 ;;=3^Secondary and unsp malig neoplasm of nodes of head, face and neck
 ;;^UTILITY(U,$J,358.3,4519,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,4519,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,4520,0)
 ;;=C77.1^^34^294^117
 ;;^UTILITY(U,$J,358.3,4520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4520,1,3,0)
 ;;=3^Secondary and unsp malignant neoplasm of intrathorac nodes
 ;;^UTILITY(U,$J,358.3,4520,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,4520,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,4521,0)
 ;;=C77.2^^34^294^118
 ;;^UTILITY(U,$J,358.3,4521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4521,1,3,0)
 ;;=3^Secondary and unsp malignant neoplasm of intra-abd nodes
 ;;^UTILITY(U,$J,358.3,4521,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,4521,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,4522,0)
 ;;=C77.3^^34^294^114
 ;;^UTILITY(U,$J,358.3,4522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4522,1,3,0)
 ;;=3^Secondary and unsp malig neoplasm of axilla and upper limb nodes
 ;;^UTILITY(U,$J,358.3,4522,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,4522,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,4523,0)
 ;;=C77.8^^34^294^116
 ;;^UTILITY(U,$J,358.3,4523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4523,1,3,0)
 ;;=3^Secondary and unsp malig neoplasm of nodes of multiple regions
 ;;^UTILITY(U,$J,358.3,4523,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,4523,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,4524,0)
 ;;=C78.01^^34^294^126
 ;;^UTILITY(U,$J,358.3,4524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4524,1,3,0)
 ;;=3^Secondary malignant neoplasm of right lung
 ;;^UTILITY(U,$J,358.3,4524,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,4524,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,4525,0)
 ;;=C78.02^^34^294^123
 ;;^UTILITY(U,$J,358.3,4525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4525,1,3,0)
 ;;=3^Secondary malignant neoplasm of left lung
 ;;^UTILITY(U,$J,358.3,4525,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,4525,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,4526,0)
 ;;=C78.7^^34^294^124
 ;;^UTILITY(U,$J,358.3,4526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4526,1,3,0)
 ;;=3^Secondary malignant neoplasm of liver/intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,4526,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,4526,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,4527,0)
 ;;=C79.31^^34^294^121
 ;;^UTILITY(U,$J,358.3,4527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4527,1,3,0)
 ;;=3^Secondary malignant neoplasm of brain
 ;;^UTILITY(U,$J,358.3,4527,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,4527,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,4528,0)
 ;;=C79.51^^34^294^119
 ;;^UTILITY(U,$J,358.3,4528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4528,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone
 ;;^UTILITY(U,$J,358.3,4528,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,4528,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,4529,0)
 ;;=C79.52^^34^294^120
 ;;^UTILITY(U,$J,358.3,4529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4529,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone marrow
 ;;^UTILITY(U,$J,358.3,4529,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,4529,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,4530,0)
 ;;=C79.71^^34^294^125
 ;;^UTILITY(U,$J,358.3,4530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4530,1,3,0)
 ;;=3^Secondary malignant neoplasm of right adrenal gland
 ;;^UTILITY(U,$J,358.3,4530,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,4530,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,4531,0)
 ;;=C79.72^^34^294^122
 ;;^UTILITY(U,$J,358.3,4531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4531,1,3,0)
 ;;=3^Secondary malignant neoplasm of left adrenal gland
 ;;^UTILITY(U,$J,358.3,4531,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,4531,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,4532,0)
 ;;=C83.50^^34^294^46
 ;;^UTILITY(U,$J,358.3,4532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4532,1,3,0)
 ;;=3^Lymphoblastic (diffuse) lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,4532,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,4532,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,4533,0)
 ;;=C83.59^^34^294^47
 ;;^UTILITY(U,$J,358.3,4533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4533,1,3,0)
 ;;=3^Lymphoblastic lymphoma, extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,4533,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,4533,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,4534,0)
 ;;=C83.70^^34^294^18
 ;;^UTILITY(U,$J,358.3,4534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4534,1,3,0)
 ;;=3^Burkitt lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,4534,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,4534,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,4535,0)
 ;;=C83.79^^34^294^17
 ;;^UTILITY(U,$J,358.3,4535,1,0)
 ;;=^358.31IA^4^2
