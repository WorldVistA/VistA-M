IBDEI05E ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2007,1,3,0)
 ;;=3^Abrasion,Right ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,2007,1,4,0)
 ;;=4^S90.511A
 ;;^UTILITY(U,$J,358.3,2007,2)
 ;;=^5043997
 ;;^UTILITY(U,$J,358.3,2008,0)
 ;;=S90.512A^^4^62^1
 ;;^UTILITY(U,$J,358.3,2008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2008,1,3,0)
 ;;=3^Abrasion,Left ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,2008,1,4,0)
 ;;=4^S90.512A
 ;;^UTILITY(U,$J,358.3,2008,2)
 ;;=^5044000
 ;;^UTILITY(U,$J,358.3,2009,0)
 ;;=S40.811A^^4^62^28
 ;;^UTILITY(U,$J,358.3,2009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2009,1,3,0)
 ;;=3^Abrasion,Right upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,2009,1,4,0)
 ;;=4^S40.811A
 ;;^UTILITY(U,$J,358.3,2009,2)
 ;;=^5026225
 ;;^UTILITY(U,$J,358.3,2010,0)
 ;;=S40.812A^^4^62^13
 ;;^UTILITY(U,$J,358.3,2010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2010,1,3,0)
 ;;=3^Abrasion,Left upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,2010,1,4,0)
 ;;=4^S40.812A
 ;;^UTILITY(U,$J,358.3,2010,2)
 ;;=^5026228
 ;;^UTILITY(U,$J,358.3,2011,0)
 ;;=S05.01XA^^4^62^46
 ;;^UTILITY(U,$J,358.3,2011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2011,1,3,0)
 ;;=3^Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init Enctr
 ;;^UTILITY(U,$J,358.3,2011,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,2011,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,2012,0)
 ;;=S05.02XA^^4^62^45
 ;;^UTILITY(U,$J,358.3,2012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2012,1,3,0)
 ;;=3^Conjuctiva/Corneal Abrasion w/o FB,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,2012,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,2012,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,2013,0)
 ;;=S50.311A^^4^62^17
 ;;^UTILITY(U,$J,358.3,2013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2013,1,3,0)
 ;;=3^Abrasion,Right elbow, initial encounter
 ;;^UTILITY(U,$J,358.3,2013,1,4,0)
 ;;=4^S50.311A
 ;;^UTILITY(U,$J,358.3,2013,2)
 ;;=^5028500
 ;;^UTILITY(U,$J,358.3,2014,0)
 ;;=S50.312A^^4^62^2
 ;;^UTILITY(U,$J,358.3,2014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2014,1,3,0)
 ;;=3^Abrasion,Left elbow, initial encounter
 ;;^UTILITY(U,$J,358.3,2014,1,4,0)
 ;;=4^S50.312A
 ;;^UTILITY(U,$J,358.3,2014,2)
 ;;=^5028503
 ;;^UTILITY(U,$J,358.3,2015,0)
 ;;=S00.81XA^^4^62^15
 ;;^UTILITY(U,$J,358.3,2015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2015,1,3,0)
 ;;=3^Abrasion,Other part of head, initial encounter
 ;;^UTILITY(U,$J,358.3,2015,1,4,0)
 ;;=4^S00.81XA
 ;;^UTILITY(U,$J,358.3,2015,2)
 ;;=^5019988
 ;;^UTILITY(U,$J,358.3,2016,0)
 ;;=S90.811A^^4^62^18
 ;;^UTILITY(U,$J,358.3,2016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2016,1,3,0)
 ;;=3^Abrasion,Right foot, initial encounter
 ;;^UTILITY(U,$J,358.3,2016,1,4,0)
 ;;=4^S90.811A
 ;;^UTILITY(U,$J,358.3,2016,2)
 ;;=^5044051
 ;;^UTILITY(U,$J,358.3,2017,0)
 ;;=S90.812A^^4^62^3
 ;;^UTILITY(U,$J,358.3,2017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2017,1,3,0)
 ;;=3^Abrasion,Left foot, initial encounter
 ;;^UTILITY(U,$J,358.3,2017,1,4,0)
 ;;=4^S90.812A
 ;;^UTILITY(U,$J,358.3,2017,2)
 ;;=^5044054
 ;;^UTILITY(U,$J,358.3,2018,0)
 ;;=S90.411A^^4^62^20
 ;;^UTILITY(U,$J,358.3,2018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2018,1,3,0)
 ;;=3^Abrasion,Right great toe, initial encounter
 ;;^UTILITY(U,$J,358.3,2018,1,4,0)
 ;;=4^S90.411A
 ;;^UTILITY(U,$J,358.3,2018,2)
 ;;=^5043889
 ;;^UTILITY(U,$J,358.3,2019,0)
 ;;=S90.412A^^4^62^5
 ;;^UTILITY(U,$J,358.3,2019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2019,1,3,0)
 ;;=3^Abrasion,Left great toe, initial encounter
 ;;^UTILITY(U,$J,358.3,2019,1,4,0)
 ;;=4^S90.412A
