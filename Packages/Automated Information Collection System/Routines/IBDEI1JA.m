IBDEI1JA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26030,0)
 ;;=F63.3^^98^1221^8
 ;;^UTILITY(U,$J,358.3,26030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26030,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,26030,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,26030,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,26031,0)
 ;;=L98.1^^98^1221^2
 ;;^UTILITY(U,$J,358.3,26031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26031,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,26031,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,26031,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,26032,0)
 ;;=F68.10^^98^1221^3
 ;;^UTILITY(U,$J,358.3,26032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26032,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,26032,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,26032,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,26033,0)
 ;;=F63.9^^98^1221^5
 ;;^UTILITY(U,$J,358.3,26033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26033,1,3,0)
 ;;=3^Impulse Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26033,1,4,0)
 ;;=4^F63.9
 ;;^UTILITY(U,$J,358.3,26033,2)
 ;;=^5003646
 ;;^UTILITY(U,$J,358.3,26034,0)
 ;;=F42.^^98^1221^4
 ;;^UTILITY(U,$J,358.3,26034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26034,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,26034,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,26034,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,26035,0)
 ;;=F06.8^^98^1221^6
 ;;^UTILITY(U,$J,358.3,26035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26035,1,3,0)
 ;;=3^Obsessive-Compulsive & Related Disorder d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,26035,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,26035,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,26036,0)
 ;;=F06.2^^98^1222^5
 ;;^UTILITY(U,$J,358.3,26036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26036,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26036,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,26036,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,26037,0)
 ;;=F06.0^^98^1222^6
 ;;^UTILITY(U,$J,358.3,26037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26037,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26037,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,26037,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,26038,0)
 ;;=F06.4^^98^1222^1
 ;;^UTILITY(U,$J,358.3,26038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26038,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26038,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,26038,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,26039,0)
 ;;=F06.1^^98^1222^2
 ;;^UTILITY(U,$J,358.3,26039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26039,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,26039,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,26039,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,26040,0)
 ;;=R41.9^^98^1222^3
 ;;^UTILITY(U,$J,358.3,26040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26040,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26040,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,26040,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,26041,0)
 ;;=F29.^^98^1222^7
 ;;^UTILITY(U,$J,358.3,26041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26041,1,3,0)
 ;;=3^Schizophrenia Spectrum/Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26041,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,26041,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,26042,0)
 ;;=F07.0^^98^1222^4
 ;;^UTILITY(U,$J,358.3,26042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26042,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26042,1,4,0)
 ;;=4^F07.0
