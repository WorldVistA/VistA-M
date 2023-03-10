KMPSGE ;OAK/KAK/JML - Master Routine ;9/1/2015
 ;;2.0;SAGG PROJECT;**1**;Jul 02, 2007;Build 67
 ;
EN ;-- this routine can only be run as a TaskMan background job
 ;
 Q:'$D(ZTQUEUED)
 ;
 N CNT,COMPDT,HANG,KMPSVOLS,KMPSZE,LOC,MAXJOB,MGR,NOWDT,OS
 N PROD,PTCHINFO,QUIT,SESSNUM,SITENUM,TEMP,TEXT,UCI,UCIVOL
 N VOL,X,ZUZR,RESULT,XMZSENT
 ;
 ; maximum number of consecutively running jobs
 S MAXJOB=6
 ; hang time for LOOP and WAIT code
 S HANG=300
 ;
 S SESSNUM=+$H,U="^",SITENUM=$P($$SITE^VASITE(),U,3)
 ;
 S NOWDT=$$NOW^XLFDT
 ;
 S OS=$$MPLTF^KMPSUTL1
 I OS="UNK" D  Q
 .S TEXT(1)="   SAGG Project for this M platform is NOT implemented !"
 .D MSG^KMPSLK(NOWDT,SESSNUM,.TEXT)
 ;
 S MGR=^%ZOSF("MGR"),PROD=$P(^%ZOSF("PROD"),",")
 S PROD=$S($P(^KMPS(8970.1,1,0),U,3)="":PROD,1:$P(^(0),U,3))
 S LOC=$P(^KMPS(8970.1,1,0),U,2)
 ;
 L +^XTMP("KMPS")
 S ^XTMP("KMPS",0)=$$FMADD^XLFDT($$DT^XLFDT,14)_U_NOWDT_U_"SAGG data"
 K ^XTMP("KMPS",SITENUM),^XTMP("KMPS","ERROR")
 K ^XTMP("KMPS","START"),^XTMP("KMPS","STOP")
 ;
 ; routine KMPSUTL will always be updated with patch release
 S X="KMPSUTL"
 X "ZL @X S PTCHINFO=$T(+2)"
 S PTCHINFO=$P(PTCHINFO,";",3)_" "_$P(PTCHINFO,";",5)
 ; session number^M platform^SAGG version_" "_patch^start date-time^
 ;     -> completed date-time will be set in $$PACK
 S ^XTMP("KMPS",SITENUM,0)=SESSNUM_U_OS_U_PTCHINFO_U_NOWDT_U
 S X="ERR1^KMPSGE",@^%ZOSF("TRAP")
 S TEMP=SITENUM_U_SESSNUM_U_LOC_U_NOWDT_U_PROD
 ;
 ; KMPS*2.0*1 - Now analyzing all volumes, not just those in the SAGG PROJECT file
 ;
 ; NOTE:  ^XINDEX incorrectly sees SYS("UCI" as an array.  It is a global in the %SYS namespace
 S CNT=0
 S VOL=""
 F  S VOL=$O(^|"%SYS"|SYS("UCI",VOL)) Q:VOL=""  D
 .Q:$G(^|"%SYS"|SYS("UCI",VOL))]""
 .J START^%ZOSVKSE(TEMP_U_VOL)
 .S CNT=CNT+1
 .I CNT=MAXJOB S CNT=$$WAIT(HANG,MAXJOB)
 ;
 D EN^KMPSLK(SESSNUM,SITENUM)
 S QUIT=0
 D LOOP(HANG,SESSNUM,OS)
 I 'QUIT D
 .S RESULT=$$PACK(SESSNUM,SITENUM)
 .S XMZSENT=+RESULT,COMPDT=$P(RESULT,U,2)
 .S X=$$OUT^KMPSLK(NOWDT,OS,SESSNUM,SITENUM,XMZSENT,.TEXT)
 .D MSG^KMPSLK(NOWDT,SESSNUM,.TEXT,COMPDT)
 D END^KMPSLK
 Q
 ;
LOOP(HANG,SESSNUM,OS) ;
 ;---------------------------------------------------------------------
 ; Loop until all volume sets complete
 ;
 ; HANG.....  time to wait to see if all volume sets have completed
 ; OS.......  type of operating system
 ; SESSNUM..  +$Horolog number of session
 ;---------------------------------------------------------------------
 N GBL,UCIVOL1,I
 ;
 F  Q:'$D(^XTMP("KMPS","START"))!+$G(^XTMP("KMPS","STOP"))  H HANG I (+$H>(SESSNUM+3)) D TOOLNG Q
 ;
 Q:QUIT
 ;
 I $D(^XTMP("KMPS","ERROR")) D  Q
 .N J,JEND,OUT,TEXT,VOL
 .S QUIT=1
 .S TEXT(1)=" The SAGG Project has recorded an error on volume set(s):"
 .S OUT=0,VOL="",JEND=$S(OS="CVMS":2,OS="CWINNT":4,1:5)
 .F I=3:1 Q:OUT  D
 ..S TEXT(I)="      "
 ..F J=1:1:JEND S VOL=$O(^XTMP("KMPS","ERROR",VOL)) S:VOL="" OUT=1 Q:VOL=""  S TEXT(I)=TEXT(I)_VOL_"   "
 .S (TEXT(2),TEXT(I))=""
 .S TEXT(I+1)=" See system error log for more details."
 .I OS["C" D
 ..S TEXT(I+2)=""
 ..S TEXT(I+3)=" Also run "_$S(OS="CVMS":"Integrity",1:"INTEGRIT")_" on the listed volume(s)."
 .D MSG^KMPSLK(NOWDT,SESSNUM,.TEXT)
 ;
 I $D(^XTMP("KMPS","STOP")) D  Q
 .N TEXT
 .S QUIT=1
 .S TEXT(1)=" The SAGG Project collection routines have been STOPPED!  No report"
 .S TEXT(2)=" has been generated."
 .D MSG^KMPSLK(NOWDT,SESSNUM,.TEXT)
 ;
 I '$D(^XTMP("KMPS",SITENUM,SESSNUM,NOWDT)) D  Q
 .N TEXT
 .S QUIT=1
 .S TEXT(1)=" The SAGG Project collection routines did NOT obtain ANY global"
 .S TEXT(2)=" information.  Please ensure that the SAGG PROJECT file is"
 .S TEXT(3)=" properly setup.  Then use the 'One-time Option Queue' under"
 .S TEXT(4)=" Task Manager to re-run the 'SAGG Master Background Task'"
 .S TEXT(5)=" [KMPS SAGG REPORT] option."
 .D MSG^KMPSLK(NOWDT,SESSNUM,.TEXT)
 ;
 Q
 ;
PACK(SESSNUM,SITENUM)       ;
 ;---------------------------------------------------------------------
 ; PackMan ^XTMP global to KMP1-SAGG-SERVER at Albany FO
 ;
 ; SESSNUM..  +$Horolog number of session
 ; SITENUM..  site number
 ;
 ; Return:
 ; RETURN...  number of SAGG data message^completed date-time
 ;---------------------------------------------------------------------
 ;
 N COMPDT,N,NM,RETURN,X,XMSUB,XMTEXT,XMY,XMZ
 S U="^",N=$O(^DIC(4,"D",SITENUM,0))
 S NM=$S($D(^DIC(4,N,0)):$P(^(0),U),1:SITENUM)
 ;
 I '$D(XMDUZ) N XMDUZ S XMDUZ=.5 S:'$D(DUZ) DUZ=.5
 ; PROTECTED VARIABLE -- REMOVING KILL: KMPS*2.0*1
 ; K:$G(IO)="" IO
 ;
 ; set completed date-time
 S COMPDT=$$NOW^XLFDT
 S $P(^XTMP("KMPS",SITENUM,0),U,5)=COMPDT
 ;
 S XMSUB=NM_" (Session #"_SESSNUM_") XTMP(""KMPS"") Global"
 ;
 I SITENUM=+SITENUM S XMTEXT="^XTMP(""KMPS"","_SITENUM_","
 E  S XMTEXT="^XTMP(""KMPS"","""_SITENUM_""","
 S XMY("S.KMP1-SAGG-SERVER@FO-ALBANY.DOMAIN.EXT")=""
 D ENT^XMPG
 ;
 S RETURN=XMZ_U_COMPDT
 ;
 Q RETURN
 ;
WAIT(HANG,MAXJOB)    ;
 ;---------------------------------------------------------------------
 ; Wait here until less than MAXJOB volume sets are running
 ;
 ; HANG....  amount of time to wait
 ; MAXJOB..  maximum number of jobs allowed to run
 ;
 ; Return:
 ; RUN.....  number of currently running jobs
 ;---------------------------------------------------------------------
 ;
 N RUN
 ;
 F  H HANG S RUN=$$RUN Q:(RUN<MAXJOB)!+$G(^XTMP("KMPS","STOP"))
 ;
 Q RUN
 ;
RUN() ;-- number of currently running jobs
 N RUN,VOL
 ;
 S RUN=0,VOL=""
 F  S VOL=$O(^XTMP("KMPS","START",VOL)) Q:VOL=""  S RUN=RUN+1
 ;
 Q RUN
 ;
TOOLNG ;-- job has been running too long
 ;
 N TEXT
 ;
 S QUIT=1
 S TEXT(1)=" The SAGG Project collection routines have been running for more"
 S TEXT(2)=" than 3 days.  No report has been generated."
 D MSG^KMPSLK(NOWDT,SESSNUM,.TEXT)
 Q
 ;
ERR1 ;
 S KMPSZE=$ZE,ZUZR=$ZR,X="",@^%ZOSF("TRAP")
 D @^%ZOSF("ERRTN")
 K TEXT
 S TEXT(1)=" SAGG Project Error: "_KMPSZE
 S TEXT(2)=" See system error log for more details."
 S ^XTMP("KMPS","STOP")=""
 D MSG^KMPSLK(NOWDT,SESSNUM,.TEXT)
 G ^XUSCLEAN
