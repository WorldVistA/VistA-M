IBDEI1F5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23686,0)
 ;;=F06.30^^113^1146^12
 ;;^UTILITY(U,$J,358.3,23686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23686,1,3,0)
 ;;=3^Mood disorder d/t known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,23686,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,23686,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,23687,0)
 ;;=F23.^^113^1146^16
 ;;^UTILITY(U,$J,358.3,23687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23687,1,3,0)
 ;;=3^Psychotic disorder, brief
 ;;^UTILITY(U,$J,358.3,23687,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,23687,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,23688,0)
 ;;=F06.2^^113^1146^15
 ;;^UTILITY(U,$J,358.3,23688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23688,1,3,0)
 ;;=3^Psychotic disorder w/ delusns d/t known physiol cond
 ;;^UTILITY(U,$J,358.3,23688,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,23688,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,23689,0)
 ;;=F29.^^113^1146^14
 ;;^UTILITY(U,$J,358.3,23689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23689,1,3,0)
 ;;=3^Psychosis not d/t a subst or known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,23689,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,23689,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,23690,0)
 ;;=F45.9^^113^1146^17
 ;;^UTILITY(U,$J,358.3,23690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23690,1,3,0)
 ;;=3^Somatoform disorder, unspec
 ;;^UTILITY(U,$J,358.3,23690,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,23690,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,23691,0)
 ;;=Z00.00^^113^1146^11
 ;;^UTILITY(U,$J,358.3,23691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23691,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnl Fndgs
 ;;^UTILITY(U,$J,358.3,23691,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,23691,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,23692,0)
 ;;=Z51.5^^113^1146^13
 ;;^UTILITY(U,$J,358.3,23692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23692,1,3,0)
 ;;=3^Palliative care 
 ;;^UTILITY(U,$J,358.3,23692,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,23692,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,23693,0)
 ;;=Z09.^^113^1146^9
 ;;^UTILITY(U,$J,358.3,23693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23693,1,3,0)
 ;;=3^Follow-up Exam,Compltd TX,Oth Than Cancer
 ;;^UTILITY(U,$J,358.3,23693,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,23693,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,23694,0)
 ;;=Z63.32^^113^1147^2
 ;;^UTILITY(U,$J,358.3,23694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23694,1,3,0)
 ;;=3^Absence of family member, oth
 ;;^UTILITY(U,$J,358.3,23694,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,23694,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,23695,0)
 ;;=Z71.41^^113^1147^3
 ;;^UTILITY(U,$J,358.3,23695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23695,1,3,0)
 ;;=3^Alcohol abuse counslng & surveil of alcoholic
 ;;^UTILITY(U,$J,358.3,23695,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,23695,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,23696,0)
 ;;=Z71.89^^113^1147^4
 ;;^UTILITY(U,$J,358.3,23696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23696,1,3,0)
 ;;=3^Counseling, oth, spec
 ;;^UTILITY(U,$J,358.3,23696,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,23696,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,23697,0)
 ;;=Z71.9^^113^1147^5
 ;;^UTILITY(U,$J,358.3,23697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23697,1,3,0)
 ;;=3^Counseling, unspec
 ;;^UTILITY(U,$J,358.3,23697,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,23697,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,23698,0)
 ;;=Z63.4^^113^1147^8
 ;;^UTILITY(U,$J,358.3,23698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23698,1,3,0)
 ;;=3^Disappearance & death of family member
 ;;^UTILITY(U,$J,358.3,23698,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,23698,2)
 ;;=^5063168
