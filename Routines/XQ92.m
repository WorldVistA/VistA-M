XQ92 ;SEA/JLI - DATE/TIME FOR PROHIBITED TIME/DAY ;7/23/91  14:11 ;4/6/92  1:02 PM
 ;;8.0;KERNEL;;Jul 10, 1995
 ; ENTRY IS WITH DATE TIME IN FILEMANAGER FORMAT IN VARIABLE X
 ;               INTERNAL ENTRY NUMBER OF OPTION IN +XQY
 ;
 ; ON RETURN X IS UNCHANGED IF NOT WITHIN A PROHIBITED TIME,
 ;                NULL IF WITHIN A PROHIBITED TIME.
 ;
ENTRY ; Check that input values are legitimate
 N %,%D,%H,%M,%T,%XQ1,%XQ2,%XQ3,%XQA,%XQB,%XQK,%XQK0,%XQK1,%XQK2
 N %XQOP,%XQX,%Y,XQUEFLG
 S %XQOP=3.91 D ENT2 I X'="" S %XQOP=3.92 D ENT2
 K %XQOP,XQUEFLG
 Q
ENT2 ;
 Q:'$D(X)!'$D(XQY)  Q:+X'>0  Q:'$D(^DIC(19,+XQY,0))
 K %XQX G:'$D(^DIC(19,+XQY,%XQOP)) CHK0
 ; Check for data in multiple DAY/TIMES field
 S %XQA=0 F %XQI=1:1 S %XQA=$O(^DIC(19,+XQY,%XQOP,%XQA)) Q:%XQA'>0  S %XQX(%XQI)=$P(^(%XQA,0),U,1)_$P(^(0),U,2)
 K %XQA,%XQI G:$D(%XQX) CHKIT
 ;
CHK0 ; Check zero node for old prohibited time
 Q:%XQOP=3.92  S %XQX(1)=$P(^DIC(19,+XQY,0),U,9) I '$L(%XQX(1)) K %XQX Q
CHKIT ; Check for time within prohibited period
 S %XQA="MO,TU,WE,TH,FR,SA,SU,MO,TU,WE,TH,FR,SA,"
 F %XQI=0:0 S %XQI=$O(%XQX(%XQI)) Q:%XQI'>0  D CHKONE
 I '$D(%XQX) S X="" ; **** At this point   set X to NULL if within a prohibited period.
 ;K %XQI,%XQX,%XQA
 Q
CHKONE ; Check for within prohibited period, if so KILL %XQX
 S %XQ1=+$P(%XQX(%XQI),"-",1),%XQ2=+$E($P(%XQX(%XQI),"-",2),1,4),%XQ3=+$E($P(X,".",2)_"0000",1,4)
 I %XQ1>%XQ3!(%XQ3>%XQ2) Q  ; Time is outside specified range
 ; Time is within range, what about day of week
 S %XQ3=(%XQ2+1)#100,%XQB=%XQ2\100,%XQK1="" S:%XQB>23 %XQB=0,%XQK1=1 S:%XQ3>59 %XQB=%XQB+1,%XQ3=0 S %XQB=($P(X,".",1)+%XQK1)_"."_$S(%XQB>9:%XQB,1:"0"_%XQB)_$S(%XQ3>9:%XQ3,1:"0"_%XQ3)
 S %XQ3=$E(%XQX(%XQI),10,100) I %XQ3="" S %XQ3="MO-FR"
 F %XQK=0:0 S %XQK1=$F(%XQ3,"-")-3 Q:%XQK1'>0  S %XQK2=%XQK1+4,%XQK0=$E(%XQA,$F(%XQA,$E(%XQ3,%XQK1,%XQK1+1))-2,100),%XQK0=$E(%XQK0,1,$F(%XQK0,$E(%XQ3,%XQK2-1,%XQK2))-1),%XQ3=$E(%XQ3,1,%XQK1-1)_%XQK0_$E(%XQ3,%XQK2+1,100)
 K %XQK,%XQK0,%XQK1,%XQK2 S %XQ1=%XQ3 I $D(^HOLIDAY($P(X,".",1),0)) S %XQ3="SU" ; Holiday, set day of week to Sunday
 E  S %XQ3=X D DOW^%DTC S X=%XQ3,%XQ3=$P("SU^MO^TU^WE^TH^FR^SA",U,Y+1)
 I %XQ1[%XQ3 K %XQX ; Only a specific day, either good or bad
 Q
 ;
XQO ; Entry from checking via menu mapping X=date/time, XQY=OPTION, XQZ=string
 ; of prohibited times/dates, joined by semicolons.
 K %XQX F %XQI=1:1 S %XQ1=$P(XQZ,";",%XQI) Q:%XQ1=""  S %XQX(%XQI)=%XQ1
 I $D(%XQX) D CHKIT
 K %XQ1,%XQ2,%XQ3,%XQA,%XQB,%XQI,%XQJ,%XQX
 Q
 ;
NEXT ;Find next time which is NOT prohibited from current date/time
 ;  Entry is with +Y equal to the option number
 ;     Return is with the next non-prohibited date/time in X
 I $G(Y)>0 N XQY S XQY=+Y
 S %XQOP=$S($D(^DIC(19,+XQY,3.91)):3.91,$D(^(3.92)):3.92,1:3.91)
NENT ;
 S X="N",%DT="T" D ^%DT S %XQB=Y S:$D(X1)#2 %XQX1=X1 S:$D(X2)#2 %XQX2=X2 S X1=%XQB,X2=7 D C^%DTC S %XQB1=X S:$D(%XQX1) X1=%XQX1 S:$D(%XQX2) X2=%XQX2 K %XQX1,%XQX2
 S X="" F %XQJ=0:0 Q:X'=""!('$D(%XQB))  S X=%XQB K %XQB D ENT2 I X>%XQB1 S X="" ;W !,$C(7),"ALL TIMES ARE PROHIBITED FOR THIS OPTION -- CAN'T BE DONE",$C(7),!
 K %XQB,%XQB1,%XQJ
 Q
CHKQUE ;Entry point to check whether queueing is required, and if so the
 ;first available time for this option.
 ;   ENTRY IS WITH THE OPTION NUMBER IN +XQY
 ;
 Q:'$D(XQY)  S X="N",%DT="T" D ^%DT S X=Y,%XQOP=3.92 D:$D(^DIC(19,+XQY,3.92)) ENT2 I X'="" S XQUEFLG=0 K %XQOP Q
 D NENT S XQUEFLG=1
 Q
