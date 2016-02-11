IBDEI02B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,312,1,3,0)
 ;;=3^Acculturation Difficulty
 ;;^UTILITY(U,$J,358.3,312,1,4,0)
 ;;=4^Z60.3
 ;;^UTILITY(U,$J,358.3,312,2)
 ;;=^5063141
 ;;^UTILITY(U,$J,358.3,313,0)
 ;;=Z60.4^^3^40^5
 ;;^UTILITY(U,$J,358.3,313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,313,1,3,0)
 ;;=3^Social Exclusion or Rejection
 ;;^UTILITY(U,$J,358.3,313,1,4,0)
 ;;=4^Z60.4
 ;;^UTILITY(U,$J,358.3,313,2)
 ;;=^5063142
 ;;^UTILITY(U,$J,358.3,314,0)
 ;;=Z60.5^^3^40^6
 ;;^UTILITY(U,$J,358.3,314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,314,1,3,0)
 ;;=3^Target of (Perceived) Adverse Discrimination or Persecution
 ;;^UTILITY(U,$J,358.3,314,1,4,0)
 ;;=4^Z60.5
 ;;^UTILITY(U,$J,358.3,314,2)
 ;;=^5063143
 ;;^UTILITY(U,$J,358.3,315,0)
 ;;=Z60.9^^3^40^4
 ;;^UTILITY(U,$J,358.3,315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,315,1,3,0)
 ;;=3^Problem Related to Social Environment,Unspec
 ;;^UTILITY(U,$J,358.3,315,1,4,0)
 ;;=4^Z60.9
 ;;^UTILITY(U,$J,358.3,315,2)
 ;;=^5063145
 ;;^UTILITY(U,$J,358.3,316,0)
 ;;=F65.4^^3^41^6
 ;;^UTILITY(U,$J,358.3,316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,316,1,3,0)
 ;;=3^Pedophilia Disorder
 ;;^UTILITY(U,$J,358.3,316,1,4,0)
 ;;=4^F65.4
 ;;^UTILITY(U,$J,358.3,316,2)
 ;;=^5003655
 ;;^UTILITY(U,$J,358.3,317,0)
 ;;=F65.2^^3^41^1
 ;;^UTILITY(U,$J,358.3,317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,317,1,3,0)
 ;;=3^Exhibitionistic Disorder
 ;;^UTILITY(U,$J,358.3,317,1,4,0)
 ;;=4^F65.2
 ;;^UTILITY(U,$J,358.3,317,2)
 ;;=^5003653
 ;;^UTILITY(U,$J,358.3,318,0)
 ;;=F65.3^^3^41^10
 ;;^UTILITY(U,$J,358.3,318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,318,1,3,0)
 ;;=3^Voyeuristic Disorder
 ;;^UTILITY(U,$J,358.3,318,1,4,0)
 ;;=4^F65.3
 ;;^UTILITY(U,$J,358.3,318,2)
 ;;=^5003654
 ;;^UTILITY(U,$J,358.3,319,0)
 ;;=F65.81^^3^41^3
 ;;^UTILITY(U,$J,358.3,319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,319,1,3,0)
 ;;=3^Frotteuristic Disorder
 ;;^UTILITY(U,$J,358.3,319,1,4,0)
 ;;=4^F65.81
 ;;^UTILITY(U,$J,358.3,319,2)
 ;;=^5003659
 ;;^UTILITY(U,$J,358.3,320,0)
 ;;=F65.51^^3^41^7
 ;;^UTILITY(U,$J,358.3,320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,320,1,3,0)
 ;;=3^Sexual Masochism Disorder
 ;;^UTILITY(U,$J,358.3,320,1,4,0)
 ;;=4^F65.51
 ;;^UTILITY(U,$J,358.3,320,2)
 ;;=^5003657
 ;;^UTILITY(U,$J,358.3,321,0)
 ;;=F65.52^^3^41^8
 ;;^UTILITY(U,$J,358.3,321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,321,1,3,0)
 ;;=3^Sexual Sadism Disorder
 ;;^UTILITY(U,$J,358.3,321,1,4,0)
 ;;=4^F65.52
 ;;^UTILITY(U,$J,358.3,321,2)
 ;;=^5003658
 ;;^UTILITY(U,$J,358.3,322,0)
 ;;=F65.0^^3^41^2
 ;;^UTILITY(U,$J,358.3,322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,322,1,3,0)
 ;;=3^Fetishistic Disorder
 ;;^UTILITY(U,$J,358.3,322,1,4,0)
 ;;=4^F65.0
 ;;^UTILITY(U,$J,358.3,322,2)
 ;;=^5003651
 ;;^UTILITY(U,$J,358.3,323,0)
 ;;=F65.1^^3^41^9
 ;;^UTILITY(U,$J,358.3,323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,323,1,3,0)
 ;;=3^Transvestic Disorder
 ;;^UTILITY(U,$J,358.3,323,1,4,0)
 ;;=4^F65.1
 ;;^UTILITY(U,$J,358.3,323,2)
 ;;=^5003652
 ;;^UTILITY(U,$J,358.3,324,0)
 ;;=F65.89^^3^41^4
 ;;^UTILITY(U,$J,358.3,324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,324,1,3,0)
 ;;=3^Paraphilic Disorder NEC
 ;;^UTILITY(U,$J,358.3,324,1,4,0)
 ;;=4^F65.89
 ;;^UTILITY(U,$J,358.3,324,2)
 ;;=^5003660
 ;;^UTILITY(U,$J,358.3,325,0)
 ;;=F65.9^^3^41^5
 ;;^UTILITY(U,$J,358.3,325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,325,1,3,0)
 ;;=3^Paraphilic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,325,1,4,0)
 ;;=4^F65.9
 ;;^UTILITY(U,$J,358.3,325,2)
 ;;=^5003661
 ;;^UTILITY(U,$J,358.3,326,0)
 ;;=F60.0^^3^42^8
 ;;^UTILITY(U,$J,358.3,326,1,0)
 ;;=^358.31IA^4^2
