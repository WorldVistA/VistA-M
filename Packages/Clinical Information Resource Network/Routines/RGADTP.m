RGADTP ;BIR/DLR-ADT PROCESSOR TO RETRIGGER A08 or A04 MESSAGES WITH AL/AL (COMMIT/APPLICATION) ACKNOWLEDGEMENTS ;2/18/22  10:22
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**26,27,20,34,35,40,45,44,47,59,60,61,62,63,65,68,69,70,74,76,77**;30 Apr 99;Build 3
 ;
 ;Reference to BLDEVN^VAFCQRY and BLDPID^VAFCQRY supported by IA #3630
 ;Reference to EN1^VAFHLZEL is supported by IA #752
 ;Reference to Patient file (#2) PREFERRED FACILITY (#27.02) is supported by IA #1850
 ;Reference to $$PV2, $$PHARA, $$LABE, $$RADE ^VAFCSB is supported by IA #4921
 ;
INIT ;
 N RGER,RGSITE,ARRAY,MSH,RGLOCAL,RGEVNT,REP,DIC,DR,DIE,DA,DLAYGO
 S RGER=""
 D IN
 D PROCIN
 D GENACK
 Q
 ;
PROC ;processing entry point
 N HLA,RGADT,PV1,DIC,ARRAY,RGEVNT,RGLOCAL,REP,ICN,RGSITE
 S RGEVNT=HL("ETN")
 I $G(HL("MID"))'="" S RGADT=HL("MID")
 I $G(HL("MID"))="" S RGADT=999
 D IN
 S ICN=$G(ARRAY("ICN"))
 I +$G(ICN)<1 Q  ;quit if no ICN
 I $E($G(ICN),1,3)=$P($$SITE^VASITE,"^",3) Q  ;quit if ICN is a local
 S ZTSAVE("DFN")="",ZTSAVE("RGEVNT")="",ZTSAVE("HLA(""HLS"",")="",ZTRTN="SEND^RGADTPC",ZTDESC="Sending HL7 Patient Update...",ZTIO="RG QUEUE",ZTDTH=$H D ^%ZTLOAD
 K ZTSAVE,ZTRTN,ZTDESC,ZTIO,ZTDTH
 Q
 ;
IN ;Process in the ADT A04/A08 (routing logic)
 N RGI,MSG,RG,SG,DFN,EVN,SITE,RGC,RGJ,DIC,PV1,PID,COMP,ENT,EN,THLA,LAB,RAD,PHARM,TMP,SIG,OBXDONE,OLD,NAMECOMP,DODF,DODD,DODNP,DODDISDT,DODOPT,SECLVL,SEXOR,SEXORD,PRON,PROND
 S ENT=1,REP=$E(HL("ECH"),2),COMP=$E(HL("ECH"),1)
 ;set local flag to indicate the processing of an outbound for reformatting
 I $P($G(HL("SAF")),COMP)=$P($$SITE^VASITE,"^",3) S RGLOCAL=1
 I $P($G(HL("SAF")),COMP)'=$P($$SITE^VASITE,"^",3) S RGLOCAL=0
 S RGC=$E($G(HL("ECH")),1)
 F RGI=1:1 X HLNEXT Q:HLQUIT'>0  S MSG=HLNODE,SG=$E(HLNODE,1,3) D
 .S RGJ=0 F  S RGJ=$O(HLNODE(RGJ)) Q:'RGJ  S MSG(RGJ)=HLNODE(RGJ)
 .D:SG?2A1(1A,1N) PICK
 .K MSG
 ;if message MSH sending facility matches the PID assigning authority update
 S ENT=0,EN=1,OBXDONE=0 F  S ENT=$O(THLA("HLS",ENT)) Q:ENT=""  D
 .;**61, MVI_3714 (ckn) - No need to send OBX segment previously built in 2.3v to MPI - Only add new OBX for 2.4v
 .I $E($G(THLA("HLS",ENT)),1,3)="OBX" D  Q
 ..I OBXDONE Q  ;**61 - MVI_3714 (ckn) - OBX was added in previous loop
 ..S RAD=$$RADE I RAD'="" S HLA("HLS",EN)=RAD,EN=EN+1
 ..S LAB=$$LABE I LAB'="" S HLA("HLS",EN)=LAB,EN=EN+1
 ..S PHARM=$$PHARA I PHARM'="" S HLA("HLS",EN)=PHARM,EN=EN+1
 ..S OLD=$$OLD I OLD'="" S HLA("HLS",EN)=OLD,EN=EN+1 ;**59,MVI_914: Pass OLDER RECORD in OBX if flagged as such
 ..S SIG=$$SIG^VAFCSB(DFN) I SIG'="" S HLA("HLS",EN)=SIG,EN=EN+1 ;**61,MVI_3714: Add Self Identified Gender in OBX
 ..S NAMECOMP=$$NAMEOBX^VAFCSB(DFN) I NAMECOMP'="" S HLA("HLS",EN)=NAMECOMP,EN=EN+1 ;**61,MVI_3976 (mko): Add Name Components in OBX
 ..S DODF=$$DODF^VAFCSB(DFN) I $G(DODF)'="" S HLA("HLS",EN)=DODF,EN=EN+1 ;**62 MVI_4899 (ckn): Add DOD fields in OBX
 ..;**65 Story 323009 (ckn) : OBX for additional DOD fields
 ..S DODD=$$DODD^VAFCSB(DFN) I $G(DODD)'="" S HLA("HLS",EN)=DODD,EN=EN+1  ;Date Of Death Documents
 ..S DODOPT=$$DODOPT^VAFCSB(DFN) I $G(DODOPT)'="" S HLA("HLS",EN)=DODOPT,EN=EN+1  ;Date Of Death Option Used
 ..;**69 Story 603856 (ckn) - No more OBX for Notification Provider from VistA
 ..;S DODNP=$$DODNTPRV^VAFCSB(DFN) I $G(DODNP)'="" S HLA("HLS",EN)=DODNP,EN=EN+1  ;Date Of Death Notify Provider
 ..S SECLVL=$$SECLOG^VAFCSB(DFN) I $G(SECLVL)'="" S HLA("HLS",EN)=SECLVL,EN=EN+1 ;**70 - Story 783361 (ckn) - Build OBX for Security Level
 ..D SEXOR^VAFCSB(DFN,.SEXOR) I $O(SEXOR(0)) N CNT S CNT=0 F  S CNT=$O(SEXOR(CNT)) Q:'CNT  S HLA("HLS",EN)=SEXOR(CNT),EN=EN+1 ;**76, VAMPI-11114 (dri)
 ..D SEXORD^VAFCSB(DFN,.SEXORD) I $O(SEXORD(0)) D  S EN=EN+1 ;**76, VAMPI-11114 (dri)
 ...N CNT,LVL
 ...S LVL=1,CNT=0 F  S CNT=$O(SEXORD(CNT)) Q:'CNT  D
 ....I CNT=1 S HLA("HLS",EN)=SEXORD(CNT)
 ....I CNT>1 S HLA("HLS",EN,LVL)=SEXORD(CNT),LVL=LVL+1
 ..D PRON^VAFCSB(DFN,.PRON) I $O(PRON(0)) N CNT S CNT=0 F  S CNT=$O(PRON(CNT)) Q:'CNT  S HLA("HLS",EN)=PRON(CNT),EN=EN+1 ;**76, VAMPI-11118 (dri)
 ..D PROND^VAFCSB(DFN,.PROND) I $O(PROND(0)) D  S EN=EN+1 ;**76, VAMPI-11118 (dri)
 ...N CNT,LVL
 ...S LVL=1,CNT=0 F  S CNT=$O(PROND(CNT)) Q:'CNT  D
 ....I CNT=1 S HLA("HLS",EN)=PROND(CNT)
 ....I CNT>1 S HLA("HLS",EN,LVL)=PROND(CNT),LVL=LVL+1
 ..S OBXDONE=1  ;**61 - MVI_3714 (ckn) - flag for all OBX added
 .S HLA("HLS",EN)=THLA("HLS",ENT),EN=EN+1
 .I $E($G(THLA("HLS",ENT)),1,3)="PID"!($E($G(THLA("HLS",ENT)),1,3)="ZEL") D
 ..;**47 handle if ZEL is over 245 as well
 ..I $O(THLA("HLS",ENT,""))'="" D
 ...S CNT="" F  S CNT=$O(THLA("HLS",ENT,CNT)) Q:CNT=""  S HLA("HLS",EN-1,CNT)=THLA("HLS",ENT,CNT)
 .I $E($G(THLA("HLS",ENT)),1,3)="PV1" I RGLOCAL S TMP=$$PV2B I TMP'="" S HLA("HLS",EN)=$$PV2B,EN=EN+1  ;**47
 .;**61 MVI_3714 (ckn) Add Self Identified Gender in OBX
 .;I $E($G(THLA("HLS",ENT)),1,3)="ZPD" I RGLOCAL D
 .;.S RAD=$$RADE I RAD'="" S HLA("HLS",EN)=RAD,EN=EN+1
 .;.S LAB=$$LABE I LAB'="" S HLA("HLS",EN)=LAB,EN=EN+1
 .;.S PHARM=$$PHARA I PHARM'="" S HLA("HLS",EN)=PHARM,EN=EN+1
 .;.S OLD=$$OLD I OLD'="" S HLA("HLS",EN)=OLD,EN=EN+1 ;**59,MVI_914: Pass OLDER RECORD in OBX if flagged as such
QUIT Q
 ;
ROUTE ;
 N RGERR
 I $G(RGEVNT)="" S RGEVNT=$G(HL("ETN"))
 N MPI S MPI=$$MPILINK^MPIFAPI() D
 .;**74 - Story - 1260465 (ckn) - Include 200M in HLL links for HAC
 .I $P($G(MPI),U)'=-1 S HLL("LINKS",1)="RG ADT-"_HL("ETN")_" 2.4 CLIENT^"_MPI_$S($P($$SITE^VASITE(),"^",3)=741:"^200M",1:"")
 .I $P($G(MPI),U)=-1 D
 ..N RGLOG,RGMTXT D START^RGHLLOG(HLMTIEN,"","") S RGMTXT="for DFN#"_$G(DFN)
 ..D EXC^RGHLLOG(224,"No MPI link identified"_RGMTXT,$G(DFN)) S RGERR=1
 ;**60 MVI_1837(rjh): to catch undefined dfn
 ;I $G(RGERR)'=1 S ^XTMP("RG"_HL("ETN")_"%"_DFN,0)=$$FMADD^XLFDT(DT,5)_"^"_DT_"^"_"RG"_HL("ETN")_" msg to MPI for DFN "_DFN S ^XTMP("RG"_HL("ETN")_"%"_DFN,"MPI",0)="A"
 I $G(RGERR)'=1,$D(^DPT(+$G(DFN),0)) D
 .S ^XTMP("RG"_HL("ETN")_"%"_DFN,0)=$$FMADD^XLFDT(DT,5)_"^"_DT_"^"_"RG"_HL("ETN")_" msg to MPI for DFN "_DFN
 .S ^XTMP("RG"_HL("ETN")_"%"_DFN,"MPI",0)="A"
 Q
 ;
RESP ;
 N RGER,RGSITE,ARRAY,MSH,RGLOCAL,RGEVNT,RGI,MSG,RG,SG,DFN,EVN,SITE,RGC,RGJ,DIC,PV1,PID
 D IN
 Q
 ;
PICK ;check routine for segment entry point
 I $T(@SG)]"" D @SG
 I $T(@SG)="" Q
 Q
 ;
MSA ;process the MSA segment
 N ARRAY,CNT,DFN,EXIT,HLCOMP,RGAA,RGERR,RGEVNT,RGMSG,RETURN,RGX,RGY,RGCODE
 I RGLOCAL S THLA("HLS",ENT)=MSG,ENT=ENT+1
 S RGAA=MSG,EXIT=0,RGCODE=$P(RGAA,HL("FS"),2),RGMSG=$P(RGAA,HL("FS"),3),RGERR=$P(RGAA,HL("FS"),4),RGMSG=$$MSG^HLCSUTL(RGMSG,"RETURN(1)") K RGMSG
 S CNT=1,RGX=0 F  S RGX=$O(RETURN(1,RGX)) Q:'RGX!(EXIT=1)  D
 .I RETURN(1,RGX)'="" D
 ..I $D(RGMSG) S RGMSG(CNT)=RETURN(1,RGX),CNT=CNT+1
 ..I '$D(RGMSG) S RGMSG=RETURN(1,RGX),RGY=RGX
 .I RETURN(1,RGX)="" D  S CNT=1 K RGMSG
 ..I $E(RETURN(1,RGY),1,3)="MSH" D MSH
 ..I $E(RETURN(1,RGY),1,3)="PID" D PIDP^RGADTP1(.RGMSG,.ARRAY,.HL) S EXIT=1
 S DFN=$G(ARRAY("DFN"))
 ;**45 Log Exception ONLY if AR is returned in MSA segment
 I RGCODE="AR" D
 .D START^RGHLLOG(HLMTIEN,"","")
 .D EXC^RGHLLOG(234,RGERR,DFN) ;**44
 .D STOP^RGHLLOG(0)
 K:$G(DFN)>0 ^XTMP("MPIF OLD RECORDS",DFN) ;**59,MVI_914: Delete the old record designation
 I $D(^XTMP("RG"_HL("ETN")_"%"_DFN,0)) K ^XTMP("RG"_HL("ETN")_"%"_DFN)
 Q
 ;
MSH ;
 S MSH=1
 I RGLOCAL S THLA("HLS",ENT)=MSG,ENT=ENT+1
 I 'RGLOCAL S RGC=$E(HL("ECH"),1)
 S RGSITE=$P($P(MSG,HL("FS"),4),RGC),RGEVNT=$P($P(MSG,HL("FS"),9),RGC,2)
 Q
 ;
PV2 ;processor of PV2 segment ;**47
 Q
 ;
PV2B() ;builder of PV2 segment ;**47
 N RET S RET=""
 I 'RGLOCAL Q RET
 N X S X="VAFCSB" X ^%ZOSF("TEST") Q:'$T RET
 ;**45 VAFCSB coming in with DG*5.3*707
 Q $$PV2^VAFCSB
 ;
PHARA() ;build obx to show active prescriptions
 N RET S RET=""
 I 'RGLOCAL Q RET
 I '$$PATCH^XPDUTL("PSS*1.0*101") Q RET
 N X S X="VAFCSB" X ^%ZOSF("TEST") Q:'$T RET
 ;**45 VAFCSB coming in with DG*5.3*707
 Q $$PHARA^VAFCSB
 ;
LABE() ;BUILD OBX FOR LAST LAB TEST DATE
 N RET S RET=""
 I 'RGLOCAL Q RET
 I '$$PATCH^XPDUTL("LR*5.2*295") Q RET
 N X S X="VAFCSB" X ^%ZOSF("TEST") Q:'$T RET
 ;**45 VAFCSB coming in with DG*5.3*707
 Q $$LABE^VAFCSB
 ;
RADE() ;BUILD OBX FOR LAST RADIOLOGY TEST DATE
 N RET S RET=""
 I 'RGLOCAL Q RET
 I '$$PATCH^XPDUTL("RA*5.0*76") Q RET
 N X S X="VAFCSB" X ^%ZOSF("TEST") Q:'$T RET
 ;**45 VAFCSB coming in with DG*5.3*707
 Q $$RADE^VAFCSB
 ;
EVN ;;
 N CNT,ERR S EVN=RGI
 I RGLOCAL S (EVN(1),THLA("HLS",ENT))=MSG,ENT=ENT+1
 I 'RGLOCAL D
 .S ARRAY("EVR")=$P(MSG,HL("FS"),2),ARRAY("DLT")=$$FMDATE^HLFNC($P(MSG,HL("FS"),3))
 .S ARRAY("EVNAME")=$$FMNAME^XLFNAME($P(MSG,HL("FS"),2),"",$E(HL("ECH"),1)),ARRAY("SENDING SITE")=$P(MSG,HL("FS"),8)
 Q
 ;
EVNP ;
 N EVNX
 I $G(DFN)'="" D BLDEVN^VAFCQRY(DFN,"1,2,4,5,6,7",.EVN,.HL,$G(HL("ETN")),.ERR) S CNT=0,EVNX=0 F  S EVNX=$O(EVN(EVNX)) Q:'EVNX  D
 .I CNT>0 S THLA("HLS",EVN,CNT)=EVN(EVNX),CNT=CNT+1
 .I CNT'>0 S THLA("HLS",EVN)=EVN(EVNX),CNT=CNT+1
 Q
 ;
PID ;;
 N CNT,PIDX
 I RGLOCAL D
 .N HLCOMP S HLCOMP=$E(HL("ECH"),1),THLA("HLS",ENT)=MSG,DFN=$P($P(MSG,HL("FS"),4),HLCOMP) ;**45 REMOVED +
 .D EVNP
 .D BLDPID^VAFCQRY(DFN,1,"ALL",.PID,.HL)
 .;get ICN value in the PID segment
 .S ARRAY("ICN")=+$P($P(PID(1),HL("FS"),4),HLCOMP)
 .S CNT=0,PIDX=0 F  S PIDX=$O(PID(PIDX)) Q:'PIDX  D
 ..I CNT>0 S THLA("HLS",ENT,CNT)=PID(PIDX),CNT=CNT+1
 ..I CNT'>0 S THLA("HLS",ENT)=PID(PIDX),CNT=CNT+1
 .S ENT=ENT+1
 I 'RGLOCAL D PIDP^RGADTP1(.MSG,.ARRAY,.HL)
 Q
 ;
PD1 ;SET PD1 SEQ 3 TO BE PREFERRED FACILITY INSTEAD OF CMOR PATCH **45
 N PD1
 I RGLOCAL D
 .;S PD1=$$PD1^VAFCSB
 .;I PD1'="" S THLA("HLS",ENT)=PD1,ENT=ENT+1
 I 'RGLOCAL S (ARRAY(991.03),ARRAY("CMOR"))=$P($P(MSG,HL("FS"),4),RGC) ;PUTTING BACK TO DO NEED FOR PATCH 40 ON MPI SIDE
 ;- NO LONGER DEALING WITH CMOR
 Q
 ;
PV1 ;;
 I RGLOCAL S THLA("HLS",ENT)=MSG,ENT=ENT+1
 Q
 ;
OBX ;;
 N COMP,SUBCOMP
 S COMP=$E(HL("ECH"),1),SUBCOMP=$E(HL("ECH"),4)
 ;
 I RGLOCAL D
 .S THLA("HLS",ENT)=MSG
 .N CNT,MSGX S CNT=1,MSGX=0 F  S MSGX=$O(MSG(MSGX)) Q:'MSGX  S THLA("HLS",ENT,CNT)=MSG(MSGX),CNT=CNT+1
 .S ENT=ENT+1
 ;
 I 'RGLOCAL D
 .I $$FREE^RGRSPARS($P($P(MSG,HL("FS"),4),COMP,2))="SECURITY LEVEL" D
 ..S ARRAY("SENSITIVITY")=$$SENSTIVE^RGRSPARS($P(MSG,HL("FS"),6),COMP),ARRAY("SENSITIVITY DATE")=$$FREE^RGRSPARS($$FMDATE^HLFNC($P(MSG,HL("FS"),15)))
 ..S ARRAY("SENSITIVITY USER")=$$FREE^RGRSPARS($P($P(MSG,HL("FS"),17),COMP,2))_","_$$FREE^RGRSPARS($P($P(MSG,HL("FS"),17),COMP,3))
 .;
 .;**45 Get SSN VERIFICATION STATUS out of OBX if message is from the MPI
 .;I $P(HL("SFN"),COMP)="200M" I $P($P(MSG,HL("FS"),4),COMP)="SSN VERIFICATION STATUS" N SSNV S SSNV=$P($P(MSG,HL("FS"),6),COMP,2),ARRAY(.0907)=$S(SSNV="VERIFIED":4,SSNV="INVALID":2,1:"@")
 .;**47 use SSN Verification status code and not words since they have changed since this code was first written
 .;only update values to valid or invalid other statuses aren't stored in VistA
 .I $P(HL("SFN"),COMP)="200M",($P($P(MSG,HL("FS"),4),COMP)="SSN VERIFICATION STATUS") N SSNV S SSNV=$P($P(MSG,HL("FS"),6),COMP,1),ARRAY(.0907)=$S(SSNV=4:4,SSNV=2:2,1:"@")
 .;
 .;**63 Story 174247 (mko): Get Self-ID Gender
 .I $P($P(MSG,HL("FS"),4),COMP)="SELF ID GENDER" S ARRAY(.024)=$$FREE^RGRSPARS($P($P(MSG,HL("FS"),6),COMP))
 .;
 .;**65 Story 323009 (ckn) : parse OBX for additional DOD fields
 .I $P($P(MSG,HL("FS"),4),COMP)="DATE OF DEATH DATA" D
 ..N DODLEB,DODLUPD
 ..S ARRAY("DODSource")=$$FREE^RGRSPARS($P($P(MSG,HL("FS"),6),COMP)),ARRAY(.353)=ARRAY("DODSource")
 ..S DODLUPD=$$FMDATE^HLFNC($P(MSG,HL("FS"),15))
 ..S ARRAY("DODLastUpdated")=$$FREE^RGRSPARS(DODLUPD),ARRAY(.354)=ARRAY("DODLastUpdated")
 ..S DODLEB=$$FREE^RGRSPARS($P(MSG,HL("FS"),17))
 ..I DODLEB'="",(DODLEB'=HL("Q")) D
 ...S ARRAY("DODEnteredBy")=$$FMNAME^XLFNAME($P(DODLEB,COMP,2,4),"L",COMP),ARRAY(.352)=ARRAY("DODEnteredBy")
 ...S ARRAY("DODLastEditedBy")=$P(DODLEB,COMP)_COMP_$P(DODLEB,COMP,13)_COMP_$P($P(DODLEB,COMP,9),SUBCOMP)_COMP_$P($P(DODLEB,COMP,14),SUBCOMP,2),ARRAY(.355)=ARRAY("DODLastEditedBy")
 .;
 .;I $P($P(MSG,HL("FS"),4),COMP)="DATE OF DEATH DOCUMENTS" S ARRAY("DODDocType")=$$FREE^RGRSPARS($P($P(MSG,HL("FS"),6),COMP)),ARRAY(.357)=ARRAY("DODDocType")
 .;
 .;**68 - Story 500735 (ckn) : Parse OBX to set a flag if deletion of
 .;Date of Death occurred through TK OVR
 .I $P($P(MSG,HL("FS"),4),COMP)="TK OVERRIDE DOD" S ARRAY("TKOVRDOD")=$P($P(MSG,HL("FS"),6),COMP)
 .;
 .;**76, VAMPI-11114 (dri) - add sexual orientation and sexual orientation description
 .;**77, VAMPI-13755 (dri) - include status, date created, date last updated
 .I $P($P(MSG,HL("FS"),4),COMP)="Sexual Orientation" D
 ..S ARRAY("SexOr",$O(ARRAY("SexOr",""),-1)+1)=$$FREE^RGRSPARS($P($P(MSG,HL("FS"),6),COMP))_"^"_$P(MSG,HL("FS"),12)_"^"_$$FMDATE^HLFNC($P(MSG,HL("FS"),15))_"^"_$$FMDATE^HLFNC($P(MSG,HL("FS"),13))
 .I $P($P(MSG,HL("FS"),4),COMP)="Sexual Or Description" D
 ..S ARRAY("SexOrDes")=$P($P(MSG,HL("FS"),6),COMP,2) I ARRAY("SexOrDes")=HL("Q") S ARRAY("SexOrDes")="@" Q
 ..N MSGX S MSGX=0 F  S MSGX=$O(MSG(MSGX)) Q:'MSGX  S ARRAY("SexOrDes")=ARRAY("SexOrDes")_$P($P(MSG(MSGX),HL("FS"),1),COMP,1)
 .;
 .;**76, VAMPI-11118 (dri) - add pronoun and pronoun description
 .I $P($P(MSG,HL("FS"),4),COMP)="Pronoun" S ARRAY("Pronoun",$O(ARRAY("Pronoun",""),-1)+1)=$$FREE^RGRSPARS($P($P(MSG,HL("FS"),6),COMP))
 .I $P($P(MSG,HL("FS"),4),COMP)="Pronoun Description" D
 ..S ARRAY("PronounDes")=$P($P(MSG,HL("FS"),6),COMP,2) I ARRAY("PronounDes")=HL("Q") S ARRAY("PronounDes")="@" Q
 ..N MSGX S MSGX=0 F  S MSGX=$O(MSG(MSGX)) Q:'MSGX  S ARRAY("PronounDes")=ARRAY("PronounDes")_$P($P(MSG(MSGX),HL("FS"),1),COMP,1)
 Q
 ;
ZPD ;;
 I RGLOCAL S THLA("HLS",ENT)=$$EN1^VAFHLZPD(DFN,"1,17,21,34"),ENT=ENT+1 ;**45 to build new ZPD
 I 'RGLOCAL S ARRAY(.0906)=$P(MSG,HL("FS"),35) I ARRAY(.0906)=HL("Q") S ARRAY(.0906)="@" ;**45 Pull out pseudo ssn reason
 Q
 ;
ZSP ;;
 I RGLOCAL S THLA("HLS",ENT)=MSG,ENT=ENT+1
 I 'RGLOCAL S ARRAY(.301)=$$YESNO^RGRSPARS($P(MSG,HL("FS"),3)),ARRAY(.302)=$$FREE^RGRSPARS($P(MSG,HL("FS"),4)),ARRAY(.323)=$$POS^RGRSPARS($P(MSG,HL("FS"),5))
 Q
 ;
ZEL ;;
 I RGLOCAL D
 .;**40 to rebuild ZEL segment
 .I '$D(DFN) S THLA("HLS",ENT)=MSG,ENT=ENT+1 Q  ;don't know DFN pass back original ZEL segment
 .N VAFZEL D EN1^VAFHLZEL(DFN,"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22",2,.VAFZEL) ;build a complete ZEL segment
 .;need to take into account may be more than 1 array entry and that each entry could go over 245 so there would be another subscript
 .N CNT,ZELX S (CNT,ZELX)=0 F  S ZELX=$O(VAFZEL(ZELX)) Q:'ZELX  D
 ..I CNT>0 S THLA("HLS",ENT,CNT)=VAFZEL(ZELX),CNT=CNT+1
 ..I CNT'>0 S THLA("HLS",ENT)=VAFZEL(ZELX),ENT=ENT+1
 I 'RGLOCAL D
 . S ARRAY(.361)=$$ELIG^RGRSPARS($P(MSG,HL("FS"),3)),ARRAY(.3612)=$$FREE^RGRSPARS($P(MSG,HL("FS"),12))
 . S ARRAY(.3615)=$$FREE^RGRSPARS($P(MSG,HL("FS"),14)),ARRAY(391)=$$TYPE^RGRSPARS($P(MSG,HL("FS"),10)),ARRAY(1901)=$$VETERAN^RGRSPARS($P(MSG,HL("FS"),9))
 Q
 ;
ZCT ;;
 I RGLOCAL S THLA("HLS",ENT)=MSG,ENT=ENT+1
 I 'RGLOCAL S ARRAY(.211)=$$FREE^RGRSPARS($P(MSG,HL("FS"),4)),ARRAY(.219)=$$FREE^RGRSPARS($P(MSG,HL("FS"),7))
 Q
 ;
ZEM ;;
 I RGLOCAL S THLA("HLS",ENT)=MSG,ENT=ENT+1
 I 'RGLOCAL S ARRAY(.31115)=$$EMP^RGRSPARS($P(MSG,HL("FS"),4))
 Q
 ;
ZFF ;;
 I RGLOCAL S THLA("HLS",ENT)=MSG,ENT=ENT+1
 I 'RGLOCAL S ARRAY("FLD")=$P(MSG,HL("FS"),3)
 Q
 ;
PROCIN ;
 D PROCIN^RGADTP2(.ARRAY,.RGLOCAL,.RGER,.DFN,.HL)
 Q
 ;
GENACK ;
 N RGCNT,IEN,RG,ERRSEG
 I $G(ARRAY("DFN"))'>0 S RGER="-1^Unknown ICN#"_$G(ARRAY("ICN"))_" and SSN#"_$G(ARRAY(.09))
 ;**65 - Story 323009 - (ckn) : If DOD did not get updated due to
 ;imprecise date OR invalid value, create ERR segment
 E  I HL("ETN")="A31",RGSITE="200M" D
 . I $G(DODIMPF) S RGER="-1^IMPRECISE DOD - "_$$HLDATE^HLFNC($P(DODIMPF,"^",2))
 . S ERRSEG=$$NAMEERR^VAFCSB(ARRAY("DFN")) ;**61,MVI_3976 (mko): Get Name Components
 ;E  I HL("ETN")="A31",RGSITE="200M" S ERRSEG=$$NAMEERR^VAFCSB(ARRAY("DFN")) ;**61,MVI_3976 (mko): Get Name Components
 ;send mas parameter 'process mvi dod update?' in 'aa' segment ;**65 - STORY_339759 (dri)
 S RGCNT=1,HLA("HLA",RGCNT)="MSA"_HL("FS")_"AA"_HL("FS")_HL("MID")_HL("FS")_$S(+$G(RGER)<0:$P(RGER,"^",2,3),1:(+$$CHK^VAFCDODA_"-"_$$GET1^DID(43,1401,,"LABEL"))),RGCNT=RGCNT+1
 S:$G(ERRSEG)]"" HLA("HLA",RGCNT)=ERRSEG,RGCNT=RGCNT+1 ;**61,MVI_3976 (mko): Put name component in ERR segment
 S RGSITE=$$LKUP^XUAF4(RGSITE)
 ;**74 - Story - 1260465 (ckn) - Include 200M in HLL links for HAC
 D LINK^HLUTIL3(RGSITE,.RG) S IEN=$O(RG(0)) S HLL("LINKS",1)="^"_RG(IEN)_$S($P($$SITE^VASITE(),"^",3)=741:"^200M",1:"")
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.HLRESLTA,"",.HL)
 K HLA,DODIMPF
 Q
 ;
RSP ;
 Q
 ;
OLD() ; Return OBX segment to flag a record as "old"
 ;**59,MVI_914: New subroutine
 Q $S($D(^XTMP("MPIF OLD RECORDS",DFN))#2:"OBX"_HL("FS")_HL("FS")_"CE"_HL("FS")_"OLDER RECORD"_HL("FS")_HL("FS")_"Y",1:"")
 ;
