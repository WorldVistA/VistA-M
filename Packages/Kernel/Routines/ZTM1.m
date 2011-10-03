%ZTM1 ;SEA/RDS-TaskMan: Manager, Part 3 (Validate Task) ;07/27/2005  18:13
 ;;8.0;KERNEL;**118,127,275,355**;JUL 10, 1995;Build 9
MAIN ;
 ;SCHQ^%ZTM--examine task, determine device and destination, ^%ZTSK(ZTSK) lock at call.
 D LOOKUP D  D STORE
 .D ZIS I %ZTREJCT Q
 .D VOLUME I %ZTREJCT Q
 .D UCI I %ZTREJCT Q
 .Q
 Q  ;Un-lock back in %ZTM
LOOKUP ;
 ;MAIN--Unload Task Variables For Validation
 S %ZTREJCT=0
 D TSKSTAT(2,"Inspected")
 S ZTREC=^%ZTSK(ZTSK,0)
 S ZTREC02="",ZTREC1=$G(^%ZTSK(ZTSK,.1)),ZTREC2=$G(^%ZTSK(ZTSK,.2))
 S ZTREC21="",ZTREC25=$G(^%ZTSK(ZTSK,.25)) ;,$P(ZTREC,U,6)=ZTDTH
 S ^%ZTSK(ZTSK,.02)="" ;Clear
 Q
 ;
ZIS ;MAIN--Determine Output Device
 S ZTIO=$S($P(ZTREC2,U)]"":$P(ZTREC2,U),1:ZTST)
 I ZTIO="" S (IO,ZTREC2,ZTREC21,ZTREC25)="" G ZISX
 S $P(ZTREC2,U)=ZTIO,%ZIS="NQRST0",IOP=ZTIO,ZTIO(1)=$P(ZTREC2,U,5)
 I ZTIO(1)="DIRECT" S %ZIS=%ZIS_"D"
 D ^%ZIS K IO(1)
 I $S($G(IOT)="VTRM":1,IO="":1,1:POP) D REJCT("INVALID OUTPUT DEVICE") G ZISX
 I IOT="HG" S IO=""
 ;Check for IO queue at end
 S $P(ZTREC2,U,1,4)=ZTIO_U_IO_U_IOT_U_IOST
 S:'$D(IOCPU) IOCPU=$P($G(^%ZIS(1,+$G(IOS),0)),U,9) ;need IOCPU
 S ZTREC21=$G(IOS)
ZISX Q
 ;
VOLUME ;determine destination volume set
 S ZTDVOL(1)="",A=$P($G(IOCPU),":",2) ;device node
 S ZTNODE=$S($L(A):A,1:$P($P(ZTREC,U,14),":",2))
 S A=$S(ZTIO="":"",1:$P($G(IOCPU),":")) ;device cpu
 S ZTDVOL=$S($L(A):A,1:$P($P(ZTREC,U,14),":")) ;Destination
 S ZTCVOL=$P(ZTREC,U,12),ZTCVT=$$VSTYP(ZTCVOL) ;Creation
 I ZTDVOL="" D
 . I ZTCVT="C" S ZTDVOL=$S(%ZTYPE="P":%ZTVOL,ZTCVOL]"":ZTCVOL,1:%ZTVOL),ZTDVOL(1)=1 Q
 . S ZTDVOL=$S(ZTCVOL]"":ZTCVOL,1:%ZTVOL) Q
 S ZTREC02=U_ZTDVOL_U_ZTNODE_U_ZTDVOL(1)
 ;
V1 ;reject tasks with destination volume sets not in Volume Set file
 S ZT1=$O(^%ZIS(14.5,"B",ZTDVOL,""))
 I ZT1="" D REJCT("Task's volume set not listed in index.") Q
 S ZTS=$G(^%ZIS(14.5,ZT1,0))
 I ZTS="" D REJCT("Task's volume set not listed in file.") Q
 ;
V2 ;lookup type of volume set, and reject tasks to F or O types
 S ZTYPE=$P(ZTS,U,10)
 I ZTYPE="F"!(ZTYPE="O") D REJCT("Task's volume set can't accept tasks.") Q
 ;
V3 ;accept tasks with the current volume set as the destination
 I ZTDVOL=%ZTVOL Q
 ;
V4 ;reject tasks whose destination volume sets lack link access
 I $P(ZTS,U,3)="N" D REJCT("Task's volume set has no link access.") Q
 Q
VSTYP(VS) ;Get a VS's type
 Q:VS="" VS N %
 S %=$O(^%ZIS(14.5,"B",VS,0)),%=$G(^%ZIS(14.5,+%,0))
 Q $P(%,U,10)
 ;
UCI ;MAIN--determine destination UCI
 S ZTUCI=$P($P(ZTREC,U,4),",")
 S ZTUCI=$S(ZTUCI]"":ZTUCI,1:$P(ZTREC,U,11))
 ;
 ;reject tasks that lack a destination UCI
U1 ;
 ;reject tasks with no UCI of origin or requested destination
 I ZTUCI="" D REJCT("Task has no destination UCI listed.") Q
U2 ;
 ;handle tasks whose destination volume set is the current one
 ;if UCI is here, accept the task; if not, reject it
 I ZTDVOL=%ZTVOL D  Q
 . S X=ZTUCI_","_ZTDVOL X ^%ZOSF("UCICHECK")
 . I 0[Y D REJCT("Task's UCI does not exist here.") Q
 . S ZTUCI=$P(Y,",")
 . S $P(ZTREC02,U)=ZTUCI
 . I $E($P(ZTREC,U,2))'="%" Q
 . S X=$P(ZTREC,U,2) X ^%ZOSF("TEST")
 . I $T Q
 . D REJCT("Task's entry routine does not exist here.")
 .Q
U3 ;
 ;accept tasks whose dest. UCIs are listed under their dest. volume sets
 I $O(^%ZIS(14.6,"AV",ZTDVOL,ZTUCI,"")) S $P(ZTREC02,U)=ZTUCI Q
U4 ;
 ;otherwise, the destination UCI must be a valid one here...
 S X=ZTUCI X ^%ZOSF("UCICHECK")
 I 0[Y D REJCT("Task's destination UCI failed check.") Q
U5 ;
 ;...and it must be changed to the associated UCI over there
 S ZT1=$O(^%ZIS(14.6,"AT",ZTUCI,%ZTVOL,ZTDVOL,""))
 I ZT1]"" S ZTUCI=ZT1
 S $P(ZTREC02,U)=ZTUCI
 Q
 ;
STORE ;Store Validated Data In Task Log, Quit If Needn't Do WAIT
 I %ZTREJCT S $P(ZTREC1,U,1,2)="B^"_$H ;Rejected
 I $D(^%ZTSK(ZTSK,0))[0 D TSKSTAT("I") S %ZTREJCT=1 Q
 S ^%ZTSK(ZTSK,0)=ZTREC
 S ^%ZTSK(ZTSK,.02)=ZTREC02
 S ^%ZTSK(ZTSK,.1)=$P(ZTREC1,U,1,9)_U_$P(^(.1),U,10,11)
 S ^%ZTSK(ZTSK,.2)=ZTREC2,^(.21)=ZTREC21,^(.25)=ZTREC25
 K %ZTF,IOCPU
 I ZTIO="" Q
 I %ZTREJCT Q
 I ZTDVOL'=%ZTVOL Q
 I IOT'="TRM",IOT'="RES" Q
 I $D(^%ZTSCH("IO",IO))>9 D IOWAIT
 K X,Y
 Q
 ;
IOWAIT ;If Device has a queue, Put Task On IO Queue.
 S %ZTREJCT=1 D TSKSTAT("A","Put On The IO List")
 S %ZTIO=IO,ZTIOS=ZTREC21,ZTIOT=IOT
 D NQ^%ZTM4
 Q
 ;
REJCT(MSG) ;Save reject msg, set flag
 S %ZTREJCT=1,$P(ZTREC1,U,3)=MSG
 I $G(DUZ)>.9 D
 . N XQA,XQAMSG,XQADATA,XQAROU,ZTUCI
 . S XQA(DUZ)="",XQAMSG="Your task #"_ZTSK_" rejected because: "_MSG,XQADATA=ZTSK,XQAROU="XQA^XUTMUTL"
 . S ZTUCI=$P($P(ZTREC,U,4),","),ZTUCI=$S(ZTUCI]"":ZTUCI,1:$P(ZTREC,U,11))
 . N ZTSK,ZTIO,ZTDTH,ZTCPU,ZTREC
 . S ZTRTN="ALERT^%ZTMS4",ZTDTH=$H,ZTIO="",ZTSAVE("XQA*")=""
 . D ^%ZTLOAD Q
 Q
 ;
TSKSTAT(CODE,MSG) ; Update task's status
 S $P(^%ZTSK(ZTSK,.1),"^",1,3)=$G(CODE)_U_$H_U_$G(MSG)
 Q
 ;
H3(%) ;Convert $H to seconds.
 Q 86400*%+$P(%,",",2)
