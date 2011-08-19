MDCVT ; HOIFO/DP/NCA - Medicine Package Conversion ;10/20/04  12:49
 ;;1.0;CLINICAL PROCEDURES;**5**;Apr 01, 2004;Build 1
 ; Integration Agreements:
 ; IA# 2263 [Supported] XPAR parameter calls.
 ; IA# 2320 [Supported] %ZISH calls.
 ; IA#10031 [Supported] DDS call to bring up Screen Man
 ;
EN ; [Procedure] Main entry point to convert database to TIU notes
 N MDCNVT,MDDIR,MDFILE,MDREC,MDTEST,MDTIUI,MDXR,ORHFS,X,Y
 S (MDCNVT("CR"),MDCNVT("CT"),MDCNVT("E"),MDCNVT("S"),MDCNVT("TOT"))=0
 I $$GET^XPAR("SYS","MD MEDICINE CONVERTED",1) W !!,"Already Converted" Q
 I '$P($G(^MDD(703.9,1,0)),U,3) W !!,"No Administrative Closure Person." Q
 S MDTEST=+$P($G(^MDD(703.9,1,0)),U,2)'=1
 S MDXR=$O(^MDD(703.9,1,2,"AS","")) I MDXR="" W !!,"No Conversion List.  Run Build Conversion List option." Q
 ;
 W @IOF,!,"Medicine to Clinical Procedure Conversion"
 K DIR S DIR(0)="YA"
 S DIR("A")="Ok to continue? "
 S DIR("A",1)="Running conversion in "_$S(MDTEST:"TEST",1:"REAL")_" mode.",DIR("B")="NO" D ^DIR K DIR Q:$D(DIRUT)!$D(DIROUT)!(Y<1)
 ;
 ; Set up the HFS variables
 S MDFILE="MDCVT.TXT",MDDIR=$P($G(^MDD(703.9,1,.1)),U)
 S X=$$TESTHFS() I '+X W !!,"HFS Device Error: ",$P(X,U,2) Q
 ;
 ; Last Chance
 W ! K DIR S DIR(0)="YA"
 S DIR("A")="Ready to "_$S(MDTEST:"test the conversion of",1:"convert")_" the Medicine Files? "
 S DIR("B")="NO" D ^DIR K DIR Q:$D(DIRUT)!$D(DIROUT)!(Y<1)
 ;
 ; See if previous errors need to be reset
 W !!,"Conversion in progress...",!
 D RESET
 ;
 ; Set MDREC up here - This prevents loss on M error trap in EN1
 S MDREC=0
 ;
 W !?5,"[.] Indicates converted record"
 W !?5,"[*] Indicates error in record",!!
 ;
EN1 ; [Procedure] Resumes on error via $ETRAP variable
 N $ESTACK,$ETRAP S $ETRAP="ERR^MDCVT"
 N MDCONS,MDECON,MDFDA,MDNODE,MDNOTE,MDOK,MDPR,MDR,MDR1,MDSTUD,MDUSR,MDX1
 F  S MDREC=$O(^MDD(703.9,1,2,"AS","R",MDREC)) Q:'MDREC  D
 .S MDPTR=$$GET1^DIQ(703.92,MDREC_",1,",.01) Q:MDPTR=""
 .S MDGBL=U_$P(MDPTR,";",2)_$P(MDPTR,";",1)_")"
 .S MDCNVT("TOT")=MDCNVT("TOT")+1
 .I '$P($G(^MDD(703.9,1,1,+$P(MDGBL,"(",2),0)),U,3) D  Q
 ..D SKIP(MDPTR,"Report type not marked for conversion")
 ..S MDCNVT("S")=MDCNVT("S")+1
 .S MDSTAT=$P($G(@MDGBL@("ES")),U,7)
 .I MDSTAT="" D  Q:'MDOK
 ..S MDOK=+$P($G(^MDD(703.9,1,1,+$P(MDGBL,"(",2),0)),U,4)
 ..D:'MDOK LOGERR(MDPTR,"Unable to determine status")
 .I MDSTAT="S" D SKIP(MDPTR,"Report Superseded") S MDCNVT("S")=MDCNVT("S")+1 Q
 .I MDSTAT["D" D LOGERR(MDPTR,"Report in Draft/Problem Draft status") Q
 .;I MDSTAT="RNV" D LOGERR(MDPTR,"Report not verified") Q
 .I MDTEST W "." ; Progress indicator
 .;
 .; Produce report using HFS device MDHFS
 .S %ZIS("HFSNAME")=MDDIR_MDFILE,%ZIS("HFSMODE")="W",IOP="MDHFS;P-MDHFS"
 .D ^%ZIS I POP D LOGERR(MDPTR,"No HFS Access or device MDHFS") Q
 .S ORHFS="SCRATCH"
 .U IO D EN^MCAPI(MDPTR,0) D ^%ZISC
 .;
 .; Fetch the report text
 .K ^TMP($J)
 .S X=$$FTG^%ZISH(MDDIR,MDFILE,$NA(^TMP($J,1)),2)
 .;
 .; Delete the Host File
 .S DELETE(MDFILE)=""
 .S X=$$DEL^%ZISH(MDDIR,"DELETE")
 .; Is it a valid report?
 .S LINES=$O(^TMP($J,""),-1)
 .S BYTES=0 F X=0:0 S X=$O(^TMP($J,X)) Q:'X  S BYTES=BYTES+$L(^(X))
 .I LINES<5&(^TMP($J,2)["BAD MEDICINE") D LOGERR(MDPTR,^TMP($J,2)) Q
 .;
 .; Get Legal header For Report
 .S RESULTS=$NA(^TMP($J)) D GETHDR^MDESPRT(.RESULTS,MDPTR)
 .;
 .; If test mode quit at this point
 .I MDTEST D FINISH(MDPTR,LINES,BYTES,"") S MDCNVT("CT")=MDCNVT("CT")+1 Q
 .;
 .; If real mode set to Unspecified Error status and proceed
 .;D LOGERR(MDPTR,"Unspecified Error")
 .S MDNODE=$G(^MDD(703.9,1,2,+MDREC,0))
 .S MDNODE=$P(MDNODE,U,1)
 .;
 .; Create the note
 .S MDTIUI=$$CONVERT^MDCVT1(MDNODE,$NA(^TMP($J)))
 .I +MDTIUI'>0 D LOGERR(MDPTR,"Couldn't create the TIU document") Q
 .;
 .; Update Consults and Imaging
 .;
 .D UPD^MDCVT1(MDGBL,MDNODE,MDTIUI,MDTEST)
 .;
 .; Flag as finished
 .;
 .D FINISH(MDPTR,LINES,BYTES,MDTIUI) S MDCNVT("CR")=MDCNVT("CR")+1
 ;
 D TOTALS^MDCVT1(.MDCNVT)
 Q
 ;
TESTHFS() ; Verify HFS is working properly
 N MDNOW
 S %ZIS("HFSNAME")=MDDIR_MDFILE,%ZIS("HFSMODE")="W",IOP="MDHFS;P-MDHFS"
 D ^%ZIS I POP W !,"No HFS Access or missing device MDHFS" Q 0
 S X=1 D  Q:'X 0
 .I IOT'="HFS" W !,"Device MDHFS not of type HFS" S X=0
 .I IOST'="P-MDHFS" W !,"Missing Terminal Type P-MDHFS" S X=0 Q
 .I IOSL'=88 W !,"Improper Page Length in Terminal Type P-MDHFS" S X=0
 .I IOM'=80 W !,"Improper Page Width in Terminal Type P-MDHFS" S X=0
 .I IOF'="#" W !,"Improper Form Feed in Terminal Type P-MDHFS" S X=0
 ;
 D NOW^%DTC S MDNOW=% K %
 U IO W !!,MDNOW
 D ^%ZISC
 ;
 ; Fetch the text
 K ^TMP($J)
 S X=$$FTG^%ZISH(MDDIR,MDFILE,$NA(^TMP($J,1)),2)
 I 'X W !,"Unable to retrieve data back from Host File" Q 0
 I ^TMP($J,3)'=MDNOW W !,"Error verifying data in Host File" Q 0
 ;
 ; Delete the Host File
 S DELETE(MDFILE)=""
 S X=$$DEL^%ZISH(MDDIR,"DELETE")
 I X'=1 W !,"Unable delete Host File" Q 0
 Q 1
 ;
ERR ; M Error trap submodule to document error and continue
 D LOGERR(MDPTR,$ECODE)
 I $G(ION)="MDHFS" D ^%ZISC ; Close device if using the HFS
 G EN1
 ;
FINISH(MDPTR,LINES,BYTES,TIUIEN) ; Update status to converted
 N MDFDA,MDIEN,MDIENS
 S MDIEN=$O(^MDD(703.9,1,2,"B",MDPTR,0))
 I MDIEN<1 W !,"Error, no log entry ",MDPTR Q
 S MDIENS=MDIEN_",1,"
 I MDTEST S MDFDA(703.92,MDIENS,.02)="CT"
 E  S MDFDA(703.92,MDIENS,.02)="CR"
 S MDFDA(703.92,MDIENS,.03)=TIUIEN
 S MDFDA(703.92,MDIENS,.04)=LINES
 S MDFDA(703.92,MDIENS,.05)=BYTES
 S MDFDA(703.92,MDIENS,.1)=LINES_" lines, "_BYTES_" bytes"
 D FILE^DIE("","MDFDA")
 Q
 ;
LOGERR(MDPTR,ERRMSG) ; Log conversion error
 N MDFDA,MDIEN,MDIENS
 S MDIEN=$O(^MDD(703.9,1,2,"B",MDPTR,0))
 I MDIEN<1 W !,"Error, no log entry ",MDPTR Q
 S MDIENS=MDIEN_",1,"
 S MDFDA(703.92,MDIENS,.02)="E"
 S MDFDA(703.92,MDIENS,.1)=$TR(ERRMSG,U,"~")
 D FILE^DIE("","MDFDA")
 W "*" ; Progress indicator
 Q
 ;
RESET ; Reset error status reports to READY TO CONVERT
 N MDIEN S MDIEN=0
 ; Check for real mode and convert test conversions
 I 'MDTEST F  S MDIEN=$O(^MDD(703.9,1,2,"AS","CT",MDIEN)) Q:'MDIEN  D
 .N MDFDA
 .S MDFDA(703.92,MDIEN_",1,",.02)="R"
 .D FILE^DIE("","MDFDA")
 ; Regardless of mode switch skipped back to ready
 F  S MDIEN=$O(^MDD(703.9,1,2,"AS","S",MDIEN)) Q:'MDIEN  D
 .N MDFDA
 .S MDFDA(703.92,MDIEN_",1,",.02)="R"
 .D FILE^DIE("","MDFDA")
 ; Regardless of mode switch errors back to ready
 F  S MDIEN=$O(^MDD(703.9,1,2,"AS","E",MDIEN)) Q:'MDIEN  D
 .N MDFDA
 .S MDFDA(703.92,MDIEN_",1,",.02)="R"
 .D FILE^DIE("","MDFDA")
 Q
 ;
REBUILD ; [Procedure] Build the file manually
 N MDROOT
 S X=$P(^MDD(703.9,0),U,1,2)_U_U K ^MDD(703.9) S ^MDD(703.9,0)=X
 S MDROOT=$NA(^MDD(703.9,1))
 S @MDROOT@(0)="DEFAULT"
 S @MDROOT@(1,0)="^703.91P^^"
 F X=691,691.1,691.5,691.6,691.7,691.8,694,694.5,698,698.1,698.2,698.3,699,699.5,700,701 S @MDROOT@(1,X,0)=X
 S DA=1,DIK="^MDD(703.9," D IXALL^DIK K DA,DIK
 Q
 ;
SETUP ; [Procedure] 
 I '$O(^MDD(703.9,0)) W !,"Initializing..." D REBUILD,SETDEF^MDSTATU
 S DDSFILE=703.9,DR="[MD MAIN]",DA=1 D ^DDS
 Q
 ;
SKIP(MDPTR,REASON) ; [Procedure] Skip Report
 N MDFDA,MDIEN,MDIENS
 S MDIEN=$O(^MDD(703.9,1,2,"B",MDPTR,0))
 I MDIEN<1 W !,"Error, no log entry ",MDPTR Q
 S MDIENS=MDIEN_",1,"
 S MDFDA(703.92,MDIENS,.02)="S"
 S MDFDA(703.92,MDIENS,.1)=$TR(REASON,U,"~")
 D FILE^DIE("","MDFDA")
 Q
 ;
SYNC(MDPTR) ; Make sure entry exists
 N MDFDA
 Q:$O(^MDD(703.9,1,2,"B",MDPTR,0))
 Q:$O(^MDD(702,"ACONV",MDPTR,0))
 S MDFDA(703.92,"+1,1,",.01)=MDPTR
 S MDFDA(703.92,"+1,1,",.02)="R"
 D UPDATE^DIE("","MDFDA")
 Q
 ;
LOCKOUT ; Lockout Options and set API Flag
 D ^MDOUTOR
 Q
 ;
STATUS(MDPTR) ; [Procedure] Return status of VPtr
 S X=$O(^MDD(703.9,1,2,"B",MDPTR,0))
 I X Q $P($G(^MDD(703.9,1,2,X,0)),U,2)  ; Return actual status
 N MDFDA,MDIEN,MDMSG
 S MDFDA(703.92,"+1,1,",.01)=MDPTR
 S MDFDA(703.92,"+1,1,",.02)="N"
 D UPDATE^DIE("","MDFDA","MDIEN","MDMSG")
 I $G(MDIEN(1))<1 W !,"Error adding to conversion log ",MDPTR Q -1
 Q "N"
 ;
SUMMARY ; Disk space requirements
 N FILE,LP,TOTB,TOTC,TOTL,X
 W !!,"Summarizing..."
 K ^TMP($J)
 S (TOTL,TOTC,TOTB)=0
 S MDSTAT=$O(^MDD(703.9,1,2,"AS","C")) ; will be CT or CR
 I MDSTAT'["C" W !!,"No report was converted. You MUST run the conversion in TEST or",!,"REAL mode first to be able to display the Disk Space Requirements." Q
 D S1 I MDSTAT="CR" S MDSTAT="CT" D S1
 W @IOF,!,"FILE",?42,$J("COUNT",8),?52,$J("LINES",8),?62,$J("BYTES",12)
 W !,$TR($J("",79)," ","-")
 S X="" F  S X=$O(^TMP($J,X)) Q:X=""  D
 .W !,$E($P(@X,U,1),1,40)
 .W ?42,$J(^TMP($J,X,"C"),8)
 .W ?52,$J(^TMP($J,X,"L"),8)
 .W ?62,$J(^TMP($J,X,"B"),12)
 .S TOTC=TOTC+^TMP($J,X,"C")
 .S TOTL=TOTL+^TMP($J,X,"L")
 .S TOTB=TOTB+^TMP($J,X,"B")
 W !?42,$TR($J("",37)," ","=")
 W !?42,$J(TOTC,8),?52,$J(TOTL,8),?62,$J(TOTB,12) K ^TMP($J)
 Q
 ;
S1 ; Loop for both CT or CR Statuses
 N X S X="" F  S X=$O(^MDD(703.9,1,2,"AS",MDSTAT,X)) Q:X=""  D
 .S FILE=$P($G(^MDD(703.9,1,2,X,0)),U,1)
 .S FILE=U_$P(FILE,";",2)_"0)"
 .S ^TMP($J,FILE,"C")=$G(^TMP($J,FILE,"C"))+1
 .S ^TMP($J,FILE,"L")=$G(^TMP($J,FILE,"L"))+$P(^MDD(703.9,1,2,X,0),U,4)
 .S ^TMP($J,FILE,"B")=$G(^TMP($J,FILE,"B"))+$P(^MDD(703.9,1,2,X,0),U,5)
 Q
TOTALS ; Count by Status
 N MDSTAT S MDSTAT=""
 F  S MDSTAT=$O(^MDD(703.9,1,2,"AS",MDSTAT)) Q:MDSTAT=""  D
 .S Y=0 F X=0:0 S X=$O(^MDD(703.9,1,2,"AS",MDSTAT,X)) Q:'X  S Y=Y+1
 .S MDSTAT(MDSTAT)=Y
 W @IOF,!,"Conversion Totals",!,$TR($J("",35)," ","-")
 W !,"Converted REAL Mode: ",$J(+$G(MDSTAT("CR")),9)
 W !,"Converted TEST Mode: ",$J(+$G(MDSTAT("CT")),9)
 W !,"Skipped:             ",$J(+$G(MDSTAT("S")),9)
 W !,"Error:               ",$J(+$G(MDSTAT("E")),9)
 Q
 ;
