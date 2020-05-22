IBDEI2R0 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43830,1,3,0)
 ;;=3^Prolonged Svcs,INPT/OBS,ea addl 30 min
 ;;^UTILITY(U,$J,358.3,43831,0)
 ;;=99354^^163^2156^10^^^^1
 ;;^UTILITY(U,$J,358.3,43831,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43831,1,2,0)
 ;;=2^99354
 ;;^UTILITY(U,$J,358.3,43831,1,3,0)
 ;;=3^Prolonged Svcs,OPT,1st hr
 ;;^UTILITY(U,$J,358.3,43832,0)
 ;;=99355^^163^2156^11^^^^1
 ;;^UTILITY(U,$J,358.3,43832,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43832,1,2,0)
 ;;=2^99355
 ;;^UTILITY(U,$J,358.3,43832,1,3,0)
 ;;=3^Prolonged Svcs,OPT,ea addl 30 min
 ;;^UTILITY(U,$J,358.3,43833,0)
 ;;=Q3014^^163^2157^9^^^^1
 ;;^UTILITY(U,$J,358.3,43833,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43833,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,43833,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,43834,0)
 ;;=H0031^^163^2157^7^^^^1
 ;;^UTILITY(U,$J,358.3,43834,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43834,1,2,0)
 ;;=2^H0031
 ;;^UTILITY(U,$J,358.3,43834,1,3,0)
 ;;=3^Psychosoc Assmt by Non LIP
 ;;^UTILITY(U,$J,358.3,43835,0)
 ;;=99497^^163^2157^1^^^^1
 ;;^UTILITY(U,$J,358.3,43835,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43835,1,2,0)
 ;;=2^99497
 ;;^UTILITY(U,$J,358.3,43835,1,3,0)
 ;;=3^Advanced Care Plan,30 min
 ;;^UTILITY(U,$J,358.3,43836,0)
 ;;=99498^^163^2157^2^^^^1
 ;;^UTILITY(U,$J,358.3,43836,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43836,1,2,0)
 ;;=2^99498
 ;;^UTILITY(U,$J,358.3,43836,1,3,0)
 ;;=3^Advanced Care Plan,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,43837,0)
 ;;=H0005^^163^2157^3^^^^1
 ;;^UTILITY(U,$J,358.3,43837,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43837,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,43837,1,3,0)
 ;;=3^Alcohol/Drug Services
 ;;^UTILITY(U,$J,358.3,43838,0)
 ;;=90875^^163^2157^5^^^^1
 ;;^UTILITY(U,$J,358.3,43838,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43838,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,43838,1,3,0)
 ;;=3^Psychophysio Tx,Incld Biofdbk Trng,30 min
 ;;^UTILITY(U,$J,358.3,43839,0)
 ;;=90876^^163^2157^6^^^^1
 ;;^UTILITY(U,$J,358.3,43839,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43839,1,2,0)
 ;;=2^90876
 ;;^UTILITY(U,$J,358.3,43839,1,3,0)
 ;;=3^Psychophysio Tx,Incld Biofdbk Trng,45 min
 ;;^UTILITY(U,$J,358.3,43840,0)
 ;;=T1023^^163^2157^4^^^^1
 ;;^UTILITY(U,$J,358.3,43840,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43840,1,2,0)
 ;;=2^T1023
 ;;^UTILITY(U,$J,358.3,43840,1,3,0)
 ;;=3^Intake Assessment for Program/Proj/Tmnt
 ;;^UTILITY(U,$J,358.3,43841,0)
 ;;=3085F^^163^2157^8^^^^1
 ;;^UTILITY(U,$J,358.3,43841,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43841,1,2,0)
 ;;=2^3085F
 ;;^UTILITY(U,$J,358.3,43841,1,3,0)
 ;;=3^Suicide Risk Assessment
 ;;^UTILITY(U,$J,358.3,43842,0)
 ;;=T1016^^163^2158^1^^^^1
 ;;^UTILITY(U,$J,358.3,43842,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43842,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,43842,1,3,0)
 ;;=3^Case Management,ea 15 min
 ;;^UTILITY(U,$J,358.3,43843,0)
 ;;=99510^^163^2159^1^^^^1
 ;;^UTILITY(U,$J,358.3,43843,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43843,1,2,0)
 ;;=2^99510
 ;;^UTILITY(U,$J,358.3,43843,1,3,0)
 ;;=3^Home Visit for Indiv/Fam/Marriage Counseling
 ;;^UTILITY(U,$J,358.3,43844,0)
 ;;=T1016^^163^2159^2^^^^1
 ;;^UTILITY(U,$J,358.3,43844,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43844,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,43844,1,3,0)
 ;;=3^Home Visit for Individual Case Management
 ;;^UTILITY(U,$J,358.3,43845,0)
 ;;=T1016^^163^2160^3^^^^1
