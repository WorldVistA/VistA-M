PRCHUTL ;SF/TKW/ID/RSD-UTILITY ROUTINES FOR SUPPLY SYSTEM ; 5/10/99 10:58am
 ;;5.1;IFCAP;**15**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN2 ;CALLED FROM FILE 441 FIELD .01, INPUT X="NEW", OUTPUT X=NEXT INTERNAL NUMBER
 S PRCHU=$P(^PRC(441,0),U,3) F I=1:1 S PRCHU=PRCHU+1 I '$D(^PRC(441,PRCHU)) L ^PRC(441,PRCHU) I  S (X,DIX)=PRCHU K PRCHU Q
 Q
 ;
ENPO ;ENTER NEW PO IN FILE 442
 K PRCHPO,PRCHNEW,DA,DIC,DLAYGO,L Q:'$D(PRC("SITE"))
 I '$D(DT) S X="T" D ^%DT S DT=Y
 W !!,"ENTER A NEW "_$S($G(PRCHDELV):"DELIVERY",1:"PURCHASE")_" ORDER NUMBER OR A COMMON NUMBERING SERIES"
 W !?3,$S($G(PRCHDELV):"DELIVERY",1:"PURCHASE")_" ORDER: " R X:DTIME
 G:X=""!(X=U) ENPOQ
 D:'$D(DIC("S"))
 . S DIC="^PRC(442.6,",DIC(0)="QEMZ"
 . I $G(PRCHPC) S DIC("S")="I +$P(^(0),U,1)=PRC(""SITE""),$P(^(0),U,5)=6"
 . E  I $G(PRCHDELV) S DIC("S")="I +$P(^(0),U,1)=PRC(""SITE""),$P(^(0),U,5)=7"
 . E  S DIC("S")="I +$P(^(0),U,1)=PRC(""SITE""),($P(^(0),U,5)=2!($P(^(0),U,5)="""")!($P(^(0),U,5)=6))"
 I $L(X)<4!($E(X,1)="?") S D="C" D IX^DIC G ENPO:Y<0,NUM:$L(X)<4
 I '$O(^PRC(442.6,"B",PRC("SITE")_"-"_$E(X,1,2),0)) W " ??? Not part of an existing Common Numbering Series." G ENPO
 I $E(X,1,2)["B" W $C(7),!! W "'B' numbers are normally used for Acquisitions from Federal Sources." S %A="  ARE YOU SURE ",%B="This number should only be used for Federal Source Acquisitions",%=2 D ^PRCFYN G:%=-1 ENPOQ G:%'=1 ENPO
 S X=PRC("SITE")_"-"_X I $D(^PRC(442,"B",X)) W !?3,"P.O. ",X," already exist, use edit option to modify." G ENPO
 ;
ENPO1 K DIC("S") S PRCHNEW="",DIC="^PRC(442,",DLAYGO=442,DIC(0)="L" D ^DIC L  G ENPO:Y<0,W3:'+$P(Y,U,3)
 S (DA,PRCHPO)=+Y,%DT="T",X="NOW" D ^%DT S $P(^PRC(442,PRCHPO,12),U,4,5)=DUZ_U_Y
 S (X,Y)=1,DA=PRCHPO D UPD^PRCHSTAT
 S $P(^PRC(442,PRCHPO,1),U,10)=DUZ
 D DOCID
 G ENPOQ
 ;
NUM L ^PRC(442.6,+Y,0):1 G:'$T W1 S X=$P(Y,U,2),Z=$S(+$P(Y(0),U,4)<$P(Y(0),U,2):+$P(Y(0),U,2),1:+$P(Y(0),U,4)),L=$L(X)#2-3
 ;
Z G:Z>$P(Y(0),U,3) W2 S Z="000"_Z,Z=$E(Z,$L(Z)+L,$L(Z)),X=X_Z I $D(^PRC(442,"B",X)) S Z=Z+1,X=$P(Y,U,2) G Z
 W $C(7) S %A="   Are you adding '"_X_"' as a new Purchase Order number ",%B="",%="" D ^PRCFYN I %'=1 L  G ENPO
 S $P(^PRC(442.6,+Y,0),U,4)=+Z
 G ENPO1
 ;
DOCID S Z=$P($P(^PRC(442,PRCHPO,0),U,1),"-",2) Q:$L(Z)'=6  F I=1:1:6 S X=$E(Z,I,I) Q:+X=X
 I +X=X S $P(^PRC(442,PRCHPO,18),"^",3)=$S(I=1:$E(Z,2,6),1:$E(Z,1,I-1)_$E(Z,I+1,6))
 Q
 ;
W1 L  W !?3," Common numbering series is being edited by another user, try later",$C(7)
 G ENPO
 ;
W2 L  W !?3,"UPPER BOUND HAS BEEN EXCEEDED FOR COMMON NUMBERING SERIES ",$P(Y,U,2),$C(7)
 G ENPO
 ;
W3 W "   Purchase Order number already exist, please try again ",$C(7)
 G ENPO
 ;
ENPOQ K DIC,DLAYGO,%DT,PRCHNEW,L
 Q
 ;several old linetags that encoded/decoded esigs were removed from here
 ;
WORD ; PRCH=GLOBAL,WX=LINE TO INSERT
 I '$D(@(PRCH_"0)")) S @(PRCH_"0)")="^^0^0^"_DT
 S WI=0 F WJ=1:1 S WI=$O(@(PRCH_WI_")")) Q:'WI  I $D(^(WI,0)) S WY=^(0),^(0)=WX,WX=WY
 S $P(@(PRCH_"0)"),U,3,4)=WJ_U_WJ,^(WJ,0)=WX K WI,WJ,WX,WY
 Q
 ;
SWITCH N X K PRCHLOG,PRCHISMS S X=$$ISMSFLAG^PRCPUX2(PRC("SITE")) S:X#2 PRCHLOG="" S:X\2 PRCHISMS="",PRCHTYP="I"
 Q
 ;
EDISTAT(D0,D1,LINECNT) ;DISPLAY P.O.'S EDI STATUS & QUANTITY
 ;REQUIRES INTERNAL RECORD NUMBER AS D0
 ;         INTERNAL SUBRECORD NUMBER AS D1
 ;         RETURNS THE NUMBER OF LINES PRINTED AS LINECNT
 ;NOTE: THE NAKED REFERENCE WILL BE ^DD(442.01,12 or 13,0) WHEN
 ;      THIS MODULE FINISHES.
 N X,Y,C
 S:'$D(LINECNT) LINECNT=0
 I $D(^PRC(442,D0,2,D1,2)) S X=$P(^(2),"^",9,12) D
 .I $P(X,"^",1)=""&($P(X,"^",3)="") Q
 .W !,"  E D I   S T A T U S :  ",?26
 .I $P(X,"^",1)]"" S Y=$P(X,"^",1),C=$P(^DD(442.01,12,0),"^",2) D Y^DIQ W "#1: ",Y,"  QTY: ",$P(X,"^",2),!,?26 S LINECNT=LINECNT+1
 .I $P(X,"^",3)]"" S Y=$P(X,"^",3),C=$P(^DD(442.01,13,0),"^",2) D Y^DIQ W "#2: ",Y,"  QTY: ",$P(X,"^",4) S LINECNT=LINECNT+1
 .W ! S LINECNT=LINECNT+1
 .Q
 Q
 ;
 ;
 ;
VEN(A) ; Entry point to get FMS Vendor ID_ Alt.Address Indicator  from the vendor file. -- Used by AR (Only)
 ;  A = internal entry number to vendor file (#440)
 ;
 N T S T=$G(^PRC(440,+A,3))
 I $L($P(T,U,4))'=9 Q ""
 Q $P(T,U,4)_$P(T,U,5)
 ;
VENSEL() ; VENSEL = VENdor SELection
 ; EXTRINSIC FUNCTION THAT ALLOWS A USER TO SELECT AN IFCAP VENDOR.
 ; THIS FUNCTION WILL BE USED BY ACCOUNTS RECEIVABLE USERS.
 ;
 ; THIS EXTRINSIC FUNCTION WILL RETURN A STRING.
 ;      CONDITION          STRING VALUE          ^DIC VALUE
 ;     LOOKUP FAILED            -1                  Y=-1
 ;       TIMED-OUT              -2                  DTOUT
 ;       UP-ARROW               -3                  DUOUT
 ;      SUCCESSFUL          DA^.01 FIELD            Y=N^S
 ;   SUCCESSFUL & NEW      DA^.01 FIELD^1          Y=N^S^1
 ;
 ; THE DEFINITIONS OF THE ^DIC VALUEs MAY BE FOUND IN VA FileMan
 ; V.21.0 Programmer Manual ON PAGES 56-57.  THIS IS THE RETURNED
 ; STRING OF THIS FUNCTION.
 ;
 ; FIRST, ASK THE USER FOR THEIR "SITE".
 ;
 S PRCF("X")="S"
 D ^PRCFSITE
 ;
 ; NOW THAT WE HAVE THE SITE, CONTINUE ON.
 ;
 S DIC="^PRC(440,"
 S DIC(0)="AEMO"
 S DIC("A")="Select the DEBTOR from the VENDOR list: "
 K DTOUT,DUOUT
 D ^DIC
 S:$D(DTOUT) Y=-2
 S:$D(DUOUT) Y=-3
 K DIC,DTOUT,DUOUT
 S PRCOY=Y
 I +PRCOY<0 Q PRCOY
 ;
 ; NOW LETS SEE IF THIS VENDOR RECORD IS PROPERLY SET UP.
 ;
 S DA=+Y
 K ^PRC(440.3,DA)
 S %X="^PRC(440,DA,"
 S %Y="^PRC(440.3,DA,"
 D %XY^%RCR
 S FLAG=1
 S FISCAL=$G(^PRC(411,PRC("SITE"),9))
 S FISCAL=$P(FISCAL,U,3)
 S SAVE=$$CHECK^PRCOVTST(DA,PRC("SITE"),FLAG)
 I FISCAL="Y",SAVE=0 D
 .  S DIE="^PRC(440.3,"
 .  S DR="47///^S X=FLAG;48///^S X=DA;49///^S X=PRC(""SITE"")"
 .  D ^DIE
 .  Q
 I FISCAL'="Y",SAVE=0 S PRCZDA=DA D VRQ^PRCOVTST(DA,PRC("SITE")) S DA=PRCZDA K PRCZDA
 I SAVE=1 D
 .  S AR=449
 .  S DIE="^PRC(440.3,"
 .  S DR="50///^S X=FLAG;51///^S X=DA;52///^S X=PRC(""SITE"")"
 .  D ^DIE
 .  K AR
 .  Q
 Q PRCOY
 ;
AF ; CALLED BY "AF" X-REF IN FIELD 52 (SITE AR) IN FILE 440.3.
 N PRCX,DIC,DLAYGO,Y
 Q:$G(AR)'=449
 S PRCX=$O(^PRCF(422.2,"B","AR-EDIT-01",0)) D:PRCX=""
 .  ; NEED TO SET UP ENTRY IN COUNTER FILE.
 .  K DD,DO
 .  S DIC="^PRCF(422.2,"
 .  S DIC(0)="L"
 .  S X="AR-EDIT-01"
 .  S DELAYGO=422.2
 .  D FILE^DICN
 .  S PRCX=+Y
 .  Q
 S $P(^PRCF(422.2,PRCX,0),U,2)=+$P(^PRCF(422.2,PRCX,0),U,2)+1
 Q
 ;
VENEDITF ; THIS ENTRY POINT WILL INFORM USERS THAT THERE ARE VENDOR
 ; RECORDS, USED BY Accounts Receivable, THAT NEED TO BE EDITED
 ; BEFORE THEY CAN BE ENTERED INTO A VRQ.
 ;
 ; SEE IF FISCAL CAN ADD A VENDOR.  IF SO, TELL THE USER THERE
 ; RECORDS TO EDIT.
 ;
 N COUNT,STN411,SHOWIT
 Q:'$D(DUZ)   ; YOU ARE UNDEFINED.
 ;
 ; SEE IF FISCAL CAN ADD VENDORS.
 ;
 D FIND
 Q:STN411'=1
 ;
 S SHOWIT=0
 ;
 ; I STN411=1 THEN FISCAL CAN ADD VENDORS.
 ; SEE IF THE USER IS A FISCAL USER.
 ;
 I $D(^XUSEC("PRCFA VENDOR EDIT",DUZ))=1 S SHOWIT=1
 Q:SHOWIT'=1
 G COUNT
 ;
VENEDITS ; THIS ENTRY POINT WILL INFORM USERS THAT THERE ARE VENDOR
 ; RECORDS, USED BY Accounts Receivable, THAT NEED TO BE EDITED
 ; BEFORE THEY CAN BE ENTERED INTO A VRQ.
 ;
 ; SEE IF FISCAL CAN ADD A VENDOR.  IF NOT, HAVE SUPPLY EDIT THE
 ; VENDOR RECORDS.
 ;
 N COUNT,STN411,SHOWIT
 Q:'$D(DUZ)   ; YOU ARE UNDEFINED.
 ;
 ; SEE IF FISCAL CAN ADD VENDORS.
 ;
 D FIND
 Q:STN411=1
 ;
 S SHOWIT=0
 ;
 ; SEE IF THE USER IS A PURCHASING AGENT OR A MANAGER.
 ;
 I +$P($G(^VA(200,DUZ,400)),U)>2 S SHOWIT=1
 Q:SHOWIT'=1
 ;
COUNT ; NOW SHOW MESSAGE, IF ANY
 ;
 S COUNT=$O(^PRCF(422.2,"B","AR-EDIT-01",0)) Q:COUNT'>0
 S COUNT=$P($G(^PRCF(422.2,COUNT,0)),U,2) Q:COUNT'>0
 W !!,"There are Vendor Records that AR is using to be edited."
 Q
 ;
FIND ; SEE IF FISCAL CAN ADD A VENDOR.
 ;
 N STATION,STNIEN
 S STATION=0
 S STN411=""
 F  S STATION=$O(^PRC(411,"B",STATION)) Q:STATION']""  D  Q:STN411=1
 .  S STNIEN=$O(^PRC(411,"B",STATION,0)) Q:STNIEN'>0
 .  S STN411=$P($G(^PRC(411,STNIEN,0)),U,20)
 .  Q
 Q
