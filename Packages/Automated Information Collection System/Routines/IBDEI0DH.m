IBDEI0DH ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16995,0)
 ;;=G82.22^^47^719^2
 ;;^UTILITY(U,$J,358.3,16995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16995,1,3,0)
 ;;=3^Paraplegia,Incomplete
 ;;^UTILITY(U,$J,358.3,16995,1,4,0)
 ;;=4^G82.22
 ;;^UTILITY(U,$J,358.3,16995,2)
 ;;=^5004127
 ;;^UTILITY(U,$J,358.3,16996,0)
 ;;=G04.1^^47^719^3
 ;;^UTILITY(U,$J,358.3,16996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16996,1,3,0)
 ;;=3^Paraplegia,Tropical Spastic
 ;;^UTILITY(U,$J,358.3,16996,1,4,0)
 ;;=4^G04.1
 ;;^UTILITY(U,$J,358.3,16996,2)
 ;;=^5003733
 ;;^UTILITY(U,$J,358.3,16997,0)
 ;;=G82.50^^47^719^4
 ;;^UTILITY(U,$J,358.3,16997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16997,1,3,0)
 ;;=3^Quadriplegia,Unspec
 ;;^UTILITY(U,$J,358.3,16997,1,4,0)
 ;;=4^G82.50
 ;;^UTILITY(U,$J,358.3,16997,2)
 ;;=^5004128
 ;;^UTILITY(U,$J,358.3,16998,0)
 ;;=M54.12^^47^719^5
 ;;^UTILITY(U,$J,358.3,16998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16998,1,3,0)
 ;;=3^Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,16998,1,4,0)
 ;;=4^M54.12
 ;;^UTILITY(U,$J,358.3,16998,2)
 ;;=^5012297
 ;;^UTILITY(U,$J,358.3,16999,0)
 ;;=M54.16^^47^719^6
 ;;^UTILITY(U,$J,358.3,16999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16999,1,3,0)
 ;;=3^Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,16999,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,16999,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,17000,0)
 ;;=M54.17^^47^719^7
 ;;^UTILITY(U,$J,358.3,17000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17000,1,3,0)
 ;;=3^Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,17000,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,17000,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,17001,0)
 ;;=M54.10^^47^719^8
 ;;^UTILITY(U,$J,358.3,17001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17001,1,3,0)
 ;;=3^Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,17001,1,4,0)
 ;;=4^M54.10
 ;;^UTILITY(U,$J,358.3,17001,2)
 ;;=^5012295
 ;;^UTILITY(U,$J,358.3,17002,0)
 ;;=M54.14^^47^719^9
 ;;^UTILITY(U,$J,358.3,17002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17002,1,3,0)
 ;;=3^Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,17002,1,4,0)
 ;;=4^M54.14
 ;;^UTILITY(U,$J,358.3,17002,2)
 ;;=^5012299
 ;;^UTILITY(U,$J,358.3,17003,0)
 ;;=M54.15^^47^719^10
 ;;^UTILITY(U,$J,358.3,17003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17003,1,3,0)
 ;;=3^Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,17003,1,4,0)
 ;;=4^M54.15
 ;;^UTILITY(U,$J,358.3,17003,2)
 ;;=^5012300
 ;;^UTILITY(U,$J,358.3,17004,0)
 ;;=M54.32^^47^719^11
 ;;^UTILITY(U,$J,358.3,17004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17004,1,3,0)
 ;;=3^Sciatica,Left Side
 ;;^UTILITY(U,$J,358.3,17004,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,17004,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,17005,0)
 ;;=M54.31^^47^719^12
 ;;^UTILITY(U,$J,358.3,17005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17005,1,3,0)
 ;;=3^Sciatica,Right Side
 ;;^UTILITY(U,$J,358.3,17005,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,17005,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,17006,0)
 ;;=M48.02^^47^719^14
 ;;^UTILITY(U,$J,358.3,17006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17006,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,17006,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,17006,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,17007,0)
 ;;=M48.03^^47^719^15
 ;;^UTILITY(U,$J,358.3,17007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17007,1,3,0)
 ;;=3^Spinal Stenosis,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,17007,1,4,0)
 ;;=4^M48.03
 ;;^UTILITY(U,$J,358.3,17007,2)
 ;;=^5012090
 ;;^UTILITY(U,$J,358.3,17008,0)
 ;;=M48.06^^47^719^16
 ;;^UTILITY(U,$J,358.3,17008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17008,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,17008,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,17008,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,17009,0)
 ;;=M48.07^^47^719^17
 ;;^UTILITY(U,$J,358.3,17009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17009,1,3,0)
 ;;=3^Spinal Stenosis,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,17009,1,4,0)
 ;;=4^M48.07
 ;;^UTILITY(U,$J,358.3,17009,2)
 ;;=^5012094
 ;;^UTILITY(U,$J,358.3,17010,0)
 ;;=M48.04^^47^719^18
 ;;^UTILITY(U,$J,358.3,17010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17010,1,3,0)
 ;;=3^Spinal Stenosis,Thoracic Region
 ;;^UTILITY(U,$J,358.3,17010,1,4,0)
 ;;=4^M48.04
 ;;^UTILITY(U,$J,358.3,17010,2)
 ;;=^5012091
 ;;^UTILITY(U,$J,358.3,17011,0)
 ;;=M48.05^^47^719^19
 ;;^UTILITY(U,$J,358.3,17011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17011,1,3,0)
 ;;=3^Spinal Stenosis,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,17011,1,4,0)
 ;;=4^M48.05
 ;;^UTILITY(U,$J,358.3,17011,2)
 ;;=^5012092
 ;;^UTILITY(U,$J,358.3,17012,0)
 ;;=M47.12^^47^719^20
 ;;^UTILITY(U,$J,358.3,17012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17012,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,17012,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,17012,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,17013,0)
 ;;=M47.13^^47^719^21
 ;;^UTILITY(U,$J,358.3,17013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17013,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,17013,1,4,0)
 ;;=4^M47.13
 ;;^UTILITY(U,$J,358.3,17013,2)
 ;;=^5012053
 ;;^UTILITY(U,$J,358.3,17014,0)
 ;;=M47.16^^47^719^22
 ;;^UTILITY(U,$J,358.3,17014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17014,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,17014,1,4,0)
 ;;=4^M47.16
 ;;^UTILITY(U,$J,358.3,17014,2)
 ;;=^5012056
 ;;^UTILITY(U,$J,358.3,17015,0)
 ;;=M47.14^^47^719^24
 ;;^UTILITY(U,$J,358.3,17015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17015,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,17015,1,4,0)
 ;;=4^M47.14
 ;;^UTILITY(U,$J,358.3,17015,2)
 ;;=^5012054
 ;;^UTILITY(U,$J,358.3,17016,0)
 ;;=M47.20^^47^719^30
 ;;^UTILITY(U,$J,358.3,17016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17016,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,17016,1,4,0)
 ;;=4^M47.20
 ;;^UTILITY(U,$J,358.3,17016,2)
 ;;=^5012059
 ;;^UTILITY(U,$J,358.3,17017,0)
 ;;=M47.15^^47^719^25
 ;;^UTILITY(U,$J,358.3,17017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17017,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,17017,1,4,0)
 ;;=4^M47.15
 ;;^UTILITY(U,$J,358.3,17017,2)
 ;;=^5012055
 ;;^UTILITY(U,$J,358.3,17018,0)
 ;;=M47.22^^47^719^26
 ;;^UTILITY(U,$J,358.3,17018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17018,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,17018,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,17018,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,17019,0)
 ;;=M47.23^^47^719^27
 ;;^UTILITY(U,$J,358.3,17019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17019,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,17019,1,4,0)
 ;;=4^M47.23
 ;;^UTILITY(U,$J,358.3,17019,2)
 ;;=^5012062
 ;;^UTILITY(U,$J,358.3,17020,0)
 ;;=M47.26^^47^719^28
 ;;^UTILITY(U,$J,358.3,17020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17020,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,17020,1,4,0)
 ;;=4^M47.26
 ;;^UTILITY(U,$J,358.3,17020,2)
 ;;=^5012065
 ;;^UTILITY(U,$J,358.3,17021,0)
 ;;=M47.27^^47^719^29
 ;;^UTILITY(U,$J,358.3,17021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17021,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,17021,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,17021,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,17022,0)
 ;;=M47.20^^47^719^31
 ;;^UTILITY(U,$J,358.3,17022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17022,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,17022,1,4,0)
 ;;=4^M47.20
 ;;^UTILITY(U,$J,358.3,17022,2)
 ;;=^5012059
 ;;^UTILITY(U,$J,358.3,17023,0)
 ;;=M47.24^^47^719^32
 ;;^UTILITY(U,$J,358.3,17023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17023,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,17023,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,17023,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,17024,0)
 ;;=M47.25^^47^719^33
 ;;^UTILITY(U,$J,358.3,17024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17024,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,17024,1,4,0)
 ;;=4^M47.25
 ;;^UTILITY(U,$J,358.3,17024,2)
 ;;=^5012064
 ;;^UTILITY(U,$J,358.3,17025,0)
 ;;=M47.10^^47^719^23
 ;;^UTILITY(U,$J,358.3,17025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17025,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,17025,1,4,0)
 ;;=4^M47.10
 ;;^UTILITY(U,$J,358.3,17025,2)
 ;;=^5012050
 ;;^UTILITY(U,$J,358.3,17026,0)
 ;;=G95.0^^47^719^34
 ;;^UTILITY(U,$J,358.3,17026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17026,1,3,0)
 ;;=3^Syringomyelia & Syringobulbia
 ;;^UTILITY(U,$J,358.3,17026,1,4,0)
 ;;=4^G95.0
 ;;^UTILITY(U,$J,358.3,17026,2)
 ;;=^116874
 ;;^UTILITY(U,$J,358.3,17027,0)
 ;;=R25.0^^47^720^1
 ;;^UTILITY(U,$J,358.3,17027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17027,1,3,0)
 ;;=3^Abnormal Head Movements
 ;;^UTILITY(U,$J,358.3,17027,1,4,0)
 ;;=4^R25.0
 ;;^UTILITY(U,$J,358.3,17027,2)
 ;;=^5019299
 ;;^UTILITY(U,$J,358.3,17028,0)
 ;;=R25.9^^47^720^2
 ;;^UTILITY(U,$J,358.3,17028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17028,1,3,0)
 ;;=3^Abnormal Involuntary Movements,Unspec
 ;;^UTILITY(U,$J,358.3,17028,1,4,0)
 ;;=4^R25.9
 ;;^UTILITY(U,$J,358.3,17028,2)
 ;;=^5019303
 ;;^UTILITY(U,$J,358.3,17029,0)
 ;;=R26.9^^47^720^3
 ;;^UTILITY(U,$J,358.3,17029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17029,1,3,0)
 ;;=3^Abnormalities of Gait & Mobility,Unspec
 ;;^UTILITY(U,$J,358.3,17029,1,4,0)
 ;;=4^R26.9
 ;;^UTILITY(U,$J,358.3,17029,2)
 ;;=^5019309
 ;;^UTILITY(U,$J,358.3,17030,0)
 ;;=R41.3^^47^720^4
 ;;^UTILITY(U,$J,358.3,17030,1,0)
 ;;=^358.31IA^4^2
