SDEC34 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
RBERR ;
 ;Called from RBCLIN on error to set up header
 K ^TMP("SDEC",$J)
 S ^TMP("SDEC",$J,0)="T00030Name^D00020DOB^T00030Sex^T00030HRN^D00030NewApptDate^T00030Clinic^T00030TypeStatus^I00010RESOURCEID"
 S ^TMP("SDEC",$J,0)=^(0)_"^T00030APPT_MADE_BY^D00020DATE_APPT_MADE^T00250NOTE^T00030STREET^T00030CITY^T00030STATE^T00030ZIP^T00030HOMEPHONE^D00030OldApptDate"_$C(30)
 D ERR(999)
 Q
 ;
CLINCAN(SDECY,SDECCLST,SDECBEG,SDECEND) ;Return recordset of CANCELLED patient appointments
 ;CLINCAN(SDECY,SDECCLST,SDECBEG,SDECEND)  external parameter tag is in SDEC
 ;Return recordset of CANCELLED patient appointments
 ;between dates SDECBEG and SDECEND for each clinic in SDECCLST.
 ;Used in generating cancellation letters for a clinic
 ;SDECCLST is a |-delimited list of SDEC RESOURCE iens.  (The last |-piece is null, so discard it.)
 ;SDECBEG and SDECEND are in external date form.
 ;RETURN:
 ; Global Array in which each array entry contains the following cancelled appointment data separated by ^:
 ; 1. Name
 ; 2. DOB
 ; 3. Sex
 ; 4. HRN
 ; 5. NewApptDate
 ; 6. Clinic
 ; 7. TypeStatus
 ; 8. RESOURCEID
 ; 9. APPT_MADE_BY
 ;10. DATE_APPT_MADE
 ;11. NOTE
 ;12. STREET
 ;13. CITY
 ;14. STATE
 ;15. ZIP
 ;16. HOMEPHONE
 ;17. OldApptDate
 N SDECCAN
 S SDECCAN=1
 D REBKCLIN(.SDECY,SDECCLST,SDECBEG,SDECEND)
 ;
 Q
 ;
REBKCLIN(SDECY,SDECCLST,SDECBEG,SDECEND) ;Return recordset of rebooked patient appointments between given dates
 ;REBKCLIN(SDECY,SDECCLST,SDECBEG,SDECEND)  external parameter tag is in SDEC
 ;Return recordset of rebooked patient appointments
 ;between dates SDECBEG and SDECEND for each clinic in SDECCLST.
 ;Used in generating rebook letters for a clinic
 ;SDECCLST is a |-delimited list of SDEC RESOURCE iens.  (The last |-piece is null, so discard it.)
 ;SDECBEG and SDECEND are in external date form.
 ;Called by SDEC REBOOK CLINIC LIST and SDEC CANCEL CLINIC LIST via entry point CANCLIN above
 ;
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 N %DT,X,Y,SDECJ,SDECCID,SDECCLN,SDECSTRT,SDECAID,SDECNOD,SDECLIST,SDEC,BSDY
 ;Convert beginning and ending dates
 ;
 S X=SDECBEG,%DT="XT" D ^%DT S SDECBEG=$P(Y,"."),SDECBEG=SDECBEG-1,SDECBEG=SDECBEG_".9999"
 I Y=-1 D RBERR(1) Q
 S X=SDECEND,%DT="XT" D ^%DT S SDECEND=$P(Y,"."),SDECEND=SDECEND_".9999"
 I Y=-1 D RBERR(1) Q
 I SDECCLST="" D RBERR(1) Q
 ;
 ;
 ;If SDECCLST is a list of resource NAMES, look up each name and convert to IEN
 F SDECJ=1:1:$L(SDECCLST,"|")-1 S SDEC=$P(SDECCLST,"|",SDECJ) D  S $P(SDECCLST,"|",SDECJ)=BSDY
 . S BSDY=""
 . I SDEC]"",$D(^SDEC(409.831,SDEC,0)) S BSDY=SDEC Q
 . I SDEC]"",$D(^SDEC(409.831,"B",SDEC)) S BSDY=$O(^SDEC(409.831,"B",SDEC,0)) Q
 . Q
 ;
 ;For each clinic in SDECCLST $O through ^SDEC(409.84,"ARSRC",ResourceIEN,FMDate,ApptIEN)
 ;
 S SDECLIST=""
 F SDECJ=1:1:$L(SDECCLST,"|")-1 S SDECCID=$P(SDECCLST,"|",SDECJ) D:+SDECCID
 . S SDECCLN=$G(^SDEC(409.831,SDECCID,0)) S SDECCLN=$P(SDECCLN,U) Q:SDECCLN=""
 . S SDECSTRT=SDECBEG F  S SDECSTRT=$O(^SDEC(409.84,"ARSRC",SDECCID,SDECSTRT)) Q:'+SDECSTRT  Q:SDECSTRT>SDECEND  D
 . . S SDECAID=0 F  S SDECAID=$O(^SDEC(409.84,"ARSRC",SDECCID,SDECSTRT,SDECAID)) Q:'+SDECAID  D
 . . . S SDECNOD=$G(^SDEC(409.84,SDECAID,0))
 . . . I $D(SDECCAN) D  Q
 . . . . I $P(SDECNOD,U,12) S SDECLIST=SDECLIST_SDECAID_"|" ;Cancelled appt
 . . . I $P(SDECNOD,U,11) S SDECLIST=SDECLIST_SDECAID_"|" ;Rebooked appt
 D REBKLIST(.SDECY,SDECLIST)
 Q
 ;
REBKLIST(SDECY,SDECLIST) ;patient appointments used in listing REBOOKED appointments for a list of appointmentIDs.
 ;REBKLIST(SDECY,SDECLIST)  external parameter tag is in SDEC
 ;SDECLIST - pipe |-delimited list of SDEC APPOINTMENT iens (the last |-piece is null)
 ;
 N SDECI,SDECIEN,SDECNOD,SDECCNID,SDECCNOD,SDECMADE,SDECCLRK,SDECNOT,SDECQ,SDEC
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S SDECI=0
 S ^TMP("SDEC",$J,SDECI)="T00030Name^D00020DOB^T00030Sex^T00030HRN^D00030NewApptDate^T00030Clinic^T00030TypeStatus"
 S ^TMP("SDEC",$J,SDECI)=^(SDECI)_"^I00010RESOURCEID^T00030APPT_MADE_BY^D00020DATE_APPT_MADE^T00250NOTE^T00030STREET^T00030CITY^T00030STATE^T00030ZIP^T00030HOMEPHONE^D00030OldApptDate"_$C(30)
 ;
 ;Iterate through SDECLIST
 S SDECIEN=0
 F SDEC=1:1:$L(SDECLIST,"|")-1 S SDECIEN=$P(SDECLIST,"|",SDEC) D
 . N SDECNOD,SDECAPT,SDECCID,SDECCNOD,SDECCLN,SDEC44,SDECDNOD,SDECSTAT,SDEC,SDECTYPE,SDECLIN,SDECPAT
 . N SDECSTRE,SDECCITY,SDECST,SDECZIP,SDECPHON
 . N SDECNAM,SDECDOB,SDECHRN,SDECSEX
 . N SDECREBK
 . S SDECNOD=$G(^SDEC(409.84,SDECIEN,0))
 . Q:SDECNOD=""
 . S SDECPAT=$P(SDECNOD,U,5) ;PATIENT ien
 . Q:'+SDECPAT
 . Q:'$D(^DPT(SDECPAT))
 . D PINFO(SDECPAT)
 . S Y=$P(SDECNOD,U)
 . Q:'+Y
 . X ^DD("DD") S Y=$TR(Y,"@"," ")
 . S SDECAPT=Y ;Appointment date time
 . S SDECREBK=""
 . S Y=$P(SDECNOD,U,11)
 . I +Y X ^DD("DD") S Y=$TR(Y,"@"," ") S SDECREBK=Y ;Rebook date time
 . S SDECCLRK=$P(SDECNOD,U,8) ;Appointment made by
 . S:+SDECCLRK SDECCLRK=$G(^VA(200,SDECCLRK,0)),SDECCLRK=$P(SDECCLRK,U)
 . S Y=$P(SDECNOD,U,9) ;Date Appointment Made
 . I +Y X ^DD("DD") S Y=$TR(Y,"@"," ")
 . S SDECMADE=Y
 . ;NOTE
 . S SDECNOT=""
 . I $D(^SDEC(409.84,SDECIEN,1,0)) S SDECNOT="",SDECQ=0 F  S SDECQ=$O(^SDEC(409.84,SDECIEN,1,SDECQ)) Q:'+SDECQ  D
 . . S SDECLIN=$G(^SDEC(409.84,SDECIEN,1,SDECQ,0))
 . . S:(SDECLIN'="")&($E(SDECLIN,$L(SDECLIN)-1,$L(SDECLIN))'=" ") SDECLIN=SDECLIN_" "
 . . S SDECNOT=SDECNOT_SDECLIN
 . ;Resource
 . S SDECCID=$P(SDECNOD,U,7) ;IEN of SDEC RESOURCE
 . Q:'+SDECCID
 . Q:'$D(^SDEC(409.831,SDECCID,0))
 . S SDECCNOD=$G(^SDEC(409.831,SDECCID,0)) ;SDEC RESOURCE node
 . Q:SDECCNOD=""
 . S SDECCLN=$P(SDECCNOD,U) ;Text name of SDEC Resource
 . S SDECTYPE="" ;Unused in this recordset
 . S SDECI=SDECI+1
 . S ^TMP("SDEC",$J,SDECI)=SDECNAM_"^"_SDECDOB_"^"_SDECSEX_"^"_SDECHRN_"^"_SDECREBK_"^"_SDECCLN_"^"_SDECTYPE_"^"_SDECCID_"^"_SDECCLRK_"^"_SDECMADE_"^"_SDECNOT_"^"_SDECSTRE_"^"_SDECCITY_"^"_SDECST_"^"_SDECZIP_"^"_SDECPHON_"^"_SDECAPT_$C(30)
 . Q
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
PINFO(SDECPAT) ;
 ;Get patient info
 N SDECNOD
 S SDECNOD=$$PATINFO^SDEC27(SDECPAT)
 S SDECNAM=$P(SDECNOD,U) ;NAME
 S SDECSEX=$P(SDECNOD,U,2) ;SEX
 S SDECDOB=$P(SDECNOD,U,3) ;DOB
 S SDECHRN=$P(SDECNOD,U,4) ;Health Record Number for location DUZ(2)
 S SDECSTRE=$P(SDECNOD,U,5) ;Street
 S SDECCITY=$P(SDECNOD,U,6) ;City
 S SDECST=$P(SDECNOD,U,7) ;State
 S SDECZIP=$P(SDECNOD,U,8) ;zip
 S SDECPHON=$P(SDECNOD,U,9) ;homephone
 Q
 ;
ERROR ;
 D ERR("VistA Error")
 Q
 ;
ERR(ERRNO) ;Error processing
 S:'$D(SDECI) SDECI=999
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)="^^^^^^^^^^^^^^^^"_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
