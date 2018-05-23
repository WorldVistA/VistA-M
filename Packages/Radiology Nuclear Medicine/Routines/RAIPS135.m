RAIPS135 ;HISC/GJC post-install routine ;28 Mar 2018 1:59 PM
 ;;5.0;Radiology/Nuclear Medicine;**135**;Mar 16, 1998;Build 7
 ;
 ;Routine              IA          Type
 ;-------------------------------------
 ; ^%ZTLOAD            10063        (S)
 ; $$FIND1^DIC          2051        (S)
 ; $$FMADD^XLFDT       10103        (S)
 ; $$NOW^XLFDT         10103        (S)
 ; $$FMTE^XLFDT        10103        (S)          
 ; $$NEWCP^XPDUTL      10141        (S)
 ; $$PROD^XUPROD        4440        (S)
 ; UPDATE^DIE           2053        (S)
 ; D EN^DIEZ           10002        (S) 
 ; $$ROUSIZE^DILF       2649        (S)
 ; OPTSTAT^XUTMOPT()    1472        (S)
 ; ^DIE("AF",           2022        (C)
 ; ^DIC(19.2, schedule  6826        (P)
 ;            option
 ; OPTSTAT^XUTMOPT      1472        (S)
 ;
 N RACHX1,RACHX2
 S RACHX1=$$NEWCP^XPDUTL("POST1","EN1^RAIPS135")
 S RACHX2=$$NEWCP^XPDUTL("POST2","EN2^RAIPS135")
 S RACHX3=$$NEWCP^XPDUTL("POST3","EN3^RAIPS135")
 Q
 ;
EN1 ;part 1: recompile 75.1 input templates
 ;
ENDIEZ ;run in the foreground as part of the post-install
 ; ^DD(75.1,21,0)="DATE DESIRED (Not guaranteed) 
 ; ^DIE("AF",file,field,template_IEN)=""
 N DMAX,RADMAX,RAY,X,Y S RAY=0,RADMAX=$$ROUSIZE^DILF()
 F  S RAY=$O(^DIE("AF",75.1,21,RAY)) Q:RAY=""  D  ;Y = IEN of compiled template
 .S DMAX=RADMAX
 .S X=$P(^DIE(RAY,"ROU"),U,2) ;X = compiled template routine name
 .S Y=RAY D:X'="" EN^DIEZ
 .Q
 ;
 ; part 2: re-index of the "BDD" 'DATE DESIRED (not guaranteed)' (tasked)
 ;
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN S ZTIO=""
 S ZTRTN="EN2^RAUTODC",(ZTDESC,RATXT(1))="RA135: re-index of the 'DATE DESIRED (Not guaranteed)' ""BDD"" xref"
 ;
 S ZTDTH=$H D ^%ZTLOAD S RATXT(2)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 Q
 ;
EN2 ;Schedule option RA AUTO DISCONTINUE PROCESS to discontinue pending, hold & scheduled
 ; (check Scheduled D/T) from the beginning of time through May 31st 2015@2359.
 ; This option will be run once and be deleted from the OPTION SCHEDULING file.
 ; A future RIS patch will delete the RA AUTO DISCONTINUE PROCESS option.
 ;
 ; Note: do not fire bulletins, do not fire notifications (toggle on/off)
 ;
 ; if "OBSOLETE ORDER-P135 (automated)" has not been added quit...
 N RATXT I $$FIND1^DIC(75.2,"","X","OBSOLETE ORDER-P135 (automated)","B")=0 D  QUIT
 .S RATXT(1)="Error: 'OBSOLETE ORDER-P135 (automated)' could not be found."
 .S RATXT(2)="Contact the developers of RA*5.0*135 to address this issue."
 .D BMES^XPDUTL(.RATXT)
 .Q
 ;
 N DIFROM,RADEV,RAERR,RAFDA,RAFREQ,RAIEN,RAOPT,RAR,RAUSER,RAWHEN,X,Y
 S RAOPT="RA AUTO DISCONTINUE PROCESS" ;xported w/135
 ;jobs in production are tasked off for tomorrow @21:00; jobs in mirror run today in an hour 
 S RAWHEN=$S($$PROD^XUPROD()=1:$$FMADD^XLFDT(DT,1)_".21",1:$$FMADD^XLFDT($E($$NOW^XLFDT(),1,12),0,1,0,0))
 S RAUSER="POSTMASTER"
 S RAWHEN=$$FMTE^XLFDT(RAWHEN) ;use external
 S RAR=$NA(RAFDA(19.2,"?+1,")) ;RAFDA root
 ;.01 - option to be scheduled
 S @RAR@(.01)=RAOPT
 ;field #: 2 - QUEUED TO RUN AT WHAT TIME
 S:$D(RAWHEN) @RAR@(2)=RAWHEN
 ;field #: 3 - DEVICE FOR QUEUED JOB OUTPUT
 S:$D(RADEV) @RAR@(3)=RADEV
 ;field #: 6 - RESCHEDULING FREQUENCY
 S:$D(RAFREQ) @RAR@(6)=RAFREQ
 ;field #: 11 - USER TO RUN TASK
 S:$D(RAUSER) @RAR@(11)=RAUSER
 D UPDATE^DIE("E","RAFDA","RAIEN","RAERR")
 I $D(RAERR) D
 .S RATXT(1)="Error: """_RAOPT_""" could not be scheduled."
 .S RATXT(2)="Contact the developers of RA*5.0*135 to address this issue."
 .D BMES^XPDUTL(.RATXT)
 .Q
 I $G(RAIEN(1))>0 D
 .K RA192,RATXT S RATXT(1)=""
 .D OPTSTAT^XUTMOPT(RAOPT,.RA192)
 .S RATXT(2)=RAOPT_" Task: "_$P($G(RA192(1)),U) ;task # ^ D/T scheduled
 .D BMES^XPDUTL(.RATXT) K RA192,RATXT
 .Q
 Q
 ;
EN3 ;re-index the "AS" cross reference missed in RA*5.0*130
 ;
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN S ZTIO="",RATXT(1)=""
 S ZTRTN="EN3^RAUTODC",(ZTDESC,RATXT(2))="RA135: re-index of the 'REQUEST STATUS' ""AS"" xref."
 ;
 S ZTDTH=$H D ^%ZTLOAD S RATXT(3)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 Q
 ;
