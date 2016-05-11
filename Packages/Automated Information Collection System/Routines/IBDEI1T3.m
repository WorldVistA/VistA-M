IBDEI1T3 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30691,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,30692,0)
 ;;=Z69.82^^123^1529^21
 ;;^UTILITY(U,$J,358.3,30692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30692,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,30692,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,30692,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,30693,0)
 ;;=T74.01XA^^123^1529^1
 ;;^UTILITY(U,$J,358.3,30693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30693,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,30693,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,30693,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,30694,0)
 ;;=T74.01XD^^123^1529^2
 ;;^UTILITY(U,$J,358.3,30694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30694,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,30694,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,30694,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,30695,0)
 ;;=T76.01XA^^123^1529^3
 ;;^UTILITY(U,$J,358.3,30695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30695,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,30695,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,30695,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,30696,0)
 ;;=T76.01XD^^123^1529^4
 ;;^UTILITY(U,$J,358.3,30696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30696,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,30696,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,30696,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,30697,0)
 ;;=Z91.412^^123^1529^31
 ;;^UTILITY(U,$J,358.3,30697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30697,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,30697,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,30697,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,30698,0)
 ;;=T74.31XA^^123^1529^9
 ;;^UTILITY(U,$J,358.3,30698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30698,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,30698,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,30698,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,30699,0)
 ;;=T74.31XD^^123^1529^10
 ;;^UTILITY(U,$J,358.3,30699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30699,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,30699,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,30699,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,30700,0)
 ;;=T76.31XA^^123^1529^11
 ;;^UTILITY(U,$J,358.3,30700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30700,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,30700,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,30700,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,30701,0)
 ;;=T76.31XD^^123^1529^12
 ;;^UTILITY(U,$J,358.3,30701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30701,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,30701,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,30701,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,30702,0)
 ;;=Z91.411^^123^1529^30
 ;;^UTILITY(U,$J,358.3,30702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30702,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,30702,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,30702,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,30703,0)
 ;;=Z69.021^^123^1529^17
 ;;^UTILITY(U,$J,358.3,30703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30703,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,30703,1,4,0)
 ;;=4^Z69.021
