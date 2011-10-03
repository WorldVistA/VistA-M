RGPVMPI ;BIR/PTD-REMOTE PRIMARY VIEW DISPLAY FROM MPI ;5/17/07
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**48,53**;30 Apr 99;Build 2
 ;
 ;Reference to EN1^XWB2HL7 supported by IA #3144
 ;Reference to RPCCHK^XWB2HL7 supported by IA #3144
 ;
INTRO ;Display purpose of option
 W @IOF S SAPV=1 ;from stand alone option, not EH
 W !,"This option sends a remote request for data to the Master Patient"
 W !,"Index, using a Remote Procedure Call (RPC).  When the RPC returns"
 W !,"the information, you can review Primary View data as it currently"
 W !,"exists on the MPI Patient Data Inquiry (PDAT) report."
 ;
 W !!,"Choose the patient for whom Primary View data is to be requested."
 W !,"The selected patient must have an Integration Control Number (ICN)."
 W !,"You can select by Patient Name, Social Security Number, or ICN.",!
 ;
ASK ;Ask For Patient
 S DFN="",RGICN="" K DTOUT,DUOUT
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: ",D="SSN^AICN^B^BS^BS5"
 D MIX^DIC1 K DIC,D
 I Y<0 G EXIT
 S DFN=+Y
 S RGICN=+$$GETICN^MPIF001(DFN) I RGICN<1 W !,"There is no Integration Control Number for this patient." G ASK
 ;
SEND ;Send a remote query to the MPI for Primary View PDAT
 ;Entry point from Exception Handler; DATA should be defined.
 S (QFLG,QUIT)=0 N RETURN,RESULT,SNTDT
 I SAPV=0 D  I QUIT=1 G EXIT
 .I DATA="" W !,"No Exception Data available." S QUIT=1 Q
 .S RGICN=$P(DATA,"^",6) I RGICN="" W !,"No ICN defined." S QUIT=1 Q
 .S VALMBCK=""
 .D FULL^VALM1
NOQ ;No previous query exists for this ICN
 I '$D(^XTMP("RGPVMPI"_RGICN)) D RPC G DISP
 ;
OLDQ ;Query previously sent for this ICN
 I $D(^XTMP("RGPVMPI"_RGICN)) D
 .S SNTDT=$$FMTE^XLFDT($P(^XTMP("RGPVMPI"_RGICN,"DATA"),"^",2))
 .W !,"A query was last sent for this ICN on "_SNTDT
 .;Has data returned for query?
 .S RETURN(0)=$P(^XTMP("RGPVMPI"_RGICN,"DATA"),"^")
 .D RPCCHK^XWB2HL7(.RESULT,RETURN(0))
 .;Data has NOT returned
 .I +RESULT(0)'=1 D FAIL  Q  ;**53
 .I +RESULT(0)=1 D  ;Data has returned
 ..S DIR("A")="Do you wish to view the existing query data now? ",DIR(0)="YA"
 ..S DIR("?")="Enter YES to review the existing data; enter NO to send a new query"
 ..S DIR("B")="YES" D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q  ;up-arrowed out
 ..I Y>0 K DIR Q  ;yes, use existing query
 ..I Y=0 D  Q  ;no, don't use existing, send new query
 ...K ^XTMP("RGPVMPI"_RGICN)
 ...D RPC
 ...K DIR
 ;
DISP ;Display Primary View Data
 I QUIT'=1 D  I QFLG G EXIT
 .I SAPV=1 D  Q:QFLG  ;Stand alone PV display
 ..W !,"(Be sure HISTORY is enabled to capture data!)"
 ..S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 ..W !,@IOF D SAPV^RGEX06(RGICN)
 .I SAPV=0 D EN^RGEX06(RGICN) ;Exception Handler PV display
 ;
EXIT ;Kill variables and quit
 K CNT,D,DFN,DIC,DIR,DIRUT,DTOUT,DUOUT,QFLG,QUIT,RGICN,SAPV,X,Y
 Q
 ;
RPC ;Send the Remote Query
 W !!,"Sending a Remote Query to the Master Patient Index."
 W !,"This will take some time; please be patient."
 D EN1^XWB2HL7(.RETURN,"200M","RG PRIMARY VIEW FROM MPI",1,RGICN) I RETURN(0)'="" D  Q
 .S ^XTMP("RGPVMPI"_RGICN,0)=$$FMADD^XLFDT(DT,2)_"^"_DT_"^"_"PRIMARY VIEW MPI PDAT"
 .S ^XTMP("RGPVMPI"_RGICN,"DATA")=RETURN(0)_"^"_$$NOW^XLFDT
 .;Has data returned for this query?
 .S CNT=0 F  S CNT=CNT+1 D RPCCHK^XWB2HL7(.RESULT,RETURN(0)) Q:RESULT(0)  H 2 I CNT>15 Q  ;result(0)=status of handle
 .I +RESULT(0)=1 W !,"Query data has returned from the MPI and is available for review."
 .I +RESULT(0)'=1 D FAIL  ;**53
 W !!,"Problem with Query: ",RETURN(0)_"^"_$G(RETURN(1))
 S QUIT=1
 I SAPV=0 D PAUSE^VALM1
 Q
 ;
FAIL ;Status of RPC call - unsuccessful after 30 seconds ;**53
 W !,"Your query request has NOT returned data from the MPI after trying for"
 W !,"30 seconds. This could be due to network issues. Please try again later."
 K ^XTMP("RGPVMPI"_RGICN)
 S QUIT=1
 I SAPV=0 D PAUSE^VALM1
 Q
 ;
