SDESGETDISPREASN ;ALB/TJB - SDES GET DISPOSITION REASON ;JUNE 5, 2023
 ;;5.3;Scheduling;**846**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
DISPOSITIONREAS(JSONRETURN,SDCONTEXT) ;
 ; Any information in SDCONTEXT ARRAY is currently ignored. All entries
 ; in file 409.853 ui returned
 N DATA,INDEX,DCNT,SDARRAY,PACKDATA
 K DATA D LIST^DIC(409.853,,,"P",,,,,,,"DATA")
 S (INDEX,DCNT)=0
 F  S INDEX=$O(DATA("DILIST",INDEX)) Q:+INDEX'>0  D
 . S DCNT=DCNT+1
 . S PACKDATA=$G(DATA("DILIST",INDEX,0)),SDARRAY("Disposition Reasons",DCNT,"IEN")=$P(PACKDATA,U)
 . S SDARRAY("Disposition Reasons",DCNT,"Name")=$P(PACKDATA,U,2)
 . Q
 I '$D(SDARRAY) S SDARRAY("Disposition Reasons",1)=""
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.SDARRAY)
 Q
