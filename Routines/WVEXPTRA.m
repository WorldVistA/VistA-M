WVEXPTRA ;HCIOFO/FT-EXPORT MAMS & ULTRASOUNDS TO WOMEN'S HEALTH  ;2/18/00  13:49
 ;;1.0;WOMEN'S HEALTH;**3,5,7,10**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;---> WVNEWP = TOTAL NEW WOMEN'S HEALTH PATIENTS ADDED.
 ;---> WVMAM  = TOTAL NEW MAMMOGRAMS PROCEDURES ADDED.
 ;
EN1 ;
 S WVPOP=0,WVEC=""
 D CHECK I WVPOP D KILL Q  ;check if site parameter entry exists
 D DESC ;describe option
 D DTRNG I WVPOP D KILL Q  ;get date range
 D STATUS I WVPOP D KILL Q  ;select status of procedure
 D EC^WVGETAL1 I WVPOP D KILL Q  ;veterans/non-vets/eligibility code
 D QUEUE ;queue a background job
 D KILL
 Q
EN2 ;
 D CPTS ;get procedure pointers
 D GET ;get RAD/NM data & store in WH
 D MAIL ;send mail message to user
 D KILL ;kill variables
 Q
DESC ; Describe option
 W @IOF
 W !,"This option searches the Radiology/Nuclear Medicine database for"
 W !,"all female patients who had a mammogram, breast ultrasound, pelvic"
 W !,"ultrasound or vaginal ultrasound exam during the date range you select."
 W !,"These procedures and patients will be added to the WH database if"
 W !,"not already there.",!
 W !,"This job will be queued as a background task so as to free up your"
 W !,"terminal to do other work. You will receive a mail message when"
 W !,"the job is done. The mail message will contain a count of the"
 W !,"number of procedures and patients added.",!!
 Q 
CHECK ; Check if DUZ(2) exists for user, if entry exists in site parameter
 ; file, if case manager, and if File 70 exists.
 D CHECK^WVLOGO
 I '$G(DUZ(2))!('$D(^WV(790.02,+DUZ(2),0))) S WVPOP=1
 I '$P($G(^WV(790.02,+$G(DUZ(2)),0)),U,2) D
 .D NODCM^WVUTL9
 .S WVPOP=1
 .Q
 I '$D(^RADPT) W !,"There is no Radiology/Nuclear Medicine Patient file (#70)",! S WVPOP=1
 Q
DTRNG ; prompt for date range, go back three years maximum
 S WVSTDT=DT-30000,WVSTDT=$$DATECHK(WVSTDT)
 K DIR S DIR(0)="DA^"_WVSTDT_":"_DT
 S DIR("A")="Enter START DATE: "
 S DIR("?")="Enter the earliest date of the mammograms/ultrasounds you wish to retrieve. You can begin your search at "_$$FMTE^XLFDT(WVSTDT,"D")_"."
 D ^DIR K DIR
 I $D(DIRUT) S WVPOP=1 Q
 S WVSTDT=Y
 S DIR(0)="DA^"_WVSTDT_":"_DT
 S DIR("A")="Enter END DATE: ",DIR("B")=$$FMTE^XLFDT(DT,"D")
 S DIR("?")="Enter the most recent date of the mammograms/ultrasounds you wish to retrieve."
 D ^DIR K DIR
 I $D(DIRUT) S WVPOP=1 Q
 S WVENDT=Y
 Q
DATECHK(WVDATE) ; Check if WVDATE is a valid date. Substract 1 day until a
 ; valid date in WVDATE and return same.
 N %DT,WVLOOP,X,Y
 S Y=0
 F WVLOOP=1:1 Q:Y>0  D
 .S X=WVDATE,%DT=""
 .D ^%DT
 .Q:Y>0  ;valid date - stop checking
 .S WVDATE=$$FMADD^XLFDT(WVDATE,-1)
 .Q
 Q WVDATE
 ;
STATUS ; Select default status for procedures
 K DIR
 S DIR(0)="S^o:OPEN;c:CLOSED",DIR("A")="Select STATUS OF IMPORTED MAMMOGRAMS"
 S DIR("?")="Enter 'O' to give a Status of OPEN to Mammograms imported from the Radiology Software into the Women's Health database. Enter 'C' to give a Status of CLOSED to imported Mammograms."
 D ^DIR K DIR
 I $D(DIRUT) S WVPOP=1
 S WVSTATUS=Y
 Q
QUEUE ; Task as background job
 S ZTIO="",ZTDESC="WH GRAB RAD/NM DATA",ZTRTN="EN2^WVEXPTRA"
 S ZTDTH=$H,WVPOP=1
 S ZTSAVE("WVENDT")="",ZTSAVE("WVSTDT")="",ZTSAVE("WVSTATUS")=""
 S ZTSAVE("WVEC(")=""
 D ^%ZTLOAD
 Q
CPTS ; Loop through File 71 to get procedure pointers for the CPTs we
 ; are interested in.
 N WVPROC S WVIEN=0 K WVARRAY
 F  S WVIEN=$O(^RAMIS(71,WVIEN)) Q:'WVIEN  D
 .S WVCPT=$$GET1^DIQ(71,WVIEN,9,"I") ;CPT code
 .Q:WVCPT=""
 .S WVPROC=0
 .S WVPROC=$O(^WV(790.2,"AC",WVCPT,WVPROC))
 .Q:'WVPROC
 .Q:$P($G(^WV(790.2,+WVPROC,0)),U,5)'="R"
 .S WVARRAY(WVIEN)=""
 .Q
 Q
GET ; get mammograms and ultrasounds from RAD/NM database
 ;---> WVMCNT = total new procedures added.
 ;---> WVNEWP = total new patients added.
 S (WVMCNT,WVNEWP)=0
 Q:'$D(WVARRAY)  ;no mammogram or ultrasound procedures in File 71
 S WVENDT=WVENDT\1,WVENDT=9999999-WVENDT ;inverse end date
 S WVSTDT=WVSTDT\1,WVSTDT=9999999-WVSTDT ;inverse start date
 S WVSTDT=WVSTDT_".9999"
 S WVDFN=0 ;patient dfn
 F  S WVDFN=$O(^RADPT(WVDFN)) Q:'WVDFN  D  ;RAD/NM patient file
 .Q:$P($G(^DPT(WVDFN,0)),U,2)'="F"  ;not female
 .Q:'$$VECCHK^WVGETAL1(WVDFN)  ;failed vet/non-vet/eligibility code check
 .S WVDTI=WVENDT  ;Because the exam date is inverse the end date will
 .;                will be the lower value.
 .F  S WVDTI=$O(^RADPT(WVDFN,"DT",WVDTI)) Q:'WVDTI!(WVDTI>WVSTDT)  D
 ..S WVCNI=0 ;case number
 ..F  S WVCNI=$O(^RADPT(WVDFN,"DT",WVDTI,"P",WVCNI)) Q:'WVCNI  D
 ...S WVNODE=$G(^RADPT(WVDFN,"DT",WVDTI,"P",WVCNI,0))
 ...Q:WVNODE=""
 ...S WVPROC=$P(WVNODE,U,2) ;procedure pointer
 ...Q:'WVPROC  ;no pointer to File 71 (no procedure) 
 ...Q:'$D(WVARRAY(WVPROC))  ;not a WH-related procedure
 ...S WVRPT=$P(WVNODE,U,17) ;report pointer
 ...Q:'WVRPT  ;no pointer to File 74 (no report)
 ...Q:$$GET1^DIQ(74,WVRPT,5,"I")'="V"  ;report status, must be VERIFIED
 ...D CREATEH^WVRALINK(WVDFN,WVDTI,WVCNI,WVSTATUS)
 ...Q
 ..Q
 .Q
 Q
MAIL ; send mail message to user with counts of procedures & patients added
 S XMDUZ=.5 ;message sender
 S XMY(DUZ)="" ;person who ran option
 S XMSUB="Export of RAD/NM procedures to WH is done"
 S WVMSG(1)="  # of New patients added to Women's Health package: "_WVNEWP
 S WVMSG(2)="# of New procedures added to Women's Health package: "_WVMCNT
 I '$D(WVARRAY) D
 .S WVMSG(3)=" "
 .S WVMSG(4)="There are no mammogram or ultrasound procedures listed in your"
 .S WVMSG(5)="Radiology/Nuclear Medicine package."
 .Q
 S XMTEXT="WVMSG("
 D ^XMD
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
KILL ;
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 K WVARRAY,WVCNI,WVCPT,WVDFN,WVDTI,WVEC,WVENDT,WVIEN,WVMCNT,WVNEWP,WVNODE,WVPOP,WVPROC,WVRPT,WVSTATUS,WVSTDT
 K X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
