IBDEI0PE ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32191,0)
 ;;=M05.79^^94^1415^9
 ;;^UTILITY(U,$J,358.3,32191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32191,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of mult site w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32191,1,4,0)
 ;;=4^M05.79
 ;;^UTILITY(U,$J,358.3,32191,2)
 ;;=^5010022
 ;;^UTILITY(U,$J,358.3,32192,0)
 ;;=M05.771^^94^1415^10
 ;;^UTILITY(U,$J,358.3,32192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32192,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of right ank/ft w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32192,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,32192,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,32193,0)
 ;;=M05.721^^94^1415^11
 ;;^UTILITY(U,$J,358.3,32193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32193,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of right elbowlbow w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32193,1,4,0)
 ;;=4^M05.721
 ;;^UTILITY(U,$J,358.3,32193,2)
 ;;=^5010004
 ;;^UTILITY(U,$J,358.3,32194,0)
 ;;=M05.741^^94^1415^12
 ;;^UTILITY(U,$J,358.3,32194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32194,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of right hand w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32194,1,4,0)
 ;;=4^M05.741
 ;;^UTILITY(U,$J,358.3,32194,2)
 ;;=^5010010
 ;;^UTILITY(U,$J,358.3,32195,0)
 ;;=M05.751^^94^1415^13
 ;;^UTILITY(U,$J,358.3,32195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32195,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of right hip w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32195,1,4,0)
 ;;=4^M05.751
 ;;^UTILITY(U,$J,358.3,32195,2)
 ;;=^5010013
 ;;^UTILITY(U,$J,358.3,32196,0)
 ;;=M05.761^^94^1415^14
 ;;^UTILITY(U,$J,358.3,32196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32196,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of right knee w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32196,1,4,0)
 ;;=4^M05.761
 ;;^UTILITY(U,$J,358.3,32196,2)
 ;;=^5010016
 ;;^UTILITY(U,$J,358.3,32197,0)
 ;;=M05.711^^94^1415^15
 ;;^UTILITY(U,$J,358.3,32197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32197,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of right shoulder w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32197,1,4,0)
 ;;=4^M05.711
 ;;^UTILITY(U,$J,358.3,32197,2)
 ;;=^5010001
 ;;^UTILITY(U,$J,358.3,32198,0)
 ;;=M05.731^^94^1415^16
 ;;^UTILITY(U,$J,358.3,32198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32198,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of right wrist w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32198,1,4,0)
 ;;=4^M05.731
 ;;^UTILITY(U,$J,358.3,32198,2)
 ;;=^5010007
 ;;^UTILITY(U,$J,358.3,32199,0)
 ;;=M06.072^^94^1415^17
 ;;^UTILITY(U,$J,358.3,32199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32199,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, left ank/ft
 ;;^UTILITY(U,$J,358.3,32199,1,4,0)
 ;;=4^M06.072
 ;;^UTILITY(U,$J,358.3,32199,2)
 ;;=^5010067
 ;;^UTILITY(U,$J,358.3,32200,0)
 ;;=M06.022^^94^1415^18
 ;;^UTILITY(U,$J,358.3,32200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32200,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, left elbow
 ;;^UTILITY(U,$J,358.3,32200,1,4,0)
 ;;=4^M06.022
 ;;^UTILITY(U,$J,358.3,32200,2)
 ;;=^5010052
 ;;^UTILITY(U,$J,358.3,32201,0)
 ;;=M06.042^^94^1415^19
 ;;^UTILITY(U,$J,358.3,32201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32201,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, left hand
 ;;^UTILITY(U,$J,358.3,32201,1,4,0)
 ;;=4^M06.042
 ;;^UTILITY(U,$J,358.3,32201,2)
 ;;=^5010058
 ;;^UTILITY(U,$J,358.3,32202,0)
 ;;=M06.052^^94^1415^20
 ;;^UTILITY(U,$J,358.3,32202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32202,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, left hip
 ;;^UTILITY(U,$J,358.3,32202,1,4,0)
 ;;=4^M06.052
 ;;^UTILITY(U,$J,358.3,32202,2)
 ;;=^5010061
 ;;^UTILITY(U,$J,358.3,32203,0)
 ;;=M06.062^^94^1415^21
 ;;^UTILITY(U,$J,358.3,32203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32203,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, left knee
 ;;^UTILITY(U,$J,358.3,32203,1,4,0)
 ;;=4^M06.062
 ;;^UTILITY(U,$J,358.3,32203,2)
 ;;=^5010064
 ;;^UTILITY(U,$J,358.3,32204,0)
 ;;=M06.012^^94^1415^22
 ;;^UTILITY(U,$J,358.3,32204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32204,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, left shoulder
 ;;^UTILITY(U,$J,358.3,32204,1,4,0)
 ;;=4^M06.012
 ;;^UTILITY(U,$J,358.3,32204,2)
 ;;=^5010049
 ;;^UTILITY(U,$J,358.3,32205,0)
 ;;=M06.032^^94^1415^23
 ;;^UTILITY(U,$J,358.3,32205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32205,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, left wrist
 ;;^UTILITY(U,$J,358.3,32205,1,4,0)
 ;;=4^M06.032
 ;;^UTILITY(U,$J,358.3,32205,2)
 ;;=^5010055
 ;;^UTILITY(U,$J,358.3,32206,0)
 ;;=M06.09^^94^1415^24
 ;;^UTILITY(U,$J,358.3,32206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32206,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, multiple sites
 ;;^UTILITY(U,$J,358.3,32206,1,4,0)
 ;;=4^M06.09
 ;;^UTILITY(U,$J,358.3,32206,2)
 ;;=^5010070
 ;;^UTILITY(U,$J,358.3,32207,0)
 ;;=M06.071^^94^1415^25
 ;;^UTILITY(U,$J,358.3,32207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32207,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right ank/ft
 ;;^UTILITY(U,$J,358.3,32207,1,4,0)
 ;;=4^M06.071
 ;;^UTILITY(U,$J,358.3,32207,2)
 ;;=^5010066
 ;;^UTILITY(U,$J,358.3,32208,0)
 ;;=M06.021^^94^1415^26
 ;;^UTILITY(U,$J,358.3,32208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32208,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right elbow
 ;;^UTILITY(U,$J,358.3,32208,1,4,0)
 ;;=4^M06.021
 ;;^UTILITY(U,$J,358.3,32208,2)
 ;;=^5010051
 ;;^UTILITY(U,$J,358.3,32209,0)
 ;;=M06.041^^94^1415^27
 ;;^UTILITY(U,$J,358.3,32209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32209,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right hand
 ;;^UTILITY(U,$J,358.3,32209,1,4,0)
 ;;=4^M06.041
 ;;^UTILITY(U,$J,358.3,32209,2)
 ;;=^5010057
 ;;^UTILITY(U,$J,358.3,32210,0)
 ;;=M06.051^^94^1415^28
 ;;^UTILITY(U,$J,358.3,32210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32210,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right hip
 ;;^UTILITY(U,$J,358.3,32210,1,4,0)
 ;;=4^M06.051
 ;;^UTILITY(U,$J,358.3,32210,2)
 ;;=^5010060
 ;;^UTILITY(U,$J,358.3,32211,0)
 ;;=M06.061^^94^1415^29
 ;;^UTILITY(U,$J,358.3,32211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32211,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right knee
 ;;^UTILITY(U,$J,358.3,32211,1,4,0)
 ;;=4^M06.061
 ;;^UTILITY(U,$J,358.3,32211,2)
 ;;=^5010063
 ;;^UTILITY(U,$J,358.3,32212,0)
 ;;=M06.011^^94^1415^30
 ;;^UTILITY(U,$J,358.3,32212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32212,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right shoulder
 ;;^UTILITY(U,$J,358.3,32212,1,4,0)
 ;;=4^M06.011
 ;;^UTILITY(U,$J,358.3,32212,2)
 ;;=^5010048
 ;;^UTILITY(U,$J,358.3,32213,0)
 ;;=M06.031^^94^1415^31
 ;;^UTILITY(U,$J,358.3,32213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32213,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right wrist
 ;;^UTILITY(U,$J,358.3,32213,1,4,0)
 ;;=4^M06.031
 ;;^UTILITY(U,$J,358.3,32213,2)
 ;;=^5010054
 ;;^UTILITY(U,$J,358.3,32214,0)
 ;;=M06.08^^94^1415^32
 ;;^UTILITY(U,$J,358.3,32214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32214,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, vertebrae
 ;;^UTILITY(U,$J,358.3,32214,1,4,0)
 ;;=4^M06.08
 ;;^UTILITY(U,$J,358.3,32214,2)
 ;;=^5010069
 ;;^UTILITY(U,$J,358.3,32215,0)
 ;;=M06.272^^94^1415^34
 ;;^UTILITY(U,$J,358.3,32215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32215,1,3,0)
 ;;=3^Rheumatoid bursitis, left ankle and foot
 ;;^UTILITY(U,$J,358.3,32215,1,4,0)
 ;;=4^M06.272
 ;;^UTILITY(U,$J,358.3,32215,2)
 ;;=^5010092
 ;;^UTILITY(U,$J,358.3,32216,0)
 ;;=M06.222^^94^1415^35
 ;;^UTILITY(U,$J,358.3,32216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32216,1,3,0)
 ;;=3^Rheumatoid bursitis, left elbow
 ;;^UTILITY(U,$J,358.3,32216,1,4,0)
 ;;=4^M06.222
 ;;^UTILITY(U,$J,358.3,32216,2)
 ;;=^5010077
 ;;^UTILITY(U,$J,358.3,32217,0)
 ;;=M06.242^^94^1415^36
 ;;^UTILITY(U,$J,358.3,32217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32217,1,3,0)
 ;;=3^Rheumatoid bursitis, left hand
 ;;^UTILITY(U,$J,358.3,32217,1,4,0)
 ;;=4^M06.242
 ;;^UTILITY(U,$J,358.3,32217,2)
 ;;=^5010083
 ;;^UTILITY(U,$J,358.3,32218,0)
 ;;=M06.252^^94^1415^37
 ;;^UTILITY(U,$J,358.3,32218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32218,1,3,0)
 ;;=3^Rheumatoid bursitis, left hip
 ;;^UTILITY(U,$J,358.3,32218,1,4,0)
 ;;=4^M06.252
 ;;^UTILITY(U,$J,358.3,32218,2)
 ;;=^5010086
 ;;^UTILITY(U,$J,358.3,32219,0)
 ;;=M06.262^^94^1415^38
 ;;^UTILITY(U,$J,358.3,32219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32219,1,3,0)
 ;;=3^Rheumatoid bursitis, left knee
 ;;^UTILITY(U,$J,358.3,32219,1,4,0)
 ;;=4^M06.262
 ;;^UTILITY(U,$J,358.3,32219,2)
 ;;=^5010089
 ;;^UTILITY(U,$J,358.3,32220,0)
 ;;=M06.212^^94^1415^39
 ;;^UTILITY(U,$J,358.3,32220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32220,1,3,0)
 ;;=3^Rheumatoid bursitis, left shoulder
 ;;^UTILITY(U,$J,358.3,32220,1,4,0)
 ;;=4^M06.212
 ;;^UTILITY(U,$J,358.3,32220,2)
 ;;=^5010074
 ;;^UTILITY(U,$J,358.3,32221,0)
 ;;=M06.232^^94^1415^40
 ;;^UTILITY(U,$J,358.3,32221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32221,1,3,0)
 ;;=3^Rheumatoid bursitis, left wrist
 ;;^UTILITY(U,$J,358.3,32221,1,4,0)
 ;;=4^M06.232
 ;;^UTILITY(U,$J,358.3,32221,2)
 ;;=^5010080
 ;;^UTILITY(U,$J,358.3,32222,0)
 ;;=M06.29^^94^1415^41
 ;;^UTILITY(U,$J,358.3,32222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32222,1,3,0)
 ;;=3^Rheumatoid bursitis, multiple sites
 ;;^UTILITY(U,$J,358.3,32222,1,4,0)
 ;;=4^M06.29
 ;;^UTILITY(U,$J,358.3,32222,2)
 ;;=^5010095
 ;;^UTILITY(U,$J,358.3,32223,0)
 ;;=M06.271^^94^1415^42
 ;;^UTILITY(U,$J,358.3,32223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32223,1,3,0)
 ;;=3^Rheumatoid bursitis, right ankle and foot
 ;;^UTILITY(U,$J,358.3,32223,1,4,0)
 ;;=4^M06.271
 ;;^UTILITY(U,$J,358.3,32223,2)
 ;;=^5010091
 ;;^UTILITY(U,$J,358.3,32224,0)
 ;;=M06.221^^94^1415^43
 ;;^UTILITY(U,$J,358.3,32224,1,0)
 ;;=^358.31IA^4^2
