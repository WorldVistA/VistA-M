IBDEI2DV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40048,1,3,0)
 ;;=3^Amputation,Traumatic,Left Great Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,40048,1,4,0)
 ;;=4^S98.112A
 ;;^UTILITY(U,$J,358.3,40048,2)
 ;;=^5046266
 ;;^UTILITY(U,$J,358.3,40049,0)
 ;;=S98.312A^^186^2076^58
 ;;^UTILITY(U,$J,358.3,40049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40049,1,3,0)
 ;;=3^Amputation,Traumatic,Left Midfoot,Init Encntr
 ;;^UTILITY(U,$J,358.3,40049,1,4,0)
 ;;=4^S98.312A
 ;;^UTILITY(U,$J,358.3,40049,2)
 ;;=^5046320
 ;;^UTILITY(U,$J,358.3,40050,0)
 ;;=S48.912A^^186^2076^59
 ;;^UTILITY(U,$J,358.3,40050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40050,1,3,0)
 ;;=3^Amputation,Traumatic,Left Shoulder/Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,40050,1,4,0)
 ;;=4^S48.912A
 ;;^UTILITY(U,$J,358.3,40050,2)
 ;;=^5028326
 ;;^UTILITY(U,$J,358.3,40051,0)
 ;;=S98.132A^^186^2076^48
 ;;^UTILITY(U,$J,358.3,40051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40051,1,3,0)
 ;;=3^Amputation,Traumatic,Left 1 Lesser Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,40051,1,4,0)
 ;;=4^S98.132A
 ;;^UTILITY(U,$J,358.3,40051,2)
 ;;=^5046284
 ;;^UTILITY(U,$J,358.3,40052,0)
 ;;=S98.212A^^186^2076^49
 ;;^UTILITY(U,$J,358.3,40052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40052,1,3,0)
 ;;=3^Amputation,Traumatic,Left 2 or More Lesser Toes,Init Encntr
 ;;^UTILITY(U,$J,358.3,40052,1,4,0)
 ;;=4^S98.212A
 ;;^UTILITY(U,$J,358.3,40052,2)
 ;;=^5046302
 ;;^UTILITY(U,$J,358.3,40053,0)
 ;;=S68.111A^^186^2076^53
 ;;^UTILITY(U,$J,358.3,40053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40053,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,40053,1,4,0)
 ;;=4^S68.111A
 ;;^UTILITY(U,$J,358.3,40053,2)
 ;;=^5036642
 ;;^UTILITY(U,$J,358.3,40054,0)
 ;;=S68.117A^^186^2076^54
 ;;^UTILITY(U,$J,358.3,40054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40054,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,40054,1,4,0)
 ;;=4^S68.117A
 ;;^UTILITY(U,$J,358.3,40054,2)
 ;;=^5036660
 ;;^UTILITY(U,$J,358.3,40055,0)
 ;;=S68.113A^^186^2076^55
 ;;^UTILITY(U,$J,358.3,40055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40055,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,40055,1,4,0)
 ;;=4^S68.113A
 ;;^UTILITY(U,$J,358.3,40055,2)
 ;;=^5036648
 ;;^UTILITY(U,$J,358.3,40056,0)
 ;;=S68.115A^^186^2076^56
 ;;^UTILITY(U,$J,358.3,40056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40056,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,40056,1,4,0)
 ;;=4^S68.115A
 ;;^UTILITY(U,$J,358.3,40056,2)
 ;;=^5036654
 ;;^UTILITY(U,$J,358.3,40057,0)
 ;;=S68.012A^^186^2076^57
 ;;^UTILITY(U,$J,358.3,40057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40057,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,40057,1,4,0)
 ;;=4^S68.012A
 ;;^UTILITY(U,$J,358.3,40057,2)
 ;;=^5036624
 ;;^UTILITY(U,$J,358.3,40058,0)
 ;;=S68.611A^^186^2076^60
 ;;^UTILITY(U,$J,358.3,40058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40058,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,40058,1,4,0)
 ;;=4^S68.611A
 ;;^UTILITY(U,$J,358.3,40058,2)
 ;;=^5036738
 ;;^UTILITY(U,$J,358.3,40059,0)
 ;;=S68.617A^^186^2076^61
 ;;^UTILITY(U,$J,358.3,40059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40059,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,40059,1,4,0)
 ;;=4^S68.617A
 ;;^UTILITY(U,$J,358.3,40059,2)
 ;;=^5036756
 ;;^UTILITY(U,$J,358.3,40060,0)
 ;;=S68.613A^^186^2076^62
