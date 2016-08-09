IBDEI139 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39522,1,3,0)
 ;;=3^Inflammatory Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,39522,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,39522,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,39523,0)
 ;;=K71.0^^148^1950^24
 ;;^UTILITY(U,$J,358.3,39523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39523,1,3,0)
 ;;=3^Toxic Liver Disease w/ Cholestasis
 ;;^UTILITY(U,$J,358.3,39523,1,4,0)
 ;;=4^K71.0
 ;;^UTILITY(U,$J,358.3,39523,2)
 ;;=^5008793
 ;;^UTILITY(U,$J,358.3,39524,0)
 ;;=K71.10^^148^1950^30
 ;;^UTILITY(U,$J,358.3,39524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39524,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/o Coma
 ;;^UTILITY(U,$J,358.3,39524,1,4,0)
 ;;=4^K71.10
 ;;^UTILITY(U,$J,358.3,39524,2)
 ;;=^5008794
 ;;^UTILITY(U,$J,358.3,39525,0)
 ;;=K71.11^^148^1950^31
 ;;^UTILITY(U,$J,358.3,39525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39525,1,3,0)
 ;;=3^Toxic Liver Disease w/ Hepatic Necrosis w/ Coma
 ;;^UTILITY(U,$J,358.3,39525,1,4,0)
 ;;=4^K71.11
 ;;^UTILITY(U,$J,358.3,39525,2)
 ;;=^5008795
 ;;^UTILITY(U,$J,358.3,39526,0)
 ;;=K71.2^^148^1950^23
 ;;^UTILITY(U,$J,358.3,39526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39526,1,3,0)
 ;;=3^Toxic Liver Disease w/ Acute Hepatitis
 ;;^UTILITY(U,$J,358.3,39526,1,4,0)
 ;;=4^K71.2
 ;;^UTILITY(U,$J,358.3,39526,2)
 ;;=^5008796
 ;;^UTILITY(U,$J,358.3,39527,0)
 ;;=K71.3^^148^1950^28
 ;;^UTILITY(U,$J,358.3,39527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39527,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Persistent Hepatitis
 ;;^UTILITY(U,$J,358.3,39527,1,4,0)
 ;;=4^K71.3
 ;;^UTILITY(U,$J,358.3,39527,2)
 ;;=^5008797
 ;;^UTILITY(U,$J,358.3,39528,0)
 ;;=K71.4^^148^1950^27
 ;;^UTILITY(U,$J,358.3,39528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39528,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Lobular Hepatitis
 ;;^UTILITY(U,$J,358.3,39528,1,4,0)
 ;;=4^K71.4
 ;;^UTILITY(U,$J,358.3,39528,2)
 ;;=^5008798
 ;;^UTILITY(U,$J,358.3,39529,0)
 ;;=K75.81^^148^1950^19
 ;;^UTILITY(U,$J,358.3,39529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39529,1,3,0)
 ;;=3^Nonalcoholic Steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,39529,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,39529,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,39530,0)
 ;;=K75.89^^148^1950^16
 ;;^UTILITY(U,$J,358.3,39530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39530,1,3,0)
 ;;=3^Inflammatory Liver Disease,Oth Spec
 ;;^UTILITY(U,$J,358.3,39530,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,39530,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,39531,0)
 ;;=K76.4^^148^1950^21
 ;;^UTILITY(U,$J,358.3,39531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39531,1,3,0)
 ;;=3^Peliosis Hepatis
 ;;^UTILITY(U,$J,358.3,39531,1,4,0)
 ;;=4^K76.4
 ;;^UTILITY(U,$J,358.3,39531,2)
 ;;=^91041
 ;;^UTILITY(U,$J,358.3,39532,0)
 ;;=K71.50^^148^1950^25
 ;;^UTILITY(U,$J,358.3,39532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39532,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,39532,1,4,0)
 ;;=4^K71.50
 ;;^UTILITY(U,$J,358.3,39532,2)
 ;;=^5008799
 ;;^UTILITY(U,$J,358.3,39533,0)
 ;;=K71.51^^148^1950^26
 ;;^UTILITY(U,$J,358.3,39533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39533,1,3,0)
 ;;=3^Toxic Liver Disease w/ Chronic Active Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,39533,1,4,0)
 ;;=4^K71.51
 ;;^UTILITY(U,$J,358.3,39533,2)
 ;;=^5008800
 ;;^UTILITY(U,$J,358.3,39534,0)
 ;;=K71.7^^148^1950^29
 ;;^UTILITY(U,$J,358.3,39534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39534,1,3,0)
 ;;=3^Toxic Liver Disease w/ Fibrosis & Cirrhosis of Liver
 ;;^UTILITY(U,$J,358.3,39534,1,4,0)
 ;;=4^K71.7
 ;;^UTILITY(U,$J,358.3,39534,2)
 ;;=^5008802
 ;;^UTILITY(U,$J,358.3,39535,0)
 ;;=K71.8^^148^1950^33
 ;;^UTILITY(U,$J,358.3,39535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39535,1,3,0)
 ;;=3^Toxic Liver Disease w/ Oth Disorders of Liver
 ;;^UTILITY(U,$J,358.3,39535,1,4,0)
 ;;=4^K71.8
 ;;^UTILITY(U,$J,358.3,39535,2)
 ;;=^5008803
 ;;^UTILITY(U,$J,358.3,39536,0)
 ;;=K71.9^^148^1950^34
 ;;^UTILITY(U,$J,358.3,39536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39536,1,3,0)
 ;;=3^Toxic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,39536,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,39536,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,39537,0)
 ;;=K75.2^^148^1950^20
 ;;^UTILITY(U,$J,358.3,39537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39537,1,3,0)
 ;;=3^Nonspecific Reactive Hepatitis
 ;;^UTILITY(U,$J,358.3,39537,1,4,0)
 ;;=4^K75.2
 ;;^UTILITY(U,$J,358.3,39537,2)
 ;;=^5008826
 ;;^UTILITY(U,$J,358.3,39538,0)
 ;;=K75.3^^148^1950^13
 ;;^UTILITY(U,$J,358.3,39538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39538,1,3,0)
 ;;=3^Granulomatous Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,39538,1,4,0)
 ;;=4^K75.3
 ;;^UTILITY(U,$J,358.3,39538,2)
 ;;=^5008827
 ;;^UTILITY(U,$J,358.3,39539,0)
 ;;=K76.6^^148^1950^22
 ;;^UTILITY(U,$J,358.3,39539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39539,1,3,0)
 ;;=3^Portal Hypertension
 ;;^UTILITY(U,$J,358.3,39539,1,4,0)
 ;;=4^K76.6
 ;;^UTILITY(U,$J,358.3,39539,2)
 ;;=^5008834
 ;;^UTILITY(U,$J,358.3,39540,0)
 ;;=F20.3^^148^1951^25
 ;;^UTILITY(U,$J,358.3,39540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39540,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,39540,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,39540,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,39541,0)
 ;;=F20.9^^148^1951^21
 ;;^UTILITY(U,$J,358.3,39541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39541,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,39541,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,39541,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,39542,0)
 ;;=F31.9^^148^1951^6
 ;;^UTILITY(U,$J,358.3,39542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39542,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,39542,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,39542,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,39543,0)
 ;;=F31.72^^148^1951^7
 ;;^UTILITY(U,$J,358.3,39543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39543,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,39543,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,39543,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,39544,0)
 ;;=F31.71^^148^1951^5
 ;;^UTILITY(U,$J,358.3,39544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39544,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,39544,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,39544,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,39545,0)
 ;;=F31.70^^148^1951^4
 ;;^UTILITY(U,$J,358.3,39545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39545,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,39545,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,39545,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,39546,0)
 ;;=F29.^^148^1951^19
 ;;^UTILITY(U,$J,358.3,39546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39546,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,39546,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,39546,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,39547,0)
 ;;=F28.^^148^1951^20
 ;;^UTILITY(U,$J,358.3,39547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39547,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
 ;;^UTILITY(U,$J,358.3,39547,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,39547,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,39548,0)
 ;;=F41.9^^148^1951^3
 ;;^UTILITY(U,$J,358.3,39548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39548,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,39548,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,39548,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,39549,0)
 ;;=F42.^^148^1951^13
 ;;^UTILITY(U,$J,358.3,39549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39549,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
