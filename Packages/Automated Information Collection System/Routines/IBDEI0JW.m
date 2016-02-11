IBDEI0JW ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8967,1,3,0)
 ;;=3^Diabetes due to underlying condition w diab prph angiopath w/o gangrene
 ;;^UTILITY(U,$J,358.3,8967,1,4,0)
 ;;=4^E08.51
 ;;^UTILITY(U,$J,358.3,8967,2)
 ;;=^5002528
 ;;^UTILITY(U,$J,358.3,8968,0)
 ;;=E08.59^^55^555^19
 ;;^UTILITY(U,$J,358.3,8968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8968,1,3,0)
 ;;=3^Diabetes due to underlying condition w oth circulatory comp
 ;;^UTILITY(U,$J,358.3,8968,1,4,0)
 ;;=4^E08.59
 ;;^UTILITY(U,$J,358.3,8968,2)
 ;;=^5002530
 ;;^UTILITY(U,$J,358.3,8969,0)
 ;;=E09.51^^55^555^36
 ;;^UTILITY(U,$J,358.3,8969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8969,1,3,0)
 ;;=3^Drug/chem diabetes w diabetic prph angiopath w/o gangrene
 ;;^UTILITY(U,$J,358.3,8969,1,4,0)
 ;;=4^E09.51
 ;;^UTILITY(U,$J,358.3,8969,2)
 ;;=^5002570
 ;;^UTILITY(U,$J,358.3,8970,0)
 ;;=E09.59^^55^555^48
 ;;^UTILITY(U,$J,358.3,8970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8970,1,3,0)
 ;;=3^Drug/chem diabetes w oth circulatory complications
 ;;^UTILITY(U,$J,358.3,8970,1,4,0)
 ;;=4^E09.59
 ;;^UTILITY(U,$J,358.3,8970,2)
 ;;=^5002572
 ;;^UTILITY(U,$J,358.3,8971,0)
 ;;=E08.618^^55^555^20
 ;;^UTILITY(U,$J,358.3,8971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8971,1,3,0)
 ;;=3^Diabetes due to underlying condition w oth diabetic arthrop
 ;;^UTILITY(U,$J,358.3,8971,1,4,0)
 ;;=4^E08.618
 ;;^UTILITY(U,$J,358.3,8971,2)
 ;;=^5002532
 ;;^UTILITY(U,$J,358.3,8972,0)
 ;;=E08.620^^55^555^21
 ;;^UTILITY(U,$J,358.3,8972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8972,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic dermatitis
 ;;^UTILITY(U,$J,358.3,8972,1,4,0)
 ;;=4^E08.620
 ;;^UTILITY(U,$J,358.3,8972,2)
 ;;=^5002533
 ;;^UTILITY(U,$J,358.3,8973,0)
 ;;=E08.621^^55^555^22
 ;;^UTILITY(U,$J,358.3,8973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8973,1,3,0)
 ;;=3^Diabetes due to underlying condition w foot ulcer
 ;;^UTILITY(U,$J,358.3,8973,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,8973,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,8974,0)
 ;;=E08.622^^55^555^23
 ;;^UTILITY(U,$J,358.3,8974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8974,1,3,0)
 ;;=3^Diabetes due to underlying condition w oth skin ulcer
 ;;^UTILITY(U,$J,358.3,8974,1,4,0)
 ;;=4^E08.622
 ;;^UTILITY(U,$J,358.3,8974,2)
 ;;=^5002535
 ;;^UTILITY(U,$J,358.3,8975,0)
 ;;=E08.628^^55^555^24
 ;;^UTILITY(U,$J,358.3,8975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8975,1,3,0)
 ;;=3^Diabetes due to underlying condition w oth skin comp
 ;;^UTILITY(U,$J,358.3,8975,1,4,0)
 ;;=4^E08.628
 ;;^UTILITY(U,$J,358.3,8975,2)
 ;;=^5002536
 ;;^UTILITY(U,$J,358.3,8976,0)
 ;;=E08.630^^55^555^25
 ;;^UTILITY(U,$J,358.3,8976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8976,1,3,0)
 ;;=3^Diabetes due to underlying condition w periodontal disease
 ;;^UTILITY(U,$J,358.3,8976,1,4,0)
 ;;=4^E08.630
 ;;^UTILITY(U,$J,358.3,8976,2)
 ;;=^5002537
 ;;^UTILITY(U,$J,358.3,8977,0)
 ;;=E08.638^^55^555^26
 ;;^UTILITY(U,$J,358.3,8977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8977,1,3,0)
 ;;=3^Diabetes due to underlying condition w oth oral comp
 ;;^UTILITY(U,$J,358.3,8977,1,4,0)
 ;;=4^E08.638
 ;;^UTILITY(U,$J,358.3,8977,2)
 ;;=^5002538
 ;;^UTILITY(U,$J,358.3,8978,0)
 ;;=E08.649^^55^555^27
 ;;^UTILITY(U,$J,358.3,8978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8978,1,3,0)
 ;;=3^Diabetes due to underlying condition w hypoglycemia w/o coma
 ;;^UTILITY(U,$J,358.3,8978,1,4,0)
 ;;=4^E08.649
 ;;^UTILITY(U,$J,358.3,8978,2)
 ;;=^5002540
 ;;^UTILITY(U,$J,358.3,8979,0)
 ;;=E08.65^^55^555^28
 ;;^UTILITY(U,$J,358.3,8979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8979,1,3,0)
 ;;=3^Diabetes due to underlying condition w hyperglycemia
