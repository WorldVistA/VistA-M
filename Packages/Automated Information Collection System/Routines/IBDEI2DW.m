IBDEI2DW ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40060,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,40060,1,4,0)
 ;;=4^S68.613A
 ;;^UTILITY(U,$J,358.3,40060,2)
 ;;=^5036744
 ;;^UTILITY(U,$J,358.3,40061,0)
 ;;=S68.615A^^186^2076^63
 ;;^UTILITY(U,$J,358.3,40061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40061,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,40061,1,4,0)
 ;;=4^S68.615A
 ;;^UTILITY(U,$J,358.3,40061,2)
 ;;=^5036750
 ;;^UTILITY(U,$J,358.3,40062,0)
 ;;=S68.512A^^186^2076^64
 ;;^UTILITY(U,$J,358.3,40062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40062,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,40062,1,4,0)
 ;;=4^S68.512A
 ;;^UTILITY(U,$J,358.3,40062,2)
 ;;=^5036720
 ;;^UTILITY(U,$J,358.3,40063,0)
 ;;=S58.111A^^186^2076^67
 ;;^UTILITY(U,$J,358.3,40063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40063,1,3,0)
 ;;=3^Amputation,Traumatic,Right Arm Between Elbow & Wrist Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,40063,1,4,0)
 ;;=4^S58.111A
 ;;^UTILITY(U,$J,358.3,40063,2)
 ;;=^5031925
 ;;^UTILITY(U,$J,358.3,40064,0)
 ;;=S98.131A^^186^2076^65
 ;;^UTILITY(U,$J,358.3,40064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40064,1,3,0)
 ;;=3^Amputation,Traumatic,Right 1 Lesser Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,40064,1,4,0)
 ;;=4^S98.131A
 ;;^UTILITY(U,$J,358.3,40064,2)
 ;;=^5046281
 ;;^UTILITY(U,$J,358.3,40065,0)
 ;;=S98.011A^^186^2076^68
 ;;^UTILITY(U,$J,358.3,40065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40065,1,3,0)
 ;;=3^Amputation,Traumatic,Right Foot at Ankle Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,40065,1,4,0)
 ;;=4^S98.011A
 ;;^UTILITY(U,$J,358.3,40065,2)
 ;;=^5046245
 ;;^UTILITY(U,$J,358.3,40066,0)
 ;;=S98.911A^^186^2076^69
 ;;^UTILITY(U,$J,358.3,40066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40066,1,3,0)
 ;;=3^Amputation,Traumatic,Right Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,40066,1,4,0)
 ;;=4^S98.911A
 ;;^UTILITY(U,$J,358.3,40066,2)
 ;;=^5046335
 ;;^UTILITY(U,$J,358.3,40067,0)
 ;;=S98.111A^^186^2076^70
 ;;^UTILITY(U,$J,358.3,40067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40067,1,3,0)
 ;;=3^Amputation,Traumatic,Right Great Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,40067,1,4,0)
 ;;=4^S98.111A
 ;;^UTILITY(U,$J,358.3,40067,2)
 ;;=^5046263
 ;;^UTILITY(U,$J,358.3,40068,0)
 ;;=S98.311A^^186^2076^76
 ;;^UTILITY(U,$J,358.3,40068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40068,1,3,0)
 ;;=3^Amputation,Traumatic,Right Midfoot,Init Encntr
 ;;^UTILITY(U,$J,358.3,40068,1,4,0)
 ;;=4^S98.311A
 ;;^UTILITY(U,$J,358.3,40068,2)
 ;;=^5046317
 ;;^UTILITY(U,$J,358.3,40069,0)
 ;;=S48.911A^^186^2076^77
 ;;^UTILITY(U,$J,358.3,40069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40069,1,3,0)
 ;;=3^Amputation,Traumatic,Right Shoulder/Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,40069,1,4,0)
 ;;=4^S48.911A
 ;;^UTILITY(U,$J,358.3,40069,2)
 ;;=^5028323
 ;;^UTILITY(U,$J,358.3,40070,0)
 ;;=S98.211A^^186^2076^66
 ;;^UTILITY(U,$J,358.3,40070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40070,1,3,0)
 ;;=3^Amputation,Traumatic,Right 2 or More Lesser Toes,Init Encntr
 ;;^UTILITY(U,$J,358.3,40070,1,4,0)
 ;;=4^S98.211A
 ;;^UTILITY(U,$J,358.3,40070,2)
 ;;=^5046299
 ;;^UTILITY(U,$J,358.3,40071,0)
 ;;=S68.110A^^186^2076^71
 ;;^UTILITY(U,$J,358.3,40071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40071,1,3,0)
 ;;=3^Amputation,Traumatic,Right MCP Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,40071,1,4,0)
 ;;=4^S68.110A
 ;;^UTILITY(U,$J,358.3,40071,2)
 ;;=^5036639
