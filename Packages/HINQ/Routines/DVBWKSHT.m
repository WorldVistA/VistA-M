DVBWKSHT ;ALB/CP/JD - CAPRI 2507 Worksheet Updates; July 11, 2023@14:08 ; 3/20/24 3:55pm
 ;;2.7;AMIE;**252**;Apr 10, 1995;Build 92
 ; Per VHA Directive 6402 this routine should not be modified
 ; Reference to $$NOW^XLFDT and $$FMTE^XLFDT in ICR #10103
 ; Reference to UP^XLFSTR in ICR #10104
 Q
 ;
 ;Added DVBF1 (Acceptable Clinical Evidence (ACE)) as a new parameter for CAPRI-13939.  JD - 10/3/24
 ;Added DVBF12 (IEPD version number) as a new parameter - CAPRI-9566.  JD - 4/23/24
 ;Adding check for Signed worksheet to block Document Manager Update CAPRI-12506 CP 7-31-24
WKSHTSAVE(DVBRTN,DVBIEN,DVBAUTH,DVBTRAN,DVBDBQ,DVBF19,DVBF20,DVBF21,DVBF12,DVBF1) ;
 ; 
 ;K DIC,DIE,DA,DR,DLAYGO,X,Y
 N DVBERROR,DVBTEMPER,DVBLRTN,DVBDTTM,DVBLOCKDT
 S DVBUPDFG=""
 ; 
 I DVBAUTH'="" D
 . I DVBAUTH'?1.N S DVBRTN(1)="-1^Invalid Format" Q
 . ;;Adding check for Locked worksheet CAPRI-12506 CP 7-30-24
 . S DVBLOCKDT=$P($G(^DVB(396.17,DVBIEN,0)),U,5)
 . I DVBLOCKDT'="2800101" S DVBRTN(1)="-1^Worksheet is Signed and Locked, Can not Update Document Manager" Q
 . S DVBAFDA(396.17,DVBIEN_",",2)=DVBAUTH
 . K DVBTEMPER D FILE^DIE(,"DVBAFDA","DVBTEMPER")
 . I $G(DVBTEMPER)'="" M DVBERROR=DVBTEMPER
 . I $G(DVBTEMPER)="" S DVBRTN(1)="1^Document Manager has been updated",DVBUPDFG=1
 . Q
 I DVBTRAN'="" D
 . I DVBTRAN'?1.N S DVBRTN(2)="-1^Invalid Format" Q
 . S DVBAFDA(396.17,DVBIEN_",",10)=DVBTRAN
 . K DVBTEMPER D FILE^DIE(,"DVBAFDA","DVBTEMPER")
 . I $G(DVBTEMPER)'="" M DVBERROR=DVBTEMPER
 . I $G(DVBTEMPER)="" S DVBRTN(2)="1^Transcriber has been updated",DVBUPDFG=1
 . Q
 I DVBDBQ'="" D
 . I "YN"'[DVBDBQ S DVBRTN(3)="-1^Invalid Format" Q
 . S DVBAFDA(396.17,DVBIEN_",",25)=DVBDBQ
 . K DVBTEMPER D FILE^DIE(,"DVBAFDA","DVBTEMPER")
 . I $G(DVBTEMPER)'="" M DVBERROR=DVBTEMPER
 . I $G(DVBTEMPER)="" S DVBRTN(3)="1^DBQ Referral has been updated",DVBUPDFG=1
 . Q
 I DVBF19'="" D
 . I "01@"'[DVBF19 S DVBRTN(4)="-1^Invalid Format" Q
 . S DVBAFDA(396.17,DVBIEN_",",19)=DVBF19
 . K DVBTEMPER D FILE^DIE(,"DVBAFDA","DVBTEMPER")
 . I $G(DVBTEMPER)'="" M DVBERROR=DVBTEMPER
 . I $G(DVBTEMPER)="" S DVBRTN(4)="1^New Flag has been updated",DVBUPDFG=1
 . Q
 I DVBF20'="" D
 . I "01@"'[DVBF20 S DVBRTN(5)="-1^Invalid Format" Q
 . S DVBAFDA(396.17,DVBIEN_",",20)=DVBF20
 . K DVBTEMPER D FILE^DIE(,"DVBAFDA","DVBTEMPER")
 . I $G(DVBTEMPER)'="" M DVBERROR=DVBTEMPER
 . I $G(DVBTEMPER)="" S DVBRTN(5)="1^Green Flag has been updated",DVBUPDFG=1
 . Q
 I DVBF21'="" D
 . I "01@"'[DVBF21 S DVBRTN(6)="-1^Invalid Format" Q
 . S DVBAFDA(396.17,DVBIEN_",",21)=DVBF21
 . K DVBTEMPER D FILE^DIE(,"DVBAFDA","DVBTEMPER")
 . I $G(DVBTEMPER)'="" M DVBERROR=DVBTEMPER
 . I $G(DVBTEMPER)="" S DVBRTN(6)="1^Exclamation Flag has been updated",DVBUPDFG=1
 . Q
 ;Next IF block is added for CAPRI-9566.
 I DVBF12'="" D
 . I $L(DVBF12)<2!($L(DVBF12)>250) S DVBRTN(7)="-1^IEPD version number is free text between 2 and 250 characters long" Q
 . S DVBAFDA(396.17,DVBIEN_",",12)=DVBF12
 . K DVBTEMPER D FILE^DIE(,"DVBAFDA","DVBTEMPER")
 . I $G(DVBTEMPER)'="" M DVBERROR=DVBTEMPER
 . I $G(DVBTEMPER)="" S DVBRTN(7)="1^IEPD version number has been updated",DVBUPDFG=1
 . Q
 ;Next IF block is added for CAPRI-13939.
 I $G(DVBF1)'="" D
 . N DVBF1S
 . S DVBF1S=$$UP^XLFSTR($E(DVBF1))
 . I "YN"'[DVBF1S S DVBRTN(8)="-1^Acceptable Clinical Evidence (ACE) is a Yes/No field.  Received: "_DVBF1 Q
 . S DVBAFDA(396.17,DVBIEN_",",1)=DVBF1S
 . K DVBTEMPER D FILE^DIE(,"DVBAFDA","DVBTEMPER")
 . I $G(DVBTEMPER)'="" M DVBERROR=DVBTEMPER
 . I $G(DVBTEMPER)="" S DVBRTN(8)="1^Acceptable Clinical Evidence (ACE) has been updated",DVBUPDFG=1
 . Q
 I DVBUPDFG'="" D
 . S DVBDTTM=$$NOW^XLFDT
 . S DVBAFDA(396.17,DVBIEN_",",4)=DVBDTTM
 . K DVBTEMPER D FILE^DIE(,"DVBAFDA","DVBTEMPER")
 . I $G(DVBTEMPER)'="" M DVBERROR=DVBTEMPER
 . I $G(DVBTEMPER)="" S DVBRTN(0)="1^Updated Record Date/Time"
 . Q
 I $G(DVBERROR)'="" S DVBRTN("ERR")=DVBERROR
 ;Added DVBF12 to the list
 ;Added DVBF1 to the list
 K DVBAFDA,DVBAUTH,DVBTRAN,DVBDBQ,DVBF1,DVBF12,DVBF19,DVBF20,DVBF21,DVBERROR,DVBTEMPER,DVBLRTN,DVBDTTM,DVBUPDFG,DVBLOCKDT
 Q
