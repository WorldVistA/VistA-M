IBDEI0TU ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13283,1,3,0)
 ;;=3^Pancreatitis w/ Necrosis,Acute
 ;;^UTILITY(U,$J,358.3,13283,1,4,0)
 ;;=4^K85.91
 ;;^UTILITY(U,$J,358.3,13283,2)
 ;;=^5138762
 ;;^UTILITY(U,$J,358.3,13284,0)
 ;;=K86.1^^83^808^71
 ;;^UTILITY(U,$J,358.3,13284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13284,1,3,0)
 ;;=3^Pancreatitis,Chronic
 ;;^UTILITY(U,$J,358.3,13284,1,4,0)
 ;;=4^K86.1
 ;;^UTILITY(U,$J,358.3,13284,2)
 ;;=^5008889
 ;;^UTILITY(U,$J,358.3,13285,0)
 ;;=D55.9^^83^809^1
 ;;^UTILITY(U,$J,358.3,13285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13285,1,3,0)
 ;;=3^Anemia d/t Enzyme Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13285,1,4,0)
 ;;=4^D55.9
 ;;^UTILITY(U,$J,358.3,13285,2)
 ;;=^5002304
 ;;^UTILITY(U,$J,358.3,13286,0)
 ;;=D63.1^^83^809^3
 ;;^UTILITY(U,$J,358.3,13286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13286,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,13286,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,13286,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,13287,0)
 ;;=D63.0^^83^809^4
 ;;^UTILITY(U,$J,358.3,13287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13287,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,13287,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,13287,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,13288,0)
 ;;=D63.8^^83^809^2
 ;;^UTILITY(U,$J,358.3,13288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13288,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,13288,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,13288,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,13289,0)
 ;;=D59.9^^83^809^5
 ;;^UTILITY(U,$J,358.3,13289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13289,1,3,0)
 ;;=3^Anemia,Acquired Hemolytic,Unspec
 ;;^UTILITY(U,$J,358.3,13289,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,13289,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,13290,0)
 ;;=D62.^^83^809^6
 ;;^UTILITY(U,$J,358.3,13290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13290,1,3,0)
 ;;=3^Anemia,Acute Posthemorrhagic
 ;;^UTILITY(U,$J,358.3,13290,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,13290,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,13291,0)
 ;;=D61.9^^83^809^7
 ;;^UTILITY(U,$J,358.3,13291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13291,1,3,0)
 ;;=3^Anemia,Aplastic,Unspec
 ;;^UTILITY(U,$J,358.3,13291,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,13291,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,13292,0)
 ;;=D52.9^^83^809^8
 ;;^UTILITY(U,$J,358.3,13292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13292,1,3,0)
 ;;=3^Anemia,Folate Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,13292,1,4,0)
 ;;=4^D52.9
 ;;^UTILITY(U,$J,358.3,13292,2)
 ;;=^5002293
 ;;^UTILITY(U,$J,358.3,13293,0)
 ;;=D58.9^^83^809^9
 ;;^UTILITY(U,$J,358.3,13293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13293,1,3,0)
 ;;=3^Anemia,Herediatary Hemolytic,Unspec
 ;;^UTILITY(U,$J,358.3,13293,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,13293,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,13294,0)
 ;;=D50.0^^83^809^10
 ;;^UTILITY(U,$J,358.3,13294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13294,1,3,0)
 ;;=3^Anemia,Iron Deficiency,Secondary to Blood Loss
 ;;^UTILITY(U,$J,358.3,13294,1,4,0)
 ;;=4^D50.0
 ;;^UTILITY(U,$J,358.3,13294,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,13295,0)
 ;;=D50.9^^83^809^11
 ;;^UTILITY(U,$J,358.3,13295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13295,1,3,0)
 ;;=3^Anemia,Iron Deficiency,Unspec
