MCEO ;WISC/MLH-MED PROC EDIT, OE INTERFACE ;4/2/98  15:19
 ;;2.3;Medicine;**17,31**;09/13/1996
 ;
IN ;
 N DA,DIC,DIE,DR
 S MCFILE1=MCFILE
 I '$D(MCOEON) D ORDER^MCPARAM
 IF $D(MCOEON) D  ;    order entry flag on
 .  N MCFILE1
 .  Q
 ;END IF
 ;
 S MCFILE=MCFILE1
 QUIT
 ;
OUT ;
 N DONE
 IF $D(MCOEON) D  I 1 ;    order entry flag on
 .  IF $D(^MCAR(MCFILE,MCARGDA)) D  I 1 ;    a record on file
 ..    IF $D(DTOUT) D  I 1 ;    timeout
 ...      S DONE=1
 ...      Q
 ..    ELSE  Q
 ..    ;END IF
 ..    Q
 .  ELSE  S DONE=1 ;    no record on file
 .  ;END IF
 .  ;
 .  Q
 ;END IF
 ;
 D EN1^MCMAG ;    imaging link
 QUIT
