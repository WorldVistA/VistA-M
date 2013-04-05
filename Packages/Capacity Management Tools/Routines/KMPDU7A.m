KMPDU7A ;OAK/RAK - CM Tools Routine Utilities ;7/22/04  09:06
 ;;3.0;KMPD;;Jan 22, 2009;Build 42
 ;
 N DATA,DATE,HR,I,LN
 ;
ADCL ;- TMG - Average Daily Coversheet Load
 ; report data
 N KMPDPTNP
 S KMPDPTNP=$G(KMPDTM)
 S KMPDATE(0)=KMPDATE
 D DATA^KMPDTP1(.KMPDATE,KMPDPTNP,"")
 I '$D(^TMP($J)) S KMPDY(0)="<No Data To Report>" Q
 ;S KMPDY(0)=$$NOW^XLFDT_"^"_$$FMTE^XLFDT($$NOW^XLFDT)
 S (DATE,LN)=0
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  D 
 .S DATA=^TMP($J,DATE),LN=LN+1
 .S $P(KMPDY(LN),U)=$$FMTE^XLFDT(DATE)
 .S $P(KMPDY(LN),U,2)=$FN($P(DATA,U),",",0)
 .S $P(KMPDY(LN),U,3)=$FN($P(DATA,U,2),",",0)
 .S $P(KMPDY(LN),U,4)=$FN($P(DATA,U,3),",",0)
 .S $P(KMPDY(LN),U,5)=$FN($P(DATA,U,4),",",0)
 Q
 ;
AHCR ;- TMG - Average Hourly Coversheet Load
 ; report data
 D DATA^KMPDTP3
 I '$D(^TMP($J)) S KMPDY(0)="<No Data to Report>" Q
 S (DATE,LN)=0
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  S HR=0 D 
 .F  S HR=$O(^TMP($J,DATE,HR)) Q:'HR  D 
 ..S DATA=^TMP($J,DATE,HR),LN=LN+1
 ..S $P(KMPDY(LN),U)=$$FMTE^XLFDT(DATE)
 ..S $P(KMPDY(LN),U,2)=$S($L(HR)=1:"0",1:"")_HR
 ..S $P(KMPDY(LN),U,3)=$FN($P(DATA,U),",",0)
 ..S $P(KMPDY(LN),U,4)=$FN($P(DATA,U,2),",",0)
 ..S $P(KMPDY(LN),U,5)=$FN($P(DATA,U,3),",",0)
 ..S $P(KMPDY(LN),U,6)=$FN($P(DATA,U,4),",",0)
 ..S $P(KMPDY(LN),U,7)=$FN($P(DATA,U,5),",",0)
 Q
 ;
CTTLAR ;- TMG - Coversheet TTL Alert Report
 I $G(KMPDSRCH)="" S KMPDY(0)="[TTL Search data is missing]" Q
 I '$G(KMPDTSEC) S KMPDY(0)="[Threshold Seconds data is missing]" Q
 ; report data
 D DATA^KMPDTP5
 I '$D(^TMP($J)) S KMPDY(0)="<No Data to Report>" Q
 S (DATE,LN)=0
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  S HR="" D 
 .F  S HR=$O(^TMP($J,DATE,HR)) Q:HR=""  D 
 ..S DATA=^TMP($J,DATE,HR)
 ..S $P(KMPDY(LN),U)=$$FMTE^XLFDT(DATE)
 ..S $P(KMPDY(LN),U,2)=HR
 ..; user name
 ..S $P(KMPDY(LN),U,3)=$P(DATA,U,5)
 ..; client name
 ..S $P(KMPDY(LN),U,4)=$P(DATA,U,6)
 ..; ip address
 ..S $P(KMPDY(LN),U,5)=$P(DATA,U,9)
 ..; time to load
 ..S $P(KMPDY(LN),U,6)=$FN($P(DATA,U,4),",",0)
 ..S LN=LN+1
 Q
 ;
DCTTLDR ;- TMG - Daily Coversheet TTL Detailed Report
 S KMPDPTNP=KMPDTM
 ; report data
 D DATA^KMPDTP2
 I '$D(^TMP($J)) S KMPDY(0)="<No Data to Report>" Q
 S (DATE,LN)=0
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  D 
 .S DATA=^TMP($J,DATE),DATA(1)=$G(^TMP($J,DATE,1))
 .F I=1:1:10 D 
 ..S $P(KMPDY(LN),U)=$$FMTE^XLFDT(DATE)
 ..I I<10 S $P(KMPDY(LN),U,2)=$J(I-1*10,2)_" to "_(I*10)
 ..E  S $P(KMPDY(LN),U,2)="90 or greater"
 ..S $P(KMPDY(LN),U,3)=$FN($P(DATA,U,I),",",0)
 ..S $P(KMPDY(LN),U,4)=$FN($P(DATA(1),U,I),",",1)_"%"
 ..S LN=LN+1
 Q
 ;
HCTTLDR ;-TMG - Hourly Coversheet TTL Detailed Report
 ; report data
 D DATA^KMPDTP4
 I '$D(^TMP($J)) S KMPDY(0)="<No Data to Report>" Q
 S (DATE,LN)=0
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  S HR=0 D 
 .F  S HR=$O(^TMP($J,DATE,HR)) Q:'HR  D 
 ..S DATA=^TMP($J,DATE,HR),DATA(1)=$G(^(HR,1))
 ..F I=1:1:9 D 
 ...S $P(KMPDY(LN),U)=$$FMTE^XLFDT(DATE)
 ...S $P(KMPDY(LN),U,2)=HR
 ...S $P(KMPDY(LN),U,3)=$J(I-1*10,2)_" to "_(I*10)
 ...S $P(KMPDY(LN),U,4)=$FN($P(DATA,U,I),",",0)
 ...S $P(KMPDY(LN),U,5)=$FN($P(DATA(1),U,I),",",1)
 ...S LN=LN+1
 Q
 ;
RTAHCL ;- TMG - Real-Time Average Hourly Coversheet Load
 ; report data
 D DATA^KMPDTP7
 I '$D(^TMP($J)) S KMPDY(0)="<No Data to Report>" Q
 S DATE=$O(^TMP($J,0)) Q:'DATE
 S HR="",LN=0
 F  S HR=$O(^TMP($J,DATE,HR)) Q:HR=""  D 
 .S DATA=^TMP($J,DATE,HR)
 .S $P(KMPDY(LN),U)=$$FMTE^XLFDT(DATE)
 .S $P(KMPDY(LN),U,2)=HR
 .; ttl average
 .S $P(KMPDY(LN),U,3)=$FN($P(DATA,U),",",0)
 .; ttl minimum
 .S $P(KMPDY(LN),U,4)=$FN($P(DATA,U,2),",",0)
 .; ttl maximum
 .S $P(KMPDY(LN),U,5)=$FN($P(DATA,U,3),",",0)
 .; # of cv loads
 .S $P(KMPDY(LN),U,6)=$FN($P(DATA,U,5),",",0)
 .S LN=LN+1 Q
 Q
 ;
RTTA ;- TMG - Real-Time Threshold Alert
 S KMPDHOUR=$G(KMPDHOUR)
 S KMPDTSEC=$G(KMPDTSEC)
 I 'KMPDTSEC S KMPDY(0)="[Seconds data is missing]" Q
 I $G(KMPDSRCH)="" S KMPDY(0)="[TTL Search data is missing]" Q
 S KMPDSRCH(1)=$P(KMPDSRCH,U),KMPDSRCH(2)=$P(KMPDSRCH,U,2,3)
 I 'KMPDSRCH(1) S KMPDY(0)="[TTL Search data invalid]" Q
 I (KMPDSRCH(1)<4)&('KMPDSRCH(2)) S KMPDY(0)="[TTL Search data missing]" Q
 ; report data
 D DATA^KMPDTP6
 I '$D(^TMP($J)) S KMPDY(0)="<No Data to Report>" Q
 S (DATE,LN)=0
 F  S DATE=$O(^TMP($J,DATE)) Q:'DATE  S HR="" D 
 .F  S HR=$O(^TMP($J,DATE,HR)) Q:HR=""  D 
 ..S DATA=^TMP($J,DATE,HR)
 ..; date
 ..S $P(KMPDY(LN),U)=$$FMTE^XLFDT(DATE)
 ..; hour
 ..S $P(KMPDY(LN),U,2)=HR
 ..; user name
 ..S $P(KMPDY(LN),U,3)=$P(DATA,U,5)
 ..; client name
 ..S $P(KMPDY(LN),U,4)=$P(DATA,U,6)
 ..; ip address
 ..S $P(KMPDY(LN),U,5)=$P(DATA,U,9)
 ..; time to load
 ..S $P(KMPDY(LN),U,6)=$P(DATA,U,4)
 ..S LN=LN+1
 ;
 Q
