ICDID ;ISL/KER - ICD Identifiers ;04/21/2014
 ;;18.0;DRG Grouper;**12,15,57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;          
 Q
 ; Identifiers for ICD Diagnosis file 80
IDDX(Y,X) ;   ICD Diagnosis Identifiers (versioned)
 N FLD,MSG,CODE,TYPE S FLD=+($G(X)),Y=+($G(Y)) Q:+FLD'>0 ""  Q:+Y'>0 ""
 S TYPE=$$CSI^ICDEX(80,+Y)
 I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDEX($G(ICDVDT),,TYPE),CODE=$$CODEC^ICDEX(80,+Y)
 I FLD=3 S X=$$VSTD^ICDEX(+Y,$G(ICDVDT))_$S($L(MSG):("  ("_MSG_")"),1:"") Q X
 I FLD=10 S X=$$VLTD^ICDEX(+Y,$G(ICDVDT))_$S($L(MSG):("  ("_MSG_")"),1:"") Q X
 I FLD=100 S X=$$STA(+($$STATCHK^ICDEX(CODE,$G(ICDVDT),TYPE))) Q X
 I FLD=20!(FLD=30)!(FLD=40)!(FLD=66)!(FLD=67)!(FLD=68) Q ""
 S X=$$GET1^DIQ(80,(+($G(Y))_","),FLD)
 Q X
IDDXF(Y) ;   ICD Diannosis Full
 N CC,CODE,TYPE,SYS,EF,ICDAT,ICID,MSG,SE,ST,LDX,IEN S (IEN,Y)=+($G(Y)) Q:+IEN'>0 ""
 S (SYS,TYPE)=$$CSI^ICDEX(80,+IEN),TYPE=$S(TYPE=1:"ICD-9 ",TYPE=30:"ICD-10",1:"")
 S CODE=$$CODEC^ICDEX(80,+IEN) I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S ICDAT=$$ICDDX^ICDEX(IEN,$G(ICDVDT),,"I",1) S MSG=$$MSG^ICDEX($G(ICDVDT),,TYPE) S:MSG["CODE " MSG="Text may be inaccurate"
 S ICID=$$UP($P(ICDAT,"^",4)),LDX="" S:ICID'=""&(TYPE'="") ICID=TYPE_" "_CODE_"  "_ICID
 I ICID="",$P($$UP(ICDAT),"^",2)["VA LOCAL CODE" S LDX=$$VSTD^ICDEX(+IEN,9990101) I $L(LDX) D
 . S:'$L(TYPE) ICID=CODE_"  "_LDX S:$L(TYPE) ICID=TYPE_" "_CODE_"  "_LDX
 . S:$P(ICDAT,"^",7)'>0 MSG="Local code, do not use"
 S:$L(MSG)&($L(ICID)) ICID=ICID_"  ("_MSG_")"
 S EF="",ST=$P(ICDAT,"^",10) S:+ST'>0 EF=$P(ICDAT,"^",12)
 S:+ST>0 EF=$P(ICDAT,"^",17) S ST=+ST
 I ST'>0,'$L(EF) S EF=$$LS^ICDEX(80,+IEN,9990101,1),ST=+($P(EF,"^",1)),EF=+($P(EF,"^",2))
 S SE=$$SF(80,IEN,ICDVDT),CC=$$CC(+$P(ICDAT,"^",19)) S:$L(CC) ICID=ICID_$S('$L(MSG):" ",1:"")_" ("_CC_")"
 S:$L(SE) ICID=ICID_$S('$L(MSG)&('$L(CC)):" ",1:"")_" "_SE
 S Y=$$TML(ICID)
 Q Y
IDDXS(Y) ;   ICD Diagnosis Identifiers (versioned - short)
 N ICID,ICDAT,MSG,CODE,SYS,TYPE,ST,IEN,CC,X S (IEN,Y)=+($G(Y)) Q:+Y'>0 ""
 S (SYS,TYPE)=$$CSI^ICDEX(80,+IEN) I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDEX($G(ICDVDT),,TYPE) S:MSG["CODE " MSG="Text may be inaccurate"
 S CODE=$$CODEC^ICDEX(80,+IEN),ICID=$$VSTD^ICDEX(+Y,$G(ICDVDT))
 S:$L(MSG) ICID=ICID_"  ("_MSG_")"
 S ST=$$STA(+($$STATCHK^ICDEX(CODE,$G(ICDVDT),TYPE)))
 S CC=+$P($$ICDDX^ICDEX(IEN,$G(ICDVDT),,"I",1),"^",19),CC=$$CC(+CC)
 S:$L(CC) ICID=ICID_$S('$L(MSG):" ",1:"")_" ("_CC_")"
 S:$L(ST) ICID=ICID_$S('$L(MSG)&('$L(CC)):" ",1:"")_" "_ST
 F  Q:$E(ICID,1)'=" "  S ICID=$E(ICID,2,$L(ICID))
 S Y=ICID
 Q Y
 ;
 ; Identifiers for ICD Procedure file 80.1
IDOP(Y,X) ;   ICD Procedure Identifiers (versioned)
 N FLD,MSG,CODE S FLD=+($G(X)),Y=+($G(Y)) Q:+FLD'>0 ""  Q:+Y'>0 ""
 S TYPE=$$CSI^ICDEX(80.1,+IEN)
 I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDEX($G(ICDVDT),,TYPE),CODE=$$CODEC^ICDEX(80.1,+IEN)
 I FLD=4 S X=$$VSTP^ICDEX(+Y,$G(ICDVDT))_$S($L(MSG):("  ("_MSG_")"),1:"") Q X
 I FLD=10 S X=$$VLTP^ICDEX(+Y,$G(ICDVDT))_$S($L(MSG):("  ("_MSG_")"),1:"") Q X
 I FLD=100 S X=$$STA(+($$STATCHK^ICDEX(CODE,$G(ICDVDT),TYPE))) Q X
 I FLD=7!(FLD=66)!(FLD=67)!(FLD=68) Q ""
 S X=$$GET1^DIQ(80.1,(+($G(Y))_","),FLD)
 Q X
IDOPF(Y) ;   ICD Procedure Full
 N CODE,EF,IEN,ICDAT,ICID,MSG,SE,ST,LOP,SYS,TYPE,LHE,LHI,LHN,LST S (IEN,Y)=+($G(Y)) Q:+IEN'>0 ""
 S CODE=$$CODEC^ICDEX(80.1,+IEN)
 S (SYS,TYPE)=$$CSI^ICDEX(80.1,+IEN) S TYPE=$S(TYPE=2:"ICD-9 ",TYPE=31:"ICD-10",1:"") I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S ICDAT=$$ICDOP^ICDEX(IEN,ICDVDT,,"I",1),MSG=$$MSG^ICDEX($G(ICDVDT),,TYPE) S:MSG["CODE " MSG="Text may be inaccurate"
 S ICID=$$UP($P(ICDAT,"^",5)),LOP="" S:ICID'=""&(TYPE'="") ICID=TYPE_" "_CODE_"  "_ICID
 I ICID="",$P($$UP(ICDAT),"^",2)["VA LOCAL CODE" S LOP=$$VSTP^ICDEX(+IEN,9990101) I $L(LOP) D
 . S:'$L(TYPE) ICID=CODE_"  "_LOP S:$L(TYPE) ICID=TYPE_" "_CODE_"  "_LOP
 . S:$P(ICDAT,"^",10)'>0 MSG="Local code, do not use"
 S:$L(MSG)&($L(ICID)) ICID=ICID_"  ("_MSG_")"
 S EF="",ST=$P(ICDAT,"^",10) S:+ST'>0 EF=$P(ICDAT,"^",12) S:+ST>0 EF=$P(ICDAT,"^",13) S ST=+ST
 I ST'>0,'$L(EF) S EF=$$LS^ICDEX(80.1,+IEN,9990101,1),ST=+($P(EF,"^",1)),EF=+($P(EF,"^",2))
 S SE=$$SF(80.1,IEN,ICDVDT) S:$L(SE) ICID=ICID_$S('$L(MSG):" ",1:"")_" "_SE S Y=$$TML(ICID)
 Q Y
IDOPS(Y) ;   ICD Procedure Identifiers (versioned - short)
 N ICID,MSG,CODE,LHE,LHI,LHN,LST,TYPE,ST,X S Y=+($G(Y)) Q:+Y'>0 ""  I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S TYPE=$$CSI^ICDEX(80.1,+IEN),MSG=$$MSG^ICDEX($G(ICDVDT),,TYPE) S:MSG["CODE " MSG="Text may be inaccurate"
 S CODE=$$CODEC^ICDEX(80.1,+IEN),ICID=$$VSTP^ICDEX(+Y,$G(ICDVDT)) S:$L(MSG) ICID=ICID_"  ("_MSG_")"
 S ST=$$STA(+($$STATCHK^ICDEX(CODE,$G(ICDVDT),TYPE)))
 S:$L(ST) ICID=ICID_$S('$L(MSG):" ",1:"")_" "_ST
 F  Q:$E(ICID,1)'=" "  S ICID=$E(ICID,2,$L(ICID))
 S Y=ICID
 Q Y
 ;
 ; Identifiers for DRG file 80.2
IDDG(Y,X) ;   DRG Identifiers (versioned)
 N FLD,MSG S FLD=+($G(X)),Y=+($G(Y)) Q:+FLD'>0 ""  Q:+Y'>0 ""
 I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDEX($G(ICDVDT)) I FLD=1 D  Q X
 . N DRG D VLTDR^ICDGTDRG(+Y,$G(ICDVDT),.DRG)
 . S X=$G(DRG(1)) S:$L(MSG) X=X_"  ("_MSG_")"
 I FLD=15 D  Q X
 . N VD,I,ST S VD=$O(^ICD(+Y,66,"B"," "),-1)
 . S I=$O(^ICD(+Y,66,"B",+VD," "),-1),X=$$STA(+($P($G(^ICD(+Y,66,+I,0)),"^",3)))
 I FLD=20!(FLD=30)!(FLD=66)!(FLD=68) Q ""
 S X=$$GET1^DIQ(80.2,(+($G(Y))_","),FLD)
 Q X
IDDGS(Y) ;   DRG Identifiers (versioned - Short)
 N MSG,X,ICDRG,ICID,VD,I,ST S Y=+($G(Y)) Q:+Y'>0 ""
 I '$D(ICDVDT) N ICDVDT S ICDVDT=$$DT^XLFDT
 S MSG=$$MSG^ICDEX($G(ICDVDT)) S:MSG["CODE " MSG="Text may be inaccurate"
 D VLTDR^ICDGTDRG(+Y,$G(ICDVDT),.ICDRG)
 S ICID=$G(ICDRG(1)) S:$L(MSG) ICID=ICID_"  ("_MSG_")"
 S VD=$O(^ICD(+Y,66,"B"," "),-1)
 S I=$O(^ICD(+Y,66,"B",+VD," "),-1)
 S ST=$$STA(+($P($G(^ICD(+Y,66,+I,0)),"^",3)))
 S:$L(ST) ICID=ICID_$S('$L(MSG):" ",1:"")_" "_ST
 F  Q:$E(ICID,1)'=" "  S ICID=$E(ICID,2,$L(ICID))
 S Y=ICID
 Q Y
 ;
 ; Miscellaneous
STA(X) ;   Format Status
 Q $S(+($G(X)):"",1:"INACTIVE")
STED(X) ;   Format Inactive Flag (Status) and Effective Date
 N ST,ED S ST=$P(X,"^",1) Q:+ST>0 ""  S ED=$P(X,"^",2) S:ED'?7N ED="" S:$L(ED) ED=$TR($$FMTE^XLFDT(ED,"5DZ"),"@"," ")
 S X="Inactive" S:$L(ED)=10 X=X_" "_ED
 Q X
SF(X,Y,Z) ; Status Flag
 N FI,RT,EF,IE,HIS,STA,EFF S FI=+($G(X)) Q:"^80^80.1^"'[("^"_FI_"^") ""
 S RT=$S(FI=80:$$ROOT^ICDEX(80),FI=80.1:$$ROOT^ICDEX(80.1),1:"") Q:'$L(RT) ""
 S IE=+($G(Y)) Q:+Y'>0 ""  Q:'$D(@(RT_IE_",0)")) ""  S EF=$G(Z) Q:EF'?7N ""
 S EFF=$O(@(RT_IE_",66,""B"","_(EF+.000009)_")"),-1)
 I EFF'?7N D  Q X
 . S X="" S EFF=$O(@(RT_IE_",66,""B"","_EF_")")) I EFF?7N D
 . . N HIS,STA S HIS=$O(@(RT_IE_",66,""B"","_EFF_","" "")"),-1) Q:+HIS'>0
 . . S STA=$G(@(RT_IE_",66,"_HIS_",0)"),-1)
 . . I $P(STA,"^",2)>0 S X="(Pending "_$TR($$FMTE^XLFDT(EFF,"5DZ"),"@"," ")_")"
 S HIS=$O(@(RT_IE_",66,""B"","_EFF_","" "")"),-1) Q:+HIS'>0 ""
 S STA=$G(@(RT_IE_",66,"_HIS_",0)"),-1)
 I $P(STA,"^",2)'>0 D  Q X
 . S X="(Inactive "_$TR($$FMTE^XLFDT(EFF,"5DZ"),"@"," ")_")"
 Q ""
CC(X) ;   Format CC
 Q $S(+($G(X))=1:"C/C",+($G(X))=2:"Major C/C",1:"")
TML(X) ;   Trim Leading Spaces
  S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
  Q X
UP(X) ;   Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
