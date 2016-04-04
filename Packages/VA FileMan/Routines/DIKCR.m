DIKCR ;SFISC/MKO-API TO CREATE A NEW-STYLE XREF ;9:55 AM  1 Nov 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**95**
 ;
CREIXN(DIKCXREF,DIFLG,DIXR,DIKCOUT,DIKCMSG) ;Create a new-style index
 ;DIFLG:
 ; e : Throw away Dialog errors
 ; r : Don't recompile templates, xrefs
 ; W : Write messages to the current device
 ; S : Execute set logic of new xref
 ;
CREIXNX ;Entry point from DDMOD
 N DIKCDEL,DIKCXR,DIKCDMSG,DIKCERR,X,Y
 ;
 ;Init
 S DIFLG=$G(DIFLG)
 I DIFLG["e" S DIKCMSG="DIKCDMSG" N DIERR
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 S DIKCDEL=$G(DIKCXREF("NAME"))]""
 M DIKCXR=DIKCXREF
 ;
 ;Check input, set defaults
 D CHK(.DIKCXR,.DIKCERR) G:DIKCERR EXIT
 D CHKVAL(.DIKCXR,.DIKCERR) G:DIKCERR EXIT
 ;
 ;Delete the old index of the same name
 D:DIKCDEL
 . N DIKCFLAG,DIERR,DIKCDMSG
 . S DIKCFLAG="d"_$E("W",DIFLG["W")_$E("K",DIFLG'["k")
 . D DELIXN^DDMOD(DIKCXR("FILE"),DIKCXR("NAME"),DIKCFLAG,"","DIKCDMSG")
 ;
 ;Create the index
 D UPDATE(.DIKCXR,.DIXR,DIFLG) I DIXR="" S DIKCERR=1 G EXIT
 ;
 ;Execute set logic
 D:DIFLG["S" SET(DIXR,DIFLG)
 ;
 ;Recompile templates and xrefs
 D:DIFLG'["r" RECOMP(DIXR,DIFLG)
 ;
EXIT ;Write and move error messages if necessary
 I $G(DIERR) D
 . D:DIFLG["W" MSG^DIALOG("WES")
 . D:$G(DIKCMSG)]"" CALLOUT^DIEFU(DIKCMSG)
 I $G(DIKCERR) S DIXR=""
 E  S DIXR=DIXR_U_DIKCXR("NAME")
 Q
 ;
UPDATE(DIKCXR,DIXR,DIFLG) ;Call Updater to create index, return DIXR=ien
 N DIKCFDA,DIKCIEN,IENS,ORD,R,SEQ,X
 W:$G(DIFLG)["W" !,"Creating index definition ..."
 ;
 ;Set FDA for top level Index file fields
 S DIKCFDA(.11,"+1,",.01)=DIKCXR("FILE")
 S DIKCFDA(.11,"+1,",.02)=DIKCXR("NAME")
 S DIKCFDA(.11,"+1,",.11)=DIKCXR("SHORT DESCR")
 S DIKCFDA(.11,"+1,",.2)=DIKCXR("TYPE")
 S DIKCFDA(.11,"+1,",.4)=DIKCXR("EXECUTION")
 S DIKCFDA(.11,"+1,",.41)=DIKCXR("ACTIVITY")
 S DIKCFDA(.11,"+1,",.42)=DIKCXR("USE")
 S DIKCFDA(.11,"+1,",.5)=DIKCXR("ROOT TYPE")
 S DIKCFDA(.11,"+1,",.51)=DIKCXR("ROOT FILE")
 S DIKCFDA(.11,"+1,",1.1)=$S($G(DIKCXR("SET"))]"":DIKCXR("SET"),1:"Q")
 S DIKCFDA(.11,"+1,",2.1)=$S($G(DIKCXR("KILL"))]"":DIKCXR("KILL"),1:"Q")
 S:$G(DIKCXR("SET CONDITION"))]"" DIKCFDA(.11,"+1,",1.4)=DIKCXR("SET CONDITION")
 S:$G(DIKCXR("KILL CONDITION"))]"" DIKCFDA(.11,"+1,",2.4)=DIKCXR("KILL CONDITION")
 S:$G(DIKCXR("WHOLE KILL"))]"" DIKCFDA(.11,"+1,",2.5)=DIKCXR("WHOLE KILL")
 ;
 ;Set FDA for Values multiple
 S ORD=0 F SEQ=2:1 S ORD=$O(DIKCXR("VAL",ORD)) Q:'ORD  D
 . S IENS="+"_SEQ_",+1,"
 . S R=$NA(DIKCXR("VAL",ORD))
 . S DIKCFDA(.114,IENS,.01)=ORD
 . S DIKCFDA(.114,IENS,1)=@R@("TYPE")
 . ;
 . I @R@("TYPE")="C" S DIKCFDA(.114,IENS,4.5)=@R
 . E  D
 .. S DIKCFDA(.114,IENS,2)=DIKCXR("ROOT FILE")
 .. S DIKCFDA(.114,IENS,3)=@R
 .. S X=$G(@R@("XFORM FOR STORAGE")) S:X]"" DIKCFDA(.114,IENS,5)=X
 .. S X=$G(@R@("XFORM FOR LOOKUP")) S:X]"" DIKCFDA(.114,IENS,5.3)=X
 .. S X=$G(@R@("XFORM FOR DISPLAY")) S:X]"" DIKCFDA(.114,IENS,5.5)=X
 . ;
 . S X=$G(@R@("SUBSCRIPT")) S:X]"" DIKCFDA(.114,IENS,.5)=X
 . S X=$G(@R@("LENGTH")) S:X]"" DIKCFDA(.114,IENS,6)=X
 . S X=$G(@R@("COLLATION")) S:X]"" DIKCFDA(.114,IENS,7)=X
 . S X=$G(@R@("LOOKUP PROMPT")) S:X]"" DIKCFDA(.114,IENS,8)=X
 ;
 ;Call Updater
 D UPDATE^DIE("E","DIKCFDA","DIKCIEN")
 K DIXR I $G(DIERR) S DIXR="" Q
 S DIXR=DIKCIEN(1)
 ;
 ;Add Description
 D:$O(DIKCXR("DESCR",0)) WP^DIE(.11,DIXR_",",.1,"",$NA(DIKCXR("DESCR")))
 Q
 ;
RECOMP(DIXR,DIFLG) ;Recompile templates and xrefs, update triggering fields
 N DIKCFLIS,DIKCI,DIKCTLIS,DIKCTOP,DIKTEML
 ;
 ;Get top level file number
 S DIKCTOP=$$FNO^DILIBF($P($G(^DD("IX",DIXR,0)),U)) Q:'DIKCTOP
 ;
 ;Get list of fields in xref
 D GETFLIST^DIKCUTL(DIXR,.DIKCFLIS) Q:'$D(DIKCFLIS)
 ;
 ;Recompile input templates and xrefs
 D DIEZ^DIKD2(.DIKCFLIS,DIFLG,$G(DIKCOUT))
 D DIKZ^DIKD(DIKCTOP,DIFLG,$G(DIKCOUT)) S DIKCTOP(DIKCTOP)=""
 ;
 ;Also update triggering fields, and their compiled templates and xrefs
 D TRIG^DICR(.DIKCFLIS,.DIKCTLIS)
 I $D(DIKCTLIS) D
 . D DIEZ^DIKD2(.DIKCTLIS,DIFLG,$G(DIKCOUT))
 . S DIKCI=0 F  S DIKCI=$O(DIKCTLIS(DIKCI)) Q:'DIKCI  D
 .. S DIKCTOP=+$$FNO^DILIBF(DIKCI) Q:$D(DIKCTOP(DIKCTOP))#2!'DIKCTOP
 .. S DIKCTOP(DIKCTOP)=""
 .. D DIKZ^DIKD(DIKCTOP,DIFLG,$G(DIKCOUT))
 Q
 ;
CHK(DIKCXR,DIKCERR) ;Check/default input array
 N FIL,NAM,RFIL,TYP,USE
 S DIKCERR=0
 ;
 ;Check FILE
 S FIL=$G(DIKCXR("FILE")) I 'FIL D ER202("FILE") Q
 I '$$VFNUM^DIKCU1(FIL,"D") S DIKCERR=1 Q
 ;
 ;Check Type, get internal form
 S TYP=$G(DIKCXR("TYPE")) I TYP="" D ER202("TYPE") Q
 D CHK^DIE(.11,.2,"",TYP,.TYP) I TYP=U S DIKCERR=1 Q
 S DIKCXR("TYPE")=TYP
 ;
 ;Check USE, get internal form.
 S USE=$G(DIKCXR("USE"))
 I USE]"" D CHK^DIE(.11,.42,"",USE,.USE) I USE=U S DIKCERR=1 Q
 S DIKCXR("USE")=USE
 ;
 S NAM=$G(DIKCXR("NAME"))
 S RFIL=$G(DIKCXR("ROOT FILE"))
 ;
 ;Check Root File, set Root Type
 S:'RFIL (RFIL,DIKCXR("ROOT FILE"))=FIL
 I FIL=RFIL S DIKCXR("ROOT TYPE")="I"
 E  D  Q:DIKCERR
 . I $$FLEVDIFF^DIKCU(FIL,RFIL)="" D ER202("ROOT FILE") Q
 . I '$$VFNUM^DIKCU1(RFIL,"D") S DIKCERR=1 Q
 . S DIKCXR("ROOT TYPE")="W"
 ;
 ;Check USE, NAME, TYPE
 I NAM="",USE="" D ER202("NAME/USE") Q
 I $E(NAM)="A",USE="LS" D ER202("NAME/USE") Q
 I USE="A",TYP'="MU" D ER202("TYPE/USE") Q
 ;
 ;Default NAM based on USE and FILE
 ; or USE based on NAME and TYPE
 I NAM="" S DIKCXR("NAME")=$$GETNAM(FIL,USE)
 E  I USE="" S DIKCXR("USE")=$S($E(NAM)="A":$S(TYP="MU":"A",1:"S"),1:"LS")
 ;
 ;Check SHORT DESCRIPTION'=null', if null set default Activity
 I $G(DIKCXR("SHORT DESCR"))="" D ER202("SHORT DESCR") Q
 S:$D(DIKCXR("ACTIVITY"))[0 DIKCXR("ACTIVITY")="IR"
 Q
 ;
CHKVAL(DIKCXR,DIKCERR) ;Check values, build logic for regular indexes
 N CNT,FCNT,FIL,KILL,L,LEV,LDIF,MAXL,NAM,ORD,RFIL,ROOT,SBSC,SEQ,SET,TYP,VAL,WKIL
 ;
 S FIL=DIKCXR("FILE")
 S NAM=DIKCXR("NAME")
 S RFIL=DIKCXR("ROOT FILE")
 S TYP=DIKCXR("TYPE")
 S DIKCERR=0
 ;
 ;Begin building logic for regular indexes
 I TYP="R" D  Q:DIKCERR
 . I FIL'=RFIL S LDIF=$$FLEVDIFF^DIKCU(FIL,RFIL)
 . E  S LDIF=0
 . S ROOT=$$FROOTDA^DIKCU(FIL,LDIF_"O",.LEV)_""""_NAM_""""
 . I $D(DIERR) S DIKCERR=1 Q
 . S WKIL="K "_ROOT_")"
 ;
 ;Build list of subscripts, count #values and #fields
 S ORD=0 F  S ORD=$O(DIKCXR("VAL",ORD)) Q:'ORD  D  Q:DIKCERR
 . I $G(DIKCXR("VAL",ORD))="" K DIKCXR("VAL",ORD) Q
 . S CNT=$G(CNT)+1
 . ;
 . ;Get type of value; if field, increment field count
 . I DIKCXR("VAL",ORD) S DIKCXR("VAL",ORD,"TYPE")="F",FCNT=$G(FCNT)+1
 . E  S DIKCXR("VAL",ORD,"TYPE")="C"
 . ;
 . ;Set subscript array; error if duplicate subscript #
 . S SBSC=$G(DIKCXR("VAL",ORD,"SUBSCRIPT")) Q:'SBSC
 . I $D(SBSC(SBSC))#2 D ER202("SUBSCRIPT") Q
 . S SBSC(SBSC)=ORD_U_$G(DIKCXR("VAL",ORD,"LENGTH"))
 . ;
 . ;Set default collation
 . S:$G(DIKCXR("VAL",ORD,"COLLATION"))="" DIKCXR("VAL",ORD,"COLLATION")="F"
 Q:DIKCERR
 ;
 S SBSC=0 F SEQ=1:1 S SBSC=$O(SBSC(SBSC)) Q:'SBSC  D  Q:DIKCERR
 . ;Check that subscripts are consecutive from 1
 . I SEQ'=SBSC D ER202("SUBSCRIPTS") Q
 . Q:TYP="MU"
 . ;
 . ;Continue building logic for regular indexes
 . S ORD=$P(SBSC(SBSC),U),MAXL=$P(SBSC(SBSC),U,2)
 . I $G(CNT)=1 S VAL=$S(MAXL:"$E(X,1,"_MAXL_")",1:"X")
 . E  S VAL=$S(MAXL:"$E(X("_ORD_"),1,"_MAXL_")",1:"X("_ORD_")")
 . S ROOT=ROOT_","_VAL
 ;
 ;If null, default Execution based on #fields
 S:$G(DIKCXR("EXECUTION"))="" DIKCXR("EXECUTION")=$S($G(FCNT)>1:"R",1:"F")
 ;
 ;We're done for MUMPS xrefs
 Q:TYP="MU"
 ;
 ;Continue building logic for regular indexes
 F L=LDIF:-1:1 S ROOT=ROOT_",DA("_L_")"
 S ROOT=ROOT_",DA)"
 ;
 I '$O(SBSC(0)) S (SET,KILL)="Q",WKIL=""
 E  S SET="S "_ROOT_"=""""",KILL="K "_ROOT
 S DIKCXR("SET")=SET
 S DIKCXR("KILL")=KILL
 S DIKCXR("WHOLE KILL")=WKIL
 Q
 ;
GETNAM(F01,USE) ;Get next available index name
 N ASC,STRT,NAME,I
 S STRT=$S(USE="LS":"",1:"A")
 F ASC=67:1:89 D  Q:NAME]""
 . S NAME=STRT_$C(ASC)
 . I $D(^DD("IX","BB",F01,NAME)) S NAME="" Q
 . I $D(^DD(F01,0,"IX",NAME)) S NAME="" Q
 Q:NAME]"" NAME
 ;
 F I=1:1 D  Q:NAME]""
 . S NAME=STRT_"C"_I
 . I $D(^DD("IX","BB",F01,NAME)) S NAME="" Q
 . I $D(^DD(F01,0,"IX",NAME)) S NAME="" Q
 Q NAME
 ;
SET(DIXR,DIFLG) ;Execute set logic
 N DIKCRFIL,DIKCTOP,DIKCTRL,DIKCTYP
 ;
 S DIKCTOP=$$FNO^DILIBF($P($G(^DD("IX",DIXR,0)),U)) Q:'DIKCTOP
 S DIKCRFIL=$P($G(^DD("IX",DIXR,0)),U,9) Q:'DIKCRFIL
 S DIKCTYP=$P($G(^DD("IX",DIXR,0)),U,4)
 ;
 I $G(DIFLG)["W" D
 . I DIKCTYP="R" W !,"Building index ..."
 . E  W !,"Executing set logic ..."
 ;
 ;Call INDEX^DIKC to execute the set logic
 S DIKCTRL="S"_$S(DIKCTOP'=DIKCRFIL:"W"_DIKCRFIL,1:"")
 D INDEX^DIKC(DIKCTOP,"","",DIXR,.DIKCTRL)
 Q
 ;
ER202(DIKCP1) ;;The input variable or parameter that identifies the |1| is missing or invalid.
 D ERR^DIKCU2(202,"","","",DIKCP1)
 S DIKCERR=1
 Q
