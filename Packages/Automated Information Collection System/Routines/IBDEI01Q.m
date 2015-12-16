IBDEI01Q ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,251,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,252,0)
 ;;=Z02.79^^1^11^21
 ;;^UTILITY(U,$J,358.3,252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,252,1,3,0)
 ;;=3^Medical Certificate Issue NEC
 ;;^UTILITY(U,$J,358.3,252,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,252,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,253,0)
 ;;=Z02.1^^1^11^10
 ;;^UTILITY(U,$J,358.3,253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,253,1,3,0)
 ;;=3^Exam for Employment
 ;;^UTILITY(U,$J,358.3,253,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,253,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,254,0)
 ;;=Z13.5^^1^11^14
 ;;^UTILITY(U,$J,358.3,254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,254,1,3,0)
 ;;=3^Eye/Ear Disorder Screening
 ;;^UTILITY(U,$J,358.3,254,1,4,0)
 ;;=4^Z13.5
 ;;^UTILITY(U,$J,358.3,254,2)
 ;;=^5062706
 ;;^UTILITY(U,$J,358.3,255,0)
 ;;=Z82.2^^1^11^16
 ;;^UTILITY(U,$J,358.3,255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,255,1,3,0)
 ;;=3^Family history of deafness and hearing loss
 ;;^UTILITY(U,$J,358.3,255,1,4,0)
 ;;=4^Z82.2
 ;;^UTILITY(U,$J,358.3,255,2)
 ;;=^5063366
 ;;^UTILITY(U,$J,358.3,256,0)
 ;;=Z83.52^^1^11^17
 ;;^UTILITY(U,$J,358.3,256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,256,1,3,0)
 ;;=3^Family history of ear disorders
 ;;^UTILITY(U,$J,358.3,256,1,4,0)
 ;;=4^Z83.52
 ;;^UTILITY(U,$J,358.3,256,2)
 ;;=^5063384
 ;;^UTILITY(U,$J,358.3,257,0)
 ;;=Z91.81^^1^11^19
 ;;^UTILITY(U,$J,358.3,257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,257,1,3,0)
 ;;=3^History of falling
 ;;^UTILITY(U,$J,358.3,257,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,257,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,258,0)
 ;;=Z76.5^^1^11^20
 ;;^UTILITY(U,$J,358.3,258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,258,1,3,0)
 ;;=3^Malingerer [conscious simulation]
 ;;^UTILITY(U,$J,358.3,258,1,4,0)
 ;;=4^Z76.5
 ;;^UTILITY(U,$J,358.3,258,2)
 ;;=^5063302
 ;;^UTILITY(U,$J,358.3,259,0)
 ;;=Z53.09^^1^11^22
 ;;^UTILITY(U,$J,358.3,259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,259,1,3,0)
 ;;=3^Proc/trtmt not carried out because of contraindication
 ;;^UTILITY(U,$J,358.3,259,1,4,0)
 ;;=4^Z53.09
 ;;^UTILITY(U,$J,358.3,259,2)
 ;;=^5063093
 ;;^UTILITY(U,$J,358.3,260,0)
 ;;=Z53.29^^1^11^24
 ;;^UTILITY(U,$J,358.3,260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,260,1,3,0)
 ;;=3^Proc/trtmt not crd out bec pt decision for oth reasons
 ;;^UTILITY(U,$J,358.3,260,1,4,0)
 ;;=4^Z53.29
 ;;^UTILITY(U,$J,358.3,260,2)
 ;;=^5063097
 ;;^UTILITY(U,$J,358.3,261,0)
 ;;=Z53.1^^1^11^23
 ;;^UTILITY(U,$J,358.3,261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,261,1,3,0)
 ;;=3^Proc/trtmt not crd out bec pt belief and group pressure
 ;;^UTILITY(U,$J,358.3,261,1,4,0)
 ;;=4^Z53.1
 ;;^UTILITY(U,$J,358.3,261,2)
 ;;=^5063094
 ;;^UTILITY(U,$J,358.3,262,0)
 ;;=Z53.21^^1^11^26
 ;;^UTILITY(U,$J,358.3,262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,262,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t pt lv bef seen by hlth care prov
 ;;^UTILITY(U,$J,358.3,262,1,4,0)
 ;;=4^Z53.21
 ;;^UTILITY(U,$J,358.3,262,2)
 ;;=^5063096
 ;;^UTILITY(U,$J,358.3,263,0)
 ;;=Z53.8^^1^11^25
 ;;^UTILITY(U,$J,358.3,263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,263,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t other reasons
 ;;^UTILITY(U,$J,358.3,263,1,4,0)
 ;;=4^Z53.8
 ;;^UTILITY(U,$J,358.3,263,2)
 ;;=^5063098
 ;;^UTILITY(U,$J,358.3,264,0)
 ;;=D50.9^^2^12^27
 ;;^UTILITY(U,$J,358.3,264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,264,1,3,0)
 ;;=3^Iron deficiency anemia, unspecified
 ;;^UTILITY(U,$J,358.3,264,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,264,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,265,0)
 ;;=D51.0^^2^12^37
