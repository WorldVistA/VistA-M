IBDEI0Y4 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15197,1,3,0)
 ;;=3^Calculus,Bile Duct w/ Acute Cholangitis w/ Obstruction
 ;;^UTILITY(U,$J,358.3,15197,1,4,0)
 ;;=4^K80.33
 ;;^UTILITY(U,$J,358.3,15197,2)
 ;;=^5008851
 ;;^UTILITY(U,$J,358.3,15198,0)
 ;;=K80.01^^85^843^10
 ;;^UTILITY(U,$J,358.3,15198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15198,1,3,0)
 ;;=3^Calculus,Gallbladder w/ Acute Cholecystitis w/ Obstruction
 ;;^UTILITY(U,$J,358.3,15198,1,4,0)
 ;;=4^K80.01
 ;;^UTILITY(U,$J,358.3,15198,2)
 ;;=^5008839
 ;;^UTILITY(U,$J,358.3,15199,0)
 ;;=K80.11^^85^843^11
 ;;^UTILITY(U,$J,358.3,15199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15199,1,3,0)
 ;;=3^Calculus,Gallbladder w/ Chronic Cholecystitis & Obstruction
 ;;^UTILITY(U,$J,358.3,15199,1,4,0)
 ;;=4^K80.11
 ;;^UTILITY(U,$J,358.3,15199,2)
 ;;=^5008841
 ;;^UTILITY(U,$J,358.3,15200,0)
 ;;=K80.10^^85^843^12
 ;;^UTILITY(U,$J,358.3,15200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15200,1,3,0)
 ;;=3^Calculus,Gallbladder w/ Chronic Cholecystitis no Obstruction
 ;;^UTILITY(U,$J,358.3,15200,1,4,0)
 ;;=4^K80.10
 ;;^UTILITY(U,$J,358.3,15200,2)
 ;;=^5008840
 ;;^UTILITY(U,$J,358.3,15201,0)
 ;;=K80.20^^85^843^9
 ;;^UTILITY(U,$J,358.3,15201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15201,1,3,0)
 ;;=3^Calculus,Gallbladder No Cholecystitis/Obstruction
 ;;^UTILITY(U,$J,358.3,15201,1,4,0)
 ;;=4^K80.20
 ;;^UTILITY(U,$J,358.3,15201,2)
 ;;=^5008846
 ;;^UTILITY(U,$J,358.3,15202,0)
 ;;=R93.2^^85^843^1
 ;;^UTILITY(U,$J,358.3,15202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15202,1,3,0)
 ;;=3^Abnormal imaging Biliary tract
 ;;^UTILITY(U,$J,358.3,15202,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,15202,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,15203,0)
 ;;=D13.5^^85^843^2
 ;;^UTILITY(U,$J,358.3,15203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15203,1,3,0)
 ;;=3^Benign neoplasm,Ampulla/Extrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,15203,1,4,0)
 ;;=4^D13.5
 ;;^UTILITY(U,$J,358.3,15203,2)
 ;;=^5001977
 ;;^UTILITY(U,$J,358.3,15204,0)
 ;;=D13.4^^85^843^3
 ;;^UTILITY(U,$J,358.3,15204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15204,1,3,0)
 ;;=3^Benign neoplasm,Intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,15204,1,4,0)
 ;;=4^D13.4
 ;;^UTILITY(U,$J,358.3,15204,2)
 ;;=^5001976
 ;;^UTILITY(U,$J,358.3,15205,0)
 ;;=Q44.4^^85^843^15
 ;;^UTILITY(U,$J,358.3,15205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15205,1,3,0)
 ;;=3^Choledochal cyst,Congenital
 ;;^UTILITY(U,$J,358.3,15205,1,4,0)
 ;;=4^Q44.4
 ;;^UTILITY(U,$J,358.3,15205,2)
 ;;=^5018695
 ;;^UTILITY(U,$J,358.3,15206,0)
 ;;=K83.5^^85^843^17
 ;;^UTILITY(U,$J,358.3,15206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15206,1,3,0)
 ;;=3^Cyst of Biliary tract,Other
 ;;^UTILITY(U,$J,358.3,15206,1,4,0)
 ;;=4^K83.5
 ;;^UTILITY(U,$J,358.3,15206,2)
 ;;=^5008879
 ;;^UTILITY(U,$J,358.3,15207,0)
 ;;=K80.21^^85^843^13
 ;;^UTILITY(U,$J,358.3,15207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15207,1,3,0)
 ;;=3^Calculus,Gallbladder,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15207,1,4,0)
 ;;=4^K80.21
 ;;^UTILITY(U,$J,358.3,15207,2)
 ;;=^5008847
 ;;^UTILITY(U,$J,358.3,15208,0)
 ;;=K83.8^^85^843^31
 ;;^UTILITY(U,$J,358.3,15208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15208,1,3,0)
 ;;=3^Sphincter of Oddi Dysfunction
 ;;^UTILITY(U,$J,358.3,15208,1,4,0)
 ;;=4^K83.8
 ;;^UTILITY(U,$J,358.3,15208,2)
 ;;=^5008880
 ;;^UTILITY(U,$J,358.3,15209,0)
 ;;=E80.4^^85^843^22
