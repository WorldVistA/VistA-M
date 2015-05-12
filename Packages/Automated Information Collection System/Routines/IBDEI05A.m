IBDEI05A ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7020,2)
 ;;=^268114
 ;;^UTILITY(U,$J,358.3,7021,0)
 ;;=296.30^^45^480^9
 ;;^UTILITY(U,$J,358.3,7021,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7021,1,2,0)
 ;;=2^296.30
 ;;^UTILITY(U,$J,358.3,7021,1,5,0)
 ;;=5^MDD, Recur, NOS
 ;;^UTILITY(U,$J,358.3,7021,2)
 ;;=^268116
 ;;^UTILITY(U,$J,358.3,7022,0)
 ;;=296.31^^45^480^7
 ;;^UTILITY(U,$J,358.3,7022,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7022,1,2,0)
 ;;=2^296.31
 ;;^UTILITY(U,$J,358.3,7022,1,5,0)
 ;;=5^MDD, Recur, Mild
 ;;^UTILITY(U,$J,358.3,7022,2)
 ;;=^268117
 ;;^UTILITY(U,$J,358.3,7023,0)
 ;;=296.32^^45^480^8
 ;;^UTILITY(U,$J,358.3,7023,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7023,1,2,0)
 ;;=2^296.32
 ;;^UTILITY(U,$J,358.3,7023,1,5,0)
 ;;=5^MDD, Recur, Moderate
 ;;^UTILITY(U,$J,358.3,7023,2)
 ;;=^268118
 ;;^UTILITY(U,$J,358.3,7024,0)
 ;;=296.33^^45^480^3
 ;;^UTILITY(U,$J,358.3,7024,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7024,1,2,0)
 ;;=2^296.33
 ;;^UTILITY(U,$J,358.3,7024,1,5,0)
 ;;=5^MDD Recur, Sev w/o Psychosis
 ;;^UTILITY(U,$J,358.3,7024,2)
 ;;=^268119
 ;;^UTILITY(U,$J,358.3,7025,0)
 ;;=296.34^^45^480^2
 ;;^UTILITY(U,$J,358.3,7025,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7025,1,2,0)
 ;;=2^296.34
 ;;^UTILITY(U,$J,358.3,7025,1,5,0)
 ;;=5^MDD Recur, Sev w/Psychosis
 ;;^UTILITY(U,$J,358.3,7025,2)
 ;;=^268120
 ;;^UTILITY(U,$J,358.3,7026,0)
 ;;=296.35^^45^480^10
 ;;^UTILITY(U,$J,358.3,7026,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7026,1,2,0)
 ;;=2^296.35
 ;;^UTILITY(U,$J,358.3,7026,1,5,0)
 ;;=5^MDD, Recur, Part Remiss
 ;;^UTILITY(U,$J,358.3,7026,2)
 ;;=^268121
 ;;^UTILITY(U,$J,358.3,7027,0)
 ;;=296.36^^45^480^6
 ;;^UTILITY(U,$J,358.3,7027,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7027,1,2,0)
 ;;=2^296.36
 ;;^UTILITY(U,$J,358.3,7027,1,5,0)
 ;;=5^MDD, Recur, Full Remiss
 ;;^UTILITY(U,$J,358.3,7027,2)
 ;;=^268122
 ;;^UTILITY(U,$J,358.3,7028,0)
 ;;=311.^^45^480^1
 ;;^UTILITY(U,$J,358.3,7028,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7028,1,2,0)
 ;;=2^311.
 ;;^UTILITY(U,$J,358.3,7028,1,5,0)
 ;;=5^Depression, NOS
 ;;^UTILITY(U,$J,358.3,7028,2)
 ;;=^35603
 ;;^UTILITY(U,$J,358.3,7029,0)
 ;;=296.26^^45^480^11
 ;;^UTILITY(U,$J,358.3,7029,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7029,1,2,0)
 ;;=2^296.26
 ;;^UTILITY(U,$J,358.3,7029,1,5,0)
 ;;=5^MDD, Single, Full Remiss
 ;;^UTILITY(U,$J,358.3,7029,2)
 ;;=^268115
 ;;^UTILITY(U,$J,358.3,7030,0)
 ;;=301.13^^45^481^1
 ;;^UTILITY(U,$J,358.3,7030,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7030,1,2,0)
 ;;=2^301.13
 ;;^UTILITY(U,$J,358.3,7030,1,5,0)
 ;;=5^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,7030,2)
 ;;=^30028
 ;;^UTILITY(U,$J,358.3,7031,0)
 ;;=300.4^^45^481^2
 ;;^UTILITY(U,$J,358.3,7031,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7031,1,2,0)
 ;;=2^300.4
 ;;^UTILITY(U,$J,358.3,7031,1,5,0)
 ;;=5^Dysthymia
 ;;^UTILITY(U,$J,358.3,7031,2)
 ;;=^303478
 ;;^UTILITY(U,$J,358.3,7032,0)
 ;;=293.82^^45^481^4
 ;;^UTILITY(U,$J,358.3,7032,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7032,1,2,0)
 ;;=2^293.82
 ;;^UTILITY(U,$J,358.3,7032,1,5,0)
 ;;=5^Mood D/O,Transient,Hallucinator
 ;;^UTILITY(U,$J,358.3,7032,2)
 ;;=^331837
 ;;^UTILITY(U,$J,358.3,7033,0)
 ;;=293.83^^45^481^3
 ;;^UTILITY(U,$J,358.3,7033,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7033,1,2,0)
 ;;=2^293.83
 ;;^UTILITY(U,$J,358.3,7033,1,5,0)
 ;;=5^Mood D/O,Transient,Depressive
 ;;^UTILITY(U,$J,358.3,7033,2)
 ;;=^331838
 ;;^UTILITY(U,$J,358.3,7034,0)
 ;;=295.12^^45^482^2
 ;;^UTILITY(U,$J,358.3,7034,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7034,1,2,0)
 ;;=2^295.12
 ;;^UTILITY(U,$J,358.3,7034,1,5,0)
 ;;=5^Disorganized Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,7034,2)
 ;;=^268051
 ;;^UTILITY(U,$J,358.3,7035,0)
 ;;=295.14^^45^482^3
 ;;^UTILITY(U,$J,358.3,7035,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7035,1,2,0)
 ;;=2^295.14
 ;;^UTILITY(U,$J,358.3,7035,1,5,0)
 ;;=5^Disorganized Schizophrenia,Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,7035,2)
 ;;=^268053
 ;;^UTILITY(U,$J,358.3,7036,0)
 ;;=295.52^^45^482^6
 ;;^UTILITY(U,$J,358.3,7036,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7036,1,2,0)
 ;;=2^295.52
 ;;^UTILITY(U,$J,358.3,7036,1,5,0)
 ;;=5^Latent Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,7036,2)
 ;;=Latent Schizophrenia, Chronic^268073
 ;;^UTILITY(U,$J,358.3,7037,0)
 ;;=295.54^^45^482^5
 ;;^UTILITY(U,$J,358.3,7037,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7037,1,2,0)
 ;;=2^295.54
 ;;^UTILITY(U,$J,358.3,7037,1,5,0)
 ;;=5^Latent Schizophrenia, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,7037,2)
 ;;=^268075
 ;;^UTILITY(U,$J,358.3,7038,0)
 ;;=295.32^^45^482^8
 ;;^UTILITY(U,$J,358.3,7038,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7038,1,2,0)
 ;;=2^295.32
 ;;^UTILITY(U,$J,358.3,7038,1,5,0)
 ;;=5^Paranoid Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,7038,2)
 ;;=Paranoid Schizophrenia, Chronic^268061
 ;;^UTILITY(U,$J,358.3,7039,0)
 ;;=295.34^^45^482^9
 ;;^UTILITY(U,$J,358.3,7039,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7039,1,2,0)
 ;;=2^295.34
 ;;^UTILITY(U,$J,358.3,7039,1,5,0)
 ;;=5^Paranoid, Schizophrenia Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,7039,2)
 ;;=^268063
 ;;^UTILITY(U,$J,358.3,7040,0)
 ;;=295.62^^45^482^23
 ;;^UTILITY(U,$J,358.3,7040,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7040,1,2,0)
 ;;=2^295.62
 ;;^UTILITY(U,$J,358.3,7040,1,5,0)
 ;;=5^Undifferentiated Schizophrenia, Chr
 ;;^UTILITY(U,$J,358.3,7040,2)
 ;;=^268078
 ;;^UTILITY(U,$J,358.3,7041,0)
 ;;=295.72^^45^482^11
 ;;^UTILITY(U,$J,358.3,7041,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7041,1,2,0)
 ;;=2^295.72
 ;;^UTILITY(U,$J,358.3,7041,1,5,0)
 ;;=5^Schizoaffective Disorder, Chr
 ;;^UTILITY(U,$J,358.3,7041,2)
 ;;=^268083
 ;;^UTILITY(U,$J,358.3,7042,0)
 ;;=295.74^^45^482^12
 ;;^UTILITY(U,$J,358.3,7042,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7042,1,2,0)
 ;;=2^295.74
 ;;^UTILITY(U,$J,358.3,7042,1,5,0)
 ;;=5^Schizoaffective Disorder, w/Exacerb.
 ;;^UTILITY(U,$J,358.3,7042,2)
 ;;=^268085
 ;;^UTILITY(U,$J,358.3,7043,0)
 ;;=295.42^^45^482^17
 ;;^UTILITY(U,$J,358.3,7043,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7043,1,2,0)
 ;;=2^295.42
 ;;^UTILITY(U,$J,358.3,7043,1,5,0)
 ;;=5^Schizophreniform Disorder, Chr
 ;;^UTILITY(U,$J,358.3,7043,2)
 ;;=^268068
 ;;^UTILITY(U,$J,358.3,7044,0)
 ;;=295.44^^45^482^18
 ;;^UTILITY(U,$J,358.3,7044,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7044,1,2,0)
 ;;=2^295.44
 ;;^UTILITY(U,$J,358.3,7044,1,5,0)
 ;;=5^Schizophreniform Disorderw/Exacerb.
 ;;^UTILITY(U,$J,358.3,7044,2)
 ;;=^268070
 ;;^UTILITY(U,$J,358.3,7045,0)
 ;;=295.02^^45^482^21
 ;;^UTILITY(U,$J,358.3,7045,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7045,1,2,0)
 ;;=2^295.02
 ;;^UTILITY(U,$J,358.3,7045,1,5,0)
 ;;=5^Simple Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,7045,2)
 ;;=Simple Schizophrenia, Chronic^268046
 ;;^UTILITY(U,$J,358.3,7046,0)
 ;;=295.04^^45^482^20
 ;;^UTILITY(U,$J,358.3,7046,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7046,1,2,0)
 ;;=2^295.04
 ;;^UTILITY(U,$J,358.3,7046,1,5,0)
 ;;=5^Simple Schizophrenia,  Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,7046,2)
 ;;=^268048
 ;;^UTILITY(U,$J,358.3,7047,0)
 ;;=295.92^^45^482^14
 ;;^UTILITY(U,$J,358.3,7047,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7047,1,2,0)
 ;;=2^295.92
 ;;^UTILITY(U,$J,358.3,7047,1,5,0)
 ;;=5^Schizophrenia, NOS, Chronic
 ;;^UTILITY(U,$J,358.3,7047,2)
 ;;=Schizophrenia, NOS, Chronic^268093
 ;;^UTILITY(U,$J,358.3,7048,0)
 ;;=295.94^^45^482^15
 ;;^UTILITY(U,$J,358.3,7048,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7048,1,2,0)
 ;;=2^295.94
 ;;^UTILITY(U,$J,358.3,7048,1,5,0)
 ;;=5^Schizophrenia, NOS, Chronic w/Exacerbation
 ;;^UTILITY(U,$J,358.3,7048,2)
 ;;=^268095
 ;;^UTILITY(U,$J,358.3,7049,0)
 ;;=295.00^^45^482^19
 ;;^UTILITY(U,$J,358.3,7049,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7049,1,2,0)
 ;;=2^295.00
 ;;^UTILITY(U,$J,358.3,7049,1,5,0)
 ;;=5^Simple Schizophrenia NOS
 ;;^UTILITY(U,$J,358.3,7049,2)
 ;;=^265175
 ;;^UTILITY(U,$J,358.3,7050,0)
 ;;=295.10^^45^482^1
 ;;^UTILITY(U,$J,358.3,7050,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7050,1,2,0)
 ;;=2^295.10
 ;;^UTILITY(U,$J,358.3,7050,1,5,0)
 ;;=5^Disorganized Schizophrenia NOS
 ;;^UTILITY(U,$J,358.3,7050,2)
 ;;=^108319
 ;;^UTILITY(U,$J,358.3,7051,0)
 ;;=295.30^^45^482^7
 ;;^UTILITY(U,$J,358.3,7051,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7051,1,2,0)
 ;;=2^295.30
 ;;^UTILITY(U,$J,358.3,7051,1,5,0)
 ;;=5^Paranoid Schizophrenia NOS
 ;;^UTILITY(U,$J,358.3,7051,2)
 ;;=^108330
 ;;^UTILITY(U,$J,358.3,7052,0)
 ;;=295.40^^45^482^16
 ;;^UTILITY(U,$J,358.3,7052,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7052,1,2,0)
 ;;=2^295.40
 ;;^UTILITY(U,$J,358.3,7052,1,5,0)
 ;;=5^Schizophreniform Disorder NOS
 ;;^UTILITY(U,$J,358.3,7052,2)
 ;;=^331845
 ;;^UTILITY(U,$J,358.3,7053,0)
 ;;=295.50^^45^482^4
 ;;^UTILITY(U,$J,358.3,7053,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7053,1,2,0)
 ;;=2^295.50
 ;;^UTILITY(U,$J,358.3,7053,1,5,0)
 ;;=5^Latent Schizophrenia NOS
 ;;^UTILITY(U,$J,358.3,7053,2)
 ;;=^68517
 ;;^UTILITY(U,$J,358.3,7054,0)
 ;;=295.60^^45^482^22
 ;;^UTILITY(U,$J,358.3,7054,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7054,1,2,0)
 ;;=2^295.60
 ;;^UTILITY(U,$J,358.3,7054,1,5,0)
 ;;=5^Undifferentiated Schizophrenia NOS
 ;;^UTILITY(U,$J,358.3,7054,2)
 ;;=^331851
 ;;^UTILITY(U,$J,358.3,7055,0)
 ;;=295.70^^45^482^10
 ;;^UTILITY(U,$J,358.3,7055,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7055,1,2,0)
 ;;=2^295.70
 ;;^UTILITY(U,$J,358.3,7055,1,5,0)
 ;;=5^Schizoaffective Disorder NOS
 ;;^UTILITY(U,$J,358.3,7055,2)
 ;;=^331857
 ;;^UTILITY(U,$J,358.3,7056,0)
 ;;=295.90^^45^482^13
 ;;^UTILITY(U,$J,358.3,7056,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7056,1,2,0)
 ;;=2^295.90
 ;;^UTILITY(U,$J,358.3,7056,1,5,0)
 ;;=5^Schizophrenia NOS,Unspec
 ;;^UTILITY(U,$J,358.3,7056,2)
 ;;=^108287
 ;;^UTILITY(U,$J,358.3,7057,0)
 ;;=300.11^^45^483^1
 ;;^UTILITY(U,$J,358.3,7057,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7057,1,2,0)
 ;;=2^300.11
