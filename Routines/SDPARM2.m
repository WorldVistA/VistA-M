SDPARM2 ;ALB/CAW - Edit Main and Division Parmaters; 3/10/92
 ;;5.3;Scheduling;**27,132**;08/13/93
 ;
1 ;Edit Main Parameters
 ;
 D FULL^VALM1
 S DIE="^DG(43,",DA=1,DR="212;215;216;32;217;226;227;224T" D ^DIE K DIE I $D(DTOUT) G Q1
 D EN^SDPARM S VALMBCK="R"
Q1 Q
 ;
2 ;Edit Division Parameters
 ;
 D FULL^VALM1
 I '$P($G(^DG(43,1,"GL")),U,2) S Y=1 D DIE Q
DIC W ! S DIC="^DG(40.8,",DIC(0)="AEMQ" D ^DIC I Y<0 S VALMBCK="" G RDSPLY
DIE S DIE="^DG(40.8,",(SD,DA)=+Y,DR="30.01:30.04" D ^DIE K DIE
 I $D(DTOUT) G Q2
 I $P($G(^DG(43,1,"GL")),U,2) G DIC
 ;
RDSPLY D EN^SDPARM S VALMBCK="R"
Q2 Q
