IBDEI00K ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,240,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,240,1,2,0)
 ;;=2^296.25
 ;;^UTILITY(U,$J,358.3,240,1,5,0)
 ;;=5^MDD, Single, Part Remission
 ;;^UTILITY(U,$J,358.3,240,2)
 ;;=^268114
 ;;^UTILITY(U,$J,358.3,241,0)
 ;;=296.30^^1^16^7
 ;;^UTILITY(U,$J,358.3,241,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,241,1,2,0)
 ;;=2^296.30
 ;;^UTILITY(U,$J,358.3,241,1,5,0)
 ;;=5^MDD, Recurrent, Unspe
 ;;^UTILITY(U,$J,358.3,241,2)
 ;;=MDD, Recurrent, Unspe^268116
 ;;^UTILITY(U,$J,358.3,242,0)
 ;;=296.31^^1^16^8
 ;;^UTILITY(U,$J,358.3,242,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,242,1,2,0)
 ;;=2^296.31
 ;;^UTILITY(U,$J,358.3,242,1,5,0)
 ;;=5^MDD, Recurrent, Mild
 ;;^UTILITY(U,$J,358.3,242,2)
 ;;=^268117
 ;;^UTILITY(U,$J,358.3,243,0)
 ;;=296.32^^1^16^9
 ;;^UTILITY(U,$J,358.3,243,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,243,1,2,0)
 ;;=2^296.32
 ;;^UTILITY(U,$J,358.3,243,1,5,0)
 ;;=5^MDD, Recur, Moderate
 ;;^UTILITY(U,$J,358.3,243,2)
 ;;=^268118
 ;;^UTILITY(U,$J,358.3,244,0)
 ;;=296.33^^1^16^10
 ;;^UTILITY(U,$J,358.3,244,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,244,1,2,0)
 ;;=2^296.33
 ;;^UTILITY(U,$J,358.3,244,1,5,0)
 ;;=5^MDD, Recurr, Severe W/o Psychosis
 ;;^UTILITY(U,$J,358.3,244,2)
 ;;=^268119
 ;;^UTILITY(U,$J,358.3,245,0)
 ;;=296.34^^1^16^11
 ;;^UTILITY(U,$J,358.3,245,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,245,1,2,0)
 ;;=2^296.34
 ;;^UTILITY(U,$J,358.3,245,1,5,0)
 ;;=5^MDD Recurrent, Severe w/Psychosis
 ;;^UTILITY(U,$J,358.3,245,2)
 ;;=^268120
 ;;^UTILITY(U,$J,358.3,246,0)
 ;;=296.35^^1^16^12
 ;;^UTILITY(U,$J,358.3,246,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,246,1,2,0)
 ;;=2^296.35
 ;;^UTILITY(U,$J,358.3,246,1,5,0)
 ;;=5^MDD, Recurrent, Part Remission
 ;;^UTILITY(U,$J,358.3,246,2)
 ;;=^268121
 ;;^UTILITY(U,$J,358.3,247,0)
 ;;=296.36^^1^16^13
 ;;^UTILITY(U,$J,358.3,247,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,247,1,2,0)
 ;;=2^296.36
 ;;^UTILITY(U,$J,358.3,247,1,5,0)
 ;;=5^MDD, Recurrent, Full Remiss
 ;;^UTILITY(U,$J,358.3,247,2)
 ;;=^268122
 ;;^UTILITY(U,$J,358.3,248,0)
 ;;=311.^^1^16^15
 ;;^UTILITY(U,$J,358.3,248,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,248,1,2,0)
 ;;=2^311.
 ;;^UTILITY(U,$J,358.3,248,1,5,0)
 ;;=5^Depression, NOS
 ;;^UTILITY(U,$J,358.3,248,2)
 ;;=^35603
 ;;^UTILITY(U,$J,358.3,249,0)
 ;;=301.13^^1^17^1
 ;;^UTILITY(U,$J,358.3,249,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,249,1,2,0)
 ;;=2^301.13
 ;;^UTILITY(U,$J,358.3,249,1,5,0)
 ;;=5^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,249,2)
 ;;=^30028
 ;;^UTILITY(U,$J,358.3,250,0)
 ;;=300.4^^1^17^2
 ;;^UTILITY(U,$J,358.3,250,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,250,1,2,0)
 ;;=2^300.4
 ;;^UTILITY(U,$J,358.3,250,1,5,0)
 ;;=5^Dysthymia
 ;;^UTILITY(U,$J,358.3,250,2)
 ;;=^303478
 ;;^UTILITY(U,$J,358.3,251,0)
 ;;=295.12^^1^18^1
 ;;^UTILITY(U,$J,358.3,251,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,251,1,2,0)
 ;;=2^295.12
 ;;^UTILITY(U,$J,358.3,251,1,5,0)
 ;;=5^Disorganized Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,251,2)
 ;;=^268051
 ;;^UTILITY(U,$J,358.3,252,0)
 ;;=295.14^^1^18^2
 ;;^UTILITY(U,$J,358.3,252,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,252,1,2,0)
 ;;=2^295.14
 ;;^UTILITY(U,$J,358.3,252,1,5,0)
 ;;=5^Disorganized Schizophrenia, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,252,2)
 ;;=^268053
 ;;^UTILITY(U,$J,358.3,253,0)
 ;;=295.52^^1^18^3
 ;;^UTILITY(U,$J,358.3,253,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,253,1,2,0)
 ;;=2^295.52
 ;;^UTILITY(U,$J,358.3,253,1,5,0)
 ;;=5^Latent Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,253,2)
 ;;=Latent Schizophrenia, Chronic^268073
 ;;^UTILITY(U,$J,358.3,254,0)
 ;;=295.54^^1^18^4
 ;;^UTILITY(U,$J,358.3,254,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,254,1,2,0)
 ;;=2^295.54
 ;;^UTILITY(U,$J,358.3,254,1,5,0)
 ;;=5^LatentSchizophrenia, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,254,2)
 ;;=^268075
 ;;^UTILITY(U,$J,358.3,255,0)
 ;;=295.32^^1^18^5
 ;;^UTILITY(U,$J,358.3,255,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,255,1,2,0)
 ;;=2^295.32
 ;;^UTILITY(U,$J,358.3,255,1,5,0)
 ;;=5^Paranoid Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,255,2)
 ;;=Paranoid Schizophrenia, Chronic^268061
 ;;^UTILITY(U,$J,358.3,256,0)
 ;;=295.34^^1^18^6
 ;;^UTILITY(U,$J,358.3,256,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,256,1,2,0)
 ;;=2^295.34
 ;;^UTILITY(U,$J,358.3,256,1,5,0)
 ;;=5^Paranoid Schizophrenia, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,256,2)
 ;;= Schizophrenia, ^268063
 ;;^UTILITY(U,$J,358.3,257,0)
 ;;=295.62^^1^18^14
 ;;^UTILITY(U,$J,358.3,257,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,257,1,2,0)
 ;;=2^295.62
 ;;^UTILITY(U,$J,358.3,257,1,5,0)
 ;;=5^Residual, Chronic
 ;;^UTILITY(U,$J,358.3,257,2)
 ;;=^268078
 ;;^UTILITY(U,$J,358.3,258,0)
 ;;=295.72^^1^18^8
 ;;^UTILITY(U,$J,358.3,258,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,258,1,2,0)
 ;;=2^295.72
 ;;^UTILITY(U,$J,358.3,258,1,5,0)
 ;;=5^Schizoaffective, Chr
 ;;^UTILITY(U,$J,358.3,258,2)
 ;;=^268083
 ;;^UTILITY(U,$J,358.3,259,0)
 ;;=295.74^^1^18^9
 ;;^UTILITY(U,$J,358.3,259,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,259,1,2,0)
 ;;=2^295.74
 ;;^UTILITY(U,$J,358.3,259,1,5,0)
 ;;=5^Schizoaffective, w/Exacerb.
 ;;^UTILITY(U,$J,358.3,259,2)
 ;;=^268085
 ;;^UTILITY(U,$J,358.3,260,0)
 ;;=295.42^^1^18^10
 ;;^UTILITY(U,$J,358.3,260,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,260,1,2,0)
 ;;=2^295.42
 ;;^UTILITY(U,$J,358.3,260,1,5,0)
 ;;=5^Schizopreniform, Chr
 ;;^UTILITY(U,$J,358.3,260,2)
 ;;=^268068
 ;;^UTILITY(U,$J,358.3,261,0)
 ;;=295.44^^1^18^11
 ;;^UTILITY(U,$J,358.3,261,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,261,1,2,0)
 ;;=2^295.44
 ;;^UTILITY(U,$J,358.3,261,1,5,0)
 ;;=5^Schizophreniform w/Exacerb.
 ;;^UTILITY(U,$J,358.3,261,2)
 ;;=^268070
 ;;^UTILITY(U,$J,358.3,262,0)
 ;;=295.02^^1^18^12
 ;;^UTILITY(U,$J,358.3,262,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,262,1,2,0)
 ;;=2^295.02
 ;;^UTILITY(U,$J,358.3,262,1,5,0)
 ;;=5^Simple, Chronic
 ;;^UTILITY(U,$J,358.3,262,2)
 ;;=^268046
 ;;^UTILITY(U,$J,358.3,263,0)
 ;;=295.04^^1^18^13
 ;;^UTILITY(U,$J,358.3,263,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,263,1,2,0)
 ;;=2^295.04
 ;;^UTILITY(U,$J,358.3,263,1,5,0)
 ;;=5^Simple, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,263,2)
 ;;=^268048
 ;;^UTILITY(U,$J,358.3,264,0)
 ;;=295.92^^1^18^15
 ;;^UTILITY(U,$J,358.3,264,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,264,1,2,0)
 ;;=2^295.92
 ;;^UTILITY(U,$J,358.3,264,1,5,0)
 ;;=5^NOS, Chronic
 ;;^UTILITY(U,$J,358.3,264,2)
 ;;=^268093
 ;;^UTILITY(U,$J,358.3,265,0)
 ;;=295.94^^1^18^16
 ;;^UTILITY(U,$J,358.3,265,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,265,1,2,0)
 ;;=2^295.94
 ;;^UTILITY(U,$J,358.3,265,1,5,0)
 ;;=5^NOS, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,265,2)
 ;;=^268095
 ;;^UTILITY(U,$J,358.3,266,0)
 ;;=300.11^^1^19^1
 ;;^UTILITY(U,$J,358.3,266,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,266,1,2,0)
 ;;=2^300.11
 ;;^UTILITY(U,$J,358.3,266,1,5,0)
 ;;=5^Conversion Disorder
 ;;^UTILITY(U,$J,358.3,266,2)
 ;;=^28139
 ;;^UTILITY(U,$J,358.3,267,0)
 ;;=300.7^^1^19^2
 ;;^UTILITY(U,$J,358.3,267,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,267,1,2,0)
 ;;=2^300.7
 ;;^UTILITY(U,$J,358.3,267,1,5,0)
 ;;=5^Hyponchondriasis
 ;;^UTILITY(U,$J,358.3,267,2)
 ;;=^60556
 ;;^UTILITY(U,$J,358.3,268,0)
 ;;=300.81^^1^19^3
 ;;^UTILITY(U,$J,358.3,268,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,268,1,2,0)
 ;;=2^300.81
 ;;^UTILITY(U,$J,358.3,268,1,5,0)
 ;;=5^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,268,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,269,0)
 ;;=307.1^^1^20^1
 ;;^UTILITY(U,$J,358.3,269,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,269,1,2,0)
 ;;=2^307.1
 ;;^UTILITY(U,$J,358.3,269,1,5,0)
 ;;=5^Anorexia Nervosa
 ;;^UTILITY(U,$J,358.3,269,2)
 ;;=^7942
 ;;^UTILITY(U,$J,358.3,270,0)
 ;;=307.51^^1^20^2
 ;;^UTILITY(U,$J,358.3,270,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,270,1,2,0)
 ;;=2^307.51
 ;;^UTILITY(U,$J,358.3,270,1,5,0)
 ;;=5^Bulemia
 ;;^UTILITY(U,$J,358.3,270,2)
 ;;=^17407
 ;;^UTILITY(U,$J,358.3,271,0)
 ;;=307.50^^1^20^3
 ;;^UTILITY(U,$J,358.3,271,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,271,1,2,0)
 ;;=2^307.50
 ;;^UTILITY(U,$J,358.3,271,1,5,0)
 ;;=5^Eating Disorder, NOS
 ;;^UTILITY(U,$J,358.3,271,2)
 ;;=^37864
 ;;^UTILITY(U,$J,358.3,272,0)
 ;;=H0001^^2^21^1^^^^1
 ;;^UTILITY(U,$J,358.3,272,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,272,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,272,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,273,0)
 ;;=H0002^^2^21^2^^^^1
 ;;^UTILITY(U,$J,358.3,273,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,273,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,273,1,3,0)
 ;;=3^Screen for Addictions Admit
 ;;^UTILITY(U,$J,358.3,274,0)
 ;;=H0004^^2^21^3
 ;;^UTILITY(U,$J,358.3,274,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,274,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,274,1,3,0)
 ;;=3^Individual Counseling per 15 min
 ;;^UTILITY(U,$J,358.3,275,0)
 ;;=H0005^^2^21^4^^^^1
 ;;^UTILITY(U,$J,358.3,275,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,275,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,275,1,3,0)
 ;;=3^Addictions Group
 ;;^UTILITY(U,$J,358.3,276,0)
 ;;=H0020^^2^21^6^^^^1
 ;;^UTILITY(U,$J,358.3,276,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,276,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,276,1,3,0)
 ;;=3^Methadone Administration
 ;;^UTILITY(U,$J,358.3,277,0)
 ;;=H0030^^2^21^7^^^^1
 ;;^UTILITY(U,$J,358.3,277,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,277,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,277,1,3,0)
 ;;=3^Addictions Phone Services
 ;;^UTILITY(U,$J,358.3,278,0)
 ;;=H0025^^2^21^8^^^^1
 ;;^UTILITY(U,$J,358.3,278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,278,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,278,1,3,0)
 ;;=3^Addictions Education Service
 ;;^UTILITY(U,$J,358.3,279,0)
 ;;=H0046^^2^21^9^^^^1
 ;;^UTILITY(U,$J,358.3,279,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,279,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,279,1,3,0)
 ;;=3^PTSD Group
