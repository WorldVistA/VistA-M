IBDEI033 ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7315,0)
 ;;=K70.11^^42^386^10
 ;;^UTILITY(U,$J,358.3,7315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7315,1,3,0)
 ;;=3^Alcoholic hepatitis (Acute) w/ Ascites
 ;;^UTILITY(U,$J,358.3,7315,1,4,0)
 ;;=4^K70.11
 ;;^UTILITY(U,$J,358.3,7315,2)
 ;;=^5008786
 ;;^UTILITY(U,$J,358.3,7316,0)
 ;;=K70.30^^42^386^7
 ;;^UTILITY(U,$J,358.3,7316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7316,1,3,0)
 ;;=3^Alcoholic cirrhosis w/o Ascites
 ;;^UTILITY(U,$J,358.3,7316,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,7316,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,7317,0)
 ;;=K70.31^^42^386^6
 ;;^UTILITY(U,$J,358.3,7317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7317,1,3,0)
 ;;=3^Alcoholic cirrhosis w/ Ascites
 ;;^UTILITY(U,$J,358.3,7317,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,7317,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,7318,0)
 ;;=K70.9^^42^386^12
 ;;^UTILITY(U,$J,358.3,7318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7318,1,3,0)
 ;;=3^Alcoholic liver disease,unspecified
 ;;^UTILITY(U,$J,358.3,7318,1,4,0)
 ;;=4^K70.9
 ;;^UTILITY(U,$J,358.3,7318,2)
 ;;=^5008792
 ;;^UTILITY(U,$J,358.3,7319,0)
 ;;=C22.7^^42^386^74
 ;;^UTILITY(U,$J,358.3,7319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7319,1,3,0)
 ;;=3^Malignant Neop Liver,Primary,Non-HCC
 ;;^UTILITY(U,$J,358.3,7319,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,7319,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,7320,0)
 ;;=C78.7^^42^386^76
 ;;^UTILITY(U,$J,358.3,7320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7320,1,3,0)
 ;;=3^Malignant Neop Liver,Secondary (Metastases)
 ;;^UTILITY(U,$J,358.3,7320,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,7320,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,7321,0)
 ;;=B17.11^^42^386^56
 ;;^UTILITY(U,$J,358.3,7321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7321,1,3,0)
 ;;=3^Hepatitis C,Acute w/ Coma
 ;;^UTILITY(U,$J,358.3,7321,1,4,0)
 ;;=4^B17.11
 ;;^UTILITY(U,$J,358.3,7321,2)
 ;;=^331777
 ;;^UTILITY(U,$J,358.3,7322,0)
 ;;=B17.10^^42^386^57
 ;;^UTILITY(U,$J,358.3,7322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7322,1,3,0)
 ;;=3^Hepatitis C,Acute w/o Coma
 ;;^UTILITY(U,$J,358.3,7322,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,7322,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,7323,0)
 ;;=B18.0^^42^386^53
 ;;^UTILITY(U,$J,358.3,7323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7323,1,3,0)
 ;;=3^Hepatitis B,Chronic w/ Delta
 ;;^UTILITY(U,$J,358.3,7323,1,4,0)
 ;;=4^B18.0
 ;;^UTILITY(U,$J,358.3,7323,2)
 ;;=^5000546
 ;;^UTILITY(U,$J,358.3,7324,0)
 ;;=K75.4^^42^386^16
 ;;^UTILITY(U,$J,358.3,7324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7324,1,3,0)
 ;;=3^Autoimmune Hepatitis
 ;;^UTILITY(U,$J,358.3,7324,1,4,0)
 ;;=4^K75.4
 ;;^UTILITY(U,$J,358.3,7324,2)
 ;;=^336610
 ;;^UTILITY(U,$J,358.3,7325,0)
 ;;=R93.2^^42^386^1
 ;;^UTILITY(U,$J,358.3,7325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7325,1,3,0)
 ;;=3^Abnormal imaging Liver
 ;;^UTILITY(U,$J,358.3,7325,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,7325,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,7326,0)
 ;;=R94.5^^42^386^2
 ;;^UTILITY(U,$J,358.3,7326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7326,1,3,0)
 ;;=3^Abnormal liver function studies
 ;;^UTILITY(U,$J,358.3,7326,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,7326,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,7327,0)
 ;;=K70.41^^42^386^8
 ;;^UTILITY(U,$J,358.3,7327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7327,1,3,0)
 ;;=3^Alcoholic hepatic failure w/ Coma
 ;;^UTILITY(U,$J,358.3,7327,1,4,0)
 ;;=4^K70.41
 ;;^UTILITY(U,$J,358.3,7327,2)
 ;;=^5008791
 ;;^UTILITY(U,$J,358.3,7328,0)
 ;;=K70.40^^42^386^9
 ;;^UTILITY(U,$J,358.3,7328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7328,1,3,0)
 ;;=3^Alcoholic hepatic failure w/o Coma
 ;;^UTILITY(U,$J,358.3,7328,1,4,0)
 ;;=4^K70.40
 ;;^UTILITY(U,$J,358.3,7328,2)
 ;;=^5008790
 ;;^UTILITY(U,$J,358.3,7329,0)
 ;;=D13.4^^42^386^17
 ;;^UTILITY(U,$J,358.3,7329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7329,1,3,0)
 ;;=3^Benign neoplasm of Liver
 ;;^UTILITY(U,$J,358.3,7329,1,4,0)
 ;;=4^D13.4
 ;;^UTILITY(U,$J,358.3,7329,2)
 ;;=^5001976
 ;;^UTILITY(U,$J,358.3,7330,0)
 ;;=Z90.81^^42^386^4
 ;;^UTILITY(U,$J,358.3,7330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7330,1,3,0)
 ;;=3^Acquired absence of Spleen
 ;;^UTILITY(U,$J,358.3,7330,1,4,0)
 ;;=4^Z90.81
 ;;^UTILITY(U,$J,358.3,7330,2)
 ;;=^5063597
 ;;^UTILITY(U,$J,358.3,7331,0)
 ;;=F10.188^^42^386^5
 ;;^UTILITY(U,$J,358.3,7331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7331,1,3,0)
 ;;=3^Alcohol abuse w/ Other Complication
 ;;^UTILITY(U,$J,358.3,7331,1,4,0)
 ;;=4^F10.188
 ;;^UTILITY(U,$J,358.3,7331,2)
 ;;=^5003079
 ;;^UTILITY(U,$J,358.3,7332,0)
 ;;=E88.01^^42^386^13
 ;;^UTILITY(U,$J,358.3,7332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7332,1,3,0)
 ;;=3^Alpha-1-Antitrypsin deficiency
 ;;^UTILITY(U,$J,358.3,7332,1,4,0)
 ;;=4^E88.01
 ;;^UTILITY(U,$J,358.3,7332,2)
 ;;=^331442
 ;;^UTILITY(U,$J,358.3,7333,0)
 ;;=R18.8^^42^386^14
 ;;^UTILITY(U,$J,358.3,7333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7333,1,3,0)
 ;;=3^Ascites
 ;;^UTILITY(U,$J,358.3,7333,1,4,0)
 ;;=4^R18.8
 ;;^UTILITY(U,$J,358.3,7333,2)
 ;;=^5019253
 ;;^UTILITY(U,$J,358.3,7334,0)
 ;;=R18.0^^42^386^15
 ;;^UTILITY(U,$J,358.3,7334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7334,1,3,0)
 ;;=3^Ascites,Malignant
 ;;^UTILITY(U,$J,358.3,7334,1,4,0)
 ;;=4^R18.0
 ;;^UTILITY(U,$J,358.3,7334,2)
 ;;=^5019252
 ;;^UTILITY(U,$J,358.3,7335,0)
 ;;=I82.0^^42^386^18
 ;;^UTILITY(U,$J,358.3,7335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7335,1,3,0)
 ;;=3^Budd-Chiari syndrome
 ;;^UTILITY(U,$J,358.3,7335,1,4,0)
 ;;=4^I82.0
 ;;^UTILITY(U,$J,358.3,7335,2)
 ;;=^5007846
 ;;^UTILITY(U,$J,358.3,7336,0)
 ;;=K76.1^^42^386^21
 ;;^UTILITY(U,$J,358.3,7336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7336,1,3,0)
 ;;=3^Congestive hepatopathy (Chronic Passive)
 ;;^UTILITY(U,$J,358.3,7336,1,4,0)
 ;;=4^K76.1
 ;;^UTILITY(U,$J,358.3,7336,2)
 ;;=^270307
 ;;^UTILITY(U,$J,358.3,7337,0)
 ;;=Q44.6^^42^386^22
 ;;^UTILITY(U,$J,358.3,7337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7337,1,3,0)
 ;;=3^Cystic disease of Liver
 ;;^UTILITY(U,$J,358.3,7337,1,4,0)
 ;;=4^Q44.6
 ;;^UTILITY(U,$J,358.3,7337,2)
 ;;=^5018697
 ;;^UTILITY(U,$J,358.3,7338,0)
 ;;=B25.1^^42^386^23
 ;;^UTILITY(U,$J,358.3,7338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7338,1,3,0)
 ;;=3^Cytomegaloviral hepatitis
 ;;^UTILITY(U,$J,358.3,7338,1,4,0)
 ;;=4^B25.1
 ;;^UTILITY(U,$J,358.3,7338,2)
 ;;=^5000557
 ;;^UTILITY(U,$J,358.3,7339,0)
 ;;=R60.0^^42^386^25
 ;;^UTILITY(U,$J,358.3,7339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7339,1,3,0)
 ;;=3^Edema,Localized
 ;;^UTILITY(U,$J,358.3,7339,1,4,0)
 ;;=4^R60.0
 ;;^UTILITY(U,$J,358.3,7339,2)
 ;;=^5019532
 ;;^UTILITY(U,$J,358.3,7340,0)
 ;;=I85.01^^42^386^26
 ;;^UTILITY(U,$J,358.3,7340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7340,1,3,0)
 ;;=3^Esophageal varices w/ Bleeding
 ;;^UTILITY(U,$J,358.3,7340,1,4,0)
 ;;=4^I85.01
 ;;^UTILITY(U,$J,358.3,7340,2)
 ;;=^269835
 ;;^UTILITY(U,$J,358.3,7341,0)
 ;;=I85.00^^42^386^27
 ;;^UTILITY(U,$J,358.3,7341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7341,1,3,0)
 ;;=3^Esophageal varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,7341,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,7341,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,7342,0)
 ;;=K76.89^^42^386^31
 ;;^UTILITY(U,$J,358.3,7342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7342,1,3,0)
 ;;=3^Focal nodular hyperplasia
 ;;^UTILITY(U,$J,358.3,7342,1,4,0)
 ;;=4^K76.89
 ;;^UTILITY(U,$J,358.3,7342,2)
 ;;=^5008835
 ;;^UTILITY(U,$J,358.3,7343,0)
 ;;=I86.4^^42^386^32
 ;;^UTILITY(U,$J,358.3,7343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7343,1,3,0)
 ;;=3^Gastric varices
 ;;^UTILITY(U,$J,358.3,7343,1,4,0)
 ;;=4^I86.4
 ;;^UTILITY(U,$J,358.3,7343,2)
 ;;=^49382
 ;;^UTILITY(U,$J,358.3,7344,0)
 ;;=D18.03^^42^386^34
 ;;^UTILITY(U,$J,358.3,7344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7344,1,3,0)
 ;;=3^Hemagioma of Liver
 ;;^UTILITY(U,$J,358.3,7344,1,4,0)
 ;;=4^D18.03
 ;;^UTILITY(U,$J,358.3,7344,2)
 ;;=^267702
 ;;^UTILITY(U,$J,358.3,7345,0)
 ;;=E83.111^^42^386^36
 ;;^UTILITY(U,$J,358.3,7345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7345,1,3,0)
 ;;=3^Hemochromatosis,Secondary (transfusions)
 ;;^UTILITY(U,$J,358.3,7345,1,4,0)
 ;;=4^E83.111
 ;;^UTILITY(U,$J,358.3,7345,2)
 ;;=^5002994
 ;;^UTILITY(U,$J,358.3,7346,0)
 ;;=E83.110^^42^386^35
 ;;^UTILITY(U,$J,358.3,7346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7346,1,3,0)
 ;;=3^Hemochromatosis,Hereditary
 ;;^UTILITY(U,$J,358.3,7346,1,4,0)
 ;;=4^E83.110
 ;;^UTILITY(U,$J,358.3,7346,2)
 ;;=^339602
 ;;^UTILITY(U,$J,358.3,7347,0)
 ;;=K72.01^^42^386^38
 ;;^UTILITY(U,$J,358.3,7347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7347,1,3,0)
 ;;=3^Hepatic Failure,Acute w/ Coma
 ;;^UTILITY(U,$J,358.3,7347,1,4,0)
 ;;=4^K72.01
 ;;^UTILITY(U,$J,358.3,7347,2)
 ;;=^5008806
 ;;^UTILITY(U,$J,358.3,7348,0)
 ;;=K72.00^^42^386^39
 ;;^UTILITY(U,$J,358.3,7348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7348,1,3,0)
 ;;=3^Hepatic Failure,Acute w/o Coma
 ;;^UTILITY(U,$J,358.3,7348,1,4,0)
 ;;=4^K72.00
 ;;^UTILITY(U,$J,358.3,7348,2)
 ;;=^5008805
 ;;^UTILITY(U,$J,358.3,7349,0)
 ;;=K72.11^^42^386^40
 ;;^UTILITY(U,$J,358.3,7349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7349,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/ Coma
 ;;^UTILITY(U,$J,358.3,7349,1,4,0)
 ;;=4^K72.11
 ;;^UTILITY(U,$J,358.3,7349,2)
 ;;=^5008808
 ;;^UTILITY(U,$J,358.3,7350,0)
 ;;=K72.10^^42^386^41
 ;;^UTILITY(U,$J,358.3,7350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7350,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/o Coma
 ;;^UTILITY(U,$J,358.3,7350,1,4,0)
 ;;=4^K72.10
 ;;^UTILITY(U,$J,358.3,7350,2)
 ;;=^5008807
 ;;^UTILITY(U,$J,358.3,7351,0)
 ;;=K76.5^^42^386^45
 ;;^UTILITY(U,$J,358.3,7351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7351,1,3,0)
 ;;=3^Hepatic veno-occlusive disease
 ;;^UTILITY(U,$J,358.3,7351,1,4,0)
 ;;=4^K76.5
 ;;^UTILITY(U,$J,358.3,7351,2)
 ;;=^56249
 ;;^UTILITY(U,$J,358.3,7352,0)
 ;;=B15.0^^42^386^46
 ;;^UTILITY(U,$J,358.3,7352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7352,1,3,0)
 ;;=3^Hepatitis A,Acute w/ Coma
 ;;^UTILITY(U,$J,358.3,7352,1,4,0)
 ;;=4^B15.0
 ;;^UTILITY(U,$J,358.3,7352,2)
 ;;=^5000535
 ;;^UTILITY(U,$J,358.3,7353,0)
 ;;=B15.9^^42^386^47
 ;;^UTILITY(U,$J,358.3,7353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7353,1,3,0)
 ;;=3^Hepatitis A,Acute w/o Coma
 ;;^UTILITY(U,$J,358.3,7353,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,7353,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,7354,0)
 ;;=B16.0^^42^386^49
 ;;^UTILITY(U,$J,358.3,7354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7354,1,3,0)
 ;;=3^Hepatitis B,Acute w/ Coma & Delta
 ;;^UTILITY(U,$J,358.3,7354,1,4,0)
 ;;=4^B16.0
 ;;^UTILITY(U,$J,358.3,7354,2)
 ;;=^5000537
 ;;^UTILITY(U,$J,358.3,7355,0)
 ;;=B16.2^^42^386^50
 ;;^UTILITY(U,$J,358.3,7355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7355,1,3,0)
 ;;=3^Hepatitis B,Acute w/ Coma no Delta
 ;;^UTILITY(U,$J,358.3,7355,1,4,0)
 ;;=4^B16.2
 ;;^UTILITY(U,$J,358.3,7355,2)
 ;;=^5000539
 ;;^UTILITY(U,$J,358.3,7356,0)
 ;;=B16.1^^42^386^51
 ;;^UTILITY(U,$J,358.3,7356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7356,1,3,0)
 ;;=3^Hepatitis B,Acute w/ Delta no Coma
 ;;^UTILITY(U,$J,358.3,7356,1,4,0)
 ;;=4^B16.1
 ;;^UTILITY(U,$J,358.3,7356,2)
 ;;=^5000538
 ;;^UTILITY(U,$J,358.3,7357,0)
 ;;=B16.9^^42^386^52
 ;;^UTILITY(U,$J,358.3,7357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7357,1,3,0)
 ;;=3^Hepatitis B,Acute,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7357,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,7357,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,7358,0)
 ;;=B19.10^^42^386^55
 ;;^UTILITY(U,$J,358.3,7358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7358,1,3,0)
 ;;=3^Hepatitis B,Unspec w/o Coma
 ;;^UTILITY(U,$J,358.3,7358,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,7358,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,7359,0)
 ;;=B17.0^^42^386^48
 ;;^UTILITY(U,$J,358.3,7359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7359,1,3,0)
 ;;=3^Hepatitis B,Acute Superinfection
 ;;^UTILITY(U,$J,358.3,7359,1,4,0)
 ;;=4^B17.0
 ;;^UTILITY(U,$J,358.3,7359,2)
 ;;=^5000541
 ;;^UTILITY(U,$J,358.3,7360,0)
 ;;=B17.2^^42^386^59
 ;;^UTILITY(U,$J,358.3,7360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7360,1,3,0)
 ;;=3^Hepatitis E,Acute
 ;;^UTILITY(U,$J,358.3,7360,1,4,0)
 ;;=4^B17.2
 ;;^UTILITY(U,$J,358.3,7360,2)
 ;;=^5000543
 ;;^UTILITY(U,$J,358.3,7361,0)
 ;;=Z12.89^^42^386^61
 ;;^UTILITY(U,$J,358.3,7361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7361,1,3,0)
 ;;=3^Hepatocellular carcinoma screening
 ;;^UTILITY(U,$J,358.3,7361,1,4,0)
 ;;=4^Z12.89
 ;;^UTILITY(U,$J,358.3,7361,2)
 ;;=^5062697
 ;;^UTILITY(U,$J,358.3,7362,0)
 ;;=R16.2^^42^386^63
 ;;^UTILITY(U,$J,358.3,7362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7362,1,3,0)
 ;;=3^Hepatomegaly w/ Splenomegaly NEC
 ;;^UTILITY(U,$J,358.3,7362,1,4,0)
 ;;=4^R16.2
 ;;^UTILITY(U,$J,358.3,7362,2)
 ;;=^5019250
 ;;^UTILITY(U,$J,358.3,7363,0)
 ;;=R16.0^^42^386^62
 ;;^UTILITY(U,$J,358.3,7363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7363,1,3,0)
 ;;=3^Hepatomegaly NEC
 ;;^UTILITY(U,$J,358.3,7363,1,4,0)
 ;;=4^R16.0
 ;;^UTILITY(U,$J,358.3,7363,2)
 ;;=^5019248
 ;;^UTILITY(U,$J,358.3,7364,0)
 ;;=K76.81^^42^386^64
 ;;^UTILITY(U,$J,358.3,7364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7364,1,3,0)
 ;;=3^Hepatopulmonary syndrome
 ;;^UTILITY(U,$J,358.3,7364,1,4,0)
 ;;=4^K76.81
 ;;^UTILITY(U,$J,358.3,7364,2)
 ;;=^340555
 ;;^UTILITY(U,$J,358.3,7365,0)
 ;;=K76.3^^42^386^66
 ;;^UTILITY(U,$J,358.3,7365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7365,1,3,0)
 ;;=3^Infarction of Liver
 ;;^UTILITY(U,$J,358.3,7365,1,4,0)
 ;;=4^K76.3
 ;;^UTILITY(U,$J,358.3,7365,2)
 ;;=^5008833
 ;;^UTILITY(U,$J,358.3,7366,0)
 ;;=R79.89^^42^386^67
 ;;^UTILITY(U,$J,358.3,7366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7366,1,3,0)
 ;;=3^Iron metabolism,Hyperferritinemia
 ;;^UTILITY(U,$J,358.3,7366,1,4,0)
 ;;=4^R79.89
 ;;^UTILITY(U,$J,358.3,7366,2)
 ;;=^5019593
 ;;^UTILITY(U,$J,358.3,7367,0)
 ;;=R79.0^^42^386^68
 ;;^UTILITY(U,$J,358.3,7367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7367,1,3,0)
 ;;=3^Iron metabolism,Iron levels abnormal
 ;;^UTILITY(U,$J,358.3,7367,1,4,0)
 ;;=4^R79.0
 ;;^UTILITY(U,$J,358.3,7367,2)
 ;;=^5019590
 ;;^UTILITY(U,$J,358.3,7368,0)
 ;;=T86.42^^42^386^70
 ;;^UTILITY(U,$J,358.3,7368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7368,1,3,0)
 ;;=3^Liver transplant failure
 ;;^UTILITY(U,$J,358.3,7368,1,4,0)
 ;;=4^T86.42
 ;;^UTILITY(U,$J,358.3,7368,2)
 ;;=^5055726
 ;;^UTILITY(U,$J,358.3,7369,0)
 ;;=T86.43^^42^386^71
 ;;^UTILITY(U,$J,358.3,7369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7369,1,3,0)
 ;;=3^Liver transplant infection
 ;;^UTILITY(U,$J,358.3,7369,1,4,0)
 ;;=4^T86.43
 ;;^UTILITY(U,$J,358.3,7369,2)
 ;;=^5055727
 ;;^UTILITY(U,$J,358.3,7370,0)
 ;;=T86.41^^42^386^72
 ;;^UTILITY(U,$J,358.3,7370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7370,1,3,0)
 ;;=3^Liver transplant rejection
 ;;^UTILITY(U,$J,358.3,7370,1,4,0)
 ;;=4^T86.41
 ;;^UTILITY(U,$J,358.3,7370,2)
 ;;=^5055725
 ;;^UTILITY(U,$J,358.3,7371,0)
 ;;=Z94.4^^42^386^73
 ;;^UTILITY(U,$J,358.3,7371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7371,1,3,0)
 ;;=3^Liver transplant status
 ;;^UTILITY(U,$J,358.3,7371,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,7371,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,7372,0)
 ;;=C22.0^^42^386^60
 ;;^UTILITY(U,$J,358.3,7372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7372,1,3,0)
 ;;=3^Hepatocellular Carcinoma
 ;;^UTILITY(U,$J,358.3,7372,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,7372,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,7373,0)
 ;;=J90.^^42^386^78
 ;;^UTILITY(U,$J,358.3,7373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7373,1,3,0)
 ;;=3^Pleural effusion NEC
 ;;^UTILITY(U,$J,358.3,7373,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,7373,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,7374,0)
 ;;=K74.3^^42^386^82
 ;;^UTILITY(U,$J,358.3,7374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7374,1,3,0)
 ;;=3^Primary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,7374,1,4,0)
 ;;=4^K74.3
 ;;^UTILITY(U,$J,358.3,7374,2)
 ;;=^5008819
 ;;^UTILITY(U,$J,358.3,7375,0)
 ;;=K76.6^^42^386^79
 ;;^UTILITY(U,$J,358.3,7375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7375,1,3,0)
 ;;=3^Portal hypertension
 ;;^UTILITY(U,$J,358.3,7375,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,7375,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,7376,0)
 ;;=K31.89^^42^386^80
 ;;^UTILITY(U,$J,358.3,7376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7376,1,3,0)
 ;;=3^Portal hypertension gastropathy
 ;;^UTILITY(U,$J,358.3,7376,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,7376,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,7377,0)
 ;;=I81.^^42^386^81
 ;;^UTILITY(U,$J,358.3,7377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7377,1,3,0)
 ;;=3^Portal vein thrombosis
 ;;^UTILITY(U,$J,358.3,7377,1,4,0)
 ;;=4^I81.
 ;;^UTILITY(U,$J,358.3,7377,2)
 ;;=^269815
 ;;^UTILITY(U,$J,358.3,7378,0)
 ;;=K74.4^^42^386^83
 ;;^UTILITY(U,$J,358.3,7378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7378,1,3,0)
 ;;=3^Secondary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,7378,1,4,0)
 ;;=4^K74.4
 ;;^UTILITY(U,$J,358.3,7378,2)
 ;;=^5008820
 ;;^UTILITY(U,$J,358.3,7379,0)
 ;;=K65.2^^42^386^85
 ;;^UTILITY(U,$J,358.3,7379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7379,1,3,0)
 ;;=3^Spontaneous bacterial peritonitis
 ;;^UTILITY(U,$J,358.3,7379,1,4,0)
 ;;=4^K65.2
 ;;^UTILITY(U,$J,358.3,7379,2)
 ;;=^332801
 ;;^UTILITY(U,$J,358.3,7380,0)
 ;;=K71.2^^42^386^87
 ;;^UTILITY(U,$J,358.3,7380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7380,1,3,0)
 ;;=3^Toxic liver disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,7380,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,7380,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,7381,0)
 ;;=K71.3^^42^386^89
 ;;^UTILITY(U,$J,358.3,7381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7381,1,3,0)
 ;;=3^Toxic liver disease w/ Chronic Hepatitis
 ;;^UTILITY(U,$J,358.3,7381,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,7381,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,7382,0)
 ;;=K71.0^^42^386^88
 ;;^UTILITY(U,$J,358.3,7382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7382,1,3,0)
 ;;=3^Toxic liver disease w/ Cholestasis
 ;;^UTILITY(U,$J,358.3,7382,1,4,0)
 ;;=4^K71.0
 ;;^UTILITY(U,$J,358.3,7382,2)
 ;;=^5008793
 ;;^UTILITY(U,$J,358.3,7383,0)
 ;;=K71.10^^42^386^91
 ;;^UTILITY(U,$J,358.3,7383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7383,1,3,0)
 ;;=3^Toxic liver disease w/ Hepatic Necrosis
 ;;^UTILITY(U,$J,358.3,7383,1,4,0)
 ;;=4^K71.10
 ;;^UTILITY(U,$J,358.3,7383,2)
 ;;=^5008794
 ;;^UTILITY(U,$J,358.3,7384,0)
 ;;=K71.6^^42^386^92
 ;;^UTILITY(U,$J,358.3,7384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7384,1,3,0)
 ;;=3^Toxic liver disease w/ Hepatitis
 ;;^UTILITY(U,$J,358.3,7384,1,4,0)
 ;;=4^K71.6
 ;;^UTILITY(U,$J,358.3,7384,2)
 ;;=^5008801
 ;;^UTILITY(U,$J,358.3,7385,0)
 ;;=K71.11^^42^386^90
 ;;^UTILITY(U,$J,358.3,7385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7385,1,3,0)
 ;;=3^Toxic liver disease w/ Coma
 ;;^UTILITY(U,$J,358.3,7385,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,7385,2)
 ;;=^5008795
