TIUPEVNT ; SLC/JER - Event logger for upload/filer ;3/30/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**3,21,81,131,113,184**;Jun 20, 1997
MAIN(BUFDA,ETYPE,ECODE,TIUTYPE,FDA,MSG) ; ---- Controls branching
 N EVNTDA
 ; ---- ETYPE = 1: Filing error event
 ; ---- ETYPE = 2: Missing/incorrect field error event
 ; ---- ETYPE = 0: Other event (no errors)
 D LOG(BUFDA,ETYPE,$G(ECODE),$G(TIUTYPE),.EVNTDA,.FDA,.MSG)
 I ETYPE=2 D FIELDS^TIUPEVN1(EVNTDA,.MSG)
 Q
LOG(BUFDA,ETYPE,ECODE,TIUTYPE,EVNTDA,FDA,MSG) ; ---- Register event in 
 ;                                              TIU UPLOAD LOG file
 ;                                              (#8925.4)
 N BUFREC,ERRMSG,NEWBUF,DIC,DLAYGO,DIE,DA,DR,TIUK,TIUL,X,Y
 S BUFREC=$G(^TIU(8925.2,+BUFDA,0))
 S (DIC,DLAYGO)=8925.4,DIC(0)="MLX",X=""""_$$NOW^TIULC_"""" D ^DIC
 Q:+Y'>0
 ; ---- File upload log record
 S DIE=DIC,(EVNTDA,DA)=+Y,ERRMSG=$$ERRMSG(ETYPE,ECODE,TIUTYPE,.FDA,.MSG)
 S DR=".02////"_$P(BUFREC,U,2)_";.03////"_TIUTYPE_";.04////"_ERRMSG_";.06////"_$S(+ETYPE:0,1:"")_";.08////"_ETYPE_";.09////"_$S($G(TIUINST):TIUINST,1:DUZ(2))
 D ^DIE K DA
 I ETYPE'=1 Q
 ; ---- Store Header of failed record in log
 S ^TIU(8925.4,+EVNTDA,"HEAD",0)="^^^^"_DT_"^"
 S TIUL=0 F TIUK=TIUFRST:1:$S($P(TIUPRM0,U,16)="C":TIUI,1:TIUFRST+1) D
 . S TIUL=TIUL+1,^TIU(8925.4,+EVNTDA,"HEAD",TIUL,0)=$G(^TIU(8925.2,+BUFDA,"TEXT",TIUK,0))
 S $P(^TIU(8925.4,+EVNTDA,"HEAD",0),U,3,4)=TIUL_U_TIUL
 ; ---- Create a new buffer entry w/ uploaded data
 S NEWBUF=$$MAKEBUF^TIUUPLD
 I +NEWBUF>0 D
 . N TIUJ,TIUL,TIUBLIN
 . S ^TIU(8925.2,+NEWBUF,"TEXT",0)="^^^^"_DT_"^"
 . S TIUJ=TIUFRST,TIUL=1
 . S ^TIU(8925.2,+NEWBUF,"TEXT",TIUL,0)=$G(^TIU(8925.2,+BUFDA,"TEXT",TIUJ,0)) K ^TIU(8925.2,+BUFDA,"TEXT",TIUJ,0)
 . F  S TIUJ=$O(^TIU(8925.2,+BUFDA,"TEXT",TIUJ)) Q:$S(+TIUJ'>0:1,($G(^TIU(8925.2,+BUFDA,"TEXT",TIUJ,0))[TIUHSIG):1,1:0)  D
 . . S TIUL=TIUL+1
 . . S ^TIU(8925.2,+NEWBUF,"TEXT",TIUL,0)=$G(^TIU(8925.2,+BUFDA,"TEXT",TIUJ,0)),TIUI=TIUJ
 . . K ^TIU(8925.2,+BUFDA,"TEXT",TIUJ,0)
 . S $P(^TIU(8925.2,+NEWBUF,"TEXT",0),U,3,4)=TIUL_U_TIUL
 . ; ---- Stuff new buffer entry pointer into event log file
 . S DIE=8925.4,DA=+EVNTDA,DR=".05////"_+NEWBUF D ^DIE
 . ; ---- File the error log pointer in buffer file
 . S ^TIU(8925.2,+NEWBUF,"ERR",0)="^8925.22PA^^",DLAYGO=8925.22
 . S DA(1)=+NEWBUF,DIC="^TIU(8925.2,"_+DA(1)_",""ERR"",",DIC(0)="L"
 . S X="`"_EVNTDA
 . D ^DIC
 . K DIC,DLAYGO
 . ; ---- Send filing error alerts
 . D ALERT(+NEWBUF,.ERRMSG,.EVNTDA)
 Q
ERRMSG(ETYPE,ECODE,TIUTYPE,FDA,MSG) ; ---- Set error messages
 N DIC,DIE,DA,X,Y
 I +ETYPE'>0 S Y="" G ERRMSX
 S TIUTYPE=$S($G(TIUTITLE)]"":$G(TIUTITLE),1:$G(TIUTYPE))
 I +$G(TIUREC("FILE"))=8925,($G(TIUHDR(.09))="PRIORITY"),($G(TIUTYPE)]"") S TIUTYPE="STAT "_$G(TIUTYPE)
 ; ---- Set filing error message
 I +ETYPE=1,+ECODE D  G ERRMSX
 . S DIC=8925.3,DIC(0)="MXZ",X="`"_ECODE D ^DIC
 . S Y="FILING ERROR: "_$G(TIUTYPE)_" "_$P(Y(0),U,2)
 ; ---- If target file is 8925, get info on entry & set missing fld msg
 I $G(MSG("DIERR",1,"PARAM","FILE"))=8925 D  G ERRMSX
 . N TIU,DA S DA=+$O(FDA(8925,"")) D GETTIU^TIULD(.TIU,DA)
 . S Y=$$NAME^TIULS(TIU("PNM"),"LAST,FI MI ")
 . S:$G(TIUHDR("TIUTITLE"))]"" TIUTYPE=TIUHDR("TIUTITLE")
 . S Y=Y_TIU("PID")_": "_$$DATE^TIULS(+TIU("EDT"),"MM/DD/YY ")_$G(TIUTYPE)_" is missing fields."
 ; ---- Otherwise get message from FM Filer error msg array
 S Y=$G(MSG("DIERR",1,"TEXT",1))
ERRMSX Q Y
ALERT(BUFDA,ERRMSG,EVNTDA) ; ---- Send alerts for filing errors
 N BUFREC,XQA,XQAID,XQADATA,XQAMSG,XQAKILL,XQAROU,TIUI,TIUSUB,TYPE
 S BUFREC=$G(^TIU(8925.2,+BUFDA,0))
 ; ---- TIU*1*81 TIUHDR is newed in MAIN+11^TIUPUTC, set in
 ;      GETREC^TIUPUTC1, so it exists for file errs.
 S TYPE=+$$WHATITLE^TIUPUTU($G(TIUHDR("TIUTITLE")))
 I TYPE'>0 S TYPE=+$G(TIUREC("TYPE"))
 I TYPE N TIUDAD D WHOGETS^TIUPEVN1(.XQA,TYPE) ;TIU*1*81 New TIUDAD here, not in WHOGETS
 ;  ---- If no 8925.95 (Document Parameter) recipients, get 8925.99
 ;       (Site Parameter) recipients
 I $D(XQA)'>9 D
 . S TIUI=$O(^TIU(8925.99,"B",+$G(DUZ(2)),0)) S:+TIUI'>0 TIUI=+$O(^TIU(8925.99,0))
 . S TIUSUB=0 F  S TIUSUB=$O(^TIU(8925.99,+TIUI,2,TIUSUB)) Q:TIUSUB'>0  D
 . . S XQA($G(^TIU(8925.99,+TIUI,2,TIUSUB,0)))=""
 Q:$D(XQA)'>9
 S XQAID="TIUERR"_+BUFDA
 S XQAMSG=ERRMSG
 W:'$D(ZTQUEUED) !!,XQAMSG,!
 S XQADATA=BUFDA_";"_ERRMSG_";"_EVNTDA_";"_$G(TIUREC("TYPE"))
 S XQAROU="DISPLAY^TIUPEVNT"
 D SETUP^XQALERT
 Q
DISPLAY ; ---- Alert followup action for filing errors
 N DIC,INQUIRE,RETRY,DWPK,EVNTDA,TIU K XQAKILL,RESCODE,TIUTYPE,TIUDONE
 N TIUEVNT,TIUSKIP,TIUBUF,PRFILERR
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 ; Set EVNTDA for backward compatibility, TIUEVNT for PN resolve code
 S (EVNTDA,TIUEVNT)=+$P(XQADATA,";",3)
 ; Set TIUBUF for similarity w TIURE.  DON'T set BUFDA since
 ; old code interprets that as set by TIURE only:
 S TIUBUF=+XQADATA
 I TIUEVNT D  I +$G(TIUDONE)!$G(TIUSKIP) G DISPX
 . D WRITEHDR(TIUEVNT)
 . S TIUTYPE=+$P(XQADATA,";",4)
 . I TIUTYPE>0 S RESCODE=$$FIXCODE^TIULC1(TIUTYPE)
 . ;E  S RESCODE="D GETPAT^TIUCHLP"
 . I $G(RESCODE)]"" D  Q
 . . W ! S INQUIRE=$$READ^TIUU("YO","Inquire to patient record","YES","^D INQRHELP^TIUPEVNT")
 . . I $D(DIRUT) S TIUSKIP=1 Q
 . . I +INQUIRE X RESCODE
 . . ; Redundant if all RESCODEs do RESOLVE:
 . . I +$G(TIUDONE),+$G(TIUEVNT) D RESOLVE(+$G(TIUEVNT))
 . W !!,"Filing error resolution code could not be found for this document type.",!,"Please edit the buffered data directly and refile."
 W !!,"You may now edit the buffered upload data in an attempt to resolve error:",!,$P(XQADATA,";",2),!
 I '$$READ^TIUU("EA","Press RETURN to continue and edit the buffer or '^' to exit: ") G DISPX
 S DIC="^TIU(8925.2,"_TIUBUF_",""TEXT"",",DWPK=1 D EN^DIWE
 S RETRY=$$READ^TIUU("YO","Now would you like to retry the filer","YES","^D FIL^TIUDIRH")
 ; -- If refiling, tell Patient Record Flag LOOKUP to ask for flag link:
 I +RETRY S PRFILERR=1
 ; -- Refile
 I +RETRY D ALERTDEL(TIUBUF)
 I +RETRY D RESOLVE(TIUEVNT,1)
 I +RETRY D FILE^TIUUPLD(TIUBUF)
DISPX K XQX1
 Q
WRITEHDR(EVNTDA) ; ---- Write header to screen
 ;Write header, as stored in Upload Log event (NOT buffer record,
 ;which can be edited w/o refiling)
 N TIUI
 S TIUI=0
 W !!,"The header of the original, failed record looks like this:",!
 F  S TIUI=$O(^TIU(8925.4,+EVNTDA,"HEAD",TIUI)) Q:+TIUI'>0  D
 . W !,$G(^TIU(8925.4,+EVNTDA,"HEAD",TIUI,0))
 Q
ALERTDEL(DA) ; ---- Delete alerts associated with a given record
 N XQA,XQAID,XQAKILL S XQAID="TIUERR"_+DA
 F  D DELETEA^XQALERT S XQAID="TIUERR"_+DA Q:'$D(^VA(200,"AXQAN",XQAID))
 Q
RESOLVE(EVNTDA,ECHO) ; ---- Indicate resolution of error
 N DA,DIE,DR,TIUI,RESTIME,X,Y
 W:+$G(ECHO) !,"Filing Record/Resolving Error..."
 S RESTIME=$$NOW^TIULC
 S DIE="^TIU(8925.4,"
 S DA=+$G(EVNTDA) Q:+DA'>0
 ; ---- If already resolved, Quit. (Go on to next record)
 I +$P(^TIU(8925.4,DA,0),U,6)>0 Q
 ; ---- Mark error log record as resolved
 S DR=".05///@;.06////1;.07////"_RESTIME_";1///@"
 D ^DIE
 Q
INQRHELP ; Help for Upload Error Inquire to Patient Record prompt
 W !,"Do you wish to be prompted for the data necessary to resolve the filing error?"
 W !,"If not, answer NO to proceed and edit the buffered data directly without"
 W !,"prompts, or enter '^' to come back and resolve the error later."
 Q
