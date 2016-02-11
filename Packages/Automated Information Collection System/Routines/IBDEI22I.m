IBDEI22I ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34671,1,3,0)
 ;;=3^Cerebrospinal fluid leak
 ;;^UTILITY(U,$J,358.3,34671,1,4,0)
 ;;=4^G96.0
 ;;^UTILITY(U,$J,358.3,34671,2)
 ;;=^5004195
 ;;^UTILITY(U,$J,358.3,34672,0)
 ;;=G96.11^^160^1763^4
 ;;^UTILITY(U,$J,358.3,34672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34672,1,3,0)
 ;;=3^Dural tear
 ;;^UTILITY(U,$J,358.3,34672,1,4,0)
 ;;=4^G96.11
 ;;^UTILITY(U,$J,358.3,34672,2)
 ;;=^5004196
 ;;^UTILITY(U,$J,358.3,34673,0)
 ;;=M54.14^^160^1763^10
 ;;^UTILITY(U,$J,358.3,34673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34673,1,3,0)
 ;;=3^Radiculopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,34673,1,4,0)
 ;;=4^M54.14
 ;;^UTILITY(U,$J,358.3,34673,2)
 ;;=^5012299
 ;;^UTILITY(U,$J,358.3,34674,0)
 ;;=M45.6^^160^1764^1
 ;;^UTILITY(U,$J,358.3,34674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34674,1,3,0)
 ;;=3^Ankylosing spondylitis lumbar region
 ;;^UTILITY(U,$J,358.3,34674,1,4,0)
 ;;=4^M45.6
 ;;^UTILITY(U,$J,358.3,34674,2)
 ;;=^5011966
 ;;^UTILITY(U,$J,358.3,34675,0)
 ;;=M45.7^^160^1764^2
 ;;^UTILITY(U,$J,358.3,34675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34675,1,3,0)
 ;;=3^Ankylosing spondylitis lumbosacral region
 ;;^UTILITY(U,$J,358.3,34675,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,34675,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,34676,0)
 ;;=M47.16^^160^1764^17
 ;;^UTILITY(U,$J,358.3,34676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34676,1,3,0)
 ;;=3^Spondylosis w/ myelopathy, lumbar region NEC
 ;;^UTILITY(U,$J,358.3,34676,1,4,0)
 ;;=4^M47.16
 ;;^UTILITY(U,$J,358.3,34676,2)
 ;;=^5012056
 ;;^UTILITY(U,$J,358.3,34677,0)
 ;;=M51.06^^160^1764^10
 ;;^UTILITY(U,$J,358.3,34677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34677,1,3,0)
 ;;=3^Intervertebral disc disorders with myelopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,34677,1,4,0)
 ;;=4^M51.06
 ;;^UTILITY(U,$J,358.3,34677,2)
 ;;=^5012241
 ;;^UTILITY(U,$J,358.3,34678,0)
 ;;=M51.36^^160^1764^9
 ;;^UTILITY(U,$J,358.3,34678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34678,1,3,0)
 ;;=3^Intervertebral disc degeneration, lumbar region NEC
 ;;^UTILITY(U,$J,358.3,34678,1,4,0)
 ;;=4^M51.36
 ;;^UTILITY(U,$J,358.3,34678,2)
 ;;=^5012253
 ;;^UTILITY(U,$J,358.3,34679,0)
 ;;=M51.26^^160^1764^11
 ;;^UTILITY(U,$J,358.3,34679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34679,1,3,0)
 ;;=3^Intervertebral disc displacement, lumbar region NEC
 ;;^UTILITY(U,$J,358.3,34679,1,4,0)
 ;;=4^M51.26
 ;;^UTILITY(U,$J,358.3,34679,2)
 ;;=^5012249
 ;;^UTILITY(U,$J,358.3,34680,0)
 ;;=M54.16^^160^1764^13
 ;;^UTILITY(U,$J,358.3,34680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34680,1,3,0)
 ;;=3^Radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,34680,1,4,0)
 ;;=4^M54.16
 ;;^UTILITY(U,$J,358.3,34680,2)
 ;;=^5012301
 ;;^UTILITY(U,$J,358.3,34681,0)
 ;;=M43.27^^160^1764^8
 ;;^UTILITY(U,$J,358.3,34681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34681,1,3,0)
 ;;=3^Fusion of spine, lumbosacral region
 ;;^UTILITY(U,$J,358.3,34681,1,4,0)
 ;;=4^M43.27
 ;;^UTILITY(U,$J,358.3,34681,2)
 ;;=^5011938
 ;;^UTILITY(U,$J,358.3,34682,0)
 ;;=M53.2X7^^160^1764^14
 ;;^UTILITY(U,$J,358.3,34682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34682,1,3,0)
 ;;=3^Spinal instabilities, lumbosacral region
 ;;^UTILITY(U,$J,358.3,34682,1,4,0)
 ;;=4^M53.2X7
 ;;^UTILITY(U,$J,358.3,34682,2)
 ;;=^5012271
 ;;^UTILITY(U,$J,358.3,34683,0)
 ;;=M47.817^^160^1764^18
 ;;^UTILITY(U,$J,358.3,34683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34683,1,3,0)
 ;;=3^Spondylosis w/o myelopathy/radiculopathy, lumbosacr region
 ;;^UTILITY(U,$J,358.3,34683,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,34683,2)
 ;;=^5012074
