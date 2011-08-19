PRCV442A ;WOIFO/CC-GET PO VALUES TO SEND TO DYNAMED;1/29/05
V ;;5.1;IFCAP;**81,86**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
ITEM(POIEN,PRCVLINE,PRCVDATA,PRCVERR) ; Get Item data to send to DynaMed
 ;
 ;   POIEN    = the ien of the purchase order
 ;   PRCVLINE = the ien of the line item number in the purchase order
 ;   PRCVDATA = information from the PO level to keep for reference
 ;               2237 number ^ expected delivery date
 ;   PRCVERR  = flag to indicate if the item is not qualified for 
 ;              transmission to DynaMed as it has no DM DOC ID or an
 ;              error occurred
 ;
 N PRCV,PRCVDD,PRCVL,PRCVI
 S PRCVDD="",PRCVERR=0,PRCVI=PRCVLINE_","_POIEN_","
 D GETS^DIQ(442.01,PRCVI,".01;1.5;2;3;3.1;2;5;10;48","IE","PRCVL")
 I $D(^TMP("DIERR",$J)) S PRCVERR=3 Q  ; item not on file in PO
 S $P(PRCV,"^",1)=PRCVL(442.01,PRCVI,48,"I") ; DM Doc ID (#48 N2P15)
 I $P(PRCV,"^",1)']"" S PRCVERR=1 Q  ; this is not a DM item
 S $P(PRCV,"^",2)=PRCVL(442.01,PRCVI,1.5,"I") ; Item IEN (#1.5 N0 P5))
 S $P(PRCV,"^",8)=$$GET1^DIQ(441,(PRCVL(442.01,PRCVI,1.5,"I")),51) ; NIF
 S $P(PRCV,"^",3)=PRCVL(442.01,PRCVI,.01,"E") ; line item# #.01 n0,p1
 S $P(PRCV,"^",6)=PRCVL(442.01,PRCVI,2,"I") ; QTY ORDERED (#2 N0 P 2)
 S $P(PRCV,"^",5)=PRCVL(442.01,PRCVI,3,"E") ; UOP (#3 N 0 P 3)
 S $P(PRCV,"^",9)=PRCVL(442.01,PRCVI,"3.1","E") ; pkg multiple (#3.1 N0 P12)
 S $P(PRCV,"^",7)=PRCVL(442.01,PRCVI,5,"I") ; unit price (#5 N0 P 9)
 S $P(PRCV,"^",4)=PRCVL(442.01,PRCVI,10,"E") ; 2237 IEN (#10 N0 P10)
 I $P(PRCV,"^",4)']"" S $P(PRCV,"^",4)=$P(PRCVDATA,"^",1)
 D DD(POIEN,PRCVL(442.01,PRCVI,.01,"E"),.PRCVDD) ; delivery date
 S $P(PRCV,"^",13)=PRCVDD I PRCVDD="" S $P(PRCV,"^",13)=$P(PRCVDATA,"^",2)
 S ^TMP("PRCV442A",$J,POIEN,PRCVLINE)=PRCV
 ; 
 Q
 ;
DD(POIEN,PRCVLINE,PRCVDD) ; get the earliest delivery date for the item
 ;
 ;   POIEN    = the ien of the purchase order
 ;   PRCVLINE = the ien of the line item number in the purchase order
 ;   PRCVDD   = the purchase order's expected delivery date
 ;
 N PRCVDS,PRCVDZ
 S PRCVDZ="",PRCVDS=0
 F  S PRCVDS=$O(^PRC(442.8,"AC",POIEN,PRCVLINE,PRCVDS)) Q:+PRCVDS'>0!(PRCVDS']"")  D
 . S PRCVDZ=$P($G(^PRC(442.8,PRCVDS,0)),"^",3) ; get date from delivery schedule for item
 . I PRCVDZ<PRCVDD S PRCVDD=PRCVDZ
 . I PRCVDD']"" S PRCVDD=PRCVDZ
 . Q
 Q
 ;
PO(POIEN,PRCVDATA,PRCVERR) ; get PO information, station, DUZ
 ;
 ;   POIEN     = the ien of the purchase order
 ;   PRCVDATA  = information from the PO level to keep for reference
 ;               2237 number ^ expected delivery date
 ;   PRCVERR   = flag to indicate if the order is not a qualified DynaMed
 ;               PO.  1 - indicates MOP is not suitable for a DM order
 ;
 N PRCV,PRCVV,PRCVP,PRCVPO
 S PRCVERR=0,PRCVPO=POIEN_","
 D GETS^DIQ(442,PRCVPO,".01;.02;.07;5;7;17;62","IE","PRCVP")
 I $D(^TMP("DIERR",$J)) S PRCVERR=2 Q  ; PO not on file
 I PRCVP(442,PRCVPO,.02,"I")'=1,PRCVP(442,PRCVPO,.02,"I")'=25 S PRCVERR=1 Q  ; MOP (#.02 - n0,p2)
 S $P(PRCV,"^",1)=PRCVP(442,PRCVPO,.01,"E") ; PO# (#.01 n0,p1)
 S $P(PRCV,"^",4)=PRCVP(442,PRCVPO,5,"I") ; vendor IEN (#5 n1 p1)
 ; get FMS vendor ID & alt addr code from file 440, #34&#35 - n3 p4&5
 D GETS^DIQ(440,PRCVP(442,PRCVPO,5,"I")_",","34:35","E","PRCVV")
 I $D(^TMP("DIERR",$J)) G PO1 ; vendor info not on file
 S $P(PRCV,"^",5)=PRCVV(440,PRCVP(442,PRCVPO,5,"I")_",",34,"E") ; FMS vendor ID
 S $P(PRCV,"^",6)=PRCVV(440,PRCVP(442,PRCVPO,5,"I")_",",35,"E") ; FMA alt add ind
PO1 S $P(PRCV,"^",7)=PRCVP(442,PRCVPO,17,"I") ; date signed (un-amended POs) n12 p3
 S PRCVDATA=PRCVP(442,PRCVPO,62,"E") ; for PC orders MOP=25, 2237 is in #62 N23,P23
 I PRCVDATA']"" S PRCVDATA=PRCVP(442,PRCVPO,.07,"E") ; for inv/rec MOP=1, 2237 is in #.07 - n0,p12
 S $P(PRCVDATA,"^",2)=PRCVP(442,PRCVPO,7,"I") ; delivery date (#7 n0p10)
 ;
 ; get Station Number, DUZ
 S $P(PRCV,"^",8)=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S $P(PRCV,"^",3)=DUZ
 ;
 S ^TMP("PRCV442A",$J,POIEN)=PRCV
 Q
 ;
RR(POIEN,PRCVLINE,PRCVRR,PRCVERR,ACTION) ; get receipt data for item
 ;
 ;   POIEN    = the ien of the purchase order
 ;   PRCVLINE = the ien of the line item number in the purchase order
 ;   PRCVRR   = the ien of the receiving report of interest
 ;   PRCVERR  = flag to indicate if the order does not qualify for
 ;              transmission to DynaMed or error occurred
 ;   ACTION   = flag  1 - approved report ; 2- deleted report
 ;
 N PRCV,PRCVI,PRCVDEL,PRCVR
 S PRCVI=PRCVRR_","_PRCVLINE_","_POIEN_","
 D GETS^DIQ(442.08,PRCVI,"1;2;3;4","I","PRCVR")
 I $D(^TMP("DIERR",$J)) S PRCVERR=4 G RR2  ; RR not on file
 S PRCVDEL="" I ACTION=2 S PRCVDEL="-"
 S PRCV=$G(^TMP("PRCV442A",$J,POIEN,PRCVLINE))
 S $P(PRCV,"^",10)=PRCVDEL_PRCVR(442.08,PRCVI,1,"I") ; qty received (#1, NO P2)
 S $P(PRCV,"^",11)=PRCVDEL_PRCVR(442.08,PRCVI,2,"I") ; total item cost (#2 NO P3)
 S $P(PRCV,"^",12)=PRCVDEL_PRCVR(442.08,PRCVI,4,"I") ; total discount for item(#4, N0 P5)
 S ^TMP("PRCV442A",$J,POIEN,PRCVLINE)=PRCV
RR2 Q
 ;
UPD(POIEN) ; Update DynaMed of Approved POs with DynaMed items on them
 ;
 ; POIEN    The IEN of the Purchase Order
 ;
 N PRCVDATA,PRCVERR,PRCVLINE
 S PRCVERR=0
 K ^TMP("PRCV442A",$J)
 D PO(POIEN,.PRCVDATA,.PRCVERR)
 I PRCVERR=1 Q  ; not a DynaMed order
 I PRCVERR>0 S PRCVERR=PRCVERR_"U" G TMPERR Q
 S PRCVLINE=0
 F  S PRCVLINE=$O(^PRC(442,POIEN,2,PRCVLINE)) Q:+PRCVLINE'>0!(PRCVLINE']"")  D
 . D ITEM(POIEN,PRCVLINE,PRCVDATA,.PRCVERR)
 . I PRCVERR=1 Q
 . I PRCVERR>0 S PRCVERR=PRCVERR_"U" D TMPERR Q
 I $O(^TMP("PRCV442A",$J,POIEN,""))]"" D
 . S $P(^TMP("PRCV442A",$J,POIEN),"^",2)=1
 I $O(^TMP("PRCV442A",$J,POIEN,""))']"" S PRCVERR=1 D Q Q  ; no item detail
 D EN^PRCVPOSD(POIEN)
 Q
 ;
DEL(POIEN) ; Update DynaMed of DynaMed items on a cancelled PC order
 ;
 ; POIEN    The IEN of the Purchase Order
 ;
 N PRCVDATA,PRCVDDAT,PRCVERR,PRCVLINE
 S PRCVERR=0
 K ^TMP("PRCV442A",$J)
 D PO(POIEN,.PRCVDATA,.PRCVERR)
 I PRCVERR=1 Q
 I PRCVERR>0 S PRCVERR=PRCVERR_"D" G TMPERR Q
 S PRCVDDAT=$$NOW^XLFDT
 S $P(^TMP("PRCV442A",$J,POIEN),"^",7)=PRCVDDAT
 S PRCVLINE=0
 S $P(^TMP("PRCV442A",$J,POIEN),"^",2)=5
 F  S PRCVLINE=$O(^PRC(442,POIEN,2,PRCVLINE)) Q:+PRCVLINE'>0!(PRCVLINE']"")  D
 . D ITEM(POIEN,PRCVLINE,PRCVDATA,.PRCVERR)
 . I PRCVERR=1 Q
 . I PRCVERR>0 S PRCVERR=PRCVERR_"D" D TMPERR Q
 . D DELAUD^PRCV442B($P(^TMP("PRCV442A",$J,POIEN,PRCVLINE),"^",1),PRCVDDAT,DUZ,POIEN,$P(^TMP("PRCV442A",$J,POIEN,PRCVLINE),"^",3),"") ; update DynaMed audit file
 I $O(^TMP("PRCV442A",$J,POIEN,""))']"" S PRCVERR=1 D Q Q  ; no item detail
 D EN^PRCVPOSD(POIEN)
 Q
 ;
REC(POIEN,PARTIAL,ACTION) ; Update DynaMed of Receiving Report activity
 ; 
 ; POIEN    The IEN of the Purchase Order 
 ; PARTIAL  The number of the Receiving Report
 ; ACTION   1-signed ; 2-deleted
 ;
 N PRCV,PRCVDAT,PRCVERR,PRCVLINE,PRCVRR,PRCVDATA,PRCVSIG
 S PRCVSIG=$$GET1^DIQ(442.11,(PARTIAL_","_POIEN_","),10,"I") ;WH D/T signed (#10 n0p11)
 I PRCVSIG']"" Q  ; send only signed RR
 ; Find all the items in the RR, get the fields needed
 K ^TMP("PRCV442A",$J)
 S PRCVERR=0
 D PO(POIEN,.PRCVDATA,.PRCVERR)
 I PRCVERR=1 D Q Q  ; order has MOP not used for DynaMed items
 I PRCVERR>0 S PRCVERR=PRCVERR_ACTION D TMPERR Q
 S PRCVDAT=$$NOW^XLFDT ; use for deletions
 S PRCVLINE=0
 F  S PRCVLINE=$O(^PRC(442,POIEN,2,PRCVLINE)) Q:+PRCVLINE'>0!(PRCVLINE']"")  D
 . S PRCVRR=0
 . F  S PRCVRR=$O(^PRC(442,POIEN,2,PRCVLINE,3,PRCVRR)) Q:+PRCVRR'>0!(PRCVRR']"")  I $P(^PRC(442,POIEN,2,PRCVLINE,3,PRCVRR,0),"^",4)=PARTIAL D
 . . D ITEM(POIEN,PRCVLINE,PRCVDATA,.PRCVERR)
 . . I PRCVERR=1 Q  ; this is not a DM item
 . . I PRCVERR>0 S PRCVERR=PRCVERR_ACTION D TMPERR Q
 . . D RR(POIEN,PRCVLINE,PRCVRR,.PRCVERR,ACTION)
 . . I ACTION=2 S PRCV=$G(^TMP("PRCV442A",$J,POIEN,PRCVLINE)) D RRAUD^PRCV442B(POIEN,PRCV,PRCVSIG,PRCVDAT)
 . . I PRCVERR>1 S PRCVERR=PRCVERR_ACTION D TMPERR ; sends blanks to DM?
 I $O(^TMP("PRCV442A",$J,POIEN,""))]"" D
 . S $P(^TMP("PRCV442A",$J,POIEN),"^",7)=$S(ACTION=2:PRCVDAT,1:PRCVSIG)
 . S $P(^TMP("PRCV442A",$J,POIEN),"^",2)=$S(ACTION=2:4,1:3)
 . D EN^PRCVPOSD(POIEN)
 I $O(^TMP("PRCV442A",$J,POIEN,""))']"" S PRCVERR=1 D Q ; no item detail
 Q
 ;
TMPERR ;
 ; D TMPERR^PRCV442B
 Q
 ;
Q I PRCVERR K ^TMP("PRCV442A",$J)
 Q
