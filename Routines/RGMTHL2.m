RGMTHL2 ;BIR/CML-COMPILE MPI/PD HL7 DATA FOR BI-DIRECTIONAL TCP ;11/15/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**21,23,28,20**;30 Apr 99
 ;
 ;Reference to ^ORD(101 supported by IA #2596
 ;Reference to ^HL(772 supported by IA #3464
 ;Reference to ^HL(771.6 supported by IA #2507
 ;Reference to ^HLMA( supported by IA #3273
 ;Reference to ^DPT("AICN" supported by IA #2070
 ;
 ;Check to see if the ^XTMP global is present and/or complete
 W @IOF
 W !,"This utility searches the HL7 MESSAGE TEXT (#772) file for a selected"
 W !,"date range.  Each HL7 message in the date range is examined.  If the"
 W !,"RELATED EVENT PROTOCOL field contains the MPI/PD protocols (e.g., ""VAF"","
 W !,"""RG"", or ""MPI"") data is compiled into the ^XTMP(""RGMT"",""HL"" array."
 W !!,"A cross-reference is built on patient ICN and DFN for faster data retrieval"
 W !,"for the associated reports."
 ;
 G:'$D(^XTMP("RGMT","HL")) BEGIN
 I '$D(^XTMP("RGMT","HL","@@@@","STOPPED")) D
 .W !!,$C(7),"The Compile MPI/PD HL7 Data compilation is already running!" G QUIT
 S CDT=$$FMTE^XLFDT($E(+^XTMP("RGMT","HL","@@@@","STOPPED"),1,12))
 W !!,"=> ""Compile MPI/PD HL7 Data"" last ran to completion on "_CDT_".",!
 I $D(^XTMP("RGMT","HL","@@@@","RANGE")) D
 .W !,"=> Data has been compiled for ",^XTMP("RGMT","HL","@@@@","RANGE"),"."
 W ! K DIR S DIR(0)="SMB^D:DELETE;A:APPEND"
 S DIR("A",1)="Do you want to:"
 S DIR("A",2)="(D)elete existing data and recompile."
 S DIR("A")="(A)ppend new data after last date of existing data"
 S DIR("B")="A"
 S DIR("?",1)="Enter:",DIR("?",2)="D if you want to delete exiting data and recompile."
 S DIR("?",3)="A or <RET> to append new data after last date of existing data."
 S DIR("?")="""^"" to HALT."
 D ^DIR K DIR G:$D(DIRUT) QUIT S ACT=Y
 ;
BEGIN ;
 S RGNOW=$$NOW^XLFDT()
 S:'$D(ACT) ACT="D"
 W !!,"Enter date range for data to be compiled."
 I ACT="A" D
 .S X1=^XTMP("RGMT","HL","@@@@","COMPENDDATE"),X2=1 D C^%DTC
 .S RGBDT=X W !,"Beginning Date for Report: ",$$FMTE^XLFDT(X)
 I ACT="D" D  G:$D(DIRUT) QUIT
 .K DIR,DIRUT,DTOUT,DUOUT
 .S DIR(0)="DAO^:"_$$NOW^XLFDT()_":EPXT",DIR("A")="Beginning Date for Report:  "
 .D ^DIR K DIR Q:$D(DIRUT)  S RGBDT=Y
 K DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="DAO^"_RGBDT_":"_$$NOW^XLFDT()_":EPXT",DIR("A")="Ending Date for Report:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT S RGEDT=Y
 ;
QUE ;Queue the task.
 S ZTSAVE("RGBDT")="",ZTSAVE("RGEDT")="",ZTSAVE("ACT")=""
 S ZTIO="",ZTRTN="START^RGMTHL2",ZTDESC="Compile MPI/PD HL7 Data (bi-directional)" D ^%ZTLOAD
 G QUIT
 ;
START ;
 S QFLG=0
 K ^XTMP("RGMT","HL","@@@@","STOPPED")
 I ACT="D" K ^XTMP("RGMT","HL"),^XTMP("RGMT","HLICN"),^XTMP("RGMT","HLDFN")
 S U="^" D NOW^%DTC
 S ^XTMP("RGMT","HL","@@@@","STARTED")=%
 S ^XTMP("RGMT",0)=$$FMADD^XLFDT(DT,30)_"^"_%_"^MPI/PD Maintenance Data"
 S STOPDT=$S($L(RGEDT)=7:RGEDT_.24,1:RGEDT)
 S RGDT=$S($L(RGBDT)=7:$$FMADD^XLFDT(RGBDT,-1)_.24,1:RGBDT-.0001)
 I ACT="D" S ^XTMP("RGMT","HL","@@@@","COMPBEGINDATE")=RGDT
 S ^XTMP("RGMT","HL","@@@@","COMPENDDATE")=STOPDT
 S PRGBDT=$$FMTE^XLFDT(RGDT)
 S PRGEDT=$$FMTE^XLFDT(STOPDT)
 S ^XTMP("RGMT","HL","@@@@","RANGE")=PRGBDT_" to "_PRGEDT
 ;
LOOP ;Loop on ^HL(772 date xref
 F  S RGDT=$O(^HL(772,"B",RGDT)) Q:'RGDT  Q:RGDT>STOPDT  Q:QFLG  D
 .I $D(^XTMP("RGMT","HL","@@@@","FORCE STOP")) S QFLG=1 Q
 .S ^XTMP("RGMT","HL","@@@@","NOW PROCESSING DATE")=RGDT
 .S IEN=0
 .F  S IEN=$O(^HL(772,"B",RGDT,IEN)) Q:'IEN  S IEN0=$G(^HL(772,IEN,0)) Q:'IEN0  D
 ..S REP=$P(IEN0,U,10)
 ..I REP D
 ...I '$D(^ORD(101,REP,0)) Q
 ...S REPNM=$P(^ORD(101,REP,0),U),RPNM=$E(REPNM,1,4)
 ...I RPNM["VAF"!(RPNM["RG")!(RPNM["MPI") D
 ....S TYPE=$P(IEN0,U,4),STAT=$P($G(^HL(772,IEN,"P")),U)
 ....I STAT="" D
 .....S HL773=$O(^HLMA("B",IEN,0))
 .....S STAT=$P($G(^HLMA(HL773,"P")),"^")
 ....I STAT S STATNM=$P(^HL(771.6,STAT,0),U)
 ....I STAT="" S STATNM="NO STATUS"
 ....S ^XTMP("RGMT","HL",REPNM,$P(RGDT,"."),TYPE,STATNM,IEN)=""
PAT ....S TXT=0 F  S TXT=$O(^HL(772,IEN,"IN",TXT)) Q:'TXT  D
 .....I $P(^HL(772,IEN,"IN",TXT,0),U)="PID" S GOT=0 D  Q:GOT
 ......I $P(^HL(772,IEN,"IN",TXT,0),"^",4)["V" S ICN=+$P(^(0),"^",4) D SET
 ......I $P(^HL(772,IEN,"IN",TXT,0),"^",3)["V" S ICN=+$P(^(0),"^",3) D SET
 .....I $P(^HL(772,IEN,"IN",TXT,0),U)="QAK" S GOT=0 D  Q:GOT
 ......I +$P(^(0),U,2) S DFN=+$P(^(0),U,2) S ^XTMP("RGMT","HLDFN",DFN,RGDT,REPNM,TYPE,STATNM,IEN)="",GOT=1
 .....I $P(^HL(772,IEN,"IN",TXT,0),U)="RDT" S ICN=+$P($P(^(0),U,6),"V") I ICN D  Q
 ......S ^XTMP("RGMT","HLICN",ICN,RGDT,REPNM,TYPE,STATNM,IEN)="(Look at ^HL(772,"_IEN_",""IN"","_TXT_",0)",GOT=1
 .....I $P(^HL(772,IEN,"IN",TXT,0),U)="VTQ" S GOT=0 D  Q:GOT
 ......S SSN=$P($P(^HL(772,IEN,"IN",TXT,0),"@00122",2),"~",3) I SSN D
 .......S DFN=$O(^DPT("SSN",SSN,0)) I DFN D
 ........S ^XTMP("RGMT","HLDFN",DFN,RGDT,REPNM,TYPE,STATNM,IEN)="(Look at ^HL(772,"_IEN_",""IN"","_TXT_",0)",GOT=1
 .....I $P(^HL(772,IEN,"IN",TXT,0),U)="MFE",$P(^(0),U,2)="MAD" S ICN=+$P($P(^(0),U,5),"~",4) D SET Q
 .....I $P(^HL(772,IEN,"IN",TXT,0),U)="MFE",$P(^(0),U,2)="MUP" D  Q
 ......S ICN=+$P(^HL(772,IEN,"IN",TXT,0),U,5) I $L(ICN)=3 S ICN=+$P($P(^HL(772,IEN,"IN",TXT,0),U,5),"~",4)
 ......D SET
 ;
 D NOW^%DTC S ^XTMP("RGMT","HL","@@@@","STOPPED")=%
 K ^XTMP("RGMT","HL","@@@@","NOW PROCESSING DATE"),^XTMP("RGMT","HL","@@@@","FORCE STOP")
 ;
QUIT ;
 K %,ACT,CDT,DFN,GOT,HL773,ICN,IEN,IEN0,PRGBDT,PRGEDT,REP,REPNM,RGBDT,RGDT
 K RGEDT,RGNOW,RPNM,SSN,STAT,STATNM,STOPDT,TYPE,TXT,X,X1,X2,Y,ZTSK,STOP,FROM,QFLG,RANGE
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
SET ;
 S GOT=1
 S ^XTMP("RGMT","HLICN",ICN,RGDT,REPNM,TYPE,STATNM,IEN)=""
 S DFN=$O(^DPT("AICN",ICN,0)) I +DFN S ^XTMP("RGMT","HLDFN",DFN,RGDT,REPNM,TYPE,STATNM,IEN)=""
 Q
 ;
STOP ;stop the compile
 W !!,"Stop HL7 Message Compile."
 I '$D(^XTMP("RGMT","HL","@@@@","STARTED")) W !?3,"<< No compile is currently running >>" G QUIT
 I $D(^XTMP("RGMT","HL","@@@@","STARTED"))&($D(^XTMP("RGMT","HL","@@@@","STOPPED"))) W !?3,"<< No compile is currently running >>" G QUIT
 ;
 W !!,"A compile is currently running for ",?35,": ",^XTMP("RGMT","HL","@@@@","RANGE"),"."
 W ! S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do you want to stop this compile" D ^DIR K DIR
 I +Y D
 .S ^XTMP("RGMT","HL","@@@@","FORCE STOP")=""
 .S STOP=$$NOW^XLFDT
 .S RANGE=^XTMP("RGMT","HL","@@@@","RANGE"),FROM=$P(RANGE," to ",1)
 .S ^XTMP("RGMT","HL","@@@@","RANGE")=FROM_" to "_$$FMTE^XLFDT(STOP)
 G QUIT
 ;
SHOW ;show status of compile
 W !!,"Show status of HL7 Message Compile."
 I '$D(^XTMP("RGMT","HL","@@@@","STARTED")) W !?3,"<< No compile is currently running >>" G QUIT
 W !!,"Compile range ",?31,": ",^XTMP("RGMT","HL","@@@@","RANGE")
 W !,"The compile was started ",?31,": ",$$FMTE^XLFDT(^XTMP("RGMT","HL","@@@@","STARTED"))
 I $D(^XTMP("RGMT","HL","@@@@","NOW PROCESSING DATE")) D
 .W !,"The compile is now processing ",?31,": ",$$FMTE^XLFDT(^XTMP("RGMT","HL","@@@@","NOW PROCESSING DATE"))
 I $D(^XTMP("RGMT","HL","@@@@","STOPPED")) D
 .W !,"The compile was stopped ",?31,": ",$$FMTE^XLFDT(^XTMP("RGMT","HL","@@@@","STOPPED"))
 G QUIT
