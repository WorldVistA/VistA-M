ORY311 ;ISP/RFR - OR*3*311 POST-INSTALL ROUTINE;06/21/2013  08:27
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**311**;Dec 17, 1997;Build 30
 Q
POST ;POST-INSTALL ACTIONS
 D MES^XPDUTL(" Setting the dosage order check to mandatory...")
 D MAND
 D MES^XPDUTL(" DONE")
 ;
MAND ;SET DOSAGE ORDER CHECK TO MANDATORY
 ;Parameter is ORK EDITABLE BY USER
 N ORERR,RETURN,ENTITY
 S RETURN=$NA(^TMP($J,"ORPARAMS"))
 K @RETURN
 D ENVAL^XPAR(.RETURN,"ORK PROCESSING FLAG","DRUG DOSAGE",.ORERR,1)
 I +ORERR>0 D  Q
 .N ORTEXT
 .S ORTEXT(1)=" Unable to set the DRUG DOSAGE order check to mandatory."
 .S ORTEXT(2)=" Error encountered while retrieving values for the"
 .S ORTEXT(3)=" ORK PROCESSING FLAG parameter:"
 .S ORTEXT(4)=" "_$P(ORERR,U,2)
 .S ORTEXT(5)=" Please log a Remedy ticket for assistance."
 .D MES^XPDUTL(.ORTEXT)
 S ENTITY="" F  S ENTITY=$O(^TMP($J,"ORPARAMS",ENTITY)) Q:$G(ENTITY)=""  D
 .I ^TMP($J,"ORPARAMS",ENTITY,34)="D" D
 ..D CHG^XPAR(ENTITY,"ORK PROCESSING FLAG","DRUG DOSAGE","E",.ORERR)
 ..I +ORERR>0 D
 ...N DIC,DO,ORTEXT
 ...S DIC=U_$P(ENTITY,";",2)
 ...D DO^DIC1
 ...S ORTEXT(1)=" Error encountered while enabling the DRUG DOSAGE order check for"
 ...S ORTEXT(2)=" the "_$$EXTERNAL^DILFD(8989.5,.01,,ENTITY,"ORERR")_" (#"_+ENTITY_") entry"
 ...S ORTEXT(3)=" in the "_$P(DO,U)_" file:"
 ...S ORTEXT(4)=" "_$P(ORERR,U,2)
 ...S ORTEXT(5)=" Please log a Remedy ticket for assistance."
 ...D MES^XPDUTL(.ORTEXT)
 K ORERR,@RETURN
 D EN^XPAR("SYS","ORK EDITABLE BY USER","DRUG DOSAGE","NO",.ORERR)
 Q
 ;
