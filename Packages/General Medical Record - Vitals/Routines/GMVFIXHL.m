GMVFIXHL ;HIOFO/FT - HOSPITAL LOCATION FIX ;10/20/09  11:42
 ;;5.0;GEN. MED. REC. - VITALS;**24**;Oct 31, 2002;Build 24
 ;
 ; This routine uses the following IAs:
 ; #2320  - ^%ZISH calls             (supported)
 ; #4253  - ^VDEFQM calls            (controlled)
 ; #10039 - FILE 42 references       (supported)
 ; #10040 - FILE 44 references       (supported)
 ; #10061 - ^VADPT calls             (supported)
 ; #10063 - ^%ZTLOAD                 (supported)
 ; #10070 - ^XMD calls               (supported)
 ; #10103 - ^XLFDT calls             (supported)
 ; #10141 - ^XPDUTL calls            (supported)
 ;
EN ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZTSTOP
 S ZTDESC="GMRV*5.0*24 HOSPITAL LOCATION FIX",ZTIO=""
 S ZTSAVE("DUZ")=""
 S ZTRTN="QUEUE^GMVFIXHL",ZTDTH=$$NOW^XLFDT()
 D ^%ZTLOAD
 D EN^DDIOL("Task "_ZTSK_" has started. I'll send you a MailMan message when I finish.","","!?5")
 Q
QUEUE ; The problem started when GMRV*5.0*3 was installed.
 ; a) Find date patch 3 was installed. Go back a little farther to be safe.
 ; b) Loop through FILE 120.5.
 ; c) Ignore if not inpatient.
 ; d) Check hospital location pointer of the Vitals record.
 ; e)Determine if pointer can/needs to be changed.
 N GMVBEG,GMVCNT,GMVDFN,GMVECNT,GMVEDT,GMVEND,GMVFILE,GMVHL,GMVIEN,GMVMSG,GMVNODE,GMVODT,GMVPATH,GMVPIEN,GMVSDT,GMVTOT,GMVTOTAL
 N POP
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J,"GMVHL")
 S GMVBEG=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 ;Get patch 3 installation date
 D INSTALDT^XPDUTL("GMRV*5.0*3",.GMVDATES)
 I $G(GMVDATES(0))=0 D  Q
 .K GMVTEXT
 .S GMVTEXT(1)="I cannot find an installation date for GMRV*5.0*3."
 .S GMVTEXT(2)="Please file a Remedy ticket."
 .D EMAIL(.GMVTEXT)
 .Q
 S GMVSDT=0
 S GMVSDT=$O(GMVDATES(GMVSDT)) ;get the earliest install date
 I 'GMVSDT D  Q
 .K GMVTEXT
 .S GMVTEXT(1)="I cannot find a valid installation date for GMRV*5.0*3."
 .S GMVTEXT(2)="Please file a Remedy ticket."
 .D EMAIL(.GMVTEXT)
 .Q
 ;problem fixed with patch 22 installation
 K GMVDATES
 D INSTALDT^XPDUTL("GMRV*5.0*22",.GMVDATES)
 I $G(GMVDATES(0))=0 D  Q
 .K GMVTEXT
 .S GMVTEXT(1)="I cannot find an installation date for GMRV*5.0*22."
 .S GMVTEXT(2)="Please file a Remedy ticket."
 .D EMAIL(.GMVTEXT)
 .Q
 S GMVEDT=0
 S GMVEDT=$O(GMVDATES(GMVEDT)) ;get the earliest install date
 I 'GMVEDT D  Q
 .K GMVTEXT
 .S GMVTEXT(1)="I cannot find a valid installation date for GMRV*5.0*22."
 .S GMVTEXT(2)="Please file a Remedy ticket."
 .D EMAIL(.GMVTEXT)
 .Q
 ; set host file name and directory path
 S GMVFILE="GMRV_5_24.DAT"
 S GMVPATH=$$PWD^%ZISH ;current directory
 ; Open up device to print to
 D OPEN^%ZISH("VITAL",GMVPATH,GMVFILE,"A") ;'A' for append
 I POP D  Q  ;send email if device cannot be opened
 .K GMVTEXT
 .S GMVTEXT(1)="Could not open file "_GMVFILE_" in path "_GMVPATH_"."
 .S GMVTEXT(2)="Please try again."
 .D EMAIL(.GMVTEXT)
 .Q
 U IO
 ; from this point on, the Write commands are to the host file.
 S GMVSDT=$$FMADD^XLFDT(GMVSDT,-7) ;go back additional 7 days to be certain
 S (GMVCNT,GMVECNT,GMVPIEN,GMVTOT,GMVTOTAL)=0
 F  S GMVSDT=$O(^GMR(120.5,"B",GMVSDT)) Q:'GMVSDT!($G(ZTSTOP)=1)!(GMVSDT>GMVEDT)  D
 .S GMVIEN=0
 .K GMVLOC
 .F  S GMVIEN=$O(^GMR(120.5,"B",GMVSDT,GMVIEN)) Q:'GMVIEN!($G(ZTSTOP)=1)  D
 ..S GMVTOTAL=GMVTOTAL+1
 ..S GMVCNT=GMVCNT+1
 ..I GMVCNT>10000 D  ;check if user wants to stop the job
 ...S GMVCNT=0
 ...Q:'$D(ZTQUEUED)  ;not a background task
 ...I $$S^%ZTLOAD D
 ....S ZTSTOP=1 ;set TaskMan variable equal to 1 to stop task
 ....W !,"Task stopped. Last record processed was "_GMVPIEN
 ....K ZTREQ ;keep record of task in task log
 ..S GMVNODE=$G(^GMR(120.5,GMVIEN,0)),GMVPIEN=GMVIEN
 ..I ($P(GMVNODE,U,1)="")!($P(GMVNODE,U,2)="")!($P(GMVNODE,U,3)="")!($P(GMVNODE,U,8)="") Q
 ..S GMVHL=+$P(GMVNODE,U,5),GMVDFN=+$P(GMVNODE,U,2),GMVODT=+$P(GMVNODE,U,1)
 ..;get inpatient location for this dfn & d/t
 ..I '$D(GMVLOC(GMVDFN,GMVODT)) D INP
 ..I $G(GMVLOC(GMVDFN,GMVODT))'>0 Q  ;not an inpatient
 ..I $G(GMVLOC(GMVDFN,GMVODT))=GMVHL Q  ;no discrepancy
 ..Q:$D(^SC(+GMVHL,0))  ;quit if FILE 44 entry exists
 ..I $G(GMVLOC(GMVDFN,GMVODT))'=GMVHL D
 ...S GMVMSG=$$SETHL(GMVLOC(GMVDFN,GMVODT),GMVIEN,GMVHL)
 ...W !,GMVMSG
 ...D HDR(GMVIEN,GMVDFN) ;upload record to HDR
 S GMVEND=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 W !,"                            Start Date/time: "_GMVBEG
 W !,"                           Finish Date/time: "_GMVEND
 W !,"                  Number of records checked: "_GMVTOTAL
 W !,"                  Number of records changed: "_GMVTOT
 W !,"Number of records that could not be changed: "_GMVECNT
 D CLOSE^%ZISH("VITAL")
 K GMVTEXT
 S GMVTEXT(1)="              The repair utility started at: "_GMVBEG
 S GMVTEXT(2)="             The repair utility finished at: "_GMVEND
 S GMVTEXT(3)="                  Number of records checked: "_GMVTOTAL
 S GMVTEXT(4)="                  Number of records changed: "_GMVTOT
 S GMVTEXT(5)="Number of records that could not be changed: "_GMVECNT
 S GMVTEXT(6)=" "
 S GMVTEXT(7)="The "_GMVFILE_" file in the "_GMVPATH_" directory contains"
 S GMVTEXT(8)="a listing of entries changed."
 D EMAIL(.GMVTEXT)
 Q
SETHL(NEWHL,IEN,OLDHL) ; Set hospital location pointer (.05) field in 120.5. 
 ; Returns a line of text
 ; NEWHL = New File 44 pointer
 ;   IEN = File 120.5 record ien
 ; OLDHL = Old File 44 pointer
 N GMVERR,GMVFDA,GMVDA,GMVLINE
 S GMVLINE=""
 S GMVFDA(120.5,IEN_",",.05)=NEWHL
 D UPDATE^DIE("","GMVFDA","GMVDA","GMVERR")
 I +$P($G(GMVERR("DIERR")),U,1)>0 D
 .S GMVLINE="RECORD: "_IEN_", not changed because: "_$G(GMVERR("DIERR",1,"TEXT",1))
 .S GMVECNT=GMVECNT+1
 I +$P($G(GMVERR("DIERR")),U,1)'>0 D
 .S GMVLINE="RECORD: "_IEN_"  OLD LOCATION: "_OLDHL_"  NEW LOCATION: "_NEWHL
 .S GMVTOT=GMVTOT+1
 Q GMVLINE
 ;
INP ;get inpatient location
 N DFN,GMVAIN,GMVHLPTR,GMVWPTR,VAINDT,VAROOT
 S DFN=GMVDFN,VAINDT=GMVODT,VAROOT="GMVAIN",GMVLOC(GMVDFN,GMVODT)=""
 D INP^VADPT
 S GMVWPTR=+$P(GMVAIN(4),U,1)
 D KVAR^VADPT
 Q:'GMVWPTR
 S GMVHLPTR=+$P($G(^DIC(42,GMVWPTR,44)),U,1)
 Q:'GMVHLPTR
 S GMVLOC(GMVDFN,GMVODT)=GMVHLPTR
 Q
EMAIL(GMVTXT) ; Send a MailMan message
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="GMRV*5.0*24 HOSPITAL LOCATION REPAIR"
 S XMY(DUZ)="",XMDUZ=.5
 S XMTEXT="GMVTXT("
 D ^XMD
 Q
HDR(GMVX,GMVY) ; Send record to Health Data Repository (HDR)
 ;  Input: GMVX - FILE 120.5 IEN
 ;         GMVY - DFN
 ; Output: none
 N ERR,GMVFLAG
 S GMVX=+$G(GMVX),GMVY=+$G(GMVY)
 Q:'GMVX
 Q:'GMVY
 Q:$$TESTPAT^VADPT(GMVY)  ;ignore test patients
 I $T(QUEUE^VDEFQM)]"" D
 .S GMVFLAG=$$QUEUE^VDEFQM("ORU^R01","SUBTYPE=VTLS^IEN="_GMVX,.ERR)
 Q
