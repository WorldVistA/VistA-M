GMRCU ;SLC/DLT - Consult/Request Utilities ;5/20/98  14:21
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
MTIM ;CONVERT TIME from X=2890313.1304 INTO X=13:04
 S X=$P(X,".",2) Q:'$L(X)
 S X=$S(X:$E(X,1,2)_$E("00",0,2-$L($E(X,1,2)))_":"_$E(X,3,4)_$E("00",0,2-$L($E(X,3,4))),1:"")
 Q
REGDT ; Receives X in internal date.time, and returns X in MM/DD/YY format
 S X=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 Q
REGDTM ;Receives X in internal date.time, and returns X in MM/DD/YY TT:TT
 N T
 S T=$P(X,".",2),X=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")_" "_$S(T:$E(T,1,2)_$E("00",0,2-$L($E(T,1,2)))_":"_$E(T,3,4)_$E("00",0,2-$L($E(T,3,4))),1:"")
 Q
SIDT ; Receives X as internal date/time and returns X in DD MMM YY
 N MON,MM
 S X=$P(X,".") I 'X S X="" Q
 S MON="JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC"
 S MM=$E(X,4,5),MM=$S(MM:$P(MON,U,MM),1:"")
 S X=$E(X,6,7)_" "_MM_" "_$E(X,2,3)
 Q
FMHL7DTM ; Recieves X as internal date/time and returns X in CCYYMMDDHHMM
 N T
 S T=$P(X,".",2)
 S T=$S(T:$E(T,1,2)_$E("00",0,2-$L($E(T,1,2)))_$E(T,3,4)_$E("00",0,2-$L($E(T,3,4))),1:"0000")
 S X=($E($P(X,"."),1,3)+1700)_$E($P(X,"."),4,7)_T
 Q
HL7FMDTM ; Recieves X as CCYYMMDDHHMM and returns X as internal date/time
 N DATE,TIME
 S DATE=$E(X,1,8),TIME=$E(X,9,12)
 S DATE=DATE-17000000,X=DATE_"."_TIME
 Q
DEM ; Gets Demographic Data from VADPT
 ; Receives: DFN
 ; Returns: GMRCPNM,GMRCSN,GMRCDOB,SEX,GMRCWARD,GMRCRB,GMRCAGE
 ; and GMRCWLI,GMRCHLI
 K VAINDT,VAHOW D OERR^VADPT
 S GMRCPNM=VADM(1)
 S GMRCSN=$S($D(VA("PID")):VA("PID"),1:$P(VADM(2),"^",2))
 S GMRCAGE=VADM(4),SEX=$P(VADM(5),"^")
 S GMRCWARD=$P(VAIN(4),"^",2),GMRCRB=VAIN(5),GMRCWLI=$P(VAIN(4),"^",1)
 S GMRCDOB=$P(VADM(3),"^",2)
 K VA,VAIN,VADM,VAERR
 Q
MD ; Format physician names ;4/4/89  11:39 ;
 ; Recieves: IFN for New Person file as PR and desired name length, as NML
 ; Returns: Lastname,FI to specified length as PR
 N PRFI,PRLN,PRNM
 S PRNM=$S(PR:$S($D(^VA(200,+PR,0)):$P(^(0),"^"),1:"UNKNOWN"),1:"UNKNOWN")
 I PRNM?1A.A." ".A1",".A.E S PRLN=$P(PRNM,","),PRFI=$E($P(PRNM,",",2),1) I $L(PRLN)>(NML-2) S PRLN=$E(PRLN,1,(NML-2))
 S PR=$S(PRNM="UNKNOWN":PRNM,1:PRLN_","_PRFI)
 Q
NAME ; Format names ;6/30/89  11:20 ;
 ; Recieves: FILE (3 for User, 16 for Person, 6 for Provider)
 ;           IFN (Internal file # for above file),
 ;           NML (Desired length for name to be returned)
 ;           FNF (Flag to specify first name format: 0 for FI, 1 for FN)
 ; Returns: Lastname,First(name/initial) to specified length as NM
 ;
 N DIC,RAWNM,LN,FN,FA,NI,CH,X,Y
 S DIC=FILE,DIC(0)="NXZ",X=IFN D ^DIC S RAWNM=$S($D(Y(0,0)):Y(0,0),1:"UNKNOWN")
 S LN=$P(RAWNM,","),FN=$P(RAWNM,",",2)
 S FA=0 I $L(FN) F NI=1:1 S CH=$E(FN,NI) Q:CH?1A  S FA=NI
 I FA S FN=$E(FN,FA+1,$L(FN))
 I 'FNF S FN=$E(FN,1)
 S NM=$S($L(FN):LN_","_FN,1:LN),NM=$E(NM,1,NML)
 K FILE,IFN,NML,FNF
 Q
PTRCLN ;Clean out subservice 'B' X-reference of deleted entries
 S I=0 F  S I=$O(^GMR(123.5,I)) Q:I<1  I $D(^(I,10,0)) S J=0 F  S J=$O(^GMR(123.5,I,10,J)) Q:J<1  S ENTRY=+^(J,0) I '$D(^GMR(123.5,ENTRY,0)) K ^GMR(123.5,I,10,J,0),^GMR(123.5,I,10,"B",ENTRY) D
 .S CNT=$P(^GMR(123.5,I,10,0),"^",4),$P(^(0),"^",4)=CNT-1
 K CNT,ENTRY,I,J Q
