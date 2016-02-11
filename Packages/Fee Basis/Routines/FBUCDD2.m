FBUCDD2 ;MNTFW/RGB - DD UTILITY ;4/25/15
 ;;3.5;FEE BASIS;**161**;JAN 30, 1995;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;FB*3.5*161 Patient MRA delete from MRA Transmission file 
 ;           161.26 when linked patient authorization is
 ;           deleted. Had to move DELB as separate call from 
 ;           DELA tag (checks for allowing delete) so the 
 ;           patient MRAs are only deleted when the user 
 ;           actually can respond 'YES' to delete query.
 ;           Linked to FROM DATE x-ref xxxx which calls this
 ;           delete process when authorization is fully deleted.
 ;
DELB(DA) ; FB*3.5*161 Patient MRA delete (161.26) for deleted linked authorization
 I $P(^FBAAA(DA(1),1,DA,0),U,13)=1,$D(^FBAA(161.26,"B",DA(1))) D
 . N FBDA,DIK,FBHDA,FBHDA1
 . S FBDA=0 F  S FBDA=$O(^FBAA(161.26,"B",DA(1),FBDA)) Q:'FBDA  D
 . . I $P(^FBAA(161.26,FBDA,0),U,3)'=DA Q
 . . S FBHDA=DA,FBHDA1=DA(1) K DA(1)
 . . S DIK="^FBAA(161.26,",DA=FBDA D ^DIK
 . . S DA=FBHDA,DA(1)=FBHDA1
DELBQ Q
