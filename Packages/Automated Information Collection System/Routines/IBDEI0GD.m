IBDEI0GD ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7088,0)
 ;;=K51.90^^58^465^9
 ;;^UTILITY(U,$J,358.3,7088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7088,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications
 ;;^UTILITY(U,$J,358.3,7088,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,7088,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,7089,0)
 ;;=K58.0^^58^465^5
 ;;^UTILITY(U,$J,358.3,7089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7089,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/ Diarrhea
 ;;^UTILITY(U,$J,358.3,7089,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,7089,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,7090,0)
 ;;=K58.9^^58^465^6
 ;;^UTILITY(U,$J,358.3,7090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7090,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,7090,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,7090,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,7091,0)
 ;;=K59.1^^58^465^2
 ;;^UTILITY(U,$J,358.3,7091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7091,1,3,0)
 ;;=3^Functional Diarrhea
 ;;^UTILITY(U,$J,358.3,7091,1,4,0)
 ;;=4^K59.1
 ;;^UTILITY(U,$J,358.3,7091,2)
 ;;=^270281
 ;;^UTILITY(U,$J,358.3,7092,0)
 ;;=K91.2^^58^465^7
 ;;^UTILITY(U,$J,358.3,7092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7092,1,3,0)
 ;;=3^Postsurgical Malabsorption NEC
 ;;^UTILITY(U,$J,358.3,7092,1,4,0)
 ;;=4^K91.2
 ;;^UTILITY(U,$J,358.3,7092,2)
 ;;=^5008901
 ;;^UTILITY(U,$J,358.3,7093,0)
 ;;=S06.2X1S^^58^466^3
 ;;^UTILITY(U,$J,358.3,7093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7093,1,3,0)
 ;;=3^Diffuse TBI w/ LOC of < 31 min,Sequela
 ;;^UTILITY(U,$J,358.3,7093,1,4,0)
 ;;=4^S06.2X1S
 ;;^UTILITY(U,$J,358.3,7093,2)
 ;;=^5020731
 ;;^UTILITY(U,$J,358.3,7094,0)
 ;;=S14.2XXD^^58^466^12
 ;;^UTILITY(U,$J,358.3,7094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7094,1,3,0)
 ;;=3^Nerve Root of Cervical Spine Inj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7094,1,4,0)
 ;;=4^S14.2XXD
 ;;^UTILITY(U,$J,358.3,7094,2)
 ;;=^5022203
 ;;^UTILITY(U,$J,358.3,7095,0)
 ;;=S16.1XXD^^58^466^11
 ;;^UTILITY(U,$J,358.3,7095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7095,1,3,0)
 ;;=3^Neck Muscle/Fascia/Tendon Strain,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7095,1,4,0)
 ;;=4^S16.1XXD
 ;;^UTILITY(U,$J,358.3,7095,2)
 ;;=^5022359
 ;;^UTILITY(U,$J,358.3,7096,0)
 ;;=S16.2XXD^^58^466^10
 ;;^UTILITY(U,$J,358.3,7096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7096,1,3,0)
 ;;=3^Neck Muscle/Fascia/Tendon Laceration,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7096,1,4,0)
 ;;=4^S16.2XXD
 ;;^UTILITY(U,$J,358.3,7096,2)
 ;;=^5022362
 ;;^UTILITY(U,$J,358.3,7097,0)
 ;;=S19.9XXD^^58^466^9
 ;;^UTILITY(U,$J,358.3,7097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7097,1,3,0)
 ;;=3^Neck Injury,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7097,1,4,0)
 ;;=4^S19.9XXD
 ;;^UTILITY(U,$J,358.3,7097,2)
 ;;=^5022401
 ;;^UTILITY(U,$J,358.3,7098,0)
 ;;=S29.092D^^58^466^18
 ;;^UTILITY(U,$J,358.3,7098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7098,1,3,0)
 ;;=3^Thorax Back Wall Muscle/Tendon Inj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7098,1,4,0)
 ;;=4^S29.092D
 ;;^UTILITY(U,$J,358.3,7098,2)
 ;;=^5023796
 ;;^UTILITY(U,$J,358.3,7099,0)
 ;;=S33.5XXA^^58^466^6
 ;;^UTILITY(U,$J,358.3,7099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7099,1,3,0)
 ;;=3^Lumbar Spine Ligament Sprain,Init Encntr
 ;;^UTILITY(U,$J,358.3,7099,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,7099,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,7100,0)
 ;;=S39.012D^^58^466^5
