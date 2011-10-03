DGAPI1 ;ALB/DWS - DG API TO COMUNICATE WITH PCE ;6/16/05 1:44pm
 ;;5.3;Registration;**635,664**;Aug 13, 1993;Build 15
DATA2PCE(DFN,PTF,DGZP) ;SEND CPT PROCEDURE TRANSACTIONS TO PCE
 ;
 N DGVISIT,DR,DIE,DA,X,Y
 ;
 D BUILD
 ;
 I $P($G(DGZPRF(DGZP)),U,6) S DGVISIT=$P(DGZPRF(DGZP),U,6)
 ;
 I $D(DGREL) S DGRELSV=DGREL ;save DGREL, it gets killed off in SCDXMSG1
 S RES=$$DATA2PCE^PXAPI("^TMP(""DGPCE1"",$J,""PXAPI"")",107,"801 SCREEN",.DGVISIT)
 I $D(DGRELSV) S DGREL=DGRELSV K DGRELSV ;restore DGREL
 ;
 D:$D(^TMP("DGPCE1",$J,"PXAPI","DIERR")) ERR
 ;
 K ^TMP("DGPCE1",$J,"PXAPI")
 ;
 ;
 Q:RES<-1 RES
 ;
 S DR=".06////"_DGVISIT_";.07////1",DIE="^DGPT("_PTF_",""C"",",DA=DGZPRF(DGZP,0),DA(1)=PTF D ^DIE
 ;
 Q RES
 ;
ERR ; looks to see if there is an trully an error
 N DGX,DGQ
 S (DGQ,DGX)=0 F  S DGX=$O(^TMP("DGPCE1",$J,"PXAPI","DIERR",$J,DGX)) Q:'DGX!(DGQ)  I $E($G(^TMP("DGPCE1",$J,"PXAPI","DIERR",$J,DGX,"TEXT",1)),1,5)="ERROR" S DGQ=1 D ERRMSG(DGX)
 Q
 ;
ERRMSG(DGX) ; sends the error message
 N XMDUZ,XMSUB,XMTEXT,XMY,XMZ,XMMG,DGL,DGTXT,DGY
 ;
 D DEM^VADPT
 ;
 S XMDUZ="PTF MODULE",XMSUB="801 to PCE filing error"
 S XMY("G.DG PTF 801 TO PCE ERROR")="",XMY(DUZ)="",XMTEXT="DGTXT("
 ;
 S DGTXT(1,0)="An error has occured while sending PTF 801 data to PCE."
 S DGTXT(2,0)=" "
 S DGTXT(3,0)="     Patient Name:  "_VADM(1)
 S DGTXT(4,0)="     Social Security:  "_$P(VADM(2),"^",2)
 S DGTXT(5,0)="     Date/Time:  "_$$FMTE^XLFDT(+DGZPRF(DGZP))
 S DGTXT(6,0)="     Location:  "_$P($G(^SC($P(DGZPRF(DGZP),"^",5),0)),"^")
 S DGTXT(7,0)=" "
 ;
 S DGL=7,DGY=0 F  S DGY=$O(^TMP("DGPCE1",$J,"PXAPI","DIERR",$J,DGX,"TEXT",DGY)) Q:'DGY!($E(^TMP("DGPCE1",$J,"PXAPI","DIERR",$J,DGX,"TEXT",DGY),1,25)="^TMP(""DGPCE1"",$J,""PXAPI"")")  D
 . S DGL=DGL+1,DGTXT(DGL,0)="     "_^TMP("DGPCE1",$J,"PXAPI","DIERR",$J,DGX,"TEXT",DGY)
 ;
 D ^XMD
 D KVAR^VADPT
 ;
 Q
 ;
DELVFILE(DFN,PTF,DGZP) ;DELETE VISIT IN PCE WHEN A CHANGE IS MADE
 N DIE,DA,DR S RES=1
 S:$P(DGZPRF(DGZP),U,7) RES=$$DELVFILE^PXAPI("ALL",$P(DGZPRF(DGZP),U,6))
 S DA=DGZPRF(DGZP,0),DA(1)=PTF
 S DIE="^DGPT("_PTF_",""C"",",DR=".06///@;.07////0" D ^DIE
 Q RES
 ;
BUILD ; now build array for passing data to PCE
 N DGAPI,DGC,DGPROC,DGPROCZ,DGP,DGDXNO,DGDXC,DGDX,DGX
 K ^TMP("DGPCE1",$J,"PXAPI") S DGDXC=0
 S DGAPI=$NA(^TMP("DGPCE1",$J,"PXAPI"))
 ; ---------encounter date/time----------------
 S @DGAPI@("ENCOUNTER",1,"ENC D/T")=+DGZPRF(DGZP)
 ; --------------patient-----------------------
 S @DGAPI@("ENCOUNTER",1,"PATIENT")=DFN
 ; ---------------location---------------------
 S @DGAPI@("ENCOUNTER",1,"HOS LOC")=$P(DGZPRF(DGZP),"^",5)
 ; --------------service category--------------
 S @DGAPI@("ENCOUNTER",1,"SERVICE CATEGORY")="I"
 ; ---------------encounter type---------------
 S @DGAPI@("ENCOUNTER",1,"ENCOUNTER TYPE")="P"
 ; ------------primary provider----------------
 S @DGAPI@("PROVIDER",1,"NAME")=$P(DGZPRF(DGZP),"^",3)
 S @DGAPI@("PROVIDER",1,"PRIMARY")=1
 ; ------------secondary provider-------------
 I $P(DGZPRF(DGZP),"^",2),$P(DGZPRF(DGZP),"^",2)'=$P(DGZPRF(DGZP),"^",3) S @DGAPI@("PROVIDER",2,"NAME")=$P(DGZPRF(DGZP),"^",2)
 ; ----------------procedures-----------------
 S DGC=0,DGPROC=0 F  S DGPROC=$O(DGZPRF(DGZP,DGPROC)) Q:'DGPROC  D
 . S DGPROCZ=$G(DGZPRF(DGZP,DGPROC)) Q:'DGPROCZ
 . S DGC=DGC+1,@DGAPI@("PROCEDURE",DGC,"PROCEDURE")=+DGPROCZ
 . ; --------------modifiers------------------
 . F DGP=2,3 I $P(DGPROCZ,"^",DGP) S @DGAPI@("PROCEDURE",DGC,"MODIFIERS",$P($$MOD^ICPTMOD($P(DGPROCZ,"^",DGP),"I",+DGZPRF(DGZP)),"^",2))=""
 . ; --------------quantity-------------------
 . S @DGAPI@("PROCEDURE",DGC,"QTY")=$P(DGPROCZ,"^",14)
 . ; --------------diagnosis------------------
 . F DGP=4:1:7,15:1:18 I $P(DGPROCZ,"^",DGP) D
 . . S DGDXNO=$S(DGP=4:"",DGP<15:DGP-3,1:DGP-11)
 . . S @DGAPI@("PROCEDURE",DGC,"DIAGNOSIS"_$S(DGDXNO<2:"",1:" "_DGDXNO))=$P(DGPROCZ,"^",DGP)
 . . I $D(DGDX($P(DGPROCZ,"^",DGP))) Q
 . . S DGDX($P(DGPROCZ,"^",DGP))="",DGDXC=DGDXC+1
 . . S @DGAPI@("DX/PL",DGDXC,"DIAGNOSIS")=$P(DGPROCZ,"^",DGP)
 . . S:DGDXC=1 @DGAPI@("DX/PL",DGDXC,"PRIMARY")=1
 . . S (DGY,DGX)=0 F  S DGX=$O(^DGICD9(46.1,"C",PTF,DGX)) Q:'DGX!(DGY)  I +$G(^DGICD9(46.1,DGX,0))=$P(DGPROCZ,"^",DGP) S DGY=DGX
 . . S DGY=$G(^DGICD9(46.1,+DGY,0))
 . . I $L($P(DGY,"^",2)) S @DGAPI@("DX/PL",DGDXC,"PL SC")=$P(DGY,"^",2)
 . . I $L($P(DGY,"^",3)) S @DGAPI@("DX/PL",DGDXC,"PL AO")=$P(DGY,"^",3)
 . . I $L($P(DGY,"^",4)) S @DGAPI@("DX/PL",DGDXC,"PL IR")=$P(DGY,"^",4)
 . . I $L($P(DGY,"^",5)) S @DGAPI@("DX/PL",DGDXC,"PL EC")=$P(DGY,"^",5)
 . . I $L($P(DGY,"^",6)) S @DGAPI@("DX/PL",DGDXC,"PL MST")=$P(DGY,"^",6)
 . . I $L($P(DGY,"^",7)) S @DGAPI@("DX/PL",DGDXC,"PL HNC")=$P(DGY,"^",7)
 . . I $L($P(DGY,"^",8)) S @DGAPI@("DX/PL",DGDXC,"PL CV")=$P(DGY,"^",8)
 . . I $L($P(DGY,"^",9)) S @DGAPI@("DX/PL",DGDXC,"PL SHAD")=$P(DGY,"^",9)
 ;
 Q
 ;
