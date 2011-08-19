LRBLY ;AVAMC/REG - STUFF DATA IN LAB LETTERS ;2/20/89  16:15 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
I S A=$P(X,"[",2) Q:'+A  S X(1)=$P(X,"["),X(2)=$P(X,"]",2,99) D R G I
 ;
R S A=$P(A,"]"),A=$S($D(@("^TMP("_"""LRBLY"""_","_A_")")):@("^TMP("_"""LRBLY"""_","_A_")"),1:"") S X=X(1)_A_X(2) Q
EN ;
 I '$D(^LRO(69.2,LRAA,8,65.9,1,LRQ,0)) S ^(0)=LRP,^LRO(69.2,LRAA,8,65.9,1,"B",LRP,LRQ)="" L +^LRO(69.2,LRAA,8,65.9,1,0) S X=^LRO(69.2,LRAA,8,65.9,1,0),^(0)=$P(X,"^",1,2)_"^"_LRQ_"^"_($P(X,"^",4)+1) L -^LRO(69.2,LRAA,8,65.9,1,0)
 Q
EN1 ;
 S:'$D(^LRO(69.2,LRAA,8,0)) ^(0)="^69.31A^^" I '$D(^(65.9,0)) S ^(0)=65.9 L +^LRO(69.2,LRAA,8,0) S X=^LRO(69.2,LRAA,8,0),^(0)=$P(X,"^",1,2)_"^"_65.9_"^"_($P(X,"^",4)+1) L -^LRO(69.2,LRAA,8,0)
 S:'$D(^LRO(69.2,LRAA,8,65.9,1,0)) ^(0)="^69.32A^^" Q
