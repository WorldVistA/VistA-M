IBDEI01A ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42,0)
 ;;=H93.12^^1^2^35
 ;;^UTILITY(U,$J,358.3,42,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42,1,3,0)
 ;;=3^Tinnitus, left ear
 ;;^UTILITY(U,$J,358.3,42,1,4,0)
 ;;=4^H93.12
 ;;^UTILITY(U,$J,358.3,42,2)
 ;;=^5006965
 ;;^UTILITY(U,$J,358.3,43,0)
 ;;=H93.11^^1^2^36
 ;;^UTILITY(U,$J,358.3,43,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43,1,3,0)
 ;;=3^Tinnitus, right ear
 ;;^UTILITY(U,$J,358.3,43,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,43,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,44,0)
 ;;=H93.92^^1^2^21
 ;;^UTILITY(U,$J,358.3,44,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44,1,3,0)
 ;;=3^Left Ear Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,44,1,4,0)
 ;;=4^H93.92
 ;;^UTILITY(U,$J,358.3,44,2)
 ;;=^5006997
 ;;^UTILITY(U,$J,358.3,45,0)
 ;;=H93.91^^1^2^30
 ;;^UTILITY(U,$J,358.3,45,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45,1,3,0)
 ;;=3^Right Ear Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,45,1,4,0)
 ;;=4^H93.91
 ;;^UTILITY(U,$J,358.3,45,2)
 ;;=^5006996
 ;;^UTILITY(U,$J,358.3,46,0)
 ;;=H81.313^^1^3^1
 ;;^UTILITY(U,$J,358.3,46,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46,1,3,0)
 ;;=3^Aural vertigo, bilateral
 ;;^UTILITY(U,$J,358.3,46,1,4,0)
 ;;=4^H81.313
 ;;^UTILITY(U,$J,358.3,46,2)
 ;;=^5006874
 ;;^UTILITY(U,$J,358.3,47,0)
 ;;=H81.312^^1^3^2
 ;;^UTILITY(U,$J,358.3,47,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47,1,3,0)
 ;;=3^Aural vertigo, left ear
 ;;^UTILITY(U,$J,358.3,47,1,4,0)
 ;;=4^H81.312
 ;;^UTILITY(U,$J,358.3,47,2)
 ;;=^5006873
 ;;^UTILITY(U,$J,358.3,48,0)
 ;;=H81.311^^1^3^3
 ;;^UTILITY(U,$J,358.3,48,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48,1,3,0)
 ;;=3^Aural vertigo, right ear
 ;;^UTILITY(U,$J,358.3,48,1,4,0)
 ;;=4^H81.311
 ;;^UTILITY(U,$J,358.3,48,2)
 ;;=^5006872
 ;;^UTILITY(U,$J,358.3,49,0)
 ;;=H81.13^^1^3^4
 ;;^UTILITY(U,$J,358.3,49,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49,1,3,0)
 ;;=3^Benign paroxysmal vertigo, bilateral
 ;;^UTILITY(U,$J,358.3,49,1,4,0)
 ;;=4^H81.13
 ;;^UTILITY(U,$J,358.3,49,2)
 ;;=^5006867
 ;;^UTILITY(U,$J,358.3,50,0)
 ;;=H81.12^^1^3^5
 ;;^UTILITY(U,$J,358.3,50,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50,1,3,0)
 ;;=3^Benign paroxysmal vertigo, left ear
 ;;^UTILITY(U,$J,358.3,50,1,4,0)
 ;;=4^H81.12
 ;;^UTILITY(U,$J,358.3,50,2)
 ;;=^5006866
 ;;^UTILITY(U,$J,358.3,51,0)
 ;;=H81.11^^1^3^6
 ;;^UTILITY(U,$J,358.3,51,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51,1,3,0)
 ;;=3^Benign paroxysmal vertigo, right ear
 ;;^UTILITY(U,$J,358.3,51,1,4,0)
 ;;=4^H81.11
 ;;^UTILITY(U,$J,358.3,51,2)
 ;;=^5006865
 ;;^UTILITY(U,$J,358.3,52,0)
 ;;=R42.^^1^3^11
 ;;^UTILITY(U,$J,358.3,52,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,52,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,52,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,53,0)
 ;;=H81.03^^1^3^12
 ;;^UTILITY(U,$J,358.3,53,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53,1,3,0)
 ;;=3^Meniere's disease, bilateral
 ;;^UTILITY(U,$J,358.3,53,1,4,0)
 ;;=4^H81.03
 ;;^UTILITY(U,$J,358.3,53,2)
 ;;=^5006862
 ;;^UTILITY(U,$J,358.3,54,0)
 ;;=H81.02^^1^3^13
 ;;^UTILITY(U,$J,358.3,54,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54,1,3,0)
 ;;=3^Meniere's disease, left ear
 ;;^UTILITY(U,$J,358.3,54,1,4,0)
 ;;=4^H81.02
 ;;^UTILITY(U,$J,358.3,54,2)
 ;;=^5006861
 ;;^UTILITY(U,$J,358.3,55,0)
 ;;=H81.01^^1^3^14
 ;;^UTILITY(U,$J,358.3,55,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55,1,3,0)
 ;;=3^Meniere's disease, right ear
 ;;^UTILITY(U,$J,358.3,55,1,4,0)
 ;;=4^H81.01
 ;;^UTILITY(U,$J,358.3,55,2)
 ;;=^5006860
 ;;^UTILITY(U,$J,358.3,56,0)
 ;;=H81.393^^1^3^15
 ;;^UTILITY(U,$J,358.3,56,1,0)
 ;;=^358.31IA^4^2
