LEXXGI4 ;ISL/KER - Global Import (Repair at Site) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**51,80**;Sep 23, 1996;Build 1
 ;              
 ; Global Variables
 ;    ^TMP("LEXXGI4ASL")  SACC 2.3.2.5.1
 ;    ^TMP("LEXXGI4TIM")  SACC 2.3.2.5.1
 ;    ^TMP("LEXXGI4MSG")  SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZTLOAD            ICR  10063
 ;    ^DIC                ICR  10006
 ;    ^DIK                ICR  10013
 ;    ENALL^DIK           ICR  10013
 ;    IX1^DIK             ICR  10013
 ;    IXALL^DIK           ICR  10013
 ;    $$GET1^DIQ          ICR   2056
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;    ^XMD                ICR  10070
 ;    MES^XPDUTL          ICR  10141
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ; 
 ;    LEXLOUD   NEWed, SET and KILLed in the Post-Install
 ;              routine LEX20nnP.  If set, the entry 
 ;              points ASL, AWRD, SSWRD and SUB will write
 ;              to the screen using MES^XPDUTL.
 ;
 ;    LEXXM     Set and Killed by the developer, used to 
 ;              report the timing of the task in the
 ;              global array ^TMP("LEXXGI4TIM",$J) and
 ;              sent to the user by MailMan message
 ;     
 ;    LEXHOME   Set and Killed by the developer in the
 ;              post-install, used to send the timing
 ;              message to G.LEXINS@FO-SLC.DOMAIN.EXT
 ;              (see entry point POST2)
 ;              
 Q
POST ; Entry Point from Post-Install
 N LEXXM,LEXHOME K @("^TMP(""LEXXGI4TIM"","_$J_")")
 S LEXXM="" D AWRD^LEXXGI4
 Q
POST2 ; Entry Point from Post-Install (home)
 N LEXXM,LEXHOME K @("^TMP(""LEXXGI4TIM"","_$J_")")
 S LEXHOME="",LEXXM="" D AWRD^LEXXGI4
 Q
AWRD ; Repair Word Index AWRD in Expression file #757.01
 N Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ S ZTRTN="AWRDT^LEXXGI4"
 S ZTDESC="Repair the AWRD index in file #757.01"
 S LEXJ=+($G(LEXJ)) S:LEXJ'>0 LEXJ=$J S ZTSAVE("LEXJ")=""
 I $D(LEXXM) S LEXXM=1,ZTSAVE("LEXXM")=""
 S:$D(LEXHOME) ZTSAVE("LEXHOME")=""
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS I $D(LEXLOUD) D
 . S LEXT="  Repair the AWRD index in file #757.01 tasked"
 . S:+($G(ZTSK))>0 LEXT=LEXT_" (#"_+($G(ZTSK))_")" D MES^XPDUTL(LEXT)
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
AWRDT ;   Repair Word Index AWRD in Expression file #757.01 (task)
 ;     Subset Indexes Axxx
 N DA,DIK,LEXBT1,LEXSB,LEXJ1 S LEXSB="WRD" S:$D(LEXXM) LEXXM=1
 S (LEXJ1,LEXJ)=+($G(LEXJ)) S:LEXJ'>0 (LEXJ1,LEXJ)=$J
 D:$D(LEXXM) KIL(LEXJ1)
 S LEXBT1=$$BEG("WRD",LEXJ1)
 H 2 D SSWRD^LEXXGI4
 ;     Supplemental Words AWRD Index
 H 2 D SUPWRD^LEXXGI4
 ;     Main Word AWRD Index
 H 2 D AWRDI
 ;     Replacement Words
 H 2 D REP
 ;     Update String Lengths
 H 2 D:'$D(LEXXM) ASL^LEXXGI4 I $D(LEXXM) D
 . N LEXJ S LEXJ=LEXJ1 D ASLT^LEXXGI4
 H 1 D END(LEXBT1,"WRD",LEXJ1) D:$D(LEXXM) XM(LEXJ1),KIL(LEXJ1)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
AWRDI ;   Repair Word Index AWRD
 N DIK S DIK="^LEX(757.01,",DIK(1)="2^AWRD" D ENALL^DIK
 Q
AWRDTIME ;   Repair Word Index AWRD (timing)
 N LEXB,LEXE,LEXT S LEXB=$$NOW^XLFDT D AWRDI^LEXXGI4 S LEXE=$$NOW^XLFDT
 S LEXT=$TR($$FMDIFF^XLFDT(LEXE,LEXB,3)," ","0")
 W !,"  Repair Word Index AWRD",!
 W !,"  Start:   ",$TR($$FMTE^XLFDT(LEXB,"5Z"),"@"," ")
 W !,"  Finish:  ",$TR($$FMTE^XLFDT(LEXE,"5Z"),"@"," ")
 W !,"  Time:    ",LEXT
 Q
 ;
REP ; Replacement Words
 N DA,DIK,LEXBT2,LEXJ2
 S LEXJ2=+($G(LEXJ)) S:LEXJ2'>0 LEXJ2=$G(LEXJ1) S:LEXJ2'>0 LEXJ2=$J
 S:$D(LEXXM) LEXXM=1 S LEXBT2=$$BEG("REP",LEXJ2)
 S DIK="^LEX(757.05," D IXALL^DIK H 1 D END(LEXBT2,"REP",LEXJ2)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
SUPWRD ; Repair Supplemental Word Index AWRD in file #757.01
 N Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ S ZTRTN="SUPWRDT^LEXXGI4"
 S ZTDESC="Repair the Supplemental Word Index in file #757.01"
 S LEXJ=+($G(LEXJ)) S:LEXJ'>0 LEXJ=$G(LEXJ1) S:LEXJ'>0 LEXJ=$J S ZTSAVE("LEXJ")=""
 I $D(LEXXM) S LEXXM=1,ZTSAVE("LEXXM")=""
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS I $D(LEXLOUD) D
 . S LEXT="  Repair the Supplemental Word Index in file #757.01 tasked"
 . S:+($G(ZTSK))>0 LEXT=LEXT_" (#"_+($G(ZTSK))_")" D MES^XPDUTL(LEXT)
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
SUPWRDT ;   Repair Supplemental Word Index AWRD in file #757.01 (task)
 N DA,DIK,LEXBT3,LEXI,LEXJ3
 S LEXJ3=+($G(LEXJ)) S:LEXJ3'>0 LEXJ3=$J
 S:$D(LEXXM) LEXXM=1 S LEXBT3=$$BEG("SUP",LEXJ3)
 S LEXI=0 F  S LEXI=$O(^LEX(757.01,LEXI)) Q:+LEXI'>0  D
 . Q:$O(^LEX(757.01,LEXI,5,0))'>0
 . N LEXII S LEXII=0 F  S LEXII=$O(^LEX(757.01,LEXI,5,LEXII)) Q:+LEXII'>0  D
 . . N X,DA S X=$G(^LEX(757.01,LEXI,5,LEXII,0)) Q:'$L(X)
 . . S DA(1)=LEXI,DA=LEXII D SSUP^LEXNDX6
 . Q  S DIK(1)=".01^AWORD" D ENALL^DIK
 H:+($G(LEXXM))>0 2 D END(LEXBT3,"SUP",LEXJ3)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SUPTIME ;   Repair Supplemental Word Index AWRD (timing)
 N LEXB,LEXE,LEXT S LEXB=$$NOW^XLFDT D SUPWRDT^LEXXGI4 S LEXE=$$NOW^XLFDT
 S LEXT=$TR($$FMDIFF^XLFDT(LEXE,LEXB,3)," ","0")
 W !,"  Repair Supplemental Word Index AWRD",!
 W !,"  Start:   ",$TR($$FMTE^XLFDT(LEXB,"5Z"),"@"," ")
 W !,"  Finish:  ",$TR($$FMTE^XLFDT(LEXE,"5Z"),"@"," ")
 W !,"  Time:    ",LEXT
 Q
 ;
SSWRD ; Repair Word Index Axxx in Sub-Set file #757.21
 N Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ S ZTRTN="SSWRDT^LEXXGI4"
 S ZTDESC="Repair the Asub in file #757.21"
 S LEXJ=+($G(LEXJ)) S:LEXJ'>0 LEXJ=$G(LEXJ1) S:LEXJ'>0 LEXJ=$J S ZTSAVE("LEXJ")=""
 I $D(LEXXM) S LEXXM=1,ZTSAVE("LEXXM")=""
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS I $D(LEXLOUD) D
 . S LEXT="  Repair the Asub index in file #757.21 tasked"
 . S:+($G(ZTSK))>0 LEXT=LEXT_" (#"_+($G(ZTSK))_")" D MES^XPDUTL(LEXT)
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
SSWRDT ;   Repair Word Index Axxx in Sub-Set file #757.21 (task)
 N DA,DIK,LEXBT4,LEXJ4
 S LEXJ4=+($G(LEXJ)) S:LEXJ4'>0 LEXJ4=$J
 S:$D(LEXXM) LEXXM=1 S LEXBT4=$$BEG("SUB",LEXJ4)
 N IEN S IEN=0 F  S IEN=$O(^LEX(757.21,IEN)) Q:+IEN'>0  D
 . N DA,X S DA=IEN,X=$P($G(^LEX(757.21,IEN,0)),"^",2) D:$L(X) SS^LEXNDX2
 . Q  S X=$P($G(^LEX(757.21,IEN,0)),"^",1) I $L(X),+X>0 D
 . . S ^LEX(757.21,"B",$E(X,1,30),DA)=""
 . . S ^LEX(757.21,"C",$E($$UP^XLFSTR(^LEX(757.01,X,0)),1,63),DA)=""
 H:+($G(LEXXM))>0 2 D END(LEXBT4,"SUB",LEXJ4)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SSTIME ;   Repair Word Index Axxx in Sub-Set file #757.21 (timing)
 N LEXB,LEXE,LEXT S LEXB=$$NOW^XLFDT D SSWRDT^LEXXGI4 S LEXE=$$NOW^XLFDT
 S LEXT=$TR($$FMDIFF^XLFDT(LEXE,LEXB,3)," ","0")
 W !,"  Repair Word Index Axxx in Sub-Set file",!
 W !,"  Start:   ",$TR($$FMTE^XLFDT(LEXB,"5Z"),"@"," ")
 W !,"  Finish:  ",$TR($$FMTE^XLFDT(LEXE,"5Z"),"@"," ")
 W !,"  Time:    ",LEXT
 Q
 ;
ASL ; Recalculate ASL cross-reference
 N Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ S ZTRTN="ASLT^LEXXGI4"
 S ZTDESC="Recalculate ASL index in Expression file #757.01"
 S LEXJ=+($G(LEXJ)) S:LEXJ'>0 LEXJ=$G(LEXJ1) S:LEXJ'>0 LEXJ=$J S ZTSAVE("LEXJ")=""
 I $D(LEXXM) S LEXXM=1,ZTSAVE("LEXXM")=""
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS I $D(LEXLOUD) D
 . S LEXT="  Re-index the ASL index of file #757.01 tasked"
 . S:+($G(ZTSK))>0 LEXT=LEXT_" (#"_+($G(ZTSK))_")" D MES^XPDUTL(LEXT)
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
ASLT ;   Recalculate ASL cross-reference (task)
 K ^TMP("LEXXGI4ASL",$J,"ASL") N LEXTK,LEXFIR,LEXFC,LEXBT5,LEXJ5
 S LEXJ5=+($G(LEXJ)) S:LEXJ5'>0 LEXJ5=$J S (LEXFIR,LEXFC,LEXTK)=""
 S:$D(LEXXM) LEXXM=1 S LEXBT5=$$BEG("ASL",LEXJ5)
 F  S LEXTK=$O(^LEX(757.01,"AWRD",LEXTK)) Q:'$L(LEXTK)  D
 . N LEXP,LEXS,LEXC,LEXF,LEXTKN S LEXTKN=LEXTK
 . F  Q:$E(LEXTKN,1)'=" "  S LEXTKN=$E(LEXTKN,2,$L(LEXTKN))
 . F  Q:$E(LEXTKN,$L(LEXTKN))'=" "  S LEXTKN=$E(LEXTKN,1,($L(LEXTKN)-1))
 . S LEXF=$E(LEXTKN,1)
 . W:'$D(ZTQUEUED)&(LEXFIR'=LEXF)&(LEXFC'[LEXF) LEXF
 . S LEXFIR=LEXF S:LEXFC'[LEXF LEXFC=LEXFC_LEXF
 . F LEXP=1:1:$L(LEXTKN)  S LEXS=$E(LEXTKN,1,LEXP) D
 . . Q:'$L($G(LEXS))  Q:$D(^TMP("LEXXGI4ASL",$J,"ASL",LEXS))
 . . S LEXC=$$ASLC(LEXS)
 . . I LEXC>0 K ^LEX(757.01,"ASL",LEXS) D
 . . . K ^LEX(757.01,"ASL",LEXS)
 . . . S ^LEX(757.01,"ASL",LEXS,LEXC)=""
 . . S ^TMP("LEXXGI4ASL",$J,"ASL",LEXS)=""
 K ^TMP("LEXXGI4ASL",$J,"ASL")
 H:+($G(LEXXM))>0 2 D END(LEXBT5,"ASL",LEXJ5)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
ASLC(X) ;   Recalculate ASL cross-reference (String Counter)
 N LEXC,LEXTK,LEXTKN,LEXO,LEXT,LEXS,LEXP
 S (LEXC,LEXTK)=$$UP^XLFSTR($G(X)),LEXT=0  Q:'$L(LEXTK) 0
 S:$L(LEXTK)>1 LEXO=$E(LEXTK,1,($L(LEXTK)-1))_$C(($A($E(LEXTK,$L(LEXTK)))-1))_"~"
 S:$L(LEXTK)=1 LEXO=$C(($A(LEXTK)-1))_"~"
 F  S LEXO=$O(^LEX(757.01,"AWRD",LEXO)) Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXC))'=LEXC  D
 . N LEXM S LEXM=0 F  S LEXM=$O(^LEX(757.01,"AWRD",LEXO,LEXM)) Q:+LEXM'>0  D
 . . N LEXE S LEXE=0 F  S LEXE=$O(^LEX(757.01,"AWRD",LEXO,LEXM,LEXE)) Q:+LEXE'>0  D
 . . . S LEXT=LEXT+1
 S X=LEXT
 Q X
ASLTIME ;   Recalculate ASL cross-reference (timing)
 N LEXB,LEXE,LEXT S LEXB=$$NOW^XLFDT D ASLT^LEXXGI4 S LEXE=$$NOW^XLFDT
 S LEXT=$TR($$FMDIFF^XLFDT(LEXE,LEXB,3)," ","0")
 W !,"  Recalculate ASL cross-reference",!
 W !,"  Start:   ",$TR($$FMTE^XLFDT(LEXB,"5Z"),"@"," ")
 W !,"  Finish:  ",$TR($$FMTE^XLFDT(LEXE,"5Z"),"@"," ")
 W !,"  Time:    ",LEXT
 Q
 ;
SUB ; Repair Subset Cross-References
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,LEXT S ZTRTN="SUBT^LEXXGI4"
 S ZTDESC="Re-Index the Subsets file #757.21 (set logic only)"
 S LEXJ=+($G(LEXJ)) S:LEXJ'>0 LEXJ=$G(LEXJ1) S:LEXJ'>0 LEXJ=$J S ZTSAVE("LEXJ")=""
 I $D(LEXXM) S LEXXM=1,ZTSAVE("LEXXM")=""
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD I $D(LEXLOUD) D
 . S LEXT="  Re-index file #757.21 tasked"
 . S:+($G(ZTSK))>0 LEXT=LEXT_" (#"_+($G(ZTSK))_")" D MES^XPDUTL(LEXT)
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
SUBT ;   Repair Subset Cross-References (task)
 N LEXP3,LEXP4,LEXIEN,LEXBT6,LEXJ6 S:$D(LEXXM) LEXXM=1
 S LEXJ6=+($G(LEXJ)) S:LEXJ6'>0 LEXJ6=$J
 S (LEXP3,LEXP4,LEXIEN)=0,LEXBT6=$$BEG("SSS",LEXJ6)
 F  S LEXIEN=$O(^LEX(757.21,LEXIEN)) Q:+LEXIEN'>0  D
 . N DA,DIK S DA=+($G(LEXIEN))  D SUBFIX(DA) Q:'$D(^LEX(757.21,+LEXIEN,0))
 . S LEXP3=LEXIEN,LEXP4=LEXP4+1
 . S DA=LEXIEN,DIK="^LEX(757.21," D IX1^DIK
 S:LEXP3>0 $P(^LEX(757.21,0),"^",3)=LEXP3
 S:LEXP4>0 $P(^LEX(757.21,0),"^",4)=LEXP4
 H:+($G(LEXXM))>0 2 D END(LEXBT6,"SSS",LEXJ6)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SUBFIX(X) ;   Repair Subset Cross-References (Fix 757.21)
 N DA,DIK,LEXEXP,LEXDFL S DA=+($G(X))
 Q:+DA'>0  Q:'$D(^LEX(757.21,+DA,0))
 S LEXEXP=+$G(^LEX(757.21,+DA,0))
 S LEXDFL=$P($G(^LEX(757.01,+LEXEXP,1)),"^",5)
 Q:+LEXDFL'>0  S DIK="^LEX(757.21," D ^DIK
 Q
 ;
XM(X) ; Mail Message
 N LEX1,LEX2,LEXB,LEXC,LEXD,LEXE,LEXJ,LEXMAIL,LEXN
 N LEXPRE,LEXNEW,LEXS,LEXT,LEXX,LEXI,LEXNM,XCNP
 N XMDUZ,XMSCR,XMSUB,XMTEXT,XMY,XMZ S:$D(LEXXM) LEXMAIL=""
 Q:'$D(LEXMAIL)&$D(ZTQUEUED)  S LEX1=9999999,LEX2="",LEXJ=+($G(X))
 Q:LEXJ'>0  Q:'$D(^TMP("LEXXGI4TIM",LEXJ))
 D XMG I LEX1'=9999999,$P(LEX1,".",1)?7N,$P(LEX2,".",1)?7N D
 . Q:$O(^TMP("LEXXGI4TIM",LEXJ,""))=$O(^TMP("LEXXGI4TIM",LEXJ,""),-1)
 . N LEXN,LEXD,LEXB,LEXE,LEXT,LEXX
 . S LEXN="Total Time",LEXD=$TR($$FMTE^XLFDT(LEX1,"5Z"),"@"," ")
 . S LEXB=$P(LEXD," ",2),LEXE=$TR($$FMTE^XLFDT(LEX2,"5Z"),"@"," ")
 . S LEXE=$P(LEXE," ",2),LEXT=$$FMDIFF^XLFDT(LEX2,LEX1,3)
 . S LEXD=$P($TR($$FMTE^XLFDT(LEX1,"5Z"),"@"," ")," ",1)
 . S:$L(LEXT)'>8 LEXT=$TR(LEXT," ","0")
 . I $L($G(LEXPRE)),+($G(LEXPRE))>0,LEXD=$G(LEXPRE) S LEXD="  ""    ""  "
 . S LEXX=LEXN,LEXX=LEXX_$J(" ",(33-$L(LEXX)))_LEXD
 . S LEXX=LEXX_$J(" ",(45-$L(LEXX)))_LEXB
 . S LEXX=LEXX_$J(" ",(55-$L(LEXX)))_LEXE
 . S LEXX=LEXX_$J(" ",(65-$L(LEXX)))_LEXT
 . D XMB((" "_LEXX),LEXJ)
 D:$D(LEXMAIL) XMS(LEXJ)
 Q
XMG ;   Get Data for Message
 N LEXS,LEXC S LEXPRE="",LEXC=0 F LEXS="WRD","SUB","SUP","REP","ASL","SSS" D
 . N LEXD,LEXB,LEXE,LEXN,LEXNEW,LEXT,LEXX
 . S LEXD=$P($G(^TMP("LEXXGI4TIM",LEXJ,LEXS,"BEG")),"^",1)
 . S:+LEXD>0&(+LEXD<LEX1) LEX1=LEXD
 . S LEXD=$TR($$FMTE^XLFDT(LEXD,"5Z"),"@"," ")
 . S LEXB=$P(LEXD," ",2)
 . S (LEXNEW,LEXD)=$P(LEXD," ",1)
 . S LEXE=$P($G(^TMP("LEXXGI4TIM",LEXJ,LEXS,"END")),"^",1)
 . S:+LEXE>LEX2 LEX2=LEXE
 . S LEXE=$TR($$FMTE^XLFDT(LEXE,"5Z"),"@"," ")
 . S LEXE=$P(LEXE," ",2)
 . S LEXT=$G(^TMP("LEXXGI4TIM",LEXJ,LEXS,"TIM"))
 . Q:'$L(LEXB)
 . S:LEXS="SUB" LEXN="Sub-Sets       757.21    ""Axxx"""
 . S:LEXS="SSS" LEXN="Sub-Sets       757.21    ""Axxx"""
 . S:LEXS="SUP" LEXN="Supplemental   757.18    ""AWRD"""
 . S:LEXS="WRD" LEXN="Expression     757.01    ""AWRD"""
 . S:LEXS="REP" LEXN="Replacements   757.05    ""AWRD"""
 . S:LEXS="ASL" LEXN="String Length  757.01    ""ASL"""
 . S:'$L(LEXE) LEXE="        "
 . S:'$L(LEXT) LEXT="        "
 . S:LEXD=LEXPRE LEXD="  ""    ""  "
 . S LEXPRE=LEXNEW
 . S LEXX=LEXN,LEXX=LEXX_$J(" ",(33-$L(LEXX)))_LEXD
 . S LEXX=LEXX_$J(" ",(45-$L(LEXX)))_LEXB
 . S LEXX=LEXX_$J(" ",(55-$L(LEXX)))_LEXE
 . S LEXX=LEXX_$J(" ",(65-$L(LEXX)))_LEXT
 . S LEXC=LEXC+1 I LEXC=1 D
 . . D:$D(LEXMAIL) XMB(" ",LEXJ)
 . . D XMB(" Repair/Re-Index          Index   Date        Start      Finish   Elapsed",LEXJ)
 . . D XMB(" -----------------------  ------  ----------  --------  --------  --------",LEXJ)
 . D XMB((" "_LEXX),LEXJ)
 . Q
 Q
XMB(X,Y) ;   Build Message
 N LEXJ S X=$G(X),LEXJ=+($G(Y)) I '$D(LEXMAIL) W:'$D(ZTQUEUED) !,X Q
 Q:+LEXJ'>0  N LEXI S LEXI=$O(^TMP("LEXXGI4MSG",LEXJ," "),-1)+1
 S ^TMP("LEXXGI4MSG",LEXJ,+LEXI)=$G(X),^TMP("LEXXGI4MSG",LEXJ,0)=LEXI
 Q
XMS(X) ;   Send Message
 N XCNP,XMSCR,XMDUZ,XMY,XMZ,XMSUB,XMY,XMTEXT,XMDUZ,LEXJ,LEXNM
 S LEXJ=+($G(X)) Q:+LEXJ'>0  Q:'$D(^TMP("LEXXGI4MSG",LEXJ))
 S XMTEXT="^TMP(""LEXXGI4MSG"","_LEXJ_",",XMSUB="Repair Major Word Indexes"
 S LEXNM=$$GET1^DIQ(200,+($G(DUZ)),.01) I '$L(LEXNM) K ^TMP("LEXXGI4MSG",LEXJ) Q
 S:$D(LEXHOME) XMY(("G.LEXINS@"_$$XMA))="" S XMY(LEXNM)="",XMDUZ=.5 D ^XMD
 K ^TMP("LEXXGI4MSG",LEXJ) K XCNP,XMSCR,XMDUZ,XMY,XMZ,XMSUB,XMY,XMTEXT,XMDUZ,LEXNM
 Q
XMA(LEX) ; Message Address
 N DIC,DTOUT,DUOUT,X,Y S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="FO-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="ISC-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 Q "ISC-SLC.DOMAIN.EXT"
 ;
 ; Miscellaneous
BEG(X,Y) ;   Begin Process - Subscript, Job
 N SUB,JNM S SUB=$G(X),X=$$NOW^XLFDT,JNM=+($G(Y)) S:JNM'>0 JNM=$J I +($G(LEXXM))>0,$L(SUB) D
 . S @("^TMP(""LEXXGI4TIM"","_+($G(JNM))_","""_SUB_""",""BEG"")")=X_"^"_$TR($$FMTE^XLFDT(X,"5Z"),"@"," ")
 Q X
END(X,Y,Z) ;   End Process - Begin, Subscript, Job
 N BEG,ELP,END,ELP,SUB,JNM S BEG=$G(X),SUB=$G(Y),JNM=+($G(Z)) S:JNM'>0 JNM=$J H 2 S END=$$NOW^XLFDT
 S ELP="" S:+BEG>0&(+END>0) ELP=$TR($$FMDIFF^XLFDT(END,BEG,3)," ","0") I +($G(LEXXM))>0,$L(SUB),$L(ELP) D
 . S @("^TMP(""LEXXGI4TIM"","_+($G(JNM))_","""_SUB_""",""BEG"")")=BEG_"^"_$TR($$FMTE^XLFDT(BEG,"5Z"),"@"," ")
 . S @("^TMP(""LEXXGI4TIM"","_+($G(JNM))_","""_SUB_""",""END"")")=END_"^"_$TR($$FMTE^XLFDT(END,"5Z"),"@"," ")
 . S @("^TMP(""LEXXGI4TIM"","_+($G(JNM))_","""_SUB_""",""TIM"")")=ELP
 Q X
KIL(X) ;   Kill ^TMP("LEXXGI4TIM",$J)
 N JNM S JNM=$G(X) S:JNM'>0 JNM=$J I +($G(LEXXM))>0 D
 . K @("^TMP(""LEXXGI4TIM"","_+($G(JNM))_")")
 . K @("^TMP(""LEXXGI4TIM"","_$J_")")
 Q
CLR ;   Clear Variables
 K LEXLOUD,LEXTEST,LEXJ,LEXXM,LEXHOME
 Q
