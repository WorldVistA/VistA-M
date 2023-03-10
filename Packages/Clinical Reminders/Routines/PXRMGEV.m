PXRMGEV ;SLC/AGP,RFR - Generic entry point to run different Reminder Evaluation ;Apr 07, 2021@13:57
 ;;2.0;CLINICAL REMINDERS;**45,71**;Feb 04, 2005;Build 43
 Q
 ;
EN(RESULT,INPUT) ;
 ; INPUT
 ;   INPUT("SUB")=Temp Global Subscript
 ;
 ; For Reminder Order Checks:
 ;   INPUT("DFN")=DFN                       The patient to perform orders checks on.
 ;   INPUT("ROC START")=START               Date to start searching for orders; applies to all orders.
 ;   INPUT("ROC STOP")=STOP                 Date to stop search for orders; applies to all orders.
 ;   INPUT("ROC DISPLAY GROUPS",DG)=""      Array of Display Group Names used in searching for orders.
 ;   INPUT("ROC DISPLAY GROUPS",DG,"START")=START
 ;                                          Date to start searching for orders; applies to orders with this
 ;                                          display group and overrides "ROC START".
 ;   INPUT("ROC DISPLAY GROUPS",DG,"STOP")=STOP
 ;                                          Date to stop searching for orders; applies to orders with this
 ;                                          display group and overrides "ROC STOP".
 ;   INPUT("ROC STATUS",STATUS)=""          Array of order status(es) used in searching for orders.
 ;   INPUT("ROC ORDERED WITHIN")=""         Flag indicating order date should fall between START and STOP; used
 ;                                          in searching for orders.
 ;   INPUT("ROC ORDERS",ORDERIEN)=""        Array of orders to evaluate Reminder Order Checks for. If defined,
 ;                                          the inputs of "ROC START", "ROC STOP", "ROC DISPLAY GROUPS",
 ;                                          "ROC STATUS" and "ROC ORDERED WITHIN" are not needed.
 ;   INPUT("ROC",ROC)=""                    Array of Reminder Order Check Groups to check for.
 ;                                          If ROC is ALL, run against ALL order checks.
 ;   INPUT("ROC RETURN TYPE","GROUPS")="" for groups
 ;                          ,"RULES")="" for rules
 ;                          ,"OI")="" for orderable items
 ;
 ; For Reminder List Rules:
 ;   INPUT("LR",LIST RULE NAME)=PNAME^START DATE^END DATE^SECURE^OVERWRITE^RETURN DATA
 ;                LIST RULE NAME        Name of the List Rule to evaluate file 810.4
 ;                PNAME                 Name of the Patient List to create file 810.5
 ;                SECURE                1 or 0 should the list be secure
 ;                OVERWRITE             1 or 0 if an existing patient list with the same name should be overwritten
 ;                START DATE            FM date to start the list rule from
 ;                END DATE              FM date to end the list rule from
 ;                RETURN DATA           1 or 0 to determine if data should be return with the patient
 ;
 ; For Reminder Definitions:
 ;   INPUT("DFN")=DFN                       The patient to execute the reminder definition for.
 ;   INPUT("REMINDERS",REMINDER)=SAVE_FIEVAL^MAINTENANCE_FORMAT^TODAY
 ;                 REMINDER             Reminder definition to execute; either the definition's IEN,
 ;                                          NAME or PRINT NAME
 ;                 SAVE_FIEVAL          Copy the FIEVAL array into the return TMP global (boolean flag)
 ;                 MAINTENANCE_FORMAT   How to format the maintenance section that is copied into the return TMP
 ;                                      global; see the description for the OUTPUT parameter in the MAIN^PXRM
 ;                                      line tag for acceptable values
 ;                 TODAY                Date to use for evaluation in FileMan format
 ;
 ; OUTPUT
 ;  ^TMP($J,SUB,0)=-1^ERROR MESSAGE     There is a problem with the INPUT array.
 ;  ^TMP($J,SUB,0)=1                    There is data in the OUTPUT.
 ;  ^TMP($J,SUB,0)=0                    There is no data in the OUTPUT.
 ;
 ; For Reminder Order Checks:
 ;   ^TMP($J,SUB,ORDER IEN)="Details from EN^ORQ1"^CURRENT AGENT/PROVIDER
 ;   ^TMP($J,SUB,ORDER IEN,"RULES",ORDER CHECK RULE NAME)=""
 ;   ^TMP($J,SUB,ORDER IEN,"GROUPS",ORDER CHECK GROUP NAME)=""
 ;   ^TMP($J,SUB,ORDER IEN,"TX",N)=TEXT <= ORDER TEXT FROM EN^ORQ1
 ;   ^TMP($J,SUB,ORDER IEN,"OI",OI)="Data from OIS^ORX8" <=ORDERABLE ITEMS
 ;
 ; For Reminder List Rules:
 ;   ^TMP($J,SUB,LIST RULE NAME,DFN)=""
 ;   ^TMP($J,SUB,RULE,DFN,"DATA",TYPE)=VALUE
 ;   ^TMP($J,SUB,LIST RULE NAME,"PATIENT LIST CREATED")=NAME OF PATIENT LIST, from file 810.4
 ;
 ; For Reminder Definitions:
 ;   ^TMP($J,SUB,REMINDER)="STATUS^DUE DATE^LAST DONE"
 ;   ^TMP($J,SUB,REMINDER,"PRINT NAME")=Reminder's print name (or name if print name is null)
 ;   ^TMP($J,SUB,REMINDER,"FIEVAL")=
 ;           Merged copy of the FIEVAL array
 ;   ^TMP($J,SUB,REMINDER,"MAINTENANCE",X)=Line X of the maintenance output
 ;   ^TMP($J,SUB,REMINDER,"FINDINGS",COMPONENT REMINDER)="STATUS^DUE DATE^LAST DONE"
 ;              If REMINDER has the VA-REMINDER DEFINITION computed finding and its
 ;              SAVETEMP parameter value is 1, then data for the COMPONENT REMINDER
 ;              that is executed is returned under this node
 ;   ^TMP($J,SUB,REMINDER,"FINDINGS",COMPONENT REMINDER,"FIEVAL")=
 ;              Merged copy of the FIEVAL array for COMPONENT REMINDER that is
 ;              executed as a finding, where COMPONENT REMINDER is the PRINT
 ;              NAME of that reminder
 ;   ^TMP($J,SUB,REMINDER,"FINDINGS",COMPONENT REMINDER,"MAINTENANCE",X)=
 ;              Line X of the maintenance output for COMPONENT REMINDER that is
 ;              executed as a finding, where COMPONENT REMINDER is the PRINT
 ;              NAME of that reminder
 ;
 ; INTERNAL INPUT ARRAY STRUCTURE
 ;  DATA("ROC ORDERS",ORDER IEN (FILE 100))= SET TO ZERO NODE DOCUMENTED IN EN^ORQ1
 ;  DATA("ROC ORDERS",ORDER IEN,"OI",OI)="" OI is the orderable item IEN (file 101.43) for the corresponding order
 ;  DATA("ROC ORDERS",ORDER IEN,"PKG ID")=PACKAGE REFERENCE FIELD (#33)
 ;  DATA("ROC ORDERS",ORDER IEN,"MODIFIERS",N)=EXTERNAL VALUE OF PROMPT WITH ID "MODIFIER"
 ;  DATA("EVAL",TYPE,SUB,PIECE)=VALUE  internal format used to updating reminder definition findings
 ;  DATA("EVAL","EVAL DATE")=DATE  internal format use to set the reminder evaluation date.
 ;
 N DGIENS,ORDLST,REMTYPE,SUB,DATA
 S SUB=$G(INPUT("SUB")) I SUB="" Q
 K ^TMP($J,SUB)
 S RESULT=$NA(^TMP($J,SUB))
 S @RESULT@(0)=0
 M DATA=INPUT
 ;Perform INPUT array checks
 I $$CINPUTS(.RESULT,.DATA)=1 Q
 I $D(DATA("ROC ORDERS")) D GETOIS^PXRMGEVA(.DATA)
 I $D(DATA("ROC DISPLAY GROUPS"))>0 D
 .; find display group IEN needed to find orders
 .D FINDDGS^PXRMGEVA(.RESULT,.DATA) I '$D(DATA("DG IEN")) D ERROR^PXRMGEVA(.RESULT,"No Display Group Found") Q
 .I +$G(@RESULT@(0))<0 Q
 .; find orders based off Display Groups and Status
 .D GTORDERS^PXRMGEVA(.DATA)
 I +$G(@RESULT@(0))<0 Q
 D REM^PXRMGEVA(.RESULT,.DATA)
 Q
 ;
CINPUTS(RESULT,INPUT) ;
 N DGIEN,FAIL,GNAME,NAME,NODE,ROC,ROCIENS,ROCTYPE,RIEN,%DT,X,Y
 I '$D(INPUT("ROC")),'$D(INPUT("REMINDERS")),'$D(INPUT("LR")) D ERROR^PXRMGEVA(.RESULT,"No reminders items defined") Q 1
 I '$D(INPUT("LR")) D  I +$G(@RESULT@(0))<0 Q 1
 .I +$G(INPUT("DFN"))<0 D ERROR^PXRMGEVA(.RESULT,"Patient is not properly defined") Q
 .I '$D(^DPT(INPUT("DFN"),0)) D ERROR^PXRMGEVA(.RESULT,"Invalid patient specified") Q
 ;check order checks array
 I $D(INPUT("ROC")) D  I +$G(@RESULT@(0))<0 Q 1
 .S ROCTYPE="",ROCTYPE("VALID")=0 F  S ROCTYPE=$O(INPUT("ROC RETURN TYPE",ROCTYPE)) Q:ROCTYPE=""  D
 ..I "^GROUPS^RULES^GROUPS/RULES^OI^"'[(U_ROCTYPE_U) D ERROR^PXRMGEVA(.RESULT,"Return type must be either GROUPS, RULES, GROUPS/RULES, or OI.") Q
 ..I "^GROUPS^RULES^GROUPS/RULES^"[(U_ROCTYPE_U) S ROCTYPE("VALID")=1
 .Q:+$G(@RESULT@(0))<0
 .I 'ROCTYPE("VALID") D ERROR^PXRMGEVA(.RESULT,"A return type of either GROUPS, RULES or GROUPS/RULES is required.") Q
 .I $D(INPUT("ROC ORDERS")),$D(INPUT("ROC DISPLAY GROUPS")) D ERROR^PXRMGEVA(.RESULT,"Cannot search for both Orders and Display Groups") Q
 .I $D(INPUT("ROC ORDERS")) Q
 .I '$D(INPUT("ROC STATUS")) D ERROR^PXRMGEVA(.RESULT,"No statuses or search criteria defined") Q
 .I '$D(INPUT("ROC DISPLAY GROUPS")) D ERROR^PXRMGEVA(.RESULT,"No Display Groups define")
 .S FAIL=0
 .I $D(INPUT("ROC ORDERED WITHIN")) D
 ..S DGIEN=0 F  S DGIEN=$O(INPUT("ROC DISPLAY GROUPS",DGIEN)) Q:DGIEN'>0!(FAIL=1)  D
 ...I +$G(INPUT("ROC DISPLAY GROUPS",DGIEN,"START"))=0 S FAIL=1 Q
 ...I +$G(INPUT("ROC DISPLAY GROUPS",DGIEN,"STOP"))=0 S FAIL=1 Q
 .I FAIL=1 D ERROR^PXRMGEVA(.RESULT,"No search date range defined") Q
 .I '$D(INPUT("ROC","ALL")) D
 ..S GNAME="" F  S GNAME=$O(INPUT("ROC",GNAME)) Q:GNAME=""!(FAIL=1)  D
 ...I '$D(^PXD(801,"B",GNAME)) D ERROR^PXRMGEVA(.RESULT,"Reminder Order Check Group: "_GNAME_" not found") S FAIL=1
 ;check list rule array
 I $D(INPUT("LR")) D  I +$G(@RESULT@(0))<0 Q 1
 . S NAME="" F  S NAME=$O(INPUT("LR",NAME)) Q:NAME=""  D
 . .S NODE=$G(INPUT("LR",NAME))
 . .I $P(NODE,U)="" D ERROR^PXRMGEVA(.RESULT,"Patient List Name not define") Q
 . .I $P(NODE,U,2)="" D ERROR^PXRMGEVA(.RESULT,"Start Date not define") Q
 . .I $P(NODE,U,3)="" D ERROR^PXRMGEVA(.RESULT,"End Date not define") Q
 . .I $P(NODE,U,4)="" D ERROR^PXRMGEVA(.RESULT,"Secure not define") Q
 . .I $P(NODE,U,5)="" D ERROR^PXRMGEVA(.RESULT,"Overwrite not define")
 ;check reminder definitions array
 I $D(INPUT("REMINDERS")) D  I +$G(@RESULT@(0))<0 Q 1
 .S NAME="" F  S NAME=$O(INPUT("REMINDERS",NAME)) Q:NAME=""  D
 ..S RIEN=0
 ..I NAME'?1.N D
 ...S RIEN=+$O(^PXD(811.9,"B",$E(NAME,1,64),0)) Q:RIEN>0
 ...S RIEN=+$O(^PXD(811.9,"D",$E(NAME,1,35),0))
 ..I NAME?1.N S RIEN=NAME
 ..I ('RIEN)!('$D(^PXD(811.9,RIEN,0))) D ERROR^PXRMGEVA(.RESULT,"Reminder definition does not exist") Q
 ..I $P($G(^PXD(811.9,RIEN,0)),U,6)=1 D ERROR^PXRMGEVA(.RESULT,"The reminder definition is inactive") Q
 ..S INPUT("REMINDERS",RIEN)=NAME_U_INPUT("REMINDERS",NAME)
 ..I NAME'=RIEN K INPUT("REMINDERS",NAME)
 ..S NODE=$G(INPUT("REMINDERS",RIEN)) Q:NODE=""
 ..I "^0^1^"'[(U_$P(NODE,U,2)_U) D ERROR^PXRMGEVA(.RESULT,"Invalid SAVE_FIEVAL flag; set it to either 0 or 1") Q
 ..I $P(NODE,U,4)'="" D
 ...S %DT="",X=$P(NODE,U,4)
 ...D ^%DT
 ...I Y=-1 D ERROR^PXRMGEVA(.RESULT,"Invalid value for TODAY") Q
 ...S $P(INPUT("REMINDERS",RIEN),U,4)=Y
 Q 0
 ;
