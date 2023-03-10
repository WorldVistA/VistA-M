TIUCOPC ;SLC/TDP - Copy/Paste Copy Tracking ;Jul 29, 2020@10:19:38
 ;;1.0;TEXT INTEGRATION UTILITIES;**290,336**;Jun 20, 1997;Build 4
 ;
 ; External Reference
 ;   DBIA 10000  NOW^%DTC
 ;   DBIA 10000  C^%DTC
 ;   DBIA  2051  $$FIND1^DIC
 ;
 Q
PUTCOPY(INST,ARY,ERR) ;Save to copy buffer
 ;   Call using $$PUTCOPY^TIUCOPC(INST,.ARY,.ERR)
 ;
 ;   Input
 ;     INST - Institution ien (file #4)
 ;     ARY - Array containing data to be saved into the Copy Buffer
 ;         Components of ARY:
 ;           ARY(1,0)=
 ;             Piece 1: Input User DUZ
 ;             Piece 2: Copy date/time (Fileman format "YYYMMDD.HHMMSS")
 ;             Piece 3: Copy from IEN;Package (1230;GMRC)
 ;                      GMRC = Consults (#123)
 ;                      TIU  = Text Integration Utilities (#8925)
 ;                      OR   = CPRS (#100)
 ;                      OUT  = Outside of application
 ;                      ???  = Other packages to be determined
 ;                      -1 for an IEN will indicate free text value in second piece
 ;             Piece 4: Capturing application (Free Text)
 ;             Piece 5: Hash Value of copied text
 ;           Below array info not used after switch to Hash Value:
 ;           ARY(1,1)= Copied text
 ;           or, if text length is greater than 255:
 ;           ARY(1,1,1)= first segment of line
 ;           ARY(1,1,2)= second segment of line
 ;           ARY(1,1,n)= last segment of line
 ;           ARY(1,2)= Copied text
 ;           ARY(1,n)= Copied text
 ;           ARY(2,0)= Next record (Same format as ARY(1,0))
 ;           ARY(2,1)= Copied text
 ;           ARY(N,n)
 ;
 ;     ERR - Name of array to return error message in.
 ;
 ;   Output
 ;     Boolean (1: Success, 0: Failed)
 ;     ERR("ERR") - "-1^Error Message"
 ;        Returned in variable received. If ERR variable not received,
 ;        then TIUERR variable will be set and returned with the
 ;        error message. If TIUERR is returned, calling routine will
 ;        need to handle it properly.
 ;
 N %,%H,%I,CDT,CDTM,DATA,DATA0,DAYS,DFN,TIUCNT,TIUCPDT,TMPARY,IEN,PKG
 N PRFX,SAVE,TIUACNT,TIUNMSPC,TODATE,TXT,X,X1,X2,TIUCPRCD,TIUERR,TIULN
 N TIULNG,TXTDATA,TXTHASH,FRETXT,CAPP,Y
 S FRETXT=""
 S PKG=""
 S TIUERR=""
 S TMPARY=""
 S SAVE=0
 D NOW^%DTC
 S CDTM=%
 S CDT=X
 I $G(INST)="" S INST=$G(DUZ(2))
 I +INST<1 S TIUERR="-1^Invalid institution" G SVQ
 S INST=$$FIND1^DIC(4,"","","`"_INST,"","","ERR")
 I +INST<1 S TIUERR="-1^Invalid institution" G SVQ
 I '$D(ARY) S TIUERR="-1^Input array does not exist." G SVQ
 I $G(ARY(1,0))="" S TIUERR="-1^Zero node of received array is empty." G SVQ
 S TIUCPRCD=""
 F  S TIUCPRCD=$O(ARY(TIUCPRCD)) Q:TIUCPRCD=""  D  Q:+TIUERR=-1
 . S DATA0=$G(ARY(TIUCPRCD,0))
 . S DFN=$P(DATA0,U,1) I DFN="" S TIUERR="-1^User dfn is required." Q
 . I $$DFNCHK^TIUCOPUT(DFN)=0 S TIUERR="-1^User ien is not valid." Q
 . S TIUCPDT=$P(DATA0,U,2) I TIUCPDT="" S TIUERR="-1^Copy date/time is required." Q
 . I $$DTCHK^TIUCOPUT(TIUCPDT)=0 S TIUERR="-1^Copy date is not valid." Q
 . S IEN=+$P($P(DATA0,U,3),";",1)
 . I IEN>0 D  Q:+TIUERR=-1
 .. S PKG=$P($P(DATA0,U,3),";",2) I PKG="" S TIUERR="-1^Copy from package is required." Q
 .. I PKG'="OUT",IEN=0 S TIUERR="-1^Copy from IEN is required." Q
 .. S PKG=$S(PKG="TIU":8925,PKG="OR":100,PKG="GMRC":123,1:PKG)
 .. I PKG'="OUT",'$$GDFIL^TIUCOPUT(IEN,.PKG,"") S TIUERR="-1^Copy from package/ien is not valid." Q
 . I IEN<0 D  Q:+TIUERR=-1
 .. S FRETXT=$P($P(DATA0,U,3),";",2,99999)
 .. I FRETXT="" S TIUERR="-1^Copy from free text identifier is empty." Q
 .. S PKG=""
 . ;I IEN<-1 S TIUERR="-1^Copy from IEN is invalid." Q
 . ;S PRFX=$P(DATA0,U,4) I PRFX="" S TIUERR="-1^Application identifier not received." Q
 . ;I +$$FIND1^DIC(9.4,"","X",PRFX,"C","","ERR")<1 S TIUERR="-1^Capturing package prefix invalid." Q
 . S CAPP=$P(DATA0,U,4) I $L(CAPP)>15 S CAPP=$E(CAPP,1,15)
 . S TXTHASH=$P(DATA0,U,5)
 . ;S (X,TXT,TIUACNT,TIUCNT)=0
 . ;F  S X=$O(ARY(TIUCPRCD,X)) Q:X=""  D
 . ;. I $TR($G(ARY(TIUCPRCD,X))," ")']"" Q
 . ;. S TXT=1
 . ;. S TIUACNT=TIUACNT+1
 . ;. S TIULNG=$L($G(ARY(TIUCPRCD,X)),"#13#10")
 . ;. I TIULNG>1 D
 . ;.. S TXTDATA=$G(ARY(TIUCPRCD,X))
 . ;.. F TIULN=1:1:TIULNG D
 . ;... S TIUCNT=TIUCNT+1
 . ;... S TMPARY(TIUCNT)=$P(TXTDATA,"#13#10",TIULN)
 . ;. I TIULNG=1 S TIUCNT=TIUCNT+1 S TMPARY(TIUCNT)=$G(ARY(TIUCPRCD,X))
 . ;I TIUCNT>TIUACNT D
 . ;. S TIULN=""
 . ;. F  S TIULN=$O(TMPARY(TIULN)) Q:TIULN=""  D
 . ;.. S ARY(TIUCPRCD,TIULN)=$G(TMPARY(TIULN))
 . I TXTHASH="" S TIUERR="-1^Copied text contains no text" Q
 . S TIUNMSPC="TIU COPY/PASTE:"_CDT
 . I '$D(^XTMP(TIUNMSPC,0)) D NWDTENT(CDT,TIUNMSPC) I $G(TIUERR)'="" Q
 . S ^XTMP(TIUNMSPC,CAPP,DFN,TIUCPDT,0)=PKG_U_IEN_U_FRETXT_U_TXTHASH
 . ;S TIULN=""
 . ;F  S TIULN=$O(ARY(TIUCPRCD,TIULN)) Q:TIULN=""  D
 . ;. S ^XTMP(TIUNMSPC,CAPP,DFN,TIUCPDT,1,TIULN)=$G(ARY(TIUCPRCD,TIULN))
 . ;S ^XTMP(TIUNMSPC,CAPP,DFN,TIUCPDT,1,0)=$O(^XTMP(TIUNMSPC,CAPP,DFN,TIUCPDT,1,""),-1)
 . S SAVE=1
SVQ I $G(TIUERR)'="" D
 . S ERR("ERR")=$G(TIUERR) K TIUERR
 Q SAVE
 ;
NWDTENT(CDT,TIUNMSPC) ;Add a new entry date (zero node) for COPY/PASTE in ^XTMP.
 N %H,X,X1,X2,DAYS,TODATE
 ;S DAYS=$$DAYS^TIUCOP(INST) I +DAYS=-1 S TIUERR=DAYS
 ;S X2=DAYS
 S X2=1 ;Only save for 1 days
 S X1=CDT
 D C^%DTC
 S TODATE=X
 S ^XTMP(TIUNMSPC,0)=TODATE_"^"_CDT_"^Copy/Paste saved copy information"
 Q
 ;
GETCOPY(INST,DFN,ARY,STRTFRM,LIMIT) ;Retrieve copy buffer
 ;   Call using GETCOPY^TIUCOPC(INSTITUTION IEN,USER DFN,.ARY)
 ;
 ;   Input
 ;     INST - Institution ien
 ;     DFN - User ien
 ;     ARY - Array to return the copy buffer data
 ;     STRTFRM - This is the starting entry to find additional copy
 ;               buffer data when the More data boolean was previously
 ;               returned.  Data format is:
 ;
 ;                  Date/Time of the Copy^Date of the XTMP global
 ;                  creation^Capturing Application^Previous Return
 ;                  Count
 ;
 ;               This is the first 3 pieces of the last entry
 ;               previously returned in the ARY("1..n,0") node.
 ;
 ;
 ;   Output
 ;     ARY("0,0") - Total number of unique entries^More Boolean (1=more data)
 ;                       Or
 ;                  Error condition "-1^Error Msg"
 ;
 ;     ARY("1..n,0") -
 ;        Piece 1: Date/Time of the copy
 ;        Piece 2: Capturing Application
 ;        Piece 3: Copy from location in 2 pieces (ien;package or
 ;                 -1;free text descriptor)
 ;        Piece 4: Hash Value (copied text)
 ;        Piece 5: Number of lines of copied text (Not used)
 ;     Below array info not used after switch to Hash Value:
 ;     ARY("1..n,1..n") - Copied text
 ;
 N %,%H,%I,CAPP,CDT,CNT,DAYS,DONE,DT,DT1,LN,LNTTL,MAXLN,NODE0 ;,PRFX
 N CAPP1,FIRST,STRT,TIUERR,TIUNMSPC,X,X1,X2
 S (CDT,TIUERR)=""
 I $G(ARY)'["" S TIUERR="-1^Return array is required." G GETQ
 I $G(INST)="" S INST=$G(DUZ(2))
 I +INST<1 S TIUERR="-1^Invalid institution" G GETQ
 S INST=$$FIND1^DIC(4,"","","`"_INST,"","","ERR")
 I +INST<1 S TIUERR="-1^Invalid institution" G GETQ
 I $G(DFN)="" S TIUERR="-1^User dfn is required." G GETQ
 I $$DFNCHK^TIUCOPUT(DFN)=0 S TIUERR="-1^User ien is not valid." G GETQ
 S (CNT,DONE,FIRST,LNTTL,STRT)=0
 I $G(STRTFRM),$L(STRTFRM,U)=4 D
 . S DT1=$P(STRTFRM,U,1)
 . S CDT=$P(STRTFRM,U,2)
 . S CAPP1=$P(STRTFRM,U,3)
 . S (CNT,STRT)=+$P(STRTFRM,U,4)
 . I DT1>0,CDT>0,CAPP1'="",$D(^XTMP("TIU COPY/PASTE:"_CDT,CAPP1,DFN,DT1,0)) D
 .. S CDT=CDT-1
 .. S FIRST=1
 I FIRST=0 D
 . D NOW^%DTC
 . S CDT=X K X
 . ;S DAYS=$$DAYS^TIUCOP(INST) I +DAYS=-1 S TIUERR=DAYS G GETQ
 . S DAYS=2
 . S X2=-DAYS
 . S X1=CDT
 . D C^%DTC
 . S CDT=X
 S MAXLN=1000
 S TIUNMSPC="TIU COPY/PASTE:"_CDT
 K %H,X
 F  S TIUNMSPC=$O(^XTMP(TIUNMSPC)) Q:TIUNMSPC=""!(TIUNMSPC'["TIU COPY/PASTE:")  D  Q:DONE
 . S CDT=$P(TIUNMSPC,":",2)
 . S CAPP=""
 . F  S CAPP=$O(^XTMP(TIUNMSPC,CAPP)) Q:CAPP=""  D  Q:DONE
 .. I FIRST=1 S CAPP=CAPP1
 .. I '$D(^XTMP(TIUNMSPC,CAPP,DFN)) Q
 .. S DT=""
 .. F  S DT=$O(^XTMP(TIUNMSPC,CAPP,DFN,DT)) Q:DT=""  D  Q:DONE
 ... I FIRST=1 S DT=DT1,FIRST=0 Q
 ... I LIMIT,LNTTL>MAXLN S DONE=1 Q
 ... S CNT=CNT+1
 ... S LN=0
 ... S NODE0=$G(^XTMP(TIUNMSPC,CAPP,DFN,DT,0))
 ... ;S ARY(CNT_",0")=DT_U_CDT_U_CAPP_U_$P(NODE0,U,2)_";"_$S($P(NODE0,U,1)'="":$P(NODE0,U,1),1:CAPP_U_U_$P(NODE0,U,3)
 ... ;S ARY(CNT,0)=DT_U_CDT_U_$P(NODE0,U,2)_";"_$S($P(NODE0,U,1)'="":$P(NODE0,U,1),1:CAPP)_U_$P(NODE0,U,3)_U_$P(NODE0,U,4)
 ... ;S ARY(CNT,0)=DT_U_CAPP_U_$P(NODE0,U,2)_";"_$S($P(NODE0,U,1)'="":$P(NODE0,U,1),1:CAPP)_U_$P(NODE0,U,3)_U_$P(NODE0,U,4)
 ... S ARY(CNT,0)=DT_U_CAPP_U_$P(NODE0,U,2)_";"_$S($P(NODE0,U,1)'="":$P(NODE0,U,1),1:$P(NODE0,U,3))_U_$P(NODE0,U,4)
 ... S LNTTL=LNTTL+1
 ... ;S X=""
 ... ;F  S X=$O(^XTMP(TIUNMSPC,CAPP,DFN,DT,1,X)) Q:X=""  D
 ... ;. I X=0 S LN=$G(^XTMP(TIUNMSPC,CAPP,DFN,DT,1,X)) Q
 ... ;. ;S ARY(CNT_","_X)=$G(^XTMP(TIUNMSPC,CAPP,DFN,DT,1,X))
 ... ;. S ARY(CNT,X)=$G(^XTMP(TIUNMSPC,CAPP,DFN,DT,1,X))
 ... ;S $P(ARY(CNT_",0"),U,5)=LN,LNTTL=LNTTL+LN
 ... ;S $P(ARY(CNT,0),U,5)=LN,LNTTL=LNTTL+LN
 S CNT=CNT-STRT
 ;S ARY("0,0")=$S(DONE=1:CNT_"^1",1:CNT)
 S ARY(0,0)=$S(DONE=1:CNT_"^1",1:CNT)
GETQ ;I TIUERR'="" S ARY("0,0")=TIUERR
 I TIUERR'="" S ARY(0,0)=TIUERR
 Q
 ;
CHKCOPY(INST,DFN) ;Patient has copy buffer data
 ;   Call using CHKCOPY^TIUCOPC(INSTITUTION IEN,USER DFN,.ARY)
 ;
 ;   Input
 ;     INST - Institution ien
 ;     DFN - User ien
 ;
 ;   Output
 ;     Returns a 1 if patient has copy data, a 0 if not
 ;
 N %,%H,%I,CAPP,CDT,DAYS,DT,RSLT,TIUNMSPC,X,X1,X2
 S RSLT=0
 ;S TIUERR=""
 I $G(INST)="" S INST=$G(DUZ(2))
 I +INST<1 Q 0
 S INST=$$FIND1^DIC(4,"","","`"_INST,"","","ERR")
 I +INST<1 Q 0
 I $G(DFN)="" Q 0
 I $$DFNCHK^TIUCOPUT(DFN)=0 Q 0
 D NOW^%DTC
 S CDT=X K X
 ;S CNT=0
 S DAYS=$$DAYS^TIUCOP(INST) I +DAYS=-1 Q 0
 S DAYS=DAYS+2
 S X2=-DAYS
 S X1=CDT
 D C^%DTC
 S TIUNMSPC="TIU COPY/PASTE:"_X
 F  S TIUNMSPC=$O(^XTMP(TIUNMSPC)) Q:TIUNMSPC=""!(TIUNMSPC'["TIU COPY/PASTE:")!(RSLT=1)  D
 . S CAPP=""
 . F  S CAPP=$O(^XTMP(TIUNMSPC,CAPP)) Q:CAPP=""  D  Q:RSLT=1
 .. I '$D(^XTMP(TIUNMSPC,CAPP,DFN)) Q
 .. S RSLT=1
 Q RSLT
