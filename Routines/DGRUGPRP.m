DGRUGPRP ;ALB/GRR/SCK - RAI/MDS DATA COLECTION
 ;;5.3;Registration;**236**;Aug 13, 1993
EN ; Main entry point
 N DGDIV,DGSTN,DGSTNUM,DGFILE,DIR,DGPATH,DGDNAM
 ;
 ;; ** SCK/Modifications for tasking.
 S DIR(0)="FAO",DIR("B")=$$PWD^%ZISH
 S DIR("A",1)=""
 S DIR("A",2)="Please make a note of the displayed directory path for reference."
 S DIR("A",3)=""
 S DIR("A")="Enter the directory path for the file: "
 S DIR("?",1)="Enter the directory path to write the ASCII data file to."
 S DIR("?",2)="The default directory path currently in effect is displayed."
 S DIR("?",3)="You may change the directory path if wish.  If you are"
 S DIR("?",4)="not sure of how to enter the proper directory path for your"
 S DIR("?",5)="system, press return to accept the default and make a note"
 S DIR("?")="of the displayed directory path for reference."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGPATH=Y
 ;
 I '$D(^DG(40.8,"B")) D  Q
 . S DGDIV=$$PRIM^VASITE ;get primary division
 . S DGSTN=$$SITE^VASITE($$NOW^XLFDT,DGDIV) ;get station info
 . S DGSTNUM=$P(DGSTN,"^",3) ;get station number
 . S DGFILE="VA"_DGSTNUM_".TXT" ;set file name
 . D TASK(DGFILE,DGPATH,DGDIV)
 ;
 I $D(^DG(40.8,"B")) D  Q  ;If multiple divisions
 . W !!?3,"Building Tasks"
 . S DGDIV=0,DGDNAM=""
 . F  S DGDNAM=$O(^DG(40.8,"B",DGDNAM)) Q:DGDNAM=""  S DGDIV=$O(^DG(40.8,"B",DGDNAM,0)) D
 . . S DGSTN=$$SITE^VASITE($$NOW^XLFDT,DGDIV) Q:DGSTN=-1  ;get station number
 . . S DGSTNUM=$P(DGSTN,"^",3) ;get station number
 . . S DGFILE="VA"_DGSTNUM_".TXT" ;set file name
 . . D TASK(DGFILE,DGPATH,DGDIV)
 Q
 ;
TASK(DGFILE,DGPATH,DGDIV) ; Task off job 
 N ZTSAVE,ZTRTN,ZTDESC,ZTSK,ZTIO,ZX
 ;
 S DGPATH=$G(DGPATH)
 S:'(DGPATH]"") DGPATH=$$PWD^%ZISH
 S ZX=""
 F ZX="DGFILE","DGPATH","DGDIV" S ZTSAVE(ZX)=""
 S ZTRTN="EN1^DGRUGPRP"
 S ZTDESC="RAI/MDS Patient Demographic Data Collection"
 S ZTIO=""
 W !!?5,"Tasking ",DGFILE,"..."
 D ^%ZTLOAD
 I $D(ZTSK)[0 W "  Task was not queued!",!
 E  W !?10,"Task queued: ",ZTSK,!
 Q
 ;
EN1 ; Build HFS file
 N DGNAME,DGWARD,DGIEN,DGWIEN,DGWDIV,DGREC,DGNAME,DOB,SSN,DGRB,DGMS,SEX,DGRACE,DGSTAB,DGADAT,DGATIME,DGHLNM,DGWREC,VADM,VAIP,VAPA,VAERR,POP,DFN,DGEN,DGENP,DGRFA
 ;
 Q:$$S^%ZTLOAD  ; Quit if the tasked job has been asked to stop
 S DGPATH=$G(DGPATH)
 S:'(DGPATH]"") DGPATH=$$PWD^%ZISH
 D OPEN^%ZISH("FILE1",DGPATH,DGFILE,"W") ; Open HFS file device handler
 Q:POP  ; Quit if the device handler did not open properly
 U IO
 S DGWARD="" F  S DGWARD=$O(^DGPM("CN",DGWARD)) Q:DGWARD=""  S DGIEN=0 F  S DGIEN=$O(^DGPM("CN",DGWARD,DGIEN)) Q:DGIEN'>0  D  ;loop thru movement file
 .S DFN=$$GET1^DIQ(405,DGIEN,.03,"I") Q:DFN=""  ;get patient ien
 .S DGRFA=$$GET1^DIQ(405,DGIEN,.11,"I")
 .S DGRFA=$S(DGRFA=0:"NSC",DGRFA=1:"SC",1:"")
 .S DGEN=$O(^DGEN(27.11,"C",DFN,""),-1),DGENP=""
 .I DGEN]"" S DGENP=$$GET1^DIQ(27.11,DGEN,.07,"I")
 .D DEM^VADPT,IN5^VADPT,ADD^VADPT ;get patient demographics, inpatient data, and address data
 .S DGWIEN=$P(VAIP(5),"^") Q:DGWIEN=""  S DGWDIV=$$GET1^DIQ(42,DGWIEN,.015,"I") ;get ward ien and ward division
 .Q:$$GET1^DIQ(42,DGWIEN,.035,"I")'=1  ;quit if not rai/mds ward
 .I DGDIV=DGWDIV D  ;if ward division equal to division being processed continue
 ..S DGNAME=VADM(1),DOB=$P(VADM(3),"^"),SSN=$P(VADM(2),"^"),DGRB=$P(VAIP(6),"^",2),DGMS=$P(VADM(10),"^"),SEX=$P(VADM(5),"^"),DGRACE=$P(VADM(8),"^"),DGSTAB=$S(VAPA(5)]"":$P(^DIC(5,$P(VAPA(5),"^"),0),"^",2),1:"")
 ..S DGREC=$P(VAIP(13,1),"^") ;get admit date/time
 ..S DGADAT=$P($P(DGREC,"^"),".") ;grab date
 ..S DGATIME=$P($P(DGREC,"^"),".",2) ;grab time
 ..S DGHLNM=$$HLNAME^HLFNC(DGNAME,"^~|\") I $P(DGHLNM,"^",4)="" S $P(DGHLNM,"^",4)="" ;parse name
 ..S DGWREC=DGHLNM_"^"_$E(DOB,4,5)_"/"_$E(DOB,6,7)_"/"_(1700+$E(DOB,1,3))_"^"_SSN_"^"_SEX_"^"_DGMS_"^"_DGRACE_"^"_$E(DGADAT,4,5)_"/"_$E(DGADAT,6,7)_"/"_(1700+$E(DGADAT,1,3))_"@"_DGATIME_"^"_DGWARD_"/"_DGRB
 ..S DGWREC=DGWREC_"^"_VAPA(1)_"^"_VAPA(2)_"^"_VAPA(4)_"^"_DGSTAB_"^"_VAPA(6)_"^"_DGENP_"^"_DGRFA
 .. W DGWREC,!
 D CLOSE^%ZISH("FILE1") ; close the HFS file handler
 Q
 ;
WARD ;Print Ward/Room/Bed for RAI/MDS wards
 D EN^XUTMDEVQ("RPT^DGRUGPRP","Print Ward/Room/Bed Report","") ;call device api
 D HOME^%ZIS
 Q
RPT N DGCNT,DGWARD,DGWNAME,DGRB,DGADT,DGRBNM,DGADATE,DGATIME,DGCDT,DGTCNT,DGWCNT
 S (DGTCNT,DGWCNT)=0
 D NOW^%DTC S Y=% D DD^%DT S DGCDT=Y ;get current date/time
 S DGCNT=0
 S DGWARD=0 F  S DGWARD=$O(^DG(405.4,"W",DGWARD)) Q:DGWARD'>0  I $$GET1^DIQ(42,DGWARD,.035,"I")=1 D  ;loop through room-bed file, check if ward is rai/mds
 .S DGWNAME=$$GET1^DIQ(42,DGWARD,".01","I"),DGWCNT=0 ;get ward name
 .D HED ;do header
 .S DGRB=0 F  S DGRB=$O(^DG(405.4,"W",DGWARD,DGRB)) Q:DGRB'>0  D  ;loop thru room-bed for this ward
 ..S DGRBNM=$$GET1^DIQ(405.4,DGRB,".01","I") ;get room-bed name
 ..S DGWCNT=DGWCNT+1 ;add one to ward count
 ..I $Y+4>$G(IOSL) D HED ;if near end of screen, do header
 ..W !,?5,DGRBNM ;write room-bed name
 .W !!,"Total beds for ward ",DGWNAME,": ",DGWCNT S DGTCNT=DGTCNT+DGWCNT ;write ward total and add to grand total
 W !!,"Total Beds for all wards: ",DGTCNT ;write grand total
 Q
HED ;FORM FEED AND PRINT HEADER
 I DGCNT>0 W @IOF
 S DGCNT=1
 W !,"RAI/MDS Ward/Room/Beds"
 W ?40,DGCDT
 W !,"WARD: ",DGWNAME,!
 Q
