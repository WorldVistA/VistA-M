IBDEI1CJ ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21758,1,3,0)
 ;;=3^Pleural Plaque w/ Presence of Asbestos
 ;;^UTILITY(U,$J,358.3,21758,1,4,0)
 ;;=4^J92.0
 ;;^UTILITY(U,$J,358.3,21758,2)
 ;;=^5008312
 ;;^UTILITY(U,$J,358.3,21759,0)
 ;;=J92.9^^70^927^8
 ;;^UTILITY(U,$J,358.3,21759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21759,1,3,0)
 ;;=3^Pleural Plaque w/o Asbestos
 ;;^UTILITY(U,$J,358.3,21759,1,4,0)
 ;;=4^J92.9
 ;;^UTILITY(U,$J,358.3,21759,2)
 ;;=^5008313
 ;;^UTILITY(U,$J,358.3,21760,0)
 ;;=R09.1^^70^927^9
 ;;^UTILITY(U,$J,358.3,21760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21760,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,21760,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,21760,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,21761,0)
 ;;=J86.0^^70^927^10
 ;;^UTILITY(U,$J,358.3,21761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21761,1,3,0)
 ;;=3^Pyothorax w/ Fistula
 ;;^UTILITY(U,$J,358.3,21761,1,4,0)
 ;;=4^J86.0
 ;;^UTILITY(U,$J,358.3,21761,2)
 ;;=^5008308
 ;;^UTILITY(U,$J,358.3,21762,0)
 ;;=J86.9^^70^927^11
 ;;^UTILITY(U,$J,358.3,21762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21762,1,3,0)
 ;;=3^Pyothorax w/o Fistula
 ;;^UTILITY(U,$J,358.3,21762,1,4,0)
 ;;=4^J86.9
 ;;^UTILITY(U,$J,358.3,21762,2)
 ;;=^5008309
 ;;^UTILITY(U,$J,358.3,21763,0)
 ;;=F41.9^^70^928^2
 ;;^UTILITY(U,$J,358.3,21763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21763,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21763,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,21763,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,21764,0)
 ;;=F10.20^^70^928^1
 ;;^UTILITY(U,$J,358.3,21764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21764,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21764,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,21764,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,21765,0)
 ;;=F32.9^^70^928^5
 ;;^UTILITY(U,$J,358.3,21765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21765,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episoide,Unspec
 ;;^UTILITY(U,$J,358.3,21765,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,21765,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,21766,0)
 ;;=F17.221^^70^928^6
 ;;^UTILITY(U,$J,358.3,21766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21766,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,21766,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,21766,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,21767,0)
 ;;=F17.220^^70^928^7
 ;;^UTILITY(U,$J,358.3,21767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21767,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21767,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,21767,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,21768,0)
 ;;=F17.211^^70^928^8
 ;;^UTILITY(U,$J,358.3,21768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21768,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,21768,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,21768,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,21769,0)
 ;;=F17.210^^70^928^9
 ;;^UTILITY(U,$J,358.3,21769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21769,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,21769,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,21769,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,21770,0)
 ;;=F17.291^^70^928^10
 ;;^UTILITY(U,$J,358.3,21770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21770,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
