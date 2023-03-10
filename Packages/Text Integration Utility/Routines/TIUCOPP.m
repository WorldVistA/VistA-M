TIUCOPP ;SLC/TDP - Copy/Paste Paste Tracking ;Jul 30, 2020@11:14:22
 ;;1.0;TEXT INTEGRATION UTILITIES;**290,336**;Jun 20, 1997;Build 4
 ;
 ; External Reference
 ;   DBIA 10000  NOW^%DTC
 ;   DBIA  2051  $$FIND1^DIC
 ;   DBIA  2058  ^DIC(9.4
 ;   DBIA  2053  UPDATE^DIE
 ;   DBIA 10018  ^DIE
 ;   DBIA 10060  ^VA(200,
 ;   DBIA  2056  $$GET1^DIQ
 ;   DBIA 10090  ^DIC(4
 ;   DBIA 10035  ^DPT(
 ;   DBIA  5771  ^OR(100
 ;   DBIA  3260  ^LRT(67
 ;   DBIA  3162  ^GMR(123 0;14 12;6
 ;   DBIA 10103  NOW^XLFDT
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA 10063  STAT^%ZTLOAD
 ;
PUTPASTE(INST,ARY,ERR,SVARY) ;Save Pasted Text
 ;   Call using $$PUTPASTE^TIUCOPP(INST,.ARY,.ERR)
 ;
 ;   Input
 ;     INST - Institution ien (file #4)
 ;     ARY - Array containing data to be saved into the Pasted Text file
 ;         Components of ARY:
 ;           ARY(1,0)=
 ;             Piece 1: Input User DUZ
 ;             Piece 2: Paste date/time (Fileman format "YYYMMDD.HHMMSS")
 ;             Piece 3: Pasted to location (IEN;Package)
 ;                      GMRC = Consults (#123)
 ;                      TIU  = Text Integration Utilities (#8925)
 ;                      OR   = CPRS (#100)
 ;                      ???  = Other packages to be determined
 ;                      If only IEN is received (single data piece),
 ;                         will assume TIU Note IEN by default
 ;             Piece 4: Copy from IEN;Package (1230;GMRC)
 ;                      GMRC = Consults (#123)
 ;                      TIU  = Text Integration Utilities (#8925)
 ;                      OR   = CPRS (#100)
 ;                      OUT  = Outside of application
 ;                      ???  = Other packages to be determined
 ;                      -1 for an IEN will indicate free text value in second piece
 ;             Piece 5: Percent match between copied text and pasted text
 ;             Piece 6: Capturing application
 ;             Piece 7: Edited Note IEN (Only if contains previous pasted text.
 ;                         Send -1 otherwise.)
 ;             Piece 8: Force App to run find
 ;             Piece 9: Not passed in, but is used to indicate parent when found
 ;                         pasted text is part of an entry
 ;           ARY(1,0,1)= Copied text (Only if Pasted text is not 100% match)
 ;           ARY(1,0,2)= Copied text
 ;           ARY(1,0,n)= Copied text
 ;           ARY(1,1)= Pasted text
 ;           ARY(1,2)= Pasted text
 ;           ARY(1,n)= Pasted text
 ;           ARY(1,"PASTE",1,1)= Found Pasted text chunk 1
 ;           ARY(1,"PASTE",1,2)= Found Pasted text chunk 1
 ;           ARY(1,"PASTE",1,n)= Found Pasted text chunk 1
 ;           ARY(1,"PASTE",2,1)= Found Pasted text chunk 2
 ;           ARY(1,"PASTE",2,2)= Found Pasted text chunk 2
 ;           ARY(1,"PASTE",2,n)= Found Pasted text chunk 2
 ;           ARY(1,"PASTE",n,n)= Found Pasted text chunk 3...n
 ;           ARY(2,0)= Next record (Same format as ARY(1,0))
 ;           ARY(2,0,1)= Copied text
 ;           ARY(2,1)= Pasted text
 ;           ARY(2,"PASTE",1,1)= Found Pasted text
 ;           ARY(N,n)
 ;
 ;     ERR - Name of array to return error message in.
 ;     SVARY - Array to receive saved paste info
 ;
 ;   Output
 ;     Boolean (1: Success, 0: Failed)
 ;     ERR("ERR") - "-1^Error Message"
 ;           Returned in variable received. If ERR variable not received,
 ;           then TIUERR variable will be set and returned with the
 ;           error message. If TIUERR is returned, calling routine will
 ;           need to handle it properly.
 ;     SVARY - Array returned containing ien of saved data
 ;
 N %,%H,%I,CDTM,DATA,DAYS,DFN,TIUCNT,TIUCPDT,TMPARY,CPIEN,CPFIL,PRFX,SAVE
 N TIUACNT,TIUNMSPC,TODATE,TXT,X,X1,X2,TIUCPRCD,TIULN,TIULNG,TXTDATA,PSV
 N TIUPSTDT,PSTIEN,PSTFIL,CPLOC,FDA,FDAIEN,CDT,DATA0,DIERR,PCT,TIUERR
 N TFSCNT,CPFTXT,PSTPCT,PARENT,PRNTARY,PSTFILNM,PSTFILGB,CPFILNM,SPST
 N CAPP,PSTXTIEN,PSTLNG,NOFIND,PSTCALC,PRNTFND,PSTPCT,SMPST,C,Y
 N CRGLN,FORCE
 S SVARY=+$G(SVARY)
 I SVARY<1 S SVARY=0
 S PSTCALC=""
 S PSTPCT=""
 S TFSCNT=0
 S TIUERR=""
 S (PRNTARY,TMPARY)=""
 S CRGLN="#13#10"
 S SAVE=0
 D NOW^%DTC
 S CDTM=%
 S CDT=X
 I $G(INST)="" S INST=$G(DUZ(2))
 I +INST<1 S TIUERR="-1^Invalid institution" G SVPSTQ
 S INST=$$FIND1^DIC(4,"","","`"_INST,"","","ERR")
 I +INST<1 S TIUERR="-1^Invalid institution" G SVPSTQ
 I '$D(ARY) S TIUERR="-1^Input array does not exist." G SVPSTQ
 I $G(ARY(1,0))="" S TIUERR="-1^Zero node of received array is empty." G SVPSTQ
 S SPST=$$PCT^TIUCOP(INST)*100
 S TIUCPRCD=""
 F  S TIUCPRCD=$O(ARY(TIUCPRCD)) Q:TIUCPRCD=""  D  Q:+TIUERR=-1
 . S DATA0=$G(ARY(TIUCPRCD,0))
 . S PSTXTIEN=$P(DATA0,U,7)
 . I $P($G(PSTXTIEN),"~",1)="NOCALC" D
 .. S PSTCALC="NOCALC"
 .. S PSTPCT=+$P($G(PSTXTIEN),"~",2)
 .. S PSTXTIEN=0
 . S PRNTFND=1
 . I +PSTXTIEN>0 S PRNTFND=$$PRNTFND(.PSTXTIEN,TIUCPRCD,.ARY)
 . Q:PRNTFND=0
 . S DFN=$P(DATA0,U,1) I DFN="" S DFN=DUZ ;S TIUERR="-1^User dfn is required." Q
 . I $$DFNCHK^TIUCOPUT(DFN)=0 S TIUERR="-1^User ien is not valid." Q
 . S TIUPSTDT=$P(DATA0,U,2) I TIUPSTDT="" S TIUERR="-1^Paste date/time is required." Q
 . I $$DTCHK^TIUCOPUT(TIUPSTDT)=0 S TIUERR="-1^Paste date is not valid." Q
 . D UNQDT^TIUCOPUT(.TIUPSTDT)
 . S PSTIEN=$P($P(DATA0,U,3),";",1)
 . I PSTIEN="" S TIUERR="-1^Pasted to IEN is required." Q
 . S PSTFILNM=""
 . S PSTFIL=$P($P(DATA0,U,3),";",2) I PSTFIL=""!(PSTFIL="TIU") S PSTFIL="8925"
 . I '$$GDFIL^TIUCOPUT(PSTIEN,.PSTFIL,.PSTFILNM) S TIUERR="-1^Pasted to file/ien is not valid." Q
 . S CPFTXT=""
 . S CPLOC=$P(DATA0,U,4) I CPLOC'="" D
 .. S CPIEN=$P(CPLOC,";",1)
 .. S CPFIL=$P(CPLOC,";",2,99)
 .. S CPFIL=$S(CPFIL="GMRC":123,CPFIL="OR":100,CPFIL="TIU":8925,CPFIL="":8925,1:CPFIL)
 .. S CPFILNM=""
 .. I CPIEN=-1 S CPFTXT=CPFIL,CPFIL=""
 .. I CPIEN=-1,CPFTXT="" S CPFTXT="Outside of current CPRS tracking"
 . I CPFIL'="",'$$GDFIL^TIUCOPUT(CPIEN,.CPFIL,.CPFILNM) S TIUERR="-1^Copy from package/ien is not valid." Q
 . I CPIEN=-1,CPFTXT="" S TIUERR="-1^Copy from free text identifier is empty." Q
 . S CAPP=$P(DATA0,U,6) I $L(CAPP)>15 S CAPP=$E(CAPP,1,15)
 . S PCT=+$P(DATA0,U,5) I PCT>100 S PCT=100
 . S (X,TXT)=0
 . F  S X=$O(ARY(TIUCPRCD,X)) Q:+X=0  D  Q:TXT=1  ;Remove leading blank lines
 .. I $TR($G(ARY(TIUCPRCD,X))," ")]"" S TXT=1 Q
 .. K ARY(TIUCPRCD,X)
 . S TXT=0
 . S X=999999999
 . F  S X=$O(ARY(TIUCPRCD,X),-1) Q:+X=0  D  Q:TXT=1  ;Remove trailing blank lines
 .. I $TR($G(ARY(TIUCPRCD,X))," ")]"" S TXT=1 Q
 .. K ARY(TIUCPRCD,X)
 . I +PSTXTIEN=-1,TXT=0 S TIUERR="-1^Pasted text contains no text" Q
 . S X=0,PSTLNG=0,NOFIND=0
 . S (TXT,TIUACNT,TIUCNT)=0
 . F  S X=$O(ARY(TIUCPRCD,X)) Q:+X=0  D
 .. S TIUACNT=TIUACNT+1
 .. S TIULNG=$L($G(ARY(TIUCPRCD,X)),"#13#10")
 .. I TIULNG>1 D
 ... S TXTDATA=$G(ARY(TIUCPRCD,X))
 ... F TIULN=1:1:TIULNG D
 .... S TIUCNT=TIUCNT+1
 .... S TMPARY(TIUCNT)=$P(TXTDATA,"#13#10",TIULN)
 .. I TIULNG=1 S TIUCNT=TIUCNT+1 S TMPARY(TIUCNT)=$G(ARY(TIUCPRCD,X))
 . I TIUCNT>TIUACNT D
 .. S TIULN=""
 .. F  S TIULN=$O(TMPARY(TIULN)) Q:TIULN=""  D
 ... S ARY(TIUCPRCD,TIULN)=$G(TMPARY(TIULN))
 . S FORCE=+$P(DATA0,U,8)
 . I FORCE>2 S FORCE=0
 . I FORCE<0 S FORCE=0
 . S PARENT=+$P(DATA0,U,9)
 . I PARENT=0 D RBLDARY^TIUCOPUT(.ARY,TIUCPRCD,CRGLN,PCT)
 . S SMPST=0
 . K C
 . S C=""
 . I +PSTXTIEN<1,PARENT=0 D
 .. S SMPST=$$CPYTXT^TIUCOPUT(.ARY,TIUCPRCD,.C)
 . D SVPST
 I SVARY>0 S SVARY(0)=TFSCNT
 I '$D(DIERR),$G(TIUERR)="" S SAVE=1
 I $D(DIERR) D
 . N ERRNM,ERRCNT,ERRTXT,LP
 . S ERRTXT=""
 . S TIUERR="-1^Error saving pasted text"
 . S ERRNM=$P(DIERR,U,1)
 . F ERRCNT=1:1:ERRNM D
 .. S LP=0
 .. F  S LP=$O(^TMP("DIERR",$J,ERRCNT,"TEXT",LP)) Q:LP=""  S ERRTXT=ERRTXT_$G(^TMP("DIERR",$J,ERRCNT,"TEXT",LP))
 .. S TIUERR(ERRCNT)=$G(^TMP("DIERR",$J,ERRCNT))_"^"_ERRTXT
SVPSTQ I $G(TIUERR)'="" D
 . S ERR("ERR")=$G(TIUERR)
 . S X=""
 . F  S X=$O(TIUERR(X)) Q:X=""  D
 .. S ERR("ERR",X)=$G(TIUERR(X))
 . K TIUERR
 K ^TMP("DIERR",$J)
 Q SAVE
 ;
PRNTFND(PSTXTIEN,TIUCPRCD,ARY) ;
 N FND,CHLD,PRNT,STRLNG,X
 S FND=0
 I '$D(^TIUP(8928,PSTXTIEN,0)) D  Q:FND=0 0
 . S PRNT=""
 . F  S PRNT=$O(^TIUP(8928,"C",PRNT)) Q:PRNT=""  D  Q:FND=1
 .. I '$D(^TIUP(8928,"C",PRNT,PSTXTIEN)) Q
 .. S PSTXTIEN=PRNT
 .. S FND=1
 I $D(^TIUP(8928,"C",PSTXTIEN)) D  Q 1
 . D KLLCHLD(PSTXTIEN)
 S PRNT=$P(^TIUP(8928,PSTXTIEN,0),U,11)
 I +PRNT>0,$D(^TIUP(8928,PRNT,0)),$D(^TIUP(8928,PRNT,1)) D
 . S PSTXTIEN=PRNT
 . S FND=1
 ;I $D(^TIUP(8928,PSTXTIEN,1)) D
 ;. S X=0
 ;. F  S X=$O(ARY(TIUCPRCD,X)) Q:+X=0  K ARY(TIUCPRCD,X)
 ;. S X=0
 ;. F  S X=$O(^TIUP(8928,PSTXTIEN,1,X)) Q:X=""  D
 ;.. S ARY(TIUCPRCD,X)=$G(^TIUP(8928,PSTXTIEN,1,X,0))
 I '$G(ARY(TIUCPRCD,0,1)),$D(^TIUP(8928,PSTXTIEN,2)) D
 . S X=0
 . F  S X=$O(^TIUP(8928,PSTXTIEN,2,X)) Q:X=""  D
 .. S ARY(TIUCPRCD,0,X)=$G(^TIUP(8928,PSTXTIEN,1,X,0))
 D KLLCHLD(PSTXTIEN)
 Q 1
 ;
KLLCHLD(PRNT) ;Kill off child paste entries
 N DA,DIK
 S DIK="^TIUP(8928,"
 S DA=""
 F  S DA=$O(^TIUP(8928,"C",PRNT,DA)) Q:DA=""  D ^DIK
 Q
 ;
SVPST ;Save the paste information
 ;The following variables are expected to exist and are created
 ; in PUTPASTE^TIUCOPP which calls this code:
 ;   CAPP,CPFIL,CPFTXT,CPIEN,DFN,FORCE,INST,PARENT,PCT,PRNTARY
 ;   PSTFIL,PSTIEN,PSTXTIEN,SMPST,SVARY,TFSCNT,TIUCPRCD,TIUPSTDT
 N DA,FDA,FDAIEN
 S DA=""
 S PRNTARY(TIUCPRCD)=$S(PARENT>0:PARENT,1:0)
 I +PSTXTIEN>0 S FDAIEN(TIUCPRCD)=PSTXTIEN
 I +PSTXTIEN'>0 D
 . S FDA(8928,"+"_TIUCPRCD_",",.01)=TIUPSTDT
 . S FDA(8928,"+"_TIUCPRCD_",",.02)=DFN
 . S FDA(8928,"+"_TIUCPRCD_",",.03)=INST
 . S FDA(8928,"+"_TIUCPRCD_",",.04)=PSTIEN
 . S FDA(8928,"+"_TIUCPRCD_",",.05)=PSTFIL
 . S FDA(8928,"+"_TIUCPRCD_",",.06)=$S(CPIEN=-1:"",1:CPIEN)
 . S FDA(8928,"+"_TIUCPRCD_",",.07)=$S(CPIEN=-1:"",1:CPFIL)
 . S FDA(8928,"+"_TIUCPRCD_",",.08)=$S(PCT=0:100,1:PCT) ;PCT
 . S FDA(8928,"+"_TIUCPRCD_",",.09)=CAPP
 . S FDA(8928,"+"_TIUCPRCD_",",.1)=$S(CPIEN=-1:CPIEN_";"_CPFTXT,1:"")
 . S FDA(8928,"+"_TIUCPRCD_",",.12)=FORCE
 . S FDA(8928,"+"_TIUCPRCD_",",1)="ARY("_TIUCPRCD_")"
 . I $G(SMPST)=1 S FDA(8928,"+"_TIUCPRCD_",",2)="C"
 . D UPDATE^DIE("","FDA","FDAIEN","")
 . S DA=$G(FDAIEN(TIUCPRCD))
 I +PSTXTIEN>0 D
 . N SVPCT
 . K FDA
 . I '$D(^TIUP(8928,PSTXTIEN)) Q
 . S SVPCT=$S(PCT=0:100,1:PCT)
 . S FDA(8928,PSTXTIEN_",",.08)=SVPCT
 . S FDA(8928,PSTXTIEN_",",.12)=FORCE
 . D FILE^DIE("","FDA","")
 I +PSTXTIEN>0,DA="" S DA=PSTXTIEN
 I SVARY>0,+PARENT=0 D
 . S SVARY(TIUCPRCD)=INST_U_DA
 . S TFSCNT=TFSCNT+1
 S PRNTARY(TIUCPRCD,0)=DA
 I +PARENT>0,+DA>0 D
 . N DIE,DR,NODE,PARENTDA
 . S NODE=$G(PRNTARY(PARENT,0))
 . S PARENTDA=$P(NODE,U,1)
 . S DIE="^TIUP(8928,"
 . S DR=".11///^S X=PARENTDA"
 . D ^DIE
 Q
 ;
GETPASTE(TIUIEN,INST,APP,ARY,ZERO) ;Retrieve pasted text
 ;   Call using GETPASTE^TIUCOPP(NOTE IEN,INSTITUTION IEN,CALLING APPLICATION,.RETURN ARRAY)
 ;
 ;   Input
 ;     INST - Institution ien
 ;     TIUIEN - Document ien and package (ien;file), ien only is TIU note
 ;     APP - Application retrieving pasted text (Not used)
 ;     ARY - Array to return the pasted text data
 ;     ZERO - 1 = Return zero node only
 ;
 ;   Output
 ;     ARY(0,0) - Total number of unique entries
 ;                       Or
 ;                  Error condition "-1^Error Msg"
 ;
 ;     ARY(1..n,0) - (If ZERO = 1, then only node returned)
 ;        Piece 1: Date/Time of the paste
 ;        Piece 2: User who pasted text
 ;        Piece 3: Copy from location (ien;file)
 ;        Piece 4: Copy from document title
 ;        Piece 5: Copy from document author (duz;name(last,first m))
 ;        Piece 6: Copy from Patient (dfn;name(last,first m))
 ;        Piece 7: Percent match between copied text and pasted text
 ;        Piece 8: Number of lines of pasted text
 ;        Piece 9: Capturing Application
 ;        Piece 10: Date/Time of the copy from document
 ;        Piece 11: Saved Paste IEN
 ;        Piece 12: Parent IEN
 ;        Piece 13: Force Search
 ;                     (2=No Search,1=Yes,0=No)
 ;        Piece 14: Pasted Note (#8925) IEN
 ;     ARY(1,0,0) - Copy text line count
 ;     ARY(1..n,0,1..n) - Copied text
 ;     ARY(1..n,1..n) - Pasted text
 ;
 N CNT,CPYDATA0,CPYDFN,CPYDUZ,CPYGBL,CPYIEN,CPYNAME,CPYFIL,CPYPTNAME
 N CPYPTSRC,CPYUSER,DATA0,DTPST,IEN,LN,PCT,FILE,PRFX,PSTDUZ,PSTUSER
 N TIUERR,TIUIENLN,TIUNMSPC,X,NODISP,CPYFILNM,CPYGBLEN,FILENM,CPYFTXT
 N CPYLOC,CAPP,CPYSRCDT,PRNTIEN,TEXTLNG,COMPLT,FORCE
 S TIUERR=""
 I $G(ARY)'["" S TIUERR="-1^Return array is required." G GETPSTQ
 I $G(INST)="" S INST=$G(DUZ(2))
 I +INST<1 S TIUERR="-1^Invalid institution" G GETPSTQ
 S INST=$$FIND1^DIC(4,"","","`"_INST,"","","ERR")
 I +INST<1 S TIUERR="-1^Invalid institution" G GETPSTQ
 I $G(TIUIEN)="" S TIUERR="-1^Document ien is required." G GETPSTQ
 S TIUIENLN=$L(TIUIEN,";")
 S FILE=$S(TIUIENLN>1:$P($G(TIUIEN),";",2),1:"8925")
 S TIUIEN=$P($G(TIUIEN),";",1)
 I FILE=""!(FILE="TIU") S FILE="8925"
 I TIUIEN="" S TIUERR="-1^Document IEN is required." G GETPSTQ
 I '$$GDFIL^TIUCOPUT(TIUIEN,.FILE,.FILENM) S TIUERR="-1^Document file/ien is not valid." G GETPSTQ
 S CNT=$S(+$G(ARY(0,0))'<0:+$G(ARY(0,0)),1:0)
 S DTPST=""
 F  S DTPST=$O(^TIUP(8928,"AC",TIUIEN,FILE,DTPST)) Q:DTPST=""  D
 . S IEN=""
 . F  S IEN=$O(^TIUP(8928,"AC",TIUIEN,FILE,DTPST,IEN)) Q:IEN=""  D
 .. S CPYDATA0=""
 .. S DATA0=$G(^TIUP(8928,IEN,0))
 .. I DATA0="" Q
 .. S PSTDUZ=$P(DATA0,U,2)
 .. I +PSTDUZ>0 S PSTUSER=$$GET1^DIQ(200,PSTDUZ_",",.01)
 .. I PSTUSER="" S PSTUSER="UNKNOWN PASTER NAME"
 .. S CPYIEN=$P(DATA0,U,6)
 .. S CPYFIL=$P(DATA0,U,7)
 .. I CPYIEN>0,CPYFIL="" S CPYFIL=8925
 .. S CAPP=$P(DATA0,U,9)
 .. S PRNTIEN=$P(DATA0,U,11)
 .. I PRNTIEN="",$D(^TIUP(8928,"C",IEN)) S PRNTIEN="+"
 .. S FORCE=$P(DATA0,U,12)
 .. S CPYLOC=""
 .. S CPYFILNM=""
 .. S CPYFTXT=""
 .. I CPYFIL'="" D
 ... S CPYFILNM=$$GET1^DIQ(1,CPYFIL_",",.01)
 ... S CPYGBL=$$GET1^DIQ(1,CPYFIL_",",1)
 ... S CPYGBLEN=CPYGBL_CPYIEN_")"
 .. I CPYIEN="" D
 ... S CPYFTXT=$P(DATA0,U,10)
 ... I $P(CPYFTXT," - ",1)="ORDER DETAILS" D
 .... S CPYIEN=$P($P(CPYFIL," - ",2),";",1)
 .... S CPYFIL=100
 .. S PCT=$P(DATA0,U,8)
 .. S CPYPTSRC=""
 .. S CPYNAME=""
 .. S CPYUSER=""
 .. S CPYPTNAME=""
 .. S CPYDUZ=""
 .. S CPYUSER=""
 .. S CPYDFN=""
 .. S CPYSRCDT=""
 .. I CPYFILNM="TIU DOCUMENT" D
 ... S CPYSRCDT=$P($G(^TIU(8925,CPYIEN,13)),U,1) ;REFERENCE DATE
 ... S CPYDUZ=$P($G(^TIU(CPYFIL,CPYIEN,12)),U,2) ;AUTHOR/DICTATOR
 ... I +CPYDUZ=0 S CPYDUZ=$P($G(^TIU(CPYFIL,CPYIEN,13)),U,2) ;ENTERED BY
 ...  I +CPYDUZ>0 S CPYUSER=$$GET1^DIQ(200,CPYDUZ_",",.01)
 ... I CPYUSER="" S CPYUSER="UNKNOWN AUTHOR"
 ... S CPYDATA0=$G(^TIU(CPYFIL,CPYIEN,0))
 ... I $G(CPYDATA0)="" Q
 ... S CPYNAME=$P(CPYDATA0,U,1)
 ... S CPYNAME=$P($G(^TIU(8925.1,CPYNAME,0)),U,1)
 ... I CPYNAME="" S CPYNAME="UNKNOWN NOTE TITLE"
 ... S CPYDFN=$P(CPYDATA0,U,2)
 ... I +CPYDFN>0 S CPYPTNAME=$P($G(^DPT(CPYDFN,0)),U,1)
 ... I CPYPTNAME="" S CPYPTNAME="UNKNOWN PATIENT NAME"
 .. I CPYFIL="100" D
 ... S CPYDATA0=$G(^OR(CPYFIL,CPYIEN,0))
 ... I $G(CPYDATA0)="" Q
 ... S CPYSRCDT=$P(CPYDATA0,U,7)
 ... S CPYDUZ=$P(CPYDATA0,U,6) ;WHO ENTERED
 ... I +CPYDUZ>0 S CPYUSER=$$GET1^DIQ(200,CPYDUZ_",",.01)
 ... I CPYUSER="" S CPYUSER="UNKNOWN AUTHOR"
 ... S CPYNAME="ORDER #"_$P(CPYDATA0,U,1)
 ... I +$P(CPYNAME,"#",2)=0 S CPYNAME="UNKNOWN ORDER NUMBER"
 ... S CPYDFN=$P(CPYDATA0,U,2) ;ORDERABLE ITEMS (PATIENT/REFERRAL)
 ... I +CPYDFN>0 D
 .... S CPYGBL=$P(CPYDFN,";",2)
 .... S CPYDFN=+CPYDFN
 ... I CPYGBL="DPT(" S CPYPTNAME=$P($G(^DPT(CPYDFN,0)),U,1)
 ... ;I CPYGBL="LRT(67," S CPYPTNAME=$P($G(^LRT(67,CPYDFN,0)),U,1),CPYPTSRC="R"
 ... I CPYGBL="LRT(67," D
 .... S CPYPTNAME=$$GET1^DIQ(67,CPYDFN_",",.01)
 .... S CPYPTSRC="R"
 ... I CPYPTNAME="" S CPYPTNAME="UNKNOWN PATIENT NAME"
 .. I CPYFILNM="REQUEST/CONSULTATION" D
 ... S CPYDATA0=$G(^GMR(CPYFIL,CPYIEN,0))
 ... I $G(CPYDATA0)="" Q
 ... S CPYSRCDT=$P(CPYDATA0,U,1)
 ... S CPYDUZ=$P(CPYDATA0,U,14) ;SENDING PROVIDER
 ... I +CPYDUZ>0 S CPYUSER=$$GET1^DIQ(200,CPYDUZ_",",.01)
 ... I +CPYDUZ<1,$P($G(^GMR(CPYFIL,CPYIEN,12)),U,6)'="" S CPYUSER=$P($G(^GMR(CPYFIL,CPYIEN,12)),U,6),CPYDUZ="IFC"
 ... I CPYUSER="" S CPYUSER="UNKNOWN AUTHOR"
 ... S CPYNAME="CONSULT #"_CPYIEN
 ... I +$P(CPYNAME,"#",2)=0 S CPYNAME="UNKNOWN CONSULT NUMBER"
 ... S CPYDFN=$P(CPYDATA0,U,2) ;PATIENT NAME (IEN)
 ... I +CPYDFN>0 S CPYPTNAME=$P($G(^DPT(CPYDFN,0)),U,1)
 ... I CPYPTNAME="" S CPYPTNAME="UNKNOWN PATIENT NAME"
 .. I $G(CPYDATA0)="",CPYFTXT="" Q
 .. S CPYLOC=$S(CPYIEN'="":CPYIEN_";"_CPYFILNM,1:CPYFTXT)
 .. S CNT=CNT+1
 .. S ARY(CNT,0)=DTPST_U_$S(+PSTDUZ>0:+PSTDUZ_";"_PSTUSER,1:"")_U_CPYLOC
 .. S ARY(CNT,0)=$G(ARY(CNT,0))_U_CPYNAME_U
 .. S ARY(CNT,0)=$G(ARY(CNT,0))_$S(+CPYDUZ>0:+CPYDUZ_";"_CPYUSER,1:"")
 .. S ARY(CNT,0)=$G(ARY(CNT,0))_U_$S(+CPYDFN>0:+CPYDFN_";"_CPYPTNAME,1:"")
 .. S ARY(CNT,0)=$G(ARY(CNT,0))_$S(((CPYPTSRC="R")&(CPYPTSRC'="")):";"_CPYPTSRC,1:"")
 .. S ARY(CNT,0)=$G(ARY(CNT,0))_U_PCT_U_U_CAPP_U_CPYSRCDT_U_IEN_U_PRNTIEN_U_FORCE_U_TIUIEN
 .. IF +ZERO=1 Q
 .. S LN=0
 .. S X=""
 .. F  S X=$O(^TIUP(8928,IEN,1,X)) Q:X=""  D
 ... I X=0 S LN=$P($G(^TIUP(8928,IEN,1,X)),U,4) Q
 ... S ARY(CNT,X)=$G(^TIUP(8928,IEN,1,X,0))
 .. S $P(ARY(CNT,0),U,8)=LN
 .. S LN=0
 .. S X=""
 .. F  S X=$O(^TIUP(8928,IEN,2,X)) Q:X=""  D
 ... I X=0 S LN=$P($G(^TIUP(8928,IEN,2,X)),U,4) Q
 ... S ARY(CNT,0,X)=$G(^TIUP(8928,IEN,2,X,0))
 .. I +LN>0 S ARY(CNT,0,0)=LN
 S ARY(0,0)=CNT
GETPSTQ I TIUERR'="" S ARY(0,0)=TIUERR
 Q
 ;
CHKPASTE(TIUIEN,INST) ;Check pasted text exists for a document
 ;   Call using $$CHKPASTE^TIUCOPP(DOCUMENT IDENTIFIER,INSTITUTION IEN)
 ;
 ;   Input
 ;     INST - Institution ien
 ;     TIUIEN - Document ien and file # (ien;file), ien only is TIU note
 ;
 ;   Output
 ;     BOOLEAN - 1 Pasted Text Available
 ;               0 No Pasted Text
 ;
 N DTPST,ERR,FILE,FILENM,IEN,RSLT,TIUIENLN
 S RSLT=0
 I $G(INST)="" S INST=$G(DUZ(2))
 I +INST<1 Q RSLT
 S INST=$$FIND1^DIC(4,"","","`"_INST,"","","ERR")
 I +INST<1 Q RSLT
 I $G(TIUIEN)="" Q RSLT
 S TIUIENLN=$L(TIUIEN,";")
 S FILE=$S(TIUIENLN>1:$P($G(TIUIEN),";",2),1:"8925")
 S TIUIEN=$P($G(TIUIEN),";",1)
 I FILE=""!(FILE="TIU") S FILE="8925"
 I TIUIEN="" Q RSLT
 I '$$GDFIL^TIUCOPUT(TIUIEN,.FILE,.FILENM) Q RSLT
 S DTPST=""
 F  S DTPST=$O(^TIUP(8928,"AC",TIUIEN,FILE,DTPST)) Q:DTPST=""  D  Q:RSLT
 . S IEN=""
 . F  S IEN=$O(^TIUP(8928,"AC",TIUIEN,FILE,DTPST,IEN)) Q:IEN=""  D  Q:RSLT
 .. I $G(^TIUP(8928,IEN,0))="" Q
 .. S RSLT=1 Q
 Q RSLT
