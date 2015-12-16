IBDEI04T ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1728,1,3,0)
 ;;=3^Chronic post-thoracotomy pain
 ;;^UTILITY(U,$J,358.3,1728,1,4,0)
 ;;=4^G89.22
 ;;^UTILITY(U,$J,358.3,1728,2)
 ;;=^5004156
 ;;^UTILITY(U,$J,358.3,1729,0)
 ;;=G89.28^^3^50^9
 ;;^UTILITY(U,$J,358.3,1729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1729,1,3,0)
 ;;=3^Chronic postprocedural pain NEC
 ;;^UTILITY(U,$J,358.3,1729,1,4,0)
 ;;=4^G89.28
 ;;^UTILITY(U,$J,358.3,1729,2)
 ;;=^5004157
 ;;^UTILITY(U,$J,358.3,1730,0)
 ;;=G89.29^^3^50^5
 ;;^UTILITY(U,$J,358.3,1730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1730,1,3,0)
 ;;=3^Chronic Pain NEC
 ;;^UTILITY(U,$J,358.3,1730,1,4,0)
 ;;=4^G89.29
 ;;^UTILITY(U,$J,358.3,1730,2)
 ;;=^5004158
 ;;^UTILITY(U,$J,358.3,1731,0)
 ;;=G89.3^^3^50^12
 ;;^UTILITY(U,$J,358.3,1731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1731,1,3,0)
 ;;=3^Neoplasm related pain (acute) (chronic)
 ;;^UTILITY(U,$J,358.3,1731,1,4,0)
 ;;=4^G89.3
 ;;^UTILITY(U,$J,358.3,1731,2)
 ;;=^5004159
 ;;^UTILITY(U,$J,358.3,1732,0)
 ;;=G89.4^^3^50^7
 ;;^UTILITY(U,$J,358.3,1732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1732,1,3,0)
 ;;=3^Chronic pain syndrome
 ;;^UTILITY(U,$J,358.3,1732,1,4,0)
 ;;=4^G89.4
 ;;^UTILITY(U,$J,358.3,1732,2)
 ;;=^334079
 ;;^UTILITY(U,$J,358.3,1733,0)
 ;;=H92.01^^3^50^15
 ;;^UTILITY(U,$J,358.3,1733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1733,1,3,0)
 ;;=3^Otalgia, right ear
 ;;^UTILITY(U,$J,358.3,1733,1,4,0)
 ;;=4^H92.01
 ;;^UTILITY(U,$J,358.3,1733,2)
 ;;=^5006945
 ;;^UTILITY(U,$J,358.3,1734,0)
 ;;=H92.02^^3^50^14
 ;;^UTILITY(U,$J,358.3,1734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1734,1,3,0)
 ;;=3^Otalgia, left ear
 ;;^UTILITY(U,$J,358.3,1734,1,4,0)
 ;;=4^H92.02
 ;;^UTILITY(U,$J,358.3,1734,2)
 ;;=^5006946
 ;;^UTILITY(U,$J,358.3,1735,0)
 ;;=H92.03^^3^50^13
 ;;^UTILITY(U,$J,358.3,1735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1735,1,3,0)
 ;;=3^Otalgia, bilateral
 ;;^UTILITY(U,$J,358.3,1735,1,4,0)
 ;;=4^H92.03
 ;;^UTILITY(U,$J,358.3,1735,2)
 ;;=^5006947
 ;;^UTILITY(U,$J,358.3,1736,0)
 ;;=R68.84^^3^50^10
 ;;^UTILITY(U,$J,358.3,1736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1736,1,3,0)
 ;;=3^Jaw pain
 ;;^UTILITY(U,$J,358.3,1736,1,4,0)
 ;;=4^R68.84
 ;;^UTILITY(U,$J,358.3,1736,2)
 ;;=^5019556
 ;;^UTILITY(U,$J,358.3,1737,0)
 ;;=N48.89^^3^50^18
 ;;^UTILITY(U,$J,358.3,1737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1737,1,3,0)
 ;;=3^Penis Disorders NEC
 ;;^UTILITY(U,$J,358.3,1737,1,4,0)
 ;;=4^N48.89
 ;;^UTILITY(U,$J,358.3,1737,2)
 ;;=^88018
 ;;^UTILITY(U,$J,358.3,1738,0)
 ;;=N50.8^^3^50^11
 ;;^UTILITY(U,$J,358.3,1738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1738,1,3,0)
 ;;=3^Male Genital Organ Disorders NEC
 ;;^UTILITY(U,$J,358.3,1738,1,4,0)
 ;;=4^N50.8
 ;;^UTILITY(U,$J,358.3,1738,2)
 ;;=^88009
 ;;^UTILITY(U,$J,358.3,1739,0)
 ;;=R10.2^^3^50^17
 ;;^UTILITY(U,$J,358.3,1739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1739,1,3,0)
 ;;=3^Pelvic and perineal pain
 ;;^UTILITY(U,$J,358.3,1739,1,4,0)
 ;;=4^R10.2
 ;;^UTILITY(U,$J,358.3,1739,2)
 ;;=^5019209
 ;;^UTILITY(U,$J,358.3,1740,0)
 ;;=Z85.810^^3^51^7
 ;;^UTILITY(U,$J,358.3,1740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1740,1,3,0)
 ;;=3^Personal history of malignant neoplasm of tongue
 ;;^UTILITY(U,$J,358.3,1740,1,4,0)
 ;;=4^Z85.810
 ;;^UTILITY(U,$J,358.3,1740,2)
 ;;=^5063438
 ;;^UTILITY(U,$J,358.3,1741,0)
 ;;=Z85.05^^3^51^8
 ;;^UTILITY(U,$J,358.3,1741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1741,1,3,0)
 ;;=3^Personal history of malignant neoplasm of liver
 ;;^UTILITY(U,$J,358.3,1741,1,4,0)
 ;;=4^Z85.05
 ;;^UTILITY(U,$J,358.3,1741,2)
 ;;=^5063402
 ;;^UTILITY(U,$J,358.3,1742,0)
 ;;=Z85.068^^3^51^9
