IBDEI021 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,504,1,5,0)
 ;;=5^Hx of Insects/Arachnids Allergy
 ;;^UTILITY(U,$J,358.3,504,2)
 ;;=^338561
 ;;^UTILITY(U,$J,358.3,505,0)
 ;;=279.00^^5^47^3
 ;;^UTILITY(U,$J,358.3,505,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,505,1,4,0)
 ;;=4^279.00
 ;;^UTILITY(U,$J,358.3,505,1,5,0)
 ;;=5^Hypogammaglobulinemia
 ;;^UTILITY(U,$J,358.3,505,2)
 ;;=^190031
 ;;^UTILITY(U,$J,358.3,506,0)
 ;;=279.06^^5^47^2
 ;;^UTILITY(U,$J,358.3,506,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,506,1,4,0)
 ;;=4^279.06
 ;;^UTILITY(U,$J,358.3,506,1,5,0)
 ;;=5^Common Variable Immunodeficiency
 ;;^UTILITY(U,$J,358.3,506,2)
 ;;=^26561
 ;;^UTILITY(U,$J,358.3,507,0)
 ;;=279.9^^5^47^4
 ;;^UTILITY(U,$J,358.3,507,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,507,1,4,0)
 ;;=4^279.9
 ;;^UTILITY(U,$J,358.3,507,1,5,0)
 ;;=5^Immunodeficiency Unsp
 ;;^UTILITY(U,$J,358.3,507,2)
 ;;=^123840
 ;;^UTILITY(U,$J,358.3,508,0)
 ;;=279.10^^5^47^5
 ;;^UTILITY(U,$J,358.3,508,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,508,1,4,0)
 ;;=4^279.10
 ;;^UTILITY(U,$J,358.3,508,1,5,0)
 ;;=5^T Cell Immunodeficiency
 ;;^UTILITY(U,$J,358.3,508,2)
 ;;=^267965
 ;;^UTILITY(U,$J,358.3,509,0)
 ;;=279.00^^5^47^1
 ;;^UTILITY(U,$J,358.3,509,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,509,1,4,0)
 ;;=4^279.00
 ;;^UTILITY(U,$J,358.3,509,1,5,0)
 ;;=5^B Cell Immunodeficiency
 ;;^UTILITY(U,$J,358.3,509,2)
 ;;=^190031
 ;;^UTILITY(U,$J,358.3,510,0)
 ;;=90471^^6^48^5^^^^1
 ;;^UTILITY(U,$J,358.3,510,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,510,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,510,1,3,0)
 ;;=3^Immunization Administration (use w/ Vacs below)
 ;;^UTILITY(U,$J,358.3,511,0)
 ;;=90472^^6^48^4^^^^1
 ;;^UTILITY(U,$J,358.3,511,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,511,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,511,1,3,0)
 ;;=3^Immunization Admin, ea add
 ;;^UTILITY(U,$J,358.3,512,0)
 ;;=90632^^6^48^1^^^^1
 ;;^UTILITY(U,$J,358.3,512,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,512,1,2,0)
 ;;=2^90632
 ;;^UTILITY(U,$J,358.3,512,1,3,0)
 ;;=3^Hepatitis A Vaccine
 ;;^UTILITY(U,$J,358.3,513,0)
 ;;=90746^^6^48^3^^^^1
 ;;^UTILITY(U,$J,358.3,513,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,513,1,2,0)
 ;;=2^90746
 ;;^UTILITY(U,$J,358.3,513,1,3,0)
 ;;=3^Hepatitis B Vaccine
 ;;^UTILITY(U,$J,358.3,514,0)
 ;;=90636^^6^48^2^^^^1
 ;;^UTILITY(U,$J,358.3,514,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,514,1,2,0)
 ;;=2^90636
 ;;^UTILITY(U,$J,358.3,514,1,3,0)
 ;;=3^Hepatitis A&B Vaccine
 ;;^UTILITY(U,$J,358.3,515,0)
 ;;=90707^^6^48^7^^^^1
 ;;^UTILITY(U,$J,358.3,515,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,515,1,2,0)
 ;;=2^90707
 ;;^UTILITY(U,$J,358.3,515,1,3,0)
 ;;=3^MMR Vaccine
 ;;^UTILITY(U,$J,358.3,516,0)
 ;;=90658^^6^48^6^^^^1
 ;;^UTILITY(U,$J,358.3,516,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,516,1,2,0)
 ;;=2^90658
 ;;^UTILITY(U,$J,358.3,516,1,3,0)
 ;;=3^Influenza Vaccine
 ;;^UTILITY(U,$J,358.3,517,0)
 ;;=90732^^6^48^8^^^^1
 ;;^UTILITY(U,$J,358.3,517,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,517,1,2,0)
 ;;=2^90732
 ;;^UTILITY(U,$J,358.3,517,1,3,0)
 ;;=3^Pneumococcal Vaccine
 ;;^UTILITY(U,$J,358.3,518,0)
 ;;=90715^^6^48^10^^^^1
 ;;^UTILITY(U,$J,358.3,518,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,518,1,2,0)
 ;;=2^90715
 ;;^UTILITY(U,$J,358.3,518,1,3,0)
 ;;=3^TDap Vaccine
 ;;^UTILITY(U,$J,358.3,519,0)
 ;;=90714^^6^48^9^^^^1
 ;;^UTILITY(U,$J,358.3,519,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,519,1,2,0)
 ;;=2^90714
 ;;^UTILITY(U,$J,358.3,519,1,3,0)
 ;;=3^TD Vaccine
 ;;^UTILITY(U,$J,358.3,520,0)
 ;;=86485^^6^49^1^^^^1
 ;;^UTILITY(U,$J,358.3,520,1,0)
 ;;=^358.31IA^3^2
