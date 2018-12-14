SDPARM2 ;ALB/CAW,GXT - Edit Main and Division Parameters; 8/13/2018
 ;;5.3;Scheduling;**27,132,705**;08/13/93;Build 11
 ;;PER VHA DIRECTIVE 2004-038, DO NOT MODIFY THIS ROUTINE
 ;
 ;Patch SD*5.3*705 updated this routine to allow the enter/edit
 ;of the ENABLE BLANK LINE? (#1.1), EXCLUDE ADMIN CLINICS? (#1.2), 
 ;and ADDITIONAL HEADER TEXT (#1.3) fields in the SCHEDULING PARAMETER 
 ;(#404.91) FILE.
 ;The ADDITIONAL HEADER TEXT (#1.3) is a subfile and includes
 ;INSTITUTION, HEADER TEXT and PRINT STARTING AT FIRST LINE? sub fields) 
 ;
1 ;Edit Main Parameters
 ;
 D FULL^VALM1
 S DIE="^DG(43,",DA=1,DR="212;215;216;32;217;226;227;224T" D ^DIE K DIE
 S DIE="^SD(404.91,",DIC(0)="AEQMZ",DR="1.1;1.2" D ^DIE K DR,DIE,DA ;Patch SD*5.3*705
 I $D(DTOUT) G SDQUIT
 G RDSPLY
 Q
 ;
2 ;Edit Division Parameters
 ;
 D FULL^VALM1
 I '$P($G(^DG(43,1,"GL")),U,2) S Y=1 D DIE Q
DIC W ! S DIC="^DG(40.8,",DIC(0)="AEMQ" D ^DIC I Y<0 S VALMBCK="" G RDSPLY
DIE S DIE="^DG(40.8,",(SD,DA)=+Y,DR="30.01:30.04" D ^DIE K DIE
 I $D(DTOUT) G SDQUIT
 I $P($G(^DG(43,1,"GL")),U,2) G DIC
 G RDSPLY
 Q
 ;
3 ;Edit Additional Header Text Fields in Scheduling Parameter (#404.91) file
 ;
 N DA,DR,DIE
 D FULL^VALM1
 S DA=1 S DR=1.3,DR(2,404.9102)=".01T;1T",DR(3,404.91021)=".01;.02",DIE=404.91 D ^DIE K DR,DA,DIE
 I $D(DTOUT) G SDQUIT
 G RDSPLY
 Q
 ;
RDSPLY D EN^SDPARM S VALMBCK="R"
SDQUIT Q
