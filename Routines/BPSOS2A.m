BPSOS2A ;BHAM ISC/FCS/DRS/DLF - continuation of BPSOS2 ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;Statistics & Misc Options Screen - Zero Stats
 ;
 ;Protocol - BPS P2 ZERO - clearing stats
ZERO N ZTYP,X
 S ZTYP=$$SELZTYP() I ZTYP="^" W !!!,"Nothing changed.",! D ANY
 I ZTYP'="^" D
 .I $$SURE'=1 W !!!,"Nothing changed.",! D ANY Q
 .;
 .;Clear Local Stats
 .I ZTYP=0 D ZLOCAL
 .;
 .;Clear Permanent Stats
 .I ZTYP=1 D ZPERM,FETCHES^BPSOS2(0) ; fetch all these zeroes into BASE(*)
 D UPD^BPSOS2
 S VALMBCK=""
 Q
 ;
 ;Zero Local Statistics
 ;
 ;Reset Base Numbers to Current Numbers
ZLOCAL K BASE M BASE=CURR
 Q
 ;
 ;Zero Permanent Statistics
 ; This logic will create a strange order - Record 1 is always the newest.
 ; Record 2 will be the oldest, Record 3 is next oldest, etc.
ZPERM N FILE
 S FILE=9002313.58
 L +^BPSECX("S"):300 I '$T W "LOCK failed",! Q
 ;
 ; Increment zero node for the database
 N I,N
 F I=3,4 D
 . S N=$P(^BPSECX("S",0),U,I)+1
 . S $P(^BPSECX("S",0),U,I)=N
 ;
 ; Merge current data into new record
 S N=$P(^BPSECX("S",0),U,3)
 M ^BPSECX("S",N)=^BPSECX("S",1)
 S $P(^BPSECX("S",N,0),U)=N ; fix up the .01 field
 N DIK,DA S DIK="^BPSECX(""S"",",DA=N D IX^DIK ; trivial indexing
 ;
 ; Update fields to be zero, except date/time cleared
 N FIELD S FIELD=.01
 F  S FIELD=$O(^DD(FILE,FIELD)) Q:'FIELD  D
 . N VALUE
 . I FIELD=2 D  ; date/time last cleared
 .. N %,%H,%I,X D NOW^%DTC S VALUE=%
 . E  S VALUE=0
 . N DIE,DA,DR S DIE=FILE,DA=1,DR=FIELD_"////"_VALUE D ^DIE
 ;
 ; Unlock record
 L -^BPSECX("S")
 Q
 ;
SELZTYP() ;
 N DFLT,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT="Local Copy"
 S DIR(0)="S^L:Local Copy;P:Permanent Copy",DIR("A")="Delete (L)ocal Copy or (P)ermanent Copy of the statistics",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="P":1,Y="L":0,1:Y)
 Q Y
 ;
SURE(DEF) ;
 N SURE,PMT,OPT,ANS
 S PMT="Are you sure"
 I '$D(DEF) S DEF="N"
 S OPT=1 ; answer is optional
 S ANS=$$YESNO^BPSOSU3(PMT,DEF,OPT)
 Q ANS ; 1 or 0 or -1 or ^ or ^^ or null
ANY ;EP
 W:$X ! D PRESSANY^BPSOSU5() Q  ; Press any key
