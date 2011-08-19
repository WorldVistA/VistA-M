FHWOR ; HISC/NCA - Main Routine to Decode HL7 ;10/10/00  14:55
 ;;5.5;DIETETICS;**2,5**;Jan 28, 2005;Build 53
EN(MSG) ; Entry Point for OE/RR 3 and pass MSG in FHMSG
 N ACT,ADM,BID,COM,FHDFN,DFN,EDT,FHPV,FHMSG,FHWF,NOW,SDT,CHK,DA,DATA,DATE,DIET,DUR,FHC,FHD,FHD1,FHD2,FOR,FTYP,IEN,ITVL,LP,MEAL,NAM,PER,PID,SERV,TIM,TIME,TM,TXT,TYPC,WARD,X,XX,YR
 S TXT="",FHWF=2 ; FHWF=2 - Orders from OE/RR
 F L=0:0 S L=$O(MSG(L)) Q:L<1  S FHMSG(L)=$G(MSG(L))
 Q:'$D(FHMSG)
 ; Decode MSH
 S X=$G(FHMSG(1)) I $E(X,1,3)'="MSH" S TXT="MSH not first record" D GETOR G ERR
 ; Check PID
 S X=$G(FHMSG(2)) I $E(X,1,3)'="PID" S TXT="PID not second record" D GETOR G ERR
 S NAM=$P(X,"|",6),DFN=$P(X,"|",4)
 I '$D(^DPT("B",$E(NAM,1,30),DFN)) S TXT="Name/DFN not found" D GETOR G ERR
 S FHZ115="P"_DFN D ADD^FHOMDPA I FHDFN=""  S TXT="Patient not found in File #115" D GETOR G ERR
 D PID^VADPT6 S PID=$G(VA("PID")),BID=$G(VA("BID")) K VA
 S X=$G(FHMSG(3)) I $E(X,1,5)="ORC|Z" G PURGE
 I $E(X,1,6)="ORC|DE" Q  ;6/2005 quit processing if "DE" returned
 ;Check for outpatient orders
 I $P(X,"|",3)="O" D ^FHOMWOR Q
 S WARD=$G(^DPT(DFN,.1)) I WARD="" D CHK^FHWORR G:CHK CANCEL S:'CHK TXT="Not an inpatient" D GETOR G ERR
 S ADM=$G(^DPT("CN",WARD,DFN)) I ADM<1 S TXT="Admission not found" D GETOR G ERR
 I '$D(^FHPT(FHDFN,"A",ADM,0)) I '$D(^DGPM(ADM,0)) S TXT="Admission not found" D GETOR G ERR
 I '$D(^FHPT(FHDFN,"A",ADM,0)) S DA=DFN D ^FHWADM
 ; Check PV1
 S X=$G(FHMSG(3)) G:$E(X,1,3)="ORC" CANCEL I $E(X,1,3)'="PV1" S TXT="Third message not ORC or PV1" D GETOR G ERR
 ; Decode ORC
 S X=$G(FHMSG(4)) I $E(X,1,3)'="ORC" S TXT="Message 4 not ORC as expected" D GETOR G ERR
 S ACT=$P(X,"|",2) I ACT'="NW" S TXT="Action not NW as expected" D GETOR G ERR
 S FHORN=$P(X,"|",3),DUR=$P(X,"|",8)
 S ITVL=$P(DUR,"^",2),SDT=$P(DUR,"^",4),EDT=$P(DUR,"^",5)
 S FHPV=$P(X,"|",13),NOW=$P(X,"|",16) I NOW="" S TXT="No Effective Date" G ERR
 S X=$G(FHMSG(5)) I $E(X,1,3)="ODT" D ^FHWOR3 G KIL
 I $E(X,1,3)="OBR" D ^FHWOR61 G KIL
 I $E(X,1,3)'="ODS" S TXT="Message 5 not ODT or ODS as expected" G ERR
 S TYPC=$P(X,"|",2) I TYPC="ZE" D ^FHWOR5 G KIL
 S DIET=$P(X,"|",4),DIET=$E(DIET,4,$L(DIET)),COM=$P(X,"|",5)
 I $E(DIET,1,4)="FH-5" D ^FHWOR4 G KIL
 I $E(DIET,1,4)="FH-6" D ^FHWOR1 G KIL
 D ^FHWOR2 G KIL
CANCEL ; Cancel/Discontinue
 S DATA=X,FOR=0
 S ACT=$P(DATA,"|",2)
 S FHORN=$P(DATA,"|",3),FILL=$P(DATA,"|",4),FTYP=$P(FILL,";",1)
 I ACT'="CA",ACT'="DC",ACT'="NA",ACT'="DE",ACT'="SS" S TXT="Action not CA, DC, NA, or DE as expected" G CERR
 I FTYP="R"!(FTYP="S") D OMSTAT^FHWORR Q  ;Status update for outpt meals
 I "ADEINT"'[FTYP G CSEND:ACT="CA"!(ACT="DC"),KIL
 S FOR=$S(FTYP="A":1,FTYP="D":2,FTYP="E":3,FTYP="N":4,FTYP="T":5,FTYP="I":6,1:0)
 I 'FOR G CSEND:ACT="CA"!(ACT="DC"),KIL
 I ACT="SS" G STATUS^FHWORR
 I ACT="NA" D NA K ACT,TXT K MSG Q
 I ACT="DE" K MSG G KIL
CAN ; Cancel Order From OE
 I FOR=1 D CAN^FHWOR1 G KIL
 I FOR=2 D CAN^FHWOR2 G KIL
 I FOR=3 D CAN^FHWOR3 G KIL
 I FOR=4 D CAN^FHWOR4 G KIL
 I FOR=5 D CAN^FHWOR5 G KIL
 I FOR=6 D CAN^FHWOR61 G KIL
 G KIL
PURGE ; Purge OE/RR Orders
 I $E(X,5,6)'="Z@" G KIL
 S FHORN=+$P(X,"|",3),FILL=$P(X,"|",4),FTYP=$P(FILL,";",1)
 S FHDR=+$P(FILL,";",3),ADM=+$P(FILL,";",2)
 I FTYP="A" S:$P($G(^FHPT(FHDFN,"A",ADM,"OO",FHDR,0)),"^",8)=FHORN $P(^FHPT(FHDFN,"A",ADM,"OO",FHDR,0),"^",8)=""
 I FTYP="D" S:$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHDR,0)),"^",14)=FHORN $P(^FHPT(FHDFN,"A",ADM,"DI",FHDR,0),"^",14)=""
 I FTYP="E" S SDT=$P(FILL,";",4),EDT=$P(FILL,";",5) S:EDT<SDT EDT=SDT D
 .F EL=SDT\1:0 S EL=$O(^FHPT(FHDFN,"A",ADM,"EL",EL)) Q:EL<1!(EL>EDT)  D
 ..S:$P($G(^FHPT(FHDFN,"A",ADM,"EL",EL,0)),"^",7)=FHORN $P(^FHPT(FHDFN,"A",ADM,"EL",EL,0),"^",7)=""
 ..Q
 .Q
 I FTYP="N" S:$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHDR,0)),"^",14)=FHORN $P(^FHPT(FHDFN,"A",ADM,"DI",FHDR,0),"^",14)=""
 I FTYP="T" S:$P($G(^FHPT(FHDFN,"A",ADM,"TF",FHDR,0)),"^",14)=FHORN $P(^FHPT(FHDFN,"A",ADM,"TF",FHDR,0),"^",14)=""
 I FTYP="I" S:$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",13)=FHORN $P(^FHPT(FHDFN,"A",ADM,0),"^",13)=""
 K EL,FHDR
 S $P(MSG(1),"|",9)="ORR",$P(MSG(3),"|",2)="ZR",$P(MSG(1),"|",3)="DIETETICS" G EVSEND
NA ; Number Assign
 I FOR=1 D NA^FHWOR1 G KIL
 I FOR=2 D NA^FHWOR2 G KIL
 I FOR=3 D NA^FHWOR3 G KIL
 I FOR=4 D NA^FHWOR4 G KIL
 I FOR=5 D NA^FHWOR5 G KIL
 I FOR=6 D NA^FHWOR61 G KIL
 Q
CVT ; Convert HL7 date to FM date
 Q:DATE=""  S DATE=$$HL7TFM^XLFDT(DATE)
 I $P(DATE,".",2)=24 S DATE=$$FMADD^XLFDT(DATE,0,0,1)
 Q
ERR ; Send error MSG
 K MSG D RMSH
 S $P(MSG(3),"|",1,2)="ORC"_"|"_$S($P($G(MSG(3)),"|",1)="ORC":"U"_$E($P($G(MSG(3)),"|",2),1),1:"OC"),$P(MSG(3),"|",3)=FHORN
 S $P(MSG(3),"|",4)=$S($P(FHMSG(3),"|",1)="ORC":$P(FHMSG(3),"|",4),1:"")
 S $P(MSG(3),"|",13)=$S($P(FHMSG(3),"|",1)="ORC":$P(FHMSG(3),"|",13),1:$P(FHMSG(4),"|",13))
 S $P(MSG(3),"|",16)=$S($P(FHMSG(3),"|",1)="ORC":$P(FHMSG(3),"|",16),1:$P(FHMSG(4),"|",16))
 S $P(MSG(3),"|",17)=TXT G EVSEND
SEND ; Send OK MSG to OERR
 K MSG D RMSH
 S MSG(3)="ORC|OK|"_FHORN_"|"_FILL_"^"_"FH" G EVSEND
CERR ; Send unable MSG
 K MSG D RMSH
 S MSG(3)="ORC|U"_$E(ACT,1)_"|"_FHORN_"|"_FILL_"|||||||||||||"_TXT G EVSEND
CSEND ; Send Canceled/Discontinued MSG to OERR
 K MSG D RMSH
 S MSG(3)="ORC|"_$E(ACT,1)_"R"_"|"_FHORN_"|"_FILL
EVSEND ; Send Message to OE/RR
 K ACT,FILL,FHORN,SITE,TXT D MSG^XQOR("FH EVSEND OR",.MSG) K MSG Q
MSH ; Code MSH message
 D MSH^FHWORR
 Q
RMSH ; Code MSH Return Message
 D SITE^FH
 S MSG(1)="MSH|^~\&|DIETETICS|"_SITE(1)_"|||||ORR"
 ; code PID
 S MSG(2)="PID|||"_DFN_"||"_$P($G(^DPT(DFN,0)),"^",1)
 Q
GETOR ; Call to Get FHORN
 D GETOR^FHWORR Q
KIL ; Kill Variables
 K ACT,ADM,BID,COM,FHDFN,DFN,EDT,FHPV,FHMSG,FHWF,NOW,SDT,CHK,DA,DATA,DATE,DIET,DUR,FHC,FHD,FHD1,FHD2,FOR,FTYP,IEN,ITVL,LP,MEAL,NAM,PER,PID,SERV,TIM,TIME,TM,TXT,TYPC,WARD,X,XX,YR Q
