TIUUTL ;ISP/RFR - UTILITIES ;Nov 09, 2018@09:45
 ;;1.0;TEXT INTEGRATION UTILITIES;**290**;Jun 20, 1997;Build 548
 Q
NOTIFY(TIUACT,ODFN,NDFN,TIU,TIUDA,TIUHOLD,OVISIT) ;NOTIFY SUBSCRIBING PACKAGES OF DOCUMENT ACTION
 S TIUACT=$G(TIUACT),ODFN=+$G(ODFN),NDFN=+$G(NDFN),TIUDA=+$G(TIUDA),TIUHOLD=+$G(TIUHOLD),OVISIT=+$G(OVISIT)
 I $D(^TMP("TIUDOCACT",$J)) G:TIUACT="SEND" NSEND G:TIUACT="CLEAR" NCLEAR
 I (TIUACT="")!(ODFN<1) Q
 I '$D(^DPT(ODFN)) Q
 I NDFN>0,'$D(^DPT(NDFN)) Q
 I TIUACT="REASSIGN",NDFN<1 Q
 I '$D(TIU) D GETTIU^TIULD(.TIU,TIUDA) Q:'$D(TIU)
 N TIUDIEN,TIUPNAME,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK,ZTSYNC,TIUNODE
 S TIUPNAME=$P($G(TIU("DOCTYP")),U,2)
 I TIUPNAME="",$D(^TIU(8925,TIUDA,0)) D
 .S TIUDIEN=+$P($G(^TIU(8925,TIUDA,0)),U)
 .I TIUDIEN>0 D
 ..S TIUPNAME=$P($G(^TIU(8925.1,TIUDIEN,0)),U,3)
 ..S:TIUPNAME="" TIUPNAME=$P($G(^TIU(8925.1,TIUDIEN,0)),U)
 I TIUACT'="REASSIGN" K ^TMP("TIUDOCACT",$J)
 S ^TMP("TIUDOCACT",$J,"ACTION")=TIUACT
 I TIUACT'="REASSIGN" D
 .S ^TMP("TIUDOCACT",$J,"PATIENT")=$G(ODFN)
 .S ^TMP("TIUDOCACT",$J,"VISIT")=$S($P($G(TIU("VISIT")),U)>0:$P(TIU("VISIT"),U),1:$P($G(^TIU(8925,TIUDA,0)),U,3))
 .S ^TMP("TIUDOCACT",$J,"DOCUMENT")=TIUDA_U_$G(TIUPNAME)
 I TIUACT="REASSIGN" D
 .N TIUOPAT,TIUOVSTR,TIUNVIEN,TIUODOC
 .S TIUOPAT=$G(^TMP("TIUDOCACT",$J,"PATIENT"))
 .K ^TMP("TIUDOCACT",$J,"PATIENT")
 .S ^TMP("TIUDOCACT",$J,"PATIENT","OLD")=$S(TIUOPAT'="":TIUOPAT,1:ODFN)
 .S ^TMP("TIUDOCACT",$J,"PATIENT","NEW")=$G(NDFN)
 .S TIUOVSTR=$G(^TMP("TIUDOCACT",$J,"VISIT"))
 .K ^TMP("TIUDOCACT",$J,"VISIT")
 .S ^TMP("TIUDOCACT",$J,"VISIT","OLD")=$S(TIUOVSTR'="":TIUOVSTR,1:OVISIT)
 .S TIUNVIEN=$P($G(^TIU(8925,TIUDA,0)),U,3)
 .S ^TMP("TIUDOCACT",$J,"VISIT","NEW")=$S($P($G(TIU("VISIT")),U)>0:$P(TIU("VISIT"),U),1:TIUNVIEN)
 .S TIUODOC=$G(^TMP("TIUDOCACT",$J,"DOCUMENT"))
 .K ^TMP("TIUDOCACT",$J,"DOCUMENT")
 .S ^TMP("TIUDOCACT",$J,"DOCUMENT","OLD")=TIUODOC
 .S ^TMP("TIUDOCACT",$J,"DOCUMENT","NEW")=TIUDA_U_$G(TIUPNAME)
 Q:TIUHOLD
 N TIUDFN,TIUVSIT,TIUAPMDA
 S TIUDFN=$S($G(^TMP("TIUDOCACT",$J,"PATIENT"))'="":^TMP("TIUDOCACT",$J,"PATIENT"),$G(^TMP("TIUDOCACT",$J,"PATIENT","OLD"))'="":^TMP("TIUDOCACT",$J,"PATIENT","OLD"),1:"")
 S TIUVSIT=$S($G(^TMP("TIUDOCACT",$J,"VISIT"))'="":^TMP("TIUDOCACT",$J,"VISIT"),$G(^TMP("TIUDOCACT",$J,"VISIT","OLD"))'="":^TMP("TIUDOCACT",$J,"VISIT","OLD"),1:"")
 S TIUAPMDA=$S($G(^TMP("TIUDOCACT",$J,"DOCUMENT"))'="":^TMP("TIUDOCACT",$J,"DOCUMENT"),$G(^TMP("TIUDOCACT",$J,"DOCUMENT","OLD"))'="":^TMP("TIUDOCACT",$J,"DOCUMENT","OLD"),1:"")
 D ANPKGMSG(TIUDFN,TIUVSIT,TIUAPMDA,TIUACT)
 S TIUNODE=$$NOW^XLFDT_";"_$J
 S ^XTMP("TIUDOCACT",0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"TIU DOCUMENT ACTION NOTIFIER DATA"
 M ^XTMP("TIUDOCACT",TIUNODE)=^TMP("TIUDOCACT",$J)
 S ZTRTN="NOTIFYDQ^TIUUTL"
 S ZTDESC="TIU DOCUMENT ACTION NOTIFIER",ZTDTH=$$NOW^XLFDT
 S (ZTSAVE("TIUNODE"),ZTSAVE("TIUDA"))="",ZTIO="TIU ACTIONS RESOURCE",ZTSYNC="TIUDAN"
 D ^%ZTLOAD
 D NCLEAR
 I '$D(ZTSK) D @ZTRTN
 Q
NOTIFYDQ ;TASKMAN ENTRY POINT
 I $G(^XTMP("TIUDOCACT",TIUNODE,"ACTION"))="REASSIGN",$G(^XTMP("TIUDOCACT",TIUNODE,"VISIT","NEW"))<1 D
 .N TIUNVSIT,TIUCNT
 .;WAIT FOR PCE FILER IN TIUPXAP1 TO FINISH
 .F TIUCNT=1:1 D  Q:$G(TIUNVSIT)>0!($G(ZTSTOP))
 ..I TIUCNT#2,$$S^%ZTLOAD S ZTSTOP=$$S^%ZTLOAD("Received shutdown request") Q:ZTSTOP
 ..S TIUNVSIT=+$P($G(^TIU(8925,TIUDA,0)),U,3)
 ..I TIUNVSIT<1 H 5
 .Q:$G(ZTSTOP)
 .S ^XTMP("TIUDOCACT",TIUNODE,"VISIT","NEW")=$G(TIUNVSIT)
 Q:$G(ZTSTOP)
 K TIUDA
NSEND ;SEND THE NOTIFICATION
 I $G(TIUNODE)'="" D
 .M ^TMP("TIUDOCACT",$J)=^XTMP("TIUDOCACT",TIUNODE)
 .K ^XTMP("TIUDOCACT",TIUNODE),TIUNODE
 .I $O(^XTMP("TIUDOCACT",0))="" K ^XTMP("TIUDOCACT")
 N DIC,X
 S DIC=101,X="TIU DOCUMENT ACTION EVENT"
 D EN^XQOR
 I $D(ZTQUEUED) K ZTSTAT S ZTREQ="@"
NCLEAR ;CLEAR DATA
 K ^TMP("TIUDOCACT",$J)
 Q
ANPKGMSG(TIUDFN,TIUVSIT,TIUDOC,TIUACT) ;RETRIEVE ANCILLARY PACKAGES' MESSAGE(S)
 N DIC,X
 K ^TMP("TIUDOCDIS",$J)
 S ^TMP("TIUDOCDIS",$J,"PATIENT")=TIUDFN
 S ^TMP("TIUDOCDIS",$J,"VISIT")=TIUVSIT
 S ^TMP("TIUDOCDIS",$J,"DOCUMENT")=TIUDOC
 S ^TMP("TIUDOCDIS",$J,"ACTION")=TIUACT
 S DIC=101,X="TIU DOCUMENT ACTION DISPLAY"
 D EN^XQOR
 I '$$BROKER^XWBLIB D
 .N TIULCNT,TIUCNTNU,TIUAPKG,TIULINE
 .S TIULCNT=0,TIUAPKG="" F  S TIUAPKG=$O(^TMP("TIUDOCDIS",$J,"MESSAGES",TIUAPKG)) Q:TIUAPKG=""  D
 ..Q:'$G(^TMP("TIUDOCDIS",$J,"MESSAGES",TIUAPKG))
 ..I TIULCNT=0!((TIULCNT+$G(^TMP("TIUDOCDIS",$J,"MESSAGES",TIUAPKG))+1)>22) W ! S TIUCNTNU=$$READ^TIUU("EA","Press RETURN to continue..."),TIULCNT=0
 ..W !,TIUAPKG_":" S TIULCNT=TIULCNT+1
 ..S TIULINE=0 F  S TIULINE=$O(^TMP("TIUDOCDIS",$J,"MESSAGES",TIUAPKG,TIULINE)) Q:'+TIULINE  D
 ...W !,$G(^TMP("TIUDOCDIS",$J,"MESSAGES",TIUAPKG,TIULINE)) S TIULCNT=TIULCNT+1
 ...I TIULCNT=22 W ! S TIUCNTNU=$$READ^TIUU("EA","Press RETURN to continue..."),TIULCNT=0
 ..W ! S TIULCNT=TIULCNT+1
 .K ^TMP("TIUDOCDIS",$J)
 Q
