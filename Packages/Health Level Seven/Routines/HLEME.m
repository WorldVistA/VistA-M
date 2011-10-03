HLEME ;ALB/CJM-HL7 - APIs for Monitor Events ;02/04/2004
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
GET(IEN,EVENT) ;
 ;Desc: given the ien, it returns an array containing the event.  Does NOT include the NOTES field or the Application Data
 ;Input:
 ;  IEN - ien of event
 ;Output:
 ;  function returns 0 on failure, 1 on success
 ;  EVENT(   ***pass by reference***
 ;  "ACTION STATUS"
 ;  "APPLICATION" - the sending application, only if the event is related to an HL7 message
 ;  "COUNT" - the number of discrete events included in this event - for conglomerated events
 ;  "DT/TM" - date/time of the event
 ;  "DT/TM ACTION" - for automated action
 ;  "DT/TM CREATED" - time stamp for this event
 ;  "DT/TM REVIEWED" - 
 ;  "ID" - unique identifier
 ;  "IEN" -the ien
 ;  "MAIL",<msg ien>)=<msg ien> - list of Mailman messages
 ;  "MSGID ID" - mssage id of message causing this event (if any)
 ;  "MSG TYPE" - HL7 message type code
 ;  "MSG EVENT" - HL7 event type code
 ;  "MSG LINK" - name of the HL Logical Link (NODE) on which the mssg was sent
 ;  "REVIEWER" - ien in New Person file
 ;  "REVIEW STATUS"
 ;  "SITE" - site of occurence, a pointer to the Institution file
 ;  "TYPE" - the type of event, an ien of a HL7 Monitor Event Type
 ;  "URGENT" - flag for urgency
 ;
 ;
 Q:'$G(IEN) 0
 N NODE,I,LABEL
 K EVENT
 S EVENT("IEN")=IEN
 S NODE=$G(^HLEV(776.4,IEN,0))
 Q:'$L(NODE) 0
 S EVENT("DT/TM")=$P(NODE,"^")
 S EVENT("TYPE")=$P(NODE,"^",2)
 S EVENT("SITE")=$P(NODE,"^",3)
 S EVENT("ID")=$P(NODE,"^",4)
 S EVENT("ACTION STATUS")=$P(NODE,"^",5)
 S EVENT("REVIEW STATUS")=$P(NODE,"^",6)
 S EVENT("DT/TM REVIEWED")=$P(NODE,"^",7)
 S EVENT("REVIEWER")=$P(NODE,"^",8)
 S EVENT("DT/TM ACTION")=$P(NODE,"^",9)
 S EVENT("MSG ID")=$P(NODE,"^",10)
 S EVENT("MSG TYPE")=$P(NODE,"^",13)
 S EVENT("MSG EVENT")=$P(NODE,"^",14)
 S EVENT("MSG LINK")=$P(NODE,"^",15)
 S EVENT("DT/TM CREATED")=$P(NODE,"^",17)
 S EVENT("APPLICATION")=$P(NODE,"^",16)
 S EVENT("COUNT")=$P(NODE,"^",11)
 S EVENT("URGENT")=$P(NODE,"^",12)
 S I=0 F  S I=$O(^HLEV(776.4,IEN,2,I)) Q:'I  S NODE=+$G(^HLEV(776.4,IEN,2,I,0)) I NODE S EVENT("MAIL",NODE)=NODE
 Q 1
 ;
STOREVAR(EVENT,APPDATA,VAR) ;
 ;Desc:  Allows an app. to store its own application-specific data.
 ;Input:
 ;   EVENT - ien of event
 ;   APPDATA - variable or array to store **for arrays, pass by reference**
 ;   VAR - **optional** - variable name, may inlucde subscripts.Required if the application needs to store multiple variables or arrays. VAR="APPDATA"is the default
 ;Output:
 ;  function reuturns 1 on success,0 on failure
 ;Ex 1
 ;  An app. needs to store a single set of data with the
 ;  event.  It could set the data into an array call
 ;  $$STOREVAR(EVENT,.MYARRAY) To get back the
 ;       data it would call $$GETVAR(EVENT,.MYARRAY).  (any variable name could have been used instead of MYARRAY.
 ;Ex 2
 ;  An application needs to store multiple sets of data with the
 ;  the event. It could accomplish that by setting the data into
 ;  multiple arrays, say DATA1,DATA2,DATA3,... and calling
 ;  $$STOREVAR(EVENT,.DATA1,"DATA1"), then $$STOREVAR(EVENT,.DATA2,"DATA2"),etc.
 ;  To get back the named datasets the application would call
 ;  $$GETVAR(EVENT,.DATA1,"DATA1"), $$GETVAR(EVENT,.DATA2,"DATA2"),
 ;  etc.
 ;
 Q:'$G(EVENT) 0
 Q:'$D(^HLEV(776.4,EVENT,0)) 0
 Q:'$D(APPDATA) 0
 ;
 N I,LABEL
 S I=+$O(^HLEV(776.4,EVENT,3,999999999),-1)
 I $L($G(VAR)) N @VAR D
 .S LABEL=VAR
 .M @VAR=APPDATA
 E  D
 .S LABEL="APPDATA"
 ;
 ;check if the root has data, if so, store it
 I $D(@LABEL)'[0 D
 .N OLDIEN
 .S OLDIEN=$O(^HLEV(776.4,EVENT,3,"B",LABEL,0))
 .I OLDIEN D
 ..K ^HLEV(776.4,EVENT,"B",LABEL,OLDIEN),^HLEV(776.4,EVENT,3,OLDIEN)
 .E  D
 ..S I=I+1
 .S ^HLEV(776.4,EVENT,3,I,0)=LABEL,^HLEV(776.4,EVENT,3,I,2)=@LABEL,^HLEV(776.4,EVENT,3,"B",LABEL,I)=0
 ;
 ;now store everything that comes below it
 F  S LABEL=$Q(@LABEL) Q:LABEL=""  D
 .;can't go over a total lenth of 230
 .Q:'$L(LABEL)>230
 .S I=I+1 S ^HLEV(776.4,EVENT,3,I,0)=LABEL,^HLEV(776.4,EVENT,3,I,2)=@LABEL,^HLEV(776.4,EVENT,3,"B",LABEL,I)=0
 ;
 ;write the 0-node
 S ^HLEV(776.4,EVENT,3,0)="^776.43^"_I_"^"_I
 ;
 Q 1
 ;
GETVAR(EVENT,APPDATA,VAR) ;
 ;Desc: Used to retrieve application-specific data that was stored along with the event.
 ;Input:
 ;   EVENT - ien of the event
 ;   VAR - name of the variable or array to fetch.  If not passed, "APPDATA" is assumed, which is also the default when calling $$STOREVAR()
 ;Output
 ;  function value - 1 on success, 0 on failure
 ;  APPDATA() - used to return the requested data **pass by reference**
 ;
 Q:'$G(EVENT) 0
 Q:'$L($G(^HLEV(776.4,EVENT,0))) 0
 ;
 N INDEX,I,LABEL,VAR2
 K APPDATA
 S INDEX="^HLEV(776.4,EVENT,3)"
 S:'$L($G(VAR)) VAR="APPDATA"
 S VAR2=$O(@INDEX@("B",VAR),-1)
 F  S VAR2=$O(@INDEX@("B",VAR2)) Q:'$L(VAR2)  Q:(VAR2'[VAR)  S I=0 F  S I=$O(@INDEX@("B",VAR2,I)) Q:'I  S LABEL=$G(@INDEX@(I,0)) S:LABEL[VAR @LABEL=$G(@INDEX@(I,2))
 ;
 M APPDATA=@VAR
 Q 1
 ;
EVENT(CODE,PACKAGE,HL7MSGID,SITE,WHEN,ERROR) ;
 ;Desc: API for applications to notify HL7 Event Monitor of their events
 ;Input:
 ;  CODE - the code (.01 field) for the HL7 Monitor Event Type
 ;  PACKAGE - the name of the package that created the HL7 Monitor Event Type, used to find the event type ien.
 ;  HL7MSGID - **optional** - if the event pertains to a specific message, this should be passed
 ;  SITE - **optional** - the station number, including any suffix, where the event occured. Will assume the local site if not passed in.
 ;  WHEN - **optional** - FM date/time of when the event occurred. Will assume now if not passed in.
 ;Output:
 ;  function value -  ien of the event (file 776.4) on success, 0 on failure
 ;  ERROR - **optional, pass by reference** - array of error messages
 ;
 N EVENT,TYPE,MSGIEN,NOW
 S EVENT("TYPE")=$$FIND^HLEMT(.CODE,.PACKAGE)
 I 'EVENT("TYPE") S ERROR(1)="UNKNOWN EVENT TYPE" Q 0
 I '$L($G(SITE)) D
 .S EVENT("SITE")=+$P($$SITE^VASITE(),"^")
 E  D
 .S EVENT("SITE")=$$LKUP^XUAF4(SITE)
 I 'EVENT("SITE") S ERROR(1)="UNKNOWN SITE" Q 0
 S NOW=$$NOW^XLFDT
 S EVENT("DT/TM")=$S('$G(WHEN):NOW,1:WHEN)
 S EVENT("DT/TM CREATED")=NOW
 ;
 ;get the event type array
 I '$$GET^HLEMT(EVENT("TYPE"),.TYPE) S ERROR(1)="UNKNOWN EVENT TYPE" Q 0
 ;
 ;is this event type active?
 I 'TYPE("ACTIVE") S ERROR(1)="INACTIVE EVENT TYPE" Q 0
 ;
 ;check if this is a conglomerated event that can be added to an existing event
 I TYPE("CONGLOMERATE") D
 .L +^HLEV(776.4,"AE",EVENT("SITE"),EVENT("TYPE")):2
 .S EVENT("IEN")=$$ADD^HLEME1(EVENT("SITE"),EVENT("TYPE"),EVENT("DT/TM"))
 ;
 I '$G(EVENT("IEN")) D
 .;
 .;otherwise, create and store a new event
 .S EVENT("ACTION STATUS")=$S($L(TYPE("ACTION")):1,1:0)
 .S EVENT("REVIEW STATUS")=TYPE("REVIEW")
 .S EVENT("MSG ID")=$G(HL7MSGID)
 .S MSGIEN=$$MSGIEN^HLEMU($G(HL7MSGID))
 .I MSGIEN D
 ..S EVENT("MSG TYPE")=$$MSGTYPE^HLEMU(MSGIEN)
 ..S EVENT("MSG EVENT")=$$HL7EVENT^HLEMU(MSGIEN)
 ..S EVENT("MSG LINK")=$P($$LINK^HLEMU(MSGIEN),"^",2)
 ..S EVENT("APPLICATION")=$$APP^HLEMU(MSGIEN)
 .E  D
 ..S EVENT("MSG TYPE")=""
 ..S EVENT("MSG EVENT")=""
 ..S EVENT("MSG LINK")=""
 ..S EVENT("APPLICATION")=""
 .S EVENT("COUNT")=1
 .S EVENT("URGENT")=TYPE("URGENT")
 .S EVENT("IEN")=$$STORE^HLEME1(.EVENT,.ERROR)
 .I EVENT("IEN"),$O(TYPE("DOMAIN",0)) S ^HLEV(776.4,"AK",NOW,EVENT("IEN"))=""
 I TYPE("CONGLOMERATE") L -^HLEV(776.4,"AE",EVENT("SITE"),EVENT("TYPE"))
 Q EVENT("IEN")
 ;
COUNT(EVENT) ;
 ;given the event ien, returns the value of the COUNT field
 Q:'$G(EVENT) 0
 Q $P($G(^HLEV(776.4,EVENT,0)),"^",11)
INC(EVENTIEN,NUMBER) ;
 ;Desc: given the ien of a conglomerated event, it will increment the count by the given amount and return the new count.  Returns "" on failure.
 ;
 Q:'$G(EVENTIEN) ""
 Q:'$G(NUMBER) ""
 N COUNT,EVENT
 L +^HLEV(776.4,EVENTIEN,0):1
 Q:'$$GET(EVENTIEN,.EVENT) ""
 S COUNT=EVENT("COUNT")
 S $P(^HLEV(776.4,EVENTIEN,0),"^",11)=COUNT+NUMBER
 D ADDSTAT^HLEMDD(EVENT("DT/TM"),,EVENT("SITE"),EVENT("TYPE"),EVENT("REVIEW STATUS"),NUMBER)
 L -^HLEV(776.4,EVENTIEN,0)
 Q (COUNT+NUMBER)
 ;
RSTATUS(EVENT) ;
 ;given the event ien, returns the value of the REVIEW STATUS field
 Q:'$G(EVENT) ""
 Q $P($G(^HLEV(776.4,EVENT,0)),"^",6)
 ;
ADDNOTE(EVENT,NOTE) ;
 ;Description:  adds a note to the NOTE field of the event
 ;Input:
 ;  EVENT - ien of the event
 ;  NOTE - either:
 ;         1) A single line to add to the NOTES OR
 ;    2) An array of lines to add. All descendant nodes will be added.
 ;Ouput:
 ;   function value - 1 on success, 0 on failure
 ;
 Q:'$G(EVENT) 0
 Q:'$L($G(^HLEV(776.4,EVENT,0))) 0
 Q:'$D(NOTE) 0
 ;
 N LABEL,I
 S I=$O(^HLEV(776.4,EVENT,1,9999999),-1)+1
 I $L($G(NOTE)) S ^HLEV(776.4,EVENT,1,I,0)=NOTE,I=I+1
 S LABEL="NOTE"
 F  S LABEL=$Q(@LABEL) Q:LABEL=""  S ^HLEV(776.4,EVENT,1,I,0)=@LABEL,I=I+1
 S ^HLEV(776.4,EVENT,1,0)="^776.41^"_(I-1)_"^"_(I-1)_"^"_DT
 Q 1
 ;
GETNOTES(EVENT,ARRAY) ;
 ;Description - given an event, returns the note field into an array, local or global
 ;Input: ARRAY - the name of the array to store the notes, referenced by indirection
 ;Output:
 ;  function returns 1 on success, 0 on failure
 ;  @ARRAY will contain the NOTES, wich is a WP field
 ;
 Q:'$L('$G(ARRAY)) 0
 Q:'$G(EVENT) 0
 K @ARRAY
 M @ARRAY=^HLEV(776.4,EVENT,1)
 Q 1
