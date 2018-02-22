XVEMRLI ;DJB/VRR**RTN LBRY - Sign In Rtns,ALL,Edit IDENTIFIER ;2017-08-15  2:00 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in EN+2,GETRTN (c) 2016 Sam Habiel
 ;
 ;--> ALL^XVEMRLI    = to sign in all routines
 ;    IDEDIT^XVEMRLI = to bulk edit IDENTIFIER field
 ;    IDDEL^XVEMRLI  = to bulk delete IDENTIFIER field
 ;
EN ;Use ALL^XVEMRLI if you need to sign in rtns other than your own.
 NEW FLAGQ,XVVUSERI,XVVUSERN,X
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^XVEMRLU,UNWIND^XVEMSY"
 Q:'$D(^XVV(19200.11))  ;...Library file doesn't exist
 S FLAGQ=0 D INIT^XVEMRLU G:FLAGQ EX
 D GETRTN G:FLAGQ EX
 G:'$D(^TMP("VPE","SELECT",$J)) EX ;No rtns selected
 I '$G(FLAGID) D SIGNIN G EX
 D EDIT
EX ;
 L -^XVV(19200.11)
 KILL ^TMP("VPE","SELECT",$J),^UTILITY($J)
 Q
 ;====================================================================
GETRTN ;Get rtns to sign in
 I $D(XVSIMERR) S $EC=",U-SIM-ERROR,"
 NEW CNT,DATA,ID,IEN,RTN,TMP,XVVBYI,XVVBYN
 W !,"Building routine list..."
 KILL ^TMP("VPE","SELECT",$J)
 KILL ^TMP("CE",$J)
 S CNT=1
 S RTN=""
 F  S RTN=$O(^XVV(19200.11,"B",RTN)) Q:RTN']""  D  ;
 . S IEN=$O(^XVV(19200.11,"B",RTN,"")) Q:IEN'>0
 . S DATA=$G(^XVV(19200.11,IEN,0)) Q:DATA']""
 . ;--> See if current user signed out this rtn. If not, quit unless
 . ;    tag ALL^XVEMRLI was used.
 . D GETBY^XVEMRLU(IEN)
 . I '$G(FLAGALL) Q:XVVBYI'=XVVUSERI
 . S ID=$P(DATA,U,4)
 . S TMP=IEN_$C(9)_RTN_$J("",15-$L(RTN))_"|"_XVVBYN_$J("",30-$L(XVVBYN))_"|"_$E(ID,1,22)
 . S ^TMP("CE",$J,CNT)=TMP
 . S CNT=CNT+1
 . W "."
 ;
 I '$D(^TMP("CE",$J)) D  Q
 . W !!,"You have no routines signed out."
 . D PAUSE^XVEMKU(2,"P")
 . S FLAGQ=1
 ;
 ;--> Set heading
 S ^TMP("CE",$J,"HD")="ROUTINE         SIGNED OUT BY                  IDENTIFIER"
 ;--> Run selector
 D SELECT^XVEMKT("^TMP(""CE"","_$J_")",1)
 KILL ^TMP("CE",$J)
 Q
 ;
SIGNIN ;Sign in selected rtns by deleting them from the file
 Q:$$ASK^XVEMKU("SIGN IN selected routine(s) now",1)'="Y"
 D LOCK^XVEMRLU Q:FLAGQ
 ;
 NEW %,%Y,CNT,DA,DATA,DDH,DIC,DIK,DZ,IEN,RTN,X,Y
 S CNT=1
 S IEN=0
 F  S IEN=$O(^TMP("VPE","SELECT",$J,IEN)) Q:IEN'>0  D  ;
 . S DATA=$G(^(IEN)) Q:DATA']""
 . S RTN=$E($P(DATA,$C(9),2),1,10)
 . S DA=$P(DATA,$C(9),1)
 . S DIK="^XVV(19200.11,"
 . D ^DIK
 . S CNT=CNT+1
 . W !?1,RTN,?15,"signed in..."
 W !!,(CNT-1)," routine(s) Signed In"
 D PAUSE^XVEMKU(2,"P")
 Q
 ;
EDIT ;Bulk edit IDENTIFIER field
 NEW %,%Y,CNT,D,D0,DA,DATA,DDH,DI,DIC,DIE,DQ,DR,IEN,RTN,XVVID,X,Y
 I FLAGID=1 D GETID Q:FLAGQ  S PROMPT="Update " ;Edit IDENTIFIER
 I FLAGID=2 S PROMPT="Delete " ;.................Delete IDENTIFIER
 W ! Q:$$ASK^XVEMKU(PROMPT_"IDENTIFIER field(s) now",1)'="Y"
 D LOCK^XVEMRLU Q:FLAGQ
 ;
 NEW %,%Y,CNT,DA,DATA,DDH,DIC,IEN,RTN,X,Y
 S CNT=1
 S IEN=0
 F  S IEN=$O(^TMP("VPE","SELECT",$J,IEN)) Q:IEN'>0  D  ;
 . S DATA=$G(^(IEN)) Q:DATA']""
 . S RTN=$E($P(DATA,$C(9),2),1,10)
 . S DA=$P(DATA,$C(9),1)
 . S DIE="^XVV(19200.11,"
 . I FLAGID=1 S DR="4///^S X=XVVID"
 . I FLAGID=2 S DR="4///@"
 . D ^DIE
 . S CNT=CNT+1 W !,RTN,?15,"updated..."
 W !!,(CNT-1)," routine(s) updated"
 D PAUSE^XVEMKU(2,"P")
 Q
 ;
GETID ;Get IDENTIFIER to stuff
 W !
GETID1 W !,"IDENTIFIER: "
 R XVVID:300 S:'$T XVVID="" I "^"[XVVID S XVVID="" Q
 I "??"[XVVID!($L(XVVID)>30) D  G GETID1
 . W !,"Enter an identifier word or phrase (1-30 characters)."
 Q
 ;====================================================================
ALL ;Allows signing in ALL rtns, not just your own
 NEW FLAGALL S FLAGALL=1
 G EN
 ;
IDEDIT ;Bulk edit IDENTIFIER field
 NEW FLAGID S FLAGID=1
 G EN
 ;
IDDEL ;Bulk delete IDENTIFIER field
 NEW FLAGID S FLAGID=2
 G EN
