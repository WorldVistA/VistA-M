SDECAR1 ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**627,642**;Aug 13, 1993;Build 23
 ;
 Q
 ;
 ; Get SDEC APPOINTMENT REQUEST for all entries in the user's Institution
 ; where the Current Status is not C(losed).
ARGET(RET,ARIEN1,MAXREC,SDBEG,SDEND,DFN,LASTSUB,SDTOP) ;Waitlist GET
ARGET1 ;
 ;ARGET(RET,ARIEN1,MAXREC,SDBEG,SDEND,DFN,LASTSUB)  external parameter tag in SDEC
 ;INPUT:
 ;  ARIEN1   - (optional) SDEC APPT REQUEST ID pointer to ^SDEC(409.85
 ;  MAXREC   - (optional) Max records returned
 ;  SDBEG    - (optional) Begin date in external format - defaults to jan 1,1800
 ;  SDEND    - (optional) End date in external format - defaults to 90 before TODAY
 ;  DFN      - (optional) patient ID pointer to PATIENT file 2
 ;  LASTSUB  - (optional) only used if DFN=""
 ;            last subscripts from previous call
 ;             <origination date/time> | <wait list ID>
 ;  SDTOP    - (optional) runs through the xrefs in reverse using -1 in $O  0=forward; 1=reverse
 ;
 ;RETURN:  Return Appointment Request data in a Dataset format with these columns:
 ;   DFN [1] ^ PATIENT NAME [2] ^ <not used> [3] ^ DOB [4] ^ SSN [5] ^ GENDER [6] ^ APPT REQUEST IEN [7]
 ; ^ ORIGINATING DATE [8] ^ INSTITUTION IEN [9] ^ INSTITUTION NAME [10] ^ APP TYPE [11]
 ; ^ SPECIFIC CLINIC IEN [12] ^ SPECIFIC CLINIC NAME [13] ^ ORIGINATING USER IEN [14] ^ ORIGINATING USER NAME [15}
 ; ^ PRIORITY [16] ^ REQUEST BY [17] ^ PROVIDER IEN [18] ^ PROVIDER NAME [19] ^ DESIRED DATE OF APPOINTMENT [20]
 ; ^ COMMENTS [21] ^ ENROLLMENT PRIORITY [22]  ^ MULTIPLE APPOINTMENT RTC 0=NO; 1=YES [23]
 ; ^ MULT APPT RTC INTERVAL-Integer between 1-365 [24] ^ MULT APPT NUMBER-Integer between 1-100 [25]
 ; ^ PRIGRP [26] ^ ELIGIEN [27] ELIGNAME [28] ^ SVCCONN [29] ^ SVCCONNP[30] ^ TYPEIEN [31] ^ TYPENAME [32]
 ; ^ PCONTACT [33] ^ ARDISPD [34] ^ ARDISPU [35] ^ ARDISPUN [36] ^ ARSVCCON [37] ^ PADDRES1 [38] ^ PADDRES2 [39]
 ; ^ PADDRES3 [40] ^ PCITY [41] ^ PSTATE [42] ^ PCOUNTRY [43] ^ PZIP4 [44] ^ GAF [45] ^ DATE/TIME ENTERED [46]
 ; ^ MTRCDATES [47] ^ SENSITIVE [48] ^^^^^^^ LASTSUB [56] ^ STOPIEN [57] ^ STOPNAME [58] ^ APPT_SCHED_DATE [59]
 ; ^ MRTCCOUNT [60] ^ PTPHONE [61] ^ APPTYPE [62] ^ EESTAT [63] ^ PRHBLOC [64] ^ APPTPTRS [65]
 ;
 ;--[64] Boolean indicating if location is a Prohibit Access clinic
 ;--[65] ptrs to SDEC APPOINTMENT file by pipe | (from #409.85 PARENT REQUEST:MULT APPTS MADE)
 ;
 ;--[48] SENSITIVE - Sensitive Record Access data separated by pipe |:
 ;        ;   1. return code:
 ;               -1-RPC/API failed
 ;                  Required variable not defined
 ;                0-No display/action required
 ;                  Not accessing own, employee, or sensitive record
 ;                1-Display warning message
 ;                  Sensitive and DG SENSITIVITY key holder
 ;                  or Employee and DG SECURITY OFFICER key holder
 ;                2-Display warning message/require OK to continue
 ;                  Sensitive and not a DG SENSITIVITY key holder
 ;                  Employee and not a DG SECURITY OFFICER key holder
 ;                3-Access to record denied
 ;                  Accessing own record
 ;                4-Access to Patient (#2) file records denied
 ;                  SSN not defined
 ;   2. display text/message
 ;   3. display text/message
 ;   4. display text/message
 ;
 ;--[47] MTRCDATES separated by pipe |, no time
 ;
 ;--[45] GAF - <text> | <GAF score> | <GAF date> | <diagnosis by IEN> | <diagnosis by name>
 ;
 ;--[33] PCONTACT   Patient Contact
 ;  PATIENT CONTACT pieced by :: where each :: piece contains the following ~~ pieces:
 ;         1. DATE ENTERED                external date/time
 ;         2. PC ENTERED BY USER IEN      Pointer to NEW PERSON file
 ;         3. PC ENTERED BY USER NAME     NAME from NEW PERSION file
 ;         4. ACTION                      C=Called; M=Message Left; L=LETTER
 ;         5. PATIENT PHONE               Free-Text 4-20 characters
 ;
 ;--[59] APPT_SCHED_DATE
 ;       APPT DATA separated by "~~"
 ;         1. SCHEDULED DATE OF APPOINTMENT
 ;        12. APPT CLERK ien
 ;        13. APPT CLERK name
 ;        17. DATE APPT. MADE
 ;
 ;     ^  |  ;;  ::  ~~  {{
 ;
 ;VARIABLES:  these numbers are wrong
 ; DFN       DFN [1]
 ; NAME      PATIENT NAME [2]
 ; HRN       PATIENT HRN [3]
 ; DOB       DOB [4]
 ; SSN       LAST4SSN [5]
 ; GENDER    GENDER [6]
 ; ARIEN     RECORD# [7]
 ; ARORIGDT  ORIGINATING DATE [8]
 ; INSTIEN    INSTITUTION [9]
 ; INSTNAME  INSTITUTION NAME [10]
 ; ARTYPE    APPOINTMENT TYPE [11]
 ; ARCLIN    SPECIFIC CLINIC [13]
 ; ARUSER    ORIGINATING USER [14]
 ; ARPRIO    PRIORITY [15]
 ; ARREQBY   REQUEST BY [16]
 ; ARPROV    PROVIDER [17]
 ; ARDAPTDT  DESIRED DATE OF APPOINTMENT [18]
 ; ARCOMM    COMMENTS [19]
 ; PTPHONE   PATIENT TELEPHONE [20]
 ; ARENPRI   ENROLLMENT PRIORITY [21]
 N CLOSED,FNUM,NAME,DOB,SSN4,GENDER,ARORIGDT,ARINST,ARINSTNM,ARTYPE,ARTEAM,ARPOS
 N ELIGIEN,ELIGNAME,FRULES,GLOREF,HRN,INSTIEN,INSTNAME,PRIGRP,SVCCONN,SVCCONNP,TYPEIEN,TYPENAME
 N PCOUNTRY,SDSUB,SDTMP,SSN,ARSSIEN,ARSSNAME,ARCLIEN,ARCLNAME
 N ARUSER,ARPRIO,ARREQBY,ARPROV,ARPROVNM,ARDAPTDT,ARCOMM,AREESTAT,ARUSRNM
 N ARCLIENL,AREDT,ARIEN,PTINFOLSTA,ARDISPD,ARDISPU,ARDISPUN,ARSVCCON
 N ARMAI,ARMAN,ARMAR,ARSTAT,ARSTOP,ARSTOPN,COUNT,STR
 N PCITY,GAF,PSTATE,PZIP4,PADDRES1,PADDRES2,PADDRES3,PPC,PTPHONE,ARENPRI,ARASD,ARPC,ARDATA
 N SDCL,SDI,SDJ,SDMTRC,SDPARENT,SDPS,SDSENS,SDDEMO,X,Y,%DT,APPTPTRS
 S RET="^TMP(""SDEC"","_$J_")"
 K @RET
 S FNUM=$$FNUM^SDECAR,COUNT=0
 S MAXREC=+$G(MAXREC,50)
 D HDR
 S GLOREF=$NA(^SDEC(409.85,"C",DUZ(2)))
 S FRULES=1
 S ARIEN=0
 ;F  S WLIEN=$O(@GLOREF@(WLIEN)) Q:'WLIEN  D ONEPAT I MAXREC,COUNT'<MAXREC Q
 S SDBEG=$G(SDBEG)
 I SDBEG'="" S %DT="" S X=$P(SDBEG,"@",1) D ^%DT S SDBEG=Y I Y=-1 S SDBEG=3100101
 I SDBEG="" S SDBEG=3100101
 S SDEND=$G(SDEND)
 I SDEND'="" S %DT="" S X=$P(SDEND,"@",1) D ^%DT S SDEND=Y I Y=-1 S SDEND=$$FMADD^XLFDT($E($$NOW^XLFDT,1,12),-90)
 I SDEND="" S SDEND=$$FMADD^XLFDT($E($$NOW^XLFDT,1,12),-90)
 S DFN=$G(DFN)
 I DFN'="",'$D(^DPT(DFN,0)) S DFN=""
 S LASTSUB=$S(DFN="":$G(LASTSUB),1:"")
 S SDTOP=+$G(SDTOP)
 ;single IEN
 S ARIEN1=$G(ARIEN1)
 I +ARIEN1 I '$D(^SDEC(409.85,+ARIEN1,0))  S ARIEN1=""
 I +ARIEN1 D
 .S ARIEN=+ARIEN1
 .S FRULES=0  ;no rules - just return the single record
 .D ONEPAT
 I +ARIEN1 S @RET@(COUNT)=@RET@(COUNT)_$C(31) Q
 ;by patient
 I +DFN D
 .I 'SDTOP S ARIEN=0 F  S ARIEN=$O(^SDEC(409.85,"B",+DFN,ARIEN)) Q:ARIEN'>0  D ONEPAT  ;I MAXREC,COUNT'<MAXREC Q
 .I +SDTOP S ARIEN=999999999 F  S ARIEN=$O(^SDEC(409.85,"B",+DFN,ARIEN),-1) Q:ARIEN'>0  D ONEPAT
 ;all by date range
 I 'DFN D
 .I 'SDTOP D
 ..S SDJ=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1)-1,1:SDBEG-1)
 ..F  S SDJ=$O(^SDEC(409.85,"E","O",SDJ)) Q:SDJ'>0  Q:SDJ>SDEND  D  I MAXREC,COUNT'<MAXREC Q
 ...S ARIEN=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2),1:0)
 ...F  S ARIEN=$O(^SDEC(409.85,"E","O",SDJ,ARIEN)) Q:ARIEN'>0  D  I MAXREC,COUNT'<MAXREC S SDSUB=SDJ_"|"_ARIEN Q
 ....S SDSUB=""
 ....D ONEPAT
 .I +SDTOP D
 ..S SDJ=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1)+1,1:SDEND+1)
 ..F  S SDJ=$O(^SDEC(409.85,"E","O",SDJ),-1) Q:SDJ'>0  Q:SDJ<SDBEG  D  I MAXREC,COUNT'<MAXREC Q
 ...S ARIEN=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2),1:999999999)
 ...F  S ARIEN=$O(^SDEC(409.85,"E","O",SDJ,ARIEN),-1) Q:ARIEN'>0  D  I MAXREC,COUNT'<MAXREC S SDSUB=SDJ_"|"_ARIEN Q
 ....S SDSUB=""
 ....D ONEPAT
 S SDTMP=@RET@(COUNT) S SDTMP=$P(SDTMP,$C(30),1)
 S:$G(SDSUB)'="" $P(SDTMP,U,56)=SDSUB
 S @RET@(COUNT)=SDTMP_$C(30,31)
 Q
HDR ;Send back the header
 ;                     1         2
 S @RET@(COUNT)="T00030DFN^T00030NAME"
 ;                                   3         4         5         6            7         8
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030HRN^T00030DOB^T00030SSN^T00030GENDER^I00010IEN^D00030ORIGDT"
 ;                                   9             10             11          12            13
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030INSTIEN^T00030INSTNAME^T00030TYPE^T00030CLINIEN^T00030CLINNAME"
 ;                                   14            15             16         17          18            19
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030USERIEN^T00030USERNAME^T00030PRIO^T00030REQBY^T00030PROVIEN^T00030PROVNAME"
 ;                                   20           21         22
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030DAPTDT^T00250COMM^T00030ENROLLMENT_PRIORITY"
 ;                                   23                             24                           25
 S @RET@(COUNT)=@RET@(COUNT)_"^T00010MULTIPLE APPOINTMENT RTC^T00010MULT APPT RTC INTERVAL^T00010MULT APPT NUMBER"
 ;                                   26           27            28             29            30
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030PRIGRP^T00030ELIGIEN^T00030ELIGNAME^T00030SVCCONN^T00030SVCCONNP"
 ;                                   31            32             33             34            35            36
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030TYPEIEN^T00030TYPENAME^T00100PCONTACT^T00030ARDISPD^T00030ARDISPU^T00030ARDISPUN"
 ;                                   37             38             39             40             41
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030WLSVCCON^T00030PADDRES1^T00030PADDRES2^T00030PADDRES3^T00030PCITY"
 ;                                   42           43             44          45        46         47
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030PSTATE^T00030PCOUNTRY^T00030PZIP4^T00050GAF^T00030DATE^T00030MTRCDATES"
 ;                                   48              49         50         51         52         53
 S @RET@(COUNT)=@RET@(COUNT)_"^T00100SENSITIVE^T00030NU49^T00030NU50^T00030NU51^T00030NU52^T00030NU53"
 ;                                   54         55         56            57            58             59
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030NU54^T00030NU55^T00030LASTSUB^T00030STOPIEN^T00030STOPNAME^T00250APPT_SCHED_DATE"
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030MRTCCOUNT^T00030PTPHONE^T00030APPTYPE^T00030EESTAT^T00030PRHBLOC^T00030APPTPTRS"
 S @RET@(COUNT)=@RET@(COUNT)_"^T00250CHILDREN^T00030SDPARENT"_$C(30)
 Q
 ;
ONEPAT ; Process one patient
 N APPTYPE,ARMRTC,CHILDREN,PRHBLOC
 K ARASD,ARDATA,ARSDOA,ARDAM,ARCLERK,ARCLERKN
 S FRULES=$G(FRULES)
 D GETS^DIQ(FNUM,ARIEN,"**","IE","ARDATA","ARMSG")
 Q:'$D(ARDATA)
 S ARSTAT=ARDATA(FNUM,ARIEN_",",23,"I")
 I FRULES I '+$G(CLOSED) Q:ARSTAT="C"  ; Ignore CLOSED records; CLOSED setup and used from SDEC54 only
 S ARORIGDT=ARDATA(FNUM,ARIEN_",",1,"I")
 I FRULES I ($P(ARORIGDT,".",1)<SDBEG)!($P(ARORIGDT,".",1)>SDEND) Q
 S DFN=ARDATA(FNUM,ARIEN_",",.01,"I")
 Q:DFN=""
 S SDPS=ARDATA(FNUM,ARIEN_",",.02,"E")
 S SDCL=ARDATA(FNUM,ARIEN_",",8,"I")
 Q:(SDCL'="")&($$GET1^DIQ(44,SDCL_",",50.01,"I")=1)  ;check OOS? in file 44
 S PRHBLOC=$S($$GET1^DIQ(44,SDCL_",",2500,"I")="Y":1,1:0)
 ;collect demographics
 D PDEMO^SDECU2(.SDDEMO,DFN)
 S NAME=SDDEMO("NAME")
 S DOB=SDDEMO("DOB")
 S GENDER=SDDEMO("GENDER")
 S HRN=SDDEMO("HRN")
 S SSN=SDDEMO("SSN")
 S INSTIEN=SDDEMO("INSTIEN")
 S INSTNAME=SDDEMO("INSTNAME")
 S PRIGRP=SDDEMO("PRIGRP")
 S ELIGIEN=SDDEMO("ELIGIEN")
 S ELIGNAME=SDDEMO("ELIGNAME")
 S SVCCONN=SDDEMO("SVCCONN")
 S SVCCONNP=SDDEMO("SVCCONNP")
 S TYPEIEN=SDDEMO("TYPEIEN")
 S TYPENAME=SDDEMO("TYPENAME")
 S PADDRES1=SDDEMO("PADDRES1")
 S PADDRES2=SDDEMO("PADDRES2")
 S PADDRES3=SDDEMO("PADDRES3")
 S PCITY=SDDEMO("PCITY")
 S PSTATE=SDDEMO("PSTATE")
 S PCOUNTRY=SDDEMO("PCOUNTRY")
 S PZIP4=SDDEMO("PZIP+4")
 ;
 S GAF=$$GAF^SDECU2(DFN)
 ;
 S PTPHONE=SDDEMO("HPHONE")    ;ARDATA(FNUM,ARIEN_",",.05,"I")  ;msc/sat
 S ARINST=ARDATA(FNUM,ARIEN_",",2,"I")
 S ARINSTNM=ARDATA(FNUM,ARIEN_",",2,"E")
 S ARTYPE=ARDATA(FNUM,ARIEN_",",4,"I")
 S ARCLIENL=ARDATA(FNUM,ARIEN_",",8,"I")
 S ARSTOP=ARDATA(FNUM,ARIEN_",",8.5,"I")
 S ARSTOPN=ARDATA(FNUM,ARIEN_",",8.5,"E")
 ;S ARCLIEN=$P($G(^SDWL(409.32,+ARCLIENL,0)),U,1)
 S ARCLIEN=ARCLIENL
 S ARCLNAME=ARDATA(FNUM,ARIEN_",",8,"E")
 S APPTYPE=ARDATA(FNUM,ARIEN_",",8.7,"I")
 S ARUSER=ARDATA(FNUM,ARIEN_",",9,"I")
 S ARUSRNM=ARDATA(FNUM,ARIEN_",",9,"E")
 S AREDT=$G(ARDATA(FNUM,ARIEN_",",9.5,"E"))   ;53
 S ARPRIO=ARDATA(FNUM,ARIEN_",",10,"I")
 S ARENPRI=ARDATA(FNUM,ARIEN_",",10.5,"E")   ;msc/sat
 S ARREQBY=ARDATA(FNUM,ARIEN_",",11,"I")
 S ARPROV=ARDATA(FNUM,ARIEN_",",12,"I")
 S ARPROVNM=ARDATA(FNUM,ARIEN_",",12,"E")
 S ARSDOA=ARDATA(FNUM,ARIEN_",",13,"E")      ;scheduled date of appt
 S ARDAM=ARDATA(FNUM,ARIEN_",",13.1,"E")     ;date appt. made
 S ARCLERK=ARDATA(FNUM,ARIEN_",",13.7,"I")   ;appt clerk ien
 S ARCLERKN=ARDATA(FNUM,ARIEN_",",13.7,"E")   ;appt clerk name
 S ARASD=""
 S:ARSDOA'="" $P(ARASD,"~~",1)=ARSDOA
 S:ARCLERK'="" $P(ARASD,"~~",12)=ARCLERK
 S:ARCLERKN'="" $P(ARASD,"~~",13)=ARCLERKN
 S:ARDAM'="" $P(ARASD,"~~",17)=ARDAM
 S ARSVCCON=ARDATA(FNUM,ARIEN_",",15,"E")
 S ARDAPTDT=ARDATA(FNUM,ARIEN_",",22,"I")
 S ARCOMM=ARDATA(FNUM,ARIEN_",",25,"I")
 ;S AREESTAT=ARDATA(FNUM,ARIEN_",",27,"I")
 S ARMAR=$$GET1^DIQ(409.85,ARIEN_",",41)
 S ARMAI=$$GET1^DIQ(409.85,ARIEN_",",42)
 S ARMAN=$$GET1^DIQ(409.85,ARIEN_",",43)
 S ARPC=$$WLPC(.ARDATA,ARIEN)
 S ARDISPD=ARDATA(FNUM,ARIEN_",",19,"E")
 S ARDISPU=ARDATA(FNUM,ARIEN_",",20,"I")
 S ARDISPUN=ARDATA(FNUM,ARIEN_",",20,"E")
 S APPTPTRS=$$GETAPPTS(ARIEN)
 S CHILDREN=$$CHILDREN(ARIEN)
 S ARMRTC=$$MRTC^SDECAR(ARIEN)
 S SDPARENT=ARDATA(FNUM,ARIEN_",",43.8,"I")
 S SDSENS=$$PTSEC^SDECUTL(DFN)
 S (SDI,SDMTRC)="" F  S SDI=$O(ARDATA(409.857,SDI)) Q:SDI=""  S SDMTRC=$S(SDMTRC'="":SDMTRC_"|",1:"")_ARDATA(409.857,SDI,.01,"E")
 S COUNT=COUNT+1
 ;     1     2      3    4     5     6        7       8          9        10         11
 S STR=DFN_U_NAME_U_""_U_DOB_U_SSN_U_GENDER_U_ARIEN_U_ARORIGDT_U_ARINST_U_ARINSTNM_U_ARTYPE
 ;           12        13         14       15        16       17        18
 S STR=STR_U_ARCLIEN_U_ARCLNAME_U_ARUSER_U_ARUSRNM_U_ARPRIO_U_ARREQBY_U_ARPROV
 ;           19         20         21       22        23      24      25
 S STR=STR_U_ARPROVNM_U_ARDAPTDT_U_ARCOMM_U_ARENPRI_U_ARMAR_U_ARMAI_U_ARMAN
 ;           26       27        28         29        30         31        32         33
 S STR=STR_U_PRIGRP_U_ELIGIEN_U_ELIGNAME_U_SVCCONN_U_SVCCONNP_U_TYPEIEN_U_TYPENAME_U_ARPC
 ;           34        35        36         37         38         39         40         41      42
 S STR=STR_U_ARDISPD_U_ARDISPU_U_ARDISPUN_U_ARSVCCON_U_PADDRES1_U_PADDRES2_U_PADDRES3_U_PCITY_U_PSTATE
 ;           43         44      45    46      47       48                       57   (save 56 for SDSUB)
 S STR=STR_U_PCOUNTRY_U_PZIP4_U_GAF_U_AREDT_U_SDMTRC_U_SDSENS_U_U_U_U_U_U_U_U_U_ARSTOP_U_ARSTOPN_U_ARASD
 S STR=STR_U_ARMRTC_U_PTPHONE_U_APPTYPE_U_SDPS_U_PRHBLOC_U_APPTPTRS_U_CHILDREN_U_SDPARENT
 S @RET@(COUNT)=STR_$C(30)
 Q
 ;
WLPC(ARDATA,ASDIEN) ;
 N PC,PC1,PCIEN
 S PC=""
 S PCIEN="" F  S PCIEN=$O(ARDATA(409.8544,PCIEN)) Q:PCIEN=""  D
 .Q:$P(PCIEN,",",2)'=ASDIEN
 .S PC1=""
 .S $P(PC1,"~~",1)=ARDATA(409.8544,PCIEN,.01,"E")    ;DATE ENTERED
 .S $P(PC1,"~~",2)=ARDATA(409.8544,PCIEN,2,"I")      ;PC ENTERED BY USER IEN
 .S $P(PC1,"~~",3)=ARDATA(409.8544,PCIEN,2,"E")      ;PC ENTERED BY USER NAME
 .S $P(PC1,"~~",4)=ARDATA(409.8544,PCIEN,3,"E")      ;ACTION
 .S $P(PC1,"~~",5)=ARDATA(409.8544,PCIEN,4,"E")      ;PATIENT PHONE
 .S PC=$S(PC'="":PC_"::",1:"")_PC1
 Q PC
 ;Returns multiple ptrs to SDEC APPOINTMENT (#409.84) by '|'
GETAPPTS(ARIEN) ;Get Multiple Appts Made field from SDEC APPT REQUEST file entry ARIEN
 N I,APPTS
 S I=0,APPTS=""
 Q:'$D(^SDEC(409.85,ARIEN,0)) ""
 I $D(^SDEC(409.85,ARIEN,2,0)) D
 .S I=0 F  S I=$O(^SDEC(409.85,ARIEN,2,I)) Q:'I  D
 ..S APPTS=APPTS_$S(APPTS]"":"|",1:"")_$P($G(^SDEC(409.85,ARIEN,2,I,0)),U,2)  ;this is correct
 ..;S APPTS=APPTS_$S(APPTS]"":"|",1:"")_$P($G(^SDEC(409.85,ARIEN,2,I,0)),U,1)   ;this is wrong
 Q APPTS
 ;
CHILDREN(ARIEN) ;Returns children SDEC APPT REQUEST pointers based on MULT APPTS MADE
 N CHILDS,MULT,REQ,SDI
 S CHILDS=""
 S SDI=0 F  S SDI=$O(^SDEC(409.85,+ARIEN,2,SDI)) Q:SDI'>0  D
 .S MULT=$P($G(^SDEC(409.85,+ARIEN,2,SDI,0)),U,1) ;this is correct
 .;S MULT=$P($G(^SDEC(409.85,+ARIEN,2,SDI,0)),U,2)  ;this is wrong
 .S CHILDS=$S(CHILDS'="":CHILDS_"|",1:"")_MULT
 Q CHILDS
