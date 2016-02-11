IBDEI370 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53624,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,53624,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,53625,0)
 ;;=G47.33^^250^2699^33
 ;;^UTILITY(U,$J,358.3,53625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53625,1,3,0)
 ;;=3^Obstructive Sleep Apnea
 ;;^UTILITY(U,$J,358.3,53625,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,53625,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,53626,0)
 ;;=R10.84^^250^2699^1
 ;;^UTILITY(U,$J,358.3,53626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53626,1,3,0)
 ;;=3^Abdominal Pain,Generalized
 ;;^UTILITY(U,$J,358.3,53626,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,53626,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,53627,0)
 ;;=Z48.01^^250^2700^1
 ;;^UTILITY(U,$J,358.3,53627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53627,1,3,0)
 ;;=3^Change/Removal of Surgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,53627,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,53627,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,53628,0)
 ;;=Z48.02^^250^2700^3
 ;;^UTILITY(U,$J,358.3,53628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53628,1,3,0)
 ;;=3^Removal of sutures
 ;;^UTILITY(U,$J,358.3,53628,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,53628,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,53629,0)
 ;;=Z09.^^250^2700^2
 ;;^UTILITY(U,$J,358.3,53629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53629,1,3,0)
 ;;=3^F/U exam aft trtmt for cond oth than malig neoplm
 ;;^UTILITY(U,$J,358.3,53629,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,53629,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,53630,0)
 ;;=K91.3^^250^2701^6
 ;;^UTILITY(U,$J,358.3,53630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53630,1,3,0)
 ;;=3^Postprocedural intestinal obstruction
 ;;^UTILITY(U,$J,358.3,53630,1,4,0)
 ;;=4^K91.3
 ;;^UTILITY(U,$J,358.3,53630,2)
 ;;=^5008902
 ;;^UTILITY(U,$J,358.3,53631,0)
 ;;=J95.830^^250^2701^5
 ;;^UTILITY(U,$J,358.3,53631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53631,1,3,0)
 ;;=3^Postproc hemor/hemtom of a resp sys org fol a resp sys proc
 ;;^UTILITY(U,$J,358.3,53631,1,4,0)
 ;;=4^J95.830
 ;;^UTILITY(U,$J,358.3,53631,2)
 ;;=^5008340
 ;;^UTILITY(U,$J,358.3,53632,0)
 ;;=T88.8XXA^^250^2701^2
 ;;^UTILITY(U,$J,358.3,53632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53632,1,3,0)
 ;;=3^Complications of surgical and medical care, NEC, init
 ;;^UTILITY(U,$J,358.3,53632,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,53632,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,53633,0)
 ;;=T81.31XA^^250^2701^3
 ;;^UTILITY(U,$J,358.3,53633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53633,1,3,0)
 ;;=3^Disruption of external operation (surgical) wound, NEC, init
 ;;^UTILITY(U,$J,358.3,53633,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,53633,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,53634,0)
 ;;=T81.4XXA^^250^2701^4
 ;;^UTILITY(U,$J,358.3,53634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53634,1,3,0)
 ;;=3^Infection following a procedure, initial encounter
 ;;^UTILITY(U,$J,358.3,53634,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,53634,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,53635,0)
 ;;=T81.89XA^^250^2701^1
 ;;^UTILITY(U,$J,358.3,53635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53635,1,3,0)
 ;;=3^Complications of procedures, NEC, init
 ;;^UTILITY(U,$J,358.3,53635,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,53635,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,53636,0)
 ;;=I25.10^^250^2702^1
 ;;^UTILITY(U,$J,358.3,53636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53636,1,3,0)
 ;;=3^Athscl Hrt Disease,NTV Cor Art w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,53636,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,53636,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,53637,0)
 ;;=I50.9^^250^2702^3
