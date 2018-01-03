MHVXUSR ;WAS/DLF/MJK - User extract ; 5/6/10 4:12pm
 ;;1.0;My HealtheVet;**6,29**;July 10, 2017;Build 73
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;  Integration Agreements:
 ;       10060 : New Person file #200
 ;       2343  : $$ACTIVE^XUSER(Y)
 ;       10103 : $$DT^XLFDT
 ;               $$NOW^XLFDT
 ;       10076 : Read ^XUSEC("PROVIDER",DUZ
 ;       1625  : PERSON CLASS- PROVIDER TYPE - CLASSIFICATION (File #8932.1)
 ;               $$GET^XUA4A72(USRIEN) - Patch 29
 ;       10093 : SERVICE/SECTION file #49
 ;       2533  : $$DIV4^XUSER(.ZZ[,duz])- DIVISIONS - Patch 29
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
 N USRNAME,USROUT,USRFNAME,OUT,PPHONE,SSECTION,USRIEN,PRV,TTITLE
 N PRVCLS,REQSIG,NETWKID
 N PERSCLS,PCEFDT,PCEXDT,PROVSPEC,PROVDIVS,USERCLS,DATARSTR,I,RETST,SUB
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
 . ;JAZZ#409966-Fix Names with Space in SM queries;and more User Fields - existing issue
 . ;retrieve only active user patrial match - if Name passed in
 . D LIST^DIC(200,"","","",,QRY("LNAME"),QRY("LNAME"),"B","I $$ACTIVE^XUSER(Y)","",OUT)
 E  D  ; Lookup by IEN
 . ;JAZZ#409966-Fix Names with Space in SM queries;and more User Fields - existing issue
 . ;retrieve both active and inactive user for exact DUZ match -
 . S @OUT@("DILIST",2,1)=QRY("IEN")
 ;
 ;$O through the OUT array to get the IEN to check for roles
 ;
 S IIEN="",HIT=0
 F  S IIEN=$O(@OUT@("DILIST",2,IIEN)) Q:IIEN=""  D
 .S USRIEN=@OUT@("DILIST",2,IIEN)
 . ; Fieds extracted pre-patch 29:
 . ; - #.01 NAME                - AI#10060 New Person file #200
 . ; - #.132 OFFICE PHONE       - AI#10060 New Person file #200
 . ; - #8 TITLE                 - AI#10060 New Person file #200
 . ; - #29 SERVICE/SECTION      - AI#10093 SERVICE/SECTION file #49
 . ;-----------------------------------------------------------------------------------------
 . ;JAZZ#409966-Fix Names with Space in SM queries- existing issue;and more User Fields;ADDED:
 . ; - #53.5-PROVIDER CLASS - POINTER TO #7 PROVIDER CLASS FILE - AI#10060
 . ; - #53.7 REQUIRES COSIGNER - AI#10060
 . ; - #501.1 NETWORK ID - AI#10060
 . ; - #8932.1-PERSON CLASS-PROVIDER TYPE-CLASSIFICATION -today's active-AI#1625
 . ;        .01  Person Class (*P8932.1'a), [0;1]
 . ;         2    Effective Date (RDXa), [0;2]
 . ;         3    Expiration Date (Da), [0;3]
 . ; - #747.111-SPECIALTY -[pointer to SPECIALTY file (#747.9)]-today's active-above call- AI#1625
 . ; - #16- DIVISION (multiple) [pointer to INSTITUTION FILE (#4)] - AI#2533
 . ;        $$DIV4^XUSER(.ZZ[,duz])- DIVISIONS
 . ;-----------------------------------------------------------------------------------------
 .;D GETS^DIQ(200,USRIEN_",",".01;.132;8;29","E","USROUT","DIERR")
 .K DIERR
 .D GETS^DIQ(200,USRIEN_",",".01;.132;8;29;53.5;53.7;501.1","E","USROUT","DIERR")
 .Q:$G(DIERR)
 .S USRNAME=$G(USROUT(200,USRIEN_",",.01,"E"))
 .S USRFNAME=$P(USRNAME,",",2)
 .Q:$E(USRFNAME,1,$L(QRY("FNAME")))'=QRY("FNAME")
 .S PPHONE=$G(USROUT(200,USRIEN_",",.132,"E"))
 .S TTITLE=$G(USROUT(200,USRIEN_",",8,"E"))
 .S SSECTION=$G(USROUT(200,USRIEN_",",29,"E"))
 .S PRV="",PRVCLS="",REQSIG="",NETWKID=""
 .I $D(^XUSEC("PROVIDER",USRIEN)) S PRV="PROVIDER"
 .S PRVCLS=$G(USROUT(200,USRIEN_",",53.5,"E"))
 .S REQSIG=$G(USROUT(200,USRIEN_",",53.7,"E"))
 .S NETWKID=$G(USROUT(200,USRIEN_",",501.1,"E"))
 .;PERSON CLASS-EFFECTIVE DATE;EXPIRATION DATE; SPECIALTY(multiple)-only there is an active entry -#1625
 .S RETST="",PERSCLS="",PCEFDT="",PCEXDT="",PROVSPEC=""
 .S RETST=$$GET^XUA4A72(USRIEN)
 .;PERSON CLASS; EFFECTIVE DATE; EXPIRATION DATE;SPECIALTY- AI#1625
 .I RETST>0 D
 .. S PERSCLS=$P(RETST,"^",2)
 .. S PCEFDT=$P(RETST,"^",5),PCEXDT=$P(RETST,"^",6)
 .. S PROVSPEC=$P(RETST,"^",3)
 .I RETST<=0 D
 .. I RETST=-1 S PERSCLS="Person Class never assigned"
 .. I RETST=-2 S PERSCLS="No active Person Class"
 .;DIVISION (multiple)
 .K DIERR
 .D GETS^DIQ(200,USRIEN_",","16*","E","USROUT","DIERR")
 .S PROVDIVS=""
 .S SUB="0,"_USRIEN_","
 .F  S SUB=$O(USROUT(200.02,SUB)) Q:SUB'[USRIEN_","  D
 .. I $D(USROUT(200.02,SUB))>1 D 
 ... S PROVDIVS=PROVDIVS_$G(USROUT(200.02,SUB,.01,"E"))_"~"_$G(USROUT(200.02,SUB,1,"E"))_"_"
 .S HIT=HIT+1
 .;JAZZ#409966-Fix Names with Space in SM queries- existing issue;and more User Fields
 .;S @DATAROOT@(HIT)=USRIEN_U_USRNAME_U_PRV_U_U_U_U_PPHONE_U_SSECTION_U_TTITLE
 .S DATARSTR=USRIEN_U_USRNAME_U_PRV_U_PRVCLS_U_PROVSPEC_U_REQSIG_U_PPHONE_U_SSECTION_U_TTITLE_U_NETWKID
 .S DATARSTR=DATARSTR_U_PERSCLS_U_PCEFDT_U_PCEXDT_U_PROVDIVS
 .S @DATAROOT@(HIT)=DATARSTR
 ;
 ; Update dataroot with number of hits and
 ; write to the log
 ;
 K @OUT
 S @DATAROOT=HIT_U_EXTIME  ; count of hits ^ time
 D LOG^MHVUL2("USERS~MHVXUSR",HIT_" HITS","S","TRACE")
 D LOG^MHVUL2("USERS~MHVXUSR","END","S","TRACE")
 Q
