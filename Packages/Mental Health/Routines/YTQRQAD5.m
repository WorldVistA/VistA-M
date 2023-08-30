YTQRQAD5 ;SLC/LLB - RESTful Calls to handle MHA assignments ; 10/07/2019
 ;;5.01;MENTAL HEALTH;**158,178,182,181,187,199,202,204,228**;Dec 30, 1994;Build 3
 ;
 ; Reference to VADPT in ICR #10061
 ; Reference to XLFDT in ICR #10103
 ; Reference to XLFSTR in ICR #10104
 ;
EDITASMT(ARGS,DATA) ; save assignment, return /api/mha/assignment/edit/{assignmentId}
 ;YTQRERRS NEWed in YTQRUTL
 N EDITFLG,MSG
 S EDITFLG="SUCCESS",MSG=""
 N I,DFN,ORDBY,VA,VADM,VAERR,I,PREFIX,SETID,FOUND,PID,PTNAME,SSN,EXPIRE,RETSTAT
 S SETID=+$G(ARGS("assignmentId"))
 I '$D(^XTMP("YTQASMT-SET-"_SETID)) Q $$DONE(400,"Assignment Not Found",1)
 S DFN=$G(^XTMP("YTQASMT-SET-"_SETID,1,"patient","dfn")) ; get pat info from existing assignment
 ; get Patient DFN from assignment and compare with that sent in. Create error if no match
 I DFN'=+$G(DATA("patient","dfn")) Q $$DONE(400,"Patient Mismatch",1)
 S PTNAME=$G(^XTMP("YTQASMT-SET-"_SETID,1,"patient","name"))
 S PID=$G(^XTMP("YTQASMT-SET-"_SETID,1,"patient","pid"))
 S SSN=$G(^XTMP("YTQASMT-SET-"_SETID,1,"patient","ssn"))
 S ORDBY=+$G(DATA("orderedBy"))
 I $G(DATA("consult"))=""!($G(DATA("consult"))="null") K DATA("consult")
 I $G(DATA("adminDate"))=""!($G(DATA("adminDate"))="null")!(+$G(DATA("adminDate"))=0) K DATA("adminDate")
 I $G(DATA("cosigner"))=""!($G(DATA("cosigner"))="null") K DATA("cosigner")
 S DATA("appSrc")=$G(DATA("appSrc"))
 I 'DFN!'ORDBY Q $$DONE(400,"FAIL - Missing Reqd Fields",1)
 D DEM^VADPT I $G(VAERR) Q $$DONE(400,"Missing Pt Info",1)
 ; Loop through instruments in assignment and test if any progress in assignments and quit if assignment  progress is not 0.
 S I=0 F  S I=$O(^XTMP("YTQASMT-SET-"_SETID,1,"instruments",I)) Q:I=""  D
 . I $G(^XTMP("YTQASMT-SET-"_SETID,1,"instruments",I,"progress"))>0 S YTQRERRS=1
 I $D(YTQRERRS) Q $$DONE(400,"Cannot edit, Instrument in progress",1)
 I $D(^XTMP("YTQASMT-SET-"_SETID,2,"PNOTE")) M DATA(2,"PNOTE")=^XTMP("YTQASMT-SET-"_SETID,2,"PNOTE")
 S RETSTAT=$$FILASGN^YTQRQAD1(.ARGS,.DATA,SETID,"EDIT")
 Q "/api/mha/assignment/edit/"_RETSTAT
 ;
DONE(CODE,MSG,FAIL) ;
 S DATA=CODE_" - "_MSG
 I $G(FAIL)=1 S YTQRERRS=1 D SETERROR^YTQRUTL(CODE,MSG) Q ""
 Q DATA
 ;
GETGRAPH(ARGS,RESULT) ; Retrieve completed instrument score graphing data for a patient
 ; Report all scores for one patient/Instrument combination
 N YS,PAT,INSTID,DFN,ADMID,YSCORES,YSGRPS,XSTR,CNT,RCNT,YSDATA
 S YSDATA=""
 S (CNT,RCNT)=1
 K RESULT
 S YS("CODE")=ARGS("instrument")
 S INSTID=$O(^YTT(601.71,"B",YS("CODE"),0))
 S DFN=ARGS("dfn")
 S PAT=$P(^DPT(DFN,0),"^",1)
 S RESULT(RCNT)="{""patient"":"""_PAT_""",""instrument"":"""_YS("CODE")_""",""adminDate"":["
 S ADMID=0 F  S ADMID=$O(^YTT(601.84,"C",DFN,ADMID)) Q:ADMID'>0  D
 . I $P(^YTT(601.84,ADMID,0),"^",3)'=INSTID Q  ;Exclude all but selected instrument
 . I $P(^YTT(601.84,ADMID,0),"^",9)'="Y" Q  ;Exclude incomplete instruments
 . S YS("AD")=$P(^YTT(601.84,ADMID,0),"^",1)
 . S YS("ADATE")=$P(^YTT(601.84,ADMID,0),"^",4)
 . K ^TMP($J,"YSCOR"),^TMP($J,"YSG") ;Kill temporary file before storing results
 . D GETSCORE^YTQAPI8(.YSDATA,.YS) ;gets scores and ScaleGroups Scores are in ^TMP($J,"YSCOR") and ScaleGroups are in ^TMP($J,"YSG")
 . I '$D(^TMP($J,"YSG")) D LCOLL ;Collect groups and scores for an single patient/LegacyInstrument/date
 . I $D(^TMP($J,"YSG")) D COLL ;Collate groups and scores for an single patient/instrument/date
 . K YSDATA
 I RCNT'=1 S RESULT(RCNT)=$E(RESULT(RCNT),1,$L(RESULT(RCNT))-1)_"]"
 I RCNT=1 S RESULT(RCNT)=$E(RESULT(RCNT),1,$L(RESULT(RCNT))-1)_"[]"
 S RCNT=RCNT+1 S RESULT(RCNT)="}" ; close out entire object
 K ^TMP("YTQ-JSON",$J)
 S CNT=0 F  S CNT=$O(RESULT(CNT)) Q:CNT=""  S ^TMP("YTQ-JSON",$J,CNT,0)=RESULT(CNT)
 K RESULT S RESULT=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
COLL ; Collect groups & scores for non-legacy instruments 
 N CNT,TYPE,YSCALENM,YSTSCORE,GCNT,GCNTMAX,YSRSCORE,FRSTYP
 N SCLRES,SDAT,YSCIND
 S (CNT,GCNT,GCNTMAX)=0
 S FRSTYP=$G(^TMP($J,"YSG",1)),FRSTYP=$P(FRSTYP,U)
 I FRSTYP["ERROR" Q  ;No graph data
 F  S CNT=$O(^TMP($J,"YSG",CNT)) Q:CNT=""  D
 .  S TYPE=$P(^TMP($J,"YSG",CNT),"=",1) I $E($P(TYPE,"=",1),1,5)="Group" S GCNTMAX=GCNTMAX+1
 S CNT=1 F  S CNT=$O(^TMP($J,"YSCOR",CNT)) Q:+CNT=0  D
 . S SDAT=^TMP($J,"YSCOR",CNT),YSCALENM=$P(SDAT,"=") Q:YSCALENM=""
 . S SCLRES(YSCALENM,CNT)=^TMP($J,"YSCOR",CNT)
 S CNT=0
 F  S CNT=$O(^TMP($J,"YSG",CNT)) Q:CNT=""  D
 . S TYPE=$P(^TMP($J,"YSG",CNT),"=",1)
 . I CNT=1&(TYPE="[DATA]") D  ; set date into RESULT
 . . S RCNT=RCNT+1
 . . S RESULT(RCNT)="   {""date"":"""_$$FMTE^XLFDT(YS("ADATE"),"7DZ")_""",""scores"":["
 . I $E($P(TYPE,"=",1),1,5)="Group" D
 . . S GCNT=GCNT+1
 . . I GCNT>1 D
 . . . S RESULT(RCNT)=$E(RESULT(RCNT),1,$L(RESULT(RCNT))-1)_"]" ;Close out scales array
 . . . S RCNT=RCNT+1 S RESULT(RCNT)="      },"
 . . S RCNT=RCNT+1
 . . S RESULT(RCNT)="      {""group"":"""_$P(^TMP($J,"YSG",CNT),"^",3)_""",""scales"":["
 . I $E($P(TYPE,"=",1),1,5)="Scale" D
 . . S RCNT=RCNT+1
 . . S YSCALENM=$P(^TMP($J,"YSG",CNT),"^",4)
 . . Q:'$D(SCLRES(YSCALENM))
 . . S YSCIND=$O(SCLRES(YSCALENM,""))
 . . S YSRSCORE=$P($P($G(^TMP($J,"YSCOR",YSCIND)),"=",2),"^",1)
 . . S YSTSCORE=$P($P($G(^TMP($J,"YSCOR",YSCIND)),"=",2),"^",2)
 . . K SCLRES(YSCALENM,YSCIND)
 . . ;S YSRSCORE=$P($P($G(^TMP($J,"YSCOR",($E(TYPE,6,8)+1))),"=",2),"^",1)
 . . ;S YSTSCORE=$P($P($G(^TMP($J,"YSCOR",($E(TYPE,6,8)+1))),"=",2),"^",2)
 . . S RESULT(RCNT)="         {""scale"":"""_YSCALENM_""",""rawScore"":"""_YSRSCORE
 . . I YSTSCORE'="" S RESULT(RCNT)=RESULT(RCNT)_""",""tScore"":"""_YSTSCORE
 . . S RESULT(RCNT)=RESULT(RCNT)_"""},"
 S RESULT(RCNT)=$E(RESULT(RCNT),1,$L(RESULT(RCNT))-1)_"]" ;Close out last scales array
 I GCNT=GCNTMAX S RCNT=RCNT+1 S RESULT(RCNT)="      }]" ;Close scores (group) array
 S RCNT=RCNT+1 S RESULT(RCNT)="   },"
 Q
 ;
LCOLL ; Collect scores from Legacy Instruments
 N CNT,TYPE,YSCALENM,YSTSCORE,YSEND,YSRSCORE,FRSTYP
 N YSRSL,INST,INSTD,YSR,YSCALE
 S CNT=0
 D INSTDEF
 I '$D(INSTD) Q  ;No proper instrument definition
 S YSEND=$O(^TMP($J,"YSCOR",""),-1)
 S FRSTYP=$G(^TMP($J,"YSCOR",1)),FRSTYP=$P(FRSTYP,U)
 I FRSTYP["ERROR" Q  ;No graph data
 F  S CNT=$O(^TMP($J,"YSCOR",CNT)) Q:CNT=""  D
 . S TYPE=$P(^TMP($J,"YSCOR",CNT),"=",1)
 . I TYPE'="[DATA]" D
 . . S YSCALENM=$P(^TMP($J,"YSCOR",CNT),"=",1)
 . . S YSRSCORE=$P($P(^TMP($J,"YSCOR",CNT),"=",2),"^",1)
 . . S YSTSCORE=$P($P(^TMP($J,"YSCOR",CNT),"=",2),"^",2)
 . . S YSRSL($$TRIM^XLFSTR($$UP^XLFSTR(YSCALENM)))=YSRSCORE_U_YSTSCORE_U_YSCALENM  ;By Scale Name, added TRIM and UP to match INSTD
 . . ;S YSRSL(CNT-1)=YSRSCORE_U_YSTSCORE_U_YSCALENM  ;CNT-1 for [DATA] offset in scale sequence number
 N GCNTMAX,SCNT,YSCALENAM,YSRSCORE,YSTSCORE,YSGNAM,GCNT
 S GCNTMAX=$O(INSTD(999),-1),GCNT=0
 F  S CNT=$O(^TMP($J,"YSG",CNT)) Q:CNT=""  D
 .  S TYPE=$P(^TMP($J,"YSG",CNT),"=",1) I $E($P(TYPE,"=",1),1,5)="Group" S GCNTMAX=GCNTMAX+1
 S CNT=0
 F  S CNT=$O(INSTD(CNT)) Q:+CNT=0  D
 . S GCNT=GCNT+1
 . I CNT=1 D  ; set date into RESULT
 . . S RCNT=RCNT+1
 . . S RESULT(RCNT)="   {""date"":"""_$$FMTE^XLFDT(YS("ADATE"),"7DZ")_""",""scores"":["
 . I CNT>1 D
 . . S RESULT(RCNT)=$E(RESULT(RCNT),1,$L(RESULT(RCNT))-1)_"]" ;Close out scales array
 . . S RCNT=RCNT+1 S RESULT(RCNT)="      },"
 . S YSGNAM=$O(INSTD(CNT,""))
 . S RCNT=RCNT+1
 . S RESULT(RCNT)="      {""group"":"""_YSGNAM_""",""scales"":["
 . S SCNT=0 F  S SCNT=$O(INSTD(CNT,YSGNAM,SCNT)) Q:SCNT=""  D
 . . S RCNT=RCNT+1
 . . S YSCALE=$O(INSTD(CNT,YSGNAM,SCNT,""))
 . . S YSR=$G(YSRSL(YSCALE))
 . . S YSRSCORE=$P(YSR,U)
 . . S YSTSCORE=$P(YSR,U,2)
 . . S YSCALENM=$P(YSR,U,3) S:YSCALENM="" YSCALENM=YSCALE
 . . S RESULT(RCNT)="         {""scale"":"""_YSCALENM_""",""rawScore"":"""_YSRSCORE
 . . I YSTSCORE'="" S RESULT(RCNT)=RESULT(RCNT)_""",""tScore"":"""_YSTSCORE
 . . S RESULT(RCNT)=RESULT(RCNT)_"""},"
 S RESULT(RCNT)=$E(RESULT(RCNT),1,$L(RESULT(RCNT))-1)_"]" ;Close out last scales array
 I GCNT=GCNTMAX S RCNT=RCNT+1 S RESULT(RCNT)="      }]" ;Close scores (group) array
 S RCNT=RCNT+1 S RESULT(RCNT)="   },"
 Q
INSTDEF ;Get the Instrument Definition of ScaleGroups/Scales
 N I,SEQ,SG,SGNAM,SCL0,SCLNAM,SCLSEQ,SCL
 S I=INSTID
 S SEQ=0 F  S SEQ=$O(^YTT(601.86,"AC",I,SEQ)) Q:SEQ=""  D
 . S SG=$O(^YTT(601.86,"AC",I,SEQ,""))
 . S SGNAM=$P(^YTT(601.86,SG,0),U,3)
 . S INST("SCALEGROUP",SEQ)=SGNAM_U_SG
 . S SCL="" F  S SCL=$O(^YTT(601.87,"AD",SG,SCL)) Q:SCL=""  D
 .. S SCL0=^YTT(601.87,SCL,0)
 .. S SCLNAM=$$UP^XLFSTR($P(SCL0,U,4))
 .. S SCLSEQ=$P(SCL0,U,3)
 .. S INST("SCALEGROUP",SEQ,"SCALE",SCLSEQ)=SCLNAM_U_SCL
 .. S INSTD(SEQ,SGNAM,SCLSEQ,SCLNAM)=""
 Q
 ;
