IBDEI2J4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42901,1,3,0)
 ;;=3^Dsplcmnt prosth dvc/implnt/grft of genitl trct,Init Encntr
 ;;^UTILITY(U,$J,358.3,42901,1,4,0)
 ;;=4^T83.428A
 ;;^UTILITY(U,$J,358.3,42901,2)
 ;;=^5055049
 ;;^UTILITY(U,$J,358.3,42902,0)
 ;;=T83.490A^^162^2049^22
 ;;^UTILITY(U,$J,358.3,42902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42902,1,3,0)
 ;;=3^Mech compl penile (implanted) prosth,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,42902,1,4,0)
 ;;=4^T83.490A
 ;;^UTILITY(U,$J,358.3,42902,2)
 ;;=^5055052
 ;;^UTILITY(U,$J,358.3,42903,0)
 ;;=T83.498A^^162^2049^23
 ;;^UTILITY(U,$J,358.3,42903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42903,1,3,0)
 ;;=3^Mech compl prosth dvc/implnt/grft of genitl trct,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,42903,1,4,0)
 ;;=4^T83.498A
 ;;^UTILITY(U,$J,358.3,42903,2)
 ;;=^5055055
 ;;^UTILITY(U,$J,358.3,42904,0)
 ;;=N99.820^^162^2049^27
 ;;^UTILITY(U,$J,358.3,42904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42904,1,3,0)
 ;;=3^Postproc hemor/hemtom of GU sys org fol GU sys procedure
 ;;^UTILITY(U,$J,358.3,42904,1,4,0)
 ;;=4^N99.820
 ;;^UTILITY(U,$J,358.3,42904,2)
 ;;=^5015968
 ;;^UTILITY(U,$J,358.3,42905,0)
 ;;=T81.4XXA^^162^2049^18
 ;;^UTILITY(U,$J,358.3,42905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42905,1,3,0)
 ;;=3^Infection following a procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,42905,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,42905,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,42906,0)
 ;;=K68.11^^162^2049^28
 ;;^UTILITY(U,$J,358.3,42906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42906,1,3,0)
 ;;=3^Postproc retroperitoneal abscess
 ;;^UTILITY(U,$J,358.3,42906,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,42906,2)
 ;;=^5008782
 ;;^UTILITY(U,$J,358.3,42907,0)
 ;;=Z48.00^^162^2049^10
 ;;^UTILITY(U,$J,358.3,42907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42907,1,3,0)
 ;;=3^Change/Removal of Nonsurg Wound Dressing
 ;;^UTILITY(U,$J,358.3,42907,1,4,0)
 ;;=4^Z48.00
 ;;^UTILITY(U,$J,358.3,42907,2)
 ;;=^5063033
 ;;^UTILITY(U,$J,358.3,42908,0)
 ;;=Z48.01^^162^2049^11
 ;;^UTILITY(U,$J,358.3,42908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42908,1,3,0)
 ;;=3^Change/Removal of Surg Wound Dressing
 ;;^UTILITY(U,$J,358.3,42908,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,42908,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,42909,0)
 ;;=Z48.02^^162^2049^29
 ;;^UTILITY(U,$J,358.3,42909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42909,1,3,0)
 ;;=3^Removal of Sutures
 ;;^UTILITY(U,$J,358.3,42909,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,42909,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,42910,0)
 ;;=Z48.89^^162^2049^30
 ;;^UTILITY(U,$J,358.3,42910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42910,1,3,0)
 ;;=3^Surg Aftercare,Oth Specified
 ;;^UTILITY(U,$J,358.3,42910,1,4,0)
 ;;=4^Z48.89
 ;;^UTILITY(U,$J,358.3,42910,2)
 ;;=^5063055
 ;;^UTILITY(U,$J,358.3,42911,0)
 ;;=Z48.03^^162^2049^9
 ;;^UTILITY(U,$J,358.3,42911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42911,1,3,0)
 ;;=3^Change/Removal of Drains
 ;;^UTILITY(U,$J,358.3,42911,1,4,0)
 ;;=4^Z48.03
 ;;^UTILITY(U,$J,358.3,42911,2)
 ;;=^5063036
 ;;^UTILITY(U,$J,358.3,42912,0)
 ;;=Z48.816^^162^2049^1
 ;;^UTILITY(U,$J,358.3,42912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42912,1,3,0)
 ;;=3^Aftercare Following GU System Surg
 ;;^UTILITY(U,$J,358.3,42912,1,4,0)
 ;;=4^Z48.816
 ;;^UTILITY(U,$J,358.3,42912,2)
 ;;=^5063053
 ;;^UTILITY(U,$J,358.3,42913,0)
 ;;=D29.1^^162^2050^4
 ;;^UTILITY(U,$J,358.3,42913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42913,1,3,0)
 ;;=3^Benign neoplasm of prostate
 ;;^UTILITY(U,$J,358.3,42913,1,4,0)
 ;;=4^D29.1
 ;;^UTILITY(U,$J,358.3,42913,2)
 ;;=^267657
