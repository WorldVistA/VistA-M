IBDEI1FK ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22891,1,3,0)
 ;;=3^Dsplcmnt of Implnt Elect Neurostim,Brain,Init Encntr
 ;;^UTILITY(U,$J,358.3,22891,1,4,0)
 ;;=4^T85.120A
 ;;^UTILITY(U,$J,358.3,22891,2)
 ;;=^5055502
 ;;^UTILITY(U,$J,358.3,22892,0)
 ;;=T85.121A^^105^1166^38
 ;;^UTILITY(U,$J,358.3,22892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22892,1,3,0)
 ;;=3^Dsplcmnt of Implnt Elect Neurostim,Periph Nrv,Init Encntr
 ;;^UTILITY(U,$J,358.3,22892,1,4,0)
 ;;=4^T85.121A
 ;;^UTILITY(U,$J,358.3,22892,2)
 ;;=^5055505
 ;;^UTILITY(U,$J,358.3,22893,0)
 ;;=T85.122A^^105^1166^39
 ;;^UTILITY(U,$J,358.3,22893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22893,1,3,0)
 ;;=3^Dsplcmnt of Implnt Elect Neurostim,Spinal Cord,Init Encntr
 ;;^UTILITY(U,$J,358.3,22893,1,4,0)
 ;;=4^T85.122A
 ;;^UTILITY(U,$J,358.3,22893,2)
 ;;=^5055508
 ;;^UTILITY(U,$J,358.3,22894,0)
 ;;=T85.128A^^105^1166^40
 ;;^UTILITY(U,$J,358.3,22894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22894,1,3,0)
 ;;=3^Dsplcmnt of Implnt Elect Stim,Nrv Sys,Init Encntr
 ;;^UTILITY(U,$J,358.3,22894,1,4,0)
 ;;=4^T85.128A
 ;;^UTILITY(U,$J,358.3,22894,2)
 ;;=^5055511
 ;;^UTILITY(U,$J,358.3,22895,0)
 ;;=T85.190A^^105^1166^153
 ;;^UTILITY(U,$J,358.3,22895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22895,1,3,0)
 ;;=3^Mech Compl of Implanted Electronic Neurostim of Brain,Init Encntr
 ;;^UTILITY(U,$J,358.3,22895,1,4,0)
 ;;=4^T85.190A
 ;;^UTILITY(U,$J,358.3,22895,2)
 ;;=^5055514
 ;;^UTILITY(U,$J,358.3,22896,0)
 ;;=T85.191A^^105^1166^154
 ;;^UTILITY(U,$J,358.3,22896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22896,1,3,0)
 ;;=3^Mech Compl of Implanted Electronic Neurostim of Periph Nrv,Init Encntr
 ;;^UTILITY(U,$J,358.3,22896,1,4,0)
 ;;=4^T85.191A
 ;;^UTILITY(U,$J,358.3,22896,2)
 ;;=^5055517
 ;;^UTILITY(U,$J,358.3,22897,0)
 ;;=T85.192A^^105^1166^155
 ;;^UTILITY(U,$J,358.3,22897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22897,1,3,0)
 ;;=3^Mech Compl of Implanted Electronic Neurostim of Spinal Cord,Init Encntr
 ;;^UTILITY(U,$J,358.3,22897,1,4,0)
 ;;=4^T85.192A
 ;;^UTILITY(U,$J,358.3,22897,2)
 ;;=^5055520
 ;;^UTILITY(U,$J,358.3,22898,0)
 ;;=T85.199A^^105^1166^156
 ;;^UTILITY(U,$J,358.3,22898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22898,1,3,0)
 ;;=3^Mech Compl of Implanted Electronic Stim of Nervous Sys,Init Encntr
 ;;^UTILITY(U,$J,358.3,22898,1,4,0)
 ;;=4^T85.199A
 ;;^UTILITY(U,$J,358.3,22898,2)
 ;;=^5055523
 ;;^UTILITY(U,$J,358.3,22899,0)
 ;;=T83.498A^^105^1166^159
 ;;^UTILITY(U,$J,358.3,22899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22899,1,3,0)
 ;;=3^Mech Compl of Prosthetic Device/Implant/Graft of Genital Tract,Init Encntr
 ;;^UTILITY(U,$J,358.3,22899,1,4,0)
 ;;=4^T83.498A
 ;;^UTILITY(U,$J,358.3,22899,2)
 ;;=^5055055
 ;;^UTILITY(U,$J,358.3,22900,0)
 ;;=T85.398A^^105^1166^160
 ;;^UTILITY(U,$J,358.3,22900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22900,1,3,0)
 ;;=3^Mech Compl of Prosthetic Device/Implant/Graft of Ocular,Init Encntr
 ;;^UTILITY(U,$J,358.3,22900,1,4,0)
 ;;=4^T85.398A
 ;;^UTILITY(U,$J,358.3,22900,2)
 ;;=^5055559
 ;;^UTILITY(U,$J,358.3,22901,0)
 ;;=T85.590A^^105^1166^161
 ;;^UTILITY(U,$J,358.3,22901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22901,1,3,0)
 ;;=3^Mech Compl of Prosthetic Device/Implant/Graft of Bile Duct,Init Encntr
 ;;^UTILITY(U,$J,358.3,22901,1,4,0)
 ;;=4^T85.590A
 ;;^UTILITY(U,$J,358.3,22901,2)
 ;;=^5055595
 ;;^UTILITY(U,$J,358.3,22902,0)
 ;;=T85.692A^^105^1166^158
