VAFCMSG5 ;ALB/JRP - MESSAGE BUILDER UTILITIES;12-SEP-1996
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
GETSRVR(EVNTTYPE) ;Get pointer to HL7 Server Protocol for given event type
 ;
 ;Input  : EVNTTYPE - Event type to build list for (Defaults to A08)
 ;                    Currently supported events:
 ;                      A04, A08, A28
 ;Output : SRVRPTR - Pointer to HL7 Server Protocol (value for HLEID)
 ;Notes  : Zero (0) will be returned if the event does not have an
 ;         associated HL7 Server Protocol or the HL7 Server Protocol
 ;         can not be found in the PROTOCOL file (#101)
 ;
 ;Check input
 S EVNTTYPE=$G(EVNTTYPE)
 S:(EVNTTYPE="") EVNTTYPE="A08"
 ;Declare variables
 N SRVRNAME,X,OK
 ;Check for supported event
 S OK=0
 F X="A04","A08","A28" I X=EVNTTYPE S OK=1 Q
 Q:('OK) 0
 ;Determine name of HL7 Server Protocol
 S SRVRNAME="VAFC ADT-"_EVNTTYPE_" SERVER"
 ;Return pointer to HL7 Server Prototol
 Q +$O(^ORD(101,"B",SRVRNAME,0))
 ;
NOW() ;Function call that returns the current date/time in FileMan format
 ;
 ;Input  : None
 ;Output : Current date/time in FileMan format
 ;
 ;Declare variables
 N %,%H,%I,X,Y
 ;Get current date/time
 D NOW^%DTC
 ;Return current date/time
 Q %
