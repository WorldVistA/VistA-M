IBDEI0GD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7264,1,4,0)
 ;;=4^E10.329
 ;;^UTILITY(U,$J,358.3,7264,2)
 ;;=^5002595
 ;;^UTILITY(U,$J,358.3,7265,0)
 ;;=E10.341^^49^479^46
 ;;^UTILITY(U,$J,358.3,7265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7265,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,7265,1,4,0)
 ;;=4^E10.341
 ;;^UTILITY(U,$J,358.3,7265,2)
 ;;=^5002598
 ;;^UTILITY(U,$J,358.3,7266,0)
 ;;=E10.349^^49^479^47
 ;;^UTILITY(U,$J,358.3,7266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7266,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,7266,1,4,0)
 ;;=4^E10.349
 ;;^UTILITY(U,$J,358.3,7266,2)
 ;;=^5002599
 ;;^UTILITY(U,$J,358.3,7267,0)
 ;;=E10.51^^49^479^27
 ;;^UTILITY(U,$J,358.3,7267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7267,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,7267,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,7267,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,7268,0)
 ;;=E10.52^^49^479^28
 ;;^UTILITY(U,$J,358.3,7268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7268,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,7268,1,4,0)
 ;;=4^E10.52
 ;;^UTILITY(U,$J,358.3,7268,2)
 ;;=^5002611
 ;;^UTILITY(U,$J,358.3,7269,0)
 ;;=E10.622^^49^479^49
 ;;^UTILITY(U,$J,358.3,7269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7269,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Ulcer NEC
 ;;^UTILITY(U,$J,358.3,7269,1,4,0)
 ;;=4^E10.622
 ;;^UTILITY(U,$J,358.3,7269,2)
 ;;=^5002617
 ;;^UTILITY(U,$J,358.3,7270,0)
 ;;=E10.628^^49^479^48
 ;;^UTILITY(U,$J,358.3,7270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7270,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Complication NEC
 ;;^UTILITY(U,$J,358.3,7270,1,4,0)
 ;;=4^E10.628
 ;;^UTILITY(U,$J,358.3,7270,2)
 ;;=^5002618
 ;;^UTILITY(U,$J,358.3,7271,0)
 ;;=E10.630^^49^479^43
 ;;^UTILITY(U,$J,358.3,7271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7271,1,3,0)
 ;;=3^Diabetes Type 1 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,7271,1,4,0)
 ;;=4^E10.630
 ;;^UTILITY(U,$J,358.3,7271,2)
 ;;=^5002619
 ;;^UTILITY(U,$J,358.3,7272,0)
 ;;=E10.638^^49^479^42
 ;;^UTILITY(U,$J,358.3,7272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7272,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oral Complication NEC
 ;;^UTILITY(U,$J,358.3,7272,1,4,0)
 ;;=4^E10.638
 ;;^UTILITY(U,$J,358.3,7272,2)
 ;;=^5002620
 ;;^UTILITY(U,$J,358.3,7273,0)
 ;;=E10.649^^49^479^35
 ;;^UTILITY(U,$J,358.3,7273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7273,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hypoglycemia w/o Coma
 ;;^UTILITY(U,$J,358.3,7273,1,4,0)
 ;;=4^E10.649
 ;;^UTILITY(U,$J,358.3,7273,2)
 ;;=^5002622
 ;;^UTILITY(U,$J,358.3,7274,0)
 ;;=E10.65^^49^479^33
 ;;^UTILITY(U,$J,358.3,7274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7274,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,7274,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,7274,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,7275,0)
 ;;=E10.8^^49^479^51
 ;;^UTILITY(U,$J,358.3,7275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7275,1,3,0)
 ;;=3^Diabetes Type 1 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,7275,1,4,0)
 ;;=4^E10.8
 ;;^UTILITY(U,$J,358.3,7275,2)
 ;;=^5002625
 ;;^UTILITY(U,$J,358.3,7276,0)
 ;;=99201^^50^480^1
 ;;^UTILITY(U,$J,358.3,7276,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,7276,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,7276,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,7277,0)
 ;;=99202^^50^480^2
 ;;^UTILITY(U,$J,358.3,7277,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,7277,1,1,0)
 ;;=1^Expanded Problem Focus
