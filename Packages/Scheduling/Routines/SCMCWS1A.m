SCMCWS1A ;ALB/ART - PCMMR-Call Patient Summary Web Service ;01/15/2015
 ;;5.3;Scheduling;**603**;Aug 13, 1993;Build 79
 ;
 QUIT
 ;
PARSEXML(SCNODE,SCVALUE,SCTEAMS,SCNVA,SCTMLVL,SCPCLVL,SCNVALVL,SCMHLVL,SCOELVL,SCSPLVL,SCSPTYPE,SCSPMBR,SCBLOCK,SCEOF) ;Build an array from XML data
 ;Inputs: SCNODE   - XML node spec
 ;        SCVALUE  - XML node value
 ;        SCTEAMS  - Teams array populated from XML data - by reference
 ;        SCNVA    - nonVA array populated from XML data - by reference
 ;        SCTMLVL  - array station count - by reference
 ;        SCPCLVL  - array PACT count - by reference
 ;        SCNVALVL - array nonVA count - by reference
 ;        SCMHLVL  - array MH count - by reference
 ;        SCOELVL  - array OEF count - by reference
 ;        SCSPLVL  - array SP count - by reference
 ;        SCSPTYPE - array SP team type - by reference
 ;        SCSPMBR  - array SP team member count - by reference
 ;        SCBLOCK  - gets set to 1 if preformatted data is received - by reference
 ;        SCEOF    - gets set to 1 if preformatted data is received - by reference
 ;
 ; Patient Data Block
 IF SCNODE="/PatientSummary/PatientSummaryText" DO  QUIT
 . IF SCVALUE="<![CDATA[]]" QUIT
 . IF SCVALUE=">" QUIT
 . IF SCVALUE["<![CDATA[" DO
 . . SET SCVALUE=$PIECE(SCVALUE,"<![CDATA[",2)
 . . SET SCVALUE=$TR(SCVALUE,"]","")
 . NEW SCI
 . FOR SCI=1:1:$LENGTH(SCVALUE,$CHAR(10)) DO
 . . SET SCTEAMS(SCI)=$PIECE(SCVALUE,$CHAR(10),SCI)
 . SET SCEOF=1
 . SET SCBLOCK=1
 . ;
 ; Station name
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/StationNameAndNumber" DO  QUIT
 . SET SCTMLVL=SCTMLVL+1
 . SET SCMHLVL=0
 . SET SCTEAMS(SCTMLVL,"STATION")=$TR(SCVALUE,"#","")
 . ;
 ; PC Status
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/assignmentStatus" DO  QUIT
 . SET SCPCLVL=SCPCLVL+1
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"STATUS")=SCVALUE
 . ;
 ; PACT Name
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/teamName" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"PACT")=SCVALUE
 . ;
 ; PC Admin POC Role
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/administrativePoc/teamRoleName" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"APOC ROLE")=SCVALUE
 . ;
 ; PC Admin POC Name
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/administrativePoc/name" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"APOC NAME")=SCVALUE
 . ;
 ; PC Admin POC Phone
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/administrativePoc/phone" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"APOC PHONE")=SCVALUE
 . ;
 ; PC Admin POC Pager
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/administrativePoc/pager" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"APOC PAGER")=SCVALUE
 . ;
 ; PC Clinical POC Role
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/clinicalPoc/teamRoleName" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"CPOC ROLE")=SCVALUE
 . ;
 ; PC Clinical POC Name
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/clinicalPoc/name" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"CPOC NAME")=SCVALUE
 . ;
 ; PC Clinical POC Phone
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/clinicalPoc/phone" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"CPOC PHONE")=SCVALUE
 . ;
 ; PC Clinical POC Pager
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/clinicalPoc/pager" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"CPOC PAGER")=SCVALUE
 . ;
 ; PCP Name
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/primaryCareProvider/name" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"PCP NAME")=SCVALUE
 . ;
 ; PCP Phone
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/primaryCareProvider/phone" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"PCP PHONE")=SCVALUE
 . ;
 ; PCP Pager
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/primaryCareProvider/pager" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"PCP PAGER")=SCVALUE
 . ;
 ; PC Assoc Provider Name
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/associateProvider/name" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"ASSOC NAME")=SCVALUE
 . ;
 ; PC Assoc Provider Phone
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/associateProvider/phone" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"ASSOC PHONE")=SCVALUE
 . ;
 ; PC Assoc Provider Pager
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/PrimaryCareAssignments/PrimaryCareAssignment/associateProvider/pager" DO  QUIT
 . SET SCTEAMS(SCTMLVL,2,SCPCLVL,"ASSOC PAGER")=SCVALUE
 . ;
 ; OEF Team
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/OEFOIFAssignments/OEFOIFAssignment/teamName" DO  QUIT
 . SET SCOELVL=SCOELVL+1
 . SET SCTEAMS(SCTMLVL,"OEF",SCOELVL,"OEF TEAM")=SCVALUE
 . ;
 ; OEF Clinical Case Manager Name
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/OEFOIFAssignments/OEFOIFAssignment/LeadCoordinator/name" DO  QUIT
 . SET SCTEAMS(SCTMLVL,"OEF",SCOELVL,"OEF MGR")=SCVALUE
 . ;
 ; OEF Clinical Case Manager Phone
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/OEFOIFAssignments/OEFOIFAssignment/LeadCoordinator/phone" DO  QUIT
 . SET SCTEAMS(SCTMLVL,"OEF",SCOELVL,"OEF PHONE")=SCVALUE
 . ;
 ; OEF Clinical Case Manager Pager
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/OEFOIFAssignments/OEFOIFAssignment/LeadCoordinator/pager" DO  QUIT
 . SET SCTEAMS(SCTMLVL,"OEF",SCOELVL,"OEF PAGER")=SCVALUE
 . ;
 ; Specialty Team
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/SpecialtyAssignments/SpecialtyAssignment/CareTypeCode" DO  QUIT
 . SET SCSPLVL=SCSPLVL+1
 . SET SCSPMBR=0
 . SET SCSPTYPE=SCVALUE
 . SET SCTEAMS(SCTMLVL,SCSPTYPE,SCSPLVL,"SP TYPE CD")=SCVALUE
 . ;
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/SpecialtyAssignments/SpecialtyAssignment/CareTypeName" DO  QUIT
 . SET SCTEAMS(SCTMLVL,SCSPTYPE,SCSPLVL,"SP TYPE NM")=SCVALUE
 . ;
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/SpecialtyAssignments/SpecialtyAssignment/teamName" DO  QUIT
 . SET SCTEAMS(SCTMLVL,SCSPTYPE,SCSPLVL,"SP TEAM")=SCVALUE
 . ;
 ; Specialty Team Role
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/SpecialtyAssignments/SpecialtyAssignment/TeamMembers/teamRoleName" DO  QUIT
 . SET SCSPMBR=SCSPMBR+1
 . SET SCTEAMS(SCTMLVL,SCSPTYPE,SCSPLVL,SCSPMBR,"SP ROLE")=SCVALUE
 . ;
 ; Specialty Team Member Name
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/SpecialtyAssignments/SpecialtyAssignment/TeamMembers/name" DO  QUIT
 . SET SCTEAMS(SCTMLVL,SCSPTYPE,SCSPLVL,SCSPMBR,"SP NAME")=SCVALUE
 . ;
 ; Specialty Team Member Phone
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/SpecialtyAssignments/SpecialtyAssignment/TeamMembers/phone" DO  QUIT
 . SET SCTEAMS(SCTMLVL,SCSPTYPE,SCSPLVL,SCSPMBR,"SP PHONE")=SCVALUE
 . ;
 ; Specialty Team Member Pager
 IF SCNODE="/PatientSummary/PatientNationalAssignments/PatientStationLevelAssignment/SpecialtyAssignments/SpecialtyAssignment/TeamMembers/pager" DO  QUIT
 . SET SCTEAMS(SCTMLVL,SCSPTYPE,SCSPLVL,SCSPMBR,"SP PAGER")=SCVALUE
 . ;
 ; nonVA Role
 IF SCNODE="/PatientSummary/NonVAProviders/NonVAProvider/roleSpecialty" DO  QUIT
 . SET SCNVALVL=SCNVALVL+1
 . ;DO BUILDNVA(.SCNVA,SCNVALVL)
 . SET SCNVA(SCNVALVL,"ROLE")=SCVALUE
 . ;
 ; nonVA Name
 IF SCNODE="/PatientSummary/NonVAProviders/NonVAProvider/providerName" DO  QUIT
 . SET SCNVA(SCNVALVL,"NAME")=SCVALUE
 . ;
 ; nonVA Phone
 IF SCNODE="/PatientSummary/NonVAProviders/NonVAProvider/phone" DO  QUIT
 . SET SCNVA(SCNVALVL,"PHONE")=SCVALUE
 . ;
 ; nonVA City
 IF SCNODE="/PatientSummary/NonVAProviders/NonVAProvider/city" DO  QUIT
 . SET SCNVA(SCNVALVL,"CITY")=SCVALUE
 . ;
 ; nonVA State
 IF SCNODE="/PatientSummary/NonVAProviders/NonVAProvider/state" DO  QUIT
 . SET SCNVA(SCNVALVL,"STATE")=SCVALUE
 . ;
 ;
 QUIT
 ;
