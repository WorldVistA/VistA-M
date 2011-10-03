RADD2 ;HISC/GJC/CAH-Radiology Data Dictionary Utility Routine ;5/14/97  10:31
 ;;5.0;Radiology/Nuclear Medicine;**84**;Mar 16, 1998;Build 13
 ;
 ;Integration Agreements
 ;----------------------
 ;EN^DDIOL(10142); FILE^DIE(2053);NOTE^ORX3(868);MES^XPDUTL(10141)
 ;
EN1(RAX,RAY) ; Input transform for the .01 field (Procedure) for the Rad/Nuc
 ; Med Common Procedure file i.e, ^RAMIS(71.3
 ; Procedure must not have an inactive date before today in file 71
 ; Procedure in file 71 must have same imaging type as the one
 ;   selected before editing this record in file 71.3
 ; If 'Parent' type procedure, it must have at least 1 descendent
 ; 'RAX' is the value of the .01 field in ^RAMIS(71.3,
 ; 'RAY' are ien's of entries in ^RAMIS(71,
 I '$G(RAIMGTYI) Q 0
 I $S('$D(^("I")):1,'^("I"):1,DT'>^("I"):1,1:0),$S(RAIMGTYI=$P($G(^RAMIS(71,+RAY,0)),"^",12):1,1:0),$S($P(^RAMIS(71,+RAY,0),U,6)'="P":1,$O(^RAMIS(71,+RAY,4,0)):1,1:0)
 Q $T
 ;
CH(RAY,RAX) ; This subroutine will fire off the 'Radiology Request Cancel
 ; /Hold' notification as defined in the 'OE/RR NOTIFICATIONS' file.
 ; Only if request is either cancelled or held.  Called from the set
 ; logic of the 'ACHN' xref in ^DD(75.1,5) field definition.
 ;
 ; Input variables:
 ; 'RAX'=Request status of the order, $S(X=1:'discontinued',X=3:'hold')
 ; 'RAY'=ien of the order in the RAD/NUC MED ORDERS file.
 ;
 Q:(RAY'=+RAY)  Q:(RAX'=1)&(RAX'=3)
 N %,C,D,D0,DA,DC,DDER,DE,DG,DH,DI,DIC,DIE,DIEDA,DIEL,DIFLD,DIP,DIW,DIWT
 N DK,DL,DM,DN,DP,DQ,DR,DU,DV,DW,I,J,N,ORBPMSG,ORBXDATA,ORIFN,ORNOTE,ORVP
 N RA751,RADFN,RANME,RAOIFN,RAOLP,RAOPTN,RAORDS,RAOREA,RAOSTS,RAPARENT
 N RAPRC,RAXIT,X,Y
 S RA751=$G(^RAO(75.1,RAY,0)) Q:RA751']""
 S RAOIFN=RAY,RADFN=+$P(RA751,"^")
 S RAPRC=$P($G(^RAMIS(71,+$P(RA751,"^",2),0)),"^"),ORVP=RADFN_";DPT("
 S ORBPMSG=$S(RAX=1:"Discontinued - ",1:"On hold - ")_$E(RAPRC,1,17)
 S ORBXDATA=RAOIFN_","_RADFN,ORIFN=+$P(RA751,"^",7),ORNOTE(26)=1
 D NOTE^ORX3
 Q
INACOM(RAD0) ; Check inactive date on the Rad/Nuc Med Procedure file (71)
 ; for the Common Procedure before setting our inactive procedure to
 ; active.  Called from the 'RA COMMON PROCEDURE EDIT' input template.
 ; Option: Common Procedure Enter/Edit (13^RAMAIN2)
 ; Input : RAD0-ien of Rad/Nuc Med Common Procedure
 ; Output: if Common cannot be re-activated, reset the 'Inactive' field
 ;         to 'yes'.
 N RAINA S RAINA=$P($G(^RAMIS(71,+$P($G(^RAMIS(71.3,RAD0,0)),"^"),"I")),"^")
 Q:RAINA=""!(RAINA>DT) "@15" ; we can inactivate the common
 N RAFDA,RAMSG
 S RAFDA(71.3,RAD0_",",4)="Y" D FILE^DIE("","RAFDA","") S RAMSG(1)=$C(7)
 S RAMSG(2)="You cannot add this procedure to the common procedure list"
 S RAMSG(3)="because it is inactivated in the Rad/Nuc Med Procedures file."
 S RAMSG(4)="You must first re-activate the procedure through the 'Procedure"
 S RAMSG(5)="Enter/Edit' option.",RAMSG(6)="" D MES^XPDUTL(.RAMSG)
 Q "@10" ; reset 'Inactive' to 'yes', re-edit field.
 ;
EN2() ; called from ^DD(74,0,"ID","WRITE")
 ; display long case #'s in the same print set as current record
 N RA1,RA2
 S RA1=0,RA2=""
 F  S RA1=$O(^RARPT(Y,1,"B",RA1)) Q:'RA1  S RA2=RA2_$S(RA2="":"-",1:",-")_$P(RA1,"-",2)
 Q RA2
USUAL(RADA,RAX) ; To insure that the USUAL DOSE value falls between the
 ; HIGH ADULT DOSE and the LOW ADULT DOSE.
 ; Input Variables:
 ;     RADA -> top level/sub-file level IEN's
 ;      RAX -> value input by the user
 ; Output Variable: $S(1: value is accepted, 0: value not accepted)
 ;
 Q:RAX="" 0 ; X does not exist
 N RA7108,RAH,RAL S RA7108=$G(^RAMIS(71,RADA(1),"NUC",RADA,0))
 S RAH=$P(RA7108,"^",5),RAL=$P(RA7108,"^",6)
 S RAH=$S(RAH="":99999.9999,1:RAH),RAL=$S(RAL="":.0001,1:RAL)
 I (+RAX<RAL)!(+RAX>RAH) D  Q 0 ; value is not accepted
 . N RARRY S RARRY(1)="The 'USUAL DOSE' must fall within the range of: "
 . S RARRY(1)=RARRY(1)_RAL_" - "_RAH_" "
 . D EN^DDIOL(.RARRY)
 . Q
 E  Q 1 ; value accepted
 ;
RANGE(RADA) ; Determine the range in which the 'USUAL DOSE' must fall
 ; Input Variables:
 ;     RADA  -> top level/sub-file level IEN's
 ; Output Variable:
 ;     RANGE -> the range in which the 'USUAL DOSE' must fall
 N RA7108,RAH,RAL
 S RA7108=$G(^RAMIS(71,RADA(1),"NUC",RADA,0))
 S RAH=$P(RA7108,"^",5),RAL=$P(RA7108,"^",6)
 S RAH=$S(RAH="":99999.9999,1:RAH),RAL=$S(RAL="":.0001,1:RAL)
 Q RAL_"-"_RAH
MEDOSE(RAY,RADT) ; Determine if this individual (RAY) is authorized to
 ; administer medications.  Called from ^DD(70.15,4,12.1)
 ; Input : RAY (pnt to 200) - the individual being checked at the moment 
 ;         RADT - Date of the examination
 ; Output: '1' - user is authorized to administer medications, else '0'
 ;
 Q:$D(^VA(200,"ARC","R",RAY)) 1 ; Rad/Nuc Med Class: Resident
 Q:$D(^VA(200,"ARC","S",RAY)) 1 ; Rad/Nuc Med Class: Staff
 Q:$D(^VA(200,"ARC","T",RAY)) 1 ; Rad/Nuc Med Class: Technologist
 Q:$D(^XUSEC("ORES",RAY)) 1 Q:$D(^XUSEC("ORELSE",RAY)) 1
 N RAUTH S RAUTH=$G(^VA(200,RAY,"PS"))
 ; If authorized to write med orders ($P(RAUTH,"^")=1) and inactivation
 ; date null -OR- inactivation date greater than or equal to the exam
 ; date individual is authorized.
 Q:+$P(RAUTH,"^")&($S('$P(RAUTH,"^",4):1,$P(RAUTH,"^",4)'<RADT:1,1:0)) 1
 Q 0
 ;
PRIDXIXK(DA,X) ;This subroutine executes the KILL logic for the 'new style' AD cross-
 ;reference on the 'PRIMARY DIAGNOSTIC CODE' (data dictionary: 70.03; field: 13)
 ;Input: DA - an array where DA(2)=RADFN, DA(1)=RADTI, & DA=RACNI
 ;        X - the primary diagnostic code value (this field points to file 78.3)
 N RACNI,RADFN,RADTI,RAFDA,RAIENS,RAX
 S RADFN=DA(2),RADTI=DA(1),RACNI=DA,RAX=X ;save the variables just in case
 S RAIENS=DA_","_DA(1)_","_DA(2)_",",RAFDA(70.03,RAIENS,20)="@"
 D FILE^DIE(,"RAFDA") ;delete data in 'DIAGNOSTIC PRINT DATE' (DD: 70.03; field: 20)
 K ^RADPT("AD",RAX,RADFN,RADTI,RACNI)
 Q
 ;
