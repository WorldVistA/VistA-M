SCMSPU1 ;ALB/JRP - AMB CARE POST INIT UTILITIES;03-JUN-1996
 ;;5.3;Scheduling;**44**;AUG 13, 1993
CRTAPP(HL7APP,HL7FAC,HL7MG) ;Create/find entry in HL APPLICATION file (#771)
 ;
 ;Input  : HL7APP - Name of application to create (field #.01)
 ;                  Free text - 3 to 15 characters
 ;         HL7FAC - Facility name (field #3)
 ;                  Free text - 1 to 20 characters
 ;                  Defaults to facility number
 ;         HL7MG - Mail Group (field #4)
 ;                 Pointer to entry in MAIL GROUP file (#3.8)
 ;Output : Ptr^New - Pointer to entry in HL APPLICATION file
 ;                   Flag indicating if entry was created
 ;                     1 = Yes
 ;                     0 = No
 ;         -1^Text - Error
 ;Notes  : If an existing entry is found, the currently stored values
 ;         will not be overwritten
 ;       : Default field seperator (#100) and encoding characters (#101)
 ;         are used.  This is done by not storing anything in the file
 ;         for these fields.
 ;       : A value for the country code (#7) will not be stored
 ;       : Application will be marked as active
 ;
 ;Check input
 S HL7APP=$G(HL7APP)
 Q:(HL7APP="") "-1^Did not pass name of HL7 Application to create"
 Q:((($L(HL7APP)<3))!(($L(HL7APP)>15))) "-1^Did not pass valid name for HL7 Application"
 S HL7FAC=$G(HL7FAC)
 S:(HL7FAC="") HL7FAC=+$P($$SITE^VASITE(),"^",3)
 Q:($L(HL7FAC)>20) "-1^Did not pass valid HL7 Facility Name"
 S HL7MG=+$G(HL7MG)
 Q:('$D(^XMB(3.8,HL7MG,0))) "-1^Did not pass valid pointer to Mail Group"
 ;Declare variables
 N HL7PTR,DIC,DIE,DA,DR,X,Y,DLAYGO,DTOUT,DUOUT,HL7NEW
 S DIC="^HL(771,"
 S DIC(0)="LX"
 S DIC("DR")="2///ACTIVE;3///^S X=HL7FAC;4////^S X=HL7MG"
 S DLAYGO=771
 S X=HL7APP
 ;Create/find entry
 D ^DIC
 S HL7PTR=+Y
 S HL7NEW=+$P(Y,"^",3)
 ;Error
 Q:(HL7PTR<0) "-1^Unable to create HL7 Application"
 ;Success - done
 Q HL7PTR_"^"_HL7NEW
 ;
OPCMG(RETNAME) ;Get pointer to Mail Group that receives OPC generation bulletin
 ;Input  : RETNAME - Flag indicating if name of Mail Group should
 ;                   be returned instead of a pointer to the Mail Group
 ;                   0 = No (default)
 ;                   1 = Yes
 ;Output : Value contained in OPC GENERATE MAIL GROUP field (#216)
 ;         of the MAS PARAMTER file (#43) - Pointer to MAIL GROUP
 ;         file (#3.8)
 ;
 ;Check input
 S RETNAME=+$G(RETNAME)
 ;Declare variables
 N NODE,PTR,NAME
 ;Get node value is stored on
 S NODE=$G(^DG(43,1,"SCLR"))
 ;Get pointer
 S PTR=+$P(NODE,"^",16)
 ;Return pointer to Mail Group file
 Q:('RETNAME) PTR
 ;Get name of Mail Group
 S NODE=$G(^XMB(3.8,PTR,0))
 S NAME=$P(NODE,"^",1)
 ;Return name of Mail Group
 Q NAME
