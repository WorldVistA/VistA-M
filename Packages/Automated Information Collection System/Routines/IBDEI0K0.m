IBDEI0K0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9018,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,9018,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,9019,0)
 ;;=I89.0^^55^556^71
 ;;^UTILITY(U,$J,358.3,9019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9019,1,3,0)
 ;;=3^Lymphedema, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,9019,1,4,0)
 ;;=4^I89.0
 ;;^UTILITY(U,$J,358.3,9019,2)
 ;;=^5008073
 ;;^UTILITY(U,$J,358.3,9020,0)
 ;;=I87.1^^55^556^29
 ;;^UTILITY(U,$J,358.3,9020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9020,1,3,0)
 ;;=3^Compression of vein
 ;;^UTILITY(U,$J,358.3,9020,1,4,0)
 ;;=4^I87.1
 ;;^UTILITY(U,$J,358.3,9020,2)
 ;;=^269850
 ;;^UTILITY(U,$J,358.3,9021,0)
 ;;=J44.0^^55^556^25
 ;;^UTILITY(U,$J,358.3,9021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9021,1,3,0)
 ;;=3^Chronic obstructive pulmon disease w acute lower resp infct
 ;;^UTILITY(U,$J,358.3,9021,1,4,0)
 ;;=4^J44.0
 ;;^UTILITY(U,$J,358.3,9021,2)
 ;;=^5008239
 ;;^UTILITY(U,$J,358.3,9022,0)
 ;;=J98.6^^55^556^33
 ;;^UTILITY(U,$J,358.3,9022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9022,1,3,0)
 ;;=3^Disorders of diaphragm
 ;;^UTILITY(U,$J,358.3,9022,1,4,0)
 ;;=4^J98.6
 ;;^UTILITY(U,$J,358.3,9022,2)
 ;;=^5008364
 ;;^UTILITY(U,$J,358.3,9023,0)
 ;;=K08.109^^55^556^28
 ;;^UTILITY(U,$J,358.3,9023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9023,1,3,0)
 ;;=3^Complete loss of teeth, unspecified cause, unspecified class
 ;;^UTILITY(U,$J,358.3,9023,1,4,0)
 ;;=4^K08.109
 ;;^UTILITY(U,$J,358.3,9023,2)
 ;;=^5008410
 ;;^UTILITY(U,$J,358.3,9024,0)
 ;;=K59.00^^55^556^30
 ;;^UTILITY(U,$J,358.3,9024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9024,1,3,0)
 ;;=3^Constipation, unspecified
 ;;^UTILITY(U,$J,358.3,9024,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,9024,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,9025,0)
 ;;=N39.0^^55^556^110
 ;;^UTILITY(U,$J,358.3,9025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9025,1,3,0)
 ;;=3^Urinary tract infection, site not specified
 ;;^UTILITY(U,$J,358.3,9025,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,9025,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,9026,0)
 ;;=N39.3^^55^556^103
 ;;^UTILITY(U,$J,358.3,9026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9026,1,3,0)
 ;;=3^Stress incontinence (female) (male)
 ;;^UTILITY(U,$J,358.3,9026,1,4,0)
 ;;=4^N39.3
 ;;^UTILITY(U,$J,358.3,9026,2)
 ;;=^5015679
 ;;^UTILITY(U,$J,358.3,9027,0)
 ;;=L60.0^^55^556^60
 ;;^UTILITY(U,$J,358.3,9027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9027,1,3,0)
 ;;=3^Ingrowing nail
 ;;^UTILITY(U,$J,358.3,9027,1,4,0)
 ;;=4^L60.0
 ;;^UTILITY(U,$J,358.3,9027,2)
 ;;=^5009234
 ;;^UTILITY(U,$J,358.3,9028,0)
 ;;=R26.2^^55^556^32
 ;;^UTILITY(U,$J,358.3,9028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9028,1,3,0)
 ;;=3^Difficulty in walking, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,9028,1,4,0)
 ;;=4^R26.2
 ;;^UTILITY(U,$J,358.3,9028,2)
 ;;=^5019306
 ;;^UTILITY(U,$J,358.3,9029,0)
 ;;=R40.20^^55^556^27
 ;;^UTILITY(U,$J,358.3,9029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9029,1,3,0)
 ;;=3^Coma,Unspec
 ;;^UTILITY(U,$J,358.3,9029,1,4,0)
 ;;=4^R40.20
 ;;^UTILITY(U,$J,358.3,9029,2)
 ;;=^5019354
 ;;^UTILITY(U,$J,358.3,9030,0)
 ;;=R40.4^^55^556^108
 ;;^UTILITY(U,$J,358.3,9030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9030,1,3,0)
 ;;=3^Transient alteration of awareness
 ;;^UTILITY(U,$J,358.3,9030,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,9030,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,9031,0)
 ;;=R44.3^^55^556^50
 ;;^UTILITY(U,$J,358.3,9031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9031,1,3,0)
 ;;=3^Hallucinations, unspecified
 ;;^UTILITY(U,$J,358.3,9031,1,4,0)
 ;;=4^R44.3
 ;;^UTILITY(U,$J,358.3,9031,2)
 ;;=^5019458
