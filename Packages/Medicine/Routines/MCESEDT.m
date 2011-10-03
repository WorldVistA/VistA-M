MCESEDT ;WISC/DCB-ELECTRONIC SIGNATURE PART 1 ; 2/6/03 9:15am
 ;;2.3;Medicine;**18,37**;09/13/1996
 ;
 ;
POST(MCFILE,MCREC) ;Get the info about screen and set-up for edit.
 Q:'MCESON
 D ENS^%ZISS
 N ERROR,HDUZ,HOLD,LOOP,MDAT1,MDAT2,NAME,REC,NEWREC,NEWST,ORG,PROV,RNV,SCRAMBLE,SREC,STATUS,TDATE,TEMP,TEMP1,TY,X1,XDUZ,NCHANGE,LINE,XDATE,DIE,DA,DR,CREAT,SUP,DJDN,CODE,CDUZ,EE,DTOUT,DUOUT,DIRUT,DIROUT
 S RNV=+$P($G(^MCAR(697.2,MCARGNUM,0)),U,17)
 S ERROR=0,REC=MCREC,NCHANGE=0,(ORG,TEMP)=$G(^MCAR(MCFILE,REC,"ES")),EXIT=0,CODE=$P(TEMP,U,7),PROV=$$ESTONUM1^MCESSCR(CODE),$P(LINE,"_",80)="",MCESPED=TEMP,SUP="" K NEWST
 S LOOP=PROV
 I $P(TEMP,U,5)="" S XDUZ=1
 ;I CODE<3,($P(ORG,U,1)="") S $P(TEMP,U,1)=DUZ,$P(ORG,U,1)=DUZ
 I PROV<3,($P(ORG,U,1)="") S $P(TEMP,U,1)=DUZ,$P(ORG,U,1)=DUZ
 E  S XDUZ=4
 S XDUZ=+$P(TEMP,U,XDUZ)
 I 'MCESSEC D EDD^MCESEDT2 S ^MCAR(MCFILE,MCARGDA,"ES")=TEMP Q
 S CREAT=$$GETDATE(15)
 I PROV<1!(PROV>7) S PROV=1
 I PROV=8 Q
 S Y=$P(^MCAR(MCFILE,REC,0),U,1) D DD^%DT
 S MDAT1=Y,MDAT2=$P($G(^MCAR(MCFILE,REC,0)),U,2),MDAT2=$P($G(^MCAR(690,+MDAT2,0)),U,1),MDAT2=$P($G(^DPT(+MDAT2,0)),U,1)
 S STATUS=$$STATUS(MCFILE,CODE)
 I PROV<3 S TDATE=$$GETDATE(3)
 E  I PROV=3!(PROV=4)!(PROV=6)!(PROV=7) S TDATE=$$GETDATE(9)
 E  I PROV=5 S TDATE=$$GETDATE(8)
 D HEADER
 I $P($G(^MCAR(MCFILE,REC,"ES")),U,7)="" D EDITD S ERROR=0 G SKIP
 I $D(MCBACK) D EDITSS K MCBACK G SKIP
 W !!!
 S DIR(0)="Y",DIR("A")=IOINHI_"Do you want to change the release status"_IOINORM,DIR("B")="N" D ^DIR K DIR I $D(DIRUT)!(Y=0) W @IOF N DIE,DA,DR S DIE="^MCAR("_MCFILE_",",DA=REC,DR="1502///NOW" D ^DIE D EXIT Q
SK ;
 D HEADER,@("EDIT"_$$NUMTOES^MCESSCR(PROV))
SKIP ;
 I EXIT=0 S $P(TEMP,U,7)=SUP_$$NUMTOES^MCESSCR(LOOP) D:LOOP>2 HEADER
 D:EXIT=0 @("ED"_$$NUMTOES^MCESSCR(LOOP)_"^MCESEDT2")
 D UPDATE:EXIT=0,NOUPDATE:EXIT=1
 I '$D(DTOUT) S DIR(0)="E" D ^DIR K DIR
EXIT ;
 D KILL^%ZISS W @IOF Q
UPDATE ;
 W !!,"Record has been updated with new release information",!!
 S ORG=$P(ORG,U,7) K:ORG'="" ^MCAR(MCFILE,"ES",ORG,REC)
 S ^MCAR(MCFILE,REC,"ES")=TEMP,^MCAR(MCFILE,"ES",$P(TEMP,U,7),REC)=""
 Q
NOUPDATE ;
 W !!,"Record has not been updated with new release information",!!
 ;; ***ORIGINAL*** ;; S ^MCAR(MCFILE,REC,"ES")=ORG
 ;  The 'IF $GET' was added to the set line to prevent dangling
 ;  'ES' nodes when the user supersedes a record, but up-arrows
 ;  out of the edit and sign-off of the new record.
 I $G(^MCAR(MCFILE,REC,0))]"" S ^MCAR(MCFILE,REC,"ES")=ORG
 D DELSS ; NEW LINE
 Q
EDITD ;Draft
EDITPD ;Problem Draft
 S DIR("B")=PROV,DIR(0)="S^1:Draft;2:Problem Draft;3:Released On-Line Verified;4:Released Off-line Verified"
 S:RNV'=0 DIR(0)=DIR(0)_";5:Released not Verified"
 D ASK I EXIT=1,($P($G(^MCAR(MCFILE,REC,"ES")),U,7)="") S TY=1,EXIT=0
 Q:EXIT=1
 S LOOP=TY
 Q
EDITSRV ;
 S SUP="S"
EDITRV ;Released On-Line Verified
 S DIR("B")=1,DIR(0)="S^1:Released On-Line Verified;2:Supersede" D ASK Q:EXIT=1
 S:TY=2 SUP="" S LOOP=$S(TY=1:3,TY=2:8) Q
EDITSROV ;
 S SUP="S"
EDITROV ;Released Off-Line Verified
 S DIR("B")=2,DIR(0)="S^1:Released On-Line Verified;2:Released Off-Line Verified;3:Supersede" D ASK Q:EXIT=1
 S:TY=3 SUP="" S LOOP=$S(TY=1:3,TY=2:4,TY=3:8) Q
EDITRNV ;Released Not Verified
 S DIR("B")=3,DIR(0)="S^1:Released On-Line Verified;2:Released Off-line Verified;3:Released not Verified;4:Supersede" D ASK Q:EXIT=1
 S LOOP=$S(TY=1:3,TY=2:4,TY=3:5,TY=4:8) Q
EDITSS ;Superseded Change
EDITS S SUP="S",DIR("B")=PROV,DIR(0)="S^1:Released On-Line Verified;2:Released Off-line Verified" D ASK
 I EXIT=1 D DELSS Q
 S LOOP=$S(TY=1:3,TY=2:4) Q
DELSS ;
 Q:'$D(MCESPREV)
 W !!,"Since you did not sign the procedure results this report will be"
 W !,"deleted and the superseded report will be convert back the way it was."
BACKSS ;
 S ^MCAR(MCFILE,MCESPREV,"ES")=MCESTEMP K ^MCAR(MCFILE,"ES","S",MCESPREV)
 S ^MCAR(MCFILE,"ES",$P(MCESTEMP,U,7),MCESPREV)="" S DIK="^MCAR("_MCFILE_",",DA=MCARGDA D ^DIK
 Q
ASK ;Ask for a status code
 S DIR("A")=IOINHI_"Please Select a New Status"_IOINORM,DIR("?")="^D HELP^MCESHLP" D ^DIR S TY=Y I $D(DIRUT)!$D(DUOUT)!$D(DTOUT) S EXIT=1
 I Y=DIR("B"),(PROV>2) S EXIT=1,NCHANGE=1
 K DIR Q:EXIT=1
 S NEWST=Y(0) Q
HEADER ;
 W @IOF,IODHLT,"       * * * Release Control * * *",!,IODHLB,"       * * * Release Control * * *"
 W !,LINE
 W:CREAT'[1700 !!,?4,IOINHI,"Created on: ",IOINORM,CREAT
 W !!,IOINHI,?14,"DATE: ",IOINORM,MDAT1,!,?16,MDAT2,!!,IOINHI,"Current Status: ",IOINORM,IOBON,STATUS,IOBOFF
 W:TDATE'="" IOINHI," as of ",IOINORM,TDATE
 S NAME=$$DECODE^MCESPRT(ORG,CODE,MCFILE,MCARGDA)
 W !,IOINHI,?16,"by: ",IOINORM,NAME
 I PROV=4 D PROVID
 I PROV=7!(PROV=8) S Y=$P(TEMP,U,14) D DD^%DT W !!,"This record supersedes record created on ",IOUON,Y,IOUOFF,"."
 W:$D(NEWST) !!,IOINHI,?8,"New status: ",IOINORM,NEWST
 W !,LINE Q
PROVID ;
 W !,IOINHI,?15,"for: ",IOINORM
 S HDUZ=+$P(TEMP,U,4)
 I '$D(^VA(200,HDUZ,0)) W "unknown"
 E  W $P(^VA(200,HDUZ,0),U,1)
 K HDUZ Q
GETDATE(EE) ;
 N Y S Y=$P(TEMP,U,EE) D DD^%DT Q Y
STATUS(FILE,PROV) ;
 N Y,C S Y=PROV,C=$P(^DD(FILE,1506,0),U,2) D Y^DIQ
 S:Y="" Y="DRAFT"
 Q Y
