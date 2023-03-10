VAFCAPI ;BIR/DRI - MVI API ENTRY POINTS ;5/18/22  09:21
 ;;5.3;Registration;**1071**;Aug 13, 1993;Build 4
 ;
 ;Supports IA #7323, Private subscription
 ;
 ;Reference to $$DT^XLFDT supported by IA# 10103
 ;Reference to ^TIU(8925 supported by IA#3376
 ;
SOGI(DFN,ARRAY,UPDATE) ;api for cprs to update sexual orientation and gender identity trait fields ;**1071, VAMPI-13755 (dri)
 ;
 ;  Business Rules:
 ;  ALL of a Patient's Sexual Orientations must be sent
 ;  Once defined, Sexual Orientations can NOT be deleted, the status must be updated
 ;  Sexual Orientation Date Created will default to today on an add
 ;  Sexual Orientation Date Last Updated will default to today on an add or update
 ;  Sexual Orientation Description added/updated when Sexual Orientation
 ;   of 'Other' has a Status of 'A'ctive, otherwise it's deleted.
 ;
 ;  When a TIU NOTE is passed to be deleted:
 ;   If the site has received more recent sexual orientation updates the NOTE
 ;   is deleted and no further updating of the sexual orientation data occures.
 ;   If no recent sexual orientation updates have been received but previous
 ;   updates exist then roll back to that data
 ;
 ;
 ;*To Add/Update a Patient's Sexual Orientation Data:
 ;  DFN = pointer to entry in PATIENT (#2) file (required)
 ;  ARRAY("SexOr",n) = sexual orientation code^status^note
 ;    n - counter
 ;    sexual orientation code - list of code(s) from the SEXUAL ORIENTATION TYPES (#47.77) file (required)
 ;    status - current status of the sexual orientation (A/I) (required)
 ;    note - note ien from the TIU DOCUMENT (#8925) file (optional)
 ;  ARRAY("SexOrDes") = description for the selected 'Other' sexual orientation
 ;  UPDATE = 1 to file data, else data is only validated (optional)
 ;
 ; Returns:
 ;  0 - if update is successful
 ; -1^error message - if unsuccessful
 ;
 ; Example:
 ;  S DFN=100006920
 ;  S ARRAY("SexOr",1)="BIS^I^5"
 ;  S ARRAY("SexOr",2)="OTH^A"
 ;  S ARRAY("SexOr",3)="STH^A"
 ;  S ARRAY("SexOrDes")="SEXUAL ORIENTATION DESCRIPTION TEXT"
 ;  S RET=$$SOGI^VAFCAPI(DFN,.ARRAY)   - to validate data
 ;  S RET=$$SOGI^VAFCAPI(DFN,.ARRAY,1) - to file data
 ;  
 ;
 ;*To Delete a Patient's TIU NOTE:
 ;  DFN = pointer to entry in PATIENT (#2) file (required)
 ;  ARRAY("Note") = pointer to entry in TIU DOCUMENT (#8925) (required)
 ;  UPDATE = 1 to file data, else data is only validated (optional)
 ;
 ; Returns:
 ;  0 - if update is successful
 ; -1^error message - if unsuccessful
 ;
 ; Example:
 ;  S DFN=100006920
 ;  S ARRAY("Note")=2
 ;  S RET=$$SOGI^VAFCAPI(DFN,.ARRAY)   - to validate data
 ;  S RET=$$SOGI^VAFCAPI(DFN,.ARRAY,1) - to file data
 ;  
 ;
 I '$G(DFN) Q "-1^invalid DFN passed to api"
 I '$D(^DPT(DFN,0)) Q "-1^entry does not exist in Patient file"
 I $D(^DPT(DFN,-9)) Q "-1^merged patient"
 ;
 I $G(UPDATE)'=1 S UPDATE=0 ;should data be filed
 ;
 N TODAY
 S TODAY=$$DT^XLFDT
 ;
 I $G(ARRAY("Note")) Q $$NOTE(DFN,.ARRAY,UPDATE)
 Q $$SEXOR(DFN,.ARRAY,UPDATE)
 ;
 ;
SEXOR(DFN,ARRAY,UPDATE) ;process incoming sexual orientation and sexual orientation description
 N CD,CUR,ERROR,FDA,INC,NOTE,RES,SEQ,STATUS,VAFCERR
 S ERROR=0
 ;
 ;loop through incoming sexual orientations, validate data, build list, ignore if passed with 'error' status
 S SEQ=0 F  S SEQ=$O(ARRAY("SexOr",SEQ)) Q:'SEQ  I $P($G(ARRAY("SexOr",SEQ)),"^",2)'="E" D  I ERROR Q
 .S CD=$P($G(ARRAY("SexOr",SEQ)),"^",1) D CHK^DIE(2.025,.01,,CD,.RES,"VAFCERR") I RES="^" S ERROR="-1^"_$$BLDERR("VAFCERR") Q  ;validate sexual orientation code
 .S STATUS=$P($G(ARRAY("SexOr",SEQ)),"^",2) D CHK^DIE(2.025,.02,,STATUS,.RES,"VAFCERR") I RES="^" S ERROR="-1^"_$$BLDERR("VAFCERR") Q  ;validate status
 .S NOTE=$P($G(ARRAY("SexOr",SEQ)),"^",3) I NOTE'="",'$D(^TIU(8925,NOTE,0)) S ERROR="-1^Invalid TIU NOTE IEN" Q  ;validate tiu note ien
 .S INC(CD)=SEQ ;build incoming list
 I ERROR Q ERROR
 ;
 ;validate sexual orientation description
 I $G(ARRAY("SexOrDes"))'="" D
 .D CHK^DIE(2,.0251,,ARRAY("SexOrDes"),.RES,"VAFCERR") I RES="^" S ERROR="-1^"_$$BLDERR("VAFCERR") Q
 .I $S('$D(INC("OTH")):1,$P($G(ARRAY("SexOr",+$G(INC("OTH")))),"^",2)'="A":1,1:0) S ERROR="-1^Sexual Orientation of 'Other' with 'Active' Status required to update 'SO' Description"
 I ERROR Q ERROR
 ;
 ;loop through current sexual orientations, validate data, build list
 S SEQ=0 F  S SEQ=$O(^DPT(DFN,.025,SEQ)) Q:'SEQ  S CD=$$GET1^DIQ(47.77,+$P(^DPT(DFN,.025,SEQ,0),"^",1)_",",1) I CD'="" D  I ERROR Q
 .I '$D(INC(CD)),$P($G(^DPT(DFN,.025,SEQ,0)),"^",2)'="E"  S ERROR="-1^Patient currently has more Sexual Orientations defined, entire list must be passed" ;errored 'so' not passed
 .S CUR(CD)=SEQ ;build current list, must included 'errored' so duplicates aren't built
 I ERROR Q ERROR
 ;
 ;loop through incoming values
 S CD="" F  S CD=$O(INC(CD)) Q:CD=""  D
 .I '$D(CUR(CD)) D  ;if not in current array set fda for an add
 ..S FDA(2.025,"+"_INC(CD)_","_DFN_",",.01)=CD ;sexual orientation
 ..S FDA(2.025,"+"_INC(CD)_","_DFN_",",.02)=$P(ARRAY("SexOr",INC(CD)),"^",2) ;status
 ..S FDA(2.025,"+"_INC(CD)_","_DFN_",",.03)=TODAY ;date created
 ..S FDA(2.025,"+"_INC(CD)_","_DFN_",",.04)=TODAY ;date last updated
 ..I $P(ARRAY("SexOr",INC(CD)),"^",3) S FDA(2.025,"+"_INC(CD)_","_DFN_",",.05)="`"_$P(ARRAY("SexOr",INC(CD)),"^",3) ;note
 ..S FDA(2.025,"+"_INC(CD)_","_DFN_",",.06)="L" ;type of update - 'l'ocal
 .;
 .I $D(CUR(CD)) D  ;if in current array set fda for an update
 ..I $P($G(^DPT(DFN,.025,CUR(CD),0)),"^",2)'=$P(ARRAY("SexOr",INC(CD)),"^",2) S FDA(2.025,CUR(CD)_","_DFN_",",.02)=$P(ARRAY("SexOr",INC(CD)),"^",2) ;status change
 ..I $P($G(^DPT(DFN,.025,CUR(CD),0)),"^",3)="" S FDA(2.025,CUR(CD)_","_DFN_",",.03)=TODAY ;date created if null
 ..I $P($G(^DPT(DFN,.025,CUR(CD),0)),"^",4)'=TODAY S FDA(2.025,CUR(CD)_","_DFN_",",.04)=TODAY ;date last updated always updated to today
 ..I $P($G(^DPT(DFN,.025,CUR(CD),0)),"^",5)'=$P(ARRAY("SexOr",INC(CD)),"^",3) S FDA(2.025,CUR(CD)_","_DFN_",",.05)=$S($P(ARRAY("SexOr",INC(CD)),"^",3):"`"_$P(ARRAY("SexOr",INC(CD)),"^",3),1:"@") ;note
 ..I $P($G(^DPT(DFN,.025,CUR(CD),0)),"^",6)'="L" S FDA(2.025,CUR(CD)_","_DFN_",",.06)="L" ;type of update - 'l'ocal
 ;
 ;current business rules don't allow sexual orientation deletions for any reason
 ;loop through current values, if not in incoming array set FDA to delete
 ;S CD="" F  S CD=$O(CUR(CD)) Q:CD=""  I '$D(INC(CD)) S FDA(2.025,CUR(CD)_","_DFN_",",.01)="@"
 ;
 ;process sexual orientation description,set fda to add/update/delete
 I '$D(INC("OTH")),$$GET1^DIQ(2,DFN_",",.0251)'="" S FDA(2,DFN_",",.0251)="@" ;delete a previously filed sexual orientation description if no 'so' of 'Other'
 I $D(INC("OTH")) D
 .I $P(ARRAY("SexOr",+INC("OTH")),"^",2)'="A",$$GET1^DIQ(2,DFN_",",.0251)'="" S FDA(2,DFN_",",.0251)="@" Q  ;delete a previously filed sexual orientation description if status of incoming 'so' of 'Other' isn't active
 .I $P(ARRAY("SexOr",+INC("OTH")),"^",2)="A",$G(ARRAY("SexOrDes"))'="",ARRAY("SexOrDes")'=$$GET1^DIQ(2,DFN_",",.0251) S FDA1(2,DFN_",",.0251)=ARRAY("SexOrDes") ;add/update sexual orientation description since 'so' of 'Other' is active
 ;
 I UPDATE D  I ERROR Q ERROR
 .I $D(FDA) S ERROR=$$UPDATE(.FDA) I ERROR Q  ;file sexual orientation data
 .I $D(FDA1) S ERROR=$$UPDATE(.FDA1) ;file sexual orientation description separately so 'ahist' x-ref is properly built
 ;
 Q ERROR
 ;
 ;
NOTE(DFN,ARRAY,UPDATE) ;tiu note deletion
 N ERROR,FDA,FDA1,GLO,LDLUP,NOTE,PREV,SEQ,SEQL
 S ERROR=0
 ;
 S NOTE=ARRAY("Note")
 ;I '$D(^TIU(8925,NOTE,0)) S ERROR="-1^Invalid TIU NOTE IEN" Q  ;validate tiu note ien - no need to validate, could have already been deleted before calling api
 S SEQ=0 F  S SEQ=$O(^DPT(DFN,.025,SEQ)) Q:'SEQ  I $P($G(^DPT(DFN,.025,SEQ,0)),"^",5)=NOTE S FDA(2.025,SEQ_","_DFN_",",.05)="@",SEQL(SEQ)="" ;delete note from entries, keep list of modified sequences
 S GLO="^DPT(DFN,.025,""AHIST"")" F  S GLO=$Q(@GLO) Q:GLO=""  Q:($QS(GLO,3)'="AHIST")  I $P(@GLO,"^",1)=NOTE S LDLUP=$QS(GLO,4) ;find most recent (last) date last update in history x-ref with tiu note, 'so' could already have a newer tiu note
 I '$D(FDA)&'$G(LDLUP) S ERROR="-1^TIU NOTE doesn't exist in Patient's Sexual Orientation History" Q ERROR
 I UPDATE,$D(FDA) S ERROR=$$UPDATE(.FDA) I ERROR Q  ;delete note, let fileman fire x-ref's
 I UPDATE S GLO="^DPT(DFN,.025,""AHIST"")" F  S GLO=$Q(@GLO) Q:GLO=""  Q:($QS(GLO,3)'="AHIST")  I $P(@GLO,"^",1)=NOTE K @GLO S SEQL($QS(GLO,6))="" ;delete orphaned x-ref with a tiu note, possibly missed due to 'so' already having newer note
 ;
 I $G(LDLUP) D  ;this is the last 'date last updated' history x-ref's removed
 .I $O(^DPT(DFN,.025,"AHIST",LDLUP)) Q  ;more recent history exists in x-ref so don't update anything, since all 'so's always updated, no need to look at just modified 'so's
 .;
 .I $O(^DPT(DFN,.025,"AHIST",LDLUP+1),-1) D  ;previous history exists, possibly from another site on the same day
 ..S GLO="^DPT(DFN,.025,""AHIST"",0)" F  S GLO=$Q(@GLO) Q:GLO=""  Q:$QS(GLO,3)'="AHIST"  Q:$QS(GLO,4)>LDLUP  I $QS(GLO,6),$D(SEQL($QS(GLO,6))) D  ;find most recent past history for modified 'so's
 ...S PREV($QS(GLO,6))=$QS(GLO,7)_"^"_$QS(GLO,8)_"^"_$QS(GLO,9)_"^"_$QS(GLO,4)_"^"_$P($G(@GLO),"^",1)_"^"_$QS(GLO,5)
 ...I $QS(GLO,7)=5 S PREV($QS(GLO,6),"SexOrDes")=$P($G(@GLO),"^",2) ;only set description if 'Other'
 .;
 .S SEQ=0 F  S SEQ=$O(SEQL(SEQ)) Q:'SEQ  D  ;only loop through the modified sexual orientations
 ..I $D(PREV(SEQ)) D  Q  ;if previous updates exist, roll back to how it looked
 ...I $P($G(^DPT(DFN,.025,SEQ,0)),"^",1)'=$P(PREV(SEQ),"^",1) S FDA(2.025,SEQ_","_DFN_",",.01)=$P(PREV(SEQ),"^",1) ;sexual orientation
 ...I $P($G(^DPT(DFN,.025,SEQ,0)),"^",2)'=$P(PREV(SEQ),"^",2) S FDA(2.025,SEQ_","_DFN_",",.02)=$P(PREV(SEQ),"^",2) ;status
 ...I $P($G(^DPT(DFN,.025,SEQ,0)),"^",3)'=$P(PREV(SEQ),"^",3) S FDA(2.025,SEQ_","_DFN_",",.03)=$P(PREV(SEQ),"^",3) ;date created
 ...I $P($G(^DPT(DFN,.025,SEQ,0)),"^",4)'=$P(PREV(SEQ),"^",4) S FDA(2.025,SEQ_","_DFN_",",.04)=$P(PREV(SEQ),"^",4) ;date last updated
 ...I $P($G(^DPT(DFN,.025,SEQ,0)),"^",5)'=$P(PREV(SEQ),"^",5) S FDA(2.025,SEQ_","_DFN_",",.05)=$S($P(PREV(SEQ),"^",5):"`"_$P(PREV(SEQ),"^",5),1:"@") ;note
 ...I $P($G(^DPT(DFN,.025,SEQ,0)),"^",6)'=$P(PREV(SEQ),"^",6) S FDA(2.025,SEQ_","_DFN_",",.06)=$P(PREV(SEQ),"^",6) ;type of update
 ...I $P($G(^DPT(DFN,.025,SEQ,0)),"^",1)=5,$P($G(^DPT(DFN,.241)),"^",1)'=$P(PREV(SEQ,"SexOrDes"),"^",1) S FDA1(2,DFN_",",.0251)=$S($P(PREV(SEQ,"SexOrDes"),"^",1)'="":$P(PREV(SEQ,"SexOrDes"),"^",1),1:"@") ;update sexual orientation description
 ..;
 ..I '$D(PREV(SEQ)) D  ;if previous updates did not exist then it was 'entered in error'
 ...S FDA(2.025,SEQ_","_DFN_",",.02)="E" ;status
 ...S FDA(2.025,SEQ_","_DFN_",",.04)=TODAY ;date last updated
 ...S FDA(2,DFN_",",.0251)="@" ;sexual orientation description (use fda instead of fda1 so it deletes prior to the fda1 from above filing)
 .;
 I UPDATE D  I ERROR Q ERROR
 .I $D(FDA) S ERROR=$$UPDATE(.FDA) I ERROR Q
 .I $D(FDA1) S ERROR=$$UPDATE(.FDA1) ;file sexual orientation description separately so 'ahist' x-ref is properly built
 ;
 Q ERROR
 ;
UPDATE(FDA) ;call update
 N VAFCERR
 I '$D(FDA) Q 0
 D UPDATE^DIE("E","FDA",,"VAFCERR")
 I $D(VAFCERR) Q "-1^"_$$BLDERR("VAFCERR")
 Q 0
 ;
 ;
BLDERR(MSGROOT) ;build error from FileMan error message array
 N ERRARR,ERRMSG,I
 D MSG^DIALOG("AE",.ERRARR,"","",MSGROOT)
 S ERRMSG="",I=0 F  S I=$O(ERRARR(I)) Q:'I  S ERRMSG=ERRMSG_$S(ERRMSG]"":" ",1:"")_$G(ERRARR(I))
 Q ERRMSG
 ;
 ;
SETSO ;set logic for 'AHIST' x-ref of Sexual Orientation Multiple (#.025) in Patient (#2) file
 I $S(X(2)="E":0,X(5)=""&(X1(5)'=""):0,1:1),X(1)'="",X(2)'="",X(3)'="",X(4)'="",X(6)'="" D  ;only set history when 'so' has a 'non-errored' status or tiu note not being deleted
 .S ^DPT(DA(1),.025,"AHIST",X(4),X(6),DA,X(1),X(2),X(3))=$S(X(6)="L":X(5),1:"") ;only local updates can have tiu notes
 Q
 ;
KILLSO ;kill logic for 'AHIST' x-ref of Sexual Orientation Multiple (#.025) in Patient (#2) file
 I $S(X(2)'=""&(X2(2)="E"):1,X(4)'=""&(X2(4)'="")&(X2(4)<X(4)):1,X(5)'=""&(X2(5)=""):1,1:0),X(1)'="",X(2)'="",X(3)'="",X(4)'="",X(6)'="" D  ;only kill history if status going to 'error', DLUP is 'rolling back' or tiu note is being deleted
 .;attempt to kill off both 'local' and 'remote' x-ref, sync from mpi will looklook like a 'remote' update 
 .K ^DPT(DA(1),.025,"AHIST",X(4),"L",DA,X(1),X(2),X(3)) ;kill 'local' x-ref
 .I $S(X(5)'=""&(X2(5)=""):0,1:1) K ^DPT(DA(1),.025,"AHIST",X(4),"R",DA,X(1),X(2),X(3)) ;kill 'remote' x-ref except on tiu note deletion, only 'local' can set/have a tiu note
 Q
 ;
SETSOD ;set logic for 'AHIST' x-ref of  Sexual Orientation Description (#.0251) in Patient (#2) file
 I X(1)'="" N XX,XXDA0,XXDA S XXDA=$O(^DPT(DA,.025,"B",5,0)) I XXDA,$P($G(^DPT(DA,.025,XXDA,0)),"^",2)="A" S XXDA0=^(0) D  ;only active sexual orientation 'Other' can have a description
 .F XX=1:1:6 S XX(XX)=$P(XXDA0,"^",XX)
 .I XX(1)'="",XX(2)'="",XX(3)'="",XX(4)'="",XX(6)'="",$D(^DPT(DA,.025,"AHIST",XX(4),XX(6),XXDA,XX(1),XX(2),XX(3))) S $P(^(XX(3)),"^",2)=X(1)
 Q
 ;
KILLSOD ;kill logic for 'AHIST' x-ref of Sexual Orientation Description (#.0251) in Patient (#2) file
 N XX,XXDA0,XXDA S XXDA=$O(^DPT(DA,.025,"B",5,0)) I XXDA S XXDA0=$G(^DPT(DA,.025,XXDA,0)) D
 .F XX=1:1:6 S XX(XX)=$P(XXDA0,"^",XX)
 .I XX(1)'="",XX(2)'="",XX(3)'="",XX(4)'="",XX(6)'="",$D(^DPT(DA,.025,"AHIST",XX(4),XX(6),XXDA,XX(1),XX(2),XX(3))) S $P(^(XX(3)),"^",2)=""
 Q
 ;
