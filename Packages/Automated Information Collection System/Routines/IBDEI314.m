IBDEI314 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48370,1,3,0)
 ;;=3^Infection d/t Cystostomy Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,48370,1,4,0)
 ;;=4^T83.510D
 ;;^UTILITY(U,$J,358.3,48370,2)
 ;;=^5140136
 ;;^UTILITY(U,$J,358.3,48371,0)
 ;;=T83.510S^^185^2420^49
 ;;^UTILITY(U,$J,358.3,48371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48371,1,3,0)
 ;;=3^Infection d/t Cystostomy Catheter,Sequela
 ;;^UTILITY(U,$J,358.3,48371,1,4,0)
 ;;=4^T83.510S
 ;;^UTILITY(U,$J,358.3,48371,2)
 ;;=^5140137
 ;;^UTILITY(U,$J,358.3,48372,0)
 ;;=T83.511A^^185^2420^51
 ;;^UTILITY(U,$J,358.3,48372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48372,1,3,0)
 ;;=3^Infection d/t Indwelling Urethral Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,48372,1,4,0)
 ;;=4^T83.511A
 ;;^UTILITY(U,$J,358.3,48372,2)
 ;;=^5140138
 ;;^UTILITY(U,$J,358.3,48373,0)
 ;;=T83.511D^^185^2420^52
 ;;^UTILITY(U,$J,358.3,48373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48373,1,3,0)
 ;;=3^Infection d/t Indwelling Urethral Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,48373,1,4,0)
 ;;=4^T83.511D
 ;;^UTILITY(U,$J,358.3,48373,2)
 ;;=^5140139
 ;;^UTILITY(U,$J,358.3,48374,0)
 ;;=T83.511S^^185^2420^53
 ;;^UTILITY(U,$J,358.3,48374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48374,1,3,0)
 ;;=3^Infection d/t Indwelling Urethral Catheter,Sequela
 ;;^UTILITY(U,$J,358.3,48374,1,4,0)
 ;;=4^T83.511S
 ;;^UTILITY(U,$J,358.3,48374,2)
 ;;=^5140140
 ;;^UTILITY(U,$J,358.3,48375,0)
 ;;=T83.512A^^185^2420^54
 ;;^UTILITY(U,$J,358.3,48375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48375,1,3,0)
 ;;=3^Infection d/t Nephrostomy Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,48375,1,4,0)
 ;;=4^T83.512A
 ;;^UTILITY(U,$J,358.3,48375,2)
 ;;=^5140141
 ;;^UTILITY(U,$J,358.3,48376,0)
 ;;=T83.512D^^185^2420^56
 ;;^UTILITY(U,$J,358.3,48376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48376,1,3,0)
 ;;=3^Infection d/t Nephrostomy Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,48376,1,4,0)
 ;;=4^T83.512D
 ;;^UTILITY(U,$J,358.3,48376,2)
 ;;=^5140142
 ;;^UTILITY(U,$J,358.3,48377,0)
 ;;=T83.512S^^185^2420^55
 ;;^UTILITY(U,$J,358.3,48377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48377,1,3,0)
 ;;=3^Infection d/t Nephrostomy Catheter,Sequela
 ;;^UTILITY(U,$J,358.3,48377,1,4,0)
 ;;=4^T83.512S
 ;;^UTILITY(U,$J,358.3,48377,2)
 ;;=^5140143
 ;;^UTILITY(U,$J,358.3,48378,0)
 ;;=R97.20^^185^2420^28
 ;;^UTILITY(U,$J,358.3,48378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48378,1,3,0)
 ;;=3^Elevated PSA
 ;;^UTILITY(U,$J,358.3,48378,1,4,0)
 ;;=4^R97.20
 ;;^UTILITY(U,$J,358.3,48378,2)
 ;;=^334262
 ;;^UTILITY(U,$J,358.3,48379,0)
 ;;=R97.21^^185^2420^29
 ;;^UTILITY(U,$J,358.3,48379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48379,1,3,0)
 ;;=3^Elevated PSA Following Trtmnt for Prostate Cancer
 ;;^UTILITY(U,$J,358.3,48379,1,4,0)
 ;;=4^R97.21
 ;;^UTILITY(U,$J,358.3,48379,2)
 ;;=^5139228
 ;;^UTILITY(U,$J,358.3,48380,0)
 ;;=N35.911^^185^2420^109
 ;;^UTILITY(U,$J,358.3,48380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48380,1,3,0)
 ;;=3^Urethral Stricture,Male,Unspec
 ;;^UTILITY(U,$J,358.3,48380,1,4,0)
 ;;=4^N35.911
 ;;^UTILITY(U,$J,358.3,48380,2)
 ;;=^5157407
 ;;^UTILITY(U,$J,358.3,48381,0)
 ;;=N35.92^^185^2420^108
 ;;^UTILITY(U,$J,358.3,48381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48381,1,3,0)
 ;;=3^Urethral Stricture,Female,Unspec
 ;;^UTILITY(U,$J,358.3,48381,1,4,0)
 ;;=4^N35.92
