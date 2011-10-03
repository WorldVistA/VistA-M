FHWOR1 ; HISC/REL/NCA - HL7 Additional Orders ;10/10/00  14:55
 ;;5.5;DIETETICS;;Jan 28, 2005
ADD ; Add new Order
 S COM=$E(COM,1,160) D ORD^FHORO S $P(^FHPT(FHDFN,"A",ADM,"OO",FHDR,0),"^",8)=+FHORN
 S FILL="A"_";"_ADM_";"_FHDR_";"_COM K COM,FHDR
 D SEND^FHWOR Q
CAN ; Process Cancel/Discontinue Order from OE/RR
 S FHDR=+$P(FILL,";",3) I 'FHDR S TXT="No Filler Number." D CERR^FHWOR Q
 D GADM^FHWORR
F0 I '$D(^FHPT(FHDFN,"A",+ADM,"OO",+FHDR,0)) S TXT="Additional Order not on file." D CERR^FHWOR Q
 S Y=^FHPT(FHDFN,"A",ADM,"OO",FHDR,0)
 I +FHORN'=$P(Y,"^",8) S TXT="Order Number Not Matching." D CERR^FHWOR Q
 D NOW^%DTC S $P(^FHPT(FHDFN,"A",ADM,"OO",FHDR,0),"^",5,7)="X^"_%_"^"_DUZ
 K ^FHPT("AOO",FHDFN,ADM,FHDR) S EVT="O^C^"_FHDR D ^FHORX K %,FHDR,Y
 D CSEND^FHWOR Q
AO ; Code Additional Orders
 K MSG S FILL="A"_";"_ADM_";"_FHDR_";"_COM
 S SDT=NOW D SET
 ; Code MSH, PID, and PV1
 D MSH^FHWOR
 ; code ORC
 S MSG(4)="ORC|SN||"_FILL_"^FH||||^^^"_SDT_"|||"_DUZ_"||"_DUZ_"|||"_NOW
 ; Code ODS
 S MSG(5)="ODS|D||^^^FH-6^Additional Order^99OTH|"_COM
 K FILL,FHWRD,HOSP,RM,SITE,SDT
 Q
SET ; Set Date/Time in HL7 format
 S:SDT SDT=$$FMTHL7^XLFDT(SDT)
 S:NOW NOW=$$FMTHL7^XLFDT(NOW)
 Q
NA ; OE/RR Number Assign
 S FHDR=+$P(FILL,";",3) G:'FHDR KIL S:ADM'=$P(FILL,";",2) ADM=$P(FILL,";",2)
 G:'+FHORN KIL
 S $P(^FHPT(FHDFN,"A",ADM,"OO",FHDR,0),"^",8)=+FHORN
KIL K FHDR,MSG,FHORN Q
