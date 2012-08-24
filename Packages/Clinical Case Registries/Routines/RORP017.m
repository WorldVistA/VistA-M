RORP017 ;BPOIFO/CLR  POST INSTALL PATCH 17 ; 8/29/11 1:26pm
 ;;1.5;CLINICAL CASE REGISTRIES;**17**;Feb 17, 2006;Build 33
 ;******************************************************************************
 ; This routine uses the following IAs:
 ;
 ; #10006  ^DIC (supported)
 ; #2053   FILE^DIE (supported)
 ; #10013  ^DIK (supported)
 ; #2054   CLEAN^DILF (supported)
 ; #2056   GETS^DIQ (supported)
 ; #2263   ADD^XPAR (supported)
 ; #2263   DEL^XPAR (supported)
 ; #10141  BMES^XPDUTL (supported)
 ;         
 ;******************************************************************************
POST ;
 D BMES^XPDUTL("Adding PTSD common template...")
 D PTSD
 D BMES^XPDUTL("Adding new reports to HepC registry...")
 D RPT
 D BMES^XPDUTL("Checking VA GENERIC drug file...")
 D GENDRG
 Q
 ;******************************************************************************
 ;Add new ICD9 entry/group "PTSD" to the PARAMETERS file #8989.5
 ;ADD^XPAR(entity,parameter[,instance],value[,.error])
 ;DBIA 2263
 ;******************************************************************************
PTSD ;
 N RORVALUE,RORERR,RORENTITY,RORPARAMETER,RORINSTANCE
 S RORENTITY="PKG.CLINICAL CASE REGISTRIES"
 S RORPARAMETER="ROR REPORT PARAMS TEMPLATE"
 S RORINSTANCE="13::PTSD"
 ;delete it first (in case it already exists)
 D DEL^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORERR)
 S RORVALUE="CCR Predefined Report Template"
 S RORVALUE(1,0)="<?xml version="_"""1.0"""_" encoding="_"""UTF-8"""_"?>"
 S RORVALUE(2,0)="<PARAMS>"
 S RORVALUE(3,0)="<ICD9LST>"
 S RORVALUE(4,0)="<GROUP ID="_"""PTSD"""_">"
 S RORVALUE(5,0)="<ICD9 ID="_"""309.81"""_">POSTTRAUMATIC STRESS DIS</ICD9>"
 S RORVALUE(6,0)="</GROUP>"
 S RORVALUE(7,0)="</ICD9LST>"
 S RORVALUE(8,0)="<PANELS>"
 S RORVALUE(9,0)="<PANEL ID="_"""160"""_"/>"
 S RORVALUE(10,0)="</PANELS>"
 S RORVALUE(11,0)="</PARAMS>"
 ;add it
 D ADD^XPAR(RORENTITY,RORPARAMETER,RORINSTANCE,.RORVALUE,.RORERR)
 Q
 ;
 ;
 ;******************************************************************************
 ;Add reports 21-22 to the list of available reports for the VA HEPC entry in the
 ; ROR REGISTRY PARAMETERS file.  Field #27: AVAILABLE REPORTS
 ;******************************************************************************
RPT ;
 N REGNAME,REGIEN,RORERR,RORDATA,OLDLIST,NEWLIST S REGNAME="VA HEPC"
 S REGIEN=$O(^ROR(798.1,"B",REGNAME,0))
 Q:$G(REGIEN)=""
 K RORDATA,RORERR D GETS^DIQ(798.1,REGIEN_",",27,"I","RORDATA","RORERR")
 Q:$D(RORERR("DIERR"))
 S OLDLIST=$G(RORDATA(798.1,REGIEN_",",27,"I"))
 Q:$G(OLDLIST)=""
 I OLDLIST[",18,19,20,21,22" Q
 ;update AVAILABLE REPORTS with the 3 additional reports
 S NEWLIST=OLDLIST_",18,19,20,21,22"
 N FLAG,FDA,IENS,FIELD S IENS=REGIEN_",",FIELD=27,FLAG="E"
 S FDA(798.1,IENS,FIELD)=NEWLIST
 K RORERR D FILE^DIE(FLAG,"FDA","RORERR")
 D CLEAN^DILF
 Q
 ;
 ;*******************************************************************
 ;
 ;Delete entry in ROR GENERIC DRUG with unresolved pointers
 ;
 ;********************************************************************
 ;clean up 799.51 if pointers are bad
GENDRG ;
 N DIC,X,DIK,DA,RORNAME,Y
 S DIC=799.51,DIC(0)="MNZ"
 F RORNAME="EMTRICI./RILPIVIRINE/TENOFOVIR" D
 .S X=RORNAME D ^DIC Q:+Y<0
 .Q:+$P(Y(0),U,4)>0
 .S DA=+Y,DIK="^ROR(799.51," D ^DIK
 .D BMES^XPDUTL("WARNING*** Missing entry in VA GENERIC file.")
 Q
