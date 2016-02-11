IBDEI0B5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4728,1,3,0)
 ;;=3^Nontraumatic Subdural Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,4728,1,4,0)
 ;;=4^I62.00
 ;;^UTILITY(U,$J,358.3,4728,2)
 ;;=^5007289
 ;;^UTILITY(U,$J,358.3,4729,0)
 ;;=C79.31^^37^315^12
 ;;^UTILITY(U,$J,358.3,4729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4729,1,3,0)
 ;;=3^Mets Malig Neop of Brain
 ;;^UTILITY(U,$J,358.3,4729,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,4729,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,4730,0)
 ;;=R40.0^^37^315^18
 ;;^UTILITY(U,$J,358.3,4730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4730,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,4730,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,4730,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,4731,0)
 ;;=R40.1^^37^315^19
 ;;^UTILITY(U,$J,358.3,4731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4731,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,4731,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,4731,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,4732,0)
 ;;=A04.7^^37^316^7
 ;;^UTILITY(U,$J,358.3,4732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4732,1,3,0)
 ;;=3^Enterocolitis d/t Clostridium Difficile
 ;;^UTILITY(U,$J,358.3,4732,1,4,0)
 ;;=4^A04.7
 ;;^UTILITY(U,$J,358.3,4732,2)
 ;;=^5000029
 ;;^UTILITY(U,$J,358.3,4733,0)
 ;;=K92.2^^37^316^9
 ;;^UTILITY(U,$J,358.3,4733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4733,1,3,0)
 ;;=3^Gastrointestinal Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,4733,1,4,0)
 ;;=4^K92.2
 ;;^UTILITY(U,$J,358.3,4733,2)
 ;;=^5008915
 ;;^UTILITY(U,$J,358.3,4734,0)
 ;;=K57.31^^37^316^6
 ;;^UTILITY(U,$J,358.3,4734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4734,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/ Bleeding
 ;;^UTILITY(U,$J,358.3,4734,1,4,0)
 ;;=4^K57.31
 ;;^UTILITY(U,$J,358.3,4734,2)
 ;;=^5008724
 ;;^UTILITY(U,$J,358.3,4735,0)
 ;;=K92.1^^37^316^20
 ;;^UTILITY(U,$J,358.3,4735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4735,1,3,0)
 ;;=3^Melena
 ;;^UTILITY(U,$J,358.3,4735,1,4,0)
 ;;=4^K92.1
 ;;^UTILITY(U,$J,358.3,4735,2)
 ;;=^5008914
 ;;^UTILITY(U,$J,358.3,4736,0)
 ;;=K92.0^^37^316^10
 ;;^UTILITY(U,$J,358.3,4736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4736,1,3,0)
 ;;=3^Hematemesis
 ;;^UTILITY(U,$J,358.3,4736,1,4,0)
 ;;=4^K92.0
 ;;^UTILITY(U,$J,358.3,4736,2)
 ;;=^5008913
 ;;^UTILITY(U,$J,358.3,4737,0)
 ;;=K25.4^^37^316^8
 ;;^UTILITY(U,$J,358.3,4737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4737,1,3,0)
 ;;=3^Gastric Ulcer w/ Hemorrhage,Chronic
 ;;^UTILITY(U,$J,358.3,4737,1,4,0)
 ;;=4^K25.4
 ;;^UTILITY(U,$J,358.3,4737,2)
 ;;=^270076
 ;;^UTILITY(U,$J,358.3,4738,0)
 ;;=K43.2^^37^316^11
 ;;^UTILITY(U,$J,358.3,4738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4738,1,3,0)
 ;;=3^Incisional Hernia w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,4738,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,4738,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,4739,0)
 ;;=K57.32^^37^316^5
 ;;^UTILITY(U,$J,358.3,4739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4739,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,4739,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,4739,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,4740,0)
 ;;=K56.5^^37^316^12
 ;;^UTILITY(U,$J,358.3,4740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4740,1,3,0)
 ;;=3^Intestinal Adhesions w/ Obstruction
 ;;^UTILITY(U,$J,358.3,4740,1,4,0)
 ;;=4^K56.5
 ;;^UTILITY(U,$J,358.3,4740,2)
 ;;=^5008712
 ;;^UTILITY(U,$J,358.3,4741,0)
 ;;=E44.0^^37^316^21
 ;;^UTILITY(U,$J,358.3,4741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4741,1,3,0)
 ;;=3^Moderate Protein-Calorie Malnutrition
 ;;^UTILITY(U,$J,358.3,4741,1,4,0)
 ;;=4^E44.0
