IBDEI0MS ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28892,1,3,0)
 ;;=3^Pre-existing diabetes, type 1, in pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28892,1,4,0)
 ;;=4^O24.011
 ;;^UTILITY(U,$J,358.3,28892,2)
 ;;=^5016255
 ;;^UTILITY(U,$J,358.3,28893,0)
 ;;=O24.012^^83^1255^58
 ;;^UTILITY(U,$J,358.3,28893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28893,1,3,0)
 ;;=3^Pre-exist diabetes, type 1, in pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28893,1,4,0)
 ;;=4^O24.012
 ;;^UTILITY(U,$J,358.3,28893,2)
 ;;=^5016256
 ;;^UTILITY(U,$J,358.3,28894,0)
 ;;=O24.013^^83^1255^63
 ;;^UTILITY(U,$J,358.3,28894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28894,1,3,0)
 ;;=3^Pre-existing diabetes, type 1, in pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28894,1,4,0)
 ;;=4^O24.013
 ;;^UTILITY(U,$J,358.3,28894,2)
 ;;=^5016257
 ;;^UTILITY(U,$J,358.3,28895,0)
 ;;=O24.111^^83^1255^64
 ;;^UTILITY(U,$J,358.3,28895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28895,1,3,0)
 ;;=3^Pre-existing diabetes, type 2, in pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28895,1,4,0)
 ;;=4^O24.111
 ;;^UTILITY(U,$J,358.3,28895,2)
 ;;=^5016261
 ;;^UTILITY(U,$J,358.3,28896,0)
 ;;=O24.112^^83^1255^59
 ;;^UTILITY(U,$J,358.3,28896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28896,1,3,0)
 ;;=3^Pre-exist diabetes, type 2, in pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28896,1,4,0)
 ;;=4^O24.112
 ;;^UTILITY(U,$J,358.3,28896,2)
 ;;=^5016262
 ;;^UTILITY(U,$J,358.3,28897,0)
 ;;=O24.113^^83^1255^65
 ;;^UTILITY(U,$J,358.3,28897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28897,1,3,0)
 ;;=3^Pre-existing diabetes, type 2, in pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28897,1,4,0)
 ;;=4^O24.113
 ;;^UTILITY(U,$J,358.3,28897,2)
 ;;=^5016263
 ;;^UTILITY(U,$J,358.3,28898,0)
 ;;=O24.03^^83^1255^60
 ;;^UTILITY(U,$J,358.3,28898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28898,1,3,0)
 ;;=3^Pre-existing diabetes mellitus, type 1, in the puerperium
 ;;^UTILITY(U,$J,358.3,28898,1,4,0)
 ;;=4^O24.03
 ;;^UTILITY(U,$J,358.3,28898,2)
 ;;=^5016260
 ;;^UTILITY(U,$J,358.3,28899,0)
 ;;=O24.13^^83^1255^61
 ;;^UTILITY(U,$J,358.3,28899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28899,1,3,0)
 ;;=3^Pre-existing diabetes mellitus, type 2, in the puerperium
 ;;^UTILITY(U,$J,358.3,28899,1,4,0)
 ;;=4^O24.13
 ;;^UTILITY(U,$J,358.3,28899,2)
 ;;=^5016266
 ;;^UTILITY(U,$J,358.3,28900,0)
 ;;=O99.281^^83^1255^16
 ;;^UTILITY(U,$J,358.3,28900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28900,1,3,0)
 ;;=3^Endo, nutritional and metab diseases comp preg, first tri
 ;;^UTILITY(U,$J,358.3,28900,1,4,0)
 ;;=4^O99.281
 ;;^UTILITY(U,$J,358.3,28900,2)
 ;;=^5017935
 ;;^UTILITY(U,$J,358.3,28901,0)
 ;;=O99.282^^83^1255^17
 ;;^UTILITY(U,$J,358.3,28901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28901,1,3,0)
 ;;=3^Endo, nutritional and metab diseases comp preg, second tri
 ;;^UTILITY(U,$J,358.3,28901,1,4,0)
 ;;=4^O99.282
 ;;^UTILITY(U,$J,358.3,28901,2)
 ;;=^5017936
 ;;^UTILITY(U,$J,358.3,28902,0)
 ;;=O99.283^^83^1255^18
 ;;^UTILITY(U,$J,358.3,28902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28902,1,3,0)
 ;;=3^Endo, nutritional and metab diseases comp preg, third tri
 ;;^UTILITY(U,$J,358.3,28902,1,4,0)
 ;;=4^O99.283
 ;;^UTILITY(U,$J,358.3,28902,2)
 ;;=^5017937
 ;;^UTILITY(U,$J,358.3,28903,0)
 ;;=O99.285^^83^1255^19
 ;;^UTILITY(U,$J,358.3,28903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28903,1,3,0)
 ;;=3^Endocrine, nutritional and metabolic diseases comp the puerp
 ;;^UTILITY(U,$J,358.3,28903,1,4,0)
 ;;=4^O99.285
 ;;^UTILITY(U,$J,358.3,28903,2)
 ;;=^5017939
 ;;^UTILITY(U,$J,358.3,28904,0)
 ;;=O99.011^^83^1255^3
 ;;^UTILITY(U,$J,358.3,28904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28904,1,3,0)
 ;;=3^Anemia complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28904,1,4,0)
 ;;=4^O99.011
 ;;^UTILITY(U,$J,358.3,28904,2)
 ;;=^5017916
 ;;^UTILITY(U,$J,358.3,28905,0)
 ;;=O99.012^^83^1255^4
 ;;^UTILITY(U,$J,358.3,28905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28905,1,3,0)
 ;;=3^Anemia complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28905,1,4,0)
 ;;=4^O99.012
 ;;^UTILITY(U,$J,358.3,28905,2)
 ;;=^5017917
 ;;^UTILITY(U,$J,358.3,28906,0)
 ;;=O99.013^^83^1255^5
 ;;^UTILITY(U,$J,358.3,28906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28906,1,3,0)
 ;;=3^Anemia complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28906,1,4,0)
 ;;=4^O99.013
 ;;^UTILITY(U,$J,358.3,28906,2)
 ;;=^5017918
 ;;^UTILITY(U,$J,358.3,28907,0)
 ;;=O99.03^^83^1255^6
 ;;^UTILITY(U,$J,358.3,28907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28907,1,3,0)
 ;;=3^Anemia complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28907,1,4,0)
 ;;=4^O99.03
 ;;^UTILITY(U,$J,358.3,28907,2)
 ;;=^5017921
 ;;^UTILITY(U,$J,358.3,28908,0)
 ;;=O99.321^^83^1255^12
 ;;^UTILITY(U,$J,358.3,28908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28908,1,3,0)
 ;;=3^Drug use complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28908,1,4,0)
 ;;=4^O99.321
 ;;^UTILITY(U,$J,358.3,28908,2)
 ;;=^5017947
 ;;^UTILITY(U,$J,358.3,28909,0)
 ;;=O99.322^^83^1255^13
 ;;^UTILITY(U,$J,358.3,28909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28909,1,3,0)
 ;;=3^Drug use complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28909,1,4,0)
 ;;=4^O99.322
 ;;^UTILITY(U,$J,358.3,28909,2)
 ;;=^5017948
 ;;^UTILITY(U,$J,358.3,28910,0)
 ;;=O99.323^^83^1255^14
 ;;^UTILITY(U,$J,358.3,28910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28910,1,3,0)
 ;;=3^Drug use complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28910,1,4,0)
 ;;=4^O99.323
 ;;^UTILITY(U,$J,358.3,28910,2)
 ;;=^5017949
 ;;^UTILITY(U,$J,358.3,28911,0)
 ;;=O99.325^^83^1255^15
 ;;^UTILITY(U,$J,358.3,28911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28911,1,3,0)
 ;;=3^Drug use complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28911,1,4,0)
 ;;=4^O99.325
 ;;^UTILITY(U,$J,358.3,28911,2)
 ;;=^5017951
 ;;^UTILITY(U,$J,358.3,28912,0)
 ;;=O90.6^^83^1255^57
 ;;^UTILITY(U,$J,358.3,28912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28912,1,3,0)
 ;;=3^Postpartum mood disturbance
 ;;^UTILITY(U,$J,358.3,28912,1,4,0)
 ;;=4^O90.6
 ;;^UTILITY(U,$J,358.3,28912,2)
 ;;=^5017818
 ;;^UTILITY(U,$J,358.3,28913,0)
 ;;=F53.^^83^1255^79
 ;;^UTILITY(U,$J,358.3,28913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28913,1,3,0)
 ;;=3^Puerperal psychosis
 ;;^UTILITY(U,$J,358.3,28913,1,4,0)
 ;;=4^F53.
 ;;^UTILITY(U,$J,358.3,28913,2)
 ;;=^5003626
 ;;^UTILITY(U,$J,358.3,28914,0)
 ;;=O99.411^^83^1255^8
 ;;^UTILITY(U,$J,358.3,28914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28914,1,3,0)
 ;;=3^Diseases of the circ sys comp pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28914,1,4,0)
 ;;=4^O99.411
 ;;^UTILITY(U,$J,358.3,28914,2)
 ;;=^5017970
 ;;^UTILITY(U,$J,358.3,28915,0)
 ;;=O99.412^^83^1255^9
 ;;^UTILITY(U,$J,358.3,28915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28915,1,3,0)
 ;;=3^Diseases of the circ sys comp pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28915,1,4,0)
 ;;=4^O99.412
 ;;^UTILITY(U,$J,358.3,28915,2)
 ;;=^5017971
 ;;^UTILITY(U,$J,358.3,28916,0)
 ;;=O99.413^^83^1255^10
 ;;^UTILITY(U,$J,358.3,28916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28916,1,3,0)
 ;;=3^Diseases of the circ sys comp pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28916,1,4,0)
 ;;=4^O99.413
 ;;^UTILITY(U,$J,358.3,28916,2)
 ;;=^5017972
 ;;^UTILITY(U,$J,358.3,28917,0)
 ;;=O99.43^^83^1255^11
 ;;^UTILITY(U,$J,358.3,28917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28917,1,3,0)
 ;;=3^Diseases of the circ sys complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28917,1,4,0)
 ;;=4^O99.43
 ;;^UTILITY(U,$J,358.3,28917,2)
 ;;=^5017975
 ;;^UTILITY(U,$J,358.3,28918,0)
 ;;=O33.0^^83^1255^38
 ;;^UTILITY(U,$J,358.3,28918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28918,1,3,0)
 ;;=3^Matern care for disproprtn d/t deformity of matern pelv bone
 ;;^UTILITY(U,$J,358.3,28918,1,4,0)
 ;;=4^O33.0
 ;;^UTILITY(U,$J,358.3,28918,2)
 ;;=^5016691
 ;;^UTILITY(U,$J,358.3,28919,0)
 ;;=O99.810^^83^1255^1
 ;;^UTILITY(U,$J,358.3,28919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28919,1,3,0)
 ;;=3^Abnormal glucose complicating pregnancy
 ;;^UTILITY(U,$J,358.3,28919,1,4,0)
 ;;=4^O99.810
 ;;^UTILITY(U,$J,358.3,28919,2)
 ;;=^5017994
 ;;^UTILITY(U,$J,358.3,28920,0)
 ;;=O99.815^^83^1255^2
 ;;^UTILITY(U,$J,358.3,28920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28920,1,3,0)
 ;;=3^Abnormal glucose complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28920,1,4,0)
 ;;=4^O99.815
 ;;^UTILITY(U,$J,358.3,28920,2)
 ;;=^5017996
 ;;^UTILITY(U,$J,358.3,28921,0)
 ;;=O99.331^^83^1256^20
 ;;^UTILITY(U,$J,358.3,28921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28921,1,3,0)
 ;;=3^Tobacco complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28921,1,4,0)
 ;;=4^O99.331
 ;;^UTILITY(U,$J,358.3,28921,2)
 ;;=^5017953
 ;;^UTILITY(U,$J,358.3,28922,0)
 ;;=O99.332^^83^1256^21
 ;;^UTILITY(U,$J,358.3,28922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28922,1,3,0)
 ;;=3^Tobacco complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28922,1,4,0)
 ;;=4^O99.332
 ;;^UTILITY(U,$J,358.3,28922,2)
 ;;=^5017954
 ;;^UTILITY(U,$J,358.3,28923,0)
 ;;=O99.333^^83^1256^22
 ;;^UTILITY(U,$J,358.3,28923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28923,1,3,0)
 ;;=3^Tobacco complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28923,1,4,0)
 ;;=4^O99.333
 ;;^UTILITY(U,$J,358.3,28923,2)
 ;;=^5017955
 ;;^UTILITY(U,$J,358.3,28924,0)
 ;;=O99.335^^83^1256^23
 ;;^UTILITY(U,$J,358.3,28924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28924,1,3,0)
 ;;=3^Tobacco complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28924,1,4,0)
 ;;=4^O99.335
 ;;^UTILITY(U,$J,358.3,28924,2)
 ;;=^5017957
 ;;^UTILITY(U,$J,358.3,28925,0)
 ;;=O99.211^^83^1256^14
 ;;^UTILITY(U,$J,358.3,28925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28925,1,3,0)
 ;;=3^Obesity complicating pregnancy, first trimester
