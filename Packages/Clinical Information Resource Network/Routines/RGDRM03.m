RGDRM03 ;BAY/ALS-MPI/PD AWARE DUPLICATE RECORD MERGE ;03/17/00
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**6,12**;30 Apr 99
 ;
 ;Reference to ^DPT( supported by IA #2070
 ;Reference to RMOVPAIR^XDRDVAL1 supported by IA #3168
 ;
EN(ARRAY) ; Entry point
 F DFNFRM=0:0 S DFNFRM=$O(@ARRAY@(DFNFRM)) Q:DFNFRM'>0  D
 . S DFNTO=$O(@ARRAY@(DFNFRM,""))
 . S IENFRM=$O(@ARRAY@(DFNFRM,DFNTO,""))
 . S IENTO=$O(@ARRAY@(DFNFRM,DFNTO,IENFRM,""))
 . S RETURN=$$CKICNS^RGDRM01(DFNFRM,DFNTO)
 . I $P(RETURN,"^",1)=1 D
 .. D MRGTF^RGDRM02(DFNFRM,DFNTO)
 .. D MRGSUB^RGDRM02(DFNFRM,DFNTO)
 . I $P(RETURN,"^",1)<1 D
 .. D START^RGHLLOG($G(HLMTIEN)),EXC^RGHLLOG(233,$P(RETURN,"^",2),DFNTO),STOP^RGHLLOG(0)
 ..; remove pair from merge
 .. S IEN=""
 .. S IEN=+$G(@ARRAY@(DFNFRM,DFNTO,IENFRM,IENTO))
 .. D RMOVPAIR^XDRDVAL1(DFNFRM,DFNTO,IEN,ARRAY)
 ; Check to see if there are any pairs left to merge
 K IEN,IENTO,IENFRM
 Q
MRGCMOR ; If the 'FROM' record has a CMOR and the 'TO' record does not, set the
 ; field in the 'TO' record and delete the field in the 'FROM' record.
 ; The CMOR score will be recalculated for the TO record when 
 ; merge completes.
 L +^DPT(DFNTO):10
 S DIE="^DPT(",DA=DFNTO,DR="991.03///^S X=CMORFRM"
 D ^DIE K DIE,DA,DR
 L -^DPT(DFNTO)
DEL ; Delete field in 'FROM' record
 L +^DPT(DFNFRM):10
 S DIE="^DPT(",DA=DFNFRM,DR="991.03///@;991.06///@;991.07///@"
 D ^DIE K DIE,DA,DR
 L -^DPT(DFNFRM)
 Q
EXIT ;
 Q RETURN
GETSCR(DFN) ; Get CMOR score and calculation date given IEN (DFN) of patient file (#2)
 Q:'DFN
 N SCORE,SCOREDT,RETURN,SCR
 I '$D(^DPT(DFN,"MPI")) S RETURN="-1^No MPI Node" G EXIT2
 S DIC="^DPT(",DR="991.06;991.07",DA=DFN,DIQ="SCR",DIQ(0)="I"
 D EN^DIQ1 K DIC,DR,DA,DIQ
 S SCORE=$G(SCR(2,DFN,991.06,"I"))
 S SCOREDT=$G(SCR(2,DFN,991.07,"I"))
 S RETURN=SCORE_"^"_SCOREDT
EXIT2 ;
 Q RETURN
