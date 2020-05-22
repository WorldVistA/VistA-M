IBDEI0H2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7401,1,4,0)
 ;;=4^M85.80
 ;;^UTILITY(U,$J,358.3,7401,2)
 ;;=^5014473
 ;;^UTILITY(U,$J,358.3,7402,0)
 ;;=M26.601^^58^473^185
 ;;^UTILITY(U,$J,358.3,7402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7402,1,3,0)
 ;;=3^Temporomandibular Joint Disorder,Right Unspec
 ;;^UTILITY(U,$J,358.3,7402,1,4,0)
 ;;=4^M26.601
 ;;^UTILITY(U,$J,358.3,7402,2)
 ;;=^5138792
 ;;^UTILITY(U,$J,358.3,7403,0)
 ;;=M26.602^^58^473^184
 ;;^UTILITY(U,$J,358.3,7403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7403,1,3,0)
 ;;=3^Temporomandibular Joint Disorder,Left Unspec
 ;;^UTILITY(U,$J,358.3,7403,1,4,0)
 ;;=4^M26.602
 ;;^UTILITY(U,$J,358.3,7403,2)
 ;;=^5138793
 ;;^UTILITY(U,$J,358.3,7404,0)
 ;;=M26.603^^58^473^183
 ;;^UTILITY(U,$J,358.3,7404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7404,1,3,0)
 ;;=3^Temporomandibular Joint Disorder,Bilateral Unspec
 ;;^UTILITY(U,$J,358.3,7404,1,4,0)
 ;;=4^M26.603
 ;;^UTILITY(U,$J,358.3,7404,2)
 ;;=^5138794
 ;;^UTILITY(U,$J,358.3,7405,0)
 ;;=M26.609^^58^473^186
 ;;^UTILITY(U,$J,358.3,7405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7405,1,3,0)
 ;;=3^Temporomandibular Joint Disorder,Unspec Side
 ;;^UTILITY(U,$J,358.3,7405,1,4,0)
 ;;=4^M26.609
 ;;^UTILITY(U,$J,358.3,7405,2)
 ;;=^5138795
 ;;^UTILITY(U,$J,358.3,7406,0)
 ;;=M79.10^^58^473^64
 ;;^UTILITY(U,$J,358.3,7406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7406,1,3,0)
 ;;=3^Myalgia,Site Unspec
 ;;^UTILITY(U,$J,358.3,7406,1,4,0)
 ;;=4^M79.10
 ;;^UTILITY(U,$J,358.3,7406,2)
 ;;=^5157394
 ;;^UTILITY(U,$J,358.3,7407,0)
 ;;=M79.11^^58^473^62
 ;;^UTILITY(U,$J,358.3,7407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7407,1,3,0)
 ;;=3^Myalgia,Mastication Muscle
 ;;^UTILITY(U,$J,358.3,7407,1,4,0)
 ;;=4^M79.11
 ;;^UTILITY(U,$J,358.3,7407,2)
 ;;=^5157395
 ;;^UTILITY(U,$J,358.3,7408,0)
 ;;=M79.12^^58^473^61
 ;;^UTILITY(U,$J,358.3,7408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7408,1,3,0)
 ;;=3^Myalgia,Auxiliary Muscles,Head & Neck
 ;;^UTILITY(U,$J,358.3,7408,1,4,0)
 ;;=4^M79.12
 ;;^UTILITY(U,$J,358.3,7408,2)
 ;;=^5157396
 ;;^UTILITY(U,$J,358.3,7409,0)
 ;;=M79.18^^58^473^63
 ;;^UTILITY(U,$J,358.3,7409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7409,1,3,0)
 ;;=3^Myalgia,Other Site
 ;;^UTILITY(U,$J,358.3,7409,1,4,0)
 ;;=4^M79.18
 ;;^UTILITY(U,$J,358.3,7409,2)
 ;;=^5157397
 ;;^UTILITY(U,$J,358.3,7410,0)
 ;;=B02.0^^58^474^46
 ;;^UTILITY(U,$J,358.3,7410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7410,1,3,0)
 ;;=3^Zoster Encephalitis
 ;;^UTILITY(U,$J,358.3,7410,1,4,0)
 ;;=4^B02.0
 ;;^UTILITY(U,$J,358.3,7410,2)
 ;;=^5000488
 ;;^UTILITY(U,$J,358.3,7411,0)
 ;;=B02.29^^58^474^36
 ;;^UTILITY(U,$J,358.3,7411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7411,1,3,0)
 ;;=3^Postherpetic Nervous System Involvement,Other
 ;;^UTILITY(U,$J,358.3,7411,1,4,0)
 ;;=4^B02.29
 ;;^UTILITY(U,$J,358.3,7411,2)
 ;;=^5000492
 ;;^UTILITY(U,$J,358.3,7412,0)
 ;;=F03.90^^58^474^10
 ;;^UTILITY(U,$J,358.3,7412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7412,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,7412,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,7412,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,7413,0)
 ;;=F03.91^^58^474^9
 ;;^UTILITY(U,$J,358.3,7413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7413,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,7413,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,7413,2)
 ;;=^5133350
