IBDEI019 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34,1,3,0)
 ;;=3^Unlisted Psych Service (Anyone)
 ;;^UTILITY(U,$J,358.3,35,0)
 ;;=96103^^1^4^6^^^^1
 ;;^UTILITY(U,$J,358.3,35,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35,1,2,0)
 ;;=2^96103
 ;;^UTILITY(U,$J,358.3,35,1,3,0)
 ;;=3^Psych Tst Admin by Comp
 ;;^UTILITY(U,$J,358.3,36,0)
 ;;=96101^^1^4^7^^^^1
 ;;^UTILITY(U,$J,358.3,36,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36,1,2,0)
 ;;=2^96101
 ;;^UTILITY(U,$J,358.3,36,1,3,0)
 ;;=3^Psych Tst by Psych/Phys
 ;;^UTILITY(U,$J,358.3,37,0)
 ;;=96102^^1^4^8^^^^1
 ;;^UTILITY(U,$J,358.3,37,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37,1,2,0)
 ;;=2^96102
 ;;^UTILITY(U,$J,358.3,37,1,3,0)
 ;;=3^Psych Tst,Tech,Ea Hr
 ;;^UTILITY(U,$J,358.3,38,0)
 ;;=96127^^1^4^1^^^^1
 ;;^UTILITY(U,$J,358.3,38,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38,1,2,0)
 ;;=2^96127
 ;;^UTILITY(U,$J,358.3,38,1,3,0)
 ;;=3^Brf Emotional/Behav Assess w/ Score/Document 
 ;;^UTILITY(U,$J,358.3,39,0)
 ;;=99406^^1^5^1^^^^1
 ;;^UTILITY(U,$J,358.3,39,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39,1,2,0)
 ;;=2^99406
 ;;^UTILITY(U,$J,358.3,39,1,3,0)
 ;;=3^Smoking/Tob Cessation Counsel 3-10Min
 ;;^UTILITY(U,$J,358.3,40,0)
 ;;=99407^^1^5^2^^^^1
 ;;^UTILITY(U,$J,358.3,40,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,40,1,2,0)
 ;;=2^99407
 ;;^UTILITY(U,$J,358.3,40,1,3,0)
 ;;=3^Smoking/Tob Cessation Counsel>10Min
 ;;^UTILITY(U,$J,358.3,41,0)
 ;;=J2680^^1^6^1^^^^1
 ;;^UTILITY(U,$J,358.3,41,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41,1,2,0)
 ;;=2^J2680
 ;;^UTILITY(U,$J,358.3,41,1,3,0)
 ;;=3^Fluphenazine Decanoate up to 25mg
 ;;^UTILITY(U,$J,358.3,42,0)
 ;;=J2426^^1^6^3^^^^1
 ;;^UTILITY(U,$J,358.3,42,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,42,1,2,0)
 ;;=2^J2426
 ;;^UTILITY(U,$J,358.3,42,1,3,0)
 ;;=3^Paliperidone Palmitate 1mg
 ;;^UTILITY(U,$J,358.3,43,0)
 ;;=J1631^^1^6^2^^^^1
 ;;^UTILITY(U,$J,358.3,43,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43,1,2,0)
 ;;=2^J1631
 ;;^UTILITY(U,$J,358.3,43,1,3,0)
 ;;=3^Haliperidol Decanoate per 50mg
 ;;^UTILITY(U,$J,358.3,44,0)
 ;;=J2794^^1^6^4^^^^1
 ;;^UTILITY(U,$J,358.3,44,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,44,1,2,0)
 ;;=2^J2794
 ;;^UTILITY(U,$J,358.3,44,1,3,0)
 ;;=3^Risperidone Long Acting 0.5mg
 ;;^UTILITY(U,$J,358.3,45,0)
 ;;=99212^^2^7^2
 ;;^UTILITY(U,$J,358.3,45,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,45,1,1,0)
 ;;=1^PROBLEM FOCUSED
 ;;^UTILITY(U,$J,358.3,45,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,46,0)
 ;;=99213^^2^7^3
 ;;^UTILITY(U,$J,358.3,46,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,46,1,1,0)
 ;;=1^EXPANDED PROBLEM FOCUSED
 ;;^UTILITY(U,$J,358.3,46,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,47,0)
 ;;=99214^^2^7^4
 ;;^UTILITY(U,$J,358.3,47,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,47,1,1,0)
 ;;=1^DETAILED
 ;;^UTILITY(U,$J,358.3,47,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,48,0)
 ;;=99215^^2^7^5
 ;;^UTILITY(U,$J,358.3,48,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,48,1,1,0)
 ;;=1^COMPREHENSIVE
 ;;^UTILITY(U,$J,358.3,48,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,49,0)
 ;;=99211^^2^7^1
 ;;^UTILITY(U,$J,358.3,49,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,49,1,1,0)
 ;;=1^E/M Not Requiring MD
 ;;^UTILITY(U,$J,358.3,49,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,50,0)
 ;;=99241^^2^8^1
 ;;^UTILITY(U,$J,358.3,50,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,50,1,1,0)
 ;;=1^PROBLEM FOCUSED
 ;;^UTILITY(U,$J,358.3,50,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,51,0)
 ;;=99242^^2^8^2
 ;;^UTILITY(U,$J,358.3,51,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,51,1,1,0)
 ;;=1^EXPANDED PROBLEM FOCUSED
 ;;^UTILITY(U,$J,358.3,51,1,2,0)
 ;;=2^99242
