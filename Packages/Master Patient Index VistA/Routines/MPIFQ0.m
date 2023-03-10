MPIFQ0 ;ALB/RJS-QUERY HANDLER TOP LEVEL ; 10/28/20 8:38pm
 ;;1.0;MASTER PATIENT INDEX VISTA;**1,3,8,14,13,16,17,21,20,24,26,28,31,33,35,38,43,52,54,56,60,76**;30 Apr 99;Build 1
 ;
 ; Integration Agreements utilized:
 ;  EXC, START and STOP^RGHLLOG - #2796
 ;  FILE^VAFCTFU - #2988
 ;  $$EN^HLCSAC - #3471
 ;  NAME^VAFCPID2 - #3492
 ;
INTACTV ;Interactive standalone query
 N DFN,NAME1,MPIFLL
 K DTOUT,DUOUT,X,Y,DIC
 S MPIFRES="",MPIFINT="",DIC="^DPT(",DIC(0)="AEMQ" D ^DIC
 I ($D(DTOUT))!($D(DUOUT))!((+$G(Y))<0) W:'$D(MPIFRPC) !,"TRY AGAIN LATER" G END
 S DFN=+Y,HLP("ACKTIME")=300
 W:'$D(MPIFRPC) !
CIRNEXC ; Exception Entry Point
 I +$$GETICN^MPIF001(DFN)>0,$$IFLOCAL^MPIF001(DFN)'=1 W:'$D(MPIFRPC) !,"Patient already has an ICN" G END
 N LOCDATA ;Data Returned from GETDATA in ICN array
 D GETDATA("^DPT(",DFN,"LOCDATA",".01;.02;.03;.09;.301;391;1901")
 S LOCDATA(2,DFN,991.01)=$P($$MPINODE^MPIFAPI(DFN),"^"),TSSN=LOCDATA(2,DFN,.09)
 I $$IFLOCAL^MPIF001(DFN)=1 S MPIFLL=""
 I $G(LOCDATA(2,DFN,991.01))>0&('$D(MPIFLL)) W:'$D(MPIFRPC) !,"Patient already has an ICN" G END
 S HLP("ACKTIME")=300,MPIQRYNM="EXACT_MATCH_QUERY"
 ;MPIQRYNM="VTQ_PID_ICN_NO_LOAD" **43 CHANGING QUERY NAME
 G JUMP
VTQ G:$G(DFN)']"" END
 N LOCDATA ;Data Returned from GETDATA in ICN array
 D GETDATA("^DPT(",DFN,"LOCDATA",".01;.02;.03;.09;.301;391;1901")
 S LOCDATA(2,DFN,991.01)=$P($$MPINODE^MPIFAPI(DFN),"^"),TSSN=LOCDATA(2,DFN,.09)
 ;S MPIQRYNM="VTQ_PID_ICN_NO_LOAD" **43 CHANGING QUERY NAME
 S MPIQRYNM="EXACT_MATCH_QUERY"
 I $G(LOCDATA(2,DFN,991.01))>0 S MPIFRTN="ALREADY HAS ICN" G END ;If Pt already has ICN don't connect to MPI
JUMP N TIME,% D NOW^%DTC S TIME=%
 N HL,MPIINM,MPIOUT,MPIIN,MPIMCNT,MPICNT,MPICS,HEADER,TEST,SITE,MPIDC,SSN
 I $G(HLP("ACKTIME"))="" S HLP("ACKTIME")=30 ;If the HLP("ACKTIME") is not already set for the D/C
 S HL("ECH")="^~\&",HL("FS")="|"
 I '$D(MPIQRYNM) S MPIQRYNM="VTQ_PID_ICN"
 S MPIIN="",MPIMCNT=DFN,MPICNT=1,MPICS=$E(HL("ECH"),1)
 D VTQ1^MPIFVTQ(DFN,.MPIOUT,.HL,.MPIQRYNM) ; **33 remove field list to get all now
 I +MPIOUT(0)=-1 D  G EXIT
 .S ^TMP($J,"MPIFQ0-ERROR-LOG",DFN,TIME)=$G(MPIOUT(0)),MPIFRTN="CONTINUE"
 ;Create MSH
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",3),SITE=SITE\1,HEADER="MSH"_HL("FS")_HL("ECH")_HL("FS")_"MPI_LOAD"_HL("FS")_SITE_HL("FS")
 S HEADER=HEADER_"MPI-ICN"_HL("FS")_HL("FS")_HL("FS")_HL("FS")_"VQQ"_MPICS_"Q02"_HL("FS")_MPIMCNT_"-"_MPICNT_HL("FS") ;**38 changed VTQ to VQQ
 S MPIOUT(1)=HEADER K MPIOUT(0)
 I '$D(MPIFS) W:'$D(MPIFRPC) !!,"Attempting to connect to the Master Patient Index in Austin...",!,"If no SSN or inexact DOB or common name, this request",!,"may take some time, please be patient...",!
 S TEST=$$EN^HLCSAC("MPIVA DIR","MPIOUT","MPIDC")
 K HLP("ACKTIME") ;kill the HLP array set for the ack timeout
 I +TEST=-1 D  G EXIT
 .S ^TMP($J,"MPIFQ0-ERROR-LOG",DFN,TIME)=TEST
 .I '$D(MPIFS) W:'$D(MPIFRPC) !!,"Could not connect to MPI or Timed Out, assigning local ICN (if not already assigned)..."
 .D LOCAL^MPIFQ3(DFN) S MPIFRTN="ASSIGNING LOCAL"
 K ^TMP("MPIFVQQ",$J),^TMP("MPIFQ0",$J) ;array data is parsed into for display in LM
INIPARS ;
 N SEG,INDEX,SKIP,CHECK,AL,TTF2,TFLL,TF,TF2,MPIREP,MPICOMP
 S INDEX=0 K CHECK
LOOP1 ;
 ;process in ADT type messages
 N MPIX S MPIX=0 N REP,SG,MSG,MPIQUIT,MPINODE
 K TWODFN S MPIQUIT=0
 F MPIX=0:1 X "D LOOP2" D  K MPINODE,MSG Q:MPIQUIT'>0
 . I $D(MPINODE(1)) S SG=$E(MPINODE(1),1,3) S MSG(1)=MPINODE(1) D
 .. S MPIJ=1 F  S MPIJ=$O(MPINODE(MPIJ)) Q:'MPIJ  S MSG(MPIJ)=MPINODE(MPIJ)
 .. D:SG?2A1(1A,1N) @SG
DECIDE ;If no data in ^TMP that means the patient was not found in the MPI w/VTQ Query. So we go to A28 to add the patient to the MPI.
 N EXC,TEXT,EXACT,EXACT2
 I '$D(^TMP("MPIFVQQ",$J)) D  G EXIT
 .I '$D(MPIFS) W:'$D(MPIFRPC) !!,"Exact match for Patient was not found in the MPI..."
 .D A28^MPIFQ3(DFN) S MPIFRTN="DID A28"
 .;**43 log potential match exception if exist
 .;**52 removed all references to logging of Potential Matches because that will be done via a remote RPC in the Probabilistic Search flow on the MPI
 ;If INDEX=1 it means we got 1 match check SSN see if definitely same pt
 I (INDEX=1) D  G EXIT
 .;**43 Removed &(TSSN=SSN) from line above as there will only be an exact match returned now
 .N CCMOR,ICN,DATA,TICN,SNM,SNM2,IEN
 .S DATA=^TMP("MPIFVQQ",$J,INDEX,"DATA"),CMOR=$P(DATA,"^",5),ICN=$P(DATA,"^",6),IEN=$$IEN^XUAF4(CMOR)
 .D START^RGHLLOG(0)
 .S TICN=$$GETDFN^MPIF001(+ICN)
 .I TICN>0,DFN'=TICN D
 ..; call the new DUPLICATE RECORD MERGE ADD API (see section 3.2.1.2)
 ..N XDRSLT,XDRLST,XDRFL
 ..S XDRFL=2,XDRLST(1)=TICN_"^"_DFN
 ..D ADD^XDRDADDS(.XDRSLT,XDRFL,.XDRLST) S TWODFN=1
 ..;D TWODFNS^MPIF002(TICN,DFN,ICN) S TWODFN=1
 ..;I '$D(MPIFS) W:'$D(MPIFRPC) !!,"Exception logged, another patient has the ICN returned already, requesting new ICN for this patient..."
 ..D A28^MPIFQ3(DFN),STOP^RGHLLOG(0) S MPIFRTN="Did A28" Q
 .;I TICN>0&(DFN'=TICN)
 .; CHECK IF NAME IS SAME - IF NOT POTENTIAL MATCH EXCEPTION
 .; **43 remove checks here as only exact match will be returned from the MPI
 .;S SNM=LOCDATA(2,DFN,.01) D NAME^VAFCPID2(DFN,.SNM,0) ;reformat name to DG 149 standard
 .;S SNM2=$P(DATA,"^") D NAME^VAFCPID2(0,.SNM2,0) S $P(DATA,"^")=SNM2
 .;I $P(SNM,",")=$P(SNM2,",")&($P($P(SNM2,",",2)," ")=$P($P(SNM,",",2)," ")) D
 .; ^first and last match - check for middle name vs middle initial
 .;N SNMN,SNMN2
 .;S SNMN=$P($P(SNM,",",2)," ",2),SNMN2=$P($P(SNM2,",",2)," ",2)
 .;I $L(SNMN)>1&($L(SNMN2)=1),$E(SNMN,1)=SNMN2 S EXACT=1
 .;I $L(SNMN2)>1&($L(SNMN)=1),$E(SNMN2,1)=SNMN S EXACT=1
 .;I $P($G(^DPT(DFN,0)),"^",2)'=$P(DATA,"^",11) S EXC=209,TEXT="Gender fields don't match between site and MPI for DFN "_DFN S EXACT2=1
 .;I SNM2'=SNM&('$D(EXACT))!($D(EXACT2)) D  Q
 .;I '$D(EXC) S EXC=214,TEXT="Name fields don't match between site and MPI for DFN "_DFN
 .;I $D(MPIFINT) D START^MPIFQ1(INDEX) Q
 .;I '$D(MPIFINT) D LOC2^MPIFQ3(DFN) Q
 .I '$D(MPIFS)&('$D(TWODFN)) W:'$D(MPIFRPC) !!,"Found Patient "_$G(LOCDATA(2,DFN,.01))_" on MPI",!,"  Updating ICN to "_+ICN_"  - just a minute..."
 .D STOP^RGHLLOG(0),UPDATE(DFN,ICN,CMOR) S MPIFRTN="GOT 1 HIT FROM MPI"
 ;I '$D(MPIFINT) D  G EXIT
 ;. came in via PIMS options to d/c with MPI
 ;.I '$D(MPIFS) W:'$D(MPIFRPC) !!,"Potential Matches Found, Assigning Local ICN..."
 ;.I '$D(EXC) S EXC=218,TEXT="Potential matches found for patient DFN= "_DFN_" Use Single Patient Initialization to MPI option to manually process."
 ;.D START^RGHLLOG(0),EXC^RGHLLOG(EXC,TEXT,DFN),STOP^RGHLLOG(0)
 ;.D LOCAL^MPIFQ3(DFN) S MPIFRTN="ASSIGNING LOCAL"
 ;D START^MPIFQ1(INDEX) G END
EXIT I $D(MPIFINT) K MPIFINT,MPIFRES,MPIQRYNM,TSSN,TWODFN
 K VALMCNT,VALMLST,CCMOR,FICN H 3 W:'$D(MPIFRPC) !!
END K ^TMP("MPIFVQQ",$J),^TMP("MPIFQ0",$J) Q
 ;
UPDATE(DFN,ICN,CMOR) ;
 N TICN,CHKSUM,SETICN,SETLOC,CHANGE,RGLOG,LOCAL,TMP
 S CHKSUM=$P(ICN,"V",2),ICN=$P(ICN,"V",1),TICN=$$GETDFN^MPIF001(+ICN)
 I TICN>0,TICN'=DFN,'$D(TWODFN) D TWODFNS^MPIF002(TICN,DFN,ICN) Q
 S SETICN=$$SETICN^MPIF001(DFN,ICN,CHKSUM)
 I +SETICN'>0 S ^TMP($J,"MPIFQ0-ERROR-LOG",DFN,TIME)="COULD NOT SET ICN IN MPIFQ0" Q
 S SETLOC=1,LOCAL="N"
 I $E(ICN,1,3)=$P($$SITE^VASITE(),"^",3) S LOCAL="Y"
 I $G(LOCAL)="Y" S SETLOC=$$SETLOC^MPIF001(DFN,1)
 I $G(LOCAL)'="Y" S SETLOC=$$SETLOC^MPIF001(DFN,0)
 I +SETLOC'>0 S ^TMP($J,"MPIFQ0-ERROR-LOG",DFN,TIME)="COULD NOT SETLOC IN MPIFQ0" Q
 ;**60 (elz) MVI_793 set the Full ICN field
 ;**76 VAMPI-799 (ckn) - Below Full ICN api is now being called by SETICN^MPIF001
 ;S TMP=$$SETFICN^MPIF001(DFN,ICN_"V"_CHKSUM)
 N CMOR1 S CMOR1=$$LKUP^XUAF4(CMOR)
 I CMOR1'="" S CHANGE=$$CHANGE^MPIF001(DFN,CMOR1)
 I CMOR1="" S CHANGE=-1
 I $G(LOCAL)="Y" S CHANGE=$$CHANGE^MPIF001(DFN,$P($$SITE^VASITE,"^"))
 ;**56 - MVI_1727 (ckn) - Don't quit after logging an error as we still want to update TFs and send A24 to MPI.
 I +CHANGE'>0 S ^TMP($J,"MPIFQ0-ERROR-LOG",DFN,TIME)="COULD NOT SET CMOR IN MPIFQ0" ;Q - commented out quit
 Q:$G(LOCAL)="Y"
 N RESLT S RESLT=$$A24^MPIFA24B(DFN)
 I +RESLT<0 D EXC^RGHLLOG(208,"Problem building A24 (ADD TF) for DFN= "_DFN,DFN)
 ; Added for patch 31, create treating facility list
 I $D(^TMP("MPIFVQQ",$J,INDEX,"TF")) D
 . N MPINTFI,MPINTF,TFSTRG,TFIEN,MPIFMDT
 . S MPINTFI=0
 . F  S MPINTFI=$O(^TMP("MPIFVQQ",$J,INDEX,"TF",MPINTFI)) Q:'MPINTFI  D
 .. S MPINTF=^TMP("MPIFVQQ",$J,INDEX,"TF",MPINTFI)
 .. S TFIEN=$$IEN^XUAF4($P(MPINTF,"^",1))
 .. S MPIFMDT=$$HL7TFM^XLFDT($P(MPINTF,"^",2)) I MPIFMDT<0 S MPIFMDT=""
 .. S TFSTRG=TFIEN_"^"_$G(MPIFMDT)_"^"_$P(MPINTF,"^",3)
 .. D FILE^VAFCTFU(DFN,TFSTRG,1)
 Q
GETDATA(DIC,DA,MPIFAR,DR,EI) ;
 ;This function returns the values stored in the fields via FM call DIQ1
 ;DIC=file reference, DA=IEN in file, ARRAY=array for the values to be stored in, DR=fields requested, EI=external/internal values
 N DIQ S DIQ=MPIFAR
 I $G(EI)]"" S DIQ(0)=EI
 D EN^DIQ1
 Q
LOOP2 ;
 N MPIDONE,MPII,MPIJ
 S MPII=0,MPIDONE=0
 F  S MPIQUIT=$O(MPIDC(MPIQUIT)) Q:'MPIQUIT  D  Q:MPIDONE
 . I MPIDC(MPIQUIT)="" S MPIDONE=1 Q
 . S MPII=MPII+1,MPINODE(MPII)=$G(MPIDC(MPIQUIT)) Q
 Q
MSH ;
 S MPIREP=$E(HL("ECH"),2),MPICOMP=$E(HL("ECH"),1)
 Q
MSA ;
 Q
RDF ;
 Q
QAK ;**43 added check for potential matches
 K MPIPOT S MPIPOT=0
 I MSG(1)["POTENTIAL MATCHES" S MPIPOT=1
 Q
RDT ;
 N NAME,ICN,BIRTHDAY,CMOR,IEN,SEG,HEREICN,STRING,LASTNAME,FRSTNAME,MIDDLE,SUFF,SEX
 S STRING="",INDEX=$G(INDEX)+1
 D RDT^MPIFSA3(.INDEX,.HL,.MSG)
 S SEG=^TMP("MPIFVQQ",$J,INDEX,"DATA")
 S FRSTNAME=$P(SEG,"^",7),LASTNAME=$P(SEG,"^",2),MIDDLE=$P(SEG,"^",10),SUFF=$P(SEG,"^",15)
 S SSN=$P(SEG,"^",3),NAME=LASTNAME_","_FRSTNAME
 I MIDDLE'="" S NAME=NAME_" "_MIDDLE
 I SUFF'="" S NAME=NAME_" "_SUFF
 S SEX=$P(SEG,"^",11)
 S ICN=$P(SEG,"^",6)
 S BIRTHDAY=$P(SEG,"^",4)
 S CMOR=$P(SEG,"^",5),IEN=$$IEN^XUAF4(CMOR)
 I IEN'="" S CMOR=$P($$NS^XUAF4(IEN),"^") ;**54 fix when CMOR not passed
 S HEREICN=$$HEREICN^MPIFQ3($P(ICN,"V",1))
 I HEREICN S STRING=$$SETSTR^VALM1("*",STRING,1,1),^TMP("MPIFVQQ",$J,INDEX,"INDICATOR")="*"_"^"_HEREICN
 S STRING=$$SETSTR^VALM1(INDEX,STRING,2,4),STRING=$$SETSTR^VALM1($E(NAME,1,23),STRING,6,23)
 S STRING=$$SETSTR^VALM1(SSN,STRING,30,9),STRING=$$SETSTR^VALM1(BIRTHDAY,STRING,41,10)
 S STRING=$$SETSTR^VALM1(CMOR,STRING,54,20)
 S ^TMP("MPIFVQQ",$J,INDEX,0)=STRING,^TMP("MPIFVQQ",$J,"IDX",INDEX,INDEX)=""
 Q
 Q
