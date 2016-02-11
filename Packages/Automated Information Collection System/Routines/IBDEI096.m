IBDEI096 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3749,0)
 ;;=M88.9^^28^258^107
 ;;^UTILITY(U,$J,358.3,3749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3749,1,3,0)
 ;;=3^Osteitis Deformans,Unspec Bone
 ;;^UTILITY(U,$J,358.3,3749,1,4,0)
 ;;=4^M88.9
 ;;^UTILITY(U,$J,358.3,3749,2)
 ;;=^5014899
 ;;^UTILITY(U,$J,358.3,3750,0)
 ;;=M18.9^^28^258^108
 ;;^UTILITY(U,$J,358.3,3750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3750,1,3,0)
 ;;=3^Osteoarthritis,1st Carpometacarpal Joint,Unspec
 ;;^UTILITY(U,$J,358.3,3750,1,4,0)
 ;;=4^M18.9
 ;;^UTILITY(U,$J,358.3,3750,2)
 ;;=^5010807
 ;;^UTILITY(U,$J,358.3,3751,0)
 ;;=M16.9^^28^258^109
 ;;^UTILITY(U,$J,358.3,3751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3751,1,3,0)
 ;;=3^Osteoarthritis,Hip,Unspec
 ;;^UTILITY(U,$J,358.3,3751,1,4,0)
 ;;=4^M16.9
 ;;^UTILITY(U,$J,358.3,3751,2)
 ;;=^5010783
 ;;^UTILITY(U,$J,358.3,3752,0)
 ;;=M17.9^^28^258^110
 ;;^UTILITY(U,$J,358.3,3752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3752,1,3,0)
 ;;=3^Osteoarthritis,Knee,Unspec
 ;;^UTILITY(U,$J,358.3,3752,1,4,0)
 ;;=4^M17.9
 ;;^UTILITY(U,$J,358.3,3752,2)
 ;;=^5010794
 ;;^UTILITY(U,$J,358.3,3753,0)
 ;;=M19.92^^28^258^111
 ;;^UTILITY(U,$J,358.3,3753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3753,1,3,0)
 ;;=3^Osteoarthritis,Post-Traumatic,Unspec Site
 ;;^UTILITY(U,$J,358.3,3753,1,4,0)
 ;;=4^M19.92
 ;;^UTILITY(U,$J,358.3,3753,2)
 ;;=^5010855
 ;;^UTILITY(U,$J,358.3,3754,0)
 ;;=M19.91^^28^258^112
 ;;^UTILITY(U,$J,358.3,3754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3754,1,3,0)
 ;;=3^Osteoarthritis,Primary,Unspec Site
 ;;^UTILITY(U,$J,358.3,3754,1,4,0)
 ;;=4^M19.91
 ;;^UTILITY(U,$J,358.3,3754,2)
 ;;=^5010854
 ;;^UTILITY(U,$J,358.3,3755,0)
 ;;=M19.93^^28^258^113
 ;;^UTILITY(U,$J,358.3,3755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3755,1,3,0)
 ;;=3^Osteoarthritis,Secondary,Unspec Site
 ;;^UTILITY(U,$J,358.3,3755,1,4,0)
 ;;=4^M19.93
 ;;^UTILITY(U,$J,358.3,3755,2)
 ;;=^5010856
 ;;^UTILITY(U,$J,358.3,3756,0)
 ;;=M19.90^^28^258^114
 ;;^UTILITY(U,$J,358.3,3756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3756,1,3,0)
 ;;=3^Osteoarthritis,Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,3756,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,3756,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,3757,0)
 ;;=M89.40^^28^258^115
 ;;^UTILITY(U,$J,358.3,3757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3757,1,3,0)
 ;;=3^Osteoarthropathy,Hypertrophic,Unspec Site
 ;;^UTILITY(U,$J,358.3,3757,1,4,0)
 ;;=4^M89.40
 ;;^UTILITY(U,$J,358.3,3757,2)
 ;;=^5015014
 ;;^UTILITY(U,$J,358.3,3758,0)
 ;;=M89.30^^28^258^116
 ;;^UTILITY(U,$J,358.3,3758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3758,1,3,0)
 ;;=3^Osteoarthropathy,Hypertrophy of Bone,Unspec Site
 ;;^UTILITY(U,$J,358.3,3758,1,4,0)
 ;;=4^M89.30
 ;;^UTILITY(U,$J,358.3,3758,2)
 ;;=^5014986
 ;;^UTILITY(U,$J,358.3,3759,0)
 ;;=M93.90^^28^258^117
 ;;^UTILITY(U,$J,358.3,3759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3759,1,3,0)
 ;;=3^Osteochondropathy,Unspec Site
 ;;^UTILITY(U,$J,358.3,3759,1,4,0)
 ;;=4^M93.90
 ;;^UTILITY(U,$J,358.3,3759,2)
 ;;=^5015303
 ;;^UTILITY(U,$J,358.3,3760,0)
 ;;=M92.9^^28^258^118
 ;;^UTILITY(U,$J,358.3,3760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3760,1,3,0)
 ;;=3^Osteochondrosis,Juvenile,Unspec
 ;;^UTILITY(U,$J,358.3,3760,1,4,0)
 ;;=4^M92.9
 ;;^UTILITY(U,$J,358.3,3760,2)
 ;;=^5015242
 ;;^UTILITY(U,$J,358.3,3761,0)
 ;;=M42.9^^28^258^119
 ;;^UTILITY(U,$J,358.3,3761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3761,1,3,0)
 ;;=3^Osteochondrosis,Spinal,Unspec
 ;;^UTILITY(U,$J,358.3,3761,1,4,0)
 ;;=4^M42.9
 ;;^UTILITY(U,$J,358.3,3761,2)
 ;;=^5011910
 ;;^UTILITY(U,$J,358.3,3762,0)
 ;;=M89.50^^28^258^120
