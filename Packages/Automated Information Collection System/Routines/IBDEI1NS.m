IBDEI1NS ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29467,0)
 ;;=M54.2^^176^1884^4
 ;;^UTILITY(U,$J,358.3,29467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29467,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,29467,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,29467,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,29468,0)
 ;;=I65.21^^176^1884^9
 ;;^UTILITY(U,$J,358.3,29468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29468,1,3,0)
 ;;=3^Occlusion and stenosis of right carotid artery
 ;;^UTILITY(U,$J,358.3,29468,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,29468,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,29469,0)
 ;;=I65.22^^176^1884^8
 ;;^UTILITY(U,$J,358.3,29469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29469,1,3,0)
 ;;=3^Occlusion and stenosis of left carotid artery
 ;;^UTILITY(U,$J,358.3,29469,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,29469,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,29470,0)
 ;;=M47.812^^176^1884^17
 ;;^UTILITY(U,$J,358.3,29470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29470,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,29470,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,29470,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,29471,0)
 ;;=M47.12^^176^1884^16
 ;;^UTILITY(U,$J,358.3,29471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29471,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,29471,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,29471,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,29472,0)
 ;;=M48.02^^176^1884^14
 ;;^UTILITY(U,$J,358.3,29472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29472,1,3,0)
 ;;=3^Spinal stenosis, cervical region
 ;;^UTILITY(U,$J,358.3,29472,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,29472,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,29473,0)
 ;;=M45.2^^176^1884^1
 ;;^UTILITY(U,$J,358.3,29473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29473,1,3,0)
 ;;=3^Ankylosing spondylitis of cervical region
 ;;^UTILITY(U,$J,358.3,29473,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,29473,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,29474,0)
 ;;=M45.0^^176^1884^2
 ;;^UTILITY(U,$J,358.3,29474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29474,1,3,0)
 ;;=3^Ankylosing spondylitis of multiple sites in spine
 ;;^UTILITY(U,$J,358.3,29474,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,29474,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,29475,0)
 ;;=Q76.2^^176^1884^5
 ;;^UTILITY(U,$J,358.3,29475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29475,1,3,0)
 ;;=3^Congenital spondylolisthesis
 ;;^UTILITY(U,$J,358.3,29475,1,4,0)
 ;;=4^Q76.2
 ;;^UTILITY(U,$J,358.3,29475,2)
 ;;=^5019003
 ;;^UTILITY(U,$J,358.3,29476,0)
 ;;=M43.10^^176^1884^15
 ;;^UTILITY(U,$J,358.3,29476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29476,1,3,0)
 ;;=3^Spondylolisthesis, site unspecified
 ;;^UTILITY(U,$J,358.3,29476,1,4,0)
 ;;=4^M43.10
 ;;^UTILITY(U,$J,358.3,29476,2)
 ;;=^5011921
 ;;^UTILITY(U,$J,358.3,29477,0)
 ;;=G95.0^^176^1884^18
 ;;^UTILITY(U,$J,358.3,29477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29477,1,3,0)
 ;;=3^Syringomyelia and syringobulbia
 ;;^UTILITY(U,$J,358.3,29477,1,4,0)
 ;;=4^G95.0
 ;;^UTILITY(U,$J,358.3,29477,2)
 ;;=^116874
 ;;^UTILITY(U,$J,358.3,29478,0)
 ;;=G95.20^^176^1884^6
 ;;^UTILITY(U,$J,358.3,29478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29478,1,3,0)
 ;;=3^Cord Compression,Unspec
 ;;^UTILITY(U,$J,358.3,29478,1,4,0)
 ;;=4^G95.20
 ;;^UTILITY(U,$J,358.3,29478,2)
 ;;=^5004190
 ;;^UTILITY(U,$J,358.3,29479,0)
 ;;=G96.0^^176^1884^3
 ;;^UTILITY(U,$J,358.3,29479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29479,1,3,0)
 ;;=3^Cerebrospinal fluid leak
 ;;^UTILITY(U,$J,358.3,29479,1,4,0)
 ;;=4^G96.0
