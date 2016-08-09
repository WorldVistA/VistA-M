IBDEI0US ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30967,1,3,0)
 ;;=3^Amputation,Traumatic,Left Foot at Ankle Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,30967,1,4,0)
 ;;=4^S98.012A
 ;;^UTILITY(U,$J,358.3,30967,2)
 ;;=^5046248
 ;;^UTILITY(U,$J,358.3,30968,0)
 ;;=S98.112A^^116^1526^52
 ;;^UTILITY(U,$J,358.3,30968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30968,1,3,0)
 ;;=3^Amputation,Traumatic,Left Great Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,30968,1,4,0)
 ;;=4^S98.112A
 ;;^UTILITY(U,$J,358.3,30968,2)
 ;;=^5046266
 ;;^UTILITY(U,$J,358.3,30969,0)
 ;;=S98.312A^^116^1526^58
 ;;^UTILITY(U,$J,358.3,30969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30969,1,3,0)
 ;;=3^Amputation,Traumatic,Left Midfoot,Init Encntr
 ;;^UTILITY(U,$J,358.3,30969,1,4,0)
 ;;=4^S98.312A
 ;;^UTILITY(U,$J,358.3,30969,2)
 ;;=^5046320
 ;;^UTILITY(U,$J,358.3,30970,0)
 ;;=S48.912A^^116^1526^59
 ;;^UTILITY(U,$J,358.3,30970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30970,1,3,0)
 ;;=3^Amputation,Traumatic,Left Shoulder/Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,30970,1,4,0)
 ;;=4^S48.912A
 ;;^UTILITY(U,$J,358.3,30970,2)
 ;;=^5028326
 ;;^UTILITY(U,$J,358.3,30971,0)
 ;;=S98.132A^^116^1526^48
 ;;^UTILITY(U,$J,358.3,30971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30971,1,3,0)
 ;;=3^Amputation,Traumatic,Left 1 Lesser Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,30971,1,4,0)
 ;;=4^S98.132A
 ;;^UTILITY(U,$J,358.3,30971,2)
 ;;=^5046284
 ;;^UTILITY(U,$J,358.3,30972,0)
 ;;=S98.212A^^116^1526^49
 ;;^UTILITY(U,$J,358.3,30972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30972,1,3,0)
 ;;=3^Amputation,Traumatic,Left 2 or More Lesser Toes,Init Encntr
 ;;^UTILITY(U,$J,358.3,30972,1,4,0)
 ;;=4^S98.212A
 ;;^UTILITY(U,$J,358.3,30972,2)
 ;;=^5046302
 ;;^UTILITY(U,$J,358.3,30973,0)
 ;;=S68.111A^^116^1526^53
 ;;^UTILITY(U,$J,358.3,30973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30973,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,30973,1,4,0)
 ;;=4^S68.111A
 ;;^UTILITY(U,$J,358.3,30973,2)
 ;;=^5036642
 ;;^UTILITY(U,$J,358.3,30974,0)
 ;;=S68.117A^^116^1526^54
 ;;^UTILITY(U,$J,358.3,30974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30974,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,30974,1,4,0)
 ;;=4^S68.117A
 ;;^UTILITY(U,$J,358.3,30974,2)
 ;;=^5036660
 ;;^UTILITY(U,$J,358.3,30975,0)
 ;;=S68.113A^^116^1526^55
 ;;^UTILITY(U,$J,358.3,30975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30975,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,30975,1,4,0)
 ;;=4^S68.113A
 ;;^UTILITY(U,$J,358.3,30975,2)
 ;;=^5036648
 ;;^UTILITY(U,$J,358.3,30976,0)
 ;;=S68.115A^^116^1526^56
 ;;^UTILITY(U,$J,358.3,30976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30976,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,30976,1,4,0)
 ;;=4^S68.115A
 ;;^UTILITY(U,$J,358.3,30976,2)
 ;;=^5036654
 ;;^UTILITY(U,$J,358.3,30977,0)
 ;;=S68.012A^^116^1526^57
 ;;^UTILITY(U,$J,358.3,30977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30977,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,30977,1,4,0)
 ;;=4^S68.012A
 ;;^UTILITY(U,$J,358.3,30977,2)
 ;;=^5036624
 ;;^UTILITY(U,$J,358.3,30978,0)
 ;;=S68.611A^^116^1526^60
 ;;^UTILITY(U,$J,358.3,30978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30978,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,30978,1,4,0)
 ;;=4^S68.611A
 ;;^UTILITY(U,$J,358.3,30978,2)
 ;;=^5036738
 ;;^UTILITY(U,$J,358.3,30979,0)
 ;;=S68.617A^^116^1526^61
 ;;^UTILITY(U,$J,358.3,30979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30979,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,30979,1,4,0)
 ;;=4^S68.617A
 ;;^UTILITY(U,$J,358.3,30979,2)
 ;;=^5036756
 ;;^UTILITY(U,$J,358.3,30980,0)
 ;;=S68.613A^^116^1526^62
 ;;^UTILITY(U,$J,358.3,30980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30980,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,30980,1,4,0)
 ;;=4^S68.613A
 ;;^UTILITY(U,$J,358.3,30980,2)
 ;;=^5036744
 ;;^UTILITY(U,$J,358.3,30981,0)
 ;;=S68.615A^^116^1526^63
 ;;^UTILITY(U,$J,358.3,30981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30981,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,30981,1,4,0)
 ;;=4^S68.615A
 ;;^UTILITY(U,$J,358.3,30981,2)
 ;;=^5036750
 ;;^UTILITY(U,$J,358.3,30982,0)
 ;;=S68.512A^^116^1526^64
 ;;^UTILITY(U,$J,358.3,30982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30982,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,30982,1,4,0)
 ;;=4^S68.512A
 ;;^UTILITY(U,$J,358.3,30982,2)
 ;;=^5036720
 ;;^UTILITY(U,$J,358.3,30983,0)
 ;;=S58.111A^^116^1526^67
 ;;^UTILITY(U,$J,358.3,30983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30983,1,3,0)
 ;;=3^Amputation,Traumatic,Right Arm Between Elbow & Wrist Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,30983,1,4,0)
 ;;=4^S58.111A
 ;;^UTILITY(U,$J,358.3,30983,2)
 ;;=^5031925
 ;;^UTILITY(U,$J,358.3,30984,0)
 ;;=S98.131A^^116^1526^65
 ;;^UTILITY(U,$J,358.3,30984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30984,1,3,0)
 ;;=3^Amputation,Traumatic,Right 1 Lesser Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,30984,1,4,0)
 ;;=4^S98.131A
 ;;^UTILITY(U,$J,358.3,30984,2)
 ;;=^5046281
 ;;^UTILITY(U,$J,358.3,30985,0)
 ;;=S98.011A^^116^1526^68
 ;;^UTILITY(U,$J,358.3,30985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30985,1,3,0)
 ;;=3^Amputation,Traumatic,Right Foot at Ankle Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,30985,1,4,0)
 ;;=4^S98.011A
 ;;^UTILITY(U,$J,358.3,30985,2)
 ;;=^5046245
 ;;^UTILITY(U,$J,358.3,30986,0)
 ;;=S98.911A^^116^1526^69
 ;;^UTILITY(U,$J,358.3,30986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30986,1,3,0)
 ;;=3^Amputation,Traumatic,Right Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,30986,1,4,0)
 ;;=4^S98.911A
 ;;^UTILITY(U,$J,358.3,30986,2)
 ;;=^5046335
 ;;^UTILITY(U,$J,358.3,30987,0)
 ;;=S98.111A^^116^1526^70
 ;;^UTILITY(U,$J,358.3,30987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30987,1,3,0)
 ;;=3^Amputation,Traumatic,Right Great Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,30987,1,4,0)
 ;;=4^S98.111A
 ;;^UTILITY(U,$J,358.3,30987,2)
 ;;=^5046263
 ;;^UTILITY(U,$J,358.3,30988,0)
 ;;=S98.311A^^116^1526^76
 ;;^UTILITY(U,$J,358.3,30988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30988,1,3,0)
 ;;=3^Amputation,Traumatic,Right Midfoot,Init Encntr
 ;;^UTILITY(U,$J,358.3,30988,1,4,0)
 ;;=4^S98.311A
 ;;^UTILITY(U,$J,358.3,30988,2)
 ;;=^5046317
 ;;^UTILITY(U,$J,358.3,30989,0)
 ;;=S48.911A^^116^1526^77
 ;;^UTILITY(U,$J,358.3,30989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30989,1,3,0)
 ;;=3^Amputation,Traumatic,Right Shoulder/Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,30989,1,4,0)
 ;;=4^S48.911A
 ;;^UTILITY(U,$J,358.3,30989,2)
 ;;=^5028323
 ;;^UTILITY(U,$J,358.3,30990,0)
 ;;=S98.211A^^116^1526^66
 ;;^UTILITY(U,$J,358.3,30990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30990,1,3,0)
 ;;=3^Amputation,Traumatic,Right 2 or More Lesser Toes,Init Encntr
 ;;^UTILITY(U,$J,358.3,30990,1,4,0)
 ;;=4^S98.211A
 ;;^UTILITY(U,$J,358.3,30990,2)
 ;;=^5046299
 ;;^UTILITY(U,$J,358.3,30991,0)
 ;;=S68.110A^^116^1526^71
 ;;^UTILITY(U,$J,358.3,30991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30991,1,3,0)
 ;;=3^Amputation,Traumatic,Right MCP Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,30991,1,4,0)
 ;;=4^S68.110A
 ;;^UTILITY(U,$J,358.3,30991,2)
 ;;=^5036639
 ;;^UTILITY(U,$J,358.3,30992,0)
 ;;=S68.116A^^116^1526^72
 ;;^UTILITY(U,$J,358.3,30992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30992,1,3,0)
 ;;=3^Amputation,Traumatic,Right MCP Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,30992,1,4,0)
 ;;=4^S68.116A
