TIUPS98 ; SLC/JER - Post-install TIU*1*98 ;15-JUN-2000 14:53:20
 ;;1.0;TEXT INTEGRATION UTILITIES;**98**;Jun 20, 1997
MAIN ; Control unit
 D DFLTCS
 D CLEANUP
 Q
DFLTCS ; Remove inappropriate default cosigners
 N TIUDA,TIUDUZ,TIUDFCS,TIUCNT S (TIUCNT,TIUDA)=0,XPDIDVT=$G(XPDIDVT,0)
 D BMES^XPDUTL("** REMOVING INAPPROPRIATE DEFAULT COSIGNERS **")
 S XPDIDTOT=+$P(^TIU(8926,0),U,4) D UPDATE^XPDID(0)
 F  S TIUDA=$O(^TIU(8926,TIUDA)) Q:+TIUDA'>0  D
 . N TIUD0,TIUDUZ,TIUDFCS
 . S TIUD0=$G(^TIU(8926,TIUDA,0)),TIUDUZ=+TIUD0,TIUDFCS=+$P(TIUD0,U,9)
 . Q:TIUDUZ'=TIUDFCS
 . D FIXIT(TIUDA) S TIUCNT=TIUCNT+1 D:'(TIUCNT#10) UPDATE^XPDID(TIUCNT)
 Q
FIXIT(DA) ; Remove Default Cosigner when equal to self
 N DIE,DR
 S DIE=8926,DR=".09///@" D ^DIE
 Q
CLEANUP ; Roll-back records that were completed prematurely
 N TIUEDT,TIUDA,TIUCNT S TIUCNT=0
 S TIUEDT=$$GETSTART Q:+TIUEDT'>0
 S ^XTMP("TIUPS98",0)=$$FMADD^XLFDT(DT,90)_U_DT
 S ^XTMP("TIUPS98","T0")=$$NOW^XLFDT
 D BMES^XPDUTL("** CLEANING UP PREMATURELY COMPLETED DOCUMENTS **")
 F  S TIUEDT=$O(^TIU(8925,"F",TIUEDT)) Q:+TIUEDT'>0  D
 . N TIUDA S TIUDA=+$P($G(^XTMP("TIUPS98","CHKPNT")),U,2)
 . F  S TIUDA=$O(^TIU(8925,"F",TIUEDT,TIUDA)) Q:+TIUDA'>0  D
 . . N TIUD0,TIUD12,TIUD15,TIUES,TIUECS,TIUSBY,TIUCSBY,TIUDPRM
 . . S TIUD0=$G(^TIU(8925,TIUDA,0)),TIUD12=$G(^(12)),TIUD15=$G(^(15))
 . . Q:+$P(TIUD0,U,5)'>6
 . . S TIUES=+$P(TIUD12,U,4) Q:TIUES=0
 . . S TIUECS=+$P(TIUD12,U,8) Q:TIUECS=0
 . . S TIUSBY=+$P(TIUD15,U,2) Q:TIUSBY=0
 . . S TIUCSBY=+$P(TIUD15,U,8) Q:TIUCSBY=0
 . . ; NEXT if the signer IS NOT the cosigner
 . . Q:TIUSBY'=TIUCSBY
 . . ; NEXT if the expected signer IS ALSO the expected cosigner
 . . Q:TIUES=TIUECS
 . . ; NEXT if the signer IS NOT the expected signer
 . . Q:TIUSBY'=TIUES
 . . ; NEXT if the cosigner IS NOT the expected signer
 . . Q:TIUCSBY'=TIUES
 . . D ROLLBACK(TIUDA)
 . . S ^XTMP("TIUPS98","CHKPNT")=TIUEDT_U_TIUDA
 S ^XTMP("TIUPS98","T1")=$$NOW^XLFDT
 I TIUCNT=0 D BMES^XPDUTL("No aberrant documents found...")
 Q
GETSTART()      ; Find out when Patch TIU*1*79 was installed
 N INSTDA,TIUY S INSTDA=""
 S TIUY=+$G(^XTMP("TIUPS98","CHKPNT"))
 I +TIUY>0 G GETSTX
 S INSTDA=$O(^XPD(9.7,"B","TIU*1.0*79",INSTDA),-1)
 S TIUY=+$P($G(^XPD(9.7,INSTDA,1)),U,3)
GETSTX Q TIUY
ROLLBACK(DA)    ; Remove cosignature and roll-back to uncosigned
 N DIE,DR
 S DIE=8925
 S DR=".05////^S X=6;1506////^S X=1;1507///@;1508///@;1509///@;1510///@;1511///@"
 D ^DIE
 D SEND^TIUALRT(DA)
 S TIUCNT=TIUCNT+1
 S ^XTMP("TIUPS98",DA)=""
 S ^XTMP("TIUPS98","COUNT")=TIUCNT
 I $S(TIUCNT=1:1,'(TIUCNT#50):1,1:0) D MES^XPDUTL($$GETMSG(TIUCNT\50))
 Q
GETMSG(LINE)    ; Get a message of encouragement...
 Q $P($T(MSG+$S(LINE'>10:LINE,1:$R(10))),";",3)
MSG ; List of messages
 ;;Hang in there, this won't take but too much longer...
 ;;Boy, you've got a lot of these!
 ;;What were you expecting, animated .gif's or something?
 ;;"I like New York in June, how about you?"
 ;;"I like a Gershwin tune, how about you?"
 ;;Aren't you glad that I didn't ask "IS EVERYTHING OK?"
 ;;DILBERT RULES!
 ;;Don't worry, I'll be done LONG before we have a mass transit subsidy...
 ;;You will be assimilated...
 ;;Resistence is futile...
