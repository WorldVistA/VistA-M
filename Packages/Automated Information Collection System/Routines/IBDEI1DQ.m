IBDEI1DQ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22047,0)
 ;;=F64.1^^99^1124^9
 ;;^UTILITY(U,$J,358.3,22047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22047,1,3,0)
 ;;=3^Gender ident disorder in adlscnc & adlthd
 ;;^UTILITY(U,$J,358.3,22047,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,22047,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,22048,0)
 ;;=F06.30^^99^1124^11
 ;;^UTILITY(U,$J,358.3,22048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22048,1,3,0)
 ;;=3^Mood disorder d/t known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,22048,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,22048,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,22049,0)
 ;;=F23.^^99^1124^15
 ;;^UTILITY(U,$J,358.3,22049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22049,1,3,0)
 ;;=3^Psychotic disorder, brief
 ;;^UTILITY(U,$J,358.3,22049,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,22049,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,22050,0)
 ;;=F06.2^^99^1124^14
 ;;^UTILITY(U,$J,358.3,22050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22050,1,3,0)
 ;;=3^Psychotic disorder w/ delusns d/t known physiol cond
 ;;^UTILITY(U,$J,358.3,22050,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,22050,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,22051,0)
 ;;=F29.^^99^1124^13
 ;;^UTILITY(U,$J,358.3,22051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22051,1,3,0)
 ;;=3^Psychosis not d/t a subst or known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,22051,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,22051,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,22052,0)
 ;;=F45.9^^99^1124^16
 ;;^UTILITY(U,$J,358.3,22052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22052,1,3,0)
 ;;=3^Somatoform disorder, unspec
 ;;^UTILITY(U,$J,358.3,22052,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,22052,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,22053,0)
 ;;=Z00.00^^99^1124^10
 ;;^UTILITY(U,$J,358.3,22053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22053,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnl Fndgs
 ;;^UTILITY(U,$J,358.3,22053,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,22053,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,22054,0)
 ;;=Z51.5^^99^1124^12
 ;;^UTILITY(U,$J,358.3,22054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22054,1,3,0)
 ;;=3^Palliative care 
 ;;^UTILITY(U,$J,358.3,22054,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,22054,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,22055,0)
 ;;=Z09.^^99^1124^8
 ;;^UTILITY(U,$J,358.3,22055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22055,1,3,0)
 ;;=3^Follow-up Exam,Compltd TX,Oth Than Cancer
 ;;^UTILITY(U,$J,358.3,22055,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,22055,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,22056,0)
 ;;=Z63.32^^99^1125^2
 ;;^UTILITY(U,$J,358.3,22056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22056,1,3,0)
 ;;=3^Absence of family member, oth
 ;;^UTILITY(U,$J,358.3,22056,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,22056,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,22057,0)
 ;;=Z71.41^^99^1125^3
 ;;^UTILITY(U,$J,358.3,22057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22057,1,3,0)
 ;;=3^Alcohol abuse counslng & surveil of alcoholic
 ;;^UTILITY(U,$J,358.3,22057,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,22057,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,22058,0)
 ;;=Z71.89^^99^1125^4
 ;;^UTILITY(U,$J,358.3,22058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22058,1,3,0)
 ;;=3^Counseling, oth, spec
 ;;^UTILITY(U,$J,358.3,22058,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,22058,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,22059,0)
 ;;=Z71.9^^99^1125^5
