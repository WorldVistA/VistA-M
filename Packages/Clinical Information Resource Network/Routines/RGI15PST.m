RGI15PST ;Hines OI/GJC-POST-INIT FOR RG*1.0*15 ;01/03/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**15**;30 Apr 99
 ;
 N RGC
 S RGC=$$NEWCP^XPDUTL("POST1","EN1^RGI15PST")
 ;         Check to see the patient has had a check out event
 ;         due to a completion of a Rad/Nuc Med, Surgery or Lab
 ;         procedure.  Checkpoint for patient's ICN while traversing
 ;         the AICN cross reference in the Patient (#2) file.
 ;
 S RGC=$$NEWCP^XPDUTL("POST2")
 ;         Checkpoint for patient's dfn while traversing
 ;         the AICN cross reference in the Patient (#2) file.
 ;         
 Q
EN1 ; entry point to check the TREATING FACILITY LIST (TFL-391.91) file
 ; for the proper LAST TREATMENT DATE.  This code is part of the post
 ; init for RG*1*15.
 ;
 ; Integration Agreements (IAs) utilized in this application:
 ; #2988-IAs for VAFCTFU utilities
 ; #2911-Treating Facility List (TFL-391.91) relationship with MPI/PD
 ; #2070-use of Integration Control Number (ICN) 'AICN' cross reference
 ;
 S:$D(ZTQUEUED) ZTREQ="@"
 N RGDT S RGDT=$P($G(^RGSITE(991.8,1,1)),"^",3)
 I RGDT D  Q
 .N RGTXT
 .S RGTXT(1)="Data comparison ran on "_$$FMTE^XLFDT($E(RGDT,1,12),"1P")
 .S RGTXT(2)="Data comparison process exiting..."
 .D BMES^XPDUTL(.RGTXT)
 .Q
 S (RGCNT,RGCNT(0),RGXIT)=0
 S RGSTART=$$FMTE^XLFDT($E($$NOW^XLFDT(),1,12),"1P") ; start time
 S U="^",RGSITE=$$KSP^XUPARAM("INST") ;defines the local facility
 ; checkpoints for RGICN (POST1) & RGDFN (POST2)
 S RGICN=+$$PARCP^XPDUTL("POST1")
 ; check ALL patients with an Integration Control Number (ICN) for a
 ; given facility, make sure the DATE LAST TREATED field in the
 ; TREATING FACILITY LIST (#391.91-TFL) file is correct.
 F  S RGICN=$O(^DPT("AICN",RGICN)) Q:RGICN'>0  D  Q:RGXIT
 .S RGDFN=+$$PARCP^XPDUTL("POST2")
 .F  S RGDFN=$O(^DPT("AICN",RGICN,RGDFN)) Q:RGDFN'>0  D  Q:RGXIT
 ..D EN2(RGDFN)
 ..S RGS=$$UPCP^XPDUTL("POST2",RGDFN)
 ..S RGCNT=RGCNT+1
 ..Q:(RGCNT#250)  ; every 250 patients, check if process stopped
 ..D:'$D(ZTQUEUED) EN^DDIOL(".",,"?0") ; print dots (process active)
 ..S RGXIT=$$S^%ZTLOAD() ; return 1 if user stopped the task, else 0
 ..S:RGXIT ZTSTOP=1 ; informs submgr to set task status to 'stopped'
 ..Q
 .S RGS=$$UPCP^XPDUTL("POST1",RGICN)
 .S RGS=$$UPCP^XPDUTL("POST2",RGDFN)
 .Q
 S RGFIN=$$FMTE^XLFDT($E($$NOW^XLFDT(),1,12),"1P") ; finish time
 D EMAIL
 I '$G(ZTSTOP) D  ; only if the process runs to completion
 .K RGFDA S RGFDA(991.8,"1,",13)=$$NOW^XLFDT()
 .D FILE^DIE("K","RGFDA")
 .Q
 D KILL
 QUIT
 ;
EN2(RGDFN) ; determine the LAST TREATMENT DATE for a single
 ; patient called from our seeding process above.
 ; input: RGDFN - the dfn of the patient
 ;
 Q:$$LOCICN^RGADT2(RGDFN,$G(RGICN))  ; local ICN
 ; find the date last treated for this patient at this facility.
 ; check the Outpatient Encounter (OE) file for a date
 ; chronologically after the date/time filed in the TFL (#391.91)
 ; file.  If a date/time exists that falls after the date/time on file
 ; update the CMOR/subscribers.
 S RGCNT(0)=RGCNT(0)+1
 S RGTFL=+$O(^DGCN(391.91,"APAT",RGDFN,RGSITE,0))
 S RGDLT=$P($G(^DGCN(391.91,RGTFL,0)),U,3) ; a date/time or null
 S RGDATE=$$ENCDT(RGDFN,RGDLT) ; patient's OE date/time (if any)
 I $L(RGDATE),RGDATE>RGDLT D FILE^VAFCTFU(RGDFN,RGSITE_U_RGDATE_U_"A3",$G(RGSUP))
 ; update the TFL file for the site running the Outpatient Encounter
 ; check.  Build the HL7 message with the new DATE LAST TREATED &
 ; ADT/HL7 EVENT REASON values & send them to our CMOR/subscribers.
 Q
 ;
KILL ; kill and quit
 K RGCNT,RGDATE,RGDFN,RGDLT,RGFIN,RGICN,RGPARSE,RGS,RGSITE,RGSTART
 K RGTFL,RGXIT
 Q
 ;
ENCDT(DFN,INPDT) ; find the last patient check out date/time.  'ADFN'
 ; cross-reference accessed through DBIA: 2953
 ; Input: DFN  - ien of the patient (file 2)
 ;        INPDT - date (if any) obtained from the DATE LAST TREATED
 ;                (#.03) field on the TFL (#391.91) file.
 ;Output: a valid check out date/time -or- null
 ;
 K RGDATA,RGPURGE,RGX,RGX1,RGX2 N RGX3
 S RGX=$C(32),RGX2=0,RGX3=""
 F  S RGX=$O(^SCE("ADFN",DFN,RGX),-1) Q:'RGX!(INPDT>RGX)  D  Q:RGX2
 .S RGX1=0
 .F  S RGX1=$O(^SCE("ADFN",DFN,RGX,RGX1)) Q:'RGX1  D  Q:RGX2
 ..D GETGEN^SDOE(RGX1,"RGDATA"),PARSE^SDOE(.RGDATA,"EXTERNAL","RGPARSE")
 ..I $G(RGPARSE(.12))="CHECKED OUT" S RGX2=1,RGX3=RGX
 ..K RGDATA,RGPARSE
 ..Q
 .Q
 K RGDATA,RGPURGE,RGX,RGX1,RGX2
 Q RGX3 ; X is either null or the date/time of the check out
 ;
EMAIL ; Send a completion email message to the user who installed this patch.
 ; Show the number of patient records processed, elapsed time and the
 ; number of patient records processed per minute.
 N DIFROM,RGARY S XMDUZ=.5,XMY(DUZ)="",XMTEXT="RGARY(1,"
 S XMY("G.MPIF EXCEPTIONS")="" ; keep us updated...
 S XMSUB="MPI/PD-determine the correct DATE LAST TREATED"
 S RGARY(1,1)="Data compare between the DATE field in the OUTPATIENT ENCOUNTER"
 S RGARY(1,2)="(#409.68) file and the DATE LAST TREATED field in the TREATING"
 S RGARY(1,3)="FACILITY LIST (#391.91) file"
 S RGARY(1,4)="process start time: "_RGSTART
 S RGARY(1,5)="process completion time: "_RGFIN
 S RGARY(1,6)=" "
 S RGARY(1,7)="# of processed patients, in the PATIENT (#2) file with"
 S RGARY(1,8)="an ICN: "_RGCNT
 S RGARY(1,9)="# of processed patients, in the PATIENT (#2) file with"
 S RGARY(1,10)="a non-local ICN: "_RGCNT(0)
 I $G(ZTSTOP) S RGARY(1,11)=" ",RGARY(1,12)="Note: task stopped by user intervention"
 D ^XMD K XMDUZ,XMSUB,XMTEXT,XMY
 Q
