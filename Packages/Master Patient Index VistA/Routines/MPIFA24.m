MPIFA24 ;BPOFO/CMC-A24 PROCESSING ROUTINE ; 5/4/20 10:58am
 ;;1.0;MASTER PATIENT INDEX VISTA;**22,24,27,31,25,41,39,48,52,59,75**;30 Apr 99;Build 1
 ;
 ; Integration Agreements Utilized:
 ;  START, EXC, STOP^RGHLLOG - #2796
 ;  BLDEVN, BLDPD1, BLDPID^VAFCQRY - #3630
 ;  ^DPT("AICN" - #2070
 ;  DELETETF^VAFCTFU, FILE^VAFCTFU - #2988
 ;
 ;PROCESS A24 RESULTING FROM A28 ADD TO MPI MESSAGE OR FROM A40 MERGE
A24 ;
 N MPII,MPIJ,ARRY,SEG,CNT,ERR,SITE,MSG,DFN,IEN,LIST,RARRY
 S (CNT,ERR,FIRST)=1
 F MPII=1:1 X HLNEXT Q:HLQUIT'>0  S MSG=HLNODE D
 .S MPIJ=0 F  S MPIJ=$O(HLNODE(MPIJ)) Q:'MPIJ  S MSG(MPIJ)=HLNODE(MPIJ)
 .S SEG=$E(HLNODE,1,3)
 .I SEG="MSH" D MSH(.ARRY,.MSG) Q
 .I SEG="EVN" D EVN(.ARRY,.MSG) Q
 .I SEG="PID" D PID(.ARRY,.MSG,FIRST) D:FIRST=1  S FIRST=2 Q
 ..;preserve the retained ICN values 991.01 and 991.02
 .. S RARRY(991.01)=ARRY(991.01),RARRY(991.02)=ARRY(991.02)
 .I SEG="PD1" D PD1(.ARRY,.MSG) Q
 ;
 ;restore the retained ICN values
 S ARRY(991.01)=RARRY(991.01),ARRY(991.02)=RARRY(991.02)
 ;UPDATE 991.01, 991.02, 991.03
 ;**41 first check for DFN, if this DFN location is here
 I $G(ARRY("DFN",2))'=""&($G(ARRY("DFNLOC"))=$P($$SITE^VASITE,"^",3)) S DFN=ARRY("DFN",2)
 ;**41 if dfn is not passed set DFN from ICN
 I $G(DFN)="" D
 . I $G(ARRY("ICN",2))'="" S DFN=$$GETDFN^MPIF001(ARRY("ICN",2))
 . I $G(ARRY("ICN",2))=""!(+$G(DFN)'>0) D
 .. I $G(ARRY("DFN",2))'="" S DFN=ARRY("DFN",2)
 .. I $G(ARRY("DFN",2))="" S DFN=ARRY("DFN",1)
 S ARRY(991.03)=$S(ARRY(991.03)="":"@",1:$$LKUP^XUAF4(ARRY(991.03))) ;**59 - MVI_2688 (dri)
 I +$G(DFN)'>0 S ERR="-1^Unknown Identifier(s) ICN#"_$G(ARRY("ICN",2))_" and DFN#"_$G(ARRY("DFN",2))
 I +$G(DFN)>0 S ERR=$$UPDATE^MPIFAPI(DFN,"ARRY",0) D
 .;remove ALL Treating Facilities except your sites and add the CMOR
 .D TFL^VAFCTFU1(.LIST,DFN) I $O(LIST(0)) D
 .. N LOC,MPINODE,LOCIEN,CMOR,MPIFX,ERROR
 .. S (CMOR,MPIFX)=0 F  S MPIFX=$O(LIST(MPIFX)) Q:'MPIFX  I $P(LIST(MPIFX),"^",5)="VAMC" D
 ... ;get MPI node
 ... S MPINODE=$$MPINODE^MPIFAPI(DFN),LOC=$P(LIST(MPIFX),"^"),LOCIEN=$$IEN^XUAF4(LOC)
 ... I LOC=$P($$SITE^VASITE,"^",3) Q  ;do not delete own site
 ... I LOCIEN=$P(MPINODE,"^",3) S CMOR=LOCIEN Q  ;do not delete CMOR site
 ... S ERROR=$$DELETETF^VAFCTFU($P(MPINODE,"^",1),LOCIEN)
 .. ;add CMOR site to TF list if it did not already exist
 .. I CMOR'=0 D FILE^VAFCTFU(DFN,CMOR,1)
 .; trigger A31 to MPI incase there have been edits since the ICN was created -- tasked off
 .; **39 DON'T TASK OFF A31 IF MOVING FROM ONE NATIONAL ICN TO A DIFFERENT NATIONAL ICN
 .I ARRY("ICN",1)=ARRY("ICN",2) D
 ..S ZTRTN="TA31^MPIFA31B",ZTDESC="A31 triggered from A24 for DFN "_DFN ;**39 added DFN to text
 ..S ZTSAVE("DFN")=DFN,ZTIO="",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,1,0)
 ..D ^%ZTLOAD
 .I ARRY("ICN",1)'=ARRY("ICN",2) D RESEX^MPIFDUP(DFN,2) ;**48
 .K ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTDTH,ZTREQ
 ;
 N AA S AA="AA"
 I $G(ERR)'>0,$P($G(ERR),"^",2)["is already in use for pt DFN" S AA="AE" ;**52 MPIC_1681/1753
 S HLA("HLA",1)="MSA"_HL("FS")_AA_HL("FS")_HL("MID")_HL("FS")_$S(+$G(ERR)'>0:$P(ERR,"^",2),1:"")
 S $P(HLA("HLA",1),HL("FS"),7)="ICN="_ARRY("ICN",1)
 ;**75 - Story - 1260465 (ckn) - Include 200M in HLL links for HAC
 D LINK^HLUTIL3(ARRY("SITE"),.LINK) S IEN=$O(LINK(0)),HLL("LINKS",1)="^"_LINK(IEN)_$S($P($$SITE^VASITE(),"^",3)=741:"^200M",1:"")
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.MPIFRSLT,"",.HL)
 K LINK,MPIFRSLT
 ;PATCH 25
 I ARRY("ICN",1)'=ARRY("ICN",2),ARRY("ICN",2)'="" D
 .; ^ checking if this is a result of a "merge" of ICNs from the MPI
 .; to trigger if this is station 200 the MERGE for the FHIE Framework
 .Q:$P($$SITE^VASITE,"^",3)'=200
 .N FHIE S FHIE=$$MERGE^OMGPIDMI(ARRY("ICN",2),ARRY("ICN",1))
 .;       ^^ THIS API IS ONLY AVAILABLE ON THE FHIE HOST SYSTEM
 .I +FHIE=-1 D START^RGHLLOG(),EXC^RGHLLOG(208,$P(FHIE,"^",2),DFN),STOP^RGHLLOG()
 Q
 ;
MSH(ARY,MSG) ;processing MSH fields
 N COMP
 S COMP=$E(HL("ECH"),1)
 S ARY("SITE")=$$LKUP^XUAF4($P($P(MSG,HL("FS"),4),COMP))
 Q
 ;
EVN(ARY,MSG) ;processing EVN fields
 S ARY("EVTR")=$P(MSG,HL("FS"),2) ;not currently used
 S ARY("DLT")=$$FMDATE^HLFNC($P(MSG,HL("FS"),3))
 Q
 ;
PID(ARY,MSG,FIRST) ;processing PID fields
 N REP,PID,COMP,SUBCOMP,MPIDFN,MPISSN,ICN
 S REP=$E(HL("ECH"),2),COMP=$E(HL("ECH"),1),SUBCOMP=$E(HL("ECH"),4)
 S MPISSN="",MPIDFN=""
 ;**41 replaced with line below D PIDPROC^MPIFA43(.ICN,.MPISSN,.MPIDFN,.PID)
 D PIDP^RGADTP1(.MSG,.ARY,.HL)
 I FIRST=1 S ARY(991.01)=+ARY("ICN"),ARY(991.02)=$P(ARY("ICN"),"V",2)
 S ARY("ICN",FIRST)=ARY("ICN")
 S ARY("SSN",FIRST)=ARY("SSN")
 S ARY("DFN",FIRST)=ARY("DFN")
 Q
 ;
PD1(ARY,MSG) ;processing PD1 fields
 N COMP
 S COMP=$E(HL("ECH"),1)
 S ARY(991.03)=$P($P(HLNODE,HL("FS"),4),COMP,3)
 Q
 ;
PROC ;
 N NXT,DFN
 F NXT=1:1 X HLNEXT Q:HLQUIT'>0  D
 .I $E(HLNODE,1,3)="MSA" S DFN=$P($P(HLNODE,HL("FS"),7),"=",2)
 .I $E(HLNODE,1,3)="MSA"&($P(HLNODE,HL("FS"),4)'="") D
 ..; ERROR RETURNED IN MSA - LOG EXCEPTION
 ..D START^RGHLLOG(HLMTIEN,"","")
 ..D EXC^RGHLLOG(208,$P(HLNODE,HL("FS"),4)_" for HL msg# "_HLMTIEN,DFN)
 ..D STOP^RGHLLOG(0)
 K ^XTMP("MPIFA24%"_DFN)
 Q
