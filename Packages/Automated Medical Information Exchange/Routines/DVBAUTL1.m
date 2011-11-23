DVBAUTL1 ;ALB/JLU;UTILITY ROUTINE;11/8/94
 ;;2.7;AMIE;;Apr 10, 1995
 ;
STATION(DFN) ;
 ;this function call returns the station number of the patient in the
 ;parameter or -1 if no station number.
 ;
 N X
 I '$D(^DPT(DFN,.31)) Q -1
 S X=$P(^DPT(DFN,.31),U,4)
 I X="" Q -1
 I '$D(^DIC(4,X,99)) Q -1
 S X=$P(^DIC(4,X,99),U,1)
 I X<1 Q -1
 Q X
 ;
EXIT ;this entry point is called from the DVBAPOST routine.  It is used as
 ;the kill statment at the end of the post init.
 ;
 I $D(V3) K CNT,LP1,V3,XMZ,XMY(DUZ),XMY(.5),XMSUB,XMDUZ
 K STOP
 Q
 ;
SET1 ;sets the parameter file node to be used in the post init Keyword
 ;population.
 I '$D(CNT) S CNT=1
 I $D(^DVB(396.1,0)) DO
 .N DVBA
 .S DVBA=$$IFNPAR^DVBAUTL3()
 .I DVBA=0 DO
 ..S DIC="^DVB(396.1,",DIC(0)="L"
 ..K DD,D0
 ..S X=$P(^DG(40.8,$$PRIM^VASITE,0),U,1)
 ..D FILE^DICN
 ..S DVBA=$S(Y=-1:0,1:+Y)
 ..K DIC,DD,D0,Y,X
 ..Q
 .S ^DVB(396.1,DVBA,"POST")="DVBA;ADVB;DVBB;ADVB"
 .S:$P(^DVB(396.1,DVBA,0),U,15)']"" $P(^(0),U,15)=1
 .S:$P(^DVB(396.1,DVBA,0),U,18)']"" $P(^(0),U,18)=1
 .S:$P(^DVB(396.1,DVBA,0),U,19)']"" $P(^(0),U,19)=1
 Q
