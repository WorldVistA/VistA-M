IBDEI08D ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20406,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,20406,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,20406,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,20407,0)
 ;;=M51.06^^68^843^21
 ;;^UTILITY(U,$J,358.3,20407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20407,1,3,0)
 ;;=3^Intvrt Disc D/O w/ Myelopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,20407,1,4,0)
 ;;=4^M51.06
 ;;^UTILITY(U,$J,358.3,20407,2)
 ;;=^5012241
 ;;^UTILITY(U,$J,358.3,20408,0)
 ;;=M51.04^^68^843^22
 ;;^UTILITY(U,$J,358.3,20408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20408,1,3,0)
 ;;=3^Intvrt Disc D/O w/ Myelopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20408,1,4,0)
 ;;=4^M51.04
 ;;^UTILITY(U,$J,358.3,20408,2)
 ;;=^5012239
 ;;^UTILITY(U,$J,358.3,20409,0)
 ;;=M51.05^^68^843^23
 ;;^UTILITY(U,$J,358.3,20409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20409,1,3,0)
 ;;=3^Intvrt Disc D/O w/ Myelopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,20409,1,4,0)
 ;;=4^M51.05
 ;;^UTILITY(U,$J,358.3,20409,2)
 ;;=^5012240
 ;;^UTILITY(U,$J,358.3,20410,0)
 ;;=M48.22^^68^843^24
 ;;^UTILITY(U,$J,358.3,20410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20410,1,3,0)
 ;;=3^Kissing Spine,Cervical Region
 ;;^UTILITY(U,$J,358.3,20410,1,4,0)
 ;;=4^M48.22
 ;;^UTILITY(U,$J,358.3,20410,2)
 ;;=^5012108
 ;;^UTILITY(U,$J,358.3,20411,0)
 ;;=M48.26^^68^843^25
 ;;^UTILITY(U,$J,358.3,20411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20411,1,3,0)
 ;;=3^Kissing Spine,Lumbar Region
 ;;^UTILITY(U,$J,358.3,20411,1,4,0)
 ;;=4^M48.26
 ;;^UTILITY(U,$J,358.3,20411,2)
 ;;=^5012112
 ;;^UTILITY(U,$J,358.3,20412,0)
 ;;=M48.27^^68^843^26
 ;;^UTILITY(U,$J,358.3,20412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20412,1,3,0)
 ;;=3^Kissing Spine,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,20412,1,4,0)
 ;;=4^M48.27
 ;;^UTILITY(U,$J,358.3,20412,2)
 ;;=^5012113
 ;;^UTILITY(U,$J,358.3,20413,0)
 ;;=M48.21^^68^843^27
 ;;^UTILITY(U,$J,358.3,20413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20413,1,3,0)
 ;;=3^Kissing Spine,Occipito-Atlanto-Axial Region
 ;;^UTILITY(U,$J,358.3,20413,1,4,0)
 ;;=4^M48.21
 ;;^UTILITY(U,$J,358.3,20413,2)
 ;;=^5012107
 ;;^UTILITY(U,$J,358.3,20414,0)
 ;;=M48.25^^68^843^29
 ;;^UTILITY(U,$J,358.3,20414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20414,1,3,0)
 ;;=3^Kissing Spine,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,20414,1,4,0)
 ;;=4^M48.25
 ;;^UTILITY(U,$J,358.3,20414,2)
 ;;=^5012111
 ;;^UTILITY(U,$J,358.3,20415,0)
 ;;=M48.24^^68^843^28
 ;;^UTILITY(U,$J,358.3,20415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20415,1,3,0)
 ;;=3^Kissing Spine,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20415,1,4,0)
 ;;=4^M48.24
 ;;^UTILITY(U,$J,358.3,20415,2)
 ;;=^5012110
 ;;^UTILITY(U,$J,358.3,20416,0)
 ;;=M54.6^^68^843^33
 ;;^UTILITY(U,$J,358.3,20416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20416,1,3,0)
 ;;=3^Pain,Thoracic Spine
 ;;^UTILITY(U,$J,358.3,20416,1,4,0)
 ;;=4^M54.6
 ;;^UTILITY(U,$J,358.3,20416,2)
 ;;=^272507
 ;;^UTILITY(U,$J,358.3,20417,0)
 ;;=M96.1^^68^843^34
 ;;^UTILITY(U,$J,358.3,20417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20417,1,3,0)
 ;;=3^Postlaminectomy Syndrome NEC
 ;;^UTILITY(U,$J,358.3,20417,1,4,0)
 ;;=4^M96.1
 ;;^UTILITY(U,$J,358.3,20417,2)
 ;;=^5015374
 ;;^UTILITY(U,$J,358.3,20418,0)
 ;;=M54.16^^68^843^35
 ;;^UTILITY(U,$J,358.3,20418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20418,1,3,0)
 ;;=3^Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,20418,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,20418,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,20419,0)
 ;;=M54.17^^68^843^36
 ;;^UTILITY(U,$J,358.3,20419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20419,1,3,0)
 ;;=3^Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,20419,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,20419,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,20420,0)
 ;;=M54.14^^68^843^37
 ;;^UTILITY(U,$J,358.3,20420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20420,1,3,0)
 ;;=3^Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20420,1,4,0)
 ;;=4^M54.14
 ;;^UTILITY(U,$J,358.3,20420,2)
 ;;=^5012299
 ;;^UTILITY(U,$J,358.3,20421,0)
 ;;=M54.15^^68^843^38
 ;;^UTILITY(U,$J,358.3,20421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20421,1,3,0)
 ;;=3^Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,20421,1,4,0)
 ;;=4^M54.15
 ;;^UTILITY(U,$J,358.3,20421,2)
 ;;=^5012300
 ;;^UTILITY(U,$J,358.3,20422,0)
 ;;=M46.1^^68^843^39
 ;;^UTILITY(U,$J,358.3,20422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20422,1,3,0)
 ;;=3^Sacroiliitis NEC
 ;;^UTILITY(U,$J,358.3,20422,1,4,0)
 ;;=4^M46.1
 ;;^UTILITY(U,$J,358.3,20422,2)
 ;;=^5011980
 ;;^UTILITY(U,$J,358.3,20423,0)
 ;;=M46.02^^68^843^41
 ;;^UTILITY(U,$J,358.3,20423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20423,1,3,0)
 ;;=3^Spinal Enthesopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,20423,1,4,0)
 ;;=4^M46.02
 ;;^UTILITY(U,$J,358.3,20423,2)
 ;;=^5011972
 ;;^UTILITY(U,$J,358.3,20424,0)
 ;;=M46.06^^68^843^43
 ;;^UTILITY(U,$J,358.3,20424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20424,1,3,0)
 ;;=3^Spinal Enthesopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,20424,1,4,0)
 ;;=4^M46.06
 ;;^UTILITY(U,$J,358.3,20424,2)
 ;;=^5011976
 ;;^UTILITY(U,$J,358.3,20425,0)
 ;;=M46.01^^68^843^45
 ;;^UTILITY(U,$J,358.3,20425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20425,1,3,0)
 ;;=3^Spinal Enthesopathy,Occipito-Atlanto-Axial Region
 ;;^UTILITY(U,$J,358.3,20425,1,4,0)
 ;;=4^M46.01
 ;;^UTILITY(U,$J,358.3,20425,2)
 ;;=^5011971
 ;;^UTILITY(U,$J,358.3,20426,0)
 ;;=M46.07^^68^843^44
 ;;^UTILITY(U,$J,358.3,20426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20426,1,3,0)
 ;;=3^Spinal Enthesopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,20426,1,4,0)
 ;;=4^M46.07
 ;;^UTILITY(U,$J,358.3,20426,2)
 ;;=^5011977
 ;;^UTILITY(U,$J,358.3,20427,0)
 ;;=M46.05^^68^843^47
 ;;^UTILITY(U,$J,358.3,20427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20427,1,3,0)
 ;;=3^Spinal Enthesopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,20427,1,4,0)
 ;;=4^M46.05
 ;;^UTILITY(U,$J,358.3,20427,2)
 ;;=^5011975
 ;;^UTILITY(U,$J,358.3,20428,0)
 ;;=M46.03^^68^843^42
 ;;^UTILITY(U,$J,358.3,20428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20428,1,3,0)
 ;;=3^Spinal Enthesopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,20428,1,4,0)
 ;;=4^M46.03
 ;;^UTILITY(U,$J,358.3,20428,2)
 ;;=^5011973
 ;;^UTILITY(U,$J,358.3,20429,0)
 ;;=M46.04^^68^843^46
 ;;^UTILITY(U,$J,358.3,20429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20429,1,3,0)
 ;;=3^Spinal Enthesopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20429,1,4,0)
 ;;=4^M46.04
 ;;^UTILITY(U,$J,358.3,20429,2)
 ;;=^5011974
 ;;^UTILITY(U,$J,358.3,20430,0)
 ;;=M48.9^^68^843^56
 ;;^UTILITY(U,$J,358.3,20430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20430,1,3,0)
 ;;=3^Spondylopathy,Unspec
 ;;^UTILITY(U,$J,358.3,20430,1,4,0)
 ;;=4^M48.9
 ;;^UTILITY(U,$J,358.3,20430,2)
 ;;=^5012204
 ;;^UTILITY(U,$J,358.3,20431,0)
 ;;=M47.812^^68^843^69
 ;;^UTILITY(U,$J,358.3,20431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20431,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,20431,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,20431,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,20432,0)
 ;;=M47.816^^68^843^71
 ;;^UTILITY(U,$J,358.3,20432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20432,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,20432,1,4,0)
 ;;=4^M47.816
 ;;^UTILITY(U,$J,358.3,20432,2)
 ;;=^5012073
 ;;^UTILITY(U,$J,358.3,20433,0)
 ;;=M47.817^^68^843^72
 ;;^UTILITY(U,$J,358.3,20433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20433,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,20433,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,20433,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,20434,0)
 ;;=M47.811^^68^843^73
 ;;^UTILITY(U,$J,358.3,20434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20434,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Occipt-Atlan-Ax Region
 ;;^UTILITY(U,$J,358.3,20434,1,4,0)
 ;;=4^M47.811
 ;;^UTILITY(U,$J,358.3,20434,2)
 ;;=^5012068
 ;;^UTILITY(U,$J,358.3,20435,0)
 ;;=M47.818^^68^843^74
 ;;^UTILITY(U,$J,358.3,20435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20435,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Sacral/Sacrocycgl Region
 ;;^UTILITY(U,$J,358.3,20435,1,4,0)
 ;;=4^M47.818
 ;;^UTILITY(U,$J,358.3,20435,2)
 ;;=^5012075
 ;;^UTILITY(U,$J,358.3,20436,0)
 ;;=M47.814^^68^843^75
 ;;^UTILITY(U,$J,358.3,20436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20436,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20436,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,20436,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,20437,0)
 ;;=M47.815^^68^843^76
 ;;^UTILITY(U,$J,358.3,20437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20437,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Thoracolumb Region
 ;;^UTILITY(U,$J,358.3,20437,1,4,0)
 ;;=4^M47.815
 ;;^UTILITY(U,$J,358.3,20437,2)
 ;;=^5012072
 ;;^UTILITY(U,$J,358.3,20438,0)
 ;;=M47.813^^68^843^70
 ;;^UTILITY(U,$J,358.3,20438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20438,1,3,0)
 ;;=3^Spondyls w/o Myelopathy/Radiculopathy,Cervicothor Region
 ;;^UTILITY(U,$J,358.3,20438,1,4,0)
 ;;=4^M47.813
 ;;^UTILITY(U,$J,358.3,20438,2)
 ;;=^5012070
 ;;^UTILITY(U,$J,358.3,20439,0)
 ;;=M48.32^^68^843^77
 ;;^UTILITY(U,$J,358.3,20439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20439,1,3,0)
 ;;=3^Traumatic Spondylopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,20439,1,4,0)
 ;;=4^M48.32
 ;;^UTILITY(U,$J,358.3,20439,2)
 ;;=^5012116
 ;;^UTILITY(U,$J,358.3,20440,0)
 ;;=M48.36^^68^843^79
 ;;^UTILITY(U,$J,358.3,20440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20440,1,3,0)
 ;;=3^Traumatic Spondylopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,20440,1,4,0)
 ;;=4^M48.36
 ;;^UTILITY(U,$J,358.3,20440,2)
 ;;=^5012120
 ;;^UTILITY(U,$J,358.3,20441,0)
 ;;=M48.37^^68^843^80
 ;;^UTILITY(U,$J,358.3,20441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20441,1,3,0)
 ;;=3^Traumatic Spondylopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,20441,1,4,0)
 ;;=4^M48.37
 ;;^UTILITY(U,$J,358.3,20441,2)
 ;;=^5012121
 ;;^UTILITY(U,$J,358.3,20442,0)
 ;;=M48.31^^68^843^81
 ;;^UTILITY(U,$J,358.3,20442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20442,1,3,0)
 ;;=3^Traumatic Spondylopathy,Occipito-Atlanto-Axial Region
 ;;^UTILITY(U,$J,358.3,20442,1,4,0)
 ;;=4^M48.31
 ;;^UTILITY(U,$J,358.3,20442,2)
 ;;=^5012115
 ;;^UTILITY(U,$J,358.3,20443,0)
 ;;=M48.38^^68^843^82
 ;;^UTILITY(U,$J,358.3,20443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20443,1,3,0)
 ;;=3^Traumatic Spondylopathy,Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,20443,1,4,0)
 ;;=4^M48.38
 ;;^UTILITY(U,$J,358.3,20443,2)
 ;;=^5012122
 ;;^UTILITY(U,$J,358.3,20444,0)
 ;;=M48.35^^68^843^84
 ;;^UTILITY(U,$J,358.3,20444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20444,1,3,0)
 ;;=3^Traumatic Spondylopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,20444,1,4,0)
 ;;=4^M48.35
 ;;^UTILITY(U,$J,358.3,20444,2)
 ;;=^5012119
 ;;^UTILITY(U,$J,358.3,20445,0)
 ;;=M48.33^^68^843^78
 ;;^UTILITY(U,$J,358.3,20445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20445,1,3,0)
 ;;=3^Traumatic Spondylopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,20445,1,4,0)
 ;;=4^M48.33
 ;;^UTILITY(U,$J,358.3,20445,2)
 ;;=^5012117
 ;;^UTILITY(U,$J,358.3,20446,0)
 ;;=M48.34^^68^843^83
 ;;^UTILITY(U,$J,358.3,20446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20446,1,3,0)
 ;;=3^Traumatic Spondylopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20446,1,4,0)
 ;;=4^M48.34
 ;;^UTILITY(U,$J,358.3,20446,2)
 ;;=^5012118
 ;;^UTILITY(U,$J,358.3,20447,0)
 ;;=M48.061^^68^843^51
 ;;^UTILITY(U,$J,358.3,20447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20447,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,20447,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,20447,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,20448,0)
 ;;=M48.062^^68^843^50
 ;;^UTILITY(U,$J,358.3,20448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20448,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,20448,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,20448,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,20449,0)
 ;;=M41.9^^68^843^40
 ;;^UTILITY(U,$J,358.3,20449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20449,1,3,0)
 ;;=3^Scoliosis,Idiopathic
 ;;^UTILITY(U,$J,358.3,20449,1,4,0)
 ;;=4^M41.9
 ;;^UTILITY(U,$J,358.3,20449,2)
 ;;=^5011889
 ;;^UTILITY(U,$J,358.3,20450,0)
 ;;=M54.50^^68^843^31
 ;;^UTILITY(U,$J,358.3,20450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20450,1,3,0)
 ;;=3^Low Back Pain,Unspec
 ;;^UTILITY(U,$J,358.3,20450,1,4,0)
 ;;=4^M54.50
 ;;^UTILITY(U,$J,358.3,20450,2)
 ;;=^5161215
 ;;^UTILITY(U,$J,358.3,20451,0)
 ;;=M54.51^^68^843^32
 ;;^UTILITY(U,$J,358.3,20451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20451,1,3,0)
 ;;=3^Low Back Pain,Vertebrogenic
 ;;^UTILITY(U,$J,358.3,20451,1,4,0)
 ;;=4^M54.51
 ;;^UTILITY(U,$J,358.3,20451,2)
 ;;=^5161216
 ;;^UTILITY(U,$J,358.3,20452,0)
 ;;=M54.59^^68^843^30
 ;;^UTILITY(U,$J,358.3,20452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20452,1,3,0)
 ;;=3^Low Back Pain,Other
 ;;^UTILITY(U,$J,358.3,20452,1,4,0)
 ;;=4^M54.59
 ;;^UTILITY(U,$J,358.3,20452,2)
 ;;=^5161217
 ;;^UTILITY(U,$J,358.3,20453,0)
 ;;=M47.12^^68^843^57
 ;;^UTILITY(U,$J,358.3,20453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20453,1,3,0)
 ;;=3^Spondyls w/ Myelopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,20453,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,20453,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,20454,0)
 ;;=M47.13^^68^843^58
 ;;^UTILITY(U,$J,358.3,20454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20454,1,3,0)
 ;;=3^Spondyls w/ Myelopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,20454,1,4,0)
 ;;=4^M47.13
 ;;^UTILITY(U,$J,358.3,20454,2)
 ;;=^5012053
 ;;^UTILITY(U,$J,358.3,20455,0)
 ;;=M47.14^^68^843^60
 ;;^UTILITY(U,$J,358.3,20455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20455,1,3,0)
 ;;=3^Spondyls w/ Myelopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20455,1,4,0)
 ;;=4^M47.14
 ;;^UTILITY(U,$J,358.3,20455,2)
 ;;=^5012054
 ;;^UTILITY(U,$J,358.3,20456,0)
 ;;=M47.15^^68^843^61
 ;;^UTILITY(U,$J,358.3,20456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20456,1,3,0)
 ;;=3^Spondyls w/ Myelopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,20456,1,4,0)
 ;;=4^M47.15
 ;;^UTILITY(U,$J,358.3,20456,2)
 ;;=^5012055
 ;;^UTILITY(U,$J,358.3,20457,0)
 ;;=M47.16^^68^843^59
 ;;^UTILITY(U,$J,358.3,20457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20457,1,3,0)
 ;;=3^Spondyls w/ Myelopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,20457,1,4,0)
 ;;=4^M47.16
 ;;^UTILITY(U,$J,358.3,20457,2)
 ;;=^5012056
 ;;^UTILITY(U,$J,358.3,20458,0)
 ;;=M47.22^^68^843^62
 ;;^UTILITY(U,$J,358.3,20458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20458,1,3,0)
 ;;=3^Spondyls w/ Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,20458,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,20458,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,20459,0)
 ;;=M47.23^^68^843^63
 ;;^UTILITY(U,$J,358.3,20459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20459,1,3,0)
 ;;=3^Spondyls w/ Radiculopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,20459,1,4,0)
 ;;=4^M47.23
 ;;^UTILITY(U,$J,358.3,20459,2)
 ;;=^5012062
 ;;^UTILITY(U,$J,358.3,20460,0)
 ;;=M47.24^^68^843^67
 ;;^UTILITY(U,$J,358.3,20460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20460,1,3,0)
 ;;=3^Spondyls w/ Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20460,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,20460,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,20461,0)
 ;;=M47.25^^68^843^68
 ;;^UTILITY(U,$J,358.3,20461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20461,1,3,0)
 ;;=3^Spondyls w/ Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,20461,1,4,0)
 ;;=4^M47.25
 ;;^UTILITY(U,$J,358.3,20461,2)
 ;;=^5012064
 ;;^UTILITY(U,$J,358.3,20462,0)
 ;;=M47.26^^68^843^64
 ;;^UTILITY(U,$J,358.3,20462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20462,1,3,0)
 ;;=3^Spondyls w/ Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,20462,1,4,0)
 ;;=4^M47.26
 ;;^UTILITY(U,$J,358.3,20462,2)
 ;;=^5012065
 ;;^UTILITY(U,$J,358.3,20463,0)
 ;;=M47.27^^68^843^65
 ;;^UTILITY(U,$J,358.3,20463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20463,1,3,0)
 ;;=3^Spondyls w/ Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,20463,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,20463,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,20464,0)
 ;;=M47.28^^68^843^66
 ;;^UTILITY(U,$J,358.3,20464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20464,1,3,0)
 ;;=3^Spondyls w/ Radiculopathy,Sacral/Sacroccygeal Region
 ;;^UTILITY(U,$J,358.3,20464,1,4,0)
 ;;=4^M47.28
 ;;^UTILITY(U,$J,358.3,20464,2)
 ;;=^5012067
 ;;^UTILITY(U,$J,358.3,20465,0)
 ;;=M48.02^^68^843^48
 ;;^UTILITY(U,$J,358.3,20465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20465,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,20465,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,20465,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,20466,0)
 ;;=M48.03^^68^843^49
 ;;^UTILITY(U,$J,358.3,20466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20466,1,3,0)
 ;;=3^Spinal Stenosis,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,20466,1,4,0)
 ;;=4^M48.03
 ;;^UTILITY(U,$J,358.3,20466,2)
 ;;=^5012090
 ;;^UTILITY(U,$J,358.3,20467,0)
 ;;=M48.04^^68^843^54
 ;;^UTILITY(U,$J,358.3,20467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20467,1,3,0)
 ;;=3^Spinal Stenosis,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20467,1,4,0)
 ;;=4^M48.04
 ;;^UTILITY(U,$J,358.3,20467,2)
 ;;=^5012091
 ;;^UTILITY(U,$J,358.3,20468,0)
 ;;=M48.05^^68^843^55
 ;;^UTILITY(U,$J,358.3,20468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20468,1,3,0)
 ;;=3^Spinal Stenosis,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,20468,1,4,0)
 ;;=4^M48.05
 ;;^UTILITY(U,$J,358.3,20468,2)
 ;;=^5012092
 ;;^UTILITY(U,$J,358.3,20469,0)
 ;;=M48.07^^68^843^52
 ;;^UTILITY(U,$J,358.3,20469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20469,1,3,0)
 ;;=3^Spinal Stenosis,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,20469,1,4,0)
 ;;=4^M48.07
 ;;^UTILITY(U,$J,358.3,20469,2)
 ;;=^5012094
 ;;^UTILITY(U,$J,358.3,20470,0)
 ;;=M48.08^^68^843^53
 ;;^UTILITY(U,$J,358.3,20470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20470,1,3,0)
 ;;=3^Spinal Stenosis,Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,20470,1,4,0)
 ;;=4^M48.08
 ;;^UTILITY(U,$J,358.3,20470,2)
 ;;=^5012095
 ;;^UTILITY(U,$J,358.3,20471,0)
 ;;=R47.01^^68^844^1
 ;;^UTILITY(U,$J,358.3,20471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20471,1,3,0)
 ;;=3^Aphasia NEC
 ;;^UTILITY(U,$J,358.3,20471,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,20471,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,20472,0)
 ;;=I69.920^^68^844^5
 ;;^UTILITY(U,$J,358.3,20472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20472,1,3,0)
 ;;=3^Aphasia after unspec cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,20472,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,20472,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,20473,0)
 ;;=I69.991^^68^844^10
