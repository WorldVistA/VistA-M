DGMTAUD ;ALB/TT,RMO,CAW,LD,BRM - AUDIT CHANGES TO MEANS TEST ; 1/2/02 11:39am
 ;;5.3;Registration;**33,45,182,433**;Aug 13, 1993
 ;
EN ;INPUT:  DFN     - Patient IEN
 ;        DGMTACT - Type of Action from Means Test
 ;        DGMTI   - Means Test IEN
 ;        DGMTINF - Means Test Interactive/Non-interactive flag
 ;        DGMTP   - Prior zero node
 ;        DGMTA   - After zero node
 ;        DGMTYPT - Type of Test 1=MT, 2=COPAY, 4=LTC
 ;        DGDEP   - (Optional) Dependent Info
 ;        DGDEPI  - (Optional) Dependent IEN
 ;OUTPUT:  None
 I DGMTP=DGMTA Q
SETD ; Update audit file
 ;
 ;DGMTFLG - Flag for status or deductible agreement change
 ;          0=no change,1=status change,2=agree to pay deductible change
 ;
 ;DGMTFLG1 - source flag  0=no change, 1=source change
 ;DGMTFLG2 - Dependent Flag 0=no change, 1=dependent info change
 ;DGMTATYP - Means Test Change Type
 ;           1-Add
 ;           2-Category change
 ;           3-Agree to pay deductible
 ;           4-Adjudicate
 ;           5-Edit
 ;           7-Status change
 ;          13-Source of test change
 ;          14-Delete primary means test that was previously uploaded
 ;          15-Deleted Dependent
 ;(IVM)     16-Name Change
 ;(IVM)     17-Date of Birth Change
 ;(IVM)     18-SSN Change
 ;(IVM)     19-Sex Change 
 ;(IVM)     20-Relationship Change
 ;
 ;DGMTACT - type of change
 ;          'DEL' (delete): changes related to that means test
 ;                are deleted from file 408.41.
 ;          'COM' (Complete) a means test then type is edited
 ;          'UPL' (Upload), this is a means test uploaded from an 
 ;                external source such as IVM and is a Source of
 ;                Test change.
 ;          'EDT' is Edit, 
 ;          'ADD' is Add, 
 ;          'ADJ' is Adjudicate,
 ;          'CAT' is Category change,
 ;          'STA' is Status change,
 ;          'DUP' is delete a primary means test, 
 ;          'DDP' is deleted dependent
 ;          'NAM' is name change (dependent only)
 ;          'DOB' is Date of Birth change (dependent only)
 ;          'SSN' is Social Security Number change (dependent only)
 ;          'SEX' is Sex change (dependent only)
 ;          'REL' is Relationship change (dependent only)
 ;
SET S DGMTATYP="" I '$D(DGMTYPT) S DGMTYPT=$P(DGMTA,U,19)
 I DGMTACT="DEL" G DEL
 I DGMTACT="STA" S DGMTATYP=$P("7^10^^10","^",DGMTYPT)
 I DGMTACT="EDT"!(DGMTACT="COM") S DGMTATYP=$P("5^9^^9","^",DGMTYPT)
 I DGMTACT="ADD" S DGMTATYP=$P("1^8^^8","^",DGMTYPT)
 I DGMTACT="CAT" S DGMTATYP=$P("2^11^^11","^",DGMTYPT)
 I DGMTACT="ADJ" S DGMTATYP=$P("4^12^^12","^",DGMTYPT)
 I DGMTACT="UPL" S DGMTATYP=$P("13^^^","^",DGMTYPT)
 I DGMTACT="DUP" S DGMTATYP=$P("14^^^","^",DGMTYPT)
 I DGMTACT="DDP" S DGMTATYP=15
 I DGMTACT="NAM" S DGMTATYP=16
 I DGMTACT="DOB" S DGMTATYP=17
 I DGMTACT="SSN" S DGMTATYP=18
 I DGMTACT="SEX" S DGMTATYP=19
 I DGMTACT="REL" S DGMTATYP=20
 S (DGMTFLG,DGMTFLG1,DGMTFLG2)=0
 I ($$SR^DGMTAUD1(DGMTP)'=$$SR^DGMTAUD1(DGMTA)) S DGMTFLG1=1,DGMTOSRC=$$SR^DGMTAUD1(DGMTP),DGMTNSRC=$$SR^DGMTAUD1(DGMTA)
 I $P(DGMTA,U,3)'=$P(DGMTP,U,3) S DGMTFLG=1,DGMTSOLD=$$S^DGMTAUD1($P(DGMTP,U,3)),DGMTSNEW=$$S^DGMTAUD1($P(DGMTA,U,3))
 I DGMTATYP=15 S DGMTSOLD=$P(DGDEP,U),DGMTSNEW="",DGMTFLG=1
 I DGMTATYP>15 S (DGMTFLG,DGMTFLG2)=1
ED ;File and edit
 D NOW^%DTC S (DIE,DIC)="^DGMT(408.41,",DIC(0)="L",X=% K DD,DO D FILE^DICN G:Y'>0 Q S (DA,DGMTAUD)=+Y
LOCK L +^DGMT(408.41,DGMTAUD):1 G:'$T LOCK
 S DR="[DGMT UPDATE AUDIT]" D ^DIE L -^DGMT(408.41,DGMTAUD)
Q K DA,DE,DGDASH,DGMTAI,DGMTAIZ,DGMTATYP,DGMTAUD,DGMTD,DGMTFLG,DGMTFLG1,DGMTSNEW,DGMTSOLD,DGMTOSRC,DGMTNSRC,DGNAM,DIC,DIE,DQ,DR,DTOUT,DUOUT,X,Y,% Q
DEL ;Delete audits associated to MT
 S DIK="^DGMT(408.41,"
 S DA=0 F  S DA=$O(^DGMT(408.41,"AM",DGMTYPT,DFN,DGMTI,DA)) Q:'DA  D ^DIK
 K DA,DIK Q
 ;
DIS ;Display changes pertaining to a means test for a vet
 D DIS^DGMTAUD2 Q
