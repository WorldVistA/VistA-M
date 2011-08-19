XPARDD ; SLC/KCM - DD Logic for Parameters (8989.5) ;05/14/2003  07:28
 ;;7.3;TOOLKIT;**26,35,39,63,69**;Apr 25, 1995
 ;
ALLOW(ENT,PAR) ; function
 ; Screen for PARAMETER (.02) field
 ; Returns 1 (true) if parameter allowed for this entity, otherwise 0
 S ENT=$P($P($G(^XTV(8989.5,ENT,0)),"^",1),";",2)
 I $L(ENT),$D(^XTV(8989.51,PAR,30,"AG",ENT)) Q 1
 Q 0
 ;
DDVALID(FLD) ; procedure
 ; Input transform for both INSTANCE (.03) and VALUE (1) fields
 ;    FLD: field (I=instance, V=value)
 N X0,ENT,PAR,ERR
 S X0=$G(^XTV(8989.5,DA,0)),ENT=$P(X0,"^",1),PAR=$P(X0,"^",2)
 D VALID(PAR,.X,FLD,.ERR)
 I FLD="I",'ERR,$D(^XTV(8989.5,"AC",PAR,ENT,X)),($O(^(X,0))'=DA) D
 . S ERR=$$ERR(89895006)                               ;Duplicate
 I ERR K X D EN^DDIOL($P(ERR,"^",2))
 Q
VALID(PAR,VAL,FLD,ERR) ; procedure
 ; Validate both INSTANCE (.03) and VALUE (1) fields
 ;    PAR: parameter (internal form)
 ; [.]VAL: value (external form), internal form returned
 ;    FLD: field (I=instance, V=value)
 ;   .ERR: returns error flag & description
 N DIR,DDER,DTOUT,DUOUT,DIRUT,DIROUT,MULT,SUB,X,Y
 S ERR=0
 I 'PAR S ERR=$$ERR(89895001) Q                        ;Invalid Param
 I $D(^XTV(8989.51,PAR))<10 S ERR=$$ERR(89895002) Q    ;Missing Param
 I '$D(XPARGET),($P(^XTV(8989.51,PAR,0),"^",6)=1),($G(DIUTIL)'="VERIFY FIELDS") S ERR=$$ERR(89895014) Q
 S MULT=$P($G(^XTV(8989.51,PAR,0)),"^",3)
 I (FLD="I"),(VAL'=1),'MULT S ERR=$$ERR(89895003) Q    ;Not Multi Valued
 I (FLD="I"),(VAL=1),'MULT Q  ;Single valued instance, no checking req'd
 S:FLD="V" SUB=0 S:FLD="I" SUB=5
 S DIR(0)=$P($G(^XTV(8989.51,PAR,SUB+1)),"^",1,2),DIR("V")=""
 I '$L(DIR(0)) S ERR=$$ERR(89895004) Q                 ;Missing Type
 I "S"[$E(DIR(0)) S DIR(0)=$P(DIR(0),U)_"V^"_$P(DIR(0),U,2,9) ;Make silent
 I $L($G(^XTV(8989.51,PAR,SUB+3))) S DIR("S")=^(SUB+3)
 I $E(DIR(0))="S",(DIR(0)[(VAL_":")) S VAL=$P($P(DIR(0),VAL_":",2),";")
 I $E(DIR(0))="P" D
 . N X S X=$P(DIR(0),"^",2)
 . S $P(DIR(0),"^",2)=X_$S(X'[":":":X",X'["X":"X",1:"")
 . I $G(DIUTIL)="VERIFY FIELDS" S VAL="`"_VAL          ;for Verify only
 I $E(DIR(0))="W" S $P(DIR(0),"^",1)="F"               ;Check WP Title
 I $E(DIR(0))="Y",VAL?1.N S VAL=$S(VAL=0:"NO",1:"YES")
 I $E(DIR(0))="D",$L($P(DIR(0),"^",2)) D               ;Resolve Date
 . N %,X,T1,T2,T3
 . S X=$P(DIR(0),"^",2),T1=$P(X,":",1),T2=$P(X,":",2),T3=$P(X,":",3)
 . D NOW^%DTC
 . S:T1="NOW" T1=% S:T1="DT" T1=X S:T2="NOW" T2=% S:T2="DT" T2=X
 . S $P(DIR(0),"^",2)=T1_":"_T2_":"_T3
 I $E(DIR(0))="W" S $P(DIR(0),"^",1)="F"
 S X=VAL D ^DIR I $G(DDER)=1 K X                       ;Check with DIR
 I $D(X),$L($G(^XTV(8989.51,PAR,SUB+2))) X ^(SUB+2)    ;Execute 3rd Piece
 I '$D(X) S ERR=$$ERR($S(FLD="V":89895005,1:89895013)) Q  ;Fail Validate
 S VAL=$P(Y,"^",1)                                        ;Pass Validate
 Q
 ;
TYPE(DA,FLD) ; function  **********************
 ; Find value type and return external value
 N X S X=$P($G(^XTV(8989.51,DA,$S(FLD="I":6,1:1))),"^",1)
 Q $S(X="D":"Date/Time",X="F":"Free Text",X="N":"Numeric",X="S":"Set",X="Y":"Yes/No",X="P":"Pointer",X="W":"Word Processing",1:"undefined")
 ;
ERR(IEN) ; function
 ; Return error number and message in format:  nnn^error message
 Q IEN_"^"_$$EZBLD^DIALOG(IEN)
 ;
HELP(FLD) ; procedure
 ; Executable Help for both INSTANCE (.03) and VALUE (1) fields
 N PDEFNOD,PROOT,PDESC,PHELP
 S PDEFNOD=$P($G(^XTV(8989.5,DA,0)),"^",2)    ;Get param definition
 I 'PDEFNOD D EN^DDIOL("Parameter must be entered before the value.")
 I PDEFNOD D
 . S PHELP=$P($G(^XTV(8989.51,PDEFNOD,$S(FLD="I":6,1:1))),"^",3)
 . I '$L(PHELP) S PHELP="Enter a "_$$TYPE(PDEFNOD,FLD)_" value."
 . D EN^DDIOL(PHELP,"","!?5")
 . I X["??" D
 . . D EN^DDIOL("Parameter Description: ","","!!")
 . . S PROOT=$$GET1^DIQ(8989.51,PDEFNOD_",",20,"","PDESC")
 . . D EN^DDIOL(.PDESC),EN^DDIOL($S(FLD="I":"Instance",1:"Value")_" Field Description:","","!!")
 Q
OUT(Y,FLD) ; function
 ; returns external value (for OUTPUT TRANSFORM of .03, 1)
 Q:$D(D0)#2'=1 Y ; ** D0 tells current record for output transform?
 N PAR S PAR=$P($G(^XTV(8989.5,D0,0)),"^",2)
 Q:'$L(PAR) Y ;Check that PAR has a value
 Q $$EXT(Y,PAR,FLD)
 ;
EXT(X,PAR,FLD) ; function
 ; return external value of INSTANCE or VALUE fields
 ;   X: internal value
 ; PAR: parameter IEN
 ; FLD: "I" for instance, "V" for value fields, default="V"
 N TYP,FN S FLD=$G(FLD,"V")
 Q:$G(X)="" "" Q:$G(PAR)="" "" ;Check parameters
 S TYP=$P($G(^XTV(8989.51,PAR,$S(FLD="I":6,1:1))),"^",1)
 I "NFWMC"[TYP Q X
 I TYP="D" Q $$EXTDATE(X)
 I TYP="S" Q $$EXTSET(X,PAR,FLD)
 I TYP="Y" Q $S(X=1:"YES",1:"NO")
 I TYP="P" D  Q $$EXTPTR(X,FN)
 . S FN=+$P(^XTV(8989.51,PAR,$S(FLD="I":6,1:1)),"^",2)
 Q  ;force error, not quitting before here is erroneous condition
EXTDATE(Y) ; function
 ; return external form of date
 ; Y: date in internal FM format
 D DD^%DT
 Q Y
EXTPTR(APTR,FN) ; function
 ; return external form of pointer
 ; APTR: pointer value
 ;   FN: pointed to file number
 I (+APTR'=APTR)!(APTR'>0) Q APTR ;not a valid pointer
 N REF S REF=$G(^DIC(FN,0,"GL"))
 I $L(REF) S @("REF=$G("_REF_APTR_",0))")
 Q:'$L(REF) APTR
 S APTR=$P(REF,"^",1)
 Q $$EXTERNAL^DILFD(FN,.01,"",APTR)
EXTSET(X,PAR,FLD) ; function
 ; return external form for set of codes
 ;   X: internal code
 ; PAR: parameter IEN
 ; FLD: "I" for instance, "V" for value fields, default = "V"
 N CODES S FLD=$G(FLD,"V")
 S CODES=$P($G(^XTV(8989.51,PAR,$S(FLD="I":6,1:1))),"^",2)
 Q $P($P(CODES,X_":",2),";",1)
