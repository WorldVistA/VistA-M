MHVU2 ;WAS/GPM - UTILITIES  ; 7/25/05 3:48pm [4/30/08 6:29pm]
 ;;1.0;My HealtheVet;**2,5**;Aug 23, 2005;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
TOGGLE(EXTRACT,VAL,ERR) ; Enable or disable the EXTRACT passed by setting the
 ; value of the BLOCKED field (.03) in MHV REQUEST TYPE file (2275.3)
 ; to NO or YES respectively.
 ;
 ;  Input: EXTRACT - String name of the extract
 ;                   Example: "CHEMISTRY"
 ;             VAL - "ENABLE" or "DISABLE"
 ;
 ;  Output:   ERR - Error Text
 ;
 N IEN,IENS,FDA
 K ERR
 S ERR=""
 I EXTRACT="" S ERR="EXTRACT PARAMETER NULL" Q 0
 S VAL=$S(VAL="ENABLE":0,VAL="DISABLE":1,1:"")
 I VAL="" S ERR="VALUE PARAMETER INVALID"_VAL Q 0
 ;
 S IEN=$$FIND1^DIC(2275.3,"","KX",EXTRACT,"B","","ERR")
 I 'IEN D  Q 0
 . I '$G(ERR("DIERR")) S ERR("DIERR",1,"TEXT",1)="NOT FOUND"
 . S ERR=$G(ERR("DIERR",1))_"^"_$G(ERR("DIERR",1,"TEXT",1))
 . Q
 ;
 K ERR
 S ERR=""
 S IENS=IEN_","
 S FDA(2275.3,IENS,.03)=VAL
 D UPDATE^DIE("","FDA","","ERR")
 I $G(ERR("DIERR")) S ERR=$G(ERR("DIERR",1))_"^"_$G(ERR("DIERR",1,"TEXT",1)) Q 0
 ;
 Q 1
 ;
UPDMAP(FIELDS,NEW,ERR) ; Update entries in the MHV RESPONSE MAP file (2275.4)
 ;
 ;  Input: FIELDS - Array of Field Values
 ;              FIELDS("SUBSCRIBER") - Name of subscriber protocol
 ;              FIELDS("PROTOCOL") - Name of event driver protocol
 ;              FIELDS("BUILDER") - Name of response builder routine
 ;              FIELDS("SEGMENT") - Name of boundary segment
 ;            NEW - 0 to edit, 1 to create new entry
 ;
 ;  Output:   ERR - Error Text
 ;
 N IEN,NAME,PROTOCOL,BUILDER,SEGMENT,FDA
 K ERR
 S ERR=""
 S NAME=$G(FIELDS("SUBSCRIBER"))
 S PROTOCOL=$G(FIELDS("PROTOCOL"))
 S BUILDER=$G(FIELDS("BUILDER"))
 S SEGMENT=$G(FIELDS("SEGMENT"))
 I NAME="" S ERR="Missing Subscriber Protocol" Q 0
 I PROTOCOL="" S ERR="Missing Response Protocol" Q 0
 I BUILDER="" S ERR="Missing Builder Routine" Q 0
 ;
 ; Check if entry exists, use it if it does
 S IEN=$O(^MHV(2275.4,"B",NAME,0))
 I NEW,'IEN S IEN="+1"
 I 'NEW,'IEN S ERR="Subscriber Not Defined" Q 0
 S IEN=IEN_","
 ;
 S FDA(2275.4,IEN,.01)=NAME
 S FDA(2275.4,IEN,.02)=PROTOCOL
 S FDA(2275.4,IEN,.03)=BUILDER
 S FDA(2275.4,IEN,.04)=SEGMENT
 D UPDATE^DIE("E","FDA","","ERR")
 I $D(ERR("DIERR")) S ERR=$G(ERR("DIERR",1,"TEXT",1)) Q 0
 Q 1
 ;
UPDREQ(FIELDS,NEW,ERR) ; Update entries in the MHV REQUEST TYPE file (2275.3)
 ;
 ;  Input: FIELDS - Array of Field Values
 ;              FIELDS("REQUEST TYPE") - Request Type
 ;              FIELDS("NUMBER") - Internal Request Number
 ;              FIELDS("BLOCK") - 0,1 Disable Request
 ;              FIELDS("REALTIME") - Enable Synchronous Response
 ;              FIELDS("EXECUTE") - Name of execute\extract routine
 ;              FIELDS("BUILDER") - Name of response builder routine
 ;              FIELDS("DATATYPE") - External Name for Request Type
 ;              FIELDS("DESCRIPTION") - WP formatted array
 ;            NEW - 0 to edit, 1 to create new entry
 ;
 ;  Output:   ERR - Error Text
 ;
 N IEN,NAME,NUMBER,BLOCK,REALTIME,EXECUTE,BUILDER,DATATYPE,DESC,FDA
 K ERR
 S ERR=""
 S NAME=$G(FIELDS("REQUEST TYPE"))
 S NUMBER=$G(FIELDS("NUMBER"))
 S BLOCK=$G(FIELDS("BLOCK"))
 S REALTIME=$G(FIELDS("REALTIME"))
 S EXECUTE=$G(FIELDS("EXECUTE"))
 S BUILDER=$G(FIELDS("BUILDER"))
 S DATATYPE=$G(FIELDS("DATATYPE"))
 M DESC=FIELDS("DESCRIPTION")
 I NAME="" S ERR="Missing Request Type" Q 0
 I NEW D  Q:ERR'="" 0
 . I NUMBER="" S ERR="Missing Type Number" Q
 . I BLOCK="" S ERR="Missing Blocked Setting" Q
 . I REALTIME="" S ERR="Missing RealTime Setting" Q
 . I EXECUTE="" S ERR="Missing Execute Routine" Q
 . I DATATYPE="" S ERR="Missing Data Type" Q
 . I '$D(DESC) S ERR="Missing Description" Q
 . Q
 ;
 ; Check if entry exists, use it if it does
 S IEN=$O(^MHV(2275.3,"B",NAME,0))
 I NEW,'IEN S IEN="+1"
 I 'NEW,'IEN S ERR="Request Type Not Defined" Q 0
 I DATATYPE'="",$D(^MHV(2275.3,IEN,1,"B",DATATYPE)) S DATATYPE=""
 S IEN=IEN_","
 ;
 S FDA(2275.3,IEN,.01)=NAME
 S:NUMBER'="" FDA(2275.3,IEN,.02)=NUMBER
 S:BLOCK'="" FDA(2275.3,IEN,.03)=BLOCK
 S:REALTIME'="" FDA(2275.3,IEN,.04)=REALTIME
 S:EXECUTE'="" FDA(2275.3,IEN,.05)=EXECUTE
 S:BUILDER'="" FDA(2275.3,IEN,.06)=BUILDER
 S:DATATYPE'="" FDA(2275.31,"+2,"_IEN,.01)=DATATYPE
 S:$D(DESC) FDA(2275.3,IEN,2)="DESC"
 D UPDATE^DIE("E","FDA","","ERR")
 I $D(ERR("DIERR")) S ERR=$G(ERR("DIERR",1,"TEXT",1)) Q 0
 Q 1
 ;
