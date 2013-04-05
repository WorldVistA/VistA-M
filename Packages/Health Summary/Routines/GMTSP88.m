GMTSP88 ;BP CHY20/RJT - GMTS*2.7*88 POST INIT: ; 2/13/08 1:56pm
 ;;2.7;HEALTH SUMMARY;**88**;Oct 20, 1995;Build 23
 Q
EN ;
 N GMTSIEN,GMTSHS,GMTSALRT,INDEX S INDEX=1 D BMES^XPDUTL("Updating the Health Summary Component file")
 I +$$VERSION^XPDUTL("GMTS")'="2.7" D BMES^XPDUTL("Health Summary version 2.7 not found!  Aborting file update...") Q
 ;S GMTSHS=$$FIND1^DIC(9.4,"","X","HEALTH SUMMARY","B","") I +GMTSHS=0 D BMES^XPDUTL("Health Summary package not found!  Aborting file update...") G END
 ;S GMTSIEN=$$FIND1^DIC(9.49,","_GMTSHS_",","X","2.7","B","") I +GMTSIEN=0 D BMES^XPDUTL("Health Summary version 2.7 not found!  Aborting file update...") G END
 D EN1,EN2
 D 
 . I '$D(^TMP("GMTS",$J,"ALERT"))  D BMES^XPDUTL("File #142.1 was updated successfully.")  Q
 . D ALERT
 G END
 Q
EN1     ;
 N MHAS S MHAS=$$FIND1^DIC(142.1,"","X","MHA Score","B","")
 I $G(MHAS)]"" D
 . I $$GET1^DIQ(142.1,MHAS,2,"I")="1" D
 . . S DIE="142.1",DA=MHAS,DR="2///yes"
 . . L +^GMT(142.1,MHAS):$G(DILOCKTM,3) I $T D ^DIE L -^GMT(142.1,MHAS) Q
 . . D BMES^XPDUTL("The Health Summary Component file (#142.1) is being edited by another user.") D ADD("MHAS","TIME LIMITS APPLICABLE") Q
 . I $$GET1^DIQ(142.1,MHAS,4,"I")="1" D
 . . S DIE="142.1",DA=MHAS,DR="4///yes"
 . . L +^GMT(142.1,MHAS):$G(DILOCKTM,3) I $T D ^DIE L -^GMT(142.1,MHAS) Q
 . . D BMES^XPDUTL("The Health Summary Component file (#142.1) is being edited by another user.") D ADD("MHAS","MAXIMUM OCCURRENCES APPLICABLE") Q
 Q
EN2 ;
 N MHAL S MHAL=$$FIND1^DIC(142.1,"","X","MHA Administration List","B","")
 I $G(MHAL)]"" D
 . I $$GET1^DIQ(142.1,MHAL,2,"I")="1" D
 . . S DIE="142.1",DA=MHAL,DR="2///yes"
 . . L +^GMT(142.1,MHAL):$G(DILOCKTM,3) I $T D ^DIE L -^GMT(142.1,MHAL) Q
 . . D BMES^XPDUTL("The Health Summary Component file (#142.1) is being edited by another user.") D ADD("MHAL","TIME LIMITS APPLICABLE") Q
 . I $$GET1^DIQ(142.1,MHAL,4,"I")="1" D
 . . S DIE="142.1",DA=MHAL,DR="4///yes"
 . . L +^GMT(142.1,MHAL):$G(DILOCKTM,3) I $T D ^DIE L -^GMT(142.1,MHAL) Q
 . . D BMES^XPDUTL("The Health Summary Component file (#142.1) is being edited by another user.") D ADD("MHAL","MAXIMUM OCCURRENCES APPLICABLE") Q
 Q
ADD(COMP,FIELD) ; Add alert info to array
 S ^TMP("GMTS",$J,"ALERT")=""
 S GMTSALRT(INDEX)=COMP_"^"_FIELD,INDEX=INDEX+1
 Q
ALERT ;  Send alert to user notifying them that file #142.1 was not updated
 N XQA,XQAARCH,XQADATA,XQAFLG,XQAGUID,XQAID,XQAMSG,XQAOPT,XQAROU,XQASUPV,XQASURO,XQATEXT,XTEXT,XQALERR,RESULT,XQATEXT2,I
 S I=0 D
 . S XQA(DUZ)=""
 . S XQAMSG="GMTS*2.7*88 Installation - update to file #142.1 failed."
 . S XQATEXT=$C(13)_$C(10)_" The following update(s) failed during the installation of GMTS*2.7*88: "_$C(13)_$C(10)
 . F  S I=$O(GMTSALRT(I)) Q:'I  D
 . . S XQATEXT=XQATEXT_$C(13)_$C(10)_$C(9)_"- field "_$P($G(GMTSALRT(I)),"^",2)_" of the "_$P($G(GMTSALRT(I)),"^",1)_" component. "
 . S XQATEXT=XQATEXT_$C(13)_$C(10)_$C(13)_$C(10)_" See the post-install section of the patch description for instructions"
 . S XQATEXT=XQATEXT_$C(13)_$C(10)_" on how to manually update the file."
 . S XQATEXT2=XQATEXT,RESULT=0,RESULT=$$SETUP1^XQALERT I RESULT=0 D BUL
 Q
BUL ; MAILMAN MESSAGE
 N XMSUB,XMTEXT,XMY,FSMG,GMTSI,DIFROM,COUNTER
 S XMY(DUZ,0)="IN",GMTSI=0,COUNTER=0
 S XMSUB="!!! GMTS*2.7*88 Installation - update failed !!!"
 S FMSG(1)="The following update(s) failed during the installation of GMTS*2.7*88:   ",FMSG(2)=""
 F  S GMTSI=$O(GMTSALRT(GMTSI)) Q:'GMTSI  D
 . S FMSG(GMTSI+2)=" - field "_$P($G(GMTSALRT(GMTSI)),"^",2)_" of the "_$P($G(GMTSALRT(GMTSI)),"^",1)_" component ",COUNTER=COUNTER+1
 S FMSG(COUNTER+3)=""
 S FMSG(COUNTER+4)=" See the post-install section of the patch description for instructions on "
 S FMSG(COUNTER+5)=" how to manually update the file."
 S XMTEXT="FMSG("
 D ^XMD K FMSG
 Q
END ;
 K ^TMP("GMTS",$J,"ALERT"),DA,DIE,DR
 Q
