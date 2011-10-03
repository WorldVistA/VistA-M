ENFAVAL ;(WIRMFO)/KLD/SAB; VALIDITY CHECKS FOR Fx DOCS ;2/18/99
 ;;7.0;ENGINEERING;**25,29,33,38,39,46,60**;Aug 17, 1993
ST ;
 N ENC,X
 S ENC("BAD")=0
 F I=1:1 X "S T=$P($T("_ENFAP("DOC")_"CHK+I),"";;"",2)" Q:T["END"  D
 . I ENFAP("DOC")="FA" D  Q
 . . Q:$P(ENEQ(+T),U,$P(T,";",2))]""  D SET("Missing "_$P(T,";",3))
 . Q:$P(ENFAP(+T),U,$P(T,";",2))]""  D SET("Missing "_$P(T,";",3))
 I ENFAP("DOC")="FA" D FA
 I ENFAP("DOC")="FC" D FC
 I ENFAP("DOC")="FD" D FD
 I ENFAP("DOC")="FR" D FR
 I ENC("BAD")>0 S ^TMP($J,"BAD",ENEQ("DA"))=ENC("BAD")
 K I,T Q
 ;
FA ;Check for appropriate values of certain required fields
 I $P(ENEQ(2),U,3)]"" D:$P(ENEQ(2),U,3)'>0 SET("Asset Value must be greater than 0.00")
 I $P(ENEQ(3),U,4)]"" D:$P(ENEQ(3),U,4)>0 SET("Acquisition Method inappropriate")
 I $P(ENEQ(0),U,4)]"" D:$P(ENEQ(0),U,4)'="NX" SET("Not non-expendable")
 D:'$P(ENEQ(8),U,2) SET("Asset not capitalized")
 I $P(ENEQ(9),U,6)]"" D
 . S X=$G(^ENG(6914.4,$P(ENEQ(9),U,6),0))
 . I $P(X,U)="" D SET("BOC invalid pointer")
 . I $P(X,U,5)]"",$P(X,U,5)'>DT D SET("BOC has been deactivated")
 I $P(ENEQ(8),U,6)]"" D
 . I '$D(^ENG(6914.3,$P(ENEQ(8),U,6))) D SET("SGL invalid pointer") Q
 . S X=$G(^ENG(6914.3,$P(ENEQ(8),U,6),0))
 . I $P(X,U)="6100" D SET("NX SGL account of 6100")
 . I $P(X,U,5)]"",$P(X,U,5)'>DT D SET("SGL has been deactivated")
 I $P(ENEQ(9),U,7)]"" D
 . S X=$G(^ENG(6914.6,$P(ENEQ(9),U,7),0))
 . I $P(X,U)="" D SET("FUND invalid pointer")
 . I $P(X,U,5)]"",$P(X,U,5)'>DT D SET("FUND has been deactivated")
 I $P(ENEQ(2),U,9)]"" D
 . S ENFAP("LOC")=$$LOC($$GET1^DIQ(6914,ENEQ("DA"),19))
 . I ENFAP("LOC")="" D SET("Invalid CMR") Q
 . I $P(ENEQ(9),U,8)]"" D
 . . S X=$O(^ENG(6914.9,"B",ENFAP("LOC"),0))
 . . Q:'X
 . . S Y=$P($G(^ENG(6914.9,X,0)),U,4)
 . . I Y]"",Y'=$P(ENEQ(9),U,8) D SET("CMR inappropriate for A/O")
 I $P(ENEQ(2),U,8)]"" D
 . S ENFAP("GRP")=$$GROUP($$GET1^DIQ(6914,ENEQ("DA"),18))
 . I 'ENFAP("GRP") D SET("Invalid CSN") Q
 . I $P(ENEQ(8),U,6)]"",'$O(^ENG(6914.3,$P(ENEQ(8),U,6),1,"B",ENFAP("GRP"),0)) D SET("CSN inappropriate for SGL")
 I $P(ENEQ(2),U,4)]"",+$E($P(ENEQ(2),U,4),4,5)'>0 D SET("Acquisition Month Missing")
 I $P(ENEQ(2),U,10)]"" D
 . I +$E($P(ENEQ(2),U,10),4,5)'>0 D SET("Replacement Month Missing")
 . I $P(ENEQ(2),U,4)]"",$P(ENEQ(2),U,10)<$P(ENEQ(2),U,4) D SET("Replacement Date preceeds Acquisition Date")
 Q
 ;
FC ;Check for problems with CSN and/or CMR
 I $P(ENFAP(100),U)]"" D
 . I $P(ENFAP(3),U,9)="" D SET("CSN is unacceptable for capitalized NX") Q
 . I $P(ENEQ(8),U,6)]"",'$O(^ENG(6914.3,$P(ENEQ(8),U,6),1,"B",$P(ENFAP(3),U,9),0)) D SET("CSN inappropriate for SGL")
 I $P(ENFAP(100),U,2)]"",$P(ENFAP(3),U,10)="" D SET("CMR is unacceptable for capitalized NX")
 ;check date order (ACQUISITION & REPLACEMENT)
 I $P(ENFAP(100),U,6)]""!($P(ENFAP(100),U,7)]"") D
 . N ENAD,ENRD
 . S ENAD=$S($P(ENFAP(100),U,6)]"":$P(ENFAP(100),U,6),1:$P(ENEQ(2),U,4))
 . S ENRD=$S($P(ENFAP(100),U,7)]"":$P(ENFAP(100),U,7),1:$P(ENEQ(2),U,10))
 . I ENAD=""!(ENRD="") Q
 . I ENRD'>ENAD D SET("REPLACEMENT DATE must follow ACQUISITION DATE.")
 Q
 ;
FD ; Check for probems with disp date
 I $P(ENFAP(100),U,3)>DT D SET("DISPOSITION DATE must not be later than Today.")
 Q
 ;
FR ; Check for problems with CMR
 I $P(ENFAP(100),U,6)]"",$$LOC($P($G(^ENG(6914.1,$P(ENFAP(100),U,6),0)),U))="" D SET("CMR is unacceptable for capitalized NX")
 I $P(ENFAP(100),U,3)]""!($P(ENFAP(100),U,6)]"") D  ; new A/O or new CMR
 . N ENAO,ENCMR
 . S ENAO=$S($P(ENFAP(100),U,3)]"":$P(ENFAP(100),U,3),1:$P(ENEQ(9),U,8))
 . S ENCMR=$S($P(ENFAP(100),U,6)]"":$P(ENFAP(100),U,6),1:$P(ENEQ(2),U,9))
 . I ENAO=""!(ENCMR="") Q
 . S ENFAP("LOC")=$$LOC($P($G(^ENG(6914.1,ENCMR,0)),U))
 . I ENFAP("LOC")="" Q
 . S X=$O(^ENG(6914.9,"B",ENFAP("LOC"),0))
 . I X'>0 Q
 . S Y=$P($G(^ENG(6914.9,X,0)),U,4)
 . I Y]"",Y'=ENAO D SET("CMR inappropriate for A/O")
 I $P(ENFAP(100),U,5)]"" D
 . S X=$G(^ENG(6914.4,$P(ENFAP(100),U,5),0))
 . I $P(X,U)="" D SET("BOC invalid pointer")
 . I $P(X,U,5)]"",$P(X,U,5)'>DT D SET("BOC has been deactivated")
 I $P(ENFAP(100),U,2)]"" D
 . S X=$G(^ENG(6914.6,$P(ENFAP(100),U,2),0))
 . I $P(X,U)="" D SET("FUND invalid pointer")
 . I $P(X,U,5)]"",$P(X,U,5)'>DT D SET("FUND has been deactivated")
 Q
SET(X) ;Record problems
 S ENC("BAD")=ENC("BAD")+1,^TMP($J,"BAD",ENEQ("DA"),ENC("BAD"))=X
 Q
 ;
LOC(CMR) ;Accepts CMR and checks 1st two char
 ;Returns FAP LOCATION (EIL)
 S ENFAP("LOC")=$E(CMR,1,2) I ENFAP("LOC")'?2N S ENFAP("LOC")="" G LOCDN
 I ENFAP("LOC")]"",'$D(^ENG(6914.9,"B",ENFAP("LOC"))) S ENFAP("LOC")=""
 ;I "^73^74^79^"[(U_ENFAP("LOC")_U) S ENFAP("LOC")=""
 ;I ENFAP("LOC")>83,"^86^88^90^98^99^"'[(U_ENFAP("LOC")_U) S ENFAP("LOC")=""
LOCDN Q ENFAP("LOC")
 ;
GROUP(CSN) ;Accepts CSN and returns FAP GROUP
 N FSC S FSC=$E(CSN,1,4) ;Federal Supply Classification
 I FSC'?4N S ENFAP("GRP")=0 G GRPDUN
 I "7020^7021^7025^7035^7040^7050^7435"[FSC S ENFAP("GRP")=FSC
 E  S ENFAP("GRP")=$E(FSC,1,2)_"00"
GRPDUN Q ENFAP("GRP")
 ;
FACHK ;;
 ;;0;4;Type of Entry
 ;;8;6;General Ledger Account
 ;;2;8;Category Stock Number
 ;;2;9;CMR
 ;;2;4;Acquisition Date
 ;;9;7;Fund
 ;;9;8;A.O. Code
 ;;9;6;Budget Object Code
 ;;2;6;Life Expectancy
 ;;2;3;Acquisition Value
 ;;3;4;Acquitition Method
 ;;9;9;Equity Account
 ;;END
FBCHK ;;
 ;;3;7;Betterment Number
 ;;3;12;Acquisition Method
 ;;6;2;Equity Account
 ;;4;4;Dollar Amount
 ;;END
FCCHK ;;
 ;;3;8;Betterment Number
 ;;END
FDCHK ;;
 ;;5;4;Disposition Method
 ;;5;5;Disposition Year
 ;;5;6;Disposition Month
 ;;5;7;Disposition Day
 ;;5;8;Selling Price
 ;;5;9;Disposition Authority
 ;;END
FRCHK ;;
 ;;3;9;New Fund Code
 ;;3;10;New A.O. Code
 ;;3;11;New Owning Station
 ;;3;12;New Xprogram
 ;;END
