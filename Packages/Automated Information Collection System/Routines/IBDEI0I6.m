IBDEI0I6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8152,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,8152,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,8153,0)
 ;;=B16.9^^55^536^3
 ;;^UTILITY(U,$J,358.3,8153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8153,1,3,0)
 ;;=3^Acute hepatitis B w/o delta-agent and without hepatic coma
 ;;^UTILITY(U,$J,358.3,8153,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,8153,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,8154,0)
 ;;=B18.1^^55^536^26
 ;;^UTILITY(U,$J,358.3,8154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8154,1,3,0)
 ;;=3^Chronic viral hepatitis B without delta-agent
 ;;^UTILITY(U,$J,358.3,8154,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,8154,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,8155,0)
 ;;=B17.10^^55^536^4
 ;;^UTILITY(U,$J,358.3,8155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8155,1,3,0)
 ;;=3^Acute hepatitis C without hepatic coma
 ;;^UTILITY(U,$J,358.3,8155,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,8155,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,8156,0)
 ;;=B18.2^^55^536^27
 ;;^UTILITY(U,$J,358.3,8156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8156,1,3,0)
 ;;=3^Chronic viral hepatitis C
 ;;^UTILITY(U,$J,358.3,8156,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,8156,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,8157,0)
 ;;=B18.8^^55^536^28
 ;;^UTILITY(U,$J,358.3,8157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8157,1,3,0)
 ;;=3^Chronic viral hepatitis NEC
 ;;^UTILITY(U,$J,358.3,8157,1,4,0)
 ;;=4^B18.8
 ;;^UTILITY(U,$J,358.3,8157,2)
 ;;=^5000549
 ;;^UTILITY(U,$J,358.3,8158,0)
 ;;=B18.9^^55^536^29
 ;;^UTILITY(U,$J,358.3,8158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8158,1,3,0)
 ;;=3^Chronic viral hepatitis, unspecified
 ;;^UTILITY(U,$J,358.3,8158,1,4,0)
 ;;=4^B18.9
 ;;^UTILITY(U,$J,358.3,8158,2)
 ;;=^5000550
 ;;^UTILITY(U,$J,358.3,8159,0)
 ;;=B37.0^^55^536^19
 ;;^UTILITY(U,$J,358.3,8159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8159,1,3,0)
 ;;=3^Candidal stomatitis
 ;;^UTILITY(U,$J,358.3,8159,1,4,0)
 ;;=4^B37.0
 ;;^UTILITY(U,$J,358.3,8159,2)
 ;;=^5000612
 ;;^UTILITY(U,$J,358.3,8160,0)
 ;;=B37.83^^55^536^17
 ;;^UTILITY(U,$J,358.3,8160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8160,1,3,0)
 ;;=3^Candidal cheilitis
 ;;^UTILITY(U,$J,358.3,8160,1,4,0)
 ;;=4^B37.83
 ;;^UTILITY(U,$J,358.3,8160,2)
 ;;=^5000622
 ;;^UTILITY(U,$J,358.3,8161,0)
 ;;=B37.81^^55^536^18
 ;;^UTILITY(U,$J,358.3,8161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8161,1,3,0)
 ;;=3^Candidal esophagitis
 ;;^UTILITY(U,$J,358.3,8161,1,4,0)
 ;;=4^B37.81
 ;;^UTILITY(U,$J,358.3,8161,2)
 ;;=^5000620
 ;;^UTILITY(U,$J,358.3,8162,0)
 ;;=K63.5^^55^536^84
 ;;^UTILITY(U,$J,358.3,8162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8162,1,3,0)
 ;;=3^Polyp of colon
 ;;^UTILITY(U,$J,358.3,8162,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,8162,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,8163,0)
 ;;=D73.2^^55^536^21
 ;;^UTILITY(U,$J,358.3,8163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8163,1,3,0)
 ;;=3^Chronic congestive splenomegaly
 ;;^UTILITY(U,$J,358.3,8163,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,8163,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,8164,0)
 ;;=K64.9^^55^536^60
 ;;^UTILITY(U,$J,358.3,8164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8164,1,3,0)
 ;;=3^Hemorrhoids,Unspec
 ;;^UTILITY(U,$J,358.3,8164,1,4,0)
 ;;=4^K64.9
 ;;^UTILITY(U,$J,358.3,8164,2)
 ;;=^5008775
 ;;^UTILITY(U,$J,358.3,8165,0)
 ;;=I85.00^^55^536^44
 ;;^UTILITY(U,$J,358.3,8165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8165,1,3,0)
 ;;=3^Esophageal varices without bleeding
 ;;^UTILITY(U,$J,358.3,8165,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,8165,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,8166,0)
 ;;=K20.9^^55^536^45
