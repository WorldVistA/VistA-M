SDECRT1 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
PRINT(ORDER,SDATE,SDX,SDSTART,SDSTOP,SDREP) ;EP; called to print routing slips
 ; called by SDROUT0
 ; assumes the following variables are set: SDSTART,SDSTOP,SDX,SDREP,DIV
 ; loop by sort criteria and get patient
 NEW SORT,TERM,DFN,BSDI,CNT,SDCNT,SECOND
 S SORT=0
 F  S SORT=$O(^TMP("SDRS",$J,SORT)) Q:SORT=""  D
 . S TERM=0 F  S TERM=$O(^TMP("SDRS",$J,SORT,TERM)) Q:TERM=""  D
 .. S DFN=0 F  S DFN=$O(^TMP("SDRS",$J,SORT,TERM,DFN)) Q:'DFN  D
 ... ;
 ... I $$FORMAT="DUPLICATE" S SECOND=0  ;print 2 per page
 ... D RS(SORT,TERM,DFN,1)              ;print one rs for file room
 ... ;
 ... ; now print a copy for each appt if parameter set that way
 ... I $$MORERS S CNT=$$APPTCNT(SORT,TERM,DFN) F BSDI=1:1:CNT D RS(SORT,TERM,DFN,0)
 ... ;
 ... D OTHER(DFN)     ;print other forms
 K SDCNT   ;remove this line to print # of rs printed on end of report
 K BDGSDEV  ;cmi/anch/maw 5/9/2008 PATCH 1009 rqmt 64 kill storage of device name after printing of all RS and other docs
 K SDSTOP D END^SDROUT1
 Q
 ;
RS(SORT,TERM,DFN,FIRST) ; -- print rs
 ; quit if not first appt that day when sorting by clinic
 ;
 ;If printing >1 RS and is second or more time through, sorting by clinic, quit if not first appt that day
 I (FIRST=0)&(ORDER=2) Q:'$G(^TMP("SDRS",$J,DFN,SORT))
 I (FIRST=0)&(ORDER=3) Q:'$G(^TMP("SDRS",$J,DFN,SORT))
 ;
 ;if printing only one RS and sorting by clinic, quit if this is not first appt
 I ($$FIRST^SDECRT0(DFN,+$O(^TMP("SDRS",$J,SORT,TERM,DFN,0)))=0),(ORDER=2),($$MORERS=0) Q
 I ($$FIRST^SDECRT0(DFN,+$O(^TMP("SDRS",$J,SORT,TERM,DFN,0)))=0),(ORDER=3),($$MORERS=0) Q
 ;
 NEW DATE,CLN,BSDPG
 D RSHED(DFN)                                ;rs heading
 S DATE=0 D CURHED                           ;current appt heading
 F  S DATE=$O(^TMP("SDRS",$J,SORT,TERM,DFN,DATE)) Q:'DATE  D
 . S CLN=^TMP("SDRS",$J,SORT,TERM,DFN,DATE)
 . ;
 . ; make sure RS by clinic contains all appts for date
 . I (ORDER=2)!(ORDER=3) D APPTC(DFN,TERM,DATE),PRTDT(DFN,DATE,CLN,$P(CLN,U,3)) S DATE=9999999 Q
 . ;
 . D APPT(DFN,DATE,CLN)                      ;display appt info
 . D PRTDT(DFN,DATE,CLN,$P(CLN,U,3))         ;record date printed
 I $$FORMAT="LONG" D FUTURE(DFN)             ;find future appts
 D PRINTED                                   ;date printed
 ;
 I $$FORMAT="DUPLICATE",'SECOND D
 . S SECOND=1                      ;mark as second one per page
 . F  Q:$Y>((IOSL)\2)  W !         ;move to middle of piece of paper
 . W !,$$REPEAT^XLFSTR("-",IOM)    ;dashed line between routing slips
 . D RS(SORT,TERM,DFN,FIRST)
 Q
 ;
APPTC(DFN,TERM,DATE)         ; -- loop through all patient's appts for date
 NEW APDT,CLN,ARRAY,SORT
 S APDT=(DATE\1)-.0001
 F  S APDT=$O(^TMP("SDRS1",$J,DFN,APDT)) Q:'APDT  D
 . S SORT=$G(^TMP("SDRS1",$J,DFN,APDT))
 . S CLN=$G(^TMP("SDRS",$J,SORT,TERM,DFN,APDT))
 . D APPT(DFN,APDT,CLN)
 Q
 ;
APPT(DFN,DATE,CLN) ; -- print individual appointments
 I $Y>(IOSL-3) D RSHED(DFN),CURHED
 NEW X,Y
 I $P(CLN,U,3)'="CR" S X=DATE D TM^SDROUT0 W !,$J(X,8)  ;appt time
 I $P(CLN,U,3)="CR" D
 . W !,"CR-"_$E(DATE,4,5)_"/"_$E(DATE,6,7)_"-"_($E(DATE,1,3)+1700)
 ;
 ; mark walkins, same day appts and chart requests
 I $P(CLN,U,3)'="CR" W ?9,$P(CLN,U,3)
 ;
 S X=CLN I $P(CLN,U,2)]"" S X=$P(CLN,U,2)_" Stop"    ;xray or lab stop
 E  S X=$$GET1^DIQ(44,+CLN,.01)                      ;clinic name
 W ?13,$E(X,1,25)                                    ;print it
 I $P(CLN,U,2)="" D
 . I $$FORMAT="SHORT" W !?11                         ;adjust print head
 . E  W ?40
 . W $$GET1^DIQ(44,+CLN,10)                          ;physical location
 . W:$$FORMAT'="SHORT" ?68,$$GET1^DIQ(44,+CLN,99)    ;clinic telephone
 ;
 ;chart request
 S X=0 F  S X=$O(^SC(+CLN,"C",DATE\1,1,X)) Q:'X  D
 . Q:+$G(^SC(+CLN,"C",DATE\1,1,X,0))'=DFN
 . S Y=$G(^SC(+CLN,"C",DATE\1,1,X,9999999))
 . ;
 . NEW COL S COL=$S($$FORMAT="SHORT":3,1:13)
 . W !?COL,$P(Y,U,3)   ;deliver to info
 . W !?COL,"Requested at "_$$FMTE^XLFDT($E(+Y,1,12))_" by "_$$GET1^DIQ(200,+$P(Y,U,2),.01)_" x"_$$GET1^DIQ(200,+$P(Y,U,2),.132)
 Q
 ;
PRTDT(P,D,C,MODE) ; -- called to set date routing slip printed
 NEW DIE,DA,DR
 I MODE="CR" D PRTCR(P,D,C) Q     ;chart request printed
 Q:'$D(^DPT(P,"S",D,0))
 Q:$P(^DPT(P,"S",D,0),U,2)["C"
 S DIE="^DPT("_P_",""S"",",DA=D,DA(1)=P
 S DR="8///Y" S:$P(^DPT(P,"S",D,0),U,13)="" DR=DR_";8.5///^S X=""NOW"""
 D ^DIE
 Q
 ;
PRTCR(PAT,DATE,CLN) ; -- set date/time chart request printed
 NEW X,DIE,DA,DR,IEN
 S IEN=0 F  S IEN=$O(^SC(+CLN,"C",(DATE\1),1,IEN)) Q:'IEN  D
 . Q:+$G(^SC(+CLN,"C",(DATE\1),1,IEN,0))'=PAT          ;wrong patient
 . S DIE="^SC("_(+CLN)_",""C"","_(DATE\1)_",1,"
 . S DA=IEN,DA(1)=DATE\1,DA(2)=+CLN,DR="9999999.04///^S X=""NOW"""
 . D ^DIE
 Q
 ;
FUTURE(DFN) ; -- print future appts
 NEW BSDX,BSDY,BSDI,X,Y
 ; print subheading (and page heading if needed)
 I $O(^DPT(DFN,"S",SDATE_".9"))>0 D
 . I $Y>(IOSL-5) D RSHED(DFN)
 . D FUTHED
 ;
 ; loop through future appts and print
 F BSDX=SDATE_".9":0 S BSDX=$O(^DPT(DFN,"S",BSDX)) Q:BSDX=""  D
 . I $Y>(IOSL-5) D RSHED(DFN),FUTHED
 . S BSDY=$G(^DPT(DFN,"S",BSDX,0))          ;appt data
 . Q:$P(BSDY,U,2)["C"                       ;skip cancelled appts
 . ;
 . ; display extra stops if scheduled
 . F BSDI=3,4,5 I $P(BSDY,U,BSDI)]"" D
 .. I $Y>(IOSL-5) D RSHED(DFN),FUTHED
 .. S (X,Y)=$P(BSDY,U,BSDI)
 .. D TM^SDROUT0,DTS^SDUTL W !,Y,?13,$J(X,8)   ;date and time
 .. W ?22,$S(BSDI=3:"LAB",BSDI=4:"XRAY",1:"EKG")," Stop"
 . ;
 . ; display main appt
 . S (X,Y)=BSDX D TM^SDROUT0,DTS^SDUTL W !,Y,?13,$J(X,8)  ;date/time
 . W ?21,$$GET1^DIQ(44,+BSDY,.01)                         ;clinic
 . W ?55,$$GET1^DIQ(44,+BSDY,10)                          ;location
 Q
 ;
PRINTED ; add date printed, requested by and increment count of rs printed
 I SDREP,SDX'["ALL" D  Q
 . W !!,"DATE ORIGINALLY PRINTED  : ",$$FMTE^XLFDT(SDSTART)
 . W !,"DATE REPRINTED: ",$$FMTE^XLFDT(DT)
 . S SDCNT=$G(SDCNT)+1             ;increment # of routing slips printed
 W !!,"DATE PRINTED: ",$$FMTE^XLFDT($$NOW^XLFDT)
 W !,"Requested by: ",$$GET1^DIQ(200,$G(DUZ),.01)
 S SDCNT=$G(SDCNT)+1             ;increment # of routing slips printed
 Q
 ;
CURHED ; -- print current appt heading
 W !!?9,"**CURRENT APPOINTMENTS**"
 W !?3,"TIME",?13,"CLINIC" Q:$$FORMAT="SHORT"   ;short and narrow
 W ?40,"LOCATION",?68,"PHONE"
 Q
 ;
FUTHED ; -- print future appt heading
 W !!,?9,"**FUTURE APPOINTMENTS**",!,$$REPEAT^XLFSTR("=",79)
 W !,"  DATE",?13,"TIME",?21,"CLINIC",?55,"LOCATION",!
 Q
 ;
RSHED(DFN) ; -- routing slip heading
 I $$FORMAT="DUPLICATE",SECOND W !
 E  I $G(SDCNT)>0 W @IOF
 W !,"FACILITY: ",$$GET1^DIQ(40.8,$$DIV,.01)
 W ?40,"**",$E($$CONF^SDECU,1,25),"**"
 S BSDPG=$G(BSDPG)+1 W !,"PAGE ",BSDPG,?10,"OUTPATIENT ROUTING SLIP"
 ;
 W !!,$$GET1^DIQ(2,DFN,.01),?30,"HRCN: ",$$HRCN^SDECF2(DFN,+$G(DUZ(2)))
 ;
 W !?5,"DOB: ",$$GET1^DIQ(2,DFN,.03)
 W ?44,"APPT DT:  ",$$FMTE^XLFDT(SDATE,5)
 ;
 I $$DEAD^SDECF2(DFN) W !?10,"**** PATIENT DIED ON ",$$DOD^SDECF2(DFN)," ****"
 ;
 Q:BSDPG>1       ;rest only needs to be on first page
 ;
 I $$FORMAT="LONG" D
 . NEW VAPA,I D ADD^VADPT F I=1:1:3 W:VAPA(I)]"" !,VAPA(I)   ;street
 . W !,VAPA(4),", ",$P(VAPA(5),U,2),"  ",VAPA(6)        ;city,state,zip
 Q
 ;
OTHER(DFN) ; -- calls other forms
 Q:$$GET1^DIQ(9009020.2,$$DIV,.04)'="YES"  ;print forms with rs?
 ;
 ; only print extra forms with first routing slip for day
 I (ORDER=2)!(ORDER=3) Q:'$G(^TMP("SDRS",$J,DFN,SORT))
 ;
 D HS(DFN,SDATE)    ;   health summary
 D MP(DFN,SDATE)    ;   med profile
 S IO=$$CHKDV($G(BDGSDEV))  ;cmi/anch/maw 5/9/2008 add check to see if device is still open
 D APRO(DFN,SDATE)  ;   action profile
 D AIU(DFN,SDATE)   ;   address/insurance update
 Q
 ;
HS(DFN,SDATE) ; -- health summary
 Q
 ;NEW Y
 ;S Y=$$ONE(DFN,SDATE,.04) I 'Y Q
 ;D HS^BSDFORM(DFN,$P(Y,U,2)) Q
 ;
MP(DFN,SDATE) ; -- med profile
 Q
 ;NEW BSDRX
 ;S BSDRX=$$ONE(DFN,SDATE,.06) I 'BSDRX Q
 ;I $P(BSDRX,U,2)'=2 D MP^BSDFORM(DFN)
 ;Q
 ;
APRO(DFN,SDATE) ; -- action profiles (one for each appt where needed)
 NEW BSDX,CLN,Y
 S BSDX=SDATE\1
 F  S BSDX=$O(^DPT(DFN,"S",BSDX)) Q:BSDX=""  Q:BSDX>(SDATE+.2400)  D
 . S CLN=$P($G(^DPT(DFN,"S",BSDX,0)),U) Q:CLN=""  Q:$P(^(0),U,2)["C"
 . S Y=$$GET1^DIQ(9009017.2,CLN,.06,"I") Q:Y=0  Q:Y=1
 . ;D APRO^BSDFORM(CLN,DFN,SDATE)
 Q
 ;
AIU(DFN,SDATE) ; -- insurance update
 Q
 ;
ONE(DFN,SDATE,FORM) ; -- returns 1 if at least one  clinic for pat wants form
 NEW X,Y,Z,C
 S Y=0,X=SDATE\1
 F  S X=$O(^DPT(DFN,"S",X)) Q:X=""  Q:X>(SDATE+.2400)  Q:(+Y=1)  D
 . S C=$P($G(^DPT(DFN,"S",X,0)),U) Q:C=""  Q:$P(^(0),U,2)["C"
 . S Z=$$GET1^DIQ(9009017.2,C,FORM,"I") Q:+Z=0   ;form not turned on
 . I FORM=.06 S Y=1_U_Z Q
 . I FORM=.04 S Y=1_U_$$GET1^DIQ(9009017.2,C,.05,"I") Q  ;hs type ien
 . S Y=1
 ;
 ; if none found, check chart requests
 I Y=0 D
 . S C=0 F  S C=$O(^SC("AIHSCR",DFN,C)) Q:'C  Q:Y=1  D
 .. I $O(^SC("AIHSCR",DFN,C,(SDATE\1),0)) D
 ... S Z=$$GET1^DIQ(9009017.2,C,FORM,"I") Q:+Z=0   ;form not turned on
 ... I FORM=.06 S Y=1_U_Z Q
 ... I FORM=.04 S Y=1_U_$$GET1^DIQ(9009017.2,C,.05,"I") Q  ;hs type ien
 ... S Y=1
 Q Y
 ;
 ;
MORERS() ; -- returns 1 if want >1 rs
 Q $$GET1^DIQ(9009020.2,$$DIV,.03,"I")
 ;
DIV() ; -- returns division ien
 Q $$DIV^SDECU
 ;
FORMAT() ; -- returns format used - short, long or duplicate
 Q $$GET1^DIQ(9009020.2,$$DIV,.16)
 ;
APPTCNT(A,B,C) ; -- count how many appts patient has for date
 NEW CNT,X S (CNT,X)=0
 F  S X=$O(^TMP("SDRS",$J,A,B,C,X)) Q:'X  D
 . Q:$P(^TMP("SDRS",$J,A,B,C,X),U,2)]""   ;don't count test stops
 . S CNT=CNT+1
 Q CNT
 ;
CHKDV(SDEV) ;-- check to see if the original device got closed and if so reopen it
 N IOP
 I SDEV="" Q IO
 I IO=SDEV Q IO
 S IOP=SDEV D ^%ZIS
 Q IO
 ;
