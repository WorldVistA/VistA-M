%ZTM2 ;SEA/RDS-TaskMan: Manager, Part 4 (Link Handling 1) ;22 May 2003 10:17 am
 ;;8.0;KERNEL;**23,118,275**;JUL 10, 1995
 ;
XLINK ;SEND^%ZTM--determine routing of XCPU task
 S ZTJOBIT=0
 S ZTI=$O(^%ZIS(14.5,"B",ZTDVOL,""))
 S ZTS=^%ZIS(14.5,ZTI,0)
 I $P(ZTS,U,4)="Y" G DOWN
 S ZTM=$P(ZTS,U,6)
 S ZTN=$P(ZTS,U,7) I ZTN S ZTN=$P(^%ZIS(14.5,ZTN,0),U)
 I ZTN="" S ZTN=ZTDVOL
 I ZTN=%ZTVOL S ZTJOBIT=1 Q
 I $D(^%ZTSCH("LINK",ZTDVOL)) G DOWN
 I ZTYPE="C" S ZTJOBIT=1 Q
 ;
OCPU ;XLINK--send task to manager on another volume set
 ;First check how many jumps to other volume sets we have done.
 I $P(^%ZTSK(ZTSK,.02),"^",3)>2 D REJCT^%ZTM1("Too many hops") Q
 S $P(^%ZTSK(ZTSK,.02),"^",3)=$P($G(^%ZTSK(ZTSK,.02)),"^",3)+1
 S X="EROCPU^%ZTM2",@^%ZOSF("TRAP")
 I '$D(^[ZTM,ZTN]%ZTSCH("RUN")) S ZTT=$H G O1
 S ZTT=^[ZTM,ZTN]%ZTSCH("RUN")
 ;
O1 L +^[ZTM,ZTN]%ZTSK(-1):5
 S ZTS=^[ZTM,ZTN]%ZTSK(-1)+1
 F ZT=0:0 Q:'$D(^[ZTM,ZTN]%ZTSK(ZTS))  S ZTS=ZTS+1
 S ^[ZTM,ZTN]%ZTSK(-1)=ZTS
 ;
 L -^[ZTM,ZTN]%ZTSK(-1),+^[ZTM,ZTN]%ZTSK(ZTS)
 D TSKSTAT^%ZTM1(1,"Ready to Move") ;S $P(^%ZTSK(ZTSK,.1),U,1,3)=1_U_ZTT_U
 S %X="^%ZTSK(ZTSK,",%Y="^[ZTM,ZTN]%ZTSK(ZTS," D %XY^%RCR
 ;Now schedule task.
 S $P(^[ZTM,ZTN]%ZTSK(ZTS,0),U,6)=ZTT,^[ZTM,ZTN]%ZTSCH($$H3^%ZTM(ZTT),ZTS)=""
 L -^[ZTM,ZTN]%ZTSK(ZTS)
 ;
 S X="",@^%ZOSF("TRAP")
 K ^%ZTSK(ZTSK,.3)
 D TSKSTAT^%ZTM1(6,"^Moved to "_ZTM_","_ZTN_" as task number "_ZTS)
 K ZT,ZT1,ZTD,ZTI,ZTM,ZTN,ZTR,ZTS,ZTT,ZTREP Q
 ;
EROCPU ;OCPU--trap dropped link and reroute task
 S X="",@^%ZOSF("TRAP")
 I $D(^%ZTSCH("LINK"))[0 S ^("LINK")=$H
 S ^%ZTSCH("LINK",ZTDVOL)=1
 ;
DOWN ;XLINK/EROCPU--reroute XCPU task whose link is down
 D REQRD I $D(ZTREQUIR) G ORIGNL
 I ZTIO]"",$D(IOCPU)#2,IOCPU]"" G LIST
 S ZTREP(ZTDVOL)=""
 S ZTREP=$P(^%ZIS(14.5,ZTI,0),U,8)
 I ZTREP S ZTREP=$P(^%ZIS(14.5,ZTREP,0),U)
 I ZTREP="" G ORIGNL
 I $D(ZTREP(ZTREP))#2 G ORIGNL
D1 ;
 I $D(^%ZTSK(ZTSK,.01))[0 S ^%ZTSK(ZTSK,.01)=ZTUCI_U_ZTDVOL
 S Y=$O(^%ZIS(14.6,"AT",ZTUCI,ZTDVOL,ZTREP,""))
 I Y="" S Y=ZTUCI
 S ZTUCI=Y,ZTDVOL=ZTREP
 I ZTDVOL=%ZTVOL S X=ZTUCI_","_ZTDVOL X ^%ZOSF("UCICHECK") S:0'[Y ZTUCI=Y I 0[Y S %ZTREJCT=1
 S $P(^%ZTSK(ZTSK,.02),U)=ZTUCI
 I ZTDVOL'=%ZTVOL S $P(^%ZTSK(ZTSK,.02),U,2)=ZTDVOL
 E  S $P(^%ZTSK(ZTSK,.02),U,2)=""
 I %ZTREJCT D TSKSTAT^%ZTM1("B","BAD DESTINATION UCI") Q
 I ZTDVOL=%ZTVOL G SEND^%ZTM
 G XLINK
 ;
REQRD ;DOWN--is dropped link required?
 S ZTI=$O(^%ZIS(14.5,"B",ZTDVOL,""))
 I ZTI="" Q
 I $D(^%ZIS(14.5,ZTI,0))#2 S ZTS=^(0)
 E  Q
 I $P(ZTS,U,5)="Y" S ZTREQUIR=ZTDVOL
 Q
 ;
ORIGNL ;DOWN--give up trying to reroute; make it wait for original destination
 I $D(^%ZTSK(ZTSK,.01))[0 G LIST
 S ZTORIGNL=^%ZTSK(ZTSK,.01)
 S ZTUCI=$P(ZTORIGNL,U)
 S ZTDVOL=$P(ZTORIGNL,U,2)
 S $P(^%ZTSK(ZTSK,.02),U)=ZTUCI
 I ZTDVOL'=%ZTVOL S $P(^%ZTSK(ZTSK,.02),U,2)=ZTDVOL
 E  S $P(^%ZTSK(ZTSK,.02),U,2)=""
 ;
LIST ;DOWN/ORIGNL--place task on waiting list for down volume
 I $D(^%ZTSCH("LINK"))[0 S ^("LINK")=$H
 I ZTYPE'="C" S ^%ZTSCH("LINK",ZTDVOL,ZTDTH,ZTSK)=""
 E  D
 .S ^%ZTSCH("LINK",ZTDVOL)=1
 .L +^%ZTSCH("C",ZTDVOL):5
 .S ^%ZTSCH("C",ZTDVOL,ZTDTH,ZTSK)=""
 .L -^%ZTSCH("C",ZTDVOL)
 .Q
 D TSKSTAT^%ZTM1("G","Link Wait")
 L  K ZT,ZT1,ZTD,ZTI,ZTM,ZTN,ZTORIGNL,ZTR,ZTS,ZTT,ZTREP Q
 ;
ERCL ;I2^%ZTM - error in C list
 Q:$$OOS^%ZTM(ZTVOL)  N %
 S %=$O(^%ZIS(14.7,"B",ZTVOL,0))
 I %>0 S $P(^%ZIS(14.7,%,0),U,11)=1
 Q
LKUP(VS) ;Lookup a VS and place in ZTVS
 N %,%1
 S %=$O(^%ZIS(14.5,"B",VS,0)),%1=$G(^%ZIS(14.5,+%,0))
 S %ZTVS(VS)=%1,%ZTVS(VS,"IFN")=% Q
