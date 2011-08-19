ABSVU2 ;VAMC ALTOONA/CTB - MISC UTILITY ROUTINES ;5/2/00  9:32 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;**7,10,15,18**;JULY 6, 1994
 ;ENTRY TO PLACE VALUES OF FIELDS INTO VARIABLES
 ;REQUIRES INPUT OF DIC, DA, DR, X
 ;DIC = FILE NUMBER OR GLOBAL ROOT
 ;DA = INTERNAL RECORD NUMBER
 ;DR = LIST OF FIELD NUMBERS DELIMITED WITH ';'
 ;X = LIST OF VARIABLE NAMES MAPPED TO FIELDS IN DR
 ;    NOTE VARIABLE NAME ALONE IMPLIES EXTERNAL
 ; IF BOTH INTERNAL AND EXTERNAL VALUES ARE REQUIRED, ';' PIECE
 ;    SHOULD BE  "VNAME,I,VNAME2,E;" OR "VNAME,,VNAME2,I;
 ;DIQ OPTIONAL VARIABLE CONTAINING GLOBAL ROOT IE ^TMP( .  STORE
 ;  ERROR COULD OCCUR FOR EXTREMELY LONG EXTRACTIONS.  SETTING
 ;  DIQ WILL FORCE PROGRAM TO PLACE DATA IN GLOBAL
 ;USES VARIABLE ARRAY TMP FOR TEMPORARY STORAGE UNLESS OVERRIDEN BY
 ;  GLOBAL ROOT IN DIQ
EXT(DIC,DA,DR,X,DIQ)         ;
EN1 N TMP,I,FN,FNX,ZX,ZY,N,DAX,DRX,D0,S,C
 S ZX=X I $O(X(0)) S N=0 F  S N=$O(X(N)) Q:'N  S ZX(N)=X(N)
 S U="^",DIQ(0)=$S(X[",I":"EI",1:"E") S:$G(DIQ)="" DIQ="TMP("
 D EN^DIQ1
 S FN=+$P($G(@(DIC_"0)")),"^",2) Q:'FN
 I $O(DA(0)) S N=0 F  S N=$O(DA(N)) Q:'N  S FN(N)=N
 F I=1:1 Q:$P(ZX,";",I)=""  D
  . S ZY=$P(ZX,";",I)
  . Q:ZY=""
  . S S=";",C="," X "S "_$P(ZY,",")_"=$G("_DIQ_"FN,DA,$P(DR,S,I),$S($P(ZY,"","",2)[""I"":""I"",1:""E"")))"
  . I $P(ZY,",",3)]"" S ZY=$P(ZY,",",3,4) X "S "_$P(ZY,",")_"=$G("_DIQ_"FN,DA,$P(DR,S,I),$S($P(ZY,"","",2)[""I"":""I"",1:""E"")))"
  . Q
 I $O(FN(0)) S N=0 F  S N=$O(FN(N)) Q:'N  D
  . Q:FN(N)=""  S FNX=FN(N)
  . Q:($G(DR(FNX))="")!($G(DA(FNX))="")!($G(ZX(FNX))="")
  . S ZX=ZX(FNX),FNX=FN(N),DAX=DA(FNX),DRX=DR(FNX)
  . F I=1:1 Q:$P(ZX,";",I)=""  D
  . . S ZY=$P(ZX,";",I)
  . . Q:ZY=""
  . . X "S "_$P(ZY,",")_"=$G("_DIQ_"FNX,DAX,$P(DRX,"";"",I),$S($P(ZY,"","",2)[""I"":""I"",1:""E"")))"
  . . I $P(ZY,",",3)]"" S ZY=$P(ZY,",",3,4) X "S "_$P(ZY,",")_"=$G("_DIQ_"FNX,DAX,$P(DRX,"";"",I),$S($P(ZY,"","",2)[""I"":""I"",1:""E"")))"
  . . Q
 I $E(DIQ,$L(DIQ))="," K @($E(DIQ,$L(DIQ)-1)_")")
 I $E(DIQ,$L(DIQ))="(" K @($E(DIQ,$L(DIQ)-1))
 Q
LZF(STRING,LENGTH) ;LEFT ZERO FILL STRING IN A FIELD LENGTH OF LENGTH
 N X
 S $P(X,"0",LENGTH)="0",STRING=X_STRING
 Q $E(STRING,$L(STRING)-(LENGTH-1),$L(STRING))
RZF(STRING,LENGTH) ;RIGHT ZERO FILL STRING IN A FIELD LENGTH OF LENGTH
 N X
 S $P(X,"0",LENGTH)=0,STRING=STRING_X
 Q $E(STRING,1,LENGTH)
LBF(STRING,LENGTH) ;LEFT BLANK FILL STRING IN A FIELD LENGTH OF LENGTH
 N X
 S $P(X," ",LENGTH)=" ",STRING=X_STRING
 Q $E(STRING,$L(STRING)-(LENGTH-1),$L(STRING))
RBF(STRING,LENGTH) ;RIGHT BLANK FILL STRING IN A FIELD LENGTH OF LENGTH
 N X
 S $P(X," ",LENGTH)=" ",STRING=STRING_X
 Q $E(STRING,1,LENGTH)
DIR() ;SET VARIABLE STRING RETURNING FROM DIR
 NEW X
 S X=$D(DTOUT)_$D(DUOUT)_$D(DIRUT)_$D(DIROUT)
 K DTOUT,DUOUT,DIRUT,DIROUT
 Q X
 ;
FULLDAT(Y) ;CONVERTS FILEMAN INTERNAL DATE TO EXTERNAL FORMAT
 S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".")
 Q Y
 ;
EXTSSN(X) ;RETURNS EXTERNAL VALUE OF SSN
 I X'?9N Q X
 Q $E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,9)
 ;
LOWER(X) ;RETURNS STRING X IN LOWER CASE
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
UPPER(X) ;RETURNS STRING X IN UPPER CASE
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
AGE(X2,X1) ;extrinsic function  returns current age based on date X
 N %,%H,%I,%T,X,%Y
 I $G(X1)="" D NOW^%DTC S X1=X
 D ^%DTC
 Q X\365.25
SETOFCDS ;display set of codes
 N X,LN,Y
 Q:$P($G(DIR(0)),"^",1)'["S"
 W !,"Select From:",!
 S X=$P(DIR(0),"^",2)
 F LN=1:1 Q:$P(X,";",LN)=""  S Y=$P(X,";",LN) W !?5,$P(Y,":"),?15,$P(Y,":",2)
 QUIT
 ;
ACTIVE(DA,INST,SILENT) ;extrinsic function to determine termination status of volunteer.
 ;sets $T=1 if active, $T=0 if terminated
 I '$D(SILENT) S SILENT=0
 I '$D(^ABS(503330,DA,4,INST,0)) S X="Volunteer is not a registered volunteer for station "_ABSV("SITE")_".  No actions are allowed." D:'SILENT MSG^ABSVQ Q 0
 I $P($G(^ABS(503330,DA,4,INST,0)),"^",8)]"" S X="Volunteer has been terminated.  No actions allowed.*" D:'SILENT MSG^ABSVQ Q 0
 Q 1
VPHONE(X) ;extrinsic function, for validating telephone numbers
 NEW ABSVX
 I X="" Q 0
 I X?7N Q 1
 I X?3N1"-"4N Q 1
 I X?10N Q 1
 I X?3N1"-"3N1"-"4N Q 1
 I X?7N1" ".6UN Q 1
 I X?3N1"-"4N1" ".6UN Q 1
 I X?10N1" ".6UN Q 1
 I X?3N1"-"3N1"-"4N1" ".6UN Q 1
 Q 0
PHONEOUT(X) ;extrinsic function to print phone number
 I $E(X,1,10)?10N Q $E(X,1,3)_"-"_$E(X,4,6)_"-"_$E(X,7,99)
 I $E(X,1,7)?7N Q "    "_$E(X,1,3)_"-"_$E(X,4,99)
 I X?10N1" ".6UN Q $E(X,1,3)_"-"_$E(X,4,6)_"-"_$E(X,7,99)
 I X?3N1"-"4N Q "    "_X
 I X?3N1"-"4N.1" ".6UN Q "    "_X
 Q X
REMPUNC(X) ;REMOVE PUNCTUATION FROM STRING FOR MAILING
 N Y,Z
 S Y="~`!@#$%^&*()_+={}[]:;'|\<>.?/"_""""
 S X=$TR(X,Y,"")
 Q $TR(X,",-","  ")
REP(DA,SITE) ;This function will determine if a volunter is a vavs representative
 ;for the medical center.  Determination is based on the combination
 ;code containing the characters 'R135A'
 N M,N,X
 S (M,X)=0
 F  S M=$O(^ABS(503330,DA,1,M)) Q:'M  S N=$G(^(M,0)) I $P(N,"-",1)=SITE,$P(N,"^",5)["R135A" S X=1 QUIT
 Q X
LINE(X) ;This function will return a line of X length
 N Y
 S $P(Y,"_",X+1)=""
 Q Y
DELFILE ;DELETE DATA FOR FILE 503339.2
 S X=$P(^ABS(503339.2,0),"^",1,2)
 K ^ABS(503339.2) S ^ABS(503339.2,0)=X
