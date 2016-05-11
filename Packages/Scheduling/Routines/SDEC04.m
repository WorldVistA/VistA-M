SDEC04 ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**627,642**;Aug 13, 1993;Build 23
 ;
 Q
 ;
CSLOTSCH(SDECY,SDECRES,SDECSTART,SDECEND,SDECTYPES,SDECSRCH) ;GET Create Assigned Slot Schedule
 ;Create Assigned Slot Schedule recordset
 ;This call is used both to create a schedule of availability for the calendar display
 ;and to search for availability in the Find Appointment function
 ;
 ;SDECRES is resource name
 ;
 ;SDECTYPES is |-delimited list of Access Type Names
 ;If SDECTYPES is "" then the screen passes all types.
 ;
 ;SDECSRCH is |-delimited search info for the Find Appointment function
 ;First piece is 1 if we are in a Find Appointment call
 ;Second piece is weekday info in the format MTWHFSU
 ;Third piece is AM PM info in the form AP
 ;If 2nd or 3rd pieces are null, the screen for that piece is skipped
 ;RETURN:
 ; Global Array in which each array entry contains slot data separated by ^:
 ; 1. START_TIME
 ; 2. END_TIME
 ; 3. SLOTS
 ; 4. RESOURCE
 ; 5. ACCESS_TYPE
 ; 6. NOTE
 ; 7. AVAILABILITYID
 ; 8. ACCESS_TYPE_TEXT
 ;
 N CNT
 N SDECAD,SDECALO,SDECBS,SDECDEP,SDECERR,SDECI,SDECIEN,SDECK,SDECL,SDECNEND,SDECNOD
 N SDECNOT,SDECNSTART,SDECPEND,SDECQ,SDECRESD,SDECRESN,SDECS,SDECSUBCD,SDECTMP
 N SDAB,SDECTYPE,SDECTYPED,SDECZ
 N %DT,X,Y
 K ^TMP("SDEC",$J)
 S SDECERR=""
 S SDECY="^TMP(""SDEC"","_$J_")"
 S SDECALO=0,SDECI=0
 S ^TMP("SDEC",$J,SDECI)="T00030START_TIME^T00030END_TIME^I00010SLOTS^T00030RESOURCE^T00010ACCESS_TYPE^T00250NOTE^I00030AVAILABILITYID^T00030ACCESS_TYPE_TEXT"_$C(30)
 ;
 S %DT="T",X=$P($P(SDECSTART,"@",1),".",1) D ^%DT
 S SDECSTART=Y
 S %DT="T",X=$P($P(SDECEND,"@",1),".",1) D ^%DT
 S SDECEND=Y
 S SDECTYPES=$G(SDECTYPES)
 S SDECSRCH=$G(SDECSRCH)
 ;validate SDECRES
 S SDECRES=$G(SDECRES) I SDECRES="" S @SDECY@(1)="-1^Invalid Resource ID" Q
 I +SDECRES,'$D(^SDEC(409.831,+SDECRES,0)) S @SDECY@(1)="-1^Resource ID is required" Q
 I '+SDECRES S SDECRES=$O(^SDEC(409.831,"B",SDECRES,0)) I '+SDECRES S @SDECY@(1)="-1^Invalid Resource ID" Q
 S SDAB="^TMP("_$J_",""SDEC"",""BLKS"")"
 K @SDAB
 ;D GETSLOTS(SDAB,SDECRES,SDECSTART,SDECEND)
 D GETSLOTS^SDEC57(SDAB,SDECRES,SDECSTART,SDECEND)
 D:SDECTYPES'="" SDTYPES(.SDTYPES,SDECTYPES)
 ;Get Access Type IDs
 I 0,'+SDECSRCH S SDECTYPED=""
 I 0,+SDECSRCH F SDECK=1:1:$L(SDECTYPES,"|") D
 . S SDECL=$P(SDECTYPES,"|",SDECK)
 . I SDECL="" S $P(SDECTYPED,"|",SDECK)=0 Q
 . I '$D(^SDEC(409.823,"B",SDECL)) S $P(SDECTYPED,"|",SDECK)=0 Q
 . S $P(SDECTYPED,"|",SDECK)=$O(^SDEC(409.823,"B",SDECL,0))
 ;
 N SD1,SD2,SD3,SD4,SDI,SDN,SDNOD
 S SDI=0 F  S SDI=$O(@SDAB@(SDI)) Q:SDI'>0  D
 .S SDNOD=@SDAB@(SDI)
 .S Y=$P(SDNOD,U,2) X ^DD("DD") S SD1=$TR(Y,"@"," ")
 .S Y=$P(SDNOD,U,3) X ^DD("DD") S SD2=$TR(Y,"@"," ")
 .S SD3=+$P(SDNOD,U,4)
 .S SD4=$P($G(^SDEC(409.831,SDECRES,0)),U,1)
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=SD1_U_SD2_U_SD3_U_SD4_U_$P(SDNOD,U,5)_U_U_SDI_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 K @SDAB
 Q
 ;
GETSLOTS(SDAB,SDECRES,SDECSTART,SDECEND)  ;load SDEC ACCESS BLOCKS from file 44
 N SDCL,SDI,SDJ
 S SDECRES=$G(SDECRES) Q:SDECRES=""
 I +SDECRES,'$D(^SDEC(409.831,+SDECRES,0)) Q
 I '+SDECRES S SDECRES=$O(^SDEC(409.831,"B",SDECRES,0))
 G:'SDECRES GETX
 S %DT="T",X=$P($P(SDECSTART,"@",1),".",1) D ^%DT
 G:Y=-1 GETX
 S SDECSTART=Y
 S %DT="T",X=$P($P(SDECEND,"@",1),".",1) D ^%DT
 G:Y=-1 GETX
 S SDECEND=Y
 S SDCL=$$GET1^DIQ(409.831,SDECRES_",",.04,"I")
 G:SDCL="" GETX
 ;L +^SDEC(409.831,SDECRES):5 G:'$T GETX
 S SDI=$$FMADD^XLFDT(SDECSTART,-1)
 F  S SDI=$$FMADD^XLFDT(SDI,1) Q:SDI>$P(SDECEND,".",1)  D
 .I ($O(^SC(SDCL,"T",0))="")!($O(^SC(SDCL,"T",0))>SDI) Q
 .I $$GET1^DIQ(44,SDCL_",",1918.5,"I")'="Y",$D(^HOLIDAY("B",SDI)) Q   ;do not schedule on holidays
 .Q:$$INACTIVE^SDEC32(SDCL,$P(SDI,".",1))   ;don't get availability if clinic inactive on day SDI
 .;Q:$G(^SC(SDCL,"ST",SDI,1))["**CANCELLED**"
 .D RESAB^SDECUTL2(SDAB,SDCL,SDI,SDI_"."_2359,SDECRES)
GETX ;
 ;L -^SDEC(409.831,SDECRES)
 Q
 ;
ABM ;Maintenance routine for SDEC ACCESS BLOCK file to be scheduled nightly
 Q
 ;
SDTYPES(SDTYPES,SDECTYPES) ;
 N SDI,SDTYPE,SDTYPEN
 K SDTYPES
 F SDI=1:1:$L(SDECTYPES,"|") D
 .S SDTYPEN=$P(SDECTYPES,"|",SDI)
 .I +SDTYPEN S SDTYPE=SDTYPEN,SDTYPEN=$$GET1^DIQ(409.823,SDTYPE_",",.01)
 .E  S SDTYPE=$O(^SDEC(409.823,"B",$E(SDTYPEN,1,30),0))
 .S:SDTYPE'="" SDTYPES(SDTYPE)=SDTYPEN
 Q
 ;
DEL(SDRES,SDBEG,SDEND) ;delete access blocks
 Q
 ;
NOAVAIL(SDECY,SDCL)   ;GET: has the given clinic ever had any availability defined?
 ;SDCL = (required) Clinic ID pointer to HOSPITAL LOCATION file
 ;RETURN:
 ;   1. AVAILABILITY:
 ;        YES = Availability has been defined for this clinic
 ;              (even if there is no availability defined 'now')
 ;        NO  = Availability has never been defined for this clinic.
 N SDECI
 S SDECI=0
 S SDECY="^TMP(""SDEC04"","_$J_",""NOVAVAIL"")"
 K @SDECY
 S @SDECY@(SDECI)="T00030AVAILABILITY"_$C(30)
 ;validate SDCL
 S SDCL=$G(SDCL) I '$D(^SC(+SDCL,0)) S SDECI=SDECI+1 S @SDECY@(SDECI)="-1^Invalid clinic id."_$C(30,31) Q
 S SDECI=SDECI+1 S @SDECY@(SDECI)=$S(+$O(^SC(SDCL,"T",0)):"YES",1:"NO")_$C(30,31)
 Q
