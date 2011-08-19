XPAR2 ;SLC/KCM - Supporting Calls - Update
 ;;7.3;TOOLKIT;**26**;Apr 25, 1995
 ;
DOADD ; call Fileman to add a new entry
 I $D(^XTV(8989.5,"AC",PAR,ENT,INST)) S ERR=$$ERR^XPARDD(89895006) Q
 I $D(XPARCHK) D VALID^XPARDD(PAR,.VAL,"V",.ERR) Q:ERR
 N FDA,FDAIEN,DIERR
 S FDA(8989.5,"+1,",.01)=ENT
 S FDA(8989.5,"+1,",.02)=PAR
 S FDA(8989.5,"+1,",.03)=INST
 S FDA(8989.5,"+1,",1)=VAL
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 I $D(DIERR) S ERR=$$ERR^XPARDD(89895009) Q      ; filing error
 N WPIEN S WPIEN=FDAIEN(1) D CHKWP
 Q
DOCHG ; call Fileman to change VALUE field
 N IEN,FDA,DIERR
 S IEN=+$O(^XTV(8989.5,"AC",PAR,ENT,INST,0))
 I 'IEN S ERR=$$ERR^XPARDD(89895008) Q           ; instance not found
 I $D(XPARCHK) D VALID^XPARDD(PAR,.VAL,"V",.ERR) Q:ERR
 S FDA(8989.5,IEN_",",1)=VAL
 D FILE^DIE("","FDA","ERR")
 I $D(DIERR) S ERR=$$ERR^XPARDD(89895009)        ; filing error
 N WPIEN S WPIEN=IEN D CHKWP
 Q
DOREP ; call Fileman to replace INSTANCE value with a new value
 N IEN,FDA,DIERR
 S IEN=+$O(^XTV(8989.5,"AC",PAR,ENT,INST,0))
 I 'IEN S ERR=$$ERR^XPARDD(89895008) Q           ; instance not found
 I $D(XPARCHK) D VALID^XPARDD(PAR,.NEWINST,"I",.ERR) Q:ERR
 I $D(^XTV(8989.5,"AC",PAR,ENT,NEWINST)) S ERR=$$ERR^XPARDD(89895006) Q
 S FDA(8989.5,IEN_",",.03)=NEWINST
 D FILE^DIE("","FDA","ERR")
 I $D(DIERR) S ERR=$$ERR^XPARDD(89895009)        ; filing error
 Q
CHKWP ; check for word processing value and file
 Q:$D(VAL)'=11  Q:$P($G(^XTV(8989.51,PAR,1)),"^",1)'="W"
 D WP^DIE(8989.5,WPIEN_",",2,"","VAL","ERR")
 I $D(DIERR) S ERR=$$ERR^XPARDD(89895009)
 Q
DODEL ; call Fileman to delete this instance
 N DA,DIK
 S DA=$O(^XTV(8989.5,"AC",PAR,ENT,INST,0))
 I 'DA S ERR="1^Parameter instance not found" Q
 S DIK="^XTV(8989.5," D ^DIK
 Q
