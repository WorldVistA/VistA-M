IB20P436 ;ALB/PIJ - POST-INIT FOR IB*2.0*436; 11/25/2008 ; 7/21/2010
 ;;2.0;INTEGRATED BILLING;**436**;21-MAR-94;Build 31
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; DESCRIPTION: This routine is used to sychronize the names in the
 ;              file 355.93 with those in file #200 when both files
 ;              have the same NPI number. It also updates the 
 ;              TYPE OF PLAN file (#355.1).
 ; 
 ; INPUTS     : None
 ; 
 ; OUTPUTS    : 1) Outputs a report showing the results of the names
 ;              found in each file for a corresponding NPI.
 ;              2) Creates a new plan.
 ; 
 ; VARIABLES  : 
 ;              NPIIEN3  - The NPI number found in file 355.93
 ;              IEN2     - The IEN of the record corresponding
 ;                         to NPIIEN2 in file 200
 ;              IEN3     - The IEN of the record corresponding to
 ;                         NPIIEN3 in file 355.93       
 ;              NM200    - The user name as found in file 200
 ;              NM35593  - The user name as found in file #355.93
 ;              NMNEW    - The new updated name in #355.93 after the
 ;                         name field from #200 gets filed into #355.93
 ;              NPI      - The NPI of a user.
 ;              DIE,DA,
 ;              DR,DIC  - Standard FILEMAN variables used for DIC 
 ;                        and DIE calls
 ; 
 ; GLOBALS      : ^VA(200      - The VistA NEW PERSON file.
 ;                ^IBA(355.93  - The VistA IB NON/OTHER VA BILLING
 ;                               PROVIDER file
 ;                       
 ; 
 ; FUNCTIONS    : None
 ; 
 ; SUBROUTINES  : None
 ; 
 ; 
 ; HISTORY    : Original version - 18 May 2010
 ; 
 ;
 ;
 ; Save off the file 335.93 names (field # .01) for entries with NPIs
 ; This only needs to be done once.
 ;
 ; Loop through file #200 looking for NPI entries
 ;
 ; 
EN N NPIIEN3,IEN2,IEN3,DIC,NPNPRV,NAM,NPI,DIE,DA,DR,NPILIST3
 N DT,I,NM200,NM35593,NMNEW,X,Y,XNAM,XUSRSLT,XMER,%,DIFROM
 N IBFLPFLP
 ;
 S U="^"
 S IBFLPFLP=0
 S NMNEW=0
 ;
 ; The global ^XTMP will be translated, with one copy for the entire
 ; VistA production system at each site.  The structure of each top node
 ; shall follow the format:
 ;  ^XTMP(namespaced-subscript,$J,0)=purge date^create date^optional descriptive information
 ;  note: both dates will be in VA FileMan internal date format.
 ;  ^XTMP("IB_CLEAN-UP_RPT_355.93/200",$J,NPIIEN3)=IEN2_U_NM200_U_IEN3_U_NM35593_U_NMNEW
 ;  note: see VARIABLES section above for descriptions.
 ;
 S DT=$$DT^XLFDT
 K ^XTMP("IB_CLEAN-UP_RPT_355.93/200",$J)
 S ^XTMP("IB_CLEAN-UP_RPT_355.93/200",$J,0)=$$FMADD^XLFDT(DT,100)_U_DT_U_"IB_CLEAN-UP_RPT_355.93/200"
 ;
 S (NPIIEN3,IEN2,IEN3)=0
 F  S NPIIEN3=$O(^IBA(355.93,"NPI42",NPIIEN3)) Q:'NPIIEN3  D
 . S IEN3=$O(^IBA(355.93,"NPI42",NPIIEN3,""))
 . S IEN2=$$QI^XUSNPI(NPIIEN3)
 . F I=1:1:$L(IEN2,";") Q:($P($P(IEN2,";",I),U)="Individual_ID")
 . S IEN2=$P($P(IEN2,";",I),U,2)
 . ;
 . ; If we do not find a file 200 entry then get next entry
 . ; 
 . Q:'IEN2
 . S DIC=200
 . S DIC(0)="MOX"
 . S X=NPIIEN3
 . D ^DIC
 . Q:+Y'>0
 . S NM200=$P(Y,U,2)
 . S (X,Y)=""
 . S DIC=355.93
 . S DIC(0)="MOX"
 . S X=NPIIEN3
 . D ^DIC
 . Q:+Y'>0
 . S NM35593=$P(Y,U,2)
 . S (X,Y)=""
 . ;
 . ; Add the NPI and IENs to the 355.93 list
 . ;
 . L +^IBA(355.93,IEN3,0):10 Q:'$T
 . S DIE="^IBA(355.93,"
 . S DA=IEN3
 . S DR=".01////"_NM200
 . D ^DIE
 . L -^IBA(355.93,IEN3,0)
 . ;
 . S DIC=355.93
 . S DIC(0)="MOX"
 . S X=NPIIEN3
 . D ^DIC
 . Q:+Y'>0
 . S NMNEW=$P(Y,U,2)
 . S NPILIST3(NPIIEN3)=IEN2_U_NM200_U_IEN3_U_NM35593_U_NMNEW
 . S ^XTMP("IB_CLEAN-UP_RPT_355.93/200",$J,NPIIEN3)=IEN2_U_NM200_U_IEN3_U_NM35593_U_NMNEW
 D TOPENTRY
 D RIT
 D RPT
 D GET
 Q
 ;
RPT ;
 N X,Y,I,SP200,SP355OR,SPNPI,NPI
 S (IEN2,IEN3,NM200,NM35593,NMNEW,NPI,X,Y)=""
 D HDR2
 D HDR3
 F  S X=$O(NPILIST3(X)) Q:'X  D
 . S Y=NPILIST3(X)
 . S NPI=X
 . S IEN2=$P(Y,U,1)
 . S NM200=$P(Y,U,2)
 . S IEN3=$P(Y,U,3)
 . S NM35593=$P(Y,U,4)
 . S NMNEW=$P(Y,U,5)
 . ; 
 . ;
 . ; spaces for name #200
 . S SP200=$J("",(20-$L(NM200)))
 . ; spaces for name #355.93 original number
 . S SP355OR=$J("",(25-$L(NM35593)))
 . S SPNPI=$J("",(13-$L(NPI)))
 . S I=I+1
 . S NMNEW=$S(NM200=NM35593:"NO CHANGE",1:NMNEW)
 . S XUSRSLT(I)=NPI_SPNPI_NM200_SP200_NM35593_SP355OR_NMNEW
 S I=I+1
 S XUSRSLT(I)=" "
 S I=I+1
 S XUSRSLT(I)="                              **End of Report**"
 Q
 ;
HDR2 ;
 S I=1
 S XUSRSLT(I)="This report is to inform users of modifications that were made as"
 S XUSRSLT(I+1)="part of the post-install process of patch IB*2.0*436.  Due to "
 S XUSRSLT(I+2)="previous restrictions in VistA, practitioners could not exist in"
 S XUSRSLT(I+3)="the VA provider (New Person) and non-VA provider (IB/Non-VA/Other"
 S XUSRSLT(I+4)="Billing Provider) files with identical names and NPIs.  With the"
 S XUSRSLT(I+5)="release of patch IB*2.0*436 this restriction has been lifted."
 S XUSRSLT(I+6)=" "
 S XUSRSLT(I+7)="As part of the installation of this patch an automated process compared"
 S XUSRSLT(I+8)="the Provider Name values in these two files using the NPI as the"
 S XUSRSLT(I+9)="common field.  When differences were identified, the provider name"
 S XUSRSLT(I+10)="in the New Person File was copied to the provider name field of the"
 S XUSRSLT(I+11)="IB/Non-VA Other Billing Provider File."
 S XUSRSLT(I+12)=" "
 S XUSRSLT(I+13)="THIS REPORT IDENTIFIES THE CHANGES THAT WERE MADE TO YOUR SYSTEM."
 S XUSRSLT(I+14)=" "
 S XUSRSLT(I+15)="If you have been designated as the person at your facility responsible"
 S XUSRSLT(I+16)="for evaluating these changes, you should confirm that the updated"
 S XUSRSLT(I+17)="names in the non-VA provider file are correct."
 S XUSRSLT(I+18)=" "
 S XUSRSLT(I+19)=" "
 S I=I+19
 ;
 Q
 ;
HDR3 ;
 S I=I+1
 S XUSRSLT(I)="                              **Clean-up Report**"
 S I=I+1
 S XUSRSLT(I)=""
 S I=I+1
 S XUSRSLT(I)="NPI#         Name-#200           Name-#355.93             Updated Name-#355.93"
 S I=I+1
 S XUSRSLT(I)="#355.93      NEW PERSON          IB Non-VA Provider       IB Non-VA Provider"
 S I=I+1
 S XUSRSLT(I)="-------------------------------------------------------------------------------"
 Q
 ;
GET ; Get names of persons to notify
 N IEN200,XMY,XMTEXT,XMSUB,XMMG,I,X,ANSWER
 N IBKEY,IBIEN,XMDUZ,DIFROM
 ;
 S XMDUZ=DUZ,IBKEY="IB PROVIDER EDIT"
 S IBIEN="" F  S IBIEN=$O(^XUSEC(IBKEY,IBIEN)) Q:'IBIEN  S XMY(IBIEN)=""
 S XMY(.05)="" ; Include Postmaster at CBO's request.  
 ;
 S XMSUB="**CLEAN-UP REPORT** - #200 to #355.93"
 S XMTEXT="XUSRSLT("
 D ^XMD
 S:($D(XMMG)!$D(XMER))&('$D(^XTMP("IB436_POST",$J))) ^XTMP("IB436_POST",$J,0)=$$NOW^XLFDT()+10_"^"_$$NOW^XLFDT()_"^Post install IB436 errors"
 S:$D(XMMG) ^XTMP("IB436_POST",$J,"XMMG",XMDUZ)=XMMG
 S:$D(XMER) ^XTMP("IB436_POST",$J,"XMER",XMDUZ)=XMER
 Q
 ;
TOPENTRY ; Adds a new record to TYPE OF PLAN file (#355.1)
 ;FIELD     FIELD
 ;NUMBER    NAME
 ;------    -----
 ;
 ;.01       NAME (RF), [0;1]
 ;.02       ABBREVIATION (F), [0;2]
 ;.03       MAJOR CATEGORY (S), [0;3]
 ;.04       INACTIVE (S), [0;4]
 ;10        DESCRIPTION (Multiple-355.11), [10;0]
 ;           .01  DESCRIPTION (W), [0;1]
 ;
 ; Define data for new entry
 ;
 N NAME,ABRV,MAJCAT,INACT,DESC,IENS,FLAGS,FILE,FDA,FIELD,IEN
 ;
 S NAME="MEDIGAP (SUPPL - COINS, DED, PART B EXC)"
 S ABRV="MG+"
 S MAJCAT="MEDICARE SUPPLEMENTAL"
 S INACT=""
 S DESC(1)="This is a Standard MediGap plan purchased individually"
 S DESC(2)="as a supplemental policy and is designed to cover Medicare"
 S DESC(3)="deductibles and coinsurance amounts plus Part B excess charges."
 S DESC(4)="These policies are not available to any individuals not covered"
 S DESC(5)="by Medicare and would usually be purchased directly by the"
 S DESC(6)="individual and not thru an employer.  Benefits not covered"
 S DESC(7)="by Medicare are not covered by a supplemental.  Select this"
 S DESC(8)="plan type if plan covers Medicare Part B excess charges such"
 S DESC(9)="as Plan F or Plan G."
 ;
 S FLAGS="EK"
 S FDA(10,355.1,"?+1,",.01)=NAME
 S FDA(10,355.1,"?+1,",.02)=ABRV
 S FDA(10,355.1,"?+1,",.03)=MAJCAT
 S FDA(10,355.1,"?+1,",.04)=INACT
 ;
 ; Create the new entry
 ;
 D UPDATE^DIE(FLAGS,"FDA(10)","IEN","ERR1")
 ;
 S FILE=355.1
 S IENS=IEN(1)_","
 S FIELD=10
 S FLAGS="K"
 ;
 D WP^DIE(FILE,IENS,FIELD,FLAGS,"DESC","ERR2")
 Q
 ;
RIT ; Recompile input templates for billing screens
 NEW X,Y,DMAX
 S X="IBXS8P",Y=$$FIND1^DIC(.402,,"X","IB SCREEN8H","B"),DMAX=15000
 I Y D EN^DIEZ
 S X="IBXS8I",Y=$$FIND1^DIC(.402,,"X","IB SCREEN82","B"),DMAX=15000
 I Y D EN^DIEZ
RITX  ;
 Q
