IBDEI0L0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9803,1,4,0)
 ;;=4^L10.81
 ;;^UTILITY(U,$J,358.3,9803,2)
 ;;=^5009088
 ;;^UTILITY(U,$J,358.3,9804,0)
 ;;=L10.5^^44^495^60
 ;;^UTILITY(U,$J,358.3,9804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9804,1,3,0)
 ;;=3^Drug-Induced Pemphigus
 ;;^UTILITY(U,$J,358.3,9804,1,4,0)
 ;;=4^L10.5
 ;;^UTILITY(U,$J,358.3,9804,2)
 ;;=^5009087
 ;;^UTILITY(U,$J,358.3,9805,0)
 ;;=L12.9^^44^495^125
 ;;^UTILITY(U,$J,358.3,9805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9805,1,3,0)
 ;;=3^Pemphigoid,Unspec
 ;;^UTILITY(U,$J,358.3,9805,1,4,0)
 ;;=4^L12.9
 ;;^UTILITY(U,$J,358.3,9805,2)
 ;;=^5009102
 ;;^UTILITY(U,$J,358.3,9806,0)
 ;;=M35.01^^44^495^153
 ;;^UTILITY(U,$J,358.3,9806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9806,1,3,0)
 ;;=3^Sicca Syndrome w/ Keratoconjunctivitis
 ;;^UTILITY(U,$J,358.3,9806,1,4,0)
 ;;=4^M35.01
 ;;^UTILITY(U,$J,358.3,9806,2)
 ;;=^5011787
 ;;^UTILITY(U,$J,358.3,9807,0)
 ;;=S05.01XA^^44^495^89
 ;;^UTILITY(U,$J,358.3,9807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9807,1,3,0)
 ;;=3^Injury of Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,9807,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,9807,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,9808,0)
 ;;=S05.02XA^^44^495^90
 ;;^UTILITY(U,$J,358.3,9808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9808,1,3,0)
 ;;=3^Injury of Conjunctiva/Corneal Abrasion w/o FB,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,9808,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,9808,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,9809,0)
 ;;=T15.02XA^^44^495^69
 ;;^UTILITY(U,$J,358.3,9809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9809,1,3,0)
 ;;=3^FB in Cornea,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,9809,1,4,0)
 ;;=4^T15.02XA
 ;;^UTILITY(U,$J,358.3,9809,2)
 ;;=^5046387
 ;;^UTILITY(U,$J,358.3,9810,0)
 ;;=T15.01XA^^44^495^70
 ;;^UTILITY(U,$J,358.3,9810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9810,1,3,0)
 ;;=3^FB in Cornea,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,9810,1,4,0)
 ;;=4^T15.01XA
 ;;^UTILITY(U,$J,358.3,9810,2)
 ;;=^5046384
 ;;^UTILITY(U,$J,358.3,9811,0)
 ;;=T15.91XA^^44^495^72
 ;;^UTILITY(U,$J,358.3,9811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9811,1,3,0)
 ;;=3^FB on External Eye,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,9811,1,4,0)
 ;;=4^T15.91XA
 ;;^UTILITY(U,$J,358.3,9811,2)
 ;;=^5046411
 ;;^UTILITY(U,$J,358.3,9812,0)
 ;;=T15.92XA^^44^495^71
 ;;^UTILITY(U,$J,358.3,9812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9812,1,3,0)
 ;;=3^FB on External Eye,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,9812,1,4,0)
 ;;=4^T15.92XA
 ;;^UTILITY(U,$J,358.3,9812,2)
 ;;=^5046414
 ;;^UTILITY(U,$J,358.3,9813,0)
 ;;=T85.398A^^44^495^118
 ;;^UTILITY(U,$J,358.3,9813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9813,1,3,0)
 ;;=3^Mech Compl of Ocular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,9813,1,4,0)
 ;;=4^T85.398A
 ;;^UTILITY(U,$J,358.3,9813,2)
 ;;=^5055559
 ;;^UTILITY(U,$J,358.3,9814,0)
 ;;=T86.840^^44^495^58
 ;;^UTILITY(U,$J,358.3,9814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9814,1,3,0)
 ;;=3^Corneal Transplant Rejection
 ;;^UTILITY(U,$J,358.3,9814,1,4,0)
 ;;=4^T86.840
 ;;^UTILITY(U,$J,358.3,9814,2)
 ;;=^5055744
 ;;^UTILITY(U,$J,358.3,9815,0)
 ;;=T86.841^^44^495^57
 ;;^UTILITY(U,$J,358.3,9815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9815,1,3,0)
 ;;=3^Corneal Transplant Failure
 ;;^UTILITY(U,$J,358.3,9815,1,4,0)
 ;;=4^T86.841
 ;;^UTILITY(U,$J,358.3,9815,2)
 ;;=^5055745
 ;;^UTILITY(U,$J,358.3,9816,0)
 ;;=T85.318A^^44^495^22
 ;;^UTILITY(U,$J,358.3,9816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9816,1,3,0)
 ;;=3^Breakdown of Ocular Prosthetic Device/Implant/Graft,Init Encntr
