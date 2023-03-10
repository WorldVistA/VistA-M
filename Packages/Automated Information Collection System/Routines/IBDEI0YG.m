IBDEI0YG ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15552,0)
 ;;=90653^^59^750^13^^^^1
 ;;^UTILITY(U,$J,358.3,15552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15552,1,2,0)
 ;;=2^90653
 ;;^UTILITY(U,$J,358.3,15552,1,3,0)
 ;;=3^FLU VACCINE SINGLE DOSE SYR (Fluad)
 ;;^UTILITY(U,$J,358.3,15553,0)
 ;;=99452^^59^751^1^^^^1
 ;;^UTILITY(U,$J,358.3,15553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15553,1,2,0)
 ;;=2^99452
 ;;^UTILITY(U,$J,358.3,15553,1,3,0)
 ;;=3^E-Consult Results/Discussion with Patient
 ;;^UTILITY(U,$J,358.3,15554,0)
 ;;=0001A^^59^752^1^^^^1
 ;;^UTILITY(U,$J,358.3,15554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15554,1,2,0)
 ;;=2^0001A
 ;;^UTILITY(U,$J,358.3,15554,1,3,0)
 ;;=3^Admin COVID-19 Vaccine (Moderna),1st Dose
 ;;^UTILITY(U,$J,358.3,15555,0)
 ;;=0012A^^59^752^2^^^^1
 ;;^UTILITY(U,$J,358.3,15555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15555,1,2,0)
 ;;=2^0012A
 ;;^UTILITY(U,$J,358.3,15555,1,3,0)
 ;;=3^Admin COVID-19 Vaccine (Moderna),2nd Dose
 ;;^UTILITY(U,$J,358.3,15556,0)
 ;;=0001A^^59^752^3^^^^1
 ;;^UTILITY(U,$J,358.3,15556,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15556,1,2,0)
 ;;=2^0001A
 ;;^UTILITY(U,$J,358.3,15556,1,3,0)
 ;;=3^Admin COVID-19 Vaccine (Pfizer),1st Dose 
 ;;^UTILITY(U,$J,358.3,15557,0)
 ;;=0002A^^59^752^4^^^^1
 ;;^UTILITY(U,$J,358.3,15557,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15557,1,2,0)
 ;;=2^0002A
 ;;^UTILITY(U,$J,358.3,15557,1,3,0)
 ;;=3^Admin COVID-19 Vaccine (Pfizer),2nd Dose 
 ;;^UTILITY(U,$J,358.3,15558,0)
 ;;=Q0243^^59^752^7^^^^1
 ;;^UTILITY(U,$J,358.3,15558,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15558,1,2,0)
 ;;=2^Q0243
 ;;^UTILITY(U,$J,358.3,15558,1,3,0)
 ;;=3^Casirivimab & Imdevimab 2400mg           
 ;;^UTILITY(U,$J,358.3,15559,0)
 ;;=M0243^^59^752^8^^^^1
 ;;^UTILITY(U,$J,358.3,15559,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15559,1,2,0)
 ;;=2^M0243
 ;;^UTILITY(U,$J,358.3,15559,1,3,0)
 ;;=3^Casirivimab & Imdevimab Infusion         
 ;;^UTILITY(U,$J,358.3,15560,0)
 ;;=91300^^59^752^9^^^^1
 ;;^UTILITY(U,$J,358.3,15560,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15560,1,2,0)
 ;;=2^91300
 ;;^UTILITY(U,$J,358.3,15560,1,3,0)
 ;;=3^SARSCOV2 Vaccine 0.3ml (Pfizer)          
 ;;^UTILITY(U,$J,358.3,15561,0)
 ;;=91301^^59^752^10^^^^1
 ;;^UTILITY(U,$J,358.3,15561,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15561,1,2,0)
 ;;=2^91301
 ;;^UTILITY(U,$J,358.3,15561,1,3,0)
 ;;=3^SARSCOV2 Vaccine 0.5ml (Moderna)         
 ;;^UTILITY(U,$J,358.3,15562,0)
 ;;=M0245^^59^752^5^^^^1
 ;;^UTILITY(U,$J,358.3,15562,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15562,1,2,0)
 ;;=2^M0245
 ;;^UTILITY(U,$J,358.3,15562,1,3,0)
 ;;=3^Bamlanivimab Infusion w/ Post Admin Monitoring
 ;;^UTILITY(U,$J,358.3,15563,0)
 ;;=Q0245^^59^752^6^^^^1
 ;;^UTILITY(U,$J,358.3,15563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15563,1,2,0)
 ;;=2^Q0245
 ;;^UTILITY(U,$J,358.3,15563,1,3,0)
 ;;=3^Bamlanivivab 700mg 
 ;;^UTILITY(U,$J,358.3,15564,0)
 ;;=99424^^59^753^1^^^^1
 ;;^UTILITY(U,$J,358.3,15564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15564,1,2,0)
 ;;=2^99424
 ;;^UTILITY(U,$J,358.3,15564,1,3,0)
 ;;=3^Prin Care Mgmt,Phys,1st 30 min,per Clndr Mnth
 ;;^UTILITY(U,$J,358.3,15565,0)
 ;;=99425^^59^753^2^^^^1
 ;;^UTILITY(U,$J,358.3,15565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15565,1,2,0)
 ;;=2^99425
 ;;^UTILITY(U,$J,358.3,15565,1,3,0)
 ;;=3^Prin Care Mgmt,Phys,Ea Addl 30 min,per Clndr Mnth
 ;;^UTILITY(U,$J,358.3,15566,0)
 ;;=99426^^59^753^3^^^^1
