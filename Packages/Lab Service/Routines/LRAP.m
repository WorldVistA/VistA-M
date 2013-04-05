LRAP ;DALOI/STAFF - ANATOMIC PATH UTILITY ;Oct 8, 2008
 ;;5.2;LAB SERVICE;**72,248,259,350**;Sep 27, 1994;Build 230
 ;
 ; Called by many routines in AP package
 D END,CK G:Y=-1 END D LRDICS G:Y B
 S DIC=68,DIC(0)="AEOQMZ"
 S DIC("A")="Select ANATOMIC PATHOLOGY SECTION: "
 S DIC("S")="I LRDICS[$P(^(0),U,2),$P(^(0),U,2)]"""",$G(^(3,DUZ(2),0))"
 D ^DIC
 K DIC,LRDICS
 G:Y<1 END
 ;
B ;
 S X=$P(Y,U,2) D ^LRUTL G:Y=-1 END
 Q
 ;
 ;
AU ; log-in autopsy
 Q  ;see routine LRAUAW
 ;
 ;
CY ; log-in cytopath
 S (LRMD,LRSIT)=""
 ;
 D GETDEF
 ;
 S DR=".08///"_$S(LRLLOC["?":"UNKNOWN",1:LRLLOC)
 S DR=DR_";.07;D:X P^LRUA;.011//^S X=LRPRAC(1);.012;.1//NOW"
 S DR=DR_";S LRRC=X;.02;.99;S LRC(5)=X;1"
 S DR(2,63.902)=".01;S LR(63.902)=X;.06R//^S X=LRSPTOP(0);S:X LRSPTOP=X,LRSPTOP(0)=$P(^LAB(61,LRSPTOP,0),U)"
 S DR(2,63.902)=DR(2,63.902)_";.07R//^S X=LRSAMP(0);S:X LRSAMP=X,LRSAMP(0)=$P(^LAB(62,LRSAMP,0),U);S:'LRCAPA Y=""@2"";.02;@2"
 Q
 ;
 ;
EM ; log-in electron microscopy
 S (LRMD,LRSIT)=""
 ;
 D GETDEF
 ;
 S DR=".08///"_$S(LRLLOC["?":"UNKNOWN",1:LRLLOC)
 S DR=DR_";.07;D:X P^LRUA;.011//^S X=LRPRAC(1);.012;.1//NOW;S LRRC=X"
 S DR=DR_";.02;.021;.99;S LRC(5)=X"
 S DR(2,63.202)=".01;.06R//^S X=LRSPTOP(0);S:X LRSPTOP=X,LRSPTOP(0)=$P(^LAB(61,LRSPTOP,0),U)"
 S DR(2,63.202)=DR(2,63.202)_";.07R//^S X=LRSAMP(0);S:X LRSAMP=X,LRSAMP(0)=$P(^LAB(62,LRSAMP,0),U)"
 Q
 ;
 ;
SP ; log-in surg path
 S (LRMD,LRSIT)=""
 S LR("FS")=+$G(^LAB(69.9,1,11))
 ;
 D GETDEF
 ;
 S DR=".08///"_$S(LRLLOC["?":"UNKNOWN",1:LRLLOC)
 S DR=DR_";.07//^S X=LR(.07);D:X P^LRUA;.011//^S X=LRPRAC(1);.012;.1//NOW"
 S DR=DR_";S LRRC=X;.02;.99;S LRC(5)=X;S:'LR(""FS"") Y=""@1"";1.3;@1"
 S DR(2,63.812)=".01;.06R//^S X=LRSPTOP(0);S:X LRSPTOP=X,LRSPTOP(0)=$P(^LAB(61,LRSPTOP,0),U)"
 S DR(2,63.812)=DR(2,63.812)_";.07R//^S X=LRSAMP(0);S:X LRSAMP=X,LRSAMP(0)=$P(^LAB(62,LRSAMP,0),U)"
 ;
 S:LRABV'["SP" LR("FS")=""
 Q
 ;
 ;
M ; edit path report parameters
 W !
 S DIC="^LRO(69.2,",DIC(0)="AEOQM"
 S DIC("S")="I ""AUCYEMSP""[$P(^(0),U,2)&($P(^(0),U,2)]"""")"
 D ^DIC K DIC G:Y<1 END S DA=+Y
 L +^LRO(69.2,DA):5 I '$T D  G M
 . S MSG="This entry is locked by another user.  Please try again later."
 . D EN^DDIOL(MSG,"","!!") K MSG,DIE,DR,DA
 . D END
 S DR="[LRAPHDR]",DIE="^LRO(69.2,"
 D ^DIE
 L -^LRO(69.2,DA)
 K DIE,DR,DA
 G M
 ;
 ;
D ; Edit path descriptions
 W ! S DIC="^LAB(62.5,",DIC(0)="AEQLM"
 S DLAYGO=62.5,DIC("S")="I ""ESCI""[$P(^(0),U,4)"
 D ^DIC K DIC,DLAYGO G:X=""!(X[U) END S DA=+Y
 S DIE("NO^")="",DIE="^LAB(62.5,"
 L +^LAB(62.5,DA):5 I '$T D  G D
 . S MSG="This entry is locked by another user.  Please try again later."
 . D EN^DDIOL(MSG,"","!!") K MSG,DIE,DR,DA
 . D END
 S DR=".01;1;5;I ""ESCI""'[X W $C(7),!,""Enter E, S, C, or I"" S Y=5;10"
 D ^DIE
 L -^LAB(62.5,DA)
 K DIE,DR,DA
 G D
 ;
 ;
V ; input transform DD(63.08,.11,0)
 I $D(LRH(2)),LRH(2)'=$E(X,1,3) K X W !,"Year received must be same as log-in year (",LRH(2)+1700,") "
 Q
 ;
 ;
CK ;
 S Y=1
 I '$D(DUZ(2)) D  Q
 . W !,$C(7)," Something is wrong..."
 . W !!,"I can't tell if you're really here..."
 . W !!,"Ask your IRM why you don't have a DUZ(2) variable defined!",!
 . S Y=-1
 ;
 S LRAA(4)=$P($G(^DIC(4,+DUZ(2),0)),U)
 I LRAA(4)="" D  Q
 . W $C(7),!!,"I can't tell what DIVISION you are from.  Contact your IRM "
 . S Y=-1
 Q
 ;
 ;
LRDICS ;
 S Y=0,X=$G(LRDICS)
 I $L(X)=2,"SPCYEMAU"[X D C I Y K LRDICS Q
 S LRDICS=$S($L($G(LRDICS)):LRDICS,1:"SPCYEMAU")
 Q
 ;
 ;
C ;
 I $D(LRDICS(2)) G CC
 S (A,B)=0
 F  S A=$O(^LRO(68,A)) Q:'A  I $P($G(^LRO(68,A,0)),"^",2)=LRDICS,$G(^(3,DUZ(2),0)) S B=B+1,B(B)=A
 I B=1 S Y=B(1)_U_$P(^LRO(68,B(1),0),U) K A,B Q
 I B>1,$D(LRDICS(1)) S Y=B(1)_U_$P(^LRO(68,B(1),0),U) K A,B
 Q
 ;
 ;
CC ;
 S (A,B)=0
 F  S A=$O(^LRO(68,A)) Q:'A  I $P($G(^LRO(68,A,0)),"^",2)=LRDICS S B=B+1,B(B)=A Q
 I B=1 S Y=B(1)_U_$P(^LRO(68,B(1),0),U) K A,B
 Q
 ;
 ;
END ;
 D V^LRU
 Q
 ;
 ;
GETDEF ; Get defaults for specimen login
 ;
 ; Default values for collection sample/specimen and lab test
 ;
 N X
 ;
 ; Default value for collection sample
 S X=$$GET^XPAR("USR^DIV^PKG","LR ACCESSION DEFAULT COL SAMP","`"_LRAA,"B")
 S LRSAMP=$P(X,"^"),LRSAMP(0)=$P(X,"^",2)
 ;
 ; Default value for specimen(topography)
 S X=$$GET^XPAR("USR^DIV^PKG","LR ACCESSION DEFAULT SPECIMEN","`"_LRAA,"B")
 S LRSPTOP=$P(X,"^"),LRSPTOP(0)=$P(X,"^",2)
 ;
 ; Default value for laboratory test
 S X=$$GET^XPAR("USR^DIV^PKG","LR ACCESSION DEFAULT LAB TEST","`"_LRAA,"B")
 S LRTST=$P(X,"^"),LRTST(0)=$P(X,"^",2)
 ;
 Q
