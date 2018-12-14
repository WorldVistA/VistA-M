ORFD435P ;ALB/RTW - FIRST DOSE NOW POST INSTALL ; 02/14/17 11:59pm
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**435**;Dec 17, 1997;Build 29
 ;ICR#   Type  Description
 ;-----  ----  -------------------------------------
 ;2263   Sup   $$GET^XPAR  SUPPORTED PARAMETER TOOL ENTRY POINTS 
 D CHECK,ORADDRPC
CHECK ; Check to See if "ASAP" exists
 N ORX
 I $$GET^XPAR("ALL","ORDER URGENCY ASAP ALTERNATIVE")'="" S ORX="The ORDER URGENCY ASAP ALTERNATIVE parameter has already been set" D MES^XPDUTL(ORX)
 Q:$$GET^XPAR("ALL","ORDER URGENCY ASAP ALTERNATIVE")'=""
 N ORPARDEF,ORPRA,ORPARSET,ORPARNUM,ERROR,ORX1
 ;If a site does not have the "ASAP" Urgency in the Order Urgency FIle ASK for an alternative
 ;If a site does have the "ASAP" Urgency in the Order Urgency FIle set ASAP in the parameter, this ensures ASAP ia pointed to if it is changed
CHECK2 ;
 I '$D(^ORD(101.42,"B","ASAP")) S ORX="Your sites' Order Urgency file does not contain 'ASAP' , please select an alternative to the ""ASAP"" urgency for your site" D MES^XPDUTL(ORX) D
 . S ORPARDEF=0,ORPARDEF=$O(^XTV(8989.51,"B","ORDER URGENCY ASAP ALTERNATIVE",ORPARDEF)) D EDITPAR^XPAREDIT(ORPARDEF)
 . G:$$GET^XPAR("ALL","ORDER URGENCY ASAP ALTERNATIVE")="" CHECK2
 . S ORPARNUM=$$GET^XPAR("ALL","ORDER URGENCY ASAP ALTERNATIVE")
 . S ORPARSET=$P(^ORD(101.42,ORPARNUM,0),U,1)
 . S ORX1=ORPARSET_" : Was recorded as your sites selection for an alternative to ""ASAP"""
 . D MES^XPDUTL(ORX1)
 I $D(^ORD(101.42,"B","ASAP")) S ORPRA=0,ORPRA=$O(^ORD(101.42,"B","ASAP",ORPRA)) D EN^XPAR("SYS","ORDER URGENCY ASAP ALTERNATIVE",1,"ASAP",.ERROR) D
 . I ERROR=0 S ORX="""ASAP"" Order Urgency exists in file 100.42 and was recorded in the ""ORDER URGENCY ASAP ALTERNATIVE"" parameter" D MES^XPDUTL(ORX)
 Q
ORADDRPC ;ADD RPCS TO THE OR CPRS GUI CHART OPTION
 ;
 N FDA,OROP,ORRPCIEN,ORTORPC
 S OROP=+$P($Q(^DIC(19,"B","OR CPRS GUI CHART")),",",4)
 S ORTORPC="" F ORTORPC="ORWDPS1 GETPRIEN","ORWDPS1 GETPRIOR" Q:ORTORPC=""  D
 . S ORRPCIEN=0 S ORRPCIEN=$O(^XWB(8994,"B",ORTORPC,ORRPCIEN))
 . Q:$D(^DIC(19,OROP,"RPC","B",ORRPCIEN))
 . S FDA(1,19.05,"+2,"_OROP_",",.01)=ORRPCIEN
 . D UPDATE^DIE("","FDA(1)")
 Q
