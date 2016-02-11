IBDEI302 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50290,1,4,0)
 ;;=4^J84.117
 ;;^UTILITY(U,$J,358.3,50290,2)
 ;;=^340540
 ;;^UTILITY(U,$J,358.3,50291,0)
 ;;=M32.0^^219^2447^8
 ;;^UTILITY(U,$J,358.3,50291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50291,1,3,0)
 ;;=3^Drug-Induced Systemic Lupus Erythematosus
 ;;^UTILITY(U,$J,358.3,50291,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,50291,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,50292,0)
 ;;=M32.11^^219^2447^9
 ;;^UTILITY(U,$J,358.3,50292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50292,1,3,0)
 ;;=3^Endocarditis in Systemic Lupus Erythematosus
 ;;^UTILITY(U,$J,358.3,50292,1,4,0)
 ;;=4^M32.11
 ;;^UTILITY(U,$J,358.3,50292,2)
 ;;=^5011754
 ;;^UTILITY(U,$J,358.3,50293,0)
 ;;=J67.0^^219^2447^10
 ;;^UTILITY(U,$J,358.3,50293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50293,1,3,0)
 ;;=3^Farmer's Lung
 ;;^UTILITY(U,$J,358.3,50293,1,4,0)
 ;;=4^J67.0
 ;;^UTILITY(U,$J,358.3,50293,2)
 ;;=^44962
 ;;^UTILITY(U,$J,358.3,50294,0)
 ;;=M32.14^^219^2447^11
 ;;^UTILITY(U,$J,358.3,50294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50294,1,3,0)
 ;;=3^Glomerular Disease in Systemic Lupus Erythematosus
 ;;^UTILITY(U,$J,358.3,50294,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,50294,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,50295,0)
 ;;=J67.9^^219^2447^12
 ;;^UTILITY(U,$J,358.3,50295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50295,1,3,0)
 ;;=3^Hypersensitivity Pneumonitis d/t Unspec Organic Dust
 ;;^UTILITY(U,$J,358.3,50295,1,4,0)
 ;;=4^J67.9
 ;;^UTILITY(U,$J,358.3,50295,2)
 ;;=^5008280
 ;;^UTILITY(U,$J,358.3,50296,0)
 ;;=J84.17^^219^2447^14
 ;;^UTILITY(U,$J,358.3,50296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50296,1,3,0)
 ;;=3^Idiopathic Interstitial Pneumonia in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,50296,1,4,0)
 ;;=4^J84.17
 ;;^UTILITY(U,$J,358.3,50296,2)
 ;;=^5008301
 ;;^UTILITY(U,$J,358.3,50297,0)
 ;;=J84.113^^219^2447^15
 ;;^UTILITY(U,$J,358.3,50297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50297,1,3,0)
 ;;=3^Idiopathic Non-Specific Interstitial Pneumonitis
 ;;^UTILITY(U,$J,358.3,50297,1,4,0)
 ;;=4^J84.113
 ;;^UTILITY(U,$J,358.3,50297,2)
 ;;=^340535
 ;;^UTILITY(U,$J,358.3,50298,0)
 ;;=J84.112^^219^2447^16
 ;;^UTILITY(U,$J,358.3,50298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50298,1,3,0)
 ;;=3^Idiopathic Pulmonary Fibrosis
 ;;^UTILITY(U,$J,358.3,50298,1,4,0)
 ;;=4^J84.112
 ;;^UTILITY(U,$J,358.3,50298,2)
 ;;=^340534
 ;;^UTILITY(U,$J,358.3,50299,0)
 ;;=J84.111^^219^2447^13
 ;;^UTILITY(U,$J,358.3,50299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50299,1,3,0)
 ;;=3^Idiopathic Interstitial Pneumonia NOS
 ;;^UTILITY(U,$J,358.3,50299,1,4,0)
 ;;=4^J84.111
 ;;^UTILITY(U,$J,358.3,50299,2)
 ;;=^340610
 ;;^UTILITY(U,$J,358.3,50300,0)
 ;;=J84.9^^219^2447^17
 ;;^UTILITY(U,$J,358.3,50300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50300,1,3,0)
 ;;=3^Interstitial Pulmonary Disease,Unspec
 ;;^UTILITY(U,$J,358.3,50300,1,4,0)
 ;;=4^J84.9
 ;;^UTILITY(U,$J,358.3,50300,2)
 ;;=^5008304
 ;;^UTILITY(U,$J,358.3,50301,0)
 ;;=M32.13^^219^2447^19
 ;;^UTILITY(U,$J,358.3,50301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50301,1,3,0)
 ;;=3^Lung Involvement in Systemic Lupus Erythematosus
 ;;^UTILITY(U,$J,358.3,50301,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,50301,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,50302,0)
 ;;=J84.2^^219^2447^20
 ;;^UTILITY(U,$J,358.3,50302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50302,1,3,0)
 ;;=3^Lymphoid Interstitial Pneumonia
 ;;^UTILITY(U,$J,358.3,50302,1,4,0)
 ;;=4^J84.2
 ;;^UTILITY(U,$J,358.3,50302,2)
 ;;=^5008302
 ;;^UTILITY(U,$J,358.3,50303,0)
 ;;=D86.82^^219^2447^21
