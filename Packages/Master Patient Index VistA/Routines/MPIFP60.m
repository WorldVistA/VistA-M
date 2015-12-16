MPIFP60 ;;OAK/ELZ-MPI VISTA POST-INIT MPIF*1*60 ;OCT 8, 2014
 ;;1.0;MASTER PATIENT INDEX VISTA;**60**;30 Apr 99;Build 2
 ;
POST ;
 D BMES^XPDUTL("Post-init will populate the new Full ICN fields.")
 ;
 N QUEDUZ,ZTDESC,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTDTH
 ;
 I $G(^XTMP("MPIFP60","CURRENT STATUS"))["FINISHED" D BMES^XPDUTL("Post-init already run...  Done") Q
 ;
 S QUEDUZ=$S($G(DUZ)="":.5,1:DUZ)
 S ZTSAVE("QUEDUZ")="",ZTRTN="DQ^MPIFP60",ZTDESC="MPI/PD - Populate new Full ICN fields",ZTIO="",ZTDTH=$$NOW^XLFDT D ^%ZTLOAD
 I $D(ZTSK) D BMES^XPDUTL("Job was queued as Task #"_ZTSK_".")
 S ^XTMP("MPIFP60",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^MPIF*1*60 POST-INIT"
 S ^XTMP("MPIFP60","CURRENT STATUS")="QUEUED TASK #"_ZTSK
 ;
 K ZTSK S:$D(ZTQUEUED) ZTREQ="@"
 ;
 Q
 ;
DQ ;entry point for background job
 ;
 N DFN,MPINODE,ICN,CKSUM,FULLICN,DIE,DA,DR,HISX,HISZ,QUIT,X,Y
 ;
 S ^XTMP("MPIFP60","CURRENT STATUS")="RUNNING AT "_$$NOW^XLFDT
 S DFN=+$G(^XTMP("MPIFP60","LAST DFN"))
 ;
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . ;
 . ;Q:DFN>5
 . ;
 . ; populate FULL ICN field
 . S MPINODE=$G(^DPT(DFN,"MPI"))
 . S ICN=$P(MPINODE,"^"),CKSUM=$P(MPINODE,"^",2)
 . I ICN,CKSUM D
 .. S FULLICN=ICN_"V"_CKSUM
 .. S DIE="^DPT(",DA=DFN,DR="991.1///^S X=FULLICN" D ^DIE
 . ;
 . ; populate the FULL ICN HISTORY multiple
 . S HISX=0 F  S HISX=$O(^DPT(DFN,"MPIFHIS",HISX)) Q:'HISX  D
 .. S HISZ=$G(^DPT(DFN,"MPIFHIS",HISX,0))
 .. S ICN=$P(HISZ,"^"),CKSUM=$P(HISZ,"^",2)
 .. I ICN,CKSUM D
 ... S FULLICN=ICN_"V"_CKSUM
 ... ;
 ... ; lets double check it isn't here already
 ... S (X,QUIT)=0 F  S X=$O(^DPT(DFN,"MPIFICNHIS",X)) Q:'X!(QUIT)  I ^DPT(DFN,"MPIFICNHIS",X,0)=FULLICN S QUIT=1
 ... Q:QUIT
 ... ;
 ... ; file it
 ... S X=FULLICN
 ... S DIC="^DPT("_DFN_",""MPIFICNHIS"",",DIC(0)="L"
 ... S DA(1)=DFN
 ... D ^DIC
 . ;
 . ; ok all done with this patient
 . S ^XTMP("MPIFP60","LAST DFN")=DFN
 ;
 ; send e-mail to user who queued job
 N XMDUZ,XMSUB,MPI,XMY,XMTEXT
 S XMDUZ="MPI PACKAGE"
 S XMSUB="MPIF*1.0*60 Post Init Complete."
 S XMY(QUEDUZ)="",XMTEXT="MPI(1,"
 S MPI(1,1)="Post Init for patch MPIF*1.0*60 has run to completion."
 S MPI(1,2)="You may now delete routine ^MPIFP60."
 D ^XMD
 ;
 S ^XTMP("MPIFP60","CURRENT STATUS")="FINISHED AT "_$$NOW^XLFDT
 ;
 Q
