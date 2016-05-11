IBDEI11A ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17543,1,3,0)
 ;;=3^Psychotic disorder, brief
 ;;^UTILITY(U,$J,358.3,17543,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,17543,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,17544,0)
 ;;=F06.2^^73^848^15
 ;;^UTILITY(U,$J,358.3,17544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17544,1,3,0)
 ;;=3^Psychotic disorder w/ delusns d/t known physiol cond
 ;;^UTILITY(U,$J,358.3,17544,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,17544,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,17545,0)
 ;;=F29.^^73^848^14
 ;;^UTILITY(U,$J,358.3,17545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17545,1,3,0)
 ;;=3^Psychosis not d/t a subst or known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,17545,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,17545,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,17546,0)
 ;;=F45.9^^73^848^17
 ;;^UTILITY(U,$J,358.3,17546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17546,1,3,0)
 ;;=3^Somatoform disorder, unspec
 ;;^UTILITY(U,$J,358.3,17546,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,17546,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,17547,0)
 ;;=Z00.00^^73^848^11
 ;;^UTILITY(U,$J,358.3,17547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17547,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnl Fndgs
 ;;^UTILITY(U,$J,358.3,17547,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,17547,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,17548,0)
 ;;=Z51.5^^73^848^13
 ;;^UTILITY(U,$J,358.3,17548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17548,1,3,0)
 ;;=3^Palliative care 
 ;;^UTILITY(U,$J,358.3,17548,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,17548,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,17549,0)
 ;;=Z09.^^73^848^9
 ;;^UTILITY(U,$J,358.3,17549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17549,1,3,0)
 ;;=3^Follow-up Exam,Compltd TX,Oth Than Cancer
 ;;^UTILITY(U,$J,358.3,17549,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,17549,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,17550,0)
 ;;=Z63.32^^73^849^2
 ;;^UTILITY(U,$J,358.3,17550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17550,1,3,0)
 ;;=3^Absence of family member, oth
 ;;^UTILITY(U,$J,358.3,17550,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,17550,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,17551,0)
 ;;=Z71.41^^73^849^3
 ;;^UTILITY(U,$J,358.3,17551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17551,1,3,0)
 ;;=3^Alcohol abuse counslng & surveil of alcoholic
 ;;^UTILITY(U,$J,358.3,17551,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,17551,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,17552,0)
 ;;=Z71.89^^73^849^4
 ;;^UTILITY(U,$J,358.3,17552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17552,1,3,0)
 ;;=3^Counseling, oth, spec
 ;;^UTILITY(U,$J,358.3,17552,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,17552,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,17553,0)
 ;;=Z71.9^^73^849^5
 ;;^UTILITY(U,$J,358.3,17553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17553,1,3,0)
 ;;=3^Counseling, unspec
 ;;^UTILITY(U,$J,358.3,17553,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,17553,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,17554,0)
 ;;=Z63.4^^73^849^8
 ;;^UTILITY(U,$J,358.3,17554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17554,1,3,0)
 ;;=3^Disappearance & death of family member
 ;;^UTILITY(U,$J,358.3,17554,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,17554,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,17555,0)
 ;;=Z73.82^^73^849^9
 ;;^UTILITY(U,$J,358.3,17555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17555,1,3,0)
 ;;=3^Dual sensory impairment
 ;;^UTILITY(U,$J,358.3,17555,1,4,0)
 ;;=4^Z73.82
 ;;^UTILITY(U,$J,358.3,17555,2)
 ;;=^5063279
 ;;^UTILITY(U,$J,358.3,17556,0)
 ;;=Z04.41^^73^849^10
 ;;^UTILITY(U,$J,358.3,17556,1,0)
 ;;=^358.31IA^4^2
