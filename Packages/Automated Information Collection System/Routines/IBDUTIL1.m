IBDUTIL1 ;ALB/SS - GENERIC UTILITIES ;16-AUG-11
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;APR 24, 1997;Build 80
 ;
 ;
 Q
 ;
 ;
 ;example
 ;adds text to Word Processing field
 ;IBDFILE - file #
 ;IBDIENS - "IEN,"
 ;IBDFLD - field #
 ;IBDFLG - flags "A" to append, "K" to lock and check locks 
 ;IBDARR - arrays with data (see example below)
 ;returns:
 ; 1- success
 ; -1 -failure
 ;example:
 ; S IBDARR(1,0)="Line 1"
 ; S IBDARR(2,0)="Line 2"
 ; I $$UPDWD^IBD3P63(357.61,"175,1",".01","KA","IBDARR")=0 W "OKAY"
UPDWD(IBDFILE,IBDIENS,IBDFLD,IBDFLG,IBDARR) ;
 N IBDERR
 D WP^DIE(IBDFILE,IBDIENS,IBDFLD,IBDFLG,"IBDARR","IBDERR")
 I $D(IBDERR("DIERR")) Q -1
 Q 1
 ;/**
 ;Creates a new entry (or node for multiple with .01 field)
 ;
 ;IBDFILE - file/subfile number
 ;IBDIEN - ien of the parent file entry in which the new subfile entry will be inserted
 ;IBDZFDA - array with values for the fields
 ; format for IBDZFDA:
 ; IBDZFDA(.01)=value for #.01 field
 ; IBDZFDA(3)=value for #3 field
 ;IBDRECNO -(optional) specify IEN if you want specific value
 ; Note: "" then the system will assign the entry number itself.
 ;IBDFLGS - FLAGS parameter for UPDATE^DIE
 ;IBDLCKGL - fully specified global reference to lock
 ;IBDLCKTM - time out for LOCK, if LOCKTIME=0 then the function will not lock the file 
 ;IBDNEWRE - optional, flag = if 1 then allow to create a new top level record 
 ;  
 ;output :
 ; positive number - record # created
 ; <=0 - failure
 ;
 ;example:
 ; S ZZ(.01)="ZZSS TEST",ZZ(.06)=1,ZZ(.09)=0 W $$INSREC^IBDUTIL1(357.6,"",.ZZ,"")
INSREC(IBDFILE,IBDIEN,IBDZFDA,IBDRECNO,IBDFLGS,IBDLCKGL,IBDLCKTM,IBDNEWRE) ;*/
 I ('$G(IBDFILE)) Q "0^Invalid parameter"
 I +$G(IBDNEWRE)=0 I $G(IBDRECNO)>0,'$G(IBDIEN) Q "0^Invalid parameter"
 ;I $G(IBDZFDA(.01))="" Q "0^Null"
 N IBDSSI,IBDIENS,IBDERR,IBDFDA
 N IBDLOCK S IBDLOCK=0
 I '$G(IBDRECNO) N IBDRECNO S IBDRECNO=$G(IBDRECNO)
 I IBDIEN'="" S IBDIENS="+1,"_IBDIEN_"," I $L(IBDRECNO)>0 S IBDSSI(1)=+IBDRECNO
 I IBDIEN="" S IBDIENS="+1," I $L(IBDRECNO)>0 S IBDSSI(1)=+IBDRECNO
 M IBDFDA(IBDFILE,IBDIENS)=IBDZFDA
 I $L($G(IBDLCKGL)) L +@IBDLCKGL:(+$G(IBDLCKTM)) S IBDLOCK=$T I 'IBDLOCK Q -2  ;lock failure
 D UPDATE^DIE($G(IBDFLGS),"IBDFDA","IBDSSI","IBDERR")
 I IBDLOCK L -@IBDLCKGL
 I $D(IBDERR) Q -1  ;D BMES^XPDUTL(IBDERR("DIERR",1,"TEXT",1))
 ;I $D(IBDERR) D BMES^XPDUTL($G(IBDERR("DIERR",1,"TEXT",1),"Update Error")) Q -1  ;D BMES^XPDUTL(IBDERR("DIERR",1,"TEXT",1))
 Q +$G(IBDSSI(1))
 ;
 ;
 ;/**
 ;another version of the INSREC above - in case you need just one #.01 field to create a new record 
 ;IBDVAL01 - .01 value for the new entry
 ;See INSREC for description of other parameters and return values
 ;
 ;Examples
 ;top level:
 ; W $$INSREC01^IBDUTIL1(366.14,"",IBDATE,"")
 ; W $$INSREC01^IBDUTIL1(357.6,"","ZZ TEST","")
 ;to create with the specific ien
 ; W $$INSREC01^IBDUTIL1(9002313.77,"",55555555,45555,,,,1)
 ; 
 ;1st level multiple:
 ; subfile number = #366.141
 ; parent file #366.14 entry number = 345
 ; W $$INSREC01(366.141,345,"SUBMIT","")
 ; to create multiple entry with particular entry number = 23
 ; W $$INSREC01(366.141,345,"SUBMIT",23)
 ;
 ;2nd level multiple
 ;parent file #366.14 entry number = 234
 ;parent multiple entry number = 55
 ;create multiple entry INSURANCE
 ; W $$INSREC01(366.1412,"55,234","INS","")
 ; results in :
 ; ^IBCNR(366.14,234,1,55,5,0)=^366.1412PA^1^1
 ; ^IBCNR(366.14,234,1,55,5,1,0)=INS
 ; ^IBCNR(366.14,234,1,55,5,"B","INS",1)=
 ;  (DD node for this multiple =5 ) 
INSREC01(IBDFILE,IBDIEN,IBDVAL01,IBDRECNO,IBDFLGS,IBDLCKGL,IBDLCKTM,IBDNEWRE) ;*/
 I ('$G(IBDFILE)) Q "0^Invalid parameter"
 I +$G(IBDNEWRE)=0 I $G(IBDRECNO)>0,'$G(IBDIEN) Q "0^Invalid parameter"
 N IBDFDAZ
 S IBDFDAZ(.01)=IBDVAL01
 Q $$INSREC(IBDFILE,IBDIEN,.IBDFDAZ,IBDRECNO,$G(IBDFLGS),$G(IBDLCKGL),$G(IBDLCKTM),$G(IBDNEWRE))
 ;
 ;
 ;populate multiple fields at once
 ;Input:
 ;IBDFILEN file number
 ;IBDIEN ien string 
 ;IBDVALAR new values (internal format) in the format
 ; IBDVALAR(IBDFLDNO)=values
 ; where IBDFLDNO - the field number
 ; example:
 ; IBDVALAR(.01)=value for #.01 field
 ; IBDVALAR(3)=value for #3 field
 ;IBDFLAG - null (for internal format)  or "E" (for external format with validation)
 ;Output:
 ;0 if failure
 ;1 if success
 ; example: see $$UPD35703^IBDUTICD 
MULTFLDS(IBDFILEN,IBDIEN,IBDVALAR,IBDFLAG) ;
 I '$G(IBDFILEN) Q "0^Invalid parameter"
 I '$G(IBDIEN) Q "0^Invalid parameter"
 N IBDIENS,IBDFDA,IBDERARY
 S IBDIENS=IBDIEN_","
 M IBDFDA(IBDFILEN,IBDIENS)=IBDVALAR
 D FILE^DIE($G(IBDFLAG),"IBDFDA","IBDERARY")
 I $D(IBDERARY) Q 0
 Q 1
 ;
 ;populate a single database field
 ;Input:
 ;IBDFILEN file number
 ;IBDFLDNO field number
 ;IBDIEN ien string 
 ;IBDVAL new value to file (internal format)
 ;IBDFLAG - null (for internal format)  or "E" (for external format with validation)
 ;Output:
 ;0^IBDVAL^error if failure
 ;1^IBDVAL if success
SINGLFLD(IBDFILEN,IBDFLDNO,IBDIEN,IBDVAL,IBDFLAG) ;
 I '$G(IBDFILEN) Q "0^Invalid parameter"
 I '$G(IBDFLDNO) Q "0^Invalid parameter"
 I '$G(IBDIEN) Q "0^Invalid parameter"
 I $G(IBDVAL)="" Q "0^Null"
 N IBDIENS,IBDFDA,IBDERARY
 S IBDIENS=IBDIEN_","
 S IBDFDA(IBDFILEN,IBDIENS,IBDFLDNO)=IBDVAL
 D FILE^DIE($G(IBDFLAG),"IBDFDA","IBDERARY")
 I $D(IBDERARY) Q "0^"_IBDVAL_"^"_IBDERARY("DIERR",1,"TEXT",1)
 Q "1^"_IBDVAL
 ;
 ;/**
 ;enter free text like comments
 ;IBDPROM  -prompt string
 ;IBDMXLEN -maxlen
FREETEXT(IBDPROM,IBDMXLEN) ;*/
 N DIR,DTOUT,DUOUT,IBDQ
 I '$D(IBDPROM) S IBDPROM="Enter a text "
 I '$D(IBDMXLEN) S IBDMXLEN=40
 S DIR(0)="FO^0:250"
 S DIR("A")=IBDPROM
 S DIR("?",1)="This response must have no more than "_IBDMXLEN_" characters"
 S DIR("?")="and must not contain embedded up arrow."
 S IBDQ=0
 F  D  Q:+IBDQ'=0
 . D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) S IBDQ=-1 Q
 . I $L(Y)'>IBDMXLEN S IBDQ=1 Q
 . W !!,"This response must have no more than "_IBDMXLEN_" characters"
 . W !,"and must not contain embedded uparrow.",!
 . S DIR("B")=$E(Y,1,IBDMXLEN)
 Q:IBDQ<0 "^"
 Q Y
 ;
 ;Standard Yes/No PROMPT:
 ;
 ;Parameters:
 ;    IBDPROM  = Text to be displayed before read
 ;    IBDDFLT    = YES, NO or <Null>
 ;    IBDOPT     = 1 - Answer optional       0 - Answer required
 ;    IBDTMOUT = Number of seconds
 ;
 ;Returns:
 ;    <null>     = No response             <^> - Up-arrow entered
 ;    <-1>       = Timeout occurred       <^^> - Two up-arrows entered
 ;    <0>        = No                      <1> - Yes
 ;
YESNO(IBDPROM,IBDDFLT,IBDOPT,IBDTMOUT) ;EP
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 Q:$G(IBDPROM)="" ""
 ;
 S $P(DIR(0),"^",1)="Y"_$S(IBDOPT=1:"O",1:"")
 S DIR("A")=IBDPROM
 S:$G(IBDDFLT)'="" DIR("B")=IBDDFLT
 S:+$G(IBDTMOUT)>0 DIR("T")=IBDTMOUT
 D ^DIR
 Q $S($G(DTOUT)=1:-1,$G(DIROUT)=1:"^^",$G(DUOUT)=1:"^",1:Y)
 ;
 ;
 ;fill fields
 ;Input:
 ;IBDFILNO file number
 ;IBDFIELD field number
 ;IBDIEN ien string 
 ;IBDNEWVL new value to file (internal format)
 ;Output:
 ;0^ IBDNEWVL^error if failure
 ;1^ IBDNEWVL if success
 ;Example:
 ; W $$FILLFLDS^IBDUTIL1(357.1,.01,227,"AA SHAVKAT DIAGNOSIS")
 ; 1^AA SHAVKAT DIAGNOSIS
FILLFLDS(IBDFILNO,IBDFIELD,IBDIEN,IBDNEWVL) ;
 I '$G(IBDFILNO) Q "0^Invalid parameter"
 I '$G(IBDFIELD) Q "0^Invalid parameter"
 I '$G(IBDIEN) Q "0^Invalid parameter"
 I $G(IBDNEWVL)="" Q "0^Null"
 N IBDIENS,IBDFDA,IBDERARY
 S IBDIENS=IBDIEN_","
 S IBDFDA(IBDFILNO,IBDIENS,IBDFIELD)=IBDNEWVL
 D FILE^DIE("","IBDFDA","IBDERARY")
 I $D(IBDERARY) Q "0^"_IBDNEWVL_"^"_IBDERARY("DIERR",1,"TEXT",1)
 Q "1^"_IBDNEWVL
 ;
 ;IBDUTIL1
