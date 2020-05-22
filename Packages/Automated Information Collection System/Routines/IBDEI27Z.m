IBDEI27Z ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35446,1,3,0)
 ;;=3^Rheumatoid Nodule,Rt Wrist
 ;;^UTILITY(U,$J,358.3,35446,1,4,0)
 ;;=4^M06.331
 ;;^UTILITY(U,$J,358.3,35446,2)
 ;;=^5010103
 ;;^UTILITY(U,$J,358.3,35447,0)
 ;;=M06.38^^137^1802^80
 ;;^UTILITY(U,$J,358.3,35447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35447,1,3,0)
 ;;=3^Rheumatoid Nodule,Vertebrae
 ;;^UTILITY(U,$J,358.3,35447,1,4,0)
 ;;=4^M06.38
 ;;^UTILITY(U,$J,358.3,35447,2)
 ;;=^5010118
 ;;^UTILITY(U,$J,358.3,35448,0)
 ;;=M05.572^^137^1802^81
 ;;^UTILITY(U,$J,358.3,35448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35448,1,3,0)
 ;;=3^Rheumatoid Polyneurop w/ Rheum Arthritis,Lt Ankle/Foot
 ;;^UTILITY(U,$J,358.3,35448,1,4,0)
 ;;=4^M05.572
 ;;^UTILITY(U,$J,358.3,35448,2)
 ;;=^5009974
 ;;^UTILITY(U,$J,358.3,35449,0)
 ;;=M05.522^^137^1802^82
 ;;^UTILITY(U,$J,358.3,35449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35449,1,3,0)
 ;;=3^Rheumatoid Polyneurop w/ Rheum Arthritis,Lt Elbow
 ;;^UTILITY(U,$J,358.3,35449,1,4,0)
 ;;=4^M05.522
 ;;^UTILITY(U,$J,358.3,35449,2)
 ;;=^5009959
 ;;^UTILITY(U,$J,358.3,35450,0)
 ;;=M05.542^^137^1802^83
 ;;^UTILITY(U,$J,358.3,35450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35450,1,3,0)
 ;;=3^Rheumatoid Polyneurop w/ Rheum Arthritis,Lt Hand
 ;;^UTILITY(U,$J,358.3,35450,1,4,0)
 ;;=4^M05.542
 ;;^UTILITY(U,$J,358.3,35450,2)
 ;;=^5009965
 ;;^UTILITY(U,$J,358.3,35451,0)
 ;;=M05.552^^137^1802^84
 ;;^UTILITY(U,$J,358.3,35451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35451,1,3,0)
 ;;=3^Rheumatoid Polyneurop w/ Rheum Arthritis,Lt Hip
 ;;^UTILITY(U,$J,358.3,35451,1,4,0)
 ;;=4^M05.552
 ;;^UTILITY(U,$J,358.3,35451,2)
 ;;=^5009968
 ;;^UTILITY(U,$J,358.3,35452,0)
 ;;=M05.562^^137^1802^85
 ;;^UTILITY(U,$J,358.3,35452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35452,1,3,0)
 ;;=3^Rheumatoid Polyneurop w/ Rheum Arthritis,Lt Knee
 ;;^UTILITY(U,$J,358.3,35452,1,4,0)
 ;;=4^M05.562
 ;;^UTILITY(U,$J,358.3,35452,2)
 ;;=^5009971
 ;;^UTILITY(U,$J,358.3,35453,0)
 ;;=M05.512^^137^1802^86
 ;;^UTILITY(U,$J,358.3,35453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35453,1,3,0)
 ;;=3^Rheumatoid Polyneurop w/ Rheum Arthritis,Lt Shoulder
 ;;^UTILITY(U,$J,358.3,35453,1,4,0)
 ;;=4^M05.512
 ;;^UTILITY(U,$J,358.3,35453,2)
 ;;=^5009956
 ;;^UTILITY(U,$J,358.3,35454,0)
 ;;=M05.532^^137^1802^87
 ;;^UTILITY(U,$J,358.3,35454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35454,1,3,0)
 ;;=3^Rheumatoid Polyneurop w/ Rheum Arthritis,Lt Wrist
 ;;^UTILITY(U,$J,358.3,35454,1,4,0)
 ;;=4^M05.532
 ;;^UTILITY(U,$J,358.3,35454,2)
 ;;=^5009962
 ;;^UTILITY(U,$J,358.3,35455,0)
 ;;=M05.59^^137^1802^88
 ;;^UTILITY(U,$J,358.3,35455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35455,1,3,0)
 ;;=3^Rheumatoid Polyneurop w/ Rheum Arthritis,Mult Sites
 ;;^UTILITY(U,$J,358.3,35455,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,35455,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,35456,0)
 ;;=M05.571^^137^1802^89
 ;;^UTILITY(U,$J,358.3,35456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35456,1,3,0)
 ;;=3^Rheumatoid Polyneurop w/ Rheum Arthritis,Rt Ankle/Foot
 ;;^UTILITY(U,$J,358.3,35456,1,4,0)
 ;;=4^M05.571
 ;;^UTILITY(U,$J,358.3,35456,2)
 ;;=^5009973
 ;;^UTILITY(U,$J,358.3,35457,0)
 ;;=M05.521^^137^1802^90
 ;;^UTILITY(U,$J,358.3,35457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35457,1,3,0)
 ;;=3^Rheumatoid Polyneurop w/ Rheum Arthritis,Rt Elbow
 ;;^UTILITY(U,$J,358.3,35457,1,4,0)
 ;;=4^M05.521
 ;;^UTILITY(U,$J,358.3,35457,2)
 ;;=^5009958
