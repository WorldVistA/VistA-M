WVRPCGF ;ISP/AGP - APIs for Clinical Reminders ;10/03/2019
 ;;1.0;WOMEN'S HEALTH;**24**;Sep 30, 1998;Build 582
 ; This routine uses the following IAs:
 ; #10035 - FILE 2          (supported)
 ;
 ; This routine supports the following IAs:
 ; NEW     - 4104
 ;
 ;
CASCADE(RESULT,INPUTS,ID,PAT) ;
 N EPISODE
 ;close reminder episode TODO: needs to be replace with sometype of file driver eventually
 S EPISODE("DFN")=PAT
 S EPISODE("NAME")=INPUTS("DATA",790.1,ID,"NAME")
 ;S EPISODE("STATUS")="CLOSED"
 D CLOSE^PXRMEOC(.RESULT,.EPISODE)
 Q
 ;
FPRONNOT(RESULT,TYPE,FDATE,PAT) ;
 N DATE,IEN,NODE,PROV
 S IEN=0 F  S IEN=$O(^WV(790.1,"S","o",IEN)) Q:IEN'>0  D
 .S NODE=$G(^WV(790.1,IEN,0))
 .I $P(NODE,U,2)'=PAT Q
 .S DATE=+$P(NODE,U,12) Q:DATE'>0
 .I +FDATE>0,DATE'=FDATE Q
 .I TYPE="BR",$P(NODE,U,15)="" Q
 .I TYPE="CX",$P(NODE,U,15)'="" Q
 .S RESULT(IEN)=$P(NODE,U,7)
 Q
 ;
FNDOPNOT(RESULT,TYPE,START,END) ;
 N ACCESS,IEN,NODE,PAT,PROCLIST
 D FINDOPEN(.RESULT,TYPE,START,END)
 Q
 ;
FINDOPEN(RESULT,TYPE,START,END) ;
 N DATE,IEN,WNNODE,WPNODE,WNIEN,WVIEN
 S DATE=START F  S DATE=$O(^WV(790.4,"AOPEN",DATE)) Q:DATE'>0!(DATE>END)  D
 .S WNIEN=0 F  S WNIEN=$O(^WV(790.4,"AOPEN",DATE,WNIEN)) Q:WNIEN'>0  D
 ..S WNNODE=$G(^WV(790.4,WNIEN,0)) Q:WNNODE=""
 ..I $P(WNNODE,U,3)>0 Q
 ..I $P(WNNODE,U,14)="C" Q
 ..S WVIEN=$P(WNNODE,U,6) Q:WVIEN'>0
 ..S WPNODE=$G(^WV(790.1,WVIEN,0))
 ..I TYPE="BR",$P(WPNODE,U,15)="" Q
 ..I TYPE="CX",$P(WPNODE,U,15)'="" Q
 ..I +$P(WPNODE,U,5)=0 Q
 ..I $P(WPNODE,U,36)=1 Q
 ..S RESULT($P(WPNODE,U,2),WVIEN)=WPNODE
 Q
 ;
FORMTX(PAT,WVTRMTS,INPUTS,CLEARNXT) ;
 N DAYS,FIELD,FUDATE,ID,PROCIEN
 S ID="" F  S ID=$O(INPUTS("DATA",790,ID)) Q:ID=""  D
 .S PROCIEN=0,DAYS=""
 .F FIELD=.18,.19 D
 .. K VALUE
 .. S VALUE=$G(INPUTS("DATA",790,ID,FIELD))
 .. I FIELD=.18,VALUE'="" S PROCIEN=$S(VALUE'="DELETE":$O(^WV(790.51,"B",VALUE,"")),1:"DELETE") Q
 .. S DAYS=VALUE
 .I PROCIEN=0 Q
 .I PROCIEN="DELETE",DAYS="DELETE" S CLEARNXT=1 Q
 .I +DAYS>0 S FUDATE=$$FMADD^XLFDT(DT,DAYS)
 .I +DAYS=0,+PROCIEN>0 D TERMEVAL(PAT,.FUDATE)
 .I FUDATE<DT S FUDATE=0
 .I FUDATE>0 S WVTRMTS("BR",+$G(FUDATE))=PROCIEN
 Q
 ;
FORMNOT(PAT,PURARR,WVTRMTS,INPUTS,NOTTYPE,WVDATA) ;
 N AGE,CONTDATE,CONTWHO,DIFF,DIFFDAYS,DOB,FUDATE,INC,OUTCOME,PROCDATE,PRINTER,TMP,TYPE,X
 S TYPE="",OUTCOME="",CONTDATE="",CONTWHO="",PRINTER=""
 S INC="" F  S INC=$O(INPUTS("DATA",790.4,INC)) Q:INC=""  D
 .; find purpose 
 .S TMP=$G(INPUTS("DATA",790.4,INC,.04))
 .S PURIEN=0
 .I TMP'="" D
 ..S PURIEN=$O(^WV(790.404,"B",TMP,""))
 ..I PURIEN>0 S PURARR(PURIEN)=""
 .;notification type
 .S TMP=$G(INPUTS("DATA",790.4,INC,.03)) I TMP'="" S TYPE=$O(^WV(790.403,"B",TMP,"")),NOTTYPE("TYPE")=TYPE
 .;notification outcome
 .S TMP=$G(INPUTS("DATA",790.4,INC,.05)) I TMP'="" S OUTCOME=$O(^WV(790.405,"B",TMP,""))
 .;printer
 .S PRINTER=$G(INPUTS("DATA",790.4,INC,"PRINTER"))
 .; who was notified only updated for Phone Call and In-Person
 .S CONTWHO=$G(INPUTS("DATA",790.4,INC,1)),CONTDATE=$G(INPUTS("DATA",790.4,INC,2))
 .I CONTWHO'="" S NOTTYPE("WHO")=CONTWHO
 .I CONTDATE'="" S NOTTYPE("WHEN")=CONTDATE
 .;set the next treatment date (F/U Date) to the standard evalaution for the patient age. (Needs to be smarter)
 .;I $D(INPUTS("DATA",790.4,INC,"AGE BASE DATE")) S FUDATE=$$GETAGEDT(PAT)
 .S PROCDATE=DT
 .;WVDATA(0)="160^1^28^^3171101"
 .I $D(WVDATA) D
 ..S X="" F  S X=$O(WVDATA(X)) Q:X=""  D
 ...I +$P($G(WVDATA(X)),U,5)'>0 Q
 ...I +$P($G(WVDATA(X)),U,5)<PROCDATE S PROCDATE=+$P($G(WVDATA(X)),U,5)
 .D GETDATES(.WVTRMTS,PURIEN,PAT,.FUDATE,PROCDATE)
 S INC=0 F  S INC=$O(PURARR(INC)) Q:INC'>0  S PURARR(INC)=TYPE_U_OUTCOME_U_CONTDATE_U_CONTWHO_U_PRINTER
 Q
 ;
FORMRES(RESULTS,ID,INPUTS) ;
 N COMMENT,DATE,ISHIST,PROCIEN,TMP,WVDX,WVIEN,X
 S COMMENT="",DATE=0,ISHIST=0,PROCIEN=0,WVDX=0
 ; get diagnosis
 S TMP=$G(INPUTS("DATA",790.1,ID,.05)) I TMP'="" S WVDX=$O(^WV(790.31,"B",TMP,""))
 I $G(INPUTS("DATA",790.1,ID,.36))="TRUE" D
 .S ISHIST=1
 .S DATE=+$G(INPUTS("DATA",790.1,ID,.12))
 .;find WV Procedure for historical updates
 .S TMP=$G(INPUTS("DATA",790.1,ID,.04)) I TMP="" Q
 .S PROCIEN=+$O(^WV(790.2,"B",TMP,""))
 I ISHIST=1,PROCIEN>0 S RESULTS(0)=WVDX_U_ISHIST_U_PROCIEN_U_COMMENT_U_DATE Q
 S COMMENT=$G(INPUTS("DATA",790.1,ID,3.01))
 F X=1:1:$L(ID,":") D
 .S WVIEN=+$P(ID,":",X)
 .S RESULTS(WVIEN)=WVDX_U_ISHIST_U_PROCIEN_U_COMMENT
 Q
 ;
NEW(RESULTS,INPUTS) ;
 N CLEAR,ENCPROV,ID,NOTE,NOTTYPE,PAT,PURARR,REG,USER,TMP,VISIT,WVDATA,WVIEN,WVTRMTS,WV79023,X
 S TMP=$G(INPUTS("VISIT")),WVDX=""
 S NOTE=+$G(INPUTS("DOCUMENT"))
 S PAT=INPUTS("DFN")
 S ENCPROV=$G(INPUTS("ENCOUNTER PROVIDER"))
 S USER=$G(INPUTS("USER"))
 S ID=$G(INPUTS("DATA",790.1,"MASTER ID"))
 I ID="" S ID="+1,"
 S VISIT=$S(TMP'="":$$GETENC^PXAPI(PAT,$P(TMP,";",2),$P(TMP,";")),1:"")
 I VISIT<1 S VISIT=""
 S CLEARNXT=0
 I $D(INPUTS("DATA",790)) D FORMTX(PAT,.WVTRMTS,.INPUTS,.CLEARNXT)
 I $D(INPUTS("DATA",790.1)) D FORMRES(.WVDATA,ID,.INPUTS)
 D FORMNOT(PAT,.PURARR,.WVTRMTS,.INPUTS,.NOTTYPE,.WVDATA)
 I '$D(PURARR),$D(NOTTYPE) D SETOPNOT(.RESULT,.WVDATA,.NOTTYPE,.INPUTS,PAT) I $G(RESULT(1))="" S RESULT(1)=1 Q
 M WV79023=INPUTS("DATA",790.23)
 S WVIEN="" F  S WVIEN=$O(WVDATA(WVIEN)) Q:WVIEN=""  D
 .D PROCESS(.RESULT,PAT,VISIT,NOTE,ID,WVIEN,USER,ENCPROV,.WVDATA,.PURARR,.WV79023)
 D SETDATES(.RESULT,.WVTRMTS,PAT,.CLEARNXT)
 I $D(INPUTS("DATA",790.1,ID,"STATUS")),$G(RESULT(1))="" D CASCADE(.RESULT,.INPUTS,ID,PAT)
 I $G(RESULT(1))="" S RESULT(1)=1
 Q
 ;
PROCESS(RESULT,PAT,VISIT,NOTE,ID,WVIEN,USER,ENCPROV,WVDATA,PURARR,WV79023) ;
 N COMMENT,DATE,ISHIST,NODE,PROCIEN,WVDX,TIMESTAMP
 S TIMESTMP=$$NOW^XLFDT
 ;WVDX_U_ISHIST_U_PROCIEN_U_COMMENT
 S NODE=WVDATA(WVIEN)
 S WVDX=$P(NODE,U),ISHIST=$P(NODE,U,2)
 S PROCIEN=$P(NODE,U,3),COMMENT=$P(NODE,U,4),DATE=$P(NODE,U,5)
 ;set results non-historical entry, WV Procedure already exist
 I WVDX'="",WVIEN>0 D SETRESLT(.RESULT,WVIEN,WVDX,COMMENT,$G(TIMESTMP),$G(VISIT),NOTE,.WV79023)
 ;set results historical entry, WV Procedure does not exist
 I WVDX'="",+WVIEN=0,PROCIEN>0,ISHIST=1 D ADDHRSLT(.RESULT,.WVIEN,PAT,PROCIEN,WVDX,COMMENT,$G(TIMESTMP),$G(VISIT),NOTE,ISHIST,.WV79023,DATE,USER,ENCPROV)
 ;
 ;notification type
 D ADDNOTS(.RESULT,.INPUTS,ID,WVIEN,PAT,.PURARR)
PROCESSX ;
 Q
 ;
ADDITEMS(WV79023,WVFDA,WVIEN,TIMESTMP,VISIT,NOTE) ;
 N CNT,FIELD,IENS,ISHIST,TMP
 S ISHIST=0
 I WVIEN=0 S WVIEN=1,ISHIST=1
 S CNT="" F  S CNT=$O(WV79023(CNT)) Q:CNT=""  D
 .S FIELD="" F  S FIELD=$O(WV79023(CNT,FIELD)) Q:FIELD=""  D
 ..S TMP=$G(WV79023(CNT,FIELD)) I TMP="" Q
 ..S IENS=$S(ISHIST=0:CNT_WVIEN_",",ISHIST=1:+CNT+1_",+1,",1:"")
 ..I IENS="" Q
 ..I ISHIST=1 S IENS="+"_IENS
 ..S WVFDA(790.23,IENS,FIELD)=TMP
 ..I TIMESTMP'="" S WVFDA(790.23,IENS,1)=TIMESTMP
 ..I VISIT'="" S WVFDA(790.23,IENS,2)=VISIT
 ..I NOTE>0 S WVFDA(790.23,IENS,3)=NOTE
 Q
 ;
 ;add outside report procedure
ADDHRSLT(RESULT,WVIEN,PAT,PROCIEN,WVRESULT,COMMENT,TIMESTMP,VISIT,NOTE,ISHIST,WV79023,DATE,USER,ENCPROV) ;
 N ACCESS,WVERR,WVFDA,WVAIEN,WVNEWP,PERSON
 S PERSON=$S(ENCPROV'="":ENCPROV,1:USER)
 S ACCESS=$$ACCSSN^WVUTL5(PROCIEN)
 S WVFDA(790.1,"+1,",.01)=ACCESS
 S WVFDA(790.1,"+1,",.02)=PAT
 S WVFDA(790.1,"+1,",.04)=PROCIEN
 S WVFDA(790.1,"+1,",.05)=WVRESULT
 I $G(PERSON)'="" S WVFDA(790.1,"+1,",.07)=PERSON
 S WVFDA(790.1,"+1,",.12)=DATE
 S WVFDA(790.1,"+1,",.14)="c"
 I COMMENT'="" S WVFDA(790.1,"+1,",3.01)=COMMENT
 I $D(WV79023) D ADDITEMS(.WV79023,.WVFDA,WVIEN,TIMESTMP,VISIT,NOTE)
 S WVFDA(790.1,"+1,",.36)=$S(ISHIST="1":1,1:"0")
 D UPDATE^DIE("","WVFDA","WVAIEN","WVERR")
 I $D(WVERR) D  Q
 .S RESULT(1)="-1^Error updating the procedure data"
 .S NUM=0
 .S NUM=NUM+1,^TMP("PXRMXMZ",$J,NUM,0)="Error adding Women's Health Procedure to the WV PROCEDURE FILE."
 .D BLDMSG^WVRPCGF1(PAT,"ERROR Updating WV PROCEDURE File",.NUM)
 S WVIEN=WVAIEN(1)
 ;update existing Episode TODO: needs to be replace with sometype of file driver eventually
 K WVERR
 D ADD^PXRMEOC(PAT,TIMESTMP,WVIEN_";WV(790.1,",1,0,"BREAST CARE",.WVERR)
 I '$D(WVERR) Q
 S NUM=0
 S NUM=NUM+1,^TMP("PXRMXMZ",$J,NUM,0)="Error adding Women's Health Procedure to the patient episode file."
 D BLDMSG^WVRPCGF1(PAT,"ERROR Updating Episode of Care File.",.NUM)
 Q
 ;
 ;set result for procedure already in the WV package
SETRESLT(RESULT,WVIEN,WVRESULT,COMMENT,TIMESTMP,VISIT,NOTE,WV79023) ; Update the RESULTS/DIAGNOSIS field (.05)
 ;
 N CNT,FIELD,NUM,OUTPUT,TMP,WVERR,WVDXFLAG,WVFAC,WVFDA,WVNODE,WVPAT
 I $G(WVIEN)'>0 Q
 D UPDATE^WVALERTS(WVIEN) ;mark procedure as processed by CR
 ;I $G(WVRESULT)'>0 Q
 ; Check 'update results/dx?' parameter
 S WVNODE=$G(^WV(790.1,+WVIEN,0))
 S WVFAC=+$P(WVNODE,U,10)
 S WVDXFLAG=$P($G(^WV(790.02,+WVFAC,0)),U,11)
 Q:'WVDXFLAG
 I $P(WVNODE,U,5)="" S WVFDA(790.1,WVIEN_",",.05)=WVRESULT
 S WVFDA(790.1,WVIEN_",",.14)="c"
 I COMMENT'="" S WVFDA(790.1,WVIEN_",",3.01)=COMMENT
 I $D(WV79023) D ADDITEMS(.WV79023,.WVFDA,WVIEN,TIMESTMP,VISIT,NOTE)
 D UPDATE^DIE("","WVFDA","","WVERR")
 I $D(WVERR) D  Q
 .S RESULT(1)="-1^Error updating procedure data"
 .S NUM=0
 .S NUM=NUM+1,^TMP("PXRMXMZ",$J,NUM,0)="Error adding Women's Health Procedure to the WV PROCEDURE FILE."
 .D BLDMSG^WVRPCGF1(PAT,"ERROR Updating WV PROCEDURE File",.NUM)
 S WVPAT=$P($G(^WV(790.1,WVIEN,0)),U,2) Q:WVPAT'>0
 ;update existing Episode TODO: needs to be replace with sometype of file driver eventually
 D ADD^PXRMEOC(WVPAT,TIMESTMP,WVIEN_";WV(790.1,",1,0,"BREAST CARE",.WVERR)
 I '$D(WVERR) Q
 S NUM=0
 S NUM=NUM+1,^TMP("PXRMXMZ",$J,NUM,0)="Error adding Women's Health Procedure to the patient episode file."
 D BLDMSG^WVRPCGF1(PAT,"ERROR Updating Episode of Care File.",.NUM)
 Q
 ;
 ;check to see if notifications should be added, loop through each notification
ADDNOTS(RESULT,INPUTS,ID,WVIEN,WVDFN,PURARR) ;
 ;
 N DFN,NODE,WVERRADD,WVFAC,WVNODE,WVNPFLAG,WVPDATE,WVPURP
 N WVTYPE,WVOUTCOM,WVPRINTR,WVFUDATE,WVCONWHO,WVCONDTE
 ;TYPE_U_OUTCOME_U_CONTDATE_U_CONTWHO
 ;process each procedure
 S WVPURP=0 F  S WVPURP=$O(PURARR(WVPURP)) Q:WVPURP'>0  D
 .I '$D(^WV(790.404,+$G(WVPURP),0)) Q  ;purpose
 .S NODE=PURARR(WVPURP)
 .S WVTYPE=$P(NODE,U),WVOUTCOM=$P(NODE,U,2)
 .S WVCONDTE=$P(NODE,U,3),WVCONWHO=$P(NODE,U,4)
 .S WVPRINTR=$P(NODE,U,5)
 .I WVIEN'>0 Q
 .D SETNOT(.RESULT,.INPUTS,.WVTRMTS,WVIEN,WVPURP,WVTYPE,WVOUTCOM,WVPRINTR,WVDFN,WVCONWHO,WVCONDTE)
 ; if a purpose and type, check other notification in the Episode for lack of type of notification. If found update
 I $D(PURARR),WVTYPE'="" D SETNOTO(.RESULT,ID,.INPUTS,WVDFN,WVTYPE)
 Q
 ;
 ;add the notification record to file 790.4
SETNOT(RESULT,INPUTS,WVTRMTS,WVIEN,WVPURP,WVTYPE,WVOUTCUM,WVPRINTR,WVDFN,WVCONWHO,WVCONDTE,WVPDATE) ;
 N DLAYGO
 N WVDA7904,WVDXFLAG,WVERR,WVFAC,WVFDA,WVFDAIEN,WVLDAT,WVLPRG,WVTXFLAG
 ;
 I '$G(WVFAC) S WVFAC=DUZ(2) ;facility ien
 S WVDXFLAG=$P($G(^WV(790.02,+WVFAC,0)),U,11,12)
 S WVTXFLAG=$P(WVDXFLAG,U,2) ;update treatment needs?
 S WVDXFLAG=$P(WVDXFLAG,U,1) ;update results/dx?
 S:$G(WVPDATE)'>0 WVPDATE=DT ;use today if no procedure date 
 I $G(WVPRINTR)]"" S WVOUTCUM=$$GETOIEN^WVRPCNO1("Letter Sent")
 ; create File 790.4 entry
 S WVFDA(790.4,"+1,",.01)=WVDFN ;DFN
 S WVFDA(790.4,"+1,",.02)=DT ;date opened
 I $G(WVTYPE)'="" S WVFDA(790.4,"+1,",.03)=WVTYPE ;type
 S WVFDA(790.4,"+1,",.04)=WVPURP ;purpose
 S WVFDA(790.4,"+1,",.05)=WVOUTCUM ;outcome
 I +$G(WVIEN)>0 S WVFDA(790.4,"+1,",.06)=$G(WVIEN) ;wh accession #
 S WVFDA(790.4,"+1,",.07)=$S($G(WVFAC):$G(WVFAC),1:DUZ(2)) ;facility
 I $G(WVTYPE)'="" S WVFDA(790.4,"+1,",.08)=DT ;date closed
 I WVCONWHO'="" S WVFDA(790.4,"+1,",1)=WVCONWHO
 I WVCONDTE'="" S WVFDA(790.4,"+1,",2)=WVCONDTE
 I $P($G(^WV(790.403,+$G(WVTYPE),0)),U,2)=1 S WVFDA(790.4,"+1,",.11)=DT ;print date
 S WVFDA(790.4,"+1,",.13)=DT ;complete by date
 I $G(WVTYPE)'="" S WVFDA(790.4,"+1,",.14)="c" ;status
 D UPDATE^DIE("","WVFDA","WVFDAIEN","WVERR")
 I $D(WVERR) D
 .S RESULT(1)="-1^Error updating the notification data"
 .S NUM=0
 .S NUM=NUM+1,^TMP("PXRMXMZ",$J,NUM,0)="Error adding Women's Health Notifications to the WV NOTIFICATION FILE."
 .D BLDMSG^WVRPCGF1(PAT,"ERROR Updating WV PROCEDURE File.",.NUM)
 S WVDA7904=WVFDAIEN(1)
 ;
 Q:$G(WVPRINTR)=""  ;no printer defined
 Q:$P($G(^WV(790.403,+$G(WVTYPE),0)),U,2)'=1  ;not printable
 S WVPRINTR=$P(WVPRINTR,";",2)
 Q:WVPRINTR=""
 D DEVICE^WVRPCNO1(WVDA7904,WVPRINTR) ;print letter
 Q
 ;
 ;update any open notification link to the pass in 790.1 IEN
SETOPNOT(RESULT,WVDATA,NOTTYPE,INPUTS,PAT) ;
 N TYPE,WHEN,WHO,WVIEN
 S TYPE=$G(NOTTYPE("TYPE")) I TYPE="" Q
 S WHO=$G(NOTTYPE("WHO")),WHEN=$G(NOTTYPE("WHEN"))
 S WVIEN=0 F  S WVIEN=$O(WVDATA(WVIEN)) Q:WVIEN'>0  D
 .D TYPEONLY(.RESULT,WVIEN,WHO,WHEN,TYPE,.INPUTS)
 Q
 ;
 ;find any open notification for the pass in Cascade name
SETNOTO(RESULT,ID,INPUTS,WVDFN,WVTYPE) ;
 N CONTWHO,CONTDATE,ITEM,WVARRAY,WVIEN
 I $G(INPUTS("DATA",790.1,ID,"NAME"))="" Q
 D GETOLIST^PXRMEOC(.WVARRAY,WVDFN,INPUTS("DATA",790.1,ID,"NAME"))
 S CONTWHO=$G(INPUTS("DATA",790.4,"+1,",1)),CONTDATE=$G(INPUTS("DATA",790.4,"+1,",2))
 S ITEM="" F  S ITEM=$O(WVARRAY(ITEM)) Q:ITEM=""  D
 .Q:ITEM'["WV(790.1"
 .S WVIEN=+ITEM Q:WVIEN'>0
 .D TYPEONLY(.RESULT,WVIEN,CONTWHO,CONTDATE,WVTYPE,.INPUTS)
 Q
 ;
TYPEONLY(RESULT,WVIEN,WVCONWHO,WVCONDTE,TYPE,INPUTS) ;
 N ACCESS,IEN,NODE,NUM,TMP,WVFDA,WVERR
 S NODE=$G(^WV(790.1,WVIEN,0)) Q:NODE=""
 S ACCESS=$P(NODE,U)
 S IEN=0 F  S IEN=$O(^WV(790.4,"C",ACCESS,IEN)) Q:IEN'>0!($D(WVERR))  D
 .K WVFDA
 .S NODE=$G(^WV(790.4,IEN,0))
 .I +$P(NODE,U,3)>0 Q
 .I +$P(NODE,U,4)=0 Q
 .I $P(NODE,U,14)="c" Q
 .S WVFDA(790.4,IEN_",",.03)=TYPE
 .S WVFDA(790.4,IEN_",",.14)="c"
 .I WVCONWHO'="" S WVFDA(790.4,IEN_",",1)=WVCONWHO
 .I WVCONDTE'="" S WVFDA(790.4,IEN_",",2)=WVCONDTE
 .I '$D(WVFDA) Q
 .D UPDATE^DIE("","WVFDA","","WVERR")
 .I $D(WVERR) D
 ..S RESULT(1)="-1^Error updating the notification data"
 ..S NUM=0
 ..S NUM=NUM+1,^TMP("PXRMXMZ",$J,NUM,0)="Error adding Women's Health Notifications to the WV NOTIFICATION FILE."
 ..D BLDMSG^WVRPCGF1(PAT,"ERROR Updating WV PROCEDURE File.",.NUM)
 Q
 ;
CHECKDAT(WVNODE,PAT,WVFUDATE) ;
 I $P(WVNODE,U)'["RETURN TO AGE SCREENING" Q
 D TERMEVAL(PAT,.WVFUDATE)
 Q
TERMEVAL(PAT,WVFUDATE) ;
 N FIEVAL,TERMARR
 D TERM^PXRMLDR("VA-WH MAMMOGRAM START DATE",.TERMARR)
 D IEVALTER^PXRMTERM(PAT,.TERMARR,.TERMARR,1,.FIEVAL)
 I $G(FIEVAL(1))'=1 Q
 I $G(FIEVAL(1,"VALUE"))>0 S WVFUDATE=FIEVAL(1,"VALUE")
 Q
 ;
 ;set array of future procedure dates and types
GETDATES(WVTRMTS,WVPURP,PAT,WVFUDATE,WVPDATE) ;
 N BRDD,BRDD,CRTX,CRDD,DATE,WVNODE
 S WVNODE=$G(^WV(790.404,WVPURP,0))
 S BRTX=$S($P(WVNODE,U,7)]"":$P(WVNODE,U,7),1:"") ;breast tx need
 S BRDD=$S($P(WVNODE,U,8)]"":$P(WVNODE,U,8),1:"") ;breast tx due date
 S CRTX=$S($P(WVNODE,U,9)]"":$P(WVNODE,U,9),1:"") ;cervical tx need
 S CRDD=$S($P(WVNODE,U,10)]"":$P(WVNODE,U,10),1:"") ;cervical tx due date
 S:'$G(WVPDATE) WVPDATE=DT
 I BRTX'="" D
 .I BRDD="",+$G(WVFUDATE)=0 D CHECKDAT(WVNODE,PAT,.WVFUDATE)
 .I BRDD'="",+$G(WVFUDATE)'>0 S DATE=$$FMADD^WVUTL3(BRDD,WVPDATE)
 .I $G(WVFUDATE)>0 S DATE=WVFUDATE
 .S WVTRMTS("BR",+$G(DATE))=BRTX
 I CRTX'="" D
 .I CRDD'="",$G(WVFUDATE)'>0 S DATE=$$FMADD^WVUTL3(BRDD,WVPDATE)
 .I $G(WVFUDATE)>0 S DATE=WVFUDATE
 .S WVTRMTS("CR",+$G(DATE))=BRTX
 Q
 ;
 ;set the actual future procedure and next treatment dates
 ;to file 790.
SETDATES(RESULT,WVTRMTS,WVDFN,CLEARNXT) ;
 N BRTX,BRDD,CRTX,CRDD
 S (BRDD,BRTX,CRDD,CRTX)=""
 I $D(WVTRMTS("BR")) D
 .S BRDD=$O(WVTRMTS("BR","")) Q:BRDD=""
 .S BRTX=$G(WVTRMTS("BR",BRDD)) I BRTX="" S BRDD="" Q
 I $D(WVTRMTS("CR")) D
 .S CRDD=$O(WVTRMTS("CR","")) Q:CRDD=""
 .S CRTX=$G(WVTRMTS("CR",BRDD)) I CRTX="" S CRDD="" Q
 I BRDD'="",BRTX'="" D
 .S WVFDA(790,WVDFN_",",.18)=BRTX
 .S WVFDA(790,WVDFN_",",.19)=BRDD
 I CRDD'="",CRTX'="" D
 .S WVFDA(790,WVDFN_",",.11)=CRTX
 .S WVFDA(790,WVDFN_",",.12)=CRDD
 I CLEARNXT=1 D
 .S WVFDA(790,WVDFN_",",.18)=""
 .S WVFDA(790,WVDFN_",",.19)=""
 I $D(WVFDA) D FILE^DIE("","WVFDA","WVERR")
 I $D(WVERR) D
 .S RESULT(1)="-1^Error updating the patient future needs"
 .S NUM=0
 .S NUM=NUM+1,^TMP("PXRMXMZ",$J,NUM,0)="Error adding PATIENT Future needs to the WV PATIENT FILE."
 .D BLDMSG^WVRPCGF1(PAT,"Error updating PATIENT Future needs",.NUM)
 Q
 ;
