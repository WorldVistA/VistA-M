IBDEI0C9 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30014,1,3,0)
 ;;=3^Erythema Elevatum Diutinum
 ;;^UTILITY(U,$J,358.3,30014,1,4,0)
 ;;=4^L95.1
 ;;^UTILITY(U,$J,358.3,30014,2)
 ;;=^5009477
 ;;^UTILITY(U,$J,358.3,30015,0)
 ;;=L97.111^^92^1195^262
 ;;^UTILITY(U,$J,358.3,30015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30015,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30015,1,4,0)
 ;;=4^L97.111
 ;;^UTILITY(U,$J,358.3,30015,2)
 ;;=^5009485
 ;;^UTILITY(U,$J,358.3,30016,0)
 ;;=L97.112^^92^1195^263
 ;;^UTILITY(U,$J,358.3,30016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30016,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30016,1,4,0)
 ;;=4^L97.112
 ;;^UTILITY(U,$J,358.3,30016,2)
 ;;=^5009486
 ;;^UTILITY(U,$J,358.3,30017,0)
 ;;=L97.113^^92^1195^264
 ;;^UTILITY(U,$J,358.3,30017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30017,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30017,1,4,0)
 ;;=4^L97.113
 ;;^UTILITY(U,$J,358.3,30017,2)
 ;;=^5009487
 ;;^UTILITY(U,$J,358.3,30018,0)
 ;;=L97.114^^92^1195^265
 ;;^UTILITY(U,$J,358.3,30018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30018,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30018,1,4,0)
 ;;=4^L97.114
 ;;^UTILITY(U,$J,358.3,30018,2)
 ;;=^5009488
 ;;^UTILITY(U,$J,358.3,30019,0)
 ;;=L97.119^^92^1195^266
 ;;^UTILITY(U,$J,358.3,30019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30019,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Thigh w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30019,1,4,0)
 ;;=4^L97.119
 ;;^UTILITY(U,$J,358.3,30019,2)
 ;;=^5009489
 ;;^UTILITY(U,$J,358.3,30020,0)
 ;;=L97.121^^92^1195^214
 ;;^UTILITY(U,$J,358.3,30020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30020,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30020,1,4,0)
 ;;=4^L97.121
 ;;^UTILITY(U,$J,358.3,30020,2)
 ;;=^5009490
 ;;^UTILITY(U,$J,358.3,30021,0)
 ;;=L97.122^^92^1195^215
 ;;^UTILITY(U,$J,358.3,30021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30021,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30021,1,4,0)
 ;;=4^L97.122
 ;;^UTILITY(U,$J,358.3,30021,2)
 ;;=^5009491
 ;;^UTILITY(U,$J,358.3,30022,0)
 ;;=L97.123^^92^1195^216
 ;;^UTILITY(U,$J,358.3,30022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30022,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30022,1,4,0)
 ;;=4^L97.123
 ;;^UTILITY(U,$J,358.3,30022,2)
 ;;=^5009492
 ;;^UTILITY(U,$J,358.3,30023,0)
 ;;=L97.124^^92^1195^217
 ;;^UTILITY(U,$J,358.3,30023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30023,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30023,1,4,0)
 ;;=4^L97.124
 ;;^UTILITY(U,$J,358.3,30023,2)
 ;;=^5009493
 ;;^UTILITY(U,$J,358.3,30024,0)
 ;;=L97.129^^92^1195^218
 ;;^UTILITY(U,$J,358.3,30024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30024,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Thigh w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30024,1,4,0)
 ;;=4^L97.129
 ;;^UTILITY(U,$J,358.3,30024,2)
 ;;=^5009494
 ;;^UTILITY(U,$J,358.3,30025,0)
 ;;=L97.211^^92^1195^230
 ;;^UTILITY(U,$J,358.3,30025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30025,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30025,1,4,0)
 ;;=4^L97.211
 ;;^UTILITY(U,$J,358.3,30025,2)
 ;;=^5009500
 ;;^UTILITY(U,$J,358.3,30026,0)
 ;;=L97.212^^92^1195^231
 ;;^UTILITY(U,$J,358.3,30026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30026,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30026,1,4,0)
 ;;=4^L97.212
 ;;^UTILITY(U,$J,358.3,30026,2)
 ;;=^5009501
 ;;^UTILITY(U,$J,358.3,30027,0)
 ;;=L97.213^^92^1195^232
 ;;^UTILITY(U,$J,358.3,30027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30027,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30027,1,4,0)
 ;;=4^L97.213
 ;;^UTILITY(U,$J,358.3,30027,2)
 ;;=^5009502
 ;;^UTILITY(U,$J,358.3,30028,0)
 ;;=L97.214^^92^1195^233
 ;;^UTILITY(U,$J,358.3,30028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30028,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30028,1,4,0)
 ;;=4^L97.214
 ;;^UTILITY(U,$J,358.3,30028,2)
 ;;=^5009503
 ;;^UTILITY(U,$J,358.3,30029,0)
 ;;=L97.219^^92^1195^234
 ;;^UTILITY(U,$J,358.3,30029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30029,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Calf w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30029,1,4,0)
 ;;=4^L97.219
 ;;^UTILITY(U,$J,358.3,30029,2)
 ;;=^5009504
 ;;^UTILITY(U,$J,358.3,30030,0)
 ;;=L97.221^^92^1195^185
 ;;^UTILITY(U,$J,358.3,30030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30030,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30030,1,4,0)
 ;;=4^L97.221
 ;;^UTILITY(U,$J,358.3,30030,2)
 ;;=^5009505
 ;;^UTILITY(U,$J,358.3,30031,0)
 ;;=L97.222^^92^1195^186
 ;;^UTILITY(U,$J,358.3,30031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30031,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30031,1,4,0)
 ;;=4^L97.222
 ;;^UTILITY(U,$J,358.3,30031,2)
 ;;=^5009506
 ;;^UTILITY(U,$J,358.3,30032,0)
 ;;=L97.223^^92^1195^187
 ;;^UTILITY(U,$J,358.3,30032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30032,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30032,1,4,0)
 ;;=4^L97.223
 ;;^UTILITY(U,$J,358.3,30032,2)
 ;;=^5009507
 ;;^UTILITY(U,$J,358.3,30033,0)
 ;;=L97.224^^92^1195^188
 ;;^UTILITY(U,$J,358.3,30033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30033,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30033,1,4,0)
 ;;=4^L97.224
 ;;^UTILITY(U,$J,358.3,30033,2)
 ;;=^5009508
 ;;^UTILITY(U,$J,358.3,30034,0)
 ;;=L97.229^^92^1195^189
 ;;^UTILITY(U,$J,358.3,30034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30034,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Calf w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30034,1,4,0)
 ;;=4^L97.229
 ;;^UTILITY(U,$J,358.3,30034,2)
 ;;=^5009509
 ;;^UTILITY(U,$J,358.3,30035,0)
 ;;=L97.311^^92^1195^222
 ;;^UTILITY(U,$J,358.3,30035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30035,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30035,1,4,0)
 ;;=4^L97.311
 ;;^UTILITY(U,$J,358.3,30035,2)
 ;;=^5009515
 ;;^UTILITY(U,$J,358.3,30036,0)
 ;;=L97.312^^92^1195^223
 ;;^UTILITY(U,$J,358.3,30036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30036,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30036,1,4,0)
 ;;=4^L97.312
 ;;^UTILITY(U,$J,358.3,30036,2)
 ;;=^5009516
 ;;^UTILITY(U,$J,358.3,30037,0)
 ;;=L97.313^^92^1195^224
 ;;^UTILITY(U,$J,358.3,30037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30037,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30037,1,4,0)
 ;;=4^L97.313
 ;;^UTILITY(U,$J,358.3,30037,2)
 ;;=^5009517
 ;;^UTILITY(U,$J,358.3,30038,0)
 ;;=L97.314^^92^1195^225
 ;;^UTILITY(U,$J,358.3,30038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30038,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30038,1,4,0)
 ;;=4^L97.314
 ;;^UTILITY(U,$J,358.3,30038,2)
 ;;=^5009518
 ;;^UTILITY(U,$J,358.3,30039,0)
 ;;=L97.319^^92^1195^226
 ;;^UTILITY(U,$J,358.3,30039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30039,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Ankle w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30039,1,4,0)
 ;;=4^L97.319
 ;;^UTILITY(U,$J,358.3,30039,2)
 ;;=^5009519
 ;;^UTILITY(U,$J,358.3,30040,0)
 ;;=L97.321^^92^1195^177
 ;;^UTILITY(U,$J,358.3,30040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30040,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30040,1,4,0)
 ;;=4^L97.321
 ;;^UTILITY(U,$J,358.3,30040,2)
 ;;=^5009520
 ;;^UTILITY(U,$J,358.3,30041,0)
 ;;=L97.322^^92^1195^178
 ;;^UTILITY(U,$J,358.3,30041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30041,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30041,1,4,0)
 ;;=4^L97.322
 ;;^UTILITY(U,$J,358.3,30041,2)
 ;;=^5009521
 ;;^UTILITY(U,$J,358.3,30042,0)
 ;;=L97.323^^92^1195^179
 ;;^UTILITY(U,$J,358.3,30042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30042,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30042,1,4,0)
 ;;=4^L97.323
 ;;^UTILITY(U,$J,358.3,30042,2)
 ;;=^5009522
 ;;^UTILITY(U,$J,358.3,30043,0)
 ;;=L97.324^^92^1195^180
 ;;^UTILITY(U,$J,358.3,30043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30043,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30043,1,4,0)
 ;;=4^L97.324
 ;;^UTILITY(U,$J,358.3,30043,2)
 ;;=^5009523
 ;;^UTILITY(U,$J,358.3,30044,0)
 ;;=L97.329^^92^1195^181
 ;;^UTILITY(U,$J,358.3,30044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30044,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Ankle w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30044,1,4,0)
 ;;=4^L97.329
 ;;^UTILITY(U,$J,358.3,30044,2)
 ;;=^5009524
 ;;^UTILITY(U,$J,358.3,30045,0)
 ;;=L97.411^^92^1195^246
 ;;^UTILITY(U,$J,358.3,30045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30045,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Heel/Midfoot w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30045,1,4,0)
 ;;=4^L97.411
 ;;^UTILITY(U,$J,358.3,30045,2)
 ;;=^5009530
 ;;^UTILITY(U,$J,358.3,30046,0)
 ;;=L97.412^^92^1195^247
 ;;^UTILITY(U,$J,358.3,30046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30046,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Heel/Midfoot w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30046,1,4,0)
 ;;=4^L97.412
 ;;^UTILITY(U,$J,358.3,30046,2)
 ;;=^5009531
 ;;^UTILITY(U,$J,358.3,30047,0)
 ;;=L97.413^^92^1195^248
 ;;^UTILITY(U,$J,358.3,30047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30047,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Heel/Midfoot w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30047,1,4,0)
 ;;=4^L97.413
 ;;^UTILITY(U,$J,358.3,30047,2)
 ;;=^5009532
 ;;^UTILITY(U,$J,358.3,30048,0)
 ;;=L97.414^^92^1195^249
 ;;^UTILITY(U,$J,358.3,30048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30048,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Heel/Midfoot w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30048,1,4,0)
 ;;=4^L97.414
 ;;^UTILITY(U,$J,358.3,30048,2)
 ;;=^5009533
 ;;^UTILITY(U,$J,358.3,30049,0)
 ;;=L97.419^^92^1195^250
 ;;^UTILITY(U,$J,358.3,30049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30049,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Heel/Midfoot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30049,1,4,0)
 ;;=4^L97.419
 ;;^UTILITY(U,$J,358.3,30049,2)
 ;;=^5009534
 ;;^UTILITY(U,$J,358.3,30050,0)
 ;;=L97.421^^92^1195^201
 ;;^UTILITY(U,$J,358.3,30050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30050,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Heel/Midfoot w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30050,1,4,0)
 ;;=4^L97.421
 ;;^UTILITY(U,$J,358.3,30050,2)
 ;;=^5009535
 ;;^UTILITY(U,$J,358.3,30051,0)
 ;;=L97.422^^92^1195^202
 ;;^UTILITY(U,$J,358.3,30051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30051,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Heel/Midfoot w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30051,1,4,0)
 ;;=4^L97.422
 ;;^UTILITY(U,$J,358.3,30051,2)
 ;;=^5009536
 ;;^UTILITY(U,$J,358.3,30052,0)
 ;;=L97.423^^92^1195^203
 ;;^UTILITY(U,$J,358.3,30052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30052,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Heel/Midfoot w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30052,1,4,0)
 ;;=4^L97.423
 ;;^UTILITY(U,$J,358.3,30052,2)
 ;;=^5009537
 ;;^UTILITY(U,$J,358.3,30053,0)
 ;;=L97.424^^92^1195^204
 ;;^UTILITY(U,$J,358.3,30053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30053,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Heel/Midfoot w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30053,1,4,0)
 ;;=4^L97.424
 ;;^UTILITY(U,$J,358.3,30053,2)
 ;;=^5009538
 ;;^UTILITY(U,$J,358.3,30054,0)
 ;;=L97.429^^92^1195^205
 ;;^UTILITY(U,$J,358.3,30054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30054,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Heel/Midfoot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30054,1,4,0)
 ;;=4^L97.429
 ;;^UTILITY(U,$J,358.3,30054,2)
 ;;=^5009539
 ;;^UTILITY(U,$J,358.3,30055,0)
 ;;=L97.511^^92^1195^238
 ;;^UTILITY(U,$J,358.3,30055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30055,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Foot w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30055,1,4,0)
 ;;=4^L97.511
 ;;^UTILITY(U,$J,358.3,30055,2)
 ;;=^5009545
 ;;^UTILITY(U,$J,358.3,30056,0)
 ;;=L97.512^^92^1195^239
 ;;^UTILITY(U,$J,358.3,30056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30056,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Foot w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30056,1,4,0)
 ;;=4^L97.512
 ;;^UTILITY(U,$J,358.3,30056,2)
 ;;=^5009546
 ;;^UTILITY(U,$J,358.3,30057,0)
 ;;=L97.513^^92^1195^240
 ;;^UTILITY(U,$J,358.3,30057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30057,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Foot w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30057,1,4,0)
 ;;=4^L97.513
 ;;^UTILITY(U,$J,358.3,30057,2)
 ;;=^5009547
 ;;^UTILITY(U,$J,358.3,30058,0)
 ;;=L97.514^^92^1195^241
 ;;^UTILITY(U,$J,358.3,30058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30058,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Foot w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30058,1,4,0)
 ;;=4^L97.514
 ;;^UTILITY(U,$J,358.3,30058,2)
 ;;=^5009548
 ;;^UTILITY(U,$J,358.3,30059,0)
 ;;=L97.519^^92^1195^242
 ;;^UTILITY(U,$J,358.3,30059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30059,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Foot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30059,1,4,0)
 ;;=4^L97.519
 ;;^UTILITY(U,$J,358.3,30059,2)
 ;;=^5009549
 ;;^UTILITY(U,$J,358.3,30060,0)
 ;;=L97.521^^92^1195^193
 ;;^UTILITY(U,$J,358.3,30060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30060,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Foot w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30060,1,4,0)
 ;;=4^L97.521
 ;;^UTILITY(U,$J,358.3,30060,2)
 ;;=^5009550
 ;;^UTILITY(U,$J,358.3,30061,0)
 ;;=L97.522^^92^1195^194
 ;;^UTILITY(U,$J,358.3,30061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30061,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Foot w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30061,1,4,0)
 ;;=4^L97.522
 ;;^UTILITY(U,$J,358.3,30061,2)
 ;;=^5009551
 ;;^UTILITY(U,$J,358.3,30062,0)
 ;;=L97.523^^92^1195^195
 ;;^UTILITY(U,$J,358.3,30062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30062,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Foot w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30062,1,4,0)
 ;;=4^L97.523
 ;;^UTILITY(U,$J,358.3,30062,2)
 ;;=^5009552
 ;;^UTILITY(U,$J,358.3,30063,0)
 ;;=L97.524^^92^1195^196
 ;;^UTILITY(U,$J,358.3,30063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30063,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Foot w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30063,1,4,0)
 ;;=4^L97.524
 ;;^UTILITY(U,$J,358.3,30063,2)
 ;;=^5009553
 ;;^UTILITY(U,$J,358.3,30064,0)
 ;;=L97.529^^92^1195^197
 ;;^UTILITY(U,$J,358.3,30064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30064,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Foot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30064,1,4,0)
 ;;=4^L97.529
 ;;^UTILITY(U,$J,358.3,30064,2)
 ;;=^5009554
 ;;^UTILITY(U,$J,358.3,30065,0)
 ;;=L97.911^^92^1195^254
 ;;^UTILITY(U,$J,358.3,30065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30065,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Lower Leg w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30065,1,4,0)
 ;;=4^L97.911
 ;;^UTILITY(U,$J,358.3,30065,2)
 ;;=^5133679
 ;;^UTILITY(U,$J,358.3,30066,0)
 ;;=L97.912^^92^1195^255
 ;;^UTILITY(U,$J,358.3,30066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30066,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Lower Leg w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30066,1,4,0)
 ;;=4^L97.912
 ;;^UTILITY(U,$J,358.3,30066,2)
 ;;=^5133681
 ;;^UTILITY(U,$J,358.3,30067,0)
 ;;=L97.913^^92^1195^256
 ;;^UTILITY(U,$J,358.3,30067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30067,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Lower Leg w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30067,1,4,0)
 ;;=4^L97.913
 ;;^UTILITY(U,$J,358.3,30067,2)
 ;;=^5133683
 ;;^UTILITY(U,$J,358.3,30068,0)
 ;;=L97.914^^92^1195^257
 ;;^UTILITY(U,$J,358.3,30068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30068,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Lower Leg w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30068,1,4,0)
 ;;=4^L97.914
 ;;^UTILITY(U,$J,358.3,30068,2)
 ;;=^5133685
 ;;^UTILITY(U,$J,358.3,30069,0)
 ;;=L97.919^^92^1195^258
 ;;^UTILITY(U,$J,358.3,30069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30069,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Right Lower Leg w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30069,1,4,0)
 ;;=4^L97.919
 ;;^UTILITY(U,$J,358.3,30069,2)
 ;;=^5133688
 ;;^UTILITY(U,$J,358.3,30070,0)
 ;;=L97.921^^92^1195^207
 ;;^UTILITY(U,$J,358.3,30070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30070,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,30070,1,4,0)
 ;;=4^L97.921
 ;;^UTILITY(U,$J,358.3,30070,2)
 ;;=^5133680
 ;;^UTILITY(U,$J,358.3,30071,0)
 ;;=L97.922^^92^1195^208
 ;;^UTILITY(U,$J,358.3,30071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30071,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,30071,1,4,0)
 ;;=4^L97.922
 ;;^UTILITY(U,$J,358.3,30071,2)
 ;;=^5133682
 ;;^UTILITY(U,$J,358.3,30072,0)
 ;;=L97.923^^92^1195^209
 ;;^UTILITY(U,$J,358.3,30072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30072,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,30072,1,4,0)
 ;;=4^L97.923
 ;;^UTILITY(U,$J,358.3,30072,2)
 ;;=^5133684
 ;;^UTILITY(U,$J,358.3,30073,0)
 ;;=L97.924^^92^1195^210
 ;;^UTILITY(U,$J,358.3,30073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30073,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,30073,1,4,0)
 ;;=4^L97.924
 ;;^UTILITY(U,$J,358.3,30073,2)
 ;;=^5133686
 ;;^UTILITY(U,$J,358.3,30074,0)
 ;;=L97.929^^92^1195^211
 ;;^UTILITY(U,$J,358.3,30074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30074,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer of Left Lower Leg w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30074,1,4,0)
 ;;=4^L97.929
 ;;^UTILITY(U,$J,358.3,30074,2)
 ;;=^5133689
 ;;^UTILITY(U,$J,358.3,30075,0)
 ;;=L98.2^^92^1195^152
 ;;^UTILITY(U,$J,358.3,30075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30075,1,3,0)
 ;;=3^Febrile Neutrophilic Dermatosis
 ;;^UTILITY(U,$J,358.3,30075,1,4,0)
 ;;=4^L98.2
 ;;^UTILITY(U,$J,358.3,30075,2)
 ;;=^5009575
 ;;^UTILITY(U,$J,358.3,30076,0)
 ;;=L98.9^^92^1195^307
 ;;^UTILITY(U,$J,358.3,30076,1,0)
 ;;=^358.31IA^4^2
