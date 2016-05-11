SDEC47 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
CLINDIS(SDECY,SDECCLST,SDECBEG,SDECEND,SDECWI) ;Return formatted text output of the Clinic Schedules Report
 ;CLINDIS(SDECY,SDECCLST,SDECBEG,SDECEND,SDECWI)  external parameter tag is in SDEC
 ;Return formatted text output of the Clinic Schedules Report
 ;between dates SDECBEG and SDECEND for each clinic in SDECCLST.
 ;SDECCLST is a |-delimited list of SDEC RESOURCE iens.  (The last |-piece is null, so discard it.)
 ;SDECBEG and SDECEND are in external date form.
 ;SDECWI = return only appointments where the WALKIN field is yes
 ;
 N SDECI,SDECNOD,SDECNAM,SDECDOB,SDECHRN,SDECSEX,SDECCID,SDECCNOD,SDECDT
 N SDECJ,SDECAID,SDECPAT,SDECPNOD,SDECCLN,SDECCLRK,SDECMADE,SDECNOT,SDECLIN
 N SDECSTRT,SDECAPT,SDECQ,SDECTMP,SDECTYPE
 N SDECSTRE,SDECCITY,SDECST,SDECZIP,SDECPHON,%DT,X,Y
 S SDECY="^TMP(""SDEC"","_$J_")"
 K ^TMP("SDEC",$J)
 S SDECI=0
 S ^TMP("SDEC",$J,SDECI)="T00080TEXT"_$C(30)
 ;
 ;Convert beginning and ending dates
 ;
 S SDECBEG=$P(SDECBEG,"@",1)
 S X=SDECBEG,%DT="X" D ^%DT S SDECBEG=$P(Y,"."),SDECBEG=SDECBEG-1,SDECBEG=SDECBEG_".9999"
 I Y=-1 D ERR("0^Routine: SDEC47, Error: Invalid Date") Q
 S SDECEND=$P(SDECEND,"@",1)
 S X=SDECEND,%DT="X" D ^%DT S SDECEND=$P(Y,"."),SDECEND=SDECEND_".9999"
 I Y=-1 D ERR("0^Routine: SDEC47, Error: Invalid Date") Q
 I SDECCLST="" D ERR("0^Routine: SDEC47, Error: Null clinic list") Q
 ;
 ;header
 ;                                     1                18          30      38          50             66            79
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="Name             DOB         Sex     HRN         Clinic"_$C(30)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="====             ===         ===     ===         ======"_$C(30)
 ;For each clinic in SDECCLST $O through ^SDEC(409.84,"ARSRC",ResourceIEN,FMDate,ApptIEN)
 F SDECJ=1:1:$L(SDECCLST,"|")-1 S SDECCID=$P(SDECCLST,"|",SDECJ) D
 . S SDECCLN=$G(^SDEC(409.831,SDECCID,0)) S SDECCLN=$P(SDECCLN,U) Q:SDECCLN=""
 . S SDECSTRT=SDECBEG F  S SDECSTRT=$O(^SDEC(409.84,"ARSRC",SDECCID,SDECSTRT)) Q:'+SDECSTRT  Q:SDECSTRT>SDECEND  D
 . . S SDECAID=0 F  S SDECAID=$O(^SDEC(409.84,"ARSRC",SDECCID,SDECSTRT,SDECAID)) Q:'+SDECAID  D
 . . . S SDECNOD=$G(^SDEC(409.84,SDECAID,0))
 . . . Q:SDECNOD=""
 . . . Q:$P(SDECNOD,U,12)]""  ;CANCELLED
 . . . I '$G(SDECWI),$P(SDECNOD,U,13)="y" Q  ;DO NOT ALLOW WALKIN
 . . . I $G(SDECWI),$P(SDECNOD,U,13)'="y" Q  ;ONLY ALLOW WALKIN
 . . . S Y=$P(SDECNOD,U)
 . . . Q:'+Y
 . . . X ^DD("DD") S Y=$TR(Y,"@"," ")
 . . . S SDECAPT=Y ;Appointment date time
 . . . ;
 . . . ;NOTE
 . . . S SDECNOT=""
 . . . I $D(^SDEC(409.84,SDECAID,1,0)) S SDECQ=0 F  S SDECQ=$O(^SDEC(409.84,SDECAID,1,SDECQ)) Q:'+SDECQ  D
 . . . . S SDECLIN=$G(^SDEC(409.84,SDECAID,1,SDECQ,0))
 . . . . S:(SDECLIN'="")&($E(SDECLIN,$L(SDECLIN)-1,$L(SDECLIN))'=" ") SDECLIN=SDECLIN_" "
 . . . . S SDECNOT=SDECNOT_SDECLIN
 . . . ;
 . . . S SDECPAT=$P(SDECNOD,U,5)
 . . . S SDECPNOD=$$PATINFO^SDEC27(SDECPAT)
 . . . S SDECNAM=$P(SDECPNOD,U) ;NAME
 . . . S SDECSEX=$P(SDECPNOD,U,2) ;SEX
 . . . S SDECDOB=$P(SDECPNOD,U,3) ;DOB
 . . . S SDECHRN=$P(SDECPNOD,U,4) ;Health Record Number for location DUZ(2)
 . . . S SDECSTRE=$P(SDECPNOD,U,5) ;Street
 . . . S SDECCITY=$P(SDECPNOD,U,6) ;City
 . . . S SDECST=$P(SDECPNOD,U,7) ;State
 . . . S SDECZIP=$P(SDECPNOD,U,8) ;zip
 . . . S SDECPHON=$P(SDECPNOD,U,9) ;homephone
 . . . S SDECTYPE="" ;Type/status doesn't exist for SDEC APPT clinics and it's not needed for clinic letters
 . . . S SDECCLRK=$P(SDECNOD,U,8)
 . . . S:+SDECCLRK SDECCLRK=$G(^VA(200,SDECCLRK,0)),SDECCLRK=$P(SDECCLRK,U)
 . . . S Y=$P(SDECNOD,U,9)
 . . . I +Y X ^DD("DD") S Y=$TR(Y,"@"," ")
 . . . S SDECMADE=Y
 . . . S SDECTMP=$E(SDECNAM,1,15)
 . . . S SDECTMP=SDECTMP_$$FILL^SDECU(17-$L(SDECTMP))_SDECDOB
 . . . S SDECTMP=SDECTMP_$$FILL^SDECU(29-$L(SDECTMP))_SDECSEX
 . . . S SDECTMP=SDECTMP_$$FILL^SDECU(37-$L(SDECTMP))_SDECHRN
 . . . S SDECTMP=SDECTMP_$$FILL^SDECU(49-$L(SDECTMP))_$E(SDECCLN,1,15)
 . . . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 . . . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="APPOINTMENT DATE: "_SDECAPT_$C(30)
 . . . S SDECTMP="APPT MADE BY:     "_$E(SDECCLRK,1,20)
 . . . S SDECTMP=SDECTMP_$$FILL^SDECU(39-$L(SDECTMP))_"DATE APPT MADE:   "_SDECMADE
 . . . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECTMP_$C(30)
 . . . I SDECSTRE'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="Address: "_SDECSTRE_$C(30)
 . . . I SDECCITY'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="         "_SDECCITY_", "_SDECST_"  "_SDECZIP_$C(30)
 . . . I SDECPHON'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="Phone:   "_SDECPHON_$C(30)
 . . . I SDECNOT'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="NOTE: "_$E(SDECNOT,1,73)_$C(30)
 . . . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""_$C(30)
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
CLINDISW(SDECY,SDECCLST,SDECBEG,SDECEND) ;Return formatted text output of the Clinic Schedules Report for Walkins
 ;CLINDISW(SDECY,SDECCLST,SDECBEG,SDECEND)  external parameter tag is in SDEC
 ;Return formatted text output of the Clinic Schedules Report for Walkins
 ;between dates SDECBEG and SDECEND for each clinic in SDECCLST.
 ;SDECCLST is a |-delimited list of SDEC RESOURCE iens.  (The last |-piece is null, so discard it.)
 ;SDECBEG and SDECEND are in external date form.
 S:$G(U)="" U="^"
 D CLINDIS(.SDECY,SDECCLST,SDECBEG,SDECEND,1)
 Q
 ;
RESLETRF(SDECY,SDECRES,SDECLT) ;Return formatted text output of the Resource's Letter - either "LETTER TEXT" (also used as Reminder Letter), NO SHOW LETTER, or CLINIC CANCELLATION LETTER.
 ;RESLETRF(SDECY,SDECRES,SDECLT)  external parameter tag is in SDEC
 ;Called by SDEC RESOURCE LETTER FORMATTED
 ;Return formatted text output of the Resource's Letter - either "LETTER TEXT" (also used as Reminder Letter), NO SHOW LETTER, or CLINIC CANCELLATION LETTER.
 ;SDECRES = Resource IEN from the SDEC RESOURCE file
 ;SDECLT  = Letter type: "R"=Reminder Letter; "C" or "A"=Clinic Cancellation letter; "N"=No Show Letter
 ;
 N SDECH,SDECI,SDECJ,SDECL
 N SDECNOD,SDECNAM,SDECDOB,SDECHRN,SDECSEX,SDECCID,SDECCNOD,SDECDT
 N SDECJ,SDECAID,SDECPAT,SDECPNOD,SDECCLN,SDECCLRK,SDECMADE,SDECNOT,SDECLIN
 N SDECSTRT
 N SDECSTRE,SDECCITY,SDECST,SDECZIP,SDECPHON
 S SDECY="^TMP(""SDEC"","_$J_")"
 K ^TMP("SDEC",$J)
 S SDECI=0
 ;check resource
 I $G(SDECRES)="" D ERR("0^SDEC47: Resource not specified.")
 I '$D(^SDEC(409.831,SDECRES)) D ERR("0^SDEC47: Invalid Resource specified.")
 ;check letter type
 I $G(SDECLT)="" D ERR("0^SDEC47: Letter type not specified.")
 I "ACNR"'[SDECLT D ERR("0^SDEC47: Invalid letter type specified.")
 ;return header
 S ^TMP("SDEC",$J,0)="T00080TEXT"_$c(30)
 ;
 ;format body of letter
 S SDECH=0
 F  S SDECH=$O(^SDEC(409.831,SDECRES,$S(SDECLT="A":13,SDECLT="C":13,SDECLT="N":12,1:1),SDECH)) Q:SDECH=""  D
 . S SDECL=$G(^SDEC(409.831,SDECRES,$S(SDECLT="A":13,SDECLT="C":13,SDECLT="N":12,1:1),SDECH,0))
 . I SDECL'="",$L(SDECL)>79 S SDECL=$$FL^SDECUTL(SDECL,80)
 . F SDECJ=1:1:$L(SDECL,"||") S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$P(SDECL,"||",SDECJ)_$C(30)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
ERROR ;
 D ERR("VISTA Error")
 Q
 ;
ERR(ERRTXT) ;Error processing
 S:'$D(SDECI) SDECI=999
 S ERRTXT=$G(ERRTXT)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=ERRTXT_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
