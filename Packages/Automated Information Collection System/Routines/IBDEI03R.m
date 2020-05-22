IBDEI03R ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8980,0)
 ;;=L60.5^^48^478^330
 ;;^UTILITY(U,$J,358.3,8980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8980,1,3,0)
 ;;=3^Yellow Nail Syndrome
 ;;^UTILITY(U,$J,358.3,8980,1,4,0)
 ;;=4^L60.5
 ;;^UTILITY(U,$J,358.3,8980,2)
 ;;=^5009238
 ;;^UTILITY(U,$J,358.3,8981,0)
 ;;=L60.8^^48^478^174
 ;;^UTILITY(U,$J,358.3,8981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8981,1,3,0)
 ;;=3^Nail Disorders NEC
 ;;^UTILITY(U,$J,358.3,8981,1,4,0)
 ;;=4^L60.8
 ;;^UTILITY(U,$J,358.3,8981,2)
 ;;=^5009239
 ;;^UTILITY(U,$J,358.3,8982,0)
 ;;=L62.^^48^478^175
 ;;^UTILITY(U,$J,358.3,8982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8982,1,3,0)
 ;;=3^Nail Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,8982,1,4,0)
 ;;=4^L62.
 ;;^UTILITY(U,$J,358.3,8982,2)
 ;;=^5009241
 ;;^UTILITY(U,$J,358.3,8983,0)
 ;;=L64.9^^48^478^34
 ;;^UTILITY(U,$J,358.3,8983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8983,1,3,0)
 ;;=3^Androgenic Alopecia,Unspec
 ;;^UTILITY(U,$J,358.3,8983,1,4,0)
 ;;=4^L64.9
 ;;^UTILITY(U,$J,358.3,8983,2)
 ;;=^5009249
 ;;^UTILITY(U,$J,358.3,8984,0)
 ;;=L65.9^^48^478^269
 ;;^UTILITY(U,$J,358.3,8984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8984,1,3,0)
 ;;=3^Nonscarring Hair Loss,Unspec
 ;;^UTILITY(U,$J,358.3,8984,1,4,0)
 ;;=4^L65.9
 ;;^UTILITY(U,$J,358.3,8984,2)
 ;;=^5009252
 ;;^UTILITY(U,$J,358.3,8985,0)
 ;;=L70.0^^48^478^7
 ;;^UTILITY(U,$J,358.3,8985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8985,1,3,0)
 ;;=3^Acne Vulgaris
 ;;^UTILITY(U,$J,358.3,8985,1,4,0)
 ;;=4^L70.0
 ;;^UTILITY(U,$J,358.3,8985,2)
 ;;=^5009268
 ;;^UTILITY(U,$J,358.3,8986,0)
 ;;=L70.1^^48^478^2
 ;;^UTILITY(U,$J,358.3,8986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8986,1,3,0)
 ;;=3^Acne Conglobata
 ;;^UTILITY(U,$J,358.3,8986,1,4,0)
 ;;=4^L70.1
 ;;^UTILITY(U,$J,358.3,8986,2)
 ;;=^5009269
 ;;^UTILITY(U,$J,358.3,8987,0)
 ;;=L70.3^^48^478^6
 ;;^UTILITY(U,$J,358.3,8987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8987,1,3,0)
 ;;=3^Acne Tropica
 ;;^UTILITY(U,$J,358.3,8987,1,4,0)
 ;;=4^L70.3
 ;;^UTILITY(U,$J,358.3,8987,2)
 ;;=^5009270
 ;;^UTILITY(U,$J,358.3,8988,0)
 ;;=L70.5^^48^478^3
 ;;^UTILITY(U,$J,358.3,8988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8988,1,3,0)
 ;;=3^Acne Excoriee des Jeunes Filles
 ;;^UTILITY(U,$J,358.3,8988,1,4,0)
 ;;=4^L70.5
 ;;^UTILITY(U,$J,358.3,8988,2)
 ;;=^5009272
 ;;^UTILITY(U,$J,358.3,8989,0)
 ;;=L70.8^^48^478^5
 ;;^UTILITY(U,$J,358.3,8989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8989,1,3,0)
 ;;=3^Acne NEC
 ;;^UTILITY(U,$J,358.3,8989,1,4,0)
 ;;=4^L70.8
 ;;^UTILITY(U,$J,358.3,8989,2)
 ;;=^87239
 ;;^UTILITY(U,$J,358.3,8990,0)
 ;;=L70.9^^48^478^8
 ;;^UTILITY(U,$J,358.3,8990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8990,1,3,0)
 ;;=3^Acne,Unspec
 ;;^UTILITY(U,$J,358.3,8990,1,4,0)
 ;;=4^L70.9
 ;;^UTILITY(U,$J,358.3,8990,2)
 ;;=^5009273
 ;;^UTILITY(U,$J,358.3,8991,0)
 ;;=L71.0^^48^478^273
 ;;^UTILITY(U,$J,358.3,8991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8991,1,3,0)
 ;;=3^Perioral Dermatitis
 ;;^UTILITY(U,$J,358.3,8991,1,4,0)
 ;;=4^L71.0
 ;;^UTILITY(U,$J,358.3,8991,2)
 ;;=^5009274
 ;;^UTILITY(U,$J,358.3,8992,0)
 ;;=L71.1^^48^478^299
 ;;^UTILITY(U,$J,358.3,8992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8992,1,3,0)
 ;;=3^Rhinophyma
 ;;^UTILITY(U,$J,358.3,8992,1,4,0)
 ;;=4^L71.1
 ;;^UTILITY(U,$J,358.3,8992,2)
 ;;=^106083
 ;;^UTILITY(U,$J,358.3,8993,0)
 ;;=L71.8^^48^478^300
 ;;^UTILITY(U,$J,358.3,8993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8993,1,3,0)
 ;;=3^Rosacea NEC
 ;;^UTILITY(U,$J,358.3,8993,1,4,0)
 ;;=4^L71.8
 ;;^UTILITY(U,$J,358.3,8993,2)
 ;;=^5009275
 ;;^UTILITY(U,$J,358.3,8994,0)
 ;;=L71.9^^48^478^301
 ;;^UTILITY(U,$J,358.3,8994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8994,1,3,0)
 ;;=3^Rosacea,Unspec
 ;;^UTILITY(U,$J,358.3,8994,1,4,0)
 ;;=4^L71.9
 ;;^UTILITY(U,$J,358.3,8994,2)
 ;;=^5009276
 ;;^UTILITY(U,$J,358.3,8995,0)
 ;;=L72.0^^48^478^145
 ;;^UTILITY(U,$J,358.3,8995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8995,1,3,0)
 ;;=3^Epidermal Cyst
 ;;^UTILITY(U,$J,358.3,8995,1,4,0)
 ;;=4^L72.0
 ;;^UTILITY(U,$J,358.3,8995,2)
 ;;=^5009277
 ;;^UTILITY(U,$J,358.3,8996,0)
 ;;=L72.12^^48^478^325
 ;;^UTILITY(U,$J,358.3,8996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8996,1,3,0)
 ;;=3^Trichodermal Cyst
 ;;^UTILITY(U,$J,358.3,8996,1,4,0)
 ;;=4^L72.12
 ;;^UTILITY(U,$J,358.3,8996,2)
 ;;=^5009279
 ;;^UTILITY(U,$J,358.3,8997,0)
 ;;=L72.2^^48^478^310
 ;;^UTILITY(U,$J,358.3,8997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8997,1,3,0)
 ;;=3^Steatocystoma Multiplex
 ;;^UTILITY(U,$J,358.3,8997,1,4,0)
 ;;=4^L72.2
 ;;^UTILITY(U,$J,358.3,8997,2)
 ;;=^5009280
 ;;^UTILITY(U,$J,358.3,8998,0)
 ;;=L72.8^^48^478^154
 ;;^UTILITY(U,$J,358.3,8998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8998,1,3,0)
 ;;=3^Follicular Cysts of Skin/Subcutaneous Tissue NEC
 ;;^UTILITY(U,$J,358.3,8998,1,4,0)
 ;;=4^L72.8
 ;;^UTILITY(U,$J,358.3,8998,2)
 ;;=^5009282
 ;;^UTILITY(U,$J,358.3,8999,0)
 ;;=L72.9^^48^478^155
 ;;^UTILITY(U,$J,358.3,8999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8999,1,3,0)
 ;;=3^Follicular Cysts of Skin/Subcutaneous Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,8999,1,4,0)
 ;;=4^L72.9
 ;;^UTILITY(U,$J,358.3,8999,2)
 ;;=^5009283
 ;;^UTILITY(U,$J,358.3,9000,0)
 ;;=L73.0^^48^478^4
 ;;^UTILITY(U,$J,358.3,9000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9000,1,3,0)
 ;;=3^Acne Keloid
 ;;^UTILITY(U,$J,358.3,9000,1,4,0)
 ;;=4^L73.0
 ;;^UTILITY(U,$J,358.3,9000,2)
 ;;=^2149
 ;;^UTILITY(U,$J,358.3,9001,0)
 ;;=L73.2^^48^478^162
 ;;^UTILITY(U,$J,358.3,9001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9001,1,3,0)
 ;;=3^Hidradenitis Suppurativa
 ;;^UTILITY(U,$J,358.3,9001,1,4,0)
 ;;=4^L73.2
 ;;^UTILITY(U,$J,358.3,9001,2)
 ;;=^278979
 ;;^UTILITY(U,$J,358.3,9002,0)
 ;;=L73.9^^48^478^156
 ;;^UTILITY(U,$J,358.3,9002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9002,1,3,0)
 ;;=3^Follicular Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,9002,1,4,0)
 ;;=4^L73.9
 ;;^UTILITY(U,$J,358.3,9002,2)
 ;;=^5009286
 ;;^UTILITY(U,$J,358.3,9003,0)
 ;;=L82.0^^48^478^163
 ;;^UTILITY(U,$J,358.3,9003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9003,1,3,0)
 ;;=3^Inflamed Seborrheic Keratosis
 ;;^UTILITY(U,$J,358.3,9003,1,4,0)
 ;;=4^L82.0
 ;;^UTILITY(U,$J,358.3,9003,2)
 ;;=^303311
 ;;^UTILITY(U,$J,358.3,9004,0)
 ;;=L82.1^^48^478^304
 ;;^UTILITY(U,$J,358.3,9004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9004,1,3,0)
 ;;=3^Seborrheic Keratosis NEC
 ;;^UTILITY(U,$J,358.3,9004,1,4,0)
 ;;=4^L82.1
 ;;^UTILITY(U,$J,358.3,9004,2)
 ;;=^303312
 ;;^UTILITY(U,$J,358.3,9005,0)
 ;;=L84.^^48^478^118
 ;;^UTILITY(U,$J,358.3,9005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9005,1,3,0)
 ;;=3^Corns and Callosities
 ;;^UTILITY(U,$J,358.3,9005,1,4,0)
 ;;=4^L84.
 ;;^UTILITY(U,$J,358.3,9005,2)
 ;;=^271920
 ;;^UTILITY(U,$J,358.3,9006,0)
 ;;=L85.0^^48^478^9
 ;;^UTILITY(U,$J,358.3,9006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9006,1,3,0)
 ;;=3^Acquired Ichthyosis
 ;;^UTILITY(U,$J,358.3,9006,1,4,0)
 ;;=4^L85.0
 ;;^UTILITY(U,$J,358.3,9006,2)
 ;;=^5009320
 ;;^UTILITY(U,$J,358.3,9007,0)
 ;;=L85.1^^48^478^11
 ;;^UTILITY(U,$J,358.3,9007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9007,1,3,0)
 ;;=3^Acquired Keratosis Palmaris et Plantaris
 ;;^UTILITY(U,$J,358.3,9007,1,4,0)
 ;;=4^L85.1
 ;;^UTILITY(U,$J,358.3,9007,2)
 ;;=^5009321
 ;;^UTILITY(U,$J,358.3,9008,0)
 ;;=L85.2^^48^478^169
 ;;^UTILITY(U,$J,358.3,9008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9008,1,3,0)
 ;;=3^Keratosis Punctata
 ;;^UTILITY(U,$J,358.3,9008,1,4,0)
 ;;=4^L85.2
 ;;^UTILITY(U,$J,358.3,9008,2)
 ;;=^5009322
 ;;^UTILITY(U,$J,358.3,9009,0)
 ;;=L85.3^^48^478^329
 ;;^UTILITY(U,$J,358.3,9009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9009,1,3,0)
 ;;=3^Xerosis Cutis
 ;;^UTILITY(U,$J,358.3,9009,1,4,0)
 ;;=4^L85.3
 ;;^UTILITY(U,$J,358.3,9009,2)
 ;;=^5009323
 ;;^UTILITY(U,$J,358.3,9010,0)
 ;;=L86.^^48^478^167
 ;;^UTILITY(U,$J,358.3,9010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9010,1,3,0)
 ;;=3^Keratoderma in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,9010,1,4,0)
 ;;=4^L86.
 ;;^UTILITY(U,$J,358.3,9010,2)
 ;;=^5009326
 ;;^UTILITY(U,$J,358.3,9011,0)
 ;;=L87.0^^48^478^168
 ;;^UTILITY(U,$J,358.3,9011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9011,1,3,0)
 ;;=3^Keratosis Follicularis et Parafollicularis in Cutem Penetrans
 ;;^UTILITY(U,$J,358.3,9011,1,4,0)
 ;;=4^L87.0
 ;;^UTILITY(U,$J,358.3,9011,2)
 ;;=^5009327
 ;;^UTILITY(U,$J,358.3,9012,0)
 ;;=L87.2^^48^478^144
 ;;^UTILITY(U,$J,358.3,9012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9012,1,3,0)
 ;;=3^Elastosis Perforans Serpiginosa
 ;;^UTILITY(U,$J,358.3,9012,1,4,0)
 ;;=4^L87.2
 ;;^UTILITY(U,$J,358.3,9012,2)
 ;;=^5009329
 ;;^UTILITY(U,$J,358.3,9013,0)
 ;;=L89.300^^48^478^282
 ;;^UTILITY(U,$J,358.3,9013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9013,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Unstageable
 ;;^UTILITY(U,$J,358.3,9013,1,4,0)
 ;;=4^L89.300
 ;;^UTILITY(U,$J,358.3,9013,2)
 ;;=^5009389
 ;;^UTILITY(U,$J,358.3,9014,0)
 ;;=L89.301^^48^478^277
 ;;^UTILITY(U,$J,358.3,9014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9014,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage 1
 ;;^UTILITY(U,$J,358.3,9014,1,4,0)
 ;;=4^L89.301
 ;;^UTILITY(U,$J,358.3,9014,2)
 ;;=^5009390
 ;;^UTILITY(U,$J,358.3,9015,0)
 ;;=L89.302^^48^478^278
 ;;^UTILITY(U,$J,358.3,9015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9015,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage 2
 ;;^UTILITY(U,$J,358.3,9015,1,4,0)
 ;;=4^L89.302
 ;;^UTILITY(U,$J,358.3,9015,2)
 ;;=^5009391
 ;;^UTILITY(U,$J,358.3,9016,0)
 ;;=L89.303^^48^478^279
 ;;^UTILITY(U,$J,358.3,9016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9016,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage 3
 ;;^UTILITY(U,$J,358.3,9016,1,4,0)
 ;;=4^L89.303
 ;;^UTILITY(U,$J,358.3,9016,2)
 ;;=^5009392
 ;;^UTILITY(U,$J,358.3,9017,0)
 ;;=L89.304^^48^478^280
 ;;^UTILITY(U,$J,358.3,9017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9017,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage 4
 ;;^UTILITY(U,$J,358.3,9017,1,4,0)
 ;;=4^L89.304
 ;;^UTILITY(U,$J,358.3,9017,2)
 ;;=^5009393
 ;;^UTILITY(U,$J,358.3,9018,0)
 ;;=L89.309^^48^478^281
 ;;^UTILITY(U,$J,358.3,9018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9018,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage Unspec
 ;;^UTILITY(U,$J,358.3,9018,1,4,0)
 ;;=4^L89.309
 ;;^UTILITY(U,$J,358.3,9018,2)
 ;;=^5133672
 ;;^UTILITY(U,$J,358.3,9019,0)
 ;;=L89.90^^48^478^287
 ;;^UTILITY(U,$J,358.3,9019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9019,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Unspec Stage
 ;;^UTILITY(U,$J,358.3,9019,1,4,0)
 ;;=4^L89.90
 ;;^UTILITY(U,$J,358.3,9019,2)
 ;;=^5133666
 ;;^UTILITY(U,$J,358.3,9020,0)
 ;;=L89.91^^48^478^283
 ;;^UTILITY(U,$J,358.3,9020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9020,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 1
 ;;^UTILITY(U,$J,358.3,9020,1,4,0)
 ;;=4^L89.91
 ;;^UTILITY(U,$J,358.3,9020,2)
 ;;=^5133664
 ;;^UTILITY(U,$J,358.3,9021,0)
 ;;=L89.92^^48^478^284
 ;;^UTILITY(U,$J,358.3,9021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9021,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 2
 ;;^UTILITY(U,$J,358.3,9021,1,4,0)
 ;;=4^L89.92
 ;;^UTILITY(U,$J,358.3,9021,2)
 ;;=^5133667
 ;;^UTILITY(U,$J,358.3,9022,0)
 ;;=L89.93^^48^478^285
 ;;^UTILITY(U,$J,358.3,9022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9022,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 3
 ;;^UTILITY(U,$J,358.3,9022,1,4,0)
 ;;=4^L89.93
 ;;^UTILITY(U,$J,358.3,9022,2)
 ;;=^5133668
 ;;^UTILITY(U,$J,358.3,9023,0)
 ;;=L89.94^^48^478^286
 ;;^UTILITY(U,$J,358.3,9023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9023,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 4
 ;;^UTILITY(U,$J,358.3,9023,1,4,0)
 ;;=4^L89.94
 ;;^UTILITY(U,$J,358.3,9023,2)
 ;;=^5133669
 ;;^UTILITY(U,$J,358.3,9024,0)
 ;;=L89.95^^48^478^288
 ;;^UTILITY(U,$J,358.3,9024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9024,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Unstageable
 ;;^UTILITY(U,$J,358.3,9024,1,4,0)
 ;;=4^L89.95
 ;;^UTILITY(U,$J,358.3,9024,2)
 ;;=^5133660
 ;;^UTILITY(U,$J,358.3,9025,0)
 ;;=L92.0^^48^478^159
 ;;^UTILITY(U,$J,358.3,9025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9025,1,3,0)
 ;;=3^Granuloma Annulare
 ;;^UTILITY(U,$J,358.3,9025,1,4,0)
 ;;=4^L92.0
 ;;^UTILITY(U,$J,358.3,9025,2)
 ;;=^184052
 ;;^UTILITY(U,$J,358.3,9026,0)
 ;;=L95.1^^48^478^146
 ;;^UTILITY(U,$J,358.3,9026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9026,1,3,0)
 ;;=3^Erythema Elevatum Diutinum
 ;;^UTILITY(U,$J,358.3,9026,1,4,0)
 ;;=4^L95.1
 ;;^UTILITY(U,$J,358.3,9026,2)
 ;;=^5009477
 ;;^UTILITY(U,$J,358.3,9027,0)
 ;;=L97.111^^48^478^262
 ;;^UTILITY(U,$J,358.3,9027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9027,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,9027,1,4,0)
 ;;=4^L97.111
 ;;^UTILITY(U,$J,358.3,9027,2)
 ;;=^5009485
 ;;^UTILITY(U,$J,358.3,9028,0)
 ;;=L97.112^^48^478^263
 ;;^UTILITY(U,$J,358.3,9028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9028,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,9028,1,4,0)
 ;;=4^L97.112
 ;;^UTILITY(U,$J,358.3,9028,2)
 ;;=^5009486
 ;;^UTILITY(U,$J,358.3,9029,0)
 ;;=L97.113^^48^478^264
 ;;^UTILITY(U,$J,358.3,9029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9029,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,9029,1,4,0)
 ;;=4^L97.113
 ;;^UTILITY(U,$J,358.3,9029,2)
 ;;=^5009487
 ;;^UTILITY(U,$J,358.3,9030,0)
 ;;=L97.114^^48^478^265
 ;;^UTILITY(U,$J,358.3,9030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9030,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,9030,1,4,0)
 ;;=4^L97.114
 ;;^UTILITY(U,$J,358.3,9030,2)
 ;;=^5009488
 ;;^UTILITY(U,$J,358.3,9031,0)
 ;;=L97.119^^48^478^266
 ;;^UTILITY(U,$J,358.3,9031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9031,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,9031,1,4,0)
 ;;=4^L97.119
 ;;^UTILITY(U,$J,358.3,9031,2)
 ;;=^5009489
 ;;^UTILITY(U,$J,358.3,9032,0)
 ;;=L97.121^^48^478^214
 ;;^UTILITY(U,$J,358.3,9032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9032,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,9032,1,4,0)
 ;;=4^L97.121
 ;;^UTILITY(U,$J,358.3,9032,2)
 ;;=^5009490
 ;;^UTILITY(U,$J,358.3,9033,0)
 ;;=L97.122^^48^478^215
 ;;^UTILITY(U,$J,358.3,9033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9033,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,9033,1,4,0)
 ;;=4^L97.122
 ;;^UTILITY(U,$J,358.3,9033,2)
 ;;=^5009491
 ;;^UTILITY(U,$J,358.3,9034,0)
 ;;=L97.123^^48^478^216
 ;;^UTILITY(U,$J,358.3,9034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9034,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,9034,1,4,0)
 ;;=4^L97.123
 ;;^UTILITY(U,$J,358.3,9034,2)
 ;;=^5009492
 ;;^UTILITY(U,$J,358.3,9035,0)
 ;;=L97.124^^48^478^217
 ;;^UTILITY(U,$J,358.3,9035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9035,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,9035,1,4,0)
 ;;=4^L97.124
 ;;^UTILITY(U,$J,358.3,9035,2)
 ;;=^5009493
 ;;^UTILITY(U,$J,358.3,9036,0)
 ;;=L97.129^^48^478^218
 ;;^UTILITY(U,$J,358.3,9036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9036,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,9036,1,4,0)
 ;;=4^L97.129
 ;;^UTILITY(U,$J,358.3,9036,2)
 ;;=^5009494
 ;;^UTILITY(U,$J,358.3,9037,0)
 ;;=L97.211^^48^478^230
 ;;^UTILITY(U,$J,358.3,9037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9037,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,9037,1,4,0)
 ;;=4^L97.211
 ;;^UTILITY(U,$J,358.3,9037,2)
 ;;=^5009500
 ;;^UTILITY(U,$J,358.3,9038,0)
 ;;=L97.212^^48^478^231
 ;;^UTILITY(U,$J,358.3,9038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9038,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,9038,1,4,0)
 ;;=4^L97.212
 ;;^UTILITY(U,$J,358.3,9038,2)
 ;;=^5009501
 ;;^UTILITY(U,$J,358.3,9039,0)
 ;;=L97.213^^48^478^232
 ;;^UTILITY(U,$J,358.3,9039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9039,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,9039,1,4,0)
 ;;=4^L97.213
 ;;^UTILITY(U,$J,358.3,9039,2)
 ;;=^5009502
 ;;^UTILITY(U,$J,358.3,9040,0)
 ;;=L97.214^^48^478^233
 ;;^UTILITY(U,$J,358.3,9040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9040,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,9040,1,4,0)
 ;;=4^L97.214
 ;;^UTILITY(U,$J,358.3,9040,2)
 ;;=^5009503
 ;;^UTILITY(U,$J,358.3,9041,0)
 ;;=L97.219^^48^478^234
 ;;^UTILITY(U,$J,358.3,9041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9041,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,9041,1,4,0)
 ;;=4^L97.219
 ;;^UTILITY(U,$J,358.3,9041,2)
 ;;=^5009504
 ;;^UTILITY(U,$J,358.3,9042,0)
 ;;=L97.221^^48^478^185
 ;;^UTILITY(U,$J,358.3,9042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9042,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,9042,1,4,0)
 ;;=4^L97.221
 ;;^UTILITY(U,$J,358.3,9042,2)
 ;;=^5009505
 ;;^UTILITY(U,$J,358.3,9043,0)
 ;;=L97.222^^48^478^186
 ;;^UTILITY(U,$J,358.3,9043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9043,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,9043,1,4,0)
 ;;=4^L97.222
 ;;^UTILITY(U,$J,358.3,9043,2)
 ;;=^5009506
 ;;^UTILITY(U,$J,358.3,9044,0)
 ;;=L97.223^^48^478^187
 ;;^UTILITY(U,$J,358.3,9044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9044,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,9044,1,4,0)
 ;;=4^L97.223
 ;;^UTILITY(U,$J,358.3,9044,2)
 ;;=^5009507
 ;;^UTILITY(U,$J,358.3,9045,0)
 ;;=L97.224^^48^478^188
 ;;^UTILITY(U,$J,358.3,9045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9045,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,9045,1,4,0)
 ;;=4^L97.224
 ;;^UTILITY(U,$J,358.3,9045,2)
 ;;=^5009508
 ;;^UTILITY(U,$J,358.3,9046,0)
 ;;=L97.229^^48^478^189
 ;;^UTILITY(U,$J,358.3,9046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9046,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,9046,1,4,0)
 ;;=4^L97.229
 ;;^UTILITY(U,$J,358.3,9046,2)
 ;;=^5009509
 ;;^UTILITY(U,$J,358.3,9047,0)
 ;;=L97.311^^48^478^222
 ;;^UTILITY(U,$J,358.3,9047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9047,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,9047,1,4,0)
 ;;=4^L97.311
 ;;^UTILITY(U,$J,358.3,9047,2)
 ;;=^5009515
 ;;^UTILITY(U,$J,358.3,9048,0)
 ;;=L97.312^^48^478^223
 ;;^UTILITY(U,$J,358.3,9048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9048,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Fat Layer Exposed
