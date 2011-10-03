RAO7RO1 ;HISC/FPT-RAD/NM Error Messages ;8/28/97  14:16
 ;;5.0;Radiology/Nuclear Medicine;**2,75,86**;Mar 16, 1998;Build 7
 ;
EN1(RAERR) ; errors encountered with OE v3.0 back & frontdoor transmission
 S RAEMSG=$P($T(MSG+RAERR),";",4)
 I RAEMSG]"" Q RAEMSG
 Q "Error # "_RAERR_" does not exist"
 ;
 ;Note: Error code nine (9) disappears with the release of CPRS GUI V27. P86
 ;
MSG ; error messages
 ;;1;Missing/Invalid Order Control
 ;;2;Missing/Invalid Patient ID
 ;;3;Missing/Invalid Patient Location
 ;;4;Missing/Invalid User DUZ
 ;;5;Missing/Invalid REQUEST URGENCY
 ;;6;Missing/Invalid REQUESTING PHYSICIAN
 ;;7;Entered Date/Time is in the Future
 ;;8;Invalid Procedure, Inactive, no Imaging Type or no Procedure Type
 ;;9;Patient Class disagrees with Patient Location
 ;;10;Invalid ISOLATION PROCEDURES
 ;;11;Invalid MODIFIER(s)
 ;;12;Missing/Invalid IMAGING LOCATION or not the same as procedure's
 ;;13;Missing/Invalid MODE OF TRANSPORT
 ;;14;Missing/Invalid PREGNANT value
 ;;15;Missing/Invalid CLINICAL HISTORY FOR EXAM
 ;;16;Missing/Invalid Placer Number
 ;;17;Missing/Invalid OBX Value Type
 ;;18;Missing/Invalid CONTRACT/SHARING SOURCE
 ;;19;Missing/Invalid RESEARCH SOURCE
 ;;20;Missing/Invalid PRE-OP SCHEDULED DATE/TIME
 ;;21;Error Filing New Entry
 ;;22;Missing/Invalid Filler Number
 ;;23;Missing/Invalid Cancel or Hold Reason
 ;;24;
 ;;25;Current status will not permit request to be put in DISCONTINUED status
 ;;26;Error filing Placer Number
 ;;27;Missing/Invalid CATEGORY OF EXAM
 ;;28;Invalid REQUEST DATE (TIME optional)
 ;;29;CATEGORY OF EXAM cannot be Research AND Contract/Sharing
 ;;30;Error Filing New Entry in Request Status Times multiple
 ;;31;Imaging Type mismatch between the Procedure and Imaging Location
 ;;32;Parent procedure does not have descendents
 ;;33;Imaging Type mismatch between the Procedure and MODIFIER(s)
 ;;34;Invalid MODFIERS(s) for a series procedure
 ;;35;FileMan rejected date/time
 ;;36;Invalid Approving Rad/Nuc Med physician
 ;;37;Rad/Nuc Med order not placed in a DISCONTINUED status
 ;;38;Missing REASON FOR STUDY value
 ;;39;Invalid REASON FOR STUDY value
