TIUSRVR2 ; SLC/JER - RPC for record-wise GET ; 11/23/07
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,109,162,222,234**;Jun 20, 1997;Build 6
 ; 4/12/01 Moved signature modules to new rtn TIUSRVR3
LOADREC(TIUDA,TIUL,TIUGDATA,TIUGWHOL,ACTION) ; Load ^TMP
 ;Requires TIUDA, array TIUL, TIUGDATA
 ;optional TIUGWHOL = 1 if we're mid-load for browse, and we're already
 ;                    loading the whole note after the original entry,
 ;                    so DON'T load the whole note again.
 N TIUKID,TIUDADT,TIUI,CANSEE
 N TIUPARNT,TIUPNAME,TIUPDATE
 N TIUGPRNT,TIUGPNM,TIUGPDT,TIUPDATA,TIUHASKD
 S ACTION=$G(ACTION,"VIEW")
 ; ---- If user cannot view, say so and quit: ----
 ;      TIU*1*100
 S CANSEE=$S(+$$ISCOMP^TIUSRVR1(TIUDA)>0:1,1:$$CANDO^TIULP(+TIUDA,ACTION))
 I +CANSEE'>0 D  Q
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=$P(CANSEE,U,2)
 ; ---- Load text of TIUDA: ----
 S TIUI=0
 F  S TIUI=$O(^TIU(8925,+TIUDA,"TEXT",TIUI)) Q:+TIUI'>0  D
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=$G(^TIU(8925,+TIUDA,"TEXT",+TIUI,0))
 ; ---- if TIUDA is a COMPONENT, QUIT
 Q:+$$ISCOMP^TIUSRVR1(TIUDA)
 ; ---- If TIUDA **IS** an addendum, load addm signature,
 ;         load original document, quit: ----
 I +$$ISADDNDM^TIULC1(+TIUDA) D  Q
 . N TIULINE,TIUPARNT S $P(TIULINE,"=",79)=""
 . D LOADSIG^TIUSRVR3(TIUDA,.TIUL)
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=""
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=TIULINE
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=""
 . S TIUPARNT=+$P(^TIU(8925,+TIUDA,0),U,6)
 . S TIUPNAME=$$PNAME^TIULC1(+^TIU(8925,TIUPARNT,0))
 . S TIUPDATE=+$G(^TIU(8925,TIUPARNT,13))
 . S TIUPDATE=$$DATE^TIULS(TIUPDATE,"MM/DD/YY")
 . S TIUPDATA=$$IDDATA^TIURECL1(TIUPARNT)
 . S TIUHASKD=$P(TIUPDATA,U,2),TIUGPRNT=+$P(TIUPDATA,U,3)
 . S TIUL=+$G(TIUL)+1
 . I TIUHASKD D
 . . S @TIUARR@(TIUL)=" --- Original Addended Interdisciplinary Entry ---"
 . I TIUGPRNT D
 . . S @TIUARR@(TIUL)=" --- Original Addended Interdisciplinary Entry ---"
 . . S TIUGPNM=$$PNAME^TIULC1(+^TIU(8925,TIUGPRNT,0))
 . . S TIUGPDT=+$G(^TIU(8925,TIUGPRNT,13))
 . . S TIUGPDT=$$DATE^TIULS(TIUGPDT,"MM/DD/YY")
 . I 'TIUHASKD,'TIUGPRNT S @TIUARR@(TIUL)=" --- Original Document ---"
 . S TIUL=+$G(TIUL)+1,@TIUARR@(TIUL)=""
 . S TIUL=+$G(TIUL)+1
 . I TIUHASKD D
 . . S @TIUARR@(TIUL)="                    << Addended Interdisciplinary Entry >>"
 . . S TIUL=+$G(TIUL)+1
 . . S @TIUARR@(TIUL)=TIUPDATE_" "_TIUPNAME_":"
 . I TIUGPRNT D
 . . S @TIUARR@(TIUL)="                         << Interdisciplinary Note >>"
 . . S TIUL=+$G(TIUL)+1
 . . S @TIUARR@(TIUL)=TIUGPDT_" "_TIUGPNM
 . . S TIUL=+$G(TIUL)+1
 . . S @TIUARR@(TIUL)="                    << Addended Interdisciplinary Entry >>"
 . . S TIUL=+$G(TIUL)+1,@TIUARR@(TIUL)=TIUPDATE_" "_TIUPNAME_":"
 . I 'TIUHASKD,'TIUGPRNT D
 . . S @TIUARR@(TIUL)=TIUPDATE_" "_TIUPNAME_":"
 . D LOADREC(TIUPARNT,.TIUL,TIUGDATA)
 ; ---- Load components of TIUDA: ----
 S TIUKID=0
 F  S TIUKID=$O(^TIU(8925,"DAD",+TIUDA,TIUKID)) Q:+TIUKID'>0  D
 . I +$$ISADDNDM^TIULC1(TIUKID)'>0 D LOADREC(TIUKID,.TIUL,$G(TIUGDATA))
 ; ---- Load signature of TIUDA if TIUDA is not addm
 ;           or comp: ----
 ; *222 don't display sig info. for FORM LETTERS
 I '+$$MEMBEROF^TIUPR222(+$G(^TIU(8925,+TIUDA,0)),"FORM LETTERS") D
 . I '$$ISCOMP^TIUSRVR1(TIUDA) D LOADSIG^TIUSRVR3(TIUDA,.TIUL)
 ; ---- Load addenda of TIUDA: ----
 S TIUKID=0
 F  S TIUKID=$O(^TIU(8925,"DAD",+TIUDA,TIUKID)) Q:+TIUKID'>0  D
 . ; If acting on an addendum, don't show it again.
 . I +TIUKID=+$G(^TMP("TIU FOCUS",$J)) Q
 . I +$$ISADDNDM^TIULC1(TIUKID) D LOADADD(TIUKID,.TIUL)
 N IDDAD
 S IDDAD=+$P(TIUGDATA,U,3)
 ; ---- If Browsed Record is an ID Note, & this cycle has
 ;      just loaded the parent entry, then load ID kids
 ;      and quit: **100** ----
 I $P(TIUGDATA,U,2),TIUDA=+TIUGDATA D LOADKIDS(TIUDA,.TIUL,TIUGDATA) Q
 ; ---- If Browsed Record is an ID Entry, & this cycle hasn't begun
 ;      loading the whole note, then load the whole ID Note after
 ;      the browsed entry and quit: ----
 I IDDAD,'$G(TIUGWHOL) D  Q
 . S TIUGWHOL=1
 . N TIULINE S $P(TIULINE,"=",79)=""
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=""
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=TIULINE
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=""
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=" --- Interdisciplinary Note ---"
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=""
 . D LOADID(IDDAD,.TIUL,TIUGDATA,TIUGWHOL)
 ; ---- If Browsed Record is an ID Entry, & this cycle has begun
 ;      loading the whole ID note, and is currently loading the first
 ;      entry of the whole note, then load kids and quit: ----
 I IDDAD,$G(TIUGWHOL),TIUDA=IDDAD D LOADKIDS(TIUDA,.TIUL,TIUGDATA,TIUGWHOL) K TIUGWHOL
 Q
 ;
LOADKIDS(TIUDA,TIUL,TIUGDATA,TIUGWHOL) ; Load ID kids of TIUDA
 ; Requires TIUDA, array TIUL, TIUGDATA
 N TIUK,PRMSORT,KIDDA,TIUD0,TIUD21
 I $G(^TMP("TIUR",$J,"IDDATA",TIUDA)) S PRMSORT=$P(^TMP("TIUR",$J,"IDDATA",TIUDA),U,4)
 E  S TIUD0=$G(^TIU(8925,TIUDA,0)),TIUD21=$G(^TIU(8925,TIUDA,21)),PRMSORT=$P($$IDDATA^TIURECL1(TIUDA,TIUD0,TIUD21),U,4)
 D GETIDKID^TIURECL2(TIUDA,PRMSORT) ; sets array ^TMP("TIUIDKID",$J,
 S TIUK=0
 F  S TIUK=$O(^TMP("TIUIDKID",$J,TIUDA,TIUK)) Q:+TIUK'>0  D
 . S KIDDA=^TMP("TIUIDKID",$J,TIUDA,TIUK)
 . D LOADID(KIDDA,.TIUL,TIUGDATA,$G(TIUGWHOL))
 K ^TMP("TIUIDKID",$J)
 Q
 ;
LOADID(TIUDA,TIUL,TIUGDATA,TIUWHOL) ; Load ID note for browse
 N TIUREC,TIU
 I '$D(^TIU(8925,+TIUDA,0)) Q
 ; ---- If ID Kid has focus, don't show it again ----
 ; I TIUDA=+$G(^TMP("TIU FOCUS",$J)) Q
 S TIUL=TIUL+1,@TIUARR@(TIUL)=""
 D GETTIU^TIULD(.TIU,+TIUDA)
 D INQUIRE(TIUDA,.TIUREC)
 ; ---- Load info missing from header since this is ID note entry: ----
 ; ---- Load dictation, transcription data, etc.: ----
 D LOADTOP^TIUSRVR1(.TIUREC,TIUDA,.TIUL,$G(TIUGDATA))
 ; ---- Load the remainder of the record: ----
 D LOADREC(TIUDA,.TIUL,$G(TIUGDATA),$G(TIUWHOL))
 Q
 ;
INQUIRE(TIUDA,TIUREC,TIUCPF) ; Inquire to document TIUDA and set TIUREC
 N DA,DIC,DIQ,DR
 S DA=TIUDA,DIC=8925,DIQ="TIUREC("
 S DR=".01;.02;.05;.09;1201;1202;1208;1209;1301;1307;1501;1502;1505;1506;89261"
 ;If the document is a member of the Clinical Procedures Class, include the
 ;Procedure Summary Code field and the Date/Time Performed field
 I $G(TIUCPF) S DR=DR_";70201;70202"
 D EN^DIQ1
 Q
LOADADD(TIUDADD,TIUL) ; Load addenda
 N TIUDAUTH,TIUDATT,TIUJ,TIUSIG,TIUCSIG,TIUVIEW
 S TIUL=TIUL+1,@TIUARR@(TIUL)=""
 S TIUDADT=$$DATE^TIULS($P($G(^TIU(8925,+TIUDADD,13)),U),"MM/DD/CCYY")
 S TIUL=TIUL+1,@TIUARR@(TIUL)=TIUDADT_" ADDENDUM"_"                      STATUS: "_$$STATUS^TIULF(TIUDADD) ;P162
 S TIUVIEW=$$CANDO^TIULP(+TIUDADD,"VIEW")
 I '+TIUVIEW D  Q
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=$P(TIUVIEW,U,2)
 S TIUJ=0
 F  S TIUJ=$O(^TIU(8925,+TIUDADD,"TEXT",TIUJ)) Q:+TIUJ'>0  D
 . S TIUL=TIUL+1,@TIUARR@(TIUL)=$G(^TIU(8925,+TIUDADD,"TEXT",TIUJ,0))
 D LOADSIG^TIUSRVR3(TIUDADD,.TIUL)
 Q
