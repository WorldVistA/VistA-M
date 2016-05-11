IBDEI0ER ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6794,1,4,0)
 ;;=4^Z98.84
 ;;^UTILITY(U,$J,358.3,6794,2)
 ;;=^5063749
 ;;^UTILITY(U,$J,358.3,6795,0)
 ;;=Z99.2^^30^397^141
 ;;^UTILITY(U,$J,358.3,6795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6795,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,6795,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,6795,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,6796,0)
 ;;=Z99.81^^30^397^144
 ;;^UTILITY(U,$J,358.3,6796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6796,1,3,0)
 ;;=3^Supplemental Oxygen Dependence
 ;;^UTILITY(U,$J,358.3,6796,1,4,0)
 ;;=4^Z99.81
 ;;^UTILITY(U,$J,358.3,6796,2)
 ;;=^5063760
 ;;^UTILITY(U,$J,358.3,6797,0)
 ;;=Z90.79^^30^397^2
 ;;^UTILITY(U,$J,358.3,6797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6797,1,3,0)
 ;;=3^Acquired Absence of Genital Organs NEC
 ;;^UTILITY(U,$J,358.3,6797,1,4,0)
 ;;=4^Z90.79
 ;;^UTILITY(U,$J,358.3,6797,2)
 ;;=^5063596
 ;;^UTILITY(U,$J,358.3,6798,0)
 ;;=Z90.5^^30^397^3
 ;;^UTILITY(U,$J,358.3,6798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6798,1,3,0)
 ;;=3^Acquired Absence of Kidney
 ;;^UTILITY(U,$J,358.3,6798,1,4,0)
 ;;=4^Z90.5
 ;;^UTILITY(U,$J,358.3,6798,2)
 ;;=^5063590
 ;;^UTILITY(U,$J,358.3,6799,0)
 ;;=Z90.2^^30^397^6
 ;;^UTILITY(U,$J,358.3,6799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6799,1,3,0)
 ;;=3^Acquired Absence of Lung (part of)
 ;;^UTILITY(U,$J,358.3,6799,1,4,0)
 ;;=4^Z90.2
 ;;^UTILITY(U,$J,358.3,6799,2)
 ;;=^5063585
 ;;^UTILITY(U,$J,358.3,6800,0)
 ;;=Z98.1^^30^397^10
 ;;^UTILITY(U,$J,358.3,6800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6800,1,3,0)
 ;;=3^Arthrodesis Status
 ;;^UTILITY(U,$J,358.3,6800,1,4,0)
 ;;=4^Z98.1
 ;;^UTILITY(U,$J,358.3,6800,2)
 ;;=^5063734
 ;;^UTILITY(U,$J,358.3,6801,0)
 ;;=Z94.7^^30^397^16
 ;;^UTILITY(U,$J,358.3,6801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6801,1,3,0)
 ;;=3^Corneal Transplant Status
 ;;^UTILITY(U,$J,358.3,6801,1,4,0)
 ;;=4^Z94.7
 ;;^UTILITY(U,$J,358.3,6801,2)
 ;;=^5063661
 ;;^UTILITY(U,$J,358.3,6802,0)
 ;;=Z83.511^^30^397^30
 ;;^UTILITY(U,$J,358.3,6802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6802,1,3,0)
 ;;=3^Family Hx of Glaucoma
 ;;^UTILITY(U,$J,358.3,6802,1,4,0)
 ;;=4^Z83.511
 ;;^UTILITY(U,$J,358.3,6802,2)
 ;;=^5063382
 ;;^UTILITY(U,$J,358.3,6803,0)
 ;;=Z80.52^^30^397^33
 ;;^UTILITY(U,$J,358.3,6803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6803,1,3,0)
 ;;=3^Family Hx of Malig Neop of Baldder
 ;;^UTILITY(U,$J,358.3,6803,1,4,0)
 ;;=4^Z80.52
 ;;^UTILITY(U,$J,358.3,6803,2)
 ;;=^5063352
 ;;^UTILITY(U,$J,358.3,6804,0)
 ;;=Z80.51^^30^397^36
 ;;^UTILITY(U,$J,358.3,6804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6804,1,3,0)
 ;;=3^Family Hx of Malig Neop of Kidney
 ;;^UTILITY(U,$J,358.3,6804,1,4,0)
 ;;=4^Z80.51
 ;;^UTILITY(U,$J,358.3,6804,2)
 ;;=^321159
 ;;^UTILITY(U,$J,358.3,6805,0)
 ;;=Z83.41^^30^397^43
 ;;^UTILITY(U,$J,358.3,6805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6805,1,3,0)
 ;;=3^Family Hx of Mult Endocrine Neoplasia Syndrome
 ;;^UTILITY(U,$J,358.3,6805,1,4,0)
 ;;=4^Z83.41
 ;;^UTILITY(U,$J,358.3,6805,2)
 ;;=^5063380
 ;;^UTILITY(U,$J,358.3,6806,0)
 ;;=Z81.8^^30^397^50
 ;;^UTILITY(U,$J,358.3,6806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6806,1,3,0)
 ;;=3^Family Hx of Substance Abuse/Dependence,Psychoactive
 ;;^UTILITY(U,$J,358.3,6806,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,6806,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,6807,0)
 ;;=Z81.4^^30^397^51
 ;;^UTILITY(U,$J,358.3,6807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6807,1,3,0)
 ;;=3^Family Hx of Substance Abuse/Dependence NEC
 ;;^UTILITY(U,$J,358.3,6807,1,4,0)
 ;;=4^Z81.4
 ;;^UTILITY(U,$J,358.3,6807,2)
 ;;=^5063362
