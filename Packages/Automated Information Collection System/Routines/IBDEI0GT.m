IBDEI0GT ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7559,0)
 ;;=46600^^37^376^2^^^^1
 ;;^UTILITY(U,$J,358.3,7559,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7559,1,2,0)
 ;;=2^46600
 ;;^UTILITY(U,$J,358.3,7559,1,3,0)
 ;;=3^Anoscopy,Diagnostic
 ;;^UTILITY(U,$J,358.3,7560,0)
 ;;=44705^^37^376^3^^^^1
 ;;^UTILITY(U,$J,358.3,7560,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7560,1,2,0)
 ;;=2^44705
 ;;^UTILITY(U,$J,358.3,7560,1,3,0)
 ;;=3^Fecal Microbiota Transplantation
 ;;^UTILITY(U,$J,358.3,7561,0)
 ;;=87077^^37^376^1^^^^1
 ;;^UTILITY(U,$J,358.3,7561,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7561,1,2,0)
 ;;=2^87077
 ;;^UTILITY(U,$J,358.3,7561,1,3,0)
 ;;=3^Aerobic Isolate,Ea Isolate Test
 ;;^UTILITY(U,$J,358.3,7562,0)
 ;;=46221^^37^376^7^^^^1
 ;;^UTILITY(U,$J,358.3,7562,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7562,1,2,0)
 ;;=2^46221
 ;;^UTILITY(U,$J,358.3,7562,1,3,0)
 ;;=3^Hemorrhoidectomy by Rubber Band Ligation
 ;;^UTILITY(U,$J,358.3,7563,0)
 ;;=83013^^37^376^6^^^^1
 ;;^UTILITY(U,$J,358.3,7563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7563,1,2,0)
 ;;=2^83013
 ;;^UTILITY(U,$J,358.3,7563,1,3,0)
 ;;=3^H Pylori Urea Breath Test
 ;;^UTILITY(U,$J,358.3,7564,0)
 ;;=96372^^37^376^10^^^^1
 ;;^UTILITY(U,$J,358.3,7564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7564,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,7564,1,3,0)
 ;;=3^Subcutaneous or Intramuscular Injection
 ;;^UTILITY(U,$J,358.3,7565,0)
 ;;=90471^^37^377^1^^^^1
 ;;^UTILITY(U,$J,358.3,7565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7565,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,7565,1,3,0)
 ;;=3^Immunization Admin,1 Vaccine
 ;;^UTILITY(U,$J,358.3,7566,0)
 ;;=90472^^37^377^2^^^^1
 ;;^UTILITY(U,$J,358.3,7566,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7566,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,7566,1,3,0)
 ;;=3^Immunization Admin,Ea Addl
 ;;^UTILITY(U,$J,358.3,7567,0)
 ;;=90632^^37^377^7^^^^1
 ;;^UTILITY(U,$J,358.3,7567,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7567,1,2,0)
 ;;=2^90632
 ;;^UTILITY(U,$J,358.3,7567,1,3,0)
 ;;=3^Hepatitis A Vaccine
 ;;^UTILITY(U,$J,358.3,7568,0)
 ;;=90746^^37^377^11^^^^1
 ;;^UTILITY(U,$J,358.3,7568,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7568,1,2,0)
 ;;=2^90746
 ;;^UTILITY(U,$J,358.3,7568,1,3,0)
 ;;=3^Hepatitis B Vaccine,3 Dose Schedule
 ;;^UTILITY(U,$J,358.3,7569,0)
 ;;=90747^^37^377^13^^^^1
 ;;^UTILITY(U,$J,358.3,7569,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7569,1,2,0)
 ;;=2^90747
 ;;^UTILITY(U,$J,358.3,7569,1,3,0)
 ;;=3^Hepatitis B Vaccine,Dialysis/Immunosupp,4 Dose
 ;;^UTILITY(U,$J,358.3,7570,0)
 ;;=90636^^37^377^6^^^^1
 ;;^UTILITY(U,$J,358.3,7570,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7570,1,2,0)
 ;;=2^90636
 ;;^UTILITY(U,$J,358.3,7570,1,3,0)
 ;;=3^Hepatitis A & B Combination Vaccine
 ;;^UTILITY(U,$J,358.3,7571,0)
 ;;=4155F^^37^377^8^^^^1
 ;;^UTILITY(U,$J,358.3,7571,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7571,1,2,0)
 ;;=2^4155F
 ;;^UTILITY(U,$J,358.3,7571,1,3,0)
 ;;=3^Hepatitis A Vaccine Previously Received
 ;;^UTILITY(U,$J,358.3,7572,0)
 ;;=G0010^^37^377^9^^^^1
 ;;^UTILITY(U,$J,358.3,7572,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7572,1,2,0)
 ;;=2^G0010
 ;;^UTILITY(U,$J,358.3,7572,1,3,0)
 ;;=3^Hepatitis B Vaccine,Admin
 ;;^UTILITY(U,$J,358.3,7573,0)
 ;;=90739^^37^377^10^^^^1
 ;;^UTILITY(U,$J,358.3,7573,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7573,1,2,0)
 ;;=2^90739
 ;;^UTILITY(U,$J,358.3,7573,1,3,0)
 ;;=3^Hepatitis B Vaccine,2 Dose Schedule
