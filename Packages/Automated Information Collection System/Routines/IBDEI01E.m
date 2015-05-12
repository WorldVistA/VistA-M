IBDEI01E ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1501,1,3,0)
 ;;=3^Pressure Ulcer Sacral Region,Stage 2
 ;;^UTILITY(U,$J,358.3,1501,1,4,0)
 ;;=4^L89.152
 ;;^UTILITY(U,$J,358.3,1501,2)
 ;;=^5009370
 ;;^UTILITY(U,$J,358.3,1502,0)
 ;;=L89.153^^6^79^105
 ;;^UTILITY(U,$J,358.3,1502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1502,1,3,0)
 ;;=3^Pressure Ulcer Sacral Region,Stage 3
 ;;^UTILITY(U,$J,358.3,1502,1,4,0)
 ;;=4^L89.153
 ;;^UTILITY(U,$J,358.3,1502,2)
 ;;=^5009371
 ;;^UTILITY(U,$J,358.3,1503,0)
 ;;=L89.154^^6^79^106
 ;;^UTILITY(U,$J,358.3,1503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1503,1,3,0)
 ;;=3^Pressure Ulcer Sacral Region,Stage 4
 ;;^UTILITY(U,$J,358.3,1503,1,4,0)
 ;;=4^L89.154
 ;;^UTILITY(U,$J,358.3,1503,2)
 ;;=^5009372
 ;;^UTILITY(U,$J,358.3,1504,0)
 ;;=L89.159^^6^79^107
 ;;^UTILITY(U,$J,358.3,1504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1504,1,3,0)
 ;;=3^Pressure Ulcer Sacral Region,Stage Unspec
 ;;^UTILITY(U,$J,358.3,1504,1,4,0)
 ;;=4^L89.159
 ;;^UTILITY(U,$J,358.3,1504,2)
 ;;=^5009373
 ;;^UTILITY(U,$J,358.3,1505,0)
 ;;=L89.210^^6^79^90
 ;;^UTILITY(U,$J,358.3,1505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1505,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Unstageable
 ;;^UTILITY(U,$J,358.3,1505,1,4,0)
 ;;=4^L89.210
 ;;^UTILITY(U,$J,358.3,1505,2)
 ;;=^5009379
 ;;^UTILITY(U,$J,358.3,1506,0)
 ;;=L89.211^^6^79^85
 ;;^UTILITY(U,$J,358.3,1506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1506,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Stage 1
 ;;^UTILITY(U,$J,358.3,1506,1,4,0)
 ;;=4^L89.211
 ;;^UTILITY(U,$J,358.3,1506,2)
 ;;=^5009380
 ;;^UTILITY(U,$J,358.3,1507,0)
 ;;=L89.212^^6^79^86
 ;;^UTILITY(U,$J,358.3,1507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1507,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Stage 2
 ;;^UTILITY(U,$J,358.3,1507,1,4,0)
 ;;=4^L89.212
 ;;^UTILITY(U,$J,358.3,1507,2)
 ;;=^5009381
 ;;^UTILITY(U,$J,358.3,1508,0)
 ;;=L89.213^^6^79^87
 ;;^UTILITY(U,$J,358.3,1508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1508,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Stage 3
 ;;^UTILITY(U,$J,358.3,1508,1,4,0)
 ;;=4^L89.213
 ;;^UTILITY(U,$J,358.3,1508,2)
 ;;=^5009382
 ;;^UTILITY(U,$J,358.3,1509,0)
 ;;=L89.214^^6^79^88
 ;;^UTILITY(U,$J,358.3,1509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1509,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Stage 4
 ;;^UTILITY(U,$J,358.3,1509,1,4,0)
 ;;=4^L89.214
 ;;^UTILITY(U,$J,358.3,1509,2)
 ;;=^5009383
 ;;^UTILITY(U,$J,358.3,1510,0)
 ;;=L89.219^^6^79^89
 ;;^UTILITY(U,$J,358.3,1510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1510,1,3,0)
 ;;=3^Pressure Ulcer Right Hip,Stage Unspec
 ;;^UTILITY(U,$J,358.3,1510,1,4,0)
 ;;=4^L89.219
 ;;^UTILITY(U,$J,358.3,1510,2)
 ;;=^5133661
 ;;^UTILITY(U,$J,358.3,1511,0)
 ;;=L89.220^^6^79^42
 ;;^UTILITY(U,$J,358.3,1511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1511,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Unstageable
 ;;^UTILITY(U,$J,358.3,1511,1,4,0)
 ;;=4^L89.220
 ;;^UTILITY(U,$J,358.3,1511,2)
 ;;=^5009384
 ;;^UTILITY(U,$J,358.3,1512,0)
 ;;=L89.221^^6^79^37
 ;;^UTILITY(U,$J,358.3,1512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1512,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Stage 1
 ;;^UTILITY(U,$J,358.3,1512,1,4,0)
 ;;=4^L89.221
 ;;^UTILITY(U,$J,358.3,1512,2)
 ;;=^5009385
 ;;^UTILITY(U,$J,358.3,1513,0)
 ;;=L89.222^^6^79^38
 ;;^UTILITY(U,$J,358.3,1513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1513,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Stage 2
 ;;^UTILITY(U,$J,358.3,1513,1,4,0)
 ;;=4^L89.222
 ;;^UTILITY(U,$J,358.3,1513,2)
 ;;=^5009386
 ;;^UTILITY(U,$J,358.3,1514,0)
 ;;=L89.223^^6^79^39
 ;;^UTILITY(U,$J,358.3,1514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1514,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Stage 3
 ;;^UTILITY(U,$J,358.3,1514,1,4,0)
 ;;=4^L89.223
 ;;^UTILITY(U,$J,358.3,1514,2)
 ;;=^5009387
 ;;^UTILITY(U,$J,358.3,1515,0)
 ;;=L89.224^^6^79^40
 ;;^UTILITY(U,$J,358.3,1515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1515,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Stage 4
 ;;^UTILITY(U,$J,358.3,1515,1,4,0)
 ;;=4^L89.224
 ;;^UTILITY(U,$J,358.3,1515,2)
 ;;=^5009388
 ;;^UTILITY(U,$J,358.3,1516,0)
 ;;=L89.229^^6^79^41
 ;;^UTILITY(U,$J,358.3,1516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1516,1,3,0)
 ;;=3^Pressure Ulcer Left Hip,Stage Unspec
 ;;^UTILITY(U,$J,358.3,1516,1,4,0)
 ;;=4^L89.229
 ;;^UTILITY(U,$J,358.3,1516,2)
 ;;=^5133662
 ;;^UTILITY(U,$J,358.3,1517,0)
 ;;=L89.310^^6^79^72
 ;;^UTILITY(U,$J,358.3,1517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1517,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Unstageable
 ;;^UTILITY(U,$J,358.3,1517,1,4,0)
 ;;=4^L89.310
 ;;^UTILITY(U,$J,358.3,1517,2)
 ;;=^5009394
 ;;^UTILITY(U,$J,358.3,1518,0)
 ;;=L89.311^^6^79^67
 ;;^UTILITY(U,$J,358.3,1518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1518,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Stage 1
 ;;^UTILITY(U,$J,358.3,1518,1,4,0)
 ;;=4^L89.311
 ;;^UTILITY(U,$J,358.3,1518,2)
 ;;=^5009395
 ;;^UTILITY(U,$J,358.3,1519,0)
 ;;=L89.312^^6^79^68
 ;;^UTILITY(U,$J,358.3,1519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1519,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Stage 2
 ;;^UTILITY(U,$J,358.3,1519,1,4,0)
 ;;=4^L89.312
 ;;^UTILITY(U,$J,358.3,1519,2)
 ;;=^5009396
 ;;^UTILITY(U,$J,358.3,1520,0)
 ;;=L89.313^^6^79^69
 ;;^UTILITY(U,$J,358.3,1520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1520,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Stage 3
 ;;^UTILITY(U,$J,358.3,1520,1,4,0)
 ;;=4^L89.313
 ;;^UTILITY(U,$J,358.3,1520,2)
 ;;=^5009397
 ;;^UTILITY(U,$J,358.3,1521,0)
 ;;=L89.314^^6^79^70
 ;;^UTILITY(U,$J,358.3,1521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1521,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Stage 4
 ;;^UTILITY(U,$J,358.3,1521,1,4,0)
 ;;=4^L89.314
 ;;^UTILITY(U,$J,358.3,1521,2)
 ;;=^5009398
 ;;^UTILITY(U,$J,358.3,1522,0)
 ;;=L89.319^^6^79^71
 ;;^UTILITY(U,$J,358.3,1522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1522,1,3,0)
 ;;=3^Pressure Ulcer Right Buttock,Stage Unspec
 ;;^UTILITY(U,$J,358.3,1522,1,4,0)
 ;;=4^L89.319
 ;;^UTILITY(U,$J,358.3,1522,2)
 ;;=^5133670
 ;;^UTILITY(U,$J,358.3,1523,0)
 ;;=L89.320^^6^79^24
 ;;^UTILITY(U,$J,358.3,1523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1523,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Unstageable
 ;;^UTILITY(U,$J,358.3,1523,1,4,0)
 ;;=4^L89.320
 ;;^UTILITY(U,$J,358.3,1523,2)
 ;;=^5009399
 ;;^UTILITY(U,$J,358.3,1524,0)
 ;;=L89.321^^6^79^19
 ;;^UTILITY(U,$J,358.3,1524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1524,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Stage 1
 ;;^UTILITY(U,$J,358.3,1524,1,4,0)
 ;;=4^L89.321
 ;;^UTILITY(U,$J,358.3,1524,2)
 ;;=^5009400
 ;;^UTILITY(U,$J,358.3,1525,0)
 ;;=L89.322^^6^79^20
 ;;^UTILITY(U,$J,358.3,1525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1525,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Stage 2
 ;;^UTILITY(U,$J,358.3,1525,1,4,0)
 ;;=4^L89.322
 ;;^UTILITY(U,$J,358.3,1525,2)
 ;;=^5009401
 ;;^UTILITY(U,$J,358.3,1526,0)
 ;;=L89.323^^6^79^21
 ;;^UTILITY(U,$J,358.3,1526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1526,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Stage 3
 ;;^UTILITY(U,$J,358.3,1526,1,4,0)
 ;;=4^L89.323
 ;;^UTILITY(U,$J,358.3,1526,2)
 ;;=^5009402
 ;;^UTILITY(U,$J,358.3,1527,0)
 ;;=L89.324^^6^79^22
 ;;^UTILITY(U,$J,358.3,1527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1527,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Stage 4
 ;;^UTILITY(U,$J,358.3,1527,1,4,0)
 ;;=4^L89.324
 ;;^UTILITY(U,$J,358.3,1527,2)
 ;;=^5009403
 ;;^UTILITY(U,$J,358.3,1528,0)
 ;;=L89.329^^6^79^23
 ;;^UTILITY(U,$J,358.3,1528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1528,1,3,0)
 ;;=3^Pressure Ulcer Left Buttock,Stage Unspec
 ;;^UTILITY(U,$J,358.3,1528,1,4,0)
 ;;=4^L89.329
 ;;^UTILITY(U,$J,358.3,1528,2)
 ;;=^5133671
 ;;^UTILITY(U,$J,358.3,1529,0)
 ;;=L89.40^^6^79^1
 ;;^UTILITY(U,$J,358.3,1529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1529,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Stage Unspec
 ;;^UTILITY(U,$J,358.3,1529,1,4,0)
 ;;=4^L89.40
 ;;^UTILITY(U,$J,358.3,1529,2)
 ;;=^5009404
 ;;^UTILITY(U,$J,358.3,1530,0)
 ;;=L89.41^^6^79^2
 ;;^UTILITY(U,$J,358.3,1530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1530,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Stage 1
 ;;^UTILITY(U,$J,358.3,1530,1,4,0)
 ;;=4^L89.41
 ;;^UTILITY(U,$J,358.3,1530,2)
 ;;=^5009405
 ;;^UTILITY(U,$J,358.3,1531,0)
 ;;=L89.42^^6^79^3
 ;;^UTILITY(U,$J,358.3,1531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1531,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Stage 2
 ;;^UTILITY(U,$J,358.3,1531,1,4,0)
 ;;=4^L89.42
 ;;^UTILITY(U,$J,358.3,1531,2)
 ;;=^5009406
 ;;^UTILITY(U,$J,358.3,1532,0)
 ;;=L89.43^^6^79^4
 ;;^UTILITY(U,$J,358.3,1532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1532,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Stage 3
 ;;^UTILITY(U,$J,358.3,1532,1,4,0)
 ;;=4^L89.43
 ;;^UTILITY(U,$J,358.3,1532,2)
 ;;=^5009407
 ;;^UTILITY(U,$J,358.3,1533,0)
 ;;=L89.44^^6^79^5
 ;;^UTILITY(U,$J,358.3,1533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1533,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Stage 4
 ;;^UTILITY(U,$J,358.3,1533,1,4,0)
 ;;=4^L89.44
 ;;^UTILITY(U,$J,358.3,1533,2)
 ;;=^5009408
 ;;^UTILITY(U,$J,358.3,1534,0)
 ;;=L89.45^^6^79^6
 ;;^UTILITY(U,$J,358.3,1534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1534,1,3,0)
 ;;=3^Pressure Ulcer Contiguous Site Back,Buttock & Hip,Unstageable
 ;;^UTILITY(U,$J,358.3,1534,1,4,0)
 ;;=4^L89.45
 ;;^UTILITY(U,$J,358.3,1534,2)
 ;;=^5009409
 ;;^UTILITY(U,$J,358.3,1535,0)
 ;;=L89.510^^6^79^66
 ;;^UTILITY(U,$J,358.3,1535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1535,1,3,0)
 ;;=3^Pressure Ulcer Right Ankle,Unstageable
 ;;^UTILITY(U,$J,358.3,1535,1,4,0)
 ;;=4^L89.510
 ;;^UTILITY(U,$J,358.3,1535,2)
 ;;=^5009415
 ;;^UTILITY(U,$J,358.3,1536,0)
 ;;=L89.511^^6^79^61
 ;;^UTILITY(U,$J,358.3,1536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1536,1,3,0)
 ;;=3^Pressure Ulcer Right Ankle,Stage 1
