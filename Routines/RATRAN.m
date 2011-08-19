RATRAN ;HISC/FPT AISC/DMK-Transcriptionist Report ;8/14/97  11:08
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
 K ^TMP($J) S RATITLE="Transcriptionist",RAOUT=0
 W !!?10,">>> IMAGING TRANSCRIPTIONIST WORKLOAD REPORT <<<",!
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0) S RAPSTX=""
 I $O(RACCESS(DUZ,""))="" D ACCVIO^RAUTL19 Q
 D SELDIV^RAUTL7
 I '$D(^TMP($J,"RA D-TYPE"))!($G(RAQUIT)) D END Q
 S A="" F  S A=$O(^TMP($J,"RA D-TYPE",A)) Q:A=""  S ^TMP($J,"RATWKL",A)=""
 S RASW=$$ALLNOTH^RALWKL3()
 I RASW="" D END Q
 I RASW=0 D USER I '$D(^TMP($J,"RATRAN")) D END Q
 I RASW=0 S RAFLDCNT=0,RALP="" F  S RALP=$O(^TMP($J,"RATRAN",RALP)) Q:RALP=""  S RALP1="" F  S RALP1=$O(^TMP($J,"RATRAN",RALP,RALP1)) Q:RALP1'>0  S RAFLDCNT=RAFLDCNT+1
 K RALP,RALP1
 D DATE^RAUTL I RAPOP D END Q
 S RABEG=BEGDATE-.0001,RAEND=ENDDATE+.9999
 S ZTRTN="START^RATRAN",ZTDESC="Rad/Nuc Med TRANSCRIPT RPT",ZTSAVE("^TMP($J,""RATWKL"",")="",ZTSAVE("^TMP($J,""RATRAN"",")=""
 F RASV="RABEG","RAEND","RAFLDCNT","RASW" S ZTSAVE(RASV)=""
 D ZIS^RAUTL G END:RAPOP
 ;
START ; start processing
 U IO S:$D(ZTQUEUED) ZTREQ="@"
 S QQ="",$P(QQ,"=",80)="=",(LCNT,RAOUT,RAPG)=0
 S Y=RABEG+.0001 D D^RAUTL S RASTART=Y,Y=RAEND-.9999 D D^RAUTL S RAFINISH=Y
 ; all transcriptionists
 I RASW=1 S RADUZ=0 D
 .F  S RADUZ=$O(^RARPT("AD",RADUZ)) Q:RADUZ'>0  D  Q:RAOUT
 ..F I=RABEG:0 S I=$O(^RARPT("AD",RADUZ,I)) Q:I'>0!(I>RAEND)  D  Q:RAOUT
 ...F J=0:0 S J=$O(^RARPT("AD",RADUZ,I,J)) Q:J'>0!(RAOUT)  I $D(^RARPT(J,0)),$D(^("T")) D SET
 ...Q
 ..Q
 .Q
 ; selected transcriptionists
 I 'RASW S RATRAN="" D
 .F  S RATRAN=$O(^TMP($J,"RATRAN",RATRAN)) Q:RATRAN=""  S RADUZ=0 D  Q:RAOUT
 ..F  S RADUZ=$O(^TMP($J,"RATRAN",RATRAN,RADUZ)) Q:RADUZ'>0  I $D(^RARPT("AD",RADUZ)) D  Q:RAOUT
 ...F I=RABEG:0 S I=$O(^RARPT("AD",RADUZ,I)) Q:I'>0!(I>RAEND)  D  Q:RAOUT
 ....F J=0:0 S J=$O(^RARPT("AD",RADUZ,I,J)) Q:J'>0!(RAOUT)  I $D(^RARPT(J,0)),$D(^("T")) D SET
 ....Q
 ...Q
 ..Q
 .Q
 ;
GET ; get tmp global values
 S RADIV=""
 F  S RADIV=$O(^TMP($J,"RATWKL",RADIV)) Q:RAOUT!(RADIV="")  D HDR Q:RAOUT  D:+^TMP($J,"RATWKL",RADIV)=0 NEGRPT S I="" F  S I=$O(^TMP($J,"RADUZ",RADIV,I)) Q:RAOUT!(I="")  D  D:'RAOUT WRT
 .S RACNT=$P(^(I),"^"),RANAME=$P(I,"/",1),RATCNT=$P(^(I),"^",2)
 ;
END ; kill variables, close device
 K A,BEGDATE,ENDDATE,I,J,LCNT,QQ,RABEG,RACNT,RADFN,RADIV,RADIVNME,RADTI,RADUZ,RADUZNME,RAEND,RAFINISH,RAFLDCNT,RAI
 K RANAME,RAOUT,RAPG,RAPGM,RAPOP,RAQUIT,RARPTNDE,RASKIP,RASTART,RASV,RASW,RATCNT,RATITLE,RATRAN,X,Y,^TMP($J)
 K:$D(RAPSTX) RACCESS,RAPSTX
 D CLOSE^RAUTL
 K A,DIRUT,DUOUT,I,POP,RAMES,RAOUT,RAPOP,RAPSTX,RAQUIT,RASW,RATITLE,ZTDESC,ZTRTN,ZTSAVE
 Q
SET ; set tmp global
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1 Q:RAOUT
 S RADUZNME=$P($G(^VA(200,RADUZ,0)),U,1)
 I RADUZNME="" Q
 S RARPTNDE=$G(^RARPT(J,0)),RADFN=+$P(RARPTNDE,U,2),RADTI=9999999.9999-$P(RARPTNDE,U,3),RADTI=+RADTI
 I '$D(^RADPT(+RADFN,"DT",RADTI)) Q
 S RADIV=$P($G(^RADPT(+RADFN,"DT",RADTI,0)),U,3),RADIV=$P($G(^RA(79,+RADIV,0)),U,1),RADIVNME=$P($G(^DIC(4,+RADIV,0)),U,1)
 I RADIVNME="" Q
 I '$D(^TMP($J,"RATWKL",RADIVNME)) Q
 I 'RASW,'$D(^TMP($J,"RATRAN",RADUZNME,RADUZ)) Q
 S LCNT=+$$LCNT(J)
 S RADUZNME=RADUZNME_"/"_RADUZ
 I '$D(^TMP($J,"RADUZ",RADIVNME,RADUZNME)) S ^(RADUZNME)="0^0"
 S RADUZ(0)=^TMP($J,"RADUZ",RADIVNME,RADUZNME)
 S $P(RADUZ(0),"^")=$P(RADUZ(0),"^")+LCNT
 S $P(RADUZ(0),"^",2)=$P(RADUZ(0),"^",2)+1
 S ^TMP($J,"RADUZ",RADIVNME,RADUZNME)=RADUZ(0),^TMP($J,"RATWKL",RADIVNME)=^TMP($J,"RATWKL",RADIVNME)+1
 K RADUZ(0)
 Q
LCNT(J) ; Count lines in report text and impression text.  If the number of
 ; characters in either the report or impression text add up to a number
 ; greater than zero and less than seventy five, assume that we have
 ; seventy five characters.
 N K,LCNT S (LCNT,LCNT("I"),LCNT("R"))=0
 I $D(^RARPT(J,"I")) S K=0 F  S K=$O(^RARPT(J,"I",K)) Q:K=""  S LCNT("I")=$L(^RARPT(J,"I",K,0))+LCNT("I") ; count impression text chars
 S:LCNT("I")&(LCNT("I")<75) LCNT("I")=75
 I $D(^RARPT(J,"R")) S K=0 F  S K=$O(^RARPT(J,"R",K)) Q:K=""  S LCNT("R")=$L(^RARPT(J,"R",K,0))+LCNT("R") ; count report text characters
 S:LCNT("R")&(LCNT("R")<75) LCNT("R")=75
 ; the total number of lines equal the number of impression text chars
 ; plus the number of report text chars divided by seventy five.
 S LCNT=LCNT("I")+LCNT("R")
 S LCNT=$J(LCNT/75,0,0)
 Q LCNT
WRT ; write out counts
 I ($Y+4)>IOSL S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D:$O(^TMP($J,"RADUZ",RADIV,I))]"" HDR Q:RAOUT
 W !,RANAME,?50,RACNT,?67,RATCNT
 I $O(^TMP($J,"RATWKL",RADIV))]"",$O(^TMP($J,"RADUZ",RADIV,I))="" S RAOUT=$$EOS^RAUTL5
 Q
HDR ; header
 W:$Y>0 @IOF,!?21,">>> IMAGING TRANSCRIPTION REPORT <<<" S RAPG=RAPG+1 W ?70,"PAGE: ",RAPG
 W !?23,"Division: ",RADIV
 W !?21,"Date Range: ",RASTART," - ",RAFINISH
 W !,"# of Transcriptionists selected: ",$S($G(RAFLDCNT)>0:$G(RAFLDCNT),1:"ALL"),!
 W !,"RADIOLOGY/NUCLEAR MEDICINE PERSONNEL",?44,"NUMBER OF LINES",?61,"NUMBER OF REPORTS"
 W !,QQ,!
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1
 Q
USER ; select transcriptionists to appear in report
 S RADIC="^VA(200,",RADIC(0)="AEMQZ",RADIC("A")="Select "_RATITLE_": ",RADIC("S")="I $D(^VA(200,+Y,""RAC"")),$D(^RARPT(""AD"",+Y))",RAUTIL="RATRAN"
 D EN1^RASELCT(.RADIC,RAUTIL,"",RASW)
 K RADIC,RAUTIL
 Q
NEGRPT ; negative report message
 W !!,"In this division there were no reports found for the transcriptionists selected."
 I $O(^TMP($J,"RATWKL",RADIV))]"" S RAOUT=$$EOS^RAUTL5()
 Q
