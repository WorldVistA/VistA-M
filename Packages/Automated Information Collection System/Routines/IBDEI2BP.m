IBDEI2BP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39010,1,4,0)
 ;;=4^M06.261
 ;;^UTILITY(U,$J,358.3,39010,2)
 ;;=^5010088
 ;;^UTILITY(U,$J,358.3,39011,0)
 ;;=M06.211^^180^1991^47
 ;;^UTILITY(U,$J,358.3,39011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39011,1,3,0)
 ;;=3^Rheumatoid bursitis, right shoulder
 ;;^UTILITY(U,$J,358.3,39011,1,4,0)
 ;;=4^M06.211
 ;;^UTILITY(U,$J,358.3,39011,2)
 ;;=^5010073
 ;;^UTILITY(U,$J,358.3,39012,0)
 ;;=M06.231^^180^1991^48
 ;;^UTILITY(U,$J,358.3,39012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39012,1,3,0)
 ;;=3^Rheumatoid bursitis, right wrist
 ;;^UTILITY(U,$J,358.3,39012,1,4,0)
 ;;=4^M06.231
 ;;^UTILITY(U,$J,358.3,39012,2)
 ;;=^5010079
 ;;^UTILITY(U,$J,358.3,39013,0)
 ;;=M06.28^^180^1991^49
 ;;^UTILITY(U,$J,358.3,39013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39013,1,3,0)
 ;;=3^Rheumatoid bursitis, vertebrae
 ;;^UTILITY(U,$J,358.3,39013,1,4,0)
 ;;=4^M06.28
 ;;^UTILITY(U,$J,358.3,39013,2)
 ;;=^5010094
 ;;^UTILITY(U,$J,358.3,39014,0)
 ;;=M05.472^^180^1991^50
 ;;^UTILITY(U,$J,358.3,39014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39014,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left ank/ft
 ;;^UTILITY(U,$J,358.3,39014,1,4,0)
 ;;=4^M05.472
 ;;^UTILITY(U,$J,358.3,39014,2)
 ;;=^5009951
 ;;^UTILITY(U,$J,358.3,39015,0)
 ;;=M05.422^^180^1991^51
 ;;^UTILITY(U,$J,358.3,39015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39015,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left elbow
 ;;^UTILITY(U,$J,358.3,39015,1,4,0)
 ;;=4^M05.422
 ;;^UTILITY(U,$J,358.3,39015,2)
 ;;=^5009936
 ;;^UTILITY(U,$J,358.3,39016,0)
 ;;=M05.442^^180^1991^52
 ;;^UTILITY(U,$J,358.3,39016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39016,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left hand
 ;;^UTILITY(U,$J,358.3,39016,1,4,0)
 ;;=4^M05.442
 ;;^UTILITY(U,$J,358.3,39016,2)
 ;;=^5009942
 ;;^UTILITY(U,$J,358.3,39017,0)
 ;;=M05.452^^180^1991^53
 ;;^UTILITY(U,$J,358.3,39017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39017,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left hip
 ;;^UTILITY(U,$J,358.3,39017,1,4,0)
 ;;=4^M05.452
 ;;^UTILITY(U,$J,358.3,39017,2)
 ;;=^5009945
 ;;^UTILITY(U,$J,358.3,39018,0)
 ;;=M05.462^^180^1991^54
 ;;^UTILITY(U,$J,358.3,39018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39018,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left knee
 ;;^UTILITY(U,$J,358.3,39018,1,4,0)
 ;;=4^M05.462
 ;;^UTILITY(U,$J,358.3,39018,2)
 ;;=^5009948
 ;;^UTILITY(U,$J,358.3,39019,0)
 ;;=M05.412^^180^1991^55
 ;;^UTILITY(U,$J,358.3,39019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39019,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left shoulder
 ;;^UTILITY(U,$J,358.3,39019,1,4,0)
 ;;=4^M05.412
 ;;^UTILITY(U,$J,358.3,39019,2)
 ;;=^5009933
 ;;^UTILITY(U,$J,358.3,39020,0)
 ;;=M05.432^^180^1991^56
 ;;^UTILITY(U,$J,358.3,39020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39020,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of left wrist
 ;;^UTILITY(U,$J,358.3,39020,1,4,0)
 ;;=4^M05.432
 ;;^UTILITY(U,$J,358.3,39020,2)
 ;;=^5009939
 ;;^UTILITY(U,$J,358.3,39021,0)
 ;;=M05.49^^180^1991^57
 ;;^UTILITY(U,$J,358.3,39021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39021,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of multiple sites
 ;;^UTILITY(U,$J,358.3,39021,1,4,0)
 ;;=4^M05.49
 ;;^UTILITY(U,$J,358.3,39021,2)
 ;;=^5009953
 ;;^UTILITY(U,$J,358.3,39022,0)
 ;;=M05.471^^180^1991^58
 ;;^UTILITY(U,$J,358.3,39022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39022,1,3,0)
 ;;=3^Rheumatoid myopathy w rheumatoid arthritis of right ank/ft
