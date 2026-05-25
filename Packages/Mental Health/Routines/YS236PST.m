YS236PST ;ISP/LMT - Patch 236 Post-init ;Mar 28, 2025@08:35:41
 ;;5.01;MENTAL HEALTH;**236**;Dec 30, 1994;Build 25
 ;
 ;
 ; Reference to TIUFLF7 in ICR #5352
 ; Reference to ^XWB(8994.5, in ICR #5032
 ; Reference to ^DIC(19, in ICR #10075
 ;
 Q
EDTDATE ; date used to update 601.71:18
 ;;3250423.1300
 Q
 ;
PRE ; nothing necessary
 Q
 ;
POST ; post-init
 N YSPROM
 D INSTALLQ^YTXCHG("XCHGLST","YS236PST")
 S YSPROM=$O(^YTT(601.71,"B","PROMIS10",0))
 I YSPROM D QTASK^YTSCOREV(YSPROM_"~2",$H)
 D DDNOTE("CES")  ;Add note titles to CES that were never set up
 D UPDURL
 D REMAPP  ; Create MHA Remote Application entry
 Q
 ;
DDNOTE(NAME) ; Add default note for this instrument
 N IEN,NOTE,CSLT,REC,ALTNOTE,ALTCSLT
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 Q:$P($G(^YTT(601.71,IEN,2)),U,2)'="Y"       ; must be operational
 ;Q:$P($G(^YTT(601.71,IEN,8)),U,9)>0          ; note title already there
 S NOTE=+$$DDEFIEN^TIUFLF7("MENTAL HEALTH DIAGNOSTIC STUDY NOTE","TL")
 S CSLT=+$$DDEFIEN^TIUFLF7("MENTAL HEALTH CONSULT NOTE","TL")
 S ALTNOTE=+$$DDEFIEN^TIUFLF7("MH DIAGNOSTIC STUDY NOTE","TL")
 S ALTCSLT=+$$DDEFIEN^TIUFLF7("MH CONSULT NOTE","TL")
 S:CSLT=0&(ALTCSLT'=0) CSLT=ALTCSLT
 S:NOTE=0&(ALTNOTE'=0) NOTE=ALTNOTE
 I 'NOTE,'CSLT QUIT   ; neither title found
 I NOTE'=0 S REC(29)=NOTE
 I CSLT'=0 S REC(30)=CSLT
 S REC(28)="Y"
 D FMSAVE^YTXCHGI(1,601.71,.REC,IEN)                 ; FMSAVE in case dry run
 D LOG^YTXCHGU("info","Linked note title.")
 Q
 ;
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ;
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS236PST")
 Q
 ;
UPDURL ; Update GUI TOOLS URL for MHA Web
 N LIST,PARM,ERR,ENT,INST,VAL,TITL,CMD,SPEC,NEWVAL
 K ^TMP($J,"XPAR")
 S LIST=$NA(^TMP($J,"XPAR"))
 S PARM="ORWT TOOLS MENU"
 D ENVAL^XPAR(LIST,PARM,"",.ERR,1)
 S ^XTMP("YS236-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS236-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/patch236/?",SPEC("/home/?")="/home/patch236/?"  ;In case URL entered home/? Patch 236
 S SPEC("/home/p254/?")="/home/patch236/?"  ;Patch 236
 S SPEC("/home/p236/?")="/home/patch236/?"  ;Patch 236 RENAME
 S ENT="" F  S ENT=$O(^TMP($J,"XPAR",ENT)) Q:ENT=""  D
 . S INST=0 F  S INST=$O(^TMP($J,"XPAR",ENT,INST)) Q:+INST=0  D
 .. S VAL=^TMP($J,"XPAR",ENT,INST)
 .. I (VAL["mha.domain.ext/app/home?"!(VAL["mha.domain.ext/app/home/")) D
 ... S TITL=$P(VAL,"="),CMD=$P(VAL,"=",2,99)
 ... S CMD=$$REPLACE^XLFSTR(CMD,.SPEC)
 ... S NEWVAL=TITL_"="_CMD
 ... D BMES^XPDUTL("Updating "_CMD_" for "_ENT)
 ... D EN^XPAR(ENT,PARM,INST,NEWVAL,.ERR)
 K ^TMP($J,"XPAR")
 Q
 ;
REMAPP ; Create MHA Remote Application entry
 N YSERR,YSFDA,YSNAME,YSOPT,YSREMAPP,YSSTR
 ;
 S YSSTR="Creating 'MENTAL HEALTH ASSISTANT' Remote Application (#8994.5) entry."
 D BMES^XPDUTL(YSSTR)
 ;
 S YSOPT=$$FIND1^DIC(19,"","X","YTQREST PATIENT ENTRY","B","","YSERR")
 I YSOPT'>0 D  QUIT
 . S YSSTR="Error - could not create entry. Context option 'YTQREST PATIENT ENTRY' not found."
 . D MES^XPDUTL(YSSTR)
 ;
 S YSNAME="MENTAL HEALTH ASSISTANT"
 S YSREMAPP=$$FIND1^DIC(8994.5,"","X",YSNAME,"B","","YSERR")
 I YSREMAPP>0 D  QUIT
 . S YSSTR="Entry already exists."
 . D MES^XPDUTL(YSSTR)
 ;
 S YSFDA(8994.5,"?+1,",.01)=YSNAME
 S YSFDA(8994.5,"?+1,",.02)=YSOPT
 S YSFDA(8994.5,"?+1,",.03)="xJ7jaq1lDjrGo5iwfJrn3AqxOB8BZgHUB4QRESFTQew="
 S YSFDA(8994.51,"?+2,?+1,",.01)="S"
 S YSFDA(8994.51,"?+2,?+1,",.02)=-1
 S YSFDA(8994.51,"?+2,?+1,",.03)="N/A"
 S YSFDA(8994.51,"?+2,?+1,",.04)="N/A"
 D UPDATE^DIE("","YSFDA","","YSERR")
 I $D(YSERR) D
 . S YSSTR="Error - FileMan error when creating entry ("_$G(YSERR)_")."
 . D MES^XPDUTL(YSSTR)
 Q
 ;
XCHGLST(ARRAY) ; return array of instrument exchange entries
 ; ARRAY(cnt,1)=instrument exchange entry name
 ; ARRAY(cnt,2)=instrument exchange entry creation date
 ;
 N I,X
 F I=1:1 S X=$P($T(ENTRIES+I),";;",2,99) Q:X="zzzzz"  D
 . S ARRAY(I,1)=$P(X,U)
 . S ARRAY(I,2)=$P(X,U,2)
 Q
 ;
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;YS*5.01*236 PSS-3^03/13/2025@14:55:48
 ;;YS*5.01*236 PSS-3-2ND^08/28/2024@16:01:48
 ;;YS*5.01*236 EPDS^11/06/2024@12:45:12
 ;;YS*5.01*236 PROMIS10^11/22/2024@11:57:09
 ;;YS*5.01*236 IADL^01/13/2025@14:13:21
 ;;YS*5.01*236 CCSA-DSM5^01/16/2025@17:55:10
 ;;YS*5.01*236 GAD-7^02/13/2025@15:34:13
 ;;YS*5.01*236 ZBI^02/18/2025@13:08:19
 ;;YS*5.01*236 SF36^03/13/2025@13:10:01
 ;;YS*5.01*236 ISS-2^03/18/2025@14:27:04
 ;;zzzzz
 ;
 Q
 ;
