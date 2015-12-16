IBDEI20X ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35376,1,3,0)
 ;;=3^Slurred speech
 ;;^UTILITY(U,$J,358.3,35376,1,4,0)
 ;;=4^R47.81
 ;;^UTILITY(U,$J,358.3,35376,2)
 ;;=^5019491
 ;;^UTILITY(U,$J,358.3,35377,0)
 ;;=R48.9^^186^2036^13
 ;;^UTILITY(U,$J,358.3,35377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35377,1,3,0)
 ;;=3^Symbolic Dysfunctions,Unspec
 ;;^UTILITY(U,$J,358.3,35377,1,4,0)
 ;;=4^R48.9
 ;;^UTILITY(U,$J,358.3,35377,2)
 ;;=^5019500
 ;;^UTILITY(U,$J,358.3,35378,0)
 ;;=Z90.02^^186^2037^1
 ;;^UTILITY(U,$J,358.3,35378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35378,1,3,0)
 ;;=3^Acquired absence of larynx
 ;;^UTILITY(U,$J,358.3,35378,1,4,0)
 ;;=4^Z90.02
 ;;^UTILITY(U,$J,358.3,35378,2)
 ;;=^5063579
 ;;^UTILITY(U,$J,358.3,35379,0)
 ;;=Z90.09^^186^2037^2
 ;;^UTILITY(U,$J,358.3,35379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35379,1,3,0)
 ;;=3^Acquired absence of other part of head and neck
 ;;^UTILITY(U,$J,358.3,35379,1,4,0)
 ;;=4^Z90.09
 ;;^UTILITY(U,$J,358.3,35379,2)
 ;;=^5063580
 ;;^UTILITY(U,$J,358.3,35380,0)
 ;;=Z45.328^^186^2037^3
 ;;^UTILITY(U,$J,358.3,35380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35380,1,3,0)
 ;;=3^Adjust and management of implanted hear dev
 ;;^UTILITY(U,$J,358.3,35380,1,4,0)
 ;;=4^Z45.328
 ;;^UTILITY(U,$J,358.3,35380,2)
 ;;=^5063003
 ;;^UTILITY(U,$J,358.3,35381,0)
 ;;=Z45.49^^186^2037^4
 ;;^UTILITY(U,$J,358.3,35381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35381,1,3,0)
 ;;=3^Adjust and mgmt of implanted nervous sys device
 ;;^UTILITY(U,$J,358.3,35381,1,4,0)
 ;;=4^Z45.49
 ;;^UTILITY(U,$J,358.3,35381,2)
 ;;=^5063006
 ;;^UTILITY(U,$J,358.3,35382,0)
 ;;=Z43.3^^186^2037^5
 ;;^UTILITY(U,$J,358.3,35382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35382,1,3,0)
 ;;=3^Attention to colostomy
 ;;^UTILITY(U,$J,358.3,35382,1,4,0)
 ;;=4^Z43.3
 ;;^UTILITY(U,$J,358.3,35382,2)
 ;;=^5062961
 ;;^UTILITY(U,$J,358.3,35383,0)
 ;;=Z43.0^^186^2037^6
 ;;^UTILITY(U,$J,358.3,35383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35383,1,3,0)
 ;;=3^Attention to tracheostomy
 ;;^UTILITY(U,$J,358.3,35383,1,4,0)
 ;;=4^Z43.0
 ;;^UTILITY(U,$J,358.3,35383,2)
 ;;=^5062958
 ;;^UTILITY(U,$J,358.3,35384,0)
 ;;=Z02.71^^186^2037^7
 ;;^UTILITY(U,$J,358.3,35384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35384,1,3,0)
 ;;=3^Disability determination
 ;;^UTILITY(U,$J,358.3,35384,1,4,0)
 ;;=4^Z02.71
 ;;^UTILITY(U,$J,358.3,35384,2)
 ;;=^5062640
 ;;^UTILITY(U,$J,358.3,35385,0)
 ;;=Z04.8^^186^2037^8
 ;;^UTILITY(U,$J,358.3,35385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35385,1,3,0)
 ;;=3^Exam and observation for oth reasons
 ;;^UTILITY(U,$J,358.3,35385,1,4,0)
 ;;=4^Z04.8
 ;;^UTILITY(U,$J,358.3,35385,2)
 ;;=^5062665
 ;;^UTILITY(U,$J,358.3,35386,0)
 ;;=Z02.0^^186^2037^9
 ;;^UTILITY(U,$J,358.3,35386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35386,1,3,0)
 ;;=3^Exam for admission to educational institution
 ;;^UTILITY(U,$J,358.3,35386,1,4,0)
 ;;=4^Z02.0
 ;;^UTILITY(U,$J,358.3,35386,2)
 ;;=^5062633
 ;;^UTILITY(U,$J,358.3,35387,0)
 ;;=Z02.2^^186^2037^10
 ;;^UTILITY(U,$J,358.3,35387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35387,1,3,0)
 ;;=3^Exam for admission to residential institution
 ;;^UTILITY(U,$J,358.3,35387,1,4,0)
 ;;=4^Z02.2
 ;;^UTILITY(U,$J,358.3,35387,2)
 ;;=^5062635
 ;;^UTILITY(U,$J,358.3,35388,0)
 ;;=Z02.4^^186^2037^11
 ;;^UTILITY(U,$J,358.3,35388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35388,1,3,0)
 ;;=3^Exam for driving license
 ;;^UTILITY(U,$J,358.3,35388,1,4,0)
 ;;=4^Z02.4
 ;;^UTILITY(U,$J,358.3,35388,2)
 ;;=^5062637
 ;;^UTILITY(U,$J,358.3,35389,0)
 ;;=Z02.6^^186^2037^12
 ;;^UTILITY(U,$J,358.3,35389,1,0)
 ;;=^358.31IA^4^2
