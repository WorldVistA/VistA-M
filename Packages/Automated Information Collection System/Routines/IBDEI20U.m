IBDEI20U ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34293,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,34293,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,34294,0)
 ;;=K71.8^^131^1683^33
 ;;^UTILITY(U,$J,358.3,34294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34294,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,34294,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,34294,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,34295,0)
 ;;=K71.9^^131^1683^34
 ;;^UTILITY(U,$J,358.3,34295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34295,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,34295,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,34295,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,34296,0)
 ;;=K75.2^^131^1683^20
 ;;^UTILITY(U,$J,358.3,34296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34296,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,34296,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,34296,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,34297,0)
 ;;=K75.3^^131^1683^13
 ;;^UTILITY(U,$J,358.3,34297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34297,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,34297,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,34297,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,34298,0)
 ;;=K76.6^^131^1683^22
 ;;^UTILITY(U,$J,358.3,34298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34298,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,34298,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,34298,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,34299,0)
 ;;=F20.3^^131^1684^25
 ;;^UTILITY(U,$J,358.3,34299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34299,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,34299,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,34299,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,34300,0)
 ;;=F20.9^^131^1684^21
 ;;^UTILITY(U,$J,358.3,34300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34300,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,34300,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,34300,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,34301,0)
 ;;=F31.9^^131^1684^6
 ;;^UTILITY(U,$J,358.3,34301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34301,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,34301,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,34301,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,34302,0)
 ;;=F31.72^^131^1684^7
 ;;^UTILITY(U,$J,358.3,34302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34302,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,34302,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,34302,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,34303,0)
 ;;=F31.71^^131^1684^5
 ;;^UTILITY(U,$J,358.3,34303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34303,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,34303,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,34303,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,34304,0)
 ;;=F31.70^^131^1684^4
 ;;^UTILITY(U,$J,358.3,34304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34304,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,34304,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,34304,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,34305,0)
 ;;=F29.^^131^1684^19
 ;;^UTILITY(U,$J,358.3,34305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34305,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,34305,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,34305,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,34306,0)
 ;;=F28.^^131^1684^20
 ;;^UTILITY(U,$J,358.3,34306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34306,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
