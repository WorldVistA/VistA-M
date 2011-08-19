DGPMBSAB ;ALB/LM/ - AUTO RECALC ; 3/16/93
 ;;5.3;Registration;;Aug 13, 1993
 ;
 Q
AUTO ; -- auto recalc entry point
 D DAT^DGPMBSAR I E G Q^DGPMBSAR
 ;
 S RC=RD
 S EGL=$S($P(DGPM("G"),U,7):$P(DGPM("G"),U,7),1:DT)
 ;
 D CLEAN^DGPMBSAR
 ;
 S CD=$O(^DGS(43.5,"AGL",0)) I CD'<EGL,CD'>RC S RC=CD
 ;
 D WDCHK^DGPMBSAR
 ;
 S DIE="^DG(43,",DA=1,DR="57///N"_$S($D(^%ZOSF("VOL")):";58////"_^("VOL"),1:"")_";60///"_RC D ^DIE
 ;
AUTOQ K DR,DA,DIE,EGL,E,CD
 ;
RECALC D GO^DGPMBSAR ; Recalc entry point
 ;
 S DIE="^DG(43,",DA=1,DR="59///N" D ^DIE ; Auto Recalc Finished
 ;
 K DR,DA,DIE
 ;
SET ; Set variables for Auto Recalc Start/Finish Bulletin
 S START=$S($P(^DG(43,1,"GLS"),"^",7)]"":$P(^DG(43,1,"GLS"),"^",7),1:"")
 I START]"" S Y=START X ^DD("DD") S START=Y
 ;
 S BACKTO=$S($P(^DG(43,1,"GLS"),"^",10)]"":$P(^DG(43,1,"GLS"),"^",10),1:"")
 I BACKTO]"" S Y=BACKTO X ^DD("DD") S BACKTO=Y
 ;
 S FINISH=$S($P(^DG(43,1,"GLS"),"^",9)]"":$P(^DG(43,1,"GLS"),"^",9),1:"")
 I FINISH]"" S Y=FINISH X ^DD("DD") S FINISH=Y
 ;
TMP S ^TMP($J,"AUTORECALC",1,0)="             Date/Time Auto Recalc Started:  "_START
 S ^TMP($J,"AUTORECALC",2,0)="             Date Auto Recalc went back to:  "_BACKTO
 S ^TMP($J,"AUTORECALC",3,0)="            Date/Time Auto Recalc Finished:  "_FINISH
 ;
BUL ; Bulletin when auto recalc start/finish
 S DGB=12 ; position on the NOT (notification) Node - file #43
 S XMSUB="AUTO RECALC START/FINISH"
 S XMTEXT="^TMP($J,""AUTORECALC"","
 ;
 D ^DGBUL
 ;
END K START,BACKTO,FINISH,Y,^TMP($J,"AUTORECALC")
 Q
