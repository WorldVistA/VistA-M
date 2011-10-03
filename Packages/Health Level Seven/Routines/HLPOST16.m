HLPOST16 ;AISC/SAW,JRP - Post-init Routine for DHCP HL7 v. 1.6 ;1/24/95
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
 ;Declare variables
 N DA,DIC,DIE,DR,X,Y,HLAPP,HLMID,HLST,HLX,HLORIGDT,HLORIGMI
 N HLX1,HLCNVCNT,HLPRTDOT,HLABORT,HLAPNM,HLTMP,HLORIGAP,HLORIGST
 S HLABORT=0
 W !!,"- File conversions started on ",$$DH4PRT^HLCSFMN1()," -"
 ;Add entries in file 770 into file 771
 W !!,"Copying entries from HL7 NON-DHCP APPLICATION PARAMETER file (#770)"
 W !,"to HL7 APPLICATION PARAMETER file (#771) "
 ;Lock files
 L +^HL(771):10 I ('$T) D  Q
 .W !!,"** Conversion halted **"
 .W !,"** Unable to lock HL7 APPLICATION PARAMETER file **"
 .W !,"** Use the entry point REQUEUE^HLPOST to requeue the file conversions **"
 .S:($D(ZTQUEUED)) ZTREQ="@"
 L +^HL(770):10 I ('$T) D  Q
 .L -^HL(771)
 .W !!,"** Conversion halted **"
 .W !,"** Unable to lock HL7 NON-DHCP APPLICATION PARAMETER file **"
 .W !,"** Use the entry point REQUEUE^HLPOST to requeue the file conversions **"
 .S:($D(ZTQUEUED)) ZTREQ="@"
 ;Loop through 770
 S HLX=0 F HLCNVCNT=1:1 S HLX=$O(^HL(770,HLX)) Q:HLX'>0  D  Q:(HLABORT)
 .W:('(HLCNVCNT#5)) "." W:($X>(IOM-2)) !
 .;User aborted
 .S HLABORT=$$S^%ZTLOAD
 .Q:(HLABORT)
 .;Get application name
 .S HLX1=$G(^HL(770,HLX,0))
 .S HLAPNM=$P(HLX1,"^",1)
 .I (HLAPNM="") D  Q
 ..W !,?5,"* Entry number ",HLX," does not have an application name"
 .;Entry already converted
 .Q:($P(HLX1,"^",12))
 .;If entry exists in 770 and 771 with same name, change name of
 .;  entry in 771 by appending "-DHCP" to it
 .S DA=$O(^HL(771,"B",HLAPNM,0)) I DA D
 ..S DIE="^HL(771,",DR=".01///"_HLAPNM_"-DHCP" D ^DIE K DIE,DR
 .K DA,DD,DO S DIC="^HL(771,",X=HLAPNM,DIC(0)="" D FILE^DICN
 .I ('Y) D  Q
 ..W !,?5,"* Unable to copy ",HLAPNM," (entry #",HLX,")"
 .S DIE="^HL(771,",DR="2///a;3///"_$P(HLX1,"^",3),DA=+Y D ^DIE K DIE,DR
 .;Stuff pointer to 771 in field 12 of file 770
 .S DR="12///"_DA,DA=HLX,DIE="^HL(770," D ^DIE
 L -^HL(771)
 L -^HL(770)
 I (HLABORT) D  Q
 .W !!,"** Conversion of files has been asked to stop **"
 .W !,"** Use the entry point REQUEUE^HLPOST to requeue the file conversions **"
 .S:($D(ZTQUEUED)) ZTREQ="@"
 ;Purge data in file 772 so that only last seven days are retained
 W !!,"Purging data from HL7 MESSAGE TEXT file (#772) "
 S HLPRTDOT=1
 D DQ^HLUOPT1
 I ($$S^%ZTLOAD) D  Q
 .W !!,"** Conversion of files has been asked to stop **"
 .W !,"** Use the entry point REQUEUE^HLPOST to requeue the file conversions **"
 .S:($D(ZTQUEUED)) ZTREQ="@"
 ;Convert data in fields .01,3 and 20 of file 772 to new format
 W !!,"Converting newly defined fields in HL7 MESSAGE TEXT file (#772) "
 ;Loop through 772
 S HLX=0
 F HLCNVCNT=1:1 S HLX=+$O(^HL(772,HLX)) Q:(HLX'>0)  D  Q:(HLABORT)
 .;Lock entry
 .L +^HL(772,HLX):10 I ('$T) D  Q
 ..W !,?5,"* Unable to lock entry number ",HLX,"  -  entry not converted"
 ..;Check for user aborted
 ..S HLABORT=$$S^%ZTLOAD
 .W:('(HLCNVCNT#5)) "." W:($X>(IOM-2)) !
 .;User aborted
 .S HLABORT=$$S^%ZTLOAD
 .I (HLABORT) L -^HL(772,HLX) Q
 .;Get date/time of message (field #.01)
 .S HLX1=$G(^HL(772,HLX,0))
 .S HLORIGDT=+HLX1
 .I ('HLORIGDT) D  Q
 ..W !,?5,"* Entry number ",HLX," does not have a date & time of message"
 ..L -^HL(772,HLX)
 .;Already converted
 .I ((HLORIGDT'?7N.1".".6N)!($D(^HLMA(HLORIGDT)))) L -^HL(772,HLX) Q
 .;Get application name (field #3)
 .S HLORIGAP=$P($G(^HL(770,+$P(HLX1,"^",3),0)),"^")
 .;Get status (field #20)
 .S HLORIGST=$P($G(^HL(772,HLX,"P")),"^")
 .;Get message ID (field #6)
 .S HLORIGMI=$P(HLX1,"^",6)
 .;Convert .01 field by creating entry in file #773 to point to
 .;  HLMID will be a pointer to file #773, if it is KILLED before
 .;  making the call
 .K HLMID D MA^HLTF(HLORIGDT) K HLDT
 .;Convert field 3
 .S HLAPP=""
 .S:(HLORIGAP'="") HLAPP=+$O(^HL(771,"B",HLORIGAP,0))
 .;Convert field 20
 .S HLST=$S(HLORIGST="P":1,HLORIGST="A":2,HLORIGST="E":4,1:3)
 .;Store converted values
 .I $G(HLMID) D
 ..S DIE="^HL(772,"
 ..S DA=HLX
 ..S DR=".01////"_HLMID_";3////"_HLAPP_";20////"_HLST
 ..D ^DIE
 ..;Change message IDs to match original message ID
 ..S DIE="^HL(772,"
 ..S DA=HLX
 ..S DR="6////"_HLORIGMI
 ..D ^DIE
 ..S DIE="^HLMA("
 ..S DA=HLMID
 ..S DR="2////"_HLORIGMI
 ..D ^DIE
 .;Unlock entry
 .L -^HL(772,HLX)
 I (HLABORT) D  Q
 .W !!,"** Conversion of files has been asked to stop **"
 .W !,"** Use the entry point REQUEUE^HLPOST to requeue the file conversions **"
 .S:($D(ZTQUEUED)) ZTREQ="@"
 W !!,"- File conversions completed on ",$$DH4PRT^HLCSFMN1()," -",!!
 S:($D(ZTQUEUED)) ZTREQ="@"
 Q
