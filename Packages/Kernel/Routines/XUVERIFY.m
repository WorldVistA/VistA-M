XUVERIFY ;SF/MUS - Checks a users ACCESS and VERIFY CODES ;11/23/2004  14:43
 ;;8.0;KERNEL;**2,26,59,265**;Jul 10, 1995
 ; The variables % and %DUZ must be set before running this
 ; program   % - may equal "A","V" OR both "AV"
 ;        %DUZ - must equal the users DUZ
 ;
 ; After the program is run % will return -1,0,1,2
 ; if %=-1 an "^" was entered  if %=0 an "?" was entered
 ; if %=1 the Code typed was correct
 ; if %=2 the Code was typed incorrectly
 ; IA# 10051
 N %AC,%VC,%R,I,X,Y,Z,XUSTMP D DIALOG
 I '$D(%)!'$D(%DUZ) S %=2 G KIL
 I '$D(^VA(200,%DUZ,0)) S %=2 G KIL
 G:%["A"!(%["V") CHECK S %=2 G KIL
CHECK S %R=$S(%="V":"VER",1:"ACC") D @%R
 I X["^" S %=-1
 I X?1.4"?" S %=0
KIL X ^%ZOSF("EON") K X,Y,Z,%AC,%VC,%R,I
 Q
ACC ;Access code
 X ^%ZOSF("EOFF") W !,XUSTMP(51) S X=$$ACCEPT^XUS Q:X["^"!(X?1.4"?")  D LC^XUS:X?.E1L.E,^XUSHSH S %AC=X
 I %AC'=$P(^VA(200,%DUZ,0),"^",3) S %AC=2 D:%["V" VER S %=%AC Q
 S %AC=1 D:%["V" VER S:%'=2 %=%AC
 Q
 ;
VER ;Verify code
 X ^%ZOSF("EOFF") W !,XUSTMP(52) S X=$$ACCEPT^XUS Q:X["^"!(X?1.4"?")  D LC^XUS:X?.E1L.E,^XUSHSH S %VC=X
 I %VC'=$P(^VA(200,%DUZ,.1),"^",2) S %=2 Q
 S %=1
 Q
 ;
XUS2 ;MOVED FROM XUS2, TO CHECK OR RETURN USER ATTRIBUTES
 S:$D(XUS)[0 XUS="" D USER:XUS["A",USER:$D(DUZ)[0,EDIT:XUS["E"
 K XUS
 Q
 ;
USER ;ASK FOR USER ID, RETURN DUZ
 N IEN,X2,XUF,XUFAC,XUSTMP S U="^" D DIALOG
 S DUZ=0,DUZ(0)="",DUZ(1)="",XUF=0
 X ^%ZOSF("EOFF") S X2=$$ASKAV^XUS
 S IEN=$$CHKAV(X2)
 I IEN>0 D DUZ^XUP(IEN)
 X ^%ZOSF("EON")
 D CHK^XM:DUZ
 Q
 ;
EDIT ;
 N XUC,DIE,DUZX,DR,D0,DA,DI,DIC,DQ
 S XUC="",DIE="^VA(200,",DA=$S($D(DUZX):DUZX,1:DUZ) D AUTO^XUS2:XUS["G"
 S DR=".01;2"_$S(XUS["M"&$L(XUC):"///"_XUC,1:"")_";11"_$S(XUS["M":";1;3:9;12:20;200:201",1:";1;13")
 D ^DIE
 Q
 ;
CHKAV(AVCODE) ;EF. IA# 10051
 ;Return IEN of the AVcode if good.
 N XUTT,XUF,XUSER,IEN,DUZ
 S XUF=0,DUZ=$$CHECKAV^XUS(AVCODE)
 I DUZ>0,$$UVALID^XUS()>0 S DUZ=0
 Q DUZ
 ;
WITNESS(PREFIX,KEYS) ;EF. IA# 1513
 ;Return IEN of a person if they have A/V & KEYs.
 ; '^' out = -1, Fail = 0, OK IEN
 N X2,IEN,CNT,EXIT,XUSTMP D DIALOG
 S U="^",EXIT=0,IEN=0,CNT=$P(^XTV(8989.3,1,"XUS"),U,2) ;# attemps
 X ^%ZOSF("EOFF")
 I $D(PREFIX) S:" "'[$E(PREFIX,$L(PREFIX)) PREFIX=PREFIX_" "
 F CNT=1:1:CNT D  Q:EXIT
 . S X2=$$ASKAV^XUS($G(PREFIX))
 . S IEN=$$CHKAV(X2),EXIT=(IEN>0) S:IEN<0 EXIT=1
 . I IEN>0,$L($G(KEYS)) S EXIT=0 F %=1:1 S X=$P(KEYS,"^",%) Q:X=""  S:$D(^XUSEC(X,IEN)) EXIT=1
 . Q
 X ^%ZOSF("EON")
 Q:'EXIT 0 Q IEN
 ;
DIALOG ;Set up the dialog
 S XUSTMP(51)=$$EZBLD^DIALOG(30810.51),XUSTMP(52)=$$EZBLD^DIALOG(30810.52)
