IBDEI1O0 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29920,2)
 ;;=^5007643
 ;;^UTILITY(U,$J,358.3,29921,0)
 ;;=R13.19^^189^1904^51
 ;;^UTILITY(U,$J,358.3,29921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29921,1,3,0)
 ;;=3^Dysphagia NEC
 ;;^UTILITY(U,$J,358.3,29921,1,4,0)
 ;;=4^R13.19
 ;;^UTILITY(U,$J,358.3,29921,2)
 ;;=^335280
 ;;^UTILITY(U,$J,358.3,29922,0)
 ;;=R15.9^^189^1904^58
 ;;^UTILITY(U,$J,358.3,29922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29922,1,3,0)
 ;;=3^Full Incontinence of Feces
 ;;^UTILITY(U,$J,358.3,29922,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,29922,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,29923,0)
 ;;=B25.2^^189^1904^36
 ;;^UTILITY(U,$J,358.3,29923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29923,1,3,0)
 ;;=3^Cytomegaloviral Pancreatitis
 ;;^UTILITY(U,$J,358.3,29923,1,4,0)
 ;;=4^B25.2
 ;;^UTILITY(U,$J,358.3,29923,2)
 ;;=^5000558
 ;;^UTILITY(U,$J,358.3,29924,0)
 ;;=D50.0^^189^1904^70
 ;;^UTILITY(U,$J,358.3,29924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29924,1,3,0)
 ;;=3^Iron Deficiency Anemia d/t Blood Loss
 ;;^UTILITY(U,$J,358.3,29924,1,4,0)
 ;;=4^D50.0
 ;;^UTILITY(U,$J,358.3,29924,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,29925,0)
 ;;=D50.9^^189^1904^71
 ;;^UTILITY(U,$J,358.3,29925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29925,1,3,0)
 ;;=3^Iron Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,29925,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,29925,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,29926,0)
 ;;=D62.^^189^1904^7
 ;;^UTILITY(U,$J,358.3,29926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29926,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,29926,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,29926,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,29927,0)
 ;;=D64.9^^189^1904^13
 ;;^UTILITY(U,$J,358.3,29927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29927,1,3,0)
 ;;=3^Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,29927,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,29927,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,29928,0)
 ;;=E08.52^^189^1904^44
 ;;^UTILITY(U,$J,358.3,29928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29928,1,3,0)
 ;;=3^Diabetes d/t Underlying Cond w/ Diabetic Peripheral Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,29928,1,4,0)
 ;;=4^E08.52
 ;;^UTILITY(U,$J,358.3,29928,2)
 ;;=^5002529
 ;;^UTILITY(U,$J,358.3,29929,0)
 ;;=E09.52^^189^1904^43
 ;;^UTILITY(U,$J,358.3,29929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29929,1,3,0)
 ;;=3^Diabetes d/t Drug/Chem w/ Diabetic Peripheral Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,29929,1,4,0)
 ;;=4^E09.52
 ;;^UTILITY(U,$J,358.3,29929,2)
 ;;=^5002571
 ;;^UTILITY(U,$J,358.3,29930,0)
 ;;=E10.52^^189^1904^39
 ;;^UTILITY(U,$J,358.3,29930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29930,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,29930,1,4,0)
 ;;=4^E10.52
 ;;^UTILITY(U,$J,358.3,29930,2)
 ;;=^5002611
 ;;^UTILITY(U,$J,358.3,29931,0)
 ;;=E10.9^^189^1904^40
 ;;^UTILITY(U,$J,358.3,29931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29931,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,29931,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,29931,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,29932,0)
 ;;=E11.52^^189^1904^41
 ;;^UTILITY(U,$J,358.3,29932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29932,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Peripheral Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,29932,1,4,0)
 ;;=4^E11.52
 ;;^UTILITY(U,$J,358.3,29932,2)
 ;;=^5002651
 ;;^UTILITY(U,$J,358.3,29933,0)
 ;;=E11.9^^189^1904^42
 ;;^UTILITY(U,$J,358.3,29933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29933,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
