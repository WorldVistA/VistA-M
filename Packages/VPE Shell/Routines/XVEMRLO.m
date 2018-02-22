XVEMRLO ;DJB/VRR**RTN LBRY - Sign Out Rtns,Rtn Save ;2017-08-15  2:02 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap (3rd code line) (c) 2016 Sam Habiel
 ;
 NEW FLAGQ,XVVID,XVVUSERI,XVVUSERN
 NEW %,%Y,%DT,D,D0,DA,DDH,DI,DIC,DIE,DQ,DR,DZ,X,Y
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XVEMRLU,UNWIND^XVEMSY"
 Q:'$D(^XVV(19200.11))  ;...Library file doesn't exist
 S FLAGQ=0
 D INIT^XVEMRLU Q:FLAGQ
TOP ;
 W @XVV("IOF"),!,"*** SIGN OUT ROUTINES ***"
 D SELECT^XVEMRUS G:'$D(^UTILITY($J)) EX
 D GETID^XVEMRLI
 W ! G:$$ASK^XVEMKU("SIGN OUT routine(s) now",1)'="Y" TOP
 D LOCK^XVEMRLU G:FLAGQ EX
 D LOOP
EX ;
 KILL ^UTILITY($J)
 L -^XVV(19200.11)
 Q
 ;====================================================================
LOOP ;Stuff data into VPE RTN LBRY
 NEW CNT,IEN,NAME,RTN,XVVBYI,XVVBYN,Y
 S CNT=1,RTN=0
 F  S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""  D  ;
 . I $E(RTN)'?1A,$E(RTN)'?1"%" Q
 . I '$D(^XVV(19200.11,"B",RTN)) D CREATE(RTN) Q
 . W $C(7),!,RTN,?12,"--> Already signed out by "
 . S IEN=$O(^XVV(19200.11,"B",RTN,"")) Q:IEN'>0
 . D GETBY^XVEMRLU(IEN) Q:XVVBYN']""  W XVVBYN
 W !!?1,(CNT-1)," routine(s) Signed Out"
 D PAUSE^XVEMKU(2,"P")
 Q
CREATE(RTN) ;Create entry and 'stuff' data
 ;X=Routine name. Requires XVVID,XVVUSERI
 Q:$G(RTN)']""
 S X=RTN
 S DIC="^XVV(19200.11,"
 S DIC(0)="QL"
 KILL DD,DO D FILE^DICN Q:$P(Y,U,3)'=1
 S DIE=DIC
 S DA=+Y
 S DR="4///^S X=$G(XVVID);12///NOW;13////^S X=XVVUSERI"
 D ^DIE
 S CNT=$G(CNT)+1
 W !!,RTN," signed out."
 Q
 ;==================================================================
RS(JOB) ;Replace ^UTILITY($J,RTNS) routines with ..LBRY routines.
 ;JOB=Job#
 ;XVV("OS"): 8=MSM 18=OpenM
 ;
 Q:'$G(JOB)
 Q:'$G(XVV("OS"))
 Q:'$D(^XVV(19200.11,"B"))
 ;
 NEW CNT,ID,IEN,RTN
 S ID=$$RSID() Q:ID="^"
 I XVV("OS")=8,'$G(%RSN) KILL ^UTILITY(JOB)
 S CNT=0,RTN=""
 F  S RTN=$O(^XVV(19200.11,"B",RTN)) Q:RTN']""  D  ;
 . S IEN=$O(^XVV(19200.11,"B",RTN,"")) Q:IEN'>0
 . I ID]"",ID'=$P($G(^XVV(19200.11,IEN,0)),"^",4) Q
 . Q:$D(^UTILITY(JOB,RTN))
 . S ^UTILITY(JOB,RTN)=""
 . S CNT=CNT+1
 . I XVV("OS")=18 S %R=$G(%R)+1
 Q:'CNT
 I XVV("OS")=8 S %RSN=1
 W !!?10,CNT," routine",$S(CNT=1:"",1:"s")," added."
 Q
RSID() ;Restrict rtns selected based on IDENTIFIER field.
 NEW ID
RSID1 W !!,"Enter IDENTIFIER: "
 R ID:300 S:'$T ID="^" I "^"[ID Q ID
 I $E(ID)="?" D  G RSID1
 . W !!,"If you want only those routines with a certain IDENTIFIER, enter it now."
 . W !,"Hit <RETURN> for ALL routines, or ^ for NO routines."
 Q ID
