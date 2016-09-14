SDECWL1 ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**627,642**;Aug 13, 1993;Build 23
 ;
 Q
 ;
 ; Get SD WAIT LIST for all entries in the user's Institution
 ; where the Current Status is not C(losed).
WLGET(RET,WLIEN1,MAXREC,SDBEG,SDEND,DFN,LASTSUB,SDTOP) ;Waitlist GET
WLGETA ;
 ;WLGET(RET,WLIEN1,MAXREC,SDBEG,SDEND,DFN,LASTSUB)  external parameter tag in SDEC
 ;INPUT:
 ;  WLIEN1   - (optional) wait list ID pointer to SDWL(409.3
 ;  MAXREC   - (optional) Max records returned
 ;  SDBEG    - (optional) Begin date in external format - defaults to jan 1,1800
 ;  SDEND    - (optional) End date in external format - defaults to 90 days before TODAY
 ;  DFN      - (optional) patient ID pointer to PATIENT file 2
 ;  LASTSUB  - (optional) only used if DFN=""
 ;            last subscripts from previous call
 ;             <origination date/time> | <wait list ID>
 ;  SDTOP    - (optional) runs through the xrefs in reverse using -1 in $O  0=forward; 1=reverse
 ;
 ;RETURN:  Return Wait List data in an OVID Dataset format with these columns:
 ;   DFN [1] ^ PATIENT NAME [2] ^ <not used> [3] ^ DOB [4] ^ SSN [5] ^ GENDER [6] ^ WAIT LIST IEN [7]
 ; ^ ORIGINATING DATE [8] ^ INSTITUTION IEN [9] ^ INSTITUTION NAME [10] ^ WAIT LIST TYPE [11] ^ WL SPECIFIC TEAM [12]
 ; ^ WL SPECIFIC POSITION [13] ^ WL SERVICE/SPECIALTY IEN [14] ^ WL SERVICE/SPECIALTY NAME [15]
 ; ^ WL SPECIFIC CLINIC IEN (file 44) [16] ^ WLSPECIFIC CLINIC NAME [17]
 ; ^ ORIGINATING USER IEN [18] ^ ORIGINATING USER NAME [19} ^ PRIORITY [20] ^ REQUEST BY [21] ^ PROVIDER IEN [22]
 ; ^ PROVIDER NAME [23] ^ DESIRED DATE OF APPOINTMENT [24] ^ COMMENTS [25] ^ EWL ENROLLEE STATUS [26]
 ; ^ NOT USED PTPHONE [27] ^ ENROLLMENT PRIORITY [28] ^ NOT USED [29]
 ; ^ <NOT USED> MULTIPLE APPOINTMENT RTC 0=NO; 1=YES [30] ^ <NOT USED> MULT APPT RTC INTERVAL-Integer between 1-365 [31]
 ; ^ <NOT USED> MULT APPT NUMBER-Integer between 1-100 [32]
 ; ^ PRIGRP [33] ^ ELIGIEN [34] ELIGNAME [35] ^ SVCCONN [36] ^ SVCCONNP[37] ^ TYPEIEN [38] ^ TYPENAME [39]
 ; ^ PCONTACT [40] ^ WLDISPD [41] ^ WLDISPU [42] ^ WLDISPUN [43] ^ WLSVCCON [44] ^ PADDRES1 [45] ^ PADDRES2 [46]
 ; ^ PADDRES3 [47] ^ PCITY [48] ^ PSTATE [49] ^ PCOUNTRY [50] ^ PZIP4 [51] ^ GAF [52] ^ DATE/TIME ENTERED [53]
 ; ^ <NOT USED> [54] ^ SENSITIVE [55] ^ LASTSUB [56] ^ PRACE [57] ^ PRACEN [58] ^ PETH [59] ^ PETHN [60] ^ APPTYPE [61]
 ; ^ PRHBLOC [62]
 ;
 ;--[64] Boolean indicating if location is a Prohibit Access clinic
 ;--[55] SENSITIVE - Sensitive Record Access data separated by pipe |:
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
 ;--[54] <NOT USED> MTRCDATES separated by pipe |, no time
 ;
 ;--[52] GAF - <text> | <GAF score> | <GAF date> | <diagnosis by IEN> | <diagnosis by name>
 ;
 ;--[40] PCONTACT   Patient Contact
 ;  PATIENT CONTACT pieced by :: where each :: piece contains the following ~~ pieces:
 ;         1. DATE ENTERED                external date/time
 ;         2. PC ENTERED BY USER IEN      Pointer to NEW PERSON file
 ;         3. PC ENTERED BY USER NAME     NAME from NEW PERSION file
 ;         4. ACTION                      C=Called; M=Message Left; L=LETTER
 ;         5. PATIENT PHONE               Free-Text 4-20 characters
 ;
 ;     ^  |  ;;  ::  ~~  {{
 ;--[29] APPT_SCHED_DATE
 ;       APPT DATA separated by "~~"
 ;         1. SCHEDULED DATE OF APPOINTMENT
 ;        12. APPT CLERK ien
 ;        13. APPT CLERK name
 ;        17. DATE APPT. MADE
 ;
 N CLOSED,FNUM,NAME,DOB,SSN4,GENDER,WLORIGDT,WLINST,WLINSTNM,WLTYPE,WLTEAM,WLPOS
 N ELIGIEN,ELIGNAME,FRULES,GLOREF,HRN,INSTIEN,INSTNAME,PRIGRP,SVCCONN,SVCCONNP,TYPEIEN,TYPENAME
 N PCOUNTRY,SDSUB,SDTMP,SSN,WLSSIEN,WLSSNAME,WLCLIEN,WLCLNAME
 N WLUSER,WLPRIO,WLREQBY,WLPROV,WLPROVNM,WLDAPTDT,WLCOMM,WLEESTAT,WLUSRNM
 N WLCLIENL,WLEDT,WLIEN,PTINFOLSTA,WLDISPD,WLDISPU,WLDISPUN,WLSVCCON
 N WLSTAT,COUNT,STR
 N PCITY,GAF,PSTATE,PZIP4,PADDRES1,PADDRES2,PADDRES3,PPC,PTPHONE,WLENPRI,WLASD,WLPC,WLDATA
 N SDI,SDJ,SDMTRC,SDSENS,SDDEMO,X,Y,%DT
 S RET="^TMP(""SDEC"","_$J_")"
 K @RET
 S FNUM=$$FNUM^SDECWL,COUNT=0
 S MAXREC=+$G(MAXREC,50)
 D HDR
 S GLOREF=$NA(^SDWL(409.3,"C",DUZ(2)))
 S FRULES=1
 S WLIEN=0
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
 S WLIEN1=$G(WLIEN1)
 I +WLIEN1 I '$D(^SDWL(409.3,+WLIEN1,0))  S COUNT=COUNT+1 S @RET@(COUNT)="-1^Invalid Wait List ID." Q  ;S WLIEN1=""
 I +WLIEN1 D
 .S WLIEN=+WLIEN1
 .S FRULES=0  ;no rules - just return the single record
 .D ONEPAT
 I +WLIEN1 S @RET@(COUNT)=@RET@(COUNT)_$C(31) Q
 ;by patient
 I +DFN D
 .I 'SDTOP S WLIEN=0 F  S WLIEN=$O(^SDWL(409.3,"B",+DFN,WLIEN)) Q:WLIEN'>0  D ONEPAT  ;I MAXREC,COUNT'<MAXREC Q
 .I SDTOP S WLIEN=999999999 F  S WLIEN=$O(^SDWL(409.3,"B",+DFN,WLIEN),-1) Q:WLIEN'>0  D ONEPAT  ;I MAXREC,COUNT'<MAXREC Q
 ;all by date range
 I 'DFN D
 .I 'SDTOP D
 ..S SDJ=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1)-1,1:SDBEG-1)
 ..F  S SDJ=$O(^SDWL(409.3,"E","O",SDJ)) Q:SDJ'>0  Q:SDJ>SDEND  D  I MAXREC,COUNT'<MAXREC Q
 ...S WLIEN=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2),1:0) S LASTSUB=""
 ...F  S WLIEN=$O(^SDWL(409.3,"E","O",SDJ,WLIEN)) Q:WLIEN'>0  D  I MAXREC,COUNT'<MAXREC S SDSUB=SDJ_"|"_WLIEN Q
 ....S SDSUB=""
 ....D ONEPAT
 .I +SDTOP D
 ..S SDJ=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1)+1,1:SDEND+1)
 ..F  S SDJ=$O(^SDWL(409.3,"E","O",SDJ),-1) Q:SDJ'>0  Q:SDJ<SDBEG  D  I MAXREC,COUNT'<MAXREC Q
 ...S WLIEN=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2),1:999999999) S LASTSUB=""
 ...F  S WLIEN=$O(^SDWL(409.3,"E","O",SDJ,WLIEN),-1) Q:WLIEN'>0  D  I MAXREC,COUNT'<MAXREC S SDSUB=SDJ_"|"_WLIEN Q
 ....S SDSUB=""
 ....D ONEPAT
 S SDTMP=@RET@(COUNT) S SDTMP=$P(SDTMP,$C(30),1)
 S:$G(SDSUB)'="" $P(SDTMP,U,56)=SDSUB
 S @RET@(COUNT)=SDTMP_$C(30,31)
 Q
 ;
HDR ;Output header
 ;                     1         2
 S @RET@(COUNT)="T00030DFN^T00030NAME"
 ;                                   3         4         5         6            7         8
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030HRN^T00030DOB^T00030SSN^T00030GENDER^I00010IEN^D00030ORIGDT"
 ;                                   9             10             11         12         13
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030INSTIEN^T00030INSTNAME^T00030TYPE^T00030TEAM^T00030POS"
 ;                                   14             15              16            17
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030SRVSPIEN^T00030SRVSPNAME^T00030CLINIEN^T00030CLINNAME"
 ;                                   18            19             20         21          22            23
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030USERIEN^T00030USERNAME^T00030PRIO^T00030REQBY^T00030PROVIEN^T00030PROVNAME"
 ;                                   24           25         26           27               28
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030DAPTDT^T00250COMM^T00030EESTAT^T00030PTELEPHONE^T00030ENROLLMENT_PRIORITY"
 S @RET@(COUNT)=@RET@(COUNT)_"^T00250APPT_SCHED_DATE^T00010MULTIPLE APPOINTMENT RTC^T00010MULT APPT RTC INTERVAL"
 S @RET@(COUNT)=@RET@(COUNT)_"^T00010MULT APPT NUMBER"
 ;                                                                             36
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030PRIGRP^T00030ELIGIEN^T00030ELIGNAME^T00030SVCCONN^T00030SVCCONNP"
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030TYPEIEN^T00030TYPENAME^T00100PCONTACT^T00030WLDISPD^T00030WLDISPU^T00030WLDISPUN"
 ;                                   44             45             46           47               48
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030WLSVCCON^T00030PADDRES1^T00030PADDRES2^T00030PADDRES3^T00030PCITY"
 ;                                   49           50             51          52        53         54
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030PSTATE^T00030PCOUNTRY^T00030PZIP4^T00050GAF^T00030DATE^T00030MTRCDATES"
 S @RET@(COUNT)=@RET@(COUNT)_"^T00100SENSITIVE^T00030LASTSUB^T00030PRACE^T00030PRACEN^T00030PETH^T00030PETHN"
 S @RET@(COUNT)=@RET@(COUNT)_"^T00030APPTYPE^T00030PRHBLOC"_$C(30)
 Q
ONEPAT ; Process one patient
 ;D GETS^DIQ(FNUM,WLIEN,"23;.01;.05;1;2;4;5;6;7;8;8.5;9;10,10.5;11;12;12.5;22;25;27","IE","WLDATA","WLMSG")
 N SDCL,WLSDOA,WLDAM,WLCLERK,WLCLERKN
 N APPTYPE,PRACE,PRACEN,PETH,PETHN,PRHBLOC
 K WLDATA
 S FRULES=$G(FRULES)
 D GETS^DIQ(FNUM,WLIEN,"**","IE","WLDATA","WLMSG")
 S WLSTAT=WLDATA(FNUM,WLIEN_",",23,"I")
 I FRULES I '+$G(CLOSED) Q:WLSTAT="C"  ; Ignore CLOSED records; CLOSED setup and used from SDEC54 only
 S WLORIGDT=WLDATA(FNUM,WLIEN_",",1,"I")
 I FRULES I ($P(WLORIGDT,".",1)<SDBEG)!($P(WLORIGDT,".",1)>SDEND) Q
 S DFN=WLDATA(FNUM,WLIEN_",",.01,"I")
 Q:DFN=""
 S WLCLIENL=WLDATA(FNUM,WLIEN_",",8,"I")
 S SDCL=WLDATA(FNUM,WLIEN_",",8.5,"I")
 I SDCL="" S SDCL=$$GET1^DIQ(409.32,WLCLIENL_",",.01,"I")
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
 S PRIGRP=SDDEMO("PRIGRP")       ;33
 S ELIGIEN=SDDEMO("ELIGIEN")     ;34
 S ELIGNAME=SDDEMO("ELIGNAME")   ;35
 S SVCCONN=SDDEMO("SVCCONN")     ;36
 S SVCCONNP=SDDEMO("SVCCONNP")   ;37
 S TYPEIEN=SDDEMO("TYPEIEN")     ;38
 S TYPENAME=SDDEMO("TYPENAME")   ;39
 S PADDRES1=SDDEMO("PADDRES1")   ;45
 S PADDRES2=SDDEMO("PADDRES2")   ;46
 S PADDRES3=SDDEMO("PADDRES3")   ;47
 S PCITY=SDDEMO("PCITY")         ;48
 S PSTATE=SDDEMO("PSTATE")       ;49
 S PCOUNTRY=SDDEMO("PCOUNTRY")   ;50
 S PZIP4=SDDEMO("PZIP+4")        ;51
 ;
 S GAF=$$GAF^SDECU2(DFN)
 ;
 S PTPHONE=SDDEMO("HPHONE")    ;WLDATA(FNUM,WLIEN_",",.05,"I")  ;msc/sat
 D RACELST^SDECU2(DFN,.PRACE,.PRACEN)
 D ETH^SDECU2(DFN,.PETH,.PETHN)   ;get ethnicity
 S WLINST=WLDATA(FNUM,WLIEN_",",2,"I")
 S WLINSTNM=WLDATA(FNUM,WLIEN_",",2,"E")
 S WLTYPE=WLDATA(FNUM,WLIEN_",",4,"I")
 Q:"34"'[WLTYPE   ;only look for SERVICE/SPECIALITY or SPECIFIC CLINIC ;todo-need xref
 S WLTEAM=WLDATA(FNUM,WLIEN_",",5,"I")
 S WLPOS=WLDATA(FNUM,WLIEN_",",6,"I")
 S WLSSIEN=WLDATA(FNUM,WLIEN_",",7,"I")
 S WLSSNAME=WLDATA(FNUM,WLIEN_",",7,"E")
 S WLCLIEN=$P($G(^SDWL(409.32,+WLCLIENL,0)),U,1)
 S WLCLNAME=WLDATA(FNUM,WLIEN_",",8,"E")
 S APPTYPE=WLDATA(FNUM,WLIEN_",",8.7,"I")
 S WLUSER=WLDATA(FNUM,WLIEN_",",9,"I")
 S WLUSRNM=WLDATA(FNUM,WLIEN_",",9,"E")
 S WLEDT=$G(WLDATA(FNUM,WLIEN_",",9.5,"E"))   ;53
 S WLPRIO=WLDATA(FNUM,WLIEN_",",10,"I")
 S WLENPRI=WLDATA(FNUM,WLIEN_",",10.5,"E")   ;msc/sat
 S WLREQBY=WLDATA(FNUM,WLIEN_",",11,"I")
 S WLPROV=WLDATA(FNUM,WLIEN_",",12,"I")
 S WLPROVNM=WLDATA(FNUM,WLIEN_",",12,"E")
 S WLSDOA=WLDATA(FNUM,WLIEN_",",13,"E")    ;scheduled date of appt
 S WLDAM=WLDATA(FNUM,WLIEN_",",13.1,"E")   ;date appt. made
 S WLCLERK=WLDATA(FNUM,WLIEN_",",13.7,"I") ;appt clerk
 S WLCLERKN=WLDATA(FNUM,WLIEN_",",13.7,"E") ;appt clerk name
 S WLSVCCON=WLDATA(FNUM,WLIEN_",",15,"E")
 S WLDAPTDT=WLDATA(FNUM,WLIEN_",",22,"I")
 S WLCOMM=WLDATA(FNUM,WLIEN_",",25,"I")
 S WLEESTAT=WLDATA(FNUM,WLIEN_",",27,"I")
 S WLASD=""
 S:WLSDOA'="" $P(WLASD,"~~",1)=WLSDOA
 S:WLCLERK'="" $P(WLASD,"~~",12)=WLCLERK
 S:WLCLERKN'="" $P(WLASD,"~~",13)=WLCLERKN
 S:WLDAM'="" $P(WLASD,"~~",17)=WLDAM
 S WLPC=$$WLPC(.WLDATA,WLIEN)
 S WLDISPD=WLDATA(FNUM,WLIEN_",",19,"E")
 S WLDISPU=WLDATA(FNUM,WLIEN_",",20,"I")
 S WLDISPUN=WLDATA(FNUM,WLIEN_",",20,"E")
 S SDSENS=$$PTSEC^SDECUTL(DFN)
 S SDMTRC=""  ;S (SDI,SDMTRC)="" F  S SDI=$O(WLDATA(409.37,SDI)) Q:SDI=""  S SDMTRC=$S(SDMTRC'="":SDMTRC_"|",1:"")_WLDATA(409.37,SDI,.01,"E")
 S COUNT=COUNT+1
 ;     1     2      3    4     5     6        7       8          9        10         11       12       13
 S STR=DFN_U_NAME_U_""_U_DOB_U_SSN_U_GENDER_U_WLIEN_U_WLORIGDT_U_WLINST_U_WLINSTNM_U_WLTYPE_U_WLTEAM_U_WLPOS   ;13
 ;           14        15         16        17         18       19        20       21        22
 S STR=STR_U_WLSSIEN_U_WLSSNAME_U_WLCLIEN_U_WLCLNAME_U_WLUSER_U_WLUSRNM_U_WLPRIO_U_WLREQBY_U_WLPROV            ;22
 S STR=STR_U_WLPROVNM_U_WLDAPTDT_U_WLCOMM_U_WLEESTAT_U_PTPHONE_U_WLENPRI_U_WLASD_U_""_U_""_U_""                ;32
 S STR=STR_U_PRIGRP_U_ELIGIEN_U_ELIGNAME_U_SVCCONN_U_SVCCONNP_U_TYPEIEN_U_TYPENAME_U_WLPC                      ;40
 S STR=STR_U_WLDISPD_U_WLDISPU_U_WLDISPUN_U_WLSVCCON_U_PADDRES1_U_PADDRES2_U_PADDRES3_U_PCITY_U_PSTATE         ;49
 ;           50         51      52    53      54   55       56   57      58       59     60
 S STR=STR_U_PCOUNTRY_U_PZIP4_U_GAF_U_WLEDT_U_""_U_SDSENS_U_""_U_PRACE_U_PRACEN_U_PETH_U_PETHN_U_APPTYPE       ;62
 S STR=STR_U_PRHBLOC
 S @RET@(COUNT)=STR_$C(30)
 Q
 ;
WLPC(WLDATA,ASDIEN) ;
 N PC,PC1,PCIEN
 S PC=""
 S PCIEN="" F  S PCIEN=$O(WLDATA(409.344,PCIEN)) Q:PCIEN=""  D
 .Q:$P(PCIEN,",",2)'=ASDIEN
 .S PC1=""
 .S $P(PC1,"~~",1)=WLDATA(409.344,PCIEN,.01,"E")    ;DATE ENTERED
 .S $P(PC1,"~~",2)=WLDATA(409.344,PCIEN,2,"I")      ;PC ENTERED BY USER IEN
 .S $P(PC1,"~~",3)=WLDATA(409.344,PCIEN,2,"E")      ;PC ENTERED BY USER NAME
 .S $P(PC1,"~~",4)=WLDATA(409.344,PCIEN,3,"E")      ;ACTION
 .S $P(PC1,"~~",5)=WLDATA(409.344,PCIEN,4,"E")      ;PATIENT PHONE
 .S PC=$S(PC'="":PC_"::",1:"")_PC1
 Q PC
