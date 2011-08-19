GMTSXAD ; SLC/KER - List Parameters/Display               ; 02/27/2002
 ;;2.7;Health Summary;**47,49**;Oct 20, 1995
 Q
 ;                                  
 ; External References in GMTSXAD
 ;   DBIA 10026  ^DIR
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA 10086  ^%ZIS
 ;   DBIA 10086  HOME^%ZIS
 ;   DBIA 10089  ^%ZISC
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA 10103  $$NOW^XLFDT
 ;   DBIA 10112  $$SITE^VASITE
 ;                           
EN ; Main Entry Point
 D EN2(+($G(DUZ))) Q
EN2(X) ; Entry for User
 K ^TMP("GMTSXAD",$J) N GMTSENV,ZTRTN,GMTSNM S ZTRTN="RPT^GMTSXAD",GMTSENV=$$ENV Q:+GMTSENV=0
 N GMTSUSR S GMTSUSR=+($G(X)) S GMTSNM=$$UNM^GMTSXAW3(+($G(GMTSUSR))) Q:'$L(GMTSNM)
 W !!,"Display user default Health Summary Type list for ",GMTSNM
 D PRE,CPL,LIST,DISP
 Q
EN3 ; Entry for Site Parameters
 K ^TMP("GMTSXAD",$J) N GMTSENV,ZTRTN,GMTSNM S ZTRTN="RPT^GMTSXAD",GMTSENV=$$ENV Q:+GMTSENV=0
 N GMTSUSR S GMTSUSR=.5 S GMTSNM=$P($$SITE^VASITE,"^",2) Q:'$L(GMTSNM)
 W !!,"Display default Health Summary Type list for ",GMTSNM
 D PRE,CPL,DISP
 Q
 ;                          
 ; Report
PRE ;   Precedence
 N GMTSPRE,GMTSM S GMTSPRE=$$PRE^GMTSXAL(GMTSUSR)
 S:+($G(GMTSUSR))=.5 GMTSPRE=$$DEF^GMTSXAW
 S:(+($G(GMTSUSR))=.5)&('$L(GMTSPRE)) GMTSPRE=$$PRE^GMTSXAL(.5)
 S GMTSM=$L(GMTSPRE,";")
 Q:'$L(GMTSPRE)  N GMTSI,GMTSE,GMTST,GMTSA,GMTSN,GMTSP,GMTSH,GMTSC,GMTSALW D EN^GMTSXAW
 S (GMTSC,GMTSI)=0 F GMTSI=1:1 Q:$P(GMTSPRE,";",GMTSI)=""  D
 . S GMTSA=$P(GMTSPRE,";",GMTSI) Q:'$L(GMTSA)  S GMTSE=$O(GMTSALW("B",GMTSA,0))
 . S GMTST=$P($G(GMTSALW("B",GMTSA,+GMTSE)),"^",4) Q:GMTSA'="NAT"&('$L(GMTST))
 . S GMTST=$S(GMTSA="USR":(GMTST_" preferences"),GMTSA="NAT":"National Health Summary Types",1:(GMTST_" defined"))
 . S GMTSC=GMTSC+1 D:GMTSC=1 PRE2 D TL(("     "_GMTSC_"  "_GMTST))
 Q
PRE2 ;     Precedence Title
 D TL(" Precedence of Parameters:        "),AL($G(GMTSPRE)),BL Q
CPL ;   Compile Method
 D EN3^GMTSXAC Q
LIST ;   Health Summary Types List 
 N GMTS,GMTSALW D GETILIST^GMTSXAL(.GMTS,GMTSUSR),EN^GMTSXAW
 N GMTS1,GMTS2,GMTST,GMTSA,GMTSI,GMTSN,GMTSEN,GMTSC,GMTSS S GMTSC=0 F  Q:$L($G(GMTSS))>29  S GMTSS=$G(GMTSS)_" "
 S GMTS1=0 F  S GMTS1=$O(GMTS("AB",GMTS1)) Q:+GMTS1=0  D
 . S GMTS2=0 F  S GMTS2=$O(GMTS("AB",GMTS1,GMTS2)) Q:+GMTS2=0  D
 . . S GMTSA=$P($G(GMTS("AB",GMTS1,GMTS2)),"^",1) Q:'$L(GMTSA)
 . . S GMTSI=+($P($G(GMTS("AB",GMTS1,GMTS2)),"^",2)) Q:+GMTSI'>0
 . . S GMTSN=$$UP^GMTSXA($P($G(GMTS("AB",GMTS1,GMTS2)),"^",3)) Q:'$L(GMTSN)
 . . S GMTSEN=+($O(GMTSALW("B",GMTSA,0))) Q:+GMTSEN'>0&(GMTSA'="NAT")
 . . S GMTSEN=$P($G(GMTSALW("B",GMTSA,GMTSEN)),"^",4) Q:'$L(GMTSEN)&(GMTSA'="NAT")
 . . S GMTSEN=GMTSEN_" defined types" S:GMTSA="NAT" GMTSEN="National types" S GMTSC=GMTSC+1 S GMTSEN="     "_GMTSEN F  Q:$L(GMTSEN)>29  S GMTSEN=GMTSEN_" "
 . . D:GMTSC=1 LIST2
 . . D TL($S(+GMTS2=1:GMTSEN,1:GMTSS))
 . . D AL(($J(GMTSC,2)_"  "_GMTSN))
 Q
LIST2 ;     List Title
 D TL(" The CPRS Reports Tab will list the following Health Summary Types:"),BL Q
 ;                             
DISP ; Display Report
 I '$L($G(ZTRTN)) K ^TMP("GMTSXAD",$J) Q
 N POP D DEV,HOME^%ZIS Q
DEV ;   Device for Display
 W ! N %ZIS,IOP S %ZIS="PQ" D ^%ZIS Q:POP  I $D(IO("Q")) D QUE Q
NOQUE ;   Do not Queue Report
 W:IOST["C-" @IOF D @ZTRTN,^%ZISC Q
QUE ;   Queue Report
 N %,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK I '$D(ZTRTN) K ^TMP("GMTSXAD",$J) Q
 K IO("Q"),ZTSAVE S ZTSAVE("^TMP(""GMTSXAD"",$J,")=""
 S ZTDESC="Health Summary Types List User Defaults",ZTIO=$G(ION),ZTDTH=$H
 D ^%ZTLOAD I $D(ZTSK) W !!,"Request queued",! H 3 W @IOF
 I '$D(ZTSK) W !!,"Request not queued",! H 3 W @IOF
 K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE D ^%ZISC Q
 ;                     
RPT ; Report
 W ! Q:'$D(^TMP("GMTSXAD",$J))
 N GMTSHDR,GMTSLC,GMTSI,GMTST,GMTSEXIT S (GMTSI,GMTSLC)=0 D HDRP
 F  S GMTSI=$O(^TMP("GMTSXAD",$J,GMTSI)) Q:+($G(GMTSEXIT))>0  Q:+GMTSI=0  D  Q:+($G(GMTSEXIT))>0
 . S GMTST=$G(^TMP("GMTSXAD",$J,GMTSI,0)),GMTSLC=GMTSLC+1 W !,GMTST
 . D:$G(IOST)["C-"&(GMTSLC>(+($G(IOSL))-4)) CONT
 . K:+($G(GMTSEXIT))>0 ^TMP("GMTSXAD",$J)
 W:$G(IOST)["P-"&($L($G(IOF))) @IOF
 K ^TMP("GMTSXAD",$J)
 Q
CONT ;   Page Break/Continue Report
 I $G(IOST)["P-" W:$L($G(IOF)) @IOF S GMTSLC=0 D HDRP Q
 N GMTSCONT S GMTSCONT="" I $G(IOST)["C-" S GMTSCONT=$$PG W:$L($G(IOF)) @IOF W:'$L($G(IOF)) !! S GMTSLC=0 D HDRP
 S:GMTSCONT["^" GMTSEXIT=1
 Q
PG(X) ;   Page Break
 N DIR,DTOUT,DIRUT,DIROUT,DUOUT S DIR(0)="EA",DIR("A")="    Press <Return> to continue  ",(DIR("?"),DIR("??"))="^W !,""        Enter either <Return> or '^'"""
 W ! D ^DIR S X=$S((+($G(DTOUT))+($G(DUOUT))+($G(DIRUT)))>0:"^",1:"") Q X
HDRP ;   Page/Report Header
 N GMTSS,GMTS1,GMTS2,GMTS3,GMTSL
 S GMTSS=$P($$SITE^VASITE,"^",2)
 S GMTS1=" Health Summary Types list for CPRS Reports Tab"
 S:(+($G(GMTSUSR))=.5)&($L(GMTSS)) GMTS1=" "_GMTSS_" Defaults for CPRS Reports Tab"
 S:+($G(GMTSHDR))>0 GMTS1=GMTS1_"    <continued> "
 S GMTS2=$$UP^GMTSXA($P($$FMTE^XLFDT($$NOW^XLFDT,"ZM"),"@",1)) F  Q:$L(GMTS1)'<(78-$L(GMTS2))  S GMTS1=GMTS1_" "
 S GMTS1=GMTS1_GMTS2 S GMTSL=" -" F  Q:$L(GMTSL)'<$L(GMTS1)  S GMTSL=GMTSL_"-"
 W !,GMTS1,!,GMTSL,! S GMTSLC=+($G(GMTSLC))+3
 Q
 ;                                 
 ; Miscellaneous
ENV(X) ;   Environment check
 D HOME^%ZIS Q:'$L($$UNM^GMTSXAW3(+($G(DUZ)))) 0
 Q 1
 ;   Add Report Lines
BL ;     Blank Line
 D TL("") Q
TL(X) ;     Text Line
 N GMTSC S X=$G(X),GMTSC=+($G(^TMP("GMTSXAD",$J,0))),GMTSC=GMTSC+1,^TMP("GMTSXAD",$J,GMTSC,0)=X,^TMP("GMTSXAD",$J,0)=GMTSC Q
AL(X) ;     Append Line
 N GMTSC S X=$G(X),GMTSC=+($G(^TMP("GMTSXAD",$J,0))),^TMP("GMTSXAD",$J,GMTSC,0)=$G(^TMP("GMTSXAD",$J,GMTSC,0))_X,^TMP("GMTSXAD",$J,0)=GMTSC Q
