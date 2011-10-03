LRCKF64 ;DALOI/KML/RLM-CHECK WKLD CODE FILE FOR DISCREPANCIES ;2/22/87
 ;;5.2;LAB SERVICE;**272**;Sep 27, 1994
 ; Reference to ^%ZISC supported by IA #10089
 ; Reference to CHK^DIE supported by IA #2053
 ; Reference to ^DD(63.04 supported by IA #999
 ;
 S ZTRTN="DQ^LRCKF64",LRCKF="LRCKF64",LRJOB=$J,(LREND,LRWARN)=0
 D LOG^LRCKF Q:LREND
DQ U IO S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP(LRCKF)
 D ENT,PRT^LRCKF(LRCKF,LRJOB)
 W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC
 Q
ENT ;from LRCKF
 U IO S LRFL=$P(^LAM(0),U),LRDA=0
 S LRTMPGL="^TMP(LRCKF,LRJOB,LRFL)",@LRTMPGL=LRFL_" file (#64)"
 W !!,"Validating "_LRFL_" File (#64)"
 S DA=0 F  S DA=$O(^LAM(DA)) Q:DA<1  D VAL64
 Q
VAL64 ; validate data elements in the WKLD CODE file 
 I $D(^LAM(DA,0))[0 S @LRTMPGL@(DA)=">>FATAL<< - Missing zero node for entry: "_DA Q
 S LA=^LAM(DA,0)
 S Z="" D CHK^DIE(64,.01,"E",$P(LA,U),.Z) I Z=U D LABEL S @LRTMPGL@(DA,"64,.01")=">>FATAL<< - The value '"_$P(LA,U)_"' for field PROCEDURE is not valid."
 I '$L($P(LA,U,2)) D LABEL S @LRTMPGL@(DA,"64,1")=">>FATAL<< - WKLD CODE field (#1) does not contain a value."
 I $L($P(LA,U,2)) D
 . S X=$P(LA,U,2) I $A(X)=45!($L(X)>12)!($L(X)<10)!(X'?5N1"."4.5N) D LABEL S @LRTMPGL(DA,"64.1")=">>FATAL<< - WKLD CODE is not valid (field #1)." Q
 . S X=$O(^LAM("E",$P(LA,U,2),DA)) I X]"" D LABEL S @LRTMPGL@(DA,"64,1")=">>CRITICAL<< - Multiple WKLD CODE cross-references ('E' x-ref) exist for '"_$P(LA,U,2)_"' (field #1)."
 I $D(^LAB(64.22,+$P(LA,U,7),0))[0 D LABEL S @LRTMPGL@(DA,"64,6")=">>FATAL<< - Invalid UNIT FOR COUNT pointer to WKLD ITEM FOR COUNT file (#64.22)."
 I $L($P(LA,U,14)),$D(^LAB(64.3,$P(LA,U,14),0))[0 D LABEL S @LRTMPGL@(DA,"64,12")=">>FATAL<< - Invalid MANUFACTURER pointer to WKLD INSTRUMENT MANUFACTURER file (#64.3)."
 I $D(^LAB(64.21,+$P(LA,U,15),0))[0 D LABEL S @LRTMPGL@(DA,"64,13")=">>FATAL<< - Invalid WKLD CODE LAB SECTION pointer to WKLD CODE LAB SECT file (#64.21)."
 S LA6=$G(^LAM(DA,6)) I $L($P(LA6,U)),$D(^LRO(68,$P(LA6,U),0))[0 D LABEL S @LRTMPGL@(DA,6,"64,21")=">>FATAL<< - Invalid LOCAL ACC AREA pointer to ACCESSION file (#68)."
 ; S CODE=0 F  S CODE=$O(^LAM(DA,4,CODE)) Q:CODE<1  I $D(^(CODE,0))#2 S LA4=^(0) D CODEV ; this code will become active at a later date
 S SPEC=0 F  S SPEC=$O(^LAM(DA,5,SPEC)) Q:SPEC<1  I $D(^(SPEC,0))#2 S LA5=^(0) D SPECV
 S NAME=0 F  S NAME=$O(^LAM(DA,7,NAME)) Q:NAME<1  I $D(^(NAME,0))#2 S LA7=$P(^(0),U) D ASSOCV
 Q
CODEV ; validation of CODE subfile data elements (multiple 64.018)
 ; code to be developed as soon as specifications are determined
 ; TYPE field (#64.018,5) of file 64 will, at some point in time, have 
 ; its DATA TYPE changed from SET OF CODES to a POINTER (according to 
 ; F. Stalling).  Once this occurs, then validation of the data element
 ; in the data file will need to be incorporated into program code.
 Q
SPECV ; validation of SPECIMEN subfile data elements (multiple 64.01)
 I $L($P(LA5,U)),$D(^LAB(61,$P(LA5,U),0))[0 D LABEL S @LRTMPGL@(DA,5,SPEC,"64.01,.01")=">>FATAL<< - Invalid SPECIMEN pointer to TOPOGRAPHY FIELD file (#61) found at SPECIMEN subfile.  Entry: "_SPEC
 S TIME=0 F  S TIME=$O(^LAM(DA,5,SPEC,1,TIME)) Q:TIME<1  I $D(^(TIME,0))#2 S LA5T=^(0) D TIMEV
 Q
TIMEV ; validation of data elements within the TIME ASPECT multiple of the SPECIMEN subfile
 I $L($P(LA5T,U)),$D(^LAB(64.061,$P(LA5T,U),0))[0 D LABEL D
 . S @LRTMPGL@(DA,5,SPEC,TIME,"64.02,.01")=">>FATAL<< - Invalid TIME ASPECT pointer to LAB ELECTRONIC CODES file (#64.061) found at TIME ASPECT multiple of the SPECIMEN subfile.  Entry: "_SPEC_" Subentry: "_TIME
 I $L($P(LA5T,U,2)),$D(^LAB(64.061,$P(LA5T,U,2),0))[0 D LABEL D
 . S @LRTMPGL@(DA,5,SPEC,TIME,"64.02,1")=">>FATAL<< - Invalid UNITS pointer to LAB ELECTRONICS CODES file (#64.061) found at TIME ASPECT multiple of the SPECIMEN subfile. Entry: "_SPEC_" Subentry: "_TIME
 I $L($P(LA5T,U,3)),$D(^DD(63.04,$P(LA5T,U,3),0))[0 D LABEL S @LRTMPGL@(DA,5,SPEC,TIME,"64.02,2")=">>FATAL<< - Invalid DATA LOCATION found at TIME ASPECT multiple of the SPECIMEN subfile.  Entry: "_SPEC_" Subentry: "_TIME
 I $L($P(LA5T,U,4)),$D(^LAB(60,$P(LA5T,U,4),0))[0 D LABEL D
  . S @LRTMPGL@(DA,5,SPEC,TIME,"64.02,3")=">>FATAL<< - Invalid TEST pointer to LABORATORY TEST file (#60) found at TIME ASPECT multiple of the SPECIMEN subfile.  Entry: "_SPEC_" Subentry: "_TIME
 Q
ASSOCV ; validation of data elements at the ASSOCIATED NAME subfile
 S X=U_$P(LA7,";",2)_$P(LA7,";")_",0)"
 I $D(@X)[0 D LABEL S @LRTMPGL@(DA,7,NAME,"64.023,.01")=">>FATAL<< - Invalid VARIABLE POINTER field found at ASSOCIATED NAME subfile for entry "_NAME
 I LRWARN,$D(^LAM("AE",$P(LA7,";",2),$P(LA7,";"),DA))[0 D LABEL S @LRTMPGL@(DA,7,NAME,"64.023,.01",1)=">>WARNING<< - ASSOCIATED NAME cross-reference does not exist for entry "_NAME
 Q
LABEL ;
 I LRDA'=DA S @LRTMPGL@(DA)=$P(LA,U) S LRDA=DA
 Q
