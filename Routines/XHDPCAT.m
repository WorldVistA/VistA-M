XHDPCAT        ; SLC/JER - Configurator Server Calls ; 25 Jul 2003  9:42 AM
 ;;1.0;HEALTHEVET DESKTOP;;Jul 15, 2003
INSERT(ERR,CATFLDS)      ; Insert ParameterCategory
 N XHDI,FDA,LASTI,LASTS,LASTN,X,XHDDAD,NEWDA
 S X="ONERROR^XHDPCAT",@^%ZOSF("TRAP")
 S XHDI="",(ERR,LASTS,LASTN)=0,LASTI=1
 F  S XHDI=$O(CATFLDS(XHDI)) Q:+XHDI'>0  D
 . S FDA($$GETFILE(XHDI),$$GETIENS(XHDI),$$GETORI(XHDI))=CATFLDS(XHDI)
 I $D(FDA)'>9 S ERR="1^Request not well-formed." Q
 D UPDATER(.ERR,.FDA) Q:+ERR
 I '+ERR S NEWDA=$P(ERR,U,2)
 ; If new record's parent doesn't include it as a subCategory, add it
 S XHDDAD=+$P(^XHD(8935.91,NEWDA,0),U,4)
 I +XHDDAD,'+$O(^XHD(8935.91,"SCAT",NEWDA,XHDDAD,0)) D  Q:+ERR
 . N FDA,SUBERR
 . S FDA(8935.913,"?+1,"_XHDDAD_",",.01)=(+$O(^XHD(8935.91,1,3,"A"),-1)+1)
 . S FDA(8935.913,"?+1,"_XHDDAD_",",.02)="`"_NEWDA
 . D UPDATER(.SUBERR,.FDA) S:+SUBERR ERR=SUBERR
 ; If there are subcategories, file NEWDA as their parentId
 I +NEWDA D
 . N XHDJ,SUBERR S XHDJ=0
 . F  S XHDJ=$O(^XHD(8935.91,NEWDA,3,XHDJ)) Q:+XHDJ'>0!+ERR  D
 . . N SUBDA,FDA,IEN,MSG
 . . S SUBDA=$P($G(^XHD(8935.91,NEWDA,3,XHDJ,0)),U,2) Q:+SUBDA'>0
 . . I +$P($G(^XHD(8935.91,SUBDA,0)),U,4)=NEWDA Q
 . . S FDA(8935.91,SUBDA_",",.04)="`"_NEWDA
 . . D FILER(.SUBERR,.FDA,SUBDA) S:+SUBERR ERR=SUBERR
 Q
ADDPARAM(ERR,CATFLDS) ; Add Parameter to Category
 N XHDI,FDA,PCDA,X S X="ONERROR^XHDPCAT",@^%ZOSF("TRAP")
 S XHDI="",ERR=0,PCDA=+$G(CATFLDS("IEN"))
 I $S('PCDA:1,'$D(^XHD(8935.91,PCDA,0)):1,1:0) D  Q
 . S ERR="1^Invalid ID passed."
 L +^XHD(8935.91,PCDA):1
 E  D  Q
 . S ERR="1^Another process is modifying Category #"_PCDA
 F  S XHDI=$O(CATFLDS(XHDI)) Q:+XHDI'>0  D
 . S FDA(8935.912,"?+1,"_PCDA_",",$P(XHDI,U,3))=CATFLDS(XHDI)
 I $D(FDA)'>9 S ERR="1^Request not well-formed." Q
 D UPDATER(.ERR,.FDA)
 L -^XHD(8935.91,PCDA)
 Q
UPDATER(ERR,FDA)        ; Call UPDATE^DIE to create pCats or subCats
 N IEN,MSG
 D UPDATE^DIE("E","FDA","IEN","MSG")
 I $D(MSG("DIERR")) S ERR="1^"_MSG("DIERR",1,"TEXT",1) Q
 S ERR="0^"_IEN(1)_U_IEN(1,0)
 Q
UPDATE(ERR,CATFLDS)     ; Call FILE^DIE to update ParameterCategory
 N XHDI,FDA,X S X="ONERROR^XHDPCAT",@^%ZOSF("TRAP")
 S XHDI="",ERR=0,PCDA=+$G(CATFLDS("IEN"))
 I $S('PCDA:1,'$D(^XHD(8935.91,PCDA,0)):1,1:0) D  Q
 . S ERR="1^Invalid ID passed."
 F  S XHDI=$O(CATFLDS(XHDI)) Q:+XHDI'>0  D
 . S FDA($$GETFILE(XHDI),$$GETUPIEN(PCDA,XHDI),$$GETORI(XHDI))=CATFLDS(XHDI)
 I $D(FDA)'>9 S ERR="1^Request not well-formed." Q
 D UPDATER(.ERR,.FDA)
 Q
REMPARAM(ERR,PDEF,PCDA) ; Remove Parameter from Category
 N XHDSDA,XHDI,FDA,X S X="ONERROR^XHDPCAT",@^%ZOSF("TRAP")
 S XHDI="",ERR=0
 I $S('+$G(PCDA):1,'$D(^XHD(8935.91,PCDA,0)):1,1:0) D  Q
 . S ERR="1^Invalid ID passed."
 S XHDSDA=$O(^XHD(8935.91,PCDA,2,"C",PDEF,0))
 I +XHDSDA S FDA(8935.912,XHDSDA_","_PCDA_",",.01)="@"
 I $D(FDA)'>9 S ERR="1^Parameter "_PDEF_" not found in Category "_PCDA_"." Q
 D FILER(.ERR,.FDA,PCDA)
 Q
REMOVE(ERR,PCAT,PARENT) ; Remove Parameter Category from parent
 N XHDSDA,FDA,X S XHDSDA=0,X="ONERROR^XHDPCAT",@^%ZOSF("TRAP")
 ; remove reference to parent
 S FDA(8935.91,PCAT_",",.04)="@"
 ; remove PCAT from parent's subCat multiple
 S XHDSDA=$O(^XHD(8935.91,PARENT,3,"C",PCAT,0))
 I +XHDSDA S FDA(8935.913,XHDSDA_","_PARENT_",",.01)="@"
 I $D(FDA)'>9 S ERR="1^Sub-category not found in Parent Category." Q
 D FILER(.ERR,.FDA,PARENT)
 Q
DELETE(ERR,PCAT,DELKIDS) ; Delete Parameter Category and all descendents
 N X,FDA,PARENT S X="ONERROR^XHDPCAT",@^%ZOSF("TRAP"),ERR=0
 ; if DELKIDS, remove descendents first
 I +$G(DELKIDS) D  Q:+ERR
 . N XHDI S XHDI=0
 . F  S XHDI=$O(^XHD(8935.91,PCAT,3,XHDI)) Q:+XHDI'>0!+ERR  D
 . . N XHDSDA S XHDSDA=$P($G(^XHD(8935.91,PCAT,3,XHDI,0)),U,2)
 . . I '+XHDSDA S ERR="1^Corrupt Sub-category at PCat #"_PCAT_", seq #"_XHDI Q
 . . D DELETE(.ERR,XHDSDA,1)
 ;Remove the sub-category from its parent prior to deletion
 S PARENT=$P($G(^XHD(8935.91,PCAT,0)),U,4)
 I +PARENT D REMOVE(.ERR,PCAT,PARENT)
 ; delete record
 S FDA(8935.91,PCAT_",",.01)="@"
 I $D(FDA)'>9 S ERR="1^Request not well-formed." Q
 D FILER(.ERR,.FDA,PCAT)
 Q
FILER(ERR,FDA,XHDDA)    ; Call FILE^DIE with FDA to post changes
 I $D(FDA)'>9 S ERR="1^Request not well-formed." Q
 L +^XHD(8935.91,XHDDA):1
 E  D  Q
 . S ERR="1^Another process is modifying Category #"_XHDDA
 D FILE^DIE("E","FDA","MSG")
 L -^XHD(8935.91,XHDDA)
 I $D(MSG("DIERR")) S ERR="1^"_MSG("DIERR",1,"TEXT",1) Q
 S ERR="0^"_XHDDA
 Q
ONERROR ; Trap errors
 S ERR="1^"_$TR($$EC^%ZOSV,"^","~")
 D ^%ZTER
 Q
GETUPIEN(PCDA,XHDI)      ; Get IENS for UPDATE call
 Q $S($L(XHDI,U)=3:"?+"_$P(XHDI,U,2)_","_PCDA_",",1:PCDA_",")
GETFILE(XHDI)    ; Get first subscript for FDA
 Q $S($P(XHDI,U)=2:8935.912,$P(XHDI,U)=3:8935.913,1:8935.91)
GETIENS(XHDI)    ; Get IENS for UPDATE^DIE call
 I $L(XHDI,U)=3 D
 . S LASTI=LASTI+$S($P(XHDI,U)'=LASTS:1,$P(XHDI,U,2)'=LASTN:1,1:0)
 . S LASTS=$P(XHDI,U),LASTN=$P(XHDI,U,2)
 Q $S($L(XHDI,U)=3:"?+"_LASTI_",?+1,",1:"?+1,")
GETORI(XHDI)     ; Get field subscript for FDA
 Q $S($L(XHDI,U)=3:$P(XHDI,U,3),1:XHDI)
