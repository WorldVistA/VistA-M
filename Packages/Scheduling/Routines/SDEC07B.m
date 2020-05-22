SDEC07B ;ALB/SAT - VISTA SCHEDULING RPCS ;MAY 15, 2017
 ;;5.3;Scheduling;**627,658,665,669,722,744**;Aug 13, 1993;Build 3
 ;
 Q
 ;
MAKE(BSDR) ;PEP; call to store appt made
 ;
 ; Make call using: S ERR=$$MAKE^SDEC07B(.ARRAY)
 ;
 ; Input Array -
 ; BSDR("PAT") = ien of patient in file 2
 ; BSDR("CLN") = ien of clinic in file 44
 ; BSDR("TYP") = C&P if appointment type is C&P, 3 for scheduled appts, 4 for walkins
 ; BSDR("COL") = collateral if appointment type is COLLATERAL OF VET.
 ; BSDR("APT") = Appointment type pointer to APPOINTMENT TYPE file 409.1
 ; BSDR("ADT") = appointment date and time
 ; BSDR("LEN") = appointment length in minutes (5-120)
 ; BSDR("OI")  = reason for appt - up to 150 characters
 ; BSDR("USR") = user who made appt
 ; BSDR("RES") = resource pointer to SDEC RESOURCE ^SDEC(409.831,
 ; BSDR("MTR") = MTRC flag (multiple appointments) 0=False (default)  1=True
 ; BSDR("DDT") = Desired Date of Appt in fm format
 ; BSDR("REQ") = Requested By - valid values are 1=PROVIDER  2=PATIENT or ""
 ; BSDR("LAB") = LAB date/time in fm format
 ; BSDR("EKG") = EKG date/time in fm format
 ; BSDR("XRA") = XRAY date/time in fm format
 ; BSDR("CON") = Consult link - pointer to file 123
 ; BSDR("OVB") = overbook flag - 1=yes, this is an overbook
 ; BSDR("ELG") = Patient Eligibilty
 ; 
 ;Output: error status and message
 ;   = 0 or null:  everything okay
 ;   = 1^message:  error and reason
 ;
 I '$D(^DPT(+$G(BSDR("PAT")),0)) Q 1_U_"Patient not on file: "_$G(BSDR("PAT"))
 I '$D(^SC(+$G(BSDR("CLN")),0)) Q 1_U_"Clinic not on file: "_$G(BSDR("CLN"))
 I "1234"'[$G(BSDR("TYP")) Q 1_U_"Appt Type error: "_$G(BSDR("TYP"))
 I $G(BSDR("ADT")) S BSDR("ADT")=+$E(BSDR("ADT"),1,12)  ;remove seconds
 I $G(BSDR("ADT"))'?7N1".".4N Q 1_U_"Appt Date/Time error: "_$G(BSDR("ADT"))
 ;
 I ($G(BSDR("LEN"))<5)!($G(BSDR("LEN"))>240) Q 1_U_"Appt Length error: "_$G(BSDR("LEN"))
 I '$D(^VA(200,+$G(BSDR("USR")),0)) Q 1_U_"User Who Made Appt Error: "_$G(BSDR("USR"))
 I $D(^DPT(BSDR("PAT"),"S",BSDR("ADT"),0)),$P(^DPT(BSDR("PAT"),"S",BSDR("ADT"),0),U,2)'="C",$P(^DPT(BSDR("PAT"),"S",BSDR("ADT"),0),U,2)'="PC" Q 1_U_"Patient "_$$GET1^DIQ(2,BSDR("PAT")_",",.01)_" already has appt at "_$$FMTE^XLFDT(BSDR("ADT"))
 ;
 N DIC,DA,Y,X,DD,DO,DLAYGO
 N SDECERR
 N SDFU,SDNA,SDRET,SDSRT
 ;
 S BSDR("APT")=+$G(BSDR("APT"))
 S BSDR("COL")=+$G(BSDR("COL"))
 ;get scheduling request type AND next ava. appt. indicator
 S SDSRT=$$SDSRT(BSDR("TYP"),BSDR("MTR"),BSDR("DDT"),BSDR("REQ"))
 ; next ava.appt. indicator field 26
 S SDNA=$P(SDSRT,U,2)
 ; scheduling request type field 25
 S SDSRT=$P(SDSRT,U,1)
 ;determine if Follow-up visit field 28
 S SDRET=""
 D PCSTGET^SDEC(.SDRET,BSDR("PAT"),BSDR("CLN"))
 S SDFU=$P($P(@SDRET@(1),U,2),$C(30,31),1)
 S SDFU=$S(SDFU="YES":1,1:0)
 K @SDRET
 ;store
 N SDECCOND
 S SDECCOND=0 I $D(^DPT(BSDR("PAT"),"S",BSDR("ADT"),0)),(($P(^DPT(BSDR("PAT"),"S",BSDR("ADT"),0),U,2)="C")!($P(^DPT(BSDR("PAT"),"S",BSDR("ADT"),0),U,2)="PC")) S SDECCOND=1
 I SDECCOND=1 D
 . ; "un-cancel" existing appt in file 2
 . N SDECFDA,SDECIENS,SDECMSG
 . S SDECIENS=BSDR("ADT")_","_BSDR("PAT")_","
 . S SDECFDA(2.98,SDECIENS,".01")=$$NULLDEL(BSDR("CLN")) ;*zeb+19 722 2/19/19 completely replace old appt's data if overlaying; prevent chimera appt
 . S SDECFDA(2.98,SDECIENS,"3")=$$NULLDEL($S($G(^DPT(+$G(BSDR("PAT")),.1))'="":"I",1:""))
 . S SDECFDA(2.98,SDECIENS,"5")=$$NULLDEL(BSDR("LAB"))    ;lab date/time
 . S SDECFDA(2.98,SDECIENS,"6")=$$NULLDEL(BSDR("XRA"))    ;xray date/time
 . S SDECFDA(2.98,SDECIENS,"7")=$$NULLDEL(BSDR("EKG"))    ;ekg date/time
 . S SDECFDA(2.98,SDECIENS,"9")=$$NULLDEL(BSDR("TYP"))
 . S SDECFDA(2.98,SDECIENS,"9.5")=$$NULLDEL(BSDR("APT"))
 . S SDECFDA(2.98,SDECIENS,"13")=$$NULLDEL(BSDR("COL"))
 . S SDECFDA(2.98,SDECIENS,"14")="@"
 . S SDECFDA(2.98,SDECIENS,"15")="@"
 . S SDECFDA(2.98,SDECIENS,"16")="@"
 . S SDECFDA(2.98,SDECIENS,"17")="@"   ;alb/sat 658
 . S SDECFDA(2.98,SDECIENS,"19")=$$NULLDEL(DUZ)           ;data entry clerk
 . S SDECFDA(2.98,SDECIENS,"20")=$$NOW^XLFDT
 . S SDECFDA(2.98,SDECIENS,"21")="@"                      ;outpatient encounter ;*zeb 722 2/26/19 clear to fix OE link issue if cancelled again
 . S SDECFDA(2.98,SDECIENS,"25")=$$NULLDEL(SDSRT)         ;scheduling request type
 . S SDECFDA(2.98,SDECIENS,"26")=$$NULLDEL(SDNA)          ;next ava. appt. indicator
 . S SDECFDA(2.98,SDECIENS,"27")=$$NULLDEL(BSDR("DDT"))   ;desired date of appt
 . S SDECFDA(2.98,SDECIENS,"28")=$$NULLDEL(SDFU)          ;follow-up visit  yes/no
 . D FILE^DIE("","SDECFDA","SDECMSG")
 . N SDECTEMP S SDECTEMP=$$NULLDEL($G(SDECMSG))
 E  D  I $G(SDECERR(1)) Q 1_U_"FileMan add to DPT error: Patient="_BSDR("PAT")_" Appt="_BSDR("ADT")
 . ; add appt to file 2
 . N SDECFDA,SDECIENS,SDECMSG
 . S SDECIENS="?+2,"_BSDR("PAT")_","
 . S SDECIENS(2)=BSDR("ADT")
 . S SDECFDA(2.98,SDECIENS,.01)=BSDR("CLN")
 . S SDECFDA(2.98,SDECIENS,"3")=$S($G(^DPT(+$G(BSDR("PAT")),.1))'="":"I",1:"")
 . S SDECFDA(2.98,SDECIENS,"5")=BSDR("LAB")    ;lab date/time
 . S SDECFDA(2.98,SDECIENS,"6")=BSDR("XRA")    ;xray date/time
 . S SDECFDA(2.98,SDECIENS,"7")=BSDR("EKG")    ;ekg date/time
 . S SDECFDA(2.98,SDECIENS,"9")=BSDR("TYP")
 . S:+BSDR("APT") SDECFDA(2.98,SDECIENS,"9.5")=BSDR("APT")
 . S:+BSDR("COL") SDECFDA(2.98,SDECIENS,"13")=BSDR("COL")
 . S SDECFDA(2.98,SDECIENS,"14")=""
 . S SDECFDA(2.98,SDECIENS,"15")=""
 . S SDECFDA(2.98,SDECIENS,"16")=""
 . S SDECFDA(2.98,SDECIENS,"17")=""   ;alb/sat 658
 . S SDECFDA(2.98,SDECIENS,"19")=DUZ           ;data entry clerk
 . S SDECFDA(2.98,SDECIENS,"20")=$$NOW^XLFDT
 . S SDECFDA(2.98,SDECIENS,"25")=SDSRT         ;scheduling request type
 . S SDECFDA(2.98,SDECIENS,"26")=SDNA          ;next ava. appt. indicator
 . S SDECFDA(2.98,SDECIENS,"27")=BSDR("DDT")   ;desired date of appt
 . S SDECFDA(2.98,SDECIENS,"28")=SDFU          ;follow-up visit  yes/no
 . D UPDATE^DIE("","SDECFDA","SDECIENS","SDECERR(1)")
 ; add appt to file 44
 K DIC,DA,X,Y,DLAYGO,DD,DO
 I '$D(^SC(BSDR("CLN"),"S",0)) S ^SC(BSDR("CLN"),"S",0)="^44.001DA^^"
 I '$D(^SC(BSDR("CLN"),"S",BSDR("ADT"),0)) D  I Y<1 Q 1_U_"Error adding date to file 44: Clinic="_BSDR("CLN")_" Date="_BSDR("ADT")
 . S DIC="^SC("_BSDR("CLN")_",""S"",",DA(1)=BSDR("CLN"),(X,DINUM)=BSDR("ADT")
 . S DIC("P")="44.001DA",DIC(0)="L",DLAYGO=44.001
 . S Y=1 I '$D(@(DIC_X_")")) D FILE^DICN
 ;
 K DIC,DA,X,Y,DLAYGO,DD,DO,DINUM
 S DIC="^SC("_BSDR("CLN")_",""S"","_BSDR("ADT")_",1,"
 S DA(2)=BSDR("CLN"),DA(1)=BSDR("ADT"),X=BSDR("PAT")
 S DIC("DR")="1////"_BSDR("LEN")_";3///"_$E($G(BSDR("OI")),1,150)_";7////"_BSDR("USR")_";8////"_$$NOW^XLFDT_";30////"_BSDR("ELG")_$S(+$G(BSDR("OVB")):";9////O",1:"")
 S DIC("P")="44.003PA",DIC(0)="L",DLAYGO=44.003
 D FILE^DICN
 ;add consult link
 I $G(BSDR("CON")) D
 .N SDFDA,SDIEN
 .S SDIEN=+Y
 .Q:SDIEN=-1
 .S SDFDA(44.003,SDIEN_","_BSDR("ADT")_","_BSDR("CLN")_",",688)=BSDR("CON")
 .D UPDATE^DIE("","SDFDA")
 ; removed quit so event driver could be called pwc 2/26/20 SD*5.3*744
 ; call event driver
 NEW DFN,SDT,SDCL,SDDA,SDMODE
 S DFN=BSDR("PAT"),SDT=BSDR("ADT"),SDCL=BSDR("CLN"),SDMODE=2
 S SDDA=$$SCIEN^SDECU2(BSDR("PAT"),BSDR("CLN"),BSDR("ADT"))
 D MAKE^SDAMEVT(DFN,SDT,SDCL,SDDA,SDMODE)
 Q 0
 ;
NULLDEL(STR) ;return "@" to delete a field if the new data would be null ;*zeb+tag 722 2/19/19 added to support APPADD
 Q $S(STR]"":STR,1:"@")
 ;
SDSRT(TYP,MTR,DDT,REQ) ;get SCHEDULING REQUEST TYPE and NEXT AVA.APPT. INDICATOR
 ;INPUT:
 ; TYP =  3 for scheduled appts, 4 for walkins
 ; MTR = MTRC flag (multiple appointments) 0=False (default)  1=True
 ; DDT = Desired Date of Appt in fm format
 ; REQ = Requested By - valid values are 1=PROVIDER  2=PATIENT or ""
 ;RETURN: 2 ^ pieces:
 ;     1 - SCHEDULING REQUEST TYPE  internal format - valid values:
 ;          N:'NEXT AVAILABLE' APPT.
 ;          C:OTHER THAN 'NEXT AVA.' (CLINICIAN REQ.)
 ;          P:OTHER THAN 'NEXT AVA.' (PATIENT REQ.)
 ;          W:WALKIN APPT.
 ;          M:MULTIPLE APPT. BOOKING
 ;          A:AUTO REBOOK
 ;          O:OTHER THAN 'NEXT AVA.' APPT.
 ;     2 - NEXT AVA. APPT. INDICATOR  internal format - valid values:
 ;          N:'NEXT AVAILABLE' APPT.
 ;          C:OTHER THAN 'NEXT AVA.' (CLINICIAN REQ.)
 ;          P:OTHER THAN 'NEXT AVA.' (PATIENT REQ.)
 ;          W:WALKIN APPT.
 ;          M:MULTIPLE APPT. BOOKING
 ;          A:AUTO REBOOK
 ;          O:OTHER THAN 'NEXT AVA.' APPT.
 ;
 N RET
 S RET=""
 ;1. If user creates a walkin appointment would be W:WALKIN APPT, 0:NOT INDICATED TO BE A 'NEXT AVA.' APPT
 I TYP=4 Q "W^0"
 ;2. If user creates an rm request with MTRC flagged
 ;   AND desired date is 'today'
 ; would be M:MULTIPLE APPT. BOOKING, 3:'NEXT AVA.' APPT. INDICATED BY USER & CALCULATION
 I +MTR,$P($$NOW^XLFDT,".",1)=DDT Q "M^3"
 ;3. If user creates an rm request with MTRC flagged
 ;   AND desired date is not 'today'
 ; would be M:MULTIPLE APPT. BOOKING, 0:'NOT INDICATED TO BE A 'NEXT AVA.' APPT
 I +MTR,$P($$NOW^XLFDT,".",1)'=DDT Q "M^0"
 ;4. If the user enters a desired date for the clinic stop that is today
 ;  then N:'NEXT AVAILABLE' APPT., 1:'NEXT AVA.' APPT. INDICATED BY USER
 I $P($$NOW^XLFDT(),".",1)=DDT Q "N^1"
 ;5. If the user enters a desired date not today
 ;   AND the request is by patient
 ; then P:OTHER THAN 'NEXT AVA.' (PATIENT REQ.); 0:NOT INDICATED TO BE A 'NEXT AVA.' APPT.
 I $P($$NOW^XLFDT(),".",1)'=DDT,REQ=2 Q "P^0"
 ;6. If the user enters a desired date not today
 ;   AND the request is by provider
 ; then C:OTHER THAN 'NEXT AVA.' (CLINICIAN REQ.); 0:NOT INDICATED TO BE A 'NEXT AVA.' APPT.
 I $P($$NOW^XLFDT(),".",1)'=DDT,REQ=1 Q "C^0"
 Q RET
 ;
 ;Create Appointment  ;alb/sat 665 moved from SDEC07
APPVISTA(SDECLEN,SDECNOTE,DFN,SDECRESD,SDECSTART,SDECWKIN,SDCL,SDECI) ;
 N SDECC,SDECERR,SDECRNOD
 S SDECRNOD=$G(^SDEC(409.831,SDECRESD,0))
 I SDECRNOD="" D ERR^SDEC07(SDECI+1,"SDEC07 Error: Unable to add appointment -- invalid Resource entry.") Q 1
 S SDECERR=""
 I +SDCL,$D(^SC(SDCL,0)) D  I +SDECERR D ERR^SDEC07(SDECI+1,SDECERR) Q SDECERR
 . S SDECC("PAT")=DFN
 . S SDECC("CLN")=SDCL
 . S SDECC("TYP")=3 ;3 for scheduled appts, 4 for walkins
 . S:SDECWKIN SDECC("TYP")=4
 . S SDECC("ADT")=SDECSTART
 . S SDECC("LEN")=SDECLEN
 . S SDECC("OI")=$E($G(SDECNOTE),1,150) ;File 44 has 150 character limit on OTHER field
 . S SDECC("OI")=$TR(SDECC("OI"),";"," ") ;No semicolons allowed
 . S SDECC("OI")=$$STRIP^SDEC07(SDECC("OI")) ;Strip control characters from note
 . S SDECC("RES")=SDECRESD
 . S SDECC("USR")=DUZ
 . S SDECERR=$$MAKE^SDEC07B(.SDECC)
 . Q:SDECERR
 . D AVUPDT^SDEC07(SDCL,SDECSTART,SDECLEN)
 Q +SDECERR
