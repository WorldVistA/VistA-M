IBDEI25C ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34283,0)
 ;;=F07.0^^134^1737^9
 ;;^UTILITY(U,$J,358.3,34283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34283,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,34283,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,34283,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,34284,0)
 ;;=Z65.4^^134^1738^5
 ;;^UTILITY(U,$J,358.3,34284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34284,1,3,0)
 ;;=3^Victim of Crime
 ;;^UTILITY(U,$J,358.3,34284,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,34284,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,34285,0)
 ;;=Z65.0^^134^1738^1
 ;;^UTILITY(U,$J,358.3,34285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34285,1,3,0)
 ;;=3^Conviction in Civil/Criminal Proceedings w/o Imprisonment
 ;;^UTILITY(U,$J,358.3,34285,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,34285,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,34286,0)
 ;;=Z65.2^^134^1738^4
 ;;^UTILITY(U,$J,358.3,34286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34286,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,34286,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,34286,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,34287,0)
 ;;=Z65.3^^134^1738^3
 ;;^UTILITY(U,$J,358.3,34287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34287,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,34287,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,34287,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,34288,0)
 ;;=Z65.1^^134^1738^2
 ;;^UTILITY(U,$J,358.3,34288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34288,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,34288,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,34288,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,34289,0)
 ;;=Z64.0^^134^1739^6
 ;;^UTILITY(U,$J,358.3,34289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34289,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,34289,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,34289,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,34290,0)
 ;;=Z64.1^^134^1739^3
 ;;^UTILITY(U,$J,358.3,34290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34290,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,34290,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,34290,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,34291,0)
 ;;=Z64.4^^134^1739^1
 ;;^UTILITY(U,$J,358.3,34291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34291,1,3,0)
 ;;=3^Discord w/ Counselors
 ;;^UTILITY(U,$J,358.3,34291,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,34291,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,34292,0)
 ;;=Z65.5^^134^1739^2
 ;;^UTILITY(U,$J,358.3,34292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34292,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,34292,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,34292,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,34293,0)
 ;;=Z65.8^^134^1739^4
 ;;^UTILITY(U,$J,358.3,34293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34293,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,34293,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,34293,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,34294,0)
 ;;=Z65.9^^134^1739^5
 ;;^UTILITY(U,$J,358.3,34294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34294,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,34294,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,34294,2)
 ;;=^5063186
