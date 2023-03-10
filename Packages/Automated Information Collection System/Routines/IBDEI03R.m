IBDEI03R ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9011,1,3,0)
 ;;=3^Malig Neop Brain,Unspec
 ;;^UTILITY(U,$J,358.3,9011,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,9011,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,9012,0)
 ;;=C18.9^^45^431^125
 ;;^UTILITY(U,$J,358.3,9012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9012,1,3,0)
 ;;=3^Malig Neop Colon,Unspec
 ;;^UTILITY(U,$J,358.3,9012,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,9012,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,9013,0)
 ;;=C49.9^^45^431^126
 ;;^UTILITY(U,$J,358.3,9013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9013,1,3,0)
 ;;=3^Malig Neop Connective/Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,9013,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,9013,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,9014,0)
 ;;=C62.12^^45^431^127
 ;;^UTILITY(U,$J,358.3,9014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9014,1,3,0)
 ;;=3^Malig Neop Descended Left Testis
 ;;^UTILITY(U,$J,358.3,9014,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,9014,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,9015,0)
 ;;=C62.11^^45^431^128
 ;;^UTILITY(U,$J,358.3,9015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9015,1,3,0)
 ;;=3^Malig Neop Descended Right Testis
 ;;^UTILITY(U,$J,358.3,9015,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,9015,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,9016,0)
 ;;=C15.9^^45^431^129
 ;;^UTILITY(U,$J,358.3,9016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9016,1,3,0)
 ;;=3^Malig Neop Esophagus,Unspec
 ;;^UTILITY(U,$J,358.3,9016,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,9016,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,9017,0)
 ;;=C24.0^^45^431^130
 ;;^UTILITY(U,$J,358.3,9017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9017,1,3,0)
 ;;=3^Malig Neop Extrahepatic Bile Duct
 ;;^UTILITY(U,$J,358.3,9017,1,4,0)
 ;;=4^C24.0
 ;;^UTILITY(U,$J,358.3,9017,2)
 ;;=^5000940
 ;;^UTILITY(U,$J,358.3,9018,0)
 ;;=C23.^^45^431^132
 ;;^UTILITY(U,$J,358.3,9018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9018,1,3,0)
 ;;=3^Malig Neop Gallbladder
 ;;^UTILITY(U,$J,358.3,9018,1,4,0)
 ;;=4^C23.
 ;;^UTILITY(U,$J,358.3,9018,2)
 ;;=^267098
 ;;^UTILITY(U,$J,358.3,9019,0)
 ;;=C32.9^^45^431^136
 ;;^UTILITY(U,$J,358.3,9019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9019,1,3,0)
 ;;=3^Malig Neop Larynx,Unspec
 ;;^UTILITY(U,$J,358.3,9019,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,9019,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,9020,0)
 ;;=C64.2^^45^431^140
 ;;^UTILITY(U,$J,358.3,9020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9020,1,3,0)
 ;;=3^Malig Neop Left Kidney,Except Renal Pelvis
 ;;^UTILITY(U,$J,358.3,9020,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,9020,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,9021,0)
 ;;=C65.2^^45^431^143
 ;;^UTILITY(U,$J,358.3,9021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9021,1,3,0)
 ;;=3^Malig Neop Left Renal Pelvis
 ;;^UTILITY(U,$J,358.3,9021,1,4,0)
 ;;=4^C65.2
 ;;^UTILITY(U,$J,358.3,9021,2)
 ;;=^5001252
 ;;^UTILITY(U,$J,358.3,9022,0)
 ;;=C62.92^^45^431^144
 ;;^UTILITY(U,$J,358.3,9022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9022,1,3,0)
 ;;=3^Malig Neop Left Testis,Unspec
 ;;^UTILITY(U,$J,358.3,9022,1,4,0)
 ;;=4^C62.92
 ;;^UTILITY(U,$J,358.3,9022,2)
 ;;=^5001238
 ;;^UTILITY(U,$J,358.3,9023,0)
 ;;=C22.8^^45^431^145
 ;;^UTILITY(U,$J,358.3,9023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9023,1,3,0)
 ;;=3^Malig Neop Liver,Primary
 ;;^UTILITY(U,$J,358.3,9023,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,9023,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,9024,0)
 ;;=C06.9^^45^431^148
 ;;^UTILITY(U,$J,358.3,9024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9024,1,3,0)
 ;;=3^Malig Neop Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,9024,1,4,0)
 ;;=4^C06.9
 ;;^UTILITY(U,$J,358.3,9024,2)
 ;;=^5000901
 ;;^UTILITY(U,$J,358.3,9025,0)
 ;;=C11.9^^45^431^149
 ;;^UTILITY(U,$J,358.3,9025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9025,1,3,0)
 ;;=3^Malig Neop Nasopharynx,Unspec
 ;;^UTILITY(U,$J,358.3,9025,1,4,0)
 ;;=4^C11.9
 ;;^UTILITY(U,$J,358.3,9025,2)
 ;;=^5000911
 ;;^UTILITY(U,$J,358.3,9026,0)
 ;;=C10.9^^45^431^152
 ;;^UTILITY(U,$J,358.3,9026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9026,1,3,0)
 ;;=3^Malig Neop Oropharynx,Unspec
 ;;^UTILITY(U,$J,358.3,9026,1,4,0)
 ;;=4^C10.9
 ;;^UTILITY(U,$J,358.3,9026,2)
 ;;=^5000909
 ;;^UTILITY(U,$J,358.3,9027,0)
 ;;=C25.9^^45^431^153
 ;;^UTILITY(U,$J,358.3,9027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9027,1,3,0)
 ;;=3^Malig Neop Pancreas,Unspec
 ;;^UTILITY(U,$J,358.3,9027,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,9027,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,9028,0)
 ;;=C47.9^^45^431^154
 ;;^UTILITY(U,$J,358.3,9028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9028,1,3,0)
 ;;=3^Malig Neop Peripheral Nerves/Autonomic Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,9028,1,4,0)
 ;;=4^C47.9
 ;;^UTILITY(U,$J,358.3,9028,2)
 ;;=^5001121
 ;;^UTILITY(U,$J,358.3,9029,0)
 ;;=C38.4^^45^431^155
 ;;^UTILITY(U,$J,358.3,9029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9029,1,3,0)
 ;;=3^Malig Neop Pleura
 ;;^UTILITY(U,$J,358.3,9029,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,9029,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,9030,0)
 ;;=C61.^^45^431^156
 ;;^UTILITY(U,$J,358.3,9030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9030,1,3,0)
 ;;=3^Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,9030,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,9030,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,9031,0)
 ;;=C20.^^45^431^157
 ;;^UTILITY(U,$J,358.3,9031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9031,1,3,0)
 ;;=3^Malig Neop Rectum
 ;;^UTILITY(U,$J,358.3,9031,1,4,0)
 ;;=4^C20.
 ;;^UTILITY(U,$J,358.3,9031,2)
 ;;=^267090
 ;;^UTILITY(U,$J,358.3,9032,0)
 ;;=C64.1^^45^431^162
 ;;^UTILITY(U,$J,358.3,9032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9032,1,3,0)
 ;;=3^Malig Neop Right Kidney,Except Renal pelvis
 ;;^UTILITY(U,$J,358.3,9032,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,9032,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,9033,0)
 ;;=C65.1^^45^431^165
 ;;^UTILITY(U,$J,358.3,9033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9033,1,3,0)
 ;;=3^Malig Neop Right Renal Pelvis
 ;;^UTILITY(U,$J,358.3,9033,1,4,0)
 ;;=4^C65.1
 ;;^UTILITY(U,$J,358.3,9033,2)
 ;;=^5001251
 ;;^UTILITY(U,$J,358.3,9034,0)
 ;;=C62.91^^45^431^166
 ;;^UTILITY(U,$J,358.3,9034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9034,1,3,0)
 ;;=3^Malig Neop Right Testis
 ;;^UTILITY(U,$J,358.3,9034,1,4,0)
 ;;=4^C62.91
 ;;^UTILITY(U,$J,358.3,9034,2)
 ;;=^5001237
 ;;^UTILITY(U,$J,358.3,9035,0)
 ;;=C17.9^^45^431^167
 ;;^UTILITY(U,$J,358.3,9035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9035,1,3,0)
 ;;=3^Malig Neop Small Intestine,Unspec
 ;;^UTILITY(U,$J,358.3,9035,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,9035,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,9036,0)
 ;;=C16.9^^45^431^168
 ;;^UTILITY(U,$J,358.3,9036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9036,1,3,0)
 ;;=3^Malig Neop Stomach,Unspec
 ;;^UTILITY(U,$J,358.3,9036,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,9036,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,9037,0)
 ;;=C02.9^^45^431^170
 ;;^UTILITY(U,$J,358.3,9037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9037,1,3,0)
 ;;=3^Malig Neop Tongue,Unspec
 ;;^UTILITY(U,$J,358.3,9037,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,9037,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,9038,0)
 ;;=C64.9^^45^431^135
 ;;^UTILITY(U,$J,358.3,9038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9038,1,3,0)
 ;;=3^Malig Neop Kidney,Except Renal Pelvis,Unspec
 ;;^UTILITY(U,$J,358.3,9038,1,4,0)
 ;;=4^C64.9
 ;;^UTILITY(U,$J,358.3,9038,2)
 ;;=^5001250
 ;;^UTILITY(U,$J,358.3,9039,0)
 ;;=C34.92^^45^431^138
 ;;^UTILITY(U,$J,358.3,9039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9039,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,9039,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,9039,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,9040,0)
 ;;=C34.90^^45^431^124
 ;;^UTILITY(U,$J,358.3,9040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9040,1,3,0)
 ;;=3^Malig Neop Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,9040,1,4,0)
 ;;=4^C34.90
 ;;^UTILITY(U,$J,358.3,9040,2)
 ;;=^5000966
 ;;^UTILITY(U,$J,358.3,9041,0)
 ;;=C65.9^^45^431^158
 ;;^UTILITY(U,$J,358.3,9041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9041,1,3,0)
 ;;=3^Malig Neop Renal Pelvis,Unspec
 ;;^UTILITY(U,$J,358.3,9041,1,4,0)
 ;;=4^C65.9
 ;;^UTILITY(U,$J,358.3,9041,2)
 ;;=^5001253
 ;;^UTILITY(U,$J,358.3,9042,0)
 ;;=C50.912^^45^431^139
 ;;^UTILITY(U,$J,358.3,9042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9042,1,3,0)
 ;;=3^Malig Neop Left Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,9042,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,9042,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,9043,0)
 ;;=C50.911^^45^431^161
 ;;^UTILITY(U,$J,358.3,9043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9043,1,3,0)
 ;;=3^Malig Neop Right Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,9043,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,9043,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,9044,0)
 ;;=C50.919^^45^431^131
 ;;^UTILITY(U,$J,358.3,9044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9044,1,3,0)
 ;;=3^Malig Neop Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,9044,1,4,0)
 ;;=4^C50.919
 ;;^UTILITY(U,$J,358.3,9044,2)
 ;;=^5001197
 ;;^UTILITY(U,$J,358.3,9045,0)
 ;;=C62.90^^45^431^169
 ;;^UTILITY(U,$J,358.3,9045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9045,1,3,0)
 ;;=3^Malig Neop Testis,Unspec
 ;;^UTILITY(U,$J,358.3,9045,1,4,0)
 ;;=4^C62.90
 ;;^UTILITY(U,$J,358.3,9045,2)
 ;;=^5001236
 ;;^UTILITY(U,$J,358.3,9046,0)
 ;;=D03.9^^45^431^174
 ;;^UTILITY(U,$J,358.3,9046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9046,1,3,0)
 ;;=3^Melanoma in Situ,Unspec
 ;;^UTILITY(U,$J,358.3,9046,1,4,0)
 ;;=4^D03.9
 ;;^UTILITY(U,$J,358.3,9046,2)
 ;;=^5001908
 ;;^UTILITY(U,$J,358.3,9047,0)
 ;;=C45.0^^45^431^175
 ;;^UTILITY(U,$J,358.3,9047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9047,1,3,0)
 ;;=3^Mesothelioma of Pleura
 ;;^UTILITY(U,$J,358.3,9047,1,4,0)
 ;;=4^C45.0
 ;;^UTILITY(U,$J,358.3,9047,2)
 ;;=^5001095
 ;;^UTILITY(U,$J,358.3,9048,0)
 ;;=C90.01^^45^431^177
 ;;^UTILITY(U,$J,358.3,9048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9048,1,3,0)
 ;;=3^Multiple Myeloma,In Remission
 ;;^UTILITY(U,$J,358.3,9048,1,4,0)
 ;;=4^C90.01
 ;;^UTILITY(U,$J,358.3,9048,2)
 ;;=^267515
 ;;^UTILITY(U,$J,358.3,9049,0)
 ;;=C90.00^^45^431^178
 ;;^UTILITY(U,$J,358.3,9049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9049,1,3,0)
 ;;=3^Multiple Myeloma,Not in Remission
 ;;^UTILITY(U,$J,358.3,9049,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,9049,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,9050,0)
 ;;=C94.6^^45^431^179
 ;;^UTILITY(U,$J,358.3,9050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9050,1,3,0)
 ;;=3^Myelodysplastic Disease NEC
 ;;^UTILITY(U,$J,358.3,9050,1,4,0)
 ;;=4^C94.6
 ;;^UTILITY(U,$J,358.3,9050,2)
 ;;=^5001846
 ;;^UTILITY(U,$J,358.3,9051,0)
 ;;=D61.82^^45^431^180
 ;;^UTILITY(U,$J,358.3,9051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9051,1,3,0)
 ;;=3^Myelophthisis
 ;;^UTILITY(U,$J,358.3,9051,1,4,0)
 ;;=4^D61.82
 ;;^UTILITY(U,$J,358.3,9051,2)
 ;;=^334037
 ;;^UTILITY(U,$J,358.3,9052,0)
 ;;=D47.9^^45^431^181
 ;;^UTILITY(U,$J,358.3,9052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9052,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,9052,1,4,0)
 ;;=4^D47.9
 ;;^UTILITY(U,$J,358.3,9052,2)
 ;;=^5002260
 ;;^UTILITY(U,$J,358.3,9053,0)
 ;;=D53.9^^45^431^185
 ;;^UTILITY(U,$J,358.3,9053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9053,1,3,0)
 ;;=3^Nutritional Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,9053,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,9053,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,9054,0)
 ;;=D47.4^^45^431^186
 ;;^UTILITY(U,$J,358.3,9054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9054,1,3,0)
 ;;=3^Osteomyelofibrosis
 ;;^UTILITY(U,$J,358.3,9054,1,4,0)
 ;;=4^D47.4
 ;;^UTILITY(U,$J,358.3,9054,2)
 ;;=^5002259
 ;;^UTILITY(U,$J,358.3,9055,0)
 ;;=D51.3^^45^431^210
 ;;^UTILITY(U,$J,358.3,9055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9055,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemia,Other
 ;;^UTILITY(U,$J,358.3,9055,1,4,0)
 ;;=4^D51.3
 ;;^UTILITY(U,$J,358.3,9055,2)
 ;;=^5002287
 ;;^UTILITY(U,$J,358.3,9056,0)
 ;;=D77.^^45^431^62
 ;;^UTILITY(U,$J,358.3,9056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9056,1,3,0)
 ;;=3^Disorder of Blood/Blood-Forming Organs in Diseases Classified Elsewhere,Other
 ;;^UTILITY(U,$J,358.3,9056,1,4,0)
 ;;=4^D77.
 ;;^UTILITY(U,$J,358.3,9056,2)
 ;;=^5002396
 ;;^UTILITY(U,$J,358.3,9057,0)
 ;;=D58.2^^45^431^88
 ;;^UTILITY(U,$J,358.3,9057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9057,1,3,0)
 ;;=3^Hemoglobinopathies,Other
 ;;^UTILITY(U,$J,358.3,9057,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,9057,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,9058,0)
 ;;=C88.8^^45^431^110
 ;;^UTILITY(U,$J,358.3,9058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9058,1,3,0)
 ;;=3^Malig Immunoproliferative Diseases,Other
 ;;^UTILITY(U,$J,358.3,9058,1,4,0)
 ;;=4^C88.8
 ;;^UTILITY(U,$J,358.3,9058,2)
 ;;=^5001750
 ;;^UTILITY(U,$J,358.3,9059,0)
 ;;=D70.8^^45^431^183
 ;;^UTILITY(U,$J,358.3,9059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9059,1,3,0)
 ;;=3^Neutropenia,Other
 ;;^UTILITY(U,$J,358.3,9059,1,4,0)
 ;;=4^D70.8
 ;;^UTILITY(U,$J,358.3,9059,2)
 ;;=^334042
 ;;^UTILITY(U,$J,358.3,9060,0)
 ;;=D59.4^^45^431^184
 ;;^UTILITY(U,$J,358.3,9060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9060,1,3,0)
 ;;=3^Nonautoimmune Hemolytic Anemias,Other
 ;;^UTILITY(U,$J,358.3,9060,1,4,0)
 ;;=4^D59.4
 ;;^UTILITY(U,$J,358.3,9060,2)
 ;;=^5002326
 ;;^UTILITY(U,$J,358.3,9061,0)
 ;;=D69.59^^45^431^190
 ;;^UTILITY(U,$J,358.3,9061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9061,1,3,0)
 ;;=3^Secondary Thrombocytopenia,Other
 ;;^UTILITY(U,$J,358.3,9061,1,4,0)
 ;;=4^D69.59
 ;;^UTILITY(U,$J,358.3,9061,2)
 ;;=^5002369
 ;;^UTILITY(U,$J,358.3,9062,0)
 ;;=C22.7^^45^431^51
 ;;^UTILITY(U,$J,358.3,9062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9062,1,3,0)
 ;;=3^Carcinomas of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,9062,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,9062,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,9063,0)
 ;;=D75.89^^45^431^61
 ;;^UTILITY(U,$J,358.3,9063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9063,1,3,0)
 ;;=3^Diseases of Blood/Blood-Forming Organs,Other Spec
 ;;^UTILITY(U,$J,358.3,9063,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,9063,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,9064,0)
 ;;=D47.Z9^^45^431^182
 ;;^UTILITY(U,$J,358.3,9064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9064,1,3,0)
 ;;=3^Neop Lymphoid,Hematopoietic & Related Tissue,Uncertain Behavior,Other
 ;;^UTILITY(U,$J,358.3,9064,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,9064,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,9065,0)
 ;;=D05.82^^45^431^39
 ;;^UTILITY(U,$J,358.3,9065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9065,1,3,0)
 ;;=3^Carcinoma in Situ Left Breast,Other Spec Type
 ;;^UTILITY(U,$J,358.3,9065,1,4,0)
 ;;=4^D05.82
 ;;^UTILITY(U,$J,358.3,9065,2)
 ;;=^5001934
 ;;^UTILITY(U,$J,358.3,9066,0)
 ;;=D05.81^^45^431^41
 ;;^UTILITY(U,$J,358.3,9066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9066,1,3,0)
 ;;=3^Carcinoma in Situ Right Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,9066,1,4,0)
 ;;=4^D05.81
 ;;^UTILITY(U,$J,358.3,9066,2)
 ;;=^5001933
 ;;^UTILITY(U,$J,358.3,9067,0)
 ;;=D05.80^^45^431^43
 ;;^UTILITY(U,$J,358.3,9067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9067,1,3,0)
 ;;=3^Carcinoma in Situ Unspec Breast,Oth Spec Type
 ;;^UTILITY(U,$J,358.3,9067,1,4,0)
 ;;=4^D05.80
 ;;^UTILITY(U,$J,358.3,9067,2)
 ;;=^5001932
 ;;^UTILITY(U,$J,358.3,9068,0)
 ;;=D56.8^^45^431^205
 ;;^UTILITY(U,$J,358.3,9068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9068,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,9068,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,9068,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,9069,0)
 ;;=C82.89^^45^431^81
 ;;^UTILITY(U,$J,358.3,9069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9069,1,3,0)
 ;;=3^Follicular Lymphoma,Extranodal/Solid Organ Sites,Other Types
 ;;^UTILITY(U,$J,358.3,9069,1,4,0)
 ;;=4^C82.89
 ;;^UTILITY(U,$J,358.3,9069,2)
 ;;=^5001540
 ;;^UTILITY(U,$J,358.3,9070,0)
 ;;=D51.8^^45^431^212
 ;;^UTILITY(U,$J,358.3,9070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9070,1,3,0)
 ;;=3^Vitamin B12 Deficiency Anemias,Other
 ;;^UTILITY(U,$J,358.3,9070,1,4,0)
 ;;=4^D51.8
 ;;^UTILITY(U,$J,358.3,9070,2)
 ;;=^5002288
 ;;^UTILITY(U,$J,358.3,9071,0)
 ;;=I80.9^^45^431^187
 ;;^UTILITY(U,$J,358.3,9071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9071,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,9071,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,9071,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,9072,0)
 ;;=D45.^^45^431^188
 ;;^UTILITY(U,$J,358.3,9072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9072,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,9072,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,9072,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,9073,0)
 ;;=C77.3^^45^431^117
 ;;^UTILITY(U,$J,358.3,9073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9073,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,9073,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,9073,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,9074,0)
 ;;=C77.2^^45^431^133
 ;;^UTILITY(U,$J,358.3,9074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9074,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,9074,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,9074,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,9075,0)
 ;;=C77.1^^45^431^134
 ;;^UTILITY(U,$J,358.3,9075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9075,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,9075,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,9075,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,9076,0)
 ;;=C77.0^^45^431^150
 ;;^UTILITY(U,$J,358.3,9076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9076,1,3,0)
 ;;=3^Malig Neop Nodes of Head,Face and Neck,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,9076,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,9076,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,9077,0)
 ;;=C77.8^^45^431^151
 ;;^UTILITY(U,$J,358.3,9077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9077,1,3,0)
 ;;=3^Malig Neop Nodes of Multiple Regions,Sec and Unspec
 ;;^UTILITY(U,$J,358.3,9077,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,9077,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,9078,0)
 ;;=C79.51^^45^431^121
 ;;^UTILITY(U,$J,358.3,9078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9078,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,9078,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,9078,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,9079,0)
 ;;=C79.52^^45^431^120
 ;;^UTILITY(U,$J,358.3,9079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9079,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
 ;;^UTILITY(U,$J,358.3,9079,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,9079,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,9080,0)
 ;;=C79.31^^45^431^122
 ;;^UTILITY(U,$J,358.3,9080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9080,1,3,0)
 ;;=3^Malig Neop Brain,Secondary
