IBDEI1FM ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22913,0)
 ;;=T84.610A^^105^1166^80
 ;;^UTILITY(U,$J,358.3,22913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22913,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Right Humerus,Init Encntr
 ;;^UTILITY(U,$J,358.3,22913,1,4,0)
 ;;=4^T84.610A
 ;;^UTILITY(U,$J,358.3,22913,2)
 ;;=^5055403
 ;;^UTILITY(U,$J,358.3,22914,0)
 ;;=T84.611A^^105^1166^81
 ;;^UTILITY(U,$J,358.3,22914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22914,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Left Humerus,Init Encntr
 ;;^UTILITY(U,$J,358.3,22914,1,4,0)
 ;;=4^T84.611A
 ;;^UTILITY(U,$J,358.3,22914,2)
 ;;=^5055406
 ;;^UTILITY(U,$J,358.3,22915,0)
 ;;=T84.612A^^105^1166^82
 ;;^UTILITY(U,$J,358.3,22915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22915,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Right Radius,Init Encntr
 ;;^UTILITY(U,$J,358.3,22915,1,4,0)
 ;;=4^T84.612A
 ;;^UTILITY(U,$J,358.3,22915,2)
 ;;=^5055409
 ;;^UTILITY(U,$J,358.3,22916,0)
 ;;=T84.613A^^105^1166^83
 ;;^UTILITY(U,$J,358.3,22916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22916,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Left Radius,Init Encntr
 ;;^UTILITY(U,$J,358.3,22916,1,4,0)
 ;;=4^T84.613A
 ;;^UTILITY(U,$J,358.3,22916,2)
 ;;=^5055412
 ;;^UTILITY(U,$J,358.3,22917,0)
 ;;=T84.614A^^105^1166^84
 ;;^UTILITY(U,$J,358.3,22917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22917,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Right Ulna,Init Encntr
 ;;^UTILITY(U,$J,358.3,22917,1,4,0)
 ;;=4^T84.614A
 ;;^UTILITY(U,$J,358.3,22917,2)
 ;;=^5055415
 ;;^UTILITY(U,$J,358.3,22918,0)
 ;;=T84.615A^^105^1166^85
 ;;^UTILITY(U,$J,358.3,22918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22918,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Left Ulna,Init Encntr
 ;;^UTILITY(U,$J,358.3,22918,1,4,0)
 ;;=4^T84.615A
 ;;^UTILITY(U,$J,358.3,22918,2)
 ;;=^5055418
 ;;^UTILITY(U,$J,358.3,22919,0)
 ;;=T84.620A^^105^1166^86
 ;;^UTILITY(U,$J,358.3,22919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22919,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Right Femur,Init Encntr
 ;;^UTILITY(U,$J,358.3,22919,1,4,0)
 ;;=4^T84.620A
 ;;^UTILITY(U,$J,358.3,22919,2)
 ;;=^5055424
 ;;^UTILITY(U,$J,358.3,22920,0)
 ;;=T84.621A^^105^1166^87
 ;;^UTILITY(U,$J,358.3,22920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22920,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Left Femur,Init Encntr
 ;;^UTILITY(U,$J,358.3,22920,1,4,0)
 ;;=4^T84.621A
 ;;^UTILITY(U,$J,358.3,22920,2)
 ;;=^5055427
 ;;^UTILITY(U,$J,358.3,22921,0)
 ;;=T84.622A^^105^1166^88
 ;;^UTILITY(U,$J,358.3,22921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22921,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Right Tibia,Init Encntr
 ;;^UTILITY(U,$J,358.3,22921,1,4,0)
 ;;=4^T84.622A
 ;;^UTILITY(U,$J,358.3,22921,2)
 ;;=^5055430
 ;;^UTILITY(U,$J,358.3,22922,0)
 ;;=T84.623A^^105^1166^89
 ;;^UTILITY(U,$J,358.3,22922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22922,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Left Tibia,Init Encntr
 ;;^UTILITY(U,$J,358.3,22922,1,4,0)
 ;;=4^T84.623A
 ;;^UTILITY(U,$J,358.3,22922,2)
 ;;=^5055433
 ;;^UTILITY(U,$J,358.3,22923,0)
 ;;=T84.624A^^105^1166^90
 ;;^UTILITY(U,$J,358.3,22923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22923,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Right Fibula,Init Encntr
 ;;^UTILITY(U,$J,358.3,22923,1,4,0)
 ;;=4^T84.624A
 ;;^UTILITY(U,$J,358.3,22923,2)
 ;;=^5055436
