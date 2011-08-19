ABSVMVV3 ;OAKLANDFO/DPC-VSS MIGRATION;7/19/2002
 ;;4.0;VOLUNTARY TIMEKEEPING;**31,33**;Jul 1994
 ;
PARKVAL(VOLIEN,PROFIEN,VOLIDEN,FLAG,VALRESPK) ;
 ;Validate Parking Sticker Information.
 N PARKIEN,PARK0
 N STPTR
 S PARKIEN=0
 F  S PARKIEN=$O(^ABS(503330,VOLIEN,4,PROFIEN,2,PARKIEN)) Q:PARKIEN=""  D
 . N ERRS S ERRS=0
 . S PARK0=$G(^ABS(503330,VOLIEN,4,PROFIEN,2,PARKIEN,0))
 . I PARK0="" Q
 . ;STICKER#
 . I $P(PARK0,U)="" D ADDERR^ABSVMVV1(VOLIDEN_"is missing a Parking Sticker.",.ERRS,VOLIEN)
 . I $L($P(PARK0,U))>13 D ADDERR^ABSVMVV1(VOLIDEN_"has a Parking Sticker longer than 13 characters.",.ERRS,VOLIEN)
 . ;REG STATE
 . S STPTR=$P(PARK0,U,2)
 . I STPTR'="",$L($P($G(^DIC(5,STPTR,0)),U,2))'=2 D ADDERR^ABSVMVV1(VOLIDEN_"has incorrect State data for a Parking Sticker.",.ERRS,VOLIEN)
 . ;PLATE#
 . I $L($P(PARK0,U,3))>12 D ADDERR^ABSVMVV1(VOLIDEN_"has a License Plate Number longer than 12 characters.",.ERRS,VOLIEN)
 . I ERRS>0 D RECERR^ABSVMUT1(.VALRESPK,.ERRS) Q
 . ;If got this far and FLAG=S, add to Parking Sort Template
 . I $G(FLAG)["S" S ^XTMP("ABSVMVOLPK","IEN",VOLIEN)=""
 . Q
 Q
 ;
COMBVAL(VOLIEN,VOLIDEN,FLAG,VALRESC) ;
 ;Validate combination data.
 N COMBIEN,COMB0,COMB
 N ORGPTR,SCHDPTR,SRVPTR
 S COMBIEN=0
 F  S COMBIEN=$O(^ABS(503330,VOLIEN,1,COMBIEN)) Q:COMBIEN=""  D
 . N ERRS S ERRS=0
 . S COMB0=$G(^ABS(503330,VOLIEN,1,COMBIEN,0))
 . I COMB0="" Q
 . I $P($P(COMB0,U),"-")]"" Q:$D(EXSITES($P($P(COMB0,U),"-")))  ;check for excluded sites
 . ;ORGANIZATION
 . S ORGPTR=$P(COMB0,U,2),COMB=$P(COMB0,U)
 . I ORGPTR="" D ADDERR^ABSVMVV1(VOLIDEN_"has Combination, "_COMB_" missing an Organization.",.ERRS,VOLIEN)
 . I ORGPTR'="",'$D(OCDS(ORGPTR)) D ADDERR^ABSVMVV1(VOLIDEN_"has Combination, "_COMB_" with an incorrect Organization Code.",.ERRS,VOLIEN)
 . ;SCHEDULE
 . S SCHDPTR=$P(COMB0,U,3)
 . I SCHDPTR="" D ADDERR^ABSVMVV1(VOLIDEN_"has Combination, "_COMB_" missing a Schedule.",.ERRS,VOLIEN)
 . I SCHDPTR'="",'$D(WCDS(SCHDPTR)) D ADDERR^ABSVMVV1(VOLIDEN_"has Combination, "_COMB_" with an incorrect Schedule Code.",.ERRS,VOLIEN)
 . ;SERVICE
 . S SRVPTR=$P(COMB0,U,4)
 . I SRVPTR="" D ADDERR^ABSVMVV1(VOLIDEN_"has Combination, "_COMB_" missing a Service.",.ERRS,VOLIEN)
 . I SRVPTR'="",'$D(SCDS(SRVPTR)) D ADDERR^ABSVMVV1(VOLIDEN_"has Combination, "_COMB_" with an incorrect Service Code.",.ERRS,VOLIEN)
 . ;INACTIVE
 . I ",0,1,"'[","_$P(COMB0,U,6)_"," D ADDERR^ABSVMVV1(VOLIDEN_"Has Combination, "_COMB_" with an incorrect Active/Inactive value.",.ERRS,VOLIEN)
 . I ERRS>0 D RECERR^ABSVMUT1(.VALRESC,.ERRS) Q
 . I $G(FLAG)["S" S ^XTMP("ABSVMVOLCB","IEN",VOLIEN)=""
 . Q
 Q
 ;
