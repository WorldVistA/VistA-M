IBDEI0DL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6239,1,3,0)
 ;;=3^Hepatitis B,Acute w/o Delta-Agent & w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,6239,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,6239,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,6240,0)
 ;;=B19.10^^30^391^62
 ;;^UTILITY(U,$J,358.3,6240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6240,1,3,0)
 ;;=3^Hepatitis B,Viral w/o Hepatic Coma,Unspec
 ;;^UTILITY(U,$J,358.3,6240,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,6240,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,6241,0)
 ;;=B18.1^^30^391^61
 ;;^UTILITY(U,$J,358.3,6241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6241,1,3,0)
 ;;=3^Hepatitis B,Chronic Viral w/o Delta-Agent
 ;;^UTILITY(U,$J,358.3,6241,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,6241,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,6242,0)
 ;;=B17.10^^30^391^63
 ;;^UTILITY(U,$J,358.3,6242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6242,1,3,0)
 ;;=3^Hepatitis C,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,6242,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,6242,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,6243,0)
 ;;=B18.2^^30^391^64
 ;;^UTILITY(U,$J,358.3,6243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6243,1,3,0)
 ;;=3^Hepatitis C,Chronic Viral
 ;;^UTILITY(U,$J,358.3,6243,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,6243,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,6244,0)
 ;;=B18.8^^30^391^66
 ;;^UTILITY(U,$J,358.3,6244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6244,1,3,0)
 ;;=3^Hepatitis,Oth Chronic Viral
 ;;^UTILITY(U,$J,358.3,6244,1,4,0)
 ;;=4^B18.8
 ;;^UTILITY(U,$J,358.3,6244,2)
 ;;=^5000549
 ;;^UTILITY(U,$J,358.3,6245,0)
 ;;=B17.8^^30^391^67
 ;;^UTILITY(U,$J,358.3,6245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6245,1,3,0)
 ;;=3^Hepatitis,Oth Spec Acute Viral
 ;;^UTILITY(U,$J,358.3,6245,1,4,0)
 ;;=4^B17.8
 ;;^UTILITY(U,$J,358.3,6245,2)
 ;;=^5000544
 ;;^UTILITY(U,$J,358.3,6246,0)
 ;;=B18.9^^30^391^65
 ;;^UTILITY(U,$J,358.3,6246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6246,1,3,0)
 ;;=3^Hepatitis,Chronic Viral Unspec
 ;;^UTILITY(U,$J,358.3,6246,1,4,0)
 ;;=4^B18.9
 ;;^UTILITY(U,$J,358.3,6246,2)
 ;;=^5000550
 ;;^UTILITY(U,$J,358.3,6247,0)
 ;;=B37.81^^30^391^18
 ;;^UTILITY(U,$J,358.3,6247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6247,1,3,0)
 ;;=3^Candidal Esophagitis
 ;;^UTILITY(U,$J,358.3,6247,1,4,0)
 ;;=4^B37.81
 ;;^UTILITY(U,$J,358.3,6247,2)
 ;;=^5000620
 ;;^UTILITY(U,$J,358.3,6248,0)
 ;;=D12.0^^30^391^12
 ;;^UTILITY(U,$J,358.3,6248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6248,1,3,0)
 ;;=3^Benign Neop of Cecum
 ;;^UTILITY(U,$J,358.3,6248,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,6248,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,6249,0)
 ;;=D12.6^^30^391^13
 ;;^UTILITY(U,$J,358.3,6249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6249,1,3,0)
 ;;=3^Benign Neop of Colon,Unspec
 ;;^UTILITY(U,$J,358.3,6249,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,6249,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,6250,0)
 ;;=D12.1^^30^391^10
 ;;^UTILITY(U,$J,358.3,6250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6250,1,3,0)
 ;;=3^Benign Neop of Appendix
 ;;^UTILITY(U,$J,358.3,6250,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,6250,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,6251,0)
 ;;=K63.5^^30^391^76
 ;;^UTILITY(U,$J,358.3,6251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6251,1,3,0)
 ;;=3^Polyp of Colon
 ;;^UTILITY(U,$J,358.3,6251,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,6251,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,6252,0)
 ;;=D12.3^^30^391^17
 ;;^UTILITY(U,$J,358.3,6252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6252,1,3,0)
 ;;=3^Benign Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,6252,1,4,0)
 ;;=4^D12.3
