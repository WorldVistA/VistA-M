MPIFDUP ;BIRM/CMC-RESOLVE DUP ACTION ;DEC 2, 2005
 ;;1.0; MASTER PATIENT INDEX VISTA ;**43,46,48,53**;30 Apr 99;Build 1
 ;
POT ;EXCEPTION HANDLER CALLS HERE ;**53 MPIC_1853 The POT module is obsolete and is no longer being called.
 ;Potential Match on MPI, Query MPI, resolve duplicate if needed. **43 Added this entry point
 ; Only available when Exception Being Reviewed is Potential Match
 ;N PELV,PTEN
 ;S PTEN=$P(DATA,"^",10)
 ;I '$D(^RGHL7(991.1,"ADFN",218,DFN)) W !,"Potential Match Review Option is Only Available for Potential Match Exceptions" H 5 S VALMBCK="R" Q
 ;I $D(^RGHL7(991.1,"ADFN",218,DFN,PTEN)) S SUB=$O(^RGHL7(991.1,"ADFN",218,DFN,PTEN,"")) I $P($G(^RGHL7(991.1,PTEN,SUB,1,0)),"^",5)=1 W !,"Potential Match Review is Only Available for Exceptions still pending." H 5 S VALMBCK="R" Q
 ;S PTEN=$P(DATA,"^",10) ;IEN IN 991.1
 ;S PELV=$P(DATA,"^",11) ;IEN IN 991.12
 ;I $P($G(^RGHL7(991.1,PTEN,1,PELV,0)),"^",3)'=218 S VALMSG="Action is ONLY for POTENTIAL MATCH exceptions!",VALMBCK="R" Q
 ; ^**46 changed check to ensure exception is Potential Match exception
 ;I $E($$GETICN^MPIF001(DFN),1,3)=$P($$SITE^VASITE,"^",3) W !,"Messaging outstanding please try again in a few minutes." H 5 Q
 ;S VALMBCK="",MPIFRES="",MPIFINT=""
 ;D FULL^VALM1
 ;D EXC
 ;D PAUSE^VALM1
 ;K MPIFRES,MPIFINT
 ;N X,Y,DIR,DIE,DA,DR,IEN,IEN2,PROCDT,%,X,%I,%H
 ;I '$D(PROCESS) D
 ;.S DIR("A")="Do you want to mark this exception as processed? ",DIR(0)="YA",DIR("B")="NO" D ^DIR K DIR(0),DIR("A")
 ;.I Y S PROCESS=1 K X,Y
 ;I $D(PROCESS) D
 ;.;**48 CAPTURE DATE/TIME AND WHO MARKED AS PROCESSED
 ;.D NOW^%DTC S PROCDT=%
 ;.S IEN="",IEN2="",IEN=$P(DATA,"^",10),IEN2=$P(DATA,"^",11)
 ;.L +^RGHL7(991.1,IEN):10
 ;.S DA(1)=IEN,DA=IEN2,DR="6///"_1_";7///"_PROCDT_";8///"_$G(DUZ),DIE="^RGHL7(991.1,"_DA(1)_",1," D ^DIE K DIE,DA,DR
 ;.L -^RGHL7(991.1,IEN)
 ;.S $P(DATA,"^",9)=1
 ;K PROCESS
 Q
EXC ; Exception Entry Point
 N LOCDATA ;Data Returned from GETDATA in ICN array
 D GETDATA("^DPT(",DFN,"LOCDATA",".01;.02;.03;.09;.301;391;1901")
 S LOCDATA(2,DFN,991.01)=$P($$MPINODE^MPIFAPI(DFN),"^"),TSSN=LOCDATA(2,DFN,.09)
 S HLP("ACKTIME")=300,MPIQRYNM="POTENTIAL_DUP_RES"
 N TIME,% D NOW^%DTC S TIME=%
 N HL,MPIINM,MPIOUT,MPIIN,MPIMCNT,MPICNT,MPICS,HEADER,TEST,SITE,MPIDC,SSN
 S HL("ECH")="^~\&",HL("FS")="|"
 S MPIIN="",MPIMCNT=DFN,MPICNT=1,MPICS=$E(HL("ECH"),1),MPIFRES=1
 D VTQ1^MPIFVTQ(DFN,.MPIOUT,.HL,.MPIQRYNM)
 I +MPIOUT(0)=-1 D  G EXIT
 .S ^TMP($J,"MPIFQ0-ERROR-LOG",DFN,TIME)=$G(MPIOUT(0)),MPIFRTN="CONTINUE"
 ;Create MSH
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",3),SITE=SITE\1,HEADER="MSH"_HL("FS")_HL("ECH")_HL("FS")_"MPI_LOAD"_HL("FS")_SITE_HL("FS")
 S HEADER=HEADER_"MPI-ICN"_HL("FS")_HL("FS")_HL("FS")_HL("FS")_"VQQ"_MPICS_"Q02"_HL("FS")_MPIMCNT_"-"_MPICNT_HL("FS") ;**38 changed VTQ to VQQ
 S MPIOUT(1)=HEADER K MPIOUT(0)
 W !!,"Attempting to connect to the Master Patient Index in Austin...",!,"If no SSN or inexact DOB or common name, this request",!,"may take some time, please be patient...",!
 S TEST=$$EN^HLCSAC("MPIVA DIR","MPIOUT","MPIDC")
 K HLP("ACKTIME") ;kill the HLP array set for the ack timeout
 I +TEST=-1 D  G EXIT
 .S ^TMP($J,"MPIFQ0-ERROR-LOG",DFN,TIME)=TEST
 .I '$D(MPIFS) W:'$D(MPIFRPC) !!,"Could not connect to MPI or Timed Out.  Try again later."
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
 N EXC,TEXT,EXACT,EXACT2,DATA,NODE2,ICN,CHKSUM,MORE,COMMON
 I '$D(^TMP("MPIFVQQ",$J)) W !,"No Potential Matches Found.",!!,"Exception has been marked automatically as processed." S PROCESS=1 G EXIT
 I INDEX=1 D
 .;need to check if exact match was returned.
 .S DATA=^TMP("MPIFVQQ",$J,INDEX,"DATA")
 .S NODE2=$G(^TMP("MPIFVQQ",$J,INDEX,"INDICATOR"))
 .S DATA(.01)=$P(DATA,"^",1) I $E(DATA(.01),$L(DATA(.01)))=" " S DATA(.01)=$E(DATA(.01),1,$L(DATA(.01))-1) ;NAME
 .S DATA(.03)=$P(DATA,"^",4),DATA(.09)=$P(DATA,"^",3),DATA(.02)=$P(DATA,"^",11) ;DOB, SSN, SEX
 .S ICN=$P(DATA,"^",6),CHKSUM=$P(ICN,"V",2),ICN=$P(ICN,"V",1),DATA(991.01)=ICN,DATA(991.02)=CHKSUM,DATA(991.03)=$$LKUP^XUAF4($P(DATA,"^",5))
 .Q:NODE2["*"
 .;^ ICN is already known at this site
 .;check if this patient has another VISTA site now OR tfs in common
 .S (MORE,COMMON)=0
 .D COMPARE^MPIF002(DFN,INDEX,.COMMON,.MORE)
 .Q:COMMON!(MORE)
 .; check that now have an exact match returned
 .N MPIFD,SSN,NAME,SEX,NAME3,BIR K COMMON,MORE
 .D GETDATA^MPIFQ0("^DPT(",DFN,"MPIFD",".01;.09;.02;.03","EI")
 .S SSN=$G(MPIFD(2,DFN,.09,"E")),NAME=$G(MPIFD(2,DFN,.01,"E")),SEX=$G(MPIFD(2,DFN,.02,"I"))
 .S BIR=$G(MPIFD(2,DFN,.03,"I")) I BIR]"" S BIR=$TR($$FMTE^XLFDT(BIR,"5D"),"/","-")
 .; if dob doesn't match -- not allowed to update ICN automatically
 .Q:DATA(.03)'=BIR
 .; if sex doesn't match -- not allowed to update ICN automatically
 .Q:DATA(.02)'=SEX
 .;if dob doesn't match -- not allowed to update ICN automatically
 .I SSN["P" S SSN=""
 .Q:DATA(.09)'=SSN
 .D NAME^VAFCPID2(0,.NAME,0) ;reformat name into DG 149 format
 .S NAME3=DATA(.01) D NAME^VAFCPID2(0,.NAME3,0) S DATA(.01)=NAME3 ;reformat name into DG 149 format
 .; check if Last, First MATCH if so is it a middle name vs middle initial
 .I $P(DATA(.01),",")=$P(NAME,",")&($P($P(NAME,",",2)," ")=$P($P(DATA(.01),",",2)," ")) D
 ..N MPIMID,NMMN S MPIMID=$P($P(DATA(.01),",",2)," ",2)
 ..S NMMN=$P($P(NAME,",",2)," ",2)
 ..I $L(NMMN)>1&($L(MPIMID)=1),($E(NMMN,1)=MPIMID) S EXACT=1
 ..I $L(MPIMID)>1&($L(NMMN)=1),($E(MPIMID,1)=NMMN) S EXACT=1
 .I DATA(.01)=NAME!($D(EXACT)) K DATA(.09),DATA(.01),DATA(.03) D  Q
 ..N PID2,ERR
 ..D INIT^HLFNC2("MPIF ADT-A24 SERVER",.HL)
 ..D BLDPID^VAFCQRY(DFN,2,"ALL",.PID2,.HL,.ERR)
 ..;**48 want to resolve an reject exceptions for "current" ICN
 ..D RESEX(DFN)
 ..D EDIT^MPIFQED(DFN,"DATA"),MSG3^MPIFQ3,PROMPT^MPIFQ3
 ..S RESLT=$$A24^MPIFA24B(DFN,.PID2) ;send a24 link icns
 ..S PROCESS=1
 I $G(PROCESS)=1 G END
 D START^MPIFD1(INDEX) G END
EXIT I $D(MPIFINT) K MPIFINT,MPIFRES,MPIQRYNM,TSSN,TWODFN,SDFN
 K VALMCNT,VALMLST,CCMOR,FICN H 3 W:'$D(MPIFRPC) !!
END K ^TMP("MPIFVQQ",$J),^TMP("MPIFQ0",$J) Q
 ;
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
 S SDFN=$P(MSG(1),HL("FS"),2)
 Q
RDT ;
 N NAME,ICN,BIRTHDAY,CMOR,IEN,SEG,HEREICN,STRING,LASTNAME,FRSTNAME,MIDDLE,SUFF,SEX,THISGUY
 S STRING="",INDEX=$G(INDEX)+1
 D RDT^MPIFSA3(.INDEX,.HL,.MSG)
 S SEG=^TMP("MPIFVQQ",$J,INDEX,"DATA")
 S FRSTNAME=$P(SEG,"^",7),LASTNAME=$P(SEG,"^",2),MIDDLE=$P(SEG,"^",10),SUFF=$P(SEG,"^",15)
 S SSN=$P(SEG,"^",3),NAME=LASTNAME_","_FRSTNAME
 I MIDDLE'="" S NAME=NAME_" "_MIDDLE
 I SUFF'="" S NAME=NAME_" "_SUFF
 S SEX=$P(SEG,"^",11)
 S ICN=$P(SEG,"^",6)
 S THISGUY=$$GETDFN^MPIF001(+ICN) I THISGUY=DFN Q
 S BIRTHDAY=$P(SEG,"^",4)
 S CMOR=$P(SEG,"^",5),IEN=$$IEN^XUAF4(CMOR)
 S CMOR=$P($$NS^XUAF4(IEN),"^")
 S HEREICN=$$HEREICN^MPIFQ3($P(ICN,"V",1))
 I HEREICN S STRING=$$SETSTR^VALM1("*",STRING,1,1),^TMP("MPIFVQQ",$J,INDEX,"INDICATOR")="*"_"^"_HEREICN
 S STRING=$$SETSTR^VALM1(INDEX,STRING,2,4),STRING=$$SETSTR^VALM1($E(NAME,1,23),STRING,6,23)
 S STRING=$$SETSTR^VALM1(SSN,STRING,30,9),STRING=$$SETSTR^VALM1(BIRTHDAY,STRING,41,10)
 S STRING=$$SETSTR^VALM1(CMOR,STRING,54,20)
 S ^TMP("MPIFVQQ",$J,INDEX,0)=STRING,^TMP("MPIFVQQ",$J,"IDX",INDEX,INDEX)=""
 Q
RESEX(DFN,POT) ;look for any pv reject (234) exceptions and resolve them for this DFN
 ;IF POT IS SET TO 2 LOOK FOR ANY POTENTIAL MATCH (218) EXCEPTIONS AND RESOLVE THEM FOR THIS DFN
 ;**48 CREATED THIS API
 N IEN,DA,DR,PROCDT,DIE,IEN2
 S IEN=0
 F  S IEN=$O(^RGHL7(991.1,"ADFN",234,DFN,IEN)) Q:IEN=""  D
 .S IEN2=$O(^RGHL7(991.1,"ADFN",234,DFN,IEN,""))
 .Q:$P(^RGHL7(991.1,IEN,1,IEN2,0),"^",5)=1  ;**ALREADY MARKED AS PROCESSED
 .D NOW^%DTC S PROCDT=%
 .L +^RGHL7(991.1,IEN):10
 .S DA(1)=IEN,DA=IEN2,DR="6///"_1_";7///"_PROCDT_";8///"_$G(DUZ),DIE="^RGHL7(991.1,"_DA(1)_",1," D ^DIE K DIE,DA,DR
 .L -^RGHL7(991.1,IEN)
 ;
 ;I $G(POT)=2 D  ;**53 MPIC_1853 Remove 218 references
 ;.S IEN=0
 ;.F  S IEN=$O(^RGHL7(991.1,"ADFN",218,DFN,IEN)) Q:IEN=""  D
 ;..S IEN2=$O(^RGHL7(991.1,"ADFN",218,DFN,IEN,""))
 ;..Q:$P(^RGHL7(991.1,IEN,1,IEN2,0),"^",5)=1  ;**ALREADY MARKED AS PROCESSED
 ;..D NOW^%DTC S PROCDT=%
 ;..L +^RGHL7(991.1,IEN):10
 ;..S DA(1)=IEN,DA=IEN2,DR="6///"_1_";7///"_PROCDT_";8///"_$G(DUZ),DIE="^RGHL7(991.1,"_DA(1)_",1," D ^DIE K DIE,DA,DR
 ;..L -^RGHL7(991.1,IEN)
 Q
