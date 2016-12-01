IBDEI0MX ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29055,0)
 ;;=O35.8XX2^^83^1258^142
 ;;^UTILITY(U,$J,358.3,29055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29055,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 2
 ;;^UTILITY(U,$J,358.3,29055,1,4,0)
 ;;=4^O35.8XX2
 ;;^UTILITY(U,$J,358.3,29055,2)
 ;;=^5016832
 ;;^UTILITY(U,$J,358.3,29056,0)
 ;;=O35.8XX3^^83^1258^143
 ;;^UTILITY(U,$J,358.3,29056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29056,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 3
 ;;^UTILITY(U,$J,358.3,29056,1,4,0)
 ;;=4^O35.8XX3
 ;;^UTILITY(U,$J,358.3,29056,2)
 ;;=^5016833
 ;;^UTILITY(U,$J,358.3,29057,0)
 ;;=O35.8XX4^^83^1258^144
 ;;^UTILITY(U,$J,358.3,29057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29057,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 4
 ;;^UTILITY(U,$J,358.3,29057,1,4,0)
 ;;=4^O35.8XX4
 ;;^UTILITY(U,$J,358.3,29057,2)
 ;;=^5016834
 ;;^UTILITY(U,$J,358.3,29058,0)
 ;;=O35.8XX5^^83^1258^145
 ;;^UTILITY(U,$J,358.3,29058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29058,1,3,0)
 ;;=3^Maternal care for oth fetal abnormality and damage, fetus 5
 ;;^UTILITY(U,$J,358.3,29058,1,4,0)
 ;;=4^O35.8XX5
 ;;^UTILITY(U,$J,358.3,29058,2)
 ;;=^5016835
 ;;^UTILITY(U,$J,358.3,29059,0)
 ;;=O35.5XX0^^83^1258^73
 ;;^UTILITY(U,$J,358.3,29059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29059,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, unsp
 ;;^UTILITY(U,$J,358.3,29059,1,4,0)
 ;;=4^O35.5XX0
 ;;^UTILITY(U,$J,358.3,29059,2)
 ;;=^5016810
 ;;^UTILITY(U,$J,358.3,29060,0)
 ;;=O35.5XX1^^83^1258^74
 ;;^UTILITY(U,$J,358.3,29060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29060,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 1
 ;;^UTILITY(U,$J,358.3,29060,1,4,0)
 ;;=4^O35.5XX1
 ;;^UTILITY(U,$J,358.3,29060,2)
 ;;=^5016811
 ;;^UTILITY(U,$J,358.3,29061,0)
 ;;=O35.5XX2^^83^1258^75
 ;;^UTILITY(U,$J,358.3,29061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29061,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 2
 ;;^UTILITY(U,$J,358.3,29061,1,4,0)
 ;;=4^O35.5XX2
 ;;^UTILITY(U,$J,358.3,29061,2)
 ;;=^5016812
 ;;^UTILITY(U,$J,358.3,29062,0)
 ;;=O35.5XX3^^83^1258^76
 ;;^UTILITY(U,$J,358.3,29062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29062,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 3
 ;;^UTILITY(U,$J,358.3,29062,1,4,0)
 ;;=4^O35.5XX3
 ;;^UTILITY(U,$J,358.3,29062,2)
 ;;=^5016813
 ;;^UTILITY(U,$J,358.3,29063,0)
 ;;=O35.5XX4^^83^1258^77
 ;;^UTILITY(U,$J,358.3,29063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29063,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 4
 ;;^UTILITY(U,$J,358.3,29063,1,4,0)
 ;;=4^O35.5XX4
 ;;^UTILITY(U,$J,358.3,29063,2)
 ;;=^5016814
 ;;^UTILITY(U,$J,358.3,29064,0)
 ;;=O35.5XX5^^83^1258^78
 ;;^UTILITY(U,$J,358.3,29064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29064,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs, fetus 5
 ;;^UTILITY(U,$J,358.3,29064,1,4,0)
 ;;=4^O35.5XX5
 ;;^UTILITY(U,$J,358.3,29064,2)
 ;;=^5016815
 ;;^UTILITY(U,$J,358.3,29065,0)
 ;;=O35.5XX9^^83^1258^79
 ;;^UTILITY(U,$J,358.3,29065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29065,1,3,0)
 ;;=3^Maternal care for damage to fetus by drugs NEC
 ;;^UTILITY(U,$J,358.3,29065,1,4,0)
 ;;=4^O35.5XX9
 ;;^UTILITY(U,$J,358.3,29065,2)
 ;;=^5016816
 ;;^UTILITY(U,$J,358.3,29066,0)
 ;;=O35.6XX0^^83^1258^80
 ;;^UTILITY(U,$J,358.3,29066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29066,1,3,0)
 ;;=3^Maternal care for damage to fetus by radiation, unsp
 ;;^UTILITY(U,$J,358.3,29066,1,4,0)
 ;;=4^O35.6XX0
 ;;^UTILITY(U,$J,358.3,29066,2)
 ;;=^5016817
 ;;^UTILITY(U,$J,358.3,29067,0)
 ;;=O35.6XX1^^83^1258^81
 ;;^UTILITY(U,$J,358.3,29067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29067,1,3,0)
 ;;=3^Maternal care for damage to fetus by radiation, fetus 1
 ;;^UTILITY(U,$J,358.3,29067,1,4,0)
 ;;=4^O35.6XX1
 ;;^UTILITY(U,$J,358.3,29067,2)
 ;;=^5016818
 ;;^UTILITY(U,$J,358.3,29068,0)
 ;;=O35.6XX2^^83^1258^82
 ;;^UTILITY(U,$J,358.3,29068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29068,1,3,0)
 ;;=3^Maternal care for damage to fetus by radiation, fetus 2
 ;;^UTILITY(U,$J,358.3,29068,1,4,0)
 ;;=4^O35.6XX2
 ;;^UTILITY(U,$J,358.3,29068,2)
 ;;=^5016819
 ;;^UTILITY(U,$J,358.3,29069,0)
 ;;=O35.6XX3^^83^1258^83
 ;;^UTILITY(U,$J,358.3,29069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29069,1,3,0)
 ;;=3^Maternal care for damage to fetus by radiation, fetus 3
 ;;^UTILITY(U,$J,358.3,29069,1,4,0)
 ;;=4^O35.6XX3
 ;;^UTILITY(U,$J,358.3,29069,2)
 ;;=^5016820
 ;;^UTILITY(U,$J,358.3,29070,0)
 ;;=O35.6XX4^^83^1258^84
 ;;^UTILITY(U,$J,358.3,29070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29070,1,3,0)
 ;;=3^Maternal care for damage to fetus by radiation, fetus 4
 ;;^UTILITY(U,$J,358.3,29070,1,4,0)
 ;;=4^O35.6XX4
 ;;^UTILITY(U,$J,358.3,29070,2)
 ;;=^5016821
 ;;^UTILITY(U,$J,358.3,29071,0)
 ;;=O35.6XX5^^83^1258^85
 ;;^UTILITY(U,$J,358.3,29071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29071,1,3,0)
 ;;=3^Maternal care for damage to fetus by radiation, fetus 5
 ;;^UTILITY(U,$J,358.3,29071,1,4,0)
 ;;=4^O35.6XX5
 ;;^UTILITY(U,$J,358.3,29071,2)
 ;;=^5016822
 ;;^UTILITY(U,$J,358.3,29072,0)
 ;;=O36.8120^^83^1258^1
 ;;^UTILITY(U,$J,358.3,29072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29072,1,3,0)
 ;;=3^Decreased fetal movements, second trimester, unsp
 ;;^UTILITY(U,$J,358.3,29072,1,4,0)
 ;;=4^O36.8120
 ;;^UTILITY(U,$J,358.3,29072,2)
 ;;=^5017089
 ;;^UTILITY(U,$J,358.3,29073,0)
 ;;=O36.8130^^83^1258^7
 ;;^UTILITY(U,$J,358.3,29073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29073,1,3,0)
 ;;=3^Decreased fetal movements, third trimester, unsp
 ;;^UTILITY(U,$J,358.3,29073,1,4,0)
 ;;=4^O36.8130
 ;;^UTILITY(U,$J,358.3,29073,2)
 ;;=^5017096
 ;;^UTILITY(U,$J,358.3,29074,0)
 ;;=O36.8121^^83^1258^2
 ;;^UTILITY(U,$J,358.3,29074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29074,1,3,0)
 ;;=3^Decreased fetal movements, second trimester, fetus 1
 ;;^UTILITY(U,$J,358.3,29074,1,4,0)
 ;;=4^O36.8121
 ;;^UTILITY(U,$J,358.3,29074,2)
 ;;=^5017090
 ;;^UTILITY(U,$J,358.3,29075,0)
 ;;=O36.8131^^83^1258^8
 ;;^UTILITY(U,$J,358.3,29075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29075,1,3,0)
 ;;=3^Decreased fetal movements, third trimester, fetus 1
 ;;^UTILITY(U,$J,358.3,29075,1,4,0)
 ;;=4^O36.8131
 ;;^UTILITY(U,$J,358.3,29075,2)
 ;;=^5017097
 ;;^UTILITY(U,$J,358.3,29076,0)
 ;;=O36.8122^^83^1258^3
 ;;^UTILITY(U,$J,358.3,29076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29076,1,3,0)
 ;;=3^Decreased fetal movements, second trimester, fetus 2
 ;;^UTILITY(U,$J,358.3,29076,1,4,0)
 ;;=4^O36.8122
 ;;^UTILITY(U,$J,358.3,29076,2)
 ;;=^5017091
 ;;^UTILITY(U,$J,358.3,29077,0)
 ;;=O36.8132^^83^1258^9
 ;;^UTILITY(U,$J,358.3,29077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29077,1,3,0)
 ;;=3^Decreased fetal movements, third trimester, fetus 2
 ;;^UTILITY(U,$J,358.3,29077,1,4,0)
 ;;=4^O36.8132
 ;;^UTILITY(U,$J,358.3,29077,2)
 ;;=^5017098
 ;;^UTILITY(U,$J,358.3,29078,0)
 ;;=O36.8123^^83^1258^4
 ;;^UTILITY(U,$J,358.3,29078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29078,1,3,0)
 ;;=3^Decreased fetal movements, second trimester, fetus 3
 ;;^UTILITY(U,$J,358.3,29078,1,4,0)
 ;;=4^O36.8123
 ;;^UTILITY(U,$J,358.3,29078,2)
 ;;=^5017092
 ;;^UTILITY(U,$J,358.3,29079,0)
 ;;=O36.8133^^83^1258^10
 ;;^UTILITY(U,$J,358.3,29079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29079,1,3,0)
 ;;=3^Decreased fetal movements, third trimester, fetus 3
 ;;^UTILITY(U,$J,358.3,29079,1,4,0)
 ;;=4^O36.8133
 ;;^UTILITY(U,$J,358.3,29079,2)
 ;;=^5017099
 ;;^UTILITY(U,$J,358.3,29080,0)
 ;;=O36.8124^^83^1258^5
 ;;^UTILITY(U,$J,358.3,29080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29080,1,3,0)
 ;;=3^Decreased fetal movements, second trimester, fetus 4
 ;;^UTILITY(U,$J,358.3,29080,1,4,0)
 ;;=4^O36.8124
 ;;^UTILITY(U,$J,358.3,29080,2)
 ;;=^5017093
 ;;^UTILITY(U,$J,358.3,29081,0)
 ;;=O36.8134^^83^1258^11
 ;;^UTILITY(U,$J,358.3,29081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29081,1,3,0)
 ;;=3^Decreased fetal movements, third trimester, fetus 4
 ;;^UTILITY(U,$J,358.3,29081,1,4,0)
 ;;=4^O36.8134
 ;;^UTILITY(U,$J,358.3,29081,2)
 ;;=^5017100
 ;;^UTILITY(U,$J,358.3,29082,0)
 ;;=O36.8125^^83^1258^6
 ;;^UTILITY(U,$J,358.3,29082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29082,1,3,0)
 ;;=3^Decreased fetal movements, second trimester, fetus 5
 ;;^UTILITY(U,$J,358.3,29082,1,4,0)
 ;;=4^O36.8125
 ;;^UTILITY(U,$J,358.3,29082,2)
 ;;=^5017094
 ;;^UTILITY(U,$J,358.3,29083,0)
 ;;=O36.8135^^83^1258^12
 ;;^UTILITY(U,$J,358.3,29083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29083,1,3,0)
 ;;=3^Decreased fetal movements, third trimester, fetus 5
 ;;^UTILITY(U,$J,358.3,29083,1,4,0)
 ;;=4^O36.8135
 ;;^UTILITY(U,$J,358.3,29083,2)
 ;;=^5017101
 ;;^UTILITY(U,$J,358.3,29084,0)
 ;;=O43.011^^83^1258^14
 ;;^UTILITY(U,$J,358.3,29084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29084,1,3,0)
 ;;=3^Fetomaternal placental transfusion syndrome, first trimester
 ;;^UTILITY(U,$J,358.3,29084,1,4,0)
 ;;=4^O43.011
 ;;^UTILITY(U,$J,358.3,29084,2)
 ;;=^5017389
 ;;^UTILITY(U,$J,358.3,29085,0)
 ;;=O43.012^^83^1258^13
 ;;^UTILITY(U,$J,358.3,29085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29085,1,3,0)
 ;;=3^Fetomaternal placental transfuse syndrome, second trimester
 ;;^UTILITY(U,$J,358.3,29085,1,4,0)
 ;;=4^O43.012
 ;;^UTILITY(U,$J,358.3,29085,2)
 ;;=^5017390
 ;;^UTILITY(U,$J,358.3,29086,0)
 ;;=O43.013^^83^1258^15
 ;;^UTILITY(U,$J,358.3,29086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29086,1,3,0)
 ;;=3^Fetomaternal placental transfusion syndrome, third trimester
 ;;^UTILITY(U,$J,358.3,29086,1,4,0)
 ;;=4^O43.013
 ;;^UTILITY(U,$J,358.3,29086,2)
 ;;=^5017391
 ;;^UTILITY(U,$J,358.3,29087,0)
 ;;=O36.0110^^83^1258^43
 ;;^UTILITY(U,$J,358.3,29087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29087,1,3,0)
 ;;=3^Maternal care for anti-D antibodies, first trimester, unsp
