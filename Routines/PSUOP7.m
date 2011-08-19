PSUOP7 ;BIR/DAM - Outpatient AMIS Summary Data;04 MAR 2004
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;No DBIA's required
 ;
DATA ;Gather AMIS summary data from the detailed "DATA" global
 ;Called from PSUOP4
 ;
 N QTY,PRICE,QUANT
 ;
 S QTY=$P(^XTMP(PSUOPSUB,"DATA",PSUDV,PSURXIEN,PSURCT,1),U,25)
 ;
 ;
 ;Find sum of 30-day fills for each division
 I QTY'>30 D
 .S ^TMP($J,"FILL",PSUDV,30)=$G(^TMP($J,"FILL",PSUDV,30))+1
 I '$G(^TMP($J,"FILL",PSUDV,30)) S ^TMP($J,"FILL",PSUDV,30)=0
 ;
 ;
 ;Find sum of 60-day fills for each division
 I (QTY>30)&(QTY'>60) D
 .S ^TMP($J,"FILL",PSUDV,60)=$G(^TMP($J,"FILL",PSUDV,60))+1
 I '$G(^TMP($J,"FILL",PSUDV,60)) S ^TMP($J,"FILL",PSUDV,60)=0
 ;
 ;
 ;Find sum of 90-day fills for each division
 I QTY>60 D
 .S ^TMP($J,"FILL",PSUDV,90)=$G(^TMP($J,"FILL",PSUDV,90))+1
 I '$G(^TMP($J,"FILL",PSUDV,90)) S ^TMP($J,"FILL",PSUDV,90)=0
 ;
 ;
 N FILL30,FILL60,FILL90
 S FILL30=^TMP($J,"FILL",PSUDV,30)
 S FILL60=^TMP($J,"FILL",PSUDV,60)
 S FILL90=^TMP($J,"FILL",PSUDV,90)
 ;
 ;Calculate Unadjusted Total Fills
 S ^TMP($J,"UNAD",PSUDV)=FILL30+FILL60+FILL90
 ;
 ;
 ;Calculate 30-day Equivalent Fills
 S ^TMP($J,"EQUIV",PSUDV)=FILL30+(2*FILL60)+(3*FILL90)
 ;
 ;
 ;Calculate total cost for all fills
 ;S PRICE=$P(^XTMP(PSUOPSUB,"DATA",PSUDV,PSURXIEN,PSURCT,2),U,5)
 S PRICE=$P(^XTMP(PSUOPSUB,"DATA",PSUDV,PSURXIEN,PSURCT,1),U,24)
 S QUANT=$P(^XTMP(PSUOPSUB,"DATA",PSUDV,PSURXIEN,PSURCT,1),U,26)
 S PSUCOST=PRICE*QUANT
 S ^TMP($J,"COST",PSUDV,PSURXIEN)=$G(^TMP($J,"COST",PSUDV,PSURXIEN))+PSUCOST
 ;
 ;
 ;Find number of "new", "refill", and "partial" prescriptions
 S PSUTYPE=$P(^XTMP(PSUOPSUB,"DATA",PSUDV,PSURXIEN,PSURCT,1),U,16)
 ;
 I PSUTYPE="N" D
 .S ^TMP($J,"NEW",PSUDV)=$G(^TMP($J,"NEW",PSUDV))+1   ;New fills
 I '$G(^TMP($J,"NEW",PSUDV)) S ^TMP($J,"NEW",PSUDV)=0
 ;
 ;
 I PSUTYPE'="N" D
 .S ^TMP($J,"REF",PSUDV)=$G(^TMP($J,"REF",PSUDV))+1   ;Refills + partial
 I '$G(^TMP($J,"REF",PSUDV)) S ^TMP($J,"REF",PSUDV)=0
 ;
 ;Find total number of "Window CS" and "Mail CS" prescription fills
 ;
 S PSUWIN=$P(^XTMP(PSUOPSUB,"DATA",PSUDV,PSURXIEN,PSURCT,1),U,18)
 S PSUCMP=$P(^XTMP(PSUOPSUB,"DATA",PSUDV,PSURXIEN,PSURCT,1),U,17)
 S PSUCS=$P(^XTMP(PSUOPSUB,"DATA",PSUDV,PSURXIEN,PSURCT,1),U,15)
 ;
 ;
 I PSUWIN="W" S ^TMP($J,"WIN",PSUDV)=$G(^TMP($J,"WIN",PSUDV))+1 D
 .I PSUCMP="N" D
 ..I (PSUCS[2)!(PSUCS[3)!(PSUCS[4)!(PSUCS[5) D
 ...S ^TMP($J,"WINCS",PSUDV)=$G(^TMP($J,"WINCS",PSUDV))+1  ;WIN CS fills
 I '$G(^TMP($J,"WIN",PSUDV)) S ^TMP($J,"WIN",PSUDV)=0
 I '$G(^TMP($J,"WINCS",PSUDV)) S ^TMP($J,"WINCS",PSUDV)=0
 ;
 ;
 I PSUWIN="M" S ^TMP($J,"MAIL",PSUDV)=$G(^TMP($J,"MAIL",PSUDV))+1 D
 .I PSUCMP="N" D
 ..I (PSUCS[2)!(PSUCS[3)!(PSUCS[4)!(PSUCS[5) D
 ...S ^TMP($J,"MAILCS",PSUDV)=$G(^TMP($J,"MAILCS",PSUDV))+1  ;Mail CS
 I '$G(^TMP($J,"MAIL",PSUDV)) S ^TMP($J,"MAIL",PSUDV)=0
 I '$G(^TMP($J,"MAILCS",PSUDV)) S ^TMP($J,"MAILCS",PSUDV)=0
 ;
 ;
 I PSUCMP="Y" D
 .S ^TMP($J,"CMOP",PSUDV)=$G(^TMP($J,"CMOP",PSUDV))+1   ;CMOP fills
 I '$G(^TMP($J,"CMOP",PSUDV)) S ^TMP($J,"CMOP",PSUDV)=0
 ;
 ;
 I PSUCMP="N" S ^TMP($J,"LOC",PSUDV)=$G(^TMP($J,"LOC",PSUDV))+1 D
 .I (PSUCS[2)!(PSUCS[3)!(PSUCS[4)!(PSUCS[5) D
 ..S ^TMP($J,"LOCS",PSUDV)=$G(^TMP($J,"LOCS",PSUDV))+1    ;Local CS fills
 I '$G(^TMP($J,"LOC",PSUDV)) S ^TMP($J,"LOC",PSUDV)=0
 I '$G(^TMP($J,"LOCS",PSUDV)) S ^TMP($J,"LOCS",PSUDV)=0
 ;
 S PSUSTF=$P(^XTMP(PSUOPSUB,"DATA",PSUDV,PSURXIEN,PSURCT,1),U,20)
 ;
 I PSUSTF="S" D
 .S ^TMP($J,"STAFF",PSUDV)=$G(^TMP($J,"STAFF",PSUDV))+1  ;Staff fills
 I '$G(^TMP($J,"STAFF",PSUDV)) S ^TMP($J,"STAFF",PSUDV)=0
 ;
 ;
 I PSUSTF="F" D
 .S ^TMP($J,"FEE",PSUDV)=$G(^TMP($J,"FEE",PSUDV))+1    ;Fee fills
 I '$G(^TMP($J,"FEE",PSUDV)) S ^TMP($J,"FEE",PSUDV)=0
 Q
