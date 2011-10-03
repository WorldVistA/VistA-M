PRSAPPU ; HISC/REL,WIRMFO/JAH - Calculate Pay Period; 22-JAN-1998
 ;;4.0;PAID;**19,22,35**;Sep 21, 1995
 ;====================================================================
PP ;Calculate Pay Period from a FileMan date.
 ;
 ; Input :  D1 = FileMan Date
 ; Output : D1 - unchanged
 ;          PPI = internal entry of pay period if available else undef.
 ;          PPE = Pay period that D1 falls in, formatted yy-pp.
 ;          PP4Y = Pay period with 4 digit year: yyyy-pp.
 ;          DAY = Day # of D1 within PPE
 ;
 ;   1.  Get 1st day of leave year (X2) that the date D1 falls in.
 ;   2.  Reserve 2 and 4 digit year to build pay period.
 ;   3.  Find # of days between 1st day & D1 and divide by 14
 ;       to determine pay period #.  Mod to find day w/in pp.
 ;   4.  Build Pay period with year and pay period #.
 ;
 N Y,K,X1,X2,X
 ;
 S Y=$P($T(DAT),";;",2)
 F K=1:1:23 Q:D1<$P(Y,",",K)
 S X2=$P(Y,",",K-1)
 ;
 S PPE=$E(X2,2,3),PP4Y=$E(X2,1,3)+1700
 ;
 S X1=D1
 D ^%DTC
 S Y=X\14+1,DAY=X#14+1
 ;
 S PPE=PPE_"-"_$S(Y<10:"0"_Y,1:Y)
 S PPI=$O(^PRST(458,"B",PPE,0))
 S PP4Y=PP4Y_"-"_$P(PPE,"-",2)
 ;
 Q
 ;====================================================================
NX ; Calculate Date of 1st day of Pay Period.
 ;
 ; INPUT:   PPE = Pay Period formatted YY-PP.
 ; OUTPUT:  D1 = FileMan Date of 1st day of pay period.
 ;
 N Y,K,X1,X2
 ;
 S Y=$P($T(DAT),";;",2)
 F K=1:1:23 Q:$E($P(Y,",",K),2,3)=$E(PPE,1,2)
 S X1=$P(Y,",",K),X2=14*($E(PPE,4,5)-1) D C^%DTC
 S D1=X Q
 ;====================================================================
DTP ; Printable Date
 S %=X,Y=$J(+$E(X,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(X,4,5))_"-"_$E(X,2,3)
 K % Q
 ;====================================================================
 ;These FileMan dates correspond to 1st day of pay period #1
 ;of respective years.
 ;
DAT ;;2910113,2920112,2930110,2940109,2950108,2960107,2970105,2980104,2990103,3000102,3010114,3020113,3030112,3040111,3050109,3060108,3070107,3080106,3090104,3100103,3110102,3120101,3130113
 ;
 ;====================================================================
PREP(CURP) ;given a pay period, return the previous pay period.
 ;  WARNING: This call only valid for years that are in the seed
 ;           range of the FileMan dates on the DAT^PRSAPPU line.
 ;           If pay period passed is out of this range then
 ;           0 is returned.
 ;
 ;Input:   CURP =  Pay period, passed in format YY-PP or YYYY-PP
 ;Output:  function returns previous pay period in YYYY-PP format.
 ;
 N PPE,PPI,D1,DAY,INYR,RANGE,FIRSTPP,INPP
 ;
 ;validate input - pay period and year
 ;
 Q:'$$VALIDPP(CURP) 0
 S INPP=$P(CURP,"-",2)
 S INYR=$P(CURP,"-")
 S INYR=$E(INYR,$L(INYR)-1,$L(INYR))
 S PPE=INYR_"-"_INPP
 ;
 ; Handle special case of 1ST PAY PERIOD iN the VALID RANGE
 S RANGE=$P($T(DAT),";;",2)
 S FIRSTPP=$E($P(RANGE,","),2,3)_"-01"
 Q:(PPE=FIRSTPP) $E($P(RANGE,","),1,3)+1700_"-26"
 ;
 ;Get 1st date of input pay period.
 ;
 D NX
 ;
 ;Subtract 14 days from current to get 1st day of previous pay period.
 S X1=D1,X2=-14 D C^%DTC S D1=X
 D PP
 Q PP4Y
 ;
 ;====================================================================
NXTPP(CURP) ;given a payperiod, return the NEXT payperiod. YYYY-PP
 ;  WARNING: This call only valid for years that are in the seed
 ;           range of the FileMan dates on the DAT^PRSAPPU line.
 ;           If pay period passed is out of this range then
 ;           0 is returned.
 ;
 ;Input:   CURP =  Pay period, passed in format YY-PP or YYYY-PP
 ;Output:  function returns previous pay period in YYYY-PP format.
 ;
 N PPE,PPI,D1,X1,X2,INPP,INYR,D1
 ;
 Q:'$$VALIDPP(CURP) 0
 ;
 ;Get 1st date of current pay period.
 S INPP=$P(CURP,"-",2)
 S INYR=$P(CURP,"-")
 S INYR=$E(INYR,$L(INYR)-1,$L(INYR))
 S PPE=INYR_"-"_INPP
 D NX
 ;
 ;Add 14 days to current to get 1st day of next pay period.
 S X1=D1,X2=14 D C^%DTC S D1=X
 D PP
 Q PP4Y
 ;====================================================================
VALIDPP(PP) ;Valid pay period must be in form YY-PP or YYYY-PP where
 ;        pp is pay periods 01-26 and
 ;        yy or yyyy are years in the FileMan dates at DAT^PRSAPPU
 ;
 N VALID,INVALID,VALYRS,RANGE,INCR,INPP,INYR,TESTYR
 S VALID=1,INVALID=0
 ;
 ;validate input - year and pay period
 ;
 S VALYRS=","
 S RANGE=$P($T(DAT),";;",2)
 F INCR=1:1:$L(RANGE,",") S VALYRS=VALYRS_$E($P(RANGE,",",INCR),2,3)_","
 S INYR=$P(PP,"-")
 I '(($L(INYR)=2)!($L(INYR)=4)) Q INVALID
 S INYR=$E(INYR,$L(INYR)-1,$L(INYR))
 S TESTYR=","_INYR_","
 I VALYRS'[TESTYR Q INVALID
 ;
 S INPP=$P(PP,"-",2)
 ;
 S VALPPS=",01,02,03,04,05,06,07,08,09,"
 S TESTINPP=","_INPP_","
 I '((VALPPS[TESTINPP)!((INPP>9)&(INPP<28))) Q INVALID
 ;
 ; pay period 27 is not always valid.
 ;
 I INPP=27 I $P($$NXTPP(INYR_"-26"),"-",2)'=27 Q INVALID
 Q VALID
 ;
 ;====================================================================
PPRANGE(STARTPP,ENDPP,STPP4Y,ENDPP4Y) ;get a pay period range from input.
 ;  INPUT: none
 ;  OUTPUT:  STARTPP = 1st pay period in range.  0 on abnormal exit.
 ;           ENDPP   = 2ND pay period in range.  0 on abnormal exit.
 ; 
 ; -Ask user to select beginning and ending pay periods from the 
 ;  pay periods that are on file.
 ; -Compare dates of 1st day of each of the input pay periods
 ;  to ensure that the beginning pay period input is LESS THAN OR = TO
 ;  the ending pay period input.
 ;
 N OUT,OK
 S (OUT,OK)=0
 ;
 F I=0:0 Q:(OK!OUT)  D
 .N DIC,FR,X,Y,TO,DAY,PPE,PPI,PP4Y,D1,STRTDAY1,ENDDAY1
 .S (STARTPP,ENDPP)=0
 .;
 .S D1=DT D PP S DIC("B")=$E($$PREP(PPE),3,7)
 .S DIC="^PRST(458,"
 .S DIC(0)="AEQZ",DIC("A")="Enter Beginning Pay Period: "
 .D ^DIC I $D(DTOUT)!$D(DUOUT)!(Y<0) S OUT=1
 .Q:OUT
 .S STARTPP=Y(0,0)
 .;
 .; ask user for 2nd pay period in range. Use default of
 .; the pay period they selected for the 1st pp.
 .;
 .S DIC("B")=STARTPP,DIC("A")="Enter Ending Pay Period: "
 .D ^DIC I $D(DTOUT)!$D(DUOUT) S OUT=1
 .Q:OUT
 .S ENDPP=Y(0,0)
 .;
 .;Get 1st day of selected pay periods. Compare the dates to ensure
 .;that a valid range has been entered.
 .;
 .S PPE=STARTPP D NX S STRTDAY1=D1
 .S PPE=ENDPP D NX S ENDDAY1=D1
 .I ENDDAY1-STRTDAY1<0 D
 .. W !,"Invalid pay period range."
 .. W !,"Ending pay period should be later than or equal to beginning pay period."
 .E  D
 ..  S D1=STRTDAY1 D PP^PRSAPPU S STPP4Y=PP4Y
 ..  S D1=ENDDAY1 D PP S ENDPP4Y=PP4Y
 ..  S OK=1
 I OUT S (STARTPP,ENDPP,ENDPP4Y,STPP4Y)=0
 ;
 Q
 ;==============================================================
IC(YY,FMT,FW,BDT) ;Infer Century from 2-digit year
 ; YY  - 2 digit year
 ; FMT - (optional) format of returned value (DEFAULT 3)
 ;       3 for YYY (fileman year .i.e. first numbers of fileman date)
 ;       4 for YYYY (standard year)
 ; FW  - (optional) # of future years from base in window (DEFAULT 20)
 ; BDT - (optional) base date (fileman) for sliding window (DEFAULT DT)
 ;
 N FMY
 I YY'?2N Q "" ; invalid 2-digit year - return null value
 I $G(FMT)'=3&($G(FMT)'=4) S FMT=3
 I $G(FW)'?1.2N S FW=20
 I $G(BDT)'?7N S BDT=DT
 I BDT'>1000000 Q "" ; invalid base date
 ; start with century of base date and adjust if necessary
 S FMY=$E(BDT)+$S($E(BDT,2,3)-YY>(99-FW):1,$E(BDT,2,3)-YY<-FW:-1,1:0)_YY
 Q $S(FMT=4:FMY+1700,1:FMY)
 ;
 ;PRSZ
 ;==============================================================
P35POST ;PRS*4.0*35 post install - execute set logic on new AB x-ref.
 ;
 I $$PATCH^XPDUTL("PRS*4.0*35") D MSSG(0) Q
 N FILE D MSSG(1) F FILE=458,459 D XREF4YR(FILE)
 Q
 ;==============================================================
MSSG(FLAG) ;PRS*4.0*35 - OUTPUT POST INSTALLATION MESSAGE.
 N MSSG
 I FLAG S MSSG="Updating AB cross reference in Files 458 and 459."
 E  S MSSG="AB X-ref NOT built. Built during earlier PRS*4.0*35 install."
 D MES^XPDUTL("      "_MSSG)
 Q
 ;==============================================================
XREF4YR(F) ;SET AB 4DIGIT YEAR XREF OF FILE 458 OR 459.
 ;
 Q:'((F=458)!(F=459))
 N DIK S DIK="^PRST("_F_",",DIK(1)=".01^AB" D ENALL^DIK
 Q
