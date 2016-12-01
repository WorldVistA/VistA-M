IBDEI0MT ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28925,1,4,0)
 ;;=4^O99.211
 ;;^UTILITY(U,$J,358.3,28925,2)
 ;;=^5017929
 ;;^UTILITY(U,$J,358.3,28926,0)
 ;;=O99.212^^83^1256^15
 ;;^UTILITY(U,$J,358.3,28926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28926,1,3,0)
 ;;=3^Obesity complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28926,1,4,0)
 ;;=4^O99.212
 ;;^UTILITY(U,$J,358.3,28926,2)
 ;;=^5017930
 ;;^UTILITY(U,$J,358.3,28927,0)
 ;;=O99.213^^83^1256^16
 ;;^UTILITY(U,$J,358.3,28927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28927,1,3,0)
 ;;=3^Obesity complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28927,1,4,0)
 ;;=4^O99.213
 ;;^UTILITY(U,$J,358.3,28927,2)
 ;;=^5017931
 ;;^UTILITY(U,$J,358.3,28928,0)
 ;;=O99.215^^83^1256^18
 ;;^UTILITY(U,$J,358.3,28928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28928,1,3,0)
 ;;=3^Obesity complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28928,1,4,0)
 ;;=4^O99.215
 ;;^UTILITY(U,$J,358.3,28928,2)
 ;;=^5017933
 ;;^UTILITY(U,$J,358.3,28929,0)
 ;;=O99.841^^83^1256^2
 ;;^UTILITY(U,$J,358.3,28929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28929,1,3,0)
 ;;=3^Bariatric surgery status comp pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28929,1,4,0)
 ;;=4^O99.841
 ;;^UTILITY(U,$J,358.3,28929,2)
 ;;=^5018004
 ;;^UTILITY(U,$J,358.3,28930,0)
 ;;=O99.842^^83^1256^3
 ;;^UTILITY(U,$J,358.3,28930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28930,1,3,0)
 ;;=3^Bariatric surgery status comp pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28930,1,4,0)
 ;;=4^O99.842
 ;;^UTILITY(U,$J,358.3,28930,2)
 ;;=^5018005
 ;;^UTILITY(U,$J,358.3,28931,0)
 ;;=O99.843^^83^1256^4
 ;;^UTILITY(U,$J,358.3,28931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28931,1,3,0)
 ;;=3^Bariatric surgery status comp pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28931,1,4,0)
 ;;=4^O99.843
 ;;^UTILITY(U,$J,358.3,28931,2)
 ;;=^5018006
 ;;^UTILITY(U,$J,358.3,28932,0)
 ;;=O99.845^^83^1256^5
 ;;^UTILITY(U,$J,358.3,28932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28932,1,3,0)
 ;;=3^Bariatric surgery status complicating the puerperium
 ;;^UTILITY(U,$J,358.3,28932,1,4,0)
 ;;=4^O99.845
 ;;^UTILITY(U,$J,358.3,28932,2)
 ;;=^5018008
 ;;^UTILITY(U,$J,358.3,28933,0)
 ;;=O99.351^^83^1256^10
 ;;^UTILITY(U,$J,358.3,28933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28933,1,3,0)
 ;;=3^Diseases of the nervous sys comp pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28933,1,4,0)
 ;;=4^O99.351
 ;;^UTILITY(U,$J,358.3,28933,2)
 ;;=^5017965
 ;;^UTILITY(U,$J,358.3,28934,0)
 ;;=O99.352^^83^1256^11
 ;;^UTILITY(U,$J,358.3,28934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28934,1,3,0)
 ;;=3^Diseases of the nervous sys comp pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28934,1,4,0)
 ;;=4^O99.352
 ;;^UTILITY(U,$J,358.3,28934,2)
 ;;=^5017966
 ;;^UTILITY(U,$J,358.3,28935,0)
 ;;=O99.353^^83^1256^12
 ;;^UTILITY(U,$J,358.3,28935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28935,1,3,0)
 ;;=3^Diseases of the nervous sys comp pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28935,1,4,0)
 ;;=4^O99.353
 ;;^UTILITY(U,$J,358.3,28935,2)
 ;;=^5017967
 ;;^UTILITY(U,$J,358.3,28936,0)
 ;;=O26.851^^83^1256^24
 ;;^UTILITY(U,$J,358.3,28936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28936,1,3,0)
 ;;=3^Spotting complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28936,1,4,0)
 ;;=4^O26.851
 ;;^UTILITY(U,$J,358.3,28936,2)
 ;;=^5016349
 ;;^UTILITY(U,$J,358.3,28937,0)
 ;;=O26.852^^83^1256^25
 ;;^UTILITY(U,$J,358.3,28937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28937,1,3,0)
 ;;=3^Spotting complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28937,1,4,0)
 ;;=4^O26.852
 ;;^UTILITY(U,$J,358.3,28937,2)
 ;;=^5016350
 ;;^UTILITY(U,$J,358.3,28938,0)
 ;;=O26.853^^83^1256^26
 ;;^UTILITY(U,$J,358.3,28938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28938,1,3,0)
 ;;=3^Spotting complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28938,1,4,0)
 ;;=4^O26.853
 ;;^UTILITY(U,$J,358.3,28938,2)
 ;;=^5016351
 ;;^UTILITY(U,$J,358.3,28939,0)
 ;;=O26.841^^83^1256^28
 ;;^UTILITY(U,$J,358.3,28939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28939,1,3,0)
 ;;=3^Uterine size-date discrepancy, first trimester
 ;;^UTILITY(U,$J,358.3,28939,1,4,0)
 ;;=4^O26.841
 ;;^UTILITY(U,$J,358.3,28939,2)
 ;;=^5016345
 ;;^UTILITY(U,$J,358.3,28940,0)
 ;;=O26.842^^83^1256^29
 ;;^UTILITY(U,$J,358.3,28940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28940,1,3,0)
 ;;=3^Uterine size-date discrepancy, second trimester
 ;;^UTILITY(U,$J,358.3,28940,1,4,0)
 ;;=4^O26.842
 ;;^UTILITY(U,$J,358.3,28940,2)
 ;;=^5016346
 ;;^UTILITY(U,$J,358.3,28941,0)
 ;;=O26.843^^83^1256^30
 ;;^UTILITY(U,$J,358.3,28941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28941,1,3,0)
 ;;=3^Uterine size-date discrepancy, third trimester
 ;;^UTILITY(U,$J,358.3,28941,1,4,0)
 ;;=4^O26.843
 ;;^UTILITY(U,$J,358.3,28941,2)
 ;;=^5016347
 ;;^UTILITY(U,$J,358.3,28942,0)
 ;;=O26.872^^83^1256^6
 ;;^UTILITY(U,$J,358.3,28942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28942,1,3,0)
 ;;=3^Cervical shortening, second trimester
 ;;^UTILITY(U,$J,358.3,28942,1,4,0)
 ;;=4^O26.872
 ;;^UTILITY(U,$J,358.3,28942,2)
 ;;=^5016354
 ;;^UTILITY(U,$J,358.3,28943,0)
 ;;=O26.873^^83^1256^7
 ;;^UTILITY(U,$J,358.3,28943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28943,1,3,0)
 ;;=3^Cervical shortening, third trimester
 ;;^UTILITY(U,$J,358.3,28943,1,4,0)
 ;;=4^O26.873
 ;;^UTILITY(U,$J,358.3,28943,2)
 ;;=^5016355
 ;;^UTILITY(U,$J,358.3,28944,0)
 ;;=O30.001^^83^1257^77
 ;;^UTILITY(U,$J,358.3,28944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28944,1,3,0)
 ;;=3^Twin pregnancy, unsp num plcnta & amnio sacs, first trimester
 ;;^UTILITY(U,$J,358.3,28944,1,4,0)
 ;;=4^O30.001
 ;;^UTILITY(U,$J,358.3,28944,2)
 ;;=^5016429
 ;;^UTILITY(U,$J,358.3,28945,0)
 ;;=O30.002^^83^1257^78
 ;;^UTILITY(U,$J,358.3,28945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28945,1,3,0)
 ;;=3^Twin pregnancy, unsp num plcnta & amnio sacs, second trimester
 ;;^UTILITY(U,$J,358.3,28945,1,4,0)
 ;;=4^O30.002
 ;;^UTILITY(U,$J,358.3,28945,2)
 ;;=^5016430
 ;;^UTILITY(U,$J,358.3,28946,0)
 ;;=O30.003^^83^1257^79
 ;;^UTILITY(U,$J,358.3,28946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28946,1,3,0)
 ;;=3^Twin pregnancy, unsp num plcnta & amnio sacs, third trimester
 ;;^UTILITY(U,$J,358.3,28946,1,4,0)
 ;;=4^O30.003
 ;;^UTILITY(U,$J,358.3,28946,2)
 ;;=^5016431
 ;;^UTILITY(U,$J,358.3,28947,0)
 ;;=O30.011^^83^1257^71
 ;;^UTILITY(U,$J,358.3,28947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28947,1,3,0)
 ;;=3^Twin pregnancy, monochorionic/monoamniotic, first trimester
 ;;^UTILITY(U,$J,358.3,28947,1,4,0)
 ;;=4^O30.011
 ;;^UTILITY(U,$J,358.3,28947,2)
 ;;=^5016432
 ;;^UTILITY(U,$J,358.3,28948,0)
 ;;=O30.012^^83^1257^72
 ;;^UTILITY(U,$J,358.3,28948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28948,1,3,0)
 ;;=3^Twin pregnancy, monochorionic/monoamniotic, second trimester
 ;;^UTILITY(U,$J,358.3,28948,1,4,0)
 ;;=4^O30.012
 ;;^UTILITY(U,$J,358.3,28948,2)
 ;;=^5016433
 ;;^UTILITY(U,$J,358.3,28949,0)
 ;;=O30.013^^83^1257^73
 ;;^UTILITY(U,$J,358.3,28949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28949,1,3,0)
 ;;=3^Twin pregnancy, monochorionic/monoamniotic, third trimester
 ;;^UTILITY(U,$J,358.3,28949,1,4,0)
 ;;=4^O30.013
 ;;^UTILITY(U,$J,358.3,28949,2)
 ;;=^5016434
 ;;^UTILITY(U,$J,358.3,28950,0)
 ;;=O30.021^^83^1257^1
 ;;^UTILITY(U,$J,358.3,28950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28950,1,3,0)
 ;;=3^Conjoined twin pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,28950,1,4,0)
 ;;=4^O30.021
 ;;^UTILITY(U,$J,358.3,28950,2)
 ;;=^5016436
 ;;^UTILITY(U,$J,358.3,28951,0)
 ;;=O30.022^^83^1257^2
 ;;^UTILITY(U,$J,358.3,28951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28951,1,3,0)
 ;;=3^Conjoined twin pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,28951,1,4,0)
 ;;=4^O30.022
 ;;^UTILITY(U,$J,358.3,28951,2)
 ;;=^5016437
 ;;^UTILITY(U,$J,358.3,28952,0)
 ;;=O30.023^^83^1257^3
 ;;^UTILITY(U,$J,358.3,28952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28952,1,3,0)
 ;;=3^Conjoined twin pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,28952,1,4,0)
 ;;=4^O30.023
 ;;^UTILITY(U,$J,358.3,28952,2)
 ;;=^5016438
 ;;^UTILITY(U,$J,358.3,28953,0)
 ;;=O30.031^^83^1257^68
 ;;^UTILITY(U,$J,358.3,28953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28953,1,3,0)
 ;;=3^Twin pregnancy, monochorionic/diamniotic, first trimester
 ;;^UTILITY(U,$J,358.3,28953,1,4,0)
 ;;=4^O30.031
 ;;^UTILITY(U,$J,358.3,28953,2)
 ;;=^5016440
 ;;^UTILITY(U,$J,358.3,28954,0)
 ;;=O30.032^^83^1257^69
 ;;^UTILITY(U,$J,358.3,28954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28954,1,3,0)
 ;;=3^Twin pregnancy, monochorionic/diamniotic, second trimester
 ;;^UTILITY(U,$J,358.3,28954,1,4,0)
 ;;=4^O30.032
 ;;^UTILITY(U,$J,358.3,28954,2)
 ;;=^5016441
 ;;^UTILITY(U,$J,358.3,28955,0)
 ;;=O30.033^^83^1257^70
 ;;^UTILITY(U,$J,358.3,28955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28955,1,3,0)
 ;;=3^Twin pregnancy, monochorionic/diamniotic, third trimester
 ;;^UTILITY(U,$J,358.3,28955,1,4,0)
 ;;=4^O30.033
 ;;^UTILITY(U,$J,358.3,28955,2)
 ;;=^5016442
 ;;^UTILITY(U,$J,358.3,28956,0)
 ;;=O30.041^^83^1257^65
 ;;^UTILITY(U,$J,358.3,28956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28956,1,3,0)
 ;;=3^Twin pregnancy, dichorionic/diamniotic, first trimester
 ;;^UTILITY(U,$J,358.3,28956,1,4,0)
 ;;=4^O30.041
 ;;^UTILITY(U,$J,358.3,28956,2)
 ;;=^5016444
 ;;^UTILITY(U,$J,358.3,28957,0)
 ;;=O30.042^^83^1257^66
 ;;^UTILITY(U,$J,358.3,28957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28957,1,3,0)
 ;;=3^Twin pregnancy, dichorionic/diamniotic, second trimester
 ;;^UTILITY(U,$J,358.3,28957,1,4,0)
 ;;=4^O30.042
 ;;^UTILITY(U,$J,358.3,28957,2)
 ;;=^5016445
 ;;^UTILITY(U,$J,358.3,28958,0)
 ;;=O30.043^^83^1257^67
 ;;^UTILITY(U,$J,358.3,28958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28958,1,3,0)
 ;;=3^Twin pregnancy, dichorionic/diamniotic, third trimester
