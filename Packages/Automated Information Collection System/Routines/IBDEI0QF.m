IBDEI0QF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12108,1,3,0)
 ;;=3^Remove FB,Cornea,w/Slit Lamp
 ;;^UTILITY(U,$J,358.3,12109,0)
 ;;=99395^^70^705^1^^^^1
 ;;^UTILITY(U,$J,358.3,12109,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12109,1,2,0)
 ;;=2^99395
 ;;^UTILITY(U,$J,358.3,12109,1,3,0)
 ;;=3^Preventive Med-Est Pt 18-39
 ;;^UTILITY(U,$J,358.3,12110,0)
 ;;=99396^^70^705^2^^^^1
 ;;^UTILITY(U,$J,358.3,12110,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12110,1,2,0)
 ;;=2^99396
 ;;^UTILITY(U,$J,358.3,12110,1,3,0)
 ;;=3^Preventive Med-Est Pt 40-64
 ;;^UTILITY(U,$J,358.3,12111,0)
 ;;=99397^^70^705^3^^^^1
 ;;^UTILITY(U,$J,358.3,12111,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12111,1,2,0)
 ;;=2^99397
 ;;^UTILITY(U,$J,358.3,12111,1,3,0)
 ;;=3^Preventive Med-Est Pt > 64
 ;;^UTILITY(U,$J,358.3,12112,0)
 ;;=99385^^70^706^1^^^^1
 ;;^UTILITY(U,$J,358.3,12112,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12112,1,2,0)
 ;;=2^99385
 ;;^UTILITY(U,$J,358.3,12112,1,3,0)
 ;;=3^Preventive Med-New Pt 18-39
 ;;^UTILITY(U,$J,358.3,12113,0)
 ;;=99386^^70^706^2^^^^1
 ;;^UTILITY(U,$J,358.3,12113,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12113,1,2,0)
 ;;=2^99386
 ;;^UTILITY(U,$J,358.3,12113,1,3,0)
 ;;=3^Preventive Med-New Pt 40-64
 ;;^UTILITY(U,$J,358.3,12114,0)
 ;;=99387^^70^706^3^^^^1
 ;;^UTILITY(U,$J,358.3,12114,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12114,1,2,0)
 ;;=2^99387
 ;;^UTILITY(U,$J,358.3,12114,1,3,0)
 ;;=3^Preventive Med-New Pt > 64
 ;;^UTILITY(U,$J,358.3,12115,0)
 ;;=3510F^^70^707^1^^^^1
 ;;^UTILITY(U,$J,358.3,12115,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12115,1,2,0)
 ;;=2^3510F
 ;;^UTILITY(U,$J,358.3,12115,1,3,0)
 ;;=3^TB Screening/Results Interpd
 ;;^UTILITY(U,$J,358.3,12116,0)
 ;;=S90.511A^^71^708^16
 ;;^UTILITY(U,$J,358.3,12116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12116,1,3,0)
 ;;=3^Abrasion,Right ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,12116,1,4,0)
 ;;=4^S90.511A
 ;;^UTILITY(U,$J,358.3,12116,2)
 ;;=^5043997
 ;;^UTILITY(U,$J,358.3,12117,0)
 ;;=S90.512A^^71^708^1
 ;;^UTILITY(U,$J,358.3,12117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12117,1,3,0)
 ;;=3^Abrasion,Left ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,12117,1,4,0)
 ;;=4^S90.512A
 ;;^UTILITY(U,$J,358.3,12117,2)
 ;;=^5044000
 ;;^UTILITY(U,$J,358.3,12118,0)
 ;;=S40.811A^^71^708^28
 ;;^UTILITY(U,$J,358.3,12118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12118,1,3,0)
 ;;=3^Abrasion,Right upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,12118,1,4,0)
 ;;=4^S40.811A
 ;;^UTILITY(U,$J,358.3,12118,2)
 ;;=^5026225
 ;;^UTILITY(U,$J,358.3,12119,0)
 ;;=S40.812A^^71^708^13
 ;;^UTILITY(U,$J,358.3,12119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12119,1,3,0)
 ;;=3^Abrasion,Left upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,12119,1,4,0)
 ;;=4^S40.812A
 ;;^UTILITY(U,$J,358.3,12119,2)
 ;;=^5026228
 ;;^UTILITY(U,$J,358.3,12120,0)
 ;;=S05.01XA^^71^708^46
 ;;^UTILITY(U,$J,358.3,12120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12120,1,3,0)
 ;;=3^Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init Enctr
 ;;^UTILITY(U,$J,358.3,12120,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,12120,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,12121,0)
 ;;=S05.02XA^^71^708^45
 ;;^UTILITY(U,$J,358.3,12121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12121,1,3,0)
 ;;=3^Conjuctiva/Corneal Abrasion w/o FB,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,12121,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,12121,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,12122,0)
 ;;=S50.311A^^71^708^17
 ;;^UTILITY(U,$J,358.3,12122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12122,1,3,0)
 ;;=3^Abrasion,Right elbow, initial encounter
