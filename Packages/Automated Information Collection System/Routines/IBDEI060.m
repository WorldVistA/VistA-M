IBDEI060 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2281,1,3,0)
 ;;=3^Pain in right hip
 ;;^UTILITY(U,$J,358.3,2281,1,4,0)
 ;;=4^M25.551
 ;;^UTILITY(U,$J,358.3,2281,2)
 ;;=^5011611
 ;;^UTILITY(U,$J,358.3,2282,0)
 ;;=M25.552^^4^63^33
 ;;^UTILITY(U,$J,358.3,2282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2282,1,3,0)
 ;;=3^Pain in left hip
 ;;^UTILITY(U,$J,358.3,2282,1,4,0)
 ;;=4^M25.552
 ;;^UTILITY(U,$J,358.3,2282,2)
 ;;=^5011612
 ;;^UTILITY(U,$J,358.3,2283,0)
 ;;=M25.561^^4^63^37
 ;;^UTILITY(U,$J,358.3,2283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2283,1,3,0)
 ;;=3^Pain in right knee
 ;;^UTILITY(U,$J,358.3,2283,1,4,0)
 ;;=4^M25.561
 ;;^UTILITY(U,$J,358.3,2283,2)
 ;;=^5011614
 ;;^UTILITY(U,$J,358.3,2284,0)
 ;;=M25.562^^4^63^34
 ;;^UTILITY(U,$J,358.3,2284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2284,1,3,0)
 ;;=3^Pain in left knee
 ;;^UTILITY(U,$J,358.3,2284,1,4,0)
 ;;=4^M25.562
 ;;^UTILITY(U,$J,358.3,2284,2)
 ;;=^5011615
 ;;^UTILITY(U,$J,358.3,2285,0)
 ;;=M54.2^^4^63^9
 ;;^UTILITY(U,$J,358.3,2285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2285,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,2285,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,2285,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,2286,0)
 ;;=M54.5^^4^63^22
 ;;^UTILITY(U,$J,358.3,2286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2286,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,2286,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,2286,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,2287,0)
 ;;=M54.9^^4^63^15
 ;;^UTILITY(U,$J,358.3,2287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2287,1,3,0)
 ;;=3^Dorsalgia, unspecified
 ;;^UTILITY(U,$J,358.3,2287,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,2287,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,2288,0)
 ;;=R51.^^4^63^18
 ;;^UTILITY(U,$J,358.3,2288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2288,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,2288,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,2288,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,2289,0)
 ;;=R05.^^4^63^14
 ;;^UTILITY(U,$J,358.3,2289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2289,1,3,0)
 ;;=3^Cough
 ;;^UTILITY(U,$J,358.3,2289,1,4,0)
 ;;=4^R05.
 ;;^UTILITY(U,$J,358.3,2289,2)
 ;;=^5019179
 ;;^UTILITY(U,$J,358.3,2290,0)
 ;;=R07.9^^4^63^10
 ;;^UTILITY(U,$J,358.3,2290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2290,1,3,0)
 ;;=3^Chest pain, unspecified
 ;;^UTILITY(U,$J,358.3,2290,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,2290,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,2291,0)
 ;;=R10.9^^4^63^1
 ;;^UTILITY(U,$J,358.3,2291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2291,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,2291,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,2291,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,2292,0)
 ;;=R76.11^^4^63^31
 ;;^UTILITY(U,$J,358.3,2292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2292,1,3,0)
 ;;=3^Nonspecific reaction to skin test w/o active tuberculosis
 ;;^UTILITY(U,$J,358.3,2292,1,4,0)
 ;;=4^R76.11
 ;;^UTILITY(U,$J,358.3,2292,2)
 ;;=^5019570
 ;;^UTILITY(U,$J,358.3,2293,0)
 ;;=R76.12^^4^63^30
 ;;^UTILITY(U,$J,358.3,2293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2293,1,3,0)
 ;;=3^Nonspec reaction to gamma intrfrn respns w/o actv tubrclosis
 ;;^UTILITY(U,$J,358.3,2293,1,4,0)
 ;;=4^R76.12
 ;;^UTILITY(U,$J,358.3,2293,2)
 ;;=^5019571
 ;;^UTILITY(U,$J,358.3,2294,0)
 ;;=R03.0^^4^63^16
 ;;^UTILITY(U,$J,358.3,2294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2294,1,3,0)
 ;;=3^Elevated blood-pressure reading, w/o diagnosis of htn
 ;;^UTILITY(U,$J,358.3,2294,1,4,0)
 ;;=4^R03.0
 ;;^UTILITY(U,$J,358.3,2294,2)
 ;;=^5019171
 ;;^UTILITY(U,$J,358.3,2295,0)
 ;;=M25.50^^4^63^32
