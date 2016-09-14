SDECINI2 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 ;Reference is made to ICR #6185
 Q
 ;
SDAPPT  ;populate SDEC APPOINTMENT file with all existing patient appointments
 N DFN,SDA,SDAPL,SDCAPL,SDCL,SDDATA,SDFDA,SDI,SDIEN,SDMSG,SDNOD,SDPRV,SDS,SDSP,SDTODAY,Y
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,"Updating SDEC APPOINTMENT file 409.84 with existing patient appointments..."
 W !,Y
 S SDTODAY=$P($$NOW^XLFDT,".",1)
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:DFN'>0  D
 .S SDS=SDTODAY F  S SDS=$O(^DPT(DFN,"S",SDS)) Q:SDS'>0  D
 ..D SDECADD
 ;cleanup previous appointment lengths that did not account for variable appt length
 S SDI=SDTODAY F  S SDI=$O(^SDEC(409.84,"B",SDI),-1) Q:SDI=""  D
 .S SDIEN="" F  S SDIEN=$O(^SDEC(409.84,"B",SDI,SDIEN)) Q:SDIEN=""  D
 ..S SDNOD=$G(^SDEC(409.84,SDIEN,0))
 ..S SDRES=$P(SDNOD,U,7)
 ..S SDCL=$$GET1^DIQ(409.831,+SDRES_",",.04,"I")
 ..Q:SDCL=""
 ..S DFN=$P(SDNOD,U,5)
 ..S SDS=$P(SDNOD,U,1)
 ..S SDSP=$$FNDAPPT(SDCL,DFN,SDS)
 ..S SDAPL=$P($G(^SC(SDCL,"S",SDS,1,+SDSP,0)),U,2)
 ..S SDCAPL=$S(SDAPL'="":SDAPL,1:$P($G(^SC(SDCL,"SL")),U,1))
 ..I SDCAPL'=$P(SDNOD,U,18) D APL(SDIEN,SDS,SDCAPL)
 ;
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,Y
 W !,"END - Updating SDEC APPOINTMENT file 409.84 with existing patient appointments..."
 Q
SDECADD  ;add SDEC APPOINTMENT entry
 N SDAPL,SDCAPL,SDAPTYP,SDCAN,SDCHK,SDCL,SDCLN,SDECAPPTID,SDECFDA,SDECIEN,SDECMSG,SDECRESD
 N SDNOS,SDREC,SDSP,SDSTAT,SDVPRV,SDWL
 K SDDATA,SDMSG
 D GETS^DIQ(2.98,SDS_","_DFN_",","**","IE","SDDATA","SDMSG")
 S SDA="SDDATA(2.98,"""_SDS_","_DFN_","")"
 S SDFDA=$NA(SDFDA(409.84,"+1,"))
 S SDCL=@SDA@(.01,"I")
 S SDCLN=@SDA@(.01,"E")
 S SDECRESD=$O(^SDEC(409.831,"B",SDCLN,0))
 S SDSP=$$FNDAPPT(SDCL,DFN,SDS)   ;get clinic appt pointer
 ;look for SDWL, consult, then recall. If none found, add APPT entry
 S SDAPTYP=""
 S SDWL=$$FNDSDWL(DFN,SDS,SDCL) I SDWL'="" S SDAPTYP=SDWL_";SDWL(409.3,"
 I SDAPTYP="" I SDSP'="",$P($G(^SC(SDCL,"S",SDS,1,SDSP,"CONS")),U,1)'="" S SDAPTYP=$P($G(^SC(SDCL,"S",SDS,1,SDSP,"CONS")),U,1)_";GMR(123,"
 I SDAPTYP="" S SDREC=$$RECALL^SDECUTL(DFN,SDS,SDCL) I SDREC'="" S SDAPTYP=SDREC_";SD(403.5,"
 ;I SDAPTYP="" S SDAPPT=$$FNDAREQ(DFN,SDS,SDCL) I SDAPPT'="" S SDAPTYP=SDAPPT_";SDEC(409.84,"
 ;Q:$$SDECCHK(DFN,SDS,SDECRESD,SDAPTYP)   ;check appt already exists
 S SDAPL=$P($G(^SC(SDCL,"S",SDS,1,+SDSP,0)),U,2)
 S SDCAPL=$S(SDAPL'="":SDAPL,1:$P($G(^SC(SDCL,"SL")),U,1))   ;appt length
 Q:$$SDECCHK(DFN,SDS,SDECRESD,,SDCAPL)   ;check appt already exists
 I SDAPTYP="" S SDWL=$$SDWLA^SDM1A(DFN,SDS,SDCL,@SDA@(27,"I"),@SDA@(9.5,"I")) I SDWL'="" S SDAPTYP=SDWL_";SDEC(409.85,"
 S:SDAPTYP'="" @SDFDA@(.22)=SDAPTYP
 ;Create entry in SDEC APPOINTMENT
 S SDSTAT=@SDA@(3,"I")                           ;status
 S SDNOS=$S(SDSTAT="N":1,SDSTAT="NA":1,1:0)      ;no show flag
 S SDCAN=$S(SDSTAT="C":1,SDSTAT="CA":1,SDSTAT="PC":1,SDSTAT="PCA":1,1:0)  ;cancel flag
 S SDCHK=$S(SDSP'="":$G(^SC(SDCL,"S",SDS,1,SDSP,"C")),1:"")               ;clinic C checkin node
 ;
 S @SDFDA@(.01)=SDS                              ;start time
 S @SDFDA@(.02)=$$FMADD^XLFDT(SDS,,,SDCAPL)       ;end time
 S:$P(SDCHK,U,1) @SDFDA@(.03)=$P(SDCHK,U,1)      ;check-in
 S:$P(SDCHK,U,5) @SDFDA@(.04)=$P(SDCHK,U,5)      ;check-in time entered
 S @SDFDA@(.05)=DFN
 ;S:SDECATID?.N @SDFDA@(.06)=SDECATID
 S @SDFDA@(.07)=SDECRESD                         ;resource
 S @SDFDA@(.08)=@SDA@(19,"I")                    ;entered by
 S @SDFDA@(.09)=@SDA@(20,"I")                    ;date appt made
 S @SDFDA@(.1)=+SDNOS                            ;no show 1=YES 0=NO
 S:SDNOS @SDFDA@(.101)=@SDA@(15,"I")             ;no show date/time
 S:SDNOS @SDFDA@(.102)=@SDA@(14,"I")             ;no show user
 S:@SDA@(12,"I")'="" @SDFDA@(.11)=@SDA@(12,"I")  ;auto rebook date/time
 S:SDCAN @SDFDA@(.12)=@SDA@(15,"I")              ;cancel date/time (same as no show date/time)
 S:SDCAN @SDFDA@(.121)=@SDA@(14,"I")             ;cancel by user
 S:SDCAN @SDFDA@(.122)=@SDA@(16,"I")             ;cancellation reason
 S:@SDA@(25,"I")="W" @SDFDA@(.13)="y"            ;walk-in
 S:$P(SDCHK,U,3)'="" @SDFDA@(.14)=$P(SDCHK,U,3)  ;checked out date/time
 S SDVPRV=$$FNDVPRV(DFN,SDS)
 S:$P(SDVPRV,U,1)'="" @SDFDA@(.15)=$P(SDVPRV,U,1)  ;v provider
 S:$P(SDVPRV,U,2)'="" @SDFDA@(.16)=$P(SDVPRV,U,2)  ;provider
 S @SDFDA@(.17)=""
 S @SDFDA@(.18)=SDCAPL                              ;appt length
 S @SDFDA@(.19)=""
 S @SDFDA@(.2)=@SDA@(27,"I")                       ;desired date of appt
 D UPDATE^DIE("","SDFDA")
 K SDECIEN,SDECMSG
 Q
 ;
FNDVPRV(DFN,APPDT)   ;get v provider for given patient and date/time
 N SDI,SDNOD,SDRET
 S SDRET=""
 S SDI=0 F  S SDI=$O(^AUPNVPRV("B",DFN,SDI)) Q:SDI'>0  D  Q:SDRET'=""
 .Q:$$GET1^DIQ(9000010.06,SDI_",",12,"I")'=APPDT
 .S SDRET=SDI_U_$$GET1^DIQ(9000010.06,SDI_",",.01,"I")
 Q SDRET
 ;
FNDAPPT(SDCL,DFN,SDS)  ;get clinic appointment pointer
 N SDI,SDRET
 S SDRET=""
 S SDI=0 F  S SDI=$O(^SC(SDCL,"S",SDS,1,SDI)) Q:SDI'>0  D  Q:SDRET'=""
 .I DFN=$$GET1^DIQ(44.003,SDI_","_SDS_","_SDCL_",",.01,"I") S SDRET=SDI
 Q SDRET
 ;
FNDSDWL(DFN,SDS,SDCL)   ;get wait list entry
 N SDI,SDNOD,SDRET
 S SDRET=""
 S SDI=0 F  S SDI=$O(^SDWL(409.3,"B",DFN,SDI)) Q:SDI'>0  D  Q:SDRET'=""
 .S SDNOD=$G(^SDWL(409.3,SDI,"SDAPT"))
 .I $P($G(^SDWL(409.3,SDI,0)),U,23)=SDS,$P(SDNOD,U,2)=SDCL S SDRET=SDI
 Q SDRET
 ;
FNDAREQ(DFN,SDS,SDCL)   ;get SDEC APPT REQUEST entry
 N SDI,SDNOD,SDRET
 S SDRET=""
 S SDI=0 F  S SDI=$O(^SDEC(409.85,"B",DFN,SDI)) Q:SDI'>0  D  Q:SDRET'=""
 .S SDNOD=$G(^SDEC(409.85,SDI,"SDAPT"))
 .I $P(SDNOD,U,1)=SDS,$P(SDNOD,U,2)=SDCL S SDRET=SDI
 Q SDRET
 ;
SDECCHK(DFN,SDS,SDRES,SDAPTYP,SDCAPL)  ;check for existing SDEC APPOINTMENT entry
 N SDFDA,SDI,SDNOD,SDNOD2,SDRET,SDTYP
 ;S:$G(SDAPTYP)="" SDAPTYP=";SDEC(409.85,"
 S SDRET=0
 S SDI=0 F  S SDI=$O(^SDEC(409.84,"CPAT",DFN,SDI)) Q:SDI'>0  D  Q:+SDRET
 .S SDNOD=$G(^SDEC(409.84,SDI,0))
 .;S SDNOD2=$G(^SDEC(409.84,SDI,2))
 .I $P(SDNOD,U,1)=SDS,$P(SDNOD,U,7)=SDRES S SDRET=SDI D
 ..;I $P($P(SDNOD2,U,1),";",2)=$P(SDAPTYP,";",2) S SDRET=SDI
 ..;check request type
 ..S SDTYP=$P($G(^SDEC(409.84,SDI,2)),U,1)
 ..I $P(SDTYP,";",2)="SDWL(409.3," D
 ...I $D(^SDWL(409.3,$P(SDTYP,";",1),0)),$$GET1^DIQ(409.3,$P(SDTYP,";",1),.01,"I")=DFN Q
 ...I $D(^SDEC(409.85,$P(SDTYP,";",1),0)),$$GET1^DIQ(409.85,$P(SDTYP,";",1),.01,"I")=DFN D
 ....S SDFDA(409.84,SDI_",",.22)=$P(SDTYP,";",1)_";SDEC(409.85,"
 ....D UPDATE^DIE("","SDFDA")
 ..I $P(SDNOD,U,18)'=SDCAPL D APL(SDI,SDS,SDCAPL)
 Q SDRET
APL(SDIEN,SDS,SDCAPL)  ;
 N SDFDA
 S SDFDA(409.84,SDIEN_",",.18)=SDCAPL
 S SDFDA(409.84,SDIEN_",",.02)=$$FMADD^XLFDT(SDS,,,SDCAPL)
 D UPDATE^DIE("","SDFDA")
 Q
 ;
CHK  ;check cross-reference integrity
 N SDA,SDDT,SDI,SDNAM,SDNOD,SDNOD1,SDNOD2,Y
 W !!,"No changes taking place during existing cross-reference validity checks."
 ;B xref in file 44
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,"BEGIN existing cross-reference validity checks for B xref of file 44."
 W !,Y
 S SDNAM="" F  S SDNAM=$O(^SC("B",SDNAM)) Q:SDNAM=""  D
 .S SDI="" F  S SDI=$O(^SC("B",SDNAM,SDI)) Q:SDI=""  D
 ..I '$D(^SC(+SDI,0)) S SDA(44,"B","INVALID",SDI,SDNAM)="" Q
 ..S SDNOD=$E($$GET1^DIQ(44,+SDI_",",.01),1,30)
 ..I SDNOD="" S SDA(44,"B","MISMATCH",+SDI,SDNAM,"<no name>")="" Q
 ..I $E(SDNOD,1,30)'=$E(SDNAM,1,30) S SDA(44,"B","MISMATCH",+SDI,SDNAM,SDNOD)="" Q
 I '$D(SDA(44,"B")) W !,"  No issues found."
 I $D(SDA(44,"B")) W !,"  See summary below."
 ;B xref in file 409.3 SD WAIT LIST
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,"BEGIN existing cross-reference validity checks for B xref of file 409.3."
 W !,Y
 S SDNAM="" F  S SDNAM=$O(^SDWL(409.3,"B",SDNAM)) Q:SDNAM=""  D
 .S SDI="" F  S SDI=$O(^SDWL(409.3,"B",SDNAM,SDI)) Q:SDI=""  D
 ..I '$D(^SDWL(409.3,+SDI,0)) S SDA(409.3,"B","INVALID",SDI,SDNAM)="" Q
 ..S SDNOD=$E($$GET1^DIQ(409.3,+SDI_",",.01,"I"),1,30)
 ..I SDNOD="" S SDA(409.3,"B","MISMATCH",+SDI,SDNAM,"<no patient>")="" Q
 ..I SDNOD'=SDNAM S SDA(409.3,"B","MISMATCH",+SDI,SDNAM,SDNOD)="" Q
 I '$D(SDA(409.3,"B")) W !,"  No issues found."
 I $D(SDA(409.3,"B")) W !,"  See summary below."
 ;B xref in file 403.5 RECALL REMINDERS
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,"BEGIN existing cross-reference validity checks for B xref of file 403.5."
 W !,Y
 S SDNAM="" F  S SDNAM=$O(^SD(403.5,"B",SDNAM)) Q:SDNAM=""  D
 .S SDI="" F  S SDI=$O(^SD(403.5,"B",SDNAM,SDI)) Q:SDI=""  D
 ..I '$D(^SD(403.5,+SDI,0)) S SDA(403.5,"B","INVALID",SDI,SDNAM)="" Q
 ..S SDNOD=$E($$GET1^DIQ(403.5,+SDI_",",.01,"I"),1,30)
 ..I SDNOD="" S SDA(403.5,"B","MISMATCH",+SDI,SDNAM,"<no patient>")="" Q
 ..I SDNOD'=SDNAM S SDA(403.5,"B","MISMATCH",+SDI,SDNAM,SDNOD)="" Q
 I '$D(SDA(403.5,"B")) W !,"  No issues found."
 I $D(SDA(403.5,"B")) W !,"  See summary below."
 ;D xref in file 403.5 RECALL REMINDERS
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,"BEGIN existing cross-reference validity checks for D xref of file 403.5."
 W !,Y
 S SDNAM="" F  S SDNAM=$O(^SD(403.5,"D",SDNAM)) Q:SDNAM=""  D
 .S SDI="" F  S SDI=$O(^SD(403.5,"D",SDNAM,SDI)) Q:SDI=""  D
 ..I '$D(^SD(403.5,+SDI,0)) S SDA(403.5,"D","INVALID",SDI,SDNAM)="" Q
 ..S SDNOD=$E($$GET1^DIQ(403.5,+SDI_",",5,"I"),1,30)
 ..I SDNOD="" S SDA(403.5,"D","MISMATCH",+SDI,SDNAM,"<no patient>")="" Q
 ..I SDNOD'=SDNAM S SDA(403.5,"D","MISMATCH",+SDI,SDNAM,SDNOD)="" Q
 I '$D(SDA(403.5,"D")) W !,"  No issues found."
 I $D(SDA(403.5,"D")) W !,"  See summary below."
 ;AD xref in file 123 REQUEST/CONSULTATION  ICR 6185
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,"BEGIN existing cross-reference validity checks for AD xref of file 123."
 W !,Y
 S SDNAM="" F  S SDNAM=$O(^GMR(123,"AD",SDNAM)) Q:SDNAM=""  D
 .S SDDT="" F  S SDDT=$O(^GMR(123,"AD",SDNAM,SDDT)) Q:SDDT=""  D
 ..S SDI="" F  S SDI=$O(^GMR(123,"AD",SDNAM,SDDT,SDI)) Q:SDI=""  D
 ...I '$D(^GMR(123,+SDI,0)) S SDA(123,"AD","INVALID",SDI,SDNAM)="" Q
 ...S SDNOD1=$$GET1^DIQ(123,+SDI_",",.02,"I")
 ...I SDNOD1="" S SDA(123,"AD","MISMATCH",+SDI,SDNAM,"<no patient>")="" Q
 ...I SDNOD1'=SDNAM S SDA(123,"AD","MISMATCH",+SDI,SDNAM,SDNOD1)="" Q
 ...S SDNOD2=$$GET1^DIQ(123,+SDI_",",3,"I")
 ...I SDNOD2="" S SDA(123,"AD","MISMATCH",+SDI,SDDT,"<no date of request>")="" Q
 ...S SDNOD2=9999999-SDNOD2
 ...I SDNOD2'=SDDT S SDA(123,"AD","MISMATCH",+SDI,SDDT,SDNOD2)="" Q
 I '$D(SDA(123,"AD")) W !,"  No issues found."
 I $D(SDA(123,"AB")) W !,"  See summary below."
 ;E xref in file 123 REQUEST/CONSULTATION   ICR 6185
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,"BEGIN existing cross-reference validity checks for E xref of file 123."
 W !,Y
 S SDNAM="" F  S SDNAM=$O(^GMR(123,"E",SDNAM)) Q:SDNAM=""  D
 .S SDI="" F  S SDI=$O(^GMR(123,"E",SDNAM,SDI)) Q:SDI=""  D
 ..I '$D(^GMR(123,+SDI,0)) S SDA(123,"E","INVALID",SDI,SDNAM)="" Q
 ..S SDNOD=$$GET1^DIQ(123,+SDI_",",3,"I")
 ..I SDNOD="" S SDA(123,"E","MISMATCH",+SDI,SDNAM,"<no patient>")="" Q
 ..I SDNOD'=SDNAM S SDA(123,"E","MISMATCH",+SDI,SDNAM,SDNOD)="" Q
 I '$D(SDA(123,"E")) W !,"  No issues found."
 I $D(SDA(123,"E")) W !,"  See summary below."
 ;AB xref in file 200 NEW PERSON
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,"BEGIN existing cross-reference validity checks for AB xref of file 200."
 W !,Y
 S SDNAM="" F  S SDNAM=$O(^VA(200,"AB",SDNAM)) Q:SDNAM=""  D
 .S SDDT="" F  S SDDT=$O(^VA(200,"AB",SDNAM,SDDT)) Q:SDDT=""  D
 ..S SDI="" F  S SDI=$O(^VA(200,"AB",SDNAM,SDDT,SDI)) Q:SDI=""  D
 ...I '$D(^VA(200,+SDDT,51,SDI,0)) S SDA(200,"AB","INVALID",SDDT,SDNAM)=""  ;SDDT=id to 200; SDNAM=id to key
 I '$D(SDA(200,"AB")) W !,"  No issues found."
 I $D(SDA(200,"AB")) W !,"  See summary below."
 ;B xref in file 200 NEW PERSON
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,"BEGIN existing cross-reference validity checks for B xref of file 200."
 W !,Y
 S SDNAM="" F  S SDNAM=$O(^VA(200,"B",SDNAM)) Q:SDNAM=""  D
 .S SDI="" F  S SDI=$O(^VA(200,"B",SDNAM,SDI)) Q:SDI=""  D
 ..I '$D(^VA(200,+SDI,0)) S SDA(200,"B","INVALID",SDI,SDNAM)="" Q
 ..S SDNOD=$E($$GET1^DIQ(200,+SDI_",",.01,"I"),1,30)
 ..I SDNOD="" S SDA(200,"B","MISMATCH",+SDI,SDNAM,"<no new person>")="" Q
 ..I $E(SDNOD,1,30)'=$E(SDNAM,1,30) S SDA(200,"B","MISMATCH",+SDI,SDNAM,SDNOD)="" Q
 I '$D(SDA(200,"B")) W !,"  No issues found."
 I $D(SDA(200,"B")) W !,"  See summary below."
 D CHKW(.SDA)
 S Y=$$NOW^XLFDT,Y=$$FMTE^XLFDT(Y)
 W !!,Y
 W !,"END existing cross-reference validity checks.",!!
 Q
CHKW(SDA) ;
 N SDF,SDI,SDNAM,SDNOD,SDS
 N T1,T2,T3
 Q:'$O(SDA(0))
 W !!,"  SUMMARY of existing cross-reference validity checks:"
 W !,"  ----------------------------------------------------"
 ;set tabs
 S T1=2,T2=14,T3=46
 S SDF="" F  S SDF=$O(SDA(SDF)) Q:SDF=""  D
 .S SDS="" F  S SDS=$O(SDA(SDF,SDS)) Q:SDS=""  D
 ..;Invalid pointers
 ..I $D(SDA(SDF,SDS,"INVALID"))>1 D
 ...W !!,"INVALID POINTERS found in "_SDS_" xref of file "_SDF
 ...W !,?T1,"ID",?T2,"XREF NAME"
 ...W !,?T1,"--",?T2,"---------"
 ...S SDI="" F  S SDI=$O(SDA(SDF,SDS,"INVALID",SDI)) Q:SDI=""  D
 ....S SDNAM="" F  S SDNAM=$O(SDA(SDF,SDS,"INVALID",SDI,SDNAM)) Q:SDNAM=""  D
 .....W !,?T1,SDI,?T2,SDNAM
 ..I $D(SDA(SDF,SDS,"MISMATCH"))>1 D
 ...W !!,"NAMES DO NOT MATCH found in "_SDS_" xref of file "_SDF
 ...W !,?T1,"ID",?T2,"XREF NAME",?T3,"ENTRY NAME"
 ...W !,?T1,"--",?T2,"---------",?T3,"----------"
 ...S SDI="" F  S SDI=$O(SDA(SDF,SDS,"MISMATCH",SDI)) Q:SDI=""  D
 ....S SDNAM="" F  S SDNAM=$O(SDA(SDF,SDS,"MISMATCH",SDI,SDNAM)) Q:SDNAM=""  D
 .....S SDNOD="" F  S SDNOD=$O(SDA(SDF,SDS,"MISMATCH",SDI,SDNAM,SDNOD)) Q:SDNOD=""  D
 ......W !,?T1,SDI,?T2,SDNAM,?T3,SDNOD
 ;I '$D(SDA) W !,"  No issues found."
 Q
