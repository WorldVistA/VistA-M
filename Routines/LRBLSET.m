LRBLSET ;AVAMC/REG - SET DD(65.091,.03 ;7/23/92  12:39
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ; If entries in MODIFIED/TO FROM FIELD then
 ; If disposition not modified or no disposition put a 1 in the
 ; ^DD(65.091,.03 field
 ; If unit is whole blood put a 2 in the 3rd piece of the zero subscript
 ; If divided unit put a 2 for each divided unit in 0;3
 ; Should be run during the post init process
 ; It does not do any harm to run this routine more than once.
EN ;
 Q
 Q:'$D(LRVR)!($G(^DD(65,0,"VR"))>5.14)
 D V^LRU F A=0:0 S A=$O(^LRD(65,A)) Q:'A  I $O(^LRD(65,A,9,0)) S B=$S($D(^LRD(65,A,4)):$P(^(4),"^"),1:1) D A
 D V^LRU Q
A I B'="MO" S P=1 D C Q
 I $S('$P($G(^LRD(65,A,0)),"^",4):1,'$D(^LAB(66,$P(^LRD(65,A,0),"^",4),0)):1,1:0) W !,"^LRD(65,",A,",entry corrupted or no entry in 4th piece of 0th subscript",!,"or no component entry in file 66 for unit" Q
 I $P(^LAB(66,$P(^LRD(65,A,0),"^",4),0),"^",26)=1 S P=2 D C Q
 K C S (E,G)=0 F C=0:0 S C=$O(^LRD(65,A,9,C)) Q:'C  S F=$P(^(C,0),"^",2),E=E+1,C(C)="" I "ABCDE"[$E(F,$L(F)) S C(C)=2
 S F=0 F C=0:0 S C=$O(C(C)) Q:'C  S F=F+1 D S
 S:G $P(^LRD(65,A,4),"^",4)="("_G_")" Q
S I F=E S $P(^LRD(65,A,9,C,0),"^",3)=2 Q
 I C(C) S $P(^LRD(65,A,9,C,0),"^",3)=2 Q
 S $P(^LRD(65,A,9,C,0),"^",3)=1,G=G+1 Q
 ;
 Q
C F C=0:0 S C=$O(^LRD(65,A,9,C)) Q:'C  S $P(^(C,0),"^",3)=P
 Q
