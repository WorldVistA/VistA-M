PRSXP91 ;WCIOFO/MGD-CORRECT #457.5 ;01/26/2004
 ;;4.0;PAID;**91**;Sep 21, 1995
 ;
 Q
 ;
 ; This program will correct two erroneous entries in the PAY
 ; ENTITLEMENT (#457.5) file (iens 64 & 106).  It will then delete two
 ; other entries (iens 2 & 3) and repoint the ENTITLEMENT (#4) field of
 ; the EMPLOYEE (#458.01) multiple in the TIME & ATTENDACNE (#458) file
 ; to the correct entries (iens 64 & 106).
 ;
START ; Define variables
 ;
 N DA,DATA,DIE,DIK,DR,EMP,ENT,IENS,PPI,PRSFDA,PRSIEN,U
 S U="^"
 ; Delete extra entries (iens 2 & 3).
 ;
 S DIK="^PRST(457.5,",DA=2 D ^DIK
 S DIK="^PRST(457.5,",DA=3 D ^DIK
 ;
 ; Correct entries (iens 64 & 106). 
 ;
 S DATA="N 3 E PAY BASIS=$",DR=".01///^S X=DATA",DIE="^PRST(457.5,",DA=64
 D ^DIE
 S DATA="N3E$",DR="1///^S X=DATA",DIE="^PRST(457.5,",DA=64
 D ^DIE
 ;
 S DATA="N 3 N PAY BASIS=$",DR=".01///^S X=DATA",DIE="^PRST(457.5,",DA=106
 D ^DIE
 S DATA="N3N$",DR="1///^S X=DATA",DIE="^PRST(457.5,",DA=106
 D ^DIE
 ;
 ; Loop through PP 04-01 and re-point as ENTITLEMENT (#4) fields as
 ; necessary.
 ;   Re-point 2 to 64
 ;   Re-point 3 to 106
 ;
 S PPI=0
 S PPI=$O(^PRST(458,"B","04-01",PPI))
 Q:PPI=""
 S EMP=0
 F  S EMP=$O(^PRST(458,PPI,"E",EMP)) Q:'EMP  D
 . S ENT=$P($G(^PRST(458,PPI,"E",EMP,0)),U,5)
 . Q:ENT'=2&(ENT'=3)
 . I ENT=2 D
 . . S IENS=EMP_","_PPI_","
 . . S PRSFDA(458.01,IENS,4)=64
 . . S PRSIEN=EMP
 . . D UPDATE^DIE("","PRSFDA","PRSIEN")
 . I ENT=3 D
 . . S IENS=EMP_","_PPI_","
 . . S PRSFDA(458.01,IENS,4)=106
 . . S PRSIEN=EMP
 . . D UPDATE^DIE("","PRSFDA","PRSIEN")
 Q
