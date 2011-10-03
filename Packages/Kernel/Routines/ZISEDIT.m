ZISEDIT ;ISF/AC - DEVICE EDIT ;01/17/2008
 ;;8.0;KERNEL;**440**;Jul 10, 1995;Build 13
 ;
TRM ;TRM or VTRM
 D EDIT("TRM",,"Select Terminal/Printer Device: ")
 Q
 ;
LPD ;LPD fields of a TRM device
 D EDIT("LPD","TRM","Select LPD (Terminal/Printer) Device: ")
 Q
 ;
MT ;Mag Tape
 D EDIT("MT",,"Select Magtape Device: ")
 Q
 ;
SDP ;
 D EDIT("SDP",,"Select SDP Device: ")
 Q
 ;
SPL ;Spool
 D EDIT("SPL",,"Select Spool Device: ")
 Q
 ;
HFS ;Host file
 D EDIT("HFS",,"Select Host File Device: ")
 Q
 ;
CHAN ;Network
 D EDIT("CHAN",,"Select Network Channel: ")
 Q
 ;
RES ;Resource
 D EDIT("RES",,"Select Resource Device: ")
 Q
 ;
EDIT(ZISTYPE,ZISSCR,DICA) ;
 N Y,DA,DIC,DIE,DR,DDSFILE
ED2 S DIC("A")=DICA,ZISSCR=$G(ZISSCR,ZISTYPE)
 S DIC=3.5,DIC(0)="AEMQZL",DIC("S")="I $G(^(""TYPE""))["_""""_ZISSCR_"""" D ^DIC
 Q:Y'>0
 S DA=+Y
 I $P(Y,"^",3) D
 . N DIE,DR
 . S DIE=DIC,DR="2///"_ZISTYPE_$S(ZISTYPE["TRM":"",1:";1.95///N")
 . D ^DIE
 . Q
 S DR="[XUDEVICE "_ZISTYPE_"]",DDSFILE=3.5 D ^DDS
 G ED2
 Q
