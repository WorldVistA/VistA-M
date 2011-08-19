DDGFFM ;SFISC/MKO-FORM ADD, EDIT, SELECT ;11:48 AM  20 Dec 1994
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SEL ;Select another form
ADD ;Add a new form
 N X,DIR0 K DDGFABT
 S DDGFDY=+$G(DY),DDGFDX=+$G(DX),(DY,DX)=0 X IOXY
 W $P(DDGLCLR,DDGLDEL,2)
 X DDGLZOSF("EON"),DDGLZOSF("TRMOFF")
 ;
 ;Select file
FIL S DDS1="EDIT/CREATE FORM FOR" D W^DICRW K DDS1 G:Y<0 ADDQ
 G:'$D(@(DIC_"0)")) ADDQ
 ;
 ;Select form
 W !
 S DIC("S")="I $P(^(0),U,8)=+DDGFFILE"
 I DUZ(0)'="@" S DIC("S")=DIC("S")_" N DDSI F DDSI=1:1:$L($P(^(0),U,3)) I DUZ(0)[$E($P(^(0),U,3),DDSI) Q"
 S DDGFFILE=Y,DIC=.403,DIC(0)="QEAL",D="F"_+Y
 D IX^DIC K DIC,D G:Y<0 ADDQ
 S DDGFY=Y
 ;
 ;Save data for previous form
 I DDGFCHG,$D(DDGFFM)#2 G:+DDGFFM=+DDGFY ADDQ D  G:$G(DDGFABT) ADDQ
 . N DDGFFNAM
 . S DIR(0)="Y",DDGFFNAM=$P(DDGFFM,U,2)
 . S DIR("A")="Save changes to form "_DDGFFNAM
 . S DIR("B")="YES"
 . S DIR("?",1)="  Enter 'Y' or press 'Return' to save changes."
 . S DIR("?",2)="  Enter 'N' to discard changes."
 . S DIR("?")="  Enter '^' to return to form "_DDGFFNAM
 . W ! D ^DIR K DIR I $D(DIRUT) K DIRUT,DUOUT,DTOUT S DDGFABT=1 Q
 . D SAVE^DDGFSV
 ;
 I $D(DDGFFM)#2,+DDGFFM'=+DDGFY D RECOMP^DDGF0
 ;
 S DDGFFM=$P(DDGFY,U,1,2)
 ;
 ;Stuff in values for form
 K DR S DIE=.403,DA=+DDGFY,DDGFNEW=$P(DDGFY,U,3)
 S:DDGFNEW DR="3////"_DUZ_";4///NOW"
 S DR=$S($G(DR)]"":DR_";",1:"")_"5///NOW"
 S:DDGFNEW DR=DR_";7////"_+DDGFFILE
 D ^DIE K DIE,DA,DR,D,%DT
 I DDGFNEW,$G(DUZ(0))]"" D
 . S $P(^DIST(.403,+DDGFFM,0),U,2,3)=DUZ(0)_U_DUZ(0)
 ;
 ;If this is a new form, create Page 1
 I DDGFNEW D
 . K DD,DO
 . S DIC="^DIST(.403,+DDGFFM,40,",DIC("P")=$P(^DD(.403,40,0),U,2)
 . S DIC(0)="",DA(1)=+DDGFFM,X=1
 . D FILE^DICN I Y=-1 K DIC,Y Q
 . S DIE=DIC,DA=+Y,DR="2////1,1;7////Page 1"
 . D ^DIE K DIC,DIE,DA,DR,D,Y
 ;
 ;Clear data for previous form
 W $P(DDGLCLR,DDGLDEL,2)
 I $D(@DDGFREF) K @DDGFREF D DESTALL^DDGLIBW
 ;
 ;Get first page, load form
 S DDGFPG=$O(^DIST(.403,+DDGFFM,40,"B",""))
 I DDGFPG]"" S DDGFPG=$O(^DIST(.403,+DDGFFM,40,"B",DDGFPG,""))
 D PG^DDGFLOAD(+DDGFFM,DDGFPG),STATUS^DDGF
 S DDGFDY=$P(DDGFLIM,U),DDGFDX=$P(DDGFLIM,U,2)
 ;
ADDQQ X DDGLZOSF("EOFF"),DDGLZOSF("TRMON")
 D RC(DDGFDY,DDGFDX)
 K DDGFABT,DDGFDY,DDGFDX,DDGFNEW,DDGFY
 Q
 ;
ADDQ I $D(DDGFFM)#2 D REFRESH^DDGF G ADDQQ
 K DDGFABT,DDGFDY,DDGFDX
 Q
 ;
EDIT ;Invoke form to edit form
 S DDGFDY=DY,DDGFDX=DX
 K DDSFILE S DDSFILE=.403
 S DA=+DDGFFM,DR="[DDGF FORM EDIT]",DDSPARM="KTW"
 D ^DDS K DDSFILE,DR,DDSPARM
 ;
 S $P(DDGFFM,U,2)=$P(^DIST(.403,+DDGFFM,0),U)
 D REFRESH^DDGF,RC(DDGFDY,DDGFDX)
EDITQ K DDGFDY,DDGFDX
 Q
 ;
RC(DDGFY,DDGFX) ;Update status line, reset DX and DY, move cursor
 N DDGFS
 I DDGFR D
 . S DY=IOSL-6,DX=IOM-9,DDGFS="R"_(DDGFY+1)_",C"_(DDGFX+1)
 . X IOXY W DDGFS_$J("",7-$L(DDGFS))
 S DY=DDGFY,DX=DDGFX X IOXY
 Q
