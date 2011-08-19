ESPDUP ;ALBANY/CJM - DELETES DUPLICATE ENTRIES IN MASTER NAME INDEX FILE;8/92
 ;;1.0;POLICE & SECURITY;**17**;Mar 31, 1994
 ;
EN ;Allows duplicate names to be deleted from the Master Name Index file.
 ;The user is required to select the name which is the 'good' one.
 ;
 N NAME
 S (NAME("DELETE"),NAME("KEEP"))=""
 W !!,"Which name do you want to delete from the Master Name Index?"
 S NAME("DELETE")=$$SELECT
 Q:'NAME("DELETE")
 ;
 W !!,"** PLEASE NOTE **"
 W !,"Entries in the Master Name Index file are referenced from many other files."
 W !,"Before you are allowed to delete a duplicate entry you must first indicate"
 W !,"the correct entry to keep so that all references in all files can be changed"
 W !,"to the correct entry."
 W !!,"Which entry do you want to keep?",!
 ;
 F  D  Q:(NAME("DELETE")'=NAME("KEEP"))
 .S NAME("KEEP")=$$SELECT
 .I NAME("DELETE")=NAME("KEEP") W !,"You must select a different entry!",!
 Q:'NAME("KEEP")
 ;
 D:$$RUSURE(NAME("DELETE"),NAME("KEEP"))
 .;
 .;first update all the xrefs, replacing NAME("DELETE") with NAME("KEEP")
 .D REPLACE(NAME("DELETE"),NAME("KEEP"))
 .;
 .;next delete the duplicate entry
 .D DELETE(NAME("DELETE"))
 .W !!,"DONE",!!
 Q
 ;
SELECT() ;
 ;asks user to select from file 910
 ;returns ptr to file 910, the Master Name Index
 ;
 N Y,DINUM,DIC,X,DTIME,DLAYGO
 S DIC=910,DIC(0)="AEFMQ"
 S DIC("A")="Select a name: "
 D ^DIC
 I (Y=-1)!$D(DTOUT)!$D(DUOUT) Q 0
 Q +Y
 ;
REPLACE(OLD,NEW) ;
 ;replaces all pointers to file 910 = OLD with NEW
 ;
 N REF,COUNT,REC,SUBREC
 S COUNT=1
 F  S REF=$P($T(REFS+COUNT),";;",2) Q:(REF="")  D
 .S COUNT=COUNT+1
 .S REF("FILE")=$P(REF,"^"),REF("XREF")=$P(REF,"^",2),REF("SUB")=$P(REF,"^",3),REF("FIELD")=$P(REF,"^",4)
 .Q:REF("FILE")=""
 .Q:REF("XREF")=""
 .Q:REF("FIELD")=""
 .;
 .S REC=0 F  S REC=$O(^ESP(REF("FILE"),REF("XREF"),OLD,REC)) Q:'REC  D
 ..I REF("SUB")="" D
 ...D EDIT(REF("FILE"),REC,REF("FIELD"),NEW)
 ..E  S SUBREC=0 F  S SUBREC=$O(^ESP(REF("FILE"),REF("XREF"),OLD,REC,SUBREC)) Q:'SUBREC  D EDIT(REF("FILE"),REC,REF("FIELD"),NEW,REF("SUB"),SUBREC)
 Q
 ;
DELETE(OLD) ;
 N DIK,DA
 S DIK="^ESP(910,",DA=OLD
 D ^DIK
 W !,"DELETED",!
 Q
 ;
RUSURE(OLD,NEW) ;
 ;
 N DIR,DA,X,Y
 S DIR(0)="Y"
 S DIR("B")="NO"
 S DIR("A")="Replace "_$P($G(^ESP(910,OLD,0)),"^")_" with "_$P($G(^ESP(910,NEW,0)),"^")_" and then delete"
 W !
 D ^DIR
 Q Y
 ;
EDIT(FILE,REC,FIELD,VALUE,SUB,SUBREC) ;
 N DIE,DA,DR
 S DIE="^ESP("_FILE_","
 S DR=FIELD_"////"_VALUE
 I $G(SUB)="" D
 .S DA=REC
 .D ^DIE
 E  D
 .Q:'SUBREC
 .S DIE=DIE_REC_","_SUB_","
 .S DA(1)=REC
 .S DA=SUBREC
 .D ^DIE
 Q
 ;
 ;
REFS ;;<file #>;<xref>;<subscript if in multiple>;<field #>
 ;;910.2^D^^.03
 ;;910.2^I^^4.05
 ;;910.2^J^^5.01
 ;;910.2^V^^6.01
 ;;910.2^BI^^6.02
 ;;910.2^W^^6.03
 ;;910.2^P^^6.04
 ;;910.2^G^^6.05
 ;;910.8^C^1^.04
 ;;910.8^D^5^.03
 ;;912^D^20^.02
 ;;912^E^30^.02
 ;;912^G^40^.02
 ;;912^I^50^.02
 ;;912^J^80^.11
 ;;913^B^^.01
 ;;914^E^^.09
 ;;
