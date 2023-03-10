PRCF223P ;MNTVBB/RGB - Cleanse Receiving queue of partial sets and update Authority file (410.9) ; 01/10/21@12:05
V ;;5.1;IFCAP;**223**;Jan 10, 2021;Build 16
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
START ;PRC*5.1*223 Updating file 410.9 [Authority of Request File] with new
 ;            sub authority 'Q', 'FRANCHISE FUND: VTP CLAIMS'
 D CLEAN1  ;Cleanse Receiving Report of incomplete filed transmission
 D SETAO  ;Set missing 'AO' index in file 410, field 4
 D UPDATE ;Update AUTHORITY OF REQUEST file
 Q
UPDATE ;Update Authority file 410.9
 N DIE,DA,DR,PRCI,PRCX,PRCIEN,PRCCD,PRCSUB,PRCDESC
 S U="^"
 S DIE="^PRCS(410.9,"
 F PRCI=1:1 S PRCX=$P($T(ADD+PRCI),";",3) Q:PRCX="QUIT"  D
 . S X=$P(PRCX,U,2),DLAYGO=410.9,DIC="^PRCS(410.9,",DIC(0)="LXZ" D ^DIC K DLAYGO G:Y<0 ERR
 . S (DA,PRCIEN)=+Y,PRCCD=$P(Y,U,2),PRCSUB=$P(PRCX,"^"),PRCDESC=$P(PRCX,"^",3)
 . S DR=".02///^S X=PRCDESC;.03///^S X=PRCSUB;.05///^S X=1;.06///^S X=1;.07///^S X=PRCSUB_PRCCD"
 . D ^DIE
 . D MES^XPDUTL("Updating Authority of Request Code "_PRCCD_PRCSUB_" - "_PRCDESC)
 D MES^XPDUTL(""),BMES^XPDUTL("**Update of Authority of Request File completed**")
 K DIC,X,Y
 Q
ADD ;;
 ;;3^Q^FRANCHISE FUND: VTP Claims
 ;;QUIT
ERR ;File add messed up!!
 ;
CLEAN1 ;Cleanse (FILE 442) fiscal signed receipts transmitted, but not filed correctly.
 N PRCIEN,PRCPART,PRCRECPT,PRCTOT
 K ^XTMP("PRCF223P")
 S ^XTMP("PRCF223P",0)=$$FMADD^XLFDT(DT,90)_"^"_DT
 S ^XTMP("PRCF223P",$J,0)="0"
 S (PRCIEN,PRCTOT)=0
A S PRCIEN=$O(^PRC(442,PRCIEN)),PRCPART=0 I 'PRCIEN G ZZ
A1 S PRCPART=$O(^PRC(442,PRCIEN,11,PRCPART)) I 'PRCPART G A
 S PRCRECPT=$G(^PRC(442,PRCIEN,11,PRCPART,0)) Q:PRCRECPT=""
 I $P(PRCRECPT,U,19)'["RR" G A1
 I $P(PRCRECPT,U,6)'="" G A1
 S ^XTMP("PRCF223P",$J,1,PRCIEN,11,PRCPART,0)=PRCRECPT,PRCTOT=PRCTOT+1
 S $P(^PRC(442,PRCIEN,11,PRCPART,0),U,6)="Y"
 ;W !!,PRCIEN,?12,$P(^PRC(442,PRCIEN,0),U),!,PRCRECPT
 G A1
ZZ S ^XTMP("PRCF223P",$J,1,0)=PRCTOT
 D MES^XPDUTL(""),BMES^XPDUTL("**Cleansing of Receiving Report completed: "_PRCTOT_" RESETS **")
 Q
SETAO ;Set 'AO' index for invalid sets in file 410, field 4 from routine PRCSEB
 N PRCSIEN,PRCTOT
B S (PRCSIEN,PRCTOT)=0
B1 S PRCSIEN=$O(^PRCS(410,PRCSIEN)) G BQ:'PRCSIEN
 S PRCSIP=$P($G(^PRCS(410,PRCSIEN,0)),U,6) G:'PRCSIP B1
 I $D(^PRCS(410,"AO",PRCSIP,PRCSIEN)) G B1
 S ^PRCS(410,"AO",PRCSIP,PRCSIEN)="",^XTMP("PRCF223P",$J,2,PRCSIEN,0)=PRCSIP
 ;W !,PRCSIEN,?15,PRCSIP
 S PRCTOT=PRCTOT+1
 G B1
BQ S ^XTMP("PRCF223P",$J,2,0)=PRCTOT
 D MES^XPDUTL(""),BMES^XPDUTL("** File 410, 'AO' index reset completed: "_PRCTOT_" RESETS **")
 Q
