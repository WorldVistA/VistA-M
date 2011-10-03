PRS8VW1 ;HISC/MRL-DECOMPOSITION, VIEW RESULTS, CONT. ;01/23/07
 ;;4.0;PAID;**6,35,45,69,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is used to view the results of the decomposition.
 ;It is a continuation of routine ^PRS8VW.
 ;
 ;See routine PRS8VW2 at label TYP for type of time
 ;text displayed from this routine.
 ;
 ;Called by Routines:  PRS8VW1
 ;
 S CHECK=0
 ;
EN ; --- entry point from PRS8CK1
 S E=E(1),W="Wk-1",LOC=1 D SHOW
 S E=E(2),W="Wk-2",LOC=2 D SHOW
 S E=E(3),W="Misc",LOC=0 D SHOW
 I 'CHECK,"C"'[$E(IOST) D
 .W !,DASH1
 .W !,TR
 K %,CHECK,D,E,I,L,LOC,USED,W,X,Y Q
 ;
SHOW ; --- show information
 F I=1:2 S X=$E(E,I,I+1) Q:X=""  D
 .I $D(USED(X)) Q
 .S USED(X)=""
 .S X(1)=$F(OLD,X),X(2)=$F(NEW,X) ; try to find time code in TT8B
 .I 'CHECK,'X(1),'X(2) Q  ;not in either string
 .I CHECK S LOC(1)=(I\2+1) S:'LOC LOC(1)=LOC(1)+50 D
 ..S FOUND(LOC(1))=$G(FOUND(LOC(1)))
 ..S $P(FOUND(LOC(1)),"^",$S(LOC<2:1,1:4))=X
 .S Y=$P($T(@($E(X)_"^PRS8VW2")),";;",2)
 .S Y(1)=$F(Y,$E(X,2)_":")
 .S Y=$P($E(Y,Y(1),999),":",1,2)
 .I 'CHECK W !,W,?10,$P($T(TYP+Y^PRS8VW2),";;",2),?45,X
 .S X=X(1),X1=52 D CON
 .S X=X(2),X1=67 D CON
 Q
 ;
CON ; --- convert to proper format
 I '+X S X=$E("00000000000",1,+$P(Y,":",2))
 I X,X1=52 S (X,Z)=$E(OLD,X(1),X(1)+$P(Y,":",2)-1)
 I X,X1=67 S:'$D(Z) Z="" S X=$E(NEW,X(2),X(2)+$P(Y,":",2)-1)
 I 'CHECK W ?X1,$J(X,9) D  Q
 .I OLD=""!(NEW="") Q
 .I X1=67,Z'="",X'=Z W " *"
 S LOC(2)=$S(X1=52:2,1:3) I LOC=2 S LOC(2)=LOC(2)+3
 S $P(FOUND(LOC(1)),"^",LOC(2))=X
 Q:X1'=67
 I $P(FOUND(LOC(1)),"^",1)="CD" Q
 S S=0,X=FOUND(LOC(1))
 I +$P(X,"^",2)!(+$P(X,"^",3)) S S=1
 I 'S,LOC,+$P(X,"^",5)!(+$P(X,"^",6)) S S=1
 I 'S,LOC'=1 K FOUND(LOC(1))
 Q
