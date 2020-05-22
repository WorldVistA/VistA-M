IBDEI1FN ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22924,0)
 ;;=T84.625A^^105^1166^91
 ;;^UTILITY(U,$J,358.3,22924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22924,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Left Fibula,Init Encntr
 ;;^UTILITY(U,$J,358.3,22924,1,4,0)
 ;;=4^T84.625A
 ;;^UTILITY(U,$J,358.3,22924,2)
 ;;=^5055439
 ;;^UTILITY(U,$J,358.3,22925,0)
 ;;=T84.63XA^^105^1166^92
 ;;^UTILITY(U,$J,358.3,22925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22925,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Fix Spine,Init Encntr
 ;;^UTILITY(U,$J,358.3,22925,1,4,0)
 ;;=4^T84.63XA
 ;;^UTILITY(U,$J,358.3,22925,2)
 ;;=^5055445
 ;;^UTILITY(U,$J,358.3,22926,0)
 ;;=T84.7XXA^^105^1166^95
 ;;^UTILITY(U,$J,358.3,22926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22926,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Internal Ortho Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22926,1,4,0)
 ;;=4^T84.7XXA
 ;;^UTILITY(U,$J,358.3,22926,2)
 ;;=^5055451
 ;;^UTILITY(U,$J,358.3,22927,0)
 ;;=T82.817A^^105^1166^51
 ;;^UTILITY(U,$J,358.3,22927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22927,1,3,0)
 ;;=3^Embol of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22927,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,22927,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,22928,0)
 ;;=T82.827A^^105^1166^57
 ;;^UTILITY(U,$J,358.3,22928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22928,1,3,0)
 ;;=3^Fibrosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22928,1,4,0)
 ;;=4^T82.827A
 ;;^UTILITY(U,$J,358.3,22928,2)
 ;;=^5054920
 ;;^UTILITY(U,$J,358.3,22929,0)
 ;;=T82.837A^^105^1166^63
 ;;^UTILITY(U,$J,358.3,22929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22929,1,3,0)
 ;;=3^Hemorrh of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22929,1,4,0)
 ;;=4^T82.837A
 ;;^UTILITY(U,$J,358.3,22929,2)
 ;;=^5054926
 ;;^UTILITY(U,$J,358.3,22930,0)
 ;;=T82.847A^^105^1166^170
 ;;^UTILITY(U,$J,358.3,22930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22930,1,3,0)
 ;;=3^Pain from Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22930,1,4,0)
 ;;=4^T82.847A
 ;;^UTILITY(U,$J,358.3,22930,2)
 ;;=^5054932
 ;;^UTILITY(U,$J,358.3,22931,0)
 ;;=T82.857A^^105^1166^223
 ;;^UTILITY(U,$J,358.3,22931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22931,1,3,0)
 ;;=3^Sten,Cardiac Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,22931,1,4,0)
 ;;=4^T82.857A
 ;;^UTILITY(U,$J,358.3,22931,2)
 ;;=^5054938
 ;;^UTILITY(U,$J,358.3,22932,0)
 ;;=T82.867A^^105^1166^229
 ;;^UTILITY(U,$J,358.3,22932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22932,1,3,0)
 ;;=3^Thromb,Cardiac Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,22932,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,22932,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,22933,0)
 ;;=T82.9XXA^^105^1166^22
 ;;^UTILITY(U,$J,358.3,22933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22933,1,3,0)
 ;;=3^Complic,Card/Vasc Prosth Dvc/Implnt/Grft Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,22933,1,4,0)
 ;;=4^T82.9XXA
 ;;^UTILITY(U,$J,358.3,22933,2)
 ;;=^5054956
 ;;^UTILITY(U,$J,358.3,22934,0)
 ;;=T82.818A^^105^1166^53
 ;;^UTILITY(U,$J,358.3,22934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22934,1,3,0)
 ;;=3^Embol of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22934,1,4,0)
 ;;=4^T82.818A
 ;;^UTILITY(U,$J,358.3,22934,2)
 ;;=^5054917
