IBDEI20T ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34281,0)
 ;;=K75.9^^131^1683^17
 ;;^UTILITY(U,$J,358.3,34281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34281,1,3,0)
 ;;=3^Inflammatory Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,34281,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,34281,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,34282,0)
 ;;=K71.0^^131^1683^24
 ;;^UTILITY(U,$J,358.3,34282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34282,1,3,0)
 ;;=3^Toxic Liver Disease w/ Cholestasis
 ;;^UTILITY(U,$J,358.3,34282,1,4,0)
 ;;=4^K71.0
 ;;^UTILITY(U,$J,358.3,34282,2)
 ;;=^5008793
 ;;^UTILITY(U,$J,358.3,34283,0)
 ;;=K71.10^^131^1683^30
 ;;^UTILITY(U,$J,358.3,34283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34283,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/o Coma
 ;;^UTILITY(U,$J,358.3,34283,1,4,0)
 ;;=4^K71.10
 ;;^UTILITY(U,$J,358.3,34283,2)
 ;;=^5008794
 ;;^UTILITY(U,$J,358.3,34284,0)
 ;;=K71.11^^131^1683^31
 ;;^UTILITY(U,$J,358.3,34284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34284,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/ Coma
 ;;^UTILITY(U,$J,358.3,34284,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,34284,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,34285,0)
 ;;=K71.2^^131^1683^23
 ;;^UTILITY(U,$J,358.3,34285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34285,1,3,0)
 ;;=3^Toxic Liver Disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,34285,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,34285,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,34286,0)
 ;;=K71.3^^131^1683^28
 ;;^UTILITY(U,$J,358.3,34286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34286,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,34286,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,34286,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,34287,0)
 ;;=K71.4^^131^1683^27
 ;;^UTILITY(U,$J,358.3,34287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34287,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,34287,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,34287,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,34288,0)
 ;;=K75.81^^131^1683^19
 ;;^UTILITY(U,$J,358.3,34288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34288,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,34288,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,34288,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,34289,0)
 ;;=K75.89^^131^1683^16
 ;;^UTILITY(U,$J,358.3,34289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34289,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,34289,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,34289,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,34290,0)
 ;;=K76.4^^131^1683^21
 ;;^UTILITY(U,$J,358.3,34290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34290,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,34290,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,34290,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,34291,0)
 ;;=K71.50^^131^1683^25
 ;;^UTILITY(U,$J,358.3,34291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34291,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,34291,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,34291,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,34292,0)
 ;;=K71.51^^131^1683^26
 ;;^UTILITY(U,$J,358.3,34292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34292,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,34292,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,34292,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,34293,0)
 ;;=K71.7^^131^1683^29
 ;;^UTILITY(U,$J,358.3,34293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34293,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
