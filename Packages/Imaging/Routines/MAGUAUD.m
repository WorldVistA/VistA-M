MAGUAUD ;WOIFO/MLH/NST - Audit log RPC ; 31 Dec 2010 03:45 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
INPUTSEP() ; Name value separator for input data ie. NAME`TESTPATIENT   
 Q "`"
EVENT(OUT,EVENT,HOST,APP,MESSAGE,DATA) ; rpc MAG EVENT AUDIT
 N ERRIX,ERRMSG,FDA,IENS,I,J,ISEP,ATT,VALUE,APPIEN
 K OUT
 ; Get application. It will be added if it is not in the file.
 S:$G(APP)'="" APPIEN=$$GETIEN^MAGVAF05(2006.9193,APP,1)
 S FDA(2006.93,"+1,",.01)="N"
 S FDA(2006.93,"+1,",1)=$G(EVENT)
 S FDA(2006.93,"+1,",2)=$G(HOST)
 S FDA(2006.93,"+1,",3)=$G(APP)
 S FDA(2006.93,"+1,",4)=$G(MESSAGE)
 S I="",ISEP=$$INPUTSEP
 F  S I=$O(DATA(I)) Q:I=""  D
 . S ATT=$P(DATA(I),ISEP,1)
 . S VALUE=$P(DATA(I),ISEP,2)
 . S J=I+1,IENS="+"_J_",+1,"
 . S FDA(2006.935,IENS,.01)=ATT
 . S FDA(2006.935,IENS,1)=VALUE
 . Q
 D UPDATE^DIE("E","FDA")
 S ERRIX=0
 F  S ERRIX=$O(^TMP("DIERR",$J,ERRIX)) Q:'ERRIX  D
 . S ERRMSG=-$G(^TMP("DIERR",$J,ERRIX))_","
 . S ERRMSG=ERRMSG_$G(^TMP("DIERR",$J,ERRIX,"TEXT",1))
 . S OUT($O(OUT(""),-1)+1)=ERRMSG
 . Q
 I '$D(OUT) S OUT(1)=0 ; no error
 Q
