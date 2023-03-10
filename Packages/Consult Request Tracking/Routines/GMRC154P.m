GMRC154P ;ABV/BL - Post-install GMRC*3.0*154; 12/16/19 09:23
 ;;3.0;CONSULT/REQUEST TRACKING;**154**;DEC 16, 2019;Build 135
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q  ;don't start at the top
ENV  ;Ensure the Cerner Institution Entry is present if not fail install
 S XPDABORT=""
 D CRNRCHK(.XPDABORT) I XPDABORT=2 D ABRT Q
 I XPDABORT="" K XPDABORT
 Q
 ;
ENT  ;Entry point for creation of Logical Links, new Cerner Mail Groups, and new Cerner parameters
 ;Create a Parameter for the 6 Logical links to be used to transmit 
 ;IFC information to VDIFF and Cerner
 ;
 ; Variable Descriptions
 ; TEST = whether the local vista instance is a test or prod site
 ; STAT = System Station Number
 ; REGION =  Region to be used to choose proper VDIF server
 ;
 K VDIF
 N TEST,STAT,REGION,ENT,PAR,ROUTE,ERR,PCHK
 S TEST=$D(^%ZOSF("TEST"))
 S VDIF=$$GETVDIF()
 ; Set a "0" value for any site that is a test site. Will require a manual config
 S:TEST VDIF=0
 ;Set system parameter for regional router
 D BMES^XPDUTL("Updating Parameters File...")
 S ROUTE="GMRC IFC"_VDIF
 S PAR="GMRC IFC REGIONAL ROUTER"
 ;See if the GMRC IFC REGIONAL ROUTER already exists
 S PCHK=$$GET^XPAR("SYS","GMRC IFC REGIONAL ROUTER",1)
 D:PCHK'=""
 . D BMES^XPDUTL("Parameter already exists Updating...")
 . D CHG^XPAR("SYS",PAR,1,ROUTE,.ERR)
 D:PCHK=""
 . D BMES^XPDUTL("Adding new parameter Updating...")
 . D ADD^XPAR("SYS",PAR,1,ROUTE,.ERR)
 D ADDERR
 D POST
 ;
 ;Create new GMRC CRNR Parameter Values
 N ENT,ERR,IENPD,IENPV,PAR,PARAM,PVN,PVWP,X
 F PVN=2:1:5 S X=$T(CRNRPV+PVN),PARAM=$P(X,";",2),PVWP(1,0)=$P(X,";",3) D
 . D BMES^XPDUTL("Adding new CRNR Parameter Value for: "_PARAM)
 . S IENPD=$O(^XTV(8989.51,"B",PARAM,"")) I 'IENPD D BMES^XPDUTL("Error: Parameter "_PARAM_" not found") Q
 . K ERR D ADD^XPAR("SYS",PARAM,1,PARAM,.ERR)
 . D:'ERR
 .. S ENT="SYS",PAR=PARAM D INTERN^XPAR1
 .. S IENPV=$O(^XTV(8989.5,"AC",PAR,ENT,1,"")) I 'IENPV D BMES^XPDUTL("Parameter Value no found for:"_PARAM_" "_$G(ERR)) Q
 .. D BMES^XPDUTL("Parameter value added for: "_PARAM)
 .. K ERR D WP^DIE(8989.5,IENPV_",",2,,"PVWP","ERR") I $D(ERR) D BMES^XPDUTL("Error while adding Parameter Value description for: "_PARAM_" "_$G(ERR)) Q
 ;
 Q
 ;
GETVDIF() ;
 N INC,REG,STAT,TAGTXT
 S REG=0,STAT=$P($$SITE^VASITE,"^",1)
 F INC=1:1 S TAGTXT=$P($T(DATA+INC),";;",2) Q:TAGTXT=""!(REG)  D
 . Q:$P(TAGTXT,"^")'=STAT
 . S REG=$P(TAGTXT,"^",2)
 Q REG
 ;
CRNRPV ;New Cerner parameters
 ;PARAMETER AND VALUE;WORD PROCESISNG TEXT
 ;GMRC CRNR IFC ERRORS;Interfacility Consult Errors Mail Group name
 ;GMRC CRNR IFC CLIN ERRORS;Interfacility Consult Clinical Errors Mail Group name
 ;GMRC CRNR IFC TECH ERRORS;Interfacility Consult Technical Errors Mail Group name
 ;GMRC TIER II CRNR IFC ERRORS;Interfacility Consult Tier II Errors Mail Group name
 ;;
ADDERR  ;Check for an error and print to screen
 I +$G(ERR)>0 D  Q
 .D BMES^XPDUTL(PAR)
 .D BMES^XPDUTL("    "_ERR)
 I '+$G(ERR)>0 D
 .D BMES^XPDUTL(PAR_" updated successfully....")
 Q
 ;
INC870(Y)  ;ONLY SEND GMRC IFC LOGICAL LINKS
 ;
 K T
 S T=0
 S:^HLCS(870,Y,0)["GMRC IFC" T=1
 Q T
 ;
INC51(Y)  ;ONLY SEND THE PARAMETER DEFINITION FOR GMRC IFC REGIONAL ROUTER
 ;
 K T
 S T=0 I $P(^XTV(8989.51,Y,0),"^",1)="GMRC IFC REGIONAL ROUTER" S T=1
 Q T
 ;
INCCRP(Y) ;Include new Cerner IFC parameter definitions
 ;
 Q ($P(^XTV(8989.51,Y,0),U)?1"CRNR IFC".E)!($P(^XTV(8989.51,Y,0),U)?1"TIER II CRNR".E)
 ;
CRNRCHK(XPDABORT) ;checks CERNER entry in Institution file. Post init will fail if missing.
 I $$FIND1^DIC(4,"","MX","CERNER")=0 D
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("There is no CERNER entry in the Institution file (#4).")
 . D MES^XPDUTL("This entry is necessary for the Logical Link file (#870) update in this patch.")
 . D MES^XPDUTL("Contact Customer Service for instructions to install this entry then try again.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
 ;
POST ; Entry point post install
 ;set up logical link
 N DGX,DGABRT,DGPORT,DGLNK,DGOLD,DGNEW,DGPCE,DGNAME
 ;
 S DGABRT=0 ;Abort Flag: 1=Abort Setup, 0=Continue Setup
 F DGX="CHK","PORT","870","FIN" D @DGX  Q:DGABRT
 D:DGABRT ABRT
 ;
 Q
 ;
CHK  ; Check for existing logical link
 N X,Y,Z,J,K
 S DGLNK="VACRNR"
 S X=$$FIND1^DIC(870,"","MX",DGLNK) I X>0 D
 . D BMES^XPDUTL("A Logical Link for "_DGLNK_" already exists and will be overwritten.")
 ;
 S DGPCE=".01,.02,.08,4.5,2,3,21,200.021,200.05,200.08,400.02,400.03,400.04,400.07"
 F J=1:1:14 S K=$$GET1^DIQ(870,X,$P(DGPCE,",",J)) S:K]"" $P(DGOLD,",",J)=K
 ; 
 Q
 ;
PORT  ; KIDS has prompted user for port number, set port variable DGPORT
 S DGPORT=6230
 Q
 S Y=$G(XPDQUES("POSPORT"))
 I Y="^" S DGABRT=1 Q
 ;
 S DGPORT=$G(Y)
 Q
 ;
870         ; Create HL7 Logical Link
 ; If Cerner is not in file 4 then don't bother - it will be there for production systems.
 I $$FIND1^DIC(4,"","MX","CERNER")=0 S DGABRT=1 Q
 ;
 N ERR,FDA,X,J
 ;
 ; Set up the logical link for the National Router
 K FDA
 S FDA(1,870,"?+1,",.01)=DGLNK                               ;Node
 S:$P($G(DGOLD),",",2)'="CERNER" FDA(1,870,"?+1,",.02)="CERNER"   ;Institution
 S FDA(1,870,"?+1,",.08)="hc-vdif-ent-a.domain.ext"              ;DNS Domain
 I TEST S FDA(1,870,"?+1,",.08)="hc-vdif-ent.domain.ext"
 S FDA(1,870,"?+1,",4.5)=1 ;Autostart
 S FDA(1,870,"?+1,",2)="TCP"                                 ;LLP Type
 S FDA(1,870,"?+1,",3)="NC"                                  ;Device Type
 S FDA(1,870,"?+1,",21)=10 ;Queue Size
 S FDA(1,870,"?+1,",200.021)="R"                             ;Exceed Re-transmit Action
 S FDA(1,870,"?+1,",200.05)=20 ;ACK timeout
 S FDA(1,870,"?+1,",200.08)=2.3 ;Protocol ID Version
 S FDA(1,870,"?+1,",400.02)=DGPORT                             ;TCP/IP Port
 S FDA(1,870,"?+1,",400.03)="C"                              ;TCP/IP Service Type
 S FDA(1,870,"?+1,",400.04)="N"                              ;Persistent
 S FDA(1,870,"?+1,",400.07)="Y"                              ;Say HELO
 ;
 D UPDATE^DIE("E","FDA(1)","","ERR")
 I $D(ERR) D  Q
 . D BMES^XPDUTL("Unable to file a logical Link for "_DGLNK_".")
 . S DGABRT=1
 ;
 ; If there were previous values for the logical link, document what was changed.
 I '$L($G(DGOLD)) Q    ;Quit if DGOLD does not have a value
 ;
 S DGNAME="Node,Institution,DNS Domain,Autostart,LLP Type,Device Type,Queue Size,"
 S DGNAME=DGNAME_"Exceed Re-transmit Action,ACK timeout,Protocol ID Version,"
 S DGNAME=DGNAME_"TCP/IP Port,TCP/IP Service Type,Persistent,Say HELO"
 S DGNEW="VACRNR,CERNER,hc-vdif-ent.domain.ext,Enabled,TCP,Non-Persistent Client,10,restart,20,2.3,"
 S DGNEW=DGNEW_DGPORT_",CLIENT (SENDER),NO,YES"
 ;
 S X="Summary of changes to logical link "_DGLNK D BMES^XPDUTL(X)
 F J=1:1:14 I '($P(DGOLD,",",J)=$P(DGNEW,",",J)) D
 . S X=" Value changed for field: "_$P(DGNAME,",",J) D MES^XPDUTL(X)
 . S X=" OLD: "_$P(DGOLD,",",J) D MES^XPDUTL(X)
 . S X=" NEW: "_$P(DGNEW,",",J) D MES^XPDUTL(X)
 Q
 ;
FIN  ;
 D BMES^XPDUTL("Logical Link Setup Complete")
 Q
 ;
ABRT  ;
 D BMES^XPDUTL("Logical Link Setup Aborted")
 Q
 ;
DATA  ;Reference data for each site and which VDIF router to use
 ;;500^1
 ;;358^1
 ;;459^1
 ;;463^1
 ;;504^1
 ;;519^1
 ;;531^1
 ;;570^1
 ;;600^1
 ;;612^1
 ;;640^1
 ;;648^1
 ;;653^1
 ;;654^1
 ;;663^1
 ;;668^1
 ;;687^1
 ;;691^1
 ;;692^1
 ;;436^5
 ;;442^5
 ;;501^5
 ;;554^5
 ;;575^5
 ;;593^5
 ;;600^5
 ;;605^5
 ;;644^5
 ;;649^5
 ;;660^5
 ;;662^5
 ;;664^5
 ;;666^5
 ;;678^5
 ;;756^5
 ;;438^2
 ;;502^2
 ;;520^2
 ;;537^2
 ;;549^2
 ;;556^2
 ;;564^2
 ;;568^2
 ;;578^2
 ;;580^2
 ;;585^2
 ;;586^2
 ;;589^2
 ;;598^2
 ;;607^2
 ;;618^2
 ;;623^2
 ;;629^2
 ;;635^2
 ;;636^2
 ;;656^2
 ;;657^2
 ;;667^2
 ;;671^2
 ;;674^2
 ;;676^2
 ;;695^2
 ;;740^2
 ;;506^3
 ;;508^3
 ;;509^3
 ;;515^3
 ;;516^3
 ;;517^3
 ;;521^3
 ;;534^3
 ;;538^3
 ;;539^3
 ;;541^3
 ;;544^3
 ;;546^3
 ;;548^3
 ;;550^3
 ;;552^3
 ;;553^3
 ;;557^3
 ;;558^3
 ;;565^3
 ;;573^3
 ;;581^3
 ;;583^3
 ;;590^3
 ;;596^3
 ;;603^3
 ;;610^3
 ;;614^3
 ;;619^3
 ;;621^3
 ;;626^3
 ;;637^3
 ;;652^3
 ;;655^3
 ;;658^3
 ;;659^3
 ;;672^3
 ;;673^3
 ;;675^3
 ;;679^3
 ;;757^3
 ;;460^4
 ;;503^4
 ;;512^4
 ;;528^4
 ;;529^4
 ;;540^4
 ;;542^4
 ;;562^4
 ;;595^4
 ;;613^4
 ;;642^4
 ;;646^4
 ;;688^4
 ;;693^4
 ;;402^6
 ;;405^6
 ;;518^6
 ;;523^6
 ;;526^6
 ;;528^6
 ;;561^6
 ;;608^6
 ;;620^6
 ;;630^6
 ;;631^6
 ;;632^6
 ;;650^6
 ;;689^6
 ;;
 ;
 Q
 ;
