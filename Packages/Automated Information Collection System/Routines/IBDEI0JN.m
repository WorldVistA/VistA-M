IBDEI0JN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8852,1,3,0)
 ;;=3^Male Genital Organ Disorders NEC
 ;;^UTILITY(U,$J,358.3,8852,1,4,0)
 ;;=4^N50.8
 ;;^UTILITY(U,$J,358.3,8852,2)
 ;;=^88009
 ;;^UTILITY(U,$J,358.3,8853,0)
 ;;=R10.2^^55^549^17
 ;;^UTILITY(U,$J,358.3,8853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8853,1,3,0)
 ;;=3^Pelvic and perineal pain
 ;;^UTILITY(U,$J,358.3,8853,1,4,0)
 ;;=4^R10.2
 ;;^UTILITY(U,$J,358.3,8853,2)
 ;;=^5019209
 ;;^UTILITY(U,$J,358.3,8854,0)
 ;;=Z85.810^^55^550^7
 ;;^UTILITY(U,$J,358.3,8854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8854,1,3,0)
 ;;=3^Personal history of malignant neoplasm of tongue
 ;;^UTILITY(U,$J,358.3,8854,1,4,0)
 ;;=4^Z85.810
 ;;^UTILITY(U,$J,358.3,8854,2)
 ;;=^5063438
 ;;^UTILITY(U,$J,358.3,8855,0)
 ;;=Z85.05^^55^550^8
 ;;^UTILITY(U,$J,358.3,8855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8855,1,3,0)
 ;;=3^Personal history of malignant neoplasm of liver
 ;;^UTILITY(U,$J,358.3,8855,1,4,0)
 ;;=4^Z85.05
 ;;^UTILITY(U,$J,358.3,8855,2)
 ;;=^5063402
 ;;^UTILITY(U,$J,358.3,8856,0)
 ;;=Z85.068^^55^550^9
 ;;^UTILITY(U,$J,358.3,8856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8856,1,3,0)
 ;;=3^Personal history of malignant neoplasm of small intestine
 ;;^UTILITY(U,$J,358.3,8856,1,4,0)
 ;;=4^Z85.068
 ;;^UTILITY(U,$J,358.3,8856,2)
 ;;=^5063404
 ;;^UTILITY(U,$J,358.3,8857,0)
 ;;=Z85.07^^55^550^10
 ;;^UTILITY(U,$J,358.3,8857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8857,1,3,0)
 ;;=3^Personal history of malignant neoplasm of pancreas
 ;;^UTILITY(U,$J,358.3,8857,1,4,0)
 ;;=4^Z85.07
 ;;^UTILITY(U,$J,358.3,8857,2)
 ;;=^5063405
 ;;^UTILITY(U,$J,358.3,8858,0)
 ;;=Z85.09^^55^550^11
 ;;^UTILITY(U,$J,358.3,8858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8858,1,3,0)
 ;;=3^Personal history of malignant neoplasm of digestive organs
 ;;^UTILITY(U,$J,358.3,8858,1,4,0)
 ;;=4^Z85.09
 ;;^UTILITY(U,$J,358.3,8858,2)
 ;;=^5063406
 ;;^UTILITY(U,$J,358.3,8859,0)
 ;;=Z85.12^^55^550^12
 ;;^UTILITY(U,$J,358.3,8859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8859,1,3,0)
 ;;=3^Personal history of malignant neoplasm of trachea
 ;;^UTILITY(U,$J,358.3,8859,1,4,0)
 ;;=4^Z85.12
 ;;^UTILITY(U,$J,358.3,8859,2)
 ;;=^5063409
 ;;^UTILITY(U,$J,358.3,8860,0)
 ;;=Z85.22^^55^550^13
 ;;^UTILITY(U,$J,358.3,8860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8860,1,3,0)
 ;;=3^Personal history of malignant neoplasm of nasl cav,med ear,acces sinus
 ;;^UTILITY(U,$J,358.3,8860,1,4,0)
 ;;=4^Z85.22
 ;;^UTILITY(U,$J,358.3,8860,2)
 ;;=^5063412
 ;;^UTILITY(U,$J,358.3,8861,0)
 ;;=Z85.41^^55^550^14
 ;;^UTILITY(U,$J,358.3,8861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8861,1,3,0)
 ;;=3^Personal history of malignant neoplasm of cervix uteri
 ;;^UTILITY(U,$J,358.3,8861,1,4,0)
 ;;=4^Z85.41
 ;;^UTILITY(U,$J,358.3,8861,2)
 ;;=^5063418
 ;;^UTILITY(U,$J,358.3,8862,0)
 ;;=Z85.42^^55^550^15
 ;;^UTILITY(U,$J,358.3,8862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8862,1,3,0)
 ;;=3^Personal history of malignant neoplasm of oth prt uterus
 ;;^UTILITY(U,$J,358.3,8862,1,4,0)
 ;;=4^Z85.42
 ;;^UTILITY(U,$J,358.3,8862,2)
 ;;=^5063419
 ;;^UTILITY(U,$J,358.3,8863,0)
 ;;=Z85.48^^55^550^16
 ;;^UTILITY(U,$J,358.3,8863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8863,1,3,0)
 ;;=3^Personal history of malignant neoplasm of epididymis
 ;;^UTILITY(U,$J,358.3,8863,1,4,0)
 ;;=4^Z85.48
 ;;^UTILITY(U,$J,358.3,8863,2)
 ;;=^5063425
 ;;^UTILITY(U,$J,358.3,8864,0)
 ;;=Z85.54^^55^550^17
 ;;^UTILITY(U,$J,358.3,8864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8864,1,3,0)
 ;;=3^Personal history of malignant neoplasm of ureter
