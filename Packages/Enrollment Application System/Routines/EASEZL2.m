EASEZL2 ;ALB/jap - 1010EZ List Manager Processing Screens (cont.) ;12/12/00  13:07
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;;Mar 15, 2001
 ;
HELP2 ;Help code
 I $D(X),X'["??" D  Q
 .D CLEAR^VALM1
 .W !!,?2,"Only two actions require a list line number indentifier --",!
 .W !,?6,IOINHI,"AF Accept Field",IOINORM," -->",?22,"Enter ",IORVON,"AF=n",IORVOFF," to act on the field shown in line #n."
 .W !,?6,IOINHI,"UF Update Field",IOINORM," -->",?22,"Enter ",IORVON,"UF=n",IORVOFF," to act on the field shown in line #n."
 .W !!,?2,"All other actions act on the Application as a whole,"
 .W !,?2,"so a line number is not used."
 .W !!,?2,"Actions ",IOINHI,"Verify Signature",IOINORM,", ",IOINHI,"File 10-10EZ",IOINORM,", and ",IOINHI,"Inactivate",IOINORM
 .W !,?2,"can be used only once per Application."
 .D PAUSE^VALM1 S VALMBCK="R"
 D CLEAR^VALM1
 I EASPSTAT="NEW" D  Q
 .W !!,"Allowed actions for NEW Applications are:",!
 .D HLZ
 .D HIZ
 .D PAUSE^VALM1 S VALMBCK="R"
 I EASPSTAT="REV" D  Q
 .W !!,"Allowed actions for IN REVIEW Applications are:",!
 .D HAF
 .D HAZ
 .D HUF
 .D HCZ
 .D PAUSE^VALM1
 .D HRZ
 .D HPZ
 .D HVZ
 .D HIZ
 .D PAUSE^VALM1 S VALMBCK="R"
 I EASPSTAT="PRT" D  Q
 .W !!,"Allowed actions for PENDING SIGNATURE Applications are:",!
 .D HRZ
 .D HPZ
 .D PAUSE^VALM1
 .D HVZ
 .D HIZ
 .D PAUSE^VALM1 S VALMBCK="R"
 I EASPSTAT="SIG" D  Q
 .W !!,"Allowed actions for SIGNED Applications are:",!
 .D HUF
 .D HPZ
 .D PAUSE^VALM1
 .D HFZ
 .D PAUSE^VALM1 S VALMBCK="R"
 I EASPSTAT="FIL" D  Q
 .W !!,"Allowed actions for FILED Applications are:",!
 .D HPZ
 .D PAUSE^VALM1 S VALMBCK="R"
 I EASPSTAT="CLS" D  Q
 .W !!,"There are no allowed actions for an INACTIVATED Application.",!
 .D PAUSE^VALM1 S VALMBCK="R"
 Q
 ;
HLZ ;
 W !!,?2,IOINHI,"LZ  Link to Patient File",IOINORM
 W !,?6,"The veteran associated with a NEW Application must be 'linked' to"
 W !,?6,"the VistA Patient database."
 W !,?6,"VistA Patient Lookup function is employed to match the applicant"
 W !,?6,"to an existing Patient OR to establish a new Patient record."
 Q
 ;
HAF ;
 W !!,?2,IOINHI,"AF  Accept Field",IOINORM," --> Enter ",IORVON,"AF=n",IORVOFF," to act on the field shown in line #n."
 W !,?6,"The 10-10 EZ data element on line #n is 'accepted' for later filing"
 W !,?6,"into the VistA Patient database."
 W !,?6,"Using this action on a previously 'accepted' data element,"
 W !,?6,"removes the 'accepted' indicator."
 Q
 ;
HAZ ;
 W !!,?2,IOINHI,"AZ  Accept All",IOINORM
 W !,?6,"All 10-10 EZ data element are 'accepted' for later filing into"
 W !,?6,"the VistA Patient database."
 Q
 ;
HCZ ;
 W !!,?2,IOINHI,"CZ  Clear All",IOINORM
 W !,?6,"The 'accepted' indicator is removed from any fields previously"
 W !,?6,"'accepted'."
 Q
 ;
HRZ ;
 W !!,?2,IOINHI,"RZ  Reset to New",IOINORM
 W !,?6,"The Application is returned to the 'New' processing status."
 W !,?6,"It can be re-matched to the VistA database."
 Q
 ;
HIZ ;
 W !!,?2,IOINHI,"IZ  Inactivate",IOINORM
 W !,?6,"Once the Application is inactivated, it will no longer be available"
 W !,?6,"for processing."
 W !,?6,"Use this action only if the Application is deemed invalid or is being"
 W !,?6,"replaced by a new Application."
 Q
 ;
HPZ ;
 W !!,?2,IOINHI,"PZ  Print 10-10EZ",IOINORM
 W !,?6,"Once the 10-10EZ is Printed, actions of Accept Field, Accept All,"
 W !,?6,"Clear All, and Update Field can no longer be used."
 W !,?6,"The 10-10EZ form is printed using all 'accepted' data. "
 W !,?6,"VistA Patient data is used for any fields not 'accepted'."
 W !,?6,"Printing must be queued to a valid print device."
 Q
 ;
HVZ ;
 W !!,?2,IOINHI,"VZ  Verify Signature",IOINORM
 W !,?6,"The user verifies that the Applicant's signature appears on a"
 W !,?6,"printed 10-10EZ."
 Q
 ;
HUF ;
 W !!,?2,IOINHI,"UF  Update Field",IOINORM," --> Enter ",IORVON,"UF=n",IORVOFF," to act on the field shown in line #n."
 W !,?6,"The 10-10 EZ data element on line #n can be overwritten by the user for"
 W !,?6,"later filing into VistA."
 W !,?6,"This action should be used to enter the Applicant's hand-written"
 W !,?6,"changes to the signed 10-10EZ."
 Q
 ;
HFZ ;
 W !!,?2,IOINHI,"FZ  File 10-10EZ",IOINORM
 W !,?6,"All 'accepted' data elements on the 10-10EZ are filed to the"
 W !,?6,"VistA Patient database."
 W !,?6,"Use this action with caution -- 10-10EZ data elements will overwrite"
 W !,?6,"any existing data in Vista."
 Q
