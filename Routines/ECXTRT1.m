ECXTRT1 ;ALB/JAP Treating Specialty Change Extract (cont) ; July 22, 1998
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 ;
PREVTRT(ECXLOC,ECXDATE1,ECXDATE2,ECXTRTL,ECXLOS) ;find the date on which the change to the losing treat. spec. occurred
 ;   input
 ;   ECXLOC   = local array built from ATS index on file #405 (passed by reference); required
 ;   ECXDATE1 = inverse date of current (new) ts movement; required)
 ;   ECXDATE2 = inverse date of previous (losing) ts movement; required
 ;   ECXTRTL  = pointer value to file #45.7 for previous facility 
 ;              treating specialty; required
 ;   output
 ;   ECXLOS  = patients length of stay on previous (losing) ts (passed by reference)
 ;
 N DATE,DATE3,X,X1,X2
 S DATE=ECXDATE2,DATE3="",ECXLOS=0
 F  S DATE=$O(ECXLOC(DATE)) Q:DATE=""  S TRT=$O(ECXLOC(DATE,0)) Q:TRT'=ECXTRTL
 ;if date=null, then get immediately previous date by reverse $o
 ;if date=null, this gets the last date in ecxloc array, i.e., the admission ts movement
 S DATE3=$O(ECXLOC(DATE),-1)
 S X1=9999999.9999999-ECXDATE1,X2=9999999.9999999-DATE3 D ^%DTC
 S ECXLOS=X S:ECXLOS>9999 ECXLOS=9999
 Q
 ;
PREVATT(ECXLOC,ECXDATE1,ECXATTN,ECXDATE2,ECXATTL,ECXLOS) ;find the date on which the change to the losing attending occurred
 ;   input
 ;   ECXLOC   = local array built from ATS index on file #405 (passed by reference); required
 ;   ECXDATE1 = inverse date of current (new) attending; required)
 ;   ECXATTN  = specifier for current (new) attending; required
 ;   ECXDATE2 = inverse date of previous (losing) attending; required
 ;   ECXATTL  = specifier for previous (losing) attending (passed by reference); required
 ;   output
 ;   ECXLOSA  = patients length of stay with previous (losing) attending (passed by reference)
 ;
 N DATE,DATE3,X,X1,X2,TRT,REC,ATT,OUT
 S (DATE,DATE3)=ECXDATE2,ECXLOSA="",OUT=0
 I ECXATTL'="" D
 .F  S DATE=$O(ECXLOC(DATE)) Q:DATE=""  S TRT=$O(ECXLOC(DATE,0)),REC=$O(ECXLOC(DATE,TRT,0)) D  Q:OUT=1
 ..S ATT=$P(ECXLOC(DATE,TRT,REC),U,3)
 ..;if provider is changed, then quit without resetting date3, and quit loop
 ..I ATT'="",ATT'=ECXATTL S OUT=1
 ..;there's probably always data on attending, so this may not be needed;
 ..;but if att=null, then dont know if provider in ecxattl was attending or not, so don't reset date3;
 ..;reset date3 only if know for sure
 ..I ATT=ECXATTL S DATE3=DATE
 .;so date3 is earliest known date for attending specified in ecxattl
 .S X1=9999999.9999999-ECXDATE1,X2=9999999.9999999-DATE3 D ^%DTC
 .S ECXLOSA=X
 ;theres probably always data on attending, so this may not be needed;
 ;but if ecxattl is null, then need to find valid previous attending
 I ECXATTL="" D
 .;ecxattn will also be null if evaluating discharge movements
 .F  S DATE=$O(ECXLOC(DATE)) Q:DATE=""  S TRT=$O(ECXLOC(DATE,0)),REC=$O(ECXLOC(DATE,TRT,0)) D  Q:OUT=1
 ..S ATT=$P(ECXLOC(DATE,TRT,REC),U,3)
 ..;if no change in attending, then keep ecxlosa=null
 ..I ATT'="",ATT=ECXATTN S OUT=1
 ..I ATT'="",ATT'=ECXATTN D
 ...;reset ecxattl to send back to caller and calculate los
 ...S OUT=1,ECXATTL=ATT,DATE3=DATE
 ...S X1=99999999.9999999-ECXDATE1,X2=9999999.9999999-DATE3 D ^%DTC
 ...S ECXLOSA=X
 ;it is possible that ecxattl and ecxlosa will still be null
 S:ECXLOSA>9999 ECXLOSA=9999
 Q
 ;
PREVPRV(ECXLOC,ECXDATE1,ECXPRVN,ECXDATE2,ECXPRVL,ECXLOS) ;find the date on which the change to the losing primary provider occurred
 ;   input
 ;   ECXLOC   = local array built from ATS index on file #405 (passed by reference); required
 ;   ECXDATE1 = inverse date of current (new) primary provider; required)
 ;   ECXPRVN  = specifier for current (new) primary provider; required
 ;   ECXDATE2 = inverse date of previous (losing) primary provider; required
 ;   ECXPRVL  = specifier for previous (losing) primary provider 9passed by reference); required
 ;   output
 ;   ECXLOSP  = patients length of stay with previous (losing) primary provider (passed by reference)
 ;
 N DATE,DATE3,X,X1,X2,TRT,REC,PRV,OUT
 S (DATE,DATE3)=ECXDATE2,ECXLOSP="",OUT=0
 I ECXPRVL'="" D
 .F  S DATE=$O(ECXLOC(DATE)) Q:DATE=""  S TRT=$O(ECXLOC(DATE,0)),REC=$O(ECXLOC(DATE,TRT,0)) D  Q:OUT=1
 ..S PRV=$P(ECXLOC(DATE,TRT,REC),U,2)
 ..;if provider is changed, then quit without resetting date3, and quit loop
 ..I PRV'="",PRV'=ECXPRVL S OUT=1
 ..;if prv=null, then don't know if provider in ecxprvl was patient's provider or not, so don't reset date3;
 ..;reset date3 only if know for sure
 ..I PRV=ECXPRVL S DATE3=DATE
 .;so date3 is earliest known date for attending specified in ecxattl
 .S X1=9999999.9999999-ECXDATE1,X2=9999999.9999999-DATE3 D ^%DTC
 .S ECXLOSP=X
 ;if ecxprvl is null, then need to find valid previous primary provider
 I ECXPRVL="" D
 .;ecxprvn will also be null if evaluating discharge movements
 .F  S DATE=$O(ECXLOC(DATE)) Q:DATE=""  S TRT=$O(ECXLOC(DATE,0)),REC=$O(ECXLOC(DATE,TRT,0)) D  Q:OUT=1
 ..S PRV=$P(ECXLOC(DATE,TRT,REC),U,2)
 ..;if no change in primary provider, then keep ecxlosp=null
 ..I PRV'="",PRV=ECXPRVN S OUT=1
 ..I PRV'="",PRV'=ECXPRVN D
 ...;reset ecxprvl to send back to caller and calculate los
 ...S OUT=1,ECXPRVL=PRV,DATE3=DATE
 ...S X1=99999999.9999999-ECXDATE1,X2=9999999.9999999-DATE3 D ^%DTC
 ...S ECXLOSP=X
 ;it is possible that ecxprvl and ecxlosp will still be null
 S:ECXLOSP>9999 ECXLOSP=9999
 Q
