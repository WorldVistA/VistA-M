IBDEI02X ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3402,1,3,0)
 ;;=3^Melanocytic Nevi of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,3402,1,4,0)
 ;;=4^D22.62
 ;;^UTILITY(U,$J,358.3,3402,2)
 ;;=^5002054
 ;;^UTILITY(U,$J,358.3,3403,0)
 ;;=D23.62^^20^252^5
 ;;^UTILITY(U,$J,358.3,3403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3403,1,3,0)
 ;;=3^Benign Neop of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,3403,1,4,0)
 ;;=4^D23.62
 ;;^UTILITY(U,$J,358.3,3403,2)
 ;;=^5002072
 ;;^UTILITY(U,$J,358.3,3404,0)
 ;;=D23.61^^20^252^9
 ;;^UTILITY(U,$J,358.3,3404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3404,1,3,0)
 ;;=3^Benign Neop of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,3404,1,4,0)
 ;;=4^D23.61
 ;;^UTILITY(U,$J,358.3,3404,2)
 ;;=^5002071
 ;;^UTILITY(U,$J,358.3,3405,0)
 ;;=D22.72^^20^252^18
 ;;^UTILITY(U,$J,358.3,3405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3405,1,3,0)
 ;;=3^Melanocytic Nevi of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,3405,1,4,0)
 ;;=4^D22.72
 ;;^UTILITY(U,$J,358.3,3405,2)
 ;;=^5002057
 ;;^UTILITY(U,$J,358.3,3406,0)
 ;;=D22.71^^20^252^23
 ;;^UTILITY(U,$J,358.3,3406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3406,1,3,0)
 ;;=3^Melanocytic Nevi of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,3406,1,4,0)
 ;;=4^D22.71
 ;;^UTILITY(U,$J,358.3,3406,2)
 ;;=^5002056
 ;;^UTILITY(U,$J,358.3,3407,0)
 ;;=D22.9^^20^252^27
 ;;^UTILITY(U,$J,358.3,3407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3407,1,3,0)
 ;;=3^Melanocytic Nevi,Unspec
 ;;^UTILITY(U,$J,358.3,3407,1,4,0)
 ;;=4^D22.9
 ;;^UTILITY(U,$J,358.3,3407,2)
 ;;=^5002058
 ;;^UTILITY(U,$J,358.3,3408,0)
 ;;=D23.72^^20^252^4
 ;;^UTILITY(U,$J,358.3,3408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3408,1,3,0)
 ;;=3^Benign Neop of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,3408,1,4,0)
 ;;=4^D23.72
 ;;^UTILITY(U,$J,358.3,3408,2)
 ;;=^5002075
 ;;^UTILITY(U,$J,358.3,3409,0)
 ;;=D23.71^^20^252^8
 ;;^UTILITY(U,$J,358.3,3409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3409,1,3,0)
 ;;=3^Benign Neop of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,3409,1,4,0)
 ;;=4^D23.71
 ;;^UTILITY(U,$J,358.3,3409,2)
 ;;=^5002074
 ;;^UTILITY(U,$J,358.3,3410,0)
 ;;=D23.9^^20^252^12
 ;;^UTILITY(U,$J,358.3,3410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3410,1,3,0)
 ;;=3^Benign Neop of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,3410,1,4,0)
 ;;=4^D23.9
 ;;^UTILITY(U,$J,358.3,3410,2)
 ;;=^5002076
 ;;^UTILITY(U,$J,358.3,3411,0)
 ;;=D22.21^^20^252^21
 ;;^UTILITY(U,$J,358.3,3411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3411,1,3,0)
 ;;=3^Melanocytic Nevi of Right Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,3411,1,4,0)
 ;;=4^D22.21
 ;;^UTILITY(U,$J,358.3,3411,2)
 ;;=^5002046
 ;;^UTILITY(U,$J,358.3,3412,0)
 ;;=C44.501^^20^253^23
 ;;^UTILITY(U,$J,358.3,3412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3412,1,3,0)
 ;;=3^Malig Neop of Skin of Breast
 ;;^UTILITY(U,$J,358.3,3412,1,4,0)
 ;;=4^C44.501
 ;;^UTILITY(U,$J,358.3,3412,2)
 ;;=^5001052
 ;;^UTILITY(U,$J,358.3,3413,0)
 ;;=C50.011^^20^253^19
 ;;^UTILITY(U,$J,358.3,3413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3413,1,3,0)
 ;;=3^Malig Neop of Nipple/Areola,Right Breast
 ;;^UTILITY(U,$J,358.3,3413,1,4,0)
 ;;=4^C50.011
 ;;^UTILITY(U,$J,358.3,3413,2)
 ;;=^5001159
 ;;^UTILITY(U,$J,358.3,3414,0)
 ;;=C50.012^^20^253^18
 ;;^UTILITY(U,$J,358.3,3414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3414,1,3,0)
 ;;=3^Malig Neop of Nipple/Areola,Left Breast
 ;;^UTILITY(U,$J,358.3,3414,1,4,0)
 ;;=4^C50.012
 ;;^UTILITY(U,$J,358.3,3414,2)
 ;;=^5001160
 ;;^UTILITY(U,$J,358.3,3415,0)
 ;;=C50.111^^20^253^12
 ;;^UTILITY(U,$J,358.3,3415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3415,1,3,0)
 ;;=3^Malig Neop of Central Portion of Right Breast
 ;;^UTILITY(U,$J,358.3,3415,1,4,0)
 ;;=4^C50.111
 ;;^UTILITY(U,$J,358.3,3415,2)
 ;;=^5001165
 ;;^UTILITY(U,$J,358.3,3416,0)
 ;;=C50.112^^20^253^11
 ;;^UTILITY(U,$J,358.3,3416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3416,1,3,0)
 ;;=3^Malig Neop of Central Portion of Left Breast
 ;;^UTILITY(U,$J,358.3,3416,1,4,0)
 ;;=4^C50.112
 ;;^UTILITY(U,$J,358.3,3416,2)
 ;;=^5001166
 ;;^UTILITY(U,$J,358.3,3417,0)
 ;;=C50.211^^20^253^25
 ;;^UTILITY(U,$J,358.3,3417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3417,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,3417,1,4,0)
 ;;=4^C50.211
 ;;^UTILITY(U,$J,358.3,3417,2)
 ;;=^5001171
 ;;^UTILITY(U,$J,358.3,3418,0)
 ;;=C50.212^^20^253^24
 ;;^UTILITY(U,$J,358.3,3418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3418,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,3418,1,4,0)
 ;;=4^C50.212
 ;;^UTILITY(U,$J,358.3,3418,2)
 ;;=^5001172
 ;;^UTILITY(U,$J,358.3,3419,0)
 ;;=C50.311^^20^253^15
 ;;^UTILITY(U,$J,358.3,3419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3419,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,3419,1,4,0)
 ;;=4^C50.311
 ;;^UTILITY(U,$J,358.3,3419,2)
 ;;=^5001177
 ;;^UTILITY(U,$J,358.3,3420,0)
 ;;=C50.312^^20^253^14
 ;;^UTILITY(U,$J,358.3,3420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3420,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,3420,1,4,0)
 ;;=4^C50.312
 ;;^UTILITY(U,$J,358.3,3420,2)
 ;;=^5133333
 ;;^UTILITY(U,$J,358.3,3421,0)
 ;;=C50.411^^20^253^27
 ;;^UTILITY(U,$J,358.3,3421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3421,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,3421,1,4,0)
 ;;=4^C50.411
 ;;^UTILITY(U,$J,358.3,3421,2)
 ;;=^5001179
 ;;^UTILITY(U,$J,358.3,3422,0)
 ;;=C50.412^^20^253^26
 ;;^UTILITY(U,$J,358.3,3422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3422,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,3422,1,4,0)
 ;;=4^C50.412
 ;;^UTILITY(U,$J,358.3,3422,2)
 ;;=^5133335
 ;;^UTILITY(U,$J,358.3,3423,0)
 ;;=C50.511^^20^253^17
 ;;^UTILITY(U,$J,358.3,3423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3423,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,3423,1,4,0)
 ;;=4^C50.511
 ;;^UTILITY(U,$J,358.3,3423,2)
 ;;=^5001181
 ;;^UTILITY(U,$J,358.3,3424,0)
 ;;=C50.512^^20^253^16
 ;;^UTILITY(U,$J,358.3,3424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3424,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,3424,1,4,0)
 ;;=4^C50.512
 ;;^UTILITY(U,$J,358.3,3424,2)
 ;;=^5133337
 ;;^UTILITY(U,$J,358.3,3425,0)
 ;;=C50.611^^20^253^10
 ;;^UTILITY(U,$J,358.3,3425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3425,1,3,0)
 ;;=3^Malig Neop of Axillary Tail of Right Breast
 ;;^UTILITY(U,$J,358.3,3425,1,4,0)
 ;;=4^C50.611
 ;;^UTILITY(U,$J,358.3,3425,2)
 ;;=^5001183
 ;;^UTILITY(U,$J,358.3,3426,0)
 ;;=C50.612^^20^253^9
 ;;^UTILITY(U,$J,358.3,3426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3426,1,3,0)
 ;;=3^Malig Neop of Axillary Tail of Left Breast
 ;;^UTILITY(U,$J,358.3,3426,1,4,0)
 ;;=4^C50.612
 ;;^UTILITY(U,$J,358.3,3426,2)
 ;;=^5001184
 ;;^UTILITY(U,$J,358.3,3427,0)
 ;;=C50.811^^20^253^21
 ;;^UTILITY(U,$J,358.3,3427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3427,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Right Breast
 ;;^UTILITY(U,$J,358.3,3427,1,4,0)
 ;;=4^C50.811
 ;;^UTILITY(U,$J,358.3,3427,2)
 ;;=^5001189
 ;;^UTILITY(U,$J,358.3,3428,0)
 ;;=C50.812^^20^253^20
 ;;^UTILITY(U,$J,358.3,3428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3428,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Left Breast
 ;;^UTILITY(U,$J,358.3,3428,1,4,0)
 ;;=4^C50.812
 ;;^UTILITY(U,$J,358.3,3428,2)
 ;;=^5001190
 ;;^UTILITY(U,$J,358.3,3429,0)
 ;;=C50.911^^20^253^22
 ;;^UTILITY(U,$J,358.3,3429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3429,1,3,0)
 ;;=3^Malig Neop of Right Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,3429,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,3429,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,3430,0)
 ;;=C50.912^^20^253^13
 ;;^UTILITY(U,$J,358.3,3430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3430,1,3,0)
 ;;=3^Malig Neop of Left Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,3430,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,3430,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,3431,0)
 ;;=C79.81^^20^253^32
 ;;^UTILITY(U,$J,358.3,3431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3431,1,3,0)
 ;;=3^Secondary Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,3431,1,4,0)
 ;;=4^C79.81
 ;;^UTILITY(U,$J,358.3,3431,2)
 ;;=^267338
 ;;^UTILITY(U,$J,358.3,3432,0)
 ;;=D24.1^^20^253^2
 ;;^UTILITY(U,$J,358.3,3432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3432,1,3,0)
 ;;=3^Benign Neop of Right Breast
 ;;^UTILITY(U,$J,358.3,3432,1,4,0)
 ;;=4^D24.1
 ;;^UTILITY(U,$J,358.3,3432,2)
 ;;=^5002077
 ;;^UTILITY(U,$J,358.3,3433,0)
 ;;=D24.2^^20^253^1
 ;;^UTILITY(U,$J,358.3,3433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3433,1,3,0)
 ;;=3^Benign Neop of Left Breast
 ;;^UTILITY(U,$J,358.3,3433,1,4,0)
 ;;=4^D24.2
 ;;^UTILITY(U,$J,358.3,3433,2)
 ;;=^5002078
 ;;^UTILITY(U,$J,358.3,3434,0)
 ;;=N60.01^^20^253^35
 ;;^UTILITY(U,$J,358.3,3434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3434,1,3,0)
 ;;=3^Solitary Cyst of Right Breast
 ;;^UTILITY(U,$J,358.3,3434,1,4,0)
 ;;=4^N60.01
 ;;^UTILITY(U,$J,358.3,3434,2)
 ;;=^5015770
 ;;^UTILITY(U,$J,358.3,3435,0)
 ;;=N60.02^^20^253^34
 ;;^UTILITY(U,$J,358.3,3435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3435,1,3,0)
 ;;=3^Solitary Cyst of Left Breast
 ;;^UTILITY(U,$J,358.3,3435,1,4,0)
 ;;=4^N60.02
 ;;^UTILITY(U,$J,358.3,3435,2)
 ;;=^5015771
 ;;^UTILITY(U,$J,358.3,3436,0)
 ;;=N60.11^^20^253^5
 ;;^UTILITY(U,$J,358.3,3436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3436,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Right Breast
 ;;^UTILITY(U,$J,358.3,3436,1,4,0)
 ;;=4^N60.11
 ;;^UTILITY(U,$J,358.3,3436,2)
 ;;=^5015773
 ;;^UTILITY(U,$J,358.3,3437,0)
 ;;=N60.12^^20^253^4
 ;;^UTILITY(U,$J,358.3,3437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3437,1,3,0)
 ;;=3^Diffuse Cystic Mastopathy of Left Breast
