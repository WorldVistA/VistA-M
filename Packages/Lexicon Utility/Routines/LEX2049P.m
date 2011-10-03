LEX2049P ; ISL/OI - Post Install LEX*2.0*49  ; 02/22/2007
 ;;2.0;LEXICON UTILITY;**49**;Sep 23, 1996;Build 3
 ;                    
 ; Global Variables
 ;    ^%ZOSF("DEL" 
 ;    ^%ZOSF("TEST"
 ;    ^LEXC
 ;    ^LEXM(0
 ;    ^LEXT(757.2
 ;    ^ORD(101
 ;    ^TMP("LEXCNT"
 ;    ^TMP("LEXCS"
 ;    ^TMP("LEXI"
 ;    ^TMP("LEXINS"
 ;    ^TMP("LEXKID"
 ;    ^TMP("LEXMSG"
 ;                
 ; External References
 ;    HOME^%ZIS
 ;    $$GET1^DID
 ;    ^DIK
 ;    ^DIM
 ;    $$GET1^DIQ
 ;    EN^DIU2
 ;    $$DT^XLFDT
 ;    $$FMTE^XLFDT
 ;    $$NOW^XLFDT
 ;    BMES^XPDUTL
 ;    MES^XPDUTL
 ;    EN^XQOR
 ;    $$DTIME^XUP
 ;                        
POST ; Post-Install Main Entry Point
 N CNT,DA,DIK,DIU,ERR,EXEC,FI,FIX,FNAME,I,INST,LEX,LEXBEG,LEXBUILD,LEXCHG,LEXEDT,LEXELP,LEXEND
 N LEXFC,LEXI,LEXID,LEXMOD,LEXMUL,LEXNM,LEXO,LEXP,LEXPOST,LEXSCHG,LEXSHORT,LEXSUB,LEXTCS,LEXTND
 N NAME,OK,PN,PNO,ROK,RTN,SSIEN,STR,T,TAG,TXT,TY,X,Y,ZTQUEUED,ZTREQ S LEXPOST="",LEXSHORT="",(LEXID,LEXSUB)="LEXKID" D MSG1
 S LEXCHG=1,LEXEDT=$$NOW^XLFDT,LEXSCHG("0")="1"
 S LEXSCHG("81",0)="",LEXSCHG("81.1",0)="",LEXSCHG("81.2",0)="",LEXSCHG("81.3",0)=""
 S LEXSCHG("B","81")="",LEXSCHG("B","81.1")="",LEXSCHG("B","81.2")="",LEXSCHG("B","81.3")=""
 S LEXSCHG("C","CPT","81")="",LEXSCHG("C","CPT","81.1")="",LEXSCHG("C","CPT","81.2")="",LEXSCHG("C","CPT","81.3")=""
 S LEXSCHG("80",0)="",LEXSCHG("80.1",0)=""
 S LEXSCHG("B","80")="",LEXSCHG("B","80.1")=""
 S LEXSCHG("C","ICD","80")="",LEXSCHG("C","ICD","80.1")=""
 S LEXSCHG("757",0)="",LEXSCHG("757.001",0)="",LEXSCHG("757.01",0)="",LEXSCHG("757.02",0)="",LEXSCHG("757.1",0)=""
 S LEXSCHG("B","757")="",LEXSCHG("B","757.001")="",LEXSCHG("B","757.01")="",LEXSCHG("B","757.02")="",LEXSCHG("B","757.1")=""
 S LEXSCHG("C","LEX","757")="",LEXSCHG("C","LEX","757.001")="",LEXSCHG("C","LEX","757.01")="",LEXSCHG("C","LEX","757.02")="",LEXSCHG("C","LEX","757.1")=""
 S LEXSCHG("D","PRO")="",LEXSHORT=""
 D DDUZ,CHGF,RTN,INST,NOTIFY,MSG2,KALL^LEXXGI2
 Q
INST ; Installed Patches
 N INST,STR D BL
 S INST=$$PROK("PXRMCSD",9) S STR=" PXRM*2.0*9      "_$S(INST>0:"Installed",1:"Not Installed") D BM(STR),TL(STR)
 S INST=$$PROK("ICDUPDT",28) S STR=" ICD*18.0*28     "_$S(INST>0:"Installed",1:"Not Installed") D M(STR),TL(STR)
 S INST=$$PROK("ICPTAU",34) S STR=" ICPT*6.0*34     "_$S(INST>0:"Installed",1:"Not Installed") D M(STR),TL(STR)
 S INST=$$PROK("LEXXGI",49) S STR=" LEX*2.0*49      "_$S(INST>0:"Installed",1:"Not Installed") D M(STR),TL(STR)
 Q
NOTIFY ; Notify by Protocol - LEXICAL SERVICES UPDATE
 N LEXP,X,STR
 S STR="ERROR:  Array of files not found" D:'$D(LEXSCHG) BM(STR),BL,TL(STR) Q:'$D(LEXSCHG)
 S LEXP=+($O(^ORD(101,"B","LEXICAL SERVICES UPDATE",0)))
 S STR="ERROR:  LEXICAL SERVICES UPDATE protocol not found" D:$G(LEXP)'>0 BM(STR),BL,TL(STR) Q:LEXP=0
 S X=LEXP_";ORD(101," D EN^XQOR
 S STR="ERROR:  LEXICAL SERVICES UPDATE protocol not invoked" D:$D(LEXSCHG) BM(STR),BL,TL(STR) Q:$D(LEXSCHG)
 S ^LEXM(0,"PRO")=$$NOW^XLFDT,X="Protocol 'LEXICAL SERVICES UPDATE' was invoked"
 W:'$D(XPDNM) !!,X D:$D(XPDNM) BM(X)
 S (STR,X)="Subscribing applications were notified",STR="  "_STR D BL,TL(STR)
 W:'$D(XPDNM) !,X D:$D(XPDNM) M(X)
 Q
CHGF ; Change File
 D M(" "),RI("Removing Change Files (757.9-757.91)","Remedy 175985") N FI,FNAME,ERR,ROK,STR
 S FI=757.91,FNAME=$$GET1^DID(FI,"","","NAME","","ERR") I $L(FNAME) D
 . N DIU,ERR S DIU="^LEXC("_FI_",",DIU(0)="D" D EN^DIU2 K:'$L($$GET1^DID(FI,"","","NAME","","ERR")) ^LEXC(FI)
 S FI=757.903,FNAME=$$GET1^DID(FI,"","","NAME","","ERR") I $L(FNAME) D
 . N DIU,ERR S DIU="^LEXC("_FI_",",DIU(0)="D" D EN^DIU2 K:'$L($$GET1^DID(FI,"","","NAME","","ERR")) ^LEXC(FI)
 S FI=757.9,FNAME=$$GET1^DID(FI,"","","NAME","","ERR") I $L(FNAME) D
 . N DIU,ERR S DIU="^LEXC("_FI_",",DIU(0)="D" D EN^DIU2 K:'$L($$GET1^DID(FI,"","","NAME","","ERR")) ^LEXC(FI)
 S FI=757.901,FNAME=$$GET1^DID(FI,"","","NAME","","ERR") I $L(FNAME) D
 . N DIU,ERR S DIU="^LEXC("_FI_",",DIU(0)="D" D EN^DIU2 K:'$L($$GET1^DID(FI,"","","NAME","","ERR")) ^LEXC(FI)
 S FI=757.902,FNAME=$$GET1^DID(FI,"","","NAME","","ERR") I $L(FNAME) D
 . N DIU,ERR S DIU="^LEXC("_FI_",",DIU(0)="D" D EN^DIU2 K:'$L($$GET1^DID(FI,"","","NAME","","ERR")) ^LEXC(FI)
 I '$D(^LEXC) S STR="Removed Change Files (757.9-757.91) (Remedy 175985)" D BL,TL(STR)     Q
 Q
RTN ; Routines
 D M(" "),BL D DRTN,MRTN
 Q
DRTN ; Delete Routines
 N EXEC,ROK,RTN,STR,X
 S X=$G(^%ZOSF("DEL")) Q:'$L(X)  D ^DIM Q:'$D(X)  Q:'$L(X)  S EXEC=X
 F RTN="LEXCHGF","LEXCHGF2","LEXNDX7","LEXXST5" D
 . S ROK=+($$ROK(RTN)) I +ROK'>0 S STR="    "_RTN,STR=STR_$J(" ",(17-$L(STR)))_"Deleted" D M(STR),TL(STR) Q
 . S X=RTN X EXEC
 . S ROK=+($$ROK(RTN)) I +ROK'>0 S STR="    "_RTN,STR=STR_$J(" ",(17-$L(STR)))_"Deleted" D M(STR),TL(STR) Q
 . S STR="    "_RTN D M(STR),TL(STR)
 Q
MRTN ; Modified Routines
 N CNT,EXEC,FIX,I,RTN,PN,PNO,STR,TXT,TY S CNT=0 F I=1:1 D  Q:'$L(TXT)
 . S TXT="" S EXEC="S TXT=$T(MRN+"_I_"^LEX2049P)" X EXEC
 . S TXT=$P(TXT,";;",2,299) Q:TXT=""
 . S RTN=$P(TXT,";",1) S:'$L(RTN) TXT="" Q:'$L(TXT)  Q:+($$ROK(RTN))=0
 . S PN=$P(TXT,";",2),TY=$P(TXT,";",3),FIX=$P(TXT,";",4)
 . S PNO=$$PROK(RTN,PN)
 . S STR="    "_RTN S:+PNO>0 STR=STR_$J(" ",(17-$L(STR)))_TY S:+PNO>0 STR=STR_$J(" ",(29-$L(STR)))_FIX
 . D M(STR),TL(STR)
 Q
MRN ; Modified Routine Names
 ;;LEXXFI;49;Modified;Removed references to file #757.9
 ;;LEXXFI7;49;Modified;Removed references to file #757.9
 ;;LEXXST;49;Modified;Removed references to file #757.9
 ;;LEXXGI;49;Modified;Fix LEXICAL SERVICES UPDATE Protocol
 ;;LEXXGI2;49;Modified;Fix LEXICAL SERVICES UPDATE Protocol
 ;;LEXXII;49;Modified;Fix Install Message (Protocol)
 ;;ICDUPDT;28;Modified;Fix ICD CODE UPDATE EVENT Protocol
 ;;ICPTAU;34;Modified;Fix ICPT CODE UPDATE EVENT Protocol
 ;;PXRMCSD;9;Modified;Fix ICD/CPT Reminder Dialogs Message
 ;;PXRMCSTX;9;Modified;Fix ICD/CPT Reminder Taxonomies Message
 ;;
DDUZ ; Delete Exported DUZ if broken Pointer
 N STR S STR="Removing broken Pointer in file #757.2"
 D M(" "),RI(STR,"ROF LEX*2.0*46") S STR=STR_" (ROF LEX*2.0*46)" Q:$L($$GET1^DIQ(200,("1118,"),.01))
 D BL,TL(STR) N DA,DIK,NAME,SSIEN S SSIEN=0 F  S SSIEN=$O(^LEXT(757.2,SSIEN)) Q:+SSIEN'>0  D
 . Q:'$D(^LEXT(757.2,SSIEN,200))  Q:$O(^LEXT(757.2,SSIEN,200,0))'>0  Q:'$D(^LEXT(757.2,SSIEN,200,1118))
 . N DA,DIK,NAME S NAME=$P($G(^LEXT(757.2,SSIEN,0)),"^",1) D:$L(NAME) CI(("  "_NAME))
 . S DA(1)=SSIEN,DA=1118,DIK="^LEXT(757.2,"_SSIEN_",200," D ^DIK
 Q
ROK(X) ; Routine OK
 S X=$G(X) Q:'$L(X) 0  Q:$L(X)>8 0  X ^%ZOSF("TEST") Q:$T 1  Q 0
PROK(X,Y) ; Routine and Patch # OK (in UCI)
 N LEX,LEXI,LEXO S X=$G(X),Y=$G(Y) Q:'$L(X) 0 Q:Y'=""&(+Y=0)
 S Y=+Y,LEX=$$ROK(X) Q:'LEX 0 Q:+Y=0 1 S LEXO=0,LEX=$T(@("+2^"_X)),LEX=$P($P(LEX,"**",2),"**",1)
 F LEXI=1:1:$L(LEX,",") S:+($P(LEX,",",LEXI))=Y LEXO=1 Q:LEXO=1
 S X=LEXO
 Q X
LL(T,X) ; Line Label
 N RTN,TAG,ROK,EXEC,OK S TAG=$G(T),RTN=$G(X) Q:'$L(RTN) 0  S ROK=$$ROK(RTN) Q:+ROK'>0 0  S:'$L(TAG)&($L(RTN)) TAG=RTN
 S OK=0,EXEC="S OK=$L($T("_TAG_"^"_RTN_")) S OK=$S(OK>0:1,1:0)" X EXEC S X=+($G(OK))
 Q X
MSG1 ; Send Installation Message to G.LEXICON
 K ^TMP("LEXCS",$J),^TMP("LEXCNT",$J),^TMP("LEXI",$J),^TMP("LEXMSG",$J)
 K ^TMP("LEXINS",$J),^TMP("LEXKID",$J) S:$D(ZTQUEUED) ZTREQ="@"
 N LEXBEG,LEXELP,LEXEND,LEXFC,LEXMOD,LEXMUL,LEXTCS,LEXTND,LEXID,ZTQUEUED
 S LEXID="LEXKID",LEXMUL=1,(LEXTND,LEXTCS,LEXMOD,LEXFC,ZTQUEUED)=0
 D HDR^LEXXFI,EN^LEXXII K ^LEXM(0,"PRO")
 Q
MSG2 ; Send Installation (part 2)
 N LEXSHORT,ZTQUEUED,LEXBUILD S ZTQUEUED=0,LEXSHORT=1,LEXBUILD="LEX*2.0*49"
 D MAIL^LEXXFI,KILL^LEXXFI
 Q
ENV(X) ; Environment check
 N LEXNM D HOME^%ZIS S U="^",DT=$$DT^XLFDT,LEXNM=$$GET1^DIQ(200,+($G(DUZ)),.01),DTIME=$$DTIME^XUP(+($G(DUZ))) Q:+($G(DUZ))'>0!('$L(LEXNM)) 0
 Q 1
ED(LEX) ; External Date MM/DD/YYYY TT:TT
 N XPDNM S LEX=$$FMTE^XLFDT($G(LEX),"1Z") S:LEX["@" LEX=$P(LEX,"@",1)_"  "_$P(LEX,"@",2,299)
 Q LEX
RI(X,Y) ; Reference - Indented
 N I S X=$G(X),Y=$G(Y) Q:'$L(X)
 I $L(Y) S X="    "_X F  Q:$L(X)>54  S X=X_" "
 S X=X_" "_Y S:$E(X,1)'=" " X="    "_X D MES^XPDUTL(X) Q
CI(X) ; Comment Text - Indented
 N I S X=$G(X) Q:'$L(X)  S X="    "_X D MES^XPDUTL(X)
 Q
BL ;   Blank Line
 D TL("") Q
TL(LEXX) ;   Text Line
 S LEXSUB=$G(LEXSUB) S:'$L(LEXSUB) LEXSUB="LEXXII"
 I '$D(^TMP(LEXSUB,$J,1)) S ^TMP(LEXSUB,$J,1)=" ",^TMP(LEXSUB,$J,0)=1
 N LEXNX S LEXNX=$O(^TMP(LEXSUB,$J," "),-1),LEXNX=LEXNX+1
 S ^TMP(LEXSUB,$J,LEXNX)=" "_$G(LEXX),^TMP(LEXSUB,$J,0)=LEXNX
 Q
BM(X) ; Blank and Line
 D BMES^XPDUTL($G(X))
 Q
M(X) ; Line
 D MES^XPDUTL($G(X))
 Q
