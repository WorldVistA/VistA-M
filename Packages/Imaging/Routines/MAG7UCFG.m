MAG7UCFG ;WOIFO/MLH - Configure HL7 PACS interface ; 02 Apr 2008 4:29 PM
 ;;3.0;IMAGING;**49**;Mar 19, 2002;Build 2033;Apr 07, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
CONFIG ; MAIN ENTRY POINT - Configure the HL7 PACS interface
 ; Allow user to specify sender and receiver names, and to toggle
 ; the interface between active/inactive.
 ; 
 ; Called by Option MAG CONFIGURE IHE PACS HL7 I/F.
 ; 
 N DA,DIC,DIE,DIQ,DR,DTOUT,DUOUT ; -- FileMan work variables
 N APP ; ------ work array for DIQ application lookups
 N SNDIX ; ---- IEN of the sending application
 N SNDNAME ; -- name of the sending application
 N RCVIX ; ---- IEN of the receiving application
 N RCVNAME ; -- name of the receiving application
 N LINKIX ; --- IEN of the logical link
 ;
 W !!,"HL7 PACS Interface Configuration",!!
 ;
 ; Look up the sending application
 S DIC="^ORD(101,",X="MAG CPACS A01",DIC(0)="X"
 D ^DIC I Y<0 D  G ABEND
 . W !,"ERROR:  HL7 messaging event driver protocol(s) missing."
 . Q
 K APP S DIQ="APP",DIQ(0)="I",DIC="^ORD(101,",DA=$P(Y,U,1),DR=770.1
 D EN^DIQ1 S SNDIX=$G(APP(101,DA,770.1,"I"))
 I SNDIX'>0 D  G ABEND
 . W !,"ERROR:  No sending application defined."
 . Q
 ; Look up sender name directly in application file - this allows
 ; us to catch a missing pointer
 K APP S DIQ="APP",DIQ(0)="IE",DIC="^HL(771,",DA=SNDIX,DR=.01
 D EN^DIQ1 I '$D(APP) D  G ABEND
 . W !,"ERROR:  Pointed-to sender entry ("_DA_") missing"
 . W !,"        from HL7 APPLICATION PARAMETER File (#771)."
 . Q
 S SNDNAME=$G(APP(771,DA,.01,"E"))
 ;
 ; Look up the receiving application
 S DIC="^ORD(101,",X="MAG CPACS A01 SUBS",DIC(0)="X"
 D ^DIC I Y<0 D  G ABEND
 . W !,"ERROR:  HL7 messaging subscriber protocol(s) missing."
 . Q
 K APP S DIQ="APP",DIQ(0)="I",DIC="^ORD(101,",DA=$P(Y,U,1),DR=770.2
 D EN^DIQ1 S RCVIX=$G(APP(101,DA,770.2,"I"))
 I RCVIX'>0 D  G ABEND
 . W !,"ERROR:  No receiving application defined."
 . Q
 ; Look up receiver name directly in application file - this allows
 ; us to catch a missing pointer
 K APP S DIQ="APP",DIQ(0)="IE",DIC="^HL(771,",DA=RCVIX,DR=.01
 D EN^DIQ1 I '$D(APP) D  G ABEND
 . W !,"ERROR:  Pointed-to receiver entry ("_DA_") missing"
 . W !,"        from HL7 APPLICATION PARAMETER File (#771)."
 . Q
 S RCVNAME=$G(APP(771,DA,.01,"E"))
 ;
 W !,"Sending application name:    "_SNDNAME,!
 W "Receiving application name:  "_RCVNAME,!
 S DIR("A")="Do you wish to change either of these names? ",DIR(0)="YA"
 D ^DIR G END:$D(DTOUT),END:$D(DUOUT)
 I Y D  G END:$D(DTOUT),END:$D(Y)
 . W !!,"Please enter the name of the SENDING application."
 . S DIE="^HL(771,",DA=SNDIX,DR=.01 D ^DIE Q:$D(DTOUT)  Q:$D(Y)
 . W !,"Please enter the name of the RECEIVING application."
 . S DIE="^HL(771,",DA=RCVIX,DR=.01 D ^DIE Q:$D(DTOUT)  Q:$D(Y)
 . Q
 ;
 ; Look up the logical link
 S DIC="^HLCS(870,",X="MAG CPACS",DIC(0)="X"
 D ^DIC I Y<0 D  G ABEND
 . W !,"ERROR:  HL7 logical link missing."
 . Q
 D  G END:$D(DTOUT),END:$D(Y) ; update link information
 . S LINKIX=+Y
 . W !!,"Please enter the TCP/IP address and port number for the logical link."
 . S DIE="^HLCS(870,",DA=LINKIX,DR="400.01;400.02" D ^DIE Q:$D(DTOUT)  Q:$D(Y)
 . Q
 ;
 ; Toggle the interface
 W !!,"Enter Y or YES below to turn the IHE-based HL7 PACS interface ON;",!
 W "enter N or NO to turn the interface OFF.",!
 S DIE="^MAG(2006.1,",DA=1,DR=3.01 D ^DIE Q:$D(DTOUT)  Q:$D(Y)
 G END
 ;
ABEND ;
 W !,"PACS HL7 messaging must be installed before using this option."
 W !,"Please contact Imaging Support for further assistance."
END ;
 Q
