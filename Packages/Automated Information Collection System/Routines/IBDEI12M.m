IBDEI12M ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17862,1,4,0)
 ;;=4^C25.8
 ;;^UTILITY(U,$J,358.3,17862,2)
 ;;=^5000945
 ;;^UTILITY(U,$J,358.3,17863,0)
 ;;=E73.0^^91^885^2
 ;;^UTILITY(U,$J,358.3,17863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17863,1,3,0)
 ;;=3^Congenital lactase deficiency
 ;;^UTILITY(U,$J,358.3,17863,1,4,0)
 ;;=4^E73.0
 ;;^UTILITY(U,$J,358.3,17863,2)
 ;;=^5002911
 ;;^UTILITY(U,$J,358.3,17864,0)
 ;;=E73.1^^91^885^13
 ;;^UTILITY(U,$J,358.3,17864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17864,1,3,0)
 ;;=3^Secondary lactase deficiency
 ;;^UTILITY(U,$J,358.3,17864,1,4,0)
 ;;=4^E73.1
 ;;^UTILITY(U,$J,358.3,17864,2)
 ;;=^5002912
 ;;^UTILITY(U,$J,358.3,17865,0)
 ;;=E73.8^^91^885^11
 ;;^UTILITY(U,$J,358.3,17865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17865,1,3,0)
 ;;=3^Lactose intolerance NEC
 ;;^UTILITY(U,$J,358.3,17865,1,4,0)
 ;;=4^E73.8
 ;;^UTILITY(U,$J,358.3,17865,2)
 ;;=^5002913
 ;;^UTILITY(U,$J,358.3,17866,0)
 ;;=E73.9^^91^885^12
 ;;^UTILITY(U,$J,358.3,17866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17866,1,3,0)
 ;;=3^Lactose intolerance, unspecified
 ;;^UTILITY(U,$J,358.3,17866,1,4,0)
 ;;=4^E73.9
 ;;^UTILITY(U,$J,358.3,17866,2)
 ;;=^5002914
 ;;^UTILITY(U,$J,358.3,17867,0)
 ;;=K50.00^^91^885^4
 ;;^UTILITY(U,$J,358.3,17867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17867,1,3,0)
 ;;=3^Crohn's disease of small intestine without complications
 ;;^UTILITY(U,$J,358.3,17867,1,4,0)
 ;;=4^K50.00
 ;;^UTILITY(U,$J,358.3,17867,2)
 ;;=^5008624
 ;;^UTILITY(U,$J,358.3,17868,0)
 ;;=K50.011^^91^885^5
 ;;^UTILITY(U,$J,358.3,17868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17868,1,3,0)
 ;;=3^Crohn's disease of small intestine with rectal bleeding
 ;;^UTILITY(U,$J,358.3,17868,1,4,0)
 ;;=4^K50.011
 ;;^UTILITY(U,$J,358.3,17868,2)
 ;;=^5008625
 ;;^UTILITY(U,$J,358.3,17869,0)
 ;;=K50.012^^91^885^3
 ;;^UTILITY(U,$J,358.3,17869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17869,1,3,0)
 ;;=3^Crohn's disease of small intestine w intestinal obstruction
 ;;^UTILITY(U,$J,358.3,17869,1,4,0)
 ;;=4^K50.012
 ;;^UTILITY(U,$J,358.3,17869,2)
 ;;=^5008626
 ;;^UTILITY(U,$J,358.3,17870,0)
 ;;=K50.013^^91^885^6
 ;;^UTILITY(U,$J,358.3,17870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17870,1,3,0)
 ;;=3^Crohn's disease of small intestine with fistula
 ;;^UTILITY(U,$J,358.3,17870,1,4,0)
 ;;=4^K50.013
 ;;^UTILITY(U,$J,358.3,17870,2)
 ;;=^5008627
 ;;^UTILITY(U,$J,358.3,17871,0)
 ;;=K50.014^^91^885^7
 ;;^UTILITY(U,$J,358.3,17871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17871,1,3,0)
 ;;=3^Crohn's disease of small intestine with abscess
 ;;^UTILITY(U,$J,358.3,17871,1,4,0)
 ;;=4^K50.014
 ;;^UTILITY(U,$J,358.3,17871,2)
 ;;=^5008628
 ;;^UTILITY(U,$J,358.3,17872,0)
 ;;=K50.018^^91^885^8
 ;;^UTILITY(U,$J,358.3,17872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17872,1,3,0)
 ;;=3^Crohn's disease of small intestine with other complication
 ;;^UTILITY(U,$J,358.3,17872,1,4,0)
 ;;=4^K50.018
 ;;^UTILITY(U,$J,358.3,17872,2)
 ;;=^5008629
 ;;^UTILITY(U,$J,358.3,17873,0)
 ;;=K50.019^^91^885^9
 ;;^UTILITY(U,$J,358.3,17873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17873,1,3,0)
 ;;=3^Crohn's disease of small intestine with unsp complications
 ;;^UTILITY(U,$J,358.3,17873,1,4,0)
 ;;=4^K50.019
 ;;^UTILITY(U,$J,358.3,17873,2)
 ;;=^5008630
 ;;^UTILITY(U,$J,358.3,17874,0)
 ;;=K56.5^^91^885^10
 ;;^UTILITY(U,$J,358.3,17874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17874,1,3,0)
 ;;=3^Intestinal adhesions w obst (postprocedural) (postinfection)
 ;;^UTILITY(U,$J,358.3,17874,1,4,0)
 ;;=4^K56.5
 ;;^UTILITY(U,$J,358.3,17874,2)
 ;;=^5008712
 ;;^UTILITY(U,$J,358.3,17875,0)
 ;;=K90.0^^91^885^1
