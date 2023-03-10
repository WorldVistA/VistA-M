IBDEI16D ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19067,1,3,0)
 ;;=3^Pleural Plaque w/ Presence of Asbestos
 ;;^UTILITY(U,$J,358.3,19067,1,4,0)
 ;;=4^J92.0
 ;;^UTILITY(U,$J,358.3,19067,2)
 ;;=^5008312
 ;;^UTILITY(U,$J,358.3,19068,0)
 ;;=J92.9^^64^847^8
 ;;^UTILITY(U,$J,358.3,19068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19068,1,3,0)
 ;;=3^Pleural Plaque w/o Asbestos
 ;;^UTILITY(U,$J,358.3,19068,1,4,0)
 ;;=4^J92.9
 ;;^UTILITY(U,$J,358.3,19068,2)
 ;;=^5008313
 ;;^UTILITY(U,$J,358.3,19069,0)
 ;;=R09.1^^64^847^9
 ;;^UTILITY(U,$J,358.3,19069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19069,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,19069,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,19069,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,19070,0)
 ;;=J86.0^^64^847^10
 ;;^UTILITY(U,$J,358.3,19070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19070,1,3,0)
 ;;=3^Pyothorax w/ Fistula
 ;;^UTILITY(U,$J,358.3,19070,1,4,0)
 ;;=4^J86.0
 ;;^UTILITY(U,$J,358.3,19070,2)
 ;;=^5008308
 ;;^UTILITY(U,$J,358.3,19071,0)
 ;;=J86.9^^64^847^11
 ;;^UTILITY(U,$J,358.3,19071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19071,1,3,0)
 ;;=3^Pyothorax w/o Fistula
 ;;^UTILITY(U,$J,358.3,19071,1,4,0)
 ;;=4^J86.9
 ;;^UTILITY(U,$J,358.3,19071,2)
 ;;=^5008309
 ;;^UTILITY(U,$J,358.3,19072,0)
 ;;=F41.9^^64^848^2
 ;;^UTILITY(U,$J,358.3,19072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19072,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,19072,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,19072,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,19073,0)
 ;;=F10.20^^64^848^1
 ;;^UTILITY(U,$J,358.3,19073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19073,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19073,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,19073,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,19074,0)
 ;;=F32.9^^64^848^5
 ;;^UTILITY(U,$J,358.3,19074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19074,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episoide,Unspec
 ;;^UTILITY(U,$J,358.3,19074,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,19074,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,19075,0)
 ;;=F17.221^^64^848^6
 ;;^UTILITY(U,$J,358.3,19075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19075,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,19075,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,19075,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,19076,0)
 ;;=F17.220^^64^848^7
 ;;^UTILITY(U,$J,358.3,19076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19076,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19076,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,19076,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,19077,0)
 ;;=F17.211^^64^848^8
 ;;^UTILITY(U,$J,358.3,19077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19077,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,In Remission
 ;;^UTILITY(U,$J,358.3,19077,1,4,0)
 ;;=4^F17.211
 ;;^UTILITY(U,$J,358.3,19077,2)
 ;;=^5003366
 ;;^UTILITY(U,$J,358.3,19078,0)
 ;;=F17.210^^64^848^9
 ;;^UTILITY(U,$J,358.3,19078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19078,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes,Uncomplicated
 ;;^UTILITY(U,$J,358.3,19078,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,19078,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,19079,0)
 ;;=F17.291^^64^848^10
 ;;^UTILITY(U,$J,358.3,19079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19079,1,3,0)
 ;;=3^Nicotine Dependence,Oth Tobacco Product,In Remission
