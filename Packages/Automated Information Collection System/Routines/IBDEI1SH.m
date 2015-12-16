IBDEI1SH ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31570,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,31571,0)
 ;;=M19.041^^180^1962^24
 ;;^UTILITY(U,$J,358.3,31571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31571,1,3,0)
 ;;=3^Primary osteoarthritis, right hand
 ;;^UTILITY(U,$J,358.3,31571,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,31571,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,31572,0)
 ;;=M19.011^^180^1962^25
 ;;^UTILITY(U,$J,358.3,31572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31572,1,3,0)
 ;;=3^Primary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,31572,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,31572,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,31573,0)
 ;;=M76.12^^180^1962^26
 ;;^UTILITY(U,$J,358.3,31573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31573,1,3,0)
 ;;=3^Psoas tendinitis, left hip
 ;;^UTILITY(U,$J,358.3,31573,1,4,0)
 ;;=4^M76.12
 ;;^UTILITY(U,$J,358.3,31573,2)
 ;;=^5013271
 ;;^UTILITY(U,$J,358.3,31574,0)
 ;;=M76.11^^180^1962^27
 ;;^UTILITY(U,$J,358.3,31574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31574,1,3,0)
 ;;=3^Psoas tendinitis, right hip
 ;;^UTILITY(U,$J,358.3,31574,1,4,0)
 ;;=4^M76.11
 ;;^UTILITY(U,$J,358.3,31574,2)
 ;;=^5013270
 ;;^UTILITY(U,$J,358.3,31575,0)
 ;;=G82.50^^180^1962^28
 ;;^UTILITY(U,$J,358.3,31575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31575,1,3,0)
 ;;=3^Quadriplegia, unspecified
 ;;^UTILITY(U,$J,358.3,31575,1,4,0)
 ;;=4^G82.50
 ;;^UTILITY(U,$J,358.3,31575,2)
 ;;=^5004128
 ;;^UTILITY(U,$J,358.3,31576,0)
 ;;=M65.4^^180^1962^29
 ;;^UTILITY(U,$J,358.3,31576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31576,1,3,0)
 ;;=3^Radial styloid tenosynovitis [de Quervain]
 ;;^UTILITY(U,$J,358.3,31576,1,4,0)
 ;;=4^M65.4
 ;;^UTILITY(U,$J,358.3,31576,2)
 ;;=^5012792
 ;;^UTILITY(U,$J,358.3,31577,0)
 ;;=M54.10^^180^1962^30
 ;;^UTILITY(U,$J,358.3,31577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31577,1,3,0)
 ;;=3^Radiculopathy, site unspecified
 ;;^UTILITY(U,$J,358.3,31577,1,4,0)
 ;;=4^M54.10
 ;;^UTILITY(U,$J,358.3,31577,2)
 ;;=^5012295
 ;;^UTILITY(U,$J,358.3,31578,0)
 ;;=M05.772^^180^1962^31
 ;;^UTILITY(U,$J,358.3,31578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31578,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left ank/ft w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,31578,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,31578,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,31579,0)
 ;;=M05.722^^180^1962^32
 ;;^UTILITY(U,$J,358.3,31579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31579,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left elbow w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,31579,1,4,0)
 ;;=4^M05.722
 ;;^UTILITY(U,$J,358.3,31579,2)
 ;;=^5010005
 ;;^UTILITY(U,$J,358.3,31580,0)
 ;;=M05.742^^180^1962^33
 ;;^UTILITY(U,$J,358.3,31580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31580,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left hand w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,31580,1,4,0)
 ;;=4^M05.742
 ;;^UTILITY(U,$J,358.3,31580,2)
 ;;=^5010011
 ;;^UTILITY(U,$J,358.3,31581,0)
 ;;=M05.752^^180^1962^34
 ;;^UTILITY(U,$J,358.3,31581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31581,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left hip w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,31581,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,31581,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,31582,0)
 ;;=M05.752^^180^1962^35
 ;;^UTILITY(U,$J,358.3,31582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31582,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left hip w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,31582,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,31582,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,31583,0)
 ;;=M05.762^^180^1962^36
