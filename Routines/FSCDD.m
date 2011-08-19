FSCDD ;SLC/STAFF-NOIS DD Calls ;1/11/98  15:48
 ;;1.1;NOIS;;Sep 06, 1998
 ;
FIELD(FIELD) ; $$(field) -> external value
 ; from ^DD(7107.11,3 output transform for FIELD
 Q $S($L($P($G(^FSC("FLD",+FIELD,0)),U,2)):$P(^(0),U,2),1:"")
 ;
COND(COND) ; $$(condition) -> external value
 ; from ^DD(7107.11,4 output transform for CONDITION
 Q $S($L($P($G(^FSC("COND",+COND,0)),U,4)):$P(^(0),U,4),1:"")
 ;
VALUE(VALUE) ; $$(value) -> external value
 ; from ^DD(7107.11,5 output transform for VALUE
 Q:'$L($G(D)) VALUE
 Q:$E(D)'="^" VALUE
 N OFFSET,FIELD,FLD,TYPE
 S FIELD=$P($G(@(D_"0)")),U,4)
 Q:'FIELD VALUE
 S TYPE=$P($G(^FSC("FLD",+FIELD,0)),U,3),OFFSET=$P($G(^(0)),U,6),FLD=$P($G(^(0)),U,8)
 I FLD,$E(TYPE)="P"!($E(TYPE)="D"),$L($T(VALUE^FSCGET)) Q $$VALUE^FSCGET(VALUE,7100,FLD)
 I $E(TYPE)="P" Q $$POINTER(VALUE,$P(TYPE,"P",2),OFFSET)
 I $E(TYPE)="D" Q $$FMTE^XLFDT(VALUE)
 Q VALUE
 ;
NONDDV(VALUE,FIELD) ; $$(value,field) -> external value
 ; external value for VALUE (depends on FIELD) in list definition
 Q:'$L($G(FIELD)) VALUE
 N FLD,OFFSET,TYPE
 S TYPE=$P($G(^FSC("FLD",+FIELD,0)),U,3),OFFSET=$P($G(^(0)),U,6),FLD=$P($G(^(0)),U,8)
 I FLD,$E(TYPE)="P"!($E(TYPE)="D") Q $$VALUE^FSCGET(VALUE,7100,FLD)
 I $E(TYPE)="P" Q $$POINTER(VALUE,$P(TYPE,"P",2),OFFSET)
 I $E(TYPE)="D" Q $$FMTE^XLFDT(VALUE)
 Q VALUE
 ;
POINTER(VALUE,FILE,OFFSET) ; $$(pointer value,file,offset) -> external value
 I 'VALUE Q ""
 I '$L($G(OFFSET)) Q $P(@(@("^DIC("_FILE_",0,""GL"")")_VALUE_",0)"),U)
 Q $P(@(@("^DIC("_FILE_",0,""GL"")")_VALUE_","_+OFFSET_")"),U,+$P(OFFSET,";",2))
