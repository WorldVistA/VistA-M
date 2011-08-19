XPAR1 ;SLC/KCM - Supporting Calls - Validate;11:35 PM  12 May 1998
 ;;7.3;TOOLKIT;**26**;Apr 25, 1995
 ;
INTERN ;convert ENT, PAR, and INST to internal form - called from XPAR only
 ;  ENT: entity in external or internal form
 ;  PAR: parameter in external or internal form
 ; INST: instance in external or internal form, or null
 ;       (may be null when retrieving all instances)
 ;  ERR: returns error (0 if none, otherwise #^error text)
 ; -- parameter
 I 'PAR S PAR=+$O(^XTV(8989.51,"B",PAR,0))
 ; -- instance
 I $D(XPARCHK) D VALID^XPARDD(PAR,.INST,"I",.ERR) Q:ERR
 ; -- entity   formats are:  nnn;GLO(  vptr int
 ;                           PRE.NAME  vptr ext
 ;                           PRE.`nnn  vptr ien
 ;                           PRE       default
 ;                           ALL       search chain
 ; begin case
 I ($L(ENT,"^")>1)!(ENT="ALL") D ENTLST(.ENT,PAR,INST) G C1
 I ENT?3U D ENTDFLT(.ENT) G C1         ;resolve default entity
 I '(+ENT&(ENT[";")) D ENTEXT(.ENT) G C1 ;resolve external vptr fmt
C1 ; end case
 ; by this time, ENT should be in internal variable ptr format
 I '$D(XPARGET) D                      ;tighter checks when storing data
 . I '(+ENT&(ENT[";")) S ERR=$$ERR^XPARDD(89895011) Q        ;not VP fmt
 . I $D(@("^"_$P(ENT,";",2)_$P(ENT,";",1)_")"))'>1 D  Q    ;not found
 . . S ERR=$$ERR^XPARDD(89895012)
 Q
ENTEXT(ENT) ; change entity from external form (PRE.NAME) to VP form
 ; .ENT: entity in external VP form
 ;  .FN: optionally returns file number for entity
 I ENT'["." S ENT="" Q
 N FN,PRE,X
 S PRE=$P(ENT,".",1),X=$P(ENT,".",2,3),ENT=""
 S FN=$O(^XTV(8989.518,"C",PRE,0))
 I $E(X)="`" S ENT=+$E(X,2,99)_$$MAKEVP(FN) Q
 S ENT=$$FIND1^DIC(FN,"","X",X)_$$MAKEVP(FN)
 I 'ENT S ENT=""
 Q
ENTDFLT(ENT) ; change default form (prefix only) to actual value in VP format
 ; .ENT: entity prefix only
 ; XPARSYS should be a system wide variable, identifies current domain
 I ENT="SYS" D:'$D(XPARSYS)  S ENT=XPARSYS Q  ; current site
 . S XPARSYS=$$FIND1^DIC(4.2,"","QX",$$KSP^XUPARAM("WHERE"))_";DIC(4.2,"
 I ENT="USR" S ENT=DUZ_";VA(200," Q    ; user in DUZ
 I ENT="CLS" S ENT="" Q                ; no default
 I ENT="TEA" S ENT="" Q                ; no default
 I ENT="BED" S ENT="" Q                ; no default
 I ENT="LOC" S ENT="" Q                ; no default
 I ENT="SRV" S ENT="" Q                ; no default
 I ENT="DIV" D  Q                      ; division in DUZ(2)
 . S ENT="" I +DUZ(2) S ENT=DUZ(2)_";DIC(4,"
 I ENT="PKG" D  Q                      ; package of param namespace
 . N PKG,NAM
 . S NAM=$P(^XTV(8989.51,PAR,0),"^",1),PKG=NAM
 . F  S PKG=$O(^DIC(9.4,"C",PKG),-1) Q:$E(NAM,1,$L(PKG))=PKG
 . I $L(PKG) S PKG=$O(^DIC(9.4,"C",PKG,0))
 . I PKG S ENT=PKG_";DIC(9.4,"
 S ENT=""                              ; no default found
 Q
ENTLST(ENT,PAR,INST) ; resolve entity list to entity with highest precedence
 ; .ENT: multiple entity pieces or keyword 'ALL'
 ;  PAR: parameter IEN
 ; INST: instance (may be null)
 I $E(ENT,1,3)="ALL" D
 . N FND,IEN,FN,GREF,LIST,I,X
 . ; set up list of entity values that were passed in
 . F I=2:1:$L(ENT,"^") S X=$P(ENT,"^",I) I $L(X) D
 . . I $D(^XTV(8989.518,"C",X)) D ENTDFLT(.X)
 . . I '(+X&(X[";")) D ENTEXT(.X)
 . . S GREF=$P(X,";",2)
 . . I $D(^XTV(8989.51,PAR,30,"AG",GREF)) S IEN=$O(^(GREF,0)) D
 . . . S LIST($P(^XTV(8989.51,PAR,30,IEN,0),"^",2))=X
 . ; using precedence defined for parameter, look up entities
 . S I=0,FND=0
 . F  S I=$O(^XTV(8989.51,PAR,30,"B",I)) Q:'I  S IEN=$O(^(I,0)) D  Q:FND
 . . S FN=$P(^XTV(8989.51,PAR,30,IEN,0),"^",2),X=$G(LIST(FN))
 . . I '$L(X) S X=$P(^XTV(8989.518,FN,0),U,2) D ENTDFLT(.X)
 . . I $L(X),'$L(INST),$D(^XTV(8989.5,"AC",PAR,X)) S ENT=X,FND=1 Q
 . . I $L(X),$L(INST),$D(^XTV(8989.5,"AC",PAR,X,INST)) S ENT=X,FND=1 Q
 E  D
 . ; use only entity values that were passed in
 . N I,FND
 . S FND=0
 . F I=1:1:$L(ENT,"^") S X=$P(ENT,"^",I) I $L(X) D  Q:FND
 . . I $D(^XTV(8989.518,"C",X)) D ENTDFLT(.X)
 . . I '(+X&(X[";")) D ENTEXT(.X)
 . . I $L(X),'$L(INST),$D(^XTV(8989.5,"AC",PAR,X)) S ENT=X,FND=1 Q
 . . I $L(X),$L(INST),$D(^XTV(8989.5,"AC",PAR,X,INST)) S ENT=X,FND=1 Q
 Q
MAKEVP(FN) ; function - returns VP suffix given file number
 Q ";"_$P($$ROOT^DILFD(FN),U,2)
 ;
