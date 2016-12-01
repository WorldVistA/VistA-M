IBDEI05C ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6605,2)
 ;;=^5002285
 ;;^UTILITY(U,$J,358.3,6606,0)
 ;;=D51.9^^26^402^188
 ;;^UTILITY(U,$J,358.3,6606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6606,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,6606,1,4,0)
 ;;=4^D51.9
 ;;^UTILITY(U,$J,358.3,6606,2)
 ;;=^5002289
 ;;^UTILITY(U,$J,358.3,6607,0)
 ;;=D68.0^^26^402^190
 ;;^UTILITY(U,$J,358.3,6607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6607,1,3,0)
 ;;=3^Von Willebrand's Disease
 ;;^UTILITY(U,$J,358.3,6607,1,4,0)
 ;;=4^D68.0
 ;;^UTILITY(U,$J,358.3,6607,2)
 ;;=^127267
 ;;^UTILITY(U,$J,358.3,6608,0)
 ;;=C88.0^^26^402^191
 ;;^UTILITY(U,$J,358.3,6608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6608,1,3,0)
 ;;=3^Waldenstrom Macroglobulinemia
 ;;^UTILITY(U,$J,358.3,6608,1,4,0)
 ;;=4^C88.0
 ;;^UTILITY(U,$J,358.3,6608,2)
 ;;=^5001748
 ;;^UTILITY(U,$J,358.3,6609,0)
 ;;=C91.02^^26^402^3
 ;;^UTILITY(U,$J,358.3,6609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6609,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,6609,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,6609,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,6610,0)
 ;;=C92.02^^26^402^6
 ;;^UTILITY(U,$J,358.3,6610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6610,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,6610,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,6610,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,6611,0)
 ;;=D09.3^^26^402^43
 ;;^UTILITY(U,$J,358.3,6611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6611,1,3,0)
 ;;=3^Carcinoma in Situ of Thyroid/Oth Endocrine Glands
 ;;^UTILITY(U,$J,358.3,6611,1,4,0)
 ;;=4^D09.3
 ;;^UTILITY(U,$J,358.3,6611,2)
 ;;=^5001955
 ;;^UTILITY(U,$J,358.3,6612,0)
 ;;=C22.0^^26^402^84
 ;;^UTILITY(U,$J,358.3,6612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6612,1,3,0)
 ;;=3^Hepatocellular Carcinoma
 ;;^UTILITY(U,$J,358.3,6612,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,6612,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,6613,0)
 ;;=C24.9^^26^402^108
 ;;^UTILITY(U,$J,358.3,6613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6613,1,3,0)
 ;;=3^Malig Neop Biliary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,6613,1,4,0)
 ;;=4^C24.9
 ;;^UTILITY(U,$J,358.3,6613,2)
 ;;=^5000942
 ;;^UTILITY(U,$J,358.3,6614,0)
 ;;=C50.922^^26^402^132
 ;;^UTILITY(U,$J,358.3,6614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6614,1,3,0)
 ;;=3^Malig Neop Left Male Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,6614,1,4,0)
 ;;=4^C50.922
 ;;^UTILITY(U,$J,358.3,6614,2)
 ;;=^5133340
 ;;^UTILITY(U,$J,358.3,6615,0)
 ;;=C34.91^^26^402^150
 ;;^UTILITY(U,$J,358.3,6615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6615,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,6615,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,6615,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,6616,0)
 ;;=C50.921^^26^402^154
 ;;^UTILITY(U,$J,358.3,6616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6616,1,3,0)
 ;;=3^Malig Neop Right Male Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,6616,1,4,0)
 ;;=4^C50.921
 ;;^UTILITY(U,$J,358.3,6616,2)
 ;;=^5001198
 ;;^UTILITY(U,$J,358.3,6617,0)
 ;;=C90.02^^26^402^163
 ;;^UTILITY(U,$J,358.3,6617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6617,1,3,0)
 ;;=3^Multiple Myeloma,In Relapse
 ;;^UTILITY(U,$J,358.3,6617,1,4,0)
 ;;=4^C90.02
 ;;^UTILITY(U,$J,358.3,6617,2)
 ;;=^5001753
 ;;^UTILITY(U,$J,358.3,6618,0)
 ;;=Z85.818^^26^403^92
 ;;^UTILITY(U,$J,358.3,6618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6618,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Lip,Oral Cavity & Pharynx
 ;;^UTILITY(U,$J,358.3,6618,1,4,0)
 ;;=4^Z85.818
 ;;^UTILITY(U,$J,358.3,6618,2)
 ;;=^5063439
 ;;^UTILITY(U,$J,358.3,6619,0)
 ;;=Z85.819^^26^403^93
 ;;^UTILITY(U,$J,358.3,6619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6619,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Lip,Oral Cavity & Pharynx,Unspec
 ;;^UTILITY(U,$J,358.3,6619,1,4,0)
 ;;=4^Z85.819
 ;;^UTILITY(U,$J,358.3,6619,2)
 ;;=^5063440
 ;;^UTILITY(U,$J,358.3,6620,0)
 ;;=Z85.01^^26^403^88
 ;;^UTILITY(U,$J,358.3,6620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6620,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Esophagus
 ;;^UTILITY(U,$J,358.3,6620,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,6620,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,6621,0)
 ;;=Z85.028^^26^403^99
 ;;^UTILITY(U,$J,358.3,6621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6621,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Stomach
 ;;^UTILITY(U,$J,358.3,6621,1,4,0)
 ;;=4^Z85.028
 ;;^UTILITY(U,$J,358.3,6621,2)
 ;;=^5063397
 ;;^UTILITY(U,$J,358.3,6622,0)
 ;;=Z85.038^^26^403^90
 ;;^UTILITY(U,$J,358.3,6622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6622,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Large Intestine
 ;;^UTILITY(U,$J,358.3,6622,1,4,0)
 ;;=4^Z85.038
 ;;^UTILITY(U,$J,358.3,6622,2)
 ;;=^5063399
 ;;^UTILITY(U,$J,358.3,6623,0)
 ;;=Z85.048^^26^403^97
 ;;^UTILITY(U,$J,358.3,6623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6623,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Rectum,Rectosig Junct & Anus
 ;;^UTILITY(U,$J,358.3,6623,1,4,0)
 ;;=4^Z85.048
 ;;^UTILITY(U,$J,358.3,6623,2)
 ;;=^5063401
 ;;^UTILITY(U,$J,358.3,6624,0)
 ;;=Z85.118^^26^403^86
 ;;^UTILITY(U,$J,358.3,6624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6624,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Bronchus & Lung
 ;;^UTILITY(U,$J,358.3,6624,1,4,0)
 ;;=4^Z85.118
 ;;^UTILITY(U,$J,358.3,6624,2)
 ;;=^5063408
 ;;^UTILITY(U,$J,358.3,6625,0)
 ;;=Z85.21^^26^403^91
 ;;^UTILITY(U,$J,358.3,6625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6625,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Larynx
 ;;^UTILITY(U,$J,358.3,6625,1,4,0)
 ;;=4^Z85.21
 ;;^UTILITY(U,$J,358.3,6625,2)
 ;;=^5063411
 ;;^UTILITY(U,$J,358.3,6626,0)
 ;;=Z85.3^^26^403^85
 ;;^UTILITY(U,$J,358.3,6626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6626,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,6626,1,4,0)
 ;;=4^Z85.3
 ;;^UTILITY(U,$J,358.3,6626,2)
 ;;=^5063416
 ;;^UTILITY(U,$J,358.3,6627,0)
 ;;=Z85.41^^26^403^87
 ;;^UTILITY(U,$J,358.3,6627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6627,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Cervix Uteri
 ;;^UTILITY(U,$J,358.3,6627,1,4,0)
 ;;=4^Z85.41
 ;;^UTILITY(U,$J,358.3,6627,2)
 ;;=^5063418
 ;;^UTILITY(U,$J,358.3,6628,0)
 ;;=Z85.43^^26^403^95
 ;;^UTILITY(U,$J,358.3,6628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6628,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Ovary
 ;;^UTILITY(U,$J,358.3,6628,1,4,0)
 ;;=4^Z85.43
 ;;^UTILITY(U,$J,358.3,6628,2)
 ;;=^5063420
 ;;^UTILITY(U,$J,358.3,6629,0)
 ;;=Z85.46^^26^403^96
 ;;^UTILITY(U,$J,358.3,6629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6629,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Prostate
 ;;^UTILITY(U,$J,358.3,6629,1,4,0)
 ;;=4^Z85.46
 ;;^UTILITY(U,$J,358.3,6629,2)
 ;;=^5063423
 ;;^UTILITY(U,$J,358.3,6630,0)
 ;;=Z85.47^^26^403^100
 ;;^UTILITY(U,$J,358.3,6630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6630,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Testis
 ;;^UTILITY(U,$J,358.3,6630,1,4,0)
 ;;=4^Z85.47
 ;;^UTILITY(U,$J,358.3,6630,2)
 ;;=^5063424
 ;;^UTILITY(U,$J,358.3,6631,0)
 ;;=Z85.51^^26^403^84
 ;;^UTILITY(U,$J,358.3,6631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6631,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Bladder
 ;;^UTILITY(U,$J,358.3,6631,1,4,0)
 ;;=4^Z85.51
 ;;^UTILITY(U,$J,358.3,6631,2)
 ;;=^5063428
 ;;^UTILITY(U,$J,358.3,6632,0)
 ;;=Z85.528^^26^403^89
 ;;^UTILITY(U,$J,358.3,6632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6632,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Kidney
 ;;^UTILITY(U,$J,358.3,6632,1,4,0)
 ;;=4^Z85.528
 ;;^UTILITY(U,$J,358.3,6632,2)
 ;;=^5063430
 ;;^UTILITY(U,$J,358.3,6633,0)
 ;;=Z85.6^^26^403^80
 ;;^UTILITY(U,$J,358.3,6633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6633,1,3,0)
 ;;=3^Personal Hx of Leukemia
 ;;^UTILITY(U,$J,358.3,6633,1,4,0)
 ;;=4^Z85.6
 ;;^UTILITY(U,$J,358.3,6633,2)
 ;;=^5063434
 ;;^UTILITY(U,$J,358.3,6634,0)
 ;;=Z85.72^^26^403^104
 ;;^UTILITY(U,$J,358.3,6634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6634,1,3,0)
 ;;=3^Personal Hx of Non-Hodgkin Lymphomas
 ;;^UTILITY(U,$J,358.3,6634,1,4,0)
 ;;=4^Z85.72
 ;;^UTILITY(U,$J,358.3,6634,2)
 ;;=^5063436
 ;;^UTILITY(U,$J,358.3,6635,0)
 ;;=Z85.79^^26^403^94
 ;;^UTILITY(U,$J,358.3,6635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6635,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Lymphoid,Hematpoetc & Rel Tissue
 ;;^UTILITY(U,$J,358.3,6635,1,4,0)
 ;;=4^Z85.79
 ;;^UTILITY(U,$J,358.3,6635,2)
 ;;=^5063437
 ;;^UTILITY(U,$J,358.3,6636,0)
 ;;=Z85.820^^26^403^83
 ;;^UTILITY(U,$J,358.3,6636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6636,1,3,0)
 ;;=3^Personal Hx of Malig Melanoma of Skin
 ;;^UTILITY(U,$J,358.3,6636,1,4,0)
 ;;=4^Z85.820
 ;;^UTILITY(U,$J,358.3,6636,2)
 ;;=^5063441
 ;;^UTILITY(U,$J,358.3,6637,0)
 ;;=Z85.828^^26^403^98
 ;;^UTILITY(U,$J,358.3,6637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6637,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Skin
 ;;^UTILITY(U,$J,358.3,6637,1,4,0)
 ;;=4^Z85.828
 ;;^UTILITY(U,$J,358.3,6637,2)
 ;;=^5063443
 ;;^UTILITY(U,$J,358.3,6638,0)
 ;;=Z85.71^^26^403^78
 ;;^UTILITY(U,$J,358.3,6638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6638,1,3,0)
 ;;=3^Personal Hx of Hodgkin Lymphoma
 ;;^UTILITY(U,$J,358.3,6638,1,4,0)
 ;;=4^Z85.71
 ;;^UTILITY(U,$J,358.3,6638,2)
 ;;=^5063435
 ;;^UTILITY(U,$J,358.3,6639,0)
 ;;=Z65.8^^26^403^138
 ;;^UTILITY(U,$J,358.3,6639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6639,1,3,0)
 ;;=3^Psychosocial Circumstance Related Problems
 ;;^UTILITY(U,$J,358.3,6639,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,6639,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,6640,0)
 ;;=Z86.11^^26^403^115
 ;;^UTILITY(U,$J,358.3,6640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6640,1,3,0)
 ;;=3^Personal Hx of Tuberculosis
 ;;^UTILITY(U,$J,358.3,6640,1,4,0)
 ;;=4^Z86.11
 ;;^UTILITY(U,$J,358.3,6640,2)
 ;;=^5063461
 ;;^UTILITY(U,$J,358.3,6641,0)
 ;;=Z86.13^^26^403^82
 ;;^UTILITY(U,$J,358.3,6641,1,0)
 ;;=^358.31IA^4^2
