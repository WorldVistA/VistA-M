PXKFVST ;ISL/JVS - Fields for VISIT file ;7/29/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**22,56,111,130,124,164,168**;Aug 12, 1996;Build 14
 ;
 ;  Adding or Editing of data in a particular field can be controlled
 ;by adding a ~ as a delimiter and the letters A and/or E to the
 ;end of the line of text which represents what could be added
 ;to the DR string in a DIE call.
 ; 1. If none or all three(~AE) of these characters are added then
 ;    the data in this field can be either added or edited.
 ; 2. If only the ~ is added then the data in this field can be
 ;    neither added or edited.
 ; 3. IF only the ~A is added then the data can only be added to
 ;    the file for this field but not edited.
 ; 4. If only the ~E is added the data can only be edited in
 ;    this file for this field. (not a likely possibility)
 ;
 ; The word "OPTION" in front of the line of text below tells the 
 ;software to determine,based on the data, the appropriateness
 ;of using either a "///" or "////" stuff in a DIE call.
 ;
 ; The information on line tag 0 $P(,," * ",1) are the piece numbers
 ;of the fields on the zero node that are required by the data
 ;dictionary and are checked for to determine if enough data is present
 ;to proceed without any errors. $P(,," * ",2) are the nodes and
 ;piece numbers of the fields used to determine duplicates in the
 ;file (node+piece (eg. 12+4)). $P(,," * ",3) is a flag use to
 ;determine if duplicates are allowed in this visit file. 
 ;If it is set to 0 then no duplicate checks will occur. If it is
 ;set to 1 then the file will be checked for duplicates based on
 ;the information in $P 2.
 ;
 ; The following is the file's global name.  Each global must have a
 ;unique name and can not have any subscripts as part of the global root.
GLOBAL ;;^AUPNVSIT
 ;
EN1 ;
 S PXKER=""
 S PXKER=$P($T(@PXKNOD+PXKPCE),";;",2) Q
EN2 ;
 S PXKFD=""
 S PXKFD=$P($T(@PXKNOD+PXKPCE),";;",2) D
 .I PXKFD="" S PXKPCE=PXKPCE+1 D EN2
 Q
ADD ;Add an entry to the file
 Q
0 ;;1,3,5,7,8,22 *  * 0
 ;;.01///^S X=$G(~
 ;;.02///^S X=$G(~
 ;;.03///^S X=$G(~
 ;;
 ;;.05////^S X=$G(~
 ;;.06////^S X=$G(~
 ;;.07///^S X=$G(~
 ;;.08////^S X=$G(~
 ;;.09///^S X=$G(~
 ;;
 ;;.11///^S X=$G(~
 ;;.12////^S X=$G(~
 ;;.13///^S X=$G(~
 ;;
 ;;
 ;;
 ;;
 ;;.18///^S X=$G(~
 ;;
 ;;
 ;;.21////^S X=$G(~
 ;;.22////^S X=$G(~
 ;;.23////^S X=$G(~
 ;;.24////^S X=$G(~
 ;;
 ;;.26////^S X=$G(~
21 ;;
 ;;2101///^S X=$G(~
800 ;;
 ;;80001///^S X=$G(~
 ;;80002///^S X=$G(~
 ;;80003///^S X=$G(~
 ;;80004///^S X=$G(~
 ;;80005///^S X=$G(~ ;added 6/17/98 for MST enhancement
 ;;80006///^S X=$G(~ ;PX*1*111 - added for HNC enhancement
 ;;80007///^S X=$G(~ ;PX*1*130
 ;;80008///^S X=$G(~ ;PX*1*168
812 ;;
 ;;81201///^S X=$G(
 ;;81202////^S X=$G(
 ;;81203////^S X=$G(
 ;
UPD ;Up date visit file using visit tracking
 ;--new VSIT to make sure that none are left around after call
 N PXTMPVST
 S PXTMPVST=VSIT("IEN")
 N VSIT
 S VSIT("IEN")=PXTMPVST
 I $G(PXKAV(0,8))]"" D
 .I PXKAV(0,8)="@" S VSIT("DSS")="@"
 .E  D
 ..K ^UTILITY("DIQ1",$J)
 ..S DIC=40.7,DA=+$G(PXKAV(0,8)),DIQ(0)="I",DR=1 D EN^DIQ1
 ..S VSIT("DSS")=$G(^UTILITY("DIQ1",$J,40.7,DA,1,"I"))
 K ^UTILITY("DIQ1",$J),DIQ,DR,DA,DIC
 I $G(PXKAV(0,6))]"" S VSIT("INS")=$G(PXKAV(0,6))
 I $G(PXKAV(0,18))]"" S VSIT("COD")=$G(PXKAV(0,18))
 ;--cannot edit "ELG"
 I $G(PXKAV(0,22))]"" S VSIT("LOC")=$G(PXKAV(0,22))
 I $G(PXKAV(0,26))]"" S VSIT("ACT")=$G(PXKAV(0,26)) ;PX*1.0*164 Set Patient Account Number reference
 ;Classification questions
 N PXP,PXV,PXN
 ;AO, IR, and EC not applicable if SC answered YES (1)
 ;I $G(PXKAV(800,1))=1 F PXP=2:1:4 S PXKAV(800,PXP)="@"
 F PXP=1:1:8 D
 .S PXV=$G(PXKAV(800,PXP))
 .S PXN=$P("SC^AO^IR^EC^MST^HNC^CV^SHAD","^",PXP)
 .I PXV'="" S VSIT(PXN)=PXV
 D UPD^VSIT
 K VSIT("DSS"),VSIT("COD"),VSIT("SC"),VSIT("AO"),VSIT("IR"),VSIT("EC")
 K VSIT("LOC"),VSIT("INS"),VSIT("ELG"),VSIT("MDT")
 ;PX*1*111 - added for HNC enhancement
 K VSIT("MST"),VSIT("HNC"),VSIT("CV"),VSIT("SHAD")
 Q
SPEC ;
 Q
