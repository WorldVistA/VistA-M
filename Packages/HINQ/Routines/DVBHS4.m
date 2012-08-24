DVBHS4 ; ALB/JLU/PJH;Routine for HINQ screen 4 ; 9/26/11 4:33pm
 ;;4.0;HINQ;**4,49,62**;03/25/92;Build 17
 ;
 N Y
 K DVBX(1)
 F LP2=.323,.324,.328,.329,.3291,.3299 S X="DVBDIQ(2,"_DFN_","_LP2_")" K @X
 I $D(X(1)) S DVBX(1)=X(1)
 S DIC="^DPT(",DA=DFN,DIQ(0)="E",DIQ="DVBDIQ("
 S DR=".323;.324:.328;.329;.3291:.3299"
 D EN^DIQ1
 I $D(DVBX(1)) S X(1)=DVBX(1) K DVBX(1)
 ;
 S DVBSCRN=4 D SCRHD^DVBHUTIL
 S DVBJS=44
 W ?325,DVBON,"HINQ Data",DVBOFF
 W !,?5,"EOD",?17,"RAD",?27,"Bran. Ser.",?44,"Char. Ser.",?69,"Ser. Num."
 D LINE
 ;
 ;DVB*4*49 - all MS data should be in the BIRLS segment, so if second 
 ;node of all these arrays is populated, kill the first node
 I +$G(DVBEOD(2))>0 K DVBEOD(1)
 I +$G(DVBRAD(2))>0 K DVBRAD(1)
 I $G(DVBBOS(2))]"" K DVBBOS(1)
 I $G(DVBCSVC(2))]"" K DVBCSVC(1)
 I $G(DVBSN(2))]"" K DVBSN(1)
 W ! I $D(DVBEOD(1)),DVBEOD(1)?8N S M=$E(DVBEOD(1),1,2) D MM^DVBHQM11 W M," ",$E(DVBEOD(1),3,4),",",$E(DVBEOD(1),5,8)
 I $D(DVBRAD(1)),DVBRAD(1)?8N S M=$E(DVBRAD(1),1,2) D MM^DVBHQM11 W ?14,M," ",$E(DVBRAD(1),3,4),",",$E(DVBRAD(1),5,8)
 I $D(DVBBOS(1)) S Y=DVBBOS(1) D XBOS^DVBHQM12 S Y=$E(Y,1,16) W ?27,Y
 I $D(DVBCSVC(1)) S I=1,Y=DVBCSVC(1) D DISCHG^DVBHQM1 W ?44,Y K Y
 I $D(DVBSN(1)) W ?69,DVBSN(1)
 W ! I $D(DVBEOD(2)),DVBEOD(2)?7N S Y=DVBEOD(2) X ^DD("DD") W ?1,Y K Y
 I $D(DVBRAD(2)),DVBRAD(2)?7N S Y=DVBRAD(2) X ^DD("DD") W ?14,Y K Y
 I $D(DVBBOS(2)) S Y=DVBBOS(2) D XBOS^DVBHQM12 S Y=$E(Y,1,16) W ?27,Y
 I $D(DVBCSVC(2)) S Y=$$DISCH2^DVBHQM1(DVBCSVC(2)) W ?44,Y K Y
 I $D(DVBSN(2)) W ?69,DVBSN(2)
 W ! I $D(DVBEOD(3)),DVBEOD(3)?7N S Y=DVBEOD(3) X ^DD("DD") W ?1,Y K Y
 I $D(DVBRAD(3)),DVBRAD(3)?7N S Y=DVBRAD(3) X ^DD("DD") W ?14,Y K Y
 I $D(DVBBOS(3)) S Y=DVBBOS(3) D XBOS^DVBHQM12 S Y=$E(Y,1,16) W ?27,Y
 I $D(DVBCSVC(3)) S Y=$$DISCH2^DVBHQM1(DVBCSVC(3)) W ?44,Y K Y
 I $D(DVBSN(3)) W ?69,DVBSN(3)
 W ! I $D(DVBEOD(4)),DVBEOD(4)?7N S Y=DVBEOD(4) X ^DD("DD") W ?1,Y K Y
 I $D(DVBRAD(4)),DVBRAD(4)?7N S Y=DVBRAD(4) X ^DD("DD") W ?14,Y K Y
 I $D(DVBBOS(4)) S Y=DVBBOS(4) D XBOS^DVBHQM12 S Y=$E(Y,1,16) W ?27,Y
 I $D(DVBCSVC(4)) S Y=$$DISCH2^DVBHQM1(DVBCSVC(4)) W ?44,Y K Y
 I $D(DVBSN(4)) W ?69,DVBSN(4)
 I $D(DVBSCR) K DVBSCR D LINE W ! Q
 W !,?34,DVBON,"Patient File",DVBOFF
 D LINE,MSE(DFN)
 W !,DVBON,"(4)",DVBOFF X DVBLIT1
 W ?4,"Per. of Ser.:",?18,$E(DVBDIQ(2,DFN,.323,"E"),1,25)
 Q
LINE W !,"-------------------------------------------------------------------------------"
 Q
 ;
 ;APIs added for MSDS (DVB*4*62)
 ;------------------------------
 ;
MSE(DFN) ;Display episodes for [DVBHINQ PAT-HINQ COMP] template
 ;
 N ARRAY,MORE,SOURCE
 ;If no data exists in .3216 nodes display old data
 S MORE=0,SOURCE=.32 I $O(^DPT(DFN,.3216,"B",0)) S SOURCE=.3216
 ;
 ;Collect old data from .32
 I SOURCE=.32 D OLD(DFN,.ARRAY)
 ;Collect last three episodes from .3216 multiple
 I SOURCE=.3216 D NEW(DFN,.ARRAY)
 ;
 ;Display MSE data
 N BOS,COMP,DATA,DISCH,EODATE,IEN,RADATE,SERVN
 S CNT=0
 F  S CNT=$O(ARRAY(CNT)) Q:'CNT  D
 .S DATA=$G(ARRAY(CNT)) Q:DATA=""
 .S DISCH=$P(DATA,U,6) ;Discharge
 .S:DISCH]"" DISCH=$P($G(^DIC(25,DISCH,0)),U)
 .S BOS=$P(DATA,U,3) ;Branch
 .S:BOS]"" BOS=$P($G(^DIC(23,BOS,0)),U)
 .S RADATE=$P(DATA,U) ;Entry Date
 .S RADATE=$$FMTE^XLFDT(RADATE)
 .S EODATE=$P(DATA,U,2) ;Separation Date
 .S EODATE=$$FMTE^XLFDT(EODATE)
 .S SERVN=$P(DATA,U,5) ;Service Number
 .I SOURCE=.32 W !,DVBON,"("_CNT_")",DVBOFF
 .I SOURCE=.3216 W !,"<"_CNT_">"
 .W $S(CNT=1:" Last",CNT=2:" NTL",1:" NNTL")_" episode"
 .;Note that Service Component is not displayed
 .W !,?1,RADATE,?15,EODATE,?34,BOS,?48,DISCH,?62,SERVN
 .I CNT=3,MORE W !,?1,"<more episodes>"
 Q
 ;
NEW(DFN,ARRAY) ;Check for new MSE format data
 N CNT,SDAT
 S CNT=0,SDAT="A"
 F  S SDAT=$O(^DPT(DFN,.3216,"B",SDAT),-1) Q:'SDAT  D  Q:CNT>2
 .S IEN=$O(^DPT(DFN,.3216,"B",SDAT,0)) Q:'IEN
 .S DATA=$G(^DPT(DFN,.3216,IEN,0)) Q:DATA=""
 .S CNT=CNT+1,ARRAY(CNT)=DATA
 .I CNT=3,$O(^DPT(DFN,.3216,"B",SDAT),-1) S MORE=1
 Q
 ;
OLD(DFN,ARRAY) ;Get old format VistA data
 N DGRP,DGRPX,DGRPED,DGRPSD,DGRPBR,DGRPCO,DGRPSN,DGRPDI
 S DGRP(.32)=$G(^DPT(DFN,.32)),DGRP(.3291)=$G(^DPT(DFN,.3291))
 ;Last service episode (SL)
 D EPISODE(1,4,8)
 ;Next to last service episode (SNL)
 Q:$P(DGRP(.32),"^",19)'="Y"  D EPISODE(2,9,13)
 ;Prior episode (SNNL)
 I $P(DGRP(.32),"^",20)="Y" D EPISODE(3,14,18)
 Q
 ;
EPISODE(SUB,P1,P2) ;Get old VistA data and save
 S DGRPX=$P(DGRP(.32),U,P1,P2),DGRPCO=$P(DGRP(.3291),U,SUB)
 S DGRPDI=$P(DGRPX,U),DGRPBR=$P(DGRPX,U,2),DGRPED=$P(DGRPX,U,3)
 S DGRPSD=$P(DGRPX,U,4),DGRPSN=$P(DGRPX,U,5)
 ;Save in format of new .3216 multiple (no lock flag)
 S ARRAY(SUB)=DGRPED_U_DGRPSD_U_DGRPBR_U_DGRPCO_U_DGRPSN_U_DGRPDI_U
 Q
