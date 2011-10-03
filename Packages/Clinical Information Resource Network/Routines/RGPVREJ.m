RGPVREJ ;BIR/PTD-REMOTE PRIMARY VIEW REJECT (PATIENT) ;10/8/06
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**44,47,53**;30 Apr 99;Build 2
 ;
 ;Reference to ^XWB2HL7 supported by IA #3144
 ;Reference to ^XWBDRPC supported by IA #3149
 ;
REJ ;Option only available for Primary View Reject exceptions
 ;From within the Exception Handler, for selection, DATA should be defined.
 N RGBDT,RGICN,RGSITE,PTEN,PELV
 I DATA="" W !,"No Exception Data available." Q
 S PTEN=$P(DATA,"^",10) ;IEN IN 991.1
 S PELV=$P(DATA,"^",11) ;IEN IN 991.12
 I $P($G(^RGHL7(991.1,PTEN,1,PELV,0)),"^",3)'=234 S VALMSG="Action is ONLY for PRIMARY VIEW REJECT exceptions!" Q
 I $P($G(^RGHL7(991.1,PTEN,1,PELV,0)),"^",5)=1 S VALMSG="Exception has been PROCESSED; no longer active." Q
 S RGSITE=$P($$SITE^VASITE(),"^",3) I RGSITE="" W !,"No Site Data defined." Q
 S RGICN=$P(DATA,"^",6) I RGICN="" W !,"No ICN defined." Q
 S RGBDT=$P(DATA,"^",3) I RGBDT="" W !,"No Exception Date defined." Q
 S X=RGBDT D ^%DT S RGBDT=Y ;convert Exception Date from external format to internal
 ;
 S VALMBCK="",QUIT=0
 D FULL^VALM1
SEND ;Send a remote query to the MPI for Primary View Reject report
 N RETURN,RESULT,RGEDT,SNTDT
 S RGEDT=$$DT^XLFDT ;End date for report internal format
NOQ ;No previous query exists for this ICN/exception date
 I '$D(^XTMP("RGPVREJ"_RGICN,RGBDT)) D RPC G DISP
 ;
OLDQ ;Query already sent for this ICN/ exception date
 I $D(^XTMP("RGPVREJ"_RGICN,RGBDT)) D
 .S SNTDT=$$FMTE^XLFDT($P(^XTMP("RGPVREJ"_RGICN,RGBDT),"^",2))
 .W !?3,"A query was last sent for this ICN/Exception Date on "_SNTDT
 .S X=$P(SNTDT,"@") D ^%DT S SNTDT=Y ;convert to internal, strip time
 .;Has data returned for existing query?
 .S RETURN(0)=$P(^XTMP("RGPVREJ"_RGICN,RGBDT),"^")
 .D RPCCHK^XWB2HL7(.RESULT,RETURN(0)) I +RESULT(0)=1 D  Q  ;Data has returned
 ..I RGEDT=SNTDT D  ;query was sent 'today', want to use that one?
 ...S DIR("A")="   Do you wish to review that existing query data now? ",DIR(0)="YA"
 ...S DIR("?")="     Enter YES to review the existing query; NO to send a new query"
 ...S DIR("B")="YES" D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q  ;up-arrowed out
 ...I Y>0 K DIR Q  ;yes, use existing query
 ...I Y=0 D  Q  ;no, don't use existing, send new query
 ....K ^XTMP("RGPVREJ"_RGICN,RGBDT)
 ....D RPC
 ....K DIR
 ....;
 ..I RGEDT'=SNTDT D  ;query was NOT sent 'today', data may be old, send new query
 ...W !?3,"Previous Query data may be obsolete."
 ...K ^XTMP("RGPVREJ"_RGICN,RGBDT)
 ...D RPC
 .;Data for existing query has NOT returned  **47
 .I +RESULT(0)'=1 D FAIL  ;**53
 ;
DISP ;Display Primary View Reject Data
 I QUIT'=1 D EN^RGEX07(RGICN,RGBDT)
EXIT ;Kill variables and quit
 K CNT,DIR,DIRUT,QUIT,X,Y
 Q
 ;
RPC ;Send the Remote Query
 W !?3,"Sending a Remote Query to the Master Patient Index."
 W !?3,"This will take some time; please be patient."
 D EN1^XWB2HL7(.RETURN,"200M","RG PRIMARY VIEW REJECT",1,RGSITE,RGICN,RGBDT,RGEDT) I RETURN(0)'="" D  Q
 .S ^XTMP("RGPVREJ"_RGICN,0)=$$FMADD^XLFDT(DT,2)_"^"_DT_"^"_"PRIMARY VIEW REJECT"
 .S ^XTMP("RGPVREJ"_RGICN,RGBDT)=RETURN(0)_"^"_$$NOW^XLFDT
 .;Has data returned for this query?
 .S CNT=0 F  S CNT=CNT+1 D RPCCHK^XWB2HL7(.RESULT,RETURN(0)) Q:RESULT(0)  H 2 I CNT>15 Q  ;result(0)=status of handle
 .I +RESULT(0)=1 W !?3,"Query data has returned from the MPI and is available for review."
 .I +RESULT(0)'=1 D FAIL  ;**53
 W !!?3,"Problem with Query: ",RETURN(0)_"^"_$G(RETURN(1))
 S QUIT=1
 D PAUSE^VALM1
 Q
 ;
FAIL ;Status of RPC call - unsuccessful after 30 seconds ;**53
 W !?3,"Your query request has NOT returned data from the MPI after trying for"
 W !?3,"30 seconds. This could be due to network issues. Please try again later."
 K ^XTMP("RGPVREJ"_RGICN,RGBDT)
 S QUIT=1
 D PAUSE^VALM1
 Q
 ;
