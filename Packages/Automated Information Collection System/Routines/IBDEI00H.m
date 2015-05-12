IBDEI00H ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,295,1,3,0)
 ;;=3^Carcinoma of Liver NEC
 ;;^UTILITY(U,$J,358.3,295,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,295,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,296,0)
 ;;=C22.2^^1^6^13
 ;;^UTILITY(U,$J,358.3,296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,296,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,296,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,296,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,297,0)
 ;;=C22.0^^1^6^14
 ;;^UTILITY(U,$J,358.3,297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,297,1,3,0)
 ;;=3^Liver Cell Carcinoma
 ;;^UTILITY(U,$J,358.3,297,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,297,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,298,0)
 ;;=C22.4^^1^6^15
 ;;^UTILITY(U,$J,358.3,298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,298,1,3,0)
 ;;=3^Liver Sarcomas NEC
 ;;^UTILITY(U,$J,358.3,298,1,4,0)
 ;;=4^C22.4
 ;;^UTILITY(U,$J,358.3,298,2)
 ;;=^5000937
 ;;^UTILITY(U,$J,358.3,299,0)
 ;;=C22.3^^1^6^16
 ;;^UTILITY(U,$J,358.3,299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,299,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,299,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,299,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,300,0)
 ;;=C23.^^1^6^17
 ;;^UTILITY(U,$J,358.3,300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,300,1,3,0)
 ;;=3^Malig Neop of Gallbladder
 ;;^UTILITY(U,$J,358.3,300,1,4,0)
 ;;=4^C23.
 ;;^UTILITY(U,$J,358.3,300,2)
 ;;=^267098
 ;;^UTILITY(U,$J,358.3,301,0)
 ;;=C24.0^^1^6^18
 ;;^UTILITY(U,$J,358.3,301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,301,1,3,0)
 ;;=3^Malig Neop of Extrahepatic Bile Duct
 ;;^UTILITY(U,$J,358.3,301,1,4,0)
 ;;=4^C24.0
 ;;^UTILITY(U,$J,358.3,301,2)
 ;;=^5000940
 ;;^UTILITY(U,$J,358.3,302,0)
 ;;=C24.1^^1^6^19
 ;;^UTILITY(U,$J,358.3,302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,302,1,3,0)
 ;;=3^Malig Neop of Ampulla of Vater
 ;;^UTILITY(U,$J,358.3,302,1,4,0)
 ;;=4^C24.1
 ;;^UTILITY(U,$J,358.3,302,2)
 ;;=^267100
 ;;^UTILITY(U,$J,358.3,303,0)
 ;;=C25.9^^1^6^20
 ;;^UTILITY(U,$J,358.3,303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,303,1,3,0)
 ;;=3^Malig Neop of Pancreas,Unspec
 ;;^UTILITY(U,$J,358.3,303,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,303,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,304,0)
 ;;=C31.9^^1^6^21
 ;;^UTILITY(U,$J,358.3,304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,304,1,3,0)
 ;;=3^Malig Neop of Accessory Sinus,Unspec
 ;;^UTILITY(U,$J,358.3,304,1,4,0)
 ;;=4^C31.9
 ;;^UTILITY(U,$J,358.3,304,2)
 ;;=^5000953
 ;;^UTILITY(U,$J,358.3,305,0)
 ;;=C32.9^^1^6^22
 ;;^UTILITY(U,$J,358.3,305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,305,1,3,0)
 ;;=3^Malig Neop of Larynx,Unspec
 ;;^UTILITY(U,$J,358.3,305,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,305,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,306,0)
 ;;=C34.91^^1^6^23
 ;;^UTILITY(U,$J,358.3,306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,306,1,3,0)
 ;;=3^Malig Neop of Right Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,306,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,306,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,307,0)
 ;;=C34.92^^1^6^24
 ;;^UTILITY(U,$J,358.3,307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,307,1,3,0)
 ;;=3^Malig Neop of Left Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,307,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,307,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,308,0)
 ;;=C38.4^^1^6^25
 ;;^UTILITY(U,$J,358.3,308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,308,1,3,0)
 ;;=3^Malig Neop of Pleura
 ;;^UTILITY(U,$J,358.3,308,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,308,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,309,0)
 ;;=C45.0^^1^6^26
 ;;^UTILITY(U,$J,358.3,309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,309,1,3,0)
 ;;=3^Mesothelioma of Pleura
 ;;^UTILITY(U,$J,358.3,309,1,4,0)
 ;;=4^C45.0
 ;;^UTILITY(U,$J,358.3,309,2)
 ;;=^5001095
 ;;^UTILITY(U,$J,358.3,310,0)
 ;;=C49.9^^1^6^27
 ;;^UTILITY(U,$J,358.3,310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,310,1,3,0)
 ;;=3^Malig Neop of Connective/Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,310,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,310,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,311,0)
 ;;=C43.9^^1^6^28
 ;;^UTILITY(U,$J,358.3,311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,311,1,3,0)
 ;;=3^Malig Melanoma of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,311,1,4,0)
 ;;=4^C43.9
 ;;^UTILITY(U,$J,358.3,311,2)
 ;;=^5001015
 ;;^UTILITY(U,$J,358.3,312,0)
 ;;=C50.912^^1^6^29
 ;;^UTILITY(U,$J,358.3,312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,312,1,3,0)
 ;;=3^Malig Neop of Left Female Breast
 ;;^UTILITY(U,$J,358.3,312,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,312,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,313,0)
 ;;=C50.911^^1^6^30
 ;;^UTILITY(U,$J,358.3,313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,313,1,3,0)
 ;;=3^Malig Neop of Right Female Breast
 ;;^UTILITY(U,$J,358.3,313,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,313,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,314,0)
 ;;=C46.9^^1^6^31
 ;;^UTILITY(U,$J,358.3,314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,314,1,3,0)
 ;;=3^Kaposi's Sarcoma,Unspec
 ;;^UTILITY(U,$J,358.3,314,1,4,0)
 ;;=4^C46.9
 ;;^UTILITY(U,$J,358.3,314,2)
 ;;=^5001108
 ;;^UTILITY(U,$J,358.3,315,0)
 ;;=C61.^^1^6^32
 ;;^UTILITY(U,$J,358.3,315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,315,1,3,0)
 ;;=3^Malig Neop of Prostate
 ;;^UTILITY(U,$J,358.3,315,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,315,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,316,0)
 ;;=C62.12^^1^6^33
 ;;^UTILITY(U,$J,358.3,316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,316,1,3,0)
 ;;=3^Malig Neop of Left Descended Testis
 ;;^UTILITY(U,$J,358.3,316,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,316,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,317,0)
 ;;=C62.11^^1^6^34
 ;;^UTILITY(U,$J,358.3,317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,317,1,3,0)
 ;;=3^Malig Neop of Right Descended Testis
 ;;^UTILITY(U,$J,358.3,317,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,317,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,318,0)
 ;;=C62.92^^1^6^35
 ;;^UTILITY(U,$J,358.3,318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,318,1,3,0)
 ;;=3^Malig Neop of Left Testis
 ;;^UTILITY(U,$J,358.3,318,1,4,0)
 ;;=4^C62.92
 ;;^UTILITY(U,$J,358.3,318,2)
 ;;=^5001238
 ;;^UTILITY(U,$J,358.3,319,0)
 ;;=C62.91^^1^6^36
 ;;^UTILITY(U,$J,358.3,319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,319,1,3,0)
 ;;=3^Malig Neop of Right Testis
 ;;^UTILITY(U,$J,358.3,319,1,4,0)
 ;;=4^C62.91
 ;;^UTILITY(U,$J,358.3,319,2)
 ;;=^5001237
 ;;^UTILITY(U,$J,358.3,320,0)
 ;;=C67.9^^1^6^37
 ;;^UTILITY(U,$J,358.3,320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,320,1,3,0)
 ;;=3^Malig Neop of Bladder,Unspec
 ;;^UTILITY(U,$J,358.3,320,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,320,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,321,0)
 ;;=C64.2^^1^6^38
 ;;^UTILITY(U,$J,358.3,321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,321,1,3,0)
 ;;=3^Malig Neop of Left Kidney,Except Renal Pelvis
 ;;^UTILITY(U,$J,358.3,321,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,321,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,322,0)
 ;;=C64.1^^1^6^39
 ;;^UTILITY(U,$J,358.3,322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,322,1,3,0)
 ;;=3^Malig Neop of Right Kidney,Except Renal Pelvis
 ;;^UTILITY(U,$J,358.3,322,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,322,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,323,0)
 ;;=C65.1^^1^6^40
 ;;^UTILITY(U,$J,358.3,323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,323,1,3,0)
 ;;=3^Malig Neop of Right Renal Pelvis
 ;;^UTILITY(U,$J,358.3,323,1,4,0)
 ;;=4^C65.1
 ;;^UTILITY(U,$J,358.3,323,2)
 ;;=^5001251
 ;;^UTILITY(U,$J,358.3,324,0)
 ;;=C65.2^^1^6^41
 ;;^UTILITY(U,$J,358.3,324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,324,1,3,0)
 ;;=3^Malig Neop of Left Renal Pelvis
 ;;^UTILITY(U,$J,358.3,324,1,4,0)
 ;;=4^C65.2
 ;;^UTILITY(U,$J,358.3,324,2)
 ;;=^5001252
 ;;^UTILITY(U,$J,358.3,325,0)
 ;;=C71.9^^1^6^42
 ;;^UTILITY(U,$J,358.3,325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,325,1,3,0)
 ;;=3^Malig Neop of Brain,Unspec
 ;;^UTILITY(U,$J,358.3,325,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,325,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,326,0)
 ;;=C83.50^^1^6^43
 ;;^UTILITY(U,$J,358.3,326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,326,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,326,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,326,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,327,0)
 ;;=C83.59^^1^6^44
 ;;^UTILITY(U,$J,358.3,327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,327,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,327,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,327,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,328,0)
 ;;=C83.70^^1^6^45
 ;;^UTILITY(U,$J,358.3,328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,328,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,328,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,328,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,329,0)
 ;;=C83.79^^1^6^46
 ;;^UTILITY(U,$J,358.3,329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,329,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,329,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,329,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,330,0)
 ;;=C81.90^^1^6^47
 ;;^UTILITY(U,$J,358.3,330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,330,1,3,0)
 ;;=3^Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,330,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,330,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,331,0)
 ;;=C81.99^^1^6^48
 ;;^UTILITY(U,$J,358.3,331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,331,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,331,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,331,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,332,0)
 ;;=C82.90^^1^6^49
 ;;^UTILITY(U,$J,358.3,332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,332,1,3,0)
 ;;=3^Follicular Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,332,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,332,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,333,0)
 ;;=C82.99^^1^6^50
 ;;^UTILITY(U,$J,358.3,333,1,0)
 ;;=^358.31IA^4^2
