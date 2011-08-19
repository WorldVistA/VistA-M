KMPRUTL3 ;OAK/RAK - Resource Usage Monitor Utilities ;5/28/03  09:16
 ;;2.0;CAPACITY MANAGEMENT - RUM;;May 28, 2003
 ;
HRSDAYS(KMPRSDT,KMPREDT,KMPRKILL,KMPRRES) ;
 ;-- number of days/hours in the date range
 ;-----------------------------------------------------------------------
 ; KMPRSDT.. Start Date in internal fileman format
 ; KMPREDT.. End Date in internal fileman format
 ; KMPRKILL. Kill node after processing: 
 ;              0 - do not kill
 ;              1 - kill
 ; KMPRRES.. Array (passed by reference) containing days/hours info
 ;           in format: KMPRRES(KMPRSDT,Node)=Data 
 ;              Where Data equals for the specified date range:
 ;              '^' Piece 1 - Prime Time Days
 ;              '^' Piece 2 - Prime Time Hours
 ;              '^' Piece 3 - Non-Prime Time Days
 ;              '^' Piece 4 - Non-Prime Time Hours
 ;              '^' Piece 5 - Workday Days
 ;              '^' Piece 6 - Workday Hours
 ;              '^' Piece 7 - Non-Workday Days
 ;              '^' Piece 8 - Non-Workday Hours
 ;           Example for the specified date range:
 ;              KMPRRES(3030418,"999A01")=5^45^7^123^5^120^2^48
 ;              KMPRRES(3030418,"999A02")=5^40^7^120^5^110^2^45 <=partial
 ;              KMPRRES(3030418,"999A03")=5^45^7^123^5^120^2^48
 ;              KMPRRES(  ...  ,   ...  )=...
 ;-----------------------------------------------------------------------
 ;
 K KMPRRES
 ;
 Q:'$G(KMPRSDT)
 Q:'$G(KMPREDT)
 S KMPRKILL=+$G(KMPRKILL)
 ;
 N DATA,DATE,DAYS,HOURS,I,NODE
 ;
 D HOURS(KMPRSDT,KMPREDT,KMPRKILL,.HOURS)
 Q:'$D(HOURS)
 ;
 S NODE=""
 F  S NODE=$O(HOURS(NODE)) Q:NODE=""  D
 .S (DATE,DAYS,HOURS)=0
 .F  S DATE=$O(HOURS(NODE,DATE)) Q:'DATE  D
 ..;
 ..; piece 1 - prime time hours per day
 ..; piece 2 - non-prime time hours per day
 ..; piece 3 - workday hours per day
 ..; piece 4 - non-workday hours per day
 ..S DATA=HOURS(NODE,DATE)
 ..;
 ..F I=1:1:4 D
 ...; total hours for the specified date range
 ...S $P(HOURS,U,I)=$P(HOURS,U,I)+$P(DATA,U,I)
 ...; if current day has hours then increment total days for the
 ...; specified date range
 ...S:$P(DATA,U,I) $P(DAYS,U,I)=$P(DAYS,U,I)+1
 .;
 .; back to NODE level
 .S KMPRRES(KMPRSDT,NODE)=$P(DAYS,U)_"^"_$P(HOURS,U)_"^"_$P(DAYS,U,2)_"^"_$P(HOURS,U,2)_"^"_$P(DAYS,U,3)_"^"_$P(HOURS,U,3)_"^"_$P(DAYS,U,4)_"^"_$P(HOURS,U,4)
 ;
 Q
 ;
HOURS(KMPRSDT,KMPREDT,KMPRKILL,KMPRRES) ;
 ;-- determine prime time & non-prime time hours per day
 ;-- determine workday & non-workday hours per day
 ;-----------------------------------------------------------------------
 ; KMPRSDT.. Start Date in internal fileman format
 ; KMPREDT.. End Date in internal fileman format
 ; KMPRKILL. Kill node after processing: 
 ;              0 - do not kill
 ;              1 - kill
 ; KMPRRES.. Array (passed by reference) containing hours info
 ;           in format: KMPRRES(Date,Node)=Data 
 ;              Where Data equals:
 ;              '^' Piece 1 - Prime Time Hours per day
 ;              '^' Piece 2 - Non-Prime Time Hours per day
 ;              '^' Piece 3 - Workday Hours per day
 ;              '^' Piece 4 - Non-Workday Hours per day
 ;           Example:
 ;              KMPRRES(3030418,"999A01")=9^15^24^0  <= Friday
 ;              KMPRRES(3030418,"999A02")=4^10^14^0  <= Friday (partial)
 ;              KMPRRES(3030419,"999A01")=0^24^0^24  <= Saturday   
 ;              KMPRRES(  ...  ,   ...  )= ...
 ;-----------------------------------------------------------------------
 ;
 K KMPRRES
 ;
 Q:'$G(KMPRSDT)
 Q:'$G(KMPREDT)
 S KMPRKILL=+$G(KMPRKILL)
 ;
 N DATA,DATE,DOW,END,HOURS,HRS,I,NODE,PIECE,WORKDAY
 ;
 ; end date
 S END=KMPREDT
 S DATE=KMPRSDT-.1,(DAYS,HOURS)=""
 F  S DATE=$O(^KMPTMP("KMPR","HOURS",DATE)) Q:'DATE!(DATE>END)  D
 .;
 .Q:DATE<KMPRSDT!(DATE>END)
 .;
 .S NODE="",DOW=$$DOW^XLFDT(DATE,1),WORKDAY=$$WORKDAY^XUWORKDY(DATE)
 .;
 .; prime time (8am to 5pm)
 .; if not saturday or sunday or holiday then prime time (piece 1)
 .; if saturday or sunday then non-prime time (piece 2)
 .S PIECE=$S(DOW'=0&(DOW'=6)&('$G(^HOLIDAY(DATE,0))):1,1:2)
 .;
 .F  S NODE=$O(^KMPTMP("KMPR","HOURS",DATE,NODE)) Q:NODE=""  D
 ..S DATA=$G(^KMPTMP("KMPR","HOURS",DATE,NODE)) Q:DATA=""
 ..S (HOURS,HRS)=0
 ..;
 ..;*** times are offset by 1  so zero hour is in piece 1
 ..;***                            one hour is in piece 2
 ..;***                            two hour is in piece 3
 ..;***                            etc.
 ..;
 ..; prime time hours
 ..F I=9:1:17 S HRS=HRS+$P(DATA,U,I)
 ..S $P(HOURS,U,PIECE)=$P(HOURS,U,PIECE)+HRS
 ..;
 ..; non-prime time hours
 ..S HRS=0
 ..F I=1:1:8,18:1:24 S HRS=HRS+$P(DATA,U,I)
 ..S $P(HOURS,U,2)=$P(HOURS,U,2)+HRS
 ..;
 ..; workday, non-workday hours
 ..S HRS=0
 ..F I=1:1:24 S HRS=HRS+$P(DATA,U,I)
 ..I WORKDAY S $P(HOURS,U,3)=$P(HOURS,U,3)+HRS
 ..E  S $P(HOURS,U,4)=$P(HOURS,U,4)+HRS
 ..;
 ..S KMPRRES(NODE,DATE)=HOURS
 ..;
 ..K:KMPRKILL ^KMPTMP("KMPR","HOURS",DATE,NODE)
 ;
 Q
 ;
PURGE(KMPRDDT,KMPRHRS) ;-- purge data in file #8971.1
 ;-----------------------------------------------------------------------
 ; KMPRDDT.. Date to begin purge in internal fileman format. Purge will
 ;           reverse $order and delete entries 'EARLIER' than KMPRDDT.
 ; KMPRHRS.. Purge Hours/Days data from ^KMPTMP("KMPR","HOURS". Entries
 ;           'EARLIER' than KMPRDDT will be deleted.
 ;           0 - do not purge hours/days data.
 ;           1 - purge hours/days data.
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPRDDT)
 S KMPRHRS=+$G(KMPRHRS)
 ;
 N DA,DATE,DIK,IEN
 D:'$D(ZTQUEUED) EN^DDIOL("Deleting old records...")
 S DATE=KMPRDDT
 F  S DATE=$O(^KMPR(8971.1,"B",DATE),-1) Q:'DATE!(DATE>KMPRDDT)  D 
 .F IEN=0:0 S IEN=$O(^KMPR(8971.1,"B",DATE,IEN)) Q:'IEN  D 
 ..; delete if no zero node
 ..I '$D(^KMPR(8971.1,IEN,0)) K ^KMPR(8971.1,"B",DATE,IEN) Q
 ..; quit if not 'sent to cm database'.
 ..Q:$P($G(^KMPR(8971.1,IEN,0)),U,2)=0
 ..; Delete entry.
 ..S DA=IEN,DIK="^KMPR(8971.1," D ^DIK
 ;
 Q:'KMPRHRS
 D:'$D(ZTQUEUED) EN^DDIOL("Deleting old entries from ^KMPTMP(""KMPR"",""HOURS""...")
 S DATE=KMPRDDT
 F  S DATE=$O(^KMPTMP("KMPR","HOURS",DATE),-1) Q:'DATE!(DATE>KMPRDDT)  D 
 .K ^KMPTMP("KMPR","HOURS",DATE)
 ;
 Q
