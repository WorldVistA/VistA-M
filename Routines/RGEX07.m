RGEX07 ;BIR/PTD-LIST MANAGER ROUTINE FOR REMOTE PRIMARY VIEW DISPLAY ;10/17/06
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**44,53**;30 Apr 99;Build 2
 ;
 ;Reference to ^XWB2HL7 supported by IA #3144
 ;Reference to ^XWBDRPC supported by IA #3149
 ;
EN(ICN,EXCDT) ;Entry point calling List Template for primary view reject display
 D EN^VALM("RG EXCPT PV REJECT RDISPLAY")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="MPI PRIMARY VIEW REJECT DISPLAY"
 Q
 ;
INIT ;Display the MPI Primary View Rejected Data Report
 K ^TMP("RGEXC7",$J)
 K @VALMAR
 I '$D(ICN) G EXIT
 I '$D(EXCDT) G EXIT
 S LIN=1,X=0,STR="",TXT=""
 I '$D(^XTMP("RGPVREJ"_ICN,EXCDT)) S TXT=" - No Primary View Reject data exists for this patient/exception date." D ADDTMP
 N STATUS,R,RETURN,RESULT,RET
 I $D(^XTMP("RGPVREJ"_ICN,EXCDT)) S RETURN(0)=$P(^XTMP("RGPVREJ"_ICN,EXCDT),"^") D
 .D RPCCHK^XWB2HL7(.RESULT,RETURN(0)) I +RESULT(0)=1 D
 ..;Retrieve the data
 ..D RTNDATA^XWBDRPC(.RET,RETURN(0)) D
 ...I $G(RET(0))<0 S TXT="No Data Returned Due To: "_$P(RET(0),"^",2,99) S STR=$$SETSTR^VALM1(TXT,STR,2,78) D ADDTMP Q
 ...I $G(RET)'="",$D(@RET) S GLO=RET F  S GLO=$Q(@GLO) Q:$QS(GLO,1)'=$J  S TXT=@GLO S STR=$$SETSTR^VALM1(TXT,STR,2,78) D ADDTMP
 ...S R="" F  S R=$O(RET(R)) Q:R=""  S TXT=RET(R) S STR=$$SETSTR^VALM1(TXT,STR,2,78) D ADDTMP
 K GLO,L,R,SL
 S VALMCNT=LIN-1
 Q
 ;
ADDTMP ;Set string into the array.
 S ^TMP("RGEXC7",$J,LIN,0)=STR
 S ^TMP("RGEXC7",$J,"IDX",LIN,LIN)=""
 S LIN=LIN+1,STR=""
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 S VALMBCK=""
 K ^TMP("RGEXC7",$J),GLO,L,LIN,R,RESULT,RET,RETURN,SL,STATUS,STR,TXT,X
 S VALMBCK="R"
 Q
 ;
EXPND ; -- expand code
 Q
 ;
