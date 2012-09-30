PRSU1B ;WOIFO/PLT-UTILITY ; 24-Aug-2005 10:34 AM
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT  ; invalid entry
 ;
 ;prsa = ~1 file number;file root;file record id;field # of multiple for adding
 ;       ~2 subfile number;subfile root (required if subfile);subfile RI;field # of multiple for adding
 ;       ~...
 ;prsb data ~1=ABCEFIKLMNnOQSTUVXZ any combination
 ;A:ask entry, B:B index only when .01 is pointer, C:display same enty more than one time
 ;E:echo back for user interactive mode, F:not save in disv for reuse
 ;I:ignore special look-up routine, K:use uniqueness key index, L:add new entry
 ;M:use all indices, N:use ien to lookup if no matches, n:include numeric in free text field
 ;O:exact match search first, partial second for all indices
 ;Q:error with ??, S:suppress disply if one match found
 ;T:continue all search results until '^' entered, U: use interanl format value search 
 ;V:ask ok if 1 match found, X:exact match
 ;Z:zero node y(0) and external format y(0,0) returned
 ;  ~2=DINUM (option), ~3=SPECIFIED INDEICES
 ;prsc = select prompt text (optional)
 ;.x = dir array for lookup specification (optional) and value returned
 ;.y = value returned from ^dic
LOOKUP(X,Y,PRSA,PRSB,PRSC) ;entry look-up
 N %,%Y,DG,DISYS,DIC,DLAYGO,DUPUT,DTOUT,DA,A,B,C,D,I
 S:PRSA'?.E1"~" PRSA=PRSA_"~" S A=$L(PRSA,"~")-1
 I A>1 F B=1:1:A-1 S C=$P(PRSA,"~",B),DA(A-B)=$P(C,";",3)
 S B=$P(PRSA,"~",A),DIC=$P(B,";",2)  S:DIC=""&(A=1) DIC=+B
 I $D(X)\10 F A=0,"A","B","S","W","DR","P" S:$D(X(A)) DIC(A)=X(A) K X(A)
 S:$D(PRSC) DIC("A")=PRSC
 S:'$D(DIC(0)) DIC(0)=$P(PRSB,"~") S:DIC(0)["L" DLAYGO=PRSA
 S:$P(PRSB,"~",2)?1.N DINUM=$P(PRSB,"~",2)
 S DA="",D=$P(PRSB,"~",3) I D="" D ^DIC I 1
 E  D MIX^DIC1
 QUIT
 ;
 ;prsa = ~1 file number;file root (required if prsc["L");file record id
 ;       ~2 subfile number (option);subfile root;subfile RI
 ;       ~...
 ;prsb = editing fields string DR if not in x-array (optional)
 ;prsc = string; '^' abort not allowed if ["^", lock/unlock if ["L"
 ;          single lock/unlock if ["LS"
 ;.x = editing filed string DR array or value returned
 ;   = value returned 0 if deleted, -1 if abort with '^'
 ;                    1 if normal exit, -2 if lock fail
EDIT(X,PRSA,PRSB,PRSC) ;edit entry in file
 N %,%Y,D0,D1,DDH,DISYS,DLAYGO,DQ
 N DI,DIE,DIC,DIS,DA,DR,PRSLOCK,A,B,C,D,Y
 S:PRSA'?.E1"~" PRSA=PRSA_"~" S PRSC=$G(PRSC),A=$L(PRSA,"~")-1,PRSLOCK=""
 I A>1 F B=1:1:A-1 S C=$P(PRSA,"~",B),DA(A-B)=$P(C,";",3)
 S B=$P(PRSA,"~",A),DIE=$P(B,";",2),DA=$P(B,";",3) S:PRSC["L" PRSLOCK=DIE_$S(PRSC["LS":DA_",",1:"")
 S:DIE=""&(A=1) DIE=+B
 S DR=$G(PRSB) S:PRSC["^" DIE("NO^")=""
 I DR="" S %X="X(",%Y="DR(",DR=X D %XY^%RCR K X
 K X I PRSLOCK]"" S Y=3 D ICLOCK(PRSLOCK,.Y) I 'Y S X=-2 QUIT
 D ^DIE,DCLOCK(PRSLOCK):PRSLOCK]""
 S X=$S('$D(DA):0,$D(Y)=0:1,1:-1)
 QUIT
 ;
 ;prsa = ~1 file number;file root (option);file record id
 ;       ~2 subfile number;subfile root (option);subfile RI
 ;       ~...
 ;prsb = ~1 field#;field#;...
 ;       ~2 subfield #;subfield #;...
 ;       ~...
 ;prsc = string of characters I, E. (no N) (required)
 ;prsd = local array name returned, it cann't be %,X,Y
 ;        PRSA,PRSB,PRSD,PRSD,PRSE,PRSF
 ;     @prsd(file#,record id,field #,"E")=external value
 ;     @prsd(file#,record id,field #,"I")=internal value
PIECE(PRSA,PRSB,PRSC,PRSD) ;get piece data
 N D0,DIC,DR,DA,DIQ,PRSE,PRSF,DI
 S PRSE=$P(PRSA,"~"),DIC=+PRSE,DA=$P(PRSE,";",3),DR=$P(PRSB,"~")
 F PRSF=2:1 Q:$P(PRSA,"~",PRSF)=""  S PRSE=$P(PRSA,"~",PRSF),DA(+PRSE)=$P(PRSE,";",3),DR(+PRSE)=$P(PRSB,"~",PRSF)
 S DIQ=PRSD,DIQ(0)=PRSC_"N"
 D EN^DIQ1
 QUIT
 ;
 ;prsa = (sub)file node root
 ;prsb = node value
NODE(PRSA,PRSB) ;get node
 N PRSC
 S @("PRSC=$G("_PRSA_"PRSB))")
 QUIT PRSC
 ;
 ;prsc is piece #
NP(PRSA,PRSB,PRSC) ;get node and piece
 N PRSD
 S @("PRSD=$P($G("_PRSA_"PRSB)),""^"",PRSC)")
 QUIT PRSD
 ;
 ;
 ;
 ;prslock array used to store lock history
ICLOCK(A,B) ;incremental lock with time (optional)
 ;  a = global root ending with ',' or '('
 ; .b = time lock seconds and value returned; false if lock fail
 S A=$E(A,1,$L(A)-1) I A["(" S A=A_")"
 I $D(B) L +@(A):B S B=$T E  QUIT
 S PRSLOCK(A)=$G(PRSLOCK(A))+1
 I '$D(B) S B=99999999 L +@(A):B
 QUIT
 ;
DCLOCK(A) ;decremental unlock a from prslock array of locking history
 ;  a = global root ending with ',' or '('
 S A=$E(A,1,$L(A)-1) I A["(" S A=A_")"
 L -@(A) S PRSLOCK(A)=$G(PRSLOCK(A))-1 K:PRSLOCK(A)<1 PRSLOCK(A)
 QUIT
 ;
UNLOCK(A) ;unlock a file (to decremental to 0) in prslock(a)
 ;  a = global root ending with ',' or '('
 S A=$E(A,1,$L(A)-1) I A["(" S A=A_")"
 F  Q:$G(PRSLOCK(A))<1  L -@(A) S PRSLOCK(A)=$G(PRSLOCK(A))-1
 K PRSLOCK(A)
 QUIT
 ;
UNLKALL ;unlock all files in prslock array
 N A
 S A="" F  S A=$O(PRSLOCK(A)) Q:A=""  F  Q:$G(PRSLOCK(A))<1  L -@(A) S PRSLOCK(A)=$G(PRSLOCK(A))-1
 K PRSLOCK
 QUIT
 ;
