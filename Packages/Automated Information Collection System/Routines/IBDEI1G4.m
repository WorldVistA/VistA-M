IBDEI1G4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24148,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,24148,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,24149,0)
 ;;=F44.9^^116^1186^6
 ;;^UTILITY(U,$J,358.3,24149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24149,1,3,0)
 ;;=3^Dissociative & conversion disorder, unspec
 ;;^UTILITY(U,$J,358.3,24149,1,4,0)
 ;;=4^F44.9
 ;;^UTILITY(U,$J,358.3,24149,2)
 ;;=^5003584
 ;;^UTILITY(U,$J,358.3,24150,0)
 ;;=F50.8^^116^1186^7
 ;;^UTILITY(U,$J,358.3,24150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24150,1,3,0)
 ;;=3^Eating disorder, oth
 ;;^UTILITY(U,$J,358.3,24150,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,24150,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,24151,0)
 ;;=F50.9^^116^1186^8
 ;;^UTILITY(U,$J,358.3,24151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24151,1,3,0)
 ;;=3^Eating disorder, unspec
 ;;^UTILITY(U,$J,358.3,24151,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,24151,2)
 ;;=^5003602
 ;;^UTILITY(U,$J,358.3,24152,0)
 ;;=F64.1^^116^1186^10
 ;;^UTILITY(U,$J,358.3,24152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24152,1,3,0)
 ;;=3^Gender ident disorder in adlscnc & adlthd
 ;;^UTILITY(U,$J,358.3,24152,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,24152,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,24153,0)
 ;;=F06.30^^116^1186^12
 ;;^UTILITY(U,$J,358.3,24153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24153,1,3,0)
 ;;=3^Mood disorder d/t known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,24153,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,24153,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,24154,0)
 ;;=F23.^^116^1186^16
 ;;^UTILITY(U,$J,358.3,24154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24154,1,3,0)
 ;;=3^Psychotic disorder, brief
 ;;^UTILITY(U,$J,358.3,24154,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,24154,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,24155,0)
 ;;=F06.2^^116^1186^15
 ;;^UTILITY(U,$J,358.3,24155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24155,1,3,0)
 ;;=3^Psychotic disorder w/ delusns d/t known physiol cond
 ;;^UTILITY(U,$J,358.3,24155,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,24155,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,24156,0)
 ;;=F29.^^116^1186^14
 ;;^UTILITY(U,$J,358.3,24156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24156,1,3,0)
 ;;=3^Psychosis not d/t a subst or known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,24156,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,24156,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,24157,0)
 ;;=F45.9^^116^1186^17
 ;;^UTILITY(U,$J,358.3,24157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24157,1,3,0)
 ;;=3^Somatoform disorder, unspec
 ;;^UTILITY(U,$J,358.3,24157,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,24157,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,24158,0)
 ;;=Z00.00^^116^1186^11
 ;;^UTILITY(U,$J,358.3,24158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24158,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnl Fndgs
 ;;^UTILITY(U,$J,358.3,24158,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,24158,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,24159,0)
 ;;=Z51.5^^116^1186^13
 ;;^UTILITY(U,$J,358.3,24159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24159,1,3,0)
 ;;=3^Palliative care 
 ;;^UTILITY(U,$J,358.3,24159,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,24159,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,24160,0)
 ;;=Z09.^^116^1186^9
 ;;^UTILITY(U,$J,358.3,24160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24160,1,3,0)
 ;;=3^Follow-up Exam,Compltd TX,Oth Than Cancer
 ;;^UTILITY(U,$J,358.3,24160,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,24160,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,24161,0)
 ;;=Z63.32^^116^1187^2
 ;;^UTILITY(U,$J,358.3,24161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24161,1,3,0)
 ;;=3^Absence of family member, oth
