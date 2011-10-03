EASEZU3 ;ALB/jap - Utilities for 1010EZ Processing ;10/12/00  13:08
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**1,57**;Mar 15, 2001
 ;
NSD(EASAPP,TYPE,MULTIPLE) ;get name, ssn, dob for person of interest
 ;input  EASAPP = application ien in file #712
 ;         TYPE = "APPLICANT", "SPOUSE", "CHILD1", or "CHILD(N)"
 ;     MULTIPLE = default to 1, unless TYPE="CHILD(N)"
 ;output  RTR   =  name^ssn^dob
 N RTR,KEY,EASNAME,EASSSN,EASDOB,LAST,FIRST,MDL,SUFF
 S RTR="",EASNAME="",EASSSN="",EASDOB=""
 S KEY=+$$KEY711^EASEZU1(TYPE_" LAST NAME") I KEY S LAST=$P($$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE),U,1)
 S KEY=+$$KEY711^EASEZU1(TYPE_" FIRST NAME") I KEY S FIRST=$P($$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE),U,1)
 S KEY=+$$KEY711^EASEZU1(TYPE_" MIDDLE NAME") I KEY S MDL=$P($$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE),U,1)
 S KEY=+$$KEY711^EASEZU1(TYPE_" SUFFIX NAME") I KEY S SUFF=$P($$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE),U,1)
 I (LAST="")!(FIRST="") Q RTR
 S EASNAME=LAST_","_FIRST
 I $L(EASNAME)+$L(MDL)>45 S MDL=$E(MDL,1)
 I MDL'="" S EASNAME=EASNAME_" "_MDL
 I SUFF'="" S EASNAME=EASNAME_" "_SUFF
 S EASNAME=$$UC^EASEZT1($E(EASNAME,1,45))
 S KEY=+$$KEY711^EASEZU1(TYPE_" SOCIAL SECURITY NUMBER")
 I KEY S EASSSN=$P($$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE),U,1),EASSSN=$$SSNOUT^EASEZT1(EASSSN)
 S KEY=+$$KEY711^EASEZU1(TYPE_" DATE OF BIRTH")
 I KEY S EASDOB=$P($$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE),U,1)
 S RTR=EASNAME_U_EASSSN_U_EASDOB
 Q RTR
 ;
LINK ;
 ;link applicant to file #2 as new or existing patient
 Q:EASVIEW'=1
 S EASPSTAT="NEW"
 D DFN^EASEZI(EASAPP,.EASDFN)
 I $G(EASDFN)>0 D
 .D SETDATE^EASEZU2(EASAPP,"REV") S EASPSTAT="REV"
 .D BLD^EASEZLM
 .W ! D WAIT^DICD,EN^VALM("EAS EZ 1010EZ REVIEW2")
 .S VALMBCK="Q"
 I '$G(EASDFN) S VALMBCK="R"
 Q
 ;
ACCFLD ;accept a single 1010EZ data element 
 ;if data element was previously accepted, this action returns to non-accepted status
 ;input  EASAPP   = pointer to file #712 for 1010EZ
 ;       EASPSTAT = current processing status of Application;
 ;result ACCEPT = 1, if toggled to accepted
 ;                0, if toggled to non-accepted
 N J,LN,SUBIEN,KEYIEN,MULTIPLE,ACCEPT,ACTION,LINK,ONE
 Q:'EASAPP  Q:EASPSTAT=""
 Q:'EASLN
 S ACTION="'Accept Field'"
 I EASPSTAT="PRT" D NOACT^EASEZLM("Printed",ACTION) Q
 I EASPSTAT="SIG" D NOACT^EASEZLM("Signed",ACTION) Q
 I EASPSTAT="FIL" D NOACT^EASEZLM("Filed",ACTION) Q
 I EASPSTAT="CLS" D NOACT^EASEZLM("Inactivated",ACTION) Q
 ;select data item to toggle
 S VALMBCK=""
 S ONE=0
 S VALM("ENTITY")="Line Item" D SELRNGE^EASEZLM
 Q:$G(EASERR)
 Q:'$G(EASSEL("BG"))
 ;
 I EASSEL("BG")=EASSEL("LST") S ONE=1
 ;
 S J=0 F  S J=$O(EASSEL(J)) Q:'J  S EASLN=J D
 .S LN=$G(^TMP("EASEXP",$J,"IDX",EASLN))
 .Q:LN=""
 .S SUBIEN=$P(LN,U,1),MULTIPLE=$P(LN,U,2),KEYIEN=$P(LN,U,3)
 .S EZDATA=$P($G(^TMP("EZDATA",$J,KEYIEN,MULTIPLE,1)),U,1),XFILE=$P($G(^TMP("EZDATA",$J,KEYIEN)),U,1)
 .Q:EZDATA=""
 .Q:'SUBIEN
 .S ACCEPT=$P($G(^EAS(712,EASAPP,10,SUBIEN,0)),U,3)
 .;provide info to user only if exactly one line item being 'accepted'
 .I ONE D FULL^VALM1
 .;don't allow accept of data which cannot be filed
 .I ((XFILE=0)!(ACCEPT=-1)) D:ONE  Q
 ..W !!,?5,"Sorry, that data element cannot be 'Accepted' for 'Filing'."
 ..W !!,?5,"After filing this Application to VistA, use Register a Patient "
 ..W !,?5,"or Patient Enrollment to enter/update data as needed.",!
 ..K DIR D PAUSE^VALM1 S VALMBCK="R"
 .;if an 'always' accept data element, don't allow user to toggle off;
 .I ACCEPT=2 D:ONE  Q
 ..W !!,?5,"Sorry, that data element must be 'Accepted' for this Applicant."
 ..I XFILE'=355.33 D
 ...W !!,?5,"After filing this Application to VistA, the Registration options"
 ...W !,?5,"can be used to modify data as needed.",!
 ..I XFILE=355.33 D
 ...W !!,?5,"After filing this Application to VistA, Integrated Billing users"
 ...W !,?5,"can modify the data using the 'Process Insurance Buffer' option.",!
 ..K DIR D PAUSE^VALM1 S VALMBCK="R"
 .;don't allow 'updated' element to be toggled off;
 .S UPD=$P($G(^EAS(712,EASAPP,10,SUBIEN,1)),U,2) I UPD'="" D:ONE  Q
 ..W !!,?5,"Sorry, that data element has been Updated and must be 'Accepted'"
 ..W !,?5,"for this Applicant."
 ..K DIR D PAUSE^VALM1 S VALMBCK="R"
 .;toggle 'accept' indicator for line itme
 .S ACCEPT=$$ATOGGLE(EASLN,SUBIEN,ACCEPT)
 ;
 Q
 ;
ATOGGLE(EASLN,SUBIEN,ACCEPT) ;toggle 'accept' on line item
 S ACCEPT='ACCEPT
 S $P(^EAS(712,EASAPP,10,SUBIEN,0),U,3)=ACCEPT
 ;highlight data on screen
 I ACCEPT D CNTRL^VALM10(EASLN,27,25,IORVON,IORVOFF)
 I 'ACCEPT D CNTRL^VALM10(EASLN,27,25,IORVOFF,IORVOFF)
 D WRITE^VALM10(EASLN)
 S VALMBCK="R"
 Q ACCEPT
 ;
ACCALL ;accept all non-null 1010EZ data elements
 ;prevously accepted data elements are not toggled to non-accepted
 ;input  EASAPP   = pointer to file #712 for 1010EZ
 ;       EASPSTAT = current processing status of Application; 
 N EASLN,ACTION,XFILE
 Q:'EASAPP  Q:EASPSTAT=""
 S ACTION="'Accept All'"
 I EASPSTAT="PRT" D NOACT^EASEZLM("Printed",ACTION) Q
 I EASPSTAT="SIG" D NOACT^EASEZLM("Signed",ACTION) Q
 I EASPSTAT="FIL" D NOACT^EASEZLM("Filed",ACTION) Q
 I EASPSTAT="CLS" D NOACT^EASEZLM("Inactivated",ACTION) Q
 ;
 S EASLN=0 F  S EASLN=$O(^TMP("EASEXP",$J,"IDX",EASLN)) Q:'EASLN  D
 .S SUBIEN=$P(^TMP("EASEXP",$J,"IDX",EASLN),U,1),MULTIPLE=$P(^(EASLN),U,2),KEYIEN=$P(^(EASLN),U,3)
 .S XFILE=$P(^TMP("EZDATA",$J,KEYIEN),U,1)
 .Q:XFILE=0
 .S EZDATA=$P($G(^TMP("EZDATA",$J,KEYIEN,MULTIPLE,1)),U,1) I EZDATA'="" D
 ..I $P(^EAS(712,EASAPP,10,SUBIEN,0),U,3)="" S $P(^(0),U,3)=1
 ..D FLDCTRL^VALM10(EASLN,"EZDATA",IORVON,IORVOFF)
 ..Q:(EASLN<VALMBG)!(EASLN>VALMLST)
 ..D CNTRL^VALM10(EASLN,27,25,IORVON,IORVOFF)
 ..D WRITE^VALM10(EASLN)
 ;
 ;update processing status if necessary
 I EASPSTAT="NEW" D
 .D SETDATE^EASEZU2(EASAPP,"REV") S EASPSTAT="REV"
 .D BLD^EASEZLM,HDR2^EASEZL1
 S VALMBCK="R"
 Q
 ;
CLEAR ;clear all accept indicators from subfile #712.01 & LM array
 ;input EASAPP   = ien to #712 for Application
 ;      EASPSTAT = current processing status of Application; 
 N BB,EASLN,ACTION
 Q:'EASAPP  Q:EASPSTAT=""
 S ACTION="'Clear All'"
 I EASPSTAT="PRT" D NOACT^EASEZLM("Printed",ACTION) Q
 I EASPSTAT="SIG" D NOACT^EASEZLM("Signed",ACTION) Q
 I EASPSTAT="FIL" D NOACT^EASEZLM("Filed",ACTION) Q
 I EASPSTAT="CLS" D NOACT^EASEZLM("Inactivated",ACTION) Q
 ;
 ;if a new patient, don't allow user to reset all accept
 I $G(EASEZNEW) D  Q
 .D FULL^VALM1
 .W !!,?5,"Sorry, the 'Clear All' action cannot be used for this new patient."
 .W !,?5,"It is recommended that all data elements be 'Accepted' for 'Filing'."
 .W !!,?5,"After filing the Application to VistA, the Registration options"
 .W !,?5,"can be used to modify data.",!
 .D PAUSE^VALM1 S VALMBCK="R"
 ;
 ;clear accept flags and updates
 ;remove accept indicators from List Manager display array
 S EASLN=0 F  S EASLN=$O(^TMP("EASEXP",$J,"IDX",EASLN)) Q:'EASLN  D
 .S SUBIEN=$P(^TMP("EASEXP",$J,"IDX",EASLN),U,1)
 .;don't clear if updated
 .Q:'SUBIEN
 .I $P($G(^EAS(712,EASAPP,10,SUBIEN,0)),U,3)=1 D
 ..F P=3,4,5 S $P(^EAS(712,EASAPP,10,SUBIEN,0),U,P)=""
 ..S $P(^EAS(712,EASAPP,10,SUBIEN,1),U,2)=""
 ..S $P(^EAS(712,EASAPP,10,SUBIEN,2),U,1)=""
 ..D FLDCTRL^VALM10(EASLN,"EZDATA",IORVOFF,IORVOFF)
 ..Q:(EASLN<VALMBG)!(EASLN>VALMLST)
 ..D CNTRL^VALM10(EASLN,27,25,IORVOFF,IORVOFF) D WRITE^VALM10(EASLN)
 S VALMBCK=""
 Q
 ;
RESET ;reset 1010EZ Application to 'new' processing status
 ;input  EASAPP  = pointer to file #712 for 1010EZ
 ;      EASPSTAT = current processing status of Application; 
 ;this action must be follwed by an 'exit' action from the List Manager screen
 N ACTION,NEWDATE
 Q:'EASAPP  Q:EASPSTAT=""
 S ACTION="'Reset to New'"
 I EASPSTAT="SIG" D NOACT^EASEZLM("Signed",ACTION) Q
 I EASPSTAT="FIL" D NOACT^EASEZLM("Filed",ACTION) Q
 I EASPSTAT="CLS" D NOACT^EASEZLM("Inactivated",ACTION) Q
 ;
 D OKRESET
 ;update to 'New' status
 S EASPSTAT="NEW",NEWDATE=$P(^EAS(712,EASAPP,0),U,6)
 D REINDEX^EASEZU2(EASAPP,EASPSTAT,NEWDATE)
 ;rebuild selection list since this application is removed from list
 D BLD^EASEZLM
 I 'VALMCNT D NOLINES^EASEZLM
 W !,"Application has been Reset to New...",!
 D PAUSE^VALM1
 S VALMBCK="Q"
 Q
 ;
OKRESET ;perform all housekeeping to for 'reset to new' or 'inactivate'
 N BB,DA,DR,DIE,REM
 ;remove status indicator fields from file #712 record
 S DA=EASAPP,DIE="^EAS(712,"
 S DR="5.1///^S X=""@"";5.2///^S X=""@"";6.1///^S X=""@"";6.2///^S X=""@"";8.1///^S X=""@"";8.2///^S X=""@"";"
 D ^DIE
 ;
 ;delete link to file #2
 I '$G(EASDFN) S EASDFN=$P(^EAS(712,EASAPP,0),U,10)
 S $P(^EAS(712,EASAPP,0),U,10)=""
 I $G(EASDFN) K ^EAS(712,"AC",EASDFN,EASAPP)
 ;remove all links to VistA datbase
 ;delete link, delete updated data, remove accept in each subfile #712.01 record
 S BB=0 F  S BB=$O(^EAS(712,EASAPP,10,BB)) Q:'BB  D
 .F P=3,4,5 S $P(^EAS(712,EASAPP,10,BB,0),U,P)=""
 .S $P(^EAS(712,EASAPP,10,BB,1),U,2)=""
 .F P=1,2 S $P(^EAS(712,EASAPP,10,BB,2),U,P)=""
 ;
 ;clear new patient indicator since applicant must be re-matched to VistA;
 ;but if this applicant is matched again with same new stub record in VistA,
 ;  there's a comment in file #2/field #.091 to indicate the record was previously
 ;  added by 1010EZ process
 ;update 'new patient' remark
 I '$G(EASEZNEW) S EASEZNEW=$P(^EAS(712,EASAPP,0),U,11)
 S $P(^EAS(712,EASAPP,0),U,11)=""
 I EASEZNEW,EASDFN D
 .S REM="New Patient record added by ELECTRONIC 10-10EZ."
 .S DA=EASDFN,DIE="^DPT(",DR=".091///^S X=REM"
 .D ^DIE
 Q
