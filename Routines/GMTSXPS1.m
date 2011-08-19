GMTSXPS1 ; SLC/KER - Health Summary Status       ; 08/27/2002
 ;;2.7;Health Summary;**35,34,46,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10086  HOME^%ZIS
 ;   DBIA 10086  ^%ZIS
 ;   DBIA 10089  ^%ZISC
 ;   DBIA 10063  ^%ZTLOAD
 ;   DBIA 10096  ^%ZOSF("UCI")
 ;   DBIA 10096  ^%ZOSF("PROD")
 ;   DBIA 10096  ^%ZOSF("TEST")
 ;   DBIA 10060  ^VA(200,
 ;   DBIA  2056  $$GET1^DIQ (file #4 and 200)
 ;   DBIA  1131  ^XMB("NETNAME")
 ;   DBIA 10091  ^XMB(1,  file #4.3
 ;   DBIA 10070  ^XMD
 ;   DBIA 10103  $$NOW^XLFDT
 ;   DBIA 10103  $$FMTE^XLFDT
 ;                    
EN ; Display status only
 N POP,GMTSENV S GMTSENV=$$ENV Q:'GMTSENV
 K ^TMP($J,"GMTSINFO"),GMTSMAIL N X,Y,ZTSAVE D HDR
 D:'$D(GMTSHORT) FI,INS^GMTSXPS2 D OUTPUT Q
SEND ; Send status to G.GMTS@ISC-SLC.VA.GOV
 N POP,GMTSENV S GMTSENV=$$ENV2 Q:'GMTSENV
 S GMTSIENS=$G(GMTSIENS) S:$L(GMTSIENS) GMTSIENS=";"_GMTSIENS_";"
 S GMTSENV=$$ROK("XMD") Q:'GMTSENV  K ^TMP($J,"GMTSINFO") N X,Y,ZTSAVE,ZTQUEUED,ZTREQ,ZTRTN
 S:$D(GMTSHORT) ZTSAVE("GMTSHORT")="" S:$L($G(GMTSBLD)) ZTSAVE("GMTSBLD")="" S:$D(GMTSINST) ZTSAVE("GMTSINST")="" S:$L($G(GMTSIENS)) ZTSAVE("GMTSIENS")=""
 S ZTRTN="SENDTO^GMTSXPS1",ZTDESC="Health Summary Status Report Msg",ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS K Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN Q
SENDTO ;   Send (Tasked)
 N GMTSMAIL S GMTSMAIL="" S:$D(ZTQUEUED) ZTREQ="@"
 N X,Y D HDR D:'$D(GMTSHORT) FI,INS^GMTSXPS2 D OUTPUT Q
 ;                           
HDR ; Report Header
 N X D TITLE,ASOF D:$D(GMTSINST) MTBY D INAC,BLD D BL
 Q
TITLE ;   As of date
 N X S X=$S($D(GMTSINST)&('$L($G(GMTSBLD))):"Health Summary Installation",$D(GMTSINST)&($L($G(GMTSBLD))):($G(GMTSBLD)_" Installation"),1:"Health Summary Status") D TT(X),BL Q
ASOF ;   As of date
 N X S X=$$NOW S:$L(X) X=$$TB($S($D(GMTSINST):"  Installed on:",1:"  As of:"))_X D:$L(X) TL(X) Q
INAC ;   In Account
 N X S X=$$UCI($$U) S:$L(X) X=$$TB("  Install Account:")_X D:$L(X) TL(X) Q
MTBY ;   Maintained by
 N X,Y S X=$$P,Y=$P(X,"^",2),X=$P(X,"^",1) S:$L(X) X=$$TB($S($D(GMTSINST):"  Installed by:",1:"  Maintained by:"))_X S:$L(X)&($L(Y)) X=X_"    "_Y D:$L(X) TL(X) Q
BLD ;   Install Build
 Q:$D(GMTSINST)&($L($G(GMTSBLD)))  N X S X=$G(GMTSBLD) Q:'$L(X)  S:$L(X) X=$$TB("  Build:")_X D:$L(X) TL(X) Q
 ;                          
FI ; Health Summary Files
 Q:$D(GMTSHORT)
 N X S X="",X=X_$J("",37-$L(X))_" Total",X=X_$J("",48-$L(X))_"Last" D TL(X)
 S X="  File",X=X_$J("",37-$L(X))_"Entries",X=X_$J("",48-$L(X))_"Entry" D TL(X)
 S X="",$P(X,"-",51)="-",X="  "_X D TL(X)
 D F142,F1421,F14299,BL
 Q
F142 ;   Health Summary Type file 142
 N X,GMTSA,GMTSAT,GMTSAP,GMTSL,GMTST,GMTSI S X="  Health Summary Type",(GMTSL,GMTST,GMTSI)=0
 F  S GMTSI=$O(^GMT(142,GMTSI)) Q:+GMTSI=0  S GMTSL=GMTSI,GMTST=GMTST+1
 S X=X_$J("",32-$L(X))_$J(GMTST,10),X=X_$J("",42-$L(X))_$J(GMTSL,10) D TL(X)
 S GMTSA=$O(^GMT(142,"B","GMTS HS ADHOC OPTION",0))
 S X="    Ad Hoc Health Summary Type",(GMTSL,GMTST,GMTSI)=0
 I GMTSA=0 S X=X_$J("",37-$L(X))_"Missing Ad Hoc Health Summary Type" D TL(X) Q
 F  S GMTSI=$O(^GMT(142,GMTSA,1,GMTSI)) Q:+GMTSI=0  S GMTSL=GMTSI,GMTST=GMTST+1
 S X=X_$J("",32-$L(X))_$J(GMTST,10),X=X_$J("",42-$L(X))_$J(GMTSL,10) S:GMTSA'=12 X=X_$J("",57-$L(X))_"Invalid IEN" D TL(X)
 Q
F1421 ;   Health Summary Component file 142.1
 N X,GMTSA,GMTSAC,GMTSAT,GMTSAP,GMTSL,GMTST,GMTSE,GMTSI
 S X="  Health Summary Component",(GMTSAT,GMTSAP,GMTSAC,GMTSL,GMTST,GMTSI,GMTSE)=0
 F  S GMTSI=$O(^GMT(142.1,GMTSI)) Q:+GMTSI=0  D
 . S GMTSL=GMTSI,GMTST=GMTST+1 S:GMTSI<501 GMTSE=GMTSE+1
 . S GMTSA=$P($G(^GMT(142.1,GMTSI,0)),"^",6) S:GMTSA="T" GMTSAT=+($G(GMTSAT))+1 S:GMTSA="P" GMTSAP=+($G(GMTSAP))+1 S:GMTSA="" GMTSAC=+($G(GMTSAC))+1
 S X=X_$J("",32-$L(X))_$J(GMTST,10),X=X_$J("",42-$L(X))_$J(GMTSL,10) D TL(X)
 I +($G(GMTSE))>0 S X="    Exported",X=X_$J("",32-$L(X))_$J(GMTSE,10) D TL(X)
 I +($G(GMTSAT))>0 S X="    Temporarily Disabled",X=X_$J("",32-$L(X))_$J(GMTSAT,10) D TL(X)
 I +($G(GMTSAP))>0 S X="    Permanently Disabled",X=X_$J("",32-$L(X))_$J(GMTSAP,10) D TL(X)
 I +($G(GMTSAC))>0&(+($G(GMTSAC))'=+($G(GMTST))) S X="    Active Components",X=X_$J("",32-$L(X))_$J(GMTSAC,10) D TL(X)
 D STA^GMTSXPS3
 Q
F14299 ;   Health Summary Parameter file 142.9
 N X,GMTSA,GMTSL,GMTST,GMTSI S X="  Health Summary Parameters",(GMTSL,GMTST,GMTSI)=0
 F  S GMTSI=$O(^GMT(142.99,GMTSI)) Q:+GMTSI=0  S GMTSL=GMTSI,GMTST=GMTST+1
 S X=X_$J("",32-$L(X))_$J(GMTST,10),X=X_$J("",42-$L(X))_$J(GMTSL,10) D TL(X)
 Q
 ;                            
 ; Retrieve Data
U(X) ;   UCI where Health Summary is installed
 N GMTSU,GMTSP,GMTST S GMTST=$G(X) X ^%ZOSF("UCI") S GMTSU=Y
 S:Y=^%ZOSF("PROD") GMTSP=" (Production)" S:Y'=^%ZOSF("PROD") GMTSP=" (Test)" S:GMTSU["DEM" GMTSP=" (Demo)"
 S X="",$P(X,"^",1)=GMTSU,$P(X,"^",2)=GMTSP Q X
UCI(X) ;   UCI Format
 S X=$G(X) N GMTSA,GMTST S GMTSA=$P(X,"^",1),GMTST=$P(X,"^",2) S:$L(GMTST) GMTST=$$MX($$TRIM($$PA(GMTST)))
 S:$L($P(GMTSA,",",1))=3&($L($P(GMTSA,",",2))=3) GMTSA="["_GMTSA_"]" S:$L(GMTSA)&($L(GMTST)) GMTST="("_GMTST_")"
 S X="" S:$L(GMTSA) X=GMTSA S:$L(X)&($L(GMTST)) X=X_"  "_GMTST S:'$L(X)&($L(GMTST)) X=GMTST
 Q X
P(X) ;   Person
 S X=+($G(DUZ)) Q:'$L($P($G(^VA(200,+($G(X)),0)),"^",1)) "UNKNOWN^"
 N GMTSDUZ,GMTSPH S GMTSDUZ=+($G(DUZ))
 S GMTSPH=$P($G(^VA(200,GMTSDUZ,.13)),"^",2) S:GMTSPH="" GMTSPH=$P($G(^VA(200,GMTSDUZ,.13)),"^",1) S:GMTSPH="" GMTSPH=$P($G(^VA(200,GMTSDUZ,.13)),"^",3) S:GMTSPH="" GMTSPH=$P($G(^VA(200,GMTSDUZ,.13)),"^",4)
 S GMTSDUZ=$P(^VA(200,GMTSDUZ,0),"^",1),X=GMTSDUZ_"^"_GMTSPH Q X
INST(X) ;   Institution
 S X=$G(^XMB("NETNAME")) I $L(X) S:X[".VA.GOV" X=$P(X,".VA.GOV",1) S:X["." X=$P(X,".",$L(X,".")) Q X
 S X=$P($G(^XMB(1,1,"XUS")),"^",17) I +X>0 S X=$$GET1^DIQ(4,+X,.01,"E") Q:$L(X) X
 S X="" Q X
 ;                     
OUTPUT ; Show global array (display or mail)
 D:$D(GMTSMAIL) MAIL,CLR D:'$D(GMTSMAIL) DSP,CLR Q
DISPLAY ;   Display global array
 N GMTSI S GMTSI=0 F  S GMTSI=$O(^TMP($J,"GMTSINFO",GMTSI)) Q:+GMTSI=0  D
 . W !,^TMP($J,"GMTSINFO",GMTSI)
 Q
MAIL ;   Mail global array in message
 N DIFROM S U="^",XMSUB="Health Summary Info"
 S:$D(GMTSINST)&($L($G(GMTSBLD))) XMSUB="Health Summary "_GMTSBLD_" Install"
 S XMY("G.GMTS@ISC-SLC.VA.GOV")=""
 S XMTEXT="^TMP($J,""GMTSINFO"",",XMDUZ=.5 D ^XMD
 K ^TMP($J,"GMTSINFO"),%Z,XCNP,XMSCR,XMDUZ,XMY("G.GMTS@ISC-SLC.VA.GOV"),XMZ,XMSUB,XMY,XMTEXT,XMDUZ Q
 Q
 ;                            
 ; Temporary Global
BL ;   Blank Line
 N GMTSNX S GMTSNX=+($$NX),^TMP($J,"GMTSINFO",GMTSNX)="" Q
TT(X) ;   Title Line
 Q:'$L($G(X))  D TL(X) N GMTSBK S GMTSBK="===============================================================================",GMTSBK=$E(GMTSBK,1,$L($G(X))) D:$L(GMTSBK) TL(GMTSBK) Q
TL(X) ;   Text Line
 N GMTSNX S GMTSNX=+($$NX),^TMP($J,"GMTSINFO",GMTSNX)=$G(X) Q
BK1 ;   Break Line
 N GMTSNX S GMTSNX=+($$NX),^TMP($J,"GMTSINFO",GMTSNX)="-------------------------------------------------------------------------------" Q
NX(X) ;   Next Line #
 S (X,^TMP($J,"GMTSINFO",0))=+($G(^TMP($J,"GMTSINFO",0)))+1 Q X
ST ;   Show ^TMP($J,"GMTSINFO")
 N GMTSNN,GMTSNC S GMTSNN="^TMP("_$J_",""GMTSINFO"")",GMTSNC="^TMP("_$J_",""GMTSINFO"","
 F  S GMTSNN=$Q(@GMTSNN) Q:GMTSNN=""!(GMTSNN'[GMTSNC)  W:GMTSNN'[",0)" !,@GMTSNN
 Q
 ;                            
DSP ; Display ^TMP($J,"GMTSINFO")
 D DEV Q
DEV ;   Select a device
 N %,%ZIS,IOP,ZTRTN,ZTSAVE,ZTDESC,ZTDTH,ZTIO,ZTSK
 S ZTRTN="DSPI^GMTSXPS1",ZTDESC="printing Health Summary install information"
 S ZTIO=ION,ZTDTH=$H,%ZIS="PQ",ZTSAVE("^TMP($J,""GMTSINFO"",")=""
 D ^%ZIS Q:POP  S ZTIO=ION I $D(IO("Q")) D QUE,^%ZISC Q
 D NOQUE Q
NOQUE ;   Do not que task
 W @IOF W:IOST["P-" !,"< Not queued, printing Health Summary Info >",! H 2 U:IOST["P-" IO D @ZTRTN,^%ZISC Q
QUE ;   Task queued to print user defaults
 K IO("Q") D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued",1:"Request Cancelled"),! H 2 Q
 Q
DSPI ;   Display installation information
 I '$D(ZTQUEUED),$G(IOST)'["P-" I '$D(^TMP($J,"GMTSINFO")) W !,"Health Summary Installation not found"
 I IOST["P-" U IO
 G:'$D(^TMP($J,"GMTSINFO")) DSPQ
 N GMTSCONT,GMTSI,GMTSLC,GMTSEOP S GMTSCONT="",(GMTSLC,GMTSI)=0,GMTSEOP=+($G(IOSL)) S:GMTSEOP=0 GMTSEOP=24
 F  S GMTSI=$O(^TMP($J,"GMTSINFO",GMTSI)) Q:+GMTSI=0!(GMTSCONT["^")  D
 . W !,^TMP($J,"GMTSINFO",GMTSI) D LF Q:GMTSCONT["^"
 S:$D(ZTQUEUED) ZTREQ="@"
 W:$G(IOST)["P-" @IOF
DSPQ ;   Quit Display
 Q
LF ;   Line Feed
 S GMTSLC=GMTSLC+1 D:IOST["P-"&(GMTSLC>(GMTSEOP-7)) CONT D:IOST'["P-"&(GMTSLC>(GMTSEOP-4)) CONT
 Q
CONT ;   Page/Form Feed
 S GMTSLC=0 W:IOST["P-" @IOF Q:IOST["P-"  W !!,"Press <Return> to continue  " R GMTSCONT:300 S:'$T GMTSCONT="^" S:GMTSCONT'["^" GMTSCONT=""
 Q
 ;                       
 ; Miscellaneous
TB(X) ;   Tab
 S X=X F  Q:$L(X)>19  S X=X_" "
 Q X
PA(X) ;   Remove Parenthesis
 Q $TR(X,"()","")
LO(X) ;   Lowercase
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
UP(X) ;   Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
MX(X) ;   Mixed Case
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
TRIM(X) ;   Trim Space Characters
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
CLR ;   Clean up
 K ^TMP($J,"GMTSINFO") Q
NOW(X) ;   Today's Date
 S X=$$EDT($$NOW^XLFDT) Q X
EDT(X) ;   External Date Foramt
 S X=+($G(X)) Q:X=0 "" S X=$$FMTE^XLFDT(+X,"5Z") S:X["@" X=$P(X,"@",1)_"  "_$P(X,"@",2) Q X
ROK(X) ;   Routine OK (in UCI) (NDBI)
 S X=$G(X) Q:'$L(X) 0 Q:$L(X)>8 0 X ^%ZOSF("TEST") Q:$T 1 Q 0
ENV(X) ;   Environment check
 D HOME^%ZIS I '$D(^VA(200,+($G(DUZ)),0)) W !!,"    User (DUZ) not defined",! Q 0
 Q 1
ENV2(X) ;   Environment check
 D HOME^%ZIS I '$D(^VA(200,+($G(DUZ)),0)) Q 0
 Q 1
