IBDEI138 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18489,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,18490,0)
 ;;=D47.1^^79^879^76
 ;;^UTILITY(U,$J,358.3,18490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18490,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,18490,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,18490,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,18491,0)
 ;;=D47.9^^79^879^77
 ;;^UTILITY(U,$J,358.3,18491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18491,1,3,0)
 ;;=3^Neop of Uncertain Behavior of Lymphoid/Hematpoetc/Related Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,18491,1,4,0)
 ;;=4^D47.9
 ;;^UTILITY(U,$J,358.3,18491,2)
 ;;=^5002260
 ;;^UTILITY(U,$J,358.3,18492,0)
 ;;=D47.Z9^^79^879^78
 ;;^UTILITY(U,$J,358.3,18492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18492,1,3,0)
 ;;=3^Neop of Uncertain Behavior of Lymphoid/Hematpoetc/Related Tissue,NEC
 ;;^UTILITY(U,$J,358.3,18492,1,4,0)
 ;;=4^D47.Z9
 ;;^UTILITY(U,$J,358.3,18492,2)
 ;;=^5002262
 ;;^UTILITY(U,$J,358.3,18493,0)
 ;;=A15.0^^79^880^103
 ;;^UTILITY(U,$J,358.3,18493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18493,1,3,0)
 ;;=3^Tuberculosis of Lung
 ;;^UTILITY(U,$J,358.3,18493,1,4,0)
 ;;=4^A15.0
 ;;^UTILITY(U,$J,358.3,18493,2)
 ;;=^5000062
 ;;^UTILITY(U,$J,358.3,18494,0)
 ;;=A31.0^^79^880^87
 ;;^UTILITY(U,$J,358.3,18494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18494,1,3,0)
 ;;=3^Pulmonary Mycobacterial Infection
 ;;^UTILITY(U,$J,358.3,18494,1,4,0)
 ;;=4^A31.0
 ;;^UTILITY(U,$J,358.3,18494,2)
 ;;=^5000149
 ;;^UTILITY(U,$J,358.3,18495,0)
 ;;=B95.5^^79^880^93
 ;;^UTILITY(U,$J,358.3,18495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18495,1,3,0)
 ;;=3^Streptococcus in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,18495,1,4,0)
 ;;=4^B95.5
 ;;^UTILITY(U,$J,358.3,18495,2)
 ;;=^5000840
 ;;^UTILITY(U,$J,358.3,18496,0)
 ;;=B95.0^^79^880^95
 ;;^UTILITY(U,$J,358.3,18496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18496,1,3,0)
 ;;=3^Streptococcus,Group A,in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,18496,1,4,0)
 ;;=4^B95.0
 ;;^UTILITY(U,$J,358.3,18496,2)
 ;;=^5000835
 ;;^UTILITY(U,$J,358.3,18497,0)
 ;;=B95.1^^79^880^96
 ;;^UTILITY(U,$J,358.3,18497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18497,1,3,0)
 ;;=3^Streptococcus,Group B,in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,18497,1,4,0)
 ;;=4^B95.1
 ;;^UTILITY(U,$J,358.3,18497,2)
 ;;=^5000836
 ;;^UTILITY(U,$J,358.3,18498,0)
 ;;=B95.4^^79^880^94
 ;;^UTILITY(U,$J,358.3,18498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18498,1,3,0)
 ;;=3^Streptococcus in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,18498,1,4,0)
 ;;=4^B95.4
 ;;^UTILITY(U,$J,358.3,18498,2)
 ;;=^5000839
 ;;^UTILITY(U,$J,358.3,18499,0)
 ;;=B95.2^^79^880^48
 ;;^UTILITY(U,$J,358.3,18499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18499,1,3,0)
 ;;=3^Enterococcus in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,18499,1,4,0)
 ;;=4^B95.2
 ;;^UTILITY(U,$J,358.3,18499,2)
 ;;=^5000837
 ;;^UTILITY(U,$J,358.3,18500,0)
 ;;=B95.8^^79^880^92
 ;;^UTILITY(U,$J,358.3,18500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18500,1,3,0)
 ;;=3^Staphylococcus,Unspec,in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,18500,1,4,0)
 ;;=4^B95.8
 ;;^UTILITY(U,$J,358.3,18500,2)
 ;;=^5000844
 ;;^UTILITY(U,$J,358.3,18501,0)
 ;;=B95.61^^79^880^77
 ;;^UTILITY(U,$J,358.3,18501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18501,1,3,0)
 ;;=3^Methicillin Suscept Staph Infct in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,18501,1,4,0)
 ;;=4^B95.61
 ;;^UTILITY(U,$J,358.3,18501,2)
 ;;=^5000841
 ;;^UTILITY(U,$J,358.3,18502,0)
 ;;=B95.62^^79^880^76
