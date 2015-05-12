IBDEI04F ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5413,1,4,0)
 ;;=4^C47.22
 ;;^UTILITY(U,$J,358.3,5413,2)
 ;;=^5001115
 ;;^UTILITY(U,$J,358.3,5414,0)
 ;;=C47.3^^22^243^17
 ;;^UTILITY(U,$J,358.3,5414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5414,1,3,0)
 ;;=3^Malig Neop of Peripheral Nerves of Thorax
 ;;^UTILITY(U,$J,358.3,5414,1,4,0)
 ;;=4^C47.3
 ;;^UTILITY(U,$J,358.3,5414,2)
 ;;=^5001116
 ;;^UTILITY(U,$J,358.3,5415,0)
 ;;=C47.4^^22^243^10
 ;;^UTILITY(U,$J,358.3,5415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5415,1,3,0)
 ;;=3^Malig Neop of Peripheral Nerves of Abdomen
 ;;^UTILITY(U,$J,358.3,5415,1,4,0)
 ;;=4^C47.4
 ;;^UTILITY(U,$J,358.3,5415,2)
 ;;=^5001117
 ;;^UTILITY(U,$J,358.3,5416,0)
 ;;=C47.5^^22^243^14
 ;;^UTILITY(U,$J,358.3,5416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5416,1,3,0)
 ;;=3^Malig Neop of Peripheral Nerves of Pelvis
 ;;^UTILITY(U,$J,358.3,5416,1,4,0)
 ;;=4^C47.5
 ;;^UTILITY(U,$J,358.3,5416,2)
 ;;=^5001118
 ;;^UTILITY(U,$J,358.3,5417,0)
 ;;=C47.6^^22^243^18
 ;;^UTILITY(U,$J,358.3,5417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5417,1,3,0)
 ;;=3^Malig Neop of Peripheral Nerves of Trunck,Unspec
 ;;^UTILITY(U,$J,358.3,5417,1,4,0)
 ;;=4^C47.6
 ;;^UTILITY(U,$J,358.3,5417,2)
 ;;=^5001119
 ;;^UTILITY(U,$J,358.3,5418,0)
 ;;=C48.0^^22^244^4
 ;;^UTILITY(U,$J,358.3,5418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5418,1,3,0)
 ;;=3^Malig Neop of Retroperitoneum
 ;;^UTILITY(U,$J,358.3,5418,1,4,0)
 ;;=4^C48.0
 ;;^UTILITY(U,$J,358.3,5418,2)
 ;;=^267111
 ;;^UTILITY(U,$J,358.3,5419,0)
 ;;=C48.1^^22^244^2
 ;;^UTILITY(U,$J,358.3,5419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5419,1,3,0)
 ;;=3^Malig Neop of Peritoneum
 ;;^UTILITY(U,$J,358.3,5419,1,4,0)
 ;;=4^C48.1
 ;;^UTILITY(U,$J,358.3,5419,2)
 ;;=^267112
 ;;^UTILITY(U,$J,358.3,5420,0)
 ;;=C48.2^^22^244^3
 ;;^UTILITY(U,$J,358.3,5420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5420,1,3,0)
 ;;=3^Malig Neop of Peritoneum,Unspec
 ;;^UTILITY(U,$J,358.3,5420,1,4,0)
 ;;=4^C48.2
 ;;^UTILITY(U,$J,358.3,5420,2)
 ;;=^5001122
 ;;^UTILITY(U,$J,358.3,5421,0)
 ;;=C48.8^^22^244^1
 ;;^UTILITY(U,$J,358.3,5421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5421,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Retroperitoneum/Peritoneum
 ;;^UTILITY(U,$J,358.3,5421,1,4,0)
 ;;=4^C48.8
 ;;^UTILITY(U,$J,358.3,5421,2)
 ;;=^5001123
 ;;^UTILITY(U,$J,358.3,5422,0)
 ;;=C73.^^22^245^14
 ;;^UTILITY(U,$J,358.3,5422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5422,1,3,0)
 ;;=3^Malig Neop of Thyroid Gland
 ;;^UTILITY(U,$J,358.3,5422,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,5422,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,5423,0)
 ;;=C74.01^^22^245^4
 ;;^UTILITY(U,$J,358.3,5423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5423,1,3,0)
 ;;=3^Malig Neop of Cortex of Right Adrenal Gland
 ;;^UTILITY(U,$J,358.3,5423,1,4,0)
 ;;=4^C74.01
 ;;^UTILITY(U,$J,358.3,5423,2)
 ;;=^5001312
 ;;^UTILITY(U,$J,358.3,5424,0)
 ;;=C74.02^^22^245^3
 ;;^UTILITY(U,$J,358.3,5424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5424,1,3,0)
 ;;=3^Malig Neop of Cortex of Left Adrenal Gland
 ;;^UTILITY(U,$J,358.3,5424,1,4,0)
 ;;=4^C74.02
 ;;^UTILITY(U,$J,358.3,5424,2)
 ;;=^5001313
 ;;^UTILITY(U,$J,358.3,5425,0)
 ;;=C74.11^^22^245^9
 ;;^UTILITY(U,$J,358.3,5425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5425,1,3,0)
 ;;=3^Malig Neop of Medulla of Right Adrenal Gland
 ;;^UTILITY(U,$J,358.3,5425,1,4,0)
 ;;=4^C74.11
 ;;^UTILITY(U,$J,358.3,5425,2)
 ;;=^5001315
 ;;^UTILITY(U,$J,358.3,5426,0)
 ;;=C74.12^^22^245^8
 ;;^UTILITY(U,$J,358.3,5426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5426,1,3,0)
 ;;=3^Malig Neop of Medulla of Left Adrenal Gland
 ;;^UTILITY(U,$J,358.3,5426,1,4,0)
 ;;=4^C74.12
 ;;^UTILITY(U,$J,358.3,5426,2)
 ;;=^5001316
 ;;^UTILITY(U,$J,358.3,5427,0)
 ;;=C74.91^^22^245^13
 ;;^UTILITY(U,$J,358.3,5427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5427,1,3,0)
 ;;=3^Malig Neop of Right Adrenal Gland,Unspec
 ;;^UTILITY(U,$J,358.3,5427,1,4,0)
 ;;=4^C74.91
 ;;^UTILITY(U,$J,358.3,5427,2)
 ;;=^5001318
 ;;^UTILITY(U,$J,358.3,5428,0)
 ;;=C74.92^^22^245^7
 ;;^UTILITY(U,$J,358.3,5428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5428,1,3,0)
 ;;=3^Malig Neop of Left Adrenal Gland,Unspec
 ;;^UTILITY(U,$J,358.3,5428,1,4,0)
 ;;=4^C74.92
 ;;^UTILITY(U,$J,358.3,5428,2)
 ;;=^5001319
 ;;^UTILITY(U,$J,358.3,5429,0)
 ;;=C75.0^^22^245^10
 ;;^UTILITY(U,$J,358.3,5429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5429,1,3,0)
 ;;=3^Malig Neop of Parathyroid Gland
 ;;^UTILITY(U,$J,358.3,5429,1,4,0)
 ;;=4^C75.0
 ;;^UTILITY(U,$J,358.3,5429,2)
 ;;=^267299
 ;;^UTILITY(U,$J,358.3,5430,0)
 ;;=C75.1^^22^245^12
 ;;^UTILITY(U,$J,358.3,5430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5430,1,3,0)
 ;;=3^Malig Neop of Pituitary Gland
 ;;^UTILITY(U,$J,358.3,5430,1,4,0)
 ;;=4^C75.1
 ;;^UTILITY(U,$J,358.3,5430,2)
 ;;=^5001320
 ;;^UTILITY(U,$J,358.3,5431,0)
 ;;=C75.2^^22^245^5
 ;;^UTILITY(U,$J,358.3,5431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5431,1,3,0)
 ;;=3^Malig Neop of Craniopharyngeal Duct
 ;;^UTILITY(U,$J,358.3,5431,1,4,0)
 ;;=4^C75.2
 ;;^UTILITY(U,$J,358.3,5431,2)
 ;;=^5001321
 ;;^UTILITY(U,$J,358.3,5432,0)
 ;;=C75.3^^22^245^11
 ;;^UTILITY(U,$J,358.3,5432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5432,1,3,0)
 ;;=3^Malig Neop of Pineal Gland
 ;;^UTILITY(U,$J,358.3,5432,1,4,0)
 ;;=4^C75.3
 ;;^UTILITY(U,$J,358.3,5432,2)
 ;;=^267301
 ;;^UTILITY(U,$J,358.3,5433,0)
 ;;=C75.4^^22^245^2
 ;;^UTILITY(U,$J,358.3,5433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5433,1,3,0)
 ;;=3^Malig Neop of Carotid Body
 ;;^UTILITY(U,$J,358.3,5433,1,4,0)
 ;;=4^C75.4
 ;;^UTILITY(U,$J,358.3,5433,2)
 ;;=^267302
 ;;^UTILITY(U,$J,358.3,5434,0)
 ;;=C75.5^^22^245^1
 ;;^UTILITY(U,$J,358.3,5434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5434,1,3,0)
 ;;=3^Malig Neop of Aortic Body/Paraganglia
 ;;^UTILITY(U,$J,358.3,5434,1,4,0)
 ;;=4^C75.5
 ;;^UTILITY(U,$J,358.3,5434,2)
 ;;=^267303
 ;;^UTILITY(U,$J,358.3,5435,0)
 ;;=C75.8^^22^245^15
 ;;^UTILITY(U,$J,358.3,5435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5435,1,3,0)
 ;;=3^Malig Neop w/ Pluriglandular Involvement,Unspec
 ;;^UTILITY(U,$J,358.3,5435,1,4,0)
 ;;=4^C75.8
 ;;^UTILITY(U,$J,358.3,5435,2)
 ;;=^5001322
 ;;^UTILITY(U,$J,358.3,5436,0)
 ;;=C75.9^^22^245^6
 ;;^UTILITY(U,$J,358.3,5436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5436,1,3,0)
 ;;=3^Malig Neop of Endocrine Gland,Unspec
 ;;^UTILITY(U,$J,358.3,5436,1,4,0)
 ;;=4^C75.9
 ;;^UTILITY(U,$J,358.3,5436,2)
 ;;=^5001323
 ;;^UTILITY(U,$J,358.3,5437,0)
 ;;=C77.0^^22^246^2
 ;;^UTILITY(U,$J,358.3,5437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5437,1,3,0)
 ;;=3^Secondary Malig Neop of Head/Face/Neck Lymph Nodes
 ;;^UTILITY(U,$J,358.3,5437,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,5437,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,5438,0)
 ;;=C77.1^^22^246^6
 ;;^UTILITY(U,$J,358.3,5438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5438,1,3,0)
 ;;=3^Secondary Malig Neop of Intrathoracic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,5438,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,5438,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,5439,0)
 ;;=C77.2^^22^246^4
 ;;^UTILITY(U,$J,358.3,5439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5439,1,3,0)
 ;;=3^Secondary Malig Neop of Intra-Abdominal Lymph Nodes
 ;;^UTILITY(U,$J,358.3,5439,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,5439,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,5440,0)
 ;;=C77.3^^22^246^1
 ;;^UTILITY(U,$J,358.3,5440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5440,1,3,0)
 ;;=3^Secondary Malig Neop of Axilla/Upper Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,5440,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,5440,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,5441,0)
 ;;=C77.4^^22^246^3
 ;;^UTILITY(U,$J,358.3,5441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5441,1,3,0)
 ;;=3^Secondary Malig Neop of Inguinal/Lower Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,5441,1,4,0)
 ;;=4^C77.4
 ;;^UTILITY(U,$J,358.3,5441,2)
 ;;=^5001331
 ;;^UTILITY(U,$J,358.3,5442,0)
 ;;=C77.5^^22^246^5
 ;;^UTILITY(U,$J,358.3,5442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5442,1,3,0)
 ;;=3^Secondary Malig Neop of Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,5442,1,4,0)
 ;;=4^C77.5
 ;;^UTILITY(U,$J,358.3,5442,2)
 ;;=^267319
 ;;^UTILITY(U,$J,358.3,5443,0)
 ;;=C77.8^^22^246^7
 ;;^UTILITY(U,$J,358.3,5443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5443,1,3,0)
 ;;=3^Secondary Malig Neop of Lymph Nodes of Mult Regions
 ;;^UTILITY(U,$J,358.3,5443,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,5443,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,5444,0)
 ;;=C77.9^^22^246^8
 ;;^UTILITY(U,$J,358.3,5444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5444,1,3,0)
 ;;=3^Secondary Malig Neop of Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,5444,1,4,0)
 ;;=4^C77.9
 ;;^UTILITY(U,$J,358.3,5444,2)
 ;;=^5001333
 ;;^UTILITY(U,$J,358.3,5445,0)
 ;;=C78.01^^22^247^11
 ;;^UTILITY(U,$J,358.3,5445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5445,1,3,0)
 ;;=3^Secondary Malig Neop of Right Lung
 ;;^UTILITY(U,$J,358.3,5445,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,5445,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,5446,0)
 ;;=C78.02^^22^247^4
 ;;^UTILITY(U,$J,358.3,5446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5446,1,3,0)
 ;;=3^Secondary Malig Neop of Left Lung
 ;;^UTILITY(U,$J,358.3,5446,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,5446,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,5447,0)
 ;;=C78.1^^22^247^6
 ;;^UTILITY(U,$J,358.3,5447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5447,1,3,0)
 ;;=3^Secondary Malig Neop of Mediastinum
 ;;^UTILITY(U,$J,358.3,5447,1,4,0)
 ;;=4^C78.1
 ;;^UTILITY(U,$J,358.3,5447,2)
 ;;=^267323
 ;;^UTILITY(U,$J,358.3,5448,0)
 ;;=C78.2^^22^247^7
 ;;^UTILITY(U,$J,358.3,5448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5448,1,3,0)
 ;;=3^Secondary Malig Neop of Pleura
 ;;^UTILITY(U,$J,358.3,5448,1,4,0)
 ;;=4^C78.2
 ;;^UTILITY(U,$J,358.3,5448,2)
 ;;=^267324
 ;;^UTILITY(U,$J,358.3,5449,0)
 ;;=C78.30^^22^247^8
 ;;^UTILITY(U,$J,358.3,5449,1,0)
 ;;=^358.31IA^4^2
