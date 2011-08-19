GMTSOBE ; SLC/KER - HS Object - Export            ; 05/22/2008
 ;;2.7;Health Summary;**89**;Oct 20, 1995;Build 61
 ;                    
 ; External References
 ;
 ;   DBIA 10096  ^%ZOSF("DEL" 
 ;   DBIA  2056  $$GET1^DIQ (file #200 and 4.3)
 ;   DBIA 10112  $$SITE^VASITE
 ;   DBIA 10103  $$DOW^XLFDT
 ;   DBIA 10103  $$DT^XLFDT
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA 10103  $$NOW^XLFDT
 ;   DBIA 10104  $$UP^XLFSTR
 ;   DBIA 10070  ^XMD
 ;                        
EN ; Main Entry Point to Export a HS Object
 N %Z,GMTS,GMTSCP,GMTSD,GMTSDM,GMTSDT,GMTSDW,GMTSEX,GMTSFRM,GMTSHD
 N GMTSI,GMTSN,GMTSNC,GMTSND,GMTSNN,GMTSNX,GMTSO,GMTSON,GMTSOND
 N GMTSQIT,GMTSRT,GMTSRTN,GMTSSX,GMTST,GMTSTMP,GMTSTN,GMTSTN0
 N GMTSTNAT,GMTSTNT,GMTSTNV,GMTSTR,GMTSTT,GMTSTXT,GMTSUSR,GMTSX
 N X,XCNP,XMDUZ,XMSCR,XMSUB,XMTEXT,XMY,XMZ,Y I +($G(DUZ))=0 W !!," User not defined" Q
 S GMTSUSR=$$GET1^DIQ(200,(+($G(DUZ))_","),.01) I '$L(GMTSUSR) W !!," Invalid User" Q
 S X=$$OBJ^GMTSOBL Q:+X'>0  S GMTSFRM=$P($$SITE^VASITE,"^",2),GMTSO=+X,GMTSOND=$G(^GMT(142.5,+GMTSO,0))
 S GMTSON=$P(GMTSOND,"^",1),GMTST=+($P(GMTSOND,"^",3)) Q:GMTST=0
 S GMTSTN0=$G(^GMT(142,+GMTST,0)),GMTSTNT=$G(^GMT(142,+GMTST,"T"))
 S GMTSTNV=$G(^GMT(142,+GMTST,"VA")),GMTSTN=$P(GMTSTN0,"^",1) Q:'$L(GMTSTN)
 S GMTSTT=$P(GMTSTNT,"^",1) S:'$L(GMTSTT)&($L(GMTSTN)) GMTSTT=$$EN2^GMTSUMX(GMTSTN)
 I GMTSTN="GMTS HS ADHOC OPTION" D  Q
 . W !," Can not export a Health Summary Object using GMTS HS ADHOC OPTION",!," (Adhoc) Health Summary Type."
 S GMTSTNAT=+GMTSTNV I GMTSTNAT>0 D  Q
 . W !," Can not export a Health Summary Object using a nationally released",!," Remote Data View Health Summary Type."
 S GMTSRTN="GMTSOBX" D INIT,TYPE,OBJ,MAIL
 K ^TMP($J,"GMTSOBXM")
 Q
INIT ; Initialize Export Routine
 Q:'$L(GMTSON)  Q:'$L(GMTSFRM)  Q:'$L(GMTSUSR)
 W !!," Exporting Object Routine - ",GMTSRTN D CRTN(GMTSRTN)
 N GMTST,GMTSI
 K ^TMP($J,"GMTSOBXM")
 S GMTST=$$CREATED D TL(GMTST)
 D BL D:$L($G(GMTSON)) TL((" Object:  "_GMTSON))
 D:$L($G(GMTSFRM)) TL((" From:    "_GMTSFRM))
 D:$L($G(GMTSUSR)) TL((" Sender:  "_GMTSUSR))
 D:$L($G(GMTSON))!($L($G(GMTSFRM)))!($L($G(GMTSUSR))) BL
 D TL(" 1) Use Packman to unpack the routine GMTSOBX contained in this message."),BL
 D TL(" 2) Use the following Option to install the Health Summary Object")
 D TL("    contained in this message."),BL
 D TL("      GMTS OBJ IMPORT/INSTALL")
 D TL("        Import/Install a Health Summary Object"),BL
 D TL("    or run the routine INS^GMTSOBJ"),BL
 D TL("$END TXT")
 D TL(("$ROU "_GMTSRTN))
 D TL((GMTSRTN_" ; CIO/SLC - HS Exported Object          ; "_$P($$FMTE^XLFDT($$NOW^XLFDT,"5Z"),"@",1)))
 D TL((" ;;"_$$VER_";Health Summary;;Oct 20, 1995")),S
 D:$L($G(GMTSON)) TL((" ; Object:  "_GMTSON))
 D:$L($G(GMTSFRM)) TL((" ; From:    "_GMTSFRM))
 D:$L($G(GMTSUSR)) TL((" ; Sender:  "_GMTSUSR)) D S,Q
 Q
 ;                         
TYPE ; Export Health Summary Type
 ;   This will not export:
 ;     National Health Summary Types
 ;     Local Components
 ;     Components with Selected Items
 N GMTSCP,GMTSHD,GMTSNC,GMTSND,GMTSNN,GMTSRT,GMTSTMP,GMTSTR
 N GMTSNX,GMTSSX,GMTSD
 D TL(("TYPE ; Health Summary Type"))
 I +($G(^GMT(142,+GMTST,"VA")))>0 D Q Q
 D TL((" ;"_GMTSTN)),TL((" ;"_GMTSTT))
 S GMTSTMP=$G(^GMT(142,+($G(GMTST)),0)),GMTSTMP=GMTSTN,$P(GMTSTMP,"^",2)="",$P(GMTSTMP,"^",5)=""
 D TL((" ;0;"_GMTSTMP))
 S GMTSRT="^GMT(142,"_+($G(GMTST))_","
 S GMTSNN="^GMT(142,"_+($G(GMTST))_",1)"
 S GMTSNC="^GMT(142,"_+($G(GMTST))_",1," S GMTSTR=1
 F  S GMTSNN=$Q(@GMTSNN) Q:GMTSNN=""!(GMTSNN'[GMTSNC)  D
 . S GMTSTR=$P($P(GMTSNN,GMTSRT,2),")",1)
 . S:$P(GMTSTR,",",3)="1" GMTSD(+($P(GMTSTR,",",2)))="" Q:$P(GMTSTR,",",3)="1"
 . S GMTSNX=$Q(@GMTSNN),GMTSSX=$P($P(GMTSNX,GMTSRT,2),")",1)
 . S:$P(GMTSSX,",",3)="1" GMTSD(+($P(GMTSSX,",",2)))="" Q:$P(GMTSSX,",",3)="1"
 . S GMTSND=@GMTSNN I GMTSTR="1,0" D TL((" ;"_GMTSTR_";"_GMTSND)) Q
 . S GMTSCP=+($P(GMTSND,"^",2)) Q:+GMTSCP>1000
 . S GMTSHD=$P($G(^GMT(142.1,+GMTSCP,0)),"^",9)
 . S:$P(GMTSND,"^",5)="" $P(GMTSND,"^",5)=GMTSHD
 . S:+($P(GMTSTR,",",2))=0 GMTSND=""
 . I +($P(GMTSTR,",",2))=0,+($P(GMTSTR,",",4))>0,$D(GMTSD(+($P(GMTSTR,",",4)))) Q
 . D TL((" ;"_GMTSTR_";"_GMTSND))
 D TL((" ;99;"_$H)) D:$L(GMTSTT) TL((" ;""T"";"_GMTSTT)) D Q
 Q
 ;                         
OBJ ; Export an Object
 N GMTSNC,GMTSND,GMTSNN,GMTSRT,GMTSTMP,GMTSTR
 D TL(("OBJ ; Health Summary Object")),TL((" ;"_GMTSON))
 S GMTSTMP=$G(^GMT(142.5,+GMTSO,0)),$P(GMTSTMP,"^",3)="",$P(GMTSTMP,"^",17)="",$P(GMTSTMP,"^",18)="",$P(GMTSTMP,"^",19)=""
 D TL((" ;0;"_GMTSTMP)) S GMTSRT="^GMT(142.5,"_+($G(GMTSO))_","
 S GMTSTMP=$G(^GMT(142.5,+GMTSO,2)) D TL((" ;2;"_GMTSTMP))
 S GMTSNN="^GMT(142.5,"_+($G(GMTSO))_",1)",GMTSNC="^GMT(142.5,"_+($G(GMTSO))_",1,"
 F  S GMTSNN=$Q(@GMTSNN) Q:GMTSNN=""!(GMTSNN'[GMTSNC)  D
 . S GMTSTR=$P($P(GMTSNN,GMTSRT,2),")",1),GMTSND=@GMTSNN D TL((" ;"_GMTSTR_";"_GMTSND))
 D Q,TL(("$END ROU "_GMTSRTN))
 Q
 ;                   
 ; Message
Q ;   Quit Line
 D TL(" Q") Q
S ;   Spacer/Comment Line
 D TL(" ;                   ") Q
BL ;   Blank Line
 D TL(" ") Q
TL(X) ;   Text Line
 N GMTS S GMTS=+($G(^TMP($J,"GMTSOBXM",0))),GMTS=GMTS+1
 S ^TMP($J,"GMTSOBXM",GMTS,0)=$G(X),^TMP($J,"GMTSOBXM",0)=GMTS
 Q
 ;                   
 ; Mailman Support
MAIL ;   Send Object via Mailman
 N %Z,XCNP,XMSCR,XMDUZ,XMY,XMZ,XMSUB,XMY,XMTEXT,XMDUZ,GMTSN,GMTSQIT Q:'$D(^TMP($J,"GMTSOBXM"))
 S XMDUZ=+($G(DUZ)) S:+XMDUZ=0 GMTSQIT=1 S GMTSN=$$XMY S:'$L(GMTSN) GMTSQIT=1 S:$L(GMTSN) XMY(GMTSN)=""
 S XMSUB=$$XMSUB S:'$L(XMSUB) GMTSQIT=1 S XMTEXT="^TMP("_$J_",""GMTSOBXM""," Q:+($G(GMTSQIT))>0
 D:+($G(GMTSQIT))'>0 ^XMD I +($G(XMZ))>0 H 1 W !,"   Message [",+($G(XMZ)),"] sent"
 K %Z,XCNP,XMSCR,XMDUZ,XMY,XMZ,XMSUB,XMY,XMTEXT,XMDUZ,^TMP($J,"GMTSOBXM")
 Q
XMY(X) ;   Get Addressee
 S X=$$GET1^DIQ(200,(+($G(DUZ))_","),.01) Q X
XMSUB(X) ;   Get Subject
 N GMTSON S GMTSON=$P($G(^GMT(142.5,+($G(GMTSO)),0)),"^",1)
 S X="Exported Health Summary Object" S:$L(GMTSON) X=$E(("Export HS Obj: "_GMTSON),1,65)
 Q X
DOM(X) ;   Domain
 S X=$$GET1^DIQ(4.3,"1,",.01) Q X
DOW(X) ;   Day of Week
 S X=$$DT^XLFDT,X=$$DOW^XLFDT(X),X=$$UP^XLFSTR(X) Q X
NOW(X) ;   Now
 N GMTSD,GMTST S X=$$NOW^XLFDT,X=$$FMTE^XLFDT(X,"5Z"),GMTSD=$P(X,"@",1)
 S GMTST=$P($P(X,"@",2),":",1,2),X=GMTSD S:$L(GMTST) X=GMTSD_" at "_GMTST
 Q X
 ;                     
 ; Miscellaneous
CRTN(X) ;   Clear Routine
 S X=$G(X) Q:'$L(X)  Q:$L(X)>8  Q:$$ROK(X)=0  X ^%ZOSF("DEL") Q
VER(X) ;   Health Summary Version
 N GMTSEX,GMTSTXT S X="GMTS",GMTSEX="S GMTSTXT=$T(+2^"_X_")" X GMTSEX S X=$P(GMTSTXT,";",3) Q X
ROK(X) ;   Routine is OK
 S X=$G(X) Q:'$L(X) 0
 N GMTSEX,GMTSTXT S GMTSEX="S GMTSTXT=$T(+1^"_X_")" X GMTSEX Q:'$L(GMTSTXT) 0 Q 1
CREATED(X) ;   Created Text
 N GMTST,GMTSN,GMTSDM,GMTSDW,GMTSDT S GMTST="$TXT",GMTSN=$$XMY S:$L(GMTSN) GMTST=GMTST_" Created by "_GMTSN
 S GMTSDM=$$DOM S:$L(GMTSDM) GMTST=GMTST_" at "_GMTSDM S GMTSDW=$$DOW S:$L(GMTSDW) GMTST=GMTST_" on "_GMTSDW
 S GMTSDT=$$NOW S:$L(GMTSDT) GMTST=GMTST_", "_GMTSDT S X=GMTST
 Q X
