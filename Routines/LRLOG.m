LRLOG ;SLC/STAFF - Edit Log ;10/15/03  09:08
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
 ;
TIMESTMP(PAT,SUB,CDT,USER,TIMESTMP) ; set a timestamp entry in edit log
 ; from LRPX,LRPXRM
 ;N DATA,NUM
 ;S PAT=+$G(PAT)
 ;S SUB=$G(SUB)
 ;S CDT=$G(CDT)
 ;Q:'PAT  Q:'$L(SUB)  Q:'CDT
 ;I '$G(TIMESTMP) S TIMESTMP=$$NOW^XLFDT
 ;S USER=$G(USER)
 ;S NUM=+$P(^LRLOG(0),U,3)
 ;S DATA=TIMESTMP_U_PAT_U_SUB_U_CDT_U_USER
 ;L +^LRLOG(0):20 I '$T Q
 ;S NUM=1+$P(^LRLOG(0),U,3)
 ;F  Q:'$D(^LRLOG(NUM))  S NUM=NUM+1
 ;S $P(^LRLOG(0),U,3)=NUM,$P(^(0),U,4)=$P(^(0),U,4)+1
 ;S ^LRLOG(NUM)=DATA
 ;L -^LRLOG(0)
 ;S ^LRLOG("B",TIMESTMP,NUM)=""
 ;S ^LRLOG("P",PAT,TIMESTMP,NUM)=""
 Q
 ;
INIT ; initialize setup of edit log
 ; sets last edit as timestamp on old data
 ; does not set user
 ;N CDT,DATA,DFN,I,IDT,LRDFN,RELEASE,SUB,TIMESTMP
 ;S I=0 F  S I=$O(^LRLOG(I)) Q:I=""  K ^LRLOG(I)
 ;S $P(^LRLOG(0),U,3,4)="0^0"
 ;S LRDFN=.9
 ;F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  D
 ;. S DFN=$$DFN^LRPXAPIU(LRDFN)
 ;. I 'DFN Q
 ;. S SUB="CH"
 ;. S IDT=0
 ;. F  S IDT=$O(^LR(LRDFN,SUB,IDT)) Q:IDT<1  D
 ;.. S DATA=$G(^LR(LRDFN,SUB,IDT,0))
 ;.. I '$L(DATA) Q
 ;.. S TIMESTMP=+$P(DATA,U,3)
 ;.. I 'TIMESTMP Q
 ;.. S CDT=+DATA
 ;.. I 'CDT Q
 ;.. D TIMESTMP(DFN,SUB,CDT,,TIMESTMP)
 ;. S SUB="MI"
 ;. S IDT=0
 ;. F  S IDT=$O(^LR(LRDFN,SUB,IDT)) Q:IDT<1  D
 ;.. S DATA=$G(^LR(LRDFN,SUB,IDT,0))
 ;.. I '$L(DATA) Q
 ;.. S CDT=+DATA
 ;.. I 'CDT Q
 ;.. S TIMESTMP=+$P(DATA,U,3)
 ;.. F I=1,5,8,11,16 I $G(^LR(LRDFN,SUB,IDT,I))>TIMESTMP S TIMESTMP=+^(I)
 ;.. I 'TIMESTMP Q
 ;.. D TIMESTMP(DFN,SUB,CDT,,TIMESTMP)
 ;. F SUB="CY","EM","SP" D
 ;.. S IDT=0
 ;.. F  S IDT=$O(^LR(LRDFN,SUB,IDT)) Q:IDT<1  D
 ;... S DATA=$G(^LR(LRDFN,SUB,IDT,0))
 ;... I '$L(DATA) Q
 ;... S TIMESTMP=+$P(DATA,U,3)
 ;... I 'TIMESTMP Q
 ;... S RELEASE=+$P(DATA,U,11)
 ;... I 'RELEASE Q
 ;... I RELEASE>TIMESTMP S TIMESTMP=RELEASE
 ;... S CDT=+DATA
 ;... I 'CDT Q
 ;... D TIMESTMP(DFN,SUB,CDT,,TIMESTMP)
 ;. S SUB="AU"
 ;. S DATA=$G(^LR(LRDFN,SUB))
 ;. I 'DATA Q
 ;. S TIMESTMP=+$P(DATA,U,3)
 ;. I 'TIMESTMP Q
 ;. S RELEASE=+$P(DATA,U,15)
 ;. I 'RELEASE Q
 ;. I RELEASE>TIMESTMP S TIMESTMP=RELEASE
 ;. S CDT=$$DOD^LRPXAPIU(DFN)
 ;. I 'CDT Q
 ;. D TIMESTMP(DFN,SUB,CDT,,TIMESTMP)
 Q
 ;
DATEINTG(DATE1,DATE2,CNT) ; check integrity on patient's that were edited during a time range
 ; returns ^TMP("LRLOG",$J),^TMP("LRLOG PATS",$J) - must kill after use
 ;N DFN,NUMBER
 ;S DATE1=+$G(DATE1,1),DATE2=+$G(DATE2,9999999)
 ;D PATS(DATE1,DATE2,.CNT)
 ;I 'CNT S ^TMP("LRLOG",$J)="0^0" Q
 ;S (CNT,DFN,NUMBER)=0
 ;F  S DFN=$O(^TMP("LRLOG PATS",$J,DFN)) Q:DFN<1  D
 ;. D PATINTEG(DFN,.CNT)
 ;. S NUMBER=NUMBER+1
 ;S ^TMP("LRLOG",$J)=CNT_U_NUMBER
 Q
 ;
PATS(DATE1,DATE2,CNT) ; get patients that were edited during a time range
 ; returns ^TMP("LRLOG PATS",$J) - must kill after use
 ;N BEGCDT,CDT,DATA,DFN,ENDCDT,NUM,TSDT
 ;K ^TMP("LRLOG PATS",$J)
 ;S BEGCDT=9999999,(CNT,ENDCDT)=0
 ;S TSDT=$G(DATE1)-.00001
 ;F  S TSDT=$O(^LRLOG("B",TSDT)) Q:TSDT<1  Q:TSDT>DATE2  D
 ;. S NUM=0
 ;. F  S NUM=$O(^LRLOG("B",TSDT,NUM)) Q:NUM<1  D
 ;.. S DATA=$G(^LRLOG(NUM))
 ;.. S DFN=+$P(DATA,U,2)
 ;.. S CDT=+$P(DATA,U,4)
 ;.. I CDT<BEGCDT S BEGCDT=CDT
 ;.. I CDT>ENDCDT S ENDCDT=CDT
 ;.. Q:'DFN  Q:'CDT
 ;.. I '$D(^TMP("LRLOG PATS",$J,DFN)) S CNT=CNT+1
 ;.. S ^TMP("LRLOG PATS",$J,DFN)=BEGCDT_U_ENDCDT
 ;.. S ^TMP("LRLOG PATS",$J,DFN,NUM)=""
 ;S ^TMP("LRLOG PATS",$J)=CNT
 Q
 ;
PATINTEG(DFN,CNT) ; check integrity of a patient
 ; returns ^TMP("LRLOG",$J) - must kill after use
 ;K ^TMP("LRLOG",$J,DFN)
 ;S CNT=+$G(CNT)
 ;D CHKPAT^LRPXCHK(DFN)
 ;I $D(^TMP("LRLOG",$J,DFN)) S CNT=CNT+1
 Q
 ;
TESTP ; test for patient integrity
 ;N DIC,X,Y K DIC
 ;S DIC=2,DIC(0)="AEMOQ"
 ;D ^DIC I Y<1 Q
 ;D PATINTEG(+Y)
 ;K ^TMP("LRLOG",$J)
 Q
 ;
TESTD ; test for integrity of patients that were edited during a date range
 ;N CNT,DFN,ERR,FROM,TO
 ;D GETDATE^LRPXAPPU(.FROM,.TO,.ERR) I ERR Q
 ;S CNT=0
 ;D DATEINTG(FROM,TO,.CNT)
 ;S DFN=0
 ;F  S DFN=$O(^TMP("LRLOG PATS",$J,DFN)) Q:DFN<.5  W !,DFN," ",$P(^DPT(DFN,0),U)," checked"
 ;K ^TMP("LRLOG",$J),^TMP("LRLOG PATS",$J)
 Q
 ;
LTS() ; $$() -> last timestamp ien
 ;N TSDT
 ;S TSDT=+$O(^LRLOG("B",""),-1)
 ;Q +$O(^LRLOG("B",TSDT,0))
 Q 0 ;remove after testing
 ;
LPTS(DFN) ; $$(dfn) -> patient's last timestamp ien
 ;N TSDT
 ;S DFN=+$G(DFN)
 ;S TSDT=+$O(^LRLOG("P",DFN,""),-1)
 ;Q +$O(^LRLOG("P",DFN,TSDT,0))
 Q 0 ;remove after testing
 ;
TSDT(TSDT,TS) ; API - returns array of timestamps for a timestamp date/time
 ;N NUM K TS
 ;S TSDT=+$G(TSDT)
 ;S NUM=0
 ;F  S NUM=$O(^LRLOG("B",TSDT,NUM)) Q:NUM<1  S TS(NUM)=""
 Q
 ;
PTSDT(DFN,TSDT,TS) ; API - returns patient's array of timestamps for a timestamp date/time
 ;N NUM K TS
 ;S DFN=+$G(DFN),TSDT=+$G(TSDT)
 ;S NUM=0
 ;F  S NUM=$O(^LRLOG("P",DFN,TSDT,NUM)) Q:NUM<1  S TS(NUM)=""
 Q
 ;
NTSDT(TSDT) ; $$(timestamp date/time) -> next timestamp ien from a timestamp date/time
 ;S TSDT=+$G(TSDT)
 ;Q +$O(^LRLOG("B",TSDT),-1)
 Q 0 ;remove after testing
 ;
NPTSDT(DFN,TSDT) ; $$(dfn,timestamp date/time) -> patient's next timestamp date/time
 ;S DFN=+$G(DFN),TSDT=+$G(TSDT)
 ;Q +$O(^LRLOG("P",DFN,TSDT),-1)
 Q 0 ;remove after testing
 ;
LOG(TS) ; $$(timestamp ien) -> timestamp entry: timestamp^dfn^sub^cdt^user
 ;Q $G(^LRLOG(+$G(TS)))
 Q 0 ;remove after testing
 ;
