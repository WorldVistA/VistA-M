IBDEI1BD ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21005,1,4,0)
 ;;=4^G47.36
 ;;^UTILITY(U,$J,358.3,21005,2)
 ;;=^5003979
 ;;^UTILITY(U,$J,358.3,21006,0)
 ;;=G47.35^^95^1042^28
 ;;^UTILITY(U,$J,358.3,21006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21006,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Congenital Central Alveolar Hypoventilation
 ;;^UTILITY(U,$J,358.3,21006,1,4,0)
 ;;=4^G47.35
 ;;^UTILITY(U,$J,358.3,21006,2)
 ;;=^332765
 ;;^UTILITY(U,$J,358.3,21007,0)
 ;;=G47.34^^95^1042^29
 ;;^UTILITY(U,$J,358.3,21007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21007,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Idiopathic
 ;;^UTILITY(U,$J,358.3,21007,1,4,0)
 ;;=4^G47.34
 ;;^UTILITY(U,$J,358.3,21007,2)
 ;;=^5003978
 ;;^UTILITY(U,$J,358.3,21008,0)
 ;;=G47.9^^95^1042^31
 ;;^UTILITY(U,$J,358.3,21008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21008,1,3,0)
 ;;=3^Sleep-Wake Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21008,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,21008,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,21009,0)
 ;;=G47.419^^95^1042^1
 ;;^UTILITY(U,$J,358.3,21009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21009,1,3,0)
 ;;=3^Autosomal Dominant Cerebella Ataxia,Deafness,and Narcolepsy
 ;;^UTILITY(U,$J,358.3,21009,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,21009,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,21010,0)
 ;;=G47.419^^95^1042^2
 ;;^UTILITY(U,$J,358.3,21010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21010,1,3,0)
 ;;=3^Autosomal Dominant Narcolepsy,Obesity,and Type 2 Diabetes
 ;;^UTILITY(U,$J,358.3,21010,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,21010,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,21011,0)
 ;;=R06.3^^95^1042^5
 ;;^UTILITY(U,$J,358.3,21011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21011,1,3,0)
 ;;=3^Cheyne-Stokes Breathing
 ;;^UTILITY(U,$J,358.3,21011,1,4,0)
 ;;=4^R06.3
 ;;^UTILITY(U,$J,358.3,21011,2)
 ;;=^5019185
 ;;^UTILITY(U,$J,358.3,21012,0)
 ;;=G47.429^^95^1042^18
 ;;^UTILITY(U,$J,358.3,21012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21012,1,3,0)
 ;;=3^Narcolepsy Secondary to Another Medical Condition
 ;;^UTILITY(U,$J,358.3,21012,1,4,0)
 ;;=4^G47.429
 ;;^UTILITY(U,$J,358.3,21012,2)
 ;;=^5003984
 ;;^UTILITY(U,$J,358.3,21013,0)
 ;;=F10.10^^95^1043^30
 ;;^UTILITY(U,$J,358.3,21013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21013,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,21013,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,21013,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,21014,0)
 ;;=F10.20^^95^1043^3
 ;;^UTILITY(U,$J,358.3,21014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21014,1,3,0)
 ;;=3^Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,21014,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,21014,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,21015,0)
 ;;=F10.239^^95^1043^34
 ;;^UTILITY(U,$J,358.3,21015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21015,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,21015,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,21015,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,21016,0)
 ;;=F10.180^^95^1043^5
 ;;^UTILITY(U,$J,358.3,21016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21016,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21016,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,21016,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,21017,0)
 ;;=F10.280^^95^1043^6
 ;;^UTILITY(U,$J,358.3,21017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21017,1,3,0)
 ;;=3^Alcohol Induced Anxiety D/O w/ Moderate/Severe Use Disorder
