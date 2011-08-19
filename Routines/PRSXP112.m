PRSXP112 ;WOIFO/JAH - PAID Parameter post-init for p 112 ;7/25/07
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
P112POST ; Initialize parameter file for the institution installing
 ; the patch
 ;
 ; Create entry in #456 and add populate fields
 N PRSFDA,IEN456,INST
 S INST=+$$KSP^XUPARAM("INST") ;   INSTITUTION
 I (INST>0),($O(^PRST(456,"B",INST,0))>0) Q
 S PRSFDA(456,"+1,",.01)=INST ;   INSTITUTION
 D UPDATE^DIE("","PRSFDA","IEN456"),MSG^DIALOG()
 S IEN456=IEN456(1)_","
 S PRSFDA(456,IEN456,1)=1 ;  TURN BULLETIN FLAG ON
 S PRSFDA(456,IEN456,2)=0 ; INIT Bulletins sent
 S PRSFDA(456,IEN456,3)=5 ; INIT Bulletin Limit
 D FILE^DIE("","PRSFDA",),MSG^DIALOG()
 Q
