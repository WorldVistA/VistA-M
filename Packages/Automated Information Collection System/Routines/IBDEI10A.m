IBDEI10A ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17064,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,17064,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,17065,0)
 ;;=F50.9^^70^808^8
 ;;^UTILITY(U,$J,358.3,17065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17065,1,3,0)
 ;;=3^Eating disorder, unspec
 ;;^UTILITY(U,$J,358.3,17065,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,17065,2)
 ;;=^5003602
 ;;^UTILITY(U,$J,358.3,17066,0)
 ;;=F64.1^^70^808^10
 ;;^UTILITY(U,$J,358.3,17066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17066,1,3,0)
 ;;=3^Gender ident disorder in adlscnc & adlthd
 ;;^UTILITY(U,$J,358.3,17066,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,17066,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,17067,0)
 ;;=F06.30^^70^808^12
 ;;^UTILITY(U,$J,358.3,17067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17067,1,3,0)
 ;;=3^Mood disorder d/t known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,17067,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,17067,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,17068,0)
 ;;=F23.^^70^808^16
 ;;^UTILITY(U,$J,358.3,17068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17068,1,3,0)
 ;;=3^Psychotic disorder, brief
 ;;^UTILITY(U,$J,358.3,17068,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,17068,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,17069,0)
 ;;=F06.2^^70^808^15
 ;;^UTILITY(U,$J,358.3,17069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17069,1,3,0)
 ;;=3^Psychotic disorder w/ delusns d/t known physiol cond
 ;;^UTILITY(U,$J,358.3,17069,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,17069,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,17070,0)
 ;;=F29.^^70^808^14
 ;;^UTILITY(U,$J,358.3,17070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17070,1,3,0)
 ;;=3^Psychosis not d/t a subst or known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,17070,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,17070,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,17071,0)
 ;;=F45.9^^70^808^17
 ;;^UTILITY(U,$J,358.3,17071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17071,1,3,0)
 ;;=3^Somatoform disorder, unspec
 ;;^UTILITY(U,$J,358.3,17071,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,17071,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,17072,0)
 ;;=Z00.00^^70^808^11
 ;;^UTILITY(U,$J,358.3,17072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17072,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnl Fndgs
 ;;^UTILITY(U,$J,358.3,17072,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,17072,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,17073,0)
 ;;=Z51.5^^70^808^13
 ;;^UTILITY(U,$J,358.3,17073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17073,1,3,0)
 ;;=3^Palliative care 
 ;;^UTILITY(U,$J,358.3,17073,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,17073,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,17074,0)
 ;;=Z09.^^70^808^9
 ;;^UTILITY(U,$J,358.3,17074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17074,1,3,0)
 ;;=3^Follow-up Exam,Compltd TX,Oth Than Cancer
 ;;^UTILITY(U,$J,358.3,17074,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,17074,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,17075,0)
 ;;=Z63.32^^70^809^2
 ;;^UTILITY(U,$J,358.3,17075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17075,1,3,0)
 ;;=3^Absence of family member, oth
 ;;^UTILITY(U,$J,358.3,17075,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,17075,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,17076,0)
 ;;=Z71.41^^70^809^3
 ;;^UTILITY(U,$J,358.3,17076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17076,1,3,0)
 ;;=3^Alcohol abuse counslng & surveil of alcoholic
 ;;^UTILITY(U,$J,358.3,17076,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,17076,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,17077,0)
 ;;=Z71.89^^70^809^4
 ;;^UTILITY(U,$J,358.3,17077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17077,1,3,0)
 ;;=3^Counseling, oth, spec
