SCMCTSK9 ;;BP/DMR - PCMM ; 18 Apr 2003  9:36 AM
 ;;5.3;Scheduling;**297,526**;AUG 13, 1993;Build 8
 Q
EXTKEY ;
 N Y,% W @IOF,!,$G(SCDHD) D NOW^%DTC S Y=% W:$X>(IOM-40) ! W ?(IOM-40)
 W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12)
 W ?(IOM-15),"PAGE: "_($G(DC)+1)
 S Y="",$P(Y,"-",IOM)="" W !,Y,!!
 W !,"Column Heading        Explanation of column headings"
 W !
 W !,"Patient Name          Name of patient scheduled to be inactivated from their primary care team and position/provider."
 W !,"SSN                   SSN number."
 W !,"Institution           Institution name, previously called Division, in which patient receives primary care."
 W !,"PC Team               The patient's assigned Primary Care team in PCMM."
 W !,"Provider/             Name of Associate Primary Care Provider (AP) assigned to patient, if there is one."
 W !," Team Position        The name of the team position to which the Associate Primary Care Provider (AP) is assigned."
 W !,"Current Preceptor/    Name of Primary Care Provider (PCP) assigned to patient.  Every Primary Care patient should"
 W !," Team Position        be assigned to one PCP. The name of the team position to which the Primary Care Provider (PCP)"
 W !,"                      is assigned."
 W !,"Date Scheduled for    Date patient will be inactivated from PCMM and their Primary Care team and provider/position unless"
 W !," Inactivation         they have a completed outpatient appointment encounter with their current PCP or AP before this date."
 W !,"                      Note: There is a patient reassignment option, which allows an inactivated patient to be reactivated"
 W !,"                      to their previous Primary Care team and position if they return for care."
 W !,"Reason for Extended   The reason entered for extending the patient's time before inactivation from PC panels."
 W !," Inactivation         Entry of this field is in the PCMM GUI, Patient drop down menu, and the Extend Patient's Date for"
 W !,"                      Inactivation from PC Panels option."
 Q
EXTCHUI ;roll n scroll option to extend a patient
 N DA,DIC,DIE,DR,SCTM,SCARRAY,SCHIGH,SCX,V1
 S SCTM=0 F  D P1 Q:+SCTM<1
 Q
P1 D GCL S DIC="^SCTM(404.51,",DIC(0)="AEQMZ" D ^DIC S SCTM=+Y Q:+SCTM<1
 W !,"Searching...",!
 D EXTEND(.SCARRAY,SCTM)
 I $G(^TMP("SCMCTSK9","OUT",$J,1))="<DATA>" W !,"No Patients to Extend..." D GCL Q
 S SCHIGH=$O(^TMP("SCMCTSK9","OUT",$J,9999999),-1)
 S SCX=999 F  Q:(SCX="^")!(SCX="")  D P2
 Q
P2 W !,"Select From:  ",!!
 S V1=0 F  S V1=$O(^TMP("SCMCTSK9","OUT",$J,V1)) Q:'V1  D
 . W $J(V1,2)_" ",$P(^TMP("SCMCTSK9","OUT",$J,V1),U,3),!
 F  W !,"Select 1-",SCHIGH," " R SCX:DTIME Q:(SCX="^")!(SCX="")!((SCX'>SCHIGH)&(SCX>0))  D
 . I $E(SCX,1)="?" W !,"Select 1-",SCHIGH," or '^' to exit" Q
 . I (+SCX<1)!(+SCX>SCHIGH) W !,"Select a valid number" Q
 I SCX'?1.9N Q
 S DIE="^SCPT(404.43,"
 S DA=$P(^TMP("SCMCTSK9","OUT",$J,SCX),U)
 S DR=".13//DO NOT EXTEND;S Y=.16 I X=4 S Y=.14;.14;.16////"_DUZ
 D ^DIE
 Q
EXTEND(DATA,SCTEAM) ;return list of patients to inactivate in next 60 days
 ;IEN^POSITION^PATIENT^EXTENDED^REASON
 K DATA,SCDATA,SDDATA
 N CNT,I,J,K,A,POSA S CNT=1 S SCTEAM=$G(SCTEAM),^TMP("SCMCTSK9","OUT",$J,1)="<DATA>"
 D DT^DICRW S X="T-9M" D ^%DT S STDT=Y
 S X="T-21M" D ^%DT S TYDT=+Y  ;MAKE THIS 21
 S POSA=""
 F  S POSA=$O(^SCTM(404.57,"ATMPOS",+SCTEAM,POSA)) Q:POSA=""  D
 .F POS=0:0 S POS=$O(^SCTM(404.57,"ATMPOS",+SCTEAM,POSA,POS)) Q:'POS  D POS
EX1 S A="^TMP(""SCMCTSK9"",$J)",CNT=1 F  S A=$Q(@A) Q:A=""!($P(A,",",2)'=$J)  D
 .S B=@A
 .S ^TMP("SCMCTSK9","OUT",$J,CNT)=(+$P(B,U,3))_U_$TR($P($P(A,"(",4),","),$C(34))_U_$TR($P(B,U,2),$C(34))_U_$P($G(^SCPT(404.43,+$P(B,U,3),0)),U,13)_U_$P($G(^SCPT(404.43,+$P(B,U,3),0)),U,14)
 .S CNT=CNT+1
 Q
POS I '$$DATES^SCAPMCU1(404.59,POS) Q   ;Not an active position
 I '$P($G(^SCTM(404.57,POS,0)),U,4) Q  ;Not PC
 ;get patients for this position
 K ^TMP("SC TMP LIST",$J)
 S X=$$PTTP^SCAPMC(POS,"",.SCLIST,.SCERR)
 S J=0 F  S J=$O(@SCLIST@(J)) Q:'J  S SCDATA=^(J) D
 .N J I $P(SCDATA,U,4)>STDT Q
 .I '$P($G(^SCPT(404.43,+$P(SCDATA,U,3),0)),U,5) Q
 .I '$P($G(^SCPT(404.43,+$P(SCDATA,U,3),0)),U,15) Q
 .S DFN=+SCDATA
 .D SEEN Q:SEEN
 .S ^TMP("SCMCTSK9",$J,$P($G(^SCTM(404.57,POS,0)),U),$P(SCDATA,U,2),+SCDATA)=SCDATA,CNT=CNT+1
 K @SCLIST
 Q
SEEN ;was patient seen
 S SEEN=0
 N SCPRO,I,PRECP,PRO
 N X,SCPRDTS,SCPR
 ;get list of providers for this position
 S PROV=+$$GETPRTP^SCAPMCU2(POS,DT) S SCPRO(+PROV)=""
 S SCPRDTS("BEGIN")=TYDT
 S SCPRDTS("END")=DT
 S X=$$PRTP^SCAPMC(POS,"SCPRDTS","SCPR")
 F I=0:0 S I=$O(SCPR(I)) Q:'I  S SCPRO(+SCPR(I))=""
 S PRECP=0 I $G(PREC),$G(PREC)'=POS S PRECP=+$$GETPRTP^SCAPMCU2(PREC,DT),SCPRO(+PRECP)=""
 F I=TYDT:0 S I=$O(^SCE("ADFN",DFN,I)) Q:'I  D  Q:SEEN
 .F J=0:0 S J=$O(^SCE("ADFN",DFN,I,J)) Q:'J  D  Q:SEEN
 ..N VISIT S VISIT=+$P($G(^SCE(J,0)),U,5) I $G(^SCE(J,0))<$G(TYDT) Q
 ..F PRO=0:0 S PRO=$O(SCPRO(PRO)) Q:'PRO  D  Q:SEEN
 ...I $D(^SDD(409.44,"AO",J,$G(PRO))) S SEEN=1 Q  ;GET THE PROVIDERJ
 ...N V F V=0:0 S V=$O(^AUPNVPRV("AD",VISIT,V)) Q:'V  I PRO=(+$G(^AUPNVPRV(V,0))) S SEEN=1 Q
 Q
GCL ;clean temp globals
 K ^TMP("SCMCTSK9",$J)
 K ^TMP("SCMCTSK9","OUT",$J)
 Q
