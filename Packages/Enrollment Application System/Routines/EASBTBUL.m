EASBTBUL  ;ALB/DHS,LMD - Beneficiary Travel Bulletin - Create and Send ;10/30/2014 8:43am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**113**;OCT 31, 2014;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; EAS*1*113 Send Bulletin if BTFI is different than what is on file
 ;
 ; this routine will send the Beneficiary Travel Bulletin for the specified conditions:
 ; When a converted/reversal Rx Copay Test is received from IVM, a check will be done to
 ; see if the new copay exemption status is different than the old copay exemption status.
 ; If the status has changed, Beneficiary Travel Eligible indicator a bulletin will be sent
 ; to the BT CLAIMS PROCESSING mail group.
 ;
 ; This routine is called from EASPREC6 and EASPREC7 at the end of ORU-Z06 processing ;EASPREC6
 ;
SET(DFN,DT,DGCAT,IVMCEB,IVM10) ; Create and Send BT Bulletin
 ;
 ; Input:
 ; DFN = IEN of Patient
 ; DT = Today's Date
 ; DGCAT = Current Means Test Status
 ; IVMCEB = Previous Means Test Status
 ; IVM10 = Date/Time Test Completed
 ;
 N IFN,DATA,SSN,X
 ;
 ;SSN
 I $D(^DPT(DFN,.36)) S X=^DPT(DFN,.36) I +X S SSN=$P(X,"^",4)
 I SSN="" S X=$P(^DPT(DFN,0),"^",9) I X]"" S SSN=$E(X,6,10)
 ;
 ; External Reference to ^DGBT(392.2 supported by DBIA #6015  ;DS THIS FILE DATA DOESNT EXIST
 S IFN=$$FIND1^DIC(392.2,"","MXQ",DFN,"","","ERR")
 ; Check if Beneficiary Travel Date Certified is within the last year
 ;I $$GET1^DIQ(392.2,IFN,"DATE CERTIFIED","I")<($P(DT,".",1)-10000) Q
 ;
 ; Input raw data into DATA array to set variables in Bulletin
 ;
 ; Patient DFN number
 S DATA(10)=DFN
 ; Patient Name
 S DATA(1)=$$GET1^DIQ(2,DFN,"NAME","I")
 ; Last 4 of SSN
 S DATA(2)=SSN
 ; Patient VPID
 S DATA(3)=$$GETICN^MPIF001(DFN)
 ; Patient IEN
 S DATA(4)=DFN
 ; Station Number
 S DATA(5)=$P($$SITE^VASITE(),"^",3)
 ; Previous Category
 S DATA(6)=IVMCEB
 ; New Category
 S DATA(7)=DGCAT
 ; Date of Test
 S Y=$P(IVM10,".") X ^DD("DD")
 S DATA(8)=Y
 ; Converted Income Year
 S Y=$$LYR^DGMTSCU1(IVM10) X ^DD("DD")
 S DATA(9)=Y
 ;
 D SENDBUL
 ;
 Q
 ;
KILL ; Remove RX Bulletin - Not used at this time
 ;
 ; This is a placeholder should it be found in the future that any data from the SET
 ; needs cleaned up.
 ;
 Q
 ;
SENDBUL ; transmit bulletin
 ;
 ; Protect Fileman from Mailman call
 N DIC,DIX,DIY,DO,DD,DFN,VSITE,XMINSTR
 N DICRREC,DIDATA,DIEFAR,DIEFCNOD,DIEFDAS,DIEFECNT,DIEFF,DIEFFLAG
 N DIEFFLD,DIEFFLST,DIEFFREF,DIEFFVAL,DIEFFXR,DIEFI,DIEFIEN,DIEFLEV
 N DIEFNODE,DIEFNVAL,DIEFOUT,DIEFOVAL,DIEFRFLD,DIEFRLST,DIEFSORK
 N DIEFSPOT,DIEFTMP,DIEFTREF,DIFLD,DIFM,DIQUIET,DISYS,D,D0,DA
 ;
 ; Set From Line of Email
 S XMINSTR("FROM")=.5
 ;
 ; Send email
 ;D SENDBULL^XMXAPI(DUZ,"RX COPAY TEST",.DATA,,,.XMINSTR)
 D SENDBULL^XMXAPI(DUZ,"EAS BT CLAIMS PROCESSING",.DATA,,,.XMINSTR)  ;EAS BT CLAIMS PROCESSING
 ;
 ;
 Q
 ;
