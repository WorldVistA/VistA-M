IBDEI0HT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8236,1,3,0)
 ;;=3^Pain in left hip
 ;;^UTILITY(U,$J,358.3,8236,1,4,0)
 ;;=4^M25.552
 ;;^UTILITY(U,$J,358.3,8236,2)
 ;;=^5011612
 ;;^UTILITY(U,$J,358.3,8237,0)
 ;;=M25.561^^33^432^37
 ;;^UTILITY(U,$J,358.3,8237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8237,1,3,0)
 ;;=3^Pain in right knee
 ;;^UTILITY(U,$J,358.3,8237,1,4,0)
 ;;=4^M25.561
 ;;^UTILITY(U,$J,358.3,8237,2)
 ;;=^5011614
 ;;^UTILITY(U,$J,358.3,8238,0)
 ;;=M25.562^^33^432^34
 ;;^UTILITY(U,$J,358.3,8238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8238,1,3,0)
 ;;=3^Pain in left knee
 ;;^UTILITY(U,$J,358.3,8238,1,4,0)
 ;;=4^M25.562
 ;;^UTILITY(U,$J,358.3,8238,2)
 ;;=^5011615
 ;;^UTILITY(U,$J,358.3,8239,0)
 ;;=M54.2^^33^432^9
 ;;^UTILITY(U,$J,358.3,8239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8239,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,8239,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,8239,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,8240,0)
 ;;=M54.5^^33^432^22
 ;;^UTILITY(U,$J,358.3,8240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8240,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,8240,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,8240,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,8241,0)
 ;;=M54.9^^33^432^15
 ;;^UTILITY(U,$J,358.3,8241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8241,1,3,0)
 ;;=3^Dorsalgia, unspecified
 ;;^UTILITY(U,$J,358.3,8241,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,8241,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,8242,0)
 ;;=R51.^^33^432^18
 ;;^UTILITY(U,$J,358.3,8242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8242,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,8242,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,8242,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,8243,0)
 ;;=R05.^^33^432^14
 ;;^UTILITY(U,$J,358.3,8243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8243,1,3,0)
 ;;=3^Cough
 ;;^UTILITY(U,$J,358.3,8243,1,4,0)
 ;;=4^R05.
 ;;^UTILITY(U,$J,358.3,8243,2)
 ;;=^5019179
 ;;^UTILITY(U,$J,358.3,8244,0)
 ;;=R07.9^^33^432^10
 ;;^UTILITY(U,$J,358.3,8244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8244,1,3,0)
 ;;=3^Chest pain, unspecified
 ;;^UTILITY(U,$J,358.3,8244,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,8244,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,8245,0)
 ;;=R10.9^^33^432^1
 ;;^UTILITY(U,$J,358.3,8245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8245,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,8245,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,8245,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,8246,0)
 ;;=R76.11^^33^432^31
 ;;^UTILITY(U,$J,358.3,8246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8246,1,3,0)
 ;;=3^Nonspecific reaction to skin test w/o active tuberculosis
 ;;^UTILITY(U,$J,358.3,8246,1,4,0)
 ;;=4^R76.11
 ;;^UTILITY(U,$J,358.3,8246,2)
 ;;=^5019570
 ;;^UTILITY(U,$J,358.3,8247,0)
 ;;=R76.12^^33^432^30
 ;;^UTILITY(U,$J,358.3,8247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8247,1,3,0)
 ;;=3^Nonspec reaction to gamma intrfrn respns w/o actv tubrclosis
 ;;^UTILITY(U,$J,358.3,8247,1,4,0)
 ;;=4^R76.12
 ;;^UTILITY(U,$J,358.3,8247,2)
 ;;=^5019571
 ;;^UTILITY(U,$J,358.3,8248,0)
 ;;=R03.0^^33^432^16
 ;;^UTILITY(U,$J,358.3,8248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8248,1,3,0)
 ;;=3^Elevated blood-pressure reading, w/o diagnosis of htn
 ;;^UTILITY(U,$J,358.3,8248,1,4,0)
 ;;=4^R03.0
 ;;^UTILITY(U,$J,358.3,8248,2)
 ;;=^5019171
 ;;^UTILITY(U,$J,358.3,8249,0)
 ;;=M25.50^^33^432^32
 ;;^UTILITY(U,$J,358.3,8249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8249,1,3,0)
 ;;=3^Pain in Joint,Unspec
 ;;^UTILITY(U,$J,358.3,8249,1,4,0)
 ;;=4^M25.50
 ;;^UTILITY(U,$J,358.3,8249,2)
 ;;=^5011601
