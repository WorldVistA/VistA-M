DGENCD1 ;ALB/CJM,Zoltan,PHH,BRM - Catastrophic Disability Protocols; 02/17/2005
 ;;5.3;Registration;**121,232,387,451,610**;Aug 13,1993
 ;
EN(DFN) ;Entry point for DGENCD CATASTROPHIC DISABILITY protocol
 D EN^DGENLCD(DFN)
 D:DFN BLD^DGENL
 Q
 ;
ADDCD ;Entry point for DGENCD ADD/EDIT CATASTROPHIC DISABILITY protocol 
 ; Input  -- DFN      Patient IEN
 ; Output -- VALMBCK  R   =Refresh screen
 N YN,EXIT,PRI,CDSITE
 S VALMBCK="",EXIT=0
 D FULL^VALM1
 I $$CDTYPE^DGENCDA(DFN) D  ;was determination by physical exam?
 .S CDSITE=$$CHKSITE^DGENCDA(DFN)
 .I CDSITE D  ;CD was determined by this site
 ..D BMES^XPDUTL("This veteran is currently determined to be Catastrophically")
 ..D MES^XPDUTL("Disabled.  You may not change this evaluation unless it is due")
 ..D MES^XPDUTL("to an error in data entry.")
 ..S YN=$$YN("Is this edit due to an error in data entry")
 ..D:"N^"[$E($G(YN))
 ...D BMES^XPDUTL("Additional CD evaluations are not necessary for this")
 ...D MES^XPDUTL("Veteran, as they are currently determined to be CD.  If")
 ...D MES^XPDUTL("this is an edit due to an error, please return to the")
 ...D MES^XPDUTL("Add/Edit action and answer YES to this prompt.")
 ...S EXIT=1
 .E  D  ;  CD was determined by another site
 ..S SITEINF=$$NS^XUAF4($P(CDSITE,"^",2))
 ..D BMES^XPDUTL("This Catastrophic Disability evaluation was entered at Site:"_$P(SITEINF,"^",2))
 ..D MES^XPDUTL("Please Contact Site "_$P(SITEINF,"^"))
 ..D MES^XPDUTL("if it is necessary to edit this evaluation.")
 ..S EXIT=1
 ..S DIR(0)="EA",DIR("A")="Press return to continue..." D ^DIR
 I EXIT S VALMBCK="R" Q
 ;
 S PRI=$$PRIORITY^DGENA(DFN)
 I PRI,PRI'>4 D
 . W:$X !
 . W !,"According to the veteran's current enrollment record, the",!
 . W "assignment of a Catastrophically Disabled Status will not",!
 . W "improve his/her enrollment priority.",!!
 . S YN=$$YN("Do you still want to perform a review")
 . I "N^"[$E($G(YN)) S EXIT=1
 I 'EXIT D EDITCD^DGENCD(DFN),INIT^DGENLCD
 S VALMBCK="R"
 Q
 ;
DELETECD ;Entry point for DGENCD DELETE CATASTROPHIC DISABILITY protocol 
 ; Input  -- DFN      Patient IEN
 ; Output -- VALMBCK  R   =Refresh screen
 S VALMBCK=""
 D FULL^VALM1
 I $$GET^DGENCDA(DFN,.DGCD),'$D(DGCD("DIAG")) D
 .W !!,">>>No Catastrophic Disabilities exist for this veteran.<<<"
 .S DIR(0)="EA",DIR("A")="Press return to continue..." D ^DIR
 E  D
 .I $$RUSURE(DFN) D
 ..I $$DELETE^DGENCDA1(DFN)
 D INIT^DGENLCD
 S VALMBCK="R"
 Q
 ;
RUSURE(DFN) ;
 ;Description: Asks user 'Are you sure?'
 ;Input: DFN is the patient ien
 ;Output: Function Value returns 0 or 1
 ;
 N DIR,SITE,SITEINF,DIROUT,DIRUT,DTOUT,DUOUT,NOERR
 S SITE=$$CHKSITE^DGENCDA(DFN)
 I '$P(SITE,"^") D  Q 0   ;CD was not determined at this site
 .S SITEINF=$$NS^XUAF4($P(SITE,"^",2))
 .D BMES^XPDUTL("This Catastrophic Disability evaluation was entered at Site:"_$P(SITEINF,"^",2))
 .D MES^XPDUTL("Please Contact Site "_$P(SITEINF,"^"))
 .D MES^XPDUTL("if it is necessary to delete this evaluation.")
 ; was this entered in error?
 I $$CDTYPE^DGENCDA(DFN) D  Q:$G(NOERR) 0
 .D BMES^XPDUTL("This Veteran is currently determined to be Catastrophically Disabled, you")
 .D MES^XPDUTL("may not delete this evaluation unless it is due to an error in data entry.")
 .S DIR(0)="Y",DIR("B")="NO"
 .S DIR("A")="Is this deletion due to an error in data entry"
 .D ^DIR
 .I $G(DIRUT)!$G(DUOUT)!$G(DIROUT)!$G(DTOUT)!('$G(Y)) S NOERR=1
 .K DIR,Y
 ;
 S DIR(0)="Y"
 S DIR("A")="Are you sure that the Catastrophic Disability should be deleted"
 S DIR("B")="NO"
 I $$HASCAT^DGENCDA(DFN) D
 . W !!,">>> Deleting the Catastrophic Disability information will also delete all <<<",!
 . W ">>>  supporting fields, including Diagnoses, Procedures and Conditions.   <<<",!
 D ^DIR
 Q:$D(DIRUT) 0
 Q Y
 ;
YN(PROMPT,DFLT) ; Ask user a yes/no question.
 S DFLT=$E($G(DFLT,"N"))
 N YN,%,%Y
 F  D  Q:"YN^"[YN
 . W PROMPT
 . S %=$S(DFLT="N":2,DFLT="Y":1,1:0)
 . D YN^DICN
 . W !
 . S YN=$S(%=-1:"^",%=1:"Y",%=2:"N",1:"?")
 . I YN["?" W ?5,"You can just enter 'Y' or 'N'.",!!
 Q YN
