MPIFP41 ;;BIR/CML-MPI VISTA build post-init to search for bad ICN Checksums ;Jun 10, 2005
 ;;1.0; MASTER PATIENT INDEX VISTA ;**41**;30 Apr 99
 ;
EN ;
 D BMES^XPDUTL("Post-init will look for patients with erroneous ICN Checksum values.")
 ;
 S QUEDUZ=$S($G(DUZ)="":.5,1:DUZ)
 S ZTSAVE("QUEDUZ")="",ZTRTN="QUE^MPIFP41",ZTDESC="MPI/PD - Search for Bad ICN Checksums",ZTIO="",ZTDTH=$$NOW^XLFDT D ^%ZTLOAD
 I $D(ZTSK) D BMES^XPDUTL("Job was queued as Task #"_ZTSK_".")
 ;
QUIT ;
 K ZTSK S:$D(ZTQUEUED) ZTREQ="@"
 K QUEDUZ,ZTDESC,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTDTH
 Q
 ;
QUE ;entry point for background job
 N ARR,CHKSUM,DA,DFN,DIFF,DR,ERRCNT,I,ICN,LTH,MPI,NODE,OLDSUM,SITENM,SITENUM,TXTCNT,START,STOP
 S (ERRCNT,DFN)=0,START=$$NOW^XLFDT
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S NODE=$G(^DPT(DFN,"MPI")) S ICN=$P(NODE,"^") I ICN D
 .S CHKSUM=$$CHECKDG^MPIFSPC(ICN),OLDSUM=$P(NODE,"^",2)
 .I +OLDSUM,$L(OLDSUM)'=6 S LTH=($L(OLDSUM)+1) F I=LTH:1:6 S OLDSUM="0"_OLDSUM
 .I CHKSUM'=OLDSUM D
 ..S ERRCNT=ERRCNT+1,ARR(ICN)=CHKSUM_"^"_OLDSUM
 ..S DIE="^DPT(",DA=DFN,DR="991.02///^S X=CHKSUM" D ^DIE K DIE
 ;
 ;calculate run time
 S STOP=$$NOW^XLFDT
 S DIFF=($$FMDIFF^XLFDT(STOP,START,2))/3600
 ;
 ;send results back to MPI
 N XMDUZ,XMSUB,SITENM,SITENUM,MPI,XMY,XMTEXT
 S SITENM=$P($$SITE^VASITE,"^",2),SITENUM=$P($$SITE^VASITE,"^",3)
 S XMDUZ="MPI AUSTIN"
 S XMSUB="MPIF*1.0*41 Post Init - "_SITENUM_"/"_SITENM
 S XMY("G.MPI POST INIT MONITOR@MPI-AUSTIN.DOMAIN.EXT")="",XMTEXT="MPI(1,"
 S MPI(1,1)=SITENUM_"/"_SITENM_":   (Run Time = "_$J(DIFF,5,2)_" hrs)"
 S MPI(1,2)="Found "_ERRCNT_" patients with bad ICN checksums"_$S(ERRCNT>0:" -- all have been fixed.",1:".")
 S MPI(1,3)=""
 I ERRCNT>0 S MPI(1,4)="(ICN/GOOD CHECKSUM^CURRENT BAD CHECKSUM)"
 S TXTCNT=4
 S ICN=0 F  S ICN=$O(ARR(ICN)) Q:'ICN  S TXTCNT=TXTCNT+1,MPI(1,TXTCNT)=ICN_"/"_ARR(ICN)
 D ^XMD
 ;send e-mail to local user who queued this job
 N XMDUZ,XMSUB,MPI,XMY,XMTEXT
 S XMDUZ="MPI AUSTIN"
 S XMSUB="MPIF*1.0*41 Post Init Complete."
 S XMY("`"_QUEDUZ_"@"_^XMB("NETNAME"))="",XMTEXT="MPI(1,"
 S MPI(1,1)="Post Init for patch MPIF*1.0*41 has run to completion."
 S MPI(1,2)="You should now delete routine ^MPIFP41."
 D ^XMD
 Q
