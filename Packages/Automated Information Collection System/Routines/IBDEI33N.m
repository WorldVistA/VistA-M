IBDEI33N ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52011,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,52012,0)
 ;;=Z02.1^^233^2552^25
 ;;^UTILITY(U,$J,358.3,52012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52012,1,3,0)
 ;;=3^Pre-employment examination
 ;;^UTILITY(U,$J,358.3,52012,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,52012,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,52013,0)
 ;;=Z13.5^^233^2552^15
 ;;^UTILITY(U,$J,358.3,52013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52013,1,3,0)
 ;;=3^Eye and Ear Disorder Screening
 ;;^UTILITY(U,$J,358.3,52013,1,4,0)
 ;;=4^Z13.5
 ;;^UTILITY(U,$J,358.3,52013,2)
 ;;=^5062706
 ;;^UTILITY(U,$J,358.3,52014,0)
 ;;=Z13.850^^233^2552^32
 ;;^UTILITY(U,$J,358.3,52014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52014,1,3,0)
 ;;=3^Traumatic Brain Injury Screening
 ;;^UTILITY(U,$J,358.3,52014,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,52014,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,52015,0)
 ;;=Z85.841^^233^2552^20
 ;;^UTILITY(U,$J,358.3,52015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52015,1,3,0)
 ;;=3^Personal history of malignant neoplasm of brain
 ;;^UTILITY(U,$J,358.3,52015,1,4,0)
 ;;=4^Z85.841
 ;;^UTILITY(U,$J,358.3,52015,2)
 ;;=^5063447
 ;;^UTILITY(U,$J,358.3,52016,0)
 ;;=Z85.21^^233^2552^21
 ;;^UTILITY(U,$J,358.3,52016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52016,1,3,0)
 ;;=3^Personal history of malignant neoplasm of larynx
 ;;^UTILITY(U,$J,358.3,52016,1,4,0)
 ;;=4^Z85.21
 ;;^UTILITY(U,$J,358.3,52016,2)
 ;;=^5063411
 ;;^UTILITY(U,$J,358.3,52017,0)
 ;;=Z85.22^^233^2552^22
 ;;^UTILITY(U,$J,358.3,52017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52017,1,3,0)
 ;;=3^Personal history of malignant neoplasm of nasl cav/mid ear/acces sinus
 ;;^UTILITY(U,$J,358.3,52017,1,4,0)
 ;;=4^Z85.22
 ;;^UTILITY(U,$J,358.3,52017,2)
 ;;=^5063412
 ;;^UTILITY(U,$J,358.3,52018,0)
 ;;=Z85.810^^233^2552^23
 ;;^UTILITY(U,$J,358.3,52018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52018,1,3,0)
 ;;=3^Personal history of malignant neoplasm of tongue
 ;;^UTILITY(U,$J,358.3,52018,1,4,0)
 ;;=4^Z85.810
 ;;^UTILITY(U,$J,358.3,52018,2)
 ;;=^5063438
 ;;^UTILITY(U,$J,358.3,52019,0)
 ;;=Z85.12^^233^2552^24
 ;;^UTILITY(U,$J,358.3,52019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52019,1,3,0)
 ;;=3^Personal history of malignant neoplasm of trachea
 ;;^UTILITY(U,$J,358.3,52019,1,4,0)
 ;;=4^Z85.12
 ;;^UTILITY(U,$J,358.3,52019,2)
 ;;=^5063409
 ;;^UTILITY(U,$J,358.3,52020,0)
 ;;=Z53.09^^233^2552^26
 ;;^UTILITY(U,$J,358.3,52020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52020,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t contraindication
 ;;^UTILITY(U,$J,358.3,52020,1,4,0)
 ;;=4^Z53.09
 ;;^UTILITY(U,$J,358.3,52020,2)
 ;;=^5063093
 ;;^UTILITY(U,$J,358.3,52021,0)
 ;;=Z53.29^^233^2552^29
 ;;^UTILITY(U,$J,358.3,52021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52021,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t pt decision for oth reasons
 ;;^UTILITY(U,$J,358.3,52021,1,4,0)
 ;;=4^Z53.29
 ;;^UTILITY(U,$J,358.3,52021,2)
 ;;=^5063097
 ;;^UTILITY(U,$J,358.3,52022,0)
 ;;=Z53.1^^233^2552^28
 ;;^UTILITY(U,$J,358.3,52022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52022,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t pt belief and group pressure
 ;;^UTILITY(U,$J,358.3,52022,1,4,0)
 ;;=4^Z53.1
 ;;^UTILITY(U,$J,358.3,52022,2)
 ;;=^5063094
 ;;^UTILITY(U,$J,358.3,52023,0)
 ;;=Z53.21^^233^2552^30
 ;;^UTILITY(U,$J,358.3,52023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52023,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t pt lv bef seen by hlth care prov
 ;;^UTILITY(U,$J,358.3,52023,1,4,0)
 ;;=4^Z53.21
 ;;^UTILITY(U,$J,358.3,52023,2)
 ;;=^5063096
 ;;^UTILITY(U,$J,358.3,52024,0)
 ;;=Z53.8^^233^2552^27
