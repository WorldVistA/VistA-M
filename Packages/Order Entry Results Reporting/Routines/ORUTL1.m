ORUTL1 ; slc/dcm - OE/RR Utilities ;5/30/07  13:46
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11,66,243**;Dec 17, 1997;Build 242
LOC ;Hospital Location Look-up
 N DIC,ORIA,ORRA
 S DIC=44,DIC(0)="AEQM",DIC("S")="I '$P($G(^(""OOS"")),""^"")"
 D ^DIC
 I Y<1 Q
 I $D(^SC(+Y,"I")) S ORIA=+^("I"),ORRA=$P(^("I"),U,2)
 I $S('$D(ORIA):0,'ORIA:0,ORIA>DT:0,ORRA'>DT&(ORRA):0,1:1) W $C(7),!,"  This location has been inactivated.",! K ORL G LOC
 Q
QUE(ZTRTN,ZTDESC,ZTSAVE,ORIOPTR,ZTDTH,%ZIS,QUE,ECHO,ORION) ;Device Handling
IO ;This entry point replaced by QUE, but left for backwards compatibility
 Q:'$D(ZTRTN)
 N IO,ION,IOP,IOPAR,IOT,ZTSK,ZTIO,POP
 I $G(QUE),'$L($G(ORIOPTR)) Q
 I $L($G(ORIOPTR)),$G(QUE),$D(ORION) S ZTIO=ORION G IOQ
 S:'($D(%ZIS)#2) %ZIS="Q"
 I $G(QUE) S:%ZIS'["Q" %ZIS=%ZIS_"Q" S %ZIS("S")="I $S($G(^%ZIS(2,+$G(^(""SUBTYPE"")),0))'[""C-"":1,1:0)",%ZIS("B")=""
 I $L($G(ORIOPTR)) S IOP=ORIOPTR
 D ^%ZIS
 I POP S OREND=1 Q
 S ZTIO=ION
IOQ I $G(QUE)!$D(IO("Q")) D  Q
 . S:'$D(ZTSAVE) ZTSAVE("O*")=""
 . D ^%ZTLOAD
 . I $D(ZTSK),'$D(ECHO) W !,"REQUEST QUEUED"
 . I '$D(ZTSK) S OREND=1
 . D ^%ZISC
 D @ZTRTN
 D ^%ZISC
 Q
 ;
DPI(PATCH) ;Function returns date patch installed - added in patch 243
 ;PATCH is set to patch designation, for example, "SR*3.0*157"
 ;Output is the fileman date/time that patch was installed on this system
 ;A return value of -1 is given if patch hasn't been installed
 N ORVALUE,ORDAT,ORERR,VER,PKG,DATE,NUM
 S DATE=-1
 I '$$PATCH^XPDUTL(PATCH) Q DATE  ;If patch hasn't been installed yet quit
 S ORVALUE=$P(PATCH,"*") ;Package
 D FIND^DIC(9.4,,,"MO",.ORVALUE,,,,,"ORDAT","ORERR")
 S PKG=$G(ORDAT("DILIST",2,1)) I 'PKG Q DATE
 S ORVALUE=$P(PATCH,"*",2) ;Version
 D FIND^DIC(9.49,(","_PKG_","),,"X",.ORVALUE,,,,,"ORDAT","ORERR")
 S VER=$G(ORDAT("DILIST",2,1)) I 'VER Q DATE
 S ORVALUE=$P(PATCH,"*",3) ;Patch number
 D FIND^DIC(9.4901,(","_VER_","_PKG_","),,,.ORVALUE,,,,,"ORDAT","ORERR")
 S NUM=$G(ORDAT("DILIST",2,1)) I 'NUM Q DATE
 S DATE=$$GET1^DIQ(9.4901,(NUM_","_VER_","_PKG_","),.02,"I")
 Q DATE
