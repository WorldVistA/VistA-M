YSASRPWP ;DALOI/YH- Report Calls ;5/11/2001
 ;;5.01;MENTAL HEALTH;**71**;Dec 30, 1994
ASINAR(ROOT,YSASDA) ;YSRP ASI NARRATIVE
 D START(132,"QTEP^YSASNAR")
 Q
 ;
ASIITM(ROOT,YSASDA) ;YSRP ASI ITEM
 D START(132,"QTEP^YSASPRT")
 Q
 ;
START(RM,GOTO) ;
 ;RM=Right margin
 S:'$G(RM) RM=80
 N ZTQUEUED,YSHFS,YSSUB,YSIO
 K ^TMP("YSDATA",$J) S ROOT=$NA(^TMP("YSDATA",$J,1))
 S YSHFS=$$HFS(),YSSUB="YSDATA"
 D OPEN(.RM,.YSHFS,"W",.YSIO)
 D @GOTO
 D CLOSE(.YSRM,.YSHFS,.YSSUB,.YSIO)
 Q
HFS() ; -- get hfs file name
 ; -- need to define better unique algorithm
 Q "YSU_"_$J_".DAT"
 ;
OPEN(YSRM,YSHFS,YSMODE,YSIO) ; -- open WORKSTATION device
 ;   YSRM: right margin
 ;  YSHFS: host file name
 ; YSMODE: open file in 'R'ead or 'W'rite mode
 S ZTQUEUED="" K IOPAR
 S IOP="OR WORKSTATION;"_$G(YSRM,80)
 S %ZIS("HFSMODE")=YSMODE,%ZIS("HFSNAME")=YSHFS
 D ^%ZIS
 K IOP,%ZIS
 U IO
 S YSIO=IO
 Q
 ;
CLOSE(YSRM,YSHFS,YSSUB,YSIO) ; -- close WORKSTATION device
 ; YSSUB: unique subscript name for output 
 I IO=YSIO D ^%ZISC
 U IO
 D USEHFS
 U IO
 Q
USEHFS ; -- use host file to build global array
 N IO,YSOK,SECTION
 S SECTION=0
 D INIT
 S YSOK=$$FTG^%ZISH(,YSHFS,$NA(@ROOT@(1)),4) I 'YSOK Q
 D STRIP
 N YSARR S YSARR(YSHFS)=""
 S YSOK=$$DEL^%ZISH("",$NA(YSARR))
 Q
 ;
INIT ; -- initialize counts and global section
 S (INC,CNT)=0,SECTION=SECTION+1
 S ROOT=$NA(^TMP(YSSUB,$J,SECTION))
 K @ROOT
 Q
 ;
STRIP ; -- strip off control chars
 N I,X
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  S X=^(I) D
 . I X[$C(8) D  ;BS
 .. I $L(X,$C(8))=$L(X,$C(95)) S (X,@ROOT@(I))=$TR(X,$C(8,95),"") Q  ;BS & _
 .. S (X,@ROOT@(I))=$TR(X,$C(8),"")
 . I X[$C(7)!(X[$C(12)) S @ROOT@(I)=$TR(X,$C(7,12),"") ;BEL or FF
 Q
