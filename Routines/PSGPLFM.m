PSGPLFM ;BIR/CML3-SENDS 'NO DRUG COST FOUND' MAILMAN MSG ;16 DEC 97 / 1:37 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
NCMSG ;
 S NCF=2,QQ="" F  S QQ=$O(^TMP("PSGNCF",$J,"B",QQ)) Q:'QQ  S NCF=NCF+1,^TMP("PSGNCF",$J,NCF,0)="         "_$S(QQ[",":QQ,1:$$ENDDN^PSGMI(QQ))
 K ^TMP("PSGNCF",$J,"B") S XMSUB="COST NOT FOUND ON DRUG ITEM"_$E("S",NCF>3),XMTEXT="^TMP(""PSGNCF"",$J,",XMDUZ="MEDICATIONS,UNIT DOSE" ; I 'XMDUZ D ENNU S XMDUZ=$O(^VA(200,"B","MEDICATIONS,UNIT DOSE",0))
 K XMY F Q=0:0 S Q=$O(^XUSEC("PSJU MGR",Q)) Q:'Q  S XMY(Q)=1
 I '$D(XMY) F Q=0:0 S Q=$O(^XUSEC("PSJ RPHARM",Q)) Q:'Q  S XMY(Q)=1
 S:$D(DUZ)#2 XMY(+DUZ)=1 S ^TMP("PSGNCF",$J,1,0)="   The following item"_$E("s",NCF>3)_" from your DRUG file "_$P("was^were","^",NCF>3+1)_" found to have NO DATA in "_$P("its^their","^",NCF>3+1)
 S ^TMP("PSGNCF",$J,2,0)="PRICE PER DISPENSE UNIT field:"
 S ^TMP("PSGNCF",$J,NCF+1,0)=" ",^TMP("PSGNCF",$J,NCF+2,0)="   Any PICK LIST with "_$P("this item^any of these items","^",NCF>3+1)_" will NOT be completely FILED AWAY"_$P(" until^","^",NCF>3+1)
 S ^TMP("PSGNCF",$J,NCF+3,0)=$P("^until ","^",NCF>3+1)_"the PRICE PER DISPENSE UNIT field has been entered into for "_$P("this^these","^",NCF>3+1)_" item"_$E("s",NCF>3)_"."
 S ^TMP("PSGNCF",$J,NCF+4,0)="   Even if there is no cost for "_$P("this^these","^",NCF>3+1)_" item"_$E("s",NCF>3)_", a zero (0) must be entered into"
 S ^TMP("PSGNCF",$J,NCF+5,0)="the PRICE PER DISPENSE UNIT field so the package knows it is not an error"
 S ^TMP("PSGNCF",$J,NCF+6,0)="or an omission.  UNTIL THIS IS DONE, NO COST REPORT WILL BE ACCURATE, AND ANY"
 S ^TMP("PSGNCF",$J,NCF+7,0)="PICK LIST WITH "_$P("THIS^THESE","^",NCF>3+1)_" ITEM"_$E("S",NCF>3)_" CANNOT BE PURGED." D ^XMD
 ;
DONE ;
 K NCF,QQ,XMDUZ,XMSUB,XMTEXT,^TMP("PSGNCF",$J) Q
