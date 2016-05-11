IBDEI080 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3446,1,3,0)
 ;;=3^Myopathy,Periodic Paralysis
 ;;^UTILITY(U,$J,358.3,3446,1,4,0)
 ;;=4^G72.3
 ;;^UTILITY(U,$J,358.3,3446,2)
 ;;=^335326
 ;;^UTILITY(U,$J,358.3,3447,0)
 ;;=G72.9^^18^219^101
 ;;^UTILITY(U,$J,358.3,3447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3447,1,3,0)
 ;;=3^Myopathy,Unspec
 ;;^UTILITY(U,$J,358.3,3447,1,4,0)
 ;;=4^G72.9
 ;;^UTILITY(U,$J,358.3,3447,2)
 ;;=^5004101
 ;;^UTILITY(U,$J,358.3,3448,0)
 ;;=M60.9^^18^219^102
 ;;^UTILITY(U,$J,358.3,3448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3448,1,3,0)
 ;;=3^Myositis,Unspec
 ;;^UTILITY(U,$J,358.3,3448,1,4,0)
 ;;=4^M60.9
 ;;^UTILITY(U,$J,358.3,3448,2)
 ;;=^5012409
 ;;^UTILITY(U,$J,358.3,3449,0)
 ;;=M79.2^^18^219^103
 ;;^UTILITY(U,$J,358.3,3449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3449,1,3,0)
 ;;=3^Neuralgia & Neuritis,Unspec
 ;;^UTILITY(U,$J,358.3,3449,1,4,0)
 ;;=4^M79.2
 ;;^UTILITY(U,$J,358.3,3449,2)
 ;;=^5013322
 ;;^UTILITY(U,$J,358.3,3450,0)
 ;;=M54.81^^18^219^104
 ;;^UTILITY(U,$J,358.3,3450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3450,1,3,0)
 ;;=3^Neuralgia,Occipital
 ;;^UTILITY(U,$J,358.3,3450,1,4,0)
 ;;=4^M54.81
 ;;^UTILITY(U,$J,358.3,3450,2)
 ;;=^5012312
 ;;^UTILITY(U,$J,358.3,3451,0)
 ;;=M89.70^^18^219^106
 ;;^UTILITY(U,$J,358.3,3451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3451,1,3,0)
 ;;=3^Osseous Defect,Major,Unspec Site
 ;;^UTILITY(U,$J,358.3,3451,1,4,0)
 ;;=4^M89.70
 ;;^UTILITY(U,$J,358.3,3451,2)
 ;;=^5015085
 ;;^UTILITY(U,$J,358.3,3452,0)
 ;;=M79.81^^18^219^105
 ;;^UTILITY(U,$J,358.3,3452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3452,1,3,0)
 ;;=3^Nontraumatic Hematoma,Soft Tissue
 ;;^UTILITY(U,$J,358.3,3452,1,4,0)
 ;;=4^M79.81
 ;;^UTILITY(U,$J,358.3,3452,2)
 ;;=^5013356
 ;;^UTILITY(U,$J,358.3,3453,0)
 ;;=M88.9^^18^219^107
 ;;^UTILITY(U,$J,358.3,3453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3453,1,3,0)
 ;;=3^Osteitis Deformans,Unspec Bone
 ;;^UTILITY(U,$J,358.3,3453,1,4,0)
 ;;=4^M88.9
 ;;^UTILITY(U,$J,358.3,3453,2)
 ;;=^5014899
 ;;^UTILITY(U,$J,358.3,3454,0)
 ;;=M18.9^^18^219^108
 ;;^UTILITY(U,$J,358.3,3454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3454,1,3,0)
 ;;=3^Osteoarthritis,1st Carpometacarpal Joint,Unspec
 ;;^UTILITY(U,$J,358.3,3454,1,4,0)
 ;;=4^M18.9
 ;;^UTILITY(U,$J,358.3,3454,2)
 ;;=^5010807
 ;;^UTILITY(U,$J,358.3,3455,0)
 ;;=M16.9^^18^219^109
 ;;^UTILITY(U,$J,358.3,3455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3455,1,3,0)
 ;;=3^Osteoarthritis,Hip,Unspec
 ;;^UTILITY(U,$J,358.3,3455,1,4,0)
 ;;=4^M16.9
 ;;^UTILITY(U,$J,358.3,3455,2)
 ;;=^5010783
 ;;^UTILITY(U,$J,358.3,3456,0)
 ;;=M17.9^^18^219^110
 ;;^UTILITY(U,$J,358.3,3456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3456,1,3,0)
 ;;=3^Osteoarthritis,Knee,Unspec
 ;;^UTILITY(U,$J,358.3,3456,1,4,0)
 ;;=4^M17.9
 ;;^UTILITY(U,$J,358.3,3456,2)
 ;;=^5010794
 ;;^UTILITY(U,$J,358.3,3457,0)
 ;;=M19.92^^18^219^111
 ;;^UTILITY(U,$J,358.3,3457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3457,1,3,0)
 ;;=3^Osteoarthritis,Post-Traumatic,Unspec Site
 ;;^UTILITY(U,$J,358.3,3457,1,4,0)
 ;;=4^M19.92
 ;;^UTILITY(U,$J,358.3,3457,2)
 ;;=^5010855
 ;;^UTILITY(U,$J,358.3,3458,0)
 ;;=M19.91^^18^219^112
 ;;^UTILITY(U,$J,358.3,3458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3458,1,3,0)
 ;;=3^Osteoarthritis,Primary,Unspec Site
 ;;^UTILITY(U,$J,358.3,3458,1,4,0)
 ;;=4^M19.91
 ;;^UTILITY(U,$J,358.3,3458,2)
 ;;=^5010854
 ;;^UTILITY(U,$J,358.3,3459,0)
 ;;=M19.93^^18^219^113
 ;;^UTILITY(U,$J,358.3,3459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3459,1,3,0)
 ;;=3^Osteoarthritis,Secondary,Unspec Site
