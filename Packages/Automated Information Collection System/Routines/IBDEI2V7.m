IBDEI2V7 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45700,1,3,0)
 ;;=3^Anaphylactic Reaction,Fish,Sequela
 ;;^UTILITY(U,$J,358.3,45700,1,4,0)
 ;;=4^T78.03XS
 ;;^UTILITY(U,$J,358.3,45700,2)
 ;;=^5054256
 ;;^UTILITY(U,$J,358.3,45701,0)
 ;;=T78.06XA^^172^2277^16
 ;;^UTILITY(U,$J,358.3,45701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45701,1,3,0)
 ;;=3^Anaphylactic Reaction,Food Additives,1st Encntr
 ;;^UTILITY(U,$J,358.3,45701,1,4,0)
 ;;=4^T78.06XA
 ;;^UTILITY(U,$J,358.3,45701,2)
 ;;=^5054263
 ;;^UTILITY(U,$J,358.3,45702,0)
 ;;=T78.06XD^^172^2277^18
 ;;^UTILITY(U,$J,358.3,45702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45702,1,3,0)
 ;;=3^Anaphylactic Reaction,Food Additives,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,45702,1,4,0)
 ;;=4^T78.06XD
 ;;^UTILITY(U,$J,358.3,45702,2)
 ;;=^5054264
 ;;^UTILITY(U,$J,358.3,45703,0)
 ;;=T78.06XS^^172^2277^17
 ;;^UTILITY(U,$J,358.3,45703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45703,1,3,0)
 ;;=3^Anaphylactic Reaction,Food Additives,Sequela
 ;;^UTILITY(U,$J,358.3,45703,1,4,0)
 ;;=4^T78.06XS
 ;;^UTILITY(U,$J,358.3,45703,2)
 ;;=^5054265
 ;;^UTILITY(U,$J,358.3,45704,0)
 ;;=T78.07XA^^172^2277^22
 ;;^UTILITY(U,$J,358.3,45704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45704,1,3,0)
 ;;=3^Anaphylactic Reaction,Milk Products,1st Encntr
 ;;^UTILITY(U,$J,358.3,45704,1,4,0)
 ;;=4^T78.07XA
 ;;^UTILITY(U,$J,358.3,45704,2)
 ;;=^5054266
 ;;^UTILITY(U,$J,358.3,45705,0)
 ;;=T78.07XD^^172^2277^24
 ;;^UTILITY(U,$J,358.3,45705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45705,1,3,0)
 ;;=3^Anaphylactic Reaction,Milk Products,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,45705,1,4,0)
 ;;=4^T78.07XD
 ;;^UTILITY(U,$J,358.3,45705,2)
 ;;=^5054267
 ;;^UTILITY(U,$J,358.3,45706,0)
 ;;=T78.07XS^^172^2277^23
 ;;^UTILITY(U,$J,358.3,45706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45706,1,3,0)
 ;;=3^Anaphylactic Reaction,Milk Products,Sequela
 ;;^UTILITY(U,$J,358.3,45706,1,4,0)
 ;;=4^T78.07XS
 ;;^UTILITY(U,$J,358.3,45706,2)
 ;;=^5054268
 ;;^UTILITY(U,$J,358.3,45707,0)
 ;;=T78.08XA^^172^2277^10
 ;;^UTILITY(U,$J,358.3,45707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45707,1,3,0)
 ;;=3^Anaphylactic Reaction,Eggs,1st Encntr
 ;;^UTILITY(U,$J,358.3,45707,1,4,0)
 ;;=4^T78.08XA
 ;;^UTILITY(U,$J,358.3,45707,2)
 ;;=^5054269
 ;;^UTILITY(U,$J,358.3,45708,0)
 ;;=T78.08XD^^172^2277^12
 ;;^UTILITY(U,$J,358.3,45708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45708,1,3,0)
 ;;=3^Anaphylactic Reaction,Eggs,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,45708,1,4,0)
 ;;=4^T78.08XD
 ;;^UTILITY(U,$J,358.3,45708,2)
 ;;=^5054270
 ;;^UTILITY(U,$J,358.3,45709,0)
 ;;=T78.08XS^^172^2277^11
 ;;^UTILITY(U,$J,358.3,45709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45709,1,3,0)
 ;;=3^Anaphylactic Reaction,Eggs,Sequela
 ;;^UTILITY(U,$J,358.3,45709,1,4,0)
 ;;=4^T78.08XS
 ;;^UTILITY(U,$J,358.3,45709,2)
 ;;=^5054271
 ;;^UTILITY(U,$J,358.3,45710,0)
 ;;=T78.09XA^^172^2277^28
 ;;^UTILITY(U,$J,358.3,45710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45710,1,3,0)
 ;;=3^Anaphylactic Reaction,Oth Food Products,1st Encntr
 ;;^UTILITY(U,$J,358.3,45710,1,4,0)
 ;;=4^T78.09XA
 ;;^UTILITY(U,$J,358.3,45710,2)
 ;;=^5054272
 ;;^UTILITY(U,$J,358.3,45711,0)
 ;;=T78.09XD^^172^2277^29
 ;;^UTILITY(U,$J,358.3,45711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45711,1,3,0)
 ;;=3^Anaphylactic Reaction,Oth Food Products,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,45711,1,4,0)
 ;;=4^T78.09XD
 ;;^UTILITY(U,$J,358.3,45711,2)
 ;;=^5054273
