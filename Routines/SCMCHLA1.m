SCMCHLA1 ;ALB/KCL - PCMM HL7 Trans Log Xref API's ; 15-JAN-2000
 ;;5.3;Scheduling;**210,272**;AUG 13, 1993
 ;
ASTSET(SCLOGIEN,STATUS) ;
 ;Description: Sets the "AST" x-ref on the PCMM HL7 Trans Log file.
 ;
 ; Input: 
 ;  SCLOGIEN - ien of PCMM HL7 Tans Log file record
 ;    STATUS - internal value of STATUS field
 ;
 ;s ^SCPT(404.471,"AST",date/time ack rec'd,status,patient,pcmm trans log ien)
 ;
 N NODE
 ;
 Q:'$G(SCLOGIEN)
 Q:$G(STATUS)']""
 S NODE=$G(^SCPT(404.471,SCLOGIEN,0))
 N DFN S DFN=$S($P(NODE,"^",2):+$P(NODE,"^",2),1:"W")
 Q:'+$P(NODE,"^",5)
 ;
 I STATUS="RJ"!(STATUS="M") D
 .S ^SCPT(404.471,"AST",$P(NODE,"^",5),STATUS,DFN,SCLOGIEN)=""
 ;
 Q
 ;
ASTKILL(SCLOGIEN,STATUS) ;
 ;Description: Kill logic for "AST" x-ref on the PCMM HL7 Trans Log file.
 ;
 ; Input: 
 ;  SCLOGIEN - ien of PCMM HL7 Tans Log file record
 ;    STATUS - internal value of STATUS field
 ;
 ;k ^SCPT(404.471,"AST",date/time ack rec'd,status,patient,pcmm trans log ien)
 ;
 N NODE
 ;
 Q:'$G(SCLOGIEN)
 Q:$G(STATUS)']""
 S NODE=$G(^SCPT(404.471,SCLOGIEN,0))
 N DFN S DFN=$S($P(NODE,"^",2):+$P(NODE,"^",2),1:"W")
 Q:'$P(NODE,"^",5)
 ;
 I STATUS="RJ"!(STATUS="M") D
 .K ^SCPT(404.471,"AST",+$P(NODE,"^",5),STATUS,DFN,SCLOGIEN)
 ;
 Q
 ;
 ;
AST1SET(SCLOGIEN,ACKREC) ;
 ;Description: Sets the "AST1" x-ref on the PCMM HL7 Trans Log file.
 ;
 ; Input: 
 ;  SCLOGIEN - ien of PCMM HL7 Tans Log file record
 ;    ACKREC - internal value of ACK RECEIVED DATE/TIME field
 ;
 ;s ^SCPT(404.471,"AST",date/time ack rec'd,status,patient,pcmm trans log ien)
 ;
 N NODE
 ;
 Q:'$G(SCLOGIEN)
 Q:'$G(ACKREC)
 S NODE=$G(^SCPT(404.471,SCLOGIEN,0))
 ;Q:'+$P(NODE,"^",2)
 N DFN S DFN=$S($P(NODE,"^",2):+$P(NODE,"^",2),1:"W")
 Q:($P(NODE,"^",4)']"")
 ;
 I $P(NODE,"^",4)="RJ"!($P(NODE,"^",4)="M") D
 .S ^SCPT(404.471,"AST",ACKREC,$P(NODE,"^",4),DFN,SCLOGIEN)=""
 ;
 Q
 ;
AST1KILL(SCLOGIEN,ACKREC) ;
 ;Description: Kill logic for "AST1" x-ref on the PCMM HL7 Trans Log file.
 ;
 ; Input: 
 ;  SCLOGIEN - ien of PCMM HL7 Tans Log file record
 ;    ACKREC - internal value of ACK RECEIVED DATE/TIME field
 ;
 ;k ^SCPT(404.471,"AST",date/time ack rec'd,status,patient,pcmm trans log ien)
 ;
 N NODE
 ;
 Q:'$G(SCLOGIEN)
 Q:'$G(ACKREC)
 S NODE=$G(^SCPT(404.471,SCLOGIEN,0))
 N DFN S DFN=$S($P(NODE,"^",2):+$P(NODE,"^",2),1:"W")
 Q:($P(NODE,"^",4)']"")
 ;
 I $P(NODE,"^",4)="RJ"!($P(NODE,"^",4)="M") D
 .K ^SCPT(404.471,"AST",ACKREC,$P(NODE,"^",4),DFN,SCLOGIEN)
 ;
 Q
 ;
 ;
AST2SET(SCLOGIEN,PAT) ;
 ;Description: Sets the "AST2" x-ref on the PCMM HL7 Trans Log file.
 ;
 ; Input: 
 ;  SCLOGIEN - ien of PCMM HL7 Tans Log file record
 ;       PAT - internal value of PATIENT field
 ;
 ;s ^SCPT(404.471,"AST",date/time ack rec'd,status,patient,pcmm trans log ien)
 ;
 N NODE
 ;
 Q:'$G(SCLOGIEN)
 Q:'$G(PAT)
 S NODE=$G(^SCPT(404.471,SCLOGIEN,0))
 Q:($P(NODE,"^",4)']"")
 Q:'+$P(NODE,"^",5)
 ;
 I $P(NODE,"^",4)="RJ"!($P(NODE,"^",4)="M") D
 .S ^SCPT(404.471,"AST",+$P(NODE,"^",5),$P(NODE,"^",4),PAT,SCLOGIEN)=""
 ;
 Q
 ;
AST2KILL(SCLOGIEN,PAT) ;
 ;Description: Kill logic for "AST2" x-ref on the PCMM HL7 Trans Log file.
 ;
 ; Input: 
 ;  SCLOGIEN - ien of PCMM HL7 Tans Log file record
 ;       PAT - internal value of PATIENT field
 ;
 ;k ^SCPT(404.471,"AST",date/time ack rec'd,status,patient,pcmm trans log ien)
 ;
 N NODE
 ;
 Q:'$G(SCLOGIEN)
 Q:'$G(PAT)
 S NODE=$G(^SCPT(404.471,SCLOGIEN,0))
 Q:($P(NODE,"^",4)']"")
 Q:'+$P(NODE,"^",5)
 ;
 I $P(NODE,"^",4)="RJ"!($P(NODE,"^",4)="M") D
 .K ^SCPT(404.471,"AST",+$P(NODE,"^",5),$P(NODE,"^",4),PAT,SCLOGIEN)
 Q
