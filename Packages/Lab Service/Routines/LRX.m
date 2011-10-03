LRX ;SLC/BA/DALISC/FHS - UTILITY ROUTINES -- PREVIOUSLY ^LAB("X","...") ;2/8/91  07:30
 ;;5.2;LAB SERVICE;**65,153,201,217,290,360**;Sep 27, 1994;Build 1
PT ;patient info
 ;
 N X,I,N,Y
 D KVAR^VADPT
 K LRTREA,LRWRD,AGE S (AGE,PNM,SEX,DOB,DOD,SSN,VA200,LRWRD,LRRB,LRTREA,VA("PID"),VA("BID"))=""
 I $G(LRDFN),'$G(LRDPF),$G(^LR(LRDFN,0)) S LRDPF=$P(^(0),U,2),DFN=$P(^(0),U,3)
 S LREND=0 S:$G(DFN)<1!('$G(LRDPF)) LREND=1 Q:$G(LREND)
 I +$G(LRDPF)'=2 D
 . S X=$$GET1^DID(1,+LRDPF,"","GLOBAL NAME","ANS","ANS1")
 . S X=X_DFN_",0)",X=$S($D(@X):@X,1:""),LRWRD=$S($D(^(.1)):$P(^(.1),U),1:0),LRRB=$S($D(^(.101)):$P(^(.101),U),1:""),DOD=$S($D(^(.35)):$P(^(.35),U),1:"")
 . S PNM=$P(X,U),SSN=$P(X,U,9) Q:+$G(LRDPF)=62.3
 . S SEX=$P(X,U,2),SEX=$S(SEX="":"M",1:SEX)
 . S DOB=$P(X,U,3)
 . S AGE=$S($D(DT)&(DOB?1(7N,7N1".".6N)):DT-DOB\10000,1:"??")
 . S AGE(2)=$$AGE2(DOB,$G(LRCDT)) ;Age of the patient when the specimen was collected (default =99Yr if no valid DOB present)
 . ;Default for LRCDT (collection date) is DT
 I +$G(LRDPF)=2 D
 . N I,X,N,Y
 . D OERR^VADPT D:'VAERR
 . . S PNM=VADM(1)
 . . S SEX=$P(VADM(5),U),DOB=$P(VADM(3),U),DOD=$P(VADM(6),U)
 . . S AGE=VADM(4),AGE(2)=$$AGE2(DOB,$G(LRCDT))
 . . S SSN=$P(VADM(2),U),LRWRD=$P(VAIN(4),U,2)
 . . S LRWRD(1)=+VAIN(4),LRRB=VAIN(5),LRPRAC=+VAIN(2)
 . . S:VAIN(3) LRTREA=+VAIN(3)
 D SSNFM^LRU
 Q
DEM ;Call DEM^VADPT instead of OERR used above
 N X,I,N,Y
 D KVAR^VADPT
 K LRTREA,LRWRD,AGE S (AGE,PNM,SEX,DOB,SSN,VA200,LRWRD,LRRB,LRTREA,VA("PID"),VA("BID"))=""
 I $G(LRDFN),'$G(LRDPF),$G(^LR(LRDFN,0)) S LRDPF=$P(^(0),U,2),DFN=$P(^(0),U,3)
 S LREND=0 S:$G(DFN)<1!('$G(LRDPF)) LREND=1 Q:$G(LREND)
 I +$G(LRDPF)'=2 D
 . S X=^DIC(+LRDPF,0,"GL")_DFN_",0)",X=$S($D(@X):@X,1:""),LRWRD=$S($D(^(.1)):$P(^(.1),U),1:0),LRRB=$S($D(^(.101)):$P(^(.101),U),1:"")
 . S PNM=$P(X,U),SEX=$P(X,U,2),SEX=$S(SEX="":"M",1:SEX),DOB=$P(X,U,3)
 . S AGE=$S($D(DT)&(DOB?1(7N,7N1".".6N)):DT-DOB\10000,1:"??")
 . S AGE(2)=$$AGE2(DOB,$G(LRCDT))
 . S SSN=$P(X,U,9)
 I +$G(LRDPF)=2 N I,X,N,Y D
 . D DEM^VADPT D:'VAERR
 . . S PNM=VADM(1),SEX=$P(VADM(5),U)
 . . S DOB=$P(VADM(3),U),SSN=$P(VADM(2),U)
 . . S AGE=VADM(4),AGE(2)=$$AGE2(DOB,$G(LRCDT))
 D SSNFM^LRU
 Q
DD ;date/time format
 S Y=$$FMTE^XLFDT(Y,"5Z")
 S Y=$P(Y,"@")_" "_$P($P(Y,"@",2),":",1,2)
 Q
DDOLD ;OLD
 I $E(Y,4,7)="0000" S Y=$S($E(Y)=2:"19"_$E(Y,2,3),1:"20"_$E(Y,2,3)) Q
 S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_$S(Y#1:" "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"")
 Q
DT ;current date format is LRDT0
 N X,DIK,DIC,%I,DICS,%DT
 D DT^DICRW
 S Y=$$FMTE^XLFDT(DT,"5D")
 S LRDT0=Y
 Q
DTOLD ;2-DIGIT
 ;current date format is LRDT0
 N X,DIK,DIC,%I,DICS,%DT
 D DT^DICRW
 S Y=$P(DT,".") D DDOLD S LRDTO=Y
 Q
DASH ;line of dashes
 W !,$E("--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",1,IOM-1)
 Q
EQUALS ;line of equals
 W !,$E("====================================================================================================================================================================================================================",1,IOM-1)
 Q
DUZ ;user info
 S (LRUSNM,LRUSI)="" Q:'$D(X)  Q:'$D(^VA(200,+X,0))  S LRUSNM=$P(^(0),"^"),LRUSI=$P(^(0),"^",2)
 Q
DOC ;provider info
 I $L(X),'X S LRDOC=X Q
 S LRDOC=$P($G(^VA(200,+X,0)),U)
 S:LRDOC="" LRDOC="Unknown"
 Q
PRAC(X) ;prac info
 N Y
 I $L(X),'X Q X
 S Y=$P($G(^VA(200,+X,0)),U)
 S:Y="" Y="Unknown"
 Q Y
YMD ;year/month/date
 S %=%H>21549+%H-.1,%Y=%\365.25+141,%=%#365.25\1,%D=%+306#(%Y#4=0+365)#153#61#31+1,%M=%-%D\29+1,X=%Y_"00"+%M_"00"+%D K %Y,%D,%M,%
 Q
STAMP ;time stamp
 S X="N",%DT="ET" D ^%DT
 Q
KEYCOM ;key to result flags
 D EQUALS W !!,"  ------------------------------  COMMENTS  ------------------------------",!,"  Key:  'L' = reference Low,  'H' = reference Hi, '*' = critical range"
 Q
URG ;urgencys
 K LRURG S LRURG(0)="ROUTINE" S I=0 F  S I=$O(^LAB(62.05,I)) Q:I<1  I $D(^(I,0)) S:'$P(^(0),U,3) LRURG(I)=$P(^(0),U)
 Q
ADD ;date format
 S Y=$E("JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC",$E(Y,4,5)*3-2,$E(Y,4,5)*3)_" "_$S(Y#100:$J(Y#100\1,2)_", ",1:"")_(Y\10000+1700)_$S(Y#1:"  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"")
 Q
INF ;Display Infectious Warning
 I $L($G(IO)),$D(^LR(LRDFN,.091)),$L(^(.091)),'$G(LRQUIET) W !,$C(7)," Pat Info: ",^(.091) Q
 Q
LRGLIN ;
 N HZ
 D GSET^%ZISS W IOG1
 F HZ=1:1:79 W IOHL
 W IOG0 D GKILL^%ZISS
 W !
 Q
LRUID(LRAA,LRAD,LRAN) ;Extrinsic function call to create a unique 
 ;accession identifier for an accession number.  See description
 ;of field .092 in file 68 for a full explanation of this number.   
 ;This function returns a value equal to the unique ID generated.
 ;LRAA=ien in file 68, accession area
 ;LRAD=ien for accession date in field 68.01
 ;LRAN=ien for accession number in field 68.02
 Q:$S('$G(LRAA):1,'$D(^LRO(68,LRAA,.4)):1,1:0) 0
 N DA,DIE,DLAYGO,DR,LRMNTH,LRUID,LRQTR,LRTYPE,LRYR1,LRYR2,LRJUL
 S LRUID=$P($G(^LRO(68,LRAA,.4)),"^") ;start building LRUID
 S:$L(LRUID)'=2 LRUID="0"_LRUID
 S LRTYPE=$P($G(^LRO(68,LRAA,0)),"^",3)
 S LRYR1=$E(LRAD,3)
 S LRYR2=$E(LRAD,2,3)
 S LRMNTH=$E(LRAD,4,5)
 S LRQTR=0_(LRMNTH\3.1+1)
 I "DW"[LRTYPE D
 . S X1=LRAD,X2=$E(LRAD,1,3)_"0101" D ^%DTC
 . S X=X+1,LRJUL=$E("000",1,3-$L(X))_X
 . S LRUID=LRUID_LRYR1_LRJUL
 . S LRUID=LRUID_$E("0000",1,4-$L(LRAN))_LRAN
 I LRTYPE="Y" D
 . S LRUID=LRUID_LRYR2_$E("000000",1,6-$L(LRAN))_LRAN
 I LRTYPE="Q" D
 . S LRUID=LRUID_LRYR1_LRQTR
 . S LRUID=LRUID_$E("00000",1,5-$L(LRAN))_LRAN
 I LRTYPE="M" D
 . S LRUID=LRUID_LRYR1_LRMNTH_$E("00000",1,5-$L(LRAN))_LRAN
 L +^LRO(68,"C"):99999
 I $D(^LRO(68,"C",LRUID)),'$D(^LRO(68,"C",LRUID,LRAA,LRAD,LRAN)) D
 . N X
 . S X=$E(LRUID,3,10)
 . F  S LRUID="00"_X Q:'$D(^LRO(68,"C",LRUID))  S X=X+1 S:X>99999999 X=11111111
 ;The following fields are also set in rtn LROLOVER
SET3 I $G(LRORDRR)'="R" S DR="16////"_LRUID
 I $G(LRORDRR)="R" D
 . S DR=";16.1////"_+$G(LRRSITE("RSITE"))_";16.2////"_+$G(LRRSITE("RPSITE"))_";16.3////"_LRUID_";16.4////"_LRSD("RUID")
 . I '$G(LRRSITE("IDTYPE")),'$D(^LRO(68,"C",LRSD("RUID"))) S LRUID=LRSD("RUID") ; Use sender's UID, unless previously used.
 . S DR="16////"_LRUID_DR
 S DA=LRAN,DA(1)=LRAD,DA(2)=LRAA,DIE="^LRO(68,"_DA(2)_",1,"_DA(1)_",1,",DLAYGO=68
 D ^DIE
 L -^LRO(68,"C")
 S LRORU3=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 Q LRUID
 ;
KVAR ;Kill laboratory/VADPT patient demographics
 K LRTREA,LRWRD,PNM,SEX,DOB,DOD,SSN,LRWRD,LRRB,LRTREA,VA,LRDFN,LRDPF,LREND,VAERR
 D KVA^VADPT
 Q
ADDPT ;Returns VAPA( Patient data
 N X,I,N,Y D ADD^VADPT Q
OPDPT ;Returns VAPD( Patient data
 N X,I,N,Y D OPD^VADPT Q
SVCPT ;Returns VASV( Patient data
 N X,I,N,Y D SVC^VADPT Q
OADPT ;Returns VAOA( Patient data
 N X,I,N,Y D OAD^VADPT Q
INPPT ;Returns VAIN( Patient data
 N X,I,N,Y D INP^VADPT Q
IN5PT ;Returns VAIP( Patient data
 N X,I,N,Y D IN5^VADPT Q
PIDPT ;Returns VA("PID") and VA("BID") Patient Identifier
 N X,I,N,Y D PID^VADPT Q
 ;
 ;
 QUIT
Y2K(X,LRYR) ;   --> used to convert 2digit year to 4digit century and year
 ; 1/1/91 TO 1/1/1991
 ;
 ;S X=$P(X,".") ;--> Date only. Not time
 S LRYR=$G(LRYR,"5S")
 N YR
 S Y=$$FMTE^XLFDT(X,LRYR)
 I $L($P(Y,"/"))=1 S $P(Y,"/")="0"_$P(Y,"/") ;--> pad for 2digit day
 I $L($P(Y,"/",2))=1 S $P(Y,"/",2)="0"_$P(Y,"/",2) ;--> for 2digit month
 Q Y
 ;
 QUIT
RD ;DIR read
 N Y,X
 K LRANSY,LRANSX
 S LREND=0 W !
 D ^DIR I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) S LREND=1
 S LRANSY=$G(Y),LRANSX=$G(X)
 Q
AGE2(DOB,LRCDT) ;Entry point if passing only a valid Date without patient
 ;   DOB, LRCDT must be defined in VA FileManager internal format
 ; Date error will return 99yr
 N X,Y,%DT
 I '$G(LRCDT) S LRCDT=$$DT^XLFDT
 I '$G(DOB) Q "99yr"  ;no DOB passed
 S DOB=$P(DOB,".")
 S X=DOB,LRCDT=$P(LRCDT,".")
 I $S(DOB'=+DOB:1,LRCDT'=+LRCDT:1,1:0) Q "99yr"
 I $S(DOB'?7N.NE:1,LRCDT'?7N.NE:1,1:0) Q "99yr"
 D ^%DT I Y'>0 Q "99yr"  ;invalid date
 S X=LRCDT
 K %DT D ^%DT I Y'>0 Q "99yr"  ;invalid date
 ;
CALC ;Calculate timeframe based on difference between DOB and collection
 ; date. Time is stripped off.
 ; .0001-24 hour = dy
 ; 0-29 days = dy
 ; 30-730 dy = mo
 ; >24 mo = yr
 ;
 I DOB>LRCDT Q "99yr"  ;DOB in future
 I DOB=LRCDT Q "1dy"  ;same dates---pass 1 day old
 S X=$E(LRCDT,1,3)-$E(DOB,1,3)-($E(LRCDT,4,7)<$E(DOB,4,7))
 I X>1 S X=+X_"yr" Q X   ;age 2 years or more---pass in years
 S X=$$FMDIFF^XLFDT(LRCDT,DOB,1)
 I X>30 S X=X\30_"mo" Q X  ;over 30 days---pass in months
 E  S X=X_"dy" Q X  ;under 31 days---pass in days
 Q "99yr"
