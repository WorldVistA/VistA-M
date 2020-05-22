IBDEI0YU ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15542,0)
 ;;=99152^^86^860^1^^^^1
 ;;^UTILITY(U,$J,358.3,15542,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15542,1,2,0)
 ;;=2^99152
 ;;^UTILITY(U,$J,358.3,15542,1,3,0)
 ;;=3^Same Provider Performing Procedure,Init 15 min
 ;;^UTILITY(U,$J,358.3,15543,0)
 ;;=99153^^86^860^2^^^^1
 ;;^UTILITY(U,$J,358.3,15543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15543,1,2,0)
 ;;=2^99153
 ;;^UTILITY(U,$J,358.3,15543,1,3,0)
 ;;=3^Same Provider Performing Procedure,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,15544,0)
 ;;=99156^^86^860^3^^^^1
 ;;^UTILITY(U,$J,358.3,15544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15544,1,2,0)
 ;;=2^99156
 ;;^UTILITY(U,$J,358.3,15544,1,3,0)
 ;;=3^Different Provider Performing Proc,Init 15 min
 ;;^UTILITY(U,$J,358.3,15545,0)
 ;;=99157^^86^860^4^^^^1
 ;;^UTILITY(U,$J,358.3,15545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15545,1,2,0)
 ;;=2^99157
 ;;^UTILITY(U,$J,358.3,15545,1,3,0)
 ;;=3^Different Provider Performing Proc,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,15546,0)
 ;;=D9223^^86^860^6^^^^1
 ;;^UTILITY(U,$J,358.3,15546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15546,1,2,0)
 ;;=2^D9223
 ;;^UTILITY(U,$J,358.3,15546,1,3,0)
 ;;=3^Deep Sedation/General Anes,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,15547,0)
 ;;=D9222^^86^860^5^^^^1
 ;;^UTILITY(U,$J,358.3,15547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15547,1,2,0)
 ;;=2^D9222
 ;;^UTILITY(U,$J,358.3,15547,1,3,0)
 ;;=3^Deep Sedation/General Anes,1st 15 min
 ;;^UTILITY(U,$J,358.3,15548,0)
 ;;=45380^^86^861^1^^^^1
 ;;^UTILITY(U,$J,358.3,15548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15548,1,2,0)
 ;;=2^45380
 ;;^UTILITY(U,$J,358.3,15548,1,3,0)
 ;;=3^Colonoscopy w/ Biopsy
 ;;^UTILITY(U,$J,358.3,15549,0)
 ;;=99152^^86^861^7^^^^1
 ;;^UTILITY(U,$J,358.3,15549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15549,1,2,0)
 ;;=2^99152
 ;;^UTILITY(U,$J,358.3,15549,1,3,0)
 ;;=3^Same Provider Performing Procedure,1st 15 min
 ;;^UTILITY(U,$J,358.3,15550,0)
 ;;=99153^^86^861^8^^^^1
 ;;^UTILITY(U,$J,358.3,15550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15550,1,2,0)
 ;;=2^99153
 ;;^UTILITY(U,$J,358.3,15550,1,3,0)
 ;;=3^Same Provider Performing Procedure,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,15551,0)
 ;;=J2250^^86^861^6^^^^1
 ;;^UTILITY(U,$J,358.3,15551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15551,1,2,0)
 ;;=2^J2250
 ;;^UTILITY(U,$J,358.3,15551,1,3,0)
 ;;=3^Midazolam HCL,per 1mg
 ;;^UTILITY(U,$J,358.3,15551,3,0)
 ;;=^357.33^1^1
 ;;^UTILITY(U,$J,358.3,15551,3,1,0)
 ;;=JA
 ;;^UTILITY(U,$J,358.3,15552,0)
 ;;=J2175^^86^861^5^^^^1
 ;;^UTILITY(U,$J,358.3,15552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15552,1,2,0)
 ;;=2^J2175
 ;;^UTILITY(U,$J,358.3,15552,1,3,0)
 ;;=3^Meperidine HCL,per 100mg
 ;;^UTILITY(U,$J,358.3,15552,3,0)
 ;;=^357.33^1^1
 ;;^UTILITY(U,$J,358.3,15552,3,1,0)
 ;;=JA
 ;;^UTILITY(U,$J,358.3,15553,0)
 ;;=43239^^86^861^4^^^^1
 ;;^UTILITY(U,$J,358.3,15553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15553,1,2,0)
 ;;=2^43239
 ;;^UTILITY(U,$J,358.3,15553,1,3,0)
 ;;=3^EGD w/ Biopsy
 ;;^UTILITY(U,$J,358.3,15554,0)
 ;;=45378^^86^861^3^^^^1
 ;;^UTILITY(U,$J,358.3,15554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15554,1,2,0)
 ;;=2^45378
 ;;^UTILITY(U,$J,358.3,15554,1,3,0)
 ;;=3^Colonoscopy,Diagnostic
 ;;^UTILITY(U,$J,358.3,15555,0)
 ;;=45385^^86^861^2^^^^1
 ;;^UTILITY(U,$J,358.3,15555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15555,1,2,0)
 ;;=2^45385
