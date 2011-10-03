ENARGR ;(WIRMFO)/JED,SAB-RECALL ARCHIVED DATA ;2.14.97
 ;;7.0;ENGINEERING;**40**;Aug 17, 1993
 Q
R ; Recall Global from archive media
 ; called from ENAR1
 ; input
 ;   ENGBL - global subscript in ^ENAR to be recalled (e.g. 6919.1)
 ;   ENRT  - number associated with type of archive (e.g. 1 for W.O.)
 ;   ENERR - error message text (should be 0 for no error)
 ; output
 ;   ENDA  - ien of ENG ARCHIVE LOG entry
 ;   ENERR - error message text or 0 when no error
 ;
 S ENFN=$S(ENRT=1:"WO ARCHIVE",ENRT=2:"2162 ACCIDENT ARCHIVE",ENRT=3:"EQUIPMENT INV. ARCHIVE",ENRT=4:"PROJECT ARCHIVE",ENRT=5:"CONTROL POINT ARCHIVE")
 ; select and open archive media
 S ENHFSM="R",ENHFSIO="" D ARDEV^ENARGO I ENERR'=0 G OUT
 I IOT="MT" D MTSETUP^ENARGO I ENERR'=0 G CLOUT
 I IOT="MT" D MTCHECK^ENARGO I ENERR'=0 G CLOUT
 ; get header info from archive media
 U IO R ENHD(1):15,ENHD(2):15,ENHD(3):15,ENHD(4):15
 D CLOSE^ENARGO
 I ENHD(3)'=("^ENAR("_ENGBL_",-1)") D  G OUT
 . W $C(7),!!,"Expected: ","^ENAR("_ENGBL_",-1)"
 . W !,"Found: ",ENHD(3)
 . W !,"Sorry, this media is unacceptable!"
 . W !,"Press <RETURN> to continue" R ENR:DTIME
 . S ENERR="BOGUS MEDIA"
 ; confirm
 S ENDA=+$P(ENHD(4),",",4) D ID^ENAR2 I ENERR'=0 G OUT
 W !!!!,"Media written on: ",ENHD(1),!,"with header: ",ENHD(2),!
 S DIR(0)="Y",DIR("A")="Is this the media you want",DIR("B")="YES"
 D ^DIR K DIR I 'Y S ENERR="RECALL RECORDS ABORT" G OUT
 ; ask type of recall
 S DIR(0)="SB^A:ALL RECORDS;O:ONE RECORD"
 S DIR("A")="Select type of recall to perform",DIR("B")="ALL"
 S DIR("?",1)="ALL RECORDS - Recall all records from archive media."
 S DIR("?",2)="ONE RECORD  - Search entire archive for a specific record"
 S DIR("?",3)="              and recall it if found."
 S DIR("?",4)=" "
 S DIR("?")="Enter ALL or ONE"
 D ^DIR K DIR I $D(DIRUT) S ENERR="RECALL TYPE NOT SPECIFIED" G OUT
 S ENRCLT=Y
 ;
 ; select and open archive media
 W !,"Please wait while I reopen the archive device."
 S IOP=ENION,ENHFSM="R" D ARDEV^ENARGO I ENERR'=0 G OUT
 I IOT="MT" D MTCHECK^ENARGO I ENERR'=0 G CLOUT
 U IO R ENX:15,ENX(1):15 U IO(0) ; skip first 2 header lines
 I ENRCLT="A" D RALL I ENERR'=0 G CLOUT
 I ENRCLT="O" D RONE I ENERR'=0 G CLOUT
 D CLOSE^ENARGO
 W !,"Elapsed time: ",$J($P($H,",",2)-ENSTART/60,6,2)," minutes."
 ;
RINIT ; initialize data dictionary
 ; save variables
 F ENX="ENDA","ENERR","ENGBL","ENRT" S ^TMP("ENAR",$J,ENX)=@ENX
 ; perform init
 I $D(^ENAR(ENGBL,-1,"INIT")) X ^("INIT")
 ; restore variables
 F ENX="ENDA","ENERR","ENGBL","ENRT" S @ENX=^TMP("ENAR",$J,ENX)
 K ^TMP("ENAR",$J)
 ; check result
 I $D(DIFQ) D  G:ENERR'=0 OUT G RINIT
 . W $C(7),!,"But your file is not initialized properly",!
 . S DIR(0)="Y",DIR("A")="Do you want to re-try",DIR("B")="YES"
 . S DIR("?",1)="If you answer no the "_ENFN_" file will be cleaned out"
 . S DIR("?",2)=" "
 . S DIR("?")="Enter Y or N"
 . D ^DIR K DIR I 'Y D GS^ENAR1,D2^ENAR1 S ENERR="ARCHIVE RECALL ABORT"
 ;
 K ^ENAR(ENGBL,-1)
 W !!,"O.K. Archive file is ready"
 G OUT
 ;
RALL ; recall all records
 W !,"Now fetching global"
 U IO
 S ENJ=0,ENSTART=$P($H,",",2)
 F  R ENX:15,ENX(1):15 Q:ENX="**EOF**"!'$T  D:ENX'["LOCK"
 . S @ENX=ENX(1),ENJ=ENJ+1
 . I '(ENJ#50) U IO(0) W "." U IO
 U IO(0)
 I ENX="**EOF**" W !!,"The global is now on the system disk"
 E  S ENERR="COULD NOT RECALL ALL RECORDS"
 Q
 ;
RONE ; recall one record
 W !,"Enter the exact "_ENFN_" record name. Remember to include"
 W !,"your station number as a pre-fix! (e.g. 688-B970121-001)",!
 S DIR(0)="F",DIR("A")="Exact "_ENFN_" record name"
 D ^DIR K DIR I $D(DIRUT) S ENERR="SINGLE RECORD UNSPECIFIED" Q
 S ENR=Y
 ;
 ; read media and recall data dictionary nodes, stop if record located
 S ENSTART=$P($H,",",2)
 U IO
 S ENJ=0
 F  R ENX:15,ENX(1):15 Q:$P(ENX(1),U,1)=ENR!(ENX="**EOF**")!'$T  D
 . S:$P(ENX,",",2)="-1" @ENX=ENX(1) ; only store data dictionary stuff
 . S ENJ=ENJ+1
 . I '(ENJ#50) U IO(0) W "." U IO
 U IO(0)
 ;
 I $P(ENX(1),U,1)'=ENR D  Q:ENERR'=0  G RONE
 . ; recall didn't stop at desired record
 . K ^ENAR(ENGBL,-1)
 . W !,"Sorry, that record doesn't appear to be on this archive."
 . S DIR(0)="Y",DIR("A")="Try another record",DIR("B")="NO"
 . D ^DIR K DIR I 'Y S ENERR="DIDN'T FIND SINGLE RECORD" Q
 . ; rewind (or close and reopen) device for retry
 . W !,"Please wait while I rewind (or reopen) the archive device."
 . S Y=$S("^MT^HFS^SDP^"[(U_IOT_U):$$REWIND^%ZIS(IO,IOT,IOPAR),1:0)
 . I 'Y D CLOSE^ENARGO S IOP=ENION,ENHFSM="R" D ARDEV^ENARGO Q:ENERR'=0
 . I IOT="MT" D MTCHECK^ENARGO Q:ENERR'=0
 . U IO R ENX:15,ENX(1):15 ; skip first 2 header lines
 . U IO(0)
 ;
 ; recall stopped at desired record
 W !!,"Found record ",$P(ENX(1),U,1),!
 S ENJ=$P(ENX,",",2)
 ; save data
 S @ENX=ENX(1)
 S ^ENAR(ENGBL,0)=ENFN_U_ENGBL_U_ENJ_"^1"
 S ^ENAR(ENGBL,"B",$P(ENX(1),U,1),ENJ)=""
 ; retrieve remaining nodes of record
 U IO
 F  R ENX:15,ENX(1):15 Q:$P(ENX,",",2)'=ENJ!(ENX="**EOF**")!'$T  D
 . S @ENX=ENX(1)
 Q
 ;
CLOUT ; Close Archive Media and Exit
 D CLOSE^ENARGO
OUT ; Exit
 K ENA,ENBOT,ENEOT,ENFN,ENHD,ENHFSIO,ENHFSM,ENION,ENJ,ENMTERR
 K ENONLINE,ENR,ENRCLT,ENREW,ENSTART,ENWPROT,ENX
 K DIROUT,DIRUT,DTOUT,DUOUT,I,X,Y
 Q
 ;
 ;ENARGR
