IBNCPUT1 ;BHAM ISC/SS - IB NCPDP UTILITIES ;22-MAR-2006
 ;;2.0;INTEGRATED BILLING;**342,363,384,550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Utilities for NPCDP
 ;/**
 ;Creates a new entry in the file or subfile with .01 field
 ;IBFILE - file/subfile #
 ;IBIEN - ien of the parent file entry in which the new subfile entry will be inserted
 ;IBVAL01 - .01 value for the new entry
 ;NEWRECNO -(optional) specify IEN if you want specific value
 ; Note: if "" then the system will assign the entry number itself.
 ;IBFLGS - FLAGS parameter for UPDATE^DIE
 ;
 ;Examples
 ;top level:
 ; INSITEM(366.14,"",IBDATE,"")
 ; INSITEM(366.14,"",IBDATE,45)
 ; 
 ;1st level multiple:
 ; subfile number = #366.141
 ; parent file #366.14 entry number = 345
 ; INSITEM(366.141,345,"SUBMIT","")
 ; to create mupltiple entry with particular entry number = 23
 ; INSITEM(366.141,345,"SUBMIT",23)
 ;
 ;2nd level multiple
 ;parent file #366.14 entry number = 234
 ;parent multiple entry number = 55
 ;create mupltiple entry INSURANCE
 ; INSITEM(366.1412,"55,234","INS","")
 ; results in :
 ; ^IBCNR(366.14,234,1,55,5,0)=^366.1412PA^1^1
 ; ^IBCNR(366.14,234,1,55,5,1,0)=INS
 ; ^IBCNR(366.14,234,1,55,5,"B","INS",1)=
 ;  (DD node for this muptiple =5 ) 
 ;  
 ;output :
 ; positive number - record # created
 ; <=0 - failure
 ;  See description above
INSITEM(IBFILE,IBIEN,IBVAL01,NEWRECNO,IBFLGS) ;*/
 N IBSSI,IBIENS,IBFDA,IBERR
 I '$G(NEWRECNO) N NEWRECNO S NEWRECNO=$G(NEWRECNO)
 I IBIEN'="" S IBIENS="+1,"_IBIEN_"," I $L(NEWRECNO)>0 S IBSSI(1)=+NEWRECNO
 I IBIEN="" S IBIENS="+1," I $L(NEWRECNO)>0 S IBSSI(1)=+NEWRECNO
 S IBFDA(IBFILE,IBIENS,.01)=IBVAL01
 D UPDATE^DIE($G(IBFLGS),"IBFDA","IBSSI","IBERR")
 I $D(IBERR) D BMES^XPDUTL(IBERR("DIERR",1,"TEXT",1)) Q -1  ;D BMES^XPDUTL(IBERR("DIERR",1,"TEXT",1)) 
 Q +$G(IBSSI(1))
 ;
 ;
 ;fill fields
 ;Input:
 ;FILENO file number
 ;FLDNO field number
 ;RECIEN ien string 
 ;NEWVAL new value to file
 ;Output:
 ;0^ NEWVAL^error if failure
 ;1^ NEWVAL if success
FILLFLDS(FILENO,FLDNO,RECIEN,NEWVAL) ;
 N RECIENS,FDA,ERRARR
 S RECIENS=RECIEN_","
 S FDA(FILENO,RECIENS,FLDNO)=NEWVAL
 D FILE^DIE("","FDA","ERRARR")
 I $D(ERRARR) Q "0^"_NEWVAL_"^"_ERRARR("DIERR",1,"TEXT",1)
 Q "1^"_NEWVAL
 ;
 ;convert external value of the field EVENT TYPE to its internal value
 ;IA# 10155
EXT2INT(IBEXTRN) ;
 N IBDD,IBZ,IBCNT,IBINTERN
 S IBINTERN=-1
 S IBDD=$P($G(^DD(366.141,.01,0)),U,3) ;IA# 10155
 F IBCNT=1:1 S IBZ=$P(IBDD,";",IBCNT) Q:IBZ=""  D  Q:IBINTERN'<0
 . I $P(IBZ,":",2)=IBEXTRN S IBINTERN=+IBZ
 Q:IBINTERN<0 0  ;treat as UNKNOWN
 Q IBINTERN
 ;
 ;
 ;should RX copay from the entry in file #350 be placed on hold ?
 ;called from HOLD^IBRUTL
 ;Input:
 ; X - zeroth node of file #350 entry
 ;output:
 ; 0 - NO - DO NOT PUT ON HOLD
 ; 1 - this is RX copay but there is no ECME claim, so process it as usual
 ; 1 - this is ECME RX copay and it should be put on HOLD
 ; 1 - this is ECME RX copay and it was rejected or reversed 
 ; 2 - this is not RX copay
HOLDECME(X) ;
 N IBRXIEN,IBREFNO,IBRXZ,IBDATE,IBDFN,IBEBCOB,IBRETVAL
 S IBRETVAL=""
 S IBRXZ=$P($G(X),U,4),(IBRXIEN,IBREFNO)=0
 I $P($P(IBRXZ,";"),":")'=52 Q 2  ;follow pre-existing logic
 S IBRXIEN=+$P($P(IBRXZ,";"),":",2) ;ien in file #52
 S IBREFNO=+$P($P($P(X,U,4),";",2),":",2) ;refill number (0 - for  original)
 S IBDFN=+$P($G(X),U,2) ;Patient ien
 ;if this is OTC "non-e-billable" drug then DO NOT PUT ON HOLD
 I $$OTCNEBIL(IBRXIEN,IBREFNO)=1 Q 0
 ;if this is non-OTC drug OR if this is OTC drug but marked as e-billable then look if it has zero amount paid
 I $$AMNTHOLD^IBNCPUT1(IBDFN,IBRXIEN,IBREFNO)=0 Q 0  ;DO NOT PUT ON HOLD
 Q 1  ;follow pre-existing logic
 ;
 ;should RX copay be placed on hold based on the PAID amount?
 ;input:
 ; IBDFN - patient's ien
 ; IBRX - file #52 ien
 ; IBREF - refill no
 ;output:
 ; 1 - YES
 ; 0 - NO
AMNTHOLD(IBDFN,IBRX,IBREF) ;
 N IBPAYRES ;for payer's response
 N IBADT
 ;
 S IBPAYRES=$$PAIDAMNT^BPSUTIL(IBRX,IBREF)
 ;if payable AND amount paid is zero AND does not have any other Pharmacy insurance 
 ;THEN return NO - it should not be put on hold
 I +IBPAYRES=1,$P(IBPAYRES,U,2)=0,'$$MOREINS^IBNCPNB(IBDFN,+$P(IBPAYRES,U,3)) Q 0
 Q 1
 ;Is this RX for OTC drug which is NOT E-billiable?
 ;Input:
 ; IBRX - ien in file #52
 ; IBREFNO - fill#
 ;Output:
 ; 1 - this is OTC drug and it is NOT marked as e-billable
 ; 0 - otherwise
OTCNEBIL(IBRX,IBREFNO) ;
 N ARR,IBSPHNDL,IBDRUG,IBELIG
 S IBDRUG=+$$RXAPI1^IBNCPUT1(IBRX,6,"I")
 S IBSPHNDL=$$DRUGDIE^IBNCPUT1(IBDRUG,3,"E",.ARR)
 I IBSPHNDL'["9" Q 0  ;this is not OTC drug
 S IBELIG=$S('IBREFNO:$$FILE^IBRXUTL(IBRX,85),1:$$SUBFILE^IBRXUTL(IBRX,IBREFNO,52,85))
 I $$BILLABLE^IBNCPDP(IBDRUG,IBELIG) Q 0 ; it is an OTC e-billable drug
 ;it is OTC NON E-billable drug
 Q 1
 ;
 ;Function to return field data from DRUG file (#50)
 ; Parameters
 ;  IBIEN50 - IEN of DRUG FILE #50
 ;  IBFLDN - Field Number(s) (like .01)
 ;  IBEXIN - Specifies internal or external value of returned field
 ;         - optional, defaults to "I"
 ;  IBARR50 - Array to return value(s).  Optional.  Pass by reference.
 ;           See EN^DIQ documentation for variable DIQ
 ;
 ; Function returns field data if one field is specified.  If
 ;   multiple fields, the function will return "" and the field
 ;   values are returned in IBARR50
 ; Example: W $$DRUGDIE^IBNCPUT1(134,25,"E",.ARR)
DRUGDIE(IBIEN50,IBFLDN,IBEXIN,IBARR50) ; Return field values for Drug file 
 I $G(IBIEN50)=""!($G(IBFLDN)="") Q ""
 N DIQ,PSSDIY
 N IBDIQ
 I $G(IBEXIN)'="E" S IBEXIN="I"
 S IBDIQ="IBARR50",IBDIQ(0)=IBEXIN
 D EN^PSSDI(50,"IB",50,.IBFLDN,.IBIEN50,.IBDIQ)
 Q $G(IBARR50(50,IBIEN50,IBFLDN,IBEXIN))
 ;
 ;/*
 ;Function to return a value for a SINGLE field of file #52
 ;DBIA 4858
 ;input:
 ; IBIEN52 - ien of file #52
 ; IBFLDN - one single field, for example ".01"
 ; IBFORMAT - 
 ;  "E" for external format
 ;  "I" - internal 
 ;  "N" - do not return nulls
 ;  default is "E"
 ;output:
 ; returns a field value or null (empty string) 
 ; examples:
 ;W $$RXAPI1^IBNCPUT1(504733,6,"E")
 ;ALBUMIN 25% 50ML
 ;W $$RXAPI1^IBNCPUT1(504733,6,"I")
 ;134
RXAPI1(IBIEN52,IBFLDN,IBFORMAT) ;*/
 N DIQ,DIC,IBARR,X,Y,D0,PSODIY
 N I,J,C,DA,DRS,DIL,DI,DIQ1
 N IBDIQ
 S IBDIQ="IBARR"
 S IBDIQ(0)=$S($G(IBFORMAT)="":"E",1:IBFORMAT)
 D DIQ^PSODI(52,52,.IBFLDN,.IBIEN52,.IBDIQ) ;DBIA 4858
 Q $S(IBDIQ(0)="N":$G(IBARR(52,IBIEN52,IBFLDN)),1:$G(IBARR(52,IBIEN52,IBFLDN,IBDIQ(0))))
 ;
 ;
 ;IBNCPUT1
