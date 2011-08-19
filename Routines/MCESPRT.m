MCESPRT ;WISC/DCB-ELECTRONIC SIGNATURE PRINT ;6/26/96  12:51
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
FOOTER(MCFILE,MCARGDA) ;
 I $Y>(IOSL-12) D  Q:$G(MCOUT)
 .S MCY="" R:$E(IOST,1,2)="C-" !!,"Press return to continue, '^' to escape: ",MCY:DTIME S:'$T MCY=U S:MCY=U DN=0,MCOUT=1 D:DN HEAD^MCARP K MCY
 D DISPLAY
 Q
DISPLAY ;
 N CODE,ERROR,PART,PDUZ,SCRAMBLE,SDUZ,TDATE,TEMP,TRUE,TP,DIC,DR,DA,DIQ
 N ENAME,EES,EDATE,VNAME,VES,VDATE,CODE,RELDATE,VERDATE,NA,MFD,MFDNAME,SUPD,CREATION,SUPNUM,SUPNUM,SUP1,SUP2,ROV,VERSION
 N FT,FTYPE,FNAME,PERSON,DTEMP,X,X1,X2
 I '$D(^MCAR(MCFILE,MCARGDA,"ES")) Q
 S TEMP=$G(^MCAR(MCFILE,MCARGDA,"ES"))
 ; Retrieve RC/ES Field (NA = Dont need"
 S NAME="ENAME^NA^EDATE^VNAME^VES^VDATE^CODE^RDATE^VDATE^SUP1^SUP2^MFD^MFDNAME^SUPD^CREATION^SUPNUM",FTYPE="P^X^D^P^F^D^F^D^D^F^F^F^P^D^D^F"
 F TT=1:1:16 D  S Y=$P(TEMP,U,TT),FT=$P(FTYPE,U,TT),FNAME=$P(NAME,U,TT) D DATE:FT="D",NAME:FT="P",FREE:FT="F"
 S MCSTAT=$S(MFD:" Mark for Deletion",1:"X")
 S:MCSTAT="X" MCSTAT=$$STATUS^MCESEDT(MCFILE,CODE)
 S SCD=$S(MFD:EDATE,CODE["RV":VDATE,CODE["ROV":VDATE,CODE="RNV":RDATE,CODE="S":EDATE,1:EDATE)
 S PERSON=$$DECODE(TEMP,CODE,MCFILE,MCARGDA)
 S ROV=$S(CODE["ROV":"Signing for "_VNAME,1:""),SUPNUM=+SUPNUM,TSUP2=SUP2,SUPNUM=SUPNUM+1
 S:'SUP2 NUM=SUPNUM
 D:SUP2 VERSION
 S VERSION=SUPNUM_" of "_NUM
 S $P(SS," -",40)="" W !!!,SS K SS
 W !,?18,"R e p o r t   R e l e a s e   S t a t u s",!
 W !,"Current ",?19,"Date   ",?28,"Person Who  "
 W !,"Report  ",?19,$S(CODE["D":"Last",1:"Status"),?28,"Last "_$S(CODE["D":"Edited",1:"Changed"),?59,"Date of",?70,"Report"
 W !,"Status  ",?19,$S(CODE["D":"Edited",1:"Changed"),?28,$S(CODE["D":"Procedure",1:"The Status"),?59," Entry ",?70,"Version"
 S $P(SS,"=",80)="" W !,SS K SS
 W !,MCSTAT
 W !,?19,SCD,?28,PERSON,?59,CREATION,?70,VERSION
 W !,?28,ROV
 K MCFILE1
 Q
 ;Get and convert name and date
NAME S Y=$P($G(^VA(200,+Y,0)),U,1),@FNAME=$P(Y,",",2)_" "_$P(Y,",",1) Q
DATE S @FNAME=+$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E((1700+$E(Y,1,3)),3,4) Q
FREE S @FNAME=Y Q
VERSION ; Find the version number of a procedure
 F NUM=SUPNUM:1 D CHECK Q:TSUP2=0
 S NUM=NUM+1
 Q
CHECK ; Find the number of times the report was superseded
 S DTEMP=$G(^MCAR(MCFILE,TSUP2,"ES"))
 S TSUP2=+$P(DTEMP,U,11)
 Q
ENCODE(FILE,REC) ;Encode Validation Code
 N CR,STR
 S CR=$P($G(^VA(200,DUZ,20)),U,2)
 S STR=$$SUM($G(^MCAR(FILE,REC,0)))
 ;Q $$ENCODER(CR,DUZ,STR)
 Q $$ENCODER(CR,DUZ,REC)
ENCODER(X,X1,X2) ;Encode
 D EN^XUSHSHP
 Q X
DECODE(TEMP,CODE,FILE,REC) ;Decode the Validation code 1
 N CR,PDUZ,STR,PER
 S PRE=+$P(TEMP,U,1) S:PRE=0 PRE=DUZ
 ;Q:(CODE="")!(CODE="D")!(CODE="PD")!(CODE="MFD") $P($G(^VA(200,PRE,0)),U,1)
 Q:(CODE="")!(CODE="D")!(CODE="PD")!(CODE="MFD")!(CODE="S") $P($G(^VA(200,PRE,0)),U,1)  ;HUN-1095-22932
 S CR=$P(TEMP,U,$S(CODE["RV":5,1:2))
 S PDUZ=$P(TEMP,U,$S(CODE["RV":4,1:1))
 S STR=$$SUM($G(^MCAR(MCFILE,REC,0)))
 ;Q $$DECODER(CR,PDUZ,STR)
 Q $$DECODER(CR,PDUZ,REC)
 ;
DECODER(X,X1,X2) ;Decode the signature name
 ;X is the signuture block name.
 ;X1 is the DUZ of the person log on.
 ;X2 is either the report # or a checksum value of the report.
 D DE^XUSHSHP
 Q X
SUM(MCX) ;Create checksum value for string
 N MCI,MCY
 S MCY=0 F MCI=1:1:$L(MCX) S MCY=$A(MCX,MCI)*MCI+MCY
 Q MCY
STATUS(MCFILE,MCARGDA) ; Get the status for the header
 N CODE,TEMP,MFD
 S TEMP=$G(^MCAR(MCFILE,MCARGDA,"ES"))
 S CODE=$P(TEMP,U,7)
 S MFD=+$P(TEMP,U,12)
 S MCSTAT=$S(MFD:"Mark for Deletion",1:"X")
 S:MCSTAT="X" MCSTAT=$$STATUS^MCESEDT(MCFILE,CODE)
 S MCARZ=MCARZ_" - "_MCSTAT
 Q
