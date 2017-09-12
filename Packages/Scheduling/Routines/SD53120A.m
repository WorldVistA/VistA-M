SD53120A ;ALB/REV; Scheduling/PCE Bad Pointer Count ;5/15/97
 ;;5.3;Scheduling;**120**;Aug 13, 1993
 ;
EN ;This is the entry point to start the count of problems
 ;in the outpatient encounter file.  This entry point allows 
 ;for date selection and queuing 
 ;
 N BEGDATE,ENDDATE,ZTDESC,ZTIO,ZTRTN,A,X,Y
 ;
 ;if NOT run as post-install, clear SDMNT and prompt for dates
 I '$D(XPDNM) D
 .S SDMNT=""
 .D DATE^SDUTL
 ;if run as post-install, set SDMNT and stuff dates
 E  D
 .S SDMNT="G.AMB CARE DEVELOPERS@ISC-ALBANY.DOMAIN.EXT"
 .S BEGDATE=2961001,ENDDATE=2970331
 I '$D(BEGDATE)!('$D(ENDDATE)) G ENQ
 I BEGDATE<2961001 W !,"Can not select a date before 10/1/96." G EN
 ;
 S ZTRTN="TSK^SD53120A",ZTDESC="Scheduling/PCE Error Count",ZTIO=""
 F A="BEGDATE","ENDDATE","DUZ","SDMNT" S ZTSAVE(A)=""
 I '$D(XPDNM) G:'$$OK() ENQ
 I $D(XPDNM) S X=DT_".23" D H^%DTC S ZTDTH=%H_","_%T
 D ^%ZTLOAD
 S Y=X D DD^%DT
 I $D(ZTSK) D BMES^XPDUTL("Job queued to run "_Y_",  task number "_ZTSK)
 I '$D(ZTSK) D BMES^XPDUTL("Job not queued!")
 ;
ENQ K ZTSAVE,SDBD,SDED,POP,ZTSK,ZTRTN,ZTDTH,%H,%T
 Q
 ;
TSK ; entry point for the queued task
 ;BEGDATE  the date of the encounter this job is to start working at.
 ;ENDDATE  the date of the encounter this job is to stop at.
 ;DUZ      the duz of the user who started the job.
 ;SDMNT    is this the post-install or via menu option?
 ;
 N SDPDATE,SDTEXT,SDPZTSK
 S SDPZTSK=ZTSK
 S SDPDATE=BEGDATE-.0000001
 I '$P(ENDDATE,".",2) S ENDDATE=ENDDATE+".235959"
 S SDTEXT="^TMP($J)"
 D FINDERR
 D MAILMSG(DUZ,SDMNT,SDTEXT)
 S:($D(ZTQUEUED)) ZTREQ="@"
TSKQ Q
 ;
MAILMSG(USER,SDMNT,XMTEXT) ;this subroutine will fire a message when
 ;                        the background job has finished.
 ; USER - who started the job
 ; SDMNT - To Albany CIOFO if run as post-install
 ; XMTEXT - notes for the end of the message
 ;
 N Y,SAV
 S XMDUZ=.5
 I $G(SDMNT)'="" S XMY(SDMNT)=""
 I $D(USER) S XMY(USER)=""
 S XMSUB="Scheduling/PCE Encounter Error Count"
 S SAV=XMTEXT
 S XMTEXT=$TR(XMTEXT,")",",")
 D ^XMD
 S XMTEXT=SAV
 K @XMTEXT,XMZ,XMY,XMDUZ,XMSUB,SDMNT
MAILQ Q
 ;
OK() ;last chance to back out
 N Y,DIR,X
 S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="NO"
 D ^DIR
 Q $S(+Y<1:0,1:1)
 ;
BLDTXT(CTR,TEXT,SDTEXT) ;  create line of text
 S CTR=+CTR+1
 S @SDTEXT@(CTR)=TEXT
 Q
 ;
FINDERR ;  main program block
 N SDMISA,SDBADA,SDTOTA,SDDFN,SDAPPT,SDAP,SDCLIN,SDENC,SCDATE,SCDFN
 N SDMISD,SDBADD,SDTOTD,SCDUPEA,SCDUPED,SCTOTE,SCDUPEE,SCDUPEC
 N SCSTOP,SDSTOP,SDDI,SDDISP,SDDATE,SCAPAT,SCADAT,SCASTP,SCDPAT,SCDDAT
 N SDPAT,SCADT,SCDDT,SDANE,SDANP,SDANA,SDDNE,SDDNP,SDDND,ZTSTOP
 S (SDMISA,SDBADA,SDTOTA,SDMISD,SDBADD,SDTOTD,SDDFN,SCDUPEA,SCDUPEE)=0
 S (SCDUPED,SDPAT,SCDUPEC,SCTOTE,SCAPAT,SCADAT,SCASTP,SCDPAT,SCDDAT)=0
 S (SCADT,SCDDT,SDANE,SDANP,SDANA,SDDNE,SDDNP,SDDND,ZTSTOP)=0
 F SDPAT=1:1 S SDDFN=$O(^DPT(+SDDFN)) Q:+SDDFN=0  D  Q:ZTSTOP
 .S ZTSTOP=$$S^%ZTLOAD
 .D APPT
 .D DISP
 I ZTSTOP D OUTPUT Q
 D DUP
 D OUTPUT
 Q
OUTPUT ; create text for MailMan message
 N SDLINE,Y
 S CTR=$O(@SDTEXT@(99999999),-1)
 S SDLINE="",$P(SDLINE,"-",78)=""
 S Y=$$SITE^VASITE()
 D BLDTXT(.CTR,"      Reporting Site: "_$P(Y,"^",2)_" ("_$P(Y,"^",3)_")",SDTEXT)
 D BLDTXT(.CTR,"  Number of patients: "_SDPAT,SDTEXT)
 S BEGDATE=$$FMTE^XLFDT(BEGDATE)
 S ENDDATE=$$FMTE^XLFDT($P(ENDDATE,".",1))
 D BLDTXT(.CTR,"Encounter Start Date: "_BEGDATE,SDTEXT)
 D BLDTXT(.CTR,"  Encounter End Date: "_ENDDATE,SDTEXT)
 D BLDTXT(.CTR," ",SDTEXT)
 I ZTSTOP D BLDTXT(.CTR,"*** Task halted at user request ***",SDTEXT)
 D BLDTXT(.CTR,SDLINE,SDTEXT)
 D BLDTXT(.CTR,"PATIENT APPOINTMENT MULTIPLE vs. OUTPATIENT ENCOUNTER FILE:",SDTEXT)
 D BLDTXT(.CTR," ",SDTEXT)
 D BLDTXT(.CTR,"Appointment does not point to an encounter:      "_SDANE,SDTEXT)
 D BLDTXT(.CTR,"           Pointed-to encounter is missing:      "_SDMISA,SDTEXT)
 D BLDTXT(.CTR,"Pointed-to encounter has inconsistent data:      "_SDBADA,SDTEXT)
 D BLDTXT(.CTR,"       Not a parent:       "_SDANP,SDTEXT)
 D BLDTXT(.CTR," Not an appointment:       "_SDANA,SDTEXT)
 D BLDTXT(.CTR,"            Patient:       "_SCAPAT,SDTEXT)
 D BLDTXT(.CTR,"               Date:       "_SCADAT,SDTEXT)
 D BLDTXT(.CTR,"               Time:       "_SCADT,SDTEXT)
 D BLDTXT(.CTR,"          Stop code:       "_SCASTP,SDTEXT)
 D BLDTXT(.CTR," ",.SDTEXT)
 D BLDTXT(.CTR,SDMISA+SDBADA+SDANE_" total errors out of "_SDTOTA_" appointment records.",SDTEXT)
 D BLDTXT(.CTR," ",SDTEXT)
 D BLDTXT(.CTR,"NOTE:  The stop code from the PATIENT file Appointment multiple was compared",SDTEXT)
 D BLDTXT(.CTR,"against the stop code in the pointed-to encounter, and non-matches",SDTEXT)
 D BLDTXT(.CTR,"were counted.  Because stop codes are being added and deactivated over time,",SDTEXT)
 D BLDTXT(.CTR,"a true comparison of the stop code of the clinic with the stop code of the",SDTEXT)
 D BLDTXT(.CTR,"appointment/encounter is probably impossible without human review.",SDTEXT)
 D BLDTXT(.CTR,SDLINE,SDTEXT)
 D BLDTXT(.CTR,"PATIENT DISPOSITION MULTIPLE vs. OUTPATIENT ENCOUNTER FILE:",SDTEXT)
 D BLDTXT(.CTR," ",SDTEXT)
 D BLDTXT(.CTR,"Disposition does not point to an encounter:      "_SDDNE,SDTEXT)
 D BLDTXT(.CTR,"           Pointed-to encounter is missing:      "_SDMISD,SDTEXT)
 D BLDTXT(.CTR,"Pointed-to encounter has inconsistent data:      "_SDBADD,SDTEXT)
 D BLDTXT(.CTR,"       Not a parent:       "_SDDNP,SDTEXT)
 D BLDTXT(.CTR,"  Not a disposition:       "_SDDND,SDTEXT)
 D BLDTXT(.CTR,"            Patient:       "_SCDPAT,SDTEXT)
 D BLDTXT(.CTR,"               Date:       "_SCDDAT,SDTEXT)
 D BLDTXT(.CTR,"               Time:       "_SCDDT,SDTEXT)
 D BLDTXT(.CTR," ",SDTEXT)
 D BLDTXT(.CTR,SDMISD+SDBADD+SDDNE_" total errors out of "_SDTOTD_" disposition records.",SDTEXT)
 D BLDTXT(.CTR," ",SDTEXT)
 D BLDTXT(.CTR,SDLINE,SDTEXT)
 D BLDTXT(.CTR,"POSSIBLY DUPLICATE ENCOUNTERS: ",SDTEXT)
 D BLDTXT(.CTR," ",SDTEXT)
 D BLDTXT(.CTR,"Duplicate appointment encounters:                "_SCDUPEA,SDTEXT)
 D BLDTXT(.CTR,"   Duplicate add/edit encounters:                "_SCDUPEE,SDTEXT)
 D BLDTXT(.CTR,"Duplicate disposition encounters:                "_SCDUPED,SDTEXT)
 D BLDTXT(.CTR,"Duplicate credit stop encounters:                "_SCDUPEC,SDTEXT)
 D BLDTXT(.CTR," ",SDTEXT)
 D BLDTXT(.CTR,SCDUPEA+SCDUPEE+SCDUPED+SCDUPEC_" total errors out of "_SCTOTE_" encounter records.",SDTEXT)
 Q
APPT ;  check patient appointment multiple
 N SDOE
 S SDAPPT=SDPDATE
 F  S SDAPPT=$O(^DPT(SDDFN,"S",SDAPPT)) Q:('SDAPPT)!(SDAPPT>ENDDATE)  D
 .S SDTOTA=SDTOTA+1
 .S SDAP=$G(^DPT(SDDFN,"S",SDAPPT,0)) Q:'SDAP
 .S SDCLIN=$P(SDAP,"^",1),SDSTOP=$P(^SC(SDCLIN,0),"^",7)
 .S SDENC=$P(SDAP,"^",20)
 .I 'SDENC S:($P(SDAP,"^",2)="NT") SDANE=SDANE+1 Q
 .I '$D(^SCE(SDENC)) S SDMISA=SDMISA+1 Q
 .S SDOE=$G(^SCE(SDENC,0))
 .I $P(SDOE,"^",6) S SDANP=SDANP+1,SDBADA=SDBADA+1 Q     ;not a parent encounter
 .I $P(SDOE,"^",8)'=1 S SDANA=SDANA+1,SDBADA=SDBADA+1 Q  ;not an appointment
 .S SCDATE=$P(SDOE,"^",1)
 .S SCDFN=$P(SDOE,"^",2)
 .S SCSTOP=$P(SDOE,"^",3)
 .I SDDFN'=SCDFN S SCAPAT=SCAPAT+1,SDBADA=SDBADA+1 Q
 .I $P(SCDATE,".",1)'=$P(SDAPPT,".",1) S SCADAT=SCADAT+1,SDBADA=SDBADA+1 Q
 .I $P(SCDATE,".",2)'=$P(SDAPPT,".",2) S SCADT=SCADT+1,SDBADA=SDBADA+1 Q
 .I SCSTOP'=SDSTOP S SCASTP=SCASTP+1,SDBADA=SDBADA+1 Q
 Q
DISP ;  check patient disposition multiple
 N SDOE
 S SDDISP=9999999-ENDDATE
 F  S SDDISP=$O(^DPT(SDDFN,"DIS",SDDISP)) Q:('SDDISP)!((9999999-SDDISP)<SDPDATE)  D
 .S SDTOTD=SDTOTD+1
 .S SDDI=$G(^DPT(SDDFN,"DIS",SDDISP,0)) Q:'SDDI
 .I $P(SDDI,"^",2)=2 Q
 .S SDENC=$P(SDDI,"^",18)
 .I 'SDENC S:(+$P(SDDI,"^",6)) SDDNE=SDDNE+1 Q
 .I '$D(^SCE(SDENC)) S SDMISD=SDMISD+1 Q
 .S SDOE=$G(^SCE(SDENC,0))
 .I $P(SDOE,"^",6) S SDDNP=SDDNP+1,SDBADD=SDBADD+1 Q     ;not a parent encounter
 .I $P(SDOE,"^",8)'=3 S SDDND=SDDND+1,SDBADD=SDBADD+1 Q   ;not a disposition
 .S SDDATE=$P(SDDI,"^",1)
 .S SCDATE=$P(SDOE,"^",1)
 .S SCDFN=$P(SDOE,"^",2)
 .I SDDFN'=SCDFN S SCDPAT=SCDPAT+1,SDBADD=SDBADD+1 Q
 .I $P(SCDATE,".",1)'=$P(SDDATE,".",1) S SCDDAT=SCDDAT+1,SDBADD=SDBADD+1 Q
 .I $P(SCDATE,".",2)'=$P(SDDATE,".",2) S SCDDT=SCDDT+1,SDBADD=SDBADD+1 Q
 Q
DUP ;  loop through outpatient encounter file - call DUPCHECK
 N SCDFN,SCDT,SCENC,SCREC1,SCREC2,SCNUM1,SCNUM2
 S (SCDFN,SCDT,SCREC1,SCREC2,SCNUM1,SCNUM2,SCENC)=""
 F  S SCDFN=$O(^SCE("ADFN",SCDFN)) Q:'SCDFN  D  Q:ZTSTOP
 .S ZTSTOP=$$S^%ZTLOAD
 .S SCDT=SDPDATE
 .F  S SCDT=$O(^SCE("ADFN",SCDFN,SCDT)) Q:('SCDT)!(SCDT>ENDDATE)  D
 ..S SCENC=""
 ..F  S SCENC=$O(^SCE("ADFN",SCDFN,SCDT,SCENC)) Q:'SCENC  D DUPCHECK
 Q
DUPCHECK ;  check for duplicates
 S SCTOTE=SCTOTE+1
 S SCNUM1=SCENC,SCREC1=$G(^SCE(+SCENC,0)) Q:'SCREC1
 S SCNUM2=$O(^SCE("ADFN",SCDFN,SCDT,SCNUM1)) Q:SCNUM2=""
 S SCREC2=$G(^SCE(+SCNUM2,0)) Q:'SCREC2
 Q:$P(SCREC1,"^",6)!($P(SCREC2,"^",6))     ;not a parent encounter
 Q:$P(SCREC2,"^",1,3)'=$P(SCREC1,"^",1,3)  ;not same date/patient/stop
 Q:$P(SCREC2,"^",5)'=$P(SCREC1,"^",5)      ;not same Visit ID
 Q:$P(SCREC2,"^",8)'=$P(SCREC1,"^",8)      ;not same Orig Proc
 I $P(SCREC1,"^",8)=1 S SCDUPEA=SCDUPEA+1 Q
 I $P(SCREC1,"^",8)=2 S SCDUPEE=SCDUPEE+1 Q
 I $P(SCREC1,"^",8)=3 S SCDUPED=SCDUPED+1 Q
 I $P(SCREC1,"^",8)=4 S SCDUPEC=SCDUPEC+1 Q
 Q
