IBDEI1AF ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20588,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,20588,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,20589,0)
 ;;=M47.20^^93^1005^32
 ;;^UTILITY(U,$J,358.3,20589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20589,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,20589,1,4,0)
 ;;=4^M47.20
 ;;^UTILITY(U,$J,358.3,20589,2)
 ;;=^5012059
 ;;^UTILITY(U,$J,358.3,20590,0)
 ;;=M47.24^^93^1005^33
 ;;^UTILITY(U,$J,358.3,20590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20590,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20590,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,20590,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,20591,0)
 ;;=M47.25^^93^1005^34
 ;;^UTILITY(U,$J,358.3,20591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20591,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,20591,1,4,0)
 ;;=4^M47.25
 ;;^UTILITY(U,$J,358.3,20591,2)
 ;;=^5012064
 ;;^UTILITY(U,$J,358.3,20592,0)
 ;;=M47.10^^93^1005^24
 ;;^UTILITY(U,$J,358.3,20592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20592,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,20592,1,4,0)
 ;;=4^M47.10
 ;;^UTILITY(U,$J,358.3,20592,2)
 ;;=^5012050
 ;;^UTILITY(U,$J,358.3,20593,0)
 ;;=G95.0^^93^1005^35
 ;;^UTILITY(U,$J,358.3,20593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20593,1,3,0)
 ;;=3^Syringomyelia & Syringobulbia
 ;;^UTILITY(U,$J,358.3,20593,1,4,0)
 ;;=4^G95.0
 ;;^UTILITY(U,$J,358.3,20593,2)
 ;;=^116874
 ;;^UTILITY(U,$J,358.3,20594,0)
 ;;=M48.061^^93^1005^17
 ;;^UTILITY(U,$J,358.3,20594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20594,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,20594,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,20594,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,20595,0)
 ;;=M48.062^^93^1005^16
 ;;^UTILITY(U,$J,358.3,20595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20595,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,20595,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,20595,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,20596,0)
 ;;=R25.0^^93^1006^1
 ;;^UTILITY(U,$J,358.3,20596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20596,1,3,0)
 ;;=3^Abnormal Head Movements
 ;;^UTILITY(U,$J,358.3,20596,1,4,0)
 ;;=4^R25.0
 ;;^UTILITY(U,$J,358.3,20596,2)
 ;;=^5019299
 ;;^UTILITY(U,$J,358.3,20597,0)
 ;;=R25.9^^93^1006^2
 ;;^UTILITY(U,$J,358.3,20597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20597,1,3,0)
 ;;=3^Abnormal Involuntary Movements,Unspec
 ;;^UTILITY(U,$J,358.3,20597,1,4,0)
 ;;=4^R25.9
 ;;^UTILITY(U,$J,358.3,20597,2)
 ;;=^5019303
 ;;^UTILITY(U,$J,358.3,20598,0)
 ;;=R26.9^^93^1006^3
 ;;^UTILITY(U,$J,358.3,20598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20598,1,3,0)
 ;;=3^Abnormalities of Gait & Mobility,Unspec
 ;;^UTILITY(U,$J,358.3,20598,1,4,0)
 ;;=4^R26.9
 ;;^UTILITY(U,$J,358.3,20598,2)
 ;;=^5019309
 ;;^UTILITY(U,$J,358.3,20599,0)
 ;;=R41.3^^93^1006^4
 ;;^UTILITY(U,$J,358.3,20599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20599,1,3,0)
 ;;=3^Amnesia,Other
 ;;^UTILITY(U,$J,358.3,20599,1,4,0)
 ;;=4^R41.3
 ;;^UTILITY(U,$J,358.3,20599,2)
 ;;=^5019439
 ;;^UTILITY(U,$J,358.3,20600,0)
 ;;=R27.0^^93^1006^5
 ;;^UTILITY(U,$J,358.3,20600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20600,1,3,0)
 ;;=3^Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,20600,1,4,0)
 ;;=4^R27.0
