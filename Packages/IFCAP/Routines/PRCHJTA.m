PRCHJTA ;OI&T/DDA - MANAGES DATA FROM MESSAGING EVENTS INTO 414.06 ;5/25/12 8:53am
 ;;5.1;IFCAP;**167**;Oct 20,2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
 Q
 ;FOR ENTRY POINT "LOG":
 ;API CALLED AS: LOG^PRCHJTA(var1,var2,var3,.array,.return)
 ; Globals are locked within the API
 ;INPUT
 ; var1 PRCHJID - FREE TEXT - EXTERNAL OF '410;.01' AS SHARED WITH ECMS (required for all)
 ; var2 ECMSID - FREE TEXT - AS SENT FROM ECMS [ActionID] (for inbound types if available)
 ; var3 TYPE - FREE TEXT or CODE of MESSAGE TYPE as defined in 'EVENT TYPE' '414.06;10;.02' (required for all)
 ; array EVENT - ARRAY THAT HOLDS THE EVENT SPECIFIC DATA TO BE STORED IN THE FILE (required, elements vary)
 ;       EVENT("MSGID")= FREE TEXT STRING OF HLO MESSAGE ID (if available)
 ;       EVENT("IEN410")= FM INTERNAL OF THE 410 RECORD (required for outbound, non-acknowledgement, types only)
 ;       EVENT("IFCAPU")= FM INTERNAL/DUZ OF IFCAP USER(required for outbound, non-acknowledgement, types only)
 ;       EVENT("STN")= FREE TEXT STRING OF THE STATION AS PASSED FROM ECMS (always store if available)
 ;       EVENT("SUBSTN")= FREE TEXT STRING OF THE SUB-STATION AS PASSED FROM ECMS (always store if available)
 ;       EVENT("ECMSU")= FREE TEXT OF ECMS USER AS PASSED FROM ECMS (always store if available)
 ;       EVENT("ECMSPH")= FREE TEXT OF THE ECMS CONTACT PHONE (always store if available)
 ;       EVENT("ECMSEM")= FREE TEXT OF THE ECMS CONTACT EMAIL (always store if available)
 ;       EVENT("ECMSDT")= DATE OF THE USER ACTION, RETURN/CANCEL, ON ECMS (always store if available)
 ;       EVENT("ECMSRN")= FREE TEXT OF THE RETURN/CANCEL REASON FROM ECMS (always store if available)
 ;       EVENT("ECMSCM")= FREE TEXT OF COMMENTS FROM ECMS (always store if available)
 ;       EVENT("ERROR",n)= FREE TEXT, INDIVIDUAL ERROR LINE TO BE STORED. n= non-zero, non-repeating integer
 ;OUTPUT
 ; .return ERR - 1^"error text"= ERROR STORING DATA, 0= NO ERROR
 ;
LOG(PRCHJID,ECMSID,TYPE,EVENT,ERR) ; params defined above
 N LINE,PRCERR,PRCIEN,PRCTIEN,PRCVIEN,TYPETXT
 S ERR=0
 D TYPE
 S:(+TYPE<1)!(+TYPE>11)!(+TYPE=5) ERR="1^Unknown TYPE "_TYPE
 I +$G(PRCHJID)=0 S ERR="2^Missing Transaction Number" Q
 I '((TYPE=1)!(TYPE=4)) G OTHER
 ; TYPE 1 or TYPE 4 CREATE A NEW ENTRY IN 414.06 unless a record already exists for this Transaction ID
 S PRCTIEN=0
 S PRCTIEN=$O(^PRCV(414.06,"B",PRCHJID,PRCTIEN))
 G:+PRCTIEN>0 OTHER
 ;lock the file to get IEN for new TRANSACTION record
 S PRCVIEN=0
 L +^PRCV(414.06,PRCVIEN):DILOCKTM E  S ERR="3^Unable to lock record" K PRCVIEN Q
 ; Create parent record
 I +$G(EVENT("IEN410"))=0 S ERR="4^Missing CONTROL POINT ACTIVITY, IEN" S PRCTIEN=0 G XLOG
 S PRC41406(414.06,"+1,",.01)=PRCHJID
 S PRC41406(414.06,"+1,",.03)=TYPETXT
 S PRC41406(414.06,"+1,",1)=EVENT("IEN410")
 S PRCIEN=""
 D UPDATE^DIE("","PRC41406","PRCIEN","PRCERR")
 I $D(PRCERR) D
 .S ERR="5^Error creating TRANSACTION record: "_$G(PRCERR("DIERR","1","TEXT",1))
 G:+ERR XLOG
 S PRCTIEN=PRCIEN(1)
 K PRC41406,PRCIEN,PRCERR
 ; Create EVENT sub-record
 S PRC41406(414.061,"+2,"_PRCTIEN_",",.01)=$$NOW^XLFDT
 S PRC41406(414.061,"+2,"_PRCTIEN_",",.02)=TYPE
 S:$G(EVENT("MSGID"))'="" PRC41406(414.061,"+2,"_PRCTIEN_",",.03)=EVENT("MSGID")
 S PRC41406(414.061,"+2,"_PRCTIEN_",",3)=EVENT("IFCAPU")
 D UPDATE^DIE("","PRC41406","PRCIEN","PRCERR")
 I $D(PRCERR) D
 .S ERR="6^Error creating TRANSACTION  record: "_$G(PRCERR("DIERR","1","TEXT",1))
  ; Store Transaction ERROR text if any
 K PRCERR
 S PRCIEN(1)=PRCTIEN
 S PRCVIEN=""
 S LINE=0
 I $D(EVENT("ERROR")) F  S LINE=$O(EVENT("ERROR",LINE)) Q:LINE=""  D  Q:+ERR
 .K PRC41406
 .S PRCVIEN(3)=LINE
 .S:$G(EVENT("ERROR",LINE))'="" PRC41406(414.0613,"+3,"_PRCIEN(2)_","_PRCIEN(1)_",",.01)=EVENT("ERROR",LINE)
 .D UPDATE^DIE("","PRC41406","PRCVIEN","PRCERR")
 .I $D(PRCERR) D
 ..S ERR="10.1^Error updating TRANSACTION word-processing field ERROR: "_$G(PRCERR("DIERR","1","TEXT",1))
 ..Q
 .Q
 S PRCTIEN=0
 G XLOG
OTHER ; LOG ALL OTHER TYPES
 ; Find the TRANSACTION record
 S PRCTIEN=0
 S PRCTIEN=$O(^PRCV(414.06,"B",PRCHJID,PRCTIEN))
 I PRCTIEN="" S ERR="7^"_PRCHJID_" does not exist in the Transaction file." K PRCTIEN Q
 L +^PRCV(414.06,PRCTIEN):DILOCKTM E  S ERR="8^Unable to lock record" K PRCTIEN Q
 ; Store header data
 S:$G(ECMSID)'="" PRC41406(414.06,PRCTIEN_",",.02)=ECMSID
 S PRC41406(414.06,PRCTIEN_",",.03)=TYPETXT
 S:+$G(EVENT("IEN410")) PRC41406(414.06,PRCTIEN_",",1)=EVENT("IEN410")
 D FILE^DIE("","PRC41406","PRCERR")
 ; Store Transaction data
 K PRC41406
 S PRC41406(414.061,"+2,"_PRCTIEN_",",.01)=$$NOW^XLFDT
 S PRC41406(414.061,"+2,"_PRCTIEN_",",.02)=TYPE
 S:$G(EVENT("MSGID"))'="" PRC41406(414.061,"+2,"_PRCTIEN_",",.03)=EVENT("MSGID")
 S:$G(EVENT("STN"))'="" PRC41406(414.061,"+2,"_PRCTIEN_",",1)=EVENT("STN")
 S:$G(EVENT("SUBSTN"))'="" PRC41406(414.061,"+2,"_PRCTIEN_",",2)=EVENT("SUBSTN")
 S:$G(EVENT("IFCAPU"))'="" PRC41406(414.061,"+2,"_PRCTIEN_",",3)=EVENT("IFCAPU")
 ;S:$G(EVENT("ECMSU"))'="" PRC41406(414.061,"+2,"_PRCTIEN_",",4)=EVENT("ECMSU")
 S:$G(EVENT("ECMSPH"))'="" PRC41406(414.061,"+2,"_PRCTIEN_",",5)=EVENT("ECMSPH")
 S:$G(EVENT("ECMSEM"))'="" PRC41406(414.061,"+2,"_PRCTIEN_",",6)=EVENT("ECMSEM")
 S:$G(EVENT("ECMSDT"))'="" PRC41406(414.061,"+2,"_PRCTIEN_",",7)=EVENT("ECMSDT")
 S:$G(EVENT("ECMSRN"))'="" PRC41406(414.061,"+2,"_PRCTIEN_",",10)=EVENT("ECMSRN")
 S PRC41406(414.061,"+2,"_PRCTIEN_",",11)=$S($G(EVENT("ECMSCM"))'="":EVENT("ECMSCM")_" ",1:"")_$S($G(EVENT("ECMSU"))'="":"{"_EVENT("ECMSU")_"}",1:"")
 S PRC41406(414.061,"+2,"_PRCTIEN_",",11)=$E(PRC41406(414.061,"+2,"_PRCTIEN_",",11),1,100)
 D UPDATE^DIE("","PRC41406","PRCVIEN","PRCERR")
 I $D(PRCERR) D
 .S ERR="9^Error updating TRANSACTION record: "_$G(PRCERR("DIERR","1","TEXT",1))
 G:+ERR XLOG
 ; Store Transaction ERROR text if any
 K PRCERR
 S PRCVIEN(1)=PRCTIEN
 S PRCVIEN=""
 S LINE=0
 I $D(EVENT("ERROR")) F  S LINE=$O(EVENT("ERROR",LINE)) Q:LINE=""  D  Q:+ERR
 .K PRC41406
 .S PRCVIEN(3)=LINE
 .S:$G(EVENT("ERROR",LINE))'="" PRC41406(414.0613,"+3,"_PRCVIEN(2)_","_PRCVIEN(1)_",",.01)=EVENT("ERROR",LINE)
 .D UPDATE^DIE("","PRC41406","PRCVIEN","PRCERR")
 .I $D(PRCERR) D
 ..S ERR="10^Error updating TRANSACTION word-processing field ERROR: "_$G(PRCERR("DIERR","1","TEXT",1))
 ..Q
 .Q
XLOG ;EXIT
 L -^PRCV(414.06,PRCTIEN)
 ; A Hang command is needed because multiple calls to this API in succession may lead to an attempt to overwrite.
 H 1
 ; No kills needed, variables were Newed.
 Q
 ; API TO RETURN A SINGLE RECORD'S MULTIPLE EVENTS.
 ;Called as DATA^PRCHJTA(IEN,.OUTPUT,.ERR)
 ;Input:
 ;      IEN- Internal entry number of a record in 414.06
 ;Output:
 ;      OUTPUT- Array holding the data from all events of a transaction record.
 ;      OUTPUT(IFCAP REFERENCE NUMBER, EVENT DATE, EVENT TYPE,0)= External Reference Number^Transaction Status^HL7 Message ID^Station^Sub-station^eCMS User^eCMS Phone^eCMS eMail^Returned/Canceled Date^Returned/Canceled Reason^Comments
 ;      OUTPUT(IFCAP REFERENCE NUMBER, EVENT DATE, EVENT TYPE,n)= Error line n (repeating: n=1 thru number of lines)
 ;      ERR- First "^" piece equals "1" if no record exists for the IEN passed in.
DATA(IEN,OUTPUT,ERR) ;
 N IEN0,EVENT,E0,E1,E2,LINE,TYPE,TYPETXT
 I '$D(^PRCV(414.06,IEN,0)) S ERR="1^RECORD DOES NOT EXIST" G XDATA
 S IEN0=^PRCV(414.06,IEN,0)
 S EVENT=0
 F  S EVENT=$O(^PRCV(414.06,IEN,1,EVENT)) Q:+EVENT=0  D
 .S E0=$G(^PRCV(414.06,IEN,1,EVENT,0))
 .S E1=$G(^PRCV(414.06,IEN,1,EVENT,1))
 .S E2=$G(^PRCV(414.06,IEN,1,EVENT,2))
 .S TYPE=$P(E0,"^",2) Q:TYPE=""  D TYPE
 .S OUTPUT($P(IEN0,"^"),$P(E0,"^"),TYPE,0)=$P(IEN0,"^",2)_"^"_TYPETXT_"^"_$P(E0,"^",3)_"^"_$P(E1,"^")_"^"_$P(E1,"^",2)_"^^"_$P(E1,"^",5)_"^"_$P(E1,"^",6)_"^"_$P(E1,"^",7)_"^"_$P(E2,"^")_"^"_$P(E2,"^",2)
 .S LINE=0
 .F  S LINE=$O(^PRCV(414.06,IEN,1,EVENT,3,LINE)) Q:+LINE=0  D
 ..S OUTPUT($P(IEN0,"^"),$P(E0,"^"),TYPE,LINE)=^PRCV(414.06,IEN,1,EVENT,3,LINE,0)
 ..Q
 .Q
 Q
XDATA ;EXIT
 Q
TYPE  ; set TYPE and TYPETXT
 I $G(TYPE)'="" D
 . S:(TYPE="2237 SENT")!(TYPE=1) TYPE=1,TYPETXT="2237 SENT"
 . S:(TYPE="2237 ACKNOWLEDGED")!(TYPE=2) TYPE=2,TYPETXT="2237 ACKNOWLEDGED"
 . S:(TYPE="2237 APPLICATION ERROR")!(TYPE=3) TYPE=1,TYPETXT="2237 APPLICATION ERROR"
 . S:(TYPE="2237 RESENT")!(TYPE=4) TYPE=4,TYPETXT="2237 RESENT"
 . S:(TYPE="RETURN TO ACCOUNTABLE OFFICER")!(TYPE=6) TYPE=6,TYPETXT="RETURN TO ACCOUNTABLE OFFICER"
 . S:(TYPE="RETURN TO AO ACK")!(TYPE=7) TYPE=7,TYPETXT="RETURN TO AO ACK"
 . S:(TYPE="RETURN TO CONTROL POINT")!(TYPE=8) TYPE=8,TYPETXT="RETURN TO CONTROL POINT"
 . S:(TYPE="RETURN TO CP ACK")!(TYPE=9) TYPE=9,TYPETXT="RETURN TO CP ACK"
 . S:(TYPE="2237 CANCELED")!(TYPE=10) TYPE=10,TYPETXT="2237 CANCELED"
 . S:(TYPE="2237 CANCEL ACK")!(TYPE=11) TYPE=11,TYPETXT="2237 CANCEL ACK"
 . Q
 Q
CONTACT(NAME) ; Call to transform the data for use within the "ACONTACT" xref for 414.06;10;6 ECMS EMAIL field
 N PRCC,PRCL,PRCF,PRCR,PRCN
 S PRCC=$P(NAME,"@",1),PRCL=$L(PRCC,".")
 S PRCF=$P(PRCC,".",PRCL)
 S PRCR=""
 F PRCN=1:1:(PRCL-1) S PRCR=PRCR_" "_$P(PRCC,".",PRCN)
 S PRCC=PRCF_PRCR
 S PRCC=$$UP^XLFSTR(PRCC)
 Q PRCC
