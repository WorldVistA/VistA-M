IBDEI0IC ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8253,0)
 ;;=B15.9^^39^397^66
 ;;^UTILITY(U,$J,358.3,8253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8253,1,3,0)
 ;;=3^Hepatitis A,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,8253,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,8253,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,8254,0)
 ;;=B16.9^^39^397^67
 ;;^UTILITY(U,$J,358.3,8254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8254,1,3,0)
 ;;=3^Hepatitis B,Acute w/o Delta-Agent & w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,8254,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,8254,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,8255,0)
 ;;=B19.10^^39^397^69
 ;;^UTILITY(U,$J,358.3,8255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8255,1,3,0)
 ;;=3^Hepatitis B,Viral w/o Hepatic Coma,Unspec
 ;;^UTILITY(U,$J,358.3,8255,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,8255,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,8256,0)
 ;;=B18.1^^39^397^68
 ;;^UTILITY(U,$J,358.3,8256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8256,1,3,0)
 ;;=3^Hepatitis B,Chronic Viral w/o Delta-Agent
 ;;^UTILITY(U,$J,358.3,8256,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,8256,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,8257,0)
 ;;=B17.10^^39^397^70
 ;;^UTILITY(U,$J,358.3,8257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8257,1,3,0)
 ;;=3^Hepatitis C,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,8257,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,8257,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,8258,0)
 ;;=B18.2^^39^397^71
 ;;^UTILITY(U,$J,358.3,8258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8258,1,3,0)
 ;;=3^Hepatitis C,Chronic Viral
 ;;^UTILITY(U,$J,358.3,8258,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,8258,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,8259,0)
 ;;=B18.8^^39^397^73
 ;;^UTILITY(U,$J,358.3,8259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8259,1,3,0)
 ;;=3^Hepatitis,Oth Chronic Viral
 ;;^UTILITY(U,$J,358.3,8259,1,4,0)
 ;;=4^B18.8
 ;;^UTILITY(U,$J,358.3,8259,2)
 ;;=^5000549
 ;;^UTILITY(U,$J,358.3,8260,0)
 ;;=B17.8^^39^397^74
 ;;^UTILITY(U,$J,358.3,8260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8260,1,3,0)
 ;;=3^Hepatitis,Oth Spec Acute Viral
 ;;^UTILITY(U,$J,358.3,8260,1,4,0)
 ;;=4^B17.8
 ;;^UTILITY(U,$J,358.3,8260,2)
 ;;=^5000544
 ;;^UTILITY(U,$J,358.3,8261,0)
 ;;=B18.9^^39^397^72
 ;;^UTILITY(U,$J,358.3,8261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8261,1,3,0)
 ;;=3^Hepatitis,Chronic Viral Unspec
 ;;^UTILITY(U,$J,358.3,8261,1,4,0)
 ;;=4^B18.9
 ;;^UTILITY(U,$J,358.3,8261,2)
 ;;=^5000550
 ;;^UTILITY(U,$J,358.3,8262,0)
 ;;=B37.81^^39^397^18
 ;;^UTILITY(U,$J,358.3,8262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8262,1,3,0)
 ;;=3^Candidal Esophagitis
 ;;^UTILITY(U,$J,358.3,8262,1,4,0)
 ;;=4^B37.81
 ;;^UTILITY(U,$J,358.3,8262,2)
 ;;=^5000620
 ;;^UTILITY(U,$J,358.3,8263,0)
 ;;=D12.0^^39^397^12
 ;;^UTILITY(U,$J,358.3,8263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8263,1,3,0)
 ;;=3^Benign Neop of Cecum
 ;;^UTILITY(U,$J,358.3,8263,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,8263,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,8264,0)
 ;;=D12.6^^39^397^13
 ;;^UTILITY(U,$J,358.3,8264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8264,1,3,0)
 ;;=3^Benign Neop of Colon,Unspec
 ;;^UTILITY(U,$J,358.3,8264,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,8264,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,8265,0)
 ;;=D12.1^^39^397^10
 ;;^UTILITY(U,$J,358.3,8265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8265,1,3,0)
 ;;=3^Benign Neop of Appendix
