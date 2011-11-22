DVBAUTL6 ;ALB/JLU;UTILITY ROUTINE;9/15/94
 ;;2.7;AMIE;;Apr 10, 1995
 ;
DSCIFN(A) ;returns the IFN of the discarge type in A. from file 405.2
 ;
 N DIC,X
 S DIC="^DG(405.2,",DIC(0)="XMZ"
 S X=A
 D ^DIC
 Q +Y
 ;
DSCTIEN(A) ;returns the IEN of the discharge type in file 405.3
 N DIC,X
 S DIC="^DG(405.3,",DIC(0)="XMZ"
 S X=A
 D ^DIC
 Q +Y
 ;
CHECK(A) ;used in the lookup screen of the discharge report to check for
 ;active facility movement types for the particular MAS movement types.
 ;A is the MAS movement type
 ;
 N DVBA,DVBFOUND
 S DVBA=""
 F  S DVBA=$O(^DG(405.1,"AM",A,DVBA)) Q:'DVBA!($D(DVBFOUND))  DO
 .I '$D(^DG(405.1,DVBA,0)) Q
 .I $P(^DG(405.1,DVBA,0),U,4)=1 S DVBFOUND=1
 .Q
 I $D(DVBFOUND) Q 1
 E  Q 0
 ;
LOCK(Y) ;locks the record.
 ;called by dvbaren1, dvbarl21, dvbareg1
 L +^DVB(396,+Y):2
 I '$T DO  Q 0
 .S VAR(1,0)="1,0,0,2,0^Record is currently in use!"
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .D PAUSE^DVBCUTL4
 Q 1
 ;
UNLOCK(Y) ;unlocks the global
 ;called by dvbaren1, dvbarl21, dvbareg1
 L -^DVB(396,+Y)
 Q
 ;
ERR(A) ;displays an error message to the user called from DVBAREG1
 N VAR
 S VAR(1,0)="1,0,0,2:2,0^There is no Admission or Non Admission information"_$S(A>0:" for this date range!",1:".")
 D WR^DVBAUTL4("VAR")
 K VAR
 D CONTMES^DVBCUTL4
 Q
 ;
