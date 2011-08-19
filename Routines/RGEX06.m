RGEX06 ;BIR/PTD-LIST MANAGER ROUTINE FOR REMOTE MPI PRIMARY VIEW PDAT ;5/17/07
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**48,53**;30 Apr 99;Build 2
 ;
 ;Reference to ^XWB2HL7 supported by IA #3144
 ;Reference to ^XWBDRPC supported by IA #3149
 ;
EN(ICN) ;Entry point calling List Template for primary view PDAT display
 D EN^VALM("RG EXCPT PV MPI PDAT")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="MPI PRIMARY VIEW PATIENT DATA DISPLAY"
 Q
 ;
INIT ;Display the MPI Primary View Patient Data (PDAT)
 K ^TMP("RGEXC6",$J)
 K @VALMAR
 I '$D(ICN) G EXIT
 S LIN=1,X=0,STR="",TXT=""
 I '$D(^XTMP("RGPVMPI"_ICN,"DATA")) S TXT=" - No MPI Primary View data exists for this patient." D ADDTMP
 N STATUS,R,RETURN,RESULT,RET
 I $D(^XTMP("RGPVMPI"_ICN,"DATA")) S RETURN(0)=$P(^XTMP("RGPVMPI"_ICN,"DATA"),"^") D
 .D RPCCHK^XWB2HL7(.RESULT,RETURN(0)) I +RESULT(0)=1 D
 ..;Retrieve the data
 ..D RTNDATA^XWBDRPC(.RET,RETURN(0)) D
 ...I $G(RET(0))<0 S TXT="No Data Returned Due To: "_$P(RET(0),"^",2,99) S STR=$$SETSTR^VALM1(TXT,STR,1,80) D ADDTMP Q
 ...I $G(RET)'="",$D(@RET) S GLO=RET F  S GLO=$Q(@GLO) Q:$QS(GLO,1)'=$J  S TXT=@GLO S STR=$$SETSTR^VALM1(TXT,STR,1,80) D ADDTMP
 ...S R="" F  S R=$O(RET(R)) Q:R=""  S TXT=RET(R) S STR=$$SETSTR^VALM1(TXT,STR,1,80) D ADDTMP
 K GLO,L,R,SL
 S VALMCNT=LIN-1
 Q
 ;
ADDTMP ;Set string into the array.
 S ^TMP("RGEXC6",$J,LIN,0)=STR
 S ^TMP("RGEXC6",$J,"IDX",LIN,LIN)=""
 S LIN=LIN+1,STR=""
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 S VALMBCK=""
 K ^TMP("RGEXC6",$J),GLO,L,LIN,R,RESULT,RET,RETURN,SL,STATUS,STR,TXT,X
 S VALMBCK="R"
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SAPV(ICN) ;Print stand alone Primary View display
 I '$D(^XTMP("RGPVMPI"_ICN,"DATA")) W !," - No MPI Primary View data exists for this patient." Q
 N STATUS,R,RETURN,RESULT,RET
 I $D(^XTMP("RGPVMPI"_ICN,"DATA")) S RETURN(0)=$P(^XTMP("RGPVMPI"_ICN,"DATA"),"^") D
 .D RPCCHK^XWB2HL7(.RESULT,RETURN(0)) I +RESULT(0)=1 D
 ..;Retrieve the data
 ..D RTNDATA^XWBDRPC(.RET,RETURN(0)) D
 ...I $D(RET(0)) I RET(0)<0 W !!,"No data returned due to: "_$P(RET(0),"^",2) Q
 ...I $G(RET)'="",$D(@RET) S GLO=RET F  S GLO=$Q(@GLO) Q:$QS(GLO,1)'=$J  S TXT=@GLO W !,TXT I $Y>22 S DIR(0)="E" D ^DIR K DIR W @IOF S $Y=1
 ...S R="" F  S R=$O(RET(R)) Q:R=""  W !,RET(R) I $Y>22 S DIR(0)="E" D ^DIR K DIR Q:'Y  W @IOF S $Y=1
 Q
 ;
