MBAAAPI1 ;OIT-PD/VSL - SCHEDULING CONSULT API ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1**;Feb 10, 2016;Build 85
 ;
 ;Associated ICRs
 ;  ICR#
 ;
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;GETAPCNS(RETURN,DFN,STPCOD) ; Get active/pending consult requests
 ;N LST,FLDS,SVS,LST,TT,X1,X2
 ;S RETURN=0
 ;S FLDS(.01)="DATE",FLDS(.02)="PATIENT",FLDS(.04)="CLINIC",FLDS(.1)="TEXT"
 ;S FLDS(8)="STATUS",FLDS(1)="SERVICE",FLDS(10)="SENDER",FLDS(13)="TYPE"
 ;I STPCOD="" Q 0
 ;D GETCONSR^MBAADAL1(.LST,.DFN,.FLDS)
 ;N A,CPRSTAT,DTENTR,DTLMT,NOS,NOSHOW
 ;K TMP S NOSHOW="no-show",X1=DT,X2=-365 D C^%DTC S DTLMT=X
 ;S A=":"
 ;F  S A=$O(LST(A),-1) Q:'+A  D
 ;. D GETRQSV^MBAADAL1(.SVS,STPCOD,+LST(A,1)) Q:'+SVS("DILIST",0)
 ;. S DTENTR=$P(LST(A,.01),U) I DTENTR<DTLMT Q
 ;. S CPRSTAT=$P(LST(A,8),U) Q:$S(CPRSTAT=5!(CPRSTAT=6)!(CPRSTAT=8)!(CPRSTAT=13):0,1:1)
 ;. S PTIEN=$P(LST(A,.02),U)
 ;. I CPRSTAT=8 S STOP=0 D  Q:STOP
 ;. . I $$CONSLNKD^MBAADAL1(A) S STOP=1 Q
 ;. . S NOS=$O(LST(A,40,":"),-1) I '+NOS S STOP=1 Q
 ;. . S X2=LST(A,40,NOS,.01),X1=DT D ^%DTC I X'=""&(X>180) S STOP=1 Q
 ;. . D SCHED(PTIEN,STPCOD,.SHOW) I 'SHOW S STOP=1 Q
 ;. . ;CPRSTAT 13 is a cancel
 ;. I CPRSTAT=13 S NOS=$O(LST(A,40,":"),-1) Q:'+NOS  D
 ;. . S NOS=$O(LST(A,40,NOS),-1) I '+NOS S STOP=1 Q
 ;. . S X2=$P(LST(A,40,NOS,.01),U),X1=DT D ^%DTC I X'=""&(X>180) S STOP=1 Q
 ;. . S COMMENT=$G(LST(A,40,NOS,5,1)) I COMMENT'[NOSHOW S STOP=1 Q
 ;. M TT(A)=LST(A) D BLDCONS(.TT,.RETURN,.FLDS)
 ;S RETURN=1
 ;Q 1
 ;
 ;SCHED(PTIEN,STPCOD,SHOW) ;===CONSULT IS SCHEDULE NOW CHECK IF IT HAS APPOINTMENT BY STOP CODE.
 ;N APT,APTS,SD,STOP,CLNC,CLN,STOPCOD
 ;S %DT="ST",X="T-1" D ^%DT
 ;S SD=Y,SD(0)=1,STOP=0,APT="",SHOW=1
 ;D GETAPTS^MBAAMDA2(.APTS,PTIEN,.SD)
 ;F  S APT=$O(APTS("APT",APT)) Q:'+APT!(STOP)  D
 ;. S CLNC=$P(APTS("APT",APT,"CLINIC"),U)
 ;. Q:CLNC=""
 ;. D GETCLN^MBAAMDA1(.CLN,CLNC,1)
 ;. S STOPCOD=$G(CLN(8)) Q:STOPCOD=""
 ;. I STOPCOD'=STPCOD S SHOW=1 Q
 ;. D GETCAPT^MBAAMDA4(.CAPT,PTIEN,APT)
 ;. I $D(CAPT) S SHOW=0,STOP=1
 ;Q
 ;
 ;BLDCONS(CIN,COUT,FLDS) ; Build consult list
 ;N FLD,NO
 ;N IN S IN=0
 ;F  S IN=$O(CIN(IN)) Q:'IN  D
 ;. F FLD=0:0 S FLD=$O(FLDS(FLD)) Q:'FLD  S COUT(IN,FLDS(FLD))=CIN(IN,FLD)
 ;. F NO=0:0 S NO=$O(CIN(IN,40,NO)) Q:'NO  D
 ;. . S COUT(IN,"ACT",NO,"DATE")=CIN(IN,40,NO,.01)
 ;Q
 ;
CANCEL(RETURN,CONS,SC,SD,IFN,RMK,WHO,ADM,AUTO,CNDIE,CNDA) ; appt was cancelled then mark consult as edit/resubmit, add comment. Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT
 N CAPT,CNS,CLN,BY,CONSULT,SDPATNT,COMMENT,USER
 S:$D(CONS) CONSULT=CONS
 S RETURN=0
 D GETCAPT^MBAAMDA1(.CAPT,SC,SD,IFN,"I")
 I '$D(CONS) S CONSULT=$G(CAPT(688,"I"))
 Q:'+CONSULT 0
 S SDPATNT=$G(CAPT(.01,"I"))
 D GETCONS^MBAADAL1(.CNS,CONSULT,"IE")
 S CPRSSTAT=$G(CNS(8,"E")) I CPRSSTAT'="" Q:CPRSSTAT'="SCHEDULED"
 S SNDPRV=$G(CNS(10,"I"))
 S USER=$G(CNS(10,"E")),Y=SD
 D DD^%DT S APPT=$E(SD,4,5)_"/"_$E(SD,6,7)_"/"_$E(SD,2,3)_" @ "_$P(Y,"@",2)
 D GETCLN^MBAAMDA1(.CLN,SC,1,1)
 S BY=$S($D(WHO):$S(WHO["P":" by the Patient.",WHO["C":" by the Clinic.",1:"."),$D(ADM):" for administrative purposes.",1:", whole clinic.")
 S COMMENT(1)=$P(CLN(.01),U)_" Appt. on "_APPT_" was cancelled"_BY
 S:$D(RMK) COMMENT(2)="Remarks: "_RMK
 ;Code removed from initial release of SCV. will be included in next release of SCV.
 N SDERR S SDERR=$$STATUS^GMRCGUIS(CONSULT,6,3,SNDPRV,"","",.COMMENT)  ;ICR#: 4854 updates the status of a consult
 S CNDIE="^GMR(123,"_CONS_",40,",CNDA=+$G(COMMENT(0))
 S AUTO(SC,SD,SDPATNT)=CONS
 N FLDS S FLDS(688)="@"
 D UPDCAPT^MBAAMDA4(.FLDS,SC,SD,IFN)
 ;Code removed from initial release of SCV. will be included in next release of SCV.
 ;D STATUS^GMRCGUIS(.FLDS,SC,SD,IFN)  ;ICR#: 4854 updates the status of a consult
 K APPT,CPRSSTAT,SNDPRV,COMMENT,Y,USER
 S RETURN=1
 Q 1
 ;
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;AUTOREB(RETURN,SC,SD,LNK,CIFN) ; Auto rebook
 ;N FLDS,Y,TME,CLN,CNS,SNDPRV,CSCHDT,COMMENT,ER
 ;N FLDS S FLDS(688)=LNK
 ;S RETURN=0
 ;D UPDCAPT^MBAAMDA4(.FLDS,SC,SD,CIFN)
 ;S Y=SD D DD^%DT S TME=$P(Y,"@",2)
 ;D GETCLN^MBAAMDA1(.CLN,SC,1,1)
 ;S COMMENT(1)=$P(CLN(.01),U)_" Consult Appt. on "_$E(SD,4,5)_"/"_$E(SD,6,7)_"/"_$E(SD,2,3)_" @ "_TME_" (Auto Rebooked)."
 ;S %DT="ST",X="NOW" D ^%DT S CSCHDT=Y
 ;D GETCONS^MBAADAL1(.CNS,LNK,"IE")
 ;S SNDPRV=$G(CNS(10,"I"))
 ;D SCH^SDQQCN2(.ER,LNK,SNDPRV,CSCHDT,0,,.COMMENT) K COMMENT
 ;S RETURN=1
 ;Q 1
 ;
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;NOSHOW(RETURN,SC,SD,DFN,CONS,CN,AUTO,NSDIE,NSDA) ;
 ;Appt. was a NoShow, then mark Consult as Edit/Resubmit, add comment using silent call to notify user.
 ;Variables NSDIE and NSDA used in calling routine for NoShow letter printed comment in consult.
 ;N CNS,CLN,SRV,CPRSSTAT,SNDPRV,NOSHOW,CSPRT,USER,APPT,COMMENT
 ;S RETURN=0
 ;D GETCONS^MBAADAL1(.CNS,CONS,"IE")
 ;S CPRSSTAT=$G(CNS(8,"E")),SNDPRV=$G(CNS(10,"I"))
 ;S NOSHOW="no-show",AUTO(SC,SD,DFN)=CONS
 ;I CPRSSTAT'="" Q:CPRSSTAT'="SCHEDULED" 0
 ;D GETRQSV1^MBAADAL1(.SRV,$G(CNS(1,"I")),"123.09","IE")
 ;S:SRV(123.09,"E")'="" CSPRT=$G(SRV(123.09,"E"))
 ;S USER=$G(CNS(10,"E")),Y=SD
 ;D DD^%DT S APPT=$E(SD,4,5)_"/"_$E(SD,6,7)_"/"_$E(SD,2,3)_" @ "_$P(Y,"@",2)
 ;D GETCLN^MBAAMDA1(.CLN,SC,1,1)
 ;S COMMENT(1)=$P(CLN(.01),U)_" Appt. on "_APPT_" was a "_NOSHOW_"." ;no-show is a key word used by a search do not change
 ;N SDERR S SDERR=$$STATUS^GMRCGUIS(CONS,6,3,SNDPRV,"","",.COMMENT)
 ;S NSDIE="^GMR(123,"_CONS_",40,",NSDA=+$G(COMMENT(0))
 ;N FLDS S FLDS(688)="@"
 ;D UPDCAPT^MBAAMDA4(.FLDS,SC,SD,CN)
 ;I $D(CSPRT) D EN^GMRCP5(CONS,"C",CSPRT)
 ;S RETURN=1
 ;Q 1
 ;
EDITCS(RETURN,CONS,SD,RMK,CLNC) ;Mark consult as scheduled Called by RPC MBAA APPOINTMENT MAKE
 N CSCHDT,SNDPRV,TME,X,Y,COMMENT,ER,CNS
 S RETURN=0
 S %DT="ST",X="NOW" D ^%DT S CSCHDT=Y K %DT
 D GETCONS^MBAADAL1(.CNS,CONS,"IE")
 S SNDPRV=$G(CNS(10,"I")),Y=SD
 D DD^%DT S TME=$P($P(Y,"@",2),":",1,2)
 S COMMENT(1)=$P(CLNC,U,2)_" Consult Appt. on "_$E(SD,4,5)_"/"_$E(SD,6,7)_"/"_$E(SD,2,3)_" @ "_TME
 S COMMENT(2)=RMK
 D SCH^SDQQCN2(.ER,CONS,SNDPRV,CSCHDT,0,,.COMMENT) K COMMENT  ;ICR#: 6050 MBAA SDQQCN2 API
 S RETURN=1
 Q 1
 ;
