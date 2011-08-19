YTRPWRP ;DALOI/YH - Report Calls ; 8/2/10 2:44pm
 ;;5.01;MENTAL HEALTH;**71,76,96**;Dec 30, 1994;Build 46
 ;Reference to VADPT APIs supported by DBIA #10061
 ;Reference to ^XLFDT APIs supported by DBIA #10103
 ;Reference to ^%ZISC supported by IA #10089
 ;Reference to ^%ZIS supported by IA #10086
 ;Reference to %ZISH supported by DBIA #2320
INTRMNT(ROOT,YSDFN,YSXT) ; -- return report text
 ;ROOT=Where you want it
 ;YSDFN=Patient DFN
 ;YSXT= DATE TEST TAKEN,POINTER TO MH INSTRUMENT FILE #601
 ;  RPC: MH INTRUMENT REPORT TEXT
 ;
 ; -- init output global for close logic of WORKSTATION device
 N YSTOUT,YSUOUT,YSTEST,YSED,YSET,DFN,YSROU,YSN,LEN,YSBLNK S (YSTOUT,YSUOUT,YSN)=0,DFN=+YSDFN,$P(YSBLNK," ",60)=""
 S %=$H>21549+$H-.1,%Y=%\365.25+141,%=%#365.25\1,YSPTD=%+306#(%Y#4=0+365)#153#61#31+1,YSPTM=%-YSPTD\29+1,Y=%Y_"00"+YSPTM_"00"+YSPTD,YSDT(0)=$$FMTE^XLFDT(Y,"5ZD")
 D DEM^VADPT,PID^VADPT S YSNM=VADM(1),YSSEX=$P(VADM(5),U),YSDOB=$P(VADM(3),U,2),YSAGE=VADM(4),YSSSN=VA("PID"),YSSX=YSSEX
 S YSHDR=YSSSN_"  "_YSNM_YSBLNK,YSHDR=$E(YSHDR,1,44)_YSSEX_" AGE "_YSAGE,YSHD=DT
 K ^TMP("YSDATA",$J)
 S ROOT=$NA(^TMP("YSDATA",$J,1))
 ; -- get report text
 D START(132,"RP1^YTDP")
 Q
 ;
START(RM,GOTO) ;
 ;RM=Right margin
 S:'$G(RM) RM=80
 N ZTQUEUED,YSHFS,YSSUB,YSIO
 K ^TMP("YSDATA",$J)
 S ROOT=$NA(^TMP("YSDATA",$J,1))
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
 S IOP="OR WORKSTATION;"_$G(YSRM,80)_";66"
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
 . I X[$C(12)&(I>7) S @ROOT@(I+.5)="***eop***"_$C(10) ;asf 4/18/08
 Q
 ;
TESTCODE(ROOT) ;YTRP LIST TEST/CODE
 N A S A="C"
 D START(132,"ENP^YTLCTD")
 Q
TESTDES(ROOT) ;YTRP LIST TEST/DESC
 N A S A="D"
 D START(132,"ENP^YTLCTD")
 Q
TESTTL(ROOT) ;YTRP LIST TEST/TITLE
 N A S A="T"
 D START(132,"ENP^YTLCTD")
 Q
