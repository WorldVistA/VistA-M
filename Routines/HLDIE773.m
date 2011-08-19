HLDIE773 ;CIOFO-O/LJA - Direct 772 & 773 Sets ; 11/18/2003 11:17
 ;;1.6;HEALTH LEVEL SEVEN;**109,115**;Oct 13,1995
 ;
 ;
F301 ; 773 - .01 - 0;1   [B] - DATE/TIME ENTERED
 D UPD^HLDIE772(0,1,VALUE)
 S XRF("B")=""
 Q
 ;
F32 ; 773 - 2 - 0;2   [C,AH] - MESSAGE ID
 D UPD^HLDIE772(0,2,VALUE)
 S XRF("C")="",XRF("AH")=""
 Q
 ;
F3202 ; 773 - 2.02 - 2;2 - FAST PURGE DT/TM
 ; Only fire ^HLMA(AI) xref when STATUS is changed...
 D UPD^HLDIE772(2,2,VALUE)
 Q
 ;
F33 ; 773 - 3 - 0;3 - TRANSMISSION TYPE
 D UPD^HLDIE772(0,3,VALUE)
 Q
 ;
F34 ; 773 - 4 - 0;4 - PRIORITY
 D UPD^HLDIE772(0,4,VALUE)
 Q
 ;
F35 ; 773 - 5 - 0;5 - HEADER TYPE
 D UPD^HLDIE772(0,5,VALUE)
 Q
 ;
F36 ; 773 - 6 - 0;6   [AF] - INITIAL MESSAGE
 D UPD^HLDIE772(0,6,VALUE)
 S XRF("AF")=""
 Q
 ;
F37 ; 773 - 7 - 0;7   [AC] - INITIAL MESSAGE
 ; Under no circumstances should DD create AC; only by package!
 D UPD^HLDIE772(0,7,VALUE)
 Q
 ;
F38 ; 773 - 8 - 0;8 - SUBSCRIBER PROTOCOL
 D UPD^HLDIE772(0,8,VALUE)
 Q
 ;
F39 ; 773 - 9 - 0;9 - SECURITY
 D UPD^HLDIE772(0,9,VALUE)
 Q
 ;
F310 ; 773 - 10 - 2;1 - DON'T PURGE
 D UPD^HLDIE772(2,1,VALUE)
 Q
 ;
F311 ; 773 - 11 - 1;1 - CONTINUATION POINTER
 D UPD^HLDIE772(1,1,VALUE)
 Q
 ;
F312 ; 773 - 12 - 0;10 - ACKNOWLEDGEMENT TO
 D UPD^HLDIE772(0,10,VALUE)
 Q
 ;
F313 ; 773 - 13 - 0;11 - SENDING APPLICATION
 D UPD^HLDIE772(0,11,VALUE)
 Q
 ;
F314 ; 773 - 14 - 0;12   [ae->AH] - RECEIVING APPLICATION
 D UPD^HLDIE772(0,12,VALUE)
 S XRF("AH")=""
 Q
 ;
F315 ; 773 - 15 - 0;13 - MESSAGE TYPE
 D UPD^HLDIE772(0,13,VALUE)
 Q
 ;
F316 ; 773 - 16 - 0;14 - EVENT TYPE
 D UPD^HLDIE772(0,14,VALUE)
 Q
 ;
F320 ; 773 - 20 - P;1   [AG,AI(index)] - STATUS
 N LINK,WAY
 ;
 D UPD^HLDIE772("P",1,VALUE)
 S XRF("AG")="",XRF("AI")=""
 ;
 ; Quit if status isn't being set to SUCCESSFULLY COMPLETED...
 QUIT:VALUE'=3  ;->
 ;
 ; Get AC's logical link IEN from new field...
 S WAY=$P($G(NODE(0,0)),U,3) QUIT:WAY']""  ;->
 ;
 S LINK=$S(WAY="O":$P($G(NODE(0,0)),U,7),1:$P($G(NODE(0,0)),U,17)) QUIT:LINK'>0  ;->
 QUIT:+$G(IEN)'>0  ;->
 ;
 KILL ^HLMA("AC",WAY,LINK,+IEN)
 ;
 Q
 ;
F321 ; 773 - 21 - P;2 - STATUS UPDATE DATE/TIME
 D UPD^HLDIE772("P",2,VALUE)
 Q
 ;
F322 ; 773 - 22 - P;3 - ERROR MESSAGE
 D UPD^HLDIE772("P",3,VALUE)
 Q
 ;
F323 ; 773 - 23 - P;4 - ERROR TYPE
 D UPD^HLDIE772("P",4,VALUE)
 Q
 ;
F324 ; 773 - 24 - P;5 - TRANSMISSION ATTEMPTS
 D UPD^HLDIE772("P",5,VALUE)
 Q
 ;
F325 ; 773 - 25 - P;6 - OPEN ATTEMPTS
 D UPD^HLDIE772("P",6,VALUE)
 Q
 ;
F326 ; 773 - 26 - P;7 - ACK TIMEOUT
 D UPD^HLDIE772("P",7,VALUE)
 Q
 ;
F3100 ; 773 - 100 - S;1   [AD] - DATE/TIME PROCESSED
 ; Only fire ^HLMA(AI) xref when STATUS is changed...
 D UPD^HLDIE772("S",1,VALUE)
 S XRF("AD")=""
 Q
 ;
F3200 ; 773 - 200 - MSH - MSH
 ; VALUE is set in EDITALL^HLDIE to the name of the local array
 ; holding the MSH segment.  Use it...
 N NO,TXT
 ;
 ; Set MSH itself into global...
 S NO=0,NO(1)=""
 F  S NO=$O(@VALUE@(NO)) Q:NO'>0  D
 .  S TXT=$G(@VALUE@(NO)) QUIT:TXT']""  ;->
 .  S ^HLMA(+IEN,"MSH",NO,0)=TXT
 .  S NO(1)=NO
 ;
 ; Add MSH header...
 S ^HLMA(+IEN,"MSH",0)="^773.01^"_NO(1)_"^"_NO(1)
 ;
 Q
 ;
 ; =================================================================
 ;
XRFAC ; AC XRF kills/sets...
 ; Under no circumstances should DD create AC; only by package!
 Q
 ;
XRFAD ; AD XRF kills/sets...
 D XRFSET^HLDIE772(FILE,+IEN,"AD","S",1)
 Q
 ;
XRFAF ; AF XRF kills/sets...
 D XRFSET^HLDIE772(FILE,+IEN,"AF",0,6)
 Q
 ;
XRFAG ; AG XRF kills/sets...
 D XRFSET^HLDIE772(FILE,+IEN,"AG","P",1)
 Q
 ;
XRFAH ; AH XRF kills/sets...
 D XRFSETC^HLDIE772(FILE,+IEN,"AH",0,12,0,2)
 Q
 ;
XRFAI ; AI INDEX code...
 S STATUS=$P($G(NODE("P",1)),U)
 D PXREF^HLUOPTF1(+$G(IEN),STATUS)
 Q
 ;
XRFB ; B XRF kills/sets...
 D XRFSET^HLDIE772(FILE,+IEN,"B",0,1)
 Q
 ;
XRFC ; C XRF kills/sets...
 D XRFSET^HLDIE772(FILE,IEN,"C",0,2)
 Q
 ;
XRFFPD(IEN772,FPDOLD,FPDNEW) ; This API is called by XRFFPD^HLDIE772 when 
 ; a 772 Fast Purge Date/time has been changed.  
 ;
 ; ASSUMPTION:  The Fast Purge Date/time should be the same in both
 ;              772 and 773 entries.
 ;
 ; ASSUMPTION:  If the Fast Purge Date/time is changed in 773, the
 ;              same value should be "echoed" (set into) file 772.
 ;              and vice versa.
 ;
 ; ASSUMPTION:  The Fast Purge Date/time will NEVER be set unless
 ;              the STATUS of both 772 and 773 entries is equal to
 ;              SUCCESSFULLY COMPLETED.  (For this reason, the status
 ;              will never be checked.
 ;
 ; The purpose of this call from 772 is to...
 ;
 ; * Kill all ^HLMA("AI") xrefs using the old Fast Purge Date/time
 ;   for both files 772 and 773.
 ; * Reset the Fast Purge Date/time in all 773 entries associated with
 ;   the 772 entry whose Fast Purge Date/time field was just changed.
 ; * Recreate the ^HLMA("AI") xrefs based on the new Fast Purge 
 ;   Date/time.
 ;
 N IEN773
 ;
 ; Checks of data...  (Code commented per Jim Moore's suggestion. LJA)
 ; QUIT:$G(^HL(772,+IEN772,0))']""  ;->
 ; QUIT:FPDOLD'?7N1"."1.N  ;-> Check the original Fast Purge Date/time...
 ; QUIT:FPDNEW'?7N1"."1.N  ;-> Check the new date...
 ; QUIT:FPDOLD=FPDNEW  ;->  No change!
 ;
 ; Kill old 772 AI entry...
 KILL ^HLMA("AI",FPDOLD,772,+IEN772) ; Kill 772 parent AI...
 ;
 ; Remove old 773 entries...
 S IEN773=0
 F  S IEN773=$O(^HLMA("B",+IEN772,IEN773)) Q:'IEN773  D
 .  KILL ^HLMA("AI",FPDOLD,773,+IEN773) ; Kill 773 child AI...
 .  S $P(^HLMA(+IEN773,2),U,2)=FPDNEW ; Set 773 to match 772...
 ;
 ; Now, all AI xrefs killed, and the Fast Purge Date/time in both 772
 ; and 773 are set to the new value, so set the new xrefs...
 S IEN773=0
 F  S IEN773=$O(^HLMA("B",+IEN772,IEN773)) Q:'IEN773  D
 .  D PXREF^HLUOPTF1(+IEN773,3)
 ;
 Q
 ;
XRFLLCT ; LLCNT^HLCSTCP(IEN870,3) XRF kills/sets...
 ;XXX D LLCNT^HLCSTCP(IEN870,3)
 Q
 ;
EOR ;HLDIE773 - Direct 772 & 773 Sets ; 11/18/2003 11:17
