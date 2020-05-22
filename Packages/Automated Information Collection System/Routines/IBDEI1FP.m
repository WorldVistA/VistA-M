IBDEI1FP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22946,0)
 ;;=T83.86XA^^105^1166^230
 ;;^UTILITY(U,$J,358.3,22946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22946,1,3,0)
 ;;=3^Thromb,Genitour Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,22946,1,4,0)
 ;;=4^T83.86XA
 ;;^UTILITY(U,$J,358.3,22946,2)
 ;;=^5055094
 ;;^UTILITY(U,$J,358.3,22947,0)
 ;;=T83.9XXA^^105^1166^23
 ;;^UTILITY(U,$J,358.3,22947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22947,1,3,0)
 ;;=3^Complic,Genitour Prosth Dvc/Implt/Grft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22947,1,4,0)
 ;;=4^T83.9XXA
 ;;^UTILITY(U,$J,358.3,22947,2)
 ;;=^5055100
 ;;^UTILITY(U,$J,358.3,22948,0)
 ;;=T84.81XA^^105^1166^47
 ;;^UTILITY(U,$J,358.3,22948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22948,1,3,0)
 ;;=3^Embol d/t Internal Ortho Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22948,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,22948,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,22949,0)
 ;;=T84.82XA^^105^1166^54
 ;;^UTILITY(U,$J,358.3,22949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22949,1,3,0)
 ;;=3^Fibrosis d/t Internal Ortho Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22949,1,4,0)
 ;;=4^T84.82XA
 ;;^UTILITY(U,$J,358.3,22949,2)
 ;;=^5055457
 ;;^UTILITY(U,$J,358.3,22950,0)
 ;;=T84.83XA^^105^1166^60
 ;;^UTILITY(U,$J,358.3,22950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22950,1,3,0)
 ;;=3^Hemorrh d/t Internal Ortho Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22950,1,4,0)
 ;;=4^T84.83XA
 ;;^UTILITY(U,$J,358.3,22950,2)
 ;;=^5055460
 ;;^UTILITY(U,$J,358.3,22951,0)
 ;;=T84.84XA^^105^1166^167
 ;;^UTILITY(U,$J,358.3,22951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22951,1,3,0)
 ;;=3^Pain d/t Internal Ortho Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22951,1,4,0)
 ;;=4^T84.84XA
 ;;^UTILITY(U,$J,358.3,22951,2)
 ;;=^5055463
 ;;^UTILITY(U,$J,358.3,22952,0)
 ;;=T84.85XA^^105^1166^220
 ;;^UTILITY(U,$J,358.3,22952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22952,1,3,0)
 ;;=3^Sten d/t Int Ortho Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,22952,1,4,0)
 ;;=4^T84.85XA
 ;;^UTILITY(U,$J,358.3,22952,2)
 ;;=^5055466
 ;;^UTILITY(U,$J,358.3,22953,0)
 ;;=T84.86XA^^105^1166^226
 ;;^UTILITY(U,$J,358.3,22953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22953,1,3,0)
 ;;=3^Thromb d/t Int Ortho Prosth Dvc/Implnt/Grft,Init Enc
 ;;^UTILITY(U,$J,358.3,22953,1,4,0)
 ;;=4^T84.86XA
 ;;^UTILITY(U,$J,358.3,22953,2)
 ;;=^5055469
 ;;^UTILITY(U,$J,358.3,22954,0)
 ;;=T84.9XXA^^105^1166^20
 ;;^UTILITY(U,$J,358.3,22954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22954,1,3,0)
 ;;=3^Complic d/t Intrn Ortho Prosth Dvc/Implnt/Grft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22954,1,4,0)
 ;;=4^T84.9XXA
 ;;^UTILITY(U,$J,358.3,22954,2)
 ;;=^5055475
 ;;^UTILITY(U,$J,358.3,22955,0)
 ;;=I97.110^^105^1166^179
 ;;^UTILITY(U,$J,358.3,22955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22955,1,3,0)
 ;;=3^Postproc Cardiac Insuff After Cardiac Surg
 ;;^UTILITY(U,$J,358.3,22955,1,4,0)
 ;;=4^I97.110
 ;;^UTILITY(U,$J,358.3,22955,2)
 ;;=^5008083
 ;;^UTILITY(U,$J,358.3,22956,0)
 ;;=I97.111^^105^1166^180
 ;;^UTILITY(U,$J,358.3,22956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22956,1,3,0)
 ;;=3^Postproc Cardiac Insuff After Oth Surg
 ;;^UTILITY(U,$J,358.3,22956,1,4,0)
 ;;=4^I97.111
 ;;^UTILITY(U,$J,358.3,22956,2)
 ;;=^5008084
 ;;^UTILITY(U,$J,358.3,22957,0)
 ;;=I97.120^^105^1166^175
