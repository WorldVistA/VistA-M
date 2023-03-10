IBDEI1K0 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25185,1,3,0)
 ;;=3^Indiv Health Education/Counseling
 ;;^UTILITY(U,$J,358.3,25186,0)
 ;;=Q3014^^91^1138^13^^^^1
 ;;^UTILITY(U,$J,358.3,25186,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25186,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,25186,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,25187,0)
 ;;=G0177^^91^1138^14^^^^1
 ;;^UTILITY(U,$J,358.3,25187,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25187,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,25187,1,3,0)
 ;;=3^Train/Ed Svcs for Care/Tx of Disabiling MH Problem,45+ min
 ;;^UTILITY(U,$J,358.3,25188,0)
 ;;=97537^^91^1138^1^^^^1
 ;;^UTILITY(U,$J,358.3,25188,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25188,1,2,0)
 ;;=2^97537
 ;;^UTILITY(U,$J,358.3,25188,1,3,0)
 ;;=3^Community/Work Reinteg Trng,1-1,Ea 15 min
 ;;^UTILITY(U,$J,358.3,25189,0)
 ;;=H2000^^91^1138^2^^^^1
 ;;^UTILITY(U,$J,358.3,25189,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25189,1,2,0)
 ;;=2^H2000
 ;;^UTILITY(U,$J,358.3,25189,1,3,0)
 ;;=3^Comprehensive Multidisc Evaluation
 ;;^UTILITY(U,$J,358.3,25190,0)
 ;;=H2011^^91^1138^3^^^^1
 ;;^UTILITY(U,$J,358.3,25190,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25190,1,2,0)
 ;;=2^H2011
 ;;^UTILITY(U,$J,358.3,25190,1,3,0)
 ;;=3^Crisis Intervention Svc,per 15 min
 ;;^UTILITY(U,$J,358.3,25191,0)
 ;;=H0031^^91^1138^4^^^^1
 ;;^UTILITY(U,$J,358.3,25191,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25191,1,2,0)
 ;;=2^H0031
 ;;^UTILITY(U,$J,358.3,25191,1,3,0)
 ;;=3^MH Assessment by Non-Phys
 ;;^UTILITY(U,$J,358.3,25192,0)
 ;;=H0032^^91^1138^5^^^^1
 ;;^UTILITY(U,$J,358.3,25192,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25192,1,2,0)
 ;;=2^H0032
 ;;^UTILITY(U,$J,358.3,25192,1,3,0)
 ;;=3^MH Svc Plan Development by Non-Phys
 ;;^UTILITY(U,$J,358.3,25193,0)
 ;;=H2025^^91^1138^6^^^^1
 ;;^UTILITY(U,$J,358.3,25193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25193,1,2,0)
 ;;=2^H2025
 ;;^UTILITY(U,$J,358.3,25193,1,3,0)
 ;;=3^Ongoing Supp to Maint Employ,per 15 min
 ;;^UTILITY(U,$J,358.3,25194,0)
 ;;=H2026^^91^1138^7^^^^1
 ;;^UTILITY(U,$J,358.3,25194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25194,1,2,0)
 ;;=2^H2026
 ;;^UTILITY(U,$J,358.3,25194,1,3,0)
 ;;=3^Ongoing Supp to Maint Employ,per diem
 ;;^UTILITY(U,$J,358.3,25195,0)
 ;;=H2017^^91^1138^8^^^^1
 ;;^UTILITY(U,$J,358.3,25195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25195,1,2,0)
 ;;=2^H2017
 ;;^UTILITY(U,$J,358.3,25195,1,3,0)
 ;;=3^Psychosocial Rehab Svc,per 15 min
 ;;^UTILITY(U,$J,358.3,25196,0)
 ;;=H2018^^91^1138^9^^^^1
 ;;^UTILITY(U,$J,358.3,25196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25196,1,2,0)
 ;;=2^H2018
 ;;^UTILITY(U,$J,358.3,25196,1,3,0)
 ;;=3^Psychosocial Rehab Svc,per diem
 ;;^UTILITY(U,$J,358.3,25197,0)
 ;;=H2014^^91^1138^10^^^^1
 ;;^UTILITY(U,$J,358.3,25197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25197,1,2,0)
 ;;=2^H2014
 ;;^UTILITY(U,$J,358.3,25197,1,3,0)
 ;;=3^Skills Training/Development,per 15 min
 ;;^UTILITY(U,$J,358.3,25198,0)
 ;;=H2023^^91^1138^11^^^^1
 ;;^UTILITY(U,$J,358.3,25198,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25198,1,2,0)
 ;;=2^H2023
 ;;^UTILITY(U,$J,358.3,25198,1,3,0)
 ;;=3^Supported Employment,per 15 min
 ;;^UTILITY(U,$J,358.3,25199,0)
 ;;=H2024^^91^1138^12^^^^1
 ;;^UTILITY(U,$J,358.3,25199,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25199,1,2,0)
 ;;=2^H2024
 ;;^UTILITY(U,$J,358.3,25199,1,3,0)
 ;;=3^Supported Employment,per diem
