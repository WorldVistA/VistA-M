RGFIACK ;ALB/CJM-PROCESS APPLICATION ACKNOWLEDGMENT ;08/27/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**5,13**;30 Apr 99
 ;
ACK ;
 ;Description: Process the application ack to the Facility Integration
 ;Message
 ;
 ;Input:
 ;  HL7 variables must be defined
 ;Output: none
 ;Variables:
 ;  FS - field seperator
 ;  CS - component seperator
 ;  CODE - returned error code
 ;  MSG - error text returned
 ;  TYPE - ack type (AA,ER)
 ;  MSGID - HL7 msg id
 ;  RGLOG - ien of entry in the CIRN HL7 Exception file
 ;  ICN - Integrated Control Number
 ;  DFN - patient DFN
 ;  SITE - station # of site that sent the app ack
 ;
 N FS,CS,QUIT,CODE,MSG,TYPE,MSGID,RGLOG,ICN,DFN,SITE
 S FS=HL("FS")
 S CS=$E(HL("ECH"),1)
 S QUIT=0
 K HLERR
 ;
 X HLNEXT D  Q:QUIT
 .I (HLQUIT'>0) S HLERR="MISSING MSH SEGMENT",QUIT=1 Q
 .I $P(HLNODE,FS)'["MSH" S HLERR="MISSING MSH SEGMENT",QUIT=1 Q
 X HLNEXT D  Q:QUIT
 .I (HLQUIT'>0) S HLERR="MISSING MSA SEGMENT",QUIT=1 Q
 .I $P(HLNODE,FS)'["MSA" S HLERR="MISSING MSA SEGMENT",QUIT=1 Q
 .S TYPE=$P(HLNODE,FS,2)
 .S MSGID=$P(HLNODE,FS,3)
 .S MSG=$P(HLNODE,FS,4)
 .S ICN=+$P(MSG,"ICN:",2)
 .S DFN=$S(ICN:$$DFN^RGFIU(ICN),1:"")
 .S SITE=$P(MSG,"From Station:",2),SITE=$P(SITE," ICN:")
 .S CODE=$P($P(HLNODE,FS,7),CS,4)
 I ($G(TYPE)["R"),$G(MSGID),$G(CODE) D
 .N HLMTIEN
 .S HLMTIEN=MSGID
 .D EXC^RGFIU(CODE,"APPLICATION ACKNOWLEDGMENT TO MSGID: "_MSGID_" - "_MSG,DFN,MSGID,SITE)
 .D STOP^RGHLLOG(1)
 Q
