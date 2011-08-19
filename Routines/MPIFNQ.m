MPIFNQ ;BHM/RGY-Miscellaneous functions for CMOR ;FEB 20, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**11**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;
 ; ^RGSITE(991.8,     IA #2746
 ;
 ;
PAT(IEN) ;Return patient CMOR (Site IEN)
 NEW RESULT
 S RESULT=$$GETVCCI^MPIF001(IEN)
 I RESULT<0 Q ""
 Q RESULT
ICN(IEN) ;Return patient ICN
 NEW RESULT
 S RESULT=$$GETICN^MPIF001(IEN)
 I RESULT<0 Q ""
 Q +RESULT
IEN(ICN) ;Return patient IEN
 NEW RESULT
 S RESULT=$$GETDFN^MPIF001(ICN)
 I RESULT<0 Q ""
 Q RESULT
AUTO() ;
 NEW TMX
 S TMX=+$P($G(^RGSITE(991.8,1,0)),"^",2)
 S:TMX'=1&(TMX'=0) TMX=0
 Q TMX
RPT1 ;
 ; Entry point for option MPIF SENT REQUEST.  This option prints
 ; all outstanding requests for Change of CMOR that this site has sent.
 ; NO input or output variables.
 N X1,X2,Y,USER,AGE,DIC,L,BY,FLDS,FROM,TO,DIR,DTOUT,DUTOUT,DIROUT,DIRUT,X
 S USER=""
 S DIR("A")="Do you only want to list the requests you entered? ",DIR("B")="YES",DIR(0)="YAO" D ^DIR K DIR Q:$D(DIRUT)
 I Y=1 S USER=DUZ
 S DIR("A")="Display requests entered on or before date: ",DIR("B")="TODAY",DIR(0)="DAO^::EP" D ^DIR K DIR Q:$D(DIRUT)
 S X2=Y,X1=DT D D^%DTC
 S AGE=X
 S DIC="^MPIF(984.9,",FLDS="[MPIF OUTSTANDING REQUESTS]",L=0
 S BY="[MPIF REQUEST SORT]",FR=",,2,"_USER_","_AGE,TO=",,2,"_USER_","
 D EN1^DIP
 Q
RPT2 ;
 ; Entry point for option:  MPIF RECEIVED REQUESTS to list all change 
 ; of CMOR requests that are still outstanding for review/processing
 ; NO input or output variables.
 N DIC,L,BY,FLDS,FROM,TO,DIR,DTOUT,DUTOUT,DIROUT
 S DIC="^MPIF(984.9,",FLDS="[MPIF OUTSTANDING REQUESTS]",L=0
 S BY="[MPIF PENDING REQUESTS]",FR="",TO=""
 D EN1^DIP
 Q
INQ ;View CMOR request
 N DIC,FLDS,FR,TO,L,BY,Y
ASK S DIC="^MPIF(984.9,",DIC(0)="QEAM",DIC("A")="Select Request #: " D ^DIC Q:+Y<0
 S FR=+Y,TO=+Y,L=0,FLDS="[MPIF REQUEST VIEW]",BY="@NUMBER" D EN1^DIP
 G ASK
 Q
RPT3 ; entry point for Approved Requests
 ;No input of output variables
 N FR,DIC,L,BY,FLDS,FROM,TO,DIR,DTOUT,DUTOUT,DIROUT,DIRUT,X
 S DIR("A")="Display requests APPROVED on or SINCE (date): ",DIR("B")="T-10",DIR(0)="DAO^::EP" D ^DIR K DIR Q:$D(DIRUT)
 S FROM=Y
 S DIC="^MPIF(984.9,",FLDS=".06,.01,2.02,.04,.07,1.02,.03"
 S BY=".06,2.02,.04"
 S FR="4,"_FROM_","
 S TO="4,,"
 D EN1^DIP
 Q
RPT4 ; entry point for Disapproved Requests
 ;No input of output variables
 N FR,DIC,L,BY,FLDS,FROM,TO,DIR,DTOUT,DUTOUT,DIROUT,DIRUT,X
 S DIR("A")="Display requests DISAPPROVED on or SINCE (date): ",DIR("B")="T-10",DIR(0)="DAO^::EP" D ^DIR K DIR Q:$D(DIRUT)
 S FROM=Y
 S DIC="^MPIF(984.9,",FLDS=".06,.01,2.02,.04,.07,1.02,.03,3.02"
 S BY=".06,2.02,.04"
 S FR="5,"_FROM_","
 S TO="5,,"
 D EN1^DIP
 Q
