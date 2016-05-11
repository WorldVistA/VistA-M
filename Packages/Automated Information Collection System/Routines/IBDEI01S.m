IBDEI01S ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,341,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,341,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,342,0)
 ;;=Z69.11^^3^39^3
 ;;^UTILITY(U,$J,358.3,342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,342,1,3,0)
 ;;=3^Mental Health Svcs for Victim of Spousal/Partner Abuse
 ;;^UTILITY(U,$J,358.3,342,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,342,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,343,0)
 ;;=Z60.0^^3^40^2
 ;;^UTILITY(U,$J,358.3,343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,343,1,3,0)
 ;;=3^Phase of Life Problem
 ;;^UTILITY(U,$J,358.3,343,1,4,0)
 ;;=4^Z60.0
 ;;^UTILITY(U,$J,358.3,343,2)
 ;;=^5063139
 ;;^UTILITY(U,$J,358.3,344,0)
 ;;=Z60.2^^3^40^3
 ;;^UTILITY(U,$J,358.3,344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,344,1,3,0)
 ;;=3^Problem Related to Living Alone
 ;;^UTILITY(U,$J,358.3,344,1,4,0)
 ;;=4^Z60.2
 ;;^UTILITY(U,$J,358.3,344,2)
 ;;=^5063140
 ;;^UTILITY(U,$J,358.3,345,0)
 ;;=Z60.3^^3^40^1
 ;;^UTILITY(U,$J,358.3,345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,345,1,3,0)
 ;;=3^Acculturation Difficulty
 ;;^UTILITY(U,$J,358.3,345,1,4,0)
 ;;=4^Z60.3
 ;;^UTILITY(U,$J,358.3,345,2)
 ;;=^5063141
 ;;^UTILITY(U,$J,358.3,346,0)
 ;;=Z60.4^^3^40^5
 ;;^UTILITY(U,$J,358.3,346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,346,1,3,0)
 ;;=3^Social Exclusion or Rejection
 ;;^UTILITY(U,$J,358.3,346,1,4,0)
 ;;=4^Z60.4
 ;;^UTILITY(U,$J,358.3,346,2)
 ;;=^5063142
 ;;^UTILITY(U,$J,358.3,347,0)
 ;;=Z60.5^^3^40^6
 ;;^UTILITY(U,$J,358.3,347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,347,1,3,0)
 ;;=3^Target of (Perceived) Adverse Discrimination or Persecution
 ;;^UTILITY(U,$J,358.3,347,1,4,0)
 ;;=4^Z60.5
 ;;^UTILITY(U,$J,358.3,347,2)
 ;;=^5063143
 ;;^UTILITY(U,$J,358.3,348,0)
 ;;=Z60.9^^3^40^4
 ;;^UTILITY(U,$J,358.3,348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,348,1,3,0)
 ;;=3^Problem Related to Social Environment,Unspec
 ;;^UTILITY(U,$J,358.3,348,1,4,0)
 ;;=4^Z60.9
 ;;^UTILITY(U,$J,358.3,348,2)
 ;;=^5063145
 ;;^UTILITY(U,$J,358.3,349,0)
 ;;=F65.4^^3^41^6
 ;;^UTILITY(U,$J,358.3,349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,349,1,3,0)
 ;;=3^Pedophilia Disorder
 ;;^UTILITY(U,$J,358.3,349,1,4,0)
 ;;=4^F65.4
 ;;^UTILITY(U,$J,358.3,349,2)
 ;;=^5003655
 ;;^UTILITY(U,$J,358.3,350,0)
 ;;=F65.2^^3^41^1
 ;;^UTILITY(U,$J,358.3,350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,350,1,3,0)
 ;;=3^Exhibitionistic Disorder
 ;;^UTILITY(U,$J,358.3,350,1,4,0)
 ;;=4^F65.2
 ;;^UTILITY(U,$J,358.3,350,2)
 ;;=^5003653
 ;;^UTILITY(U,$J,358.3,351,0)
 ;;=F65.3^^3^41^10
 ;;^UTILITY(U,$J,358.3,351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,351,1,3,0)
 ;;=3^Voyeuristic Disorder
 ;;^UTILITY(U,$J,358.3,351,1,4,0)
 ;;=4^F65.3
 ;;^UTILITY(U,$J,358.3,351,2)
 ;;=^5003654
 ;;^UTILITY(U,$J,358.3,352,0)
 ;;=F65.81^^3^41^3
 ;;^UTILITY(U,$J,358.3,352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,352,1,3,0)
 ;;=3^Frotteuristic Disorder
 ;;^UTILITY(U,$J,358.3,352,1,4,0)
 ;;=4^F65.81
 ;;^UTILITY(U,$J,358.3,352,2)
 ;;=^5003659
 ;;^UTILITY(U,$J,358.3,353,0)
 ;;=F65.51^^3^41^7
 ;;^UTILITY(U,$J,358.3,353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,353,1,3,0)
 ;;=3^Sexual Masochism Disorder
 ;;^UTILITY(U,$J,358.3,353,1,4,0)
 ;;=4^F65.51
 ;;^UTILITY(U,$J,358.3,353,2)
 ;;=^5003657
 ;;^UTILITY(U,$J,358.3,354,0)
 ;;=F65.52^^3^41^8
 ;;^UTILITY(U,$J,358.3,354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,354,1,3,0)
 ;;=3^Sexual Sadism Disorder
 ;;^UTILITY(U,$J,358.3,354,1,4,0)
 ;;=4^F65.52
 ;;^UTILITY(U,$J,358.3,354,2)
 ;;=^5003658
 ;;^UTILITY(U,$J,358.3,355,0)
 ;;=F65.0^^3^41^2
 ;;^UTILITY(U,$J,358.3,355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,355,1,3,0)
 ;;=3^Fetishistic Disorder
