XMAFTP ;(WASH ISC)/TCPIP-FTP Options ;04/17/2002  07:29
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; GET     XM-FTP-GET
 ; PUT     XM-FTP-PUT
 Q
GO ;Come here from GET or PUT (see tags below)
 I ^%ZOSF("OS")'["VAX DSM" W !!,"Sorry...this option only works for VAX DSM" Q
 N $ETRAP,$ESTACK S $ETRAP=""
 S X="EXIT^XMAFTP",@^%ZOSF("TRAP")
 N DIC,DIE,DIK,DD,DO,DTOUT,DUOUT,XMAFTP S XMAFTP=Z
 S DIC="^XMBX(4.2995,",DIC(0)="AEQFZ",X="TMP"_$P($H,",",2)
 S DIC("DR")="1///"_($H*86400+$P($H,",",2))_";2///"_$S($G(XMDUZ):XMDUZ,1:DUZ)_";4///"_Z
 K DD,DO D FILE^DICN K DD,DO
 Q:Y<0  S DIE=DIC,DA=+Y
 S DIE("NO^")="BACKOUTOK"
 ;
 ;Ask data according to Get or Put option
 S DR=$S(XMAFTP=1:"12;13;10;11;7;8;9",XMAFTP=2:"10;11;12;13;7;8;9",1:"")
 G EXIT:DR=""
 D ^DIE
 G EXIT:$S(X="":1,$D(DTOUT):1,$D(DUOUT):1,1:0)
 D SETXMF
 W !!,"In process...it will take a little time to complete the transmission."
 D FTP K XMSFTP
 Q
EXIT S DIK="^XMBX(4.2995," D ^DIK
 I '$D(ZTQUEUED),'$D(XMCHAN) W !!,"Process Aborted !!!",$C(7)
 Q
SETXMF ;Set up XMSFTP array to use when doing tag FTP
 S %1=$G(^XMBX(4.2995,DA,1))
 S XMSFTP(4)=$P(%1,U,4)
 S XMSFTP(5)=$P(%1,U,5)
 I XMAFTP=1 S XMSFTP(1)=$P(%1,U,6),XMSFTP(2)=$P(%1,U,10),XMSFTP(2,"F")=$P(%1,U,9),XMSFTP(9)=$P(%1,U,7),XMSFTP(10)=$P(%1,U,8)
 I XMAFTP=2 S XMSFTP(3)=$P(%1,U,6),XMSFTP(2)=$P(%1,U,8),XMSFTP(2,"F")=$P(%1,U,7),XMSFTP(9)=$P(%1,U,9),XMSFTP(10)=$P(%1,U,10)
 Q
FTP ;Set up 4.2995 entry and XMnn.COM file
 N XMIO S XMIO=$I
 S (XMSFTP,X)=$G(^XMBX(4.2995,"F",0))+1,^(0)=X
 S FILE="XM"_X_".COM" O FILE:NEW U FILE
 W "$! FTP COM procedure for fetching file from server and sending it",!
 W "$ set noon",!
 W "$ assign/user nla0: sys$output",! ; Turn off echo
 W "$ assign/user sys$input sys$command",!
 I $L($G(XMSFTP(3))),$L($G(XMSFTP(2))) W "$ set def "_XMSFTP(2),!
 I $L($G(XMSFTP(1))),$L($G(XMSFTP(10))) W "$ set def "_XMSFTP(10),!
 W "$ FTP=""$TWG$TCP:[NETDIST.USER]FTP",!
 W "$ FTP "
 I $L($G(XMSFTP(1))) W XMSFTP(1),!
 E  W XMSFTP(3),!
 S %2=$G(XMSFTP(4)) W %2,!
 S %2=$G(XMSFTP(5)) I $L(%2) W %2,!
 W "bin",!
TT I XMAFTP=1 D
 .I $L($G(XMSFTP(2))) W "cd "_XMSFTP(2),!
 .W "get "_XMSFTP(2,"F")_" "_$G(XMSFTP(9)),!
 I XMAFTP=2 D
 .I $L($G(XMSFTP(10))) W "cd "_XMSFTP(10),!
 .W "put "_XMSFTP(2,"F")_" "_$G(XMSFTP(9)),!
 W "quit",!
 S DIE="^XMBX(4.2995,",DR=".01////"_FILE D ^DIE
 C FILE
 K FILE
 U XMIO
 Q
GET ;Entry for GET option
 N Z S Z=1 G GO
PUT ;Entry for PUT option
 N Z S Z=2 G GO
