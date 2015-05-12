IBDEI02M ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3080,1,3,0)
 ;;=3^Pressure Ulcer Left Upper Back,Stage Unspec
 ;;^UTILITY(U,$J,358.3,3080,1,4,0)
 ;;=4^L89.129
 ;;^UTILITY(U,$J,358.3,3080,2)
 ;;=^5133652
 ;;^UTILITY(U,$J,358.3,3081,0)
 ;;=L89.120^^13^127^42
 ;;^UTILITY(U,$J,358.3,3081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3081,1,3,0)
 ;;=3^Pressure Ulcer Left Upper Back,Unstageable
 ;;^UTILITY(U,$J,358.3,3081,1,4,0)
 ;;=4^L89.120
 ;;^UTILITY(U,$J,358.3,3081,2)
 ;;=^5009358
 ;;^UTILITY(U,$J,358.3,3082,0)
 ;;=L89.121^^13^127^37
 ;;^UTILITY(U,$J,358.3,3082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3082,1,3,0)
 ;;=3^Pressure Ulcer Left Upper Back,Stage 1
 ;;^UTILITY(U,$J,358.3,3082,1,4,0)
 ;;=4^L89.121
 ;;^UTILITY(U,$J,358.3,3082,2)
 ;;=^5009359
 ;;^UTILITY(U,$J,358.3,3083,0)
 ;;=L89.122^^13^127^38
 ;;^UTILITY(U,$J,358.3,3083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3083,1,3,0)
 ;;=3^Pressure Ulcer Left Upper Back,Stage 2
 ;;^UTILITY(U,$J,358.3,3083,1,4,0)
 ;;=4^L89.122
 ;;^UTILITY(U,$J,358.3,3083,2)
 ;;=^5009360
 ;;^UTILITY(U,$J,358.3,3084,0)
 ;;=L89.123^^13^127^39
 ;;^UTILITY(U,$J,358.3,3084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3084,1,3,0)
 ;;=3^Pressure Ulcer Left Upper Back,Stage 3
 ;;^UTILITY(U,$J,358.3,3084,1,4,0)
 ;;=4^L89.123
 ;;^UTILITY(U,$J,358.3,3084,2)
 ;;=^5009361
 ;;^UTILITY(U,$J,358.3,3085,0)
 ;;=L89.124^^13^127^40
 ;;^UTILITY(U,$J,358.3,3085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3085,1,3,0)
 ;;=3^Pressure Ulcer Left Upper Back,Stage 4
 ;;^UTILITY(U,$J,358.3,3085,1,4,0)
 ;;=4^L89.124
 ;;^UTILITY(U,$J,358.3,3085,2)
 ;;=^5009362
 ;;^UTILITY(U,$J,358.3,3086,0)
 ;;=L89.130^^13^127^78
 ;;^UTILITY(U,$J,358.3,3086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3086,1,3,0)
 ;;=3^Pressure Ulcer Right Lower Back,Unstageable
 ;;^UTILITY(U,$J,358.3,3086,1,4,0)
 ;;=4^L89.130
 ;;^UTILITY(U,$J,358.3,3086,2)
 ;;=^5009363
 ;;^UTILITY(U,$J,358.3,3087,0)
 ;;=L89.139^^13^127^77
 ;;^UTILITY(U,$J,358.3,3087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3087,1,3,0)
 ;;=3^Pressure Ulcer Right Lower Back,Stage Unspec
 ;;^UTILITY(U,$J,358.3,3087,1,4,0)
 ;;=4^L89.139
 ;;^UTILITY(U,$J,358.3,3087,2)
 ;;=^5133653
 ;;^UTILITY(U,$J,358.3,3088,0)
 ;;=L89.131^^13^127^73
 ;;^UTILITY(U,$J,358.3,3088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3088,1,3,0)
 ;;=3^Pressure Ulcer Right Lower Back,Stage 1
 ;;^UTILITY(U,$J,358.3,3088,1,4,0)
 ;;=4^L89.131
 ;;^UTILITY(U,$J,358.3,3088,2)
 ;;=^5009364
 ;;^UTILITY(U,$J,358.3,3089,0)
 ;;=L89.132^^13^127^74
 ;;^UTILITY(U,$J,358.3,3089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3089,1,3,0)
 ;;=3^Pressure Ulcer Right Lower Back,Stage 2
 ;;^UTILITY(U,$J,358.3,3089,1,4,0)
 ;;=4^L89.132
 ;;^UTILITY(U,$J,358.3,3089,2)
 ;;=^5009365
 ;;^UTILITY(U,$J,358.3,3090,0)
 ;;=L89.133^^13^127^75
 ;;^UTILITY(U,$J,358.3,3090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3090,1,3,0)
 ;;=3^Pressure Ulcer Right Lower Back,Stage 3
 ;;^UTILITY(U,$J,358.3,3090,1,4,0)
 ;;=4^L89.133
 ;;^UTILITY(U,$J,358.3,3090,2)
 ;;=^5009366
 ;;^UTILITY(U,$J,358.3,3091,0)
 ;;=L89.134^^13^127^76
 ;;^UTILITY(U,$J,358.3,3091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3091,1,3,0)
 ;;=3^Pressure Ulcer Right Lower Back,Stage 4
 ;;^UTILITY(U,$J,358.3,3091,1,4,0)
 ;;=4^L89.134
 ;;^UTILITY(U,$J,358.3,3091,2)
 ;;=^5009367
 ;;^UTILITY(U,$J,358.3,3092,0)
 ;;=L89.140^^13^127^36
 ;;^UTILITY(U,$J,358.3,3092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3092,1,3,0)
 ;;=3^Pressure Ulcer Left Lower Back,Unstageable
 ;;^UTILITY(U,$J,358.3,3092,1,4,0)
 ;;=4^L89.140
 ;;^UTILITY(U,$J,358.3,3092,2)
 ;;=^5133655
 ;;^UTILITY(U,$J,358.3,3093,0)
 ;;=L89.149^^13^127^35
 ;;^UTILITY(U,$J,358.3,3093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3093,1,3,0)
 ;;=3^Pressure Ulcer Left Lower Back,Stage Unspec
 ;;^UTILITY(U,$J,358.3,3093,1,4,0)
 ;;=4^L89.149
 ;;^UTILITY(U,$J,358.3,3093,2)
 ;;=^5133654
 ;;^UTILITY(U,$J,358.3,3094,0)
 ;;=L89.141^^13^127^31
 ;;^UTILITY(U,$J,358.3,3094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3094,1,3,0)
 ;;=3^Pressure Ulcer Left Lower Back,Stage 1
 ;;^UTILITY(U,$J,358.3,3094,1,4,0)
 ;;=4^L89.141
 ;;^UTILITY(U,$J,358.3,3094,2)
 ;;=^5133656
 ;;^UTILITY(U,$J,358.3,3095,0)
 ;;=L89.142^^13^127^32
 ;;^UTILITY(U,$J,358.3,3095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3095,1,3,0)
 ;;=3^Pressure Ulcer Left Lower Back,Stage 2
 ;;^UTILITY(U,$J,358.3,3095,1,4,0)
 ;;=4^L89.142
 ;;^UTILITY(U,$J,358.3,3095,2)
 ;;=^5133657
 ;;^UTILITY(U,$J,358.3,3096,0)
 ;;=L89.143^^13^127^33
 ;;^UTILITY(U,$J,358.3,3096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3096,1,3,0)
 ;;=3^Pressure Ulcer Left Lower Back,Stage 3
 ;;^UTILITY(U,$J,358.3,3096,1,4,0)
 ;;=4^L89.143
 ;;^UTILITY(U,$J,358.3,3096,2)
 ;;=Pressure Ulcer Left Lower Back,Stage 3^5133658
 ;;^UTILITY(U,$J,358.3,3097,0)
 ;;=L89.144^^13^127^34
 ;;^UTILITY(U,$J,358.3,3097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3097,1,3,0)
 ;;=3^Pressure Ulcer Left Lower Back,Stage 4
 ;;^UTILITY(U,$J,358.3,3097,1,4,0)
 ;;=4^L89.144
 ;;^UTILITY(U,$J,358.3,3097,2)
 ;;=^5133659
 ;;^UTILITY(U,$J,358.3,3098,0)
 ;;=L89.210^^13^127^72
 ;;^UTILITY(U,$J,358.3,3098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3098,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Unstageable
 ;;^UTILITY(U,$J,358.3,3098,1,4,0)
 ;;=4^L89.210
 ;;^UTILITY(U,$J,358.3,3098,2)
 ;;=^5009379
 ;;^UTILITY(U,$J,358.3,3099,0)
 ;;=L89.219^^13^127^71
 ;;^UTILITY(U,$J,358.3,3099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3099,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Stage Unspec
 ;;^UTILITY(U,$J,358.3,3099,1,4,0)
 ;;=4^L89.219
 ;;^UTILITY(U,$J,358.3,3099,2)
 ;;=^5133661
 ;;^UTILITY(U,$J,358.3,3100,0)
 ;;=L89.211^^13^127^67
 ;;^UTILITY(U,$J,358.3,3100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3100,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Stage 1
 ;;^UTILITY(U,$J,358.3,3100,1,4,0)
 ;;=4^L89.211
 ;;^UTILITY(U,$J,358.3,3100,2)
 ;;=^5009380
 ;;^UTILITY(U,$J,358.3,3101,0)
 ;;=L89.212^^13^127^68
 ;;^UTILITY(U,$J,358.3,3101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3101,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Stage 2
 ;;^UTILITY(U,$J,358.3,3101,1,4,0)
 ;;=4^L89.212
 ;;^UTILITY(U,$J,358.3,3101,2)
 ;;=^5009381
 ;;^UTILITY(U,$J,358.3,3102,0)
 ;;=L89.213^^13^127^69
 ;;^UTILITY(U,$J,358.3,3102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3102,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Stage 3
 ;;^UTILITY(U,$J,358.3,3102,1,4,0)
 ;;=4^L89.213
 ;;^UTILITY(U,$J,358.3,3102,2)
 ;;=^5009382
 ;;^UTILITY(U,$J,358.3,3103,0)
 ;;=L89.214^^13^127^70
 ;;^UTILITY(U,$J,358.3,3103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3103,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Stage 4
 ;;^UTILITY(U,$J,358.3,3103,1,4,0)
 ;;=4^L89.214
 ;;^UTILITY(U,$J,358.3,3103,2)
 ;;=^5009383
 ;;^UTILITY(U,$J,358.3,3104,0)
 ;;=L89.220^^13^127^30
 ;;^UTILITY(U,$J,358.3,3104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3104,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Unstageable
 ;;^UTILITY(U,$J,358.3,3104,1,4,0)
 ;;=4^L89.220
 ;;^UTILITY(U,$J,358.3,3104,2)
 ;;=^5009384
 ;;^UTILITY(U,$J,358.3,3105,0)
 ;;=L89.229^^13^127^29
 ;;^UTILITY(U,$J,358.3,3105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3105,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Stage Unspec
 ;;^UTILITY(U,$J,358.3,3105,1,4,0)
 ;;=4^L89.229
 ;;^UTILITY(U,$J,358.3,3105,2)
 ;;=^5133662
 ;;^UTILITY(U,$J,358.3,3106,0)
 ;;=L89.221^^13^127^25
 ;;^UTILITY(U,$J,358.3,3106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3106,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Stage 1
 ;;^UTILITY(U,$J,358.3,3106,1,4,0)
 ;;=4^L89.221
 ;;^UTILITY(U,$J,358.3,3106,2)
 ;;=^5009385
 ;;^UTILITY(U,$J,358.3,3107,0)
 ;;=L89.222^^13^127^26
 ;;^UTILITY(U,$J,358.3,3107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3107,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Stage 2
 ;;^UTILITY(U,$J,358.3,3107,1,4,0)
 ;;=4^L89.222
 ;;^UTILITY(U,$J,358.3,3107,2)
 ;;=^5009386
 ;;^UTILITY(U,$J,358.3,3108,0)
 ;;=L89.223^^13^127^27
 ;;^UTILITY(U,$J,358.3,3108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3108,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Stage 3
 ;;^UTILITY(U,$J,358.3,3108,1,4,0)
 ;;=4^L89.223
 ;;^UTILITY(U,$J,358.3,3108,2)
 ;;=^5009387
 ;;^UTILITY(U,$J,358.3,3109,0)
 ;;=L89.224^^13^127^28
 ;;^UTILITY(U,$J,358.3,3109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3109,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Stage 4
 ;;^UTILITY(U,$J,358.3,3109,1,4,0)
 ;;=4^L89.224
 ;;^UTILITY(U,$J,358.3,3109,2)
 ;;=^5009388
 ;;^UTILITY(U,$J,358.3,3110,0)
 ;;=L89.310^^13^127^54
 ;;^UTILITY(U,$J,358.3,3110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3110,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Unstageable
 ;;^UTILITY(U,$J,358.3,3110,1,4,0)
 ;;=4^L89.310
 ;;^UTILITY(U,$J,358.3,3110,2)
 ;;=^5009394
 ;;^UTILITY(U,$J,358.3,3111,0)
 ;;=L89.319^^13^127^53
 ;;^UTILITY(U,$J,358.3,3111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3111,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Stage Unspec
 ;;^UTILITY(U,$J,358.3,3111,1,4,0)
 ;;=4^L89.319
 ;;^UTILITY(U,$J,358.3,3111,2)
 ;;=^5133670
 ;;^UTILITY(U,$J,358.3,3112,0)
 ;;=L89.311^^13^127^49
 ;;^UTILITY(U,$J,358.3,3112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3112,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Stage 1
 ;;^UTILITY(U,$J,358.3,3112,1,4,0)
 ;;=4^L89.311
 ;;^UTILITY(U,$J,358.3,3112,2)
 ;;=^5009395
 ;;^UTILITY(U,$J,358.3,3113,0)
 ;;=L89.312^^13^127^50
 ;;^UTILITY(U,$J,358.3,3113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3113,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Stage 2
 ;;^UTILITY(U,$J,358.3,3113,1,4,0)
 ;;=4^L89.312
 ;;^UTILITY(U,$J,358.3,3113,2)
 ;;=^5009396
 ;;^UTILITY(U,$J,358.3,3114,0)
 ;;=L89.313^^13^127^51
 ;;^UTILITY(U,$J,358.3,3114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3114,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Stage 3
 ;;^UTILITY(U,$J,358.3,3114,1,4,0)
 ;;=4^L89.313
 ;;^UTILITY(U,$J,358.3,3114,2)
 ;;=^5009397
 ;;^UTILITY(U,$J,358.3,3115,0)
 ;;=L89.314^^13^127^52
 ;;^UTILITY(U,$J,358.3,3115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3115,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Stage 4
