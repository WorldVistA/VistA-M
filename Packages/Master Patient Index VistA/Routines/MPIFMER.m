MPIFMER ;SF/MJM,CMC-Merge patient ICN ;JUL 14, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**9,21**;30 Apr 99
 ;
 ; *** THIS ROUTINE IS TO BE REPLACED BY THE LINK/UNLINK MESSAGES
 ; *** SINCE MESSAGES ARE NOT BEING USED BY ANYONE, PLACING QUIT
 ; **** AT ALL ENTRY POINTS.
 ;
 ;Notify MPI and other TF of change to patient's ICN
 ;
MER(PDFN,OLD,ERROR,FLG) ;
 Q
 ;Q:$D(MPIFMER)
 ;Q:$E(OLD,1,3)=$E($P($$SITE^VASITE,"^",3),1,3)
 ;; ^ LOCAL ICN being resolved don't send to CIRN sites OR MPI
 ;; but others may want to know Local Resolved, 
 ;;If other want to know resolved look at x-ref on 991.01 field in file 2
 ;I '$G(PDFN) S ERROR="DFN VARIABLE UNDEFINED" Q
 ;Q:OLD=""
 ;I '$D(FLG) S FLG=""
 ;I '$D(ERROR) S ERROR=""
 ;S ZTRTN="MER2^MPIFMER",ZTDESC="MERGE ICN JOB",ZTIO=""
 ;D NOW^%DTC S ZTDTH=% K %,X
 ;I $D(DUZ) S ZTSAVE("DUZ")=DUZ
 ;S ZTSAVE("PDFN")=PDFN,ZTSAVE("OLD")=OLD,ZTSAVE("ERROR")=ERROR,ZTSAVE("FLG")=FLG
 ;D ^%ZTLOAD
 ;K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 ;Q
MER2 ;
 Q
 ;N RGLOG,CNT,HLA,HL,RGLINK,HOME,SUB,ICN,TMP,PARENT,RGL,CLIENT,I,TD,X,CMOR,HERE,%
 ;Q:$E(OLD,1,3)=$E($P($$SITE^VASITE,"^",3),1,3)
 ;; ^ LOCAL ICN being resolved don't send to CIRN sites or MPI
 ;; though others may want to know Local has been resolved.
 ;;If other want to know resolved look at x-ref on 991.01 field in file 2
 ;Q:'$G(PDFN)
 ;Q:+$$GETICN^MPIF001(PDFN)<0
 ;; ^ If no ICN currently don't send mesg
 ;S CNT=0,HL=0,ERROR="",CLIENT="MPIF A30 SERVER"
 ;D NOW^%DTC S TD=$$HLDATE^HLFNC(%,"DT")
 ;S CMOR=+$$PAT^MPIFNQ(PDFN),HERE=+$$SITE^VASITE()
 ;I CMOR'=HERE,FLG="" S ERROR="PATIENT'S CMOR MUST BE THIS FACILITY" D EXC^MPIFDEL(PDFN,ERROR,226) Q
 ;D INIT^HLFNC2(CLIENT,.HL)
 ;I HL S ERROR=HL D EXC^MPIFDEL(PDFN,ERROR,220) Q
 ;S CNT=CNT+1,HLA("HLS",CNT)="EVN"_HL("FS")_"A30"_HL("FS")_TD_HL("FS")_HL("FS")_HL("FS")
 ;S CNT=CNT+1,HLA("HLS",CNT)=$$EN^VAFCPID(PDFN,"1,2,3,4,5,6,7,8,10,13,14,17,19,11")
 ;S CNT=CNT+1,HLA("HLS",CNT)="MRG"_HL("FS")_OLD
 ;D GENERATE^HLMA(CLIENT,"LM",1,.HLRST,"",.HL)
 ;I 'HLRST S ERROR=HLRST D EXC^MPIFDEL(PDFN,ERROR,220)
 ;Q
LINKS ; gets links to send messages to, including mpi
 ; Currently only the MPI will get Change ICN msgs.
 Q
 ;N SUB,MPI
 ;Q:$P($$GETICN^MPIF001(PDFN),1,3)=$P($$SITE^VASITE(),3)
 ;S SUB=$P($G(^DPT(PDFN,"MPI")),"^",5)
 ;I SUB'="" D GET^HLSUB(SUB,0,"MPIF A30",.HLL)
 ;S MPI=$$MPILINK^MPIFAPI() D
 ;.I $P($G(MPI),U)'=-1 S HLL("LINKS",999)="MPIF A30"_"^"_MPI
 ;.I $P($G(MPI),U)=-1 N RGLOG D START^RGHLLOG(HLMTIEN,"","") D EXC^RGHLLOG(224,"No MPI link defined in CIRN Site Parameter file") D STOP^RGHLLOG(0)
 ;Q
 ;
IN ;process inbound Merge ICN Message - currently not used.
 Q
 ;N I,CNT,NODE,SENDER,NEWICN,OLDICN,PDFN,CMOR,ERR,DA,DIE,DR,SEP,CHK
 ;K ^XTMP($J,"MPIFMER")
 ;; get message
 ;F I=1:1 X HLNEXT Q:HLQUIT'>0  S ^XTMP($J,"MPIFMER","IN",I)=HLNODE
 ;; ^XTMP($J,"MPIFMER","IN",I look for data
 ;S CNT=0
 ;F  S CNT=$O(^XTMP($J,"MPIFMER","IN",CNT)) Q:CNT=""  D
 ;.S NODE=$G(^XTMP($J,"MPIFMER","IN",CNT))
 ;.I $E(NODE,1,3)="MSH" S SEP=$E(NODE,4),SENDER=$P(NODE,SEP,4) Q:'$D(SEP)
 ;.I $P(NODE,SEP)="EVN" Q:$P(NODE,SEP,2)'="A30"
 ;.I $P(NODE,SEP)="PID" S NEWICN=+$P(NODE,SEP,3),CHK=$P($P(NODE,SEP,3),"V",2) Q:NEWICN=""
 ;.I $P(NODE,SEP)="MRG" S OLDICN=+$P(NODE,SEP,2) Q:OLDICN=""
 ;;
 ;Q:'$D(OLDICN)
 ;Q:'$D(^DPT("AICN",OLDICN))
 ;; ^ old icn not at site
 ;S PDFN=""
 ;F  S PDFN=$O(^DPT("AICN",OLDICN,PDFN)) Q:PDFN=""  D
 ;.; incase have multiple OLD-ICNs
 ;.S CMOR=$$PAT^MPIFNQ(PDFN)
 ;.I CMOR'=SENDER S ERR="MERGE ICN MESSAGE DID NOT COME FROM CMOR for Patient dfn="_PDFN D EXC^MPIFDEL(PDFN,ERR,226) Q
 ;.K DA,DIE,DR
 ;.S DA=PDFN,DIE="^DPT(",DR="991.01////"_NEWICN_";991.02////"_CHK,MPIFMER=""
 ;.D ^DIE K MPIFMER
 ;Q
