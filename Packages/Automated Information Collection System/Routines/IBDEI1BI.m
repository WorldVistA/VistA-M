IBDEI1BI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21063,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,21063,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,21064,0)
 ;;=F12.188^^95^1044^10
 ;;^UTILITY(U,$J,358.3,21064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21064,1,3,0)
 ;;=3^Cannabis Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21064,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,21064,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,21065,0)
 ;;=F12.288^^95^1044^3
 ;;^UTILITY(U,$J,358.3,21065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21065,1,3,0)
 ;;=3^Cannabis Dependence w/ Induced Mood Disorder,Other
 ;;^UTILITY(U,$J,358.3,21065,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,21065,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,21066,0)
 ;;=F12.99^^95^1044^20
 ;;^UTILITY(U,$J,358.3,21066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21066,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21066,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,21066,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,21067,0)
 ;;=F12.11^^95^1044^1
 ;;^UTILITY(U,$J,358.3,21067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21067,1,3,0)
 ;;=3^Cannabis Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,21067,1,4,0)
 ;;=4^F12.11
 ;;^UTILITY(U,$J,358.3,21067,2)
 ;;=^268236
 ;;^UTILITY(U,$J,358.3,21068,0)
 ;;=F16.10^^95^1045^1
 ;;^UTILITY(U,$J,358.3,21068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21068,1,3,0)
 ;;=3^Hallucinogen Abuse
 ;;^UTILITY(U,$J,358.3,21068,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,21068,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,21069,0)
 ;;=F16.20^^95^1045^8
 ;;^UTILITY(U,$J,358.3,21069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21069,1,3,0)
 ;;=3^Hallucinogen Dependence
 ;;^UTILITY(U,$J,358.3,21069,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,21069,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,21070,0)
 ;;=F16.121^^95^1045^5
 ;;^UTILITY(U,$J,358.3,21070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21070,1,3,0)
 ;;=3^Hallucinogen Abuse w/ Intoxication w/ Delirium
 ;;^UTILITY(U,$J,358.3,21070,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,21070,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,21071,0)
 ;;=F16.221^^95^1045^12
 ;;^UTILITY(U,$J,358.3,21071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21071,1,3,0)
 ;;=3^Hallucinogen Dependence w/ Intoxication w/ Delirium
 ;;^UTILITY(U,$J,358.3,21071,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,21071,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,21072,0)
 ;;=F16.921^^95^1045^19
 ;;^UTILITY(U,$J,358.3,21072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21072,1,3,0)
 ;;=3^Hallucinogen Use w/ Intoxication w/ Delirium
 ;;^UTILITY(U,$J,358.3,21072,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,21072,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,21073,0)
 ;;=F16.129^^95^1045^6
 ;;^UTILITY(U,$J,358.3,21073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21073,1,3,0)
 ;;=3^Hallucinogen Abuse w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,21073,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,21073,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,21074,0)
 ;;=F16.229^^95^1045^13
 ;;^UTILITY(U,$J,358.3,21074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21074,1,3,0)
 ;;=3^Hallucinogen Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,21074,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,21074,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,21075,0)
 ;;=F16.929^^95^1045^20
 ;;^UTILITY(U,$J,358.3,21075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21075,1,3,0)
 ;;=3^Hallucinogen Use w/ Intoxication,Unspec
