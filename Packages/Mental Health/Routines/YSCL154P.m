YSCL154P ; HEC/hrubovcak - NCC Pre-install;1 Oct 2019 12:31:04
 ;;5.01;MENTAL HEALTH;**154**;Dec 30, 1994;Build 48
 ;
 Q
 ;
START ;
 D DT^DICRW
 N Y,YSCNTR,YSDA,YSFLD,YSFMERR,YSMSG,YSTRGT
 D XTMPZRO^YSCLTST5  ; update ^XTMP("YSCLTRN",0)
 D XTMPZRO^YSCLDIS  ; update ^XTMP("YSCLDIS",0)
 ; YSCNTR - error count
 S YSTRGT="YSCL DAILY TRANSMISSION",YSCNTR=0
 D ADD2TXT(.YSMSG,YSTRGT_" information in file #19.2:")
 D  ; check that the option is scheduled
 . S YSDA=$$FIND1^DIC(19.2,"","B",YSTRGT,"","","YSFMERR")
 . I '(YSDA>0) D  Q
 ..  D ADD2TXT(.YSMSG,"*** WARNING *** The option is NOT scheduled.")
 ..  D ADD2TXT("This MUST be scheduled to run in TaskMan.")
 ..  S YSCNTR=1
 . ;
 . S YSFLD=2,Y=$$GET1^DIQ(19.2,YSDA,YSFLD) S:'$L(Y) YSCNTR=YSCNTR+1
 . D ADD2TXT(.YSMSG,"  QUEUED TO RUN AT WHAT TIME: "_$S($L(Y):Y,1:" * Time not found! *"))
 . S YSFLD=6,Y=$$GET1^DIQ(19.2,YSDA,YSFLD) S:'$L(Y) YSCNTR=YSCNTR+1
 . D ADD2TXT(.YSMSG,"  RESCHEDULING FREQUENCY: "_$S($L(Y):Y,1:" * Frequency not found! *"))
 . S YSFLD=12,Y=$$GET1^DIQ(19.2,YSDA,YSFLD) S:'$L(Y) YSCNTR=YSCNTR+1
 . D ADD2TXT(.YSMSG,"  TASK ID: "_$S($L(Y):Y,1:" * Task not found! *"))
 . I 'YSCNTR D  Q  ; no errors found
 ..  D ADD2TXT(.YSMSG,"No issues found for the "_YSTRGT_" option.")
 . S Y=YSCNTR_" error"_$E("s",'(YSCNTR=1))_" found for the Option."
 ;
 I YSCNTR D
 . D ADD2TXT(.YSMSG," ")  ; skip a line
 . D ADD2TXT(.YSMSG,"The "_YSTRGT_" Option should be scheduled to be run daily,")
 . D ADD2TXT(.YSMSG," in the early AM hours with no DEVICE.")
 ;
 S Y=0 F  S Y=$O(YSMSG(Y)) Q:'Y  D MES^XPDUTL(YSMSG(Y,0))
 Q
 ;
ADD2TXT(TXT,L) ; TXT passed by ref. - add L to TXT array in W-P format
 Q:'$L($G(L))  ; must have text
 S TXT(0)=$G(TXT(0))+1,TXT(TXT(0),0)=L Q
 ;
