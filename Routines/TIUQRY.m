TIUQRY ; SLC/JER/CAM - Queries for Documents Across Patients ;3/27/03  16:15
 ;;1.0;TEXT INTEGRATION UTILITIES;**150**;Jun 20, 1997
QUERY(TIUY,QRY,PATIENT) ; Execute Query
 N TIUPRM0,TIUPRM1,TIUPRM3,FLAGA,FLAGV S FLAGA=0,FLAGV=0
 D SETPARM^TIULE
 I '+$G(PATIENT("Patient.DFN")) S @TIUY@(0,"Documents")="0^ Patient not specified" Q
 I '$O(QRY("Status",0)) D STATUS(.QRY)
 I '$O(QRY("Title",0)),'$O(QRY("Class",0)) S @TIUY@(0,"Documents")="0^ Title or Class not specified" Q
 I $O(QRY("Author",0)) S FLAGA=1
 I $O(QRY("Location",0)) S FLAGV=1
 D CHECKADD(.QRY)
 D GATHER(TIUY,.QRY,.PATIENT,FLAGA,FLAGV)
 K @TIUY@("INDX")
 Q
 ;
GATHER(TIUY,QRY,PATIENT,FLAGA,FLAGV) ; Find/sort records for the list
 N DFN,EARLY,LATE,RANGE,TIUC
 S TIUC=0
 S RANGE=$O(QRY("Reference",""))
 S DFN=+$G(PATIENT("Patient.DFN"))
 S EARLY=9999999-$P(RANGE,":")
 S LATE=9999999-$P(RANGE,":",2)
 I $O(QRY("Title",0)) D
 .N GVN S GVN=$NA(^TIU(8925,"APT",DFN))
 .N TIUT S TIUT=0
 .F  S TIUT=$O(QRY("Title",TIUT)) Q:+TIUT'>0  D
 ..N TIUS S TIUS=0
 ..F  S TIUS=$O(QRY("Status",TIUS)) Q:+TIUS'>0  D
 ...N TIUJ S TIUJ=LATE
 ...F  S TIUJ=$O(@GVN@(TIUT,TIUS,TIUJ)) Q:+TIUJ'>0!(+TIUJ>EARLY)  D
 ....N TIUDA
 ....S TIUDA=0 F  S TIUDA=$O(@GVN@(TIUT,TIUS,TIUJ,TIUDA)) Q:+TIUDA'>0  D
 .....I FLAGA=0,FLAGV=0 D FOUNDTL(TIUY,TIUDA,.QRY,.PATIENT,.TIUC)
 .....I FLAGA=1,FLAGV=0,$$AUTHOR(TIUDA,.QRY) D FOUNDTL(TIUY,TIUDA,.QRY,.PATIENT,.TIUC)
 .....I FLAGA=0,FLAGV=1,$$VISIT(TIUDA,.QRY) D FOUNDTL(TIUY,TIUDA,.QRY,.PATIENT,.TIUC)
 .....I FLAGA=1,FLAGV=1,$$AUTHOR(TIUDA,.QRY),$$VISIT(TIUDA,.QRY) D FOUNDTL(TIUY,TIUDA,.QRY,.PATIENT,.TIUC)
 I $O(QRY("Class",0)) D
 .N TIUCC S TIUCC=0
 .F  S TIUCC=$O(QRY("Class",TIUCC)) Q:TIUCC'>0  D STATCHK(TIUCC,.QRY,.TIUC,.DFN,.EARLY,.LATE,.FLAGA)
 S @TIUY@(0,"Documents")=TIUC
 Q
 ;
ACLSB(TIUCC,QRY,TIUC,DFN,EARLY,LATE,FLAGA) ; Using the ACLSB cross reference for a status of > 5 
 N TIUAUTH S TIUAUTH=0
 F  S TIUAUTH=$O(^TIU(8925,"ACLSB",TIUCC,TIUAUTH)) Q:(TIUAUTH'>0)  D
 .Q:(FLAGA=1)&'$$AUTHDOC(TIUAUTH,.QRY)
 .N GVN S GVN=$NA(^TIU(8925,"ACLSB",TIUCC,TIUAUTH,DFN))
 .N TIUD S TIUD=LATE
 .F  S TIUD=$O(@GVN@(TIUD)) Q:TIUD'>0!(TIUD>EARLY)  D
 ..N TIUDA S TIUDA=0
 ..F  S TIUDA=$O(@GVN@(TIUD,TIUDA)) Q:TIUDA'>0  D
 ...I FLAGV=0,$$STAT(TIUDA,.QRY) D FOUNDDC(TIUY,TIUDA,.QRY,.PATIENT,.TIUC)
 ...I FLAGV=1,$$VISIT(TIUDA,.QRY),$$STAT(TIUDA,.QRY) D FOUNDDC(TIUY,TIUDA,.QRY,.PATIENT,.TIUC)
 Q
 ;
ACLAU(TIUCC,QRY,TIUC,DFN,EARLY,LATE,FLAGA) ; Using the ACLAU cross reference for a status of < 6
 N TIUAUTH S TIUAUTH=0
 F  S TIUAUTH=$O(^TIU(8925,"ACLAU",TIUCC,TIUAUTH)) Q:(TIUAUTH'>0)  D
 .Q:(FLAGA=1)&'$$AUTHDOC(TIUAUTH,.QRY)
 .N GVN S GVN=$NA(^TIU(8925,"ACLAU",TIUCC,TIUAUTH,DFN))
 .N TIUD S TIUD=LATE
 .F  S TIUD=$O(@GVN@(TIUD)) Q:TIUD'>0!(TIUD>EARLY)  D
 ..N TIUDA S TIUDA=0
 ..F  S TIUDA=$O(@GVN@(TIUD,TIUDA)) Q:TIUDA'>0  D
 ...I FLAGV=0,$$STAT(TIUDA,.QRY) D FOUNDDC(TIUY,TIUDA,.QRY,.PATIENT,.TIUC)
 ...I FLAGV=1,$$VISIT(TIUDA,.QRY),$$STAT(TIUDA,.QRY) D FOUNDDC(TIUY,TIUDA,.QRY,.PATIENT,.TIUC)
 Q
 ;
STATCHK(TIUCC,QRY,TIUC,DFN,EARLY,LATE,FLAGA) ; Check status(es) entered by user. Cross ref used depends on status of doc.
 N TIUS S TIUS=0
 F  S TIUS=$O(QRY("Status",TIUS)) Q:TIUS'>0  D
 .I TIUS>5 D ACLSB(TIUCC,.QRY,.TIUC,.DFN,.EARLY,.LATE,.FLAGA)
 .I TIUS<6 D ACLAU(TIUCC,.QRY,.TIUC,.DFN,.EARLY,.LATE,.FLAGA)
 Q
 ;
FOUNDTL(TIUY,TIUDA,QRY,PATIENT,TIUC) ;Sort by title, resolves document found
 I TIUT=81,'$$DADINTYP(TIUDA,.QRY) Q
 D RESOLVE^TIUQRYL(TIUY,TIUDA,.QRY,.PATIENT)
 S @TIUY@("INDX",TIUDA)="",TIUC=TIUC+1
 Q
 ;
FOUNDDC(TIUY,TIUDA,QRY,PATIENT,TIUC) ;Sort by document, resolves document found
 I $D(@TIUY@("INDX",TIUDA)) Q  ; Don't set up if already exists
 D RESOLVE^TIUQRYL(TIUY,TIUDA,.QRY,.PATIENT)
 S @TIUY@("INDX",TIUDA)="",TIUC=TIUC+1
 Q
 ;
STAT(TIUDA1,QRY) ; Determines status of document then checks to see if
 ; status is included in the status list selected for query.
 ; TIUS=Status of document
 N TIUS1,CHECK,TIUS S TIUS1=0,CHECK="",TIUS=0
 ; CHECK returned as 1 if the status was selected in query.
 S TIUS1=$P($G(^TIU(8925,TIUDA1,0)),U,5)
 F  S TIUS=$O(QRY("Status",TIUS)) Q:TIUS'>0  I TIUS=TIUS1 S CHECK=1
 Q CHECK
 ;
AUTHDOC(TIUAUTH1,QRY) ; Checks to see if the author of the note being evaluated is
 ; included in the author list selected for query.
 N CHECK,TIUAUTH2
 ; CHECK returned as 1 if the author was selected in query.
 S CHECK="",TIUAUTH2=0
 F  S TIUAUTH2=$O(QRY("Author",TIUAUTH2)) Q:TIUAUTH2'>0!+CHECK  I TIUAUTH2=TIUAUTH1 S CHECK=1
 Q CHECK
 ;
AUTHOR(TIUDA1,QRY) ; Determines author of document then checks to see if author
 ; is included in the author list selected for query.
 N TIUAUTH,TIUAUTH1,CHECK S TIUAUTH=0,TIUAUTH1=0,CHECK=""
 S TIUAUTH1=$P($G(^TIU(8925,TIUDA1,12)),U,2)
 F  S TIUAUTH=$O(QRY("Author",TIUAUTH)) Q:TIUAUTH'>0!+CHECK  I TIUAUTH=TIUAUTH1 S CHECK=1
 Q CHECK
 ;
VISIT(TIUDA1,QRY) ; Checks location of visit then checks to see if location is included
 ; in the location list selected for query.
 N TIUVST,TIUVST1,CHECK S TIUVST=0,TIUVST1=0,CHECK=0
 S TIUVST1=$P($G(^TIU(8925,TIUDA1,12)),U,5)
 F  S TIUVST=$O(QRY("Location",TIUVST)) Q:TIUVST'>0!+CHECK  I TIUVST=TIUVST1 S CHECK=1
 Q CHECK
 ;
DADINTYP(TIUDA,QRY) ; Evaluates whether addendum's parent belongs is among
 ;                 the selected types
 N TIUI,TIUDTYP,TIUY S (TIUI,TIUY)=0
 S TIUDTYP=+$G(^TIU(8925,+$P($G(^TIU(8925,+TIUDA,0)),U,6),0))
 F  S TIUI=$O(QRY("Title",TIUI)) Q:+TIUI'>0!+TIUY  D
 . S:TIUI=TIUDTYP TIUY=1
 Q TIUY
 ;
CHECKADD(QRY) ; Assures that Addendum is included in the list of types
 S QRY("Title",81)=""
 Q
 ;
STATUS(QRY) ; Gets status(es)
 N TIUI,TIUS,STATUS S (TIUI,TIUS)=0
 S STATUS=""
 F  S STATUS=$O(^TIU(8925.6,"B",STATUS)) Q:STATUS=""  D
 .S TIUS=0
 .F  S TIUS=$O(^TIU(8925.6,"B",STATUS,TIUS)) Q:+TIUS'>0  D
 ..S:($P(^TIU(8925.6,+TIUS,0),U,4)'="DEF") QRY("Status",TIUS)=""
 Q
