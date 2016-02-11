IBDEI2UP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47841,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,47841,1,4,0)
 ;;=4^Z85.118
 ;;^UTILITY(U,$J,358.3,47841,2)
 ;;=^5063408
 ;;^UTILITY(U,$J,358.3,47842,0)
 ;;=Z85.09^^209^2357^10
 ;;^UTILITY(U,$J,358.3,47842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47842,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Digestive Organs
 ;;^UTILITY(U,$J,358.3,47842,1,4,0)
 ;;=4^Z85.09
 ;;^UTILITY(U,$J,358.3,47842,2)
 ;;=^5063406
 ;;^UTILITY(U,$J,358.3,47843,0)
 ;;=Z85.01^^209^2357^11
 ;;^UTILITY(U,$J,358.3,47843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47843,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Esophagus
 ;;^UTILITY(U,$J,358.3,47843,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,47843,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,47844,0)
 ;;=Z85.528^^209^2357^12
 ;;^UTILITY(U,$J,358.3,47844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47844,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Kidney
 ;;^UTILITY(U,$J,358.3,47844,1,4,0)
 ;;=4^Z85.528
 ;;^UTILITY(U,$J,358.3,47844,2)
 ;;=^5063430
 ;;^UTILITY(U,$J,358.3,47845,0)
 ;;=Z85.038^^209^2357^13
 ;;^UTILITY(U,$J,358.3,47845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47845,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Large Intestine
 ;;^UTILITY(U,$J,358.3,47845,1,4,0)
 ;;=4^Z85.038
 ;;^UTILITY(U,$J,358.3,47845,2)
 ;;=^5063399
 ;;^UTILITY(U,$J,358.3,47846,0)
 ;;=Z85.21^^209^2357^14
 ;;^UTILITY(U,$J,358.3,47846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47846,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Larynx
 ;;^UTILITY(U,$J,358.3,47846,1,4,0)
 ;;=4^Z85.21
 ;;^UTILITY(U,$J,358.3,47846,2)
 ;;=^5063411
 ;;^UTILITY(U,$J,358.3,47847,0)
 ;;=Z85.819^^209^2357^15
 ;;^UTILITY(U,$J,358.3,47847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47847,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Lip.Oral Cavity/Pharynx,Unspec
 ;;^UTILITY(U,$J,358.3,47847,1,4,0)
 ;;=4^Z85.819
 ;;^UTILITY(U,$J,358.3,47847,2)
 ;;=^5063440
 ;;^UTILITY(U,$J,358.3,47848,0)
 ;;=Z85.05^^209^2357^16
 ;;^UTILITY(U,$J,358.3,47848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47848,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Liver
 ;;^UTILITY(U,$J,358.3,47848,1,4,0)
 ;;=4^Z85.05
 ;;^UTILITY(U,$J,358.3,47848,2)
 ;;=^5063402
 ;;^UTILITY(U,$J,358.3,47849,0)
 ;;=Z85.79^^209^2357^17
 ;;^UTILITY(U,$J,358.3,47849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47849,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Lymphoid/Hematpoetc/Rel Tiss
 ;;^UTILITY(U,$J,358.3,47849,1,4,0)
 ;;=4^Z85.79
 ;;^UTILITY(U,$J,358.3,47849,2)
 ;;=^5063437
 ;;^UTILITY(U,$J,358.3,47850,0)
 ;;=Z85.22^^209^2357^18
 ;;^UTILITY(U,$J,358.3,47850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47850,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Nasal Cavity/Med Ear/Acces Sinus
 ;;^UTILITY(U,$J,358.3,47850,1,4,0)
 ;;=4^Z85.22
 ;;^UTILITY(U,$J,358.3,47850,2)
 ;;=^5063412
 ;;^UTILITY(U,$J,358.3,47851,0)
 ;;=Z85.07^^209^2357^19
 ;;^UTILITY(U,$J,358.3,47851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47851,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Pancreas
 ;;^UTILITY(U,$J,358.3,47851,1,4,0)
 ;;=4^Z85.07
 ;;^UTILITY(U,$J,358.3,47851,2)
 ;;=^5063405
 ;;^UTILITY(U,$J,358.3,47852,0)
 ;;=Z85.46^^209^2357^20
 ;;^UTILITY(U,$J,358.3,47852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47852,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Prostate
 ;;^UTILITY(U,$J,358.3,47852,1,4,0)
 ;;=4^Z85.46
 ;;^UTILITY(U,$J,358.3,47852,2)
 ;;=^5063423
 ;;^UTILITY(U,$J,358.3,47853,0)
 ;;=Z85.048^^209^2357^21
 ;;^UTILITY(U,$J,358.3,47853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47853,1,3,0)
 ;;=3^Personal Hx of Malig Neo of Rectum/Rectosig Junct/Anus
 ;;^UTILITY(U,$J,358.3,47853,1,4,0)
 ;;=4^Z85.048
