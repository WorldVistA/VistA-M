PRC0B1 ;WISC/PLT-UTILITY ; 06/30/94  12:40 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ; invalid entry
 ;
 ;prca=~1 file number;file root;file record id;field # of multiple for adding
 ;     ~2 subfile number;subfile root;subfile RI;field # of multiple for adding
 ;     ~3 ...
 ;.x = .01 value or array of dic and X("DR") to input for other fields
 ;.y = value returned; -1 no new entry added, ^1=ri,^2=.01 value,^3=1 for new if added
ADD(X,Y,PRCA,DINUM) ;add new entry
 N DD,DO,DIC,%,D0,DA,DI,DIE,DLAYGO,DQ,DR,A,B,C,I
 S:PRCA'?.E1"~" PRCA=PRCA_"~" S A=$L(PRCA,"~")-1
 I A>1 F B=1:1:A-1 S C=$P(PRCA,"~",B),DA(A-B)=$P(C,";",3) S:$P(C,";",4)]"" DIC("P")=$$DICP^PRC0B1(+C,$P(C,";",4))
 S B=$P(PRCA,"~",A),DIC=$P(B,";",2)  S:DIC=""&(A=1) DIC=+B
 S DLAYGO=PRCA,DIC(0)="FIL"
 S:$D(X(0)) DIC(0)=X(0) S:$D(X("DR")) DIC("DR")=X("DR") K X(0),X("DR")
 D FILE^DICN
 QUIT
 ;
 ;prca = ~1 file number(option);file root;file record id
 ;       ~2 subfile number(option);subfile root;subfile RI
 ;       ~...
 ;.x = value return; 1 if deleted, 0 if not, -2 if lock fail
DELETE(X,PRCA) ;delete entry
 N %,DA,DIC,Y
 N DIK,DIA,PRCLOCK,A,B,C
 S:PRCA'?.E1"~" PRCA=PRCA_"~" S A=$L(PRCA,"~")-1,PRCLOCK=""
 I A>1 F B=1:1:A-1 S C=$P(PRCA,"~",B),DA(A-B)=$P(C,";",3)
 S B=$P(PRCA,"~",A),DIK=$P(B,";",2),DA=$P(B,";",3),PRCLOCK=DIK_DA_","
 S X=3 D ICLOCK^PRC0B(PRCLOCK,.X) I 'X S X=-2 QUIT
 D ^DIK,DCLOCK^PRC0B(PRCLOCK)
 S X=1
 QUIT
 ;
 ;A=global root (including cross reference) ending with ','
 ;B=start value
FIRST(A,B) ;$O-first node after B-value
 N C
 S @("C=$O("_A_"B))")
 QUIT C
 ;
DICP(A,B) ;EF value=2nd piece of 0-node of the multiple field's dd entry
 QUIT $S(A&B:$P($G(^DD(A,B,0)),"^",2),1:"")
 ;
 ;
DICGL(A) ;EF value=global root ending with ',' for file # A.
 QUIT $G(^DIC(A,0,"GL"))
 ;
