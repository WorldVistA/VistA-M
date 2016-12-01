IBDEI0P4 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31845,0)
 ;;=M48.27^^94^1404^27
 ;;^UTILITY(U,$J,358.3,31845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31845,1,3,0)
 ;;=3^Kissing spine, lumbosacral region
 ;;^UTILITY(U,$J,358.3,31845,1,4,0)
 ;;=4^M48.27
 ;;^UTILITY(U,$J,358.3,31845,2)
 ;;=^5012113
 ;;^UTILITY(U,$J,358.3,31846,0)
 ;;=M48.21^^94^1404^28
 ;;^UTILITY(U,$J,358.3,31846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31846,1,3,0)
 ;;=3^Kissing spine, occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,31846,1,4,0)
 ;;=4^M48.21
 ;;^UTILITY(U,$J,358.3,31846,2)
 ;;=^5012107
 ;;^UTILITY(U,$J,358.3,31847,0)
 ;;=M48.25^^94^1404^30
 ;;^UTILITY(U,$J,358.3,31847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31847,1,3,0)
 ;;=3^Kissing spine, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,31847,1,4,0)
 ;;=4^M48.25
 ;;^UTILITY(U,$J,358.3,31847,2)
 ;;=^5012111
 ;;^UTILITY(U,$J,358.3,31848,0)
 ;;=M48.24^^94^1404^29
 ;;^UTILITY(U,$J,358.3,31848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31848,1,3,0)
 ;;=3^Kissing spine, thoracic region
 ;;^UTILITY(U,$J,358.3,31848,1,4,0)
 ;;=4^M48.24
 ;;^UTILITY(U,$J,358.3,31848,2)
 ;;=^5012110
 ;;^UTILITY(U,$J,358.3,31849,0)
 ;;=M54.5^^94^1404^31
 ;;^UTILITY(U,$J,358.3,31849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31849,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,31849,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,31849,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,31850,0)
 ;;=M54.6^^94^1404^32
 ;;^UTILITY(U,$J,358.3,31850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31850,1,3,0)
 ;;=3^Pain in thoracic spine
 ;;^UTILITY(U,$J,358.3,31850,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,31850,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,31851,0)
 ;;=M96.1^^94^1404^33
 ;;^UTILITY(U,$J,358.3,31851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31851,1,3,0)
 ;;=3^Postlaminectomy syndrome NEC
 ;;^UTILITY(U,$J,358.3,31851,1,4,0)
 ;;=4^M96.1
 ;;^UTILITY(U,$J,358.3,31851,2)
 ;;=^5015374
 ;;^UTILITY(U,$J,358.3,31852,0)
 ;;=M54.16^^94^1404^34
 ;;^UTILITY(U,$J,358.3,31852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31852,1,3,0)
 ;;=3^Radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,31852,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,31852,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,31853,0)
 ;;=M54.17^^94^1404^35
 ;;^UTILITY(U,$J,358.3,31853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31853,1,3,0)
 ;;=3^Radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,31853,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,31853,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,31854,0)
 ;;=M54.14^^94^1404^36
 ;;^UTILITY(U,$J,358.3,31854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31854,1,3,0)
 ;;=3^Radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,31854,1,4,0)
 ;;=4^M54.14
 ;;^UTILITY(U,$J,358.3,31854,2)
 ;;=^5012299
 ;;^UTILITY(U,$J,358.3,31855,0)
 ;;=M54.15^^94^1404^37
 ;;^UTILITY(U,$J,358.3,31855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31855,1,3,0)
 ;;=3^Radiculopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,31855,1,4,0)
 ;;=4^M54.15
 ;;^UTILITY(U,$J,358.3,31855,2)
 ;;=^5012300
 ;;^UTILITY(U,$J,358.3,31856,0)
 ;;=M46.1^^94^1404^38
 ;;^UTILITY(U,$J,358.3,31856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31856,1,3,0)
 ;;=3^Sacroiliitis NEC
 ;;^UTILITY(U,$J,358.3,31856,1,4,0)
 ;;=4^M46.1
 ;;^UTILITY(U,$J,358.3,31856,2)
 ;;=^5011980
 ;;^UTILITY(U,$J,358.3,31857,0)
 ;;=M46.02^^94^1404^39
 ;;^UTILITY(U,$J,358.3,31857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31857,1,3,0)
 ;;=3^Spinal enthesopathy, cervical region
 ;;^UTILITY(U,$J,358.3,31857,1,4,0)
 ;;=4^M46.02
 ;;^UTILITY(U,$J,358.3,31857,2)
 ;;=^5011972
 ;;^UTILITY(U,$J,358.3,31858,0)
 ;;=M46.06^^94^1404^41
 ;;^UTILITY(U,$J,358.3,31858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31858,1,3,0)
 ;;=3^Spinal enthesopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,31858,1,4,0)
 ;;=4^M46.06
 ;;^UTILITY(U,$J,358.3,31858,2)
 ;;=^5011976
 ;;^UTILITY(U,$J,358.3,31859,0)
 ;;=M46.01^^94^1404^43
 ;;^UTILITY(U,$J,358.3,31859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31859,1,3,0)
 ;;=3^Spinal enthesopathy, occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,31859,1,4,0)
 ;;=4^M46.01
 ;;^UTILITY(U,$J,358.3,31859,2)
 ;;=^5011971
 ;;^UTILITY(U,$J,358.3,31860,0)
 ;;=M46.07^^94^1404^42
 ;;^UTILITY(U,$J,358.3,31860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31860,1,3,0)
 ;;=3^Spinal enthesopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,31860,1,4,0)
 ;;=4^M46.07
 ;;^UTILITY(U,$J,358.3,31860,2)
 ;;=^5011977
 ;;^UTILITY(U,$J,358.3,31861,0)
 ;;=M46.05^^94^1404^45
 ;;^UTILITY(U,$J,358.3,31861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31861,1,3,0)
 ;;=3^Spinal enthesopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,31861,1,4,0)
 ;;=4^M46.05
 ;;^UTILITY(U,$J,358.3,31861,2)
 ;;=^5011975
 ;;^UTILITY(U,$J,358.3,31862,0)
 ;;=M46.03^^94^1404^40
 ;;^UTILITY(U,$J,358.3,31862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31862,1,3,0)
 ;;=3^Spinal enthesopathy, cervicothoracic region
 ;;^UTILITY(U,$J,358.3,31862,1,4,0)
 ;;=4^M46.03
 ;;^UTILITY(U,$J,358.3,31862,2)
 ;;=^5011973
 ;;^UTILITY(U,$J,358.3,31863,0)
 ;;=M46.04^^94^1404^44
 ;;^UTILITY(U,$J,358.3,31863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31863,1,3,0)
 ;;=3^Spinal enthesopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,31863,1,4,0)
 ;;=4^M46.04
 ;;^UTILITY(U,$J,358.3,31863,2)
 ;;=^5011974
 ;;^UTILITY(U,$J,358.3,31864,0)
 ;;=M48.9^^94^1404^46
 ;;^UTILITY(U,$J,358.3,31864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31864,1,3,0)
 ;;=3^Spondylopathy, unspecified
 ;;^UTILITY(U,$J,358.3,31864,1,4,0)
 ;;=4^M48.9
 ;;^UTILITY(U,$J,358.3,31864,2)
 ;;=^5012204
 ;;^UTILITY(U,$J,358.3,31865,0)
 ;;=M47.812^^94^1404^47
 ;;^UTILITY(U,$J,358.3,31865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31865,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,31865,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,31865,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,31866,0)
 ;;=M47.816^^94^1404^48
 ;;^UTILITY(U,$J,358.3,31866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31866,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,31866,1,4,0)
 ;;=4^M47.816
 ;;^UTILITY(U,$J,358.3,31866,2)
 ;;=^5012073
 ;;^UTILITY(U,$J,358.3,31867,0)
 ;;=M47.817^^94^1404^49
 ;;^UTILITY(U,$J,358.3,31867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31867,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, lumbosacr region
 ;;^UTILITY(U,$J,358.3,31867,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,31867,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,31868,0)
 ;;=M47.811^^94^1404^50
 ;;^UTILITY(U,$J,358.3,31868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31868,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, occipt-atlan-ax rgn
 ;;^UTILITY(U,$J,358.3,31868,1,4,0)
 ;;=4^M47.811
 ;;^UTILITY(U,$J,358.3,31868,2)
 ;;=^5012068
 ;;^UTILITY(U,$J,358.3,31869,0)
 ;;=M47.818^^94^1404^51
 ;;^UTILITY(U,$J,358.3,31869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31869,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, sacr/sacrocygl rgn
 ;;^UTILITY(U,$J,358.3,31869,1,4,0)
 ;;=4^M47.818
 ;;^UTILITY(U,$J,358.3,31869,2)
 ;;=^5012075
 ;;^UTILITY(U,$J,358.3,31870,0)
 ;;=M47.814^^94^1404^52
 ;;^UTILITY(U,$J,358.3,31870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31870,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,31870,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,31870,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,31871,0)
 ;;=M47.815^^94^1404^53
 ;;^UTILITY(U,$J,358.3,31871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31871,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, thoracolum region
 ;;^UTILITY(U,$J,358.3,31871,1,4,0)
 ;;=4^M47.815
 ;;^UTILITY(U,$J,358.3,31871,2)
 ;;=^5012072
 ;;^UTILITY(U,$J,358.3,31872,0)
 ;;=M47.813^^94^1404^54
 ;;^UTILITY(U,$J,358.3,31872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31872,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, cervicothor region
 ;;^UTILITY(U,$J,358.3,31872,1,4,0)
 ;;=4^M47.813
 ;;^UTILITY(U,$J,358.3,31872,2)
 ;;=^5012070
 ;;^UTILITY(U,$J,358.3,31873,0)
 ;;=M48.32^^94^1404^55
 ;;^UTILITY(U,$J,358.3,31873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31873,1,3,0)
 ;;=3^Traumatic spondylopathy, cervical region
 ;;^UTILITY(U,$J,358.3,31873,1,4,0)
 ;;=4^M48.32
 ;;^UTILITY(U,$J,358.3,31873,2)
 ;;=^5012116
 ;;^UTILITY(U,$J,358.3,31874,0)
 ;;=M48.36^^94^1404^57
 ;;^UTILITY(U,$J,358.3,31874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31874,1,3,0)
 ;;=3^Traumatic spondylopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,31874,1,4,0)
 ;;=4^M48.36
 ;;^UTILITY(U,$J,358.3,31874,2)
 ;;=^5012120
 ;;^UTILITY(U,$J,358.3,31875,0)
 ;;=M48.37^^94^1404^58
 ;;^UTILITY(U,$J,358.3,31875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31875,1,3,0)
 ;;=3^Traumatic spondylopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,31875,1,4,0)
 ;;=4^M48.37
 ;;^UTILITY(U,$J,358.3,31875,2)
 ;;=^5012121
 ;;^UTILITY(U,$J,358.3,31876,0)
 ;;=M48.31^^94^1404^59
 ;;^UTILITY(U,$J,358.3,31876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31876,1,3,0)
 ;;=3^Traumatic spondylopathy, occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,31876,1,4,0)
 ;;=4^M48.31
 ;;^UTILITY(U,$J,358.3,31876,2)
 ;;=^5012115
 ;;^UTILITY(U,$J,358.3,31877,0)
 ;;=M48.38^^94^1404^60
 ;;^UTILITY(U,$J,358.3,31877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31877,1,3,0)
 ;;=3^Traumatic spondylopathy, sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,31877,1,4,0)
 ;;=4^M48.38
 ;;^UTILITY(U,$J,358.3,31877,2)
 ;;=^5012122
 ;;^UTILITY(U,$J,358.3,31878,0)
 ;;=M48.35^^94^1404^62
 ;;^UTILITY(U,$J,358.3,31878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31878,1,3,0)
 ;;=3^Traumatic spondylopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,31878,1,4,0)
 ;;=4^M48.35
 ;;^UTILITY(U,$J,358.3,31878,2)
 ;;=^5012119
 ;;^UTILITY(U,$J,358.3,31879,0)
 ;;=M48.33^^94^1404^56
 ;;^UTILITY(U,$J,358.3,31879,1,0)
 ;;=^358.31IA^4^2
