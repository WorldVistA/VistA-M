IBDEI06A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2342,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,2342,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,2342,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,2343,0)
 ;;=I95.2^^19^196^8
 ;;^UTILITY(U,$J,358.3,2343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2343,1,3,0)
 ;;=3^Hypotension d/t Drugs
 ;;^UTILITY(U,$J,358.3,2343,1,4,0)
 ;;=4^I95.2
 ;;^UTILITY(U,$J,358.3,2343,2)
 ;;=^5008077
 ;;^UTILITY(U,$J,358.3,2344,0)
 ;;=I95.81^^19^196^11
 ;;^UTILITY(U,$J,358.3,2344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2344,1,3,0)
 ;;=3^Postprocedural Hypotension
 ;;^UTILITY(U,$J,358.3,2344,1,4,0)
 ;;=4^I95.81
 ;;^UTILITY(U,$J,358.3,2344,2)
 ;;=^5008078
 ;;^UTILITY(U,$J,358.3,2345,0)
 ;;=I95.9^^19^196^9
 ;;^UTILITY(U,$J,358.3,2345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2345,1,3,0)
 ;;=3^Hypotension,Unspec
 ;;^UTILITY(U,$J,358.3,2345,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,2345,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,2346,0)
 ;;=B25.9^^19^197^5
 ;;^UTILITY(U,$J,358.3,2346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2346,1,3,0)
 ;;=3^CMV Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2346,1,4,0)
 ;;=4^B25.9
 ;;^UTILITY(U,$J,358.3,2346,2)
 ;;=^5000560
 ;;^UTILITY(U,$J,358.3,2347,0)
 ;;=I30.1^^19^197^7
 ;;^UTILITY(U,$J,358.3,2347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2347,1,3,0)
 ;;=3^Infective Pericarditis
 ;;^UTILITY(U,$J,358.3,2347,1,4,0)
 ;;=4^I30.1
 ;;^UTILITY(U,$J,358.3,2347,2)
 ;;=^5007158
 ;;^UTILITY(U,$J,358.3,2348,0)
 ;;=I30.0^^19^197^1
 ;;^UTILITY(U,$J,358.3,2348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2348,1,3,0)
 ;;=3^Acute Nonspecific Idiopathic Pericarditis
 ;;^UTILITY(U,$J,358.3,2348,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,2348,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,2349,0)
 ;;=I33.0^^19^197^3
 ;;^UTILITY(U,$J,358.3,2349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2349,1,3,0)
 ;;=3^Acute/Subacute Infective Endocarditis
 ;;^UTILITY(U,$J,358.3,2349,1,4,0)
 ;;=4^I33.0
 ;;^UTILITY(U,$J,358.3,2349,2)
 ;;=^5007167
 ;;^UTILITY(U,$J,358.3,2350,0)
 ;;=I33.9^^19^197^2
 ;;^UTILITY(U,$J,358.3,2350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2350,1,3,0)
 ;;=3^Acute/Subacute Endocarditis,Unspec
 ;;^UTILITY(U,$J,358.3,2350,1,4,0)
 ;;=4^I33.9
 ;;^UTILITY(U,$J,358.3,2350,2)
 ;;=^5007168
 ;;^UTILITY(U,$J,358.3,2351,0)
 ;;=I31.0^^19^197^4
 ;;^UTILITY(U,$J,358.3,2351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2351,1,3,0)
 ;;=3^Adhesive Pericarditis,Chronic
 ;;^UTILITY(U,$J,358.3,2351,1,4,0)
 ;;=4^I31.0
 ;;^UTILITY(U,$J,358.3,2351,2)
 ;;=^5007161
 ;;^UTILITY(U,$J,358.3,2352,0)
 ;;=I31.1^^19^197^6
 ;;^UTILITY(U,$J,358.3,2352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2352,1,3,0)
 ;;=3^Constrictive Pericarditis,Chronic
 ;;^UTILITY(U,$J,358.3,2352,1,4,0)
 ;;=4^I31.1
 ;;^UTILITY(U,$J,358.3,2352,2)
 ;;=^5007162
 ;;^UTILITY(U,$J,358.3,2353,0)
 ;;=E78.0^^19^198^5
 ;;^UTILITY(U,$J,358.3,2353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2353,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,2353,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,2353,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,2354,0)
 ;;=E78.1^^19^198^6
 ;;^UTILITY(U,$J,358.3,2354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2354,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,2354,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,2354,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,2355,0)
 ;;=E78.2^^19^198^4
 ;;^UTILITY(U,$J,358.3,2355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2355,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,2355,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,2355,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,2356,0)
 ;;=E78.4^^19^198^1
