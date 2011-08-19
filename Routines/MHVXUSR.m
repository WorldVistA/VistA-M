MHVXUSR ;WAS/DLF - User extract ; 9/25/08 4:12pm
 ;;1.0;My HealtheVet;**6**;Aug 23, 2005;Build 82
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;  Integration Agreements:
 ;       10060 : New Person file #200
 ;       10103 : $$DT^XLFDT
 ;               $$NOW^XLFDT
 ;
USERS(QRY,ERR,DATAROOT)        ; return users from file 200
 ;
 ; Primary Care Management Module interface
 ; return user data in DATAROOT
 ; QRY, ERR passed by ref.
 ;
 ;  Input:
 ;       QRY - Query array
 ;       ERR - Variable to hold error conditions
 ;       DATAROOT - Root of array to hold extract data
 ;  Output:
 ;       DATAROOT - Populated data array
 ;                  includes number of hits and timestamp
 ;       ERR - Errors during extraction, zero on success
 ;
 ;
 ;
 D LOG^MHVUL2("USERS~MHVXUSR","BEGIN","S","TRACE")
 ;
 K @DATAROOT,^TMP("MHXUSR",$J)  ; clean up residue
 ;
 N NXT,IIEN,NODE,TEAM,OUT,MHVPURPA,MHVROLEA,MHVLIST,MHVERR
 N DIERR,DT,EXTIME,HIT,LOGND,RTN,TMIEN,NM,U,X
 N USRNAME,USROUT,USRFNAME,OUT,PPHONE,SSECTION,USRIEN,PRV
 ;
 S U="^",DT=$$DT^XLFDT,ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 S OUT=$NA(^TMP("MHVXUSR",$J))
 S NXT=0,IIEN=0
 K @OUT
 ;
 ;FIND ALL ACTIVE NEW PERSONS THAT MATCH ENTRY
 ;
 I QRY("IEN")=""  D    ; Name lookup
 .D LIST^DIC(200,"","","",,QRY("LNAME"),QRY("LNAME"),"B","I $$ACTIVE^XUSER(Y)","",OUT)
 E  D  ; Lookup by IEN
 .S @OUT@("DILIST",2,1)=QRY("IEN")
 ;
 ;$O through the OUT array to get the IEN to check for roles
 ;
 S IIEN="",HIT=0
 F  S IIEN=$O(@OUT@("DILIST",2,IIEN)) Q:IIEN=""  D
 .S USRIEN=@OUT@("DILIST",2,IIEN)
 .D GETS^DIQ(200,USRIEN_",",".01;.132;29","E","USROUT","DIERR")
 .Q:$G(DIERR)
 .S USRNAME=$G(USROUT(200,USRIEN_",",.01,"E"))
 .S USRFNAME=$P(USRNAME,",",2)
 .Q:$E(USRFNAME,1,$L(QRY("FNAME")))'=QRY("FNAME")
 .S PPHONE=$G(USROUT(200,USRIEN_",",.132,"E"))
 .S SSECTION=$G(USROUT(200,USRIEN_",",.29,"E"))
 .S PRV=""
 .I $D(^XUSEC("PROVIDER",USRIEN)) S PRV="PROVIDER"
 .S HIT=HIT+1
 .S @DATAROOT@(HIT)=USRIEN_U_USRNAME_U_PRV_U_U_U_U_PPHONE_U_SSECTION
 ;
 ; Update dataroot with number of hits and
 ; write to the log
 ;
 K @OUT
 S @DATAROOT=HIT_U_EXTIME  ; count of hits ^ time
 D LOG^MHVUL2("USERS~MHVXUSR",HIT_" HITS","S","TRACE")
 D LOG^MHVUL2("USERS~MHVXUSR","END","S","TRACE")
 Q
