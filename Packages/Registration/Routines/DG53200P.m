DG53200P ;ALB/MLI - Post-install routine for DG*5.3*200 ; Nov 27, 1998
 ;;5.3;Registration;**200**;Aug 13, 1993
 ;
 ; This post-install routine for DG*5.3*200 will add a DEL node
 ; to the PATIENT file to prevent deletion of a patient if the
 ; patient has entries in the ORDER file (#100)
 ;
EN ; post-install
 S ^DD(2,.01,"DEL",100,0)="I $D(^OR(100,""ACT"",DA_"";DPT("")) D EN^DDIOL(""Patient orders must be deleted first."","""",""!?0"")"
 Q
