ICDID ;SLC/KER - ICD IDENTIFIERS ; 04/18/2004
 ;;18.0;DRG Grouper;**12,15**;Oct 20, 2000
 ;
 ;
 ; External References
 ;   DBIA   2056  $$GET1^DIQ
 ;   DBIA  10103  $$DT^XLFDT
 ;                 
 Q
 ; Versioned Identifiers use the following
 ; input parameters:
 ;                   
 ;    Y    Fileman's Internal Entry Number
 ;    X    DD Field Number
 ;                   
 ; Format for using Identifiers
 ;                   
 ;   ^DD(file,0,"ID",field)=
 ;        D EN^DDIOL(("   "_$$IDDX^ICDID(+Y,field)),"","?0")
 ;                       
IDDX(Y,X) ; ICD Diagnosis Identifiers (versioned)
 N FLD,MSG,CODE S FLD=+($G(X)),Y=+($G(Y)) Q:+FLD'>0 ""  Q:+Y'>0 ""
 I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDAPIU($G(ICDVDT)),CODE=$P($G(^ICD9(+Y,0)),U,1)
 I FLD=3 S X=$$VSTD^ICDCODE(+Y,$G(ICDVDT))_$S($L(MSG):("  ("_MSG_")"),1:"") Q X
 I FLD=10 S X=$$VLTD^ICDCODE(+Y,$G(ICDVDT))_$S($L(MSG):("  ("_MSG_")"),1:"") Q X
 I FLD=100 S X=$$STA(+($$STATCHK^ICDAPIU(CODE,$G(ICDVDT)))) Q X
 I FLD=20!(FLD=30)!(FLD=40)!(FLD=66)!(FLD=67)!(FLD=68) Q ""
 S X=$$GET1^DIQ(80,(+($G(Y))_","),FLD)
 Q X
IDDXS(Y) ; ICD Diagnosis Identifiers (versioned - short)
 N ICID,MSG,CODE,ST,ND,CC,X S Y=+($G(Y)) Q:+Y'>0 ""  S ND=$G(^ICD9(+Y,0))
 I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDAPIU($G(ICDVDT)) S:MSG["CODE " MSG="Text may be inaccurate"
 S CODE=$P(ND,U,1)
 S ICID=$$VSTD^ICDCODE(+Y,$G(ICDVDT)) S:$L(MSG) ICID=ICID_"  ("_MSG_")"
 S ST=$$STA(+($$STATCHK^ICDAPIU(CODE,$G(ICDVDT))))
 S CC=+$P(ND,U,7),CC=$S(CC>0:"C/C",1:"")
 S:$L(CC) ICID=ICID_$S('$L(MSG):" ",1:"")_"("_CC_")"
 S:$L(ST) ICID=ICID_$S('$L(MSG)&('$L(CC)):" ",1:"")_" "_ST
 F  Q:$E(ICID,1)'=" "  S ICID=$E(ICID,2,$L(ICID))
 S Y=ICID
 Q Y
IDOP(Y,X) ; ICD Procedure Identifiers (versioned)
 N FLD,MSG,CODE S FLD=+($G(X)),Y=+($G(Y)) Q:+FLD'>0 ""  Q:+Y'>0 ""
 I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDAPIU($G(ICDVDT)),CODE=$P($G(^ICD0(+Y,0)),U,1)
 I FLD=4 S X=$$VSTP^ICDCODE(+Y,$G(ICDVDT))_$S($L(MSG):("  ("_MSG_")"),1:"") Q X
 I FLD=10 S X=$$VLTP^ICDCODE(+Y,$G(ICDVDT))_$S($L(MSG):("  ("_MSG_")"),1:"") Q X
 I FLD=100 S X=$$STA(+($$STATCHK^ICDAPIU(CODE,$G(ICDVDT)))) Q X
 I FLD=7!(FLD=66)!(FLD=67)!(FLD=68) Q ""
 S X=$$GET1^DIQ(80.1,(+($G(Y))_","),FLD)
 Q X
IDOPS(Y) ; ICD Procedure Identifiers (versioned - short)
 N ICID,MSG,CODE,ST,X S Y=+($G(Y)) Q:+Y'>0 ""
 I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDAPIU($G(ICDVDT)) S:MSG["CODE " MSG="Text may be inaccurate"
 S CODE=$P($G(^ICD0(+Y,0)),U,1)
 S ICID=$$VSTP^ICDCODE(+Y,$G(ICDVDT)) S:$L(MSG) ICID=ICID_"  ("_MSG_")"
 S ST=$$STA(+($$STATCHK^ICDAPIU(CODE,$G(ICDVDT))))
 S:$L(ST) ICID=ICID_$S('$L(MSG):" ",1:"")_" "_ST
 F  Q:$E(ICID,1)'=" "  S ICID=$E(ICID,2,$L(ICID))
 S Y=ICID
 Q Y
IDDG(Y,X) ; DRG Identifiers (versioned)
 N FLD,MSG S FLD=+($G(X)),Y=+($G(Y)) Q:+FLD'>0 ""  Q:+Y'>0 ""
 I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDAPIU($G(ICDVDT)) I FLD=1 D  Q X
 . N DRG D VLTDR^ICDGTDRG(+Y,$G(ICDVDT),.DRG)
 . S X=$G(DRG(1)) S:$L(MSG) X=X_"  ("_MSG_")"
 I FLD=15 D  Q X
 . N VD,I,ST S VD=$O(^ICD(+Y,66,"B"," "),-1)
 . S I=$O(^ICD(+Y,66,"B",+VD," "),-1),X=$$STA(+($P($G(^ICD(+Y,66,+I,0)),U,3)))
 I FLD=20!(FLD=30)!(FLD=66)!(FLD=68) Q ""
 S X=$$GET1^DIQ(80.2,(+($G(Y))_","),FLD)
 Q X
IDDGS(Y) ; DRG Identifiers (versioned - Short)
 N MSG,X,ICDRG,ICID,VD,I,ST S Y=+($G(Y)) Q:+Y'>0 ""
 I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDAPIU($G(ICDVDT)) S:MSG["CODE " MSG="Text may be inaccurate"
 D VLTDR^ICDGTDRG(+Y,$G(ICDVDT),.ICDRG)
 S ICID=$G(ICDRG(1)) S:$L(MSG) ICID=ICID_"  ("_MSG_")"
 S VD=$O(^ICD(+Y,66,"B"," "),-1)
 S I=$O(^ICD(+Y,66,"B",+VD," "),-1)
 S ST=$$STA(+($P($G(^ICD(+Y,66,+I,0)),U,3)))
 S:$L(ST) ICID=ICID_$S('$L(MSG):" ",1:"")_" "_ST
 F  Q:$E(ICID,1)'=" "  S ICID=$E(ICID,2,$L(ICID))
 S Y=ICID
 Q Y
STA(X) ; Status
 Q $S(+($G(X)):"",1:"INACTIVE")
