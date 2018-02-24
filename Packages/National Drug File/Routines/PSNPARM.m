PSNPARM ;BIR/SJA-PPS-N Site Parameters ; 11/16/2016
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;
 ;Reference to ^PS(59.7 supported by DBIA #2613
 ;Reference to ^VA(200 supported by DBIA #10060
 ;Reference to ^XUSEC supported by DBIA #10076
 ;Reference to ^ORD(101 supported by DBIA #872
 ;Reference to ^DIC(19.2 supported by DBIA #1472
 ;Reference to ^DIC(19 supported by DBIA #2246
 ;
EN ; -- option entry point
 N CURLEY,FLDS,LN,PSNAR,PSNLCK,PSNNOW,PSNNOW1,PSNOUT,PSNTAG,PSNUSER,PSNX,SHEMP,TYPE,X,XX,Y,Z
 N NODE0,NODE1,NODE2,NOD597,PSNFLD,PSNJ,PSNZ,REQFLDS,IORVON,IORVOFF
 S PSNOUT=0,REQFLDS="^3^4^5^6^7^10^11^12^13^"
 S X="IORVON;IORVOFF" D ENDR^%ZISS
 ;
ASK ; -- screen display
 G:PSNOUT END D DISP
 W !!,"Select field number to Edit: " R X:DTIME I '$T!("^"[X) S PSNOUT=1 G END
 S X=$S(X="a":"A",1:X) I '$D(PSNAR(X)),(X'?.N1":".N),(X'="A") D HELP G:PSNOUT END G ASK
 I X="A" S X="1:14"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>14)!(Y>Z) D HELP G:PSNOUT END G ASK
 D HDR
 I X?.N1":".N D RANGE G ASK
 I $D(PSNAR(X)) S FLDS=X W ! D  G ASK
 .I $$LOCK W ! D ONE,UNLOCK
 ;
END ; -- kill variables and quit
 W @IOF
 K CURLEY,FLDS,LN,PSNAR,PSNLCK,PSNNOW,PSNNOW1,PSNOUT,PSNTAG,PSNUSER,PSNX,SHEMP,TYPE,X,Y,Z
 K NODE0,NODE1,NODE2,NOD597,PSNFLD,PSNJ,PSNZ,REQFLDS
 Q
RANGE ; -- range of numbers
 I $$LOCK D  D UNLOCK
 .W !! S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F FLDS=SHEMP:1:CURLEY Q:PSNOUT  D ONE
 Q
ONE ; -- edit one item
 I FLDS=14 D DISOPTS^PSNPPSNR Q
 I REQFLDS[("^"_FLDS_"^"),'$D(^XUSEC("PSN PPS COORD",DUZ)) D ERR Q
 I FLDS=4,($P($G(^PS(57.23,1,0)),"^",4)="") D RDIR
 K DR,DIE,DA S DA=1,DR=$P(PSNAR(FLDS),"^",3)_"T",DIE=$P(PSNAR(FLDS),"^",2) D ^DIE K DR,DA I $D(Y) S PSNOUT=1
 I FLDS=7 W !!,"Press <RET> to continue, or '^' to quit  ",$C(7) R XX:DTIME I '$T!(XX["^") S PSNOUT=1
 I FLDS=10,($P(^PS(57.23,1,0),"^",10)="Y"&("QN"[($P(^PS(59.7,1,10),"^",12)))) D
 . S $P(^PS(57.23,1,0),"^",10)="N" S FLDS=11,$P(PSNAR(11),"^")="NO" G ONE
 Q
HDR ; -- print screen header
 S $P(LN,"-",80)="" W @IOF,!
 W !,"Pharmacy Product System-National(PPS-N) Site Parameters",!,LN,!
 Q
LOCK() ; -- apply incremental lock
 N PSNNOW,PSNNOW1,PSNTAG
 S PSNNOW=$$NOW^XLFDT,PSNNOW1=$$FMADD^XLFDT(PSNNOW,,2)
 S PSNLCK=1,PSNTAG=""
 L +^XTMP("PSNPARM"):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3)
 E  D L1 S PSNLCK=0 Q PSNLCK
 D:PSNLCK XTMP
 Q PSNLCK
 ;
UNLOCK() ; -- apply decremental lock
 L -^XTMP("PSNPARM")
 K ^XTMP("PSNPARM")
 Q
XTMP S ^XTMP("PSNPARM",0)=PSNNOW1_"^"_PSNNOW_"^PSN Site Parameters Lock"_PSNTAG_"^"_$J,^XTMP("PSNPARM",$J,DUZ)=""
 Q
L1 S PSNX="",PSNUSER="Another person",PSNX=$O(^XTMP("PSNPARM",$J,0))
 I PSNX S PSNUSER=$P($G(^VA(200,PSNX,0)),"^")
 D EN^DDIOL(PSNUSER_" is editing the PPS-N site Parameters. Please try again later.","","!,$C(7)") H 3
 Q
DISP ; -- displays parameters
 S $P(LN,"-",80)="" D HDR
 S NODE0=$G(^PS(57.23,1,0)),NODE1=$G(^PS(57.23,1,1)),NODE2=$G(^PS(57.23,1,2))
 S NOD597=$G(^PS(59.7,1,10)),TYPE=$S($P(NOD597,"^",12)]"":$P(NOD597,"^",12),1:"")
 I TYPE]"" S TYPE=TYPE_" - "_$S(TYPE="Q":"National SQA Testing",TYPE="P":"Production",TYPE="T":"Test Account",TYPE="S":"Product Support",TYPE="N":"QA NDFMS",1:"")
 F PSNJ=1:1 S PSNFLD=$P($T(FIELD+PSNJ),";;",2) Q:PSNFLD=""!(PSNFLD="END")  S PSNZ(PSNJ)=$P(PSNFLD,"^",2)
 S PSNAR(1)=$P(NODE0,"^",3)_"^57.23^2",PSNAR(2)=$P(NODE0,"^",7)_"^57.23^8"
 S PSNAR(3)=$P(NODE0,"^",2)_"^57.23^1",PSNAR(4)=$P(NODE0,"^",4)_"^57.23^3",PSNAR(5)=$P(NODE2,"^")_"^57.23^20"
 S PSNAR(6)=$P(NODE2,"^",2)_"^57.23^21",PSNAR(7)=$P(NODE2,"^",3)_"^57.23^22"
 S PSNAR(8)=$P(NODE0,"^",6)_"^57.23^5",PSNAR(9)=$P(NODE1,"^")_"^57.23^6",PSNAR(10)=TYPE_"^59.7^17"
 S PSNAR(11)=$S($P(NODE0,"^",10)="Y":"YES",$P(NODE0,"^",10)="N":"NO",1:"")_"^57.23^45"
 S PSNAR(12)=$S($P(NODE0,"^",8)="Y":"IN PROGRESS",1:"NOT IN PROGRESS")_"^57.23^9"
 S PSNAR(13)=$S($P(NODE0,"^",9)="Y":"IN PROGRESS",1:"NOT IN PROGRESS")_"^57.23^10"
 S PSNAR(14)=IORVON_$S($$DISBL():"<DATA>",1:"")_IORVOFF
 F PSNJ=1:1 Q:'$D(PSNZ(PSNJ))  W !,$$RJ^XLFSTR((PSNJ_"."),3," ")," ",$S(REQFLDS[("^"_PSNJ_"^"):"*",1:" "),PSNZ(PSNJ),?33,": ",$P(PSNAR(PSNJ),"^")
 W !,LN
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"An '*' (asterisk) before the field indicates that an additional security key is required."
 W !!,"1. Enter 'A' to update all information."
 W !!,"2. Enter a specific number to update the information in that field.  (For",!,"   example, enter '1' to Update File Version Counter)"
 W !!,"3. Enter a range of numbers separated by a ':' to enter a range of",!,"   information.  (For example, enter '1:3' to enter PPS-N Install Version,",!,"   PPS-N Download Version, and Open VMS Local Directory.)"
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S PSNOUT=1
 Q
ERR ; -- display error message
 W !,PSNZ(FLDS)," :",$P(PSNAR(FLDS),"^"),!
 W !,"Security key 'PSN PPS COORD' is required for editing this field."_$C(7)
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S PSNOUT=1 Q
 W !!
 Q
DISBL() ; -- check for out of order scheduled option/menu option/protocol
 N X,I,ICNT,ND,SOPT K ^TMP("PSN PPSN PARSED",$J)
 S ICNT=0 F ND="3:19.2","3.1:19","3.2:101" D
 .S X=0 F  S X=$O(^PS(57.23,1,+ND,"B",X)) Q:'X  S I=0 F  S I=$O(^PS(57.23,1,+ND,"B",X,I)) Q:'I  D
 ..S SOPT=$$GET1^DIQ($P(ND,":",2),X,.01,"E") S:SOPT'="" ICNT=ICNT+1,^TMP("PSN PPSN PARSED",$J,SOPT,ICNT)=I
 I $D(^TMP("PSN PPSN PARSED",$J)) K ^TMP("PSN PPSN PARSED",$J) Q 1
 Q 0
 ;
RDIR ; -- recomended Unix dirrectory
 N RUXDIR S RUXDIR=""
 S RUXDIR=$$LXDIR() I RUXDIR="" Q
 W !,"*** The recommended Unix/Linux Local Directory is ",RUXDIR,$C(7),!
 Q
UNXLDIR ; -- Unix/Linux Local Directory
 N UNXLD,NDIR,DIR,DUOUT,DTOUT
 I $$OS^%ZOSV()'="UNIX" Q
 I $$UP^XLFSTR($$VERSION^%ZOSV(1))'["CACHE" Q
 I $G(X)'="",$E(X,$L(X))'="/" S X=X_"/"
 S UNXLD=X
 I UNXLD'="",'$$DIREXIST^PSNFTP2(UNXLD) W ! D
 . S DIR("A",1)="The directory above could not be found.",DIR("A",2)=""
 . S DIR("A")="Would you like to create it now",DIR(0)="Y",DIR("B")="N"
 . D ^DIR I $G(DTOUT)!$G(DUOUT)!'Y S X=UNXLD W ! Q
 . S X=UNXLD
 . D MAKEDIR^PSNFTP2(UNXLD) S NDIR=1 W !
 . I '$$DIREXIST^PSNFTP2(UNXLD) D
 . . W !!,"Warning: "_$S($G(NDIR):"The directory could not be created.",1:"The directory could not be found and is required for PPSN update file download."),!,$C(7)
 . . K DIR S DIR(0)="FOA",DIR("A")="  Press <RET> to continue, or '^' to quit " D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S PSNOUT=1
 Q
 ;
LXDIR() ; -- Returns the Linux Directory for PPSN sFTP
 N CURDIR,ROOTDIR
 I $$OS^%ZOSV()'="UNIX" Q ""
 I $$UP^XLFSTR($$VERSION^%ZOSV(1))'["CACHE" Q ""
 ; Retrieving the current directory
 X "S CURDIR=$ZU(12)" S ROOTDIR=$P(CURDIR,"/",1,4)
 I $E(ROOTDIR,$L(ROOTDIR))="/" S $E(ROOTDIR,$L(ROOTDIR))=""
 Q ROOTDIR_"/user/sftp/PPSN/"
 ;
SCR(Y) ; -- screen entry to the Legacy Update Processing field
 N TYPE,OK
 S TYPE=$P(^PS(59.7,1,10),"^",12),OK=1
 I "QN"[TYPE,Y="Y" S OK=0
 Q OK
 ;
STRIP(X) ; strip control chrs and any other invalid characters
 N II,YY,CHR
 ; remove control characters & special chars
 S YY="" F II=1:1:$L(X) I $A(X,II)>31 S YY=YY_$E(X,II)
 S CHR="!#%&*)({} " F II=1:1:$L(CHR) I YY[$E(CHR,II) S YY=$$STRIP^XLFSTR(YY,$E(CHR,II))
 Q YY
 ;
FIELD ; -- field name
 ;;1^PPS-N Install Version
 ;;2^PPS-N Download Version
 ;;3^Open VMS Local Directory
 ;;4^Unix/Linux Local Directory
 ;;5^Remote Server Address
 ;;6^Remote Server Directory
 ;;7^Remote SFTP Username
 ;;8^Primary PPS-N Mail Group
 ;;9^Secondary PPS-N Mail group
 ;;10^PPS-N Account Type
 ;;11^Legacy Update Processing
 ;;12^Download Status
 ;;13^Install Status
 ;;14^Disable Menus, Options, etc
 ;;END
