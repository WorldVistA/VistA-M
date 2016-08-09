RCDPEMSG ;ALB/TMK - Server interface to CARC/RARC data from Austin ;01/20/15
 ;;4.5;Accounts Receivable;**303**;Mar 20, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Mailman IA 2729
 ; IA 594 - ACCOUNTS RECEIVABLE CATEGORY file (#430.2)
 ; IA 1992 - BILL/CLAIMS file (#399)
 ; IA 3822 - RATE TYPE file (#399.3)
 ; IA 4051 - EXPLANATION OF BENEFITS file (#361.1)
 ; IA 2736 - Mailman
 ;
SERV ; Entry point for server option to process CARC RARC messages received
 ; from Austin. Activated by the option S.RCDPE EDI CARC-RARC SERVER which 
 ; is subscribed to the group G.CARC_RARC_DATA
 ;
 N RCEFLG,RCERR,XMER,RCXMZ,RCTYPE,RCERR
 K ^TMP("RC_CARC_RARC",$J)
 S ^TMP("RC_CARC_RARC",$J,"000")="STARTED-01 "_$G(XMZ)
 S RCXMZ=$G(XMZ)
 ; Read and process the message
 S RCEFLG=$$MSG(RCXMZ,.RCERR)
 D:$G(RCEFLG) EMSG(.RCERR,"G.RCDPE PAYMENTS EXCEPTIONS",RCXMZ)
 ; Remove mail message that has just been processed
 ;D ZAPSERV^XMXAPI("S.RCDPE EDI CARC-RARC SERVER",RCXMZ)
 ;
 S ^TMP("RC_CARC_RARC",$J,"001")="FINISHED"
 ;
 K ^TMP("RC_CARC_RARC",$J)
 ;
 Q
 ;
MSG(RCXMZ,RCERR) ; Read/Store message lines
 ; RCERR = array to hold errors
 ; RCXMZ = Mailman message number to be processed
 ; 
 ; OUTPUT: 0 = No Errors ; 1 = Errors - details in RCERR
 N RCTYP1,RCDATE,RCHD,RCTXN,XMDUZ,RCGBL,RCD,RCFLG,RCCT,RCDXM,X,Y
 N TYPE,CODE,START,MOD,STOP,D0,D1,P1,INREC,DOIT
 S RCFLG=0,INREC=0,RCCT=0,DOIT=1
 S (TYPE,CODE,START,MOD,STOP,D0,D1)=""
 ; Read message, line from mail message is in XMRG variable?
 F  X XMREC Q:XMER<0  S RCCT=RCCT+1,^TMP("RC_CARC_RARC",$J,"MSG",RCCT)=XMRG D
 . S P1=$P(XMRG,U,1)
 . ;If INREC=0 we are between records, skip anything before/in-between/after data records, get next line
 . ;if INREC=1 and P1 is not what we are expecting, then record the error and skip this record when we see the "ZZ" record terminator
 . I (",ZZ,CD,01,02,03,99,")'[(","_P1_",") D:INREC=1 ERR("LINE: "_RCCT_" CODE: "_$G(CODE)_" |"_P1_"|",XMRG,.RCERR) S:INREC=1 DOIT=0 Q
 . E  D
 .. ; If in record and we get a "CD" (new record) or "99" (end of file) Report data error, get next line
 .. I (INREC=1),((P1="CD")!(P1="99")) S X="LINE: "_RCCT_" CODE: "_$G(CODE)_" |"_P1_"|",Y="Out of order record in file message: "_RCXMZ D ERR(X,Y,.RCERR) Q
 .. ; Can't use $CASE which works so, here is the ugly construct to do the same thing
 .. D START(RCCT_" "_P1,XMRG):P1="CD",CODE(RCCT_" "_P1,XMRG):P1="01",DESC(RCCT_" "_P1,XMRG):P1="02",NOTE(RCCT_" "_P1,XMRG):P1="03",END(RCCT_" "_P1,XMRG):P1="ZZ",EOF(RCCT_" "_P1,XMRG):P1="99"
 S:$D(RCERR)>0 RCFLG=1
 Q RCFLG
 ;
ERR(F,LINE,ARR) ; Record a line error
 N EINC
 S ARR("ERROR")=$G(ARR("ERROR"))+1,EINC=ARR("ERROR"),ARR("ERROR",EINC)=F_"  DATA LINE: |"_LINE_"|"
 S ^TMP("RC_CARC_RARC",$J,"00_ERROR",EINC,"MESSAGE_LINE")=F
 S ^TMP("RC_CARC_RARC",$J,"00_ERROR",EINC,"DATA")=LINE
 Q
START(F,LINE) ; "CD" read, set type and indicate a record was entered
 S TYPE=$P(LINE,U,2)
 Q
CODE(F,LINE) ; Process line beginning with "01"
 S CODE=$P(LINE,U,5),START=$P(LINE,U,2),STOP=$P(LINE,U,3),MOD=$P(LINE,U,4),INREC=1
 Q
DESC(F,LINE) ; Process line beginning with "02"
 S D0=$G(D0)_$P(LINE,U,2)
 Q
NOTE(F,LINE) ; Process line beginning with "03"
 S D1=$G(D1)_$P(LINE,U,2)
 Q
END(F,LINE) ; Process record reached end of record indicator "ZZ"
 ; File the entry
 N IX,MISS,ZZ,FILE,DATA
 ; If any of the required fields are missing file an error
 I DOIT=0 S DOIT=1 G EQ ; Found error someplace skip this record and reset DOIT variable 
 I ((TYPE'="CARC")&(TYPE'="RARC"))!(CODE="")!(START="")!(D0="") D  D ERR(F_MISS,LINE) I 1
 . S MISS="Missing Required Data: " S:(TYPE'="CARC")&(TYPE'="RARC") MISS=MISS_" Type of Record: |"_TYPE_"|;"
 . S:CODE="" MISS=MISS_" Code;" S:START="" MISS=MISS_" Start Date;" S:D0="" MISS=MISS_" Description;"
 E  D
 . S DATA=CODE_U_D0_U_START_U_MOD_U_STOP_U_D1
 . ; TYPE should be either CARC or RARC
 . S FILE=$S(TYPE="CARC":345,TYPE="RARC":346,1:0)
 . ;See if this is an existing or new record IEN=0 (new) IEN>0 (existing) 
 . S IEN=$$FIND1^DIC(FILE,"","BX",CODE,"","","RCERR")
 . S ^TMP("RC_CARC_RARC",$J,TYPE)=$G(^TMP("RC_CARC_RARC",$J,TYPE))+1,IX=^(TYPE)
 . S ^TMP("RC_CARC_RARC",$J,TYPE,IX)="IEN: "_IEN_" DATA: "_DATA
 . D FILEIT(FILE,IEN,DATA)
EQ ; End Quit 
 S (CODE,START,MOD,STOP,D0,D1)="",INREC=0
 Q
 ;
EOF(F,LINE) ; Reached end of File indicator
 ; Check error array and see if we need to send an email.
 Q
 ;
FILEIT(FILE,IEN,DATA) ; Add new record or update existing record
 N I,CODE,DESC,START,STOP,NOTE,FDA,FDAIEN,ERR,RCZ,LMOD
 S LMOD=$$NOW^XLFDT
 S I=IEN
 S CODE=$P(DATA,"^",1),DESC=$P(DATA,"^",2),START=$P(DATA,"^",3),MOD=$P(DATA,"^",4),STOP=$P(DATA,"^",5),NOTE=$P(DATA,"^",6)
 S FDA(I,FILE,IEN_",",.01)=CODE
 S FDA(I,FILE,IEN_",",1)=START
 S:STOP'="" FDA(I,FILE,IEN_",",2)=STOP S:MOD'="" FDA(I,FILE,IEN_",",3)=MOD S:NOTE'="" FDA(I,FILE,IEN_",",5)=NOTE S FDA(I,FILE,IEN_",",6)=LMOD
 ; If there is an IEN then update the existing record otherwise add a new record
 I $G(IEN)>0 D FILE^DIE("E",$NA(FDA(I)),"ERR")
 I $G(IEN)=0 D UPDATE^DIE("E",$NA(FDA(I)),"","ERR") S IEN=$$FIND1^DIC(FILE,"","BX",CODE,"","","ERR") ; Need IEN for WP field
 I $D(ERR)>0 S RCZ=$S(IEN=0:"Adding",1:"Updating") D ERR("Error with "_RCZ_" Data","Code: "_CODE_" Processing did not complete correctly")
 D WPINS(DESC,IEN,CODE)
 K FDA(I),ERR
 Q
 ;
WPINS(DATA,REC,CD) ; Insert data into word processing field
 N DIWL,DIWR,DIWF,ERR,LGT,MID,NXT,RCZ
 K ^UTILITY($J,"W") Set DIWL=1,DIWR=80,DIWF=""
 ; Format Description field for insert to word processing field
 ; if description length is less than 950 chars then insert it to the WP field
 I $L(DATA)<950 S X=DATA,DIWL=1,DIWR=80,DIWF="" D ^DIWP
 D:$L(DATA)>949  ; description of 950 characters or greater - split into 2 strings and insert to WP field
 . S LGT=$L(DATA," "),MID=LGT\2,NXT=MID+1
 . S X=$P(DATA," ",1,MID),DIWL=1,DIWR=80,DIWF="" D ^DIWP
 . S X=$P(DATA," ",NXT,LGT) D ^DIWP
 D WP^DIE(FILE,REC_",",4,"K",$NA(^UTILITY($J,"W",1)),"ERR")
 I $D(ERR) D ERR("Error with CODE: "_CODE_"; "_$G(RCZ)_"Data","Record IEN: "_REC_" Wordprocessing field was not updated correctly")
 Q
 ;
 ; Send error e-mail
EMSG(RCERR,RCEMG,RCXMZ) ; Process Errors - Send bulletin to mail group
 ; RCERR = Error text array
 ; RCEMG = name of the mail group to which these errors should be sent
 ; RCXMZ = internal entry # of the mailman msg with errors
 N CT,XMDUZ,XMSUBJ,XMBODY,XMB,XMINSTR,XMTYPE,XMFULL,XMTO,RCXM,RCBODY,RCSUBJ,XMZ,XMERR,Z
 ;
 S CT=0
 ;
 ; Set the error text into RCBODY array to send to mailman
 S RCSUBJ=$$ZSUBJ^XMXUTIL2(RCXMZ)
 S Z=12,RCBODY(1)="ERRORS found processing CARC & RARC data file from FSC:"
 S RCBODY(2)=""
 S RCBODY(3)="The data record within the received message does NOT match the expected format"
 S RCBODY(4)="for VistA to import. Please note that these CARC/RARC codes were NOT updated in"
 S RCBODY(5)="VistA and should be retransmitted from the FSC when fixed."
 S RCBODY(6)=""
 S RCBODY(7)="Mailman Message: "_RCXMZ_" The subject of that message is:"
 S RCBODY(8)="    "_RCSUBJ
 S RCBODY(9)="This message will contain the full text. Line numbers should correspond to"
 S RCBODY(10)="line number in the body of that message."
 S RCBODY(11)=""
 S RCBODY(12)="-----------------------------------------------------------------"
 F  S CT=$O(RCERR("ERROR",CT)) Q:CT=""  S Z=Z+1,RCBODY(Z)=RCERR("ERROR",CT)
 S Z=Z+1,RCBODY(Z)="-----------------------------------------------------------------"
 ;
 I $D(RCEMG) D
 . S:RCEMG="" RCEMG="RCDPE PAYMENTS EXCEPTIONS"
 . S:$E(RCEMG,1,2)'="G." RCEMG="G."_RCEMG
 . S XMTO("I:"_RCEMG)=""
 ;
 S Z=$O(XMTO("")) I Z=.5,'$O(XMTO(.5)) S XMTO("I:G.RCDPE PAYMENTS EXCEPTIONS")=""
 ;
 S XMDUZ=""
 S XMSUBJ="EDI CARC_RARC SERVER OPTION ERROR",XMBODY="RCBODY"
 D
 . N DUZ S DUZ=.5,DUZ(0)="@"
 . D SENDMSG^XMXAPI(DUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 Q
 ;
