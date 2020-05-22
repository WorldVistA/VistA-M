IBDEI0H6 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7450,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,7451,0)
 ;;=I69.959^^58^474^18
 ;;^UTILITY(U,$J,358.3,7451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7451,1,3,0)
 ;;=3^Hemplg/Hemprs d/t Cerebvasc Diz Aff Unspec Side
 ;;^UTILITY(U,$J,358.3,7451,1,4,0)
 ;;=4^I69.959
 ;;^UTILITY(U,$J,358.3,7451,2)
 ;;=^5007563
 ;;^UTILITY(U,$J,358.3,7452,0)
 ;;=I69.359^^58^474^19
 ;;^UTILITY(U,$J,358.3,7452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7452,1,3,0)
 ;;=3^Hemplg/Hemprs d/t Cerebvasc Infrc Aff Unspec Side
 ;;^UTILITY(U,$J,358.3,7452,1,4,0)
 ;;=4^I69.359
 ;;^UTILITY(U,$J,358.3,7452,2)
 ;;=^5007508
 ;;^UTILITY(U,$J,358.3,7453,0)
 ;;=S14.109S^^58^474^39
 ;;^UTILITY(U,$J,358.3,7453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7453,1,3,0)
 ;;=3^Sequela of Unspec Injury to Cervical Spinal Cord
 ;;^UTILITY(U,$J,358.3,7453,1,4,0)
 ;;=4^S14.109S
 ;;^UTILITY(U,$J,358.3,7453,2)
 ;;=^5134243
 ;;^UTILITY(U,$J,358.3,7454,0)
 ;;=S34.109S^^58^474^40
 ;;^UTILITY(U,$J,358.3,7454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7454,1,3,0)
 ;;=3^Sequela of Unspec Injury to Lumbar Spinal Cord
 ;;^UTILITY(U,$J,358.3,7454,1,4,0)
 ;;=4^S34.109S
 ;;^UTILITY(U,$J,358.3,7454,2)
 ;;=^5134570
 ;;^UTILITY(U,$J,358.3,7455,0)
 ;;=S24.109S^^58^474^41
 ;;^UTILITY(U,$J,358.3,7455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7455,1,3,0)
 ;;=3^Sequela of Unspec Injury to Thoracic Spinal Cord
 ;;^UTILITY(U,$J,358.3,7455,1,4,0)
 ;;=4^S24.109S
 ;;^UTILITY(U,$J,358.3,7455,2)
 ;;=^5134384
 ;;^UTILITY(U,$J,358.3,7456,0)
 ;;=Z91.5^^58^475^1
 ;;^UTILITY(U,$J,358.3,7456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7456,1,3,0)
 ;;=3^Personal Hx of Suicide Attempt(s)
 ;;^UTILITY(U,$J,358.3,7456,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,7456,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,7457,0)
 ;;=R45.851^^58^475^2
 ;;^UTILITY(U,$J,358.3,7457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7457,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,7457,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,7457,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,7458,0)
 ;;=T14.91XA^^58^475^3
 ;;^UTILITY(U,$J,358.3,7458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7458,1,3,0)
 ;;=3^Suicide Attempt,Initial Encntr
 ;;^UTILITY(U,$J,358.3,7458,1,4,0)
 ;;=4^T14.91XA
 ;;^UTILITY(U,$J,358.3,7458,2)
 ;;=^5151779
 ;;^UTILITY(U,$J,358.3,7459,0)
 ;;=T14.91XD^^58^475^4
 ;;^UTILITY(U,$J,358.3,7459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7459,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,7459,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,7459,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,7460,0)
 ;;=T14.91XS^^58^475^5
 ;;^UTILITY(U,$J,358.3,7460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7460,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,7460,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,7460,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,7461,0)
 ;;=99211^^59^476^1
 ;;^UTILITY(U,$J,358.3,7461,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,7461,1,1,0)
 ;;=1^Brief (no MD seen)
 ;;^UTILITY(U,$J,358.3,7461,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,7462,0)
 ;;=99212^^59^476^2
 ;;^UTILITY(U,$J,358.3,7462,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,7462,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,7462,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,7463,0)
 ;;=99213^^59^476^3
 ;;^UTILITY(U,$J,358.3,7463,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,7463,1,1,0)
 ;;=1^Expanded Problem Focused
