IBDEI0SD ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37461,1,3,0)
 ;;=3^Primary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,37461,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,37461,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,37462,0)
 ;;=M76.12^^106^1590^64
 ;;^UTILITY(U,$J,358.3,37462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37462,1,3,0)
 ;;=3^Psoas tendinitis, left hip
 ;;^UTILITY(U,$J,358.3,37462,1,4,0)
 ;;=4^M76.12
 ;;^UTILITY(U,$J,358.3,37462,2)
 ;;=^5013271
 ;;^UTILITY(U,$J,358.3,37463,0)
 ;;=M76.11^^106^1590^65
 ;;^UTILITY(U,$J,358.3,37463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37463,1,3,0)
 ;;=3^Psoas tendinitis, right hip
 ;;^UTILITY(U,$J,358.3,37463,1,4,0)
 ;;=4^M76.11
 ;;^UTILITY(U,$J,358.3,37463,2)
 ;;=^5013270
 ;;^UTILITY(U,$J,358.3,37464,0)
 ;;=M65.4^^106^1590^66
 ;;^UTILITY(U,$J,358.3,37464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37464,1,3,0)
 ;;=3^Radial styloid tenosynovitis [de Quervain]
 ;;^UTILITY(U,$J,358.3,37464,1,4,0)
 ;;=4^M65.4
 ;;^UTILITY(U,$J,358.3,37464,2)
 ;;=^5012792
 ;;^UTILITY(U,$J,358.3,37465,0)
 ;;=M54.18^^106^1590^67
 ;;^UTILITY(U,$J,358.3,37465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37465,1,3,0)
 ;;=3^Radiculopathy, sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,37465,1,4,0)
 ;;=4^M54.18
 ;;^UTILITY(U,$J,358.3,37465,2)
 ;;=^5012303
 ;;^UTILITY(U,$J,358.3,37466,0)
 ;;=M05.772^^106^1590^68
 ;;^UTILITY(U,$J,358.3,37466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37466,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of left ank/ft w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37466,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,37466,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,37467,0)
 ;;=M05.742^^106^1590^69
 ;;^UTILITY(U,$J,358.3,37467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37467,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of left hand w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37467,1,4,0)
 ;;=4^M05.742
 ;;^UTILITY(U,$J,358.3,37467,2)
 ;;=^5010011
 ;;^UTILITY(U,$J,358.3,37468,0)
 ;;=M05.762^^106^1590^70
 ;;^UTILITY(U,$J,358.3,37468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37468,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of left knee w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37468,1,4,0)
 ;;=4^M05.762
 ;;^UTILITY(U,$J,358.3,37468,2)
 ;;=^5010017
 ;;^UTILITY(U,$J,358.3,37469,0)
 ;;=M05.712^^106^1590^71
 ;;^UTILITY(U,$J,358.3,37469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37469,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of left shoulder w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37469,1,4,0)
 ;;=4^M05.712
 ;;^UTILITY(U,$J,358.3,37469,2)
 ;;=^5010002
 ;;^UTILITY(U,$J,358.3,37470,0)
 ;;=M05.732^^106^1590^72
 ;;^UTILITY(U,$J,358.3,37470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37470,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of left wrist w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37470,1,4,0)
 ;;=4^M05.732
 ;;^UTILITY(U,$J,358.3,37470,2)
 ;;=^5010008
 ;;^UTILITY(U,$J,358.3,37471,0)
 ;;=M05.771^^106^1590^73
 ;;^UTILITY(U,$J,358.3,37471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37471,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of right ank/ft w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37471,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,37471,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,37472,0)
 ;;=M05.721^^106^1590^74
 ;;^UTILITY(U,$J,358.3,37472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37472,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of right elbow w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37472,1,4,0)
 ;;=4^M05.721
 ;;^UTILITY(U,$J,358.3,37472,2)
 ;;=^5010004
 ;;^UTILITY(U,$J,358.3,37473,0)
 ;;=M05.741^^106^1590^75
 ;;^UTILITY(U,$J,358.3,37473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37473,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of right hand w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37473,1,4,0)
 ;;=4^M05.741
 ;;^UTILITY(U,$J,358.3,37473,2)
 ;;=^5010010
 ;;^UTILITY(U,$J,358.3,37474,0)
 ;;=M05.751^^106^1590^76
 ;;^UTILITY(U,$J,358.3,37474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37474,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of right hip w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37474,1,4,0)
 ;;=4^M05.751
 ;;^UTILITY(U,$J,358.3,37474,2)
 ;;=^5010013
 ;;^UTILITY(U,$J,358.3,37475,0)
 ;;=M05.761^^106^1590^77
 ;;^UTILITY(U,$J,358.3,37475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37475,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of right knee w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37475,1,4,0)
 ;;=4^M05.761
 ;;^UTILITY(U,$J,358.3,37475,2)
 ;;=^5010016
 ;;^UTILITY(U,$J,358.3,37476,0)
 ;;=M05.711^^106^1590^78
 ;;^UTILITY(U,$J,358.3,37476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37476,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of right shoulder w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37476,1,4,0)
 ;;=4^M05.711
 ;;^UTILITY(U,$J,358.3,37476,2)
 ;;=^5010001
 ;;^UTILITY(U,$J,358.3,37477,0)
 ;;=M05.731^^106^1590^79
 ;;^UTILITY(U,$J,358.3,37477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37477,1,3,0)
 ;;=3^Rheu arthrit w rheu factor of right wrist w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,37477,1,4,0)
 ;;=4^M05.731
 ;;^UTILITY(U,$J,358.3,37477,2)
 ;;=^5010007
 ;;^UTILITY(U,$J,358.3,37478,0)
 ;;=M06.072^^106^1590^80
 ;;^UTILITY(U,$J,358.3,37478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37478,1,3,0)
 ;;=3^Rheu arthrit w/o rheu factor of left ank/ft
 ;;^UTILITY(U,$J,358.3,37478,1,4,0)
 ;;=4^M06.072
 ;;^UTILITY(U,$J,358.3,37478,2)
 ;;=^5010067
 ;;^UTILITY(U,$J,358.3,37479,0)
 ;;=M06.022^^106^1590^81
 ;;^UTILITY(U,$J,358.3,37479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37479,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, left elbow 
 ;;^UTILITY(U,$J,358.3,37479,1,4,0)
 ;;=4^M06.022
 ;;^UTILITY(U,$J,358.3,37479,2)
 ;;=^5010052
 ;;^UTILITY(U,$J,358.3,37480,0)
 ;;=M06.042^^106^1590^82
 ;;^UTILITY(U,$J,358.3,37480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37480,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, left hand 
 ;;^UTILITY(U,$J,358.3,37480,1,4,0)
 ;;=4^M06.042
 ;;^UTILITY(U,$J,358.3,37480,2)
 ;;=^5010058
 ;;^UTILITY(U,$J,358.3,37481,0)
 ;;=M06.052^^106^1590^83
 ;;^UTILITY(U,$J,358.3,37481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37481,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, left hip 
 ;;^UTILITY(U,$J,358.3,37481,1,4,0)
 ;;=4^M06.052
 ;;^UTILITY(U,$J,358.3,37481,2)
 ;;=^5010061
 ;;^UTILITY(U,$J,358.3,37482,0)
 ;;=M06.062^^106^1590^84
 ;;^UTILITY(U,$J,358.3,37482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37482,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, left knee 
 ;;^UTILITY(U,$J,358.3,37482,1,4,0)
 ;;=4^M06.062
 ;;^UTILITY(U,$J,358.3,37482,2)
 ;;=^5010064
 ;;^UTILITY(U,$J,358.3,37483,0)
 ;;=M06.012^^106^1590^85
 ;;^UTILITY(U,$J,358.3,37483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37483,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, left shoulder
 ;;^UTILITY(U,$J,358.3,37483,1,4,0)
 ;;=4^M06.012
 ;;^UTILITY(U,$J,358.3,37483,2)
 ;;=^5010049
 ;;^UTILITY(U,$J,358.3,37484,0)
 ;;=M06.032^^106^1590^86
 ;;^UTILITY(U,$J,358.3,37484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37484,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, left wrist 
 ;;^UTILITY(U,$J,358.3,37484,1,4,0)
 ;;=4^M06.032
 ;;^UTILITY(U,$J,358.3,37484,2)
 ;;=^5010055
 ;;^UTILITY(U,$J,358.3,37485,0)
 ;;=M06.071^^106^1590^87
 ;;^UTILITY(U,$J,358.3,37485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37485,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right ank/ft 
 ;;^UTILITY(U,$J,358.3,37485,1,4,0)
 ;;=4^M06.071
 ;;^UTILITY(U,$J,358.3,37485,2)
 ;;=^5010066
 ;;^UTILITY(U,$J,358.3,37486,0)
 ;;=M06.021^^106^1590^88
 ;;^UTILITY(U,$J,358.3,37486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37486,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right elbow 
 ;;^UTILITY(U,$J,358.3,37486,1,4,0)
 ;;=4^M06.021
 ;;^UTILITY(U,$J,358.3,37486,2)
 ;;=^5010051
 ;;^UTILITY(U,$J,358.3,37487,0)
 ;;=M06.041^^106^1590^89
 ;;^UTILITY(U,$J,358.3,37487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37487,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right hand 
 ;;^UTILITY(U,$J,358.3,37487,1,4,0)
 ;;=4^M06.041
 ;;^UTILITY(U,$J,358.3,37487,2)
 ;;=^5010057
 ;;^UTILITY(U,$J,358.3,37488,0)
 ;;=M06.051^^106^1590^90
 ;;^UTILITY(U,$J,358.3,37488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37488,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right hip 
 ;;^UTILITY(U,$J,358.3,37488,1,4,0)
 ;;=4^M06.051
 ;;^UTILITY(U,$J,358.3,37488,2)
 ;;=^5010060
 ;;^UTILITY(U,$J,358.3,37489,0)
 ;;=M06.061^^106^1590^91
 ;;^UTILITY(U,$J,358.3,37489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37489,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right knee
 ;;^UTILITY(U,$J,358.3,37489,1,4,0)
 ;;=4^M06.061
 ;;^UTILITY(U,$J,358.3,37489,2)
 ;;=^5010063
 ;;^UTILITY(U,$J,358.3,37490,0)
 ;;=M06.011^^106^1590^92
 ;;^UTILITY(U,$J,358.3,37490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37490,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right shoulder
 ;;^UTILITY(U,$J,358.3,37490,1,4,0)
 ;;=4^M06.011
 ;;^UTILITY(U,$J,358.3,37490,2)
 ;;=^5010048
 ;;^UTILITY(U,$J,358.3,37491,0)
 ;;=M06.031^^106^1590^93
 ;;^UTILITY(U,$J,358.3,37491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37491,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right wrist 
 ;;^UTILITY(U,$J,358.3,37491,1,4,0)
 ;;=4^M06.031
 ;;^UTILITY(U,$J,358.3,37491,2)
 ;;=^5010054
 ;;^UTILITY(U,$J,358.3,37492,0)
 ;;=M06.08^^106^1590^94
 ;;^UTILITY(U,$J,358.3,37492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37492,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, vertebrae
 ;;^UTILITY(U,$J,358.3,37492,1,4,0)
 ;;=4^M06.08
 ;;^UTILITY(U,$J,358.3,37492,2)
 ;;=^5010069
 ;;^UTILITY(U,$J,358.3,37493,0)
 ;;=M06.272^^106^1590^123
 ;;^UTILITY(U,$J,358.3,37493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37493,1,3,0)
 ;;=3^Rheumatoid bursitis, left ankle and foot
 ;;^UTILITY(U,$J,358.3,37493,1,4,0)
 ;;=4^M06.272
 ;;^UTILITY(U,$J,358.3,37493,2)
 ;;=^5010092
 ;;^UTILITY(U,$J,358.3,37494,0)
 ;;=M06.222^^106^1590^124
 ;;^UTILITY(U,$J,358.3,37494,1,0)
 ;;=^358.31IA^4^2
