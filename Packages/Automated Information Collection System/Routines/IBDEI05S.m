IBDEI05S ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2369,0)
 ;;=M71.10^^15^186^51
 ;;^UTILITY(U,$J,358.3,2369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2369,1,3,0)
 ;;=3^Infective bursitis, unspec site
 ;;^UTILITY(U,$J,358.3,2369,1,4,0)
 ;;=4^M71.10
 ;;^UTILITY(U,$J,358.3,2369,2)
 ;;=^5013123
 ;;^UTILITY(U,$J,358.3,2370,0)
 ;;=M71.111^^15^186^49
 ;;^UTILITY(U,$J,358.3,2370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2370,1,3,0)
 ;;=3^Infective bursitis, rt shldr
 ;;^UTILITY(U,$J,358.3,2370,1,4,0)
 ;;=4^M71.111
 ;;^UTILITY(U,$J,358.3,2370,2)
 ;;=^5013124
 ;;^UTILITY(U,$J,358.3,2371,0)
 ;;=M71.112^^15^186^41
 ;;^UTILITY(U,$J,358.3,2371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2371,1,3,0)
 ;;=3^Infective bursitis, lft shldr
 ;;^UTILITY(U,$J,358.3,2371,1,4,0)
 ;;=4^M71.112
 ;;^UTILITY(U,$J,358.3,2371,2)
 ;;=^5013125
 ;;^UTILITY(U,$J,358.3,2372,0)
 ;;=M71.121^^15^186^45
 ;;^UTILITY(U,$J,358.3,2372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2372,1,3,0)
 ;;=3^Infective bursitis, rt elbow
 ;;^UTILITY(U,$J,358.3,2372,1,4,0)
 ;;=4^M71.121
 ;;^UTILITY(U,$J,358.3,2372,2)
 ;;=^5013127
 ;;^UTILITY(U,$J,358.3,2373,0)
 ;;=M71.122^^15^186^37
 ;;^UTILITY(U,$J,358.3,2373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2373,1,3,0)
 ;;=3^Infective bursitis, lft elbow
 ;;^UTILITY(U,$J,358.3,2373,1,4,0)
 ;;=4^M71.122
 ;;^UTILITY(U,$J,358.3,2373,2)
 ;;=^5013128
 ;;^UTILITY(U,$J,358.3,2374,0)
 ;;=M71.131^^15^186^50
 ;;^UTILITY(U,$J,358.3,2374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2374,1,3,0)
 ;;=3^Infective bursitis, rt wrist
 ;;^UTILITY(U,$J,358.3,2374,1,4,0)
 ;;=4^M71.131
 ;;^UTILITY(U,$J,358.3,2374,2)
 ;;=^5013130
 ;;^UTILITY(U,$J,358.3,2375,0)
 ;;=M71.132^^15^186^42
 ;;^UTILITY(U,$J,358.3,2375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2375,1,3,0)
 ;;=3^Infective bursitis, lft wrist
 ;;^UTILITY(U,$J,358.3,2375,1,4,0)
 ;;=4^M71.132
 ;;^UTILITY(U,$J,358.3,2375,2)
 ;;=^5013131
 ;;^UTILITY(U,$J,358.3,2376,0)
 ;;=M71.141^^15^186^46
 ;;^UTILITY(U,$J,358.3,2376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2376,1,3,0)
 ;;=3^Infective bursitis, rt hand
 ;;^UTILITY(U,$J,358.3,2376,1,4,0)
 ;;=4^M71.141
 ;;^UTILITY(U,$J,358.3,2376,2)
 ;;=^5013133
 ;;^UTILITY(U,$J,358.3,2377,0)
 ;;=M71.142^^15^186^38
 ;;^UTILITY(U,$J,358.3,2377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2377,1,3,0)
 ;;=3^Infective bursitis, lft hand
 ;;^UTILITY(U,$J,358.3,2377,1,4,0)
 ;;=4^M71.142
 ;;^UTILITY(U,$J,358.3,2377,2)
 ;;=^5013134
 ;;^UTILITY(U,$J,358.3,2378,0)
 ;;=M71.151^^15^186^47
 ;;^UTILITY(U,$J,358.3,2378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2378,1,3,0)
 ;;=3^Infective bursitis, rt hip
 ;;^UTILITY(U,$J,358.3,2378,1,4,0)
 ;;=4^M71.151
 ;;^UTILITY(U,$J,358.3,2378,2)
 ;;=^5013136
 ;;^UTILITY(U,$J,358.3,2379,0)
 ;;=M71.152^^15^186^39
 ;;^UTILITY(U,$J,358.3,2379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2379,1,3,0)
 ;;=3^Infective bursitis, lft hip
 ;;^UTILITY(U,$J,358.3,2379,1,4,0)
 ;;=4^M71.152
 ;;^UTILITY(U,$J,358.3,2379,2)
 ;;=^5013137
 ;;^UTILITY(U,$J,358.3,2380,0)
 ;;=M71.161^^15^186^48
 ;;^UTILITY(U,$J,358.3,2380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2380,1,3,0)
 ;;=3^Infective bursitis, rt knee
 ;;^UTILITY(U,$J,358.3,2380,1,4,0)
 ;;=4^M71.161
 ;;^UTILITY(U,$J,358.3,2380,2)
 ;;=^5013139
 ;;^UTILITY(U,$J,358.3,2381,0)
 ;;=M71.162^^15^186^40
 ;;^UTILITY(U,$J,358.3,2381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2381,1,3,0)
 ;;=3^Infective bursitis, lft knee
 ;;^UTILITY(U,$J,358.3,2381,1,4,0)
 ;;=4^M71.162
 ;;^UTILITY(U,$J,358.3,2381,2)
 ;;=^5013140
 ;;^UTILITY(U,$J,358.3,2382,0)
 ;;=M71.171^^15^186^44
 ;;^UTILITY(U,$J,358.3,2382,1,0)
 ;;=^358.31IA^4^2
