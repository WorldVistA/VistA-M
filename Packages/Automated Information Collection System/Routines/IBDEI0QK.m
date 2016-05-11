IBDEI0QK ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12446,1,3,0)
 ;;=3^Gastroduodenitis, unspecified, without bleeding
 ;;^UTILITY(U,$J,358.3,12446,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,12446,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,12447,0)
 ;;=K29.70^^50^563^17
 ;;^UTILITY(U,$J,358.3,12447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12447,1,3,0)
 ;;=3^Gastritis, unspecified, without bleeding
 ;;^UTILITY(U,$J,358.3,12447,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,12447,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,12448,0)
 ;;=K29.71^^50^563^16
 ;;^UTILITY(U,$J,358.3,12448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12448,1,3,0)
 ;;=3^Gastritis, unspecified, with bleeding
 ;;^UTILITY(U,$J,358.3,12448,1,4,0)
 ;;=4^K29.71
 ;;^UTILITY(U,$J,358.3,12448,2)
 ;;=^5008553
 ;;^UTILITY(U,$J,358.3,12449,0)
 ;;=K29.91^^50^563^18
 ;;^UTILITY(U,$J,358.3,12449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12449,1,3,0)
 ;;=3^Gastroduodenitis, unspecified, with bleeding
 ;;^UTILITY(U,$J,358.3,12449,1,4,0)
 ;;=4^K29.91
 ;;^UTILITY(U,$J,358.3,12449,2)
 ;;=^5008557
 ;;^UTILITY(U,$J,358.3,12450,0)
 ;;=E08.43^^50^563^10
 ;;^UTILITY(U,$J,358.3,12450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12450,1,3,0)
 ;;=3^Diab due to undrl cond w diabetic autonm (poly)neuropathy
 ;;^UTILITY(U,$J,358.3,12450,1,4,0)
 ;;=4^E08.43
 ;;^UTILITY(U,$J,358.3,12450,2)
 ;;=^5002525
 ;;^UTILITY(U,$J,358.3,12451,0)
 ;;=E09.43^^50^563^11
 ;;^UTILITY(U,$J,358.3,12451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12451,1,3,0)
 ;;=3^Drug/chem diab w neuro comp w diab autonm (poly)neuropathy
 ;;^UTILITY(U,$J,358.3,12451,1,4,0)
 ;;=4^E09.43
 ;;^UTILITY(U,$J,358.3,12451,2)
 ;;=^5002567
 ;;^UTILITY(U,$J,358.3,12452,0)
 ;;=E10.43^^50^563^28
 ;;^UTILITY(U,$J,358.3,12452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12452,1,3,0)
 ;;=3^Type 1 diabetes w diabetic autonomic (poly)neuropathy
 ;;^UTILITY(U,$J,358.3,12452,1,4,0)
 ;;=4^E10.43
 ;;^UTILITY(U,$J,358.3,12452,2)
 ;;=^5002607
 ;;^UTILITY(U,$J,358.3,12453,0)
 ;;=E11.43^^50^563^29
 ;;^UTILITY(U,$J,358.3,12453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12453,1,3,0)
 ;;=3^Type 2 diabetes w diabetic autonomic (poly)neuropathy
 ;;^UTILITY(U,$J,358.3,12453,1,4,0)
 ;;=4^E11.43
 ;;^UTILITY(U,$J,358.3,12453,2)
 ;;=^5002647
 ;;^UTILITY(U,$J,358.3,12454,0)
 ;;=K31.89^^50^563^27
 ;;^UTILITY(U,$J,358.3,12454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12454,1,3,0)
 ;;=3^Stomach and Duodenum Diseases NEC
 ;;^UTILITY(U,$J,358.3,12454,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,12454,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,12455,0)
 ;;=K31.89^^50^563^26
 ;;^UTILITY(U,$J,358.3,12455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12455,1,3,0)
 ;;=3^Portal hypertensive gastropathy
 ;;^UTILITY(U,$J,358.3,12455,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,12455,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,12456,0)
 ;;=K94.23^^50^563^21
 ;;^UTILITY(U,$J,358.3,12456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12456,1,3,0)
 ;;=3^Gastrostomy malfunction
 ;;^UTILITY(U,$J,358.3,12456,1,4,0)
 ;;=4^K94.23
 ;;^UTILITY(U,$J,358.3,12456,2)
 ;;=^5008931
 ;;^UTILITY(U,$J,358.3,12457,0)
 ;;=K94.29^^50^563^9
 ;;^UTILITY(U,$J,358.3,12457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12457,1,3,0)
 ;;=3^Complications of gastrostomy NEC
 ;;^UTILITY(U,$J,358.3,12457,1,4,0)
 ;;=4^K94.29
 ;;^UTILITY(U,$J,358.3,12457,2)
 ;;=^5008932
 ;;^UTILITY(U,$J,358.3,12458,0)
 ;;=K94.21^^50^563^20
 ;;^UTILITY(U,$J,358.3,12458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12458,1,3,0)
 ;;=3^Gastrostomy hemorrhage
 ;;^UTILITY(U,$J,358.3,12458,1,4,0)
 ;;=4^K94.21
 ;;^UTILITY(U,$J,358.3,12458,2)
 ;;=^5008929
