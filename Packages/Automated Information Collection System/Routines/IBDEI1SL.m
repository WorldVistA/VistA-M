IBDEI1SL ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31619,1,4,0)
 ;;=4^M06.221
 ;;^UTILITY(U,$J,358.3,31619,2)
 ;;=^5010076
 ;;^UTILITY(U,$J,358.3,31620,0)
 ;;=M06.241^^180^1962^73
 ;;^UTILITY(U,$J,358.3,31620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31620,1,3,0)
 ;;=3^Rheumatoid bursitis, right hand
 ;;^UTILITY(U,$J,358.3,31620,1,4,0)
 ;;=4^M06.241
 ;;^UTILITY(U,$J,358.3,31620,2)
 ;;=^5010082
 ;;^UTILITY(U,$J,358.3,31621,0)
 ;;=M06.251^^180^1962^74
 ;;^UTILITY(U,$J,358.3,31621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31621,1,3,0)
 ;;=3^Rheumatoid bursitis, right hip
 ;;^UTILITY(U,$J,358.3,31621,1,4,0)
 ;;=4^M06.251
 ;;^UTILITY(U,$J,358.3,31621,2)
 ;;=^5010085
 ;;^UTILITY(U,$J,358.3,31622,0)
 ;;=M06.261^^180^1962^75
 ;;^UTILITY(U,$J,358.3,31622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31622,1,3,0)
 ;;=3^Rheumatoid bursitis, right knee
 ;;^UTILITY(U,$J,358.3,31622,1,4,0)
 ;;=4^M06.261
 ;;^UTILITY(U,$J,358.3,31622,2)
 ;;=^5010088
 ;;^UTILITY(U,$J,358.3,31623,0)
 ;;=M06.211^^180^1962^76
 ;;^UTILITY(U,$J,358.3,31623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31623,1,3,0)
 ;;=3^Rheumatoid bursitis, right shoulder
 ;;^UTILITY(U,$J,358.3,31623,1,4,0)
 ;;=4^M06.211
 ;;^UTILITY(U,$J,358.3,31623,2)
 ;;=^5010073
 ;;^UTILITY(U,$J,358.3,31624,0)
 ;;=M06.231^^180^1962^77
 ;;^UTILITY(U,$J,358.3,31624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31624,1,3,0)
 ;;=3^Rheumatoid bursitis, right wrist
 ;;^UTILITY(U,$J,358.3,31624,1,4,0)
 ;;=4^M06.231
 ;;^UTILITY(U,$J,358.3,31624,2)
 ;;=^5010079
 ;;^UTILITY(U,$J,358.3,31625,0)
 ;;=M06.28^^180^1962^78
 ;;^UTILITY(U,$J,358.3,31625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31625,1,3,0)
 ;;=3^Rheumatoid bursitis, vertebrae
 ;;^UTILITY(U,$J,358.3,31625,1,4,0)
 ;;=4^M06.28
 ;;^UTILITY(U,$J,358.3,31625,2)
 ;;=^5010094
 ;;^UTILITY(U,$J,358.3,31626,0)
 ;;=M05.472^^180^1962^79
 ;;^UTILITY(U,$J,358.3,31626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31626,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left ank/ft
 ;;^UTILITY(U,$J,358.3,31626,1,4,0)
 ;;=4^M05.472
 ;;^UTILITY(U,$J,358.3,31626,2)
 ;;=^5009951
 ;;^UTILITY(U,$J,358.3,31627,0)
 ;;=M05.422^^180^1962^80
 ;;^UTILITY(U,$J,358.3,31627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31627,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left elbow
 ;;^UTILITY(U,$J,358.3,31627,1,4,0)
 ;;=4^M05.422
 ;;^UTILITY(U,$J,358.3,31627,2)
 ;;=^5009936
 ;;^UTILITY(U,$J,358.3,31628,0)
 ;;=M05.442^^180^1962^81
 ;;^UTILITY(U,$J,358.3,31628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31628,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left hand
 ;;^UTILITY(U,$J,358.3,31628,1,4,0)
 ;;=4^M05.442
 ;;^UTILITY(U,$J,358.3,31628,2)
 ;;=^5009942
 ;;^UTILITY(U,$J,358.3,31629,0)
 ;;=M05.452^^180^1962^82
 ;;^UTILITY(U,$J,358.3,31629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31629,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left hip
 ;;^UTILITY(U,$J,358.3,31629,1,4,0)
 ;;=4^M05.452
 ;;^UTILITY(U,$J,358.3,31629,2)
 ;;=^5009945
 ;;^UTILITY(U,$J,358.3,31630,0)
 ;;=M05.462^^180^1962^83
 ;;^UTILITY(U,$J,358.3,31630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31630,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left knee
 ;;^UTILITY(U,$J,358.3,31630,1,4,0)
 ;;=4^M05.462
 ;;^UTILITY(U,$J,358.3,31630,2)
 ;;=^5009948
 ;;^UTILITY(U,$J,358.3,31631,0)
 ;;=M05.412^^180^1962^84
 ;;^UTILITY(U,$J,358.3,31631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31631,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left shoulder
 ;;^UTILITY(U,$J,358.3,31631,1,4,0)
 ;;=4^M05.412
 ;;^UTILITY(U,$J,358.3,31631,2)
 ;;=^5009933
