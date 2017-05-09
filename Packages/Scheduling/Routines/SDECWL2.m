SDECWL2 ;ALB/SAT - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**627,642,658**;Aug 13, 1993;Build 23
 ;
 Q
 ;
WLSET(RET,INP) ;Waitlist Set
 ;WLSET(RET,INP...)  external parameter tag in SDEC
 ;  INP(1)  = (integer)  Wait List IEN point to
 ;                       SD WAIT LIST file 409.3.
 ;                       If null, a new entry will be added
 ;  INP(2)  = (text)     DFN Pointer to the PATIENT file 2
 ;  INP(3)  = (date)     Originating Date/time in external date form
 ;  INP(4)  = (text)     Institution name NAME field from the INSTITUTION file
 ;  INP(5)  = (text)     Wait List Type
 ;                        PCMM TEAM ASSIGNMENT
 ;                        PCMM POSITION ASSIGNMENT
 ;                        SERVICE/SPECIALITY
 ;                        SPECIFIC CLINIC
 ;  INP(6)  = (text)     WL Specific Team name - NAME field in the TEAM file 404.51
 ;  INP(7)  = (text)     WL Specific Position name - NAME field in the
 ;                       TEAM POSITION file 404.57.
 ;  INP(8)  = (text)     WL Service/Specialty name - NAME field in
 ;                       SD WL SERVICE/SPECIALTY file 409.31 OR ien from 409.31
 ;  INP(9)  = (text)     WL Specific Clinic name - NAME field in
 ;                       SD WL CLINIC LOCATION file 409.32.
 ;  INP(10) = (text)     Originating User name  - NAME field in NEW PERSON file 200
 ;  INP(11) = (text)     Priority - 'ASAP' or 'FUTURE'
 ;  INP(12) = (text)     Request By - 'PROVIDER' or 'PATIENT'
 ;  INP(13) = (text)     Provider name  - NAME field in NEW PERSON file 200
 ;  INP(14) = (date)     Desired Date of appointment in external format.
 ;  INP(15) = (text)     comment must be 1-60 characters
 ;  INP(16) = (text)     EWL Enrollee Status
 ;                        NEW
 ;                        ESTABLISHED
 ;                        PRIOR
 ;                        UNDETERMINED
 ;  INP(17) = (text)     NOT USED - PATIENT TELEPHONE  4-20 characters
 ;  INP(18) = (text)     ENROLLMENT PRIORITY - Valid Values are:
 ;                                             GROUP 1
 ;                                             GROUP 2
 ;                                             GROUP 3
 ;                                             GROUP 4
 ;                                             GROUP 5
 ;                                             GROUP 6
 ;                                             GROUP 7
 ;                                             GROUP 8
 ;  INP(19) = (text)    NOT USED - APPT SCHEDULED DATE
 ;  INP(20) = (text)     <NOT USED>  MULTIPLE APPOINTMENT RTC      NO; YES
 ;  INP(21) = (integer)  <NOT USED>  MULT APPT RTC INTERVAL integer between 1-365
 ;  INP(22) = (integer)  <NOT USED>  MULT APPT NUMBER integer between 1-100
 ;  INP(23) = Patient Contacts separated by ::
 ;            Each :: piece has the following ~~ pieces:
 ;            1) = (date)    DATE ENTERED external date/time
 ;            2) = (text)    PC ENTERED BY USER ID or NAME - Pointer to NEW PERSON file or NAME
 ;            4) = (text)    ACTION - 'CALLED', 'MESSAGE LEFT', or 'LETTER'
 ;            5) = (optional) PATIENT PHONE Free-Text 4-20 characters
 ;            6) = NOT USED (optional) Comment 1-160 characters
 ;  INP(24) = (optional) SERVICE CONNECTED PRIORITY valid values are NO  YES
 ;  INP(25) = (optional) SERVICE CONNECTED PERCENTAGE = numeric 0-100
 ;  INP(27) = (optional) Appointment Type ID pointer to APPOINTMENT TYPE file 409.1
 ;
 N X,Y,%DT
 N DFN,MI,WLIEN,WLORIGDT,WLINST,WLINSTI,WLTYPE,WLTEAM,WLPOS,WLSRVSP,WLCLIN
 N WLUSER,WLPRIO,WLREQBY,WLPROV,WLDAPTDT,WLCOMM,WLEESTAT,WLEDT,WLQUIT
 N AUDF,FNUM,FDA,WLNEW,WLRET,WLMSG,WLDATA,WLERR,WLHOS
 N WLAPTYP,WLPATTEL,WLENPRI,WLSVCCON,WLSVCCOP
 S (AUDF,WLQUIT)=0
 S FNUM=$$FNUM^SDECWL
 S RET="I00020ERRORID^T00030ERRORTEXT"_$C(30)
 ; Use MERGE instead of SET so we can know if values were actually specified or not.
 ; This way, if a value is null, we will delete any previous value,
 ; but if it is missing, then we will just ignore it.
 M WLIEN=INP(1)
 S WLHOS=""
 S DFN=$G(INP(2))
 I '+DFN S RET=RET_"-1^Invalid Patient ID."_$C(30,31) Q
 I '$D(^DPT(DFN,0)) S RET=RET_"-1^Invalid Patient ID"_$C(30,31) Q
 S WLEDT=$P($G(INP(3)),":",1,2)
 S %DT="TX" S X=WLEDT D ^%DT S WLEDT=Y
 I Y=-1 S RET=RET_"-1^Invalid Origination date."_$C(30,31) Q
 S WLORIGDT=$P(WLEDT,".",1)
 S WLINST=$G(INP(4)) I WLINST'="" D
 .I '+WLINST S WLINST=$O(^DIC(4,"B",WLINST,0))
 S WLTYPE=$G(INP(5)) I WLTYPE'="" S WLTYPE=$S(WLTYPE="PCMM TEAM ASSIGNMENT":1,WLTYPE="PCMM POSSITION ASSIGNMENT":2,WLTYPE="SERVICE/SPECIALITY":3,WLTYPE="SPECIFIC CLINIC":4,+WLTYPE:+WLTYPE,1:"")
 I WLTYPE="" S RET=RET_"-1^Invalid Wait List Type."_$c(30,31) Q
 S WLTEAM=$G(INP(6)) I WLTEAM'="" D
 .I '+WLTEAM S WLTEAM=$O(^SCTM(404.51,"B",WLTEAM,0))
 .I +WLTEAM I '$D(^SCTM(404.51,+WLTEAM,0)) S WLTEAM=""
 S WLPOS=$G(INP(7)) I WLPOS'="" D
 .I '+WLPOS S WLPOS=$O(^DIC(404.57,"B",WLPOS,0))
 .I +WLPOS I '$D(^SCTM(404.57,WLPOS,0)) S WLPOS=""
 S WLCLIN=$G(INP(9))
 I WLCLIN'="" D   ;WLCLIN pointer to SD WL CLINIC LOCATION; WLHOS pointer to HOSPITAL LOCATION
 .I +WLCLIN D
 ..I '$D(^SDWL(409.32,+WLCLIN,0)) S RET=RET_"-1^"_WLCLIN_" is an invalid WL Waitlist Specific Clinic ID."_$C(30,31) S WLQUIT=1 Q
 ..S WLHOS=+$P($G(^SDWL(409.32,+WLCLIN,0)),U,1)
 .I '+WLCLIN D
 ..S WLHOS=$O(^SC("B",WLCLIN,0))  ;$S(+WLCLIN:$P($G(^SC($P($G(^SDWL(409.32,WLCLIN,0)),U,1),0)),U,1),1:WLCLIN)
 ..S WLCLIN=$O(^SDWL(409.32,"B",+WLHOS,0)) I 'WLCLIN S RET=RET_"-1^"_WLCLIN_" is an invalid WL Waitlist Specific Clinic Name."_$C(30,31) S WLQUIT=1 Q
 S INP(8)=$G(INP(8))
 I INP(8)'="",WLCLIN'="" S RET=RET_"-1^Cannot include both Clinic and Service."_$C(30,31) Q   ;alb/sat 642
 I +INP(8),'$D(^SDWL(409.31,+INP(8),0)) S RET=RET_"-1^Invalid service/specialty "_+INP(8)_"."_$C(30,31) Q   ;alb/sat 642
 S WLUSER=$G(INP(10))
 I WLUSER'="" I '+WLUSER S WLUSER=$O(^VA(200,"B",WLUSER,0))
 I WLUSER="" S WLUSER=DUZ
 S WLREQBY=$G(INP(12)) I WLREQBY'="" S WLREQBY=$S(WLREQBY="PATIENT":2,WLREQBY="PROVIDER":1,1:"")
 S WLPROV=$G(INP(13)) I WLPROV'="" I '+WLPROV S WLPROV=$O(^VA(200,"B",WLPROV,0))
 S WLDAPTDT=$G(INP(14))
 S %DT="" S X=$P($G(WLDAPTDT),"@",1) D ^%DT S WLPRIO=$S(Y=$P($$NOW^XLFDT,".",1):"A",1:"F")
 S WLDAPTDT=Y
 I Y=-1 S WLDAPTDT=""   ;S RET=RET_"-1^Invalid Desired Date."_$C(30,31) Q
 S (INP(15),WLCOMM)=$TR($G(INP(15)),"^"," ")  ;alb/sat 658
 S WLEESTAT=$G(INP(16)) I WLEESTAT'="" S WLEESTAT=$S(WLEESTAT="NEW":"N",WLEESTAT="ESTABLISHED":"E",WLEESTAT="PRIOR":"P",WLEESTAT="UNDETERMINED":"U",1:WLEESTAT)
 M WLPATTEL=INP(17)
 S WLENPRI=$G(INP(18)) D
 .S:WLENPRI'="" WLENPRI=$S(WLENPRI="GROUP 1":1,WLENPRI="GROUP 2":2,WLENPRI="GROUP 3":3,WLENPRI="GROUP 4":4,WLENPRI="GROUP 5":5,WLENPRI="GROUP 6":6,WLENPRI="GROUP 7":7,WLENPRI="GROUP 8":8,1:WLENPRI)
 S WLSVCCON=$G(INP(24)) S:WLSVCCON'="" WLSVCCON=$S(WLSVCCON="YES":1,1:0)
 S WLSVCCOP=$G(INP(25)) I WLSVCCOP'="" S WLSVCCOP=+$G(WLSVCCOP) S:(+WLSVCCOP<0)!(+WLSVCCOP>100) WLSVCCOP=""
 S WLAPTYP=+$G(INP(27)) I +WLAPTYP,'$D(^SD(409.1,WLAPTYP,0)) S WLAPTYP=""
 S WLIEN=$G(WLIEN)
 S WLNEW=WLIEN=""
 I WLNEW D
 . S FDA=$NA(FDA(FNUM,"+1,"))
 . S @FDA@(.01)=+DFN
 . ;This handles the date/time coming in as "8/27/2014 12:00:00 AM"
 . S:$G(WLORIGDT)'="" @FDA@(1)=WLORIGDT
 . S:$G(WLINST)'="" @FDA@(2)=+WLINST
 . S:$G(WLTYPE)'="" @FDA@(4)=WLTYPE
 . ;S:$G(WLTEAM)'="" @FDA@(5)=+WLTEAM
 . S:$G(WLPOS)'="" @FDA@(6)=+WLPOS
 . ;S:$G(WLSRVSP)'="" @FDA@(7)=$S(+WLSRVSP:$P($G(^SDWL(409.31,WLSRVSP,0)),U),1:WLSRVSP)
 . S:$G(WLCLIN)'="" @FDA@(8)=+WLCLIN
 . S:$G(WLHOS)'="" @FDA@(8.5)=WLHOS
 . S:+WLAPTYP @FDA@(8.7)=+WLAPTYP
 . S:$G(WLUSER)'="" @FDA@(9)=+WLUSER
 . S:$G(WLEDT)'="" @FDA@(9.5)=WLEDT
 . S:$G(WLPRIO)'="" @FDA@(10)=WLPRIO
 . S:$G(WLENPRI)'="" @FDA@(10.5)=WLENPRI
 . S:$G(WLREQBY)'="" @FDA@(11)=WLREQBY
 . S:$G(WLPROV)'="" @FDA@(12)=+WLPROV
 . S:$G(WLSVCCOP)'="" @FDA@(14)=WLSVCCOP
 . S:$G(WLSVCCON)'="" @FDA@(15)=WLSVCCON
 . S:$G(WLDAPTDT)'="" @FDA@(22)=WLDAPTDT
 . S @FDA@(23)="O"
 . S:$G(WLCOMM)'="" @FDA@(25)=WLCOMM
 . S:$G(WLEESTAT)'="" @FDA@(27)=WLEESTAT
 . S:+WLAPTYP @FDA@(8.7)=+WLAPTYP
 E  D
 . S WLIEN=WLIEN_"," ; Append the comma for both
 . K WLDATA,WLERR
 . D GETS^DIQ(FNUM,WLIEN,"*","IE","WLDATA","WLERR")
 . I $D(WLERR) M WLMSG=WLERR K FDA Q
 . S FDA=$NA(FDA(FNUM,WLIEN))
 . I $D(WLORIGDT) D
 . . I WLORIGDT'=WLDATA(FNUM,WLIEN,1,"I") S @FDA@(1)=WLORIGDT
 . I $D(WLINST),WLINST'=WLDATA(FNUM,WLIEN,2,"I") S @FDA@(2)=$S(WLINST="":"@",1:+WLINST)
 . I $D(WLTYPE),WLTYPE'=WLDATA(FNUM,WLIEN,4,"E") S @FDA@(4)=WLTYPE
 . ;I $D(WLTEAM),WLTEAM'=WLDATA(FNUM,WLIEN,5,"I") S @FDA@(5)=$S(WLTEAM="":"@",1:+WLTEAM)
 . I $D(WLPOS),WLPOS'=WLDATA(FNUM,WLIEN,6,"I") S @FDA@(6)=$S(WLPOS="":"@",1:+WLPOS)
 . ;I $D(WLSRVSP),WLSRVSP'=WLDATA(FNUM,WLIEN,7,"I") S @FDA@(7)=$S(WLSRVSP="":"@",+WLSRVSP:$P($G(^DIC(40.7,$P($G(^SDWL(409.31,WLSRVSP,0)),U),0)),U),1:WLSRVSP)
 . I $D(WLCLIN),WLCLIN'=WLDATA(FNUM,WLIEN,8,"I") S @FDA@(8)=$S(WLCLIN="":"@",1:+WLCLIN),AUDF=1 S:WLDATA(FNUM,WLIEN,7,"I")'="" @FDA@(7)="@"
 . I $D(WLHOS),WLHOS'=WLDATA(FNUM,WLIEN,8.5,"I") S @FDA@(8.5)=WLHOS,AUDF=1 S:WLDATA(FNUM,WLIEN,7,"I")'="" @FDA@(7)="@"
 . S:+WLAPTYP @FDA@(8.7)=+WLAPTYP
 . I $D(WLUSER),WLUSER'=WLDATA(FNUM,WLIEN,9,"I") S @FDA@(9)=$S(WLUSER="":"@",1:+WLUSER)
 . I $D(WLEDT),WLEDT'=$G(WLDATA(FNUM,WLIEN,9.5,"I")) S @FDA@(9.5)=WLEDT
 . I $D(WLPRIO),WLPRIO'=WLDATA(FNUM,WLIEN,10,"I") S @FDA@(10)=$S(WLPRIO="":"@",1:WLPRIO)
 . I $D(WLENPRI),WLENPRI'=WLDATA(FNUM,WLIEN,10.5,"E") S @FDA@(10.5)=WLENPRI
 . I $D(WLREQBY),WLREQBY'=WLDATA(FNUM,WLIEN,11,"I") S @FDA@(11)=$S(WLREQBY="":"@",1:WLREQBY)
 . I $D(WLPROV),WLPROV'=WLDATA(FNUM,WLIEN,12,"I") S @FDA@(12)=$S(WLPROV="":"@",1:+WLPROV)
 . I $D(WLSVCCOP),WLSVCCOP'=$G(WLDATA(FNUM,WLIEN,14,"I")) S @FDA@(14)=WLSVCCOP
 . I $D(WLSVCCON),WLSVCCON'=WLDATA(FNUM,WLIEN,15,"E") S @FDA@(15)=WLSVCCON
 . I $D(WLDAPTDT),WLDAPTDT'=WLDATA(FNUM,WLIEN,22,"I") S @FDA@(22)=$S(WLDAPTDT="":"@",1:WLDAPTDT)
 . I $D(WLCOMM),WLCOMM'=WLDATA(FNUM,WLIEN,25,"I") S @FDA@(25)=$S(WLCOMM="":"@",1:WLCOMM)
 . I $D(WLEESTAT),WLEESTAT'=WLDATA(FNUM,WLIEN,27,"I") S @FDA@(27)=$S(WLEESTAT="":"@",1:WLEESTAT)
 ; Only call UPDATE^DIE if there are any array entries in FDA
 D:$D(@FDA) UPDATE^DIE("","FDA","WLRET","WLMSG")
 I $D(WLMSG) D
 . F MI=1:1:$G(WLMSG("DIERR")) S RET=RET_"-1^"_$G(WLMSG("DIERR",MI,"TEXT",1))_$C(30)
 . S RET=RET_$C(31)
 Q:$D(WLMSG)
 S WLINSTI=$P($G(^SDWL(409.3,$S(+WLIEN:WLIEN,1:WLRET(1)),0)),U,3)
 I $G(INP(6))'="" D WL6   ;wl specific team
 I $G(INP(8))'="" D WL8   ;wl service specialty
 I $D(INP(23)) D WL23(INP(23),$S(+WLIEN:WLIEN,1:WLRET(1)))   ;patient contacts
 I +AUDF D WLAUD($S(+WLIEN:+WLIEN,1:WLRET(1)),WLCLIN,WLHOS,INP(8))   ;VS AUDIT
 I +$G(WLRET(1)) S RET=RET_WLRET(1)_U_$C(30,31)
 E  S RET=RET_+WLIEN_U_$C(30,31)
 Q
 ;
WL6 ;WL SPECIFIC TEAM does not store with bulk UPDATE^DIE with external data; don't know why
 N FDA,H
 S H=$O(^SCTM(404.51,"B",+$G(INP(6)),0))
 I +H K FDA S FDA=$NA(FDA(409.3,$S(+WLIEN:WLIEN,1:WLRET(1))_",")) S @FDA@(5)=H D UPDATE^DIE("","FDA")
 Q
 ;
WL8 ;WL SERVICE/SPECIALTY does not store with bulk UPDATE^DIE if duplicates; need to look for 1st active one
 ; WL Service/Specialty name - NAME field in
 ; SD WL SERVICE/SPECIALTY file 409.31.
 N ADUF,SDWLNOD,WLSRVSP
 S WLSRVSP=""
 I +INP(8) S WLSRVSP=INP(8)
 I WLSRVSP="" S H="" F  S H=$O(^DIC(40.7,"B",$G(INP(8)),H)) Q:H=""  D  Q:WLSRVSP'=""
 .I $P(^DIC(40.7,H,0),U,3)'="",$P(^DIC(40.7,H,0),U,3)<$$NOW^XLFDT() Q
 .S WLSRVSP=$O(^SDWL(409.31,"B",H,0))
 I WLSRVSP'="" D
 .K FDA
 .S FDA=$NA(FDA(409.3,$S(+WLIEN:WLIEN,1:WLRET(1))_","))
 .S @FDA@(7)=WLSRVSP,ADUF=1
 .I +WLIEN,$D(WLDATA) D
 ..S:WLDATA(FNUM,WLIEN,8,"I")'="" @FDA@(8)="@"  ;errors
 ..S:WLDATA(FNUM,WLIEN,8.5,"I")'="" @FDA@(8.5)="@" ;errors
 .D:$D(FDA) UPDATE^DIE("","FDA")
 Q
 ;
WLACT(NAME) ;
 N ACTIVE,H
 S ACTIVE=""
 S H="" F  S H=$O(^DIC(40.7,"B",NAME,H)) Q:H=""  D  Q:ACTIVE'=""
 .I $P(^DIC(40.7,H,0),U,3)'="",$P(^DIC(40.7,H,0),U,3)<$$NOW^XLFDT() Q
 .S ACTIVE=H
 Q ACTIVE
 ;
WL23(INP23,WLI) ;Patient Contacts
 N STR23,WLASD,WLASDH,WLDATA1,WLERR1,WLI1,WLIENS,WLIENS1,WLRET1,FDA
 N WLUSR,X,Y,%DT
 S WLIENS=WLI_","
 F WLI1=1:1:$L(INP23,"::") D
 .S STR23=$P(INP23,"::",WLI1)
 .K FDA
 .S %DT="T" S X=$P($P(STR23,"~~",1),":",1,2) D ^%DT S WLASD=Y
 .I (WLASD=-1)!(WLASD="") Q
 .S WLASDH=""   ;$O(^SDWL(409.3,WLI,4,"B",WLASD,0))
 .S WLIENS1=$S(WLASDH'="":WLASDH,1:"+1")_","_WLIENS
 .S FDA=$NA(FDA(409.344,WLIENS1))
 .I WLASDH'="" D
 ..D GETS^DIQ(409.344,WLIENS1,"*","IE","WLDATA1","WLERR1")
 ..I $P(STR23,"~~",1)'="" S @FDA@(.01)=$P($P(STR23,"~~",1),":",1,2) ;DATE ENTERED external date/time
 ..I $P(STR23,"~~",2)'="" S WLUSR=$P(STR23,"~~",2) S @FDA@(2)=$S(WLUSR="":"@",+WLUSR:$P($G(^VA(200,WLUSR,0)),U,1),1:WLUSR)  ;PC ENTERED BY USER
 ..I $P(STR23,"~~",4)'="" S @FDA@(3)=$P(STR23,"~~",4)     ;ACTION  C=Called; M=Message Left; L=LETTER
 ..I $P(STR23,"~~",5)'="" S @FDA@(4)=$P(STR23,"~~",5)     ;PATIENT PHONE
 ..;I $P(STR23,"~~",6)'="" S @FDA@(5)=$E($P(STR23,"~~",6),1,160)     ;COMMENT
 .I WLASDH="" D
 ..I $P(STR23,"~~",1)'="" S @FDA@(.01)=$P($P(STR23,"~~",1),":",1,2) ;DATE ENTERED external date/time
 ..I $P(STR23,"~~",2)'=""  S WLUSR=$P(STR23,"~~",2) S @FDA@(2)=$S(WLUSR="":"@",+WLUSR:$P($G(^VA(200,WLUSR,0)),U,1),1:WLUSR)     ;PC ENTERED BY USER
 ..I $P(STR23,"~~",4)'="" S @FDA@(3)=$P(STR23,"~~",4)     ;ACTION  C=Called; M=Message Left; L=LETTER
 ..I $P(STR23,"~~",5)'="" S @FDA@(4)=$P(STR23,"~~",5)     ;PATIENT PHONE
 ..;I $P(STR23,"~~",6)'="" S @FDA@(5)=$E($P(STR23,"~~",6),1,160)     ;COMMENT
 .D:$D(@FDA) UPDATE^DIE("E","FDA","WLRET1","WLMSG1")
 .;D:$D(@FDA) UPDATE^DIE("E","FDA","WLRET1")
 Q
 ;
WLAUD(WLIEN,WLCLIN,SDCL,WLSTOP,DATE,USER)  ;populate VS AUDIT multiple field 45
 ; WLIEN   - (required) pointer to SDEC APPT REQUEST file 409.85
 ; WLCLIN  - (optional) pointer to SD WL SPECIFIC CLINIC
 ; SDCL    - (optional) pointer to HOSPITAL LOCATION file 44
 ; WLSTOP  - (optional) pointer to CLINIC STOP file
 ; DATE    - (optional) date/time in fileman format
 N SDFDA,SDP,SDPN
 S WLIEN=$G(WLIEN) Q:WLIEN=""
 S WLCLIN=$G(WLCLIN)
 S SDCL=$G(SDCL)
 S WLSTOP=$G(WLSTOP)
 S SDP=$O(^SDWL(409.3,WLIEN,6,9999999),-1)
 I +SDP S SDPN=^SDWL(409.3,WLIEN,6,SDP,0) I $P(SDPN,U,3)=WLCLIN,$P(SDPN,U,4)=SDCL,$P(SDPN,U,5)=WLSTOP Q
 S DATE=$G(DATE) S:DATE="" DATE=$E($$NOW^XLFDT,1,12)
 S USER=$G(USER) S:USER="" USER=DUZ
 S SDFDA(409.345,"+1,"_WLIEN_",",.01)=DATE
 S SDFDA(409.345,"+1,"_WLIEN_",",1)=USER
 S:WLCLIN'="" SDFDA(409.345,"+1,"_WLIEN_",",2)=WLCLIN
 S:SDCL'="" SDFDA(409.345,"+1,"_WLIEN_",",3)=SDCL
 S:WLSTOP'="" SDFDA(409.345,"+1,"_WLIEN_",",4)=WLSTOP
 D UPDATE^DIE("","SDFDA")
 Q
