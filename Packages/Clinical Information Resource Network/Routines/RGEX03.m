RGEX03 ;BAY/ALS-LIST MANAGER FOR MPI/PD EXCEPTIONS ;10/13/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**3,12,19,23,27,30,38,39,43,44,48,54,57**;30 Apr 99;Build 2
 ;
 ;Reference to START^VAFCPDAT supported by IA #3299
 ;Reference to ^DIA(2 supported by IA #2097
 ;Reference to ^DPT( supported by IA #2969
 ;Reference to HINQ^DG10 supported by IA #2076
 ;Reference to CIRNEXC^MPIFQ0 supported by IA #2942
 ;Reference to VTQ^MPIFSAQ supported by IA #2941
 ;Reference to NOTICE^DGSEC4 and PTSEC^DGSEC4 supported by IA#3027
 ;Reference to POT^MPIFDUP supported by IA #4464;**57 MPIC_1893 call obsolete; removed PMR
 ;Reference to $$NCEDIT^DPTNAME supported by private IA #4116
 ;
EN(DATA) ; -- main entry point for RG EXCPT ACTION
 D EN^VALM("RG EXCPT ACTION")
 Q
HDR ; -- header code
 S VALMHDR(1)="MPI/PD EXCEPTION HANDLING ACTIONS.",VALMHDR(2)=""
 Q
INIT ; -- init variables and list array
 K ^TMP("RGEXC2",$J)
 K @VALMAR
 I DATA="" Q
 S STR="",LIN=1,STATUS="",NAME="",DOB="",SSN="",DFN="",CHKSM="" ;**44
 S NAME=$P(DATA,"^",1),DOB=$P(DATA,"^",8),SSN=$P(DATA,"^",2)
 S DFN=$P(DATA,"^",5),CHKSM=$P($G(^DPT(DFN,"MPI")),"^",2) ;**44
 S STR=$$SETSTR^VALM1("Name:",STR,6,6),STR=$$SETSTR^VALM1(NAME,STR,14,30) D ADDTMP
 S STR=$$SETSTR^VALM1(" SSN:",STR,6,6),STR=$$SETSTR^VALM1(SSN,STR,14,12) D ADDTMP
 S STR=$$SETSTR^VALM1(" DOB:",STR,6,6),STR=$$SETSTR^VALM1(DOB,STR,14,20) D ADDTMP
 S STR=$$SETSTR^VALM1(" DFN:",STR,6,6),STR=$$SETSTR^VALM1(DFN,STR,14,12) D ADDTMP ;**44
 S STR=$$SETSTR^VALM1(" ICN:",STR,6,6),ICN="" S ICN=$P(DATA,"^",6) I ICN<0 S ICN=""
 S STR=$$SETSTR^VALM1(ICN_($S(CHKSM="":"",1:"V"_CHKSM)),STR,14,20) D ADDTMP ;**44
 S STR=$$SETSTR^VALM1("Date of Death:",STR,6,20),STR=$$SETSTR^VALM1($P(DATA,"^",13),STR,26,20) D ADDTMP
 S STR=$$SETSTR^VALM1("Exception Type:",STR,6,20),STR=$$SETSTR^VALM1($P(DATA,"^",4),STR,26,50) D ADDTMP
 S STR=$$SETSTR^VALM1("Exception Date:",STR,6,20),STR=$$SETSTR^VALM1($P(DATA,"^",3),STR,26,30) D ADDTMP
 S STATUS=$P(DATA,"^",9)
 I STATUS<1 S STATUS="NOT PROCESSED"
 E  S STATUS="PROCESSED"
 S STR=$$SETSTR^VALM1("Exception Status:",STR,6,20),STR=$$SETSTR^VALM1(STATUS,STR,26,15) D ADDTMP
 ;Added Exception Text to Exception Handler, patch 39
 N IEN,IEN2,X K ^UTILITY($J,"W") S IEN=$P(DATA,"^",10),IEN2=$P(DATA,"^",11)
 I IEN'=""!(IEN2'="") D
 .S EXCTEXT=$P($G(^RGHL7(991.1,IEN,1,IEN2,10)),"^",1) Q:EXCTEXT=""
 .S STR=$$SETSTR^VALM1("Exception Text:",STR,6,20)
 .S X=EXCTEXT,DIWL=1,DIWR=50,DIWF="|" D ^DIWP
 .F N=1:1:$P($G(^UTILITY($J,"W",1)),1) D  Q:'N
 ..S STR=$$SETSTR^VALM1(^UTILITY($J,"W",1,(N),0),STR,26,76)
 ..D ADDTMP
ADDNOTE ;Display Exception Notes, Word Processing field
 S STR=$$SETSTR^VALM1("Exception Notes:",STR,6,20) D ADDTMP
 N IEN,IEN2,IENS,N,NOTE
 S IEN=$P(DATA,"^",10),IEN2=$P(DATA,"^",11),IENS=IEN2_","_IEN_",",N=$$GET1^DIQ(991.12,IENS,11,"","NT")
 S L=0 F  S L=$O(NT(L)) Q:'L  S NOTE=NT(L),STR=$$SETSTR^VALM1(NOTE,STR,6,74) D ADDTMP
 S VALMCNT=LIN-1,DFN=$P(DATA,"^",5),VAFCDFN=DFN
 K L,NT
 Q
ADDTMP ;
 S ^TMP("RGEXC2",$J,LIN,0)=STR,^TMP("RGEXC2",$J,"IDX",LIN,LIN)="",LIN=LIN+1,STR=""
 Q
UPD ;
 N PROCDT,%,X,%I,%H
 W !,"This option updates the exception status to PROCESSED.",!,"After it is processed it will not be listed in the summary."
 S DIR("A")="Are you sure you want to change the status? ",DIR(0)="YA",DIR("B")="YES"
 D ^DIR Q:$D(DIRUT)  I Y>0 D
 .;**48 populating the date/time marked as processed and who marked it as processed
 .D NOW^%DTC S PROCDT=%
 .S IEN="",IEN2="",IEN=$P(DATA,"^",10),IEN2=$P(DATA,"^",11) L +^RGHL7(991.1,IEN):10
 .S DA(1)=IEN,DA=IEN2,DR="6///"_1_";7///"_PROCDT_";8////"_$G(DUZ),DIE="^RGHL7(991.1,"_DA(1)_",1," D ^DIE K DIE,DA,DR ;**57,MPIC_2024
 .L -^RGHL7(991.1,IEN) S $P(DATA,"^",9)=1
 .D INIT
 K DIR,DIRUT S VALMBCK="R"
 Q
PA ;Patient Audit
 S PDFN=DFN
 I '$O(^DIA(2,"B",VAFCDFN,0)) S VALMSG="This patient has no audit data available.",VALMBCK="" G PAQ
 N IEN S DFN=VAFCDFN,QFLG=1 D FULL^VALM1 D:$T(ASK2^RGMTAUD)]"" ASK2^RGMTAUD S VALMBCK="R"
 S DFN=PDFN K QFLG,PDFN
PAQ Q
HI ;Hinq Inquiry
 S VALMBCK="" D HINQ^DG10 D PAUSE^VALM1 S VALMBCK="R"
 Q
DISP ; Display Only Query
 S VALMBCK="" D FULL^VALM1
 S MPIVAR("DFN")=DFN,MPIVAR("SSN")=SSN,MPIVAR("NM")=NAME,MPIVAR("DOB")=$P($P(DATA,"^",7),".",1)
 D VTQ^MPIFSAQ(.MPIVAR) D PAUSE^VALM1
 S VALMBCK="R" K MPIVAR
 Q
 ;
POT ;Potential Match on MPI, Query MPI, resolve duplicate if needed. **43;**57 MPIC_1893 OBSOLETE; remove PMR
 ;D POT^MPIFDUP
 ;D INIT S VALMBCK="R" K PROCESS
 Q
 ;
REJ ;Primary View Reject. **44 Added entry point
 D REJ^RGPVREJ
 D INIT S VALMBCK="R"
 Q
 ;
MPIPV ;MPI Primary View PDAT. **48 Added entry point
 S SAPV=0 ;from EH, not stand alone option
 D SEND^RGPVMPI
 D INIT S VALMBCK="R"
 Q
 ;
LOAD ; Edit Patient Data, if patient's eligibility is verified - check for DG ELIGIBILITY key for user
 S VALMBCK="",DATAOLD=""
 D FULL^VALM1 D ELIG^VADPT
 I $P(VAEL(8),"^",1)="V" D
 .I '$D(^XUSEC("DG ELIGIBILITY",DUZ)) D
 ..W !!,"Eligibility has been verified for this patient.",!!,"You do not have access to edit the Name, Date of ",!,"Birth or Social Security Number for this patient."
 ..D PAUSE^VALM1 S VALMBCK="R"
 .E  D SENS
 E  D SENS
 Q
SENS ; check for patient sensitivity and user security
 N RESULT,RGSEN
 D PTSEC^DGSEC4(.RESULT,DFN,0,"RG EXCEPTION HANDLING^MPI/PD Exception Handling")
 I RESULT(1)=-1 W !!,"Access denied: Required parameters not defined" D PAUSE^VALM1 S VALMBCK="R" Q
 I RESULT(1)>0 W !!?15,"***PATIENT MARKED SENSITIVE***"
 I RESULT(1)=3 W !!?15,"Access not allowed on your own PATIENT (#2) file entry" D PAUSE^VALM1 S VALMBCK="R" Q
 I RESULT(1)=4 W !!?15,"Access denied: Your SSN is not defined" D PAUSE^VALM1 S VALMBCK="R" Q
 I RESULT(1)<3 D
 .I RESULT(1)=1 D NOTICE^DGSEC4(.RGSEN,DFN,"RG EXCEPTION HANDLING^MPI/PD Exception Handling",2)
 .I RESULT(1)=2 D NOTICE^DGSEC4(.RGSEN,DFN,"RG EXCEPTION HANDLING^MPI/PD Exception Handling",3)
 D EDIT
 Q
EDIT ; edit patient data
 S ACCESS=0
 D REC
 Q:ACCESS=0
 S DIE="^DPT(",DA=DFN,DR=".01///^S X=$$NCEDIT^DPTNAME(DA);.03//^S X=DOB;.09//^S X=SSN"
 L +^DPT(DFN):10 D ^DIE K DIE,DA,DR L -^DPT(DFN)
 S DATAOLD=DATA
 D DEATH
 D DEM^VADPT
 S DATA=VADM(1)_"^"_$P($G(VADM(2)),"^",1)_"^"_$P(DATAOLD,"^",3)_"^"_$P(DATAOLD,"^",4)_"^"_DFN_"^"_$P(DATAOLD,"^",6)_"^"
 S DATA=DATA_$G(VADM(3))_"^"_$P(DATAOLD,"^",9)_"^"_$P(DATAOLD,"^",10)_"^"_$P(DATAOLD,"^",11)_"^"_$P(DATAOLD,"^",12)_"^"_$P($G(VADM(6)),"^",2)
 D INIT
 S VALMBCK="R"
 K DGNEW,DATAOLD,VAEL,ACCESS,DGNPSSN
QUIT Q
REC ; Check if user is attempting to access own record
 ; check for security key
 I $D(^XUSEC("DG RECORD ACCESS",+DUZ)) S ACCESS=1 Q
 S DGNPSSN=$$GET1^DIQ(200,+DUZ_",",9,"I","","DGNPERR")
 I 'DGNPSSN D  Q
 .W !!,"Your SSN is missing from the NEW PERSON file.",!,"Contact your ADP Coordinator."
 .D PAUSE^VALM1 S VALMBCK="R"
 I DGNPSSN=SSN D  Q
 .W !!,"Security regulations prohibit computer access to your",!,"own medical record."
 .D PAUSE^VALM1 S VALMBCK="R"
 E  S ACCESS=1
 Q
DEATH ; Check for access to edit date of death
 I $D(^XUSEC("DG DETAIL",+DUZ)) D
 .K VADM,DIE,DA,DR
 .S (DOD1,DOD2,SRS)=""
 .D DEM^VADPT
 .S DOD1=$P($G(VADM(6)),"^",2) ;DOD original value
 .S DIC="2",DA=DFN,DR=".353",DIQ(0)="E" D EN^DIQ1 ;**54
 .S SRS=$G(^UTILITY("DIQ1",$J,2,DA,.353,"E")) ;source of notification original value
 .S DIE="^DPT(",DA=DFN,DR=".351//^S X=DOD1" D DIEC ;ask DOD, prompt with original value
 .;was a change made to DOD?
 .D DEM^VADPT
 .S DOD2=$P($G(VADM(6)),"^",2) D  ;DOD value after DIE call
 ..I DOD1="",DOD2="" Q  ;original and added DOD both null; don't prompt for .353
 ..I DOD1'="",DOD2="" S DIE="^DPT(",DA=DFN,DR=".353////@" D DIEC Q  ;DOD now null - deleted; remove source field
 ..;Else DOD added or changed; so prompt for source
 ..I (DOD1=""&DOD2'="")!(DOD1'=DOD2) D
 ...S DIE="^DPT(",DA=DFN,DR=".353//^S X=SRS" D DIEC Q
 E  W !!,"You do not have the proper security to edit date of death." D PAUSE^VALM1 D INIT S VALMBCK="R"
 K VADM,DIE,DA,DR,DOD1,DOD2,SRS,X,Y
 Q
 ;
DIEC ;Do the ^DIE call from the DEATH module
 L +^DPT(DFN):10
 D ^DIE
 L -^DPT(DFN)
 Q
 ;
INQ ; Patient Inquiry
 S VALMBCK=""
 D FULL^VALM1 D EN^DGRPD D PAUSE^VALM1 D CLEAN^VALM10 D INIT
 S VALMBCK="R"
 Q
EDTNOT ; Edit Exception Notes
 S IEN=$P(DATA,"^",10),IEN2=$P(DATA,"^",11)
 L +^RGHL7(991.1,IEN):10 S DIE="^RGHL7(991.1,"_IEN_",1,",DA(1)=IEN,DA=IEN2,DR="11" D ^DIE L -^RGHL7(991.1,IEN)
 K DIE,DA,DR,IEN,IEN2
 D INIT
 S VALMBCK="R"
 Q
PDAT S VALMBCK="",PICN="",PSSN=""
 I $D(SSN) S PSSN=SSN
 S ARRAY="^TMP(""RGXHFS"","_$J_")",TYPE="I",REP=1,RGXDIR=$$GET^XPAR("SYS","RGX HFS SCRATCH"),RGXFILE="RGX"_DUZ_".DAT"
 S IOM=132,IOSL=99999,IOST="P-DUMMY",IOF=""""""
 D OPEN^%ZISH("RGX",RGXDIR,RGXFILE,"W") Q:POP
 U IO
 I ICN'="" S PICN=ICN D START^VAFCPDAT
 N RGXDEL
 D CLOSE^%ZISH("RGX")
 K ^TMP("RGPDAT",$J)
 S RGXDEL(RGXFILE)="",X=$$FTG^%ZISH(RGXDIR,RGXFILE,$NAME(^TMP("RGPDAT",$J,1)),3),X=$$DEL^%ZISH(RGXDIR,$NA(RGXDEL))
 I $D(^TMP("RGPDAT",$J)) D EN^RGEX04
 S ICN=PICN,SSN=PSSN
 D INIT
 S VALMBCK="R" K PICN,PSSN,ARRAY,REP,RGXDIR,RGXFILE,TYPE
 Q
GETEX(RETURN,DFN) ; Get array of pending exceptions for a patient
 K RETURN
 S CNT=0,RETURN(0)="0^No Pending Exceptions",TYP=""
 I 'DFN S RETURN(0)="-1^DFN not passed" G QGET
 F  S TYP=$O(^RGHL7(991.1,"ADFN",TYP)) Q:'TYP  D
 .I $D(^RGHL7(991.1,"ADFN",TYP,DFN)) D
 ..S IEN="" F  S IEN=$O(^RGHL7(991.1,"ADFN",TYP,DFN,IEN)) Q:'IEN  D
 ...S IEN2="",ETYP="" F  S IEN2=$O(^RGHL7(991.1,"ADFN",TYP,DFN,IEN,IEN2)) Q:'IEN2  D
 ....I $P(^RGHL7(991.1,IEN,1,IEN2,0),"^",5)<1 D
 .....S CNT=CNT+1,ETYP=$P(^RGHL7(991.11,TYP,10),"^",1)
 .....S RETURN(CNT)=ETYP_"^"_IEN_"^"_IEN2
 I CNT>0 S RETURN(0)=CNT_"^Pending Exception(s)"
QGET ;
 K TYP,ETYP,IEN,IEN2,CNT
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
EXIT ; -- exit code
 S VALMBCK="" K ^TMP("RGEXC2",$J),CHKSM,DFN,DIR,EXCTEXT,IEN,IEN2,NAME,DOB,SSN,LIN,STATUS,STR,VAFCDFN,X,Y
 S VALMBCK="R",RGBG=1
 Q
EXPND ; -- expand code
 Q
