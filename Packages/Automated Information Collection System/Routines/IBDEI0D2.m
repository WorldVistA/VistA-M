IBDEI0D2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5992,1,3,0)
 ;;=3^Acne Keloid
 ;;^UTILITY(U,$J,358.3,5992,1,4,0)
 ;;=4^L73.0
 ;;^UTILITY(U,$J,358.3,5992,2)
 ;;=^2149
 ;;^UTILITY(U,$J,358.3,5993,0)
 ;;=L73.2^^30^385^159
 ;;^UTILITY(U,$J,358.3,5993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5993,1,3,0)
 ;;=3^Hidradenitis Suppurativa
 ;;^UTILITY(U,$J,358.3,5993,1,4,0)
 ;;=4^L73.2
 ;;^UTILITY(U,$J,358.3,5993,2)
 ;;=^278979
 ;;^UTILITY(U,$J,358.3,5994,0)
 ;;=L73.9^^30^385^153
 ;;^UTILITY(U,$J,358.3,5994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5994,1,3,0)
 ;;=3^Follicular Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,5994,1,4,0)
 ;;=4^L73.9
 ;;^UTILITY(U,$J,358.3,5994,2)
 ;;=^5009286
 ;;^UTILITY(U,$J,358.3,5995,0)
 ;;=L82.0^^30^385^160
 ;;^UTILITY(U,$J,358.3,5995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5995,1,3,0)
 ;;=3^Inflamed Seborrheic Keratosis
 ;;^UTILITY(U,$J,358.3,5995,1,4,0)
 ;;=4^L82.0
 ;;^UTILITY(U,$J,358.3,5995,2)
 ;;=^303311
 ;;^UTILITY(U,$J,358.3,5996,0)
 ;;=L82.1^^30^385^264
 ;;^UTILITY(U,$J,358.3,5996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5996,1,3,0)
 ;;=3^Seborrheic Keratosis NEC
 ;;^UTILITY(U,$J,358.3,5996,1,4,0)
 ;;=4^L82.1
 ;;^UTILITY(U,$J,358.3,5996,2)
 ;;=^303312
 ;;^UTILITY(U,$J,358.3,5997,0)
 ;;=L84.^^30^385^116
 ;;^UTILITY(U,$J,358.3,5997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5997,1,3,0)
 ;;=3^Corns and Callosities
 ;;^UTILITY(U,$J,358.3,5997,1,4,0)
 ;;=4^L84.
 ;;^UTILITY(U,$J,358.3,5997,2)
 ;;=^271920
 ;;^UTILITY(U,$J,358.3,5998,0)
 ;;=L85.0^^30^385^8
 ;;^UTILITY(U,$J,358.3,5998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5998,1,3,0)
 ;;=3^Acquired Ichthyosis
 ;;^UTILITY(U,$J,358.3,5998,1,4,0)
 ;;=4^L85.0
 ;;^UTILITY(U,$J,358.3,5998,2)
 ;;=^5009320
 ;;^UTILITY(U,$J,358.3,5999,0)
 ;;=L85.1^^30^385^10
 ;;^UTILITY(U,$J,358.3,5999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5999,1,3,0)
 ;;=3^Acquired Keratosis Palmaris et Plantaris
 ;;^UTILITY(U,$J,358.3,5999,1,4,0)
 ;;=4^L85.1
 ;;^UTILITY(U,$J,358.3,5999,2)
 ;;=^5009321
 ;;^UTILITY(U,$J,358.3,6000,0)
 ;;=L85.2^^30^385^166
 ;;^UTILITY(U,$J,358.3,6000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6000,1,3,0)
 ;;=3^Keratosis Punctata
 ;;^UTILITY(U,$J,358.3,6000,1,4,0)
 ;;=4^L85.2
 ;;^UTILITY(U,$J,358.3,6000,2)
 ;;=^5009322
 ;;^UTILITY(U,$J,358.3,6001,0)
 ;;=L85.3^^30^385^289
 ;;^UTILITY(U,$J,358.3,6001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6001,1,3,0)
 ;;=3^Xerosis Cutis
 ;;^UTILITY(U,$J,358.3,6001,1,4,0)
 ;;=4^L85.3
 ;;^UTILITY(U,$J,358.3,6001,2)
 ;;=^5009323
 ;;^UTILITY(U,$J,358.3,6002,0)
 ;;=L86.^^30^385^164
 ;;^UTILITY(U,$J,358.3,6002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6002,1,3,0)
 ;;=3^Keratoderma in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,6002,1,4,0)
 ;;=4^L86.
 ;;^UTILITY(U,$J,358.3,6002,2)
 ;;=^5009326
 ;;^UTILITY(U,$J,358.3,6003,0)
 ;;=L87.0^^30^385^165
 ;;^UTILITY(U,$J,358.3,6003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6003,1,3,0)
 ;;=3^Keratosis Follicularis et Parafollicularis in Cutem Penetrans
 ;;^UTILITY(U,$J,358.3,6003,1,4,0)
 ;;=4^L87.0
 ;;^UTILITY(U,$J,358.3,6003,2)
 ;;=^5009327
 ;;^UTILITY(U,$J,358.3,6004,0)
 ;;=L87.2^^30^385^141
 ;;^UTILITY(U,$J,358.3,6004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6004,1,3,0)
 ;;=3^Elastosis Perforans Serpiginosa
 ;;^UTILITY(U,$J,358.3,6004,1,4,0)
 ;;=4^L87.2
 ;;^UTILITY(U,$J,358.3,6004,2)
 ;;=^5009329
 ;;^UTILITY(U,$J,358.3,6005,0)
 ;;=L89.300^^30^385^242
 ;;^UTILITY(U,$J,358.3,6005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6005,1,3,0)
 ;;=3^Pressure Ulcer of Buttock,Unstageable
 ;;^UTILITY(U,$J,358.3,6005,1,4,0)
 ;;=4^L89.300
 ;;^UTILITY(U,$J,358.3,6005,2)
 ;;=^5009389
