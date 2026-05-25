SDES915P ;ALB/TAW,TJB - SD*5.3*915 Post Init Routine ; June 25, 2025
 ;;5.3;SCHEDULING;**915**;AUG 13, 1993;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified
 ;;
 Q
 ;
EN ;
 D TASK,TASK1
 Q
 ;
 ;
TASK ; tasks off process to update the direct patient schedule field in the hospital location file
 D MES^XPDUTL("")
 D MES^XPDUTL(" SD*5.3*915 Post-Install to update DIRECT PATIENT SCHEDULING field in")
 D MES^XPDUTL(" HOSPITAL LOCATION file (#44)")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*915 Post Install Routine Task 1"
 D NOW^%DTC
 S ZTDTH=X,ZTIO="",ZTRTN="DIRPAT^SDES915P",ZTSAVE("*")=""
 D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL(" >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL(" UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL(" Please contact the National Help Desk to report this issue.")
 Q
 ;
TASK1 ; tasks off process to check 409.831 file for clinic resource pointing at the same clinic
 D MES^XPDUTL("")
 D MES^XPDUTL(" SD*5.3*915 Post-Install to check for duplicate clinic resources")
 D MES^XPDUTL(" on file 409.831 pointing to the same clinic (file #44) entry")
 D MES^XPDUTL(" is being queued to run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*915 Post Install Routine Task "
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="DUPCLIN^SDES915P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL(" >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL(" UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL(" Please contact the National Help Desk to report this issue.")
 Q
 ;
DIRPAT ;
 N CLNIEN,CLNNAME,RETURN,ERRORS,FDA,FIELD,UPDATECNT,STOPCODE,ERRORCNT
 S (CLNIEN,CLNNAME,RETURN,ERRORS,FDA,FIELD,UPDATECNT,STOPCODE,ERRORCNT)=""
 S (CLNNAME,CLNIEN)="",UPDATECNT=0
 K ^XTMP("SDES915P","VSE-10065")
 D GETSC  ;Look up the stop codes
 ;Loop over all Clinics in 44
 F  S CLNNAME=$O(^SC("AG","C",CLNNAME)) Q:CLNNAME=""  D
 .S CLNIEN=""
 .F  S CLNIEN=$O(^SC("AG","C",CLNNAME,CLNIEN)) Q:CLNIEN=""  D
 ..K RETURN
 ..D GETS^DIQ(44,CLNIEN_",","8;61;62;2503;2505;2506","I","RETURN","ERRORS")
 ..I $D(RETURN)<1 Q
 ..; Ensure we have the array built for empty fields
 ..F FIELD=8,61,62,2503,2505,2506 S RETURN(44,CLNIEN_",",FIELD,"I")=$G(RETURN(44,CLNIEN_",",FIELD,"I"))
 ..I ($E(RETURN(44,CLNIEN_",",61,"I"))="Y"),($E(RETURN(44,CLNIEN_",",62,"I"))="N") S UPDATECNT=UPDATECNT+1,^XTMP("SDES915P","VSE-10065",UPDATECNT)=CLNIEN_" : Invalid Patient scheduling on field 61 and 62" Q
 ..I $E(RETURN(44,CLNIEN_",",61,"I"))="Y" Q
 ..I $E(RETURN(44,CLNIEN_",",62,"I"))="N" Q
 ..; Check if clinics are inactive and have no future reactivation
 ..I RETURN(44,CLNIEN_",",2505,"I")'="" Q:$$CLNINACTIVE(CLNIEN,RETURN(44,CLNIEN_",",2506,"I"))
 ..; Stop Code
 ..I '$$VALIDSC(RETURN(44,CLNIEN_",",8,"I")) Q
 ..; Credit Stop Code
 ..I '$$VALIDCSC(RETURN(44,CLNIEN_",",2503,"I")) Q
 ..;
 ..; Direct Patient Scheduling = Y
 ..S FDA(44,CLNIEN_",",61)="Y"
 ..D FILE^DIE("","FDA","ERRORS")
 ..K FDA,ERRORS
 ..S UPDATECNT=UPDATECNT+1
 ..S ^XTMP("SDES915P","VSE-10065",UPDATECNT)=CLNIEN_" : "_$S($D(ERRORS):"ERROR",1:"UPDATED")
 S ^XTMP("SDES915P","VSE-10065",UPDATECNT+1)="Done : "_UPDATECNT_" clinics"
 D MAIL
 K ^XTMP("SDES915P","VSE-10065")
 Q
CLNINACTIVE(CLNIEN,REACTDT) ;
 N INACTIVE
 S INACTIVE=1
 ; Is the clinic active as of today
 S INACTIVE=$$INACTIVE^SDES2UTIL(CLNIEN,DT)
 ; Clinic is considered active if there is a future reactivation date
 I REACTDT,INACTIVE S:(REACTDT'<DT) INACTIVE=0
 ;
 Q INACTIVE
 ;
VALIDSC(SC) ;
 N VALID
 S VALID=0
 I SC,$D(STOPCODE("SC",SC)) S VALID=1
 Q VALID
 ;
VALIDCSC(CSC) ;
 N VALID
 S VALID=0
 I CSC="" S VALID=1
 I CSC,$D(STOPCODE("CSC",CSC)) S VALID=1
 Q VALID
 ;
GETSC ;Build an array of stop codes
 N CODE,IEN
 F CODE=322,323,350 D
 .S IEN=$O(^DIC(40.7,"C",CODE,""))
 .S:IEN STOPCODE("SC",IEN)=CODE
 F CODE=117,123,125,160,185,186,187 D
 .S IEN=$O(^DIC(40.7,"C",CODE,""))
 .S:IEN STOPCODE("CSC",IEN)=CODE
 Q
 ;
MAIL     ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM,%,D,D0,D1,D2,DG,DIC,DICR,DIW,XMDUN,XMZ
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 S XMDUZ=DUZ
 S XMTEXT="^XTMP(""SDES915P"",""VSE-10065"","
 S XMSUB=MESS1_"SD*5.3*915 - Post Install Data Report VSE-10065"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 S XMY("BARBER.LORI@DOMAIN.EXT")=""
 S XMY("DUNNAM.DAVID@DOMAIN.EXT")=""
 S XMY("WISE,TODD_A@DOMAIN.EXT")=""
 D ^XMD
 Q
 ;
DUPCLIN ;
 N I,FL,ZN,CLIEN,LIST,OUT,MISS,DUPS,RESIEN,RTIEN,RTNAM,RTSTAT,XT,XTMM
 K DUPS,MISS,CLIEN,^XTMP("SDES915P","VSE-10278")
 S XTMM=$NA(^XTMP("SDES915P","VSE-10278"))
 S I=0
 F  S I=$O(^SDEC(409.831,I)) Q:'+I  S ZN=^SDEC(409.831,I,0) D:$P(ZN,U,11)["SC("
 . I $P(ZN,U,4)="" S MISS(I)=ZN Q
 . S DUPS($P(ZN,U,4))=$G(DUPS($P(ZN,U,4)))+1,DUPS($P(ZN,U,4),I)=ZN
 ;
 S FL="ClinIEN^ClinName^ClinStat^ResourceIEN^ResourceClinIEN^ResourceClinName^ResourceClinStat^ResourceName^ResourceTypeInt"
 S CLIEN="",I=0
 F  S CLIEN=$O(DUPS(CLIEN)) Q:CLIEN=""  D
 . Q:DUPS(CLIEN)=1
 . S LIST=CLIEN_U_$P(^SC(CLIEN,0),U)_U_$S($$INACTIVE^SDES2UTIL(CLIEN)=1:"INACTIVE",1:"ACTIVE")
 . S RESIEN="" F  S RESIEN=$O(DUPS(CLIEN,RESIEN)) Q:RESIEN=""  D
 .. S RTIEN=$P($P(DUPS(CLIEN,RESIEN),U,11),";"),RTNAM=$S($D(^SC(RTIEN,0)):$P($G(^SC(RTIEN,0)),U),1:"Missing Clinic")
 .. S RTSTAT=$S($$INACTIVE^SDES2UTIL(RTIEN)=1:"INACTIVE",RTNAM="Missing Clinic":"N/A",1:"ACTIVE")
 .. S I=I+1,OUT(I)=LIST_U_RESIEN_U_RTIEN_U_RTNAM_U_RTSTAT_U_$P(DUPS(CLIEN,RESIEN),U)_U_$P(DUPS(CLIEN,RESIEN),U,11)
 ;
 S @XTMM@(1)=" "
 S @XTMM@(2)=FL
 S @XTMM@(3)=" "
 S XT=3,I=""
 F  S I=$O(OUT(I)) Q:'+I  S XT=XT+1,@XTMM@(XT)=OUT(I)
 I $D(MISS)>0 D
 . S XT=XT+1,@XTMM@(XT)=" "
 . S XT=XT+1,@XTMM@(XT)="Missing Clinics on Resource"
 . S I="" F  S I=$O(MISS(I)) Q:'+I  S XT=XT+1,@XTMM@(XT)=I_U_MISS(I)
 . S XT=XT+1,@XTMM@(XT)=" "
 S XT=XT+1,@XTMM@(XT)=" "
 S XT=XT+1,@XTMM@(XT)="DONE"
 S XT=XT+1,@XTMM@(XT)=" "
 D MAIL1
 Q
 ;
MAIL1 ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM,%,D,D0,D1,D2,DG,DIC,DICR,DIW,XMDUN,XMZ
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 S XMDUZ=DUZ
 S XMTEXT="^XTMP(""SDES915P"",""VSE-10278"","
 S XMSUB=MESS1_"SD*5.3*915 - Post Install Data Report VSE-10278"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 S XMY("BARBER.LORI@DOMAIN.EXT")=""
 S XMY("DUNNAM.DAVID@DOMAIN.EXT")=""
 S XMY("BOYDA.THOMAS@DOMAIN.EXT")=""
 D ^XMD
 K ^XTMP("SDES915P","VSE-10278")
 Q
