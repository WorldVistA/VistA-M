IBDEI06Q ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2627,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,2627,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,2628,0)
 ;;=R13.11^^6^81^11
 ;;^UTILITY(U,$J,358.3,2628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2628,1,3,0)
 ;;=3^Dysphagia, oral phase
 ;;^UTILITY(U,$J,358.3,2628,1,4,0)
 ;;=4^R13.11
 ;;^UTILITY(U,$J,358.3,2628,2)
 ;;=^335276
 ;;^UTILITY(U,$J,358.3,2629,0)
 ;;=R13.12^^6^81^12
 ;;^UTILITY(U,$J,358.3,2629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2629,1,3,0)
 ;;=3^Dysphagia, oropharyngeal phase
 ;;^UTILITY(U,$J,358.3,2629,1,4,0)
 ;;=4^R13.12
 ;;^UTILITY(U,$J,358.3,2629,2)
 ;;=^335277
 ;;^UTILITY(U,$J,358.3,2630,0)
 ;;=R13.13^^6^81^13
 ;;^UTILITY(U,$J,358.3,2630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2630,1,3,0)
 ;;=3^Dysphagia, pharyngeal phase
 ;;^UTILITY(U,$J,358.3,2630,1,4,0)
 ;;=4^R13.13
 ;;^UTILITY(U,$J,358.3,2630,2)
 ;;=^335278
 ;;^UTILITY(U,$J,358.3,2631,0)
 ;;=R13.14^^6^81^14
 ;;^UTILITY(U,$J,358.3,2631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2631,1,3,0)
 ;;=3^Dysphagia, pharyngoesophageal phase
 ;;^UTILITY(U,$J,358.3,2631,1,4,0)
 ;;=4^R13.14
 ;;^UTILITY(U,$J,358.3,2631,2)
 ;;=^335279
 ;;^UTILITY(U,$J,358.3,2632,0)
 ;;=R13.19^^6^81^10
 ;;^UTILITY(U,$J,358.3,2632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2632,1,3,0)
 ;;=3^Dysphagia NEC
 ;;^UTILITY(U,$J,358.3,2632,1,4,0)
 ;;=4^R13.19
 ;;^UTILITY(U,$J,358.3,2632,2)
 ;;=^335280
 ;;^UTILITY(U,$J,358.3,2633,0)
 ;;=R14.3^^6^81^19
 ;;^UTILITY(U,$J,358.3,2633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2633,1,3,0)
 ;;=3^Flatulence
 ;;^UTILITY(U,$J,358.3,2633,1,4,0)
 ;;=4^R14.3
 ;;^UTILITY(U,$J,358.3,2633,2)
 ;;=^5019243
 ;;^UTILITY(U,$J,358.3,2634,0)
 ;;=R14.2^^6^81^17
 ;;^UTILITY(U,$J,358.3,2634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2634,1,3,0)
 ;;=3^Eructation
 ;;^UTILITY(U,$J,358.3,2634,1,4,0)
 ;;=4^R14.2
 ;;^UTILITY(U,$J,358.3,2634,2)
 ;;=^5019242
 ;;^UTILITY(U,$J,358.3,2635,0)
 ;;=R14.1^^6^81^21
 ;;^UTILITY(U,$J,358.3,2635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2635,1,3,0)
 ;;=3^Gas pain
 ;;^UTILITY(U,$J,358.3,2635,1,4,0)
 ;;=4^R14.1
 ;;^UTILITY(U,$J,358.3,2635,2)
 ;;=^5019241
 ;;^UTILITY(U,$J,358.3,2636,0)
 ;;=R14.0^^6^81^1
 ;;^UTILITY(U,$J,358.3,2636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2636,1,3,0)
 ;;=3^Abdominal distension (gaseous)
 ;;^UTILITY(U,$J,358.3,2636,1,4,0)
 ;;=4^R14.0
 ;;^UTILITY(U,$J,358.3,2636,2)
 ;;=^5019240
 ;;^UTILITY(U,$J,358.3,2637,0)
 ;;=R19.7^^6^81^9
 ;;^UTILITY(U,$J,358.3,2637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2637,1,3,0)
 ;;=3^Diarrhea, unspecified
 ;;^UTILITY(U,$J,358.3,2637,1,4,0)
 ;;=4^R19.7
 ;;^UTILITY(U,$J,358.3,2637,2)
 ;;=^5019276
 ;;^UTILITY(U,$J,358.3,2638,0)
 ;;=R15.9^^6^81^20
 ;;^UTILITY(U,$J,358.3,2638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2638,1,3,0)
 ;;=3^Full incontinence of feces
 ;;^UTILITY(U,$J,358.3,2638,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,2638,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,2639,0)
 ;;=K52.2^^6^81^3
 ;;^UTILITY(U,$J,358.3,2639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2639,1,3,0)
 ;;=3^Allergic and dietetic gastroenteritis and colitis
 ;;^UTILITY(U,$J,358.3,2639,1,4,0)
 ;;=4^K52.2
 ;;^UTILITY(U,$J,358.3,2639,2)
 ;;=^5008701
 ;;^UTILITY(U,$J,358.3,2640,0)
 ;;=K52.89^^6^81^33
 ;;^UTILITY(U,$J,358.3,2640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2640,1,3,0)
 ;;=3^Noninfective Gastroenteritis/Colitis
 ;;^UTILITY(U,$J,358.3,2640,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,2640,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,2641,0)
 ;;=R19.4^^6^81^7
 ;;^UTILITY(U,$J,358.3,2641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2641,1,3,0)
 ;;=3^Change in bowel habit
