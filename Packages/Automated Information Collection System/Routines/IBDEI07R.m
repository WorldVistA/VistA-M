IBDEI07R ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3060,1,4,0)
 ;;=4^N63.
 ;;^UTILITY(U,$J,358.3,3060,2)
 ;;=^5015791
 ;;^UTILITY(U,$J,358.3,3061,0)
 ;;=L13.9^^28^247^17
 ;;^UTILITY(U,$J,358.3,3061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3061,1,3,0)
 ;;=3^Bullous Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3061,1,4,0)
 ;;=4^L13.9
 ;;^UTILITY(U,$J,358.3,3061,2)
 ;;=^5009105
 ;;^UTILITY(U,$J,358.3,3062,0)
 ;;=L02.93^^28^247^18
 ;;^UTILITY(U,$J,358.3,3062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3062,1,3,0)
 ;;=3^Carbuncle,Unspec
 ;;^UTILITY(U,$J,358.3,3062,1,4,0)
 ;;=4^L02.93
 ;;^UTILITY(U,$J,358.3,3062,2)
 ;;=^5009018
 ;;^UTILITY(U,$J,358.3,3063,0)
 ;;=L03.90^^28^247^19
 ;;^UTILITY(U,$J,358.3,3063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3063,1,3,0)
 ;;=3^Cellulitis,Unspec
 ;;^UTILITY(U,$J,358.3,3063,1,4,0)
 ;;=4^L03.90
 ;;^UTILITY(U,$J,358.3,3063,2)
 ;;=^5009067
 ;;^UTILITY(U,$J,358.3,3064,0)
 ;;=L94.9^^28^247^20
 ;;^UTILITY(U,$J,358.3,3064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3064,1,3,0)
 ;;=3^Connective Tissue Disorder,Localized,Unspec
 ;;^UTILITY(U,$J,358.3,3064,1,4,0)
 ;;=4^L94.9
 ;;^UTILITY(U,$J,358.3,3064,2)
 ;;=^5009475
 ;;^UTILITY(U,$J,358.3,3065,0)
 ;;=L84.^^28^247^21
 ;;^UTILITY(U,$J,358.3,3065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3065,1,3,0)
 ;;=3^Corns & Callosities
 ;;^UTILITY(U,$J,358.3,3065,1,4,0)
 ;;=4^L84.
 ;;^UTILITY(U,$J,358.3,3065,2)
 ;;=^271920
 ;;^UTILITY(U,$J,358.3,3066,0)
 ;;=L27.0^^28^247^23
 ;;^UTILITY(U,$J,358.3,3066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3066,1,3,0)
 ;;=3^Dermatitis d/t Drugs/Meds Taken Internally,General
 ;;^UTILITY(U,$J,358.3,3066,1,4,0)
 ;;=4^L27.0
 ;;^UTILITY(U,$J,358.3,3066,2)
 ;;=^5009144
 ;;^UTILITY(U,$J,358.3,3067,0)
 ;;=L27.1^^28^247^24
 ;;^UTILITY(U,$J,358.3,3067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3067,1,3,0)
 ;;=3^Dermatitis d/t Drugs/Meds Taken Internally,Local
 ;;^UTILITY(U,$J,358.3,3067,1,4,0)
 ;;=4^L27.1
 ;;^UTILITY(U,$J,358.3,3067,2)
 ;;=^5009145
 ;;^UTILITY(U,$J,358.3,3068,0)
 ;;=L27.2^^28^247^25
 ;;^UTILITY(U,$J,358.3,3068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3068,1,3,0)
 ;;=3^Dermatitis d/t Ingested Food
 ;;^UTILITY(U,$J,358.3,3068,1,4,0)
 ;;=4^L27.2
 ;;^UTILITY(U,$J,358.3,3068,2)
 ;;=^5009146
 ;;^UTILITY(U,$J,358.3,3069,0)
 ;;=L58.0^^28^247^26
 ;;^UTILITY(U,$J,358.3,3069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3069,1,3,0)
 ;;=3^Dermatitis d/t Radiation,Acute
 ;;^UTILITY(U,$J,358.3,3069,1,4,0)
 ;;=4^L58.0
 ;;^UTILITY(U,$J,358.3,3069,2)
 ;;=^5009228
 ;;^UTILITY(U,$J,358.3,3070,0)
 ;;=L58.1^^28^247^27
 ;;^UTILITY(U,$J,358.3,3070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3070,1,3,0)
 ;;=3^Dermatitis d/t Radiation,Chronic
 ;;^UTILITY(U,$J,358.3,3070,1,4,0)
 ;;=4^L58.1
 ;;^UTILITY(U,$J,358.3,3070,2)
 ;;=^5009229
 ;;^UTILITY(U,$J,358.3,3071,0)
 ;;=L58.9^^28^247^22
 ;;^UTILITY(U,$J,358.3,3071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3071,1,3,0)
 ;;=3^Dermatitis d/t  Radiation,Unspec
 ;;^UTILITY(U,$J,358.3,3071,1,4,0)
 ;;=4^L58.9
 ;;^UTILITY(U,$J,358.3,3071,2)
 ;;=^5009230
 ;;^UTILITY(U,$J,358.3,3072,0)
 ;;=L27.9^^28^247^28
 ;;^UTILITY(U,$J,358.3,3072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3072,1,3,0)
 ;;=3^Dermatitis d/t Unspec Subs Taken Internally
 ;;^UTILITY(U,$J,358.3,3072,1,4,0)
 ;;=4^L27.9
 ;;^UTILITY(U,$J,358.3,3072,2)
 ;;=^271914
 ;;^UTILITY(U,$J,358.3,3073,0)
 ;;=L20.9^^28^247^30
 ;;^UTILITY(U,$J,358.3,3073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3073,1,3,0)
 ;;=3^Dermatitis,Atopic,Unspec
 ;;^UTILITY(U,$J,358.3,3073,1,4,0)
 ;;=4^L20.9
 ;;^UTILITY(U,$J,358.3,3073,2)
 ;;=^5009113
 ;;^UTILITY(U,$J,358.3,3074,0)
 ;;=L23.9^^28^247^29
