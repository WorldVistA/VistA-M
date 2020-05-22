IBDEI2XT ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46876,1,3,0)
 ;;=3^Brkdwn (mech) penile (impl) pros,Init Encntr
 ;;^UTILITY(U,$J,358.3,46876,1,4,0)
 ;;=4^T83.410A
 ;;^UTILITY(U,$J,358.3,46876,2)
 ;;=^5055040
 ;;^UTILITY(U,$J,358.3,46877,0)
 ;;=T83.418A^^179^2338^10
 ;;^UTILITY(U,$J,358.3,46877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46877,1,3,0)
 ;;=3^Brkdwn pros dvc/implnt/grft,genitl trct,Init Encntr
 ;;^UTILITY(U,$J,358.3,46877,1,4,0)
 ;;=4^T83.418A
 ;;^UTILITY(U,$J,358.3,46877,2)
 ;;=^5055043
 ;;^UTILITY(U,$J,358.3,46878,0)
 ;;=T83.420A^^179^2338^19
 ;;^UTILITY(U,$J,358.3,46878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46878,1,3,0)
 ;;=3^Dsplcmnt penile (implanted) prosth,Init Encntr
 ;;^UTILITY(U,$J,358.3,46878,1,4,0)
 ;;=4^T83.420A
 ;;^UTILITY(U,$J,358.3,46878,2)
 ;;=^5055046
 ;;^UTILITY(U,$J,358.3,46879,0)
 ;;=T83.428A^^179^2338^15
 ;;^UTILITY(U,$J,358.3,46879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46879,1,3,0)
 ;;=3^Dsplcmnt genitl trct (impl) prosth,Init Encntr
 ;;^UTILITY(U,$J,358.3,46879,1,4,0)
 ;;=4^T83.428A
 ;;^UTILITY(U,$J,358.3,46879,2)
 ;;=^5055049
 ;;^UTILITY(U,$J,358.3,46880,0)
 ;;=T83.490A^^179^2338^40
 ;;^UTILITY(U,$J,358.3,46880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46880,1,3,0)
 ;;=3^Mech compl penile (implanted) prosth,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,46880,1,4,0)
 ;;=4^T83.490A
 ;;^UTILITY(U,$J,358.3,46880,2)
 ;;=^5055052
 ;;^UTILITY(U,$J,358.3,46881,0)
 ;;=T83.498A^^179^2338^41
 ;;^UTILITY(U,$J,358.3,46881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46881,1,3,0)
 ;;=3^Mech compl prosth dvc/implnt/grft of genitl trct,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,46881,1,4,0)
 ;;=4^T83.498A
 ;;^UTILITY(U,$J,358.3,46881,2)
 ;;=^5055055
 ;;^UTILITY(U,$J,358.3,46882,0)
 ;;=N99.820^^179^2338^45
 ;;^UTILITY(U,$J,358.3,46882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46882,1,3,0)
 ;;=3^Postproc hemor,GU syst org/struct fol GU sys proc
 ;;^UTILITY(U,$J,358.3,46882,1,4,0)
 ;;=4^N99.820
 ;;^UTILITY(U,$J,358.3,46882,2)
 ;;=^5015968
 ;;^UTILITY(U,$J,358.3,46883,0)
 ;;=K68.11^^179^2338^47
 ;;^UTILITY(U,$J,358.3,46883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46883,1,3,0)
 ;;=3^Postproc retroperitoneal abscess
 ;;^UTILITY(U,$J,358.3,46883,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,46883,2)
 ;;=^5008782
 ;;^UTILITY(U,$J,358.3,46884,0)
 ;;=Z48.00^^179^2338^12
 ;;^UTILITY(U,$J,358.3,46884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46884,1,3,0)
 ;;=3^Change/Rem of Nonsurg Wound Dressing
 ;;^UTILITY(U,$J,358.3,46884,1,4,0)
 ;;=4^Z48.00
 ;;^UTILITY(U,$J,358.3,46884,2)
 ;;=^5063033
 ;;^UTILITY(U,$J,358.3,46885,0)
 ;;=Z48.01^^179^2338^13
 ;;^UTILITY(U,$J,358.3,46885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46885,1,3,0)
 ;;=3^Change/Rem of Surg Wound Dressing
 ;;^UTILITY(U,$J,358.3,46885,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,46885,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,46886,0)
 ;;=Z48.02^^179^2338^48
 ;;^UTILITY(U,$J,358.3,46886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46886,1,3,0)
 ;;=3^Removal of Sutures
 ;;^UTILITY(U,$J,358.3,46886,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,46886,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,46887,0)
 ;;=Z48.89^^179^2338^49
 ;;^UTILITY(U,$J,358.3,46887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46887,1,3,0)
 ;;=3^Surg Aftercare,Oth Specified
 ;;^UTILITY(U,$J,358.3,46887,1,4,0)
 ;;=4^Z48.89
 ;;^UTILITY(U,$J,358.3,46887,2)
 ;;=^5063055
 ;;^UTILITY(U,$J,358.3,46888,0)
 ;;=Z48.03^^179^2338^11
