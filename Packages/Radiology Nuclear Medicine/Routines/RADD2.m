RADD2 ;HISC/GJC/CAH-Radiology Data Dictionary Utility Routine ; Feb 11, 2021@11:10:54
 ;;5.0;Radiology/Nuclear Medicine;**84,47,124,158,175**;Mar 16, 1998;Build 2
 ;
 ;Integration Agreements
 ;----------------------
 ;EN^DDIOL(10142); FILE^DIE(2053);NOTE^ORX3(868);MES^XPDUTL(10141)
 ;
EN1(RA71) ; Input transform for the .01 field (Procedure) for the Rad/Nuc
 ; Med Common Procedure file i.e, ^RAMIS(71.3 (reworked for RA*5.0*158)
 ; Procedure must not have an inactive date before today in file 71
 ; Procedure in file 71 must have same imaging type as the one
 ;   selected before editing this record in file 71.3
 ;
 ; A PARENT type procedure must have at least one descendent
 ; Output:
 ; -If at least one descendant return one
 ; -else return 0
 ;
 ; Input:
 ; RA71 = IENS of entries in ^RAMIS(71,
 ; RAIMGTYI = IEN of an IMAGING TYPE record (global scope)
 ;
 Q:'$G(RAIMGTYI) 0
 ;
 S RA71("I")=$G(^RAMIS(71,+RA71,"I")),RA71(0)=$G(^RAMIS(71,+RA71,0))
 ;parent procedure?
 S RAPARENT=$S($P(RA71(0),"^",6)="P":1,1:0)
 ;does the parent have a descendant?
 S:RAPARENT RAPFLG=+$O(^RAMIS(71,+RA71,4,0))
 ;
 ;if no "I" node or "I" node null ok, if DT is before today ok, else not ok
 S RA71ACTIVE=$S(RA71("I")="":1,DT<RA71("I"):1,1:0)
 Q:RA71ACTIVE=0 0
 ;
 ;match i-type?
 S RA71ITYPE=$S(RAIMGTYI=$P($G(RA71(0)),"^",12):1,1:0)
 Q:RA71ITYPE=0 0
 ;
 ;if active, w/i-type match & non-parent quit 1
 Q:RAPARENT=0 1
 ;
 ;if active, w/i-type match & parent w/descendant quit 1
 Q:RAPARENT&RAPFLG 1
 ;
 K RA71ACTIVE,RA71ITYPE,RAPARENT,RAPFLG
 Q 0
 ;
CH ;this tag was removed w/RA*5.0*175
 Q
 ;
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
 ; F  S RA1=$O(^RARPT(Y,1,"B",RA1)) Q:'RA1  S RA2=RA2_$S(RA2="":"-",1:",-")_$P(RA1,"-",2)
 F  S RA1=$O(^RARPT(Y,1,"B",RA1)) Q:'RA1  S RA2=RA2_$S(RA2="":"-",1:",-")_$P(RA1,"-",$L(RA1,"-"))  ;P47 to accommodate possible SSAN format
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
AEASSET(RAX,RADA,RAXREF) ;determine is the examination status of the
 ;study is either CANCELED or COMPLETE. This routine will set the "AS"
 ; or "AE" xref SET logic (new style). 
 ;
 ; Note: The first numeric subscript of the "AE" xref is the
 ;       CASE NUMBER (70.03;.01). Since the .01 field cannot
 ;       be changed because of business rules, the "AE" xref
 ;       does not have set/kill logic in the CASE NUMBER field.
 ;
 ;       The first numeric subscript of the "AS" xref is the
 ;       EXAMINATION STATUS IEN (70.03;3). 
 ;
 ;
 ;input: RAX = value of 'X' passed into from ^DD(70.03,3,0)
 ;             'X' is the IEN of a record in the EXAMINATION
 ;             STATUS (#72) file.
 ;      RADA = the DA array: DA(2) think RADFN, DA(1) think
 ;             RADTI & DA think RACNI.
 ;    RAXREF = one of two values: "AS" or "AE"
 ;
 ;
 ;ORDER value for CANCELED is zero (0), ORDER value for CANCELED is nine (9)
 ;ORDER values 0, 1 & 9 are RESERVED. RAIMGTY is set in the input transform
 N RAIMGTY,RAY2,RAY3,RAY S RAY=$P($G(^RA(72,RAX,0)),U,3) ;ORDER value
 Q:RAY=""  S RAY2=$G(^RADPT(RADA(2),"DT",RADA(1),0))
 S RAY3=$G(^RADPT(RADA(2),"DT",RADA(1),"P",RADA,0)) ;70.03
 S RAIMGTY=$P($G(^RA(79.2,+$P(RAY2,U,2),0)),U) Q:RAIMGTY=""
 ;^RA(72,"AA","GENERAL RADIOLOGY",1,1)="" 4th subscript is ORDER,
 ;the 5th is IEN of file 72
 Q:'$D(^RA(72,"AA",RAIMGTY,RAY,RAX))#2  ;the "AA" must be preserved
 Q:RAY=0!(RAY=9)  ;the study is canceled or complete or broken
 S:RAXREF="AE"&($P(RAY3,U)>0) ^RADPT("AE",$E(+RAY3,1,30),RADA(2),RADA(1),RADA)=""
 S:RAXREF="AS" ^RADPT("AS",$E(RAX,1,30),RADA(2),RADA(1),RADA)=""
 Q
 ;
AEKILL(RADA) ;execute the KILL logic for the "AE" xref on the
 ;EXAM STATUS field (70.03;3)
 ;input: RADA = the DA array: DA(2) think RADFN, DA(1) think
 ;              & DA think RACNI.
 N RAY3 S RAY3=$G(^RADPT(RADA(2),"DT",RADA(1),"P",RADA,0)) ;70.03
 K ^RADPT("AE",$E(+RAY3,1,30),RADA(2),RADA(1),RADA)
 Q
 ;
