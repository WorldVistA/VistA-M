RMPRPIX5 ;HINCIO/ODJ- PIP LOCATION FILE 661.5 API ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** CRE - Create a new 661.5 Stock Location record
 ;
 ; Inputs:
 ;    RMPR - an array consisting of...
 ;       RMPR("NAME")        - Location name (.01 field)
 ;       RMPR("STATION")     - Station ien (fld 2 ptr ^DIC(4,)
 ;       RMPR("ADDRESS")     - Location address (fld 3, can be null)
 ;       RMPR("STATUS")      - A - Active, I - Inactive (fld 4)
 ;       RMPR("STATUS DATE") - Date (Fileman) of any status change
 ;                             (fld 5)
 ;       RMPR("USER")        - ien of User creating location
 ;                             (fld 6, ptr ^VA(200,)
 ;
 ; Outputs:
 ;    RMPR("IEN") - the ien of the created 661.5 record
 ;    RMPRCRE     - if non 0 there was an error creating the record
 ;
CRE(RMPR) ;
 N RMPRCRE,RMPRFDA,RMPRIEN,RMPRMSG
 S RMPRCRE=0
 S RMPRFDA(661.5,"+1,",.01)=RMPR("NAME")
 S RMPRFDA(661.5,"+1,",2)=RMPR("STATION")
 S RMPRFDA(661.5,"+1,",3)=RMPR("ADDRESS")
 S RMPRFDA(661.5,"+1,",4)=RMPR("STATUS")
 S RMPRFDA(661.5,"+1,",5)=RMPR("STATUS DATE")
 S RMPRFDA(661.5,"+1,",6)=RMPR("USER")
 D UPDATE^DIE("S","RMPRFDA","RMPRIEN","RMPRMSG")
 I $D(RMPRMSG) S RMPRCRE=1 G CREX
 S RMPR("IEN")=RMPRIEN(1)
CREX Q RMPRCRE
 ;
 ;***** GET - read in a 661.5 Stock Location record
 ;
 ; Inputs:
 ;    must pass either...
 ;
 ;    RMPR("IEN")     - the ien (661.5 ptr) of the desired record
 ;
 ;    or, if the ien is unknown...
 ;
 ;    RMPR("STATION") - the Station ien (fld 2, ptr ^DIC(4,)
 ;    RMPR("NAME")    - the Location name (.01 field)
 ;
 ; Outputs:
 ;    RMPR - an array consisting of (all external values)...
 ;       RMPR("IEN")         - 661.5 record's ien if none input
 ;       RMPR("NAME")        - Location name (.01 field)
 ;       RMPR("STATION")     - Station name (fld 2)
 ;       RMPR("ADDRESS")     - Location address (fld 3, can be null)
 ;       RMPR("STATUS")      - ACTIVE or INACTIVE (fld 4)
 ;       RMPR("STATUS DATE") - Date of any status change
 ;                             (fld 5)
 ;       RMPR("USER")        - Name of User creating location
 ;                             (fld 6)
 ;
 ;    RMPRRET - 0 if no errors, else non 0
 ;              1 - RMPR("IEN") and RMPR("STATION") inputs are null
 ;              2 - RMPR("IEN") and RMPR("NAME") inputs are null
 ;              3 - no ien for input RMPR("STATION") and RMPR("NAME")
 ;              4 - error on the Fileman read
 ;
GET(RMPR) ;
 N RMPRRET,RMPRFME,RMPRIEN,RMPRKEY,RMPRERR,RMPROUP
 S RMPRRET=0
 I $G(RMPR("IEN"))="" D
 . I $G(RMPR("STATION"))="" S RMPRRET=1 Q
 . I $G(RMPR("NAME"))="" S RMPRRET=2 Q
 . S RMPR("IEN")=$O(^RMPR(661.5,"XSL",RMPR("STATION"),RMPR("NAME"),""))
 . I RMPR("IEN")="" S RMPRRET=3 Q
 . Q
 I RMPRRET G GETX
 S RMPRIEN=RMPR("IEN")_","
 D GETS^DIQ(661.5,RMPRIEN,"*","","RMPROUP","RMPRFME")
 I $D(RMPRFME) S RMPRRET=4 G GETX
 S RMPR("USER")=RMPROUP(661.5,RMPRIEN,6)
 S RMPR("STATION")=RMPROUP(661.5,RMPRIEN,2)
 S RMPR("ADDRESS")=RMPROUP(661.5,RMPRIEN,3)
 S RMPR("STATUS")=RMPROUP(661.5,RMPRIEN,4)
 S RMPR("STATUS DATE")=RMPROUP(661.5,RMPRIEN,5)
 S RMPR("NAME")=RMPROUP(661.5,RMPRIEN,.01)
GETX Q RMPRRET
 ;
 ;***** UPD - Update existing Stock Location rec (661.5)
 ; Inputs:
 ;    RMPR5("IEN") - mandatory; the ien of the 661.5 rec. to modify
 ;    see subscripts for CRE above for the other elements that can
 ;    be set in the RMPR5 input array. You should only create these
 ;    elements if they differ in value from an existing rec.
 ;    Use only internal values.
 ;
 ; Outputs:
 ;    RMPRERR -  0 - no problems
 ;               1 - FM returned an error from its update
 ;
UPD(RMPR5) ;
 N RMPRFDA,RMPRFME,RMPRERR,X,Y,DA,RMPRI
 S RMPRERR=0
 S RMPRI=RMPR5("IEN")_","
 S:$D(RMPR5("NAME")) RMPRFDA(661.5,RMPRI,.01)=RMPR5("NAME")
 S:$D(RMPR5("STATION")) RMPRFDA(661.5,RMPRI,2)=RMPR5("STATION")
 S:$D(RMPR5("ADDRESS")) RMPRFDA(661.5,RMPRI,3)=RMPR5("ADDRESS")
 S:$D(RMPR5("STATUS")) RMPRFDA(661.5,RMPRI,4)=RMPR5("STATUS")
 S:$D(RMPR5("STATUS DATE")) RMPRFDA(661.5,RMPRI,5)=RMPR5("STATUS DATE")
 S:$D(RMPR5("USER")) RMPRFDA(661.5,RMPRI,6)=RMPR5("USER")
 D:$D(RMPRFDA) FILE^DIE("","RMPRFDA","RMPRFME")
 I $D(RMPRFME) S RMPRERR=1
UPDX Q RMPRERR
 ;
 ;***** ISACT - Test if Location active or inactive
 ;
 ; Inputs:
 ;    RMPR5("IEN") - mandatory: ien of Location rec.
 ;
 ; Outputs:
 ;    RMPRACT - 1 if location active, else 0
 ;
ISACT(RMPR5) ;
 N RMPRFDI,RMPRI,RMPRFME,X,Y,DA,RMPRACT
 S RMPRACT=0
 S RMPRI=RMPR5("IEN")_","
 D GETS^DIQ(661.5,RMPRI,"4","I","RMPRFDI","RMPRFME")
 I $D(RMPRFME) G ISACTX
 I RMPRFDI(661.5,RMPRI,4,"I")="A" S RMPRACT=1
ISACTX Q RMPRACT
 ;
 ;***** ETOI - Convert external form of 661.5 rec to internal vals.
 ;
 ; Inputs:
 ;    RMPR5("IEN") - mandatory; ien of Location rec.
 ;
 ; Outputs:
 ;    RMPR5I  - output array whose subscripts defined as for CRE above
 ;    RMPRERR - 0 if no problems, +ve if FM returned an error
 ;
ETOI(RMPR5,RMPR5I) ;
 N RMPRI,RMPRFDI,RMPRFME,RMPRERR,X,Y,DA
 S RMPRERR=0
 S RMPRI=RMPR5("IEN")_","
 D GETS^DIQ(661.5,RMPRI,"*","I","RMPRFDI","RMPRFME")
 I $D(RMPRFME) S RMPRERR=1 G ETOIX
 S RMPR5I("IEN")=RMPR5("IEN")
 S RMPR5I("STATION")=RMPRFDI(661.5,RMPRI,2,"I")
 S RMPR5I("NAME")=RMPRFDI(661.5,RMPRI,.01,"I")
 S RMPR5I("ADDRESS")=RMPRFDI(661.5,RMPRI,3,"I")
 S RMPR5I("STATUS")=RMPRFDI(661.5,RMPRI,4,"I")
 S RMPR5I("STATUS DATE")=RMPRFDI(661.5,RMPRI,5,"I")
 S RMPR5I("USER")=RMPRFDI(661.5,RMPRI,6,"I")
ETOIX Q RMPRERR
