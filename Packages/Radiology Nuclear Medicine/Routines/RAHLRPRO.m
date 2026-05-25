RAHLRPRO ;WOIFO/KLM - Radiology HL7 Reprocessing Utilities ; Jun 20, 2025@13:09:53
 ;;5.0;Radiology/Nuclear Medicine;**220,227**;Mar 16, 1998;Build 2
 ;
 ; This routine is called by the scheduled option 'Reprocess locked study accession error'
 ; It traverses the index on a REPROCESS flag of the HL7 MESSAGE EXCEPTIONS file for
 ; result messages rejected with a "Lock of Accession.." or "Lock of Report.." error
 ; and calls the HL7 utility to reprocess the message.   
 ;
 ; Routine/File         IA          Type
 ; -------------------------------------
 ; $$REPROC^HLUTL      2434         (S)
 ; ^HLMA (fld #2)      3244         (C)
 ;
 ; 
 ;
REPROC ;Record locked error - HL7 MESSAGE EXCEPTIONS file (#79.3)
 N RA773,RARTN,RAN,RAERR,RAEXDA,RAMID,RAR,RARST,RAREP,RAR,RADFN,RADTI,RACNI,RADC
 S RARTN="RAHLTCPB"
 S RAEXDA=0 F  S RAEXDA=$O(^RA(79.3,"C","Y",RAEXDA)) Q:RAEXDA=""  D
 .;get message IEN/check if purged
 .I $$CHECKHL7(RAEXDA)=1 D DFLAG(RAEXDA) Q  ;Message purged, clear flag
 .;get ACC# / Check lock and report status
 .S RAERR=$$GET1^DIQ(79.3,RAEXDA,1)
 .K RAN S RAN=$P($P(RAERR,": ",2)," ") Q:RAN=""
 .I $$CHECKLOC(RAN)=1 Q  ;do not clear flag
 .S RAR=$$GETRPT(RAN)
 .I $$CHECKRPT(RAN)=1 D DFLAG(RAEXDA) Q  ;Report already filed, clear flag
 .;call REPROC^HLUTIL
 .K RAREP S RAREP=$$REPROC^HLUTIL($$GET1^DIQ(79.3,RAEXDA,.05,"I"),RARTN)
 .;Check if successful
 .I RAREP=0 D UPDATEX(RAEXDA,RAN)
 .Q
 Q
CHECKHL7(RAX) ;Check Hl7 message status
 ;RAX is the IEN from 79.3
 I RAX="" Q 1
 N RA773,RAMID,RAMST
 S RA773=$$GET1^DIQ(79.3,RAEXDA,.05,"I") I RA773="" Q 1
 S RAMID=$$GET1^DIQ(773,RA773,2) I RAMID="" Q 1
 S RAMST=$$MSGSTAT^HLUTIL(RAMID)
 I +RAMST'=3 Q 1 ;3 means HL7 message successfully completed and not yet purged
 Q 0
CHECKLOC(RAN) ;Check if the exam record is still locked
 ;RAN is the Accession number
 I $G(RAN)="" Q 1
 N RADC,RADFN,RADTI
 S RADC=$S($L($P(RAN,"-"))=3:"ADC1",1:"ADC") I $G(RADC)="" Q 1
 S RADFN=$O(^RADPT(RADC,RAN,"")) I $G(RADFN)="" Q 1
 S RADTI=$O(^RADPT(RADC,RAN,RADFN,"")) I $G(RADTI)="" Q 1
 L +^RADPT(RADFN,"DT",RADTI):2 I '$T Q 1 ;record still locked
 L -^RADPT(RADFN,"DT",RADTI) ;unlock it
 Q 0
CHECKRPT(RAN) ;Check if report exists and status
 ;RAN is the Accession number
 I $G(RAN)="" Q 1
 N RADC,RADFN,RADTI,RACNI,RAR
 ;p227: could be printset - get rpt pointer from exam
 S RAR=$$GETRPT(RAN) I $G(RAR)<1 Q 0
 ;report exists - check status
 I $G(RAR)>0 S RARST=$$GET1^DIQ(74,RAR,5,"I")
 I $G(RARST)="V"!($G(RARST)="EF") Q 1  ;Report already filed
 Q 0
UPDATEX(RAX,RAN) ;Clear Reprocess Flag
 ;RAX is the IEN from 79.3
 ;RAN is the accession number
 Q:$G(RAX)=""!($G(RAN)="")
 N RARST,RAR
 S RAR=$$GETRPT(RAN) Q:$G(RAR)<1
 S RARST=$$GET1^DIQ(74,RAR,5,"I")
 I ($G(RARST)'="V"),($G(RARST)'="R") Q  ;p226v2 Not verified or prelim
 D DFLAG(RAX)
 Q
DFLAG(RAX) ;delete reprocess flag
 Q:RAX=""
 N RAFDA
 S RAFDA(79.3,RAEXDA_",",.07)="@"
 D FILE^DIE("","RAFDA")
 Q
SANABLE ;Enable reprocessing for a sending application
 ;Called by option RASAN ENABLE REPROCESSING
 S DIC="^RA(79.7,",DIC(0)="AEMQL",DLAYGO=79.7 W ! D ^DIC K DIC,DLAYGO I Y<0 K D,X,Y Q
 S DA=+Y,DIE="^RA(79.7,",DR="1.6;1.7" D ^DIE
 K DA,DIE,DR,DIC,D,D0,DI,DTO,X G SANABLE
 Q
GETRPT(RAN) ;p227 - pset handling, get report pointer from 70.03;17
 ;RAN is the Accession number
 I $G(RAN)="" Q 0
 N RADFN,RADTI,RACNI,RADC,RAR
 S RADC=$S($L($P(RAN,"-"))=3:"ADC1",1:"ADC") I $G(RADC)="" Q 0
 S RADFN=$O(^RADPT(RADC,RAN,"")) I $G(RADFN)="" Q 0
 S RADTI=$O(^RADPT(RADC,RAN,RADFN,"")) I $G(RADTI)="" Q 0
 S RACNI=$O(^RADPT(RADC,RAN,RADFN,RADTI,"")) I $G(RACNI)="" Q 0
 S RAR=$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,17) I $G(RAR)="" Q 0
 Q $G(RAR)
