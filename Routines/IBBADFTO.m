IBBADFTO ;OAK/ELZ - PFSS DFT BATCH MESSAGING ;15-MAR-2005
 ;;2.0;INTEGRATED BILLING;**286**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;entry point from menu option IBBA BATCH DFT
 N IBBMMAX,X
 S X=$T(SWSTAT^IBBASWCH)
 Q:(X="")
 Q:'(+$$SWSTAT^IBBASWCH())
 Q:'$D(^IBBAS(372,1,0))
 Q:+$P(^IBBAS(372,1,0),U,10)
 ;set batch running flag
 S $P(^IBBAS(372,1,0),U,10)=1,$P(^(0),U,11)=$$NOW^XLFDT()
 S IBBMMAX=+$P(^IBBAS(372,1,0),U,3) S:'IBBMMAX IBBMMAX=999
 ;call batch builder
 S X=$T(BATCH^IBBVP03) I X'="" D BATCH^IBBVP03(IBBMMAX)
 ;clear batch running flag
 S $P(^IBBAS(372,1,0),U,10)=0,$P(^(0),U,11)=""
 Q
