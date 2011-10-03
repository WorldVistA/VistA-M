PSXUTL ;BIR/BAB,WPB,HTW-Utility Subroutines ;14 Feb 2002  2:27 PM
 ;;2.0;CMOP;**3,38**;11 Apr 97
 ;Reference to ^PS(54   supported by DBIA #2227
 ;Reference to ^PSDRUG( supported by DBIA #1983
 ;
HEX ;converts decimal #<128 to a two byte hex #
 ;requires PSXHEX = decimal # to be converted
 ;returns PSXHEX = hex #, if error PSXHEX=""
 N %,H,H1,H2 S %=PSXHEX
 I (%<0)!(%>127)!(%'=+%) S PSXHEX="" Q  ;error if # not between 0 - 127
 I %<10 S PSXHEX=0_% Q  ;if # < 10 result is trivial, pad with zero
 S H=%\16 S:H>9 H=$E("         ABCDEF",H) S H1=H
 S H=%#16 S:H>9 H=$E("         ABCDEF",H) S H2=H
 S PSXHEX=H1_H2
 Q
FLUSH1 N X,X1,X2,N S N=0
 ; the *READ is for the CMOP vendors CPU only
 S X=$P($H,",",2) F  R *X2:0 Q:'$T  S N=N+1 S X1=$P($H,",",2) S:X1<X X1=X1+86400 Q:(X1-X)>20
 Q
 ;check to see if a timer has expired
 ;requires PSXTM = PSXTMx where x is A, B, D or E
 ;returns PSXTMOUT=1 if timer has expired, otherwise PSXTMOUT=0
CHKA S DELTA=PSXDLTA,PSXTM=PSXTMA G CHK
CHKB S DELTA=PSXDLTB,PSXTM=PSXTMB G CHK
CHKD S DELTA=PSXDLTD,PSXTM=PSXTMD G CHK
CHKE S DELTA=PSXDLTE,PSXTM=PSXTME
CHK N %
 S %=$P($H,",",2) S:%<PSXTM %=%+86400
 S PSXTMOUT=$S(%'>(PSXTM+DELTA):0,1:1)
 K DELTA
 Q
LOG ;create a log entry in the CMOP INTERFACE file
 ;requires the LOG() array with the text of the MESSAGE
 N X,Y
 H 1
 D NOW^%DTC K %I,%H
 K DIC,DD,DO
 S X=%,DINUM=9999999-X,DIC="^PSX(553,"_1_",""X"",",DIC(0)="Z"
 D FILE^DICN G:$P(Y,"^",3)'=1 LOG
 L +^PSX(553,1,"S"):DTIME Q:'$T
 S X="" F %=1:1 S X=$O(LOG(X)) Q:'X  S ^PSX(553,1,"X",+Y,"X",%,0)=LOG(X)
 S %=%-1,^PSX(553,1,"X",+Y,"X",0)="^^"_%_"^"_%_"^"_$P(+Y(0),".")
 L -^PSX(553,1,"S")
 K DD,DO,DUOUT,DTOUT,X,Y,DIC,DINUM,%,DLAYGO
 Q
TSOUT ;convert current date time to HL7 timestamp
 ;returns PSXTS= YYYYMMDDHHMM
 D NOW^%DTC
 S %=$E($P(%,".",2),1,6)
 S PSXTS=(1700+$E(X,1,3))_$E(X,4,7)_%_$E("0000",1,4-$L(%))
 K %,%H,%I
 Q
TSIN ;convert an HL7 timestamp to fileman format
 ;returns e.g. PSXFM=2910305.213
 ;requires PSXTS as input with YYYYMMDDHHMM format
 I $G(PSXTS)']""!($L(PSXTS)<7) S PSXFM=""
 N X S X=$E(PSXTS,9,14) S PSXFM=$E(PSXTS,1,2)-17_$E(PSXTS,3,8)_$S(+X:+("."_X),1:"")
 Q
STATUS ;display CMOP status for entry action on RX menu
 N PSXSTAT,PSXTXT
 S PSXSTAT=$G(^PSX(553,1,"S"))
 Q:$G(PSXSTAT)=""
 S PSXTXT="CMOP Interface is "_$S(PSXSTAT="R":"RUNNING!!!",1:"Stopped.")
 W !!,?((IOM\2)-($L(PSXTXT)\2)-3),PSXTXT
 K PSXSTAT,PSXTXT
 Q
EXIT K DIC,DIE,Y,DR,DA
 Q
DRUGW ;
 F Z0=1:1 Q:$P(X,",",Z0,99)=""  S Z1=$P(X,",",Z0) W:$D(^PS(54,Z1,0)) ?35,$P(^(0),"^"),! I '$D(^(0)) W ?35,"NO SUCH WARNING LABEL" K X Q
 Q
DRG ;     
 F X=0:0 S X=$O(^PSDRUG(X)) Q:'$G(X)  I $D(^PSDRUG(X,5)) D
 .S XX=$P(^PSDRUG(X,5),"^"),^(5)=XX K XX
 Q
UNMARK ;Entry point to unmark drug for CMOP dispense
 N PSX,Z,%
 S $P(^PSDRUG(PSXCK,3),"^",1)=0 K ^PSDRUG("AQ",PSXCK)
 S:'$D(^PSDRUG(PSXCK,4,0)) ^PSDRUG(PSXCK,4,0)="^50.0214DA^^"
 S (PSX,Z)=0 F  S Z=$O(^PSDRUG(PSXCK,4,Z)) Q:'Z  S PSX=Z
 S PSX=PSX+1 D NOW^%DTC S ^PSDRUG(PSXCK,4,PSX,0)=%_"^E^"_DUZ_"^CMOP Dispense^"_$S($G(^PSDRUG(PSXCK,3))=1:"YES",$G(^PSDRUG(PSXCK,3))=0:"NO",1:"")
 S $P(^PSDRUG(PSXCK,4,0),"^",3)=PSX,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 K PSX,Z,%
 Q
RALRT S XQAMSG=PSXFILE_" file is in use. Transmission not completed. Contact IRM." D GRP1^PSXNOTE,SETUP^XQALERT K PSXFILE,XQALERT,XQA,XQAMSG Q
SETVER S DIC="9.4",X="OUTPATIENT PHARMACY",DIC(0)="MOZX" D ^DIC D:$G(Y)'>0 ALRT Q:$G(Y)'>0  S XDA=+$G(Y) K X,Y,DIC,DIC(0)
 S DA=XDA,DIQ="PSXUTL1",DIQ(0)="I",DIC="9.4",DR="13" D EN^DIQ1 S PSXV=+$G(PSXUTL1(9.4,XDA,13,"I")) D:$G(PSXV)'>0 ALRT K DA,XDA,DIQ,DIQ(0),DIC,X,Y,PSXUTL1 S PSXVER=$S($G(PSXV)>"6.0":1,1:"")
 Q
ALRT S XQAMSG="Package file entry for Outpatient Pharamacy is corrupt" D GRP1^PSXNOTE,SETUP^XQALERT K PSXFILE,XQALERT,XQA,XQAMSG S PSXER=$G(PSXER)_"^"_12 D ER1^PSXERR K PSXER Q
 ;
GETS(FILE,IENS,DR,FORM,TARG,ERR) ;
 S IENS=$$IENS(IENS)
 I $D(ERR) D GETS^DIQ(FILE,IENS,DR,FORM,TARG,ERR) I 1
 E  D GETS^DIQ(FILE,IENS,DR,FORM,TARG)
 D TOP(TARG)
 Q
IENS(IENS) ;Resolve IENS to numbers X,Y,Z to 89,34,345
 N I,X
 F I=1:1 S X=$P(IENS,",",I) Q:X=""  D
 . I X'=+X F  S X=@X I X=+X S $P(IENS,",",I)=X Q
 Q IENS
 ;
TOP(TARGROOT) ; Move to the top the returned DIQ array
 ; Move  array(file,iens,field)=value to array(field)=value
 ; also moves the ,field,"I") =value(internal) to (field)=value(internal)
 Q:'$D(@TARGROOT)
 N FILE,IENS,FLD
 S FILE=$O(@TARGROOT@(""))
 S IENS=$O(@TARGROOT@(FILE,""))
 S FLD=+$O(@TARGROOT@(FILE,IENS,""))
 M ^TMP($J,"TOP")=@TARGROOT@(FILE,IENS)
 K @TARGROOT
 M @TARGROOT=^TMP($J,"TOP")
 K ^TMP($J,"TOP")
 ; if form is of xx(FLD,"I") move value to xx(FLD)
 I $O(@TARGROOT@(FLD,""))="I" D
 . S FLD=0 F  S FLD=$O(@TARGROOT@(FLD)) Q:FLD'>0  D
 .. S @TARGROOT@(FLD)=@TARGROOT@(FLD,"I") K @TARGROOT@(FLD,"I")
 Q
 ;
PIECE(REC,DLM,XX) ; where XX = VAR_U_I  ex: XX="PATNM^1"
 ; Set VAR = piece I of REC using delimiter DLM
 N Y,I S Y=$P(XX,U),I=$P(XX,U,2),@Y=$P(REC,DLM,I)
 Q
SET(REC,DLM,ABCD) ; where XX = VAR_U_I  ex: XX="PATNM^1"
 ; Set VAR into piece I of REC using delimiter DLM
 N Y,I S Y=$P(ABCD,U),I=$P(ABCD,U,2)
 I Y'=+Y,Y'="" S $P(REC,DLM,I)=$G(@Y) I 1
 E  S $P(REC,DLM,I)=Y
