RGMTUT01 ;BIR/CML-MPI/PD Compile and Correct Data Validation Data for Local Sites ;08/12/02
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**20,31,41**;30 Apr 99
 ;
 ;Reference to $$UPDATE^MPIFAPI supported by IA #2706
 ;Reference to VAFCTFU supported by IA #2988
 ;Reference to ^DPT( supported by IA #2070
 ;Reference to ^DGCN(391.91,"APAT" supported by IA #2911
 ;Reference to ^%ZTSCH("TASK" supported by IA #3520
 ;
EN1 ;Use this entry point to get only display diagnostics for development team
 ;BYPASS=0 means prohibit times are enforced
 ;SITEOPT=0 means CMOR, TF, and diagnostics are included in report
 ;SITEOPT=1 means diagnostics are omitted from report (this is the report for the site)
 ;SITEOPT=2 means only diagnostics are in report
 ;
 S BYPASS=0,SITEOPT=2 G BEGIN
 ;
EN2 ;Use this entry point from remote query
 S BYPASS=1,SITEOPT=0 G BEGIN  ; **41
 ;
EN3 ;Use this entry point for site menu option [RG NATIONAL ICN STATISTICS] to omit
 ;diagnostic section from report
 S BYPASS=0,SITEOPT=1 G BEGIN
 ;
BY ;use this call to bypass check to prohibit primetime run
 S BYPASS=1,SITEOPT=2
 ;
BEGIN ;
 S PRT=0,QFLG=0 K RGROU
 I $D(^XTMP("RGMT","UT01","@@","COMPILE STARTED"))&('$D(^XTMP("RGMT","UT01","@@","COMPILE STOPPED"))) D  I QFLG G QUIT
 .;check running tasks to see if compile is running
 .S TASK=0 F  S TASK=$O(^%ZTSCH("TASK",TASK)) Q:'TASK  D
 ..S RGROU=$P(^%ZTSCH("TASK",TASK),"^",2)
 ..I RGROU="RGMTSTAT" D
 ...I TASK=$G(ZTSK) Q
 ...S QFLG=1
 ...I '$D(RGHLMQ) W !!,"The Stat Report is currently being compiled."
 .I 'QFLG K ^XTMP("RGMT","UT01"),^XTMP("RGMT","REINDDT")
 ;
 I $D(RGHLMQ) G STARTQ
 W !!,"This option provides the following statistics:"
 W !?3,"1.  Total patients assigned to each unique COORDINATING MASTER OF"
 W !?3,"    RECORD (CMOR)."
 W !?3,"2.  Total patients shared with each unique entry in the TREATING"
 W !?3,"    FACILITY LIST (#391.91) file."
 W !?3,"3.  Totals for national ICNs, local ICNs, and patients with no ICN."
 I SITEOPT=1 G START
 W !?3,"4.  Total CMOR assignments missing a matching Treating Facility."
 W !?3,"5.  Total patients with NATIONAL ICN and missing local Treating Facility."
 W !?3,"6.  Total number of patients with duplicate entries in the TREATING"
 W !?3,"    FACILITY LIST file (#391.91)."
 W !?3,"7.  Patient File xref problems for ""AICN"", ""AICNL"", and ""SSN""."
 W !?3,"8.  Total number of patients with a no ICN but have a CMOR assignment."
 W !?3,"9.  Total number of patients with a no ICN but have TF assignments."
 W !?3,"10. Total number of patients with a local ICN but have remote TFs."
 ;
START ;
 S QFLG=0
 I '$D(^XTMP("RGMT","UT01","@@","COMPILE STARTED")) W !!,"No data is currently available." I SITEOPT=1 G QUIT
 ;
 W !!,"===> NOTE <==="
 I SITEOPT=1 D
 .W !,"This data is compiled by a remote process initiated from the MPI in Austin"
 .W !,"on a regular basis for reporting purposes.  It is not compiled by the local"
 .W !,"site, however, the local site can view the last report that was compiled.",!
 ;
 I $D(^XTMP("RGMT","UT01","@@","COMPILE STOPPED")) D  G:QFLG QUIT I PRT D ^RGMTUT03 G QUIT
 .S PRT=0
 .S LAST=^XTMP("RGMT","UT01","@@","COMPILE STOPPED")
 .S LAST=$$FMTE^XLFDT(LAST)
 .W !,"This data was last compiled on ",LAST,"."
 .I SITEOPT=1 S PRT=1 Q
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you just want a reprint of that data"
 .S DIR("?",1)="Enter:"
 .S DIR("?",2)=" ""YES"" or <RET> to reprint current data and NOT recompile."
 .S DIR("?",3)=" ""NO"" to recompile new data (this may take several hours)."
 .S DIR("?")=" ""^"" to HALT."
 .D ^DIR K DIR
 .I Y="^" S QFLG=1 Q
 .I +Y=1 S PRT=1 Q
 ;
STARTQ ;pick up here for queued job
 D NOW^%DTC
 ;
 ;check to be sure stat report not being run during prime time
 S TODAY=$$DOW^XLFDT($$NOW^XLFDT()) I TODAY="Saturday"!(TODAY="Sunday") S BYPASS=1
 S QUIT=0
 I 'BYPASS D  I QUIT G QUIT
 .S CHKTIME=$E($P(%,".",2),1,4)
 .I CHKTIME>"0700"&(CHKTIME<"1700") S QUIT=1 I '$D(RGHLMQ) D
 ..W !!,"<< STAT report cannot be compiled between 7:00am and 5:00pm! >>"
 ;
 I '$D(RGHLMQ) W !!,"Recompiling data..."
 ;
 S ^XTMP("RGMT",0)=$$FMADD^XLFDT(DT,30)_"^"_$$NOW^XLFDT_"^MPI/PD Maintenance Data"
 K ^XTMP("RGMT","UT01"),^XTMP("RGMT","REINDDT")  ; **41
 S ^XTMP("RGMT","UT01","@@","COMPILE STARTED")=%
 ;
 D REIND^RGMTUT02
 D CMOR,TF,TFCHK
 ;
 I 'PRT D
 .D NOW^%DTC
 .S ^XTMP("RGMT","UT01","@@","COMPILE STOPPED")=%
 D ^RGMTUT03
 ;
QUIT ;
 K %,BYPASS,CHKTIME,LAST,LOC,PRT,QFLG,QUIT,SITEOPT,TODAY,Y,RGROU,TASK
 Q
 ;
CMOR ; Check "ACMOR" xref for:
 ; - existence of a TF entry for the CMOR in the TF file #391.91
 ; - existence of a TF for the local site (if not the CMOR)
 ; - CMOR totals by site
 ;
 I '$D(RGHLMQ) D
 .W !!,"Check #1 for:"
 .W !,"- Patients missing Treating Facility entries for their CMOR."
 .W !,"- Patients missing Treating Facility entries for their local site."
 .W !,"- Unique CMOR totals."
 ;
 K ^XTMP("RGMT","UT01","CMOR")
 K ^XTMP("RGMT","UT01","TOT CMOR MISS TF")
 K ^XTMP("RGMT","UT01","TOT LOC SITE MISS TF")
 K ^XTMP("RGMT","UT01","CMOR WITH NO ICN")
 S (CNT,NOICN,TOTMISSC,TOTMISSL)=0
 S SITESTA=$P($$SITE^VASITE(),"^",3),SITEDA=$P($$SITE^VASITE(),"^")
 ;
 S CMOR=0 F  S CMOR=$O(^DPT("ACMOR",CMOR)) Q:'CMOR  D
 .I '$D(CMOR(CMOR)) S CMOR(CMOR)=0
 .S DFN=0 F  S DFN=$O(^DPT("ACMOR",CMOR,DFN)) Q:'DFN  D
 ..S CNT=CNT+1 I '$D(RGHLMQ) W:'(CNT#10000) "."
 ..S ICN=$P($G(^DPT(DFN,"MPI")),"^")
 ..I $E(ICN,1,3)=SITESTA Q
 ..I ICN="" D  Q
 ...S NOICN=NOICN+1
 ...I '$D(RGHLMQ) W !?3,"DFN #",DFN," has no ICN and a CMOR of ",$P($$NS^XUAF4(CMOR),"^")
 ...S ^XTMP("RGMT","UT01","CMOR WITH NO ICN",DFN)=""
 ...S LOC(991.03)="@" W $$UPDATE^MPIFAPI(DFN,"LOC")
 ..S CMOR(CMOR)=CMOR(CMOR)+1
 ..I '$D(^DGCN(391.91,"APAT",DFN,CMOR)) D
 ...S TOTMISSC=TOTMISSC+1
 ...S SSN=$P($G(^DPT(DFN,0)),"^",9)
 ...S NAME=$P($G(^DPT(DFN,0)),"^")
 ...S ^XTMP("RGMT","UT01","CMOR","ZZMISSC",CMOR,DFN)="DFN/"_DFN_"^NAME/"_NAME_"^SSN/"_SSN_"^ICN/"_ICN
 ...D FILE^VAFCTFU(DFN,CMOR,1)
 ..I SITEDA'=CMOR,'$D(^DGCN(391.91,"APAT",DFN,SITEDA)) D
 ...S TOTMISSL=TOTMISSL+1
 ...S SSN=$P($G(^DPT(DFN,0)),"^",9)
 ...S NAME=$P($G(^DPT(DFN,0)),"^")
 ...S ^XTMP("RGMT","UT01","CMOR","ZZMISSL",CMOR,DFN)="DFN/"_DFN_"^NAME/"_NAME_"^SSN/"_SSN_"^ICN/"_ICN
 ...D FILE^VAFCTFU(DFN,SITEDA,1)
 ;
 S CMOR=0 F  S CMOR=$O(CMOR(CMOR)) Q:'CMOR  D
 .S CMORNM=$P($$NS^XUAF4(CMOR),"^"),CMORSTA=$P($$NS^XUAF4(CMOR),"^",2) Q:CMORSTA=""
 .S ^XTMP("RGMT","UT01","CMOR",CMORNM,CMORSTA)=CMOR(CMOR)
 S ^XTMP("RGMT","UT01","TOT CMOR MISS TF")=TOTMISSC
 S ^XTMP("RGMT","UT01","TOT LOC SITE MISS TF")=TOTMISSL
 S ^XTMP("RGMT","UT01","CMOR WITH NO ICN")=NOICN
 I '$D(RGHLMQ) W !,"Check #1 - Complete"
 K CMOR,CMORNM,CMORSTA,CNT,DFN,ICN,NAME,NOICN,SITEDA,SITESTA,SSN,TOTMISSC,TOTMISSL
 Q
 ;
TF ; Get totals for unique sites in the TF file (#391.91)
 I '$D(RGHLMQ) D
 .W !!,"Check #2 for:"
 .W !,"- Unique Treating Facility totals."
 K ^XTMP("RGMT","UT01","TF"),TFCNT S CNT=0
 S SITE=$P($$SITE^VASITE(),"^",3)
 S TF=0 F  S TF=$O(^DGCN(391.91,"AINST",TF)) Q:'TF  D
 .S CNT=CNT+1 I '$D(RGHLMQ) W:'(CNT#10000) "."
 .I '$D(TFCNT(TF)) S TFCNT(TF)=0
 .S TFIEN=0 F  S TFIEN=$O(^DGCN(391.91,"AINST",TF,TFIEN)) Q:'TFIEN  S TFCNT(TF)=TFCNT(TF)+1
 S TF=0 F  S TF=$O(TFCNT(TF)) Q:'TF  D
 .S TFNM=$P($$NS^XUAF4(TF),"^"),TFSTA=$P($$NS^XUAF4(TF),"^",2) Q:TFSTA=""
 .S ^XTMP("RGMT","UT01","TF",TFNM,TFSTA)=TFCNT(TF)
 I '$D(RGHLMQ) W !,"Check #2 - Complete"
 K CNT,SITE,TF,TFCNT,TFIEN,TFNM,TFSTA
 Q
 ;
TFCHK ; Get totals for duplicates in TF file (#391.91)
 ;NOICN=# of patients found with remote TFs and no ICN
 ;LOCICN=# of patients found with remote TFs and a local ICN
 ;
 I '$D(RGHLMQ) D
 .W !!,"Check #3 for:"
 .W !,"- Duplicate Treating Facility assignments."
 .W !,"- Patients with Treating Facilities and no ICN."
 .W !,"- Patients remote treating Facilities and Local ICN."
 ;
 K ^XTMP("RGMT","UT01","TOT TFDUP"),^XTMP("RGMT","UT01","TOT NO ICN W/TF"),^XTMP("RGMT","UT01","TOT LOC ICN W/REMOTE TF")
 S (PTCNT,DUPCNT,NOICN,LOCICN)=0
 S SITESTA=$P($$SITE^VASITE(),"^",3),SITEDA=$P($$SITE^VASITE(),"^")
 S DFN=0 F  S DFN=$O(^DGCN(391.91,"APAT",DFN)) Q:'DFN  D
 .S PTCNT=PTCNT+1 I '$D(RGHLMQ) W:'(PTCNT#10000) "."
 .S TF=0 F  S TF=$O(^DGCN(391.91,"APAT",DFN,TF)) Q:'TF  D
 ..S MPI0=$G(^DPT(DFN,"MPI")),ICN=$P(MPI0,"^")
 ..;delete all TFs for patients with no ICN
 ..I ICN="" D  Q
 ...S NOICN=NOICN+1
 ...S TFIEN=0 F  S TFIEN=$O(^DGCN(391.91,"APAT",DFN,TF,TFIEN)) Q:'TFIEN  D
 ....S ^XTMP("RGMT","UT01","NO ICN WITH REMOTE OR LOCAL TF",DFN,TFIEN)=""
 ....D DELETE^VAFCTFU(TFIEN)
 ..;delete all remote TFs for patients with local ICNs
 ..I $E(ICN,1,3)=SITESTA,TF'=SITEDA D  Q
 ...S TFIEN=0 F  S TFIEN=$O(^DGCN(391.91,"APAT",DFN,TF,TFIEN)) Q:'TFIEN  D
 ....S LOCICN=LOCICN+1
 ....S ^XTMP("RGMT","UT01","LOCAL ICN WITH REMOTE TF",DFN,TFIEN)=""
 ....D DELETE^VAFCTFU(TFIEN)
 ..;look for TF dups
 ..S (TFCNT,TFIEN)=0 F  S TFIEN=$O(^DGCN(391.91,"APAT",DFN,TF,TFIEN)) Q:'TFIEN  D
 ...S TFCNT=TFCNT+1 I TFCNT>1 D
 ....S DUPCNT=DUPCNT+1
 ....S SSN=$P($G(^DPT(DFN,0)),"^",9)
 ....S NM=$P($G(^(0)),"^")
 ....S ^XTMP("RGMT","UT01","TFDUP",DFN,TFIEN)=TF_"^"_NM_"^"_SSN
 ....D DELETE^VAFCTFU(TFIEN)
 ;
 S ^XTMP("RGMT","UT01","TOT TFDUP")=DUPCNT
 S ^XTMP("RGMT","UT01","TOT NO ICN W/TF")=NOICN
 S ^XTMP("RGMT","UT01","TOT LOC ICN W/REMOTE TF")=LOCICN
 I '$D(RGHLMQ) W !,"Check #3 - Complete"
 K DFN,DUPCNT,ICN,LOCICN,MPI0,NM,NOICN,PTCNT,SITEDA,SITESTA,SSN,TF,TFCNT,TFIEN
 Q
