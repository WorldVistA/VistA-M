IBDEI03L ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3272,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,3272,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,3273,0)
 ;;=I62.00^^27^252^26
 ;;^UTILITY(U,$J,358.3,3273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3273,1,3,0)
 ;;=3^Nontraumatic Subdural Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,3273,1,4,0)
 ;;=4^I62.00
 ;;^UTILITY(U,$J,358.3,3273,2)
 ;;=^5007289
 ;;^UTILITY(U,$J,358.3,3274,0)
 ;;=C79.31^^27^252^12
 ;;^UTILITY(U,$J,358.3,3274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3274,1,3,0)
 ;;=3^Mets Malig Neop of Brain
 ;;^UTILITY(U,$J,358.3,3274,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,3274,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,3275,0)
 ;;=R40.0^^27^252^30
 ;;^UTILITY(U,$J,358.3,3275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3275,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,3275,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,3275,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,3276,0)
 ;;=R40.1^^27^252^31
 ;;^UTILITY(U,$J,358.3,3276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3276,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,3276,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,3276,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,3277,0)
 ;;=I61.0^^27^252^16
 ;;^UTILITY(U,$J,358.3,3277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3277,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage in Hemisphere,Subcortical
 ;;^UTILITY(U,$J,358.3,3277,1,4,0)
 ;;=4^I61.0
 ;;^UTILITY(U,$J,358.3,3277,2)
 ;;=^5007280
 ;;^UTILITY(U,$J,358.3,3278,0)
 ;;=I61.1^^27^252^17
 ;;^UTILITY(U,$J,358.3,3278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3278,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage in Hemisphere,Cortical
 ;;^UTILITY(U,$J,358.3,3278,1,4,0)
 ;;=4^I61.1
 ;;^UTILITY(U,$J,358.3,3278,2)
 ;;=^5007281
 ;;^UTILITY(U,$J,358.3,3279,0)
 ;;=I61.2^^27^252^18
 ;;^UTILITY(U,$J,358.3,3279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3279,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage in Hemisphere,Unspec
 ;;^UTILITY(U,$J,358.3,3279,1,4,0)
 ;;=4^I61.2
 ;;^UTILITY(U,$J,358.3,3279,2)
 ;;=^5007282
 ;;^UTILITY(U,$J,358.3,3280,0)
 ;;=I61.3^^27^252^19
 ;;^UTILITY(U,$J,358.3,3280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3280,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage in Brain Stem
 ;;^UTILITY(U,$J,358.3,3280,1,4,0)
 ;;=4^I61.3
 ;;^UTILITY(U,$J,358.3,3280,2)
 ;;=^5007283
 ;;^UTILITY(U,$J,358.3,3281,0)
 ;;=I61.4^^27^252^20
 ;;^UTILITY(U,$J,358.3,3281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3281,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage in Cerebellum
 ;;^UTILITY(U,$J,358.3,3281,1,4,0)
 ;;=4^I61.4
 ;;^UTILITY(U,$J,358.3,3281,2)
 ;;=^5007284
 ;;^UTILITY(U,$J,358.3,3282,0)
 ;;=I61.5^^27^252^21
 ;;^UTILITY(U,$J,358.3,3282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3282,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage,Intraventricular
 ;;^UTILITY(U,$J,358.3,3282,1,4,0)
 ;;=4^I61.5
 ;;^UTILITY(U,$J,358.3,3282,2)
 ;;=^5007285
 ;;^UTILITY(U,$J,358.3,3283,0)
 ;;=I61.6^^27^252^22
 ;;^UTILITY(U,$J,358.3,3283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3283,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage,Mult Localized
 ;;^UTILITY(U,$J,358.3,3283,1,4,0)
 ;;=4^I61.6
 ;;^UTILITY(U,$J,358.3,3283,2)
 ;;=^5007286
 ;;^UTILITY(U,$J,358.3,3284,0)
 ;;=I61.8^^27^252^23
 ;;^UTILITY(U,$J,358.3,3284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3284,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage,Other
 ;;^UTILITY(U,$J,358.3,3284,1,4,0)
 ;;=4^I61.8
 ;;^UTILITY(U,$J,358.3,3284,2)
 ;;=^5007287
 ;;^UTILITY(U,$J,358.3,3285,0)
 ;;=I61.9^^27^252^24
 ;;^UTILITY(U,$J,358.3,3285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3285,1,3,0)
 ;;=3^Nontraumatic Intracerebral Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,3285,1,4,0)
 ;;=4^I61.9
 ;;^UTILITY(U,$J,358.3,3285,2)
 ;;=^5007288
 ;;^UTILITY(U,$J,358.3,3286,0)
 ;;=I62.01^^27^252^13
 ;;^UTILITY(U,$J,358.3,3286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3286,1,3,0)
 ;;=3^Nontraumatic Acute Subdural Hemorrhage
 ;;^UTILITY(U,$J,358.3,3286,1,4,0)
 ;;=4^I62.01
 ;;^UTILITY(U,$J,358.3,3286,2)
 ;;=^5007290
 ;;^UTILITY(U,$J,358.3,3287,0)
 ;;=I62.02^^27^252^25
 ;;^UTILITY(U,$J,358.3,3287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3287,1,3,0)
 ;;=3^Nontraumatic Subacute Subdural Hemorrhage
 ;;^UTILITY(U,$J,358.3,3287,1,4,0)
 ;;=4^I62.02
 ;;^UTILITY(U,$J,358.3,3287,2)
 ;;=^5007291
 ;;^UTILITY(U,$J,358.3,3288,0)
 ;;=I62.03^^27^252^14
 ;;^UTILITY(U,$J,358.3,3288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3288,1,3,0)
 ;;=3^Nontraumatic Chronic Subdural Hemorrhage
 ;;^UTILITY(U,$J,358.3,3288,1,4,0)
 ;;=4^I62.03
 ;;^UTILITY(U,$J,358.3,3288,2)
 ;;=^5007292
 ;;^UTILITY(U,$J,358.3,3289,0)
 ;;=I62.1^^27^252^15
 ;;^UTILITY(U,$J,358.3,3289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3289,1,3,0)
 ;;=3^Nontraumatic Extradural Hemorrhage
 ;;^UTILITY(U,$J,358.3,3289,1,4,0)
 ;;=4^I62.1
 ;;^UTILITY(U,$J,358.3,3289,2)
 ;;=^269743
 ;;^UTILITY(U,$J,358.3,3290,0)
 ;;=A04.7^^27^253^14
 ;;^UTILITY(U,$J,358.3,3290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3290,1,3,0)
 ;;=3^Enterocolitis d/t Clostridium Difficile
 ;;^UTILITY(U,$J,358.3,3290,1,4,0)
 ;;=4^A04.7
 ;;^UTILITY(U,$J,358.3,3290,2)
 ;;=^5000029
 ;;^UTILITY(U,$J,358.3,3291,0)
 ;;=K92.2^^27^253^18
 ;;^UTILITY(U,$J,358.3,3291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3291,1,3,0)
 ;;=3^Gastrointestinal Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,3291,1,4,0)
 ;;=4^K92.2
 ;;^UTILITY(U,$J,358.3,3291,2)
 ;;=^5008915
 ;;^UTILITY(U,$J,358.3,3292,0)
 ;;=K57.31^^27^253^13
 ;;^UTILITY(U,$J,358.3,3292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3292,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/ Bleeding
 ;;^UTILITY(U,$J,358.3,3292,1,4,0)
 ;;=4^K57.31
 ;;^UTILITY(U,$J,358.3,3292,2)
 ;;=^5008724
 ;;^UTILITY(U,$J,358.3,3293,0)
 ;;=K92.1^^27^253^34
 ;;^UTILITY(U,$J,358.3,3293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3293,1,3,0)
 ;;=3^Melena
 ;;^UTILITY(U,$J,358.3,3293,1,4,0)
 ;;=4^K92.1
 ;;^UTILITY(U,$J,358.3,3293,2)
 ;;=^5008914
 ;;^UTILITY(U,$J,358.3,3294,0)
 ;;=K92.0^^27^253^19
 ;;^UTILITY(U,$J,358.3,3294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3294,1,3,0)
 ;;=3^Hematemesis
 ;;^UTILITY(U,$J,358.3,3294,1,4,0)
 ;;=4^K92.0
 ;;^UTILITY(U,$J,358.3,3294,2)
 ;;=^5008913
 ;;^UTILITY(U,$J,358.3,3295,0)
 ;;=K25.4^^27^253^16
 ;;^UTILITY(U,$J,358.3,3295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3295,1,3,0)
 ;;=3^Gastric Ulcer w/ Hemorrhage,Chronic
 ;;^UTILITY(U,$J,358.3,3295,1,4,0)
 ;;=4^K25.4
 ;;^UTILITY(U,$J,358.3,3295,2)
 ;;=^270076
 ;;^UTILITY(U,$J,358.3,3296,0)
 ;;=K43.2^^27^253^20
 ;;^UTILITY(U,$J,358.3,3296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3296,1,3,0)
 ;;=3^Incisional Hernia w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,3296,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,3296,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,3297,0)
 ;;=K57.32^^27^253^12
 ;;^UTILITY(U,$J,358.3,3297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3297,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,3297,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,3297,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,3298,0)
 ;;=K56.5^^27^253^21
 ;;^UTILITY(U,$J,358.3,3298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3298,1,3,0)
 ;;=3^Intestinal Adhesions w/ Obstruction
 ;;^UTILITY(U,$J,358.3,3298,1,4,0)
 ;;=4^K56.5
 ;;^UTILITY(U,$J,358.3,3298,2)
 ;;=^5008712
 ;;^UTILITY(U,$J,358.3,3299,0)
 ;;=E44.0^^27^253^35
 ;;^UTILITY(U,$J,358.3,3299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3299,1,3,0)
 ;;=3^Moderate Protein-Calorie Malnutrition
 ;;^UTILITY(U,$J,358.3,3299,1,4,0)
 ;;=4^E44.0
 ;;^UTILITY(U,$J,358.3,3299,2)
 ;;=^5002787
 ;;^UTILITY(U,$J,358.3,3300,0)
 ;;=K56.60^^27^253^22
 ;;^UTILITY(U,$J,358.3,3300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3300,1,3,0)
 ;;=3^Intestinal Obstruction,Unspec
