IBDEI32R ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49094,1,3,0)
 ;;=3^Problems Related to Reduced Mobility
 ;;^UTILITY(U,$J,358.3,49094,1,4,0)
 ;;=4^Z74.09
 ;;^UTILITY(U,$J,358.3,49094,2)
 ;;=^5063283
 ;;^UTILITY(U,$J,358.3,49095,0)
 ;;=Z60.9^^185^2428^156
 ;;^UTILITY(U,$J,358.3,49095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49095,1,3,0)
 ;;=3^Problems Related to Social Environment
 ;;^UTILITY(U,$J,358.3,49095,1,4,0)
 ;;=4^Z60.9
 ;;^UTILITY(U,$J,358.3,49095,2)
 ;;=^5063145
 ;;^UTILITY(U,$J,358.3,49096,0)
 ;;=Z60.4^^185^2428^157
 ;;^UTILITY(U,$J,358.3,49096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49096,1,3,0)
 ;;=3^Problems Related to Social Exclusion/Rejection
 ;;^UTILITY(U,$J,358.3,49096,1,4,0)
 ;;=4^Z60.4
 ;;^UTILITY(U,$J,358.3,49096,2)
 ;;=^5063142
 ;;^UTILITY(U,$J,358.3,49097,0)
 ;;=Z60.5^^185^2428^125
 ;;^UTILITY(U,$J,358.3,49097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49097,1,3,0)
 ;;=3^Problems Related to Adverse Discrimination/Persecution
 ;;^UTILITY(U,$J,358.3,49097,1,4,0)
 ;;=4^Z60.5
 ;;^UTILITY(U,$J,358.3,49097,2)
 ;;=^5063143
 ;;^UTILITY(U,$J,358.3,49098,0)
 ;;=Z75.3^^185^2428^158
 ;;^UTILITY(U,$J,358.3,49098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49098,1,3,0)
 ;;=3^Problems Related to Unavailability/Inaccessibility of Health-Care Facilities
 ;;^UTILITY(U,$J,358.3,49098,1,4,0)
 ;;=4^Z75.3
 ;;^UTILITY(U,$J,358.3,49098,2)
 ;;=^5063292
 ;;^UTILITY(U,$J,358.3,49099,0)
 ;;=Z75.4^^185^2428^159
 ;;^UTILITY(U,$J,358.3,49099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49099,1,3,0)
 ;;=3^Problems Related to Unavailability/Inaccessibility of Helping Agencies
 ;;^UTILITY(U,$J,358.3,49099,1,4,0)
 ;;=4^Z75.4
 ;;^UTILITY(U,$J,358.3,49099,2)
 ;;=^5063293
 ;;^UTILITY(U,$J,358.3,49100,0)
 ;;=Z65.9^^185^2428^153
 ;;^UTILITY(U,$J,358.3,49100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49100,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,49100,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,49100,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,49101,0)
 ;;=Z75.2^^185^2428^160
 ;;^UTILITY(U,$J,358.3,49101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49101,1,3,0)
 ;;=3^Problems Related to Waiting Period for Investigation/Treatment
 ;;^UTILITY(U,$J,358.3,49101,1,4,0)
 ;;=4^Z75.2
 ;;^UTILITY(U,$J,358.3,49101,2)
 ;;=^5063291
 ;;^UTILITY(U,$J,358.3,49102,0)
 ;;=Z75.5^^185^2428^161
 ;;^UTILITY(U,$J,358.3,49102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49102,1,3,0)
 ;;=3^Respite/Holiday Relief Care
 ;;^UTILITY(U,$J,358.3,49102,1,4,0)
 ;;=4^Z75.5
 ;;^UTILITY(U,$J,358.3,49102,2)
 ;;=^5063294
 ;;^UTILITY(U,$J,358.3,49103,0)
 ;;=R68.89^^185^2428^165
 ;;^UTILITY(U,$J,358.3,49103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49103,1,3,0)
 ;;=3^Symptoms/Signs,General,Other
 ;;^UTILITY(U,$J,358.3,49103,1,4,0)
 ;;=4^R68.89
 ;;^UTILITY(U,$J,358.3,49103,2)
 ;;=^5019557
 ;;^UTILITY(U,$J,358.3,49104,0)
 ;;=Z72.0^^185^2428^168
 ;;^UTILITY(U,$J,358.3,49104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49104,1,3,0)
 ;;=3^Tobacco Use
 ;;^UTILITY(U,$J,358.3,49104,1,4,0)
 ;;=4^Z72.0
 ;;^UTILITY(U,$J,358.3,49104,2)
 ;;=^5063255
 ;;^UTILITY(U,$J,358.3,49105,0)
 ;;=Z94.9^^185^2428^169
 ;;^UTILITY(U,$J,358.3,49105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49105,1,3,0)
 ;;=3^Transplanted Organ/Tissue Status,Unspec
 ;;^UTILITY(U,$J,358.3,49105,1,4,0)
 ;;=4^Z94.9
 ;;^UTILITY(U,$J,358.3,49105,2)
 ;;=^5063667
 ;;^UTILITY(U,$J,358.3,49106,0)
 ;;=R76.11^^185^2428^166
