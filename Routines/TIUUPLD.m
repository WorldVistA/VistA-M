TIUUPLD ; SLC/JER - ASCII Upload ;9/11/98@16:39:47
 ;;1.0;TEXT INTEGRATION UTILITIES;**21**;Jun 20, 1997
MAIN ; Control branching
 N EOM,TIUDA,TIUERR,TIUHDR,TIULN,TIUSRC,X
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 S TIUSRC=$P($G(TIUPRM0),U,9),EOM=$P($G(TIUPRM0),U,11)
 I EOM']"",($P(TIUPRM0,U,17)'="k") W !,$C(7),$C(7),$C(7),"No End of Message Signal Defined - Contact IRM.",! Q
 S:TIUSRC']"" TIUSRC="R"
 S TIUHDR=$P(TIUPRM0,U,10)
 I TIUHDR']"" W $C(7),$C(7),$C(7),"No Record Header Signal Defined - Contact IRM.",! Q
 S TIUDA=$$MAKEBUF
 I +TIUDA'>0 W $C(7),$C(7),$C(7),"Unable to create a Buffer File Record - Contact IRM.",! Q
 I TIUSRC="R" D REMOTE(TIUDA)
 I TIUSRC="H" D HFS(TIUDA)
 I +$G(TIUERR) W $C(7),$C(7),$C(7),!,"File Transfer Error: ",$G(TIUERR),!!,"Please re-transmit the file...",!
 ; Set $ZB to MAIN+14^TIUUPLD:2
 I +$O(^TIU(8925.2,TIUDA,"TEXT",0))>0,'+$G(TIUERR) D FILE(TIUDA)
 I +$O(^TIU(8925.2,TIUDA,"TEXT",0))'>0!+$G(TIUERR) D BUFPURGE^TIUPUTC(TIUDA)
 Q
REMOTE(DA) ; Read ASCII stream from remote computer
 N TIUI,TIUPAC,X
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 S TIUPAC=$P(TIUPRM0,U,15)
 I TIUPAC']"",($P(TIUPRM0,U,17)'="k") W $C(7),$C(7),$C(7),"No Pace Character Defined - Contact IRM.",! Q
 I $P(TIUPRM0,U,17)="k" D KERMIT(DA) Q
 D REMHDR("ASCII")
 S TIUERR=""
 W !,$C(TIUPAC)
 F  R X:DTIME S:'$T X="^TIMEOUT" D  Q:TIUERR'=""
 . I (X="^")!(X="^^")!(X="^TIMEOUT") DO  Q
 . . S TIUERR="1,End of Message Signal not seen."
 . I X=EOM S TIUERR=0 W ! Q
 . I X?1."?" D HELP(X),REMHDR("ASCII") Q
 . ; Ignore leading white space
 . I (+$O(^TIU(8925.2,DA,"TEXT",0))'>0),(X="") Q
 . S TIUI=+$G(TIUI)+1,^TIU(8925.2,DA,"TEXT",TIUI,0)=$$STRIP(X)
 . W !,$C(TIUPAC) ; Send ACK to remote
 S ^TIU(8925.2,DA,"TEXT",0)="^^"_$G(TIUI)_"^"_$G(TIUI)_"^"_DT_"^^^^"
 Q
REMHDR(PRTCL) ; Write Header for Remote upload
 W @IOF D JUSTIFY^TIUU($$TITLE^TIUU(PRTCL_" UPLOAD"),"C")
 W:PRTCL="ASCII" !!,"Initiate upload procedure:",!
 Q
KERMIT(DA) ; Use Kermit Protocol Driver
 N XTKDIC,XTKERR,XTKMODE,DWLC
 D REMHDR("KERMIT")
 S XTKDIC="^TIU(8925.2,"_+DA_",""TEXT"",",XTKMODE=2
 D RECEIVE^XTKERMIT I +$G(XTKERR) S TIUERR=$G(XTKERR) W !
 Q
HFS(DA) ; Read HFS file
 N TIUI,X
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 W @IOF D JUSTIFY^TIUU($$TITLE^TIUU("ASCII UPLOAD"),"C")
 W !!,"Select Host File:",! D ^%ZIS I POP W !,$C(7),"Device unavailable." Q
 F  U IO R X:DTIME Q:'$T!(X=EOM)!(X="^")!(X="^^")  D
 . U IO(0) W X,!
 . S TIUI=+$G(TIUI)+1,^TIU(8925.2,DA,"TEXT",TIUI,0)=$$STRIP(X)
 S ^TIU(8925.2,DA,"TEXT",0)="^^"_$G(TIUI)_"^"_$G(TIUI)_"^"_DT_"^^^^"
 D ^%ZISC
 Q
STRIP(X) ; Strip control characters
 N I,Y
 ; First replace TABS w/5 spaces
 F I=1:1:$L(X) S:$A(X,I)=9 X=$E(X,1,(I-1))_"     "_$E(X,(I+1),$L(X))
 ; Next, remove control characters
 S Y="" F I=1:1:$L(X) S:$A(X,I)>31 Y=Y_$E(X,I)
 Q Y
MAKEBUF() ; Subroutine to create buffer records
 N DIC,DA,DR,DIE,START,X,Y
 S START=$$NOW^TIULC
 S (DIC,DLAYGO)=8925.2,DIC(0)="LX",X=""""_$J_"""" D ^DIC
 I +Y'>0 S DA=Y G MAKEBUX
 S DA=+Y,DIE=DIC,DR=".02////"_+$G(DUZ)_";.03////"_START D ^DIE
MAKEBUX Q DA
FILE(DA) ; Completes upload transaction, invokes filer/router
 N DIE,DR
 I '$D(^TIU(8925.2,+DA,0)) G FILEX
 S DIE="^TIU(8925.2,",DR=".04////"_$$NOW^TIULC D ^DIE
 ; Task background filer/router to process buffer record
 S ZTIO="",ZTDTH=$H,ZTSAVE("DA")=""
 S ZTRTN=$S($P(TIUPRM0,U,16)="D":"MAIN^TIUPUTD",1:"MAIN^TIUPUTC")
 S ZTDESC="TIU Document Filer"
 ; If filer is NOT designated to run in the foreground, queue it
 I '+$P(TIUPRM0,U,18) D  G FILEX
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"Filer/Router Queued!",1:"Filer/Router Cancelled!")
 ; Otherwise, run the filer in the foreground
 W !!,"File Transfer Complete--Now Filing Records..."
 D @ZTRTN
FILEX Q
HELP(X) ; Process HELP for Remote upload
 I X="?" W !?3,"Begin file transfer using ASCII protocol upload procedure.",!
 I X?2."?" D
 . W !?3,"Consult your terminal emulator's User Manual to determine",!
 . W !?3,"how to set-up and initiate an ASCII protocol file transfer.",!
 W !?3,"Enter '^' or '^^' to exit.",!
 S TIUX=$$READ^TIUU("FOA","Press RETURN to continue...")
 Q
