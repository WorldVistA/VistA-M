PRCHQUE ;WISC/CLH,ID/RSD/TKW/REW/BGJ-QUE PRINTOUTS ; [7/2/98 3:20pm]
 ;;5.1;IFCAP;**14**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;     INPUT TO PRCHQUE:
 ;
 ;     D0,D1
 ;     PRCHQ=ROUTINE
 ;     PRCHQ("DEST")=DESTINATION
 ;     PRC("SITE")=STATION #
 ;     PRC("SST")=SUBSTATION #
 ;     DUZ
 ;     PRCHQ("DEST2")=INDICATOR THAT ROUTES PRINT OF RECEIVING
 ;                    REPORT TO FISCAL
 ;
 D CLNUP
 S (ZTRTN,ZTDESC)=PRCHQ
 S:$D(D0) PRCHXXD0=D0
 S:$D(D1) PRCHXXD1=D1
 I PRCHQ["PRCPRIB" D
 .  N PRCPRIB
 .  S (PRCPRIB,ZTSAVE("PRCPRIB"))=D0
 .  Q
 S:$D(PPMFLG) ZTSAVE("NOPRINT")=""
 K IOP,ZTSK
 S IOP=""
 S X=""
 I $D(PRCHQ("DEST2")) S X=PRCHQ("DEST2")
 I X=""&($D(PRCHQ("DEST"))) S X=PRCHQ("DEST")
 ;Check for substation
 I $G(PRC("SST"))]"" D SUBST Q
 I $D(^PRC(411,PRC("SITE"),2)) D GETIOP(PRC("SITE"))
 ;Check for Fiscal Stack
 I IOP'=""&(X'="IFP")&(X'="IFR")&(X="F"!(X="FR")) S DA=$O(^PRC(411,PRC("SITE"),2,"AC",X,IOP,0)) I $P($G(^PRC(411,PRC("SITE"),2,DA,0)),U,3) D ^PRCFPR Q
QDEV G Q:$G(PRCHIO)=IO(0)
 I IOP'="" D  G:'POP Q
 .  S %ZIS=$S(IOP=" ":"",1:"NQ")
 .  D ^%ZIS
 .  Q:'POP
 .  W $C(7),!!,">>>>  ",X," IS NOT A VALID PRINTER, POSSIBLY FROM ",PRC("SITE"),"'S SITE PARAMETER FILE ",!!
 .  Q
 ;
SDEV S %ZIS("B")=""
 ;
SDEV1 S %ZIS("A")="QUEUE ON DEVICE: "
 S %ZIS="NQ"
 S NOZTDTH=""
 K IOP
 D ^%ZIS
 G:POP EXIT
 S IOP=ION_";"_IOST_";"_IOM_";"_IOSL
 I IO=IO(0) D  G EXIT
 .  D ^%ZIS
 .  U IO
 .  D @ZTRTN
 .  D ^%ZISC
 .  Q
 ;
Q S U="^"
 S:$D(PRCHXXD0) D0=PRCHXXD0,ZTSAVE("D0")=""
 S:$D(PRCHXXD1) D1=PRCHXXD1,ZTSAVE("D1")=""
 S ZTSAVE("U")=""
 S:$D(PRCHQ("DEST")) ZTSAVE("PRCHQ(""DEST"")")=""
 S:$D(PRCHFPT) ZTSAVE("PRCHFPT")=""
 S:$D(DEST) ZTSAVE("DEST")=""
 S:$D(PRC("SITE")) ZTSAVE("PRC(""SITE"")")=""
 S:$D(PRCHREPR) ZTSAVE("PRCHREPR")=""
 I ZTRTN="EN2^PRCHRPT9"!(ZTRTN="EN2^PRCHRPL") D
 .  D PP3
 .  S ZTDTH=""
 .  Q
 E  D
 .  D:ZTRTN="STQUE^PRCHPNT1" PP2
 .  S:'$D(NOZTDTH) ZTDTH=$H
 .  ; Per SAAN for P69 -- allow scheduling for user selected devices.
 .  Q
 ;
 I $G(PRCHIO)=IO(0)!($G(PRCHIO)=" ") D
 .  D @ZTRTN,^%ZISC:$G(PRCHIO)=" "
 .  ;Specify device 0;##;### TO RUN PRINT PROGRAMS THAT
 .  ;NORMALLY RUN IN THE BACKGROUND IN THE FOREGROUND.
 .  Q
 E  D ^%ZTLOAD,^%ZISC
 ;
EXIT K IOP,PRCHQ,XMAPHOST,NOZTDTH
 ;
CLNUP K ZTRTN,ZTUCI,ZTDTH,ZTSAVE,ZTDESC,ZTSK,ZTSKT,ZTCPU,ZTI,ZTJOB,ZTM1
 K ZTM2,ZTMAST,ZTMGR,ZTNLG,ZTOS,ZTPD,ZTPO,ZTPROD,ZTPT,ZTRET,ZTSIZ
 K ZTU1,ZTVOL,ZTXMB,PRCHXXD0,PRCHXXD1
 Q
 ;
SUBST ;Substation is being used
 N DONE
 S DONE=0
 I $D(^PRC(411,PRC("SST"),2)) D  Q:DONE
 . D GETIOP(PRC("SST"))
 . ;Check for Fiscal Stack
 . I IOP'=""&(X'="IFP")&(X'="IFR")&(X="F"!(X="FR")) S DA=$O(^PRC(411,PRC("SST"),2,"AC",X,IOP,0)) I $P($G(^PRC(411,PRC("SST"),2,DA,0)),U,3) D ^PRCFPR S DONE=1
 I IOP="",$D(^PRC(411,PRC("SITE"),2)) D  Q:DONE
 . D GETIOP(PRC("SITE"))
 . ;Check for Fiscal Stack
 . I IOP'=""&(X'="IFP")&(X'="IFR")&(X="F"!(X="FR")) S DA=$O(^PRC(411,PRC("SITE"),2,"AC",X,IOP,0)) I $P($G(^PRC(411,PRC("SITE"),2,DA,0)),U,3) D ^PRCFPR S DONE=1
 ;Check field 61 in file 411 to see if user should be prompted for device
 I +$P($G(^PRC(411,PRC("SITE"),0)),U,26) D  Q
 . S %ZIS("B")=IOP
 . D SDEV1
 . Q
 D QDEV
 Q
 ;
GETIOP(DA) ;
 I X]"" D
 . S IOP=$O(^PRC(411,DA,2,"AC",X,0))
 . I IOP=""&(X["SPOOL"!(X["LTA")!$D(^%ZIS(1,"B",X))!(X?1N.N)!(X=" ")) S IOP=X
 . Q
 Q
 ;
PP2 S ZTSAVE("PRCH0")=""
 S ZTSAVE("PRCH1")=""
 S ZTSAVE("PRCH")=""
 S ZTSAVE("PRCHV")=""
 S ZTSAVE("PRCHP")=""
 S ZTSAVE("PRCHJ")=""
 S ZTSAVE("N")=""
 S ZTSAVE("^TMP($J,")=""
 Q
 ;
PP3 ;SETUP FOR PRINTING PL100-322 REPORT
 S ZTSAVE("FR")=""
 S ZTSAVE("TO")=""
 S ZTSAVE("PRCHNULL")=""
 S ZTSAVE("PRCHDET")=""
 Q
