GMVZEROS ;HIOFO/FT - LOOK FOR TRAILING ZEROES IN FILE 120.5, FIELD .01 ;08/27/08 16:07
 ;;5.0;GEN. MED. REC. - VITALS;**25**;Oct 31, 2002;Build 4
 ;
 ; This routine uses the following IAs:
 ; #2320  - ^%ZISH calls             (supported)
 ; #10063 - ^%ZTLOAD                 (supported)
 ; #10070 - ^XMD calls               (supported)
 ; #10103 - ^XLFDT calls             (supported)
 ;
QUEUE ;Queue job as a background task
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 D EN^DDIOL("Starting FIX^GMVZEROS as a background task.","","!?5")
 S ZTDESC="GMRV*5.0*25 D/T REPAIR UTILITY",ZTIO=""
 S ZTRTN="FIX^GMVZEROS",ZTDTH=$$NOW^XLFDT()
 D ^%ZTLOAD
 D EN^DDIOL("Task "_ZTSK_" has started. I'll send you a MailMan message when I finish.","","!?5")
 Q
 ;
FIX ;Search for string dates and repair them.
 I $D(ZTQUEUED) S ZTREQ="@"
 N DA,DIE,DR,X,Y,ZTSTOP
 N GMVBAD,GMVCNT,GMVDATE,GMVEND,GMVIEN,GMVFILE,GMVFOUND,GMVLINE,GMVPATH,GMVSTART,GMVTEXT,GMVTOTAL
 N POP
 S DIE=120.5,GMVLINE=1
 S GMVTEXT(GMVLINE)="Starting search for string dates in FILE 120.5 at "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S (GMVBAD,GMVCNT,GMVIEN,GMVFOUND,GMVTOTAL)=0
 ; set host file name and directory path
 S GMVFILE="GMRV_5_25.DAT"
 S GMVPATH=$$PWD^%ZISH ;current directory
 ; Open up device to print to
 D OPEN^%ZISH("VITAL",GMVPATH,GMVFILE,"A") ;'A' for append
 I POP D  Q  ;send email if device cannot be opened
 .S GMVLINE=GMVLINE+1
 .S GMVTEXT(GMVLINE)="Could not open file "_GMVFILE_" in path "_GMVPATH_"."
 .S GMVLINE=GMVLINE+1
 .S GMVTEXT(GMVLINE)="Stopping at "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 .D EMAIL(.GMVTEXT)
 .Q
 U IO
 ; from this point on, the Write commands are writing to the host file.
 F  S GMVIEN=+$O(^GMR(120.5,GMVIEN)) Q:GMVIEN=0!($G(ZTSTOP)=1)  D
 .S GMVTOTAL=GMVTOTAL+1
 .S GMVCNT=GMVCNT+1
 .I GMVCNT>10000 D  ;check if user wants to stop the job
 ..S GMVCNT=0
 ..Q:'$D(ZTQUEUED)  ;not a background task
 ..I $$S^%ZTLOAD D
 ...S ZTSTOP=1 ;set TaskMan variable equal to 1 to stop task
 ...W !,"Task stopped at "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 ...W !,"Stopped at record "_GMVIEN
 ...K ZTREQ ;keep record of task in task log
 .S GMVDATE=$P(^GMR(120.5,GMVIEN,0),U,1)
 .I GMVDATE'=+GMVDATE D
 ..I $$DTCHECK(+GMVDATE,"TX")=0 D  Q  ;not a real date/time
 ...W !,"IEN="_GMVIEN,?15,GMVDATE_" is not a real date/time. No action taken."
 ...S GMVBAD=GMVBAD+1
 ..S GMVFOUND=GMVFOUND+1
 ..W !,"IEN="_GMVIEN,?15,GMVDATE_" changed to "_+GMVDATE
 ..S DR=".01///"_+GMVDATE,DA=GMVIEN
 ..D ^DIE
 W !!,"# of Records changed: "_GMVFOUND
 D CLOSE^%ZISH("VITAL")
 S GMVLINE=GMVLINE+1
 S GMVTEXT(GMVLINE)="Finished at "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S GMVLINE=GMVLINE+1
 S GMVTEXT(GMVLINE)="Records checked: "_GMVTOTAL
 S GMVLINE=GMVLINE+1
 S GMVTEXT(GMVLINE)="Records changed: "_GMVFOUND
 S GMVLINE=GMVLINE+1
 S GMVTEXT(GMVLINE)="Records that could not be changed: "_GMVBAD
 S GMVLINE=GMVLINE+1
 S GMVTEXT(GMVLINE)="The "_GMVFILE_" file in the "_GMVPATH_" directory contains"
 S GMVLINE=GMVLINE+1
 S GMVTEXT(GMVLINE)="a list of entries changed and those that could not be changed."
 D EMAIL(.GMVTEXT)
 Q
 ;
DTCHECK(GMVDT,GMVPDT) ; Is GMVDT a real date/time?
 ;  Input:   GMVDT - date/time (FM internal format)(req)
 ;          GMVPDT - %DT value (opt - default is 'TX')
 ; Output:  1 = Yes
 ;          0 = No
 N %DT,X,Y
 S GMVDT=$G(GMVDT),GMVPDT=$G(GMVPDT)
 I $G(GMVDT)="" Q 0
 I $G(GMVPDT)="" S GMVPDT="TX"
 S X=GMVDT
 S %DT=GMVPDT
 D ^%DT
 I Y=-1 Q 0
 Q 1
 ;
EMAIL(GMVTXT) ; Send a MailMan message
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="GMRV*5.0*25 D/T REPAIR UTILITY"
 S XMY(DUZ)="",XMDUZ=.5
 S XMTEXT="GMVTXT("
 D ^XMD
 Q
