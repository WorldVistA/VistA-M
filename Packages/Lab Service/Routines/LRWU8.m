LRWU8 ;DALOI/WPW - TOOL TO FIX ORGANISM SUBFILE AND DATA ;06/06/12  16:06
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;Reference to ^DD supported by ICR# 29 and 999
 ;---------------------------------------------------------------
 ;
 ;Output:
 ;-------
 ; ^TMP("LR",$J,scenario  [for email/report]
 ;
 ; scenario  Description
 ; --------  -----------------------------------------------------
 ; S1........Bad Input Transform found.
 ; S2........Bad Help Text found.
 ; S3........Bad Key found.
 ; S4........Field number is good (ien) so build sensitivity,
 ;           interp & screen definition based on good field
 ;           number, no result data needs updating.
 ; S5........Field number is bad (ien) so delete bad  definitions,
 ;           build new sensitivity, interp & screen definitions
 ;           and update results data as needed.
 ; S6........Everything left over that could not be
 ;           programmatically corrected.
 ;
 ;---------------------------------------------------------------
EN ; Interactive entry point.
 ;
 N FIX,INSTALL,LR,LRSITE,LRSUBFIL,LRTYPE,NBR,TSTR,XMDUZ,XMY
 ;
 I '$D(^XUSEC("LRLIASON",DUZ)) D  Q
 .W !,"You do not have the LRLIASON key which is required to"
 .W " run this tool.",*7
 ;
 S FIX=$$ASK^LRWU8A(),INSTALL=0
 ;
 I 'FIX Q
 ;
 S FIX=FIX-1   ;FIX=0: Analyze, FIX=1: Analyze and Fix.
 ;
 S XMDUZ=DUZ,XMY(DUZ)=""
 D DES^XMA21    ; call to get the email recipients list.
 ;
 D PREP^XGF     ; setup screen
 ;
 D INIT,SORT,DISCARD,ANALYZE,FIX0,FIX5,FIX1,FIX2,FIX3,FIX4
 D SEND^LRWU8A  ; send email/report
 D CLEAN^XGF    ; reset screen
 ;
 K ^TMP(LR,$J)
 ;
 Q
 ;---------------------------------------------------------------
KIDS ; Entry point for post install run.
 ;
 N FIX,INSTALL,LR,LRSITE,LRSUBFIL,LRTYPE,NBR,XMY
 ;
 I $$PROD^XUPROD(),$G(^XMB("NETNAME"))["DOMAIN.EXT" S XMY("G.LAB DEV IRMFO@DOMAIN.EXT")="",XMY("G.CSCLIN4@DOMAIN.EXT")=""
 S XMY(DUZ)="",XMY("G.LMI")="",FIX=0,INSTALL=1   ;[ccr-8167]
 ;
 D INIT,SORT,DISCARD,ANALYZE,FIX0,FIX5,FIX1,FIX2,FIX3,FIX4
 D SEND^LRWU8A  ; send email/report
 ;
 K ^TMP(LR,$J)
 ;
 Q
 ;---------------------------------------------------------------
LRNIGHT ; Entry point for ^LRNIGHT run.
 ;
 N FIX,INSTALL,LR,LRSITE,LRSUBFIL,LRTYPE,NBR,XMY
 ;
 I $$PROD^XUPROD(),$G(^XMB("NETNAME"))["DOMAIN.EXT" S XMY("G.LAB DEV IRMFO@DOMAIN.EXT")="",XMY("G.CSCLIN4@DOMAIN.EXT")=""
 S (XMY(DUZ),XMY("G.LMI"))="",FIX=0,INSTALL=1
 ;
 D INIT,SORT,DISCARD,ANALYZE,FIX0,FIX5,FIX1,FIX2,FIX3,FIX4
 I $D(^TMP(LR,$J)) D SEND^LRWU8A  ; send email/report
 ;
 K ^TMP(LR,$J)
 ;
 Q
 ;---------------------------------------------------------------
INIT ; Initialize variables and such...
 ;
 D DT^DICRW   ; load fileman variables.
 ;
 S LRTYPE=1,LR="LR",LRSITE=$$STA^XUAF4($$KSP^XUPARAM("INST"))
 S NBR="2.00"_LRSITE,LRSUBFIL=63.3,DT=$$DT^XLFDT
 ;
 ; Ignore fields inadvertently distributed by a previous Lab patch from
 ; a development account to some VA sites during patch testing.
 ; These fields were name spaced under site number 170 and 600.
 S TSTR=""
 I $E(LRSITE,1,3)'=170 S TSTR=TSTR_"|2.00170001|2.00170002|2.00170003|2.00170004|2.00170005"
 I $E(LRSITE,1,3)'=600 S TSTR=TSTR_"|2.00600001|2.00600002|2.00600003|2.00600004|2.00600005|2.00600006|2.00600007"
 S TSTR=TSTR_"|"
 ;
 K ^TMP(LR,$J)
 ;
 Q
 ;---------------------------------------------------------------
SORT ; Sort Antibiotics fields: 1-Sensitivity, 2-Interp & 3-Screen.
 ;
 ; Input: None.
 ;
 ;Output: ^TMP(LR,$j,"SORT", = field number sort + 1, 2 and/or 3
 ;        ^TMP(LR,$j,"S1",ien) = bad input transform
 ;        ^TMP(LR,$j,"S2",ien) = bad help text
 ;        ^TMP(LR,$j,"S3",ien) = bad key
 ;-----
 N D0,DATA,HELP,IT,KEY,NKEY
 ;
 S NKEY="A:ALWAYS DISPLAY;N:NEVER DISPLAY;R:RESTRICT DISPLAY;"
 ;
 S D0=""
 F  S D0=$O(^DD(63.3,D0)) Q:D0=""  D:$D(^DD(63.3,D0,0))
 .S DATA=$G(^DD(63.3,D0,0)) Q:DATA=""
 .I +$P(DATA,U,4)<2 Q
 .I +$P(DATA,U,4)>2.99999999 Q
 .S IT=$P(DATA,U,5,99),HELP=$G(^DD(63.3,D0,4)),KEY=$P(DATA,U,3)
 .I $P($P(DATA,U,4),";",2)=1 D
 ..I IT'="D ^LRMISR" D
 ...S ^TMP(LR,$J,"S1",D0)=IT_"|D ^LRMISR"
 ..I HELP'="D EN^LRMISR" D
 ...S ^TMP(LR,$J,"S2",D0)=HELP_"|D EN^LRMISR"
 .I $P($P(DATA,U,4),";",2)=2 D
 ..I IT'="D INT^LRMISR" D
 ...S ^TMP(LR,$J,"S1",D0)=IT_"|D INT^LRMISR"
 ..I HELP'="D HINT^LRMISR" D
 ...S ^TMP(LR,$J,"S2",D0)=HELP_"|D HINT^LRMISR"
 .I $P($P(DATA,U,4),";",2)=3 D
 ..I IT'="Q" D
 ...S ^TMP(LR,$J,"S1",D0)=IT_"|Q"
 ..I KEY'=NKEY D
 ...S ^TMP(LR,$J,"S3",D0)=KEY_"|"_NKEY
 .S ^TMP(LR,$J,"SORT",+$P(DATA,U,4),$P($P(DATA,U,4),";",2))=D0
 ;
 Q
 ;---------------------------------------------------------------
DISCARD ; Discard Antibiotic if all 3 tests are defined.
 ;
 ; Input: ^TMP(LR,$J,"SORT"
 ;
 ;Output: ^TMP(LR,$J,"SORT"
 ;-----
 N CNT,DATA,LRX,LRFLD
 ;
 S (LRX,LRFLD)=""
 F  S LRFLD=$O(^TMP(LR,$J,"SORT",LRFLD)) Q:LRFLD=""  D
 .F CNT=0:1 S LRX=$O(^TMP(LR,$J,"SORT",LRFLD,LRX)) Q:LRX=""  D
 ..S DATA=^TMP(LR,$J,"SORT",LRFLD,LRX)
 .;
 .; Ignore fields inadvertently distributed by a previous Lab patch from
 .; a development account to some VA sites during patch testing.
 .; These fields were name spaced under site number 170 and 600.
 .I CNT=3,TSTR'[("|"_LRFLD_"|") K ^TMP(LR,$J,"SORT",LRFLD) Q
 .S ^TMP(LR,$J,"SORT",LRFLD)=CNT_U_DATA
 ;
 Q
 ;---------------------------------------------------------------
ANALYZE ; Check ^LR for entries after discard.
 ;
 ; Input: ^TMP(LR,$J,"SORT"
 ;
 ;Output: ^TMP(LR,$J,"CNT",LRFLD = total result entries for ien
 ;-----
 I '$D(^TMP(LR,$J,"SORT")) Q
 ;
 N CNT,D2,LRFLD,LRDFN,LRIDT
 ;
 S (LRDFN,LRIDT,D2,LRFLD)=""
 F CNT=1:1 S LRDFN=$O(^LR(LRDFN)) Q:LRDFN=""  D
 .I 'INSTALL D
 ..I (CNT#1000)=1 D SAY^XGF(24,1,"Analyzing LRDFN: "_LRDFN)
 .I '$D(^LR(LRDFN,"MI")) Q
 .F  S LRIDT=$O(^LR(LRDFN,"MI",LRIDT)) Q:LRIDT=""  D
 ..I '$D(^LR(LRDFN,"MI",LRIDT,3)) Q
 ..F  S D2=$O(^LR(LRDFN,"MI",LRIDT,3,D2)) Q:D2=""  D
 ...F  S LRFLD=$O(^TMP(LR,$J,"SORT",LRFLD)) Q:LRFLD=""  D
 ....I '$D(^LR(LRDFN,"MI",LRIDT,3,D2,LRFLD)) Q
 ....S ^TMP(LR,$J,"CNT",LRFLD)=$G(^TMP(LR,$J,"CNT",LRFLD))+1
 ;
 Q
 ;---------------------------------------------------------------
FIX0 ; Cleanup non data leftover fields from previous patches.
 ;
 ; Input: ^TMP(LR,$J,"SORT"
 ;
 ;Output: None
 ;-----
 I '$D(^TMP(LR,$J,"SORT")) Q
 ;
 N CNT,DA,DIK,LRFLD,LRTNODE,PCE
 ;
 F PCE=2:1 S LRFLD=$P(TSTR,"|",PCE) Q:LRFLD=""  D
 .I +$G(^TMP(LR,$J,"CNT",LRFLD)) D  Q
 ..I +$G(^TMP(LR,$J,"SORT",LRFLD))=3 D
 ...K ^TMP(LR,$J,"SORT",LRFLD),^TMP(LR,$J,"CNT",LRFLD)
 .;
 .F CNT=1:1:3 I $D(^TMP(LR,$J,"SORT",LRFLD,CNT)) D
 ..S DA=^TMP(LR,$J,"SORT",LRFLD,CNT)
 ..S DA(1)=LRSUBFIL,DIK="^DD("_DA(1)_","
 ..I FIX D ^DIK
 ..F LRTNODE="S1","S2","S3" K ^TMP(LR,$J,LRTNODE,DA)
 .;
 .K ^TMP(LR,$J,"SORT",LRFLD)
 ;
 Q
 ;---------------------------------------------------------------
FIX1 ; Cleanup the bad Input Transforms, Help Text and Input Keys.
 ;
 ; Input: ^TMP(LR,$J,"S1"  <= input transforms
 ;        ^TMP(LR,$J,"S2"  <= help text
 ;        ^TMP(LR,$J,"S3"  <= input keys
 ;
 ;Output: None
 ;-----
 I 'FIX Q
 I '$D(^TMP(LR,$J,"S1")),'$D(^TMP(LR,$J,"S2")),'$D(^TMP(LR,$J,"S3")) Q
 ;
 N DATA,LRFLD,NEW
 ;
 S LRFLD=""
 F  S LRFLD=$O(^TMP(LR,$J,"S1",LRFLD)) Q:LRFLD=""  D
 .S DATA=^DD(63.3,LRFLD,0),NEW=$P(^TMP(LR,$J,"S1",LRFLD),"|",2)
 .S ^DD(63.3,LRFLD,0)=$P(DATA,U,1,4)_U_NEW
 .S ^DD(63.3,LRFLD,"DT")=DT
 ;
 F  S LRFLD=$O(^TMP(LR,$J,"S2",LRFLD)) Q:LRFLD=""  D
 .S ^DD(63.3,LRFLD,4)=$P(^TMP(LR,$J,"S2",LRFLD),"|",2)
 .S ^DD(63.3,LRFLD,"DT")=DT
 ;
 F  S LRFLD=$O(^TMP(LR,$J,"S3",LRFLD)) Q:LRFLD=""  D
 .S DATA=^DD(63.3,LRFLD,0),NEW=$P(^TMP(LR,$J,"S3",LRFLD),"|",2)
 .S ^DD(63.3,LRFLD,0)=$P(DATA,U,1,2)_U_NEW_U_$P(DATA,U,4,99)
 .S ^DD(63.3,LRFLD,"DT")=DT
 ;
 Q
 ;---------------------------------------------------------------
FIX2 ; If no ^LR data found kill any 2 & 3 positions from ^DD(63.3
 ;    (2=interp & 3=screen) based on the ANALYZE sub findings.
 ;
 ; Input: ^TMP(LR,$J,"SORT"
 ;
 ;Output: None
 ;
 ;-----
 I '$D(^TMP(LR,$J,"SORT")) Q
 ;
 N CNT,LRFLD,D1,DA,DIK,LRNUM,LRNAME,LR6206
 ;
 S (LRFLD,D1)=""
 F  S LRFLD=$O(^TMP(LR,$J,"SORT",LRFLD)) Q:LRFLD=""  D
 .S LRNUM=$G(^TMP(LR,$J,"SORT",LRFLD,1))
 .S LRNAME=$P($G(^DD(63.3,+LRNUM,0)),U)
 .I $D(^TMP(LR,$J,"SORT",LRFLD,1)),LRNAME'[" INTERP",LRNAME'[" SCREEN" Q
 .S LR6206=$O(^LAB(62.06,"AD",LRFLD,""))
 .I LR6206 Q
 .I '$D(^TMP(LR,$J,"CNT",LRFLD)) D
 ..F CNT=1,2,3 I $D(^TMP(LR,$J,"SORT",LRFLD,CNT)) D
 ...S DA=^TMP(LR,$J,"SORT",LRFLD,CNT)
 ...S DA(1)=LRSUBFIL,DIK="^DD("_DA(1)_","
 ...I FIX D ^DIK
 ...K ^TMP(LR,$J,"SORT",LRFLD,CNT)
 ..F CNT=0:1 S D1=$O(^TMP(LR,$J,"SORT",LRFLD,D1)) Q:D1=""
 ..I 'CNT K ^TMP(LR,$J,"SORT",LRFLD)
 ..E  S $P(^TMP(LR,$J,"SORT",LRFLD),U)=CNT
 ;
 Q
 ;---------------------------------------------------------------
FIX3 ; Fix 1 and 1,2 and 1,3 DD entries, leaving 2 and 3 and 2,3
 ;
 ; Input: ^TMP(LR,$J,"SORT"
 ;
 ;Output: ^TMP(LR,$J,"S4",ien1) = ien2 ^ ien3
 ;
 ;    [where: ien1 = ^DD(63.3,ien1 (for the sensitivity)
 ;            ien2 = ^DD(63.3,ien2 (for the interp)
 ;            ien3 = ^DD(63.3,ien3 (for the screen)]
 ;
 ;        ^TMP(LR,$J,"S5",ien) = ien1 ^ ien2 ^ ien3 ^ cnt
 ;
 ;    [where:  ien = old ^DD(63.3,ien (for old sensitivity)
 ;            ien1 = ^DD(63.3,ien1    (for the sensitivity)
 ;            ien2 = ^DD(63.3,ien2    (for the interp)
 ;            ien3 = ^DD(63.3,ien3    (for the screen)
 ;             cnt = total # of ^LR's that has been updated]
 ;-----
 I '$D(^TMP(LR,$J,"SORT")) Q
 ;
 N CNT,DATA,LRFLD,DA,DIK,LR6206,LRFDA,LRNAME,LRNAME1,LRNAME2
 N LRNUM,LRNUM1,LRNUM2
 ;
 S LRFLD=""
 F  S LRFLD=$O(^TMP(LR,$J,"SORT",LRFLD)) Q:LRFLD=""  D
 .S LR6206=$O(^LAB(62.06,"AD",LRFLD,""))
 .I $D(^TMP(LR,$J,"SORT",LRFLD,1)) D
 ..S LRNUM=^TMP(LR,$J,"SORT",LRFLD,1)
 ..;
 ..; index and field match & are correct format.
 ..;
 ..I LRFLD=LRNUM,$E(LRNUM,1,$L(NBR))=NBR D  Q
 ...S LRNUM1=LRNUM+.000000001,LRNUM2=LRNUM+.000000002
 ...S LRNAME=$P(^DD(63.3,LRNUM,0),U)
 ...I LRNAME[" INTERP"!(LRNAME[" SCREEN") Q
 ...S LRNAME1=LRNAME_" INTERP",LRNAME2=LRNAME_" SCREEN"
 ...I FIX D
 ....S DA(1)=LRSUBFIL,DIK="^DD("_DA(1)_","
 ....F DA=LRNUM,LRNUM1,LRNUM2 D ^DIK
 ....D SETFLDS^LRWU7
 ...S ^TMP(LR,$J,"S4",LRNUM)=LRNUM1_U_LRNUM2
 ...K ^TMP(LR,$J,"SORT",LRFLD)
 ..;
 ..; index and field don't match & are incorrect format.
 ..;
 ..I $E(LRNUM,1,$L(NBR))'=NBR D  Q
 ...S LRNAME=$P(^DD(63.3,LRNUM,0),U)
 ...I LRNAME[" INTERP"!(LRNAME[" SCREEN") Q
 ...S LRNAME1=LRNAME_" INTERP",LRNAME2=LRNAME_" SCREEN"
 ...D NUMBER^LRWU7
 ...S DA=^TMP(LR,$J,"SORT",LRFLD,1)
 ...S DA(1)=LRSUBFIL,DIK="^DD("_DA(1)_","
 ...I FIX D
 ....D SETFLDS^LRWU7
 ....I LR6206]"" D
 .....S LRFDA(62.06,LR6206_",",5)=LRNUM
 .....D FILE^DIE(,"LRFDA")
 .....;
 .....D UPD624(LR6206,LRNUM) ; Update Auto Instrument File with new Drug Node
 ....F CNT=3,2,1 I $D(^TMP(LR,$J,"SORT",LRFLD,CNT)) D
 .....S DA=^TMP(LR,$J,"SORT",LRFLD,CNT) D ^DIK
 ...S CNT=+$G(^TMP(LR,$J,"CNT",LRFLD))
 ...K ^TMP(LR,$J,"CNT",LRFLD)
 ...S ^TMP(LR,$J,"S5",DA)=LRNUM_U_LRNUM1_U_LRNUM2_U_CNT
 ...K ^TMP(LR,$J,"SORT",LRFLD)
 ...S ^TMP(LR,$J,"SORT",LRFLD,"NEW")=LRNUM
 ;
 Q
 ;---------------------------------------------------------------
FIX4 ; Cleanup the ^LR entries for single DD's.
 ;
 ; Input: ^TMP(LR,$J,"SORT"
 ;
 ;Output: ^TMP(LR,$J,"S6",ien) = "" [where:  ien = ^DD(63.3,ien]
 ;-----
 I '$D(^TMP(LR,$J,"SORT")) Q
 ;
 N CNT,D2,LRFLD,DA,DIK,LRDFN,LRIDT,LRN,LRNUM
 ;
 S (LRDFN,LRIDT,D2)=""
 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN=""  D
 .I '$D(^LR(LRDFN,"MI")) Q
 .F  S LRIDT=$O(^LR(LRDFN,"MI",LRIDT)) Q:LRIDT=""  D
 ..S D2=""
 ..F  S D2=$O(^LR(LRDFN,"MI",LRIDT,3,D2)) Q:D2=""!(D2'?.N)  D
 ...S LRFLD=2
 ...F  S LRFLD=$O(^LR(LRDFN,"MI",LRIDT,3,D2,LRFLD)) Q:LRFLD=""!(LRFLD>3)  D
 ....I '$D(^TMP(LR,$J,"SORT",LRFLD,"NEW")) Q
 ....S LRN=^TMP(LR,$J,"SORT",LRFLD,"NEW")
 ....I FIX D
 .....I 'INSTALL D
 ......D SAY^XGF(24,1,"Repairing LRDFN: "_LRDFN_" LRIDT: "_LRIDT)
 .....M ^LR(LRDFN,"MI",LRIDT,3,D2,LRN)=^LR(LRDFN,"MI",LRIDT,3,D2,LRFLD)
 .....K ^LR(LRDFN,"MI",LRIDT,3,D2,LRFLD)
 .....D UPDATE^LRPXRM(LRDFN,"MI",LRIDT) ;Update Clinical Reminders Index
 ;
 ; Move all non-programatically fixed data to Scenario 6 (S6).
 ;
 S (D2,LRFLD)=""
 F  S D2=$O(^TMP(LR,$J,"SORT",D2)) Q:D2=""  D
 .F  S LRFLD=$O(^TMP(LR,$J,"SORT",D2,LRFLD)) Q:LRFLD=""  D
 ..I LRFLD="NEW" K ^TMP(LR,$J,"SORT",D2,LRFLD) Q
 ..S DA=^TMP(LR,$J,"SORT",D2,LRFLD)
 ..S ^TMP(LR,$J,"S6",DA)=""
 .K ^TMP(LR,$J,"SORT",D2)
 ;
 ; Remove S1,S2 and/or S3 entries that do not have
 ; associated DD entries.
 ;
 S LRFLD=""
 F D2="S1","S2","S3" D:$D(^TMP(LR,$J,D2))
 .F  S LRFLD=$O(^TMP(LR,$J,D2,LRFLD)) Q:LRFLD=""  D
 ..I '$D(^DD(63.3,LRFLD)) K ^TMP(LR,$J,D2,LRFLD)
 ;
 Q
 ;---------------------------------------------------------------
FIX5 ; Ensure that the fix entry is an ANTIBIOTIC NAME instead of an
 ; INTERP or SCREEN.
 ;
 ; Input: ^TMP(LR,$J,"S1"  <= input transforms
 ;        ^TMP(LR,$J,"S2"  <= help text
 ;        ^TMP(LR,$J,"S3"  <= input keys
 ;
 ;Output: None
 ;-----
 N TYPE,LRFLD,DATA,DA,DIK
 ;
 F TYPE="S1","S2","S3" D
 .S LRFLD=""
 .F  S LRFLD=$O(^TMP(LR,$J,TYPE,LRFLD)) Q:LRFLD=""  D
 ..S DATA=$G(^DD(63.3,LRFLD,0))
 ..I $P($P(DATA,U,4),";",2)=1 D
 ...I $P(DATA,U)[" INTERP"!($P(DATA,U)[" SCREEN") K ^TMP(LR,$J,TYPE,LRFLD)
 ..I $P($P(DATA,U,4),";",2)=2 D
 ...I $P(DATA,U)'[" INTERP" K ^TMP(LR,$J,TYPE,LRFLD)
 ..I $P($P(DATA,U,4),";",2)=3 D
 ...I $P(DATA,U)'[" SCREEN" K ^TMP(LR,$J,TYPE,LRFLD)
 Q
 ;
 ;---------------------------------------------------------------
 ;
UPD624(LR6206,LRNDRGND) ; Update Drug Node in Auto Instrument File
 ;
 ; Input:
 ;     LR6206 - IEN in Antimicrobial Susceptibility File (#62.06)
 ;   LRNDRGND - The new Drug Node
 ;
 ; Output: None
 ;
 N LR624,LR6243,LR6246,LRDRUG
 ;
 S LR624=0 F  S LR624=$O(^LAB(62.4,LR624)) Q:'LR624  D
 . ;
 . S LR6243=0 F  S LR6243=$O(^LAB(62.4,LR624,7,LR6243)) Q:'LR6243  D
 . . ;
 . . S LR6246=0 F  S LR6246=$O(^LAB(62.4,LR624,7,LR6243,2,LR6246)) Q:'LR6246  D
 . . . ;
 . . . S LRDRUG=$P($G(^LAB(62.4,LR624,7,LR6243,2,LR6246,0)),U,1)
 . . . ;
 . . . I LRDRUG'=LR6206 Q
 . . . ;
 . . . N LRFDA,LRIENS
 . . . S LRIENS=LR6246_","_LR6243_","_LR624_","
 . . . S LRFDA(62.46,LRIENS,1)=LRNDRGND
 . . . D FILE^DIE("","LRFDA")
 ;
 Q
