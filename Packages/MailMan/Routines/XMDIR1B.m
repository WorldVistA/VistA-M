XMDIR1B ;(WASH ISC)/CAP-Load VACO Directories (NOAVA) ;04/17/2002  08:47
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; REMOTES  XMEDIT-REMOTE-USER
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP=""
 S X="EOF^XMDIR1B",@^%ZOSF("TRAP"),XMB0=^%ZOSF("UPPERCASE")
GO G P:'$D(ZTQUEUED)
R1 U IO R Y:DTIME I '$D(ZTQUEUED) U IO(0)
 S XMA=XMA+1 I '$D(ZTQUEUED),XMA#10=0 W "."
P S X=Y X XMB0 F %=0:0 Q:$E(Y)'?1P  S Y=$E(Y,2,99)
 F %=$L(Y):-1:0 Q:$E(Y,%)?1A  S Y=$E(Y,1,%-1)
 K X S X=$$STRIP($P(Y,":"))
 G R1:X[" ",R1:X["@",R1:X["::",R1:X["..",R1:X="",R1:X?1.N,R1:X?.E3N.E,R1:X["/",R1:X?.E1C.E
 S XMY=Y
 ;
 ;Name
 S X("LN")=X
 S X=$$STRIP($P(XMY,":",2)),X("FN")=X,X("RN")=""
 ;
 ;Mail code
 S X=$$STRIP($P(XMY,":",6)),X("MC")=$P(X," "),X("EMC")=X G R1:X("MC")?.E1C.E
 ;
 ;Phone number / Extension
 S X("PHONE")=$$STRIP($P(XMY,":",5)),X("PHONE/E")=$$STRIP($P(XMY,":",7))
 ;
 ;Location
 S X("L")=$$STRIP($P(XMY,":",4))
 ;
 ;Network address
 S X=$$STRIP($P(XMY,":",9)),X=$P(X,"@")
 G R1:'$L(X),R1:X?.E1C.E S X("NET")=X_"@VACO.VA.GOV"
 I $D(^XMD(4.2997,"B",X("LN"))) S %="" F  S %=$O(^XMD(4.2997,"B",X("LN"),%)) Q:%=""  I $D(^XMD(4.2997,%,0)) S %6=^XMD(4.2997,%,0) I X("NET")=$P(%6,U,7) S XME="Already on file - not filed " D ER^XMDIR1 G R1
 ;
 D FILE^XMDIR1A(.X)
 G R1
EOF D ^%ZISC,END^XMDIR1A("NOAVA",90) Q
 ;
 ;Strip leading and trailing spaces
STRIP(X) F  Q:$E(X)'=" "  S X=$E(X,2,999)
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,$L(X)-1)
 Q X
NOWANG D @^%ZOSF("ERRTN")
 I '$D(ZTQUEUED) W !!,"The error: "_$ZE_" occured !!!",!!
 G Q^XMDIR1
REMOTES ;Edit/Add Remote members
 N DA,DIE,DR,DIC,DLAYGO,X,Y,DUOUT,DTOUT
 S DIC=4.2997,DLAYGO=4.2997,DIC(0)="AELQMZ" D ^DIC
 Q:$S($D(DTOUT):1,$D(DUOUT):1,Y<1:1,1:0)
 S DA=+Y,DIE=4.2997,DR=".01:99999" D ^DIE
 Q
