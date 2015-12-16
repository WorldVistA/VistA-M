IBDEI03D ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1038,1,3,0)
 ;;=3^Hepatitis A without hepatic coma
 ;;^UTILITY(U,$J,358.3,1038,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,1038,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,1039,0)
 ;;=B16.9^^3^37^3
 ;;^UTILITY(U,$J,358.3,1039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1039,1,3,0)
 ;;=3^Acute hepatitis B w/o delta-agent and without hepatic coma
 ;;^UTILITY(U,$J,358.3,1039,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,1039,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,1040,0)
 ;;=B18.1^^3^37^26
 ;;^UTILITY(U,$J,358.3,1040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1040,1,3,0)
 ;;=3^Chronic viral hepatitis B without delta-agent
 ;;^UTILITY(U,$J,358.3,1040,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,1040,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,1041,0)
 ;;=B17.10^^3^37^4
 ;;^UTILITY(U,$J,358.3,1041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1041,1,3,0)
 ;;=3^Acute hepatitis C without hepatic coma
 ;;^UTILITY(U,$J,358.3,1041,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,1041,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,1042,0)
 ;;=B18.2^^3^37^27
 ;;^UTILITY(U,$J,358.3,1042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1042,1,3,0)
 ;;=3^Chronic viral hepatitis C
 ;;^UTILITY(U,$J,358.3,1042,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,1042,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,1043,0)
 ;;=B18.8^^3^37^28
 ;;^UTILITY(U,$J,358.3,1043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1043,1,3,0)
 ;;=3^Chronic viral hepatitis NEC
 ;;^UTILITY(U,$J,358.3,1043,1,4,0)
 ;;=4^B18.8
 ;;^UTILITY(U,$J,358.3,1043,2)
 ;;=^5000549
 ;;^UTILITY(U,$J,358.3,1044,0)
 ;;=B18.9^^3^37^29
 ;;^UTILITY(U,$J,358.3,1044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1044,1,3,0)
 ;;=3^Chronic viral hepatitis, unspecified
 ;;^UTILITY(U,$J,358.3,1044,1,4,0)
 ;;=4^B18.9
 ;;^UTILITY(U,$J,358.3,1044,2)
 ;;=^5000550
 ;;^UTILITY(U,$J,358.3,1045,0)
 ;;=B37.0^^3^37^19
 ;;^UTILITY(U,$J,358.3,1045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1045,1,3,0)
 ;;=3^Candidal stomatitis
 ;;^UTILITY(U,$J,358.3,1045,1,4,0)
 ;;=4^B37.0
 ;;^UTILITY(U,$J,358.3,1045,2)
 ;;=^5000612
 ;;^UTILITY(U,$J,358.3,1046,0)
 ;;=B37.83^^3^37^17
 ;;^UTILITY(U,$J,358.3,1046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1046,1,3,0)
 ;;=3^Candidal cheilitis
 ;;^UTILITY(U,$J,358.3,1046,1,4,0)
 ;;=4^B37.83
 ;;^UTILITY(U,$J,358.3,1046,2)
 ;;=^5000622
 ;;^UTILITY(U,$J,358.3,1047,0)
 ;;=B37.81^^3^37^18
 ;;^UTILITY(U,$J,358.3,1047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1047,1,3,0)
 ;;=3^Candidal esophagitis
 ;;^UTILITY(U,$J,358.3,1047,1,4,0)
 ;;=4^B37.81
 ;;^UTILITY(U,$J,358.3,1047,2)
 ;;=^5000620
 ;;^UTILITY(U,$J,358.3,1048,0)
 ;;=K63.5^^3^37^84
 ;;^UTILITY(U,$J,358.3,1048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1048,1,3,0)
 ;;=3^Polyp of colon
 ;;^UTILITY(U,$J,358.3,1048,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,1048,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,1049,0)
 ;;=D73.2^^3^37^21
 ;;^UTILITY(U,$J,358.3,1049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1049,1,3,0)
 ;;=3^Chronic congestive splenomegaly
 ;;^UTILITY(U,$J,358.3,1049,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,1049,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,1050,0)
 ;;=K64.9^^3^37^60
 ;;^UTILITY(U,$J,358.3,1050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1050,1,3,0)
 ;;=3^Hemorrhoids,Unspec
 ;;^UTILITY(U,$J,358.3,1050,1,4,0)
 ;;=4^K64.9
 ;;^UTILITY(U,$J,358.3,1050,2)
 ;;=^5008775
 ;;^UTILITY(U,$J,358.3,1051,0)
 ;;=I85.00^^3^37^44
 ;;^UTILITY(U,$J,358.3,1051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1051,1,3,0)
 ;;=3^Esophageal varices without bleeding
 ;;^UTILITY(U,$J,358.3,1051,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,1051,2)
 ;;=^5008023
