ALPBUTL1 ;OIFO-DALLAS MW,SED,KC-BCBU BACKUP REPORT FUNCTIONS AND UTILITIES  ;01/01/03
 ;;3.0;BAR CODE MED ADMIN;**8,37**;Mar 2004;Build 10
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference/IA
 ; INP^VADPT/10061
 ; DIC(42/10039
 ; DIC(42/2440
 ;
ERRBLD(SEG,MSG,ERR) ; build an error array for non-FileMan-related errors...
 ; SEG = HL7 segment name
 ; MSG = a message that will be used in the error text portion of the array (optional -- if not passed, the
 ;       default will be used)
 ; ERR = array passed by reference in which error will be returned
 ; note:  code 999 is a code indicating a non-FileMan error for filing the error message in file 53.71
 S ERR("DIERR")=1
 S ERR("DIERR",1)=999
 S ERR("DIERR",1,"TEXT",1)=$S($G(MSG)'="":MSG,1:"Invalid parameter passed to "_SEG_" module in routine ALPBHL1U")
 Q
 ;
ERRLOG(IEN,OIEN,MSGREC,SEGNAME,SEGDATA,ERRTEXT) ; log filing errors...
 ; this module logs error data in the BCMA BACKUP PARAMETERS file (53.71).  These
 ; errors usually occur as the result of missing or bad data passed to one of the
 ; File Manager DBS calls used by this package.
 ; 
 ; IEN       = the patient's record number in file 53.7
 ; OIEN      = the order number's sub-file record number in file 53.7
 ; MSGREC    = the HL7 message's record number in file 772
 ; SEGNAME   = the HL7 segment associated with the error (optional)
 ; SEGDATA   = the HL7 segment's data (optional)
 ; ERRTEXT   = an array passed by reference which contains the error
 ;             code (numeric) and the error text to be filed.  It is
 ;             expected that this is usually the error array returned
 ;             from a FileMan DBS call, so the format is specific:
 ;
 ;             ERRTEXT("DIERR",n)=error code (numeric)
 ;             ERRTEXT("DIERR",n,"TEXT",1)=first line of error text
 ;             ERRTEXT("DIERR",n,"TEXT",2)=second line of error text
 ;             ERRTEXT("DIERR",n,"TEXT",n)=last line of error text
 ;
 ;             However, any error message can be passed to this module
 ;             as long as the above format is used.
 N ALPBCODE,ALPBFERR,ALPBFILE,ALPBLOGD,ALPBN1,ALPBN2,ALPBPIEN,ALPBTEXT,ALPBX
 S ALPBLOGD=$$NOW^XLFDT()
 S ALPBPIEN=+$O(^ALPB(53.71,0))
 I ALPBPIEN=0 D
 .S X="ONE"
 .S DIC="^ALPB(53.71,"
 .S DIC(0)="LZ"
 .S DIC("DR")="1///^S X=3"
 .S DINUM=1
 .S DLAYGO=53.71
 .D FILE^DICN K DIC
 .S ALPBPIEN=+Y
 I ALPBPIEN'>0 Q
 S ALPBN1=+$O(^ALPB(53.71,ALPBPIEN,1," "),-1)+1
 S ALPBFILE(53.713,"+"_ALPBN1_","_ALPBPIEN_",",.01)=ALPBLOGD
 S ALPBFILE(53.713,"+"_ALPBN1_","_ALPBPIEN_",",1)=+$G(IEN)
 S ALPBFILE(53.713,"+"_ALPBN1_","_ALPBPIEN_",",2)=+$G(OIEN)
 S ALPBFILE(53.713,"+"_ALPBN1_","_ALPBPIEN_",",3)=+$G(MSGREC)
 S ALPBFILE(53.713,"+"_ALPBN1_","_ALPBPIEN_",",3.1)=$G(SEGNAME)
 S ALPBFILE(53.713,"+"_ALPBN1_","_ALPBPIEN_",",3.2)=$G(SEGDATA)
 D UPDATE^DIE("","ALPBFILE","ALPBN1","ALPBFERR")
 K ALPBFERR,ALPBFILE
 S ALPBX=0
 F  S ALPBX=$O(ERRTEXT("DIERR",ALPBX)) Q:'ALPBX  D
 .S ALPBCODE=ERRTEXT("DIERR",ALPBX)
 .; file the error code...
 .S ALPBN2=+$O(^ALPB(53.71,ALPBPIEN,1,ALPBN1,2," "),-1)+1
 .S ALPBFILE(53.7135,"+"_ALPBN2_","_ALPBN1_","_ALPBPIEN_",",.01)=ALPBCODE
 .D UPDATE^DIE("","ALPBFILE","ALPBN2","ALPBFERR")
 .K ALPBFERR,ALPBFILE
 .; file the error text...
 .M ALPBTEXT=ERRTEXT("DIERR",ALPBX,"TEXT")
 .D WP^DIE(53.7135,ALPBN2_","_ALPBN1_","_ALPBPIEN_",",1,"","ALPBTEXT","ALPBFERR")
 .;S ALPBFILE(53.7135,"+"_ALPBN2_","_ALPBN1_","_ALPBPIEN_",",1)=ALPBTEXT
 .;D UPDATE^DIE("","ALPBFILE","ALPBN2","ALPBFERR")
 .K ALPBCODE,ALPBFERR,ALPBFILE,ALPBN2,ALPBTEXT
 Q
 ;
CLEAN(IEN) ; check error log records to see if the patients' whose records
 ; are noted still exist in file 53.7.  if not, delete the error log
 ; record(s) in file 53.71...
 ; IEN = patient record number in file 53.7
 ; Note:  this function is also called from DELPT^ALPBUTL when a patient's
 ; record is deleted (as a result of a discharge action) from 53.7.
 ;
 N ALPBX,ALPBY,DA,DIK,X,Y
 ; patient still has record in 53.7?  if so, quit...
 I $G(^ALPB(53.7,IEN,0))'="" Q
 S ALPBX=0
 F  S ALPBX=$O(^ALPB(53.71,"C",IEN,ALPBX)) Q:'ALPBX  D
 .S ALPBY=0
 .F  S ALPBY=$O(^ALPB(53.71,"C",IEN,ALPBX,ALPBY)) Q:'ALPBY  D
 ..S DA=ALPBY
 ..S DA(1)=ALPBX
 ..S DIK="^ALPB(53.71,"_DA(1)_",1,"
 ..D ^DIK
 ..K DA,DIK
 .K ALPBY
 K ALPBX
 Q
 ;
DELERR(ERRIEN) ; delete an error log entry from file 53.71...
 ; ERRIEN = error log entry's internal record number
 N ALPBPARM,DA,DIK,X,Y
 S ALPBPARM=+$O(^ALPB(53.71,0))
 I ALPBPARM'>0 Q
 S DA=ERRIEN
 S DA(1)=ALPBPARM
 S DIK="^ALPB(53.71,"_DA(1)_",1,"
 D ^DIK
 Q
 ;
PTLIST(LTYPE,RESULTS) ; get list of patients in file 53.7...
 ; LTYPE   = passed = "ALL" to list all patients or
 ;                  = <wardname> to list patients on a selected ward
 ; RESULTS = an array passed by reference in which data will be returned
 N ALPBDATA,ALPBIEN,ALPBPTN,ALPBX
 I $G(LTYPE)="" S LTYPE="ALL"
 S ALPBX=0
 I LTYPE="ALL" D
 .S ALPBPTN=""
 .F  S ALPBPTN=$O(^ALPB(53.7,"B",ALPBPTN)) Q:ALPBPTN=""  D
 ..S ALPBIEN=0
 ..F  S ALPBIEN=$O(^ALPB(53.7,"B",ALPBPTN,ALPBIEN)) Q:'ALPBIEN  D
 ...S ALPBDATA=$G(^ALPB(53.7,ALPBIEN,0))
 ...I ALPBDATA="" K ALPBDATA Q
 ...S ALPBX=ALPBX+1
 ...S RESULTS(ALPBX)=ALPBPTN_"^"_$P(ALPBDATA,"^",2)_"^"_$P(ALPBDATA,"^",5)_"^"_$P(ALPBDATA,"^",6)_"^"_$P(ALPBDATA,"^",7)
 ...K ALPBDATA
 ..K ALPBIEN
 .K ALPBPTN
 I LTYPE'="ALL" D
 .S ALPBPTN=""
 .F  S ALPBPTN=$O(^ALPB(53.7,"AW",LTYPE,ALPBPTN)) Q:ALPBPTN=""  D
 ..S ALPBIEN=0
 ..F  S ALPBIEN=$O(^ALPB(53.7,"AW",LTYPE,ALPBPTN,ALPBIEN)) Q:'ALPBIEN  D
 ...S ALPBDATA=$G(^ALPB(53.7,ALPBIEN,0))
 ...I ALPBDATA="" K ALPBDATA Q
 ...S ALPBX=ALPBX+1
 ...S RESULTS(ALPBX)=ALPBPTN_"^"_$P(ALPBDATA,"^",2)_"^"_$P(ALPBDATA,"^",5)_"^"_$P(ALPBDATA,"^",6)_"^"_$P(ALPBDATA,"^",7)
 ...K ALPBDATA
 ..K ALPBIEN
 .K ALPBPTN
 Q
 ;
STAT(ST) ;This will return the value of a status code for pharmacy
 I $G(ST)="" Q ""
 I $L($T(@ST)) G @ST
 Q ""
IP Q "pending"
CM Q "finished/verified by pharmacist(active)"
DC Q "discontinued"
RP Q "replaced"
HD Q "on hold"
ZE Q "expired"
ZS Q "suspended(active)"
ZU Q "un-suspended(active)"
ZX Q "unreleased"
ZZ Q "renewed"
 ;
STAT2(CODE) ; convert order status code for output...
 ; this function is used primarily by the workstation software
 ; CODE = an order status code
 ; returns printable status code
 I $G(CODE)="" Q "Unknown"
 I CODE="IP"!(CODE="ZX") Q "Pending"
 I CODE="CM"!(CODE="ZU")!(CODE="ZZ") Q "Active"
 I CODE="HD"!(CODE="ZS") Q "Hold"
 I CODE="DC"!(CODE="RP")!(CODE="ZE") Q "Expired"
 Q "Unknown"
 ;
DIV(DFN,ALPBMDT) ;get the Division for a patient
 I +$G(DFN)'>0 Q ""
 N ALPBDIV,ALPWRD,VAIN,VAINDT
 S:+$G(ALPBMDT)>0 VAINDT=$P(ALPBMDT,".",1)
 K ALPBMDT
 D INP^VADPT
 S ALPWRD=$P($G(VAIN(4)),U,1)
 Q:+ALPWRD'>0 ""
 ;Check to see if ward is a DOMICILIARY 
 I $P($G(^DIC(42,ALPWRD,0)),U,3)="D",+$$GET^XPAR("PKG.BAR CODE MED ADMIN","PSB BKUP DOM FILTER",1,"Q")>0 Q "DOM"
 S ALPBDIV=$P($G(^DIC(42,ALPWRD,0)),U,11)
 Q:+ALPBDIV'>0 ""
 Q ALPBDIV
 ;
CNV(A,B,X) ;CONVERT A STRING
 ;This API will take a HL7 segment and convert characters
 ;defined in the input
 ;Example:
 ;Single encoding characters can be converted such as ^ to ~
 ;or multiple encoding characters can be converted such as
 ;  |~^@/ to ^~|/@
 ;A is the string of HL7 encoding characters to be converted
 ;B is the string of HL7 encoding characters to be converted to
 ;X is te message string to be converted
 I A=""!B=""!X="" Q ""
 F I=1:1:$L(A) S A(I)=$E(A,I,I),A(I,1)=""
 F I=1:1:$L(B) S B(I)=$E(B,I,I)
 S J=0
 F  S J=$O(A(J)) Q:+J'>0  D
 . F I=1:1:$L(X) S:$E(X,I,I)=A(J) A(J,1)=A(J,1)_I_U
 S J=0
 F  S J=$O(A(J)) Q:+J'>0  D
 . Q:'$D(A(J,1))!'$D(B(J))
 . F I=1:1:$L(A(J,1),U) S C=$P(A(J,1),U,I) S:+C>0 $E(X,C,C)=B(J)
 Q X
