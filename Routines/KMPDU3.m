KMPDU3 ;OAK/RAK - CM Tools Utilities ;7/22/04  09:10
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**2**;Mar 22, 2002
 ;
ERRDATA(KMPDY,KMPDIEN,KMPDGBL) ;-- error log data.
 ;-----------------------------------------------------------------------
 ; KMPDIEN. Ien in format 'multiple,ien'.
 ; KMPDGBL... Global where data is stored.
 ;-----------------------------------------------------------------------
 ;
 K KMPDY
 ;
 I $G(KMPDIEN)="" S @KMPDGBL@(0)="[IEN not defined]" Q
 ;
 I KMPDGBL="" S @KMPDGBL@(0)="[Global for storage is not defined]" Q
 ;
 N DATA,DATA1,I,IEN,IEN1,LN
 ;
 ; kill global with check for ^tmp or ^utility.
 D KILL^KMPDU(.DATA,KMPDGBL)
 ; if error.
 I $E(DATA)="[" S @KMPDGBL@(0)=DATA Q
 ;
 S IEN1=$P(KMPDIEN,",")
 I 'IEN1 S @KMPDGBL@(0)="[IEN1 not defined]" Q
 S IEN=$P(KMPDIEN,",",2)
 I 'IEN S @KMPDGBL@(0)="[IEN not defined]" Q
 ;
 S DATA=$G(^%ZTER(1,IEN,0))
 I DATA="" S @KMPDGBL@(0)="[No data for "_KMPDIEN_"]" Q
 ;
 ; $h date in external format.
 S @KMPDGBL@(0)=$$HTE^XLFDT(+DATA)
 ; error text.
 S @KMPDGBL@(1)=$G(^%ZTER(1,IEN,1,IEN1,"ZE"))
 S @KMPDGBL@(2)="",LN=3
 ; last global reference.
 I $G(^%ZTER(1,IEN,1,IEN1,"GR"))'="" D 
 .S @KMPDGBL@(LN)="Last Global Reference: "_^("GR"),LN=LN+1
 ; $h.
 I $G(^%ZTER(1,IEN,1,IEN1,"H"))'="" D 
 .S @KMPDGBL@(LN)="$H: "_^("H"),LN=LN+1
 S DATA=$G(^%ZTER(1,IEN,1,IEN1,"ECODE"))
 ; $ecode
 S @KMPDGBL@(LN)="$ECODE = "_$P(DATA,U),LN=LN+1
 ; $stack
 S @KMPDGBL@(LN)="$STACK = "_$P(DATA,U,2),LN=LN+1
 ; $estack
 S @KMPDGBL@(LN)="$ESTACK = "_$P(DATA,U,3),LN=LN+1
 ; $quit
 S @KMPDGBL@(LN)="$QUIT = "_$P(DATA,U,4),LN=LN+1
 ; $stack multiple.
 F I=0:0 S I=$O(^%ZTER(1,IEN,1,IEN1,"STACK",I)) Q:'I  D 
 .Q:'$D(^%ZTER(1,IEN,1,IEN1,"STACK",I,0))  S DATA=^(0)
 .S @KMPDGBL@(LN)=$P(DATA,U)_" = "_$P(DATA,U,2)
 .S LN=LN+1
 ; variables and data multiple #10.
 F I=0:0 S I=$O(^%ZTER(1,IEN,1,IEN1,"ZV",I)) Q:'I  D 
 .Q:'$D(^%ZTER(1,IEN,1,IEN1,"ZV",I,0))  S DATA=^(0),DATA1=$G(^("D"))
 .Q:DATA=""
 .S @KMPDGBL@(LN)=DATA_" = "_$E(DATA1,1,225)
 .S LN=LN+1
 ;
 S KMPDY=$NA(@KMPDGBL)
 S:'$D(@KMPDGBL) KMPDY="<No Data To Report>"
 ;
 Q
 ;
ERRDATE(KMPDY,KMPDATE) ;-- get error log date or list all dates
 ;-----------------------------------------------------------------------
 ; KMPDATE... Date in internal fileman format, or "*" for a list of all
 ;            available dates.
 ;
 ;          if one date
 ; KMPDY(0)=ExternalDate^Ien^NumberOfErrors
 ;
 ;          or a list of all available dates
 ; KMPDY(0)=ExternalDate^Ien^NumberOfErrors
 ; KMPDY(1)=ExternalDate^Ien^NumberOfErrors
 ; KMPDY(2)=ExternalDate^Ien^NumberOfErrors
 ; KMPDY(...)=...
 ;-----------------------------------------------------------------------
 ;
 I $G(KMPDATE)="" S KMPDY(0)="[Date entry not defined]" Q
 ;
 I KMPDATE'="*" D  Q
 .; external date
 .S $P(KMPDY(0),U)=$$FMTE^XLFDT(KMPDATE)
 .; set to date portion of $h format
 .S KMPDATE=+$$FMTH^XLFDT(KMPDATE)
 .; ien
 .S $P(KMPDY(0),U,2)=$O(^%ZTER(1,"B",KMPDATE,0))
 .; number of errors
 .S $P(KMPDY(0),U,3)=$P($G(^%ZTER(1,+$P(KMPDY(0),U,2),1,0)),U,3)
 ;
 ; if all entries requested
 I KMPDATE="*" D  Q
 .N DATE,I,LN S (I,LN)=0
 .F  S I=$O(^%ZTER(1,"B",I)) Q:'I  I $D(^%ZTER(1,I,0)) D 
 ..; external date
 ..S $P(KMPDY(LN),U)=$$HTE^XLFDT(I)
 ..; ien
 ..S $P(KMPDY(LN),U,2)=I
 ..; number of errors
 ..S $P(KMPDY(LN),U,3)=$P($G(^%ZTER(1,I,1,0)),U,3)
 ..S LN=LN+1
 ;
 Q
 ;
ROUSAVE(KMPDRES,KMPDRNM,KMPDRCD) ;-- routine save
 ;-----------------------------------------------------------------------
 ; KMPDRNM... Routine name.
 ; KMPDRCD... Array contianing routine code (or text).
 ;-----------------------------------------------------------------------
 ;
 K KMPDRES
 I $G(KMPDRNM)="" S KMPDRES(0)="[Routine Name not defined]" Q
 I $L(KMPDRNM)>8 D  Q
 .S KMPDRES(0)="[Routine Name must not be greater than 8 characters]"
 I '$D(KMPDRCD) D  Q
 .S KMPDRES(0)="[There is no Routine code (text) to save]"
 ;
 N DIE,GLOBAL,I,X,XCN
 S GLOBAL=$NA(^TMP("KMPDU3-1",$J))
 K @GLOBAL
 S I=0
 F  S I=$O(KMPDRCD(I)) Q:'I  S @GLOBAL@(I,0)=KMPDRCD(I)
 S X=KMPDRNM,DIE="^TMP("_"""KMPDU3-1"""_","_$J_",",XCN=0
 X ^%ZOSF("SAVE")
 ;
 S KMPDRES(0)="<Routine Saved>"
 ;
 Q
 ;
ROUSTATS(KMPDRES,KMPDIENS) ;-- routine stats
 ;-----------------------------------------------------------------------
 ; KMPDIENS... Ien(s) for file #8972.1 (CAPMAN ROUTINE STATS).  If more
 ;             than one Ien then each will be seperated by a comma.
 ;             Example: KMPDIENS="12,98,38,123"
 ;
 ; KMPDRES()   Results up-arrow (^) delimited in format:
 ;             Piece 1  - Name..................(field .01)
 ;             Piece 4  - CPU Time..............(field #.04)
 ;             Piece 5  - DIO References........(field #.05)
 ;             Piece 6  - BIO References........(field #.06)
 ;             Piece 7  - Page Faults...........(field #.07)
 ;             Piece 8  - M commands/Lines......(field #.08)
 ;             Piece 9  - Global References.....(field #.09)
 ;             Piece 10 - Count.................(field #.1)
 ;             Piece 14 - Ave CPU Time..........(field #99.04 - computed)
 ;             Piece 15 - Ave DIO References....(field #99.05 - computed)
 ;             Piece 16 - Ave BIO References....(field #99.06 - computed)
 ;             Piece 17 - Ave Page Faults.......(field #99.07 - computed)
 ;             Piece 18 - Ave M Commands/Lines..(field #99.08 - computed)
 ;             Piece 19 - Ave Global References.(field #99.09 - computed)
 ;-----------------------------------------------------------------------
 ;
 K KMPDRES
 I $G(KMPDIENS)="" S KMPDRES(0)="[IEN data not defined]" Q
 ;
 N DATA,I,IEN,J,LN
 ;
 S IEN="",(I,LN)=0
 F I=1:1 S IEN=$P(KMPDIENS,",",I) Q:'IEN  D 
 .Q:'$D(^KMPD(8972.1,IEN,0))  S DATA=^(0)
 .; put second piece (date/time entered) in external format
 .S $P(DATA,U,2)=$$FMTE^XLFDT($P(DATA,U,2))
 .S KMPDRES(LN)=DATA
 .; computed fields
 .F J=4:1:9 S $P(KMPDRES(LN),U,(J+10))=$$GET1^DIQ(8972.1,IEN,(99+(.01*J)))
 .S LN=LN+1
 ;
 S:'$D(KMPDRES) KMPDRES(0)="<No Data to Report>"
 ;
 Q
