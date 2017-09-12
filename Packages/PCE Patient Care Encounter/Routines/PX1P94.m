PX1P94 ;PB - Cleanup Unresolved entries in Problem (#9000011) file ; 07/13/00
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**94**;Aug 12, 1996
 ;
 ;
START ; Entry point
 N DA,DR,DIE
 N IEN,ICD9CODE,LEXCODE,LEXS
 S (ICD9CODE,IEN,LEXCODE)=0
 ; Search for Unresolved entries
 F  S IEN=$O(^AUPNPROB("C",1,IEN)) Q:IEN=""  D
 .S ICD9CODE=$$GETICD(IEN) Q:ICD9CODE=-1  ; Get ICD9 Code
 .S LEXCODE=$$GETLEXCD(ICD9CODE) ; Get Lexicon Code
 .I LEXCODE=-1!(LEXCODE=1) Q
 .; Edit File entry to include Lexicon code for problem
 .S DR="1.01////^S X=LEXCODE",DIE="9000011",DA=IEN
 .D ^DIE
 Q
 ;
GETLEXCD(ICD9CODE) ; Retrieve Lexicon Code for passed ICD9 code
 NEW LEXS,LEXCD
 S LEXCD=-1
 D EN^LEXCODE(ICD9CODE)
 I $G(LEXS("ICD",0))>0 S LEXCD=$P($G(LEXS("ICD",1)),"^",1)
 Q LEXCD
 ;
GETICD(IEN) ; Retrieve ICD9 code
 NEW ICDPTR,ICD9C
 ; PTR to ICD9 file
 S ICDPTR=$P($G(^AUPNPROB(IEN,0)),U,1) Q:ICDPTR="" -1
 I '$D(^ICD9(ICDPTR)) Q -1
 S ICD9C=$P($G(^ICD9(ICDPTR,0)),U,1) ; ICD9 Code
 Q ICD9C
 ;
