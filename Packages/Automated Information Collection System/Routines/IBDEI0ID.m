IBDEI0ID ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8244,2)
 ;;=^5019224
 ;;^UTILITY(U,$J,358.3,8245,0)
 ;;=R10.816^^55^536^41
 ;;^UTILITY(U,$J,358.3,8245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8245,1,3,0)
 ;;=3^Epigastric abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8245,1,4,0)
 ;;=4^R10.816
 ;;^UTILITY(U,$J,358.3,8245,2)
 ;;=^5019218
 ;;^UTILITY(U,$J,358.3,8246,0)
 ;;=R10.826^^55^536^43
 ;;^UTILITY(U,$J,358.3,8246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8246,1,3,0)
 ;;=3^Epigastric rebound abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8246,1,4,0)
 ;;=4^R10.826
 ;;^UTILITY(U,$J,358.3,8246,2)
 ;;=^5019225
 ;;^UTILITY(U,$J,358.3,8247,0)
 ;;=R74.8^^55^536^2
 ;;^UTILITY(U,$J,358.3,8247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8247,1,3,0)
 ;;=3^Abnormal levels of other serum enzymes
 ;;^UTILITY(U,$J,358.3,8247,1,4,0)
 ;;=4^R74.8
 ;;^UTILITY(U,$J,358.3,8247,2)
 ;;=^5019566
 ;;^UTILITY(U,$J,358.3,8248,0)
 ;;=R79.89^^55^536^1
 ;;^UTILITY(U,$J,358.3,8248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8248,1,3,0)
 ;;=3^Abnormal Findings of Blood Chemistry NEC
 ;;^UTILITY(U,$J,358.3,8248,1,4,0)
 ;;=4^R79.89
 ;;^UTILITY(U,$J,358.3,8248,2)
 ;;=^5019593
 ;;^UTILITY(U,$J,358.3,8249,0)
 ;;=R19.5^^55^536^49
 ;;^UTILITY(U,$J,358.3,8249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8249,1,3,0)
 ;;=3^Fecal Abnormalites NEC
 ;;^UTILITY(U,$J,358.3,8249,1,4,0)
 ;;=4^R19.5
 ;;^UTILITY(U,$J,358.3,8249,2)
 ;;=^5019274
 ;;^UTILITY(U,$J,358.3,8250,0)
 ;;=Z87.11^^55^536^83
 ;;^UTILITY(U,$J,358.3,8250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8250,1,3,0)
 ;;=3^Personal history of peptic ulcer disease
 ;;^UTILITY(U,$J,358.3,8250,1,4,0)
 ;;=4^Z87.11
 ;;^UTILITY(U,$J,358.3,8250,2)
 ;;=^5063482
 ;;^UTILITY(U,$J,358.3,8251,0)
 ;;=Z86.010^^55^536^82
 ;;^UTILITY(U,$J,358.3,8251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8251,1,3,0)
 ;;=3^Personal history of colonic polyps
 ;;^UTILITY(U,$J,358.3,8251,1,4,0)
 ;;=4^Z86.010
 ;;^UTILITY(U,$J,358.3,8251,2)
 ;;=^5063456
 ;;^UTILITY(U,$J,358.3,8252,0)
 ;;=Z83.71^^55^536^46
 ;;^UTILITY(U,$J,358.3,8252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8252,1,3,0)
 ;;=3^Family history of colonic polyps
 ;;^UTILITY(U,$J,358.3,8252,1,4,0)
 ;;=4^Z83.71
 ;;^UTILITY(U,$J,358.3,8252,2)
 ;;=^5063386
 ;;^UTILITY(U,$J,358.3,8253,0)
 ;;=Z83.79^^55^536^47
 ;;^UTILITY(U,$J,358.3,8253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8253,1,3,0)
 ;;=3^Family history of other diseases of the digestive system
 ;;^UTILITY(U,$J,358.3,8253,1,4,0)
 ;;=4^Z83.79
 ;;^UTILITY(U,$J,358.3,8253,2)
 ;;=^5063387
 ;;^UTILITY(U,$J,358.3,8254,0)
 ;;=A54.00^^55^537^21
 ;;^UTILITY(U,$J,358.3,8254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8254,1,3,0)
 ;;=3^Gonococcal infection of lower genitourinary tract, unsp
 ;;^UTILITY(U,$J,358.3,8254,1,4,0)
 ;;=4^A54.00
 ;;^UTILITY(U,$J,358.3,8254,2)
 ;;=^5000311
 ;;^UTILITY(U,$J,358.3,8255,0)
 ;;=B37.42^^55^537^10
 ;;^UTILITY(U,$J,358.3,8255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8255,1,3,0)
 ;;=3^Candidal balanitis
 ;;^UTILITY(U,$J,358.3,8255,1,4,0)
 ;;=4^B37.42
 ;;^UTILITY(U,$J,358.3,8255,2)
 ;;=^5000617
 ;;^UTILITY(U,$J,358.3,8256,0)
 ;;=A59.03^^55^537^60
 ;;^UTILITY(U,$J,358.3,8256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8256,1,3,0)
 ;;=3^Trichomonal cystitis and urethritis
 ;;^UTILITY(U,$J,358.3,8256,1,4,0)
 ;;=4^A59.03
 ;;^UTILITY(U,$J,358.3,8256,2)
 ;;=^5000349
 ;;^UTILITY(U,$J,358.3,8257,0)
 ;;=C61.^^55^537^41
 ;;^UTILITY(U,$J,358.3,8257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8257,1,3,0)
 ;;=3^Malignant neoplasm of prostate
 ;;^UTILITY(U,$J,358.3,8257,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,8257,2)
 ;;=^267239
