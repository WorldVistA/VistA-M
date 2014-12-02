IBDEI01P ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,320,2)
 ;;=^331838
 ;;^UTILITY(U,$J,358.3,321,0)
 ;;=295.12^^2^23^2
 ;;^UTILITY(U,$J,358.3,321,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,321,1,2,0)
 ;;=2^295.12
 ;;^UTILITY(U,$J,358.3,321,1,5,0)
 ;;=5^Disorganized Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,321,2)
 ;;=^268051
 ;;^UTILITY(U,$J,358.3,322,0)
 ;;=295.14^^2^23^3
 ;;^UTILITY(U,$J,358.3,322,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,322,1,2,0)
 ;;=2^295.14
 ;;^UTILITY(U,$J,358.3,322,1,5,0)
 ;;=5^Disorganized Schizophrenia,Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,322,2)
 ;;=^268053
 ;;^UTILITY(U,$J,358.3,323,0)
 ;;=295.52^^2^23^6
 ;;^UTILITY(U,$J,358.3,323,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,323,1,2,0)
 ;;=2^295.52
 ;;^UTILITY(U,$J,358.3,323,1,5,0)
 ;;=5^Latent Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,323,2)
 ;;=Latent Schizophrenia, Chronic^268073
 ;;^UTILITY(U,$J,358.3,324,0)
 ;;=295.54^^2^23^5
 ;;^UTILITY(U,$J,358.3,324,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,324,1,2,0)
 ;;=2^295.54
 ;;^UTILITY(U,$J,358.3,324,1,5,0)
 ;;=5^Latent Schizophrenia, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,324,2)
 ;;=^268075
 ;;^UTILITY(U,$J,358.3,325,0)
 ;;=295.32^^2^23^8
 ;;^UTILITY(U,$J,358.3,325,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,325,1,2,0)
 ;;=2^295.32
 ;;^UTILITY(U,$J,358.3,325,1,5,0)
 ;;=5^Paranoid Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,325,2)
 ;;=Paranoid Schizophrenia, Chronic^268061
 ;;^UTILITY(U,$J,358.3,326,0)
 ;;=295.34^^2^23^9
 ;;^UTILITY(U,$J,358.3,326,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,326,1,2,0)
 ;;=2^295.34
 ;;^UTILITY(U,$J,358.3,326,1,5,0)
 ;;=5^Paranoid, Schizophrenia Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,326,2)
 ;;=^268063
 ;;^UTILITY(U,$J,358.3,327,0)
 ;;=295.62^^2^23^23
 ;;^UTILITY(U,$J,358.3,327,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,327,1,2,0)
 ;;=2^295.62
 ;;^UTILITY(U,$J,358.3,327,1,5,0)
 ;;=5^Undifferentiated Schizophrenia, Chr
 ;;^UTILITY(U,$J,358.3,327,2)
 ;;=^268078
 ;;^UTILITY(U,$J,358.3,328,0)
 ;;=295.72^^2^23^11
 ;;^UTILITY(U,$J,358.3,328,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,328,1,2,0)
 ;;=2^295.72
 ;;^UTILITY(U,$J,358.3,328,1,5,0)
 ;;=5^Schizoaffective Disorder, Chr
 ;;^UTILITY(U,$J,358.3,328,2)
 ;;=^268083
 ;;^UTILITY(U,$J,358.3,329,0)
 ;;=295.74^^2^23^12
 ;;^UTILITY(U,$J,358.3,329,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,329,1,2,0)
 ;;=2^295.74
 ;;^UTILITY(U,$J,358.3,329,1,5,0)
 ;;=5^Schizoaffective Disorder, w/Exacerb.
 ;;^UTILITY(U,$J,358.3,329,2)
 ;;=^268085
 ;;^UTILITY(U,$J,358.3,330,0)
 ;;=295.42^^2^23^17
 ;;^UTILITY(U,$J,358.3,330,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,330,1,2,0)
 ;;=2^295.42
 ;;^UTILITY(U,$J,358.3,330,1,5,0)
 ;;=5^Schizophreniform Disorder, Chr
 ;;^UTILITY(U,$J,358.3,330,2)
 ;;=^268068
 ;;^UTILITY(U,$J,358.3,331,0)
 ;;=295.44^^2^23^18
 ;;^UTILITY(U,$J,358.3,331,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,331,1,2,0)
 ;;=2^295.44
 ;;^UTILITY(U,$J,358.3,331,1,5,0)
 ;;=5^Schizophreniform Disorderw/Exacerb.
 ;;^UTILITY(U,$J,358.3,331,2)
 ;;=^268070
 ;;^UTILITY(U,$J,358.3,332,0)
 ;;=295.02^^2^23^21
 ;;^UTILITY(U,$J,358.3,332,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,332,1,2,0)
 ;;=2^295.02
 ;;^UTILITY(U,$J,358.3,332,1,5,0)
 ;;=5^Simple Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,332,2)
 ;;=Simple Schizophrenia, Chronic^268046
 ;;^UTILITY(U,$J,358.3,333,0)
 ;;=295.04^^2^23^20
 ;;^UTILITY(U,$J,358.3,333,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,333,1,2,0)
 ;;=2^295.04
 ;;^UTILITY(U,$J,358.3,333,1,5,0)
 ;;=5^Simple Schizophrenia,  Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,333,2)
 ;;=^268048
