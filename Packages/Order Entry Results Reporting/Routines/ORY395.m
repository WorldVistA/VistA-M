ORY395 ;ISP/TC,RFR - POST INSTALL FOR PATCH OR*3*395;07/23/2014  12:22
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**395**;Dec 17, 1997;Build 11
 ;
POST ; Initiate post-init processes
 D UNDOPLRP,FIXMENU
 Q
UNDOPLRP ; Remove SNOMED CT description, Primary ICD code/description, and Secondary ICD code/description columns from PL Clinical Reports.
 N I
 F I=1:1:4  D
 . N DIC,DA,X,J,ORIFN
 . S DIC="^ORD(101.24,",DIC(0)="BIX"
 . S X=$S(I=1:"ORRPW PROBLEM ACTIVE",I=2:"ORRPW PROBLEM ALL",I=3:"ORRPW PROBLEM INACTIVE",1:"ORRPW DOD PROBLEM LIST ALL")
 . D ^DIC I Y=-1 K DIC Q  ; perform top file level search for record X, if unsuccessful quit
 . S DA(1)=+Y,DIC=DIC_DA(1)_",3,",DIC(0)="IXZ",ORIFN=DA(1)
 . D BMES^XPDUTL("Updating the "_X_" report in File #101.24.")
 . L +^ORD(101.24,DA(1)):5 I '$T D  Q
 . . D BMES^XPDUTL("Error updating the "_X_" report in File #101.24.")
 . . D BMES^XPDUTL("Another user is currently editing this report entry.")
 . . Q
 . I ORIFN>1000 D  ; if report is a national standard, then proceed to modify the below X fields in the subfile #101.243
 . . N X,L,ORPRIMCN,ORSECCLN
 . . F L=1:1:2  D
 . . . S X=$S(L=1:"Primary ICD-9-CM Code & Description",1:"Secondary ICD-9-CM Code & Description") D ^DIC
 . . . I Y=-1 D
 . . . . I L=1 S ORPRIMCN="Primary ICD Code & Description"
 . . . . I L=2 S ORSECCLN="Secondary ICD Code & Description"
 . . . . Q
 . . . I $D(Y(0,0)),(Y(0,0)]""),(Y(0,0)["ICD-9") D
 . . . . I L=1 S ORPRIMCN=Y(0,0)
 . . . . I L=2 S ORSECCLN=Y(0,0)
 . . F J=1:1:9  D
 . . . N X,ORCOLHDR S X=$S(J=1:"Date of Onset",J=2:"Date Modified",J=3:"Provider Name    ",J=4:"Note Narrative",J=5:"[+]",J=6:"Exposures",J=7:"SNOMED CT Description",J=8:ORPRIMCN,J=9:ORSECCLN)
 . . . S ORCOLHDR=X
 . . . D ^DIC I Y=-1 Q  ;perform subfile entry level search for record X, if unsuccessful quit
 . . . N DIE,DA,DR S DIE=DIC S DA=+Y,DA(1)=ORIFN
 . . . S DR=".03///"_$S(J=1:"5",J=2:"6",J=3:"7",J=4:"8",J=5:"10",J=6:"9",1:"@")
 . . . D ^DIE  ; edit the SEQUENCE fields of the X COLUMN HEADER multiple accordingly
 . . . I J>6 D
 . . . . D MES^XPDUTL("   Deleting the "_ORCOLHDR_" column header.")
 . . . . N DIK S DIK=DIE D ^DIK  ; delete the 3 new column headers introduced in OR*3*306
 . . . K DIE,DIK,DR,DA,Y Q
 . . K DIC Q
 . L -^ORD(101.24,DA(1)) Q
 . Q
 Q
FIXMENU ;UNDO MENU CHANGES FROM PATCH OR*3*378
 N RESULT
 D BMES^XPDUTL("Cleaning up menus...")
 S RESULT=$$FIND("OR PARAM COORDINATOR MENU","ORE KEY CHECK")
 Q:RESULT=-1
 I RESULT D
 .N ERROR
 .D MES^XPDUTL("  Adding ORE KEY CHECK to OR PARAM COORDINATOR MENU")
 .;IA #1157
 .S ERROR=$$ADD^XPDMENU("OR PARAM COORDINATOR MENU","ORE KEY CHECK","KK")
 .D:ERROR=1 MES^XPDUTL("  DONE")
 .D:ERROR=0 MES^XPDUTL("  ORE KEY CHECK was not added to OR PARAM COORDINATOR MENU")
 D MES^XPDUTL("DONE")
 Q
ERROR(MESSAGE) ;HANDLE AN ERROR MESSAGE FROM FILEMAN
 N IDX
 S IDX=0 F  S IDX=$O(MESSAGE("DIERR",IDX)) Q:'IDX  D
 .D MES^XPDUTL("FILEMAN ERROR #"_MESSAGE("DIERR",IDX)_":")
 .D MES^XPDUTL(MESSAGE("DIERR",IDX,"TEXT",1))
 Q
FIND(ORMENU,OROPTION) ;DETERMINE IF MENU CONTAINS OPTION
 N IEN,RETURN,ERROR,ADD
 ;IA #10156
 S ADD=1,IEN=$$FIND1^DIC(19,,"X",ORMENU)
 I +$G(IEN)=0 D  Q -1
 .D MES^XPDUTL("ERROR: Could not find the "_ORMENU_" option in the OPTION file (#19).")
 ;IA #10156
 D GETS^DIQ(19,IEN_",","10*",,"RETURN","ERROR")
 I $D(ERROR) D ERROR(.ERROR)  Q -1
 I $D(RETURN) D
 .N IDX
 .S IDX=0 F  S IDX=$O(RETURN(19.01,IDX)) Q:+$G(IDX)=0  D
 ..S:RETURN(19.01,IDX,.01)=OROPTION ADD=0
 Q ADD
