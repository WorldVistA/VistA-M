PRCA444P ;MNTVBB/AJR - Update for Annual Interest Rate in File 342 AR SITE PARAMETER ;11/18/24
 ;;4.5;Accounts Receivable;**444**;Mar 20, 1995;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ;ENTRY POINT
 ; Call the Global Backup Tag (Backs up entire file to XTMP and sets the GLBRSTR node
 ; used to prevent a rerun of the backup and update, that would result in
 ; overwriting the backup file unintentionally)
 N GLBKUP
 D GLBBKUP
 I $D(GLBKUP) Q
 ; Initiate Update
 D PRCANEW
 Q
 ;
PRCANEW ;Add new rates in File 342 AR SITE PARAMETER
 N X,Y,PRCAEFF
 D BMES^XPDUTL("** Updating AR SITE PARAMETER (#342) file **")
 S DA(1)=0 S DA(1)=$O(^RC(342,DA(1)))
 S X=999999 S X=$O(^RC(342,DA(1),4,X),-1)
 S PRCAEFF=$P($G(^RC(342,DA(1),4,X,0)),U)
 I PRCAEFF="3250101" D  Q
 .S DA=X
 .S DIE="^RC(342,"_DA(1)_",4,",DR=".01///3250101;.02///.05;.03///1.51;.04///.06;.05///378.40"
 .D ^DIE
 .K DIE,DR,DA,DA(1)
 .D BMES^XPDUTL("** Done **")
 .Q
 S X=X+1
 K DO
 S DIC="^RC(342,"_DA(1)_",4,",DIC(0)="L",DIC("DR")=".01///3250101;.02///.05;.03///1.51;.04///.06;.05///378.40"
 D FILE^DICN I Y=-1 D PRCAERR Q
 K DA(1),DIC
 D BMES^XPDUTL("** Done **") Q
PRCAERR ;Message to the user that an error occurred.
 D BMES^XPDUTL("*** AN ERROR OCCURRED WHEN ATTEMPTING TO ADD NEW FILE ENTRIES. PLEASE CONTACT PRODUCT SUPPORT ***")
 Q
 ;
GLBBKUP  ; XTMP Backup of file(s)
 S PRCA444P="PRCA444P-Update for Annual Interest Rate in File 342 AR SITE PARAMETER"
 S ^XTMP("PRCA444P",0)=$$FMADD^XLFDT(DT,120)_"^"_DT
 M ^XTMP("PRCA444P",342,$H)=^RC(342)
 Q
 ;
