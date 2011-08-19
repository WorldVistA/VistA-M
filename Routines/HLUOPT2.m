HLUOPT2 ;CIOFO-O/LJA - Purging Entries in file #772 and #773 ;12/13/02 14:03
 ;;1.6;HEALTH LEVEL SEVEN;**98**;Oct 13, 1995
 ;
DELBODY(IEN772,APP,STORE) ; Delete the body of a message.  
 ; (See patch HL*1.6*98 for complete details.)
 ;
 ; (Call here ONLY if the message, and all related ACK messages
 ; have been successfully completed!)
 ;
 N NOLN,NOW,SNO,SUB,X
 ;
 ; Has the message body already been deleted?  If so, quit...
 QUIT:'$D(^HL(772,+$G(IEN772),"IN"))  ;->
 ;
 ; Set up variable environment...
 S APP=$G(APP),STORE=$G(STORE),NOW=$$NOW^XLFDT
 ;
 ; Get the number lines and delete data...
 S NOLN=$O(^HL(772,+IEN772,"IN",":"),-1)
 KILL ^HL(772,+IEN772,"IN")
 ;
 ; Get subscript for XTMP data about to be stored.  Make sub 0 entry prn.
 S SUB=$$XTMP0($$DT^XLFDT)
 ;
 ; Get storage number...
 S SNO=$O(^XTMP(SUB,":"),-1)+1
 ;
 ; Store deletion information...
 S ^XTMP(SUB,SNO,0)=NOW_U_APP_U_NOLN_U_$G(XQY0)_U_$G(ZTSK)
 ;
 ; Quit if user doesn't want @STORE data stored...
 QUIT:STORE']""  ;->
 ;
 ; Store STORE data...
 KILL X S X="I "_STORE D ^DIM I $D(X) MERGE ^XTMP(SUB,SNO,"S")=@STORE
 ;
 QUIT
 ;
XTMP0(DATE) ; Return subscript for ^XTMP data...
 N SUB
 S SUB="HLUOPT2 "_DATE
 S:'$D(^XTMP(SUB,0)) ^XTMP(SUB,0)=$$FMADD^XLFDT(DATE,7)_U_$$NOW^XLFDT_U_"HLUOPT2 Message Body Deletion"
 QUIT SUB
 ;
EOR ; HLUOPT2 - Purging Entries in file #772 and #773
