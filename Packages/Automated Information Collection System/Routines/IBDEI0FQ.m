IBDEI0FQ ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7610,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7610,1,4,0)
 ;;=4^787.60
 ;;^UTILITY(U,$J,358.3,7610,1,5,0)
 ;;=5^Incontinence of Feces
 ;;^UTILITY(U,$J,358.3,7610,2)
 ;;=^339670
 ;;^UTILITY(U,$J,358.3,7611,0)
 ;;=780.61^^55^583^72
 ;;^UTILITY(U,$J,358.3,7611,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7611,1,4,0)
 ;;=4^780.61
 ;;^UTILITY(U,$J,358.3,7611,1,5,0)
 ;;=5^Fever in Other Conditions
 ;;^UTILITY(U,$J,358.3,7611,2)
 ;;=^336667
 ;;^UTILITY(U,$J,358.3,7612,0)
 ;;=780.62^^55^583^73
 ;;^UTILITY(U,$J,358.3,7612,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7612,1,4,0)
 ;;=4^780.62
 ;;^UTILITY(U,$J,358.3,7612,1,5,0)
 ;;=5^Fever,Postprocedural
 ;;^UTILITY(U,$J,358.3,7612,2)
 ;;=^336668
 ;;^UTILITY(U,$J,358.3,7613,0)
 ;;=780.63^^55^583^74
 ;;^UTILITY(U,$J,358.3,7613,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7613,1,4,0)
 ;;=4^780.63
 ;;^UTILITY(U,$J,358.3,7613,1,5,0)
 ;;=5^Fever,Postvaccination
 ;;^UTILITY(U,$J,358.3,7613,2)
 ;;=^336669
 ;;^UTILITY(U,$J,358.3,7614,0)
 ;;=780.64^^55^583^38
 ;;^UTILITY(U,$J,358.3,7614,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7614,1,4,0)
 ;;=4^780.64
 ;;^UTILITY(U,$J,358.3,7614,1,5,0)
 ;;=5^Chills w/o Fever
 ;;^UTILITY(U,$J,358.3,7614,2)
 ;;=^336670
 ;;^UTILITY(U,$J,358.3,7615,0)
 ;;=780.65^^55^583^89
 ;;^UTILITY(U,$J,358.3,7615,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7615,1,4,0)
 ;;=4^780.65
 ;;^UTILITY(U,$J,358.3,7615,1,5,0)
 ;;=5^Hypothermia w/o Low Env Temp
 ;;^UTILITY(U,$J,358.3,7615,2)
 ;;=^336671
 ;;^UTILITY(U,$J,358.3,7616,0)
 ;;=780.99^^55^583^41
 ;;^UTILITY(U,$J,358.3,7616,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7616,1,4,0)
 ;;=4^780.99
 ;;^UTILITY(U,$J,358.3,7616,1,5,0)
 ;;=5^Cold Intolerence
 ;;^UTILITY(U,$J,358.3,7616,2)
 ;;=^328568
 ;;^UTILITY(U,$J,358.3,7617,0)
 ;;=787.21^^55^583^56
 ;;^UTILITY(U,$J,358.3,7617,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7617,1,4,0)
 ;;=4^787.21
 ;;^UTILITY(U,$J,358.3,7617,1,5,0)
 ;;=5^Dysphagia, Oral Phase
 ;;^UTILITY(U,$J,358.3,7617,2)
 ;;=^335276
 ;;^UTILITY(U,$J,358.3,7618,0)
 ;;=787.22^^55^583^57
 ;;^UTILITY(U,$J,358.3,7618,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7618,1,4,0)
 ;;=4^787.22
 ;;^UTILITY(U,$J,358.3,7618,1,5,0)
 ;;=5^Dysphagia, Oropharyngeal
 ;;^UTILITY(U,$J,358.3,7618,2)
 ;;=^335277
 ;;^UTILITY(U,$J,358.3,7619,0)
 ;;=787.23^^55^583^58
 ;;^UTILITY(U,$J,358.3,7619,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7619,1,4,0)
 ;;=4^787.23
 ;;^UTILITY(U,$J,358.3,7619,1,5,0)
 ;;=5^Dysphagia, Pharyngeal
 ;;^UTILITY(U,$J,358.3,7619,2)
 ;;=^335278
 ;;^UTILITY(U,$J,358.3,7620,0)
 ;;=787.24^^55^583^59
 ;;^UTILITY(U,$J,358.3,7620,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7620,1,4,0)
 ;;=4^787.24
 ;;^UTILITY(U,$J,358.3,7620,1,5,0)
 ;;=5^Dysphagia, Pharyngoesoph
 ;;^UTILITY(U,$J,358.3,7620,2)
 ;;=^335279
 ;;^UTILITY(U,$J,358.3,7621,0)
 ;;=995.83^^55^584^2
 ;;^UTILITY(U,$J,358.3,7621,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7621,1,4,0)
 ;;=4^995.83
 ;;^UTILITY(U,$J,358.3,7621,1,5,0)
 ;;=5^Non-Military Sexual Trauma
 ;;^UTILITY(U,$J,358.3,7621,2)
 ;;=^1
 ;;^UTILITY(U,$J,358.3,7622,0)
 ;;=E967.9^^55^584^1
 ;;^UTILITY(U,$J,358.3,7622,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7622,1,4,0)
 ;;=4^E967.9
 ;;^UTILITY(U,$J,358.3,7622,1,5,0)
 ;;=5^Child & Adult Abuse by Unspec Person
 ;;^UTILITY(U,$J,358.3,7622,2)
 ;;=^22623
 ;;^UTILITY(U,$J,358.3,7623,0)
 ;;=784.0^^55^585^18
 ;;^UTILITY(U,$J,358.3,7623,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7623,1,4,0)
 ;;=4^784.0
 ;;^UTILITY(U,$J,358.3,7623,1,5,0)
 ;;=5^Headache
 ;;^UTILITY(U,$J,358.3,7623,2)
 ;;=Headache^54133
 ;;^UTILITY(U,$J,358.3,7624,0)
 ;;=729.5^^55^585^16