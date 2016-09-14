SDEC59 ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**642**;Aug 13, 1993;Build 23
 ;
 Q
 ;
GETSITES(SDECY) ;GET active National VA site names and station numbers
 N IEN,IEN,NM,SDECI,STN
 S SDECY="^TMP(""SDEC59"","_$J_",""GETSTNS"")"
 K @SDECY
 S SDECI=0
 S @SDECY@(SDECI)="T00050NAME^T00010STATION_NUMBER"_$C(30)
 S NM="" F  S NM=$O(^DIC(4,"B",NM)) Q:NM=""  D
 .S IEN=$O(^DIC(4,"B",NM,""))
 .Q:($P(^DIC(4,IEN,0),U,11)'="N")  ;national entries only
 .Q:$P($G(^DIC(4,IEN,99)),U,4)  ;skip inactive
 .S STN=$P($G(^DIC(4,IEN,99)),U) ;get station number
 .Q:STN']""  ;skip sites with no station number
 .S SDECI=SDECI+1
 .S @SDECY@(SDECI)=NM_U_STN_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
NETLOC(SDECY,LOCATION)   ;GET data from the NETWORK LOCATION file 2005.2
 ;INPUT:
 ; LOCATION - (optional) name for ID pointer to NETWORK LOCATION file 2005.2
 ;                       null will default to VISTASITESERVICE
 ;RETURN:
 ; 1. LOCATION_IEN  - pointer to NETWORK LOCATION file 2005.2
 ; 2. LOCATION_NAME - name from NETWORK LOCATION file
 ; 3. PHYSICAL_REF - PHYCICAL REFERENCE field (free-text)
 N SD,SDECI
 N IEN,NAME,REF
 S SDECI=0
 S SDECY="^TMP(""SDEC59"","_$J_",""NETLOC"")"
 K @SDECY
 S @SDECY@(SDECI)="T00030LOCATION_IEN^T00030LOCATION_NAME^T00030PHYSICAL_REF"_$C(30)
 S LOCATION=$G(LOCATION)
 I LOCATION="" S LOCATION="VISTASITESERVICE"
 I LOCATION'="" D
 .D FIND^DIC(2005.2,,"1","MO",LOCATION,,,,,"SD")
 .S IEN=$G(SD("DILIST",2,1))
 .S NAME=$G(SD("DILIST",1,1))
 .S REF=$G(SD("DILIST","ID",1,1))
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=IEN_U_NAME_U_REF_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
