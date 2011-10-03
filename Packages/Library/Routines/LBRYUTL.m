LBRYUTL ;SSI/ALA-UTILITY PROGRAM FOR LIBRARY PKG ;[ 09/08/98  2:45 PM ]
 ;;2.5;Library;**2,6**;Mar 11, 1996
JDN(LBRFDATE) ;  Create 7 digit Julian date from FileMan internal date
 ;  Requires LBRFDATE=FileMan internal date.  Returns LBRJDATE as Julian day number
 N LBRLDAY,LBRMDAYS,LBRMO,LBRYR,I,LBRDAYS,LBRJDATE
 ; set default total # of days per month in ^-pieced string
 S LBRMDAYS="31^28^31^30^31^30^31^31^30^31^30^31"
 ; extract FMan 3 digit year and convert to Julian 4 digit year
 S LBRYR=$E(LBRFDATE,1,3)+1700
 ; extract month and day from FMan date
 S LBRMO=$E(LBRFDATE,4,5)
 S LBRLDAY=$E(LBRFDATE,6,7)
 ; check for leap years & centuries and change days per month string
 I (((LBRYR#4=0)&(LBRYR#100'=0))!((LBRYR#100=0)&(LBRYR#400=0))) S $P(LBRMDAYS,U,2)=29
 S LBRDAYS=0
 ; sum up the days since Jan 1 to the current month
 I LBRMO'=1 S LBRDAYS=0 F I=1:1:LBRMO-1 S LBRDAYS=LBRDAYS+$P(LBRMDAYS,U,I)
 ; add the sum to the date of the current month
 ; to obtain the total number of days since Jan 1
 ; then create a Julian date year+days since Jan 1
 ;Insert placeholder 0's as nessecary
 I ((LBRDAYS+LBRLDAY)<10) Q (LBRYR_"00"_(LBRDAYS+LBRLDAY))
 I ((LBRDAYS+LBRLDAY)<100) Q (LBRYR_"0"_(LBRDAYS+LBRLDAY))
 Q (LBRYR_(LBRDAYS+LBRLDAY))
RJD(LBRJDATE) ;  Create FileMan internal date from 7 digit Julian date
 ;  Requires LBRJDATE=Year_Number of days from begin of year
 N LBRMDAYS,LDY,I,LBRNLDY,LBRFDATE,LBRYR
 ; extract 4 digit Julian year
 S LBRYR=$E(LBRJDATE,1,4)
 ; set default total # of days per month in ^-pieced string
 S LBRMDAYS="31^28^31^30^31^30^31^31^30^31^30^31"
 ; check for leap years & centuries and change days per month string
 I (((LBRYR#4=0)&(LBRYR#100'=0))!((LBRYR#100=0)&(LBRYR#400=0))) S $P(LBRMDAYS,U,2)=29
 ; convert 4 digit Julian year to 3 digit FMan year
 S LBRYR=LBRYR-1700
 ; calculate the month from total number of days
 ; keep subtracting until <0
 S LBRNLDY=$E(LBRJDATE,5,7) F I=1:1:12 S LBRNLDY=(LBRNLDY-$P(LBRMDAYS,U,I)) Q:LBRNLDY<0
 ; to obtain the day of month, add back last months day total
 S LBRNLDY=LBRNLDY+$P(LBRMDAYS,U,I)
 S LBRMO=I
 ; calculate if '0' placeholders are necessary 29811 -> 2980101
 I LBRNLDY=0 S LBRNLDY=$P(LBRMDAYS,U,LBRMO-1),LBRMO=LBRMO-1
 I LBRMO<10 S LBRFDATE=LBRYR_"0"_LBRMO
 I (LBRMO'<10) S LBRFDATE=LBRYR_LBRMO
 I LBRNLDY<10 S LBRFDATE=LBRFDATE_"0"_LBRNLDY
 I (LBRNLDY'<10) S LBRFDATE=LBRFDATE_LBRNLDY
 Q LBRFDATE
TRN ;  Get next transaction number for transaction file local site
 S DIC(0)="L",DLAYGO=682.1,DIC="^LBRY(682.1,"
 L ^LBRY(682.1,0):5 I '$T G TRN
 S DINUM=+$P(^LBRY(682.1,0),U,3) F I=1:1 S DINUM=DINUM+I Q:'$D(^LBRY(682.1,DINUM,0))
 L
 S X=DINUM D FILE^DICN S LBRYDA=+Y K X,Y,DLAYGO
 S DA=LBRYDA,DIC="^LBRY(682.1,",DIE=DIC
 S DR=$S($G(SRVFLG)=1:"[LBRYLTF]",1:"[LBRYREC]") D ^DIE
 I $G(SRVFLG)=1 S $P(^LBRY(682.1,LBRYDA,1),U,2)=LBRYCLS
 K DINUM,DA,SRVFLG Q
FTRN ;  Get next transaction number for transaction file in FORUM
 S DIC(0)="L",DLAYGO=682.1,DIC="^LBRY(682.1,"
 L ^LBRY(682.1,0):5 I '$T G FTRN
 S DINUM=+$P(^LBRY(682.1,0),U,3) F I=1:1 S DINUM=DINUM+I Q:'$D(^LBRY(682.1,DINUM,0))
 L
 S X=DINUM D FILE^DICN S LBRYDA=+Y K X,Y,DLAYGO
 S DA=LBRYDA,DIC="^LBRY(682.1,",DIE=DIC
 S DR=$S($G(SRVFLG)=1:"[LBRYRECV]",1:"[LBRYSND]") D ^DIE
 S $P(^LBRY(682.1,LBRYDA,1),U,2)=$G(LBRYCLS)
 S $P(^LBRY(682.1,LBRYDA,0),U,7)=$G(STN)
 K DINUM,SRVFLG,DA
 Q
PAUSE W !,XZ S DTOUT=0 R X:DTIME E  W $C(7) S DTOUT=1 Q
 Q:X=""  Q:X="^"  W !,"Enter carriage return to ",XZ
 G PAUSE
