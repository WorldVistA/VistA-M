IBDEI0EN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6399,2)
 ;;=^5003453
 ;;^UTILITY(U,$J,358.3,6400,0)
 ;;=F15.221^^43^397^42
 ;;^UTILITY(U,$J,358.3,6400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6400,1,3,0)
 ;;=3^Stimulant Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,6400,1,4,0)
 ;;=4^F15.221
 ;;^UTILITY(U,$J,358.3,6400,2)
 ;;=^5003298
 ;;^UTILITY(U,$J,358.3,6401,0)
 ;;=F15.121^^43^397^38
 ;;^UTILITY(U,$J,358.3,6401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6401,1,3,0)
 ;;=3^Stimulant Abuse w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,6401,1,4,0)
 ;;=4^F15.121
 ;;^UTILITY(U,$J,358.3,6401,2)
 ;;=^5003284
 ;;^UTILITY(U,$J,358.3,6402,0)
 ;;=F13.221^^43^397^32
 ;;^UTILITY(U,$J,358.3,6402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6402,1,3,0)
 ;;=3^Sedatv/Hyp/Anxiolytc Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,6402,1,4,0)
 ;;=4^F13.221
 ;;^UTILITY(U,$J,358.3,6402,2)
 ;;=^5003204
 ;;^UTILITY(U,$J,358.3,6403,0)
 ;;=F12.221^^43^397^1
 ;;^UTILITY(U,$J,358.3,6403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6403,1,3,0)
 ;;=3^Cannabis Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,6403,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,6403,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,6404,0)
 ;;=F14.121^^43^397^3
 ;;^UTILITY(U,$J,358.3,6404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6404,1,3,0)
 ;;=3^Cocaine Abuse w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,6404,1,4,0)
 ;;=4^F14.121
 ;;^UTILITY(U,$J,358.3,6404,2)
 ;;=^5003241
 ;;^UTILITY(U,$J,358.3,6405,0)
 ;;=F16.221^^43^397^9
 ;;^UTILITY(U,$J,358.3,6405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6405,1,3,0)
 ;;=3^Hallucinogen Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,6405,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,6405,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,6406,0)
 ;;=F11.221^^43^397^12
 ;;^UTILITY(U,$J,358.3,6406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6406,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,6406,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,6406,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,6407,0)
 ;;=F19.94^^43^397^25
 ;;^UTILITY(U,$J,358.3,6407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6407,1,3,0)
 ;;=3^Psychoactive Subs Use w/ Mood Disorder
 ;;^UTILITY(U,$J,358.3,6407,1,4,0)
 ;;=4^F19.94
 ;;^UTILITY(U,$J,358.3,6407,2)
 ;;=^5003460
 ;;^UTILITY(U,$J,358.3,6408,0)
 ;;=F15.24^^43^397^43
 ;;^UTILITY(U,$J,358.3,6408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6408,1,3,0)
 ;;=3^Stimulant Dependence w/ Mood Disorder
 ;;^UTILITY(U,$J,358.3,6408,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,6408,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,6409,0)
 ;;=F15.14^^43^397^39
 ;;^UTILITY(U,$J,358.3,6409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6409,1,3,0)
 ;;=3^Stimulant Abuse w/ Mood Disorder
 ;;^UTILITY(U,$J,358.3,6409,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,6409,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,6410,0)
 ;;=F13.24^^43^397^33
 ;;^UTILITY(U,$J,358.3,6410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6410,1,3,0)
 ;;=3^Sedatv/Hyp/Anxiolytc Dependence w/ Mood Disorder
 ;;^UTILITY(U,$J,358.3,6410,1,4,0)
 ;;=4^F13.24
 ;;^UTILITY(U,$J,358.3,6410,2)
 ;;=^5003210
 ;;^UTILITY(U,$J,358.3,6411,0)
 ;;=F13.14^^43^397^29
 ;;^UTILITY(U,$J,358.3,6411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6411,1,3,0)
 ;;=3^Sedatv/Hyp/Anxiolytc Abuse w/ Mood Disorder
 ;;^UTILITY(U,$J,358.3,6411,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,6411,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,6412,0)
 ;;=F14.151^^43^397^5
 ;;^UTILITY(U,$J,358.3,6412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6412,1,3,0)
 ;;=3^Cocaine Abuse w/ Psych Disorder w/ Hallucinations
