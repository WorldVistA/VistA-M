IBDEI22G ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34645,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,34646,0)
 ;;=M47.812^^160^1762^17
 ;;^UTILITY(U,$J,358.3,34646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34646,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,34646,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,34646,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,34647,0)
 ;;=M47.12^^160^1762^16
 ;;^UTILITY(U,$J,358.3,34647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34647,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,34647,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,34647,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,34648,0)
 ;;=M48.02^^160^1762^14
 ;;^UTILITY(U,$J,358.3,34648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34648,1,3,0)
 ;;=3^Spinal stenosis, cervical region
 ;;^UTILITY(U,$J,358.3,34648,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,34648,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,34649,0)
 ;;=M45.2^^160^1762^1
 ;;^UTILITY(U,$J,358.3,34649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34649,1,3,0)
 ;;=3^Ankylosing spondylitis of cervical region
 ;;^UTILITY(U,$J,358.3,34649,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,34649,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,34650,0)
 ;;=M45.0^^160^1762^2
 ;;^UTILITY(U,$J,358.3,34650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34650,1,3,0)
 ;;=3^Ankylosing spondylitis of multiple sites in spine
 ;;^UTILITY(U,$J,358.3,34650,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,34650,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,34651,0)
 ;;=Q76.2^^160^1762^5
 ;;^UTILITY(U,$J,358.3,34651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34651,1,3,0)
 ;;=3^Congenital spondylolisthesis
 ;;^UTILITY(U,$J,358.3,34651,1,4,0)
 ;;=4^Q76.2
 ;;^UTILITY(U,$J,358.3,34651,2)
 ;;=^5019003
 ;;^UTILITY(U,$J,358.3,34652,0)
 ;;=M43.10^^160^1762^15
 ;;^UTILITY(U,$J,358.3,34652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34652,1,3,0)
 ;;=3^Spondylolisthesis, site unspecified
 ;;^UTILITY(U,$J,358.3,34652,1,4,0)
 ;;=4^M43.10
 ;;^UTILITY(U,$J,358.3,34652,2)
 ;;=^5011921
 ;;^UTILITY(U,$J,358.3,34653,0)
 ;;=G95.0^^160^1762^18
 ;;^UTILITY(U,$J,358.3,34653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34653,1,3,0)
 ;;=3^Syringomyelia and syringobulbia
 ;;^UTILITY(U,$J,358.3,34653,1,4,0)
 ;;=4^G95.0
 ;;^UTILITY(U,$J,358.3,34653,2)
 ;;=^116874
 ;;^UTILITY(U,$J,358.3,34654,0)
 ;;=G95.20^^160^1762^6
 ;;^UTILITY(U,$J,358.3,34654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34654,1,3,0)
 ;;=3^Cord Compression,Unspec
 ;;^UTILITY(U,$J,358.3,34654,1,4,0)
 ;;=4^G95.20
 ;;^UTILITY(U,$J,358.3,34654,2)
 ;;=^5004190
 ;;^UTILITY(U,$J,358.3,34655,0)
 ;;=G96.0^^160^1762^3
 ;;^UTILITY(U,$J,358.3,34655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34655,1,3,0)
 ;;=3^Cerebrospinal fluid leak
 ;;^UTILITY(U,$J,358.3,34655,1,4,0)
 ;;=4^G96.0
 ;;^UTILITY(U,$J,358.3,34655,2)
 ;;=^5004195
 ;;^UTILITY(U,$J,358.3,34656,0)
 ;;=G96.11^^160^1762^7
 ;;^UTILITY(U,$J,358.3,34656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34656,1,3,0)
 ;;=3^Dural tear
 ;;^UTILITY(U,$J,358.3,34656,1,4,0)
 ;;=4^G96.11
 ;;^UTILITY(U,$J,358.3,34656,2)
 ;;=^5004196
 ;;^UTILITY(U,$J,358.3,34657,0)
 ;;=G82.51^^160^1762^10
 ;;^UTILITY(U,$J,358.3,34657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34657,1,3,0)
 ;;=3^Quadriplegia, C1-C4 complete
 ;;^UTILITY(U,$J,358.3,34657,1,4,0)
 ;;=4^G82.51
 ;;^UTILITY(U,$J,358.3,34657,2)
 ;;=^5004129
 ;;^UTILITY(U,$J,358.3,34658,0)
 ;;=G82.52^^160^1762^11
 ;;^UTILITY(U,$J,358.3,34658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34658,1,3,0)
 ;;=3^Quadriplegia, C1-C4 incomplete
 ;;^UTILITY(U,$J,358.3,34658,1,4,0)
 ;;=4^G82.52
