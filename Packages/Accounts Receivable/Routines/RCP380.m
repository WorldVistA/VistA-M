RCP380 ;AITC/MBS - Patch PRCA*4.5*380 Post Installation Processing ; 9/9/21 10:34am
 ;;4.5;Accounts Receivable;**380**;Sep 9, 2021;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 Q
POST ;
 D IX3443
 Q
IX3443 ; Build new ADEP2 index in file #344.3
 N DIK
 D BMES^XPDUTL("Creating index by deposit number and deposit date on EDI LOCKBOX DEPOSIT file (#344.3)")
 S DIK="^RCY(344.3,",DIK(1)=".06^ADEP2" D ENALL^DIK
 Q
