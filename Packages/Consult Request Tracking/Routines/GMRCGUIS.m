GMRCGUIS ;ALB/TDP - update Consult Status ;4/26/2006
 ;;3.0;CONSULT/REQUEST TRACKING;**52**;DEC 27, 1997
 ;
 ;Called by SDCNSLT for Scheduling Consult Appointment Linkage
STATUS(GMRCO,GMRCSTS,GMRCA,GMRCORNP,GMRCAD,GMRCADUZ,GMRCMT) ;Change status/last action/add comment consult API
 ; Input variables:
 ;GMRCO - The internal file number of the consult from File 123
 ;GMRCSTS - Status of the consult
 ;GMRCA - Last Action to be added to the consult
 ;GMRCORNP - Name of the person who actually 'Received' the consult 
 ;GMRCAD - Actual date time that consult was received into the service.
 ;GMRCADUZ - array of alert recipients as chosen by user (by reference)
 ;   ARRAY(DUZ)="" 
 ;GMRCMT - array of comments if entered (by reference)
 ;   ARRAY(1)="FIRST LINE OF COMMENT"
 ;   ARRAY(2)="SECOND LINE OF COMMENT"
 ;
 ;Output:
 ;GMRCERR - Error Condition Code: 0 = NO error, 1=error
 ;GMRCERMS - Error message or null
 ;  returned as GMRCERR^GMRCERMS
 ;
 N DFN,GMRCNOW,GMRCERR,GMRCERMS
 S GMRCERR=0,GMRCERMS="",GMRCNOW=$$NOW^XLFDT,GMRCMT=0
 I 'GMRCSTS!('GMRCA) D  Q GMRCERR_"^"_GMRCERMS
 . S GMRCERR="1",GMRCERMS="Status/last action update is missing or wrong."
 . D EXIT^GMRCGUIA
 S:$G(GMRCAD)="" GMRCAD=GMRCNOW
 S:'$G(GMRCDUZ) GMRCDUZ=DUZ
 S DFN=$P($G(^GMR(123,GMRCO,0)),"^",2) I DFN="" D  Q GMRCERR_"^"_GMRCERMS
 . S GMRCERR="1",GMRCERMS="Not A Valid Consult - File Not Found."
 . D EXIT^GMRCGUIA
 D STATUS^GMRCP I $D(GMRCQUT) D EXIT^GMRCGUIA Q GMRCERR_"^"_GMRCERMS
 I '$O(GMRCMT(0)) D AUDIT^GMRCP
 I $O(GMRCMT(0)) D
 . S DA=$$SETDA^GMRCGUIB
 . S GMRCMT(0)=DA,GMRCMT=1
 . D SETCOM^GMRCGUIB(.GMRCMT,GMRCDUZ)
 D EN^GMRCHL7(DFN,GMRCO,"","","SC",GMRCORNP,"",.GMRCMT,"",GMRCAD)
 D  ;send alerts
 . N TXT
 . S TXT="Comment Added to Consult "_$$ORTX^GMRCAU(GMRCO)
 . I $P(^GMR(123,+GMRCO,0),U,14) S GMRCADUZ($P(^(0),U,14))=""
 . D MSG^GMRCP(DFN,TXT,GMRCO,63,.GMRCADUZ,0)
 D EXIT^GMRCGUIA
 Q GMRCERR_"^"_GMRCERMS
