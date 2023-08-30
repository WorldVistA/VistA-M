IBCNEUT2 ;DAOU/DAC - eIV MISC. UTILITIES ;06-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,416,435,713,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Can't be called from the top
 Q
 ;
SAVETQ(IEN,TDT) ;  Update service date in TQ record
 ;
 N DIE,DA,DR,D,D0,DI,DIC,DQ,X
 S DIE="^IBCN(365.1,",DA=IEN,DR=".12////"_TDT
 D ^DIE
 Q
 ;
 ;
SST(IEN,STAT) ;  Set the Transmission Queue Status
 ;  Input parameters
 ;    IEN = Internal entry number for the record
 ;    STAT= Status IEN
 ;
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X
 ;
 I IEN="" Q
 ;
 S DIE="^IBCN(365.1,",DA=IEN,DR=".04////^S X=STAT;.15////^S X=$$NOW^XLFDT()"
 D ^DIE
 Q
 ;
RSP(IEN,STAT) ;  Set the Response File Status
 ;  Input parameters
 ;    IEN = Internal entry number for the record
 ;    STAT= Status IEN
 ;
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X
 S DIE="^IBCN(365,",DA=IEN,DR=".06////^S X=STAT"
 D ^DIE
 Q
 ;
BUFF(BUFF,BNG) ;  Set error symbol into Buffer File
 ;  Input Parameter
 ;    BUFF = Buffer internal entry number
 ;    BNG = Buffer Symbol IEN
 I 'BUFF!'BNG Q
 I +$P($G(^IBA(355.33,BUFF,0)),U,17) Q    ; .12 field not for ePharmacy IB*2*435
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X,DISYS
 S DIE="^IBA(355.33,",DA=BUFF,DR=".12////^S X=BNG"
 D ^DIE
 Q
 ;
BADMSG(EXT,QUERY) ; Checks to see if the msg is allowed
 ; IB*713 Introduced this tag, checks for foreign characters as defined
 ;        in FOREIGN^IBCNINSU. If foreign characters are encountered, some 
 ;        times the msg can't be created/sent via HL7. Other times, if you
 ;        clear out the field with the foreign character you can still send
 ;        the message.  (Watch for the STOP variable.)
 ;        This could be expanded in the future to check other scenarios that
 ;        should stop the transmissions.
 ;
 ;INPUT:
 ;  EXT = WHICH EXTRACT (#365.1,.1)
 ;  QUERY = QUERY FLAG(#365.1,.11)
 ;  PID, IN1, HLFS, HLECH - existing global variables
 ;  GT1 global variable that may or may not exist
 ;
 ;OUTPUT: 0 - Continue with creating and sending HL7 msg
 ;        1 - Do not send this TQ entry out as a HL7 msg
 ;            * NOTE: If Abort, this function sets the
 ;              TRANSMISSION QUEUE (#365.1,.04) to "Cancelled"
 ;
 N FLD,HCT,SEG,STOP,TMP
 S HCT="",STOP=0
 F  S HCT=$O(^TMP("HLS",$J,HCT)) Q:'HCT  S SEG=$P(^(HCT),HLFS,1),TMP(SEG)=HCT
 ;
 ; Regular 270 Messages
 I (EXT=1)!(EXT=2)!(EXT=5)!(EXT=6) D  G BADMSGX
 . I $$FOREIGN^IBCNINSU($P(PID,HLFS,6),"1;2;3;4;5;6") S STOP=1 Q   ;PID-5 PATIENT NAME
 . I $$FOREIGN^IBCNINSU($P(IN1,HLFS,3)) S STOP=1 Q                 ;IN1-2 PATIENT/SUBSCRIBER ID
 . I $D(GT1) D  I STOP Q
 .. I $$FOREIGN^IBCNINSU($P(GT1,HLFS,3)) S STOP=1 Q                ;GT1-2 SUBSCRIBER ID
 .. I $$FOREIGN^IBCNINSU($P(GT1,HLFS,4),"1;2;3;4;5;6") S STOP=1 Q  ;GT1-3 SUBSCRIBER NAME
 . ;
 . ;If foreign chars encountered clear field and continue with msg
 . ;
 . ; PID-11 Addr (street,ignore,city,state,zip)
 . S FLD=$P(PID,HLFS,12) I $$FOREIGN^IBCNINSU(.FLD,"1;3;4;5",1) S $P(PID,HLFS,12)=FLD ;PID-11
 . S FLD=$P(IN1,HLFS,9) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(IN1,HLFS,9)=FLD ;IN1-8 GROUP NUMBER
 . S FLD=$P(IN1,HLFS,10) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(IN1,HLFS,10)=FLD ;IN1-9 GROUP NAME
 . ;
 . I $D(GT1) D
 .. ; GT1-6 Addr (street,ignore,city,state,zip)
 .. S FLD=$P(GT1,HLFS,7) I $$FOREIGN^IBCNINSU(.FLD,"1;3;4;5",1) S $P(GT1,HLFS,7)=FLD ;GT1-6
 ;
 ; EICD-Identifications (aka A1 msgs)
 ; [Asking clearinghouse if they know insurance for this patient]
 I (EXT=4),(QUERY="I") D  G BADMSGX
 . I $$FOREIGN^IBCNINSU($P(PID,HLFS,6),"1;2;3;4;5;6") S STOP=1 Q  ;PID-5 PATIENT NAME
 . ; PID-11 Addr (ignore,ignore,city,state,zip)
 . I $$FOREIGN^IBCNINSU($P(PID,HLFS,12),"3;4;5") S STOP=1 Q       ;PID-11
 . ;
 . ;If foreign chars encountered clear field and continue with msg
 . ;
 . S FLD=$P(PID,HLFS,12) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(PID,HLFS,12)=FLD ;PID-11-1 ADDR STREET
 ;
 ; EICD-Verification (aka A2 msgs)
 ; [Confirming policies clearinghouse found for VA]
 I (EXT=4),(QUERY="V") D  G BADMSGX
 . I $$FOREIGN^IBCNINSU($P(PID,HLFS,6),"1;2;3;4;5;6") S STOP=1 Q  ;PID-5 PATIENT NAME
 . I $$FOREIGN^IBCNINSU($P(IN1,HLFS,3)) S STOP=1 Q                ;IN1-2 PATIENT/SUBSCRIBER ID
 . I $D(GT1) D  I STOP Q
 .. I $$FOREIGN^IBCNINSU($P(GT1,HLFS,3)) S STOP=1 Q                ;GT1-2 SUBSCRIBER ID
 .. I $$FOREIGN^IBCNINSU($P(GT1,HLFS,4),"1;2;3;4;5;6") S STOP=1 Q  ;GT1-3 SUBSCRIBER NAME
 . ;
 . ;If foreign chars encountered clear field and continue with msg
 . ;
 . ; PID-11 Addr (street,ignore,city,state,zip)
 . S FLD=$P(PID,HLFS,12) I $$FOREIGN^IBCNINSU(.FLD,"1;3;4;5",1) S $P(PID,HLFS,12)=FLD ;PID-11
 . S FLD=$P(IN1,HLFS,9) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(IN1,HLFS,9)=FLD ;IN1-8 GROUP NUMBER
 . S FLD=$P(IN1,HLFS,10) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(IN1,HLFS,10)=FLD ;IN1-9 GROUP NAME
 . I $D(GT1) D
 .. ; GT1-6 Addr (street,ignore,city,state,zip)
 .. S FLD=$P(GT1,HLFS,7) I $$FOREIGN^IBCNINSU(.FLD,"1;3;4;5",1) S $P(GT1,HLFS,7)=FLD ;GT1-6
 ;
 ; MBI REQUEST
 I EXT=7 D  G BADMSGX
 . I $$FOREIGN^IBCNINSU($P(PID,HLFS,6),"1;2;3;4;5;6") S STOP=1 Q  ;PID-5 SUBSCRIBER NAME
 . ;
 . ;If foreign chars encountered clear field and continue with msg
 . ;
 . ; PID-11 Addr (street,ignore,city,state,zip)
 . S FLD=$P(PID,HLFS,12) I $$FOREIGN^IBCNINSU(.FLD,"1;3;4;5",1) S $P(PID,HLFS,12)=FLD   ;PID-11
 ;
BADMSGX ;Exit BADMSG
 I 'STOP D
 . S HCT=$G(TMP("PID")) I HCT S ^TMP("HLS",$J,HCT)=PID
 . S HCT=$G(TMP("IN1")) I HCT S ^TMP("HLS",$J,HCT)=IN1
 . S HCT=$G(TMP("GT1")) I HCT S ^TMP("HLS",$J,HCT)=GT1
 Q STOP
