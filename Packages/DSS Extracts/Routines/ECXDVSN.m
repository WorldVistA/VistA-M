ECXDVSN ;ALB/JAP - Division selection utility ; 8/13/07 1:11pm
 ;;3.0;DSS EXTRACTS;**8,105**;Dec 22, 1997;Build 70
ADM(ECXDIV,ECXALL,ECXSTART,ECXEND,ECXERR) ;division information for ADM extract audit report
 ;selected inpatient divisions from medical center division file (#40.8)
 ;   input
 ;   ECXDIV = array of inpatient divisions selected (required)
 ;            passed by reference array containing
 ;            selected divisions;
 ;   ECXALL = 1/0 (optional)
 ;            1==> user wants all inpatient divisions OR
 ;                 facility is non-divisional
 ;            0==> user wants to select some divisions
 ;            if ECXALL not defined, then assume 1
 ;   ECXSTART = start date of date range (optional)
 ;   ECXEND   = end date of date range (optional)
 ;   ECXERR   = passed by reference for error return (required)
 ;   output
 ;   ECXDIV = array of divisions selected from file #40.8;
 ;            if ECXALL=1, then array contains all divisions 
 ;            if ECXALL=0, then array contains user-selected divisions
 ;    ECXDIV(ien in file #40.8) = ien in file #4^name^station number^primary indicator^active indicator^dss id
 ;   error CODE
 ;   ECXERR   = 1, if input problem occurs
 ;              0, otherwise
 N OUT,DIC,X,Y,NM,ECXD,ECXIEN,ECXDIEN,ECXACT,ECXNAME,ECXNUM
 S (OUT,ECXERR)=0
 ;if start date or end date missing, then both default to today
 I '$G(ECXSTART)!('$G(ECXEND)) S (ECXSTART,ECXEND)=DT
 S:'$D(ECXALL) ECXALL=1 S:ECXALL="" ECXALL=1
 I ECXALL=1 D
 .S NM="" F  S NM=$O(^DG(40.8,"B",NM)) Q:NM=""  S ECXIEN=$O(^(NM,"")) D
 ..Q:+$P(^DG(40.8,ECXIEN,0),U,3)=1
 ..K Y S DIC="^DG(40.8,",DIC(0)="NZ",X=ECXIEN D ^DIC
 ..Q:Y=-1
 ..S ECXNAME=$P(Y(0),U,1),ECXNUM=$P(Y(0),U,2),ECXDIEN=$P(Y(0),U,7)
 ..S ECXDIV(ECXIEN)=ECXDIEN_U_ECXNAME_U_ECXNUM
 ..D ACTDIV(ECXIEN,ECXSTART,ECXEND,.ECXD,.ECXACT)
 ..S ECXDIV(ECXIEN)=ECXDIV(ECXIEN)_U_ECXD_U_ECXACT
 ..I $D(^ECX(727.3,ECXIEN)) D
 ...S ECXDIV(ECXIEN)=ECXDIV(ECXIEN)_U_$P($G(^ECX(727.3,ECXIEN,0)),U,2)
 I ECXALL=0 F  Q:OUT!ECXERR  D
 .K Y S DIC="^DG(40.8,",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),U,3)'=1"
 .D ^DIC I $G(DUOUT)!($G(DTOUT)) S OUT=1,ECXERR=1 Q
 .I Y=-1,X="" S OUT=1 Q
 .S ECXIEN=+Y,ECXNAME=$P(Y(0),U,1),ECXNUM=$P(Y(0),U,2),ECXDIEN=$P(Y(0),U,7)
 .S ECXDIV(ECXIEN)=ECXDIEN_U_ECXNAME_U_ECXNUM
 .D ACTDIV(ECXIEN,ECXSTART,ECXEND,.ECXD,.ECXACT)
 .S ECXDIV(ECXIEN)=ECXDIV(ECXIEN)_U_ECXD_U_ECXACT
 .I $D(^ECX(727.3,ECXIEN)) D
 ..S ECXDIV(ECXIEN)=ECXDIV(ECXIEN)_U_$P($G(^ECX(727.3,ECXIEN,0)),U,2)
 .I 'ECXACT W !!,?5,"Please note: Division "_ECXNUM_" was not active during",!,?5,"             selected date range.",!
 I ECXERR=1 K ECXDIV
 I '$D(ECXDIV) S ECXERR=1
 Q
ACTDIV(ECXIEN,ECXSTART,ECXEND,ECXD,ECXACT) ;determine if division active at anytime during date range
 ;to be called by ADM^ECXDVSN
 ;   input
 ;   ECXIEN   = ien in file #40.8; required
 ;   ECXSTART = start of date range; FM format; required
 ;   ECXEND   = end of date range; FM format; required
 ;   output
 ;   ECXD   = 1/0; passed by reference
 ;            1 indicates primary division
 ;   ECXACT = 1/0; passed by reference
 ;            returns 0, if division not active during date range;
 ;            note: only start date and end date are checked; if division
 ;                  inactive on both dates, then division assumed inactive
 ;                  for entire date range
 ;assume division active; set ecxact=1
 S ECXACT=1
 ;check if division active on start date or end date;
 ;these dates are normally within the same month
 F ECXDATE=ECXSTART,ECXEND D
 .S DATE(ECXDATE)=$$SITE^VASITE(ECXDATE,ECXIEN)
 .S ECXD=0
 .I ECXIEN=$$PRIM^VASITE(ECXDATE) S ECXD=1
 ;if not active on start date and not active on end date, reset ecxact=0
 I DATE(ECXSTART)=-1,DATE(ECXEND)=-1 S ECXACT=0
 Q
MOV(ECXDIV,ECXALL,ECXSTART,ECXEND,ECXERR) ;division information for MOV extract audit report 
 ;selected divisions from medical center division file (#40.8)
 ;   input
 ;   (see ADM)
 ;   output
 ;   (see ADM)
 D ADM^ECXDVSN(.ECXDIV,ECXALL,ECXSTART,ECXEND,.ECXERR)
 Q
PAS(ECXDIV,ECXALL,ECXERR) ;setup division/site information for PAS extract audit report
 ;   input
 ;   ECXDIV = passed by reference array variable
 ;   ECXALL = 1
 ;   output
 ;   ECXDIV = data for default division/site;
 ;            ECXDIV(1)=ien in file #4^name^station number
 ;            where the INSTITUTION file pointer is obtained from file #728
 S ECXALL=1 D DEFAULT^ECXDVSN(.ECXDIV,ECXALL,.ECXERR)
 Q
TRT(ECXDIV,ECXALL,ECXERR) ;setup division/site information for TRT extract audit report
 ;   input
 ;   ECXDIV = passed by reference array variable
 ;   ECXALL = 1
 ;   output
 ;   ECXDIV = data for default division/site;
 ;            ECXDIV(1)=ien in file #4^name^station number
 ;            where the INSTITUTION file pointer is obtained from file #728
 S ECXALL=1 D DEFAULT^ECXDVSN(.ECXDIV,ECXALL,.ECXERR)
 Q
DEFAULT(ECXDIV,ECXALL,ECXERR) ;default division/site information for audit report
 ;   input
 ;   ECXDIV = passed by reference array variable
 ;   ECXALL = 1
 ;   output
 ;   ECXDIV = data for default division/site;
 ;            ECXDIV(1)=ien in file #4^name^station number
 ;            where the INSTITUTION file pointer is obtained from file #728
 N DIV,ECX
 S ECXERR=0
 S DIV=$P($G(^ECX(728,1,0)),U,1)
 I DIV="" S ECXERR=1 Q
 K ECX S DIC="^DIC(4,",DIQ(0)="I",DIQ="ECX",DA=DIV,DR=".01;99" D EN^DIQ1
 I $D(ECX) S ECXDIV(1)=DIV_U_ECX(4,DIV,.01,"I")_U_ECX(4,DIV,99,"I")
 I '$D(ECX) S ECXERR=1
 I '$D(ECXDIV) S ECXERR=1
 Q
DEN(ECXDIV,ECXALL,ECXERR) ;setup division/site information for DEN extract audit report
 ;   input
 ;   ECXDIV = passed by reference array variable (required)
 ;   ECXALL = 0/1 (optional)
 ;            '0' indicates user to select dental division;
 ;            '1' indicates 'all' dental divisions or only one division
 ;                exists in file #225; default is '1'
 ;   output
 ;   ECXDIV = data for dental division/site;
 ;            ECXDIV(ien in file #225)=ien in file #4^name^station number
 ;   ECXERR = 0/1
 ;            if input problem, then '1' returned
 N X,Y,DIC,DTOUT,DUOUT,DIRUT,OUT,ECXD,ECXIEN
 S:'$D(ECXALL) ECXALL=1 S:ECXALL="" ECXALL=1
 S ECXERR=0,ECXD=""
 ;if ecxall=1, then all dental divisions/sites
 I ECXALL=1 D
 .F  S ECXD=$O(^DENT(225,"B",ECXD)) Q:ECXD=""  S ECXIEN=$O(^(ECXD,"")) D
 ..S $P(ECXDIV(ECXIEN),U,3)=ECXD S DIC="^DIC(4,",DIC(0)="MX",X=ECXD D ^DIC
 ..S:+Y>0 ECXDIV(ECXIEN)=Y S:+Y=-1 ECXDIV(ECXIEN)=U
 ..S ECXDIV(ECXIEN)=ECXDIV(ECXIEN)_U_ECXD
 ;if ecxall=0, user selects some/all dental divisions/sites
 I ECXALL=0 S OUT=0 D
 .F  Q:OUT!ECXERR  D
 ..S DIC="^DENT(225,",DIC(0)="AEMQ" K X,Y D ^DIC
 ..I $G(DUOUT)!($G(DTOUT)) S OUT=1,ECXERR=1 Q
 ..I Y=-1,X="" S OUT=1 Q
 ..S ECXIEN=+Y,ECXD=$P(Y,U,2) K X,Y
 ..S DIC="^DIC(4,",DIC(0)="MX",X=ECXD D ^DIC
 ..S:+Y>0 ECXDIV(ECXIEN)=Y S:+Y=-1 ECXDIV(ECXIEN)=U
 ..S ECXDIV(ECXIEN)=ECXDIV(ECXIEN)_U_ECXD
 I ECXERR=1 K ECXDIV
 I '$D(ECXDIV) S ECXERR=1
 Q
ECS(ECXDIV,ECXALL,ECXERR) ;setup division/location information for ECS extract audit report
 ;   input
 ;   ECXDIV = passed by reference array variable (required)
 ;   ECXALL = 0/1 (optional)
 ;            '0' indicates user to select EC location(s);
 ;            '1' indicates 'all' locations or only one location
 ;                exists in file #4 "LOC" index;
 ;            default is '1'
 ;   output
 ;   ECXDIV = data for EC location;
 ;            ECXDIV(ien in file #4)=ien in file #4^name^station number
 ;            where the INSTITUTION file pointer is obtained from 
 ;            "LOC" index in file #4
 ;   ECXERR = 0/1
 ;            if input problem, then '1' returned
 ;
 N X,Y,I,DIC,DIR,DIRUT,DTOUT,DUOUT,NM,OUT,ECXD,ECXIEN,ECXLOC
 S:'$D(ECXALL) ECXALL=1 S:ECXALL="" ECXALL=1
 S ECXERR=0,ECXD="",I=0
 ;get all available ec locations in ecxloc array
 F  S ECXD=$O(^DIC(4,"LOC",ECXD)) Q:ECXD=""  S I=I+1,ECXIEN=$O(^(ECXD,"")),ECXLOC(I)=ECXD_U_ECXIEN_U_$P($G(^DIC(4,ECXIEN,99)),U,1)
 ;if ecxall=1, then all ec locations
 I ECXALL=1 S I="" D  Q
 .F  S I=$O(ECXLOC(I)) Q:I=""  D
 ..S ECXIEN=$P(ECXLOC(I),U,2)
 ..S ECXDIV(ECXIEN)=ECXIEN_U_$P(ECXLOC(I),U,1)_U_$P(ECXLOC(I),U,3)
 I ECXALL=0 S OUT=0,I=0 D
 .W !!,"Event Capture Locations:",! S I=0,DIR(0)="SXO^"
 .;spaces are embedded in dir(0) to prevent user from selecting by alpha characters in name
 .F  S I=$O(ECXLOC(I)) Q:I=""  S NM=$P(ECXLOC(I),U,1) W !,?10,I_"  ",NM S DIR(0)=DIR(0)_I_":"_"-   "_NM_";"
 .W !
 .F  Q:OUT!ECXERR  D
 ..S DIR("A")="Select Event Capture Location",DIR("S")="I +Y=Y"
 ..D ^DIR
 ..I $G(DTOUT)!($G(DUOUT)) S ECXERR=1 Q
 ..I X="" D  Q
 ...I '$D(ECXDIV) W !!,"No Location selected...exiting.",! S OUT=1 Q
 ...W !!,"You have selected the following Location(s):",!
 ...S I=0 F  S I=$O(ECXDIV(I)) Q:I=""  W !,?10,$P(ECXDIV(I),U,2)_" ("_$P(ECXDIV(I),U,3)_")"
 ...W ! K X,Y,DIR S DIR(0)="Y",DIR("A")="Is that ok",DIR("B")="YES" D ^DIR
 ...I $D(DIRUT) S ECXERR=1
 ...I Y=0 S ECXERR=1
 ...S OUT=1
 ..S ECXIEN=$P(ECXLOC(X),U,2)
 ..S ECXDIV(ECXIEN)=ECXIEN_U_$P(ECXLOC(X),U,1)_U_$P(ECXLOC(X),U,3)
 ;exit
 I ECXERR=1 K ECXDIV
 I '$D(ECXDIV) S ECXERR=1
 Q
NUT() ; Set Divisions into screen array (prompt is one/many/all)
 ;Input  : SCRNARR - Screen array full global reference
 ;Output : 1 = OK     0 = User abort/timeout
 ;         @SCRNARR@("DIVISION") = User pick all divisions ?
 ;           1 = Yes (all)     0 = No
 ;         @SCRNARR@("DIVISION",PtrDiv) = Division name
 ;Note   : @SCRNARR@("DIVISION") is initialized (KILLed) on input
 ;       : @SCRNARR@("DIVISION",PtrDiv) is only set when the user
 ;         picked individual divisions (i.e. didn't pick all)
 ;
 ;Declare variables
 N VAUTD,Y,SCANARR
 ;Get division selection
 S DIC="^DIC(4,"
 S VAUTSTR="PATIENT DIVISION"
 S VAUTVB="SCANARR"
 S VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 Q 1
 M @SCRNARR@("DIVISION")=SCANARR
 Q 0
