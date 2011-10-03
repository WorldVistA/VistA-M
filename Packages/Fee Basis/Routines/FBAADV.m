FBAADV ;AISC/GRR-FLAG VENDOR FOR DELETION IN CENTRAL FEE ; 8/28/09 12:35pm
 ;;3.5;FEE BASIS;**111**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 D DT^DICRW
RD W !! S DIC(0)="AEQM",DIC="^FBAAV(" D ^DIC G END:X="^"!(X=""),RD:Y<0 S DA=+Y I $$CKVEN(DA) W !!?5,*7,"Unable to delete, vendor is Awaiting Austin Approval." G RD
ASK S DIR(0)="Y",DIR("A")="Are you sure you want to place this vendor in delete status",DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT) END W !! I 'Y W *7,"Not Deleted" G RD
 S DIE="^FBAAV(",DR="9////Y;13////^S X=DT" D LOCK^FBUCUTL(DIE,DA) I FBLOCK D ^DIE L -^FBAAV(DA) K DIE W !!,*7,"Vendor flagged for deletion!" G RD
 W !!,*7,"Unable to delete vendor record at this time." G RD
END K FBZ,X,DIC,DIRUT,Y,DA,FBLOCK Q
CKVEN(FBVIEN) ;Checks to see if a change or add is pending in the Fee Basis Vendor Corrections file (#161.25)
 ;fbvien = internal entry # of vendor from Fee Basis Vendor file (#161.2)
 ;output: 1 = change or add awaiting austin approval, 0 = nothing pending, 2 = change or add on linked vendor awaiting austin approval
 N FBVC S FBVC=$P($G(^FBAA(161.25,FBVIEN,0)),U,2,3),FBVC=$TR(FBVC,U) Q $S(FBVC["C":1,FBVC["N":1,$D(^FBAA(161.25,+FBVIEN,0))!($D(^FBAA(161.25,"AF",+FBVIEN))):2,1:0)
