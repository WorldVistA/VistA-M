IBDEI0GW ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7604,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7604,1,2,0)
 ;;=2^99153
 ;;^UTILITY(U,$J,358.3,7604,1,3,0)
 ;;=3^Same Provider Performing Procedure,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,7605,0)
 ;;=99156^^37^381^3^^^^1
 ;;^UTILITY(U,$J,358.3,7605,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7605,1,2,0)
 ;;=2^99156
 ;;^UTILITY(U,$J,358.3,7605,1,3,0)
 ;;=3^Different Provider Performing Proc,Init 15 min
 ;;^UTILITY(U,$J,358.3,7606,0)
 ;;=99157^^37^381^4^^^^1
 ;;^UTILITY(U,$J,358.3,7606,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7606,1,2,0)
 ;;=2^99157
 ;;^UTILITY(U,$J,358.3,7606,1,3,0)
 ;;=3^Different Provider Performing Proc,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,7607,0)
 ;;=D9223^^37^381^6^^^^1
 ;;^UTILITY(U,$J,358.3,7607,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7607,1,2,0)
 ;;=2^D9223
 ;;^UTILITY(U,$J,358.3,7607,1,3,0)
 ;;=3^Deep Sedation/General Anes,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,7608,0)
 ;;=D9222^^37^381^5^^^^1
 ;;^UTILITY(U,$J,358.3,7608,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7608,1,2,0)
 ;;=2^D9222
 ;;^UTILITY(U,$J,358.3,7608,1,3,0)
 ;;=3^Deep Sedation/General Anes,1st 15 min
 ;;^UTILITY(U,$J,358.3,7609,0)
 ;;=45380^^37^382^1^^^^1
 ;;^UTILITY(U,$J,358.3,7609,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7609,1,2,0)
 ;;=2^45380
 ;;^UTILITY(U,$J,358.3,7609,1,3,0)
 ;;=3^Colonoscopy w/ Biopsy
 ;;^UTILITY(U,$J,358.3,7610,0)
 ;;=99152^^37^382^8^^^^1
 ;;^UTILITY(U,$J,358.3,7610,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7610,1,2,0)
 ;;=2^99152
 ;;^UTILITY(U,$J,358.3,7610,1,3,0)
 ;;=3^Same Provider Performing Procedure,1st 15 min
 ;;^UTILITY(U,$J,358.3,7611,0)
 ;;=99153^^37^382^9^^^^1
 ;;^UTILITY(U,$J,358.3,7611,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7611,1,2,0)
 ;;=2^99153
 ;;^UTILITY(U,$J,358.3,7611,1,3,0)
 ;;=3^Same Provider Performing Procedure,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,7612,0)
 ;;=J2250^^37^382^7^^^^1
 ;;^UTILITY(U,$J,358.3,7612,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7612,1,2,0)
 ;;=2^J2250
 ;;^UTILITY(U,$J,358.3,7612,1,3,0)
 ;;=3^Midazolam HCL,per 1mg
 ;;^UTILITY(U,$J,358.3,7612,3,0)
 ;;=^357.33^1^1
 ;;^UTILITY(U,$J,358.3,7612,3,1,0)
 ;;=JA
 ;;^UTILITY(U,$J,358.3,7613,0)
 ;;=J2175^^37^382^6^^^^1
 ;;^UTILITY(U,$J,358.3,7613,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7613,1,2,0)
 ;;=2^J2175
 ;;^UTILITY(U,$J,358.3,7613,1,3,0)
 ;;=3^Meperidine HCL,per 100mg
 ;;^UTILITY(U,$J,358.3,7613,3,0)
 ;;=^357.33^1^1
 ;;^UTILITY(U,$J,358.3,7613,3,1,0)
 ;;=JA
 ;;^UTILITY(U,$J,358.3,7614,0)
 ;;=43239^^37^382^4^^^^1
 ;;^UTILITY(U,$J,358.3,7614,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7614,1,2,0)
 ;;=2^43239
 ;;^UTILITY(U,$J,358.3,7614,1,3,0)
 ;;=3^EGD w/ Biopsy
 ;;^UTILITY(U,$J,358.3,7615,0)
 ;;=45378^^37^382^3^^^^1
 ;;^UTILITY(U,$J,358.3,7615,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7615,1,2,0)
 ;;=2^45378
 ;;^UTILITY(U,$J,358.3,7615,1,3,0)
 ;;=3^Colonoscopy,Diagnostic
 ;;^UTILITY(U,$J,358.3,7616,0)
 ;;=45385^^37^382^2^^^^1
 ;;^UTILITY(U,$J,358.3,7616,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7616,1,2,0)
 ;;=2^45385
 ;;^UTILITY(U,$J,358.3,7616,1,3,0)
 ;;=3^Colonoscopy w/ Snare
 ;;^UTILITY(U,$J,358.3,7617,0)
 ;;=J3010^^37^382^5^^^^1
 ;;^UTILITY(U,$J,358.3,7617,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7617,1,2,0)
 ;;=2^J3010
 ;;^UTILITY(U,$J,358.3,7617,1,3,0)
 ;;=3^Fentanyl Citrate,per 0.1mg
 ;;^UTILITY(U,$J,358.3,7618,0)
 ;;=99417^^37^383^1^^^^1
