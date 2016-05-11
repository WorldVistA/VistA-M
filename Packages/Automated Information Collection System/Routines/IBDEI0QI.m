IBDEI0QI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12421,1,3,0)
 ;;=3^Congenital lactase deficiency
 ;;^UTILITY(U,$J,358.3,12421,1,4,0)
 ;;=4^E73.0
 ;;^UTILITY(U,$J,358.3,12421,2)
 ;;=^5002911
 ;;^UTILITY(U,$J,358.3,12422,0)
 ;;=E73.1^^50^562^13
 ;;^UTILITY(U,$J,358.3,12422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12422,1,3,0)
 ;;=3^Secondary lactase deficiency
 ;;^UTILITY(U,$J,358.3,12422,1,4,0)
 ;;=4^E73.1
 ;;^UTILITY(U,$J,358.3,12422,2)
 ;;=^5002912
 ;;^UTILITY(U,$J,358.3,12423,0)
 ;;=E73.8^^50^562^11
 ;;^UTILITY(U,$J,358.3,12423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12423,1,3,0)
 ;;=3^Lactose intolerance NEC
 ;;^UTILITY(U,$J,358.3,12423,1,4,0)
 ;;=4^E73.8
 ;;^UTILITY(U,$J,358.3,12423,2)
 ;;=^5002913
 ;;^UTILITY(U,$J,358.3,12424,0)
 ;;=E73.9^^50^562^12
 ;;^UTILITY(U,$J,358.3,12424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12424,1,3,0)
 ;;=3^Lactose intolerance, unspecified
 ;;^UTILITY(U,$J,358.3,12424,1,4,0)
 ;;=4^E73.9
 ;;^UTILITY(U,$J,358.3,12424,2)
 ;;=^5002914
 ;;^UTILITY(U,$J,358.3,12425,0)
 ;;=K50.00^^50^562^4
 ;;^UTILITY(U,$J,358.3,12425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12425,1,3,0)
 ;;=3^Crohn's disease of small intestine without complications
 ;;^UTILITY(U,$J,358.3,12425,1,4,0)
 ;;=4^K50.00
 ;;^UTILITY(U,$J,358.3,12425,2)
 ;;=^5008624
 ;;^UTILITY(U,$J,358.3,12426,0)
 ;;=K50.011^^50^562^5
 ;;^UTILITY(U,$J,358.3,12426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12426,1,3,0)
 ;;=3^Crohn's disease of small intestine with rectal bleeding
 ;;^UTILITY(U,$J,358.3,12426,1,4,0)
 ;;=4^K50.011
 ;;^UTILITY(U,$J,358.3,12426,2)
 ;;=^5008625
 ;;^UTILITY(U,$J,358.3,12427,0)
 ;;=K50.012^^50^562^3
 ;;^UTILITY(U,$J,358.3,12427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12427,1,3,0)
 ;;=3^Crohn's disease of small intestine w intestinal obstruction
 ;;^UTILITY(U,$J,358.3,12427,1,4,0)
 ;;=4^K50.012
 ;;^UTILITY(U,$J,358.3,12427,2)
 ;;=^5008626
 ;;^UTILITY(U,$J,358.3,12428,0)
 ;;=K50.013^^50^562^6
 ;;^UTILITY(U,$J,358.3,12428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12428,1,3,0)
 ;;=3^Crohn's disease of small intestine with fistula
 ;;^UTILITY(U,$J,358.3,12428,1,4,0)
 ;;=4^K50.013
 ;;^UTILITY(U,$J,358.3,12428,2)
 ;;=^5008627
 ;;^UTILITY(U,$J,358.3,12429,0)
 ;;=K50.014^^50^562^7
 ;;^UTILITY(U,$J,358.3,12429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12429,1,3,0)
 ;;=3^Crohn's disease of small intestine with abscess
 ;;^UTILITY(U,$J,358.3,12429,1,4,0)
 ;;=4^K50.014
 ;;^UTILITY(U,$J,358.3,12429,2)
 ;;=^5008628
 ;;^UTILITY(U,$J,358.3,12430,0)
 ;;=K50.018^^50^562^8
 ;;^UTILITY(U,$J,358.3,12430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12430,1,3,0)
 ;;=3^Crohn's disease of small intestine with other complication
 ;;^UTILITY(U,$J,358.3,12430,1,4,0)
 ;;=4^K50.018
 ;;^UTILITY(U,$J,358.3,12430,2)
 ;;=^5008629
 ;;^UTILITY(U,$J,358.3,12431,0)
 ;;=K50.019^^50^562^9
 ;;^UTILITY(U,$J,358.3,12431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12431,1,3,0)
 ;;=3^Crohn's disease of small intestine with unsp complications
 ;;^UTILITY(U,$J,358.3,12431,1,4,0)
 ;;=4^K50.019
 ;;^UTILITY(U,$J,358.3,12431,2)
 ;;=^5008630
 ;;^UTILITY(U,$J,358.3,12432,0)
 ;;=K56.5^^50^562^10
 ;;^UTILITY(U,$J,358.3,12432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12432,1,3,0)
 ;;=3^Intestinal adhesions w obst (postprocedural) (postinfection)
 ;;^UTILITY(U,$J,358.3,12432,1,4,0)
 ;;=4^K56.5
 ;;^UTILITY(U,$J,358.3,12432,2)
 ;;=^5008712
 ;;^UTILITY(U,$J,358.3,12433,0)
 ;;=K90.0^^50^562^1
 ;;^UTILITY(U,$J,358.3,12433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12433,1,3,0)
 ;;=3^Celiac disease
