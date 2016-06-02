IBY528PA ;ALB/SS - Pre and post install routine for patch 528 ;12-OCT-15
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;====== preinstall code
PREINST ; 
 N IBLSTIEN,IBRET,IBASK
 ;
 S IBASK=0
 ;Check the file #355.1 --------
 D BMES^XPDUTL("** Checking entries in the file #355.1 **")
 S IBLSTIEN=$O(^IBE(355.1,99999999),-1)
 ; if file contains unauthorized changes  ( the last IEN is not equal to 77 )
 ; AND this patch was NOT installed previously
 ; then warn the user and give the options to abort installation and fix the issue
 I IBLSTIEN'=77,$$PATCH^XPDUTL("IB*2.0*528")=0 D MESS1 S IBASK=1
 ; if entries are introduced by this patch were added manually previously in wrong IEN number range 
 S IBRET=$$CHCKEXWR() I +IBRET=1 D MESS2($P(IBRET,U,2)) S IBASK=1
 I IBASK=0 D MES^XPDUTL("..OK")
 ;
 ;Check the file #355.12 --------
 D BMES^XPDUTL("** Checking entries in the file #355.12 **")
 S IBLSTIEN=$O(^IBE(355.12,99999999),-1)
 ; if file contains unauthorized changes  ( the last IEN is not equal to 11 )
 ; AND this patch was NOT installed previously
 ; then warn the user and give the options to abort installation and fix the issue
 I IBLSTIEN'=11,$$PATCH^XPDUTL("IB*2.0*528")=0 D:IBLSTIEN>11 MESS4 D:IBLSTIEN<11 MESS5 S IBASK=1
 I IBASK=0 D MES^XPDUTL("..OK")
 ;
 ; if any issues were detected the ask the user 
 I IBASK=1 D MESS3 I $$YESNO("Do you want to abort installation now","YES")'=0 W !,"Aborting installation!" S XPDABORT=1 Q
 Q
 ;
 ;====== post-install code 
ADSRCINF ; to add new source of information to to #355.12
 D BMES^XPDUTL("** Adding a new entry to the file #355.12 **")
 ; if the patch was installed previously - skip adding new entries
 I $$PATCH^XPDUTL("IB*2.0*528") D MES^XPDUTL("Skipping adding new entries to the file #355.12 since the patch was installed previously.") Q
 ; get the last IEN in the file
 S IBNEWIEN=$O(^IBE(355.12,99999999),-1)
 ; if less than 11 (Baltimore) then set the last IEN to what majority of sites have (11)
 I IBNEWIEN<11 S IBNEWIEN=11
 ; if 11 or greater than 11 (Hines) then add new entries after the last entry
 S IBNEWIEN=IBNEWIEN+1
 ;
 D ADD35512(IBNEWIEN)
 Q
 ;
ADTYPPLN ; to add type of plans to #355.1
 D BMES^XPDUTL("** Adding new entries to the file #355.1 **")
 ; if the patch was installed previously - skip adding new entries
 I $$PATCH^XPDUTL("IB*2.0*528") D MES^XPDUTL("Skipping adding new entries to the file #355.1 since the patch was installed previously.") Q
 ; get the last IEN in the file
 S IBNEWIEN=$O(^IBE(355.1,99999999),-1)
 ; if less than 77 (Durham ) then set the last IEN to what majority of sites have (77)
 I IBNEWIEN<77 S IBNEWIEN=77
 ; if 77 or greater than 77 (Hines) then add new entries after the last entry
 S IBNEWIEN=IBNEWIEN+1
 ;
 ; add top level entries
 D ADD3551(IBNEWIEN)
 ; add descriptions to new entries
 D MES^XPDUTL("** Adding descriptions to the file #355.1 **")
 D ADD35511()
 Q
 ;
 ;check if new entries are alraedy in #355.1 and they are below IEN=77
CHCKEXWR() ;
 N IBZ,IBSTR,IBRET,IBFLD,IBWRNG,IBIEN,IBRET
 S IBWRNG=0
 S IBRET="IEN="
 F IBZ=1:1 S IBSTR=$P($T(DAT3551+IBZ),";;",2,10) Q:IBSTR=""  D
 . S IBFLD(.01)=$P(IBSTR,U,1)
 . S IBIEN=$O(^IBE(355.1,"B",IBFLD(.01),"")) I IBIEN>0,IBIEN<78 S IBWRNG=1,IBRET=IBRET_IBIEN_","
 Q IBWRNG_U_IBRET
 ;
 ;Add new types of plan to #355.1
 ;IBSTRIEN to use for the first new entry
ADD3551(IBSTRIEN) ;
 N IBZ,IBSTR,IBRET,IBFLD,IBNEWIEN
 N IB1STDON S IB1STDON=0
 ;
 ; -- get the set of codes for the type of plans
 ; -- put the plan types into array, set it to it's code value
 ; -- example:  IBC("DENTAL")=2
 N I,IBA,IBB,IBC
 S IBA=$P(^DD(355.1,.03,0),U,3),IBB=$L(IBA,";")
 F I=1:1:IBB-1 S IBC($P($P(IBA,";",I),":",2))=$P($P(IBA,";",I),":")
 ;
 ;
 F IBZ=1:1 S IBSTR=$P($T(DAT3551+IBZ),";;",2,10) Q:IBSTR=""  D
 . S IBFLD(.01)=$P(IBSTR,U,1)
 . I $O(^IBE(355.1,"B",IBFLD(.01),"")) D MES^XPDUTL(" Entry "_IBFLD(.01)_" already exists - skipping.") Q
 . S IBNEWIEN=$S(IB1STDON=0:IBSTRIEN,1:"") ;for the first new entry use IBSTRIEN, for others - let the system decide
 . S IBFLD(.02)=$P(IBSTR,U,2)
 . S IBFLD(.03)=IBC($P(IBSTR,U,3)) ; set of codes for plan type
 . S IBRET=$$INSREC(355.1,"",.IBFLD,IBNEWIEN,,,,1)
 . I IBRET<0 D MES^XPDUTL(" Error: the entry "_IBFLD(.01)_" hasn't been added.") Q
 . D MES^XPDUTL(" "_IBFLD(.01)_" added.")
 . S IB1STDON=1
 Q
 ;
 ;Add descriptions
ADD35511() ;
 N IBZ,IBSTR,IB01,IB10IEN,IBARR,IBTOPIEN,IBFLD,IBSKIPST
 S IBSKIPST=0
 F IBZ=1:1 S IBSTR=$P($T(DAT35511+IBZ),";;",2,10) Q:IBSTR=""  D
 . I $P(IBSTR,U,1)="START" D  Q
 . . S IBSKIPST=0
 . . K IBARR
 . . S IB01=$P(IBSTR,U,2)
 . . S IBTOPIEN=$O(^IBE(355.1,"B",IB01,"")) I +IBTOPIEN=0 S IBSKIPST=1 D MES^XPDUTL("Entry "_IB01_" doesn't exist - skipping adding description.") Q
 . . I $O(^IBE(355.1,IBTOPIEN,10,0)) S IBSKIPST=1 D MES^XPDUTL("Description for "_IB01_" already exists - skipping.")
 . I IBSKIPST=1 Q  ;skip the whole section if the top level entry doesn't exist or description is already there
 . I $P(IBSTR,U,1)="END" D  Q
 . . K IBERR
 . . D WP^DIE(355.1,IBTOPIEN_",",10,"KA","IBARR","IBERR")
 . . I $D(IBERR("DIERR")) D MES^XPDUTL("Error: the description for "_IB01_" hasn't been created.")
 . . D MES^XPDUTL(" Description for "_IB01_" added.")
 . S IBARR(+$P(IBSTR,U,1),0)=$P(IBSTR,U,2)
 ;
 Q
 ;
 ;Add new entires to #355.12
 ;IBSTRIEN to use for the first new entry
ADD35512(IBSTRIEN) ;
 N IBZ,IBSTR,IBRET,IBFLD,IBNEWIEN
 N IB1STDON S IB1STDON=0
 F IBZ=1:1 S IBSTR=$P($T(DAT35512+IBZ),";;",2,10) Q:IBSTR=""  D
 . S IBFLD(.01)=$P(IBSTR,U,1)
 . S IBFLD(.02)=$P(IBSTR,U,2)
 . I $O(^IBE(355.12,"C",IBFLD(.02),"")) D MES^XPDUTL(" Entry "_IBFLD(.02)_" already exists - skipping.") Q
 . S IBNEWIEN=$S(IB1STDON=0:IBSTRIEN,1:"") ;for the first new entry use IBSTRIEN, for others - let the system decide
 . S IBFLD(.03)=$P(IBSTR,U,3)
 . S IBRET=$$INSREC(355.12,"",.IBFLD,IBNEWIEN,,,,1)
 . I IBRET<0 D MES^XPDUTL(" Error: the entry "_IBFLD(.01)_" hasn't been added.") Q
 . D MES^XPDUTL(" "_IBFLD(.01)_" "_IBFLD(.02)_" added.")
 . S IB1STDON=1
 Q
 ;
 ;
MESS1 ;
 D BMES^XPDUTL("Local entries and/or missing standard entries were detected in the file #355.1")
 D MES^XPDUTL("Local modifications are not allowed for this file. If you continue installation")
 D MES^XPDUTL("then new entries that this patch is introducing will be added after the last")
 D MES^XPDUTL("existing entry in the file #355.1 but not lower that IEN=78.")
 Q
 ;
MESS2(IBIENLST) ;
 D BMES^XPDUTL("At least one of new entries that this patch is introducing was detected within")
 D MES^XPDUTL("the incorrect internal entry numbers range in the file #355.1. (below IEN=78):")
 D MES^XPDUTL(" "_IBIENLST)
 Q
 ;
MESS3 ;
 D BMES^XPDUTL("You might want to consider to resolve the issue first and install this patch")
 D MES^XPDUTL("after that.")
 Q
 ;
MESS4 ;
 D BMES^XPDUTL("Local entries were detected in the file #355.12")
 D MES^XPDUTL("Local modifications are not allowed for this file. If you continue installation")
 D MES^XPDUTL("then new entry that this patch is introducing will be added after the last")
 D MES^XPDUTL("existing entry in the file #355.12 and IEN for the new source of information")
 D MES^XPDUTL("will be different than the standard IEN=12 that will be used by all VA sites.")
 Q
MESS5 ;
 D BMES^XPDUTL("One or more standard entries are missing in the file #355.12 .")
 D MES^XPDUTL("Local modifications are not allowed for this file. If you continue installation")
 D MES^XPDUTL("then new entries that this patch is introducing will be added at the posistion")
 D MES^XPDUTL("IEN=12, which will be used by all VA sites.")
 Q
 ; Ask
 ; Input:  ;  IBQSTR - question  ;  IBDFL - default answer
 ; Output:  ; 1 YES ; 0 NO ; -1 if cancelled
YESNO(IBQSTR,IBDFL) ; Default - YES
 N DIR,Y,DUOUT
 S DIR(0)="Y"
 S DIR("A")=IBQSTR
 S:$L($G(IBDFL)) DIR("B")=IBDFL
 D ^DIR
 Q $S($G(DUOUT)!$G(DUOUT)!(Y="^"):-1,1:Y)
 ;
 ;/**
 ;Creates a new entry (or node for multiple with .01 field)
 ;IBFILE - file/subfile number
 ;IBEIEN - ien of the parent file entry in which the new subfile entry will be inserted
 ;IBZFDA - array with values for the fields
 ; format for IBZFDA:
 ; IBZFDA(.01)=value for #.01 field
 ; IBZFDA(3)=value for #3 field
 ;IBRECNO -(optional) specify IEN if you want specific value
 ; Note: "" then the system will assign the entry number itself.
 ;IBFLGS - FLAGS parameter for UPDATE^DIE
 ;IBLCKGL - fully specified global reference to lock
 ;IBLCKTM - time out for LOCK, if LOCKTIME=0 then the function will not lock the file 
 ;IBNEWRE - optional, flag = if 1 then allow to create a new top level record 
 ;  
 ;output :
 ; positive number - record # created
 ; <=0 - failure
 ;
 ;example:
 ; S ZZ(.01)="ZZSS TEST",ZZ(.06)=1,ZZ(.09)=0 W $$INSREC^IBDUTIL1(357.6,"",.ZZ,"")
INSREC(IBFILE,IBEIEN,IBZFDA,IBRECNO,IBFLGS,IBLCKGL,IBLCKTM,IBNEWRE) ;*/
 I ('$G(IBFILE)) Q "0^Invalid parameter"
 I +$G(IBNEWRE)=0 I $G(IBRECNO)>0,'$G(IBEIEN) Q "0^Invalid parameter"
 N IBDSSI,IBIENS,IBDERR,IBDFDA
 N IBDLOCK S IBDLOCK=0
 I '$G(IBRECNO) N IBRECNO S IBRECNO=$G(IBRECNO)
 I IBEIEN'="" S IBIENS="+1,"_IBEIEN_"," I $L(IBRECNO)>0 S IBDSSI(1)=+IBRECNO
 I IBEIEN="" S IBIENS="+1," I $L(IBRECNO)>0 S IBDSSI(1)=+IBRECNO
 M IBDFDA(IBFILE,IBIENS)=IBZFDA
 I $L($G(IBLCKGL)) L +@IBLCKGL:(+$G(IBLCKTM)) S IBDLOCK=$T I 'IBDLOCK Q -2  ;lock failure
 D UPDATE^DIE($G(IBFLGS),"IBDFDA","IBDSSI","IBDERR")
 I IBDLOCK L -@IBLCKGL
 I $D(IBDERR) Q -1
 Q +$G(IBDSSI(1))
 ;
 ;
 ; (#.01) NAME^,(#.02) ABBREVIATION^ (#.03) MAJOR CATEGORY
DAT3551 ;entries to add to #355.1 (top level)
 ;;HIGH DEDUCTIBLE HEALTH PLAN^HDHP^MAJOR MEDICAL
 ;;HIGH DEDUCTIBLE HEALTH PLAN W/HEALTH SAVINGS ACCOUNT^HDHP w/HSA^MAJOR MEDICAL
 ;;HIGH DEDUCTIBLE HEALTH PLAN W/HEALTH REIMBURSEMENT ARRANGEMENT^HDHP w/HRA^MAJOR MEDICAL
 ;;HEALTH MAINTENANCE ORGANIZATION W/OUT OF NETWORK BENEFITS^HMO w/OON^MAJOR MEDICAL
 ;;EXCLUSIVE PROVIDER ORGANIZATION^EPO^MAJOR MEDICAL
 ;;MEDICARE ADVANTAGE^MR ADV^MEDICARE
 ;;VISION^VIS^ALL OTHER
 ;;
 ;
 ;(#10) DESCRIPTION to add to #355.1
DAT35511 ;
 ;;START^HIGH DEDUCTIBLE HEALTH PLAN
 ;;1^HIGH DEDUCTIBLE HEALTH PLAN
 ;;END
 ;;START^HIGH DEDUCTIBLE HEALTH PLAN W/HEALTH SAVINGS ACCOUNT
 ;;1^HIGH DEDUCTIBLE HEALTH PLAN W/HEALTH SAVINGS ACCOUNT
 ;;END
 ;;START^HIGH DEDUCTIBLE HEALTH PLAN W/HEALTH REIMBURSEMENT ARRANGEMENT
 ;;1^HIGH DEDUCTIBLE HEALTH PLAN W/HEALTH REIMBURSEMENT ARRANGEMENT
 ;;END
 ;;START^HEALTH MAINTENANCE ORGANIZATION W/OUT OF NETWORK BENEFITS
 ;;1^HEALTH MAINTENANCE ORGANIZATION W/OUT OF NETWORK BENEFITS
 ;;END
 ;;START^EXCLUSIVE PROVIDER ORGANIZATION
 ;;1^EXCLUSIVE PROVIDER ORGANIZATION
 ;;END
 ;;START^MEDICARE ADVANTAGE
 ;;1^MEDICARE ADVANTAGE
 ;;END
 ;;START^VISION
 ;;1^VISION
 ;;END
 ;;
 ;
 ; (#.01) CODE^(#.02) DESCRIPTION ^(#.03) IB BUFFER ACRONYM
DAT35512 ;entries to add to #355.12 (top level)
 ;;12^INTERFACILITY INS UPDATE^IIU
 ;;
 ;
 ;
 ;IBY528PA
