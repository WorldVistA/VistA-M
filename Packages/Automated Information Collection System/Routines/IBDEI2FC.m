IBDEI2FC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41121,1,4,0)
 ;;=4^N48.1
 ;;^UTILITY(U,$J,358.3,41121,2)
 ;;=^12525
 ;;^UTILITY(U,$J,358.3,41122,0)
 ;;=N52.34^^159^2000^38
 ;;^UTILITY(U,$J,358.3,41122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41122,1,3,0)
 ;;=3^Erectile Dysfunction Following Simple Prostatectomy
 ;;^UTILITY(U,$J,358.3,41122,1,4,0)
 ;;=4^N52.34
 ;;^UTILITY(U,$J,358.3,41122,2)
 ;;=^5015760
 ;;^UTILITY(U,$J,358.3,41123,0)
 ;;=N52.39^^159^2000^40
 ;;^UTILITY(U,$J,358.3,41123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41123,1,3,0)
 ;;=3^Erectile Dysfunction Post-Surgical
 ;;^UTILITY(U,$J,358.3,41123,1,4,0)
 ;;=4^N52.39
 ;;^UTILITY(U,$J,358.3,41123,2)
 ;;=^5015761
 ;;^UTILITY(U,$J,358.3,41124,0)
 ;;=N52.33^^159^2000^39
 ;;^UTILITY(U,$J,358.3,41124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41124,1,3,0)
 ;;=3^Erectile Dysfunction Following Urethral Surgery
 ;;^UTILITY(U,$J,358.3,41124,1,4,0)
 ;;=4^N52.33
 ;;^UTILITY(U,$J,358.3,41124,2)
 ;;=^5015759
 ;;^UTILITY(U,$J,358.3,41125,0)
 ;;=N52.32^^159^2000^36
 ;;^UTILITY(U,$J,358.3,41125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41125,1,3,0)
 ;;=3^Erectile Dysfunction Following Radical Cystectomy
 ;;^UTILITY(U,$J,358.3,41125,1,4,0)
 ;;=4^N52.32
 ;;^UTILITY(U,$J,358.3,41125,2)
 ;;=^5015758
 ;;^UTILITY(U,$J,358.3,41126,0)
 ;;=N52.31^^159^2000^37
 ;;^UTILITY(U,$J,358.3,41126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41126,1,3,0)
 ;;=3^Erectile Dysfunction Following Radical Prostatectomy
 ;;^UTILITY(U,$J,358.3,41126,1,4,0)
 ;;=4^N52.31
 ;;^UTILITY(U,$J,358.3,41126,2)
 ;;=^5015757
 ;;^UTILITY(U,$J,358.3,41127,0)
 ;;=N52.2^^159^2000^43
 ;;^UTILITY(U,$J,358.3,41127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41127,1,3,0)
 ;;=3^Erectile Dysfunction,Drug-Induced
 ;;^UTILITY(U,$J,358.3,41127,1,4,0)
 ;;=4^N52.2
 ;;^UTILITY(U,$J,358.3,41127,2)
 ;;=^5015756
 ;;^UTILITY(U,$J,358.3,41128,0)
 ;;=N52.03^^159^2000^34
 ;;^UTILITY(U,$J,358.3,41128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41128,1,3,0)
 ;;=3^Erectile Dysfunction Comb Artrl Insuff & Corporo-Venous Occlusv
 ;;^UTILITY(U,$J,358.3,41128,1,4,0)
 ;;=4^N52.03
 ;;^UTILITY(U,$J,358.3,41128,2)
 ;;=^5015754
 ;;^UTILITY(U,$J,358.3,41129,0)
 ;;=N52.02^^159^2000^35
 ;;^UTILITY(U,$J,358.3,41129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41129,1,3,0)
 ;;=3^Erectile Dysfunction Corporo-Venous Occlusive
 ;;^UTILITY(U,$J,358.3,41129,1,4,0)
 ;;=4^N52.02
 ;;^UTILITY(U,$J,358.3,41129,2)
 ;;=^5015753
 ;;^UTILITY(U,$J,358.3,41130,0)
 ;;=N52.1^^159^2000^42
 ;;^UTILITY(U,$J,358.3,41130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41130,1,3,0)
 ;;=3^Erectile Dysfunction d/t Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,41130,1,4,0)
 ;;=4^N52.1
 ;;^UTILITY(U,$J,358.3,41130,2)
 ;;=^5015755
 ;;^UTILITY(U,$J,358.3,41131,0)
 ;;=N52.01^^159^2000^41
 ;;^UTILITY(U,$J,358.3,41131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41131,1,3,0)
 ;;=3^Erectile Dysfunction d/t Arterial Insufficiency
 ;;^UTILITY(U,$J,358.3,41131,1,4,0)
 ;;=4^N52.01
 ;;^UTILITY(U,$J,358.3,41131,2)
 ;;=^5015752
 ;;^UTILITY(U,$J,358.3,41132,0)
 ;;=N95.2^^159^2000^81
 ;;^UTILITY(U,$J,358.3,41132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41132,1,3,0)
 ;;=3^Postmenopausal Atrophic Vaginitis
 ;;^UTILITY(U,$J,358.3,41132,1,4,0)
 ;;=4^N95.2
 ;;^UTILITY(U,$J,358.3,41132,2)
 ;;=^270577
 ;;^UTILITY(U,$J,358.3,41133,0)
 ;;=R30.9^^159^2000^65
 ;;^UTILITY(U,$J,358.3,41133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41133,1,3,0)
 ;;=3^Micturition Painful,Unspec
 ;;^UTILITY(U,$J,358.3,41133,1,4,0)
 ;;=4^R30.9
 ;;^UTILITY(U,$J,358.3,41133,2)
 ;;=^5019324
 ;;^UTILITY(U,$J,358.3,41134,0)
 ;;=R30.0^^159^2000^26
