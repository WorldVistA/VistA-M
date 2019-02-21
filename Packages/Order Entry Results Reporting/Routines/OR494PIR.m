OR494PIR ;HPS-CS/JSG - OR*3.0*494 POST INSTALL ROUTINE;SEP 27, 2018@13:00
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**494**;Sep 27, 2018;Build 4
 ;Examines the INTERVAL ITEM in the ORDER DIALOG file #101.41 to make the
 ;INTERVAL ITEM a required response when the NUMBER OF APPOINTMENTS ITEM 
 ;is greater than one (1).
 ;
 D MES^XPDUTL("Checking the ORDER DIALOG file for suitability to apply changes")
 D MES^XPDUTL("to ORDER DIALOG SD RTC to modify the ITEM INTERVAL.")
 S ORPIRIEN=$O(^ORD(101.41,"AB","SD RTC",0)) I 'ORPIRIEN D  Q
 .D MES^XPDUTL("ORDER DIALOG SD RTC missing from instance - no update.")
 S ORPIRSEQ=$O(^ORD(101.41,ORPIRIEN,10,"B",20.5,0)) I 'ORPIRSEQ D  Q
 .D MES^XPDUTL("ITEM INTERVAL is not on the ORDER DIALOG SD RTC - no update.")
 S ORPIRINT=$G(^ORD(101.41,ORPIRIEN,10,ORPIRSEQ,3)) I ORPIRINT'="I +$$VAL^ORCD(""NUMBER OF APPOINTMENTS"")>1" D  Q
 .D MES^XPDUTL("ITEM INTERVAL value is not as expected - no update.")
 I $D(^ORD(101.41,ORPIRIEN,10,ORPIRSEQ,.1)) D  Q
 .D MES^XPDUTL("INPUT TRANSFORM already esists - no update.")
SET ;
 S ^ORD(101.41,ORPIRIEN,10,ORPIRSEQ,3)=ORPIRINT_" S REQD=1"
 S ^ORD(101.41,ORPIRIEN,10,ORPIRSEQ,.1)="I +$$VAL^ORCD(""NUMBER OF APPOINTMENTS"")>1,X<1 K X"
 D MES^XPDUTL("ITEM INTERVAL value updated.")
END ;
 K ORPIRIEN,ORPIRSEQ,ORPIRINT
 Q
ROLL ;Reset INTERVAL ITEM to original value should the patch need to rolled back.
 W !,"Checking the ORDER DIALOG file for suitability to roll back"
 W !,"the patch change to the ITEM INTERVAL."
 S ORPIRIEN=$O(^ORD(101.41,"AB","SD RTC",0)) I 'ORPIRIEN D  Q
 .W !,"ORDER DIALOG SD RTC missing from instance - no roll back."
 S ORPIRSEQ=$O(^ORD(101.41,ORPIRIEN,10,"B",20.5,0)) I 'ORPIRSEQ D  Q
 .W !,"ITEM INTERVAL is not on the ORDER DIALOG SD RTC - no roll back."
 S ORPIRINT=$G(^ORD(101.41,ORPIRIEN,10,ORPIRSEQ,3)) I ORPIRINT'[" S REQD=1" D  Q
 .W !,"ITEM INTERVAL value is not as expected - no roll bacck."
BACK ;
 S ^ORD(101.41,ORPIRIEN,10,ORPIRSEQ,3)="I +$$VAL^ORCD(""NUMBER OF APPOINTMENTS"")>1"
 I $D(^ORD(101.41,ORPIRIEN,10,ORPIRSEQ,.1)) K ^(.1)
 W !!,"ITEM INTERVAL for SD RTC restored to pre-patch value:"
 W !,"I +$$VAL^ORCD(""NUMBER OF APPOINTMENTS"")>1"
 K ORPIRIEN,ORPIRSEQ,ORPIRINT
 Q
