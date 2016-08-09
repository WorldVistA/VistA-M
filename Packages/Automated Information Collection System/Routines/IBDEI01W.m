IBDEI01W ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1411,2)
 ;;=^5008356
 ;;^UTILITY(U,$J,358.3,1412,0)
 ;;=J96.92^^9^120^11
 ;;^UTILITY(U,$J,358.3,1412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1412,1,3,0)
 ;;=3^Resp Failure,Unspec w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1412,1,4,0)
 ;;=4^J96.92
 ;;^UTILITY(U,$J,358.3,1412,2)
 ;;=^5008358
 ;;^UTILITY(U,$J,358.3,1413,0)
 ;;=J96.91^^9^120^12
 ;;^UTILITY(U,$J,358.3,1413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1413,1,3,0)
 ;;=3^Resp Failure,Unspec w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1413,1,4,0)
 ;;=4^J96.91
 ;;^UTILITY(U,$J,358.3,1413,2)
 ;;=^5008357
 ;;^UTILITY(U,$J,358.3,1414,0)
 ;;=J96.00^^9^120^7
 ;;^UTILITY(U,$J,358.3,1414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1414,1,3,0)
 ;;=3^Resp Failure,Acute,Unspec w/ Hypoxia or Hypercapnia
 ;;^UTILITY(U,$J,358.3,1414,1,4,0)
 ;;=4^J96.00
 ;;^UTILITY(U,$J,358.3,1414,2)
 ;;=^5008347
 ;;^UTILITY(U,$J,358.3,1415,0)
 ;;=J96.02^^9^120^5
 ;;^UTILITY(U,$J,358.3,1415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1415,1,3,0)
 ;;=3^Resp Failure,Acute w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1415,1,4,0)
 ;;=4^J96.02
 ;;^UTILITY(U,$J,358.3,1415,2)
 ;;=^5008349
 ;;^UTILITY(U,$J,358.3,1416,0)
 ;;=J96.01^^9^120^6
 ;;^UTILITY(U,$J,358.3,1416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1416,1,3,0)
 ;;=3^Resp Failure,Acute w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1416,1,4,0)
 ;;=4^J96.01
 ;;^UTILITY(U,$J,358.3,1416,2)
 ;;=^5008348
 ;;^UTILITY(U,$J,358.3,1417,0)
 ;;=J96.22^^9^120^3
 ;;^UTILITY(U,$J,358.3,1417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1417,1,3,0)
 ;;=3^Resp Failure,Acute & Chronic w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1417,1,4,0)
 ;;=4^J96.22
 ;;^UTILITY(U,$J,358.3,1417,2)
 ;;=^5008355
 ;;^UTILITY(U,$J,358.3,1418,0)
 ;;=J96.21^^9^120^4
 ;;^UTILITY(U,$J,358.3,1418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1418,1,3,0)
 ;;=3^Resp Failure,Acute & Chronic w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1418,1,4,0)
 ;;=4^J96.21
 ;;^UTILITY(U,$J,358.3,1418,2)
 ;;=^5008354
 ;;^UTILITY(U,$J,358.3,1419,0)
 ;;=J96.10^^9^120^10
 ;;^UTILITY(U,$J,358.3,1419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1419,1,3,0)
 ;;=3^Resp Failure,Chronic,Unspec w/ Hypoxia or Hypercapnia
 ;;^UTILITY(U,$J,358.3,1419,1,4,0)
 ;;=4^J96.10
 ;;^UTILITY(U,$J,358.3,1419,2)
 ;;=^5008350
 ;;^UTILITY(U,$J,358.3,1420,0)
 ;;=J96.12^^9^120^8
 ;;^UTILITY(U,$J,358.3,1420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1420,1,3,0)
 ;;=3^Resp Failure,Chronic w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,1420,1,4,0)
 ;;=4^J96.12
 ;;^UTILITY(U,$J,358.3,1420,2)
 ;;=^5008352
 ;;^UTILITY(U,$J,358.3,1421,0)
 ;;=J96.11^^9^120^9
 ;;^UTILITY(U,$J,358.3,1421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1421,1,3,0)
 ;;=3^Resp Failure,Chronic w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,1421,1,4,0)
 ;;=4^J96.11
 ;;^UTILITY(U,$J,358.3,1421,2)
 ;;=^5008351
 ;;^UTILITY(U,$J,358.3,1422,0)
 ;;=S23.9XXA^^9^121^18
 ;;^UTILITY(U,$J,358.3,1422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1422,1,3,0)
 ;;=3^Sprain Thorax,Unspec Part,Initial Encounter
 ;;^UTILITY(U,$J,358.3,1422,1,4,0)
 ;;=4^S23.9XXA
 ;;^UTILITY(U,$J,358.3,1422,2)
 ;;=^5023267
 ;;^UTILITY(U,$J,358.3,1423,0)
 ;;=I69.928^^9^121^13
 ;;^UTILITY(U,$J,358.3,1423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1423,1,3,0)
 ;;=3^Speech/Lang Deficits Following Unspec Cerebrovascular Disease
 ;;^UTILITY(U,$J,358.3,1423,1,4,0)
 ;;=4^I69.928
 ;;^UTILITY(U,$J,358.3,1423,2)
 ;;=^5007557
 ;;^UTILITY(U,$J,358.3,1424,0)
 ;;=S13.4XXA^^9^121^17
 ;;^UTILITY(U,$J,358.3,1424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1424,1,3,0)
 ;;=3^Sprain Ligaments Cervical Spine,Initial Encounter
 ;;^UTILITY(U,$J,358.3,1424,1,4,0)
 ;;=4^S13.4XXA
 ;;^UTILITY(U,$J,358.3,1424,2)
 ;;=^5022028
 ;;^UTILITY(U,$J,358.3,1425,0)
 ;;=M15.3^^9^121^5
 ;;^UTILITY(U,$J,358.3,1425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1425,1,3,0)
 ;;=3^Secondary Multiple Arthritis
 ;;^UTILITY(U,$J,358.3,1425,1,4,0)
 ;;=4^M15.3
 ;;^UTILITY(U,$J,358.3,1425,2)
 ;;=^5010765
 ;;^UTILITY(U,$J,358.3,1426,0)
 ;;=L08.9^^9^121^9
 ;;^UTILITY(U,$J,358.3,1426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1426,1,3,0)
 ;;=3^Skin Infection,Unspec
 ;;^UTILITY(U,$J,358.3,1426,1,4,0)
 ;;=4^L08.9
 ;;^UTILITY(U,$J,358.3,1426,2)
 ;;=^5009082
 ;;^UTILITY(U,$J,358.3,1427,0)
 ;;=L98.9^^9^121^10
 ;;^UTILITY(U,$J,358.3,1427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1427,1,3,0)
 ;;=3^Skin/Subcutaneous Tissue Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1427,1,4,0)
 ;;=4^L98.9
 ;;^UTILITY(U,$J,358.3,1427,2)
 ;;=^5009595
 ;;^UTILITY(U,$J,358.3,1428,0)
 ;;=M48.06^^9^121^14
 ;;^UTILITY(U,$J,358.3,1428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1428,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,1428,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,1428,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,1429,0)
 ;;=R22.2^^9^121^19
 ;;^UTILITY(U,$J,358.3,1429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1429,1,3,0)
 ;;=3^Swelling,Mass & Lump,Trunk
 ;;^UTILITY(U,$J,358.3,1429,1,4,0)
 ;;=4^R22.2
 ;;^UTILITY(U,$J,358.3,1429,2)
 ;;=^5019286
 ;;^UTILITY(U,$J,358.3,1430,0)
 ;;=M54.31^^9^121^3
 ;;^UTILITY(U,$J,358.3,1430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1430,1,3,0)
 ;;=3^Sciatica,Right Side
 ;;^UTILITY(U,$J,358.3,1430,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,1430,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,1431,0)
 ;;=M54.32^^9^121^2
 ;;^UTILITY(U,$J,358.3,1431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1431,1,3,0)
 ;;=3^Sciatica,Left Side
 ;;^UTILITY(U,$J,358.3,1431,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,1431,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,1432,0)
 ;;=F20.5^^9^121^1
 ;;^UTILITY(U,$J,358.3,1432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1432,1,3,0)
 ;;=3^Schizophrenia,Residual
 ;;^UTILITY(U,$J,358.3,1432,1,4,0)
 ;;=4^F20.5
 ;;^UTILITY(U,$J,358.3,1432,2)
 ;;=^5003473
 ;;^UTILITY(U,$J,358.3,1433,0)
 ;;=J01.90^^9^121^7
 ;;^UTILITY(U,$J,358.3,1433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1433,1,3,0)
 ;;=3^Sinusitis Acute,Unspec
 ;;^UTILITY(U,$J,358.3,1433,1,4,0)
 ;;=4^J01.90
 ;;^UTILITY(U,$J,358.3,1433,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,1434,0)
 ;;=J32.9^^9^121^8
 ;;^UTILITY(U,$J,358.3,1434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1434,1,3,0)
 ;;=3^Sinusitis,Chronic Unspec
 ;;^UTILITY(U,$J,358.3,1434,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,1434,2)
 ;;=^5008207
 ;;^UTILITY(U,$J,358.3,1435,0)
 ;;=L72.3^^9^121^4
 ;;^UTILITY(U,$J,358.3,1435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1435,1,3,0)
 ;;=3^Sebaceous Cyst
 ;;^UTILITY(U,$J,358.3,1435,1,4,0)
 ;;=4^L72.3
 ;;^UTILITY(U,$J,358.3,1435,2)
 ;;=^5009281
 ;;^UTILITY(U,$J,358.3,1436,0)
 ;;=M46.90^^9^121^15
 ;;^UTILITY(U,$J,358.3,1436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1436,1,3,0)
 ;;=3^Spondylopathy Inflammatory,Site Unspec
 ;;^UTILITY(U,$J,358.3,1436,1,4,0)
 ;;=4^M46.90
 ;;^UTILITY(U,$J,358.3,1436,2)
 ;;=^5012030
 ;;^UTILITY(U,$J,358.3,1437,0)
 ;;=M47.819^^9^121^16
 ;;^UTILITY(U,$J,358.3,1437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1437,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,1437,1,4,0)
 ;;=4^M47.819
 ;;^UTILITY(U,$J,358.3,1437,2)
 ;;=^5012076
 ;;^UTILITY(U,$J,358.3,1438,0)
 ;;=R55.^^9^121^20
 ;;^UTILITY(U,$J,358.3,1438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1438,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,1438,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,1438,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,1439,0)
 ;;=G47.9^^9^121^12
 ;;^UTILITY(U,$J,358.3,1439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1439,1,3,0)
 ;;=3^Sleep Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1439,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,1439,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,1440,0)
 ;;=G47.30^^9^121^11
 ;;^UTILITY(U,$J,358.3,1440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1440,1,3,0)
 ;;=3^Sleep Apnea,Unspec
