ONCOUK ;WISC/MLH - ONCOLOGY UTILITY - CROSS REFERENCES ;7/1/93  17:44
 ;;2.11;ONCOLOGY;**5**;Mar 07, 1995
 ;
RX ;Reindex data files
 ;Called by routine ONCOPOS
 ;Called by option ONCO #SITE-REINDEX DATA FILES
 W !!,"This option will reindex the ONCOLOGY PATIENT, ONCOLOGY PRIMARY and ONCOLOGY"
 W !,"CONTACT files.",!
 S DIR("A")="Are you sure you want to do this",DIR("B")="No",DIR(0)="Y"
 D ^DIR Q:(Y=0)!(Y["^")!(Y="")
 D RX1
 I 'EX D RX2,RX3,RX4
 QUIT
 ;
RX1 S EX=0 D XRF1 Q
RX2 S ONCORX=1 D XRF2 Q  ;    Reindex 165.5 - inhibit writing
RX3 D XRF3 Q  ;    Reindex 165
RX4 D XRF4 Q  ;    Reindex 160.1
 ;
XRF1 ;REINDEX 160
 I '$D(NW) W !!!,?15,"Re-indexing ONCOLOGY PATIENT File (#160)..."
 F I="APC","ACP","AD","AS","ADX","AFS","ASM","B","C","CN","D" K ^ONCO(160,I)
 F I="APC","ACP" K ^ONCO(165,I)
 ;"F" CROSS REFERENCE
 S XD0=0 F  S XD0=$O(^ONCO(160,XD0)) Q:XD0'>0  F I="AA","B" K ^ONCO(160,XD0,"F",I)
XRF ;CROSS REF MULTIPLE & UPDATE
 I '$D(NW) W !!?10,"Reindexing Follow-up Multiple",!
 L +^ONCO(160):1 I '$T S DIR("A")="Can't LOCK file #160...TRY AGAIN",DIR(0)="Y",DIR("B")="Yes" D ^DIR S EX=$S('Y:1,Y="^":1,1:0) Q:EX  G XRF
 S J=0,XD0=0 F  S XD0=$O(^ONCO(160,XD0)) Q:XD0'>0  S J=J+1 W:'(J#10) "." D XD0
 ;Reindex main
MF L -^ONCO(160) S DIK="^ONCO(160," D IXALL^DIK
 W !?10,"DONE re-indexing file #160" Q
 ;
XD0 ;ENTER WITH D0=XD0
 S X=0 F  S X=$O(^ONCO(160,XD0,"F",X)) Q:X'>0  S LC=$P(^(X,0),U),^ONCO(160,XD0,"F","AA",(9999999-LC),X)="",^ONCO(160,XD0,"F","B",LC,X)=""
 ;last date contact
 S FLC=$O(^ONCO(160,XD0,"F","B",0))
LD S LLC=$O(^ONCO(160,XD0,"F","AA",0)) Q:LLC=""  S I=$O(^(LLC,0)),LD=$G(^ONCO(160,XD0,"F",I,0)) Q:LD=""
 S LC=$P(LD,U),VS=$P(LD,U,2),CS=$P(LD,U,3),FM=$P(LD,U,4),QS=$P(LD,U,5),NM=$P(LD,U,6) I VS="" S VS=1,$P(^ONCO(160,XD0,"F",I,0),U,2)=VS
 I CS="" S CS=9,$P(^ONCO(160,XD0,"F",I,0),U,3)=CS
 I FM="",FLC'=LLC S $P(^ONCO(160,XD0,"F",I,0),U,4)=0
 I QS="" S $P(^ONCO(160,XD0,"F",I,0),U,5)=$S(VS=0:8,1:9)
 S NM=$S(VS=0:9,NM="":0,1:NM),$P(^ONCO(160,XD0,"F",I,0),U,6)=NM
 S FS=$S(NM<8:1,VS=0:0,1:0) I FS S X1=DT,X2=LC D ^%DTC I X>456.25 S FS=8
 S $P(^ONCO(160,XD0,1),U)=VS,$P(^(1),U,7)=FS,$P(^(1),U,4)=$S(VS=0:9,1:0),$P(^(1),U,8)=$S(VS=0:LC,1:"") I 'FS S $P(^ONCO(160,XD0,1),U,2)="" Q
NF S NF=$E(LC,1,3)+1_$E(LC,4,5)_"00",$P(^ONCO(160,XD0,1),U,2)=NF W:'(XD0#100) "*"
 Q
 ;
XRF2 ;RE-INDEX FILE 165.5
 W !!!?15,"Re-indexing ONCOLOGY PRIMARY File (#165.5)..." F I="APC","ACP" K ^ONCO(165,I)
 F I="AA","AAY","AAY1","AC","ACAY","ACF","ACS","AD","ADX","AE","AF","AG","AG1","AGC","AH","AS","AS1","ASG1","ASG","ATB","ATC","ATH","ATO","ATP","ATS","ATX","AY","B","C","D","D1" K ^ONCO(165.5,I)
 S DIK="^ONCO(165.5," D IXALL^DIK W !?10,"DONE Re-indexing file #165.5"
 Q
 ;
XRF3 ;RE-INDEX FILE 165
 W !!!?15,"Re-indexing ONCOLOGY CONTACT File (#165)..." F I="B","C","B1","B2","B3","B4" K ^ONCO(165,I) S DIK="^ONCO(165," D IXALL^DIK
 W !?10,"DONE Re-indexing file #165"
 Q
 ;
XRF4 ;160.1
 W !!!?15,"Re-indexing ONCOLOGY SITE PARAMETERS File (#160.1)..."
 S DIK="^ONCO(160.1," D IXALL^DIK
 W !?10,"DONE Re-indexing file #160.1"
 Q
 ;
KEY55 ;    Assign new .01 fields to ONCOLOGY PRIMARY File (#165.5)
 ;    (based on topographies not histologies)
 N ONCOPI S ONCOPI=0 ;    primary file index
 FOR  S ONCOPI=$O(^ONCO(165.5,ONCOPI)) Q:ONCOPI'=+ONCOPI  D
 .  N ONCOTOP S ONCOTOP=$P($G(^ONCO(165.5,ONCOPI,2)),U) ;    ICDO topography
 .  IF ONCOTOP,$E(ONCOTOP,1,2)=67 D  ;    a valid topography code exists
 ..    N ONCOSITE S ONCOSITE=$P(^ONCO(164,ONCOTOP,0),U,13) ;    new site group
 ..    IF $P(^ONCO(165.5,ONCOPI,0),U)'=ONCOSITE D  ;    change it
 ...      N DIE S DIE="^ONCO(165.5," ;    file to change
 ...      N DR S DR=".01///^S X=+ONCOSITE" ;    field to change
 ...      N DA S DA=ONCOPI ;    entry # to edit
 ...      D ^DIE ;    change the entry
 ...      W:$D(WRTFLG) "." ;DA,?10,ONCOTOP,?20,ONCOSITE,!
 ...      Q
 ..    ;END IF
 ..    ;
 ..    Q
 .  ;END IF
 .  ;
 .  Q
 ;END FOR
 ;
 QUIT
