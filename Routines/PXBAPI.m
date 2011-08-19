PXBAPI ;ISL/JVS,ISA/KWP - PCE's API interview questions - encounter ;04/26/99
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**19,67,173**;Aug 12, 1996
 Q
 ;
INTV(WHAT,PACKAGE,SOURCE,PXBVST,PXBHLOC,PXBPAT,PXBAPPT,PXLIMDT,PXALHLOC) ;
 ;+This api will prompt the user for Visit and related V-file data used to document an encounter.
 ;+Interview Questions
 ;+Parameters
 ;+  WHAT  Required, defines the series of prompts. Valid values are:
 ;+    "INTV" all of the prompts in the checkout interview.
 ;+    "ADQ"  all of the administrative prompts related to the interview.
 ;+    "CODT" prompts for the Check Out Date/Time.
 ;+    "SCC"  prompts for the service connected conditions.
 ;+    "PRV"  prompts for the providers
 ;+    "CPT"  prompts for the provider and then the procedures that 
 ;+           the provider did.
 ;+    "POV"  prompts for the diagnoses
 ;+    "STP"  prompts for the stop codes
 ;+----------
 ;+  PACKAGE  Required, text string of the package name space
 ;+             or a pointer to the Package file (#9.4)
 ;+  SOURCE   Required, text string that discribes the source of the data.
 ;+             This will be added to the PCE Data Source file (#839.7) if
 ;+             it is not already in the file.
 ;+  PXBVST   Required except for on "INTV" and "ADQ".
 ;+             This is a pointer to the Visit file (#9000010)
 ;+  PXBHLOC  Optional (passed if known) pointer to the Hospital
 ;+             Location file (#44)
 ;+  PXBPAT   Pointer to the Patient file (#2)
 ;+             Required if there is no PXBVST and there is a PXBAPPT
 ;+             otherwise it is Optional (passed if known) 
 ;+  PXBAPPT  Optional (passed if known) pointer to the Apointment 
 ;+             subfile (#2.98) of the Patient file (#2)
 ;+  PXLIMDT  Optional if passed then user can not create an encounter
 ;+             (Visit file entry) before this date.
 ;+  PXALHLOC  Optional if is not passed, 0, or null then only clinics
 ;+             can be entered for hospital locations otherwise
 ;+             any non disposition hospital location can be entered.
 ;+
 ;+ Returns:
 ;+  1   if no errors and process completely
 ;+  0   if user up arrows out may have did part of the processing
 ;+        but at least have a visit
 ;+  -1  if user up arrows out or errors out and did not do anything
 ;+  -2  if could not get a visit
 ;+  -3  if called incorrectly
 ;
 ;---------------NEW CURSOR CONTROL VARIABLE-----------------------
 N IOARM0,IOARM1,IOAWM0,IOAWM1,IOBOFF,IOBON,IOCOMMA,IOCUB,IOCUD,IOCUF
 N IOCUON,IOCUOFF,IOCUU,IODCH,IODHLB,IODHLT,IODL,IODWL,IOECH,IOEDALL
 N IOEDBOP,IOEDEOP,IOEFLD,IOELALL,IOELBOL,IOELEOL,IOENTER,IOFIND
 N IOHDWN,IOHOME,IOHTS,IOHUP,IOICH,IOIL,IOIND,IOINHI,IOINLOW,IOINORM
 N IOINSERT,IOKP0,IOKP1,IOKP2,IOKP3,IOKP4,IOKP5,IOKP6,IOKP7,IOKP8,IOKP9
 N IOIRM0,IOIRM1,IOKPAM,IOKPNM,IOMC,IOMINUS,IONEL,IONEXTSC,IOPERIOD
 N IOPF1,IOPF2,IOPF3,IOPF4,IOPREVSC,IOPROB,IOPTCH10,IOPTCH12,IOPTCH16
 N IORC,IOREMOVE,IORESET,IORI,IORVOFF,IORVON,IOSC,IOSGR0,IOSELECT
 N IOSTBM,IOSWL,IOTBC,IOTBCALL,IOUOFF,IOUON,IOIS
 ;
 ;------------------------*******----------------------------------
 ; Fix IHS Patient files.
 N PX,DA
 S DA=DFN D
 .D CHECK^PXXDPT Q:'$T
 .S PX=$P($G(^DPT(DA,0)),U,9)
 .D EN^PXXDPT
 .K DR,DIE,DA,PXDA,PX
 ;
 D FIX1^PXBCC
 N DIQ,TANA
 N PXBPXXX S PXBPXXX="1^1" ;--PROMPTING CONTROL VARIABLE
 ;
 N PXBSOURC,PXBEXIT,PXBVSTDT,PXELAP,PXBCODT,PXB800,PXBPRBON,DFN
 N PXBEXIT,PAT,ITEM,NF,POP,PXBCNTPL,Q,TEST,UID,PXBPKG
 N VAL,VAR,PXBNCPTF,DXX,DYY
 S PXBEXIT=1
 ;
 I $G(WHAT)']"" W !,"Procedure ""INTV^PXAPI"" was called incorrectly without a ""WHAT"", contact IRM." Q -3
 I $G(PACKAGE)']"" W !,"Procedure ""INTV^PXAPI"" was called incorrectly without a ""PACKAGE"", contact IRM." Q -3
 I $G(SOURCE)']"" W !,"Procedure ""INTV^PXAPI"" was called incorrectly without a ""SOURCE"", contact IRM." Q -3
 ;Get package pointer
 I PACKAGE=+PACKAGE S PXBPKG=PACKAGE
 E  S PXBPKG=$$PKG2IEN^VSIT(PACKAGE)
 I '($D(^DIC(9.4,PXBPKG,0))#2) W !,"Procedure ""INTV^PXAPI"" was called incorrectly without a valid ""PACKAGE"", contact IRM." Q -3
 ;
 ;Lookup source in PCE DATA SOURCE file (#839.7) with LAYGO
 I SOURCE=+SOURCE S PXBSOURC=SOURCE
 E  S PXBSOURC=$$SOURCE^PXAPIUTL(SOURCE)
 ;
 I PXBVST'>0,WHAT'="INTV"&(WHAT'="ADQ")&(WHAT'="ADDEDIT") W !,"Procedure ""INTV^PXAPI"" was called incorrectly without a ""VISIT"", contact IRM." Q -3
 I PXBVST>0 D  Q:PXBEXIT<1 PXBEXIT
 . S PXBVSTDT=$P(^AUPNVSIT(PXBVST,0),"^",1)
 . I PXBPAT'>0 S PXBPAT=$P(^AUPNVSIT(PXBVST,0),"^",5)
 . E  I PXBPAT'=$P(^AUPNVSIT(PXBVST,0),"^",5) W !,"Procedure ""INTV^PXAPI"" was called incorrectly with the Visit for a different Patient, contact IRM." S PXBEXIT=-3 Q
 . I PXBHLOC'>0 S PXBHLOC=$P(^AUPNVSIT(PXBVST,0),"^",22)
 . E  I PXBHLOC'=$P(^AUPNVSIT(PXBVST,0),"^",22) W !,"Procedure ""INTV^PXAPI"" was called incorrectly with the Visit for a different Hospital Locations, contact IRM." S PXBEXIT=-3 Q
 . I PXBAPPT'>0 D
 .. I $D(^DPT(PXBPAT,"S",PXBVSTDT,0))#2,PXBHLOC'>0!(PXBHLOC=+^DPT(PXBPAT,"S",PXBVSTDT,0)) S PXBAPPT=PXBVSTDT S:PXBHLOC'>0 PXBHLOC=+^DPT(PXBPAT,"S",PXBVSTDT,0)
 . E  I '$D(^DPT(PXBPAT,"S",PXBVSTDT,0))#2!(PXBVSTDT'=PXBAPPT) W !,"Procedure ""INTV^PXAPI"" was called incorrectly with the Visit and Appointment of different times, contact IRM." S PXBEXIT=-3 Q
 E  I PXBAPPT>0 D  Q:PXBEXIT<1 PXBEXIT
 . I PXBPAT'>0 W !,"Procedure ""INTV^PXAPI"" was called incorrectly without a ""PATIENT"", contact IRM." S PXBEXIT=-3 Q
 . S PXBVSTDT=PXBAPPT
 . I PXBHLOC'>0,+$G(^DPT(PXBPAT,"S",PXBAPPT,0)) S PXBHLOC=+^DPT(PXBPAT,"S",PXBAPPT,0)
 S DFN=PXBPAT
 S PXBPRBON=$L($T(^GMPLUTL)) ;see if Problem List exists
 ;+ If visit has been passed lock ^PXLCKUSR(VISIEN)
 ;+ and create XTMP("PXLCKUSR",VISIEN)=DUZ
 N PXRESVAL,PXVISIEN
 I PXBVST>0 S PXVISIEN=PXBVST D  I 'PXRESVAL Q -2
 .N PXMSG,PXUSR
 .S PXMSG=""
 .I $D(^XTMP("PXLCKUSR",PXVISIEN)) S PXUSR=$G(^VA(200,^XTMP("PXLCKUSR",PXVISIEN),0)),PXUSR=$S(PXUSR="":"Unknown",1:$P(PXUSR,"^")),PXMSG="Encounter Locked by "_PXUSR
 .S PXRESVAL=$$LOCK^PXUALOCK("^PXLCKUSR("_PXVISIEN_")",5,0,PXMSG,0)
 .I 'PXRESVAL Q
 .S PXRESVAL=$$CREATE^PXUAXTMP("PXLCKUSR",PXVISIEN,365,"PCE Encounter Lock",DUZ) I 'PXRESVAL D UNLOCK^PXUALOCK("^PXLCKUSR("_PXVISIEN_")")
 D PROCESS^PXBAPI1(.PXBEXIT)
 W !,"  - - - - S o r r y   A b o u t   T h e   W a i t - - - -"
 W !,"This information is being stored or monitored by Scheduling"
 W !,"Integrated Billing, Order Entry, Registration, Prosthetics"
 W !,"PCE/Visit Tracking and Automated Med Information Exchange."
 D EVENT^PXKMAIN
 K PXVDR
 I $G(PXVISIEN)>0 D UNLOCK^PXUALOCK("^PXLCKUSR("_PXVISIEN_")"),DELETE^PXUAXTMP("PXLCKUSR",PXVISIEN)
 Q PXBEXIT
 ;
