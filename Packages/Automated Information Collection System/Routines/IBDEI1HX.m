IBDEI1HX ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26856,1,3,0)
 ;;=3^491.20
 ;;^UTILITY(U,$J,358.3,26856,1,4,0)
 ;;=4^COPD w/ Chr Bronchitis,Stable
 ;;^UTILITY(U,$J,358.3,26856,2)
 ;;=COPD with Chronic Bronchitis, Stable^269953
 ;;^UTILITY(U,$J,358.3,26857,0)
 ;;=116.0^^161^1657^15
 ;;^UTILITY(U,$J,358.3,26857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26857,1,3,0)
 ;;=3^116.0
 ;;^UTILITY(U,$J,358.3,26857,1,4,0)
 ;;=4^Fungus, Blastomycosis
 ;;^UTILITY(U,$J,358.3,26857,2)
 ;;=Blastomycosis^15213
 ;;^UTILITY(U,$J,358.3,26858,0)
 ;;=117.5^^161^1657^17
 ;;^UTILITY(U,$J,358.3,26858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26858,1,3,0)
 ;;=3^117.5
 ;;^UTILITY(U,$J,358.3,26858,1,4,0)
 ;;=4^Fungus, Cryptococcosis
 ;;^UTILITY(U,$J,358.3,26858,2)
 ;;=Cryptococcosis^29608
 ;;^UTILITY(U,$J,358.3,26859,0)
 ;;=117.3^^161^1657^14
 ;;^UTILITY(U,$J,358.3,26859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26859,1,3,0)
 ;;=3^117.3
 ;;^UTILITY(U,$J,358.3,26859,1,4,0)
 ;;=4^Fungus, Aspergillosis
 ;;^UTILITY(U,$J,358.3,26859,2)
 ;;=Aspergillosis^10935
 ;;^UTILITY(U,$J,358.3,26860,0)
 ;;=115.95^^161^1657^18
 ;;^UTILITY(U,$J,358.3,26860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26860,1,3,0)
 ;;=3^115.95
 ;;^UTILITY(U,$J,358.3,26860,1,4,0)
 ;;=4^Fungus, Histoplasmosis Pneumonia
 ;;^UTILITY(U,$J,358.3,26860,2)
 ;;=Histoplasmosis Pneumonia^266908
 ;;^UTILITY(U,$J,358.3,26861,0)
 ;;=114.5^^161^1657^16
 ;;^UTILITY(U,$J,358.3,26861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26861,1,3,0)
 ;;=3^114.5
 ;;^UTILITY(U,$J,358.3,26861,1,4,0)
 ;;=4^Fungus, Coccidiomycosis
 ;;^UTILITY(U,$J,358.3,26861,2)
 ;;=Coccidiomycosis^295703
 ;;^UTILITY(U,$J,358.3,26862,0)
 ;;=491.1^^161^1657^28
 ;;^UTILITY(U,$J,358.3,26862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26862,1,3,0)
 ;;=3^491.1
 ;;^UTILITY(U,$J,358.3,26862,1,4,0)
 ;;=4^Mucopurulent Chronic Bronchitis
 ;;^UTILITY(U,$J,358.3,26862,2)
 ;;=Mucopurulent Chronic Bronchitis^269949
 ;;^UTILITY(U,$J,358.3,26863,0)
 ;;=491.0^^161^1657^62
 ;;^UTILITY(U,$J,358.3,26863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26863,1,3,0)
 ;;=3^491.0
 ;;^UTILITY(U,$J,358.3,26863,1,4,0)
 ;;=4^Simple Chronic Bronchitis
 ;;^UTILITY(U,$J,358.3,26863,2)
 ;;=Simple Chronic Bronchitis^269946
 ;;^UTILITY(U,$J,358.3,26864,0)
 ;;=079.99^^161^1657^70
 ;;^UTILITY(U,$J,358.3,26864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26864,1,3,0)
 ;;=3^079.99
 ;;^UTILITY(U,$J,358.3,26864,1,4,0)
 ;;=4^Viral Infection
 ;;^UTILITY(U,$J,358.3,26864,2)
 ;;=Viral Infection^295798
 ;;^UTILITY(U,$J,358.3,26865,0)
 ;;=477.9^^161^1657^3
 ;;^UTILITY(U,$J,358.3,26865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26865,1,3,0)
 ;;=3^477.9
 ;;^UTILITY(U,$J,358.3,26865,1,4,0)
 ;;=4^Allergic Rhinitis
 ;;^UTILITY(U,$J,358.3,26865,2)
 ;;=Allergic Rhinitis^4955
 ;;^UTILITY(U,$J,358.3,26866,0)
 ;;=460.^^161^1657^13
 ;;^UTILITY(U,$J,358.3,26866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26866,1,3,0)
 ;;=3^460.
 ;;^UTILITY(U,$J,358.3,26866,1,4,0)
 ;;=4^Common Cold
 ;;^UTILITY(U,$J,358.3,26866,2)
 ;;=Common Cold^26543
 ;;^UTILITY(U,$J,358.3,26867,0)
 ;;=464.00^^161^1657^24
 ;;^UTILITY(U,$J,358.3,26867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26867,1,3,0)
 ;;=3^464.00
 ;;^UTILITY(U,$J,358.3,26867,1,4,0)
 ;;=4^Laryngitis, Acute
 ;;^UTILITY(U,$J,358.3,26867,2)
 ;;=Laryngitis, Acute^323469
 ;;^UTILITY(U,$J,358.3,26868,0)
 ;;=464.20^^161^1657^25
 ;;^UTILITY(U,$J,358.3,26868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26868,1,3,0)
 ;;=3^464.20
 ;;^UTILITY(U,$J,358.3,26868,1,4,0)
 ;;=4^Laryngotracheitis, Acute
