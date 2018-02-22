XVEMRIE ;DJB/VRR**INSERT - Programmer Call cont.. [1/15/96 10:52pm];2017-08-15  1:57 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
CODE ;Set CD array to Call code
 NEW CHK,I,LIMIT,RTN,TMP
 ;LIMIT=How many params/vars are there?
 ;  CHK=Quit if none have data
 S (CHK,LIMIT)=0,CD=""
 ;--> Set TMP array with values
 F I=1:1 Q:$P($G(^XVV(19200.113,CALL,"P")),U,I)']""  D  ;
 . S TMP(I)=$G(^XVV(19200.113,CALL,"V"_I))
 . S:TMP(I)]"" CHK=1 S LIMIT=LIMIT+1
 I 'LIMIT!('CHK) S FLAGQ=1 Q
 S RTN=$G(^XVV(19200.113,CALL,"RTN")) I RTN']"" S FLAGQ=1 Q
 S:RTN'["^" RTN="^"_RTN
 I $P($G(^XVV(19200.113,CALL,0)),U,4)'="v" D CODEP Q
 D CODEV
 Q
CODEP ;A Call that uses parameters
 NEW I,PARAM
 ;--> Delete right most params that have no data
 F I=LIMIT:-1:1 Q:TMP(I)]""  KILL TMP(I)
 S PARAM="" F I=1:1:LIMIT Q:'$D(TMP(I))  D  ;
 . S:TMP(I)']"" TMP(I)=""""""
 . S PARAM=PARAM_TMP(I)_$S($D(TMP(I+1)):",",1:"")
 S CD(1)=$S($E(RTN)="$":"W ",1:"D ")_RTN_"("_PARAM_")"
 Q
CODEV ;A Call that uses variables
 NEW CNT,I,LN,VAR
 S CNT=1 F I=1:1:LIMIT D  ;
 . Q:TMP(I)']""
 . S VAR=$P($G(^XVV(19200.113,CALL,"P")),U,I) Q:VAR'>0
 . S VAR=$P($G(^XVV(19200.114,VAR,0)),U,1) Q:VAR']""
 . ;->FM doesn't allow ["^] in .01. Convert ['~].
 . S VAR=$TR(VAR,"'~","""^")
 . S LN(CNT)=VAR_"="_TMP(I),CNT=CNT+1
 S LN(CNT)=RTN,LIMIT=CNT
 S CNT=1,CD(CNT)="" F I=1:1 Q:'$D(LN(I))  D  ;
 . I I=1 S CD(CNT)="S "_LN(I) Q  ;..............SET VARIABLE
 . I I=LIMIT S CNT=CNT+1,CD(CNT)="D "_LN(I) Q  ;DO RTN
 . ;--> Next, either append next variable or start new line. Allow
 . ;    for 9 spaces in the line tag area.
 . I ($L(CD(CNT))+$L(LN(I))<66) S CD(CNT)=CD(CNT)_","_LN(I) Q
 . S CNT=CNT+1,CD(CNT)="S "_LN(I)
 Q
 ;====================================================================
DELETE ;Delete previous VALUEs for this Call.
 NEW ASK,DA,DDH,DIE,DQ,DR,X,Y
 W ! S ASK=$$ASK^XVEMKU("Delete previous values",1)
 S:ASK="^" FLAGQ=1 Q:ASK'="Y"
 S DIE="^XVV(19200.113,",DA=CALL
 S DR="61///@;62///@;63///@;64///@;65///@;66///@;67///@;68///@;69///@;70///@;71///@;72///@;73///@"
 D ^DIE
 Q
 ;====================================================================
EXTHELP(PC) ;Extended Help Text
 ;PC=Global piece that contains Parameter pointer.
 Q:'$G(DDS)  Q:$G(PC)'>0
 NEW CHK,FLAGQ,HD,I,INT,LINE,LN
 S DDSERROR=1
 S HD="E X T E N D E D   H E L P",$P(LINE,"=",79)=""
 W @IOF,!?(IOM-$L(HD)\2),HD,!,LINE
 S INT=+$P($G(^XVV(19200.113,DA,"P")),U,PC) ;Parameter
 S (CHK,FLAGQ,LN)=0
 F  S LN=$O(^XVV(19200.114,INT,"WP1",LN)) Q:LN'>0!FLAGQ  D  ;
 . W !?1,$G(^(LN,0)) S CHK=1
 . Q:$Y'>(IOSL-5)  Q:$O(^XVV(19200.114,INT,"WP1",LN))'>0
 . D PAUSE^XVEMKU(2,"Q") W:'FLAGQ @IOF
 I 'CHK D  ;
 . W !!?1,"There is no EXTENDED HELP for this field."
 . W !?1,"Fields with EXTENDED HELP will display '--> H=Help' in the Command Area."
 I 'FLAGQ D  ;
 . F I=$Y:1:(IOSL-5) W !
 . D PAUSE^XVEMKU(2,"P")
 D REFRESH^DDSUTL
 Q
