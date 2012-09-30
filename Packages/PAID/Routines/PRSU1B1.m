PRSU1B1 ;WOIFO/PLT-UTILITY ; 24-Aug-2005 10:34 AM
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT  ; invalid entry
 ;
 ;prsa=~1 file number (required);file root;file record id;field # of multiple for adding
 ;     ~2 subfile number;subfile root (required);subfile RI;field # of multiple for adding
 ;     ~3 ...
 ;.x = .01 internal value or array of dic and X("DR") to input for other fields
 ;.y = value returned; -1 no new entry added, ^1=ri,^2=.01 value,^3=1 for new if added
ADD(X,Y,PRSA,DINUM) ;add new entry
 N DD,DO,DIC,%,D0,DA,DI,DIE,DLAYGO,DQ,DR,A,B,C,I
 K:$G(DINUM)="" DINUM
 S:PRSA'?.E1"~" PRSA=PRSA_"~" S A=$L(PRSA,"~")-1
 I A>1 F B=1:1:A-1 S C=$P(PRSA,"~",B),DA(A-B)=$P(C,";",3)
 S B=$P(PRSA,"~",A),DIC=$P(B,";",2)  S:DIC=""&(A=1) DIC=+B
 S DLAYGO=PRSA,DIC(0)="FIL"
 S:$D(X(0)) DIC(0)=X(0) S:$D(X("DR")) DIC("DR")=X("DR") K X(0),X("DR")
 D FILE^DICN
 QUIT
 ;
 ;prs = ~1 file number(option);file root;file record id
 ;       ~2 subfile number;subfile root;subfile RI
 ;       ~...
 ;.x = value return; 1 if deleted, 0 if not, -2 if lock fail
DELETE(X,PRSA) ;delete entry
 N %,DA,DIC,Y
 N DIK,DIA,PRSLOCK,A,B,C
 S:PRSA'?.E1"~" PRSA=PRSA_"~" S A=$L(PRSA,"~")-1,PRSLOCK=""
 I A>1 F B=1:1:A-1 S C=$P(PRSA,"~",B),DA(A-B)=$P(C,";",3)
 S B=$P(PRSA,"~",A),DIK=$P(B,";",2),DA=$P(B,";",3),PRSLOCK=DIK_DA_","
 S X=3 D ICLOCK^PRSU1B(PRSLOCK,.X) I 'X S X=-2 QUIT
 D ^DIK,DCLOCK^PRSU1B(PRSLOCK)
 S X=1
 QUIT
