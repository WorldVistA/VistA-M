IBDEI11F ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18487,0)
 ;;=293.83^^101^1058^3
 ;;^UTILITY(U,$J,358.3,18487,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18487,1,2,0)
 ;;=2^293.83
 ;;^UTILITY(U,$J,358.3,18487,1,5,0)
 ;;=5^Mood D/O,Transient,Depressive
 ;;^UTILITY(U,$J,358.3,18487,2)
 ;;=^331838
 ;;^UTILITY(U,$J,358.3,18488,0)
 ;;=295.12^^101^1059^2
 ;;^UTILITY(U,$J,358.3,18488,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18488,1,2,0)
 ;;=2^295.12
 ;;^UTILITY(U,$J,358.3,18488,1,5,0)
 ;;=5^Disorganized Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,18488,2)
 ;;=^268051
 ;;^UTILITY(U,$J,358.3,18489,0)
 ;;=295.14^^101^1059^3
 ;;^UTILITY(U,$J,358.3,18489,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18489,1,2,0)
 ;;=2^295.14
 ;;^UTILITY(U,$J,358.3,18489,1,5,0)
 ;;=5^Disorganized Schizophrenia,Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,18489,2)
 ;;=^268053
 ;;^UTILITY(U,$J,358.3,18490,0)
 ;;=295.52^^101^1059^6
 ;;^UTILITY(U,$J,358.3,18490,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18490,1,2,0)
 ;;=2^295.52
 ;;^UTILITY(U,$J,358.3,18490,1,5,0)
 ;;=5^Latent Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,18490,2)
 ;;=Latent Schizophrenia, Chronic^268073
 ;;^UTILITY(U,$J,358.3,18491,0)
 ;;=295.54^^101^1059^5
 ;;^UTILITY(U,$J,358.3,18491,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18491,1,2,0)
 ;;=2^295.54
 ;;^UTILITY(U,$J,358.3,18491,1,5,0)
 ;;=5^Latent Schizophrenia, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,18491,2)
 ;;=^268075
 ;;^UTILITY(U,$J,358.3,18492,0)
 ;;=295.32^^101^1059^8
 ;;^UTILITY(U,$J,358.3,18492,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18492,1,2,0)
 ;;=2^295.32
 ;;^UTILITY(U,$J,358.3,18492,1,5,0)
 ;;=5^Paranoid Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,18492,2)
 ;;=Paranoid Schizophrenia, Chronic^268061
 ;;^UTILITY(U,$J,358.3,18493,0)
 ;;=295.34^^101^1059^9
 ;;^UTILITY(U,$J,358.3,18493,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18493,1,2,0)
 ;;=2^295.34
 ;;^UTILITY(U,$J,358.3,18493,1,5,0)
 ;;=5^Paranoid, Schizophrenia Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,18493,2)
 ;;=^268063
 ;;^UTILITY(U,$J,358.3,18494,0)
 ;;=295.62^^101^1059^23
 ;;^UTILITY(U,$J,358.3,18494,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18494,1,2,0)
 ;;=2^295.62
 ;;^UTILITY(U,$J,358.3,18494,1,5,0)
 ;;=5^Undifferentiated Schizophrenia, Chr
 ;;^UTILITY(U,$J,358.3,18494,2)
 ;;=^268078
 ;;^UTILITY(U,$J,358.3,18495,0)
 ;;=295.72^^101^1059^11
 ;;^UTILITY(U,$J,358.3,18495,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18495,1,2,0)
 ;;=2^295.72
 ;;^UTILITY(U,$J,358.3,18495,1,5,0)
 ;;=5^Schizoaffective Disorder, Chr
 ;;^UTILITY(U,$J,358.3,18495,2)
 ;;=^268083
 ;;^UTILITY(U,$J,358.3,18496,0)
 ;;=295.74^^101^1059^12
 ;;^UTILITY(U,$J,358.3,18496,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18496,1,2,0)
 ;;=2^295.74
 ;;^UTILITY(U,$J,358.3,18496,1,5,0)
 ;;=5^Schizoaffective Disorder, w/Exacerb.
 ;;^UTILITY(U,$J,358.3,18496,2)
 ;;=^268085
 ;;^UTILITY(U,$J,358.3,18497,0)
 ;;=295.42^^101^1059^17
 ;;^UTILITY(U,$J,358.3,18497,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18497,1,2,0)
 ;;=2^295.42
 ;;^UTILITY(U,$J,358.3,18497,1,5,0)
 ;;=5^Schizophreniform Disorder, Chr
 ;;^UTILITY(U,$J,358.3,18497,2)
 ;;=^268068
 ;;^UTILITY(U,$J,358.3,18498,0)
 ;;=295.44^^101^1059^18
 ;;^UTILITY(U,$J,358.3,18498,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18498,1,2,0)
 ;;=2^295.44
 ;;^UTILITY(U,$J,358.3,18498,1,5,0)
 ;;=5^Schizophreniform Disorderw/Exacerb.
 ;;^UTILITY(U,$J,358.3,18498,2)
 ;;=^268070
 ;;^UTILITY(U,$J,358.3,18499,0)
 ;;=295.02^^101^1059^21
 ;;^UTILITY(U,$J,358.3,18499,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,18499,1,2,0)
 ;;=2^295.02
 ;;^UTILITY(U,$J,358.3,18499,1,5,0)
 ;;=5^Simple Schizophrenia, Chronic
