RGRPC ;BIRMIO/CMC-RG RPC API ;3 MAY 07
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**48**;30 Apr 99;Build 3
 ;
 ;
EN(RETURN,ICN,SSN,DFN,BRANGE,ERANGE) ;
 ;RETURN IS THE ARRAY TO HOLD THE RESULTS
 ;ICN is the Integration Control Number of the patient to find exceptions for (optional)
 ;SSN is the social of the patient to find exceptions for (optional)
 ;DFN is the internal entry number of the patient in the PATIENT (#2) file to find exceptions for (optional)
 ;Either ICN, SSN or DFN must be present
 ;BRANGE is the BEGINNING date range specified to find exceptions for the patient
 ;ERANGE is the ENDING date range specified to find exceptions for the patient
 ;
 ;S ^XTMP("CMC")=ICN_"^"_SSN_"^"_DFN_"^"_BRANGE_"^"_ERANGE FOR DEBUGGING
 I $G(ICN)=""&$G(SSN)=""&$G(DFN)="" S RETURN="-1^Patient not specified" Q
 I $G(BRANGE)="" S BRANGE=DT
 I $G(ERANGE)="" S ERANGE=DT
 I BRANGE>ERANGE S RETURN="-1^Beginning date is newer than End date" Q
 ;
 I $G(DFN)="" D
 .;need to get DFN
 .I $G(SSN)'="" S ICN=$$GETICNS^MPIF002(SSN)
 .I $G(ICN)'="" S DFN=$$GETDFN^MPIF001(ICN)
 I $G(DFN)=""!(+$G(DFN)=-1) S RETURN="-1^Can't find Patient" Q
 ;
 ; check if this data can be returned and if sensative pt bulletin needed
 N SENS D PTSEC^DGSEC4(.SENS,DFN,1,"Remote Procedure from MPI^RPC from MPI for RG Exception Information")
 N NOT D NOTICE^DGSEC4(.NOT,DFN,"Remote Procedure from MPI^RPC from MPI for RG Exception Information")
 I SENS(1)=3!(SENS(1)=4)!(SENS(1)=-1) S RETURN="-1^SENSATIVE PT ISSUE "_SENS(2)_" DFN= "_DFN_" ICN= "_ICN Q
 ;
 ;are there any exceptions for this patient?
 N TYP,CNT,IEN,IEN2,ETYP,WHO,X,Y,DIC,WTYP,WSTAT,MCNT S TYP="",CNT=1,MCNT=0
 F  S TYP=$O(^RGHL7(991.1,"ADFN",TYP)) Q:TYP=""  D
 .I $D(^RGHL7(991.1,"ADFN",TYP,DFN)) D
 ..S IEN=0 F  S IEN=$O(^RGHL7(991.1,"ADFN",TYP,DFN,IEN)) Q:IEN=""  D
 ...S IEN2="",ETYP="" F  S IEN2=$O(^RGHL7(991.1,"ADFN",TYP,DFN,IEN,IEN2)) Q:'IEN2  D
 ....S NODE=$G(^RGHL7(991.1,IEN,1,IEN2,0))
 ....S NODE10=$G(^RGHL7(991.1,IEN,1,IEN2,10))
 ....S LOGGED=$P(^RGHL7(991.1,IEN,0),"^",2)
 ....I $P(LOGGED,".")<BRANGE!($P(LOGGED,".")>ERANGE) Q
 ....S RETURN(CNT)="Exception Number: "_$P($G(^RGHL7(991.1,IEN,0)),"^"),CNT=CNT+1,MCNT=MCNT+1
 ....K Y S Y=LOGGED I Y'="" D DD^%DT
 ....S RETURN(CNT)="Exception logged on: "_Y,CNT=CNT+1
 ....S WTYP=$G(^RGHL7(991.11,TYP,10))
 ....S RETURN(CNT)="Exception Type: "_TYP_" - "_WTYP,CNT=CNT+1
 ....S RETURN(CNT)="Patient DFN: "_$P(NODE,"^",4),CNT=CNT+1
 ....S WSTAT=$P(NODE,"^",5) S WSTAT=$S(WSTAT=1:"PROCESSED",WSTAT=0:"NOT PROCESSED",1:"")
 ....S RETURN(CNT)="Exception Status: "_WSTAT,CNT=CNT+1
 ....I $P(NODE,"^",5)=1 D
 .....;MARKED AS PROCESSED
 .....K Y S Y=$P(NODE,"^",6) I Y'="" D DD^%DT
 .....S RETURN(CNT)="Date Processed: "_Y,CNT=CNT+1
 .....S WHO=$P(NODE,"^",7) I WHO'="" K X,Y S DIC="^VA(200,",DIC(0)="ZMO",X="`"_WHO D ^DIC I $G(Y)>1 S WHO=$G(Y(0,0))
 .....S RETURN(CNT)="Processed by: "_WHO,CNT=CNT+1
 ....S RETURN(CNT)="Exception Text: "_NODE10,CNT=CNT+1
 ....I $D(^RGHL7(991.1,IEN,1,IEN2,11)) D
 .....S RETURN(CNT)="Exception Notes:",CNT=CNT+1
 .....N IEN3 S IEN3=0 F  S IEN3=$O(^RGHL7(991.1,IEN,1,IEN2,11,IEN3)) Q:IEN3=""  S RETURN(CNT)=$G(^RGHL7(991.1,IEN,1,IEN2,11,IEN3,0)),CNT=CNT+1
 ....S RETURN(CNT)="**************************",CNT=CNT+1
 I CNT=1 S RETURN(0)="-1^No Exceptions found in date range.",RETURN=0
 S SITE=$$SITE^VASITE
 N PT S PT=$S(ICN'="":"ICN= "_ICN,DFN'="":"DFN= "_DFN,SSN'="":"SSN= "_SSN)
 I CNT>1 S RETURN(0)=MCNT_" exceptions found for "_PT_" at "_$P(SITE,"^",2)_" ("_$P(SITE,"^",3)_")",RETURN=MCNT
 Q
