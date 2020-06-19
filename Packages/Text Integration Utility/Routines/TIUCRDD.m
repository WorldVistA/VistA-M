TIUCRDD ;SPFO/AJB - Create Document Definitions ;May 18, 2020@08:11:43
 ;;1.0;TEXT INTEGRATION UTILITIES;**331**;Jun 20, 1997;Build 6
 ;
 ; $$FIND1^DIC     ICR#2051          UPDATE^DIE     ICR#2053
 ;  $$GET1^DIQ     ICR#2056           $$NOW^XLFDT   ICR#10103
 ;    $$UP^XLFSTR  ICR#10104            MES^XPDUTL  ICR#10141
 Q
CRDD(NAME,TYPE,STATUS,PARENT,STDTTL) ; create a TIU Document Definition in 8925.1
 ; NAME   - "Example Title"            TYPE   - Class "CL", Document Class "DC", (Document) Title "DOC"
 ; STATUS - Active 11, Inactive 13     PARENT - name or IEN of desired parent 8925.1
 ;                                     STDTTL - name or IEN of enterprise standard title 8926.1
 ; verify arguments
 S NAME=$$UP^XLFSTR($G(NAME)) I NAME="" Q "0^NAME missing."
 I '+NAME,$A($E(NAME))<65!($A($E(NAME))>90) Q "0^NAME must not start with punctuation."
 I $L(NAME)<3!($L(NAME)>60) Q "0^NAME must be 3-60 characters"
 ; check TYPE
 S TYPE=$$UP^XLFSTR($G(TYPE))
 S TYPE=$S(TYPE="CLASS":"CL",TYPE="DOCUMENT CLASS":"DC",TYPE="TITLE":"DOC",TYPE="CL":"CL",TYPE="DC":"DC",TYPE="DOC":"DOC",1:"0^TYPE incorrect/missing.")
 I $P(TYPE,U)=0 Q TYPE
 ; set screen
 N SCR S SCR="I $P(^(0),U,4)="_""""_TYPE_""""
 ; check NAME
 I +$$LU(8925.1,NAME,"X",SCR) Q "0^"_NAME_" "_$S(TYPE="CL":"Class",TYPE="DC":"Document Class",1:"Title")_" already exists in 8925.1."
 ; check STATUS
 S STATUS=$$UP^XLFSTR($G(STATUS))
 S STATUS=$S(STATUS="ACTIVE":11,STATUS="INACTIVE":13,STATUS=11:11,STATUS=13:13,1:"0^STATUS incorrect/missing.")
 I $P(STATUS,U)=0 Q STATUS
 ; check PARENT
 S PARENT=$$UP^XLFSTR($G(PARENT)) D  I '+PARENT Q PARENT
 . I PARENT="" S PARENT="0^PARENT missing." Q
 . I +PARENT S PARENT=$S($$GET1^DIQ(8925.1,PARENT,.01)'="":PARENT,1:"0^Invalid IEN for PARENT.") Q
 . S PARENT=$$LU(8925.1,PARENT,"X"),PARENT=$S(+PARENT:PARENT,1:"0^PARENT not found.")
 I $$GET1^DIQ(8925.1,PARENT_",",.07,"I")=13 S STATUS=13 ; if parent is inactive, set child inactive
 I TYPE="CL",$$GET1^DIQ(8925.1,PARENT_",",.04,"I")'="CL" Q "0^PARENT must be CL for a new Class."
 I TYPE="DC",$$GET1^DIQ(8925.1,PARENT_",",.04,"I")="DOC" Q "0^PARENT must be CL/DC for a new Document Class."
 I TYPE="DOC",$$GET1^DIQ(8925.1,PARENT_",",.04,"I")'="DC" Q "0^PARENT must be DC for a new Document Title."
 ; check STDTTL
 I TYPE="DOC" S STDTTL=$$UP^XLFSTR($G(STDTTL)) D
 . I STDTTL="" S STDTTL="0^ENTERPRISE STANDARD TITLE not sent." Q
 . I +STDTTL S STDTTL=$S($$GET1^DIQ(8926.1,STDTTL,.01)'="":STDTTL,1:"0^Invalid IEN for ENTERPRISE STANDARD TITLE.") Q
 . S STDTTL=$$LU(8926.1,STDTTL,"X"),STDTTL=$S(+STDTTL:STDTTL,1:"0^Invalid NAME for ENTERPRISE STANDARD TITLE.")
 I TYPE="DOC",'+STDTTL D
 . D MES^XPDUTL("Failed to map: "_NAME_" because "_$P(STDTTL,U,2)),MES^XPDUTL("") S STDTTL=""
 . I STATUS=11 D MES^XPDUTL("STATUS will be set to INACTIVE."),MES^XPDUTL("") S STATUS=13
 ; set owner
 N OWNER S OWNER=$$LU(8930,"CLINICAL COORDINATOR","X") Q:'+OWNER "0^CLINICAL COORDINATOR class not found."
 N DA,FDA,ERR,IEN
 S FDA(8925.1,"+1,",.01)=NAME
 S FDA(8925.1,"+1,",.03)=NAME
 S FDA(8925.1,"+1,",.04)=TYPE
 S FDA(8925.1,"+1,",.06)=OWNER
 S FDA(8925.1,"+1,",.07)=STATUS
 I TYPE="DOC" D
 . S FDA(8925.1,"+1,",1501)=$G(STDTTL)
 . S FDA(8925.1,"+1,",1502)=$$NOW^XLFDT
 . S FDA(8925.1,"+1,",1503)=DUZ
 S FDA(8925.1,"+1,",99)=$H
 D UPDATE^DIE("","FDA","IEN","ERR") S DA=IEN(1)
 D ATTACH(PARENT,DA)
 Q $G(DA,0)
ATTACH(PARENT,CHILD) ;
 N FDA,IEN,ERR
 S FDA(8925.14,"+2,"_PARENT_",",.01)=CHILD
 S FDA(8925.14,"+2,"_PARENT_",",4)=$$GET1^DIQ(8925.1,CHILD,.01)
 D UPDATE^DIE("","FDA","IEN","ERR")
 Q
LU(FILE,NAME,FLAGS,SCREEN,INDEXES) ;
 Q $$FIND1^DIC(FILE,"",$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN),"ERR")
