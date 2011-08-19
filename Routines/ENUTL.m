ENUTL ;(WIRMFO)/DH-Engineering Utilities ;1.12.98
 ;;7.0;ENGINEERING;**35,42,48**;Aug 17, 1993
 ;
GETEQ ;  Lookup equipment file entries allowing searches by user
 ;    specified x-refs
 ;  Called from ENEQ2, ENEQ4, ENEQLT,ENEQNX5, ENEQPMR4, ENEQRP1, ENEQRP6,
 ;              ENEQTD, ENLBL3, ENWO1
 ;  DIC("S") may be passed, but is not required or returned
 ;  Output => Y as per ^DIC
 ;
 N D,X,ENX,ENI
 S DIC="^ENG(6914,"
EQA ;  Ask for input
 R !,"Select EQUIPMENT ENTRY #: ",ENX:DTIME I '$T!(ENX="")!($E(ENX)="^") S Y=-1 G EQX
 I $E(ENX,3)="." D  I $G(D)]"" S X=$E(ENX,4,99),DIC(0)="QE" D IX^DIC G EQR
 . S ENI=$E(ENX,1,2) I "^EC^LI^LO^MA^MF^MO^SN^"'[(U_ENI_U) Q
 . S D=$S(ENI="EC":"G",ENI="LI":"L",ENI="LO":"D",ENI="MA":"K",ENI="MF":"H",ENI="MO":"EC",ENI="SN":"FC",1:"") I D="" Q
 . I "EC^FC"[D D EQCOMP
 S X=ENX I $E(X)="?" D
 . W !," 'EC.value' => equipment whose EQUIP. CATEGORY starts with 'value'"
 . W !," 'LI.value' => equipment whose LOCAL ID starts with 'value'"
 . W !," 'LO.value' => equipment whose LOCATION starts with 'value'"
 . W !," 'MA.value' => equipment whose MANUFACTURER starts with 'value'"
 . W !," 'MF.value' => equipment whose MFGR. EQUIP. NAME starts with 'value'"
 . W !," 'MO.value' => equipment whose MODEL starts with 'value'"
 . W !," 'SN.value' => equipment whose SERIAL NUMBER starts with 'value'"
 S DIC(0)="QEM" D ^DIC
EQR ;  Result of ^DIC call
 G:Y'>0 EQA
EQX ;  Design EXIT
 K DIC
 Q
 ;
EQCOMP ;  Compress local var X
 Q:$G(X)']""
 S X=$$UP^XLFSTR(X)
 S X=$TR(X," ""~!@#$%^&*()_+|-=\[];',./{}:<>?`","")
 Q
 ;
ZIS ;  Get BOLD and UNBOLD sequences
 ;  Set to NULL if printer (bolding in hard copy would be nice,
 ;    but the Device Files are too messy for it to work well)
 I $E(IOST,1,2)'="C-" S (IOINLOW,IOINHI)="" Q
 N X S X="IOINLOW;IOINHI;IOINORM" D ENDR^%ZISS
 I IOINLOW="",IOINORM]"" S IOINLOW=IOINORM
 Q
 ;
EOM(ENDT) ;End of Month Extrinsic Function
 ; ENDT - Date (internal format)
 ; Returns - Date for end of month (internal format)
 I "^01^03^05^07^08^10^12^"[(U_$E(ENDT,4,5)_U) S ENDT=$E(ENDT,1,5)_"31"
 I "^04^06^09^11^"[(U_$E(ENDT,4,5)_U) S ENDT=$E(ENDT,1,5)_"30"
 I "02"=$E(ENDT,4,5) N YEAR,LEAP D
 . S YEAR=$E(ENDT,1,3)+1700,LEAP=$S('(YEAR#400):1,'(YEAR#4)&(YEAR#100):1,1:0)
 . S ENDT=$E(ENDT,1,5)_$S(LEAP:"29",1:"28")
 Q ENDT
 ;
 ;ENUTL
