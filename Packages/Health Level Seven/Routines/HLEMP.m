HLEMP ;ALB/CJM-HL7 - APIs for Monitor Events Log Profiles  ;07/10/2003
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
FDEFAULT(DUZ) ;
 ;Description: Given a DUZ, returns the default profile, or "" on failure
 ;
 Q:'$G(DUZ) 0
 Q $O(^HLEV(776.5,"AC",DUZ,0))
 ;
 Q $S(Y=-1:0,1:+Y)
 ;
GET(IEN,PROFILE) ;
 ;Description - given the ien, it returns an array containing the profile
 ;Input:
 ;  IEN - ien of the profile
 ;Output:
 ;  function returns 0 on failure, 1 on success
 ;  PROFILE(   **pass by reference**
 ;  "ALL APPS" - 1 if all sending applications should be included, 0 otherwise
 ;  "ALL SITES" - 1 if all sites should be included, 0 otherwise
 ;  "ALL STATUSES" 1 if all review statuses should be included, 0 otherwise
 ;  "ALL TYPES" - 1 if all event types should be included, 0 otherwise
 ;  "APPS",<HL7 APPLICATION PARAMETER>) -list of sending applications to include - NOT the iens, but the names of the HL7 Application Parameter
 ;  "DUZ" - the duz of the profile's owner
 ;  "DEFAULT" - 1 if this is the default profile, 0 if it isn't
 ;  "IEN" - ien of the profile
 ;  "NAME" - name of the profile
 ;  "SITES",<institution ien>) - list of institution numbers to include
 ;  "START" - starting date/time for selecting events for display, in FM format
 ;  "STATUSES",<review status code>) - list of review status codes to include
 ;  "TYPES",<HL7 MONITOR EVENT TYPE>) - list of event type iens
 ;  "URGENT" - 1 means urgent only, 0 means disregard urgency
 ;
 ;
 Q:'$G(IEN) 0
 N NODE,SITE,TYPE,APP,STATUS,APPNAME,I
 K PROFILE S PROFILE=IEN
 S NODE=$G(^HLEV(776.5,IEN,0))
 Q:'$L(NODE) 0
 S PROFILE("IEN")=IEN
 S PROFILE("DUZ")=+NODE
 S PROFILE("NAME")=$P(NODE,"^",2)
 S PROFILE("DEFAULT")=$P(NODE,"^",3)
 S PROFILE("ALL SITES")=$P(NODE,"^",4)
 S PROFILE("ALL TYPES")=$P(NODE,"^",5)
 S PROFILE("ALL APPS")=$P(NODE,"^",6)
 S PROFILE("ALL STATUSES")=$P(NODE,"^",7)
 S START=+$P(NODE,"^",8) D
 .N NOW
 .S NOW=$$NOW^XLFDT
 .S PROFILE("START")=0
 .I START=1 S PROFILE("START")=$$FMADD^XLFDT(NOW,,-1) Q
 .I START=2 S PROFILE("START")=$$FMADD^XLFDT(NOW,,-2) Q
 .I START=3 S PROFILE("START")=$$FMADD^XLFDT(NOW,,-6) Q
 .I START=4 S PROFILE("START")=+NOW Q
 .I START=5 S PROFILE("START")=$$FMADD^XLFDT(NOW,-1) Q
 .I START=6 S PROFILE("START")=$$FMADD^XLFDT(+NOW,-1) Q
 .I START=7 S PROFILE("START")=$$FMADD^XLFDT(NOW,-2) Q
 .I START=8 S PROFILE("START")=$$FMADD^XLFDT(NOW,-3) Q
 .I START=9 S PROFILE("START")=$$FMADD^XLFDT(NOW,-7) Q
 S PROFILE("URGENT")=$P(NODE,"^",9)
 S SITE=0
 F I="APPS","SITES","TYPES","STATUSES" S PROFILE(I)=""
 F  S SITE=$O(^HLEV(776.5,IEN,1,SITE)) Q:'SITE  S PROFILE("SITES",+$G(^HLEV(776.5,IEN,1,SITE,0)))=""
 S TYPE=0
 F  S TYPE=$O(^HLEV(776.5,IEN,2,TYPE)) Q:'TYPE  S PROFILE("TYPES",+$G(^HLEV(776.5,IEN,2,TYPE,0)))=""
 S APP=0
 F  S APP=$O(^HLEV(776.5,IEN,3,APP)) Q:'APP  S PROFILE("APPS",$$APPNAME^HLEMU(+$G(^HLEV(776.5,IEN,3,APP,0))))=""
 S STATUS=0
 F  S STATUS=$O(^HLEV(776.5,IEN,4,STATUS)) Q:'STATUS  S APPNAME=$$APPNAME^HLEMU(+$G(^HLEV(776.5,IEN,4,STATUS,0))) I $L(APPNAME) S PROFILE("APPS",APPNAME)=""
 Q 1
 ;
CREATE(DUZ,NAME,ERROR) ;
 ;Given the DUZ and a name, creates a new profile of that name.
 ;Output-
 ;  function value - returns the new profile ien on success, 0 on failure
 ;  ERROR **optional, pass by reference** an array of errors
 ;
 Q:'$G(DUZ) 0
 Q:'$L(NAME) 0
 ;
 N DATA
 S DATA(.01)=DUZ
 S DATA(.02)=NAME
 Q $$ADD^HLEMU(776.5,,.DATA,.ERROR)
 ;
EDIT(PROFILE) ;
 ;Given the ien of a profile, allows a user to edit it.
 ;Input:  PROFILE - ien of a profile
 ;Output:  function returns 1 on success, 0 on failure, or on indication that the user did not complete the edit
 ;
 Q:'$G(PROFILE) 0
 Q:'$G(^HLEV(776.5,PROFILE,0)) 0
 K DA,DIE,DR
 S DA=PROFILE
 S DIE=776.5
 S DR=".02:.09"
 S DIE("NO^")="OUTOK"
 D ^DIE
 I '$D(Y),'$D(DTOUT),$$GET(PROFILE,.PROFILE) D
 .S DR=""
 .S DIE("NO^")="OUTOK"
 .I 'PROFILE("ALL SITES") S DR="1;"
 .I 'PROFILE("ALL TYPES") S DR=DR_"2;"
 .I 'PROFILE("ALL APPS") S DR=DR_"3;"
 .I 'PROFILE("ALL STATUSES") S DR=DR_4
 .D ^DIE
 Q $S($D(Y)!$D(DTOUT):0,1:1)
 ;
DELETE(PROFILE) ;
 ;Given the ien, deletes the profile
 Q $$DELETE^HLEMU(776.5,.PROFILE)
