SCENIA1 ;ALB/SCK - INCOMPLETE ENCOUNTER ERROR DISPLAY PROTOCOLS ; 09 Oct 98  3:03 PM
 ;;5.3;Scheduling;**66,154,323,378**;AUG 13, 1993
 ;
VE ; View Expanded Error
 N SDHDR1,SDHDR2
 S SDHDR1=VALMHDR(1)
 S SDHDR2=VALMHDR(2)
 S VALMBCK=""
 D EN^SCENIB0
 S VALMBCK="R"
 Q
 ;
CE ;  Entry point for getting corrective action for error and executing it.
 ;    Variables
 ;      SCXER  - Ptr to 409.76
 ;      SCEN   - Ptr to 409.75
 ;      SDXMT   - Ptr to 409.73
 ;
 N SCXER,SCEN
 ;;;; MOD
 K ^TMP("SCENI COR",$J)
 ;
 D SELERM("O")
 Q:'$D(SCXER)
 ;
 ;;;;; MOD
 ;F I=1:1 S SCTEXT=$P($T(HDR+I),";;",2) Q:SCTEXT["$$END"  D
 ;. W !?2,SCTEXT
 ;
 S SCEN=0
 S SDXMT=$G(^TMP("SCENI XMT",$J,0)) Q:'SDXMT
 F  S SCEN=$O(SCXER(SCEN)) Q:'SCEN  D
 . Q:'$D(^SD(409.75,SCEN,0))
 . S SCCOR=$G(^SD(409.76,$P(^SD(409.75,SCEN,0),U,2),"COR"))
 . I SCCOR="" D ERMSG(1) Q
 .;;;;;; MOD
 . Q:$D(^TMP("SCENI COR",$J,$P(SCCOR,"(")))
 . W !!,$G(^SD(409.76,$P(^SD(409.75,SCEN,0),U,2),1))
 . X SCCOR
 . I 'RTN D ERMSG(2) ;;;Q
 .;;;;; MOD
 . S ^TMP("SCENI COR",$J,$P(SCCOR,"("))=""
 ; 
 ; ** After correcting selected errors, fire off the validator and reflag
 ;    transmission entry
 W !,"Performing Ambulatory Care Validation Checks..."
 S RTN=$$VALIDATE^SCMSVUT2(SDXMT)
 I RTN<0 D ERMSG(5) G CEQ
 S RTN=$$SETRFLG(SDXMT)
 I RTN<0 D ERMSG(3) G CEQ
 ;
 ;;;;; MOD
 K ^TMP("SCENI COR",$J)
CEQ Q
 ;
EDI() ; Entry point for ENCOUNTER INFORMATION corrective action
 S SDOK=0
 D EI^SCENIA2
 Q SDOK
 ;
DEM1() ; Entry point for correction logic
 S SDOK=0
 D DEM
 Q SDOK
 ;
DEM ; Entry point for the SCENI PATIENT DEMOGRAPHICS protocol
 N DFN,SDXMT,RTN
 ;
 S DFN=$G(^TMP("SCENI DFN",$J,0)) Q:'DFN
 S SDXMT=$G(^TMP("SCENI XMT",$J,0)) Q:'SDXMT
 D FULL^VALM1
 ;SD*5.3*323 add sensitive record warning if applicable
 ;reference to DGRPU1 allowed in Integration Agreement 413
 N DIC S DIC=2,DIC(0)="EM",X="`"_DFN D ^DIC I Y=-1 S SDOK=1 Q
 D QUES^DGRPU1(DFN,"ADD3")
 ;
 I '$D(SDOK) D
 . W !,"Performing Ambulatory Care Validation Checks..."
 . S RTN=$$VALIDATE^SCMSVUT2(SDXMT)
 . ;;; MOD
 . I RTN<0 D ERMSG(5) Q  ;G DEMQ
 . S RTN=$$SETRFLG(SDXMT)
 . I RTN<0 D ERMSG(3) Q  ;G DEMQ
 I $D(SDOK) S SDOK=1
DEMQ Q
 ;
INTV() ;  Entry point for correction logic for checkout errors
 S SDOK=0
 D CO
 Q SDOK
 ;
CO ;  Entry point for SCENI CHECKOUT INTERVIEW
 N SDXMT,SCENFLG,SDOE,SDDT,SDOEND
 K SCINF
 ;SD*5.3*323 add sensitive record warning if applicable next 5 lines
 N DFN
 S DFN=$G(^TMP("SCENI DFN",$J,0)) Q:'DFN
 S SDXMT=$G(^TMP("SCENI XMT",$J,0)) Q:'SDXMT
 D FULL^VALM1
 N DIC S DIC=2,DIC(0)="EM",X="`"_DFN D ^DIC I Y=-1 S SDOK=1 Q
 S SCSTAT=$$OPENC^SCUTIE1(SDXMT,"SCINF")
 I SCSTAT D  G COQ
 . D FULL^VALM1
 . W !!,$CHAR(7),"This is a deleted encounter.  Checkout information cannot be changed!"
 . D PAUSE^VALM1
 ;
 S SDOE=$P(^SD(409.73,SDXMT,0),U,2)
 S SDOEND=$G(^SCE(+SDOE,0))
 S SDCOHDL="",SCENFLG=1,VALMBCK=""
 ;
 I $P(SDOEND,U,8)=2,$P(SDOEND,U,6)="" D ADDEDIT(SDOEND) I 1
 E  D EN^SDCO6
 ;
 S VALMBCK="R"
 ;
 I '$D(SDOK) D
 . W !,"Performing Ambulatory Care Validation Checks..."
 . S RTN=$$VALIDATE^SCMSVUT2(SDXMT)
 . ;;; MOD
 . I RTN<0 D ERMSG(5) Q  ;G COQ
 . S RTN=$$SETRFLG(SDXMT)
 . I RTN<0 D ERMSG(3) Q  ;G COQ
 I $D(SDOK) S SDOK=1
COQ ;
 Q
 ;
ADDEDIT(SDOEND) ;this is to edit add/edits
 N VAR
 Q:'$P(SDOEND,U,5)
 S VAR=$$INTV^PXAPI("ADDEDIT","SD","PIMS",$P(SDOEND,U,5),"",$P(SDOEND,U,2))
 Q
 ;
LEDT() ;
 S SDOK=0
 D LE
 Q SDOK
 ;
LE ;  Entry point patient load edit.
 N DFN,SDXMT
 ;
 S DFN=$G(^TMP("SCENI DFN",$J,0)) Q:'DFN
 S SDXMT=$G(^TMP("SCENI XMT",$J,0)) Q:'SDXMT
 S VALMBCK="",DGNEW=0
 D FULL^VALM1
 ;SD*5.3*323 add sensitive record warning if applicable
 N DIC S DIC=2,DIC(0)="EM",X="`"_DFN D ^DIC I Y=-1 S SDOK=1 Q
 D A1^DG10
 I '$D(SDOK) D
 . W !,"Performing Ambulatory Care Validation Checks."
 . S RTN=$$VALIDATE^SCMSVUT2(SDXMT)
 . ;;;;; MOD
 . I RTN<0 D ERMSG(5) Q  ;G LEQ
 . S RTN=$$SETRFLG(SDXMT)
 . I RTN<0 D ERMSG(3) Q  ;G LEQ
 I $D(SDOK) S SDOK=1
LEQ ;
 Q
 ;
REFLG() ; Entry point for reflag correction action
 ;;;; MOD
 ;S SDOK=0
 ;D FLG
 ;Q SDOK
 Q 1
 ;
FLG ; Entry point for Reflag Transmission protocol
 N SDXMT
 ;
 S SDXMT=$G(^TMP("SCENI XMT",$J,0)) Q:'SDXMT
 W !,"Performing Ambulatory Care Validation Checks..."
 S RTN=$$VALIDATE^SCMSVUT2(SDXMT)
 I RTN<0 D ERMSG(5) G FLQ
 S RTN=$$SETRFLG(SDXMT)
 I RTN<0 D ERMSG(3) G FLQ
 ;;;; MOD
 ;I $D(SDOK) S SDOK=1
FLQ Q
 ;
SETRFLG(SDXMT) ;
 ;  Input
 ;     SDXMT  - Pointer to Transmission File, #409.73
 ;
 ;  Output
 ;      -1  - There was a problem reflaging the transmission 
 ;       0  - No errors occured
 ;       1  - The entry is already flagged for transmission
 ;
 S RESULT=-1
 S STATUS=$P($G(^SD(409.73,SDXMT,0)),U,4)
 I STATUS S RESULT=1
 E  D
 . D XMITFLAG^SCDXFU01(SDXMT,0),STREEVNT^SCDXFU01(SDXMT,0)
 . S RESULT=0
 D INIT^SCENIA0
 D RE^VALM4
 Q RESULT
 ;
MSG(SDTEXT,SDEXMT) ;
 W:SDTEXT]"" !!,SDTEXT,!
 S DIR(0)="FAO",DIR("A")="Press ENTER to continue " D ^DIR K DIR
 Q 1
 ;
SELERM(FLG) ;  Select Multiple entries
 N VALMY
 ;
 D FULL^VALM1
 I $G(FLG)']"" S FLG="O"
 D EN^VALM2(XQORNOD(0),FLG) S VALMI=0
 I '$D(VALMY) S VALMBCK="R" Q
 S SDN1=""
 F  S SDN1=$O(VALMY(SDN1)) Q:'SDN1  D
 . S SCEPTR="",SCEPTR=$O(^TMP("SCENI ERR",$J,"DA",SDN1,SCEPTR))
 . I SCEPTR>0 S SCXER(SCEPTR)=""
 Q
 ;
ERMSG(MSGN) ;
 D FULL^VALM1
 S SCTEXT=$P($T(@MSGN),";;",2)
 W $CHAR(7)
 W !!?5,SCTEXT,!
 S DIR(0)="FAO",DIR("A")="Press ENTER to continue " D ^DIR K DIR
 S VALMBCK="R"
 Q
 ;
EXIT ;
 I $D(VALMBCK),VALMBCK="R" D REFRESH^VALM S VALMBCK=$P(VALMBCK,"R")_$P(VALMBCK,"R",2)
 Q
 ;
HDR ;
 ;;Selecting a range of errors to correct may result in one or
 ;;more similar errors being removed from the display list after 
 ;;correction of the initial error.  
 ;;$$END
 ;
1 ;;No correction logic has been defined for this error.
2 ;;Unable to execute Correction Logic.
3 ;;There was a problem trying to flag this entry for retransmission.
4 ;;This transmission entry is already flagged for transmission.
5 ;;The validator encountered a problem with this transmission entry.
