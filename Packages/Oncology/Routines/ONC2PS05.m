ONC2PS05 ;Hines OIFO/RTK - Post-Install Routine for Patch ONC*2.2*5 ;09/3/15
 ;;2.2;ONCOLOGY;**5**;Jul 31, 2013;Build 6
 ;
 N RC
 ;NEW Washington DC production server.
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:83/cgi_bin/oncsrv.exe")
 ;NEW Washington DC test server, comment out for final release.
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:81/cgi_bin/oncsrv.exe")
 ;
 D ADDSPS,ADDOSFO,TNMADD,DELOPT,CNVFPST
 K ONC164N,ONCSNAME Q
 ;
ADDSPS ;Add text to 5TH ED-SURGERY PRIMARY SITE (#111) multiple field-code #15
 ;for entry 67340 (LUNG) of the ICDO TOPOGRAPGY (#164) file
 S ONC164N=$O(^ONCO(164,67340,"SPS","C",15,"")) Q:ONC164N=""
 S DIE="^ONCO(164,67340,""SPS"","
 S DA(1)=67340,DA=ONC164N,ONCSNAME="Local tumor destruction, NOS; RFA"
 S DR=".01///^S X=ONCSNAME" D ^DIE
 K DA,DIE,DR
 Q
ADDOSFO ;Add new entries to the OTHER STAGING FOR ONCOLOGY (#164.3) file
 I '$D(^ONCO(164.3,"B","BCLC A0")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="BCLC A0" D FILE^DICN
 I '$D(^ONCO(164.3,"B","BCLC A1")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="BCLC A1" D FILE^DICN
 I '$D(^ONCO(164.3,"B","BCLC A2")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="BCLC A2" D FILE^DICN
 I '$D(^ONCO(164.3,"B","BCLC A3")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="BCLC A3" D FILE^DICN
 I '$D(^ONCO(164.3,"B","BCLC A4")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="BCLC A4" D FILE^DICN
 I '$D(^ONCO(164.3,"B","BCLC B")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="BCLC B" D FILE^DICN
 I '$D(^ONCO(164.3,"B","BCLC C")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="BCLC C" D FILE^DICN
 I '$D(^ONCO(164.3,"B","BCLC D")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="BCLC D" D FILE^DICN
 I '$D(^ONCO(164.3,"B","UNOS T1")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="UNOS T1" D FILE^DICN
 I '$D(^ONCO(164.3,"B","UNOS T2")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="UNOS T2" D FILE^DICN
 I '$D(^ONCO(164.3,"B","UNOS T3")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="UNOS T3" D FILE^DICN
 I '$D(^ONCO(164.3,"B","UNOS T4a")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="UNOS T4a" D FILE^DICN
 I '$D(^ONCO(164.3,"B","UNOS T4b")) D
 .S DIC="^ONCO(164.3,",DIC(0)="L",X="UNOS T4b" D FILE^DICN
 Q
TNMADD ;Add 88 to some T,N,M codes/help text for various entries in
 ;the ICDO TOPOGRAPGY (#164) file
 S ^ONCO(164,67440,11,13,0)="T88  NA"
 S $P(^ONCO(164,67440,11,0),"^",3)=13
 S $P(^ONCO(164,67440,11,0),"^",4)=13
 S ONCNWACT="S ACDANS=$$ADDDXST~ONCACDU1(IEN)"  ;set for all 3 extracts
 S DA=405,DA(1)=67440,DIE="^ONCO(164,"_DA(1)_",""N7"","
 S DR="4///^S X=ONCNWACT"
 D ^DIE
TESTZX9 ;Add 88 entry for 7TH ED N-CODE, 67440 IN (#164) file
 N D0,DA,DD,DIC,X,Y K DD,DO
 Q:$D(^ONCO(164,67440,"N7","B",88))
 S DA(1)=67440,DIC="^ONCO(164,"_DA(1)_",""N7"",",DIC(0)="L"
 F X=88 D FILE^DICN
 Q
DELOPT ;Delete ONCO ABSTRACT-BRIEF (80c) option from the ONCO ABSTRACT MENU
 S ZZDELO=$$DELETE^XPDMENU("ONCO ABSTRACT MENU","ONCO ABSTRACT-BRIEF 80")
 K ZZDELO
 Q
CNVFPST ;Convert/correct the FOLLOW-UP STATUS (#160, #15.2) field
 ; First Re-index "AFS" cross-reference on (file #160, field #15.2)
 ;IA #10013 - ENALL2^DIK and ENALL^DIK
 ;IA #10141 - BMES^XPDUTL
 N DIK
 S DIK="^ONCO(160,",DIK(1)="15.2^AFS"
 D BMES^XPDUTL("Re-indexing 'AFS' cross-reference of file #160...")
 D ENALL2^DIK ;Kill existing "AFS" cross-reference.
 D ENALL^DIK ;Re-create "AFS" cross-reference.
 D BMES^XPDUTL("Done Re-indexing the 'AFS' cross-reference...Converting FOLLOW-UP STATUS field...")
 ;
 ;SEARCH FOLLOW-UP SOURCE VALUES FOR PROBLEMS
 S ZZDOTS=0 F ZZFL=0:0 S ZZFL=$O(^ONCO(160,"AFS",ZZFL)) Q:ZZFL'>0  D
 .F ZZPT=0:0 S ZZPT=$O(^ONCO(160,"AFS",ZZFL,ZZPT)) Q:ZZPT'>0  D
 ..;CHECK IF PATIENT HAS SINGLE PRIMARY ONLY & CLASS OF CASE 00 OR 30-99
 ..S ZZPRI=0,ZZPRCNT=0,ZZDOTS=ZZDOTS+1 I ZZDOTS#100=0 W "."
 ..F  S ZZPRI=$O(^ONCO(165.5,"C",ZZPT,ZZPRI)) Q:ZZPRI'>0  D
 ...S ZZPRCNT=ZZPRCNT+1
 ..I ZZPRCNT=1 D  ; if patient has exactly 1 primary
 ...S ZZPRENT=$O(^ONCO(165.5,"C",ZZPT,0)) Q:ZZPRENT'>0  ; get primary IEN
 ...S ZZPRCOC=$P($G(^ONCO(165.5,ZZPRENT,0)),"^",4)  ; get the COC
 ...I ZZPRCOC=1!(ZZPRCOC>9) D
 ....S $P(^ONCO(160,ZZPT,1),"^",7)=0
 ....K ^ONCO(160,"AFS",ZZFL,ZZPT)
 ....S ^ONCO(160,"AFS",0,ZZPT)=""
 K ZZFL,ZZPT,ZZPRI,ZZPRCNT,ZZPRENT,ZZPRCOC
 Q
