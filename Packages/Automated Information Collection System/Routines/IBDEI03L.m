IBDEI03L ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4355,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,4356,0)
 ;;=E10.40^^21^202^2
 ;;^UTILITY(U,$J,358.3,4356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4356,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,4356,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,4356,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,4357,0)
 ;;=E10.51^^21^202^3
 ;;^UTILITY(U,$J,358.3,4357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4357,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopath w/o Gangrene
 ;;^UTILITY(U,$J,358.3,4357,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,4357,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,4358,0)
 ;;=E10.621^^21^202^4
 ;;^UTILITY(U,$J,358.3,4358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4358,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,4358,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,4358,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,4359,0)
 ;;=E10.628^^21^202^5
 ;;^UTILITY(U,$J,358.3,4359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4359,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oth Skin Complications
 ;;^UTILITY(U,$J,358.3,4359,1,4,0)
 ;;=4^E10.628
 ;;^UTILITY(U,$J,358.3,4359,2)
 ;;=^5002618
 ;;^UTILITY(U,$J,358.3,4360,0)
 ;;=E10.622^^21^202^6
 ;;^UTILITY(U,$J,358.3,4360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4360,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oth Skin Ulcer
 ;;^UTILITY(U,$J,358.3,4360,1,4,0)
 ;;=4^E10.622
 ;;^UTILITY(U,$J,358.3,4360,2)
 ;;=^5002617
 ;;^UTILITY(U,$J,358.3,4361,0)
 ;;=E11.620^^21^202^7
 ;;^UTILITY(U,$J,358.3,4361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4361,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,4361,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,4361,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,4362,0)
 ;;=E11.40^^21^202^8
 ;;^UTILITY(U,$J,358.3,4362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4362,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,4362,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,4362,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,4363,0)
 ;;=E11.51^^21^202^9
 ;;^UTILITY(U,$J,358.3,4363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4363,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Peripheral Angiopath w/o Gangrene
 ;;^UTILITY(U,$J,358.3,4363,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,4363,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,4364,0)
 ;;=E11.621^^21^202^10
 ;;^UTILITY(U,$J,358.3,4364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4364,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,4364,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,4364,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,4365,0)
 ;;=E11.618^^21^202^11
 ;;^UTILITY(U,$J,358.3,4365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4365,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oth Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,4365,1,4,0)
 ;;=4^E11.618
 ;;^UTILITY(U,$J,358.3,4365,2)
 ;;=^5002654
 ;;^UTILITY(U,$J,358.3,4366,0)
 ;;=E11.628^^21^202^12
 ;;^UTILITY(U,$J,358.3,4366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4366,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oth Skin Complications
 ;;^UTILITY(U,$J,358.3,4366,1,4,0)
 ;;=4^E11.628
 ;;^UTILITY(U,$J,358.3,4366,2)
 ;;=^5002658
 ;;^UTILITY(U,$J,358.3,4367,0)
 ;;=E11.622^^21^202^13
 ;;^UTILITY(U,$J,358.3,4367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4367,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oth Skin Ulcer
 ;;^UTILITY(U,$J,358.3,4367,1,4,0)
 ;;=4^E11.622
 ;;^UTILITY(U,$J,358.3,4367,2)
 ;;=^5002657
 ;;^UTILITY(U,$J,358.3,4368,0)
 ;;=L89.90^^21^203^107
 ;;^UTILITY(U,$J,358.3,4368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4368,1,3,0)
 ;;=3^Pressure Ulcer Unspec Site,Unspec Stage
 ;;^UTILITY(U,$J,358.3,4368,1,4,0)
 ;;=4^L89.90
 ;;^UTILITY(U,$J,358.3,4368,2)
 ;;=^5133666
 ;;^UTILITY(U,$J,358.3,4369,0)
 ;;=L89.91^^21^203^103
 ;;^UTILITY(U,$J,358.3,4369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4369,1,3,0)
 ;;=3^Pressure Ulcer Unspec Site,Stage 1
 ;;^UTILITY(U,$J,358.3,4369,1,4,0)
 ;;=4^L89.91
 ;;^UTILITY(U,$J,358.3,4369,2)
 ;;=^5133664
 ;;^UTILITY(U,$J,358.3,4370,0)
 ;;=L89.92^^21^203^104
 ;;^UTILITY(U,$J,358.3,4370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4370,1,3,0)
 ;;=3^Pressure Ulcer Unspec Site,Stage 2
 ;;^UTILITY(U,$J,358.3,4370,1,4,0)
 ;;=4^L89.92
 ;;^UTILITY(U,$J,358.3,4370,2)
 ;;=^5133667
 ;;^UTILITY(U,$J,358.3,4371,0)
 ;;=L89.93^^21^203^105
 ;;^UTILITY(U,$J,358.3,4371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4371,1,3,0)
 ;;=3^Pressure Ulcer Unspec Site,Stage 3
 ;;^UTILITY(U,$J,358.3,4371,1,4,0)
 ;;=4^L89.93
 ;;^UTILITY(U,$J,358.3,4371,2)
 ;;=^5133668
 ;;^UTILITY(U,$J,358.3,4372,0)
 ;;=L89.94^^21^203^106
 ;;^UTILITY(U,$J,358.3,4372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4372,1,3,0)
 ;;=3^Pressure Ulcer Unspec Site,Stage 4
 ;;^UTILITY(U,$J,358.3,4372,1,4,0)
 ;;=4^L89.94
 ;;^UTILITY(U,$J,358.3,4372,2)
 ;;=^5133669
 ;;^UTILITY(U,$J,358.3,4373,0)
 ;;=L89.95^^21^203^108
 ;;^UTILITY(U,$J,358.3,4373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4373,1,3,0)
 ;;=3^Pressure Ulcer Unspec Site,Unstageable
 ;;^UTILITY(U,$J,358.3,4373,1,4,0)
 ;;=4^L89.95
 ;;^UTILITY(U,$J,358.3,4373,2)
 ;;=^5133660
 ;;^UTILITY(U,$J,358.3,4374,0)
 ;;=L89.41^^21^203^1
 ;;^UTILITY(U,$J,358.3,4374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4374,1,3,0)
 ;;=3^Pressure Ulcer Contig Site Back/Buttock/Hip,Stage 1
 ;;^UTILITY(U,$J,358.3,4374,1,4,0)
 ;;=4^L89.41
 ;;^UTILITY(U,$J,358.3,4374,2)
 ;;=^5009405
 ;;^UTILITY(U,$J,358.3,4375,0)
 ;;=L89.42^^21^203^2
 ;;^UTILITY(U,$J,358.3,4375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4375,1,3,0)
 ;;=3^Pressure Ulcer Contig Site Back/Buttock/Hip,Stage 2
 ;;^UTILITY(U,$J,358.3,4375,1,4,0)
 ;;=4^L89.42
 ;;^UTILITY(U,$J,358.3,4375,2)
 ;;=^5009406
 ;;^UTILITY(U,$J,358.3,4376,0)
 ;;=L89.43^^21^203^3
 ;;^UTILITY(U,$J,358.3,4376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4376,1,3,0)
 ;;=3^Pressure Ulcer Contig Site Back/Buttock/Hip,Stage 3
 ;;^UTILITY(U,$J,358.3,4376,1,4,0)
 ;;=4^L89.43
 ;;^UTILITY(U,$J,358.3,4376,2)
 ;;=^5009407
 ;;^UTILITY(U,$J,358.3,4377,0)
 ;;=L89.44^^21^203^4
 ;;^UTILITY(U,$J,358.3,4377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4377,1,3,0)
 ;;=3^Pressure Ulcer Contig Site Back/Buttock/Hip,Stage 4
 ;;^UTILITY(U,$J,358.3,4377,1,4,0)
 ;;=4^L89.44
 ;;^UTILITY(U,$J,358.3,4377,2)
 ;;=^5009408
 ;;^UTILITY(U,$J,358.3,4378,0)
 ;;=L89.45^^21^203^5
 ;;^UTILITY(U,$J,358.3,4378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4378,1,3,0)
 ;;=3^Pressure Ulcer Contig Site Back/Buttock/Hip,Unstageable
 ;;^UTILITY(U,$J,358.3,4378,1,4,0)
 ;;=4^L89.45
 ;;^UTILITY(U,$J,358.3,4378,2)
 ;;=^5009409
 ;;^UTILITY(U,$J,358.3,4379,0)
 ;;=L89.40^^21^203^6
 ;;^UTILITY(U,$J,358.3,4379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4379,1,3,0)
 ;;=3^Pressure Ulcer Contig Site Back/Buttock/Hip,Unspec Stage
 ;;^UTILITY(U,$J,358.3,4379,1,4,0)
 ;;=4^L89.40
 ;;^UTILITY(U,$J,358.3,4379,2)
 ;;=^5009404
 ;;^UTILITY(U,$J,358.3,4380,0)
 ;;=L89.611^^21^203^73
 ;;^UTILITY(U,$J,358.3,4380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4380,1,3,0)
 ;;=3^Pressure Ulcer Right Heel,Stage 1
 ;;^UTILITY(U,$J,358.3,4380,1,4,0)
 ;;=4^L89.611
 ;;^UTILITY(U,$J,358.3,4380,2)
 ;;=^5009431
 ;;^UTILITY(U,$J,358.3,4381,0)
 ;;=L89.811^^21^203^7
 ;;^UTILITY(U,$J,358.3,4381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4381,1,3,0)
 ;;=3^Pressure Ulcer Head,Stage 1
 ;;^UTILITY(U,$J,358.3,4381,1,4,0)
 ;;=4^L89.811
 ;;^UTILITY(U,$J,358.3,4381,2)
 ;;=^5009441
 ;;^UTILITY(U,$J,358.3,4382,0)
 ;;=L89.812^^21^203^8
 ;;^UTILITY(U,$J,358.3,4382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4382,1,3,0)
 ;;=3^Pressure Ulcer Head,Stage 2
 ;;^UTILITY(U,$J,358.3,4382,1,4,0)
 ;;=4^L89.812
 ;;^UTILITY(U,$J,358.3,4382,2)
 ;;=^5009442
 ;;^UTILITY(U,$J,358.3,4383,0)
 ;;=L89.813^^21^203^9
 ;;^UTILITY(U,$J,358.3,4383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4383,1,3,0)
 ;;=3^Pressure Ulcer Head,Stage 3
 ;;^UTILITY(U,$J,358.3,4383,1,4,0)
 ;;=4^L89.813
 ;;^UTILITY(U,$J,358.3,4383,2)
 ;;=^5009443
 ;;^UTILITY(U,$J,358.3,4384,0)
 ;;=L89.814^^21^203^10
 ;;^UTILITY(U,$J,358.3,4384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4384,1,3,0)
 ;;=3^Pressure Ulcer Head,Stage 4
 ;;^UTILITY(U,$J,358.3,4384,1,4,0)
 ;;=4^L89.814
 ;;^UTILITY(U,$J,358.3,4384,2)
 ;;=^5009444
 ;;^UTILITY(U,$J,358.3,4385,0)
 ;;=L89.819^^21^203^11
 ;;^UTILITY(U,$J,358.3,4385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4385,1,3,0)
 ;;=3^Pressure Ulcer Head,Unspec Stage
 ;;^UTILITY(U,$J,358.3,4385,1,4,0)
 ;;=4^L89.819
 ;;^UTILITY(U,$J,358.3,4385,2)
 ;;=^5009445
 ;;^UTILITY(U,$J,358.3,4386,0)
 ;;=L89.810^^21^203^12
 ;;^UTILITY(U,$J,358.3,4386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4386,1,3,0)
 ;;=3^Pressure Ulcer Head,Unstageable
 ;;^UTILITY(U,$J,358.3,4386,1,4,0)
 ;;=4^L89.810
 ;;^UTILITY(U,$J,358.3,4386,2)
 ;;=^5009440
 ;;^UTILITY(U,$J,358.3,4387,0)
 ;;=L89.521^^21^203^13
 ;;^UTILITY(U,$J,358.3,4387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4387,1,3,0)
 ;;=3^Pressure Ulcer Left Ankle,Stage 1
 ;;^UTILITY(U,$J,358.3,4387,1,4,0)
 ;;=4^L89.521
 ;;^UTILITY(U,$J,358.3,4387,2)
 ;;=^5009421
 ;;^UTILITY(U,$J,358.3,4388,0)
 ;;=L89.522^^21^203^14
 ;;^UTILITY(U,$J,358.3,4388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4388,1,3,0)
 ;;=3^Pressure Ulcer Left Ankle,Stage 2
 ;;^UTILITY(U,$J,358.3,4388,1,4,0)
 ;;=4^L89.522
 ;;^UTILITY(U,$J,358.3,4388,2)
 ;;=^5009422
 ;;^UTILITY(U,$J,358.3,4389,0)
 ;;=L89.523^^21^203^15
 ;;^UTILITY(U,$J,358.3,4389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4389,1,3,0)
 ;;=3^Pressure Ulcer Left Ankle,Stage 3
 ;;^UTILITY(U,$J,358.3,4389,1,4,0)
 ;;=4^L89.523
 ;;^UTILITY(U,$J,358.3,4389,2)
 ;;=^5009423
 ;;^UTILITY(U,$J,358.3,4390,0)
 ;;=L89.524^^21^203^16
 ;;^UTILITY(U,$J,358.3,4390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4390,1,3,0)
 ;;=3^Pressure Ulcer Left Ankle,Stage 4
 ;;^UTILITY(U,$J,358.3,4390,1,4,0)
 ;;=4^L89.524
 ;;^UTILITY(U,$J,358.3,4390,2)
 ;;=^5009424
 ;;^UTILITY(U,$J,358.3,4391,0)
 ;;=L89.529^^21^203^17
