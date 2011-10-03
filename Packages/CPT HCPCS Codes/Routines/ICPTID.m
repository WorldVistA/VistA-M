ICPTID ;SLC/KER - CPT IDENTIFIERS ; 04/18/2004
 ;;6.0;CPT/HCPCS;**19**;May 19, 1997
 ;
 ; External References
 ;   DBIA   2056  $$GET1^DIQ
 ;   DBIA  10103  $$DT^XLFDT
 ;                 
 Q
 ; Versioned Identifiers use the following
 ; input parameters:
 ;                   
 ;    X    Fileman's Internal Entry Number
 ;    Y    DD Field Number
 ;                   
 ; Format for using Identifiers
 ;                   
 ;   ^DD(file,0,"ID",field)=
 ;        D EN^DDIOL(("   "_$$IDCP^ICPTID(+Y,field)),"","?0")
 ;                       
IDCP(Y,X) ; CPT/HCPCS Identifiers (versioned)
 N FLD,MSG,CODE S FLD=+($G(X)),Y=+($G(Y)) Q:+FLD'>0 ""  Q:+Y'>0 ""
 S:'$D(DT) DT=$$DT^XLFDT I '$D(ICPTVDT) N ICPTVDT S ICPTVDT=DT
 S MSG=$$MSG^ICPTSUPT($G(ICPTVDT),1),CODE=$P($G(^ICPT(+Y,0)),U,1)
 I FLD=2 S X=$$VSTCP^ICPTCOD(+Y,$G(ICPTVDT))_$S($L(MSG):("  ("_MSG_")"),1:"") Q X
 I FLD=5 S X=$$STA(+($$STATCHK^ICPTAPIU(CODE,$G(ICPTVDT)))) Q X
 I FLD=50!(FLD=60)!(FLD=61)!(FLD=62) Q ""
 S X=$$GET1^DIQ(81,(+($G(Y))_","),FLD)
 Q X
IDCPS(Y) ; CPT/HCPCS Identifiers (versioned - short)
 N ICID,MSG,CODE,ST,X S Y=+($G(Y)) Q:+Y'>0 ""
 S:'$D(DT) DT=$$DT^XLFDT I '$D(ICPTVDT) N ICPTVDT S ICPTVDT=DT
 S MSG=$$MSG^ICPTSUPT($G(ICPTVDT),1) S:MSG["CODE " MSG="Text may be inaccurate"
 S CODE=$P($G(^ICPT(+Y,0)),U,1)
 S ICID=$$VSTCP^ICPTCOD(+Y,$G(ICPTVDT)) S:$L(MSG) ICID=ICID_"  ("_MSG_")"
 S ST=$$STA(+($$STATCHK^ICPTAPIU(CODE,$G(ICPTVDT))))
 S:$L(ST) ICID=ICID_$S('$L(MSG):" ",1:"")_" "_ST
 F  Q:$E(ICID,1)'=" "  S ICID=$E(ICID,2,$L(ICID))
 S Y=ICID
 Q Y
IDMD(Y,X) ; CPT Modifier Identifiers (versioned)
 N FLD,MSG,CODE S FLD=+($G(X)),Y=+($G(Y)) Q:+FLD'>0 ""  Q:+Y'>0 ""
 S:'$D(DT) DT=$$DT^XLFDT I '$D(ICPTVDT) N ICPTVDT S ICPTVDT=DT
 S MSG=$$MSG^ICPTSUPT($G(ICPTVDT),1)
 I FLD=.02 S X=$$VSTCM^ICPTMOD(+Y,$G(ICPTVDT))_$S($L(MSG):("  ("_MSG_")"),1:"") Q X
 I FLD=5 D  Q X
 . N VD,I S VD=$O(^DIC(81.3,+Y,60,"B"," "),-1)
 . S I=+($O(^DIC(81.3,+Y,60,"B",+VD," "),-1))
 . S X=$$STA(+($P($G(^DIC(81.3,+Y,60,+I,0)),U,2)))
 I FLD=10!(FLD=50)!(FLD=60)!(FLD=61)!(FLD=62) Q ""
 S X=$$GET1^DIQ(81.3,(+($G(Y))_","),FLD)
 Q X
IDMDS(Y) ; CPT Modifier Identifiers (versioned - short)
 N ICID,MSG,CODE,ST,X,VD,VI S Y=+($G(Y)) Q:+Y'>0 ""
 S:'$D(DT) DT=$$DT^XLFDT I '$D(ICPTVDT) N ICPTVDT S ICPTVDT=DT
 S MSG=$$MSG^ICPTSUPT($G(ICPTVDT),1) S:MSG["CODE " MSG="Text may be inaccurate"
 S ICID=$$VSTCM^ICPTMOD(+Y,$G(ICPTVDT)) S:$L(MSG) ICID=ICID_"  ("_MSG_")"
 S VD=$O(^DIC(81.3,+Y,60,"B"," "),-1)
 S VI=+($O(^DIC(81.3,+Y,60,"B",+VD," "),-1))
 S ST=$$STA(+($P($G(^DIC(81.3,+Y,60,+VI,0)),U,2)))
 S:$L(ST) ICID=ICID_$S('$L(MSG):" ",1:"")_" "_ST
 F  Q:$E(ICID,1)'=" "  S ICID=$E(ICID,2,$L(ICID))
 S Y=ICID
 Q Y
STA(X) ; Status
 Q $S(+($G(X)):"",1:"INACTIVE")
