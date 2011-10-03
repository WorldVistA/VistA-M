TIUPS104 ; SLC/JER - Post-install TIU*1*104 ;20-SEP-2000 14:22:20
 ;;1.0;TEXT INTEGRATION UTILITIES;**104**;Jun 20, 1997
MAIN ; Control unit
 D CLEANUP
 Q
CLEANUP ; Correct PARENT DOCUMENT CLASS field for records that were filed with bad values
 N TIUEDT,TIUDA,TIUCNT S TIUCNT=0
 S TIUEDT=$$GETSTART Q:+TIUEDT'>0
 S ^XTMP("TIUPS104",0)=$$FMADD^XLFDT(DT,90)_U_DT
 S ^XTMP("TIUPS104","T0")=$$NOW^XLFDT
 D BMES^XPDUTL("** CLEANING UP DOCUMENTS WITH BAD DOCUMENT CLASS VALUES **")
 F  S TIUEDT=$O(^TIU(8925,"F",TIUEDT)) Q:+TIUEDT'>0  D
 . N TIUDA S TIUDA=0
 . F  S TIUDA=$O(^TIU(8925,"F",TIUEDT,TIUDA)) Q:+TIUDA'>0  D
 . . N TIUD0,TIUDCLS,TIUCDCLS
 . . S TIUD0=$G(^TIU(8925,TIUDA,0)),TIUDCLS=$P(TIUD0,U,4)
 . . S TIUCDCLS=$$DOCCLASS^TIULC1(+TIUD0)
 . . ; Don't process records where Document Class is correct
 . . Q:TIUCDCLS=TIUDCLS
 . . D FIXIT(TIUDA,TIUCDCLS,TIUDCLS)
 . . S ^XTMP("TIUPS104","CHKPNT")=TIUEDT_U_TIUDA
 S ^XTMP("TIUPS104","T1")=$$NOW^XLFDT
 I TIUCNT=0 D BMES^XPDUTL("No aberrant documents found...")
 Q
GETSTART()      ; Get the starting date
 N TIUY
 S TIUY=+$G(^XTMP("TIUPS104","CHKPNT"))
 I +TIUY>0 G GETSTX
 S TIUY=$$FMADD^XLFDT(DT,-180)
GETSTX Q TIUY
FIXIT(DA,TIUCDCLS,TIUDCLS)    ; file the corrected document class
 N DIE,DR
 S DIE=8925
 S DR=".04////^S X=TIUCDCLS"
 D ^DIE
 S TIUCNT=TIUCNT+1
 S ^XTMP("TIUPS104",DA)=TIUDCLS_U_TIUCDCLS
 S ^XTMP("TIUPS104","COUNT")=TIUCNT
 I $S(TIUCNT=1:1,'(TIUCNT#50):1,1:0) D MES^XPDUTL($$GETMSG(TIUCNT\50))
 Q
GETMSG(LINE)    ; Get a message of encouragement...
 Q $P($T(MSG+$S(LINE'>10:LINE,1:$R(10))),";",3)
MSG ; List of messages
 ;;Hang in there, this won't take too much longer...
 ;;Boy, you've got a lot of these!
 ;;What were you expecting, animated .gif's or something?
 ;;"I like New York in June, how about you?"
 ;;"I like a Gershwin tune, how about you?"
 ;;Aren't you glad that I didn't ask "IS EVERYTHING OK?"
 ;;DILBERT RULES!
 ;;Don't worry, I'll be done LONG before we have a mass transit subsidy...
 ;;You will be assimilated...
 ;;Resistence is futile...
