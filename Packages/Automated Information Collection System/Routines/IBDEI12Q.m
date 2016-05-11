IBDEI12Q ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18255,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,18255,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,18255,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,18256,0)
 ;;=E10.51^^79^874^54
 ;;^UTILITY(U,$J,358.3,18256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18256,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,18256,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,18256,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,18257,0)
 ;;=E10.621^^79^874^56
 ;;^UTILITY(U,$J,358.3,18257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18257,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,18257,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,18257,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,18258,0)
 ;;=E10.65^^79^874^57
 ;;^UTILITY(U,$J,358.3,18258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18258,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,18258,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,18258,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,18259,0)
 ;;=E10.649^^79^874^58
 ;;^UTILITY(U,$J,358.3,18259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18259,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hypoglycemia w/o Coma
 ;;^UTILITY(U,$J,358.3,18259,1,4,0)
 ;;=4^E10.649
 ;;^UTILITY(U,$J,358.3,18259,2)
 ;;=^5002622
 ;;^UTILITY(U,$J,358.3,18260,0)
 ;;=E10.618^^79^874^51
 ;;^UTILITY(U,$J,358.3,18260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18260,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,18260,1,4,0)
 ;;=4^E10.618
 ;;^UTILITY(U,$J,358.3,18260,2)
 ;;=^5002614
 ;;^UTILITY(U,$J,358.3,18261,0)
 ;;=E10.638^^79^874^59
 ;;^UTILITY(U,$J,358.3,18261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18261,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oral Complications
 ;;^UTILITY(U,$J,358.3,18261,1,4,0)
 ;;=4^E10.638
 ;;^UTILITY(U,$J,358.3,18261,2)
 ;;=^5002620
 ;;^UTILITY(U,$J,358.3,18262,0)
 ;;=E10.628^^79^874^61
 ;;^UTILITY(U,$J,358.3,18262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18262,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Complications
 ;;^UTILITY(U,$J,358.3,18262,1,4,0)
 ;;=4^E10.628
 ;;^UTILITY(U,$J,358.3,18262,2)
 ;;=^5002618
 ;;^UTILITY(U,$J,358.3,18263,0)
 ;;=E10.622^^79^874^62
 ;;^UTILITY(U,$J,358.3,18263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18263,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Ulcer
 ;;^UTILITY(U,$J,358.3,18263,1,4,0)
 ;;=4^E10.622
 ;;^UTILITY(U,$J,358.3,18263,2)
 ;;=^5002617
 ;;^UTILITY(U,$J,358.3,18264,0)
 ;;=E10.69^^79^874^50
 ;;^UTILITY(U,$J,358.3,18264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18264,1,3,0)
 ;;=3^Diabetes Type 1 w/ Complications NEC
 ;;^UTILITY(U,$J,358.3,18264,1,4,0)
 ;;=4^E10.69
 ;;^UTILITY(U,$J,358.3,18264,2)
 ;;=^5002624
 ;;^UTILITY(U,$J,358.3,18265,0)
 ;;=E10.630^^79^874^60
 ;;^UTILITY(U,$J,358.3,18265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18265,1,3,0)
 ;;=3^Diabetes Type 1 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,18265,1,4,0)
 ;;=4^E10.630
 ;;^UTILITY(U,$J,358.3,18265,2)
 ;;=^5002619
 ;;^UTILITY(U,$J,358.3,18266,0)
 ;;=E11.620^^79^874^65
 ;;^UTILITY(U,$J,358.3,18266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18266,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,18266,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,18266,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,18267,0)
 ;;=E11.40^^79^874^66
 ;;^UTILITY(U,$J,358.3,18267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18267,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,18267,1,4,0)
 ;;=4^E11.40
