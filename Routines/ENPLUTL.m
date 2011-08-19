ENPLUTL ;WISC/SAB-PROJECT PLANNING UTILITIES ;6/8/94
 ;;7.0;ENGINEERING;**11**;Aug 17, 1993
 Q
POSTCL(ENDA,ENAR,ENSKIP) ; Post Text to Communication Log
 ; ENDA - ien of project in file #6925
 ; ENAR - closed root of text array (array has positive numbered nodes)
 ; ENSKIP - optional number of lines to skip before text (defaults to 1)
 N ENLC,ENWPLC,ENX
 S ENAR=$S($E(ENAR,$L(ENAR))=")":$E(ENAR,1,$L(ENAR)-1)_",",$E(ENAR,$L(ENAR))'="(":ENAR_"(",1:ENAR)
 S ENSKIP=$G(ENSKIP) S:ENSKIP'=+ENSKIP\1 ENSKIP=1
 S ENWPLC=$P($G(^ENG("PROJ",ENDA,80,0)),U,3)
 F  Q:'$D(^ENG("PROJ",ENDA,80,ENWPLC+1,0))  S ENWPLC=ENWPLC+1
 S ENLC=0
 I ENSKIP F ENLC=1:1:ENSKIP S ^ENG("PROJ",ENDA,80,ENWPLC+ENLC,0)=" "
 S ENX="" F  S ENX=$O(@(ENAR_"ENX)")) Q:ENX=""  D
 . S ENLC=ENLC+1
 . S ^ENG("PROJ",ENDA,80,ENWPLC+ENLC,0)=@(ENAR_"ENX)")
 S ENWPLC=ENWPLC+ENLC
 S $P(^ENG("PROJ",ENDA,80,0),U,3,5)=ENWPLC_U_ENWPLC_U_$P(DT,".")
 Q
LTZ() ; Local TimeZone Extrinsic Variable
 ; Returns 3 character local timezone
 N D0,DA,DIC,DIQ,DR,ENDIQ,Y
 S DA=$O(^XMB(1,0)) Q:'DA ""
 S DIC=4.3,DIQ="ENDIQ(",DIQ(0)="E",DR=1
 D EN^DIQ1
 Q ENDIQ(4.3,DA,1,"E")
FDT(ENDTI) ; Formatted Date/Time Extrinsic Function
 ; ENDTI - internal FileMan date
 ; Returns date/time in mm/dd/yy hh:mm format
 N ENDTE,ENT
 S ENT=$P(ENDTI,".",2)_$E("000000",1,6-$L($P(ENDTI,".",2)))
 S ENDTE=$E(ENDTI,4,5)_"/"_$E(ENDTI,6,7)_"/"_$E(ENDTI,2,3)
 S ENDTE=ENDTE_" "_$E(ENT,1,2)_":"_$E(ENT,3,4)
 Q ENDTE
TZD(ENLTZ,ENRTZ) ; Timezone Difference Extrinsic Function
 ; ENLTZ - first 3 character timezone (normally local timezone)
 ; ENRTZ - second 3 character timezone (normally remote timezone)
 ; Returns difference in hours
 ;   result could be added to remote time to convert it to local time
 N D0,DA,DIC,DIQ,DR,ENDIQ,ENLTZDA,ENRTZDA,X,Y
 I '$D(ENLTZ)!'$D(ENRTZ) Q ""
 S DIC=4.4,DIC(0)="X",X=ENLTZ D ^DIC Q:Y<0 ""  S ENLTZDA=+Y
 S DIC=4.4,DIC(0)="X",X=ENRTZ D ^DIC Q:Y<0 ""  S ENRTZDA=+Y
 S DIC=4.4,DR=2,DIQ="ENDIQ(",DIQ(0)="E"
 S DA=ENLTZDA D EN^DIQ1
 S DA=ENRTZDA D EN^DIQ1
 Q ENDIQ(4.4,ENLTZDA,2,"E")-ENDIQ(4.4,ENRTZDA,2,"E")
PPDOM ; Determine Domain for project planning transmissions
 N D0,DA,DIC,DIQ,DR,ENDIQ,X
 S DA=$O(^DIC(6910,0)),DIC=6910,DIQ="ENDIQ(",DIQ(0)="E",DR=100
 D EN^DIQ1
 S ENDOMAIN=$G(ENDIQ(6910,DA,100,"E"))
 I ENDOMAIN']"" W !,"Domain not found in PROJECT PLANNING ROLLUP DOMAIN (#100) field",!,"of the ENG INIT PARAMETERS (#6910) file. Transmission aborted!",!! R "Press RETURN to Continue",X:DTIME
 Q
 ;ENPLUTL
