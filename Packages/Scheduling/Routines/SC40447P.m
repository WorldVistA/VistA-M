SC40447P ;BP-CIOFO/TEH CROSS-REFERENCE REPAIR UTILITY ; 28 Apr 04  04:11PM
        ;;5.3;Scheduling;**365**;Apr 28 2004
 ;;
 ;;
 ;;This utility will verify that in the PCMM HL7 TRANSMISSION LOG 
 ;;file that if the 'ACK RECIEVED DATE/TIME" field is set and the
 ;;STATUS file does not have a "A" for accepted then a correct will
 ;;be done to the STATUS field and the "ASTAT" x-ref will be corrected.
 ;;
 ;;This routine should not be run while transmitting PCMM HL7 data.
 Q
EN N SCX,SCACKDT,DA,DR,SCXX,DIE
 S SCX="" F  S SCX=$O(^SCPT(404.471,"ASTAT","T",SCX)) Q:SCX<1  D
 .S SCXX=$G(^SCPT(404.471,SCX,0)) Q:SCXX=""
 .;CHECK FOR ACK RECIEVED DATE/TIME
 .S SCACKDT=$P(SCXX,"^",5) Q:'SCACKDT  D
 ..;CORRECT STATUS AND X-REF
 ..S DIE="^SCPT(404.471,",DA=SCX,DR=".04////A" D ^DIE
 Q
