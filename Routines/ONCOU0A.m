ONCOU0A ;WISC/MLH - ONCOLOGY PATIENT FILE UTILITIES - Fix follow ups for expired patients ;6/21/93  09:18
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
FIXFOR(ONCOWRT) ;    correct erroneous 'foreign resident' status for exp pats
 ;    ONCOWRT defined if output desired
 N ONCOLVL S ONCOLVL="^TMP(""ONCOFIXFOR"","_$$INITSYA_")" ;    level of ^TMP for SYA
 N ONCOKP,ONCOKF,ONCOKC S (ONCOKP,ONCOKF,ONCOKC)=0 ;    counts
 N ONCOPI S ONCOPI=0 ;    patient file index
 FOR ONCOKP=0:1 S ONCOPI=$O(^ONCO(160,ONCOPI)) Q:ONCOPI'=+ONCOPI  D
 .  N ONCOFI S ONCOFI=0 ;    follow-up sub-file index
 .  FOR  S ONCOFI=$O(^ONCO(160,ONCOPI,"F",ONCOFI)) Q:ONCOFI'=+ONCOFI  S ONCOKF=ONCOKF+1,ONCOKC=ONCOKC+$$CHKSTAT(ONCOPI,ONCOFI,ONCOLVL,ONCOWRT)
 .  Q
 ;END FOR
 ;
 N ONCORES S ONCORES=ONCOKP_U_ONCOKF_U_ONCOKC ;    results array
 I $D(ONCOWRT) D WRT(ONCORES)
 QUIT
 ;
INITSYA() ;    find level of ^TMP on which to put SYA and initialize
 N ONCOI S ONCOI=$P($G(^TMP("ONCOFIXFOR",0)),U,3)+1,$P(^(0),U,3)=ONCOI
 Q ONCOI
 ;
CHKSTAT(ONCOP,ONCOF,ONCOLVL,ONCOWRT) ;    look at follow-up record for patient ONCOP, follow-up ONCOF
 ;    if we need to change and ONCOLVL defined, back up on ^TMP("ONCOFIXFOR",ONCOLVL)
 ;    ONCOWRT is defined if we want dots for the user
 N ONCOX S ONCOX=$G(^ONCO(160,ONCOP,"F",ONCOF,0)) ;    onco pat rec
 N ONCOCHG S ONCOCHG=0 ;    change flag
 IF $P(ONCOX,U,2)=0,$P(ONCOX,U,6)=8 D  ;    exp pat, foreign resident --> hit!
 .  S ONCOSYA=$P($G(@ONCOLVL@(0)),U,3)+1,$P(@ONCOLVL@(0),U,3)=ONCOSYA,@ONCOLVL@(ONCOSYA,0)=ONCOP_":"_ONCOF_":"_ONCOX ;    save old data
 .  ;
 .  ;    correct follow-up method
 .  N DIE,DA S DIE="^ONCO(160,"_ONCOP_",""F"",",DA(1)=ONCOP,DA=ONCOF,DR="6///9"
 .  D ^DIE
 .  ;
 .  I $D(ONCOWRT),$R(40)=0 W "."
 .  S ONCOCHG=1
 .  Q
 ;END IF
 ;
 Q ONCOCHG
 ;
WRT(ONCORES) ;    output results array
 N ONCOI F ONCOI=1:1:3 S ONCORES(ONCOI)=$P(ONCORES,U,ONCOI)
 W !!,"Oncology patients processed:  ",?35,$J(ONCORES(1),6),!,"Follow-ups processed:  ",?35,$J(ONCORES(2),6),!,"Follow-ups corrected:  ",?35,$J(ONCORES(3),6),!!
 Q
