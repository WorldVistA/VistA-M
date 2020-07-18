RAIPS165 ;WOIFO/KLM-PostInit 165; Jun 02, 2020@07:30:06
 ;;5.0;Radiology/Nuclear Medicine;**165**;Mar 16, 1998;Build 3
 ;
 ; Routine/File      IA        Type
 ;---------------------------------
 ; ^ORD(101.43
 ;  #2              2835       (P)
 ;  #.01,.1,3       7130       (P)
 ;  #71.1-71.4      7130       (P)
 ;
 N RACHX1,RACHX2
 S RACHX1=$$NEWCP^XPDUTL("POST1","EN1^RAIPS165")
 S RACHX2=$$NEWCP^XPDUTL("POST2","EN2^RAIPS165")
 Q
EN1 ;sync radiology procedures with their orderable items (101.43)
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,RAMRCP S ZTIO=""
 ;Installation Questions from KIDS
 I +$G(XPDQUES("POS1"))>0 S ZTSAVE("RAMRCP")=+XPDQUES("POS1") ;ADPAC/AO
 ;
 I '$D(ZTSAVE) S ZTSAVE("RAMRCP")=.5 ;If no real person identified, use Postmaster
 ;
 S ZTRTN="TASK1^RAIPS165",(ZTDESC,RATXT(1))="RA165: Find and resync mismatched Orderable Items"
 S ZTDTH=$H D ^%ZTLOAD S RATXT(2)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 Q
EN2 ;Re-Index of "D" cross reference in file #71, field #9 - CPT CODE
 ;
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN S ZTIO=""
 S ZTRTN="RIX^RAIPS165",(ZTDESC,RATXT(1))="RA165: re-index of CPT CODE ""D"" cross reference"
 S ZTDTH=$H D ^%ZTLOAD S RATXT(2)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 Q
 ;
TASK1 ;Task1 entry point
 N RAOII,RAOIE,RAOI0,RAPROC,RAOISET,RAOINAM,RAOIAC,RAOICPT,RAOICM,RAOIPT,RAOIIT,RAOICOM,RAFILE
 N RAORD,RAOIFLDS,RAOIENS,RACM,RACMI,RAPN,RAI,RATEXT,RAPT,RAPIAC,RAIT,RAVIT,RAY
 N RAC1,RAC2,RACT S (RAC1,RAC2,RACT)=0 ;RACT=total count, RAC1=synced count, RAC2=not synced count
 K ^TMP("RASYNC") S RAI=12
 ;order thru "S.XRAY" xref in 101.43 for rad OIs only
 ;
 S RAOISET="" F  S RAOISET=$O(^ORD(101.43,"S.XRAY",RAOISET)) Q:RAOISET=""  D
 .S RAOII=0 F  S RAOII=$O(^ORD(101.43,"S.XRAY",RAOISET,RAOII)) Q:RAOII=""  D
 ..K RAORD,RAERR,RAQ S RACT=RACT+1
 ..S RAOIFLDS=".01;.1;2;3;71.1:71.4",RAOIENS=RAOII_","
 ..D GETS^DIQ(101.43,RAOIENS,RAOIFLDS,"E","RAORD","RAERR")
 ..S RAPROC=$P($G(RAORD(101.43,RAOIENS,2,"E")),";") ;1st piece of ID is RA Procedure IEN
 ..D PROCCHK ;check all the file #71 fields
 ..S RAOICOM=$G(RAORD(101.43,RAOIENS,71.4,"E")) D COMMCHK ;OI Common Procedure
 ..Q
 .Q
 I $D(^TMP("RASYNC",$J)) D RESYNCIT
 D RPTIT
 K ^TMP("RASYNC",$J),RAORD,RAERR,RAQ,RAMRCP
 Q
PROCCHK ;Check procedure fields for mismatches
 ;Once a mismatch is identified there is no need to keep checking subsequent fields.
 ;
 N RAY S RAFILE=71,RAY=RAPROC_U_$$GET1^DIQ(RAFILE,RAPROC,.01)
 N RAII F RAII=1:1:9 S RAVIT($P($T(VIT+RAII),";",3))=""
 S RAOINAM=$G(RAORD(101.43,RAOIENS,.01,"E")) ;OI Name
 Q:RAOINAM'=RAOISET  ;to avoid processing records twice due to synonyms
 I RAPROC<1 S RATEXT(RAI)=RAOINAM_" ["_RAPROC_"]: OI missing procedure IEN - cannot resync",RAI=RAI+1,RAC2=RAC2+1,RAQ=1 Q
 I '$D(^RAMIS(71,RAPROC)) S RATEXT(RAI)=RAOINAM_" ["_RAPROC_"]: Radiology procedure deleted - cannot resync",RAI=RAI+1,RAC2=RAC2+1,RAQ=1 Q 
 ;
 S RAOIIT=$G(RAORD(101.43,RAOIENS,71.3,"E")) ;OI Imaging Type
 S RAIT=$$GET1^DIQ(71,RAPROC,12)
 I '$D(RAVIT(RAIT)) S RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Invalid I-Type - cannot resync",RAI=RAI+1,RAC2=RAC2+1,RAQ=1 Q
 I RAIT'[RAOIIT D  Q
 .S RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Imaging Type mismatch - cannot resync",RAI=RAI+1,RAC2=RAC2+1,RAQ=1
 .Q
 ;
 S RAPN=$$GET1^DIQ(71,RAPROC,.01)
 S RAOIPT=$G(RAORD(101.43,RAOIENS,71.2,"E")) ;OI Procedure Type (detailed,parent etc)
 ;Don't resync if PT was Detailed or Series as CPT gets deleted.
 S RAPT=$$GET1^DIQ(71,RAPROC,6) I RAPT'=RAOIPT,((RAOIPT="DETAILED")!(RAOIPT="SERIES")) D  Q
 .S RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Procedure Type mismatch - cannot resync",RAI=RAI+1,RAC2=RAC2+1,RAQ=1
 .Q
 ;
 I RAPN'[RAOINAM S RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Original proc name must be preserved - cannot resync",RAI=RAI+1,RAC2=RAC2+1,RAQ=1 Q
 I RAPN'=RAOINAM D
 .S ^TMP("RASYNC",$J,RAFILE,RAPROC)=RAY
 .S RAY(RAPROC)=""
 .S RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Procedure Name",RAI=RAI+1,RAC1=RAC1+1
 .Q
 ;Allow OI Parent to Broad to be synced.
 I RAPT'=RAOIPT,RAPT="BROAD",RAOIPT="PARENT" D  Q
 .S ^TMP("RASYNC",$J,RAFILE,RAPROC)=RAY
 .S RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Procedure Type",RAI=RAI+1,RAC1=RAC1+1,RAQ=1
 .Q
 ;Make sure any parent procedures that do not have descendants are inactive
 S RAPIAC=$$GET1^DIQ(71,RAPROC,100,"I") ;Inactivation Date
 I RAPT="PARENT",'$O(^RAMIS(71,RAPROC,4,0)),((RAPIAC="")!((RAPIAC<4141015)&(RAPIAC>DT))) D  Q
 .N RAFDA S RAFDA(71,RAPROC_",",100)=DT D FILE^DIE("","RAFDA") ;set inactivation date to today
 .S ^TMP("RASYNC",$J,RAFILE,RAPROC)=RAY
 .S RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Inactivation Date set",RAI=RAI+1,RAC1=RAC1+1
 .Q
 ;
 S RAOICPT=$G(RAORD(101.43,RAOIENS,3,"E")) ;OI CPT code
 I $$GET1^DIQ(71,RAPROC,9)'=RAOICPT D  Q
 .S ^TMP("RASYNC",$J,RAFILE,RAPROC)=RAY
 .S:'$D(RAY(RAPROC)) RATEXT(RAI)=RAPN_" ["_RAPROC_"]: CPT Code",RAI=RAI+1,RAC1=RAC1+1
 .Q
 ;
 S RAOIAC=$G(RAORD(101.43,RAOIENS,.1,"E")) ;OI Inactivated
 ;Date range limit to match FM - We will ignore anything over
 I RAPIAC]"",(RAPIAC<1410102)!(RAPIAC>4141015.235959) S RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Inactive Date out of range - cannot resync",RAI=RAI+1,RAC2=RAC2+1,RAQ=1 Q
 I $$GET1^DIQ(71,RAPROC,100)'=RAOIAC D  Q
 .S ^TMP("RASYNC",$J,RAFILE,RAPROC)=RAY
 .S:'$D(RAY(RAPROC)) RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Inactive Date",RAI=RAI+1,RAC1=RAC1+1
 .Q
 ;
CM ;Note that parent procedures in CPRS show contrast based on descendants having
 ;contrast on the radiology side. We'll check descendants if procedure type is PARENT
 ;
 S RAOICM=$G(RAORD(101.43,RAOIENS,71.1,"E")) ;OI Contrast Media
 I RAPT="PARENT" D
 .N RADES,RADI,RAX S RADI=0,RACM=""
 .F  S RADI=$O(^RAMIS(71,RAPROC,4,RADI)) Q:RADI=""  D
 ..S RADES=+$G(^RAMIS(71,RAPROC,4,RADI,0)) ;descendent procedure ien
 ..S RACMI=0 F  S RACMI=$O(^RAMIS(71,RADES,"CM",RACMI)) Q:RACMI=""  D
 ...S RAX=$G(^RAMIS(71,RADES,"CM",RACMI,0)) Q:RACM[RAX  ;don't want repeats
 ...S RACM=RACM_RAX
 ...Q
 ..Q
 .Q
 E  D
 .S RACM="",RACMI=0 F  S RACMI=$O(^RAMIS(71,RAPROC,"CM",RACMI)) Q:RACMI=""  D
 ..S RACM=RACM_$G(^RAMIS(71,RAPROC,"CM",RACMI,0))
 ..Q
 .Q
 I $G(RACM)'=RAOICM D  Q
 .S ^TMP("RASYNC",$J,RAFILE,RAPROC)=RAY
 .S:'$D(RAY(RAPROC)) RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Contrast Media",RAI=RAI+1,RAC1=RAC1+1
 .Q
 Q
 ;
COMMCHK ;Common Procedure check - File 71.3
 ; 'RAOICOM' - Orderable Item Common Procedure flag (YES, NO or NULL)
 ; 'RAPROC'  - Rad procedure IEN
 Q:$D(RAQ)  ;quit flag
 S RAFILE=71.3
 N RACOM,RACOMIAC,RAIT,RASEQ,RAACT S RAACT=0
 I $D(^RAMIS(71.3,"B",RAPROC)) S RACOM=$O(^RAMIS(71.3,"B",RAPROC,0)) D
 .S RAIT=$$EN3^RAUTL17(RAPROC) ;Get I-Type
 .S RASEQ=$P(^RAMIS(71.3,RACOM,0),U,4) ;no sequence nbr=inactive
 .I $G(RASEQ)>0,$D(^RAMIS(71.3,"AA",RAIT,RASEQ,RACOM)) S RAACT=1 ;"AA" set for active only
 .;71.3 not common & 101.43 common or vice versa
 .I (RAACT=0&(RAOICOM="YES"))!(RAACT=1&(RAOICOM'="YES")) D
 ..S ^TMP("RASYNC",$J,RAFILE,RAPROC)=RACOM_U_$$GET1^DIQ(RAFILE,RACOM,.01,"I")
 ..S:'$D(RAY(RAPROC)) RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Common Procedure",RAI=RAI+1,RAC1=RAC1+1
 ..Q
 .Q
 ;if it's not a common procedure but OI common flag is set - resync
 I '$D(^RAMIS(71.3,"B",RAPROC))&(RAOICOM="YES") D
 .S ^TMP("RASYNC",$J,RAFILE,RAPROC)=0_U_RAPROC ;no common procedure IEN to pass
 .S:'$D(RAY(RAPROC)) RATEXT(RAI)=RAPN_" ["_RAPROC_"]: Common Procedure",RAI=RAI+1,RAC1=RAC1+1
 .Q
 Q
RESYNCIT ;Send to CPRS
 ;Now to resync what we stored in ^TMP("RASYNC"
 ;Loop thru ^TMP("RASYNC" to get OoS procedures
 ;build the MFN message for OI update
 ; 'RAY'    <> is the same as 'Y' when passed back from DIC after
 ;             lookup on file 71 & file 71.3
 ; 'RAENALL'<> single procedure (0) or whole file update (1) flag
 ; 'RAFILE' <> file # of the file being edited (71 or 71.3)
 ; 'RASTAT' <> Procedure file (71) status: 0 inactive^1 active
 ; 'RAMIS713(0)' <> For common procedure changed code (not used)
 ; 'RA165'  <> Flag used in RAO7MFN to force update on parent w/o des
 ;
 N RADA,RAY,RAENALL,RASTAT,RAMIS713,RA165 S (RAMIS713(0),RAENALL)=0,RA165=1
 S RASTAT="1^1" ;Pass active^active even with an inactive procedure - forces OI update
 S RAFILE=0 F  S RAFILE=$O(^TMP("RASYNC",$J,RAFILE)) Q:RAFILE=""  D
 .S RADA="" F  S RADA=$O(^TMP("RASYNC",$J,RAFILE,RADA)) Q:RADA=""  D
 ..S RAY=$G(^TMP("RASYNC",$J,RAFILE,RADA)) Q:RAY=""
 ..D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 ..Q
 .Q
 Q
RPTIT ;send results via Mailman
 N XMDUZ,XMSUB,XMTEXT,XMY,RAC3
 N DIFROM ;Required for mailman API (per Kernel DG)
 I '$D(RATEXT) S RATEXT(7)="*** No procedure mismatches found! ***"
 S RAC3=RAC1+RAC2
 ;Mail message introductory blub...
 S RATEXT(1)="The following list of procedures were mismatched between radiology"
 S RATEXT(2)="and CPRS. The PROCEDURE NAME [IEN] is listed followed by the field"
 S RATEXT(3)="that did not match up. Upon completion of patch RA*5*165, the procedures"
 S RATEXT(4)="listed here should be in sync with CPRS. If they could not be synced up"
 S RATEXT(5)="they will also be listed along with the reason they were not resynced."
 S RATEXT(6)=""
 S RATEXT(7)="Total number of procedures checked: "_RACT
 S RATEXT(8)="Total number of mismatched procedures: "_RAC3
 S RATEXT(9)="Total mismatched procedures resynced: "_RAC1
 S RATEXT(10)="Total mismatched procedures skipped: "_RAC2
 S RATEXT(11)=""
 ;XMTEXT for message text
 S XMTEXT="RATEXT("
 S XMSUB="RAD/NUC MED Mismatched Procedures Report"
 S XMDUZ=.5 ;postmaster
 ;Mail Recipients
 S XMY($G(RAMRCP))=""
 D ^XMD
 Q
RIX ;Re-Index CPT CODE - "D" XREF
 N DA,DIC,DIK
 K ^RAMIS(71,"D") ;kill the "D" XREF
 S DIK="^RAMIS(71,",DIK(1)="9^D" D ENALL^DIK
 K DA,DIC,DIK
 Q
VIT ;Valid Imaging types
 ;;ANGIO/NEURO/INTERVENTIONAL
 ;;CARDIOLOGY STUDIES (NUC MED)
 ;;CT SCAN
 ;;GENERAL RADIOLOGY
 ;;MAGNETIC RESONANCE IMAGING
 ;;MAMMOGRAPHY
 ;;NUCLEAR MEDICINE
 ;;ULTRASOUND
 ;;VASCULAR LAB
