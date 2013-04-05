LRRP1 ;DALOI/STAFF - PRINT THE DATA FOR INTERIM REPORTS ;11/18/11  16:33
 ;;5.2;LAB SERVICE;**153,221,283,286,356,372,350**;Sep 27, 1994;Build 230
 ;
 ; from LRRP, LRRP2, LRRP3, LRMIPSU
 ;
PRINT ;
 S:$G(SEX)="" SEX="M" S:$G(DOB)="" DOB="UNKNOWN"
 S LRAAO=0 F  S LRAAO=$O(^TMP("LR",$J,"TP",LRAAO)) Q:LRAAO<1  D ORDER Q:LRSTOP
 K ^TMP("LR",$J,"TP")
 Q
 ;
 ;
ORDER ;
 N LRCAN
 S LRCDT=0
 F  S LRCDT=$O(^TMP("LR",$J,"TP",LRAAO,LRCDT)) Q:LRCDT<1  D
 . S LRCAN=0
 . I LRSS="CH" D
 . . S LRIDT=+^TMP("LR",$J,"TP",LRAAO,LRCDT,-2)
 . . F  S LRCAN=+$O(^LR(LRDFN,"CH",LRIDT,1,LRCAN)) Q:LRCAN<1  Q:$E($G(^(LRCAN,0)))="*"
 . D TEST Q:LRSTOP
 Q
 ;
 ;
TEST ;
 N LRRELDT,LRX
 S LRIDT=+^TMP("LR",$J,"TP",LRAAO,LRCDT,-2)
 S LRSS=$P(^TMP("LR",$J,"TP",LRAAO),U,2)
 S LR0=$S($D(^(LRAAO,LRCDT))#2:^(LRCDT),1:""),LRTC=$P(LR0,U,12)
 I LRSS="MI" D  Q
 . S LRH=1 D:LRFOOT FOOT Q:LRSTOP
 . D EN1^LRMIPC
 . S LRHF=1,LRFOOT=0
 . K A,Z,LRH
 . S:LREND LREND=0,LRSTOP=1
 ;
 ; Protect against results for AP subscripts being processed from file #69 orders.
 I LRSS'="CH" Q
 ;
 Q:'$G(LRCAN)&('$P(LR0,U,3))  D @$S(LRHF:"HDR",1:"CHECK") Q:LRSTOP
 S LRSPEC=+$P(LR0,U,5),X=$P(LR0,U,10) D DOC^LRX
 ;
 ; Display reporting lab
 I $$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")#2 D
 . S LRX=+$G(^LR(LRDFN,LRSS,LRIDT,"RF"))
 . I LRX D RL(LRX)
 ;
 I LRDOC?1"REF:"1.AN D
 . S LRX=$$REFDOC^LRRP1(LRDFN,LRSS,LRIDT)
 . I LRX'="" S LRDOC=LRX
 W !!,?7,"Provider: ",LRDOC
 W !,?7,"Specimen: ",$P($G(^LAB(61,LRSPEC,0),"<no specimen on file>"),U)
 D ORU
 S LRRELDT=$P(^TMP("LR",$J,"TP",LRAAO,LRCDT),U,3)
 W !,"Report Released: ",$$FMTE^XLFDT(LRRELDT,"M")
 W !!,?30,"Specimen Collection Date: ",$$FMTE^XLFDT(LRCDT,"M")
 W !?5,"Test name",?30,"Result    units",?51,"Ref.   range",?66,"Site Code"
 S LRPO=0
 F  S LRPO=$O(^TMP("LR",$J,"TP",LRAAO,LRCDT,LRPO)) Q:LRPO'>0  S LRDATA=^(LRPO) D DATA Q:LRSTOP
 Q:LRSTOP
 ;
 I $D(^TMP("LR",$J,"TP",LRAAO,LRCDT,"C")) D
 . W !,"Comment: " S LRCMNT=0
 . F  S LRCMNT=+$O(^TMP("LR",$J,"TP",LRAAO,LRCDT,"C",LRCMNT)) Q:LRCMNT<1  D  Q:LRSTOP
 . . W ^TMP("LR",$J,"TP",LRAAO,LRCDT,"C",LRCMNT)
 . . D CONT Q:LRSTOP
 . . W:$O(^TMP("LR",$J,"TP",LRAAO,LRCDT,"C",LRCMNT)) !?9
 Q:LRSTOP  D EQUALS^LRX
 W !?7,"KEY: ""L""=Abnormal low, ""H""=Abnormal high, ""*""=Critical value"
 S LRFOOT=1
 Q
 ;
 ;
DATA ;
 N LR63DATA,LRREFS,LRX
 ;
 S LRTSTS=+LRDATA,LRPC=$P(LRDATA,U,5),LRSUB=$P(LRDATA,U,6)
 S X=$P(LRDATA,U,7) Q:X=""
 S LR63DATA=$$TSTRES^LRRPU(LRDFN,LRSS,LRIDT,$P(LRDATA,U,10),LRTSTS)
 S LRLO=$P(LR63DATA,"^",3),LRHI=$P(LR63DATA,"^",4),LRREFS=$$EN^LRLRRVF(LRLO,LRHI),LRPLS=$P(LR63DATA,"^",6),LRTHER=$P(LR63DATA,"^",7)
 I LRPLS S LRPLS(LRPLS)=LRPLS
 ;
 ; Find reference lab filler order number
 S LREPR=LRDFN_","_LRSS_","_LRIDT_","_$P(LRDATA,"^",10)
 S LRX=$O(^LR(LRDFN,"EPR","AD",LREPR,4,""))
 I LRX S LREPR(4,LREPR,LRX)=""
 ;
 ;W !?5,$S($L($P(LRDATA,U,2))>20:$P(LRDATA,U,3),1:$P(LRDATA,U,2))
 ; Insure something is printed as test name - either print name or #.01 field
 I $L($P(LRDATA,U,2))>25,$P(LRDATA,U,3)'="" W !,$P(LRDATA,U,3)
 E  W !,$E($P(LRDATA,U,2),1,25)
 S X=$P(LR63DATA,"^")
 W ?27,@$S(LRPC="":"$J(X,LRCW)",1:LRPC)," ",$P(LR63DATA,"^",2)
 I $X>39 W !
 W ?40,$P(LR63DATA,U,5)
 I $X>50 W !
 W ?51,LRREFS
 ;
 I LRPLS'="" D
 . I $X>67 W !
 . W ?68,"[",LRPLS,"]"
 D CONT Q:LRSTOP
 ;
 I $O(^TMP("LR",$J,"TP",LRAAO,LRCDT,LRPO,0))>0 D  Q:LRSTOP
 . S LRINTP=0
 . F  S LRINTP=+$O(^TMP("LR",$J,"TP",LRAAO,LRCDT,LRPO,LRINTP)) Q:LRINTP<1  W !?7,"Eval: ",^(LRINTP) D CONT Q:LRSTOP
 ;
 Q
 ;
 ;
CHECK I LRTC+11>(IOSL-$Y) D FOOT Q:LRSTOP  D HDR
 Q
 ;
 ;
CONT I $Y+5>IOSL D FOOT Q:LRSTOP  D HDR W !?20,">> CONTINUATION OF ",$P(LR0,U,6)," <<",!
 Q
 ;
 ;
FOOT ; from LRRP, LRRP2, LRRP3
 ;
 N I
 Q:LRSTOP
 F I=$Y:1:IOSL-4 W !
 ;
 I $E(IOST,1,2)'="C-" D  Q
 . W !,PNM,?40,"  ",SSN,"  ",$$HTE^XLFDT($H,"1M"),!
 ;
 W !,PNM,?25,"  ",SSN,"  ",$$HTE^XLFDT($H,"1M"),?59," PRESS '^' TO STOP "
 R X:DTIME S:X="" X=1 S:(".^"[X)!('$T) LRSTOP=1
 Q
 ;
 ;
HDR ; Add Printed at, page #, change age to dob 7/2002 cka
 W:($G(LRJ02))!($G(LRJ0))!($E(IOST,1,2)="C-") @IOF
 S LRHF=0,LRJ02=1,LRPG=$G(LRPG)+1
 I $E(IOST,1)="P" W !!,$$CJ^XLFSTR("CLINICAL LABORATORY REPORT",IOM),!
 ;
 I $$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")>1 D PFAC(DUZ(2),LRPG)
 ;
 W !!,PNM,?44,"Report date: ",$$HTE^XLFDT($H,"M")
 W !?1,"Pat ID: ",SSN,"    SEX: ",SEX,"    DOB: ",$$FMTE^XLFDT(DOB),"    LOC: ",LROC
 Q
 ;
 ;
ORU ; Display remote ordering info if available
 ; Handle calls that don't pass parameters.
 D ORUA("",LRDFN,LRSS,LRIDT,0)
 Q
 ;
 ;
ORUA(LRARRAY,LRDFN,LRSS,LRIDT,LRFLAG) ; Display remote ordering info if available
 ; Call with LRARRAY = array with name/address info
 ;             LRDFN = file #63 ien
 ;              LRSS = file #63 subscript
 ;             LRIDT = file #63 internal data/time of specimen
 ;            LRFLAG = 0 (print facility info)
 ;                     1 (return facility info in LRARRAY)
 ;
 N A,IENS,LRFILE,LRX,LRY
 ;
 S LRFLAG=$G(LRFLAG,0)
 S LRFILE=$S(LRSS="CH":63.04,LRSS="MI":63.05,LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,LRSS="BB":63.01,1:0)
 S LRX(0)=$G(^LR(LRDFN,LRSS,LRIDT,0))
 S LRX("ORU")=$G(^LR(LRDFN,LRSS,LRIDT,"ORU")),IENS=LRIDT_","_LRDFN_","
 ;
 S LRY="Accession [UID]: "_$P(LRX(0),"^",6)_" ["_$P(LRX("ORU"),"^")_"]"
 I LRSS="MI",$P(LRX(0),"^",10) S LRY=$$LJ^XLFSTR(LRY,43," ")_" Received: "_$$FMTE^XLFDT($P(LRX(0),"^",10),"M")
 I LRFLAG S A(1)=LRY
 E  D EN^DDIOL(LRY,"","!")
 ;
 I $P(LRX("ORU"),"^",3) D
 . S LRY=$$LJ^XLFSTR("Ordering Site: "_$$GET1^DIQ(LRFILE,IENS,.33,""),43," ")_" Ordering Site UID: "_$P(LRX("ORU"),"^",5)
 . I LRFLAG S A(2)=LRY
 . E  D EN^DDIOL(LRY,"","!?2")
 ;
 I $P(LRX("ORU"),"^",2) D
 . S LRY="Collecting Site: "_$$GET1^DIQ(LRFILE,IENS,.32,"")
 . I LRFLAG=1 S A(3)=LRY
 . E  D EN^DDIOL(LRY,"","!")
 ;
 I LRFLAG M LRARRAY=A
 ;
 Q
 ;
 ;
PFAC(LR4,LRPG,LRFLAG,LRARRAY) ; Display name/address of printing facility
 ; Call with LR4 = File #4 IEN
 ;          LRPG = current page number to print
 ;        LRFLAG = 0 (print facility info)
 ;                 1 (return facility info in LRARRAY)
 ;       LRARRAY = array with name/address info
 ;
 N A,CLIA,LRX,X
 S LRX=$$NAME^XUAF4(LR4),CLIA=$$ID^XUAF4("CLIA",LR4),LRFLAG=$G(LRFLAG,0)
 S A(1)="Printed at:"
 I $G(LRPG) S A(1)=$$LJ^XLFSTR(A(1),$G(IOM,80)-15)_"page "_LRPG
 S A(2)=LRX
 I CLIA'="" D
 . S X="[CLIA# "_CLIA_"]"
 . I $L(A(2))+$L(X)+1>$G(IOM,80) S A(2.5)=X
 . E  S A(2)=A(2)_" "_X
 S LRX=$$PADD^XUAF4(LR4),LRX(1)=$$WHAT^XUAF4(LR4,1.02)
 S A(3)=$P(LRX,U)_" "_$S(LRX(1)'="":LRX(1)_" ",1:"")_$P(LRX,U,2)_$S($P(LRX,U,3)'="":", ",1:"")_$P(LRX,U,3)_" "_$P(LRX,U,4)
 I 'LRFLAG D
 . S A(4)=" "
 . S A(1,"F")="?2",A(2,"F")="!?2",A(3,"F")="!?2",A(4,"F")="!"
 . I $D(A(2.5)) S A(2.5,"F")="!?2"
 . D EN^DDIOL(.A)
 I LRFLAG M LRARRAY=A
 ;
 Q
 ;
 ;
RL(LR4,LRFLAG,OUT) ; Display name/address of reporting laboratory
 ; Call with LR4: File #4 IEN
 ;        LRFLAG: <opt> 1=save to OUT array
 ;           OUT: <byref><opt>
 ;
 N A,CLIA,LRX,X,I
 S LRFLAG=$G(LRFLAG)
 K OUT
 S LRX=$$NAME^XUAF4(LR4),CLIA=$$ID^XUAF4("CLIA",LR4)
 S A(1)="Reporting Lab:" ;_LRX
 S A(2)=LRX
 I 'LRFLAG S A(1,"F")="!!?2",A(2,"F")="!?2"
 I CLIA'="" D
 . S X="[CLIA# "_CLIA_"]"
 . I $L(A(2))+$L(X)+1>$G(IOM,80) S A(2.5)=X S:'LRFLAG A(2.5,"F")="!?17"
 . E  S A(2)=A(2)_" "_X
 S LRX=$$PADD^XUAF4(LR4),LRX(1)=$$WHAT^XUAF4(LR4,1.02)
 S A(3)=$P(LRX,U)_" "_$P(LRX,U,2)_", "_$P(LRX,U,3)_" "_$P(LRX,U,4)
 S A(3)=$P(LRX,U)_" "_$S(LRX(1)'="":LRX(1)_" ",1:"")_$P(LRX,U,2)_$S($P(LRX,U,3)'="":", ",1:"")_$P(LRX,U,3)_" "_$P(LRX,U,4)
 I 'LRFLAG D
 . S A(4)=" ",A(3,"F")="!?2",A(4,"F")="!"
 . I $D(A(2.5)) S A(2.5,"F")="!?2"
 . D EN^DDIOL(.A)
 I LRFLAG M OUT=A
 ;
 Q
 ;
 ;
REFDOC(LRDFN,LRSS,LRIDT) ; Lookup LEDI referral free text provider name in file #63 on "ORUT" subscript
 ; Call with LRDFN = ien on entry in file #63
 ;            LRSS = file #63 subscript
 ;           LRIDT = inverse specimen date/time
 ;
 ; Returns     LRY = free text provider found on first test in file #63
 ;
 N LRI,LRX,LRY
 S LRI=0,(LRX,LRY)=""
 F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,"ORUT",LRI)) Q:'LRI  S LRX=$P(^(LRI,0),"^",7) Q:LRX'=""
 I LRX'="" S LRY=LRX
 Q LRY
