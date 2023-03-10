IBDEI00L ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,864,1,4,0)
 ;;=4^C57.01
 ;;^UTILITY(U,$J,358.3,864,2)
 ;;=^5001216
 ;;^UTILITY(U,$J,358.3,865,0)
 ;;=C57.02^^10^67^4
 ;;^UTILITY(U,$J,358.3,865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,865,1,3,0)
 ;;=3^Malignant neoplasm of left fallopian tube
 ;;^UTILITY(U,$J,358.3,865,1,4,0)
 ;;=4^C57.02
 ;;^UTILITY(U,$J,358.3,865,2)
 ;;=^5001217
 ;;^UTILITY(U,$J,358.3,866,0)
 ;;=C52.^^10^67^12
 ;;^UTILITY(U,$J,358.3,866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,866,1,3,0)
 ;;=3^Malignant neoplasm of vagina
 ;;^UTILITY(U,$J,358.3,866,1,4,0)
 ;;=4^C52.
 ;;^UTILITY(U,$J,358.3,866,2)
 ;;=^267232
 ;;^UTILITY(U,$J,358.3,867,0)
 ;;=C51.9^^10^67^13
 ;;^UTILITY(U,$J,358.3,867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,867,1,3,0)
 ;;=3^Malignant neoplasm of vulva, unspecified
 ;;^UTILITY(U,$J,358.3,867,1,4,0)
 ;;=4^C51.9
 ;;^UTILITY(U,$J,358.3,867,2)
 ;;=^5001202
 ;;^UTILITY(U,$J,358.3,868,0)
 ;;=C53.0^^10^67^2
 ;;^UTILITY(U,$J,358.3,868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,868,1,3,0)
 ;;=3^Malignant neoplasm of endocervix
 ;;^UTILITY(U,$J,358.3,868,1,4,0)
 ;;=4^C53.0
 ;;^UTILITY(U,$J,358.3,868,2)
 ;;=^267215
 ;;^UTILITY(U,$J,358.3,869,0)
 ;;=C53.1^^10^67^3
 ;;^UTILITY(U,$J,358.3,869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,869,1,3,0)
 ;;=3^Malignant neoplasm of exocervix
 ;;^UTILITY(U,$J,358.3,869,1,4,0)
 ;;=4^C53.1
 ;;^UTILITY(U,$J,358.3,869,2)
 ;;=^267216
 ;;^UTILITY(U,$J,358.3,870,0)
 ;;=C53.8^^10^67^7
 ;;^UTILITY(U,$J,358.3,870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,870,1,3,0)
 ;;=3^Malignant neoplasm of overlapping sites of cervix uteri
 ;;^UTILITY(U,$J,358.3,870,1,4,0)
 ;;=4^C53.8
 ;;^UTILITY(U,$J,358.3,870,2)
 ;;=^5001203
 ;;^UTILITY(U,$J,358.3,871,0)
 ;;=C79.81^^10^67^14
 ;;^UTILITY(U,$J,358.3,871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,871,1,3,0)
 ;;=3^Secondary Malignant Neoplasm Breast
 ;;^UTILITY(U,$J,358.3,871,1,4,0)
 ;;=4^C79.81
 ;;^UTILITY(U,$J,358.3,871,2)
 ;;=^267338
 ;;^UTILITY(U,$J,358.3,872,0)
 ;;=C79.82^^10^67^15
 ;;^UTILITY(U,$J,358.3,872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,872,1,3,0)
 ;;=3^Secondary Malignant Neoplasm Genital Organs (Cervix,Fallopian Tube,Vagina)
 ;;^UTILITY(U,$J,358.3,872,1,4,0)
 ;;=4^C79.82
 ;;^UTILITY(U,$J,358.3,872,2)
 ;;=^267339
 ;;^UTILITY(U,$J,358.3,873,0)
 ;;=C79.60^^10^67^16
 ;;^UTILITY(U,$J,358.3,873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,873,1,3,0)
 ;;=3^Secondary Malignant Neoplasm Unspec Ovary
 ;;^UTILITY(U,$J,358.3,873,1,4,0)
 ;;=4^C79.60
 ;;^UTILITY(U,$J,358.3,873,2)
 ;;=^5001352
 ;;^UTILITY(U,$J,358.3,874,0)
 ;;=D66.^^10^68^16
 ;;^UTILITY(U,$J,358.3,874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,874,1,3,0)
 ;;=3^Hereditary factor VIII deficiency
 ;;^UTILITY(U,$J,358.3,874,1,4,0)
 ;;=4^D66.
 ;;^UTILITY(U,$J,358.3,874,2)
 ;;=^5002353
 ;;^UTILITY(U,$J,358.3,875,0)
 ;;=D67.^^10^68^15
 ;;^UTILITY(U,$J,358.3,875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,875,1,3,0)
 ;;=3^Hereditary factor IX deficiency
 ;;^UTILITY(U,$J,358.3,875,1,4,0)
 ;;=4^D67.
 ;;^UTILITY(U,$J,358.3,875,2)
 ;;=^5002354
 ;;^UTILITY(U,$J,358.3,876,0)
 ;;=D68.1^^10^68^17
 ;;^UTILITY(U,$J,358.3,876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,876,1,3,0)
 ;;=3^Hereditary factor XI deficiency
 ;;^UTILITY(U,$J,358.3,876,1,4,0)
 ;;=4^D68.1
 ;;^UTILITY(U,$J,358.3,876,2)
 ;;=^5002355
 ;;^UTILITY(U,$J,358.3,877,0)
 ;;=D68.2^^10^68^14
 ;;^UTILITY(U,$J,358.3,877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,877,1,3,0)
 ;;=3^Hereditary deficiency of other clotting factors
 ;;^UTILITY(U,$J,358.3,877,1,4,0)
 ;;=4^D68.2
 ;;^UTILITY(U,$J,358.3,877,2)
 ;;=^5002356
 ;;^UTILITY(U,$J,358.3,878,0)
 ;;=D68.0^^10^68^26
 ;;^UTILITY(U,$J,358.3,878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,878,1,3,0)
 ;;=3^Von Willebrand's disease
 ;;^UTILITY(U,$J,358.3,878,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,878,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,879,0)
 ;;=D68.311^^10^68^2
 ;;^UTILITY(U,$J,358.3,879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,879,1,3,0)
 ;;=3^Acquired hemophilia
 ;;^UTILITY(U,$J,358.3,879,1,4,0)
 ;;=4^D68.311
 ;;^UTILITY(U,$J,358.3,879,2)
 ;;=^340502
 ;;^UTILITY(U,$J,358.3,880,0)
 ;;=D68.312^^10^68^4
 ;;^UTILITY(U,$J,358.3,880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,880,1,3,0)
 ;;=3^Antiphospholipid antibody with hemorrhagic disorder
 ;;^UTILITY(U,$J,358.3,880,1,4,0)
 ;;=4^D68.312
 ;;^UTILITY(U,$J,358.3,880,2)
 ;;=^340503
 ;;^UTILITY(U,$J,358.3,881,0)
 ;;=D68.318^^10^68^13
 ;;^UTILITY(U,$J,358.3,881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,881,1,3,0)
 ;;=3^Hemorrhagic disord d/t intrns circ anticoag,antib,inhib NEC
 ;;^UTILITY(U,$J,358.3,881,1,4,0)
 ;;=4^D68.318
 ;;^UTILITY(U,$J,358.3,881,2)
 ;;=^340504
 ;;^UTILITY(U,$J,358.3,882,0)
 ;;=D65.^^10^68^7
 ;;^UTILITY(U,$J,358.3,882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,882,1,3,0)
 ;;=3^Disseminated intravascular coagulation
 ;;^UTILITY(U,$J,358.3,882,1,4,0)
 ;;=4^D65.
 ;;^UTILITY(U,$J,358.3,882,2)
 ;;=^5002352
 ;;^UTILITY(U,$J,358.3,883,0)
 ;;=D68.32^^10^68^12
 ;;^UTILITY(U,$J,358.3,883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,883,1,3,0)
 ;;=3^Hemorrhagic disord d/t extrinsic circulating anticoagulants
 ;;^UTILITY(U,$J,358.3,883,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,883,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,884,0)
 ;;=D68.4^^10^68^1
 ;;^UTILITY(U,$J,358.3,884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,884,1,3,0)
 ;;=3^Acquired coagulation factor deficiency
 ;;^UTILITY(U,$J,358.3,884,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,884,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,885,0)
 ;;=D68.8^^10^68^5
 ;;^UTILITY(U,$J,358.3,885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,885,1,3,0)
 ;;=3^Coagulation Defects NEC
 ;;^UTILITY(U,$J,358.3,885,1,4,0)
 ;;=4^D68.8
 ;;^UTILITY(U,$J,358.3,885,2)
 ;;=^5002363
 ;;^UTILITY(U,$J,358.3,886,0)
 ;;=D68.9^^10^68^6
 ;;^UTILITY(U,$J,358.3,886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,886,1,3,0)
 ;;=3^Coagulation Defects,Unspec
 ;;^UTILITY(U,$J,358.3,886,1,4,0)
 ;;=4^D68.9
 ;;^UTILITY(U,$J,358.3,886,2)
 ;;=^5002364
 ;;^UTILITY(U,$J,358.3,887,0)
 ;;=D69.1^^10^68^22
 ;;^UTILITY(U,$J,358.3,887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,887,1,3,0)
 ;;=3^Qualitative platelet defects
 ;;^UTILITY(U,$J,358.3,887,1,4,0)
 ;;=4^D69.1
 ;;^UTILITY(U,$J,358.3,887,2)
 ;;=^101922
 ;;^UTILITY(U,$J,358.3,888,0)
 ;;=D47.3^^10^68^8
 ;;^UTILITY(U,$J,358.3,888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,888,1,3,0)
 ;;=3^Essential (hemorrhagic) thrombocythemia
 ;;^UTILITY(U,$J,358.3,888,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,888,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,889,0)
 ;;=D69.0^^10^68^3
 ;;^UTILITY(U,$J,358.3,889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,889,1,3,0)
 ;;=3^Allergic purpura
 ;;^UTILITY(U,$J,358.3,889,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,889,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,890,0)
 ;;=D69.2^^10^68^19
 ;;^UTILITY(U,$J,358.3,890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,890,1,3,0)
 ;;=3^Nonthrombocytopenic purpura NEC
 ;;^UTILITY(U,$J,358.3,890,1,4,0)
 ;;=4^D69.2
 ;;^UTILITY(U,$J,358.3,890,2)
 ;;=^5002366
 ;;^UTILITY(U,$J,358.3,891,0)
 ;;=D69.3^^10^68^18
 ;;^UTILITY(U,$J,358.3,891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,891,1,3,0)
 ;;=3^Immune thrombocytopenic purpura
 ;;^UTILITY(U,$J,358.3,891,1,4,0)
 ;;=4^D69.3
 ;;^UTILITY(U,$J,358.3,891,2)
 ;;=^332746
 ;;^UTILITY(U,$J,358.3,892,0)
 ;;=D69.41^^10^68^9
 ;;^UTILITY(U,$J,358.3,892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,892,1,3,0)
 ;;=3^Evans syndrome
 ;;^UTILITY(U,$J,358.3,892,1,4,0)
 ;;=4^D69.41
 ;;^UTILITY(U,$J,358.3,892,2)
 ;;=^332747
 ;;^UTILITY(U,$J,358.3,893,0)
 ;;=D69.51^^10^68^21
 ;;^UTILITY(U,$J,358.3,893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,893,1,3,0)
 ;;=3^Posttransfusion purpura
 ;;^UTILITY(U,$J,358.3,893,1,4,0)
 ;;=4^D69.51
 ;;^UTILITY(U,$J,358.3,893,2)
 ;;=^5002368
 ;;^UTILITY(U,$J,358.3,894,0)
 ;;=D69.59^^10^68^23
 ;;^UTILITY(U,$J,358.3,894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,894,1,3,0)
 ;;=3^Secondary thrombocytopenia NEC
 ;;^UTILITY(U,$J,358.3,894,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,894,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,895,0)
 ;;=D69.8^^10^68^10
 ;;^UTILITY(U,$J,358.3,895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,895,1,3,0)
 ;;=3^Hemorrhagic Conditions NEC
 ;;^UTILITY(U,$J,358.3,895,1,4,0)
 ;;=4^D69.8
 ;;^UTILITY(U,$J,358.3,895,2)
 ;;=^88074
 ;;^UTILITY(U,$J,358.3,896,0)
 ;;=D69.6^^10^68^24
 ;;^UTILITY(U,$J,358.3,896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,896,1,3,0)
 ;;=3^Thrombocytopenia, unspecified
 ;;^UTILITY(U,$J,358.3,896,1,4,0)
 ;;=4^D69.6
 ;;^UTILITY(U,$J,358.3,896,2)
 ;;=^5002370
 ;;^UTILITY(U,$J,358.3,897,0)
 ;;=D69.9^^10^68^11
 ;;^UTILITY(U,$J,358.3,897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,897,1,3,0)
 ;;=3^Hemorrhagic condition, unspecified
 ;;^UTILITY(U,$J,358.3,897,1,4,0)
 ;;=4^D69.9
 ;;^UTILITY(U,$J,358.3,897,2)
 ;;=^5002371
 ;;^UTILITY(U,$J,358.3,898,0)
 ;;=I80.9^^10^68^20
 ;;^UTILITY(U,$J,358.3,898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,898,1,3,0)
 ;;=3^Phlebitis and thrombophlebitis of unspecified site
 ;;^UTILITY(U,$J,358.3,898,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,898,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,899,0)
 ;;=M31.10^^10^68^25
 ;;^UTILITY(U,$J,358.3,899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,899,1,3,0)
 ;;=3^Thrombotic Microangiopathy,Unspec
 ;;^UTILITY(U,$J,358.3,899,1,4,0)
 ;;=4^M31.10
 ;;^UTILITY(U,$J,358.3,899,2)
 ;;=^5161189
 ;;^UTILITY(U,$J,358.3,900,0)
 ;;=Z31.5^^10^69^4
 ;;^UTILITY(U,$J,358.3,900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,900,1,3,0)
 ;;=3^Genetic Counseling
 ;;^UTILITY(U,$J,358.3,900,1,4,0)
 ;;=4^Z31.5
 ;;^UTILITY(U,$J,358.3,900,2)
 ;;=^5062838
 ;;^UTILITY(U,$J,358.3,901,0)
 ;;=Z51.11^^10^69^2
 ;;^UTILITY(U,$J,358.3,901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,901,1,3,0)
 ;;=3^Antineoplastic Chemotherapy
 ;;^UTILITY(U,$J,358.3,901,1,4,0)
 ;;=4^Z51.11
 ;;^UTILITY(U,$J,358.3,901,2)
 ;;=^5063061
 ;;^UTILITY(U,$J,358.3,902,0)
 ;;=Z71.3^^10^69^3
 ;;^UTILITY(U,$J,358.3,902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,902,1,3,0)
 ;;=3^Dietary counseling and surveillance
 ;;^UTILITY(U,$J,358.3,902,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,902,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,903,0)
 ;;=Z71.89^^10^69^8
 ;;^UTILITY(U,$J,358.3,903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,903,1,3,0)
 ;;=3^Specified Counseling NEC
 ;;^UTILITY(U,$J,358.3,903,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,903,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,904,0)
 ;;=Z51.89^^10^69^1
 ;;^UTILITY(U,$J,358.3,904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,904,1,3,0)
 ;;=3^Aftercare NEC
 ;;^UTILITY(U,$J,358.3,904,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,904,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,905,0)
 ;;=Z12.39^^10^69^5
 ;;^UTILITY(U,$J,358.3,905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,905,1,3,0)
 ;;=3^Malig Neop of Breast Screening
 ;;^UTILITY(U,$J,358.3,905,1,4,0)
 ;;=4^Z12.39
 ;;^UTILITY(U,$J,358.3,905,2)
 ;;=^5062686
 ;;^UTILITY(U,$J,358.3,906,0)
 ;;=Z12.4^^10^69^6
 ;;^UTILITY(U,$J,358.3,906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,906,1,3,0)
 ;;=3^Malig Neop of Cervix Screening
 ;;^UTILITY(U,$J,358.3,906,1,4,0)
 ;;=4^Z12.4
 ;;^UTILITY(U,$J,358.3,906,2)
 ;;=^5062687
 ;;^UTILITY(U,$J,358.3,907,0)
 ;;=Z12.12^^10^69^7
 ;;^UTILITY(U,$J,358.3,907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,907,1,3,0)
 ;;=3^Malig Neop of Rectum Screening
 ;;^UTILITY(U,$J,358.3,907,1,4,0)
 ;;=4^Z12.12
 ;;^UTILITY(U,$J,358.3,907,2)
 ;;=^5062682
 ;;^UTILITY(U,$J,358.3,908,0)
 ;;=C61.^^10^70^10
 ;;^UTILITY(U,$J,358.3,908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,908,1,3,0)
 ;;=3^Malignant neoplasm of prostate
 ;;^UTILITY(U,$J,358.3,908,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,908,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,909,0)
 ;;=C62.11^^10^70^5
 ;;^UTILITY(U,$J,358.3,909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,909,1,3,0)
 ;;=3^Malignant neoplasm of descended right testis
 ;;^UTILITY(U,$J,358.3,909,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,909,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,910,0)
 ;;=C62.12^^10^70^4
 ;;^UTILITY(U,$J,358.3,910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,910,1,3,0)
 ;;=3^Malignant neoplasm of descended left testis
 ;;^UTILITY(U,$J,358.3,910,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,910,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,911,0)
 ;;=C62.91^^10^70^2
 ;;^UTILITY(U,$J,358.3,911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,911,1,3,0)
 ;;=3^Malig neoplasm of right testis, unsp descended or undescended
 ;;^UTILITY(U,$J,358.3,911,1,4,0)
 ;;=4^C62.91
 ;;^UTILITY(U,$J,358.3,911,2)
 ;;=^5001237
 ;;^UTILITY(U,$J,358.3,912,0)
 ;;=C62.92^^10^70^1
 ;;^UTILITY(U,$J,358.3,912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,912,1,3,0)
 ;;=3^Malig neoplasm of left testis, unsp descended or undescended
 ;;^UTILITY(U,$J,358.3,912,1,4,0)
 ;;=4^C62.92
 ;;^UTILITY(U,$J,358.3,912,2)
 ;;=^5001238
 ;;^UTILITY(U,$J,358.3,913,0)
 ;;=C60.9^^10^70^9
 ;;^UTILITY(U,$J,358.3,913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,913,1,3,0)
 ;;=3^Malignant neoplasm of penis, unspecified
 ;;^UTILITY(U,$J,358.3,913,1,4,0)
 ;;=4^C60.9
 ;;^UTILITY(U,$J,358.3,913,2)
 ;;=^5001229
 ;;^UTILITY(U,$J,358.3,914,0)
 ;;=C67.9^^10^70^3
 ;;^UTILITY(U,$J,358.3,914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,914,1,3,0)
 ;;=3^Malignant neoplasm of bladder, unspecified
 ;;^UTILITY(U,$J,358.3,914,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,914,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,915,0)
 ;;=C64.2^^10^70^6
 ;;^UTILITY(U,$J,358.3,915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,915,1,3,0)
 ;;=3^Malignant neoplasm of left kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,915,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,915,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,916,0)
 ;;=C64.1^^10^70^11
 ;;^UTILITY(U,$J,358.3,916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,916,1,3,0)
 ;;=3^Malignant neoplasm of right kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,916,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,916,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,917,0)
 ;;=C65.1^^10^70^12
 ;;^UTILITY(U,$J,358.3,917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,917,1,3,0)
 ;;=3^Malignant neoplasm of right renal pelvis
 ;;^UTILITY(U,$J,358.3,917,1,4,0)
 ;;=4^C65.1
 ;;^UTILITY(U,$J,358.3,917,2)
 ;;=^5001251
 ;;^UTILITY(U,$J,358.3,918,0)
 ;;=C65.2^^10^70^7
 ;;^UTILITY(U,$J,358.3,918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,918,1,3,0)
 ;;=3^Malignant neoplasm of left renal pelvis
 ;;^UTILITY(U,$J,358.3,918,1,4,0)
 ;;=4^C65.2
 ;;^UTILITY(U,$J,358.3,918,2)
 ;;=^5001252
 ;;^UTILITY(U,$J,358.3,919,0)
 ;;=C66.1^^10^70^13
 ;;^UTILITY(U,$J,358.3,919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,919,1,3,0)
 ;;=3^Malignant neoplasm of right ureter
 ;;^UTILITY(U,$J,358.3,919,1,4,0)
 ;;=4^C66.1
 ;;^UTILITY(U,$J,358.3,919,2)
 ;;=^5001254
 ;;^UTILITY(U,$J,358.3,920,0)
 ;;=C66.2^^10^70^8
 ;;^UTILITY(U,$J,358.3,920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,920,1,3,0)
 ;;=3^Malignant neoplasm of left ureter
 ;;^UTILITY(U,$J,358.3,920,1,4,0)
 ;;=4^C66.2
 ;;^UTILITY(U,$J,358.3,920,2)
 ;;=^5001255
 ;;^UTILITY(U,$J,358.3,921,0)
 ;;=C68.0^^10^70^14
 ;;^UTILITY(U,$J,358.3,921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,921,1,3,0)
 ;;=3^Malignant neoplasm of urethra
 ;;^UTILITY(U,$J,358.3,921,1,4,0)
 ;;=4^C68.0
 ;;^UTILITY(U,$J,358.3,921,2)
 ;;=^267266
 ;;^UTILITY(U,$J,358.3,922,0)
 ;;=C79.11^^10^70^15
 ;;^UTILITY(U,$J,358.3,922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,922,1,3,0)
 ;;=3^Secondary Malignant Neoplasm Bladder
 ;;^UTILITY(U,$J,358.3,922,1,4,0)
 ;;=4^C79.11
 ;;^UTILITY(U,$J,358.3,922,2)
 ;;=^5001346
 ;;^UTILITY(U,$J,358.3,923,0)
 ;;=C79.82^^10^70^16
 ;;^UTILITY(U,$J,358.3,923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,923,1,3,0)
 ;;=3^Secondary Malignant Neoplasm Genital Organs (Testes,Penis,Prostate)
 ;;^UTILITY(U,$J,358.3,923,1,4,0)
 ;;=4^C79.82
 ;;^UTILITY(U,$J,358.3,923,2)
 ;;=^267339
 ;;^UTILITY(U,$J,358.3,924,0)
 ;;=C79.00^^10^70^18
 ;;^UTILITY(U,$J,358.3,924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,924,1,3,0)
 ;;=3^Secondary Malignant Neoplasm Unspec Kidney & Renal Pelvis
 ;;^UTILITY(U,$J,358.3,924,1,4,0)
 ;;=4^C79.00
 ;;^UTILITY(U,$J,358.3,924,2)
 ;;=^5001342
 ;;^UTILITY(U,$J,358.3,925,0)
 ;;=C79.19^^10^70^17
 ;;^UTILITY(U,$J,358.3,925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,925,1,3,0)
 ;;=3^Secondary Malignant Neoplasm Oth Urinary Organs (Ureter,Urethra)
 ;;^UTILITY(U,$J,358.3,925,1,4,0)
 ;;=4^C79.19
 ;;^UTILITY(U,$J,358.3,925,2)
 ;;=^267332
 ;;^UTILITY(U,$J,358.3,926,0)
 ;;=C15.9^^10^71^9
 ;;^UTILITY(U,$J,358.3,926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,926,1,3,0)
 ;;=3^Malignant neoplasm of esophagus, unspecified
 ;;^UTILITY(U,$J,358.3,926,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,926,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,927,0)
 ;;=C16.9^^10^71^18
 ;;^UTILITY(U,$J,358.3,927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,927,1,3,0)
 ;;=3^Malignant neoplasm of stomach, unspecified
 ;;^UTILITY(U,$J,358.3,927,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,927,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,928,0)
 ;;=C17.9^^10^71^17
 ;;^UTILITY(U,$J,358.3,928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,928,1,3,0)
 ;;=3^Malignant neoplasm of small intestine, unspecified
 ;;^UTILITY(U,$J,358.3,928,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,928,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,929,0)
 ;;=C18.9^^10^71^8
 ;;^UTILITY(U,$J,358.3,929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,929,1,3,0)
 ;;=3^Malignant neoplasm of colon, unspecified
 ;;^UTILITY(U,$J,358.3,929,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,929,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,930,0)
 ;;=C20.^^10^71^16
 ;;^UTILITY(U,$J,358.3,930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,930,1,3,0)
 ;;=3^Malignant neoplasm of rectum
 ;;^UTILITY(U,$J,358.3,930,1,4,0)
 ;;=4^C20.
 ;;^UTILITY(U,$J,358.3,930,2)
 ;;=^267090
 ;;^UTILITY(U,$J,358.3,931,0)
 ;;=C21.0^^10^71^6
 ;;^UTILITY(U,$J,358.3,931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,931,1,3,0)
 ;;=3^Malignant neoplasm of anus, unspecified
 ;;^UTILITY(U,$J,358.3,931,1,4,0)
 ;;=4^C21.0
 ;;^UTILITY(U,$J,358.3,931,2)
 ;;=^5000930
 ;;^UTILITY(U,$J,358.3,932,0)
 ;;=C22.8^^10^71^12
 ;;^UTILITY(U,$J,358.3,932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,932,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary, unspecified as to type
 ;;^UTILITY(U,$J,358.3,932,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,932,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,933,0)
 ;;=C22.7^^10^71^2
 ;;^UTILITY(U,$J,358.3,933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,933,1,3,0)
 ;;=3^Carcinomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,933,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,933,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,934,0)
 ;;=C22.2^^10^71^3
 ;;^UTILITY(U,$J,358.3,934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,934,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,934,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,934,2)
 ;;=^5000935
