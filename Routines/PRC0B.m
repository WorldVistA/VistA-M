PRC0B ;WISC/PLT-UTILITY ; 02/03/94  8:36 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ; invalid entry
 ;
 ;prca = ~1 file number;file root;file record id;field # of multiple for adding
 ;       ~2 subfile number;subfile root (required if subfile);subfile RI;field # of multiple for adding
 ;       ~...
 ;prcb data ~1=ACEFILMNOQSXZ any combination, ~2=DINUM (option), ~3=SPECIFIED INDEICES
 ;prcc = select propmt text (optional)
 ;.x = dir array for lookup specification (optional) and value returned
 ;.y = value returned from ^dic
LOOKUP(X,Y,PRCA,PRCB,PRCC) ;entry look-up
 N %,%Y,DG,DISYS,DIC,DLAYGO,DUPUT,DTOUT,DA,A,B,C,D,I
 S:PRCA'?.E1"~" PRCA=PRCA_"~" S A=$L(PRCA,"~")-1
 I A>1 F B=1:1:A-1 S C=$P(PRCA,"~",B),DA(A-B)=$P(C,";",3) S:$P(C,";",4)]"" DIC("P")=$$DICP^PRC0B1(+C,$P(C,";",4))
 S B=$P(PRCA,"~",A),DIC=$P(B,";",2)  S:DIC=""&(A=1) DIC=+B
 I $D(X)\10 F A=0,"A","B","S","W","DR","P" S:$D(X(A)) DIC(A)=X(A) K X(A)
 S:$D(PRCC) DIC("A")=PRCC
 S:'$D(DIC(0)) DIC(0)=$P(PRCB,"~") S:DIC(0)["L" DLAYGO=PRCA
 S:$P(PRCB,"~",2)?1.N DINUM=$P(PRCB,"~",2)
 S DA="",D=$P(PRCB,"~",3) I D="" D ^DIC I 1
 E  D MIX^DIC1
 QUIT
 ;
 ;prca = ~1 file number;file root (required if prcc["L");file record id
 ;       ~2 subfile number (option);subfile root;subfile RI
 ;       ~...
 ;prcb = editing fields string DR if not in x-array (optional)
 ;prcc = string; '^' abort not allowed if ["^", lock/unlock if ["L"
 ;          single lock/unlock if ["LS"
 ;.x = editing filed string DR array or value returned
 ;   = value returned 0 if deleted, -1 if abort with '^'
 ;                    1 if normal exit, -2 if lock fail
EDIT(X,PRCA,PRCB,PRCC) ;edit entry in file
 N %,%Y,D0,D1,DDH,DISYS,DLAYGO,DQ
 N DI,DIE,DIC,DIS,DA,DR,PRCLOCK,A,B,C,D,Y
 S:PRCA'?.E1"~" PRCA=PRCA_"~" S PRCC=$G(PRCC),A=$L(PRCA,"~")-1,PRCLOCK=""
 I A>1 F B=1:1:A-1 S C=$P(PRCA,"~",B),DA(A-B)=$P(C,";",3)
 S B=$P(PRCA,"~",A),DIE=$P(B,";",2),DA=$P(B,";",3) S:PRCC["L" PRCLOCK=DIE_$S(PRCC["LS":DA_",",1:"")
 S:DIE=""&(A=1) DIE=+B
 S DR=$G(PRCB) S:PRCC["^" DIE("NO^")=""
 I DR="" S %X="X(",%Y="DR(",DR=X D %XY^%RCR K X
 K X I PRCLOCK]"" S Y=3 D ICLOCK(PRCLOCK,.Y) I 'Y S X=-2 QUIT
 D ^DIE,DCLOCK(PRCLOCK):PRCLOCK]""
 S X=$S('$D(DA):0,$D(Y)=0:1,1:-1)
 QUIT
 ;
 ;prca = ~1 file number;file root (option);file record id
 ;       ~2 subfile number;subfile root (option);subfile RI
 ;       ~...
 ;prcb = ~1 field#;field#;...
 ;       ~2 subfield #;subfield #;...
 ;       ~...
 ;prcc = string of characters I, E. (no N) (required)
 ;prcd = local array name returned, it cann't be %,X,Y
 ;        PRCA,PRCB,PRCD,PRCD,PRCE,PRCF
 ;     @prcd(file#,record id,field #,"E")=external value
 ;     @prcd(file#,record id,field #,"I")=internal value
PIECE(PRCA,PRCB,PRCC,PRCD) ;get piece data
 N D0,DIC,DR,DA,DIQ,PRCE,PRCF,DI
 S PRCE=$P(PRCA,"~"),DIC=+PRCE,DA=$P(PRCE,";",3),DR=$P(PRCB,"~")
 F PRCF=2:1 Q:$P(PRCA,"~",PRCF)=""  S PRCE=$P(PRCA,"~",PRCF),DA(+PRCE)=$P(PRCE,";",3),DR(+PRCE)=$P(PRCB,"~",PRCF)
 S DIQ=PRCD,DIQ(0)=PRCC_"N"
 D EN^DIQ1
 QUIT
 ;
 ;prca = (sub)file node root
 ;prcb = node value
NODE(PRCA,PRCB) ;get node
 N PRCC
 S @("PRCC=$G("_PRCA_"PRCB))")
 QUIT PRCC
 ;
 ;prc is piece #
NP(PRCA,PRCB,PRCC) ;get node and piece
 N PRCD
 S @("PRCD=$P($G("_PRCA_"PRCB)),""^"",PRCC)")
 QUIT PRCD
 ;
 ;extrinsic variable for lookup screen active enteries for sd dic
 ;$$STATUS^PRC0B = fix value of status file 420.1999
STATUS() ;get status fix value via pointer of file 420.1999, naked '^' used for lookup screen
 N A
 S A=$P($G(^(0)),U,3)
 QUIT $S(A:$P($G(^PRCD(420.1999,A,0)),U,4),1:"A")
 ;
 ;
 ;
ICLOCK(A,B) ;incremental lock with time (optional)
 ;  a = global root ending with ','
 ; .b = time lock seconds and value returned; false if lock fail
 S A=$E(A,1,$L(A)-1)
 I $D(B) L +@(A_")"):B S B=$T E  QUIT
 S PRCLOCK(A)=$G(PRCLOCK(A))+1
 I '$D(B) S B=99999999 L +@(A_")"):B
 QUIT
 ;
DCLOCK(A) ;decremental unlock
 ;  a = global root ending with ','
 S A=$E(A,1,$L(A)-1)
 L -@(A_")") S PRCLOCK(A)=$G(PRCLOCK(A))-1 K:PRCLOCK(A)<1 PRCLOCK(A)
 QUIT
 ;
UNLOCK(A) ;unlock all ^PRC(A)
 ;  a = global root ending with ','
 S A=$E(A,1,$L(A)-1)
 F  Q:$G(PRCLOCK(A))<1  L -@(A_")") S PRCLOCK(A)=$G(PRCLOCK(A))-1
 K PRCLOCK(A)
 QUIT
 ;
UNLKALL ;unlock all ^PRC
 N A
 S A="" F  S A=$O(PRCLOCK(A)) Q:A=""  F  Q:$G(PRCLOCK(A))<1  L -@(A_")") S PRCLOCK(A)=$G(PRCLOCK(A))-1
 K PRCLOCK
 QUIT
 ;
