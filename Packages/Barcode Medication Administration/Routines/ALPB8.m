ALPB8 ;OIFO-DALLAS/SED  BCMA-POST INIT ;5/2/2002
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ;
POST ;Index file 53.7
 ;Quit if not a workstation
 Q:$$KSP^XUPARAM("WHERE")'["BCMABU"
 ;Index file
 N DIK
 S DIK="^ALPB(53.7," D IXALL^DIK
 ;Check for duplicates
 N ALPSSN,CNT,ALPMSG,ALPDFN,DIE,DA,DR
 S ALPSSN="" F  S ALPSSN=$O(^VA(200,"SSN",ALPSSN)) Q:ALPSSN=""  D
 . I ALPSSN["LOCAL" D
 . . S ALPDFN=0 F  S ALPDFN=$O(^VA(200,"SSN",ALPSSN,ALPDFN)) Q:ALPDFN<1  D BAD
 . S CNT=0
 . S ALPDFN="" F  S ALPDFN=$O(^VA(200,"SSN",ALPSSN,ALPDFN)) Q:ALPDFN'>0  D 
 . . S CNT=CNT+1 I CNT>1 D BAD
STOP ;
 Q
BAD ;Kill bad SSN or duplicate
 S ALPMSG="DFN: "_ALPDFN_" SSN: "_ALPSSN_" NAME: "_$P(^VA(200,ALPDFN,0),U)
 D MES^XPDUTL(ALPMSG)
 S DIE="^VA(200,",DA=ALPDFN
 S DR="7///^S X=1" ;*********disuser
 S DR=DR_";2///^S X=""@""" ;*access code
 S DR=DR_";9///^S X=""@""" ;*SSN
 D ^DIE
