FBNHRAT ;AISC/CMR-POST NEW RATES FOR VETERAN ;4/14/93
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S FBRATE=1 K ^TMP($J,"FB")
VENDOR ;select CNH vendor from the fee vendor file (161.2)
 S DIC="^FBAAV(",DIC(0)="AEQM",DIC("A")="Select CNH Vendor:",DIC("S")="I $P(^(0),U,9)=5" D ^DIC K DIC G Q:X=""!(X="^")!(Y<0)  S FBVIEN=+Y
 ;
VETDISP ;get patients in the selected nursing home
 S I=0
 F  S I=$O(^FBAACNH("AD",I)) Q:'I  S J=0 F  S J=+$O(^FBAACNH("AD",I,J)) Q:'J  I $P($G(^FBAACNH(J,0)),U,9)=FBVIEN S FB(0)=$G(^(0)) D DRIV(I,J,.FB) K FBNFDT,FBNTDT
 I '$G(FBFND) W !!,"There are presently no patients that need rates updated for this vendor."
Q K DIC,X,Y,FBVIEN,I,J,FB,FBTYP,FBNFDT,FBNTDT,FBAUTHN,FBAUTH,FBAFDT,FBATDT,FB7078,FBRT1,FBNFDT,FBNTDT,FBRTDT,FBIEN,FBRFDT,FBCFDT,FBI,FBCTDT,FBCNUM,FBRATE,FBFND,FBX,FBNRTDT,FBNRFDT,DUOUT,DTOUT,DIRUT,DR,DIE,FBCHFDT,FBCHTDT,FBRT,FBZ
 K FBRET
 Q
DRIV(I,J,FB,FBDDT) ;identify incomplete rate data for a given authorization
 ;INPUT   I = DFN
 ;        J = ien of active admission from movement file (162.3)
 ;        FB = passing of 0 node of mvmnt(162.3)
 ;        FBDDT (optional) = date of discharge
 ;output  FBFND = if 1 means at least 1 pt. had a rate created
 ;        FBUNR (only set if FBDDT passed) = array containing timeframes
 ;             unable to establish rates for
 N FBVIEN,FBAUTHN,FBAUTH,FBAFDT,FBATDT,FB7078,FBNFDT,FBNTDT,FBIEN,FBRFDT,FBRTDT,FBRT,FBCHFDT,FBCHTDT
 S FBVIEN=+$P(FB(0),U,9),FBAUTHN=$P(^FBAACNH(J,0),"^",10),FBAUTH=$G(^FBAAA(I,1,FBAUTHN,0)),FBAFDT=+FBAUTH,FBATDT=$P(FBAUTH,"^",2),FB7078=+$P(FBAUTH,"^",9)
 I $G(FBDDT) S FBAFDT=$S($$DTC^FBUCUTL(DT,FBAFDT)>730:$$CDTC^FBUCUTL(DT,-730),1:FBAFDT) Q:FBAFDT>FBDDT
 ;checks rate file, if no rates exist it will create one
 I '$D(^FBAA(161.23,"AC",FB7078)) S FBNFDT=FBAFDT,FBNTDT=$S($G(FBDDT):FBDDT,1:FBATDT) D VENDAT^FBNHRAT1 Q
 ;set up array of existing rates
 K FBRT S FBIEN=0 F  S FBIEN=$O(^FBAA(161.23,"AC",FB7078,FBIEN)) Q:'$G(FBIEN)  S FB(1)=$G(^FBAA(161.23,FBIEN,0)),FBRFDT=+FB(1),FBRT(FBRFDT)=FB(1) K FB(1)
 ;FBCHFDT and FBCHTDT are check dates (initially = to auth fr & to dates,  they are incremented based on existing rates throughout the check)
 S FBCHFDT=FBAFDT,FBCHTDT=$S($G(FBDDT):FBDDT,1:FBATDT),FBRFDT=0 D GETRAT,CKFRDT
 Q
GETRAT ;gets next rate from rate array
 S FBRFDT=+$O(FBRT(FBRFDT)) Q:'FBRFDT  S FBRTDT=$P(FBRT(FBRFDT),"^",2) Q
CKFRDT ;comparison of from dates
 Q:FBCHFDT>FBCHTDT
 I FBCHFDT=FBRFDT G CKTODT
 I FBCHFDT<FBRFDT S FBNFDT=FBCHFDT,FBNTDT=$S($$CDTC^FBUCUTL(FBRFDT,-1)>FBCHTDT:FBCHTDT,1:$$CDTC^FBUCUTL(FBRFDT,-1)) D VENDAT^FBNHRAT1 S FBCHFDT=$$CDTC^FBUCUTL(FBNTDT,1) K FBNFDT,FBNTDT G CKFRDT
 I FBCHFDT>FBRFDT Q:FBCHFDT>FBCHTDT  I 'FBRFDT S FBNFDT=FBCHFDT,FBNTDT=FBCHTDT D VENDAT^FBNHRAT1 K FBNFDT,FBNTDT Q
 I FBCHFDT>FBRFDT G CKTODT
 Q
CKTODT ;comparison of to dates
 Q:FBCHTDT=FBRTDT!(FBCHTDT<FBRTDT)
 I FBCHFDT'>FBRTDT S FBCHFDT=$$CDTC^FBUCUTL(FBRTDT,1)
 D GETRAT G CKFRDT
