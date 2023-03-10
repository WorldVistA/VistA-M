ORWTIU ;SLC/REV - Functions for GUI PARAMETER ACTIONS ;Feb 10, 2021@11:37:06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,109,132,195,243,377,539**;Dec 17, 1997;Build 41
 ;
 ; External Reference
 ;   DBIA  6211  ^TIUCOP
 ;   DBIA  7225  REQDFLD^TIUPREF
 ;
GTTIUCTX(Y,ORUSER) ; Returns current Notes view context for user
 N OCCLIM,SHOWSUB
 S Y=$$GET^XPAR("ALL","ORCH CONTEXT NOTES",1)
 I +$P(Y,";",5)=0 D
 . S OCCLIM=$P($$PERSPRF^TIULE(DUZ),U,10)
 . S:+OCCLIM>0 $P(Y,";",5)=OCCLIM
 S SHOWSUB=$P(Y,";",6)
 S $P(Y,";",6)=$S(SHOWSUB'="":SHOWSUB,1:0)
 Q
SVTIUCTX(Y,ORCTXT) ; Save new Notes view preferences for user
 N TMP
 S TMP=$$GET^XPAR(DUZ_";VA(200,","ORCH CONTEXT NOTES",1)
 I TMP'="" D  Q
 . D CHG^XPAR(DUZ_";VA(200,","ORCH CONTEXT NOTES",1,ORCTXT)
 D ADD^XPAR(DUZ_";VA(200,","ORCH CONTEXT NOTES",1,ORCTXT)
 Q
GTDCCTX(Y,ORUSER) ; Returns current DC Summary view context for user
 N OCCLIM,SHOWSUB
 S Y=$$GET^XPAR("ALL","ORCH CONTEXT SUMMRIES",1)
 I +$P(Y,";",5)=0 D
 . S OCCLIM=$P($$PERSPRF^TIULE(DUZ),U,10)
 . S:+OCCLIM>0 $P(Y,";",5)=OCCLIM
 S SHOWSUB=$P(Y,";",6)
 S $P(Y,";",6)=$S(SHOWSUB'="":SHOWSUB,1:0)
 Q
SVDCCTX(Y,ORCTXT) ; Save new DC Summary view preferences for user
 N TMP
 S TMP=$$GET^XPAR(DUZ_";VA(200,","ORCH CONTEXT SUMMRIES",1)
 I TMP'="" D  Q
 . D CHG^XPAR(DUZ_";VA(200,","ORCH CONTEXT SUMMRIES",1,ORCTXT)
 D ADD^XPAR(DUZ_";VA(200,","ORCH CONTEXT SUMMRIES",1,ORCTXT)
 Q
 ;
PRINTW(ORY,ORDA,ORFLG) ;TIU print to windows printer
 N ZTQUEUED,ORHFS,ORSUB,ORIO,ORSTATUS,ROOT,ORERR,ORWIN,ORHANDLE
 N IOM,IOSL,IOST,IOF,IOT,IOS
 S (ORSUB,ROOT)="ORDATA",ORIO="OR WINDOWS HFS",ORWIN=1,ORHANDLE="ORWTIU"
 S ORY=$NA(^TMP(ORSUB,$J,1))
 S ORHFS=$$HFS^ORWRP()
 D HFSOPEN^ORWRP(ORHANDLE,ORHFS,"W")
 I POP D  Q
 . I $D(ROOT) D SETITEM^ORWRP(.ROOT,"ERROR: Unable to open HFS file for TIU print")
 D IOVAR^ORWRP(.ORIO,,,"P-WINHFS80")
 N $ETRAP,$ESTACK
 S $ETRAP="D ERR^ORWRP Q"
 U IO
 D RPC^TIUPD(.ORERR,ORDA,ORIO,ORFLG,ORWIN)
 D HFSCLOSE^ORWRP(ORHANDLE,ORHFS)
 Q
GTLSTITM(ORY,ORTIUDA) ; Return single listbox item for document
 Q:+$G(ORTIUDA)=0
 S ORY=ORTIUDA_U_$$RESOLVE^TIUSRVLO(ORTIUDA)
 Q
IDNOTES(ORY) ; Is ID Notes installed?
 S ORY=$$PATCH^XPDUTL("TIU*1.0*100")
 Q
CANLINK(ORY,ORTITLE) ;Can the title be an ID child?
 ; DBIA #2322
 S ORY=$$CANLINK^TIULP(ORTITLE)
 Q
GETCP(ORY,ORTIUDA) ; Checks required CP fields before signature
 S ORY=""
 N ORTITLE,ORAUTH,ORCOS,ORPSUMCD,ORPROCDT,ORROOT,ORERR,ORREFDT
 S ORERR="",ORROOT=$NA(^TMP("ORTIU",$J))
 D EXTRACT^TIULQ(ORTIUDA,.ORROOT,.ORERR,".01;1202;1208;70201;70202;1301",,,"I")
 S ORTITLE=@ORROOT@(ORTIUDA,".01","I")
 S ORAUTH=@ORROOT@(ORTIUDA,"1202","I")
 S ORCOS=@ORROOT@(ORTIUDA,"1208","I")
 S ORPSUMCD=@ORROOT@(ORTIUDA,"70201","I")
 S ORPROCDT=@ORROOT@(ORTIUDA,"70202","I")
 S ORREFDT=@ORROOT@(ORTIUDA,"1301","I")
 S ORY=ORAUTH_U_ORCOS_U_ORPSUMCD_U_ORPROCDT_U_ORTITLE_U_ORREFDT
 K @ORROOT
 Q
CHKTXT(ORY,ORTIUDA) ; Checks for presence of text before signature
 S ORY='$$EMPTYDOC^TIULF(ORTIUDA)  ;DBIA #4426
 Q
 ;
EXCCOPY(ORY,ORTIUDA) ; Checks if note is excluded from copy/paste tracking
 I +$G(ORTIUDA)=0 S ORY="-1^TIU IEN required" Q
 S ORY=$$EXC^TIUCOP(ORTIUDA)
 Q
 ;
EXCPLST(ORY) ;Returns a list of notes excluded from copy/paste tracking
 D EXCLST^TIUCOP(.ORY)
 Q
 ;
PCTCOPY(ORY,DIV) ; Return the Copy/Paste verification percentage
 I +$G(DIV)=0 S ORY="-1^Institution is required" Q
 S ORY=$$PCT^TIUCOP(DIV)
 Q
 ;
WRDCOPY(ORY,DIV) ; Return the Copy/Paste required number of words
 I +$G(DIV)=0 S ORY="-1^Institution is required" Q
 S ORY=$$WORDS^TIUCOP(DIV)
 Q
 ;
GETCOPY(ORY,ORUSER,DIV,STRT) ; Returns tracked copied text for user
 I $G(STRT)="" S STRT=""
 I +$G(ORUSER)=0 S ORUSER=DUZ
 I +$G(DIV)=0 S ORY="-1^Institution is required" Q
 S ORY(0,0)=-1
 D GETCOPY^TIUCOP(DIV,ORUSER,.ORY,STRT)
 I +ORY(0,0)>0 D
 . N CNT,ND,ND1,X
 . S CNT=0
 . S ND="" F  S ND=$O(ORY(ND)) Q:ND=""  D
 .. S ND1="" F  S ND1=$O(ORY(ND,ND1)) Q:ND1=""  D
 ... S X="("_ND_","_ND1_")="
 ... S CNT=CNT+1
 ... S ORY(CNT)=X_$G(ORY(ND,ND1))
 ... K ORY(ND,ND1)
 I +$G(ORY(0,0))=-1 S ORY(-1)=$P($G(ORY),U,2) K ORY(0,0)
 Q
 ;
SVCOPY(Y,ORTXT,DIV) ; Saves tracked copied text for user
 N CNT,LN,ORDATA,ORERR,ORPC,ORTMP,TXT,X
 I +$G(DIV)=0 S Y="-1^Institution is required" Q
 I '$D(ORTXT) S Y="-1^Copied text not received" Q
 S ORERR=""
 S Y=$$PUTCOPY^TIUCOP(DIV,.ORTXT,.ORERR)
 I Y=0,$G(ORERR("ERR"))'="" S Y=$G(ORERR("ERR"))
 I Y=0,$G(ORERR("ERR"))="" S Y="-1^Unidentified error during save."
 Q
 ;
CHKPASTE(ORY,DIV,DOC) ; Return whether or not the user has copy buffer data
 S ORY=$$CHKPASTE^TIUCOP(DIV,DOC)
 Q
 ;
GETPASTE(ORY,ORTIU,DIV) ; Returns pasted text for current note
 N FILE,IEN1,IENSV,X,Y1,Y,ARY,FLTMP,IEN
 I +$G(DIV)=0 S ORY="-1^Institution is required" Q
 I +$G(ORTIU)=0 S ORY="-1^Document ien is required." Q
 S IEN1=1
 S (ARY(0,0),ORY(0,0))=-1
 I $L(ORTIU,";")=2,$P(ORTIU,";",2)'="" D
 . S IEN1=0
 . S FILE=$P(ORTIU,";",2),ORTIU=+ORTIU,X=""
 . I FILE=123 D  Q
 .. F  S X=$O(^GMR(123,ORTIU,50,"B",X)) Q:X=""  D
 ... I $P(X,";",2)'="TIU(8925," Q
 ... N CHILD,PARNT
 ... I '$D(^TIU(8925,+X,0)) Q
 ... S PARNT=+$P(^TIU(8925,+X,0),U,6)
 ... I PARNT>0 D
 .... S CHILD=""
 .... F  S CHILD=$O(^TIU(8925,"DAD",PARNT,CHILD)) Q:CHILD=""  D
 ..... I $D(FLTMP(CHILD)) Q
 ..... S Y=$$VIEW^TIUCOP(DUZ,CHILD,DIV)
 ..... I Y>0 D GETPASTE^TIUCOP(CHILD,DIV,"OR",.ARY) S FLTMP(CHILD)=1 D LOADORY(.ARY,.ORY)
 .... I $D(FLTMP(PARNT)) Q
 .... S Y=$$VIEW^TIUCOP(DUZ,PARNT,DIV)
 .... I Y>0 D GETPASTE^TIUCOP(PARNT,DIV,"OR",.ARY) S FLTMP(PARNT)=1 D LOADORY(.ARY,.ORY)
 ... I PARNT=0 D
 .... S CHILD=""
 .... F  S CHILD=$O(^TIU(8925,"DAD",+X,CHILD)) Q:CHILD=""  D
 ..... I $D(FLTMP(CHILD)) Q
 ..... S Y=$$VIEW^TIUCOP(DUZ,CHILD,DIV)
 ..... I Y>0 D GETPASTE^TIUCOP(CHILD,DIV,"OR",.ARY) S FLTMP(CHILD)=1 D LOADORY(.ARY,.ORY)
 .... I $D(FLTMP(+X)) Q
 .... S Y=$$VIEW^TIUCOP(DUZ,+X,DIV) I Y>0 D
 ..... D GETPASTE^TIUCOP(+X,DIV,"OR",.ARY) S FLTMP(+X)=1 D LOADORY(.ARY,.ORY)
 . N CHILD,PARNT
 . I '$D(^TIU(8925,+ORTIU,0)) Q
 . S PARNT=+$P(^TIU(8925,+ORTIU,0),U,6)
 . I PARNT>0 D
 .. S CHILD=""
 .. F  S CHILD=$O(^TIU(8925,"DAD",PARNT,CHILD)) Q:CHILD=""  D
 ... I $D(FLTMP(CHILD)) Q
 ... S Y=$$VIEW^TIUCOP(DUZ,CHILD,DIV)
 ... I Y>0 D GETPASTE^TIUCOP(CHILD,DIV,"OR",.ARY) S FLTMP(CHILD)=1 D LOADORY(.ARY,.ORY)
 .. I $D(FLTMP(PARNT)) Q
 .. S Y=$$VIEW^TIUCOP(DUZ,PARNT,DIV)
 .. I Y>0 D GETPASTE^TIUCOP(PARNT,DIV,"OR",.ARY) S FLTMP(PARNT)=1 D LOADORY(.ARY,.ORY)
 . I PARNT=0 D
 .. S CHILD=""
 .. F  S CHILD=$O(^TIU(8925,"DAD",+ORTIU,CHILD)) Q:CHILD=""  D
 ... I $D(FLTMP(CHILD)) Q
 ... S Y=$$VIEW^TIUCOP(DUZ,CHILD,DIV)
 ... I Y>0 D GETPASTE^TIUCOP(CHILD,DIV,"OR",.ARY) S FLTMP(CHILD)=1 D LOADORY(.ARY,.ORY)
 .. I $D(FLTMP(+ORTIU)) Q
 .. S Y=$$VIEW^TIUCOP(DUZ,+ORTIU,DIV) I Y>0 D
 ... D GETPASTE^TIUCOP(+ORTIU,DIV,"OR",.ARY) S FLTMP(+ORTIU)=1 D LOADORY(.ARY,.ORY)
 I IEN1=1 D
 . N CHILD,PARNT
 . I '$D(^TIU(8925,+ORTIU,0)) Q
 . S PARNT=+$P(^TIU(8925,+ORTIU,0),U,6)
 . I PARNT>0 D
 .. S CHILD=""
 .. F  S CHILD=$O(^TIU(8925,"DAD",PARNT,CHILD)) Q:CHILD=""  D
 ... I $D(FLTMP(CHILD)) Q
 ... S Y=$$VIEW^TIUCOP(DUZ,CHILD,DIV)
 ... I Y>0 D GETPASTE^TIUCOP(CHILD,DIV,"OR",.ARY) S FLTMP(CHILD)=1 D LOADORY(.ARY,.ORY)
 .. I $D(FLTMP(PARNT)) Q
 .. S Y=$$VIEW^TIUCOP(DUZ,PARNT,DIV)
 .. I Y>0 D GETPASTE^TIUCOP(PARNT,DIV,"OR",.ARY) S FLTMP(PARNT)=1 D LOADORY(.ARY,.ORY)
 . I PARNT=0 D
 .. S CHILD=""
 .. F  S CHILD=$O(^TIU(8925,"DAD",+ORTIU,CHILD)) Q:CHILD=""  D
 ... I $D(FLTMP(CHILD)) Q
 ... S Y=$$VIEW^TIUCOP(DUZ,CHILD,DIV)
 ... I Y>0 D GETPASTE^TIUCOP(CHILD,DIV,"OR",.ARY) S FLTMP(CHILD)=1 D LOADORY(.ARY,.ORY)
 .. I $D(FLTMP(+ORTIU)) Q
 .. S Y=$$VIEW^TIUCOP(DUZ,+ORTIU,DIV) I Y>0 D
 ... D GETPASTE^TIUCOP(+ORTIU,DIV,"OR",.ARY) S FLTMP(+ORTIU)=1 D LOADORY(.ARY,.ORY)
 I +ORY(0,0)=-1 S ORY(-1)=$P($G(ORY),U,2) S ORY("0,0")=-1 K ORY(0,0) Q
 I +ORY(0,0)'<0 D
 . N CNT,ND,ND1,ND2,X
 . S CNT=0
 . S ND="" F  S ND=$O(ORY(ND)) Q:ND=""  D
 .. S ND1="" F  S ND1=$O(ORY(ND,ND1)) Q:ND1=""  D
 ... S X="("_ND_","_ND1_")="
 ... S CNT=CNT+1
 ... S ORY(CNT)=X_$G(ORY(ND,ND1))
 ... S ND2="" F  S ND2=$O(ORY(ND,ND1,ND2)) Q:ND2=""  D
 .... S X="("_ND_","_ND1_","_ND2_")="
 .... S CNT=CNT+1
 .... S ORY(CNT)=X_$G(ORY(ND,ND1,ND2))
 ... K ORY(ND,ND1)
 Q
 ;
LOADORY(ARY,ORY) ;Take an array and add it to a second array
 N CNT,CNT2,CNT3,LNCNT
 I +ARY(0,0)<0 Q
 S LNCNT=+$O(ORY(""),-1)
 S CNT=""
 F  S CNT=$O(ARY(CNT)) Q:CNT=""  D
 . I +CNT=0 S ORY(0,0)=$S(+$G(ORY(0,0))>0:+$G(ORY(0,0)),1:0)+$G(ARY(0,0)) K ARY(0,0) Q
 . S LNCNT=LNCNT+1
 . S CNT2=""
 . F  S CNT2=$O(ARY(CNT,CNT2)) Q:CNT2=""  D
 .. S ORY(LNCNT,CNT2)=$G(ARY(CNT,CNT2))
 .. S CNT3=""
 .. F  S CNT3=$O(ARY(CNT,CNT2,CNT3)) Q:CNT3=""  D
 ... S ORY(LNCNT,CNT2,CNT3)=$G(ARY(CNT,CNT2,CNT3))
 .. K ARY(CNT,CNT2)
 Q
 ;
FORMAT(ORY) ;Format result for CPRS GUI RPC
 N X,Y
 S X=""
 F  S X=$O(ORY(X)) Q:X=""  D
 . S Y=""
 . F  S Y=$O(ORY(X,Y)) Q:Y=""  D
 .. S ORY(X_","_Y)=$G(ORY(X,Y))
 .. K ORY(X,Y)
 Q
 ;
SVPASTE(ORY,ORTXT,DIV) ; Saves pasted text for the Copy/Paste functionality
 N ORERR,Y
 I +$G(DIV)=0 S ORY="-1^Institution is required" Q
 I '$D(ORTXT) S ORY="-1^Pasted text not received" Q
 S ORERR=""
 S Y=0
 S Y=$$PUTPASTE^TIUCOP(.ORY,DIV,.ORTXT,.ORERR)
 I Y=0,$G(ORERR("ERR"))'="" S ORY=$G(ORERR("ERR"))
 I Y=0,$G(ORERR("ERR"))="" S ORY="-1^Unidentified error during save."
 Q
 ;
VIEWCOPY(Y,USER,IEN,INST) ; Is user allowed to view copy/paste information
 N FILE,IENSV,X,Y1
 S (Y,Y1)=0
 S IEN=$G(IEN)
 I +$G(USER)'>0 S USER=DUZ
 I +$G(INST)=0 S INST=0
 I $L(IEN,";")=2 D  Q
 . S FILE=$P(IEN,";",2),IENSV=+IEN,(IEN,X)=""
 . I FILE=123 D  Q
 .. F  S X=$O(^GMR(123,IENSV,50,"B",X)) Q:X=""  D  Q:Y=2
 ... I $P(X,";",2)'="TIU(8925," Q
 ... S Y=$$VIEW1(+X,INST,USER,Y1)
 ... I Y=2
 .. I Y1>Y S Y=Y1
 . S Y=$$VIEW1(+IENSV,INST,USER,Y1)
 . I Y1>Y S Y=Y1
 I +IEN=0 S Y=$$VIEW^TIUCOP(USER,0,INST) Q
 S Y=$$VIEW1(+IEN,INST,USER,Y1)
 I Y1>Y S Y=Y1
 Q
 ;
VIEW1(IEN,INST,USER,Y1) ;Find parent and child notes and call $$VIEW^TIUCOP for each
 N CHILD,PARNT,USAGE
 S USAGE=0
 I '$D(^TIU(8925,+IEN,0)) Q USAGE
 S PARNT=+$P(^TIU(8925,+IEN,0),U,6)
 I PARNT>0 D
 . S CHILD=""
 . F  S CHILD=$O(^TIU(8925,"DAD",PARNT,CHILD)) Q:CHILD=""  D  Q:USAGE=2
 .. S USAGE=$$VIEW^TIUCOP(USER,CHILD,INST)
 .. I USAGE=2 Q
 .. I USAGE=1 S Y1=USAGE
 . S USAGE=$$VIEW^TIUCOP(USER,PARNT,INST)
 . I USAGE=1 S Y1=USAGE
 I PARNT=0 D
 . S CHILD=""
 . F  S CHILD=$O(^TIU(8925,"DAD",+IEN,CHILD)) Q:CHILD=""  D  Q:USAGE=2
 .. S USAGE=$$VIEW^TIUCOP(USER,CHILD,INST)
 .. I USAGE=2 Q
 .. I USAGE=1 S Y1=USAGE
 . I USAGE=2 Q
 . S USAGE=$$VIEW^TIUCOP(USER,+IEN,INST)
 . I Y1>USAGE S USAGE=Y1
 Q USAGE
 ;
LDCPIDNT(VAL) ;Return the copy/paste identifier parameters
 N X
 S VAL=""
 S VAL=$$GET^XPAR("PKG","ORQQTIU COPY/PASTE IDENT",,"Q")
 I VAL="-2;CP Disable Override" S VAL=-2 Q
 S VAL=$$GET^XPAR("ALL","ORQQTIU COPY/PASTE IDENT",,"Q")
 I VAL["-2" S VAL=-2 Q
 I VAL="" S VAL="-1;Visual Disable Override" ;"0,0,1,1,65535" ;Default to Highlight and Underline
 Q
 ;
SVCPIDNT(ORERR,VAL) ;Save the copy/paste identifier parameters
 ; VAL=Bold,Italicize,Underline,Highlight,Highlight Color
 N PARAM
 S ORERR=0
 I $G(VAL)="" S ORERR="-1^Input parameter is missing" Q
 D EN^XPAR("USR","ORQQTIU COPY/PASTE IDENT",1,VAL,.ORERR)
 Q
 ;
VALCODE(X) ;Validation code for the ORQQTIU COPY/PASTE IDENT parameter
 ; Returns 1 if fail
 ;ENT is expected to exist when this is called
 ;N RTN
 ;S RTN=0
 I X="" Q 1
 ;The following line is an attribute which can be used to disable
 ;copy/paste identifiers. This only affects the visual components of
 ;copy/paste. All tracking continues to occur.
 I X="-1;Visual Disable Override" Q 0
 ;The following line is a hidden attribute which can be used to disable
 ;copy/paste functionality. NOTE: This functionality is only for use at
 ;the direction of the VACO Health Information Management Program
 ;Office or the event of an Emergency situation.
 ;I X="-2;CP Disable Override",$P(ENT,";",2)="DIC(9.4," Q 0
 I X="-2;CP Disable Override" Q 0
 ;
 I (X'?4(1N1",")1(1"-"1.N1",",1.N1",")5(1N1",")1(1"-"1.N1","1.N,1.N1","1.N))!(($P(X,U,4)=1)&($P(X,U,5)'>0))!(($P(X,U,10)=1)&($P(X,U,11)'>0)) Q 1
 I (($P(X,",",1)'=1)&($P(X,",",1)'=0))!(($P(X,",",2)'=1)&($P(X,",",2)'=0))!(($P(X,",",3)'=1)&($P(X,",",3)'=0))!(($P(X,",",4)'=1)&($P(X,",",4)'=0)) Q 1
 I ((($P(X,",",6)'=1)&($P(X,",",6)'=0))!(($P(X,",",7)'=1)&($P(X,",",7)'=0))!(($P(X,",",8)'=1)&($P(X,",",8)'=0))!(($P(X,",",9)'=1)&($P(X,",",9)'=0))!(($P(X,",",10)'=1)&($P(X,",",10)'=0))) Q 1
 Q 0
 ;
START(VAL,DFN,DIV,IP,HWND) ;Start copy retrieval background job
 I +$G(DFN)<1 S DFN=DUZ
 I $G(IP)="" Q
 I $G(HWND)="" Q
 I +$G(DIV)<1 Q
 D START^TIUCOP(.VAL,DFN,IP,HWND,DIV)
 Q
 ;
POLL(LST,DFN,IP,HWND) ;Poll copy retrieval background job and return results
 I +$G(DFN)<1 S DFN=DUZ
 I $G(IP)="" Q
 I $G(HWND)="" Q
 D POLL^TIUCOP(.LST,DFN,IP,HWND)
 I $G(LST(1))="" S LST(1)=-1
 Q
 ;
STOP(OK,DFN,IP,HWND) ;Stop copy retrieval background job
 S OK=0
 I +$G(DFN)<1 S DFN=DUZ
 I $G(IP)="" Q
 I $G(HWND)="" Q
 D STOP^TIUCOP(.OK,DFN,IP,HWND)
 Q
 ;
CLEAN ;clean up ^XTMP nodes related to copy/paste
 ;The task number is returned. Currently, we do nothing with it.
 N TASK
 S TASK=0
 D CLEAN^TIUCOP(.TASK)
 Q
 ;
REQDFLD(VAL,ACTION,INPUT) ;Load or Save Template Required Fields Preferences
 D REQDFLD^TIUPREF(.VAL,$G(ACTION),$G(INPUT))
 Q
