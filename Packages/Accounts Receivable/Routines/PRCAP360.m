PRCAP360 ;SAB/Albany - PRCA*4.5*360 POST INSTALL;07/30/19 2:10pm
 ;;4.5;Accounts Receivable;**360**;Mar 20, 1995;Build 10
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for PRCA*4.5*360
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for PRCA*4.5*360 ")
 ; Adding AR CATEGORY
 D ARCAT
 ; rebuild cross-references
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for PRCA*4.5*360")
 Q
 ;
ARCAT ;AR CATEGORY ENTRY (430.2)
 N LOOP,FDA,FDAIEN,DATA,CHKIEN,NUM,NEWREC,SEMI2
 N DA,DIE,DLAYGO,DR,FUND,X,Y
 ;
 D MES^XPDUTL("     -> Adding new AR CATEGORY entries to file 430.2 ...")
 ; Add new AR categories
 S SEMI2=2  ; Two semicolons";;" counted for each field
 F LOOP=2:1 S DATA=$T(ARDATA+LOOP) Q:$P(DATA,";",3)="END"  D
 .S NEWREC=1 ; New record indicator
 .;Extract the new AR Category to be added.
 .;Check to insure that the AR Category doesn't exist already
 .S CHKIEN=""  ; Initialized the check variable
 .S CHKIEN=$O(^PRCA(430.2,"B",$P(DATA,";",3),"")) ;   Category Name (UNEDITABLE)
 .I +CHKIEN S NEWREC=0 D MES^XPDUTL($P(DATA,";",3)_" already exist and updating...")
 . K DD,DO,Y
 . S DLAYGO=430.2,DIC="^PRCA(430.2,",DIC(0)="L",X=$P(DATA,";",3)
 . ;
 . ; If no entry found, create a new entry
 . I '+CHKIEN D FILE^DICN S CHKIEN=+Y K DIC,DINUM,DLAYGO
 . ;
 .S DR=""
 .;                                                  Field# | Name of field
 .S:NEWREC=1 DR="1///"_$P(DATA,";",2+SEMI2)        ; 1      | Abbreviation (UNEDITABLE)
 .S DR=DR_";2///"_$P(DATA,";",3+SEMI2)             ; 2      | AMIS Seg # (UNEDITABLE)
 .S DR=DR_";3///"_$P(DATA,";",4+SEMI2)             ; 3      | GL Number
 .S DR=DR_";5///"_$P(DATA,";",5+SEMI2)             ; 5      | Type   (P,O,T,V,C,N)
 .S:NEWREC=1 DR=DR_";6////"_$P(DATA,";",6+SEMI2)   ; 6      | Category number (UNEDITABLE)
 .S DR=DR_";7///"_$P(DATA,";",7+SEMI2)             ; 7      | Receivable Code 
 .S DR=DR_";9///"_$P(DATA,";",11+SEMI2)            ; 9      | Interest
 .S DR=DR_";10///"_$P(DATA,";",9+SEMI2)            ;10      | Admin 
 .S DR=DR_";11///"_$P(DATA,";",10+SEMI2)           ;11      | Penalty 
 .S:NEWREC=1 DR=DR_";12///"_$P(DATA,";",11+SEMI2)  ;12      | Accrued (UNEDITABLE)
 .S DR=DR_";13///"_$P(DATA,";",12+SEMI2)           ;13      | Refund
 .S DR=DR_";14///"_$P(DATA,";",13+SEMI2)           ;14      | Paragraph Codes
 .; REFERRALS
 .S DR=DR_";1.01///1;"                             ;1.01    | Refer to DMC? 
 .S DR=DR_"1.02///2;"                              ;1.02    | Refer to TOP? 
 .S DR=DR_"1.03///3"                               ;1.03    | Refer to CS? 
 .;
 .I $E(DR,1)=";" S DR=$P(DR,";",2,$L(DR))          ; Remove ";" to update existing record with data specified in fields
 .;
 .S DIE="^PRCA(430.2,",DA=CHKIEN
 .D ^DIE
 S DA=CHKIEN,DIK="^IBE(430.2," D IX^DIK            ; Re-Index
 D MES^XPDUTL("        New AR CATEGORY added.")
 Q
 ; ACTUAL FIELD SETTINGS NEXT LINE
 ;;CC URGENT CARE;U1;240;1221;P;87;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;
 ; field    1      2  3   4   5  6 7 8 9 10111213
ARDATA ; New AR Category data. (Internal data format)
 ;;Category Name;Abbreviation;AMIS Seg #;GL Number;Type;AR Cat #;Receivable Code;Interest;Admin;Penalty;Accrued;Refund;Paragraph Codes
 ;;CC URGENT CARE;U1;240;1221;P;87;2;1;1;0;1;2;30,40,55,80,85,50,60,65,70
 ;;END
