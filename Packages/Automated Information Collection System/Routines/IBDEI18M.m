IBDEI18M ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20697,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,20698,0)
 ;;=H0005^^98^979^2^^^^1
 ;;^UTILITY(U,$J,358.3,20698,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20698,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,20698,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,20699,0)
 ;;=H0006^^98^979^5^^^^1
 ;;^UTILITY(U,$J,358.3,20699,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20699,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,20699,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,20700,0)
 ;;=H0020^^98^979^8^^^^1
 ;;^UTILITY(U,$J,358.3,20700,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20700,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,20700,1,3,0)
 ;;=3^Methadone Admin &/or Svc by Licensed Program
 ;;^UTILITY(U,$J,358.3,20701,0)
 ;;=H0025^^98^979^3^^^^1
 ;;^UTILITY(U,$J,358.3,20701,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20701,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,20701,1,3,0)
 ;;=3^Addictions Health Prevention Ed Service
 ;;^UTILITY(U,$J,358.3,20702,0)
 ;;=H0030^^98^979^4^^^^1
 ;;^UTILITY(U,$J,358.3,20702,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20702,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,20702,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,20703,0)
 ;;=H0046^^98^979^9^^^^1
 ;;^UTILITY(U,$J,358.3,20703,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20703,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,20703,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,20704,0)
 ;;=90791^^98^980^1^^^^1
 ;;^UTILITY(U,$J,358.3,20704,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20704,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,20704,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation
 ;;^UTILITY(U,$J,358.3,20705,0)
 ;;=T74.11XA^^99^981^8
 ;;^UTILITY(U,$J,358.3,20705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20705,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,20705,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,20705,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,20706,0)
 ;;=T74.11XD^^99^981^9
 ;;^UTILITY(U,$J,358.3,20706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20706,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,20706,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,20706,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,20707,0)
 ;;=T76.11XA^^99^981^10
 ;;^UTILITY(U,$J,358.3,20707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20707,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,20707,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,20707,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,20708,0)
 ;;=T76.11XD^^99^981^11
 ;;^UTILITY(U,$J,358.3,20708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20708,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,20708,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,20708,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,20709,0)
 ;;=Z69.11^^99^981^4
 ;;^UTILITY(U,$J,358.3,20709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20709,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,20709,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,20709,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,20710,0)
 ;;=Z91.410^^99^981^5
 ;;^UTILITY(U,$J,358.3,20710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20710,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,20710,1,4,0)
 ;;=4^Z91.410
