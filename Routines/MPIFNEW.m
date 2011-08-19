MPIFNEW ;BHM/RGY-Create new request for patient demographic change ;FEB 20, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA **11**;;30 Apr 99
ADD(RNO) ;
 ;This function allows the addition of new CMOR Change requests to be
 ;added to the 984.9 file
 ; RNO - is the site making the request, optional
 ;Returned:  is the IEN of the new entry in 984.9
 ;  OR 0 if no entry is added.
 ;
 N DIC,D0,DIE,DA,X,DLAYGO,DR,RGOK,EVN,DINUM
 S RNO=$G(RNO)
 F EVN=+$P(^MPIF(984.9,0),"^",3)+1:1 L +^MPIF(984.9,EVN):0 I $T S RGOK=0 D  L -^MPIF(984.9,EVN) Q:RGOK
 .I $D(^MPIF(984.9,EVN)) Q
 .S DINUM=EVN,DIC="^MPIF(984.9,",DIC(0)="L",DLAYGO=984.9,X=$S(RNO="":$P($$SITE^VASITE(),"^",3)_"-"_EVN,1:RNO) K DD,D0 D FILE^DICN K DIC,DLAYGO,D0
 .S DIE="^MPIF(984.9,",DR="[MPIF OPEN REQUEST]",DA=EVN D ^DIE
 .S RGOK=1
 .Q
Q Q EVN
 ;
EDIT ; edit existing Requests that have a status of OPEN
 ;select a patient to edit request
 ;
 N ERR,PT,Y
 S DIC="^MPIF(984.9,",DIC(0)="AEMQZ",DIC("A")="Select Patient's Request you would like to edit (Must have a Status of Open): ",DIC("S")="I $D(^MPIF(984.9,""AC"",1,Y))"
 D ^DIC
 Q:+Y<0
 S PT=$P(^MPIF(984.9,+Y,0),"^",4)
 I +PT<0 W !,"No Patient associated with this Request." Q
 S DA=+Y
 D EDIT^MPIFEDIT
 K DA,ERR
 Q
