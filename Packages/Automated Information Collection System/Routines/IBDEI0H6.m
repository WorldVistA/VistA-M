IBDEI0H6 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7948,1,2,0)
 ;;=2^65205
 ;;^UTILITY(U,$J,358.3,7948,1,3,0)
 ;;=3^Remove FB,Conjunc,External Eye
 ;;^UTILITY(U,$J,358.3,7949,0)
 ;;=65210^^32^426^4^^^^1
 ;;^UTILITY(U,$J,358.3,7949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7949,1,2,0)
 ;;=2^65210
 ;;^UTILITY(U,$J,358.3,7949,1,3,0)
 ;;=3^Remove FB,Conjunc,Embed,External Eye
 ;;^UTILITY(U,$J,358.3,7950,0)
 ;;=65220^^32^426^5^^^^1
 ;;^UTILITY(U,$J,358.3,7950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7950,1,2,0)
 ;;=2^65220
 ;;^UTILITY(U,$J,358.3,7950,1,3,0)
 ;;=3^Remove FB,Cornea w/o Slit Lamp
 ;;^UTILITY(U,$J,358.3,7951,0)
 ;;=65222^^32^426^6^^^^1
 ;;^UTILITY(U,$J,358.3,7951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7951,1,2,0)
 ;;=2^65222
 ;;^UTILITY(U,$J,358.3,7951,1,3,0)
 ;;=3^Remove FB,Cornea,w/Slit Lamp
 ;;^UTILITY(U,$J,358.3,7952,0)
 ;;=99395^^32^427^1^^^^1
 ;;^UTILITY(U,$J,358.3,7952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7952,1,2,0)
 ;;=2^99395
 ;;^UTILITY(U,$J,358.3,7952,1,3,0)
 ;;=3^Preventive Med-Est Pt 18-39
 ;;^UTILITY(U,$J,358.3,7953,0)
 ;;=99396^^32^427^2^^^^1
 ;;^UTILITY(U,$J,358.3,7953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7953,1,2,0)
 ;;=2^99396
 ;;^UTILITY(U,$J,358.3,7953,1,3,0)
 ;;=3^Preventive Med-Est Pt 40-64
 ;;^UTILITY(U,$J,358.3,7954,0)
 ;;=99397^^32^427^3^^^^1
 ;;^UTILITY(U,$J,358.3,7954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7954,1,2,0)
 ;;=2^99397
 ;;^UTILITY(U,$J,358.3,7954,1,3,0)
 ;;=3^Preventive Med-Est Pt > 64
 ;;^UTILITY(U,$J,358.3,7955,0)
 ;;=99385^^32^428^1^^^^1
 ;;^UTILITY(U,$J,358.3,7955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7955,1,2,0)
 ;;=2^99385
 ;;^UTILITY(U,$J,358.3,7955,1,3,0)
 ;;=3^Preventive Med-New Pt 18-39
 ;;^UTILITY(U,$J,358.3,7956,0)
 ;;=99386^^32^428^2^^^^1
 ;;^UTILITY(U,$J,358.3,7956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7956,1,2,0)
 ;;=2^99386
 ;;^UTILITY(U,$J,358.3,7956,1,3,0)
 ;;=3^Preventive Med-New Pt 40-64
 ;;^UTILITY(U,$J,358.3,7957,0)
 ;;=99387^^32^428^3^^^^1
 ;;^UTILITY(U,$J,358.3,7957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7957,1,2,0)
 ;;=2^99387
 ;;^UTILITY(U,$J,358.3,7957,1,3,0)
 ;;=3^Preventive Med-New Pt > 64
 ;;^UTILITY(U,$J,358.3,7958,0)
 ;;=3510F^^32^429^1^^^^1
 ;;^UTILITY(U,$J,358.3,7958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7958,1,2,0)
 ;;=2^3510F
 ;;^UTILITY(U,$J,358.3,7958,1,3,0)
 ;;=3^TB Screening/Results Interpd
 ;;^UTILITY(U,$J,358.3,7959,0)
 ;;=99415^^32^430^1^^^^1
 ;;^UTILITY(U,$J,358.3,7959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7959,1,2,0)
 ;;=2^99415
 ;;^UTILITY(U,$J,358.3,7959,1,3,0)
 ;;=3^Prolong Clin Staff Svc,1st hr
 ;;^UTILITY(U,$J,358.3,7960,0)
 ;;=99416^^32^430^2^^^^1
 ;;^UTILITY(U,$J,358.3,7960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7960,1,2,0)
 ;;=2^99416
 ;;^UTILITY(U,$J,358.3,7960,1,3,0)
 ;;=3^Prolong Clin Staff Svc,Ea Addl 30min
 ;;^UTILITY(U,$J,358.3,7961,0)
 ;;=S90.511A^^33^431^16
 ;;^UTILITY(U,$J,358.3,7961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7961,1,3,0)
 ;;=3^Abrasion,Right ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,7961,1,4,0)
 ;;=4^S90.511A
 ;;^UTILITY(U,$J,358.3,7961,2)
 ;;=^5043997
 ;;^UTILITY(U,$J,358.3,7962,0)
 ;;=S90.512A^^33^431^1
 ;;^UTILITY(U,$J,358.3,7962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7962,1,3,0)
 ;;=3^Abrasion,Left ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,7962,1,4,0)
 ;;=4^S90.512A
 ;;^UTILITY(U,$J,358.3,7962,2)
 ;;=^5044000
 ;;^UTILITY(U,$J,358.3,7963,0)
 ;;=S40.811A^^33^431^28
 ;;^UTILITY(U,$J,358.3,7963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7963,1,3,0)
 ;;=3^Abrasion,Right upper arm, initial encounter
