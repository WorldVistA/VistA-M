IBDEI1FX ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23036,1,4,0)
 ;;=4^T83.61XA
 ;;^UTILITY(U,$J,358.3,23036,2)
 ;;=^5140162
 ;;^UTILITY(U,$J,358.3,23037,0)
 ;;=T83.62XA^^105^1166^78
 ;;^UTILITY(U,$J,358.3,23037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23037,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Implanted Testicular Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,23037,1,4,0)
 ;;=4^T83.62XA
 ;;^UTILITY(U,$J,358.3,23037,2)
 ;;=^5140165
 ;;^UTILITY(U,$J,358.3,23038,0)
 ;;=T83.69XA^^105^1166^100
 ;;^UTILITY(U,$J,358.3,23038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23038,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Oth Prosthetic Device/Implant/Graft in Genital Tract,Init Encntr
 ;;^UTILITY(U,$J,358.3,23038,1,4,0)
 ;;=4^T83.69XA
 ;;^UTILITY(U,$J,358.3,23038,2)
 ;;=^5140168
 ;;^UTILITY(U,$J,358.3,23039,0)
 ;;=T83.510A^^105^1166^67
 ;;^UTILITY(U,$J,358.3,23039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23039,1,3,0)
 ;;=3^Infect d/t Cystostomy Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,23039,1,4,0)
 ;;=4^T83.510A
 ;;^UTILITY(U,$J,358.3,23039,2)
 ;;=^5140135
 ;;^UTILITY(U,$J,358.3,23040,0)
 ;;=T83.510S^^105^1166^68
 ;;^UTILITY(U,$J,358.3,23040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23040,1,3,0)
 ;;=3^Infect d/t Cystostomy Catheter,Sequela
 ;;^UTILITY(U,$J,358.3,23040,1,4,0)
 ;;=4^T83.510S
 ;;^UTILITY(U,$J,358.3,23040,2)
 ;;=^5140137
 ;;^UTILITY(U,$J,358.3,23041,0)
 ;;=T83.510D^^105^1166^66
 ;;^UTILITY(U,$J,358.3,23041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23041,1,3,0)
 ;;=3^Infect d/t Cystostomy Catheter,Healing/Subs
 ;;^UTILITY(U,$J,358.3,23041,1,4,0)
 ;;=4^T83.510D
 ;;^UTILITY(U,$J,358.3,23041,2)
 ;;=^5140136
 ;;^UTILITY(U,$J,358.3,23042,0)
 ;;=T83.511A^^105^1166^69
 ;;^UTILITY(U,$J,358.3,23042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23042,1,3,0)
 ;;=3^Infect d/t Indwelling Urethral Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,23042,1,4,0)
 ;;=4^T83.511A
 ;;^UTILITY(U,$J,358.3,23042,2)
 ;;=^5140138
 ;;^UTILITY(U,$J,358.3,23043,0)
 ;;=T83.511D^^105^1166^70
 ;;^UTILITY(U,$J,358.3,23043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23043,1,3,0)
 ;;=3^Infect d/t Indwelling Urethral Catheter,Healing/Subs
 ;;^UTILITY(U,$J,358.3,23043,1,4,0)
 ;;=4^T83.511D
 ;;^UTILITY(U,$J,358.3,23043,2)
 ;;=^5140139
 ;;^UTILITY(U,$J,358.3,23044,0)
 ;;=T83.511S^^105^1166^71
 ;;^UTILITY(U,$J,358.3,23044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23044,1,3,0)
 ;;=3^Infect d/t Indwelling Urethral Catheter,Sequela
 ;;^UTILITY(U,$J,358.3,23044,1,4,0)
 ;;=4^T83.511S
 ;;^UTILITY(U,$J,358.3,23044,2)
 ;;=^5140140
 ;;^UTILITY(U,$J,358.3,23045,0)
 ;;=T83.512A^^105^1166^73
 ;;^UTILITY(U,$J,358.3,23045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23045,1,3,0)
 ;;=3^Infect d/t Nephrostomy Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,23045,1,4,0)
 ;;=4^T83.512A
 ;;^UTILITY(U,$J,358.3,23045,2)
 ;;=^5140141
 ;;^UTILITY(U,$J,358.3,23046,0)
 ;;=T83.512D^^105^1166^72
 ;;^UTILITY(U,$J,358.3,23046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23046,1,3,0)
 ;;=3^Infect d/t Nephrostomy Catheter,Healing/Subs
 ;;^UTILITY(U,$J,358.3,23046,1,4,0)
 ;;=4^T83.512D
 ;;^UTILITY(U,$J,358.3,23046,2)
 ;;=^5140142
 ;;^UTILITY(U,$J,358.3,23047,0)
 ;;=T83.512S^^105^1166^74
 ;;^UTILITY(U,$J,358.3,23047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23047,1,3,0)
 ;;=3^Infect d/t Nephrostomy Catheter,Sequela
 ;;^UTILITY(U,$J,358.3,23047,1,4,0)
 ;;=4^T83.512S
 ;;^UTILITY(U,$J,358.3,23047,2)
 ;;=^5140143
