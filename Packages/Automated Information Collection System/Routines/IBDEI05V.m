IBDEI05V ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14254,1,4,0)
 ;;=4^L70.5
 ;;^UTILITY(U,$J,358.3,14254,2)
 ;;=^5009272
 ;;^UTILITY(U,$J,358.3,14255,0)
 ;;=L70.8^^62^688^5
 ;;^UTILITY(U,$J,358.3,14255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14255,1,3,0)
 ;;=3^Acne NEC
 ;;^UTILITY(U,$J,358.3,14255,1,4,0)
 ;;=4^L70.8
 ;;^UTILITY(U,$J,358.3,14255,2)
 ;;=^87239
 ;;^UTILITY(U,$J,358.3,14256,0)
 ;;=L70.9^^62^688^8
 ;;^UTILITY(U,$J,358.3,14256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14256,1,3,0)
 ;;=3^Acne,Unspec
 ;;^UTILITY(U,$J,358.3,14256,1,4,0)
 ;;=4^L70.9
 ;;^UTILITY(U,$J,358.3,14256,2)
 ;;=^5009273
 ;;^UTILITY(U,$J,358.3,14257,0)
 ;;=L71.0^^62^688^273
 ;;^UTILITY(U,$J,358.3,14257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14257,1,3,0)
 ;;=3^Perioral Dermatitis
 ;;^UTILITY(U,$J,358.3,14257,1,4,0)
 ;;=4^L71.0
 ;;^UTILITY(U,$J,358.3,14257,2)
 ;;=^5009274
 ;;^UTILITY(U,$J,358.3,14258,0)
 ;;=L71.1^^62^688^299
 ;;^UTILITY(U,$J,358.3,14258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14258,1,3,0)
 ;;=3^Rhinophyma
 ;;^UTILITY(U,$J,358.3,14258,1,4,0)
 ;;=4^L71.1
 ;;^UTILITY(U,$J,358.3,14258,2)
 ;;=^106083
 ;;^UTILITY(U,$J,358.3,14259,0)
 ;;=L71.8^^62^688^300
 ;;^UTILITY(U,$J,358.3,14259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14259,1,3,0)
 ;;=3^Rosacea NEC
 ;;^UTILITY(U,$J,358.3,14259,1,4,0)
 ;;=4^L71.8
 ;;^UTILITY(U,$J,358.3,14259,2)
 ;;=^5009275
 ;;^UTILITY(U,$J,358.3,14260,0)
 ;;=L71.9^^62^688^301
 ;;^UTILITY(U,$J,358.3,14260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14260,1,3,0)
 ;;=3^Rosacea,Unspec
 ;;^UTILITY(U,$J,358.3,14260,1,4,0)
 ;;=4^L71.9
 ;;^UTILITY(U,$J,358.3,14260,2)
 ;;=^5009276
 ;;^UTILITY(U,$J,358.3,14261,0)
 ;;=L72.0^^62^688^145
 ;;^UTILITY(U,$J,358.3,14261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14261,1,3,0)
 ;;=3^Epidermal Cyst
 ;;^UTILITY(U,$J,358.3,14261,1,4,0)
 ;;=4^L72.0
 ;;^UTILITY(U,$J,358.3,14261,2)
 ;;=^5009277
 ;;^UTILITY(U,$J,358.3,14262,0)
 ;;=L72.12^^62^688^325
 ;;^UTILITY(U,$J,358.3,14262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14262,1,3,0)
 ;;=3^Trichodermal Cyst
 ;;^UTILITY(U,$J,358.3,14262,1,4,0)
 ;;=4^L72.12
 ;;^UTILITY(U,$J,358.3,14262,2)
 ;;=^5009279
 ;;^UTILITY(U,$J,358.3,14263,0)
 ;;=L72.2^^62^688^310
 ;;^UTILITY(U,$J,358.3,14263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14263,1,3,0)
 ;;=3^Steatocystoma Multiplex
 ;;^UTILITY(U,$J,358.3,14263,1,4,0)
 ;;=4^L72.2
 ;;^UTILITY(U,$J,358.3,14263,2)
 ;;=^5009280
 ;;^UTILITY(U,$J,358.3,14264,0)
 ;;=L72.8^^62^688^154
 ;;^UTILITY(U,$J,358.3,14264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14264,1,3,0)
 ;;=3^Follicular Cysts of Skin/Subcutaneous Tissue NEC
 ;;^UTILITY(U,$J,358.3,14264,1,4,0)
 ;;=4^L72.8
 ;;^UTILITY(U,$J,358.3,14264,2)
 ;;=^5009282
 ;;^UTILITY(U,$J,358.3,14265,0)
 ;;=L72.9^^62^688^155
 ;;^UTILITY(U,$J,358.3,14265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14265,1,3,0)
 ;;=3^Follicular Cysts of Skin/Subcutaneous Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,14265,1,4,0)
 ;;=4^L72.9
 ;;^UTILITY(U,$J,358.3,14265,2)
 ;;=^5009283
 ;;^UTILITY(U,$J,358.3,14266,0)
 ;;=L73.0^^62^688^4
 ;;^UTILITY(U,$J,358.3,14266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14266,1,3,0)
 ;;=3^Acne Keloid
 ;;^UTILITY(U,$J,358.3,14266,1,4,0)
 ;;=4^L73.0
 ;;^UTILITY(U,$J,358.3,14266,2)
 ;;=^2149
 ;;^UTILITY(U,$J,358.3,14267,0)
 ;;=L73.2^^62^688^162
 ;;^UTILITY(U,$J,358.3,14267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14267,1,3,0)
 ;;=3^Hidradenitis Suppurativa
 ;;^UTILITY(U,$J,358.3,14267,1,4,0)
 ;;=4^L73.2
 ;;^UTILITY(U,$J,358.3,14267,2)
 ;;=^278979
 ;;^UTILITY(U,$J,358.3,14268,0)
 ;;=L73.9^^62^688^156
 ;;^UTILITY(U,$J,358.3,14268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14268,1,3,0)
 ;;=3^Follicular Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,14268,1,4,0)
 ;;=4^L73.9
 ;;^UTILITY(U,$J,358.3,14268,2)
 ;;=^5009286
 ;;^UTILITY(U,$J,358.3,14269,0)
 ;;=L82.0^^62^688^163
 ;;^UTILITY(U,$J,358.3,14269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14269,1,3,0)
 ;;=3^Inflamed Seborrheic Keratosis
 ;;^UTILITY(U,$J,358.3,14269,1,4,0)
 ;;=4^L82.0
 ;;^UTILITY(U,$J,358.3,14269,2)
 ;;=^303311
 ;;^UTILITY(U,$J,358.3,14270,0)
 ;;=L82.1^^62^688^304
 ;;^UTILITY(U,$J,358.3,14270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14270,1,3,0)
 ;;=3^Seborrheic Keratosis NEC
 ;;^UTILITY(U,$J,358.3,14270,1,4,0)
 ;;=4^L82.1
 ;;^UTILITY(U,$J,358.3,14270,2)
 ;;=^303312
 ;;^UTILITY(U,$J,358.3,14271,0)
 ;;=L84.^^62^688^118
 ;;^UTILITY(U,$J,358.3,14271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14271,1,3,0)
 ;;=3^Corns and Callosities
 ;;^UTILITY(U,$J,358.3,14271,1,4,0)
 ;;=4^L84.
 ;;^UTILITY(U,$J,358.3,14271,2)
 ;;=^271920
 ;;^UTILITY(U,$J,358.3,14272,0)
 ;;=L85.0^^62^688^9
 ;;^UTILITY(U,$J,358.3,14272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14272,1,3,0)
 ;;=3^Acquired Ichthyosis
 ;;^UTILITY(U,$J,358.3,14272,1,4,0)
 ;;=4^L85.0
 ;;^UTILITY(U,$J,358.3,14272,2)
 ;;=^5009320
 ;;^UTILITY(U,$J,358.3,14273,0)
 ;;=L85.1^^62^688^11
 ;;^UTILITY(U,$J,358.3,14273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14273,1,3,0)
 ;;=3^Acquired Keratosis Palmaris et Plantaris
 ;;^UTILITY(U,$J,358.3,14273,1,4,0)
 ;;=4^L85.1
 ;;^UTILITY(U,$J,358.3,14273,2)
 ;;=^5009321
 ;;^UTILITY(U,$J,358.3,14274,0)
 ;;=L85.2^^62^688^169
 ;;^UTILITY(U,$J,358.3,14274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14274,1,3,0)
 ;;=3^Keratosis Punctata
 ;;^UTILITY(U,$J,358.3,14274,1,4,0)
 ;;=4^L85.2
 ;;^UTILITY(U,$J,358.3,14274,2)
 ;;=^5009322
 ;;^UTILITY(U,$J,358.3,14275,0)
 ;;=L85.3^^62^688^329
 ;;^UTILITY(U,$J,358.3,14275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14275,1,3,0)
 ;;=3^Xerosis Cutis
 ;;^UTILITY(U,$J,358.3,14275,1,4,0)
 ;;=4^L85.3
 ;;^UTILITY(U,$J,358.3,14275,2)
 ;;=^5009323
 ;;^UTILITY(U,$J,358.3,14276,0)
 ;;=L86.^^62^688^167
 ;;^UTILITY(U,$J,358.3,14276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14276,1,3,0)
 ;;=3^Keratoderma in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,14276,1,4,0)
 ;;=4^L86.
 ;;^UTILITY(U,$J,358.3,14276,2)
 ;;=^5009326
 ;;^UTILITY(U,$J,358.3,14277,0)
 ;;=L87.0^^62^688^168
 ;;^UTILITY(U,$J,358.3,14277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14277,1,3,0)
 ;;=3^Keratosis Follicularis et Parafollicularis in Cutem Penetrans
 ;;^UTILITY(U,$J,358.3,14277,1,4,0)
 ;;=4^L87.0
 ;;^UTILITY(U,$J,358.3,14277,2)
 ;;=^5009327
 ;;^UTILITY(U,$J,358.3,14278,0)
 ;;=L87.2^^62^688^144
 ;;^UTILITY(U,$J,358.3,14278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14278,1,3,0)
 ;;=3^Elastosis Perforans Serpiginosa
 ;;^UTILITY(U,$J,358.3,14278,1,4,0)
 ;;=4^L87.2
 ;;^UTILITY(U,$J,358.3,14278,2)
 ;;=^5009329
 ;;^UTILITY(U,$J,358.3,14279,0)
 ;;=L89.300^^62^688^282
 ;;^UTILITY(U,$J,358.3,14279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14279,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Unstageable
 ;;^UTILITY(U,$J,358.3,14279,1,4,0)
 ;;=4^L89.300
 ;;^UTILITY(U,$J,358.3,14279,2)
 ;;=^5009389
 ;;^UTILITY(U,$J,358.3,14280,0)
 ;;=L89.301^^62^688^277
 ;;^UTILITY(U,$J,358.3,14280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14280,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage 1
 ;;^UTILITY(U,$J,358.3,14280,1,4,0)
 ;;=4^L89.301
 ;;^UTILITY(U,$J,358.3,14280,2)
 ;;=^5009390
 ;;^UTILITY(U,$J,358.3,14281,0)
 ;;=L89.302^^62^688^278
 ;;^UTILITY(U,$J,358.3,14281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14281,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage 2
 ;;^UTILITY(U,$J,358.3,14281,1,4,0)
 ;;=4^L89.302
 ;;^UTILITY(U,$J,358.3,14281,2)
 ;;=^5009391
 ;;^UTILITY(U,$J,358.3,14282,0)
 ;;=L89.303^^62^688^279
 ;;^UTILITY(U,$J,358.3,14282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14282,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage 3
 ;;^UTILITY(U,$J,358.3,14282,1,4,0)
 ;;=4^L89.303
 ;;^UTILITY(U,$J,358.3,14282,2)
 ;;=^5009392
 ;;^UTILITY(U,$J,358.3,14283,0)
 ;;=L89.304^^62^688^280
 ;;^UTILITY(U,$J,358.3,14283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14283,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage 4
 ;;^UTILITY(U,$J,358.3,14283,1,4,0)
 ;;=4^L89.304
 ;;^UTILITY(U,$J,358.3,14283,2)
 ;;=^5009393
 ;;^UTILITY(U,$J,358.3,14284,0)
 ;;=L89.309^^62^688^281
 ;;^UTILITY(U,$J,358.3,14284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14284,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Stage Unspec
 ;;^UTILITY(U,$J,358.3,14284,1,4,0)
 ;;=4^L89.309
 ;;^UTILITY(U,$J,358.3,14284,2)
 ;;=^5133672
 ;;^UTILITY(U,$J,358.3,14285,0)
 ;;=L89.90^^62^688^287
 ;;^UTILITY(U,$J,358.3,14285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14285,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Unspec Stage
 ;;^UTILITY(U,$J,358.3,14285,1,4,0)
 ;;=4^L89.90
 ;;^UTILITY(U,$J,358.3,14285,2)
 ;;=^5133666
 ;;^UTILITY(U,$J,358.3,14286,0)
 ;;=L89.91^^62^688^283
 ;;^UTILITY(U,$J,358.3,14286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14286,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 1
 ;;^UTILITY(U,$J,358.3,14286,1,4,0)
 ;;=4^L89.91
 ;;^UTILITY(U,$J,358.3,14286,2)
 ;;=^5133664
 ;;^UTILITY(U,$J,358.3,14287,0)
 ;;=L89.92^^62^688^284
 ;;^UTILITY(U,$J,358.3,14287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14287,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 2
 ;;^UTILITY(U,$J,358.3,14287,1,4,0)
 ;;=4^L89.92
 ;;^UTILITY(U,$J,358.3,14287,2)
 ;;=^5133667
 ;;^UTILITY(U,$J,358.3,14288,0)
 ;;=L89.93^^62^688^285
 ;;^UTILITY(U,$J,358.3,14288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14288,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 3
 ;;^UTILITY(U,$J,358.3,14288,1,4,0)
 ;;=4^L89.93
 ;;^UTILITY(U,$J,358.3,14288,2)
 ;;=^5133668
 ;;^UTILITY(U,$J,358.3,14289,0)
 ;;=L89.94^^62^688^286
 ;;^UTILITY(U,$J,358.3,14289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14289,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Stage 4
 ;;^UTILITY(U,$J,358.3,14289,1,4,0)
 ;;=4^L89.94
 ;;^UTILITY(U,$J,358.3,14289,2)
 ;;=^5133669
 ;;^UTILITY(U,$J,358.3,14290,0)
 ;;=L89.95^^62^688^288
 ;;^UTILITY(U,$J,358.3,14290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14290,1,3,0)
 ;;=3^Pressure Ulcer of Unspec Site,Unstageable
 ;;^UTILITY(U,$J,358.3,14290,1,4,0)
 ;;=4^L89.95
 ;;^UTILITY(U,$J,358.3,14290,2)
 ;;=^5133660
 ;;^UTILITY(U,$J,358.3,14291,0)
 ;;=L92.0^^62^688^159
 ;;^UTILITY(U,$J,358.3,14291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14291,1,3,0)
 ;;=3^Granuloma Annulare
 ;;^UTILITY(U,$J,358.3,14291,1,4,0)
 ;;=4^L92.0
 ;;^UTILITY(U,$J,358.3,14291,2)
 ;;=^184052
 ;;^UTILITY(U,$J,358.3,14292,0)
 ;;=L95.1^^62^688^146
 ;;^UTILITY(U,$J,358.3,14292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14292,1,3,0)
 ;;=3^Erythema Elevatum Diutinum
 ;;^UTILITY(U,$J,358.3,14292,1,4,0)
 ;;=4^L95.1
 ;;^UTILITY(U,$J,358.3,14292,2)
 ;;=^5009477
 ;;^UTILITY(U,$J,358.3,14293,0)
 ;;=L97.111^^62^688^262
 ;;^UTILITY(U,$J,358.3,14293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14293,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,14293,1,4,0)
 ;;=4^L97.111
 ;;^UTILITY(U,$J,358.3,14293,2)
 ;;=^5009485
 ;;^UTILITY(U,$J,358.3,14294,0)
 ;;=L97.112^^62^688^263
 ;;^UTILITY(U,$J,358.3,14294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14294,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,14294,1,4,0)
 ;;=4^L97.112
 ;;^UTILITY(U,$J,358.3,14294,2)
 ;;=^5009486
 ;;^UTILITY(U,$J,358.3,14295,0)
 ;;=L97.113^^62^688^264
 ;;^UTILITY(U,$J,358.3,14295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14295,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,14295,1,4,0)
 ;;=4^L97.113
 ;;^UTILITY(U,$J,358.3,14295,2)
 ;;=^5009487
 ;;^UTILITY(U,$J,358.3,14296,0)
 ;;=L97.114^^62^688^265
 ;;^UTILITY(U,$J,358.3,14296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14296,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,14296,1,4,0)
 ;;=4^L97.114
 ;;^UTILITY(U,$J,358.3,14296,2)
 ;;=^5009488
 ;;^UTILITY(U,$J,358.3,14297,0)
 ;;=L97.119^^62^688^266
 ;;^UTILITY(U,$J,358.3,14297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14297,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,14297,1,4,0)
 ;;=4^L97.119
 ;;^UTILITY(U,$J,358.3,14297,2)
 ;;=^5009489
 ;;^UTILITY(U,$J,358.3,14298,0)
 ;;=L97.121^^62^688^214
 ;;^UTILITY(U,$J,358.3,14298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14298,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,14298,1,4,0)
 ;;=4^L97.121
 ;;^UTILITY(U,$J,358.3,14298,2)
 ;;=^5009490
 ;;^UTILITY(U,$J,358.3,14299,0)
 ;;=L97.122^^62^688^215
 ;;^UTILITY(U,$J,358.3,14299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14299,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,14299,1,4,0)
 ;;=4^L97.122
 ;;^UTILITY(U,$J,358.3,14299,2)
 ;;=^5009491
 ;;^UTILITY(U,$J,358.3,14300,0)
 ;;=L97.123^^62^688^216
 ;;^UTILITY(U,$J,358.3,14300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14300,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,14300,1,4,0)
 ;;=4^L97.123
 ;;^UTILITY(U,$J,358.3,14300,2)
 ;;=^5009492
 ;;^UTILITY(U,$J,358.3,14301,0)
 ;;=L97.124^^62^688^217
 ;;^UTILITY(U,$J,358.3,14301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14301,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,14301,1,4,0)
 ;;=4^L97.124
 ;;^UTILITY(U,$J,358.3,14301,2)
 ;;=^5009493
 ;;^UTILITY(U,$J,358.3,14302,0)
 ;;=L97.129^^62^688^218
 ;;^UTILITY(U,$J,358.3,14302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14302,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,14302,1,4,0)
 ;;=4^L97.129
 ;;^UTILITY(U,$J,358.3,14302,2)
 ;;=^5009494
 ;;^UTILITY(U,$J,358.3,14303,0)
 ;;=L97.211^^62^688^230
 ;;^UTILITY(U,$J,358.3,14303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14303,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,14303,1,4,0)
 ;;=4^L97.211
 ;;^UTILITY(U,$J,358.3,14303,2)
 ;;=^5009500
 ;;^UTILITY(U,$J,358.3,14304,0)
 ;;=L97.212^^62^688^231
 ;;^UTILITY(U,$J,358.3,14304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14304,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,14304,1,4,0)
 ;;=4^L97.212
 ;;^UTILITY(U,$J,358.3,14304,2)
 ;;=^5009501
 ;;^UTILITY(U,$J,358.3,14305,0)
 ;;=L97.213^^62^688^232
 ;;^UTILITY(U,$J,358.3,14305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14305,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,14305,1,4,0)
 ;;=4^L97.213
 ;;^UTILITY(U,$J,358.3,14305,2)
 ;;=^5009502
 ;;^UTILITY(U,$J,358.3,14306,0)
 ;;=L97.214^^62^688^233
 ;;^UTILITY(U,$J,358.3,14306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14306,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,14306,1,4,0)
 ;;=4^L97.214
 ;;^UTILITY(U,$J,358.3,14306,2)
 ;;=^5009503
 ;;^UTILITY(U,$J,358.3,14307,0)
 ;;=L97.219^^62^688^234
 ;;^UTILITY(U,$J,358.3,14307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14307,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,14307,1,4,0)
 ;;=4^L97.219
 ;;^UTILITY(U,$J,358.3,14307,2)
 ;;=^5009504
 ;;^UTILITY(U,$J,358.3,14308,0)
 ;;=L97.221^^62^688^185
 ;;^UTILITY(U,$J,358.3,14308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14308,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,14308,1,4,0)
 ;;=4^L97.221
 ;;^UTILITY(U,$J,358.3,14308,2)
 ;;=^5009505
 ;;^UTILITY(U,$J,358.3,14309,0)
 ;;=L97.222^^62^688^186
 ;;^UTILITY(U,$J,358.3,14309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14309,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,14309,1,4,0)
 ;;=4^L97.222
 ;;^UTILITY(U,$J,358.3,14309,2)
 ;;=^5009506
 ;;^UTILITY(U,$J,358.3,14310,0)
 ;;=L97.223^^62^688^187
 ;;^UTILITY(U,$J,358.3,14310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14310,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,14310,1,4,0)
 ;;=4^L97.223
 ;;^UTILITY(U,$J,358.3,14310,2)
 ;;=^5009507
 ;;^UTILITY(U,$J,358.3,14311,0)
 ;;=L97.224^^62^688^188
 ;;^UTILITY(U,$J,358.3,14311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14311,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,14311,1,4,0)
 ;;=4^L97.224
 ;;^UTILITY(U,$J,358.3,14311,2)
 ;;=^5009508
 ;;^UTILITY(U,$J,358.3,14312,0)
 ;;=L97.229^^62^688^189
 ;;^UTILITY(U,$J,358.3,14312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14312,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,14312,1,4,0)
 ;;=4^L97.229
 ;;^UTILITY(U,$J,358.3,14312,2)
 ;;=^5009509
 ;;^UTILITY(U,$J,358.3,14313,0)
 ;;=L97.311^^62^688^222
 ;;^UTILITY(U,$J,358.3,14313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14313,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,14313,1,4,0)
 ;;=4^L97.311
 ;;^UTILITY(U,$J,358.3,14313,2)
 ;;=^5009515
 ;;^UTILITY(U,$J,358.3,14314,0)
 ;;=L97.312^^62^688^223
 ;;^UTILITY(U,$J,358.3,14314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14314,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,14314,1,4,0)
 ;;=4^L97.312
 ;;^UTILITY(U,$J,358.3,14314,2)
 ;;=^5009516
 ;;^UTILITY(U,$J,358.3,14315,0)
 ;;=L97.313^^62^688^224
 ;;^UTILITY(U,$J,358.3,14315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14315,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,14315,1,4,0)
 ;;=4^L97.313
 ;;^UTILITY(U,$J,358.3,14315,2)
 ;;=^5009517
 ;;^UTILITY(U,$J,358.3,14316,0)
 ;;=L97.314^^62^688^225
 ;;^UTILITY(U,$J,358.3,14316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14316,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,14316,1,4,0)
 ;;=4^L97.314
 ;;^UTILITY(U,$J,358.3,14316,2)
 ;;=^5009518
 ;;^UTILITY(U,$J,358.3,14317,0)
 ;;=L97.319^^62^688^226
 ;;^UTILITY(U,$J,358.3,14317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14317,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,14317,1,4,0)
 ;;=4^L97.319
 ;;^UTILITY(U,$J,358.3,14317,2)
 ;;=^5009519
 ;;^UTILITY(U,$J,358.3,14318,0)
 ;;=L97.321^^62^688^177
 ;;^UTILITY(U,$J,358.3,14318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14318,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,14318,1,4,0)
 ;;=4^L97.321
 ;;^UTILITY(U,$J,358.3,14318,2)
 ;;=^5009520
 ;;^UTILITY(U,$J,358.3,14319,0)
 ;;=L97.322^^62^688^178
 ;;^UTILITY(U,$J,358.3,14319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14319,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,14319,1,4,0)
 ;;=4^L97.322
 ;;^UTILITY(U,$J,358.3,14319,2)
 ;;=^5009521
 ;;^UTILITY(U,$J,358.3,14320,0)
 ;;=L97.323^^62^688^179
 ;;^UTILITY(U,$J,358.3,14320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14320,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,14320,1,4,0)
 ;;=4^L97.323
 ;;^UTILITY(U,$J,358.3,14320,2)
 ;;=^5009522
