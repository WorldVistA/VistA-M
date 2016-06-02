TIUVPR ;SLC/JER,MKB,ASMR/BL - Server fns - lists for VPR ; 10/16/15 2:12pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**106**;Jun 20, 1997;Build 328
 ;Per VA Directive 6402, this routine should not be modified.
 ;
NOTES(TIUY,DFN,EARLY,LATE) ; Gets list of Notes
 I $S(+$G(DFN)'>0:1,'$D(^DPT(+$G(DFN),0)):1,1:0) Q
 D LIST(TIUY,DFN,3,$G(EARLY),$G(LATE))
 Q
SUMMARY(TIUY,DFN,EARLY,LATE) ; Gets list of Summaries
 I $S(+$G(DFN)'>0:1,'$D(^DPT(+$G(DFN),0)):1,1:0) Q
 D LIST(TIUY,DFN,244,$G(EARLY),$G(LATE))
 Q
 ;
LIST(TIUY,DFN,CLASS,EARLY,LATE,STATUS) ; Build List of [parent] documents
 ;  TIUY    - Return array name, pass by reference
 ;  DFN     - Pointer to PATIENT #2
 ; [CLASS]  - PN,CR,C,W,A,D,DS,SR,CP,LR  [default=ALL]
 ;             or TIU DOCUMENT DEFINITION #8925.1 ien
 ; [EARLY]  - FM date/time to begin search
 ; [LATE]   - FM date/time to end search
 ; [STATUS] - Name of TIU STATUS #8925.6 [default=COMPLETED]
 ;
 ; Returns @TIUY@(DA)       = ""
 ;         @TIUY@("COUNT")  = total# documents
 ;
 N TIUCOUNT,TIUC,SUB,TIUI,TIUDA,TIU0,TIUTYPE,DAD,DA
 S TIUCOUNT=0,TIUY=$NA(^TMP("TIULIST",$J)) K @TIUY
 S CLASS=$G(CLASS,"ALL"),STATUS=$G(STATUS,"COMPLETED"),SUB=0
 ; accept Class ien, or convert code to ien
 I +CLASS=CLASS S TIUC=+CLASS
 E  S TIUC=$S(CLASS="ALL":38,CLASS="DS":244,CLASS="SR":$$CLASS("SURGICAL REPORTS"),CLASS="LR":$$CLASS("LR LABORATORY REPORTS"),CLASS="CP":$$CLASS("CLINICAL PROCEDURES"),CLASS="RA":0,1:3)
 I "CRWAD"[CLASS S SUB=$S(CLASS="C":30,CLASS="W":31,CLASS="A":25,CLASS="D":27,1:$$CLASS("CONSULTS"))
 S EARLY=9999999-+$G(EARLY),TIUI=9999999-$S(+$G(LATE):+$G(LATE),1:3333333)-.000001
 F  S TIUI=$O(^TIU(8925,"APTCL",DFN,TIUC,TIUI)) Q:TIUI<1!(TIUI>EARLY)  D
 . S TIUDA=0 F  S TIUDA=$O(^TIU(8925,"APTCL",DFN,TIUC,TIUI,TIUDA)) Q:+TIUDA'>0  D
 .. Q:$D(@TIUY@(TIUDA))
 .. S TIU0=$G(^TIU(8925,TIUDA,0)),TIUTYPE=$G(^TIU(8925.1,+TIU0,0))
 .. I $P(TIUTYPE,U,4)="CO" Q
 .. I SUB,$P(TIU0,U,4)'=SUB Q
 .. S DAD=$S($P(TIUTYPE,U)["ADDENDUM":+$P(TIU0,U,6),1:0),DA=TIUDA
 .. I STATUS="COMPLETED",$P(TIU0,U,5)<7!($P(TIU0,U,5)>13)!DAD Q
 .. I STATUS="UNSIGNED" Q:'$$UNSIG(TIUDA,DUZ)
 .. I DAD Q:$D(@TIUY@(DAD))  S DA=DAD
 .. ; add to array
 .. S TIUCOUNT=TIUCOUNT+1,@TIUY@(DA)=""
 S @TIUY@("COUNT")=$G(TIUCOUNT)
 Q
 ;
CLASS(CLNAME) ; -- Returns the TIU [Document] Class for CLNAME
 N TIUY S TIUY=+$O(^TIU(8925.1,"B",CLNAME,0))
 I +TIUY>0,$S($P($G(^TIU(8925.1,+TIUY,0)),U,4)="CL":0,$P($G(^(0)),U,4)="DC":0,1:1) S TIUY=0
 Q TIUY
 ;
UNSIG(IEN,USER) ; -- Return 1 or 0, if note IEN is unsigned for USER
 I $P(TIU0,U,5)>5 Q 0
 I $P($G(^TIU(8925,IEN,12)),U,2)=DUZ Q 1
 I $P($G(^TIU(8925,IEN,13)),U,2)=DUZ Q 1
 Q 0
 ;
GET(TIUY,DFN,CLASS,EARLY,LATE) ; Build List of [parent only] documents
 ;  TIUY    - Return array, pass name by reference
 ;  DFN     - Pointer to PATIENT #2
 ;  CLASS   - Pointer to TIU DOCUMENT DEFINITION #8925.1
 ; [EARLY]  - FM date/time to begin search
 ; [LATE]   - FM date/time to end search
 ;
 ; Returns @TIUY@(#)        = DA
 ;         @TIUY@("COUNT")  = total# documents
 ;
 N TIUCOUNT,TIUI,DA
 S TIUCOUNT=0,TIUY=$NA(^TMP("TIULIST",$J)) K @TIUY
 I +$G(CLASS)'>0 S CLASS=38 ;S @TIUY@("COUNT")=0 Q
 S EARLY=9999999-+$G(EARLY),TIUI=9999999-$S(+$G(LATE):+$G(LATE),1:3333333)
 F  S TIUI=$O(^TIU(8925,"APTCL",DFN,CLASS,TIUI)) Q:TIUI<1!(TIUI>EARLY)  D
 . S DA=0 F  S DA=$O(^TIU(8925,"APTCL",DFN,CLASS,TIUI,DA)) Q:+DA'>0  D
 . . I +$$ISADDNDM^TIULC1(+DA) Q  ;no addenda
 . . I +$$ISCOMP^TIUSRVR1(+DA) Q  ;no components
 . . ;I +$G(^TIU(8925,+DA,21)) Q  ;no id children
 . . S TIUCOUNT=TIUCOUNT+1
 . . S @TIUY@(TIUCOUNT)=DA
 S @TIUY@("COUNT")=$G(TIUCOUNT)
 Q
