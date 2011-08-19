ORWDLR33 ; SLC/KCM/REV/JDL - Lab Calls ; 7/1/2002 11AM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,141,243**;Dec 17, 1997;Build 242
 ;
STOP(VAL,X2)       ; return a calculated stop date
 N X1,X
 S X1=DT D C^%DTC S VAL=X
 Q
MAXDAYS(Y,LOC,SCHED) ; Return max number of days for a continuing order
 N TMP1,TMP2
 K ^TMP($J,"ORWDLR33 MAXDAYS")
 S TMP1=$$GET^XPAR("ALL^LOC.`"_+LOC,"LR MAX DAYS CONTINUOUS",1,"Q")
 I +TMP1=0 S Y="-1" Q
 I +$G(SCHED)>0 D ZERO^PSS51P1(SCHED,,,,"ORWDLR33 MAXDAYS") S TMP2=$G(^TMP($J,"ORWDLR33 MAXDAYS",SCHED,2.5)) K ^TMP($J,"ORWDLR33 MAXDAYS")
 E  S TMP2=0
 I +TMP1=0,+TMP2>0 S Y=TMP2 Q
 I +TMP2=0,+TMP1>0 S Y=TMP1 Q
 S Y=$S(+TMP1>+TMP2:+TMP2,+TMP2>+TMP1:+TMP1,+TMP1=+TMP2:+TMP1,1:0)
 K ^TMP($J,"ORWDLR33 MAXDAYS")
 Q
ALLSPEC(Y,FROM,DIR) ; Return a set of specimens from topography file
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(^LAB(61,"B",FROM),DIR) Q:FROM=""  D
 . S IEN=0 F  S IEN=$O(^LAB(61,"B",FROM,IEN)) Q:'IEN  D
 . . S I=I+1,Y(I)=IEN_U_FROM_"  ("_$P($G(^LAB(61,IEN,0)),U,2)_")"
 Q
LABCOLTM(ORYN,ORDATE,ORLOC) ; Is this a routine lab collect time for this location?
 N ORDA,ORTI,ORDOW,ORCTM,I,X,Y
 S ORYN=0 Q:'$G(ORDATE)!($G(ORDATE)<0)!('$G(ORLOC))
 S ORDA=$P(ORDATE,".",1),ORTI=$P(ORDATE,".",2)
 S I=0 F  S I=$L(ORTI) Q:I>3  S ORTI=ORTI_"0"
 S X=ORDA D DW^%DTC S ORDOW=X
 D GETLST^XPAR(.ORCTM,"ALL","LR PHLEBOTOMY COLLECTION","Q")
 S I=0 F  S I=$O(ORCTM(I)) Q:'I  D
 . S:$P(ORCTM(I),U,2)=ORTI ORYN=1
 Q:ORYN=0
 I $G(ORLOC),$$GET^XPAR(ORLOC_";SC(","LR EXCEPTED LOCATIONS",1,"Q") S ORYN=1 Q
 I '$$GET^XPAR("ALL","LR IGNORE HOLIDAYS",1,"Q"),$D(^HOLIDAY(ORDA,0)) S ORYN=0 Q
 I $$GET^XPAR("ALL","LR COLLECT "_ORDOW,1,"Q") S ORYN=1 Q
 S ORYN=0
 Q
IMMCOLL(ORY) ; Return help screen showing immediate collect times
 D SHOW^LR7OV4(DUZ(2),.ORY)
 Q
ICDEFLT(ORY) ;Return default immediate collect time
 S ORY=$$DEFTIME^LR7OV4(DUZ(2))
 Q
ICVALID(ORY,ORTIME) ;Is the time a valid immediate collect time?
 S ORTIME=$P(ORTIME,".",1)_"."_$E($P(ORTIME,".",2),1,4)
 S ORY=$$VALID^LR7OV4(DUZ(2),ORTIME)
 Q
GETLABTM(ORY,ORDATE,ORLOC) ;Return list of lab collect times for a date and location
 N ORDA,ORTI,ORNOW,ORDOW,ORCTM,ORTI,X,%,%H
 S ORY(0)=0 Q:'$G(ORDATE)!($G(ORDATE)<0)!('$G(ORLOC))
 S ORDA=$P(ORDATE,".",1)
 S ORNOW=$$NOW^XLFDT,ORTI=$P(ORNOW,".",2)
 I ORDA<$P(ORNOW,".",1) S ORY(0)="-1^Dates in the past are not allowed." Q
 I '+$$GET^XPAR(ORLOC_";SC(","LR EXCEPTED LOCATIONS",1,"Q") D
 . S X=ORDA D DW^%DTC S ORDOW=X
 . I '+$$GET^XPAR("ALL","LR COLLECT "_ORDOW,1,"Q") S ORY(0)="-1^No collections on "_ORDOW Q
 . I '+$$GET^XPAR("ALL","LR IGNORE HOLIDAYS",1,"Q"),$D(^HOLIDAY(ORDA,0)) S ORY(0)="-1^No holiday collections" Q
 I +ORY(0)>-1 D 
 . D GETLST^XPAR(.ORY,"ALL","LR PHLEBOTOMY COLLECTION","Q")
 . I +$G(ORY)=0 S ORY(0)="-1^No lab collect times defined for this division" Q
 S I=0 F  S I=$O(ORY(I)) Q:'I  D
 . D NOW^%DTC S ORTI=%,%H=+%H_","_+ORY(I) D YMD^%DTC
 . I (ORDA=$P(ORTI,".",1)),(+(ORDA+%)<+ORTI) K ORY(I) S ORY=ORY-1 Q   ; cutoff time has passed for this collect time
 . S ORY(I)=$P(ORY(I),U,2)
 I +$G(ORY)=0,('$D(ORY(0))) S ORY(0)="-1^All of today's collection times have passed."
 Q
LCFUTR(ORDY,ORLOC,ORDIV)  ;Get # of days for future Lab Collects
 ; For Event Delay Order
 ;  --ORLOC Event default location
 ;  --ORDIV Event default division
 S ORDY=0
 Q:'$D(^XTV(8989.51,"B","LR LAB COLLECT FUTURE"))
 I $G(ORDIV) S ORDY=+$$GET^XPAR(+$G(ORLOC)_";SC("_"^"_+$G(ORDIV)_";DIC(4,^SYS^PKG","LR LAB COLLECT FUTURE",1,"I")
 E  S ORDY=+$$GET^XPAR(+$G(ORLOC)_";SC("_"^DIV^SYS^PKG","LR LAB COLLECT FUTURE",1,"I")
 ;S DUZ(2)=TMPDIV
 Q
LASTTIME(ORY)   ; Get last collection time used from ^TMP("ORECALL",$J) array
 N ORDIALOG,ORTYPE,ORTIME
 S ORDIALOG=$O(^ORD(101.41,"B","LR OTHER LAB TESTS",0))
 S ORTYPE=$O(^ORD(101.41,"B","OR GTX COLLECTION TYPE",0))
 S ORTIME=$O(^ORD(101.41,"B","OR GTX START DATE/TIME",0))
 S ORY=$$RECALL^ORCD(ORTYPE,1)_U_$$RECALL^ORCD(ORTIME,1)
 Q
LCTOWC(ORTXT,ORLOC)     ; return text instructing user when LC changed to WC on accept/release
 N ORDIV,ORSVC
 S ORDIV=DUZ(2)
 S ORSVC=+$G(^VA(200,DUZ,5))
 I ORSVC S ORTXT=$$GET^XPAR(+$G(ORLOC)_";SC("_"^"_+$G(ORSVC)_";DIC(49,^"_+$G(ORDIV)_";DIC(4,^SYS^PKG","ORWLR LC CHANGED TO WC",1,"I")
 E  S ORTXT=$$GET^XPAR(+$G(ORLOC)_";SC("_"^SVC^"_+$G(ORDIV)_";DIC(4,^SYS^PKG","ORWLR LC CHANGED TO WC",1,"I")
 Q
