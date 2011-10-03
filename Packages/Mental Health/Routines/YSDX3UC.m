YSDX3UC ;SLC/DJP/LJA-Continuation of Utilities for Diagnosis Entry in the MH Medical Record ;9/7/94 14:51
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
ASKQUAL ;  Ask for qaulifiers.
 ;  YSQIEN   -- req --> YSQCH(YSQIEN,INTERNAL CODE)=Stands For
 ;                  --> YSOK,YSTOUT,YSUOUT
 ;
 ;Note:  When this subroutine called, all choices have been displayed.
 ;
 S YSOK=0
 QUIT:'$D(^DIC(627.9,+$G(YSQIEN)))  ;->
 ;
 ;  Start preparing for DIR(0)...
 S YSQDIR0="O^" ;Use to add choices to...  (L or S will be added later.)
 S YSQDIRT="L" ;Assume it is LIST.  Changed below, if not...
 ;
 ;  If not available, build needed variables
 S YSQNCH=0 K YSQCH
 S YSQNO=0
 F  S YSQNO=$O(^DIC(627.9,+YSQIEN,1,YSQNO)) QUIT:'YSQNO  D
 .  S YSX=$G(^DIC(627.9,+YSQIEN,1,+YSQNO,0)) QUIT:YSX']""  ;->
 .  S:$P(YSX,U,2)']"" $P(YSX,U,2)=" " ;For possible DIR call...
 .  QUIT:$P(YSX,U)']""  ;->
 .  S YSQNCH=YSQNCH+1
 .  S YSQCH(+YSQIEN,+YSQNO)=$P(YSX,U,2)
 .  S YSQDIR0=YSQDIR0_$P(YSX,U)_":"_$P(YSX,U,2)_";"
 .  I YSQNCH'=+YSX S YSQDIRT="S" ;Not 1-2-3...n LIST sequence...
 ;
 ;  Add DIR(0) type (List or Set)
 S YSQDIR0=YSQDIRT_YSQDIR0
 ;
 ;  Multiple-allowed List of Numeric Choice qualifiers?
 ;  Adjust P(2)...
 I YSQDIRT="L",$P($G(^DIC(627.9,+YSQIEN,2)),U)="Y" S $P(YSQDIR0,U,2,99)="1:"_+YSQNCH
 I YSQDIRT="L",$P($G(^DIC(627.9,+YSQIEN,2)),U)'="Y" S YSQDIR0="S"_$E(YSQDIR0,2,999)
 ;
 ;  Chop trailing semicolons...
 I $E(YSQDIR0,$L(YSQDIR0))=";" S YSQDIR0=$E(YSQDIR0,1,$L(YSQDIR0)-1)
 ;
 ;  Now, present query...
 N DIR
 S DIR(0)=YSQDIR0
 S X=$E(DIR(0)),DIR("A")=$S(X="L"&(YSQNCH>1):"Select one or more modifiers",1:"Select modifier")
 D ^DIR
 S YSAX=X,YSAY=Y
 ;
 S YSUOUT=(X[U) QUIT:YSUOUT  ;->
 ;
 ;  Set OK now... Users should be allowed to "return past" any query...
 S YSOK=1
 ;
 ;  Note!!
 ;  FO-DIR call results are the same whether user timed out, or if
 ;  the user "returned past":  DIRUT=1, $T=1, X=""
 I YSAX']"" K YSQCH QUIT  ;->
 ;
 ;  Build User Selection array & Kill YSQCH array elements not selected...
 K YSQUSEL
 F YSI=1:1:$L(YSAY,",") S YSX=$P(YSAY,",",+YSI) I YSX]"" S YSQUSEL(YSX)=""
 ;
 ; YSQXIEN stores the response IEN
 ; If response is non-numeric (eg., Y/N), that response's IEN must
 ; be found.  That is why the response string (YSQXRS) must be found;
 ; to be able to match...
 ;
 S YSQXIEN=0
 F  S YSQXIEN=$O(YSQCH(+YSQIEN,YSQXIEN)) QUIT:YSQXIEN']""  D
 .  S YSQXRS=$P($G(^DIC(627.9,+YSQIEN,1,+YSQXIEN,0)),U) ;Resp "string"
 .  I '$D(YSQUSEL(YSQXRS)) KILL YSQCH(+YSQIEN,YSQXIEN)
 ;
 QUIT
 ;
EOR ;YSDX3UC-Continuation of Utilities for Diagnosis Entry in the MH Medical Record ;9/7/94 14:51
