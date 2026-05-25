YS254PST ;BAL/KTL - Patch 254 Post-init ; 10/06/2023
 ;;5.01;MENTAL HEALTH;**254**;Dec 30, 1994;Build 5
 ;
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to GETLST^XPAR in ICR #2263
 ; Reference to XLFSTR in ICR #10104
 Q
EDTDATE ; date used to update 601.71:18
 ;;3250103.2159
 Q
PRE ; nothing necessary
 Q
POST ; post-init
 N INST
 S INST="HIT-6"
 D DROPTST(INST)
 D UPDTST(INST)
 D UPDURL
 Q
 ;
UPDTST(NAME) ; Update Date Edited
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(11)="Y"
 S REC(18)=$P($T(EDTDATE+1),";;",2)
 D FMUPD^YTXCHGU(601.71,.REC,IEN)
 Q
 ;
DROPTST(NAME) ; Change OPERATIONAL to dropped
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0))
 I +IEN'=0 D
 . S REC(10)="D"
 . S REC(18)=$P($T(EDTDATE+1),";;",2)
 . D FMUPD^YTXCHGU(601.71,.REC,IEN)
 K REC,IEN
 S IEN=$O(^YTT(601,"B",NAME,0))
 I 'IEN QUIT
 S REC(32)="N"
 D FMUPD^YTXCHGU(601,.REC,IEN)
 Q
 ;
UPDURL ; Update GUI TOOLS URL for MHA Web
 N LIST,PARM,ERR,ENT,INST,VAL,TITL,CMD,SPEC,NEWVAL
 K ^TMP($J,"XPAR")
 S LIST=$NA(^TMP($J,"XPAR"))
 S PARM="ORWT TOOLS MENU"
 D ENVAL^XPAR(LIST,PARM,"",.ERR,1)
 S ^XTMP("YS254-TOOLS",0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"MH Backup Tools Menu"
 M ^XTMP("YS254-TOOLS","XPAR")=^TMP($J,"XPAR")
 S SPEC("/home?")="/home/p254/?",SPEC("/home/?")="/home/p254/?"  ;In case URL entered home/? Patch 254
 S SPEC("/home/p250/?")="/home/p254/?"  ;Patch 254
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
SCREEN ; line to put in DATA SCREEN of KIDS build
 ; $$INCLUDE^YTXCHG(Y,"TAG","RTN") calls TAG^RTN to get an array of
 ; instrument exchange entries to include in the build.  It sets Y
 ; to true if the entry should be included.
 ; 
 I $$INCLUDE^YTXCHG(Y,"XCHGLST","YS238PST")
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
ENTRIES ; New MHA instruments ^ Exchange Entry Date
 ;;zzzzz
 ;
 Q
