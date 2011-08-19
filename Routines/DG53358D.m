DG53358D ;ALB/AEG,GN DG*5.3*358 DELETE INCOME TESTS ; 12/17/03 3:06pm
 ;;5.3;REGISTRATION;**358,558**;5-1-2001
 ;
 ;This is a modified version of IVMCMD in that it calls a modified
 ;version of IVMCMD1 called DG53358C which only deletes the
 ;records from the Annual Means Test(#408.31) file.  It does not open
 ;a case record in the IVM Patient (#301.5)file, does not send 'delete'
 ;bulletin/notification to local mail group, does not call the means
 ;test event driver and does not call DGMTR.
 ;
 ;DG*53*558 - re-deploy with this patch
 ;
EN(IVMMTIEN) ; --
 ; This routine will process income test deletion requests received
 ; from the IVM Center.
 ;
 ;  Input(s):
 ;       IVMMTIEN - pointer to test to be deleted in file 408.31
 ;
 ; Output(s):
 ;       Function Value - 1 test deleted
 ;                        0 test not deleted
 ;
 ;
 ; Initialize variables
 N DFN,IVMERR,IVMLINK,IVMNODE0,IVMDOT,IVMTOT,IVMDONE
 S IVMDONE=0
 ;
EN1 ; Get zero node of (#408.31)
 S IVMNODE0=$G(^DGMT(408.31,IVMMTIEN,0))
 I 'IVMNODE0 Q 1  ; test not found
 S IVMDOT=$P(IVMNODE0,"^") ; date of test
 S DFN=$P(IVMNODE0,"^",2)
 S IVMTOT=$P(IVMNODE0,"^",19) ; type of test
 S IVMLINK=$P($G(^DGMT(408.31,IVMMTIEN,2)),"^",6)
 ;don't delete copay test linked to valid means test
 I IVMTOT=2,IVMLINK,$D(^DGMT(408.31,IVMLINK,0)) Q 0
 I IVMTOT=1,IVMLINK D  I $D(IVMERR) Q 0  ;I MT linkd to copay delete both
 .D DELETE(IVMLINK,DFN,IVMDOT) ; delete copay
 D DELETE(IVMMTIEN,DFN,IVMDOT) ; delete copay or MT
 Q IVMDONE
 ;
DELETE(IVMMTIEN,DFN,IVMDOT) ; delete copay or MT
 ;
 ; Get Income Relation IEN array (DGINR) and
 ; Individual Annual Income IEN array (DGINC)
 D ALL^DGMTU21(DFN,"VSC",IVMDOT,"IR",IVMMTIEN)
 ;
 ;
DEL22 ; Delete veteran, spouse, and dependent entries from the
 ; Income Relation (#408.22) file:
 ; - Veteran (#408.22) record
 S DA=$G(DGINR("V")) D
 .Q:'DA
 .S DIK="^DGMT(408.22,"
 .D ^DIK
 ;
 ; - Spouse (#408.22) record
 S DA=$G(DGINR("S")) D
 .Q:'DA
 .S DIK="^DGMT(408.22,"
 .D ^DIK
 ;
 ; - All dependent children (#408.22) records
 S IVMDEP=0
 F  S IVMDEP=$O(DGINR("C",IVMDEP)) Q:'IVMDEP  D
 .S DA=$G(DGINR("C",IVMDEP))
 .S DIK="^DGMT(408.22,"
 .D ^DIK
 ;
 ;
DEL21 ; Delete veteran, spouse, and dependent entries from
 ; Individual Annual Income (#408.21) file:
 ; - Veteran (#408.21) record
 S DA=$G(DGINC("V")) D
 .Q:'DA
 .S DIK="^DGMT(408.21,"
 .D ^DIK
 ;
 ; - Spouse (#408.21) record
 S DA=$G(DGINC("S")) D
 .Q:'DA
 .S DIK="^DGMT(408.21,"
 .D ^DIK
 ;
 ; - All dependent children (#408.21) records
 S IVMDEP=0
 F  S IVMDEP=$O(DGINC("C",IVMDEP)) Q:'IVMDEP  D
 .S DA=$G(DGINC("C",IVMDEP))
 .S DIK="^DGMT(408.21,"
 .D ^DIK
 ;
 ;
 ; Logic for (#408.12/#408.1275) & (#408.13) file entries
 D SETUPAR
 ;
 ; Look for IVM/DCD Patient Realtion (#408.12) file entries.
 ; If no entries in "AIVM" x-ref, no dependent changes required.
 S IVM12="" F  S IVM12=$O(^DGPR(408.12,"AIVM",IVMMTIEN,IVM12)) Q:'IVM12  D  Q:$D(IVMERR)
 .; -- if can't find entry in (#408.12), set IVMERR
 .I $G(^DGPR(408.12,+IVM12,0))']"" D  Q
 ..S IVMERR="" Q
 .;
 .; - if only one record exists in (#408.1275) mult., then only one
 .;IVM/DCD dependent to delete
 .I $P($G(^DGPR(408.12,+IVM12,"E",0)),"^",4)=1 D  Q
 ..;
 ..; -- if can't find entry in (#408.13), set IVMERR
 ..S IVM13=$P($P($G(^DGPR(408.12,+IVM12,0)),"^",3),";")
 ..I $G(^DGPR(408.13,+IVM13,0))']"" D  Q
 ...S IVMERR="" Q
 ..;
 ..; -- delete (#408.12) & (#408.13) records for IVM/DCD dependent
 ..S DA=IVM12,DIK="^DGPR(408.12," D ^DIK K DA,DIK
 ..S DA=IVM13,DIK="^DGPR(408.13," D ^DIK K DA,DIK
 ..Q
 .;
 .;
 .; Delete (#408.1275) record for IVM/DCD dependent and
 .; change demo data in (#408.12) & (#408.13) back to VAMC values.
 .; OR, Delete (#408.1275) record for inactivated VAMC dependent.
 .S IVM121="",IVM121=$O(^DGPR(408.12,"AIVM",IVMMTIEN,+IVM12,IVM121))
 .; - if can't find entry in (#408.1275), set IVMERR
 .I $G(^DGPR(408.12,+IVM12,"E",+IVM121,0))']"" D  Q
 ..S IVMERR="" Q
 .;
 .S IVMVAMCA=$P($G(^DGPR(408.12,+IVM12,"E",+IVM121,0)),"^",2)
 .;dependent active?
 .;
 .; - If active, inactivate dependant
 .I IVMVAMCA D
 ..S DR=".02////0",DA=+IVM121,DA(1)=0
 ..S DIE="^DGPR(408.12,"_+IVM12_",""E"","
 ..D ^DIE S IVMVAMCA=0 Q
 .;
 .S DA(1)=IVM12,DA=IVM121,DIK="^DGPR(408.12,"_DA(1)_",""E"","
 .D ^DIK K DA(1),DA,DIK
 .;
 .Q
 ;
 ; Complete deletion of income test
 D EN^DG53358C
 ;
ENQ Q
 ;
 ;
SETUPAR ; Create array IVMAR1() where
 ;  1) Subscript is MT Changes Type (#408.42) file node where type of
 ;     change = Name, DOB, SSN, Sex, Relationship.
 ;  2) 1st piece is (#408.12) or (#408.13) file.
 ;  3) 2nd piece is (#408.12) or (#408.13) file field number.
 ;
 F IVM41=4:1 S IVM411=$P($T(TYPECH+IVM41),";;",2) Q:IVM411="QUIT"  D
 .S IVMAR1($P(IVM411,";"))=$P(IVM411,";",2,3)
 K IVM41,IVM411
 Q
 ;
DELTYPE(DFN,MTDATE,TYPE) ;
 ;will delete any primary test for patient=DFN for same income year as
 ;MTDATE for test of type=TYPE
 ;
 Q:'$G(DFN)
 Q:'$G(MTDATE)
 Q:'$G(TYPE)
 N MTNODE,YEAR,RET
 S YEAR=$E(MTDATE,1,3)_1230.999999
 D
 .S MTNODE=$$LST^DGMTU(DFN,YEAR,TYPE)
 .Q:'+MTNODE
 .I $E($P(MTNODE,"^",2),1,3)'=$E(YEAR,1,3) Q
 .;don't want to delete auto-created Rx copay tests -they are deleted by
 .; deleting the MT that they are based on
 .I TYPE=2,+$P($G(^DGMT(408.31,+MTNODE,2)),"^",6) Q
 .I $P(MTNODE,"^",5),$P(MTNODE,"^",5)'=1 I $$EN(+MTNODE) D
 ..;
 ..S RET=$$LST^DGMTU(DFN,DT,IVMTYPE)
 ..I $E($P(RET,"^",2),1,3)'=$E(YEAR,1,3) S RET=""
 ..D ADD^IVMCMB(DFN,IVMTYPE,"DELETE PRMYTEST",$P(MTNODE,"^",2),$P(MTNODE,"^",4),$P(RET,"^",4))
 Q
 ;
TYPECH ; Type of dependent changes (#408.41/#408.42) file
 ;    1st piece - 408.42 table file node
 ;    2nd piece - file (408.12/408.13)
 ;    3rd piece - 408.12/408.13 field
 ;;16;408.13;.01
 ;;17;408.13;.03
 ;;18;408.13;.09
 ;;19;408.13;.02
 ;;20;408.12;.02
 ;;QUIT
 Q
